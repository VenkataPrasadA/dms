package com.vts.dms.dao;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import jakarta.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.dms.model.LabMaster;
import com.vts.dms.model.MailConfiguration;
import com.vts.dms.model.AuditPatches;
import com.vts.dms.master.model.Employee;
import com.vts.dms.master.model.EmployeeDesig;
import com.vts.dms.model.AuditStamping;
import com.vts.dms.model.DakMailTracking;
import com.vts.dms.model.DakMailTrackingInsights;
import com.vts.dms.model.DakSmsTracking;
import com.vts.dms.model.DakSmsTrackingInsights;

	

@Transactional
@Repository
public class DmsDaoImp  implements DmsDao {
	    private static final Logger logger=LogManager.getLogger(DmsDaoImp.class);
	    private  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	    
	    
	    
		private static final String LOGINVALIDATION = "select count(*)  from login a where a.user=:user and a.password=:password ";
		private static final String DASHBOARDFORMURLLIST = "select a.formdispname,a.formurl,a.formcolor,a.ToolTip from dak_form_detail a,dak_form_role_access b,login c where c.loginid=:loginid and a.formmoduleid=:formmoduleid AND b.formroleid=c.formroleid AND a.formdetailid=b.formdetailid AND a.isactive='1' AND b.isactive='1' order by a.formserialno";
		private static final String USERMANAGELIST = "select a.loginid, a.username, b.divisionname,c.formrolename  from login a , divisio_nmaster b , form_role c where a.divisionid=b.divisionid and a.formroleid=c.formroleid and a.isactive=1";
		private static final String MAILCONFIGURATIONLIST = "SELECT a.MailConfigurationId,a.Username,a.Host,a.TypeOfHost,a.Port,a.Password,a.CreatedBy,a.CreatedDate FROM mail_configuration a  WHERE a.IsActive='1' ORDER BY MailConfigurationId DESC";
		private static final String DELETEMAILCONFIGURATION = "UPDATE mail_configuration SET IsActive=0 AND ModifiedBy=:modifiedBy AND ModifiedDate=:modifiedDate WHERE MailConfigurationId=:mailConfigurationId";
        private static final String MAILCONFIGURATIONEDITLIST ="SELECT a.MailConfigurationId,a.Username,a.Host,a.TypeOfHost,a.Port,a.Password,a.CreatedBy,a.CreatedDate FROM mail_configuration a  WHERE a.MailConfigurationId=:mailConfigurationId";
        private static final String UPDATEMAILCONFIGURATION = "UPDATE mail_configuration a SET a.Username=:userNameData ,a.TypeOfHost=:hostType, a.ModifiedBy=:modifiedBy ,a.ModifiedDate=:modifiedDate,a.Host=:Host,a.Port=:Port,a.Password=:pass WHERE a.MailConfigurationId=:mailConfigurationId";
        private static final String MAILPROPERTIESCONFIGURATION = "SELECT a.MailConfigurationId,a.TypeOfHost,a.Host,a.Port,a.Username,a.Password,a.CreatedBy,a.CreatedDate FROM mail_configuration a WHERE a.TypeOfHost=:typeOfHost LIMIT 1";
        private static final String LASTLOGINEMPID = "select a.auditstampingid from  dak_audit_stamping a where a.auditstampingid=(select max(b.auditstampingid) from dak_audit_stamping b WHERE b.loginid=:loginid)";
		private static final String LOGINSTAMPINGUPDATE="update dak_audit_stamping set logouttype=:logouttype,logoutdatetime=:logoutdatetime where auditstampingid=:auditstampingid";
		private static final String DESGID="select desigid from employee where  empid=:empid";
		//COMMON Start
		private static final String MAILINITIATEDCOUNT = "SELECT COUNT(*) FROM dak_mail_track WHERE CreatedDate = CURDATE() AND TrackingType=:trackingType";
		private static final String UPDATENOPENDINGREPLY = "UPDATE dak_mail_track SET MailSentCount=0 AND MailSentStatus='NA' WHERE CreatedDate=CURDATE() AND TrackingType=:trackingtype ";
		private static final String UPDATEWEEKLYMAILTRACK = "UPDATE dak_mail_track SET MailSentCount=:successcount,MailSentStatus='S',MailSentDateTime= CAST(CURRENT_TIMESTAMP AS DATETIME) WHERE MailTrackingId=:mailtrackingid AND CreatedDate=CURDATE() AND TrackingType=:trackingtype  ";
		private static final String UPDATEPARTICULAREMPMAILSTATUS = "UPDATE dak_mail_track_insights SET MailStatus=:mailstatus,MailSentDate= CAST(CURRENT_TIMESTAMP AS DATETIME) WHERE MailPurpose=:mailpurpose AND EmpId=:mailempid AND MailTrackingId=:mailtrackingid ";
			
		//COMMON End
		
		private static final String DAILYEXPECTEDPENDINGREPLYCOUNT = "SELECT COUNT(DISTINCT m.EmpId) FROM dak_marking m JOIN Dak a ON m.DakId = a.DakId WHERE a.ReceiptDate IS NOT NULL AND DATE(a.ReceiptDate) >='2023-12-01' AND m.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId = m.DakId) AND a.DakStatus IN('DD','DA') AND a.ActionId='2' AND m.IsActive=1";
		private static final String WEEKLYEXPECTEDPENDINGREPLYCOUNT="SELECT COUNT(DISTINCT m.EmpId) FROM dak_marking m  JOIN Dak a ON m.DakId = a.DakId WHERE m.ActionDueDate IS NOT NULL  AND DATE(m.ActionDueDate) >= CURDATE() - INTERVAL WEEKDAY(CURDATE()) DAY AND DATE(m.ActionDueDate) < CURDATE() + INTERVAL 7 - WEEKDAY(CURDATE()) DAY  AND m.EmpId NOT IN (SELECT r.EmpId FROM dak_reply r WHERE r.DakId = m.DakId)  AND a.DakStatus != 'DI' AND m.IsActive=1";
		private static final String SUMMARYDISTRIBUTEDCOUNT        ="SELECT COUNT(DISTINCT m.EmpId) FROM dak_marking m INNER JOIN Dak a ON m.DakId = a.DakId AND DATE(a.DistributedDate) = CURDATE() AND  a.DistributedDate != 'DI' AND m.IsActive=1";
		
		
		private static final String DAILYPENDINGREPLYEMPDATA = "SELECT m.DakId,m.EmpId,empData.EmpName,empData.Email,a.DakNo,sourceData.SourceShortName,a.ActionDueDate,empData.MobileNo,empData.DronaEmail FROM dak_marking m LEFT JOIN employee empData ON empData.EmpId=m.EmpId JOIN Dak a ON m.DakId=a.DakId LEFT JOIN dak_source_details sourceData ON sourceData.SourceDetailId=a.SourceDetailId WHERE a.ReceiptDate IS NOT NULL AND DATE(a.ReceiptDate) >='2023-12-01' AND m.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=m.DakId) AND a.DakStatus IN('DD','DA') AND a.ActionId='2' AND m.IsActive=1";
		private static final String WEEKLYPENDINGREPLYEMPDATA = "SELECT  m.DakId,m.EmpId,empData.EmpName,empData.Email,a.DakNo, sourceData.SourceShortName,a.ActionDueDate  FROM dak_marking m LEFT JOIN employee empData ON empData.EmpId = m.EmpId JOIN Dak a ON m.DakId = a.DakId LEFT JOIN dak_source_details sourceData ON sourceData.SourceDetailId = a.SourceDetailId WHERE  m.ActionDueDate IS NOT NULL AND DATE(m.ActionDueDate) >= CURDATE() - INTERVAL WEEKDAY(CURDATE()) DAY AND DATE(m.ActionDueDate) < CURDATE() + INTERVAL 7 - WEEKDAY(CURDATE()) DAY  AND m.EmpId NOT IN (SELECT r.EmpId FROM dak_reply r WHERE r.DakId = m.DakId)  AND a.DakStatus != 'DI' AND m.IsActive=1 ORDER BY ActionDueDate;";   
        private static final String SUMMARYDISTRIBUTEDEMPDATA = "SELECT m.DakId,m.EmpId,empData.EmpName,empData.Email,a.DakNo,sourceData.SourceShortName,a.ActionDueDate,empData.DronaEmail FROM dak_marking m LEFT  JOIN employee empData ON empData.EmpId=m.EmpId  INNER JOIN dak a ON m.DakId=a.DakId AND DATE(a.DistributedDate) = CURDATE() AND  a.DistributedDate != 'DI' LEFT  JOIN dak_source_details sourceData ON sourceData.SourceDetailId=a.SourceDetailId WHERE m.IsActive=1";
		
		private static final String DASHBOARDCOUNTDATA="CALL Dms_DakDashBoardCount(:empId,:fromDate,:toDate,:username,:Source,:Project,:SelSourceType,:selProjectTypeId,:MemberTypeId,:Emp,:Delivery,:Priority)";
        private static final String SOURCELIST = "select sourceid,sourcename from dak_source";
		private static final String ALLSOURCETYPELIST="SELECT a.SourceDetailId,a.SourceShortName,a.SourceName FROM dak_source_details a,dak_source b WHERE a.SourceId=b.SourceId";
		private static final String SELECTEDSOURCETYPELIST="SELECT a.SourceDetailId,a.SourceShortName,a.SourceName FROM dak_source_details a,dak_source b WHERE a.SourceId=b.SourceId AND a.SourceId=:source";
		private static final String PROJECTTYPELIST="SELECT ProjectId,ProjectCode FROM project_master WHERE labCode=:lab UNION SELECT NonProjectId,NonProjectName FROM dak_non_project UNION SELECT ProjectOtherId,ProjectName FROM dak_others_project";
		
		
		private static final String SELPROJECTLIST = "SELECT projectid,projectcode,ProjectShortName from project_master where isactive='1' AND LabCode=:lab";
		private static final String GETLABCODE = "SELECT labcode FROM employee WHERE empid=:empId";
		private static final String SELNONPROJECTLIST = "SELECT nonprojectid, nonprojectname FROM dak_non_project WHERE isactive='1'";
		private static final String SELOTHERPROJECTLIST = "SELECT ProjectOtherId, ProjectName,LabCode FROM dak_others_project WHERE isactive='1'";
		private static final String DAKSLAMISSEDDASHBOARDCOUNTDATA="CALL Dms_DakSLAMissedDashBoardCount(:fromDate,:toDate,:source,:project,:selSourceType,:selProjectTypeId,:MemberTypeId,:Emp,:Delivery,:Priority)";
		private static final String DAKSLANEARDASHBOARDCOUNTDATA="CALL Dms_DakSLANearDashBoardCount(:fromDate,:toDate,:source,:project,:selSourceType,:selProjectTypeId,:MemberTypeId,:Emp,:Delivery,:Priority)";
		private static final String DAKGROUPINGLISTDROPDOWN="SELECT a.DakMemberTypeId,a.DakMemberType FROM dak_member_type a WHERE a.MemberTypeGrouping='Y'";
		private static final String STARTEMPLOYEELIST="SELECT a.EmpId, a.EmpName, b.Designation FROM employee a JOIN employee_desig b ON a.DesigId = b.DesigId WHERE a.LabCode = :lab ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
		private static final String SELMEMBERTYPEEMPLOYEELIST="SELECT DISTINCT a.EmpId, a.EmpName, b.Designation FROM employee a JOIN employee_desig b ON a.DesigId = b.DesigId JOIN dak_members c ON a.EmpId = c.EmpId WHERE c.DakMemberTypeId = :memberTypeId AND a.LabCode = :lab ";
		private static final String DAKDELIVERYLIST = "select deliverytypeid,deliverytype from dak_delivery_type";
		private static final String PRIORITYLIST = "select priorityid,priorityname from dak_priority";
		private static final String PROJECTWISECOUNT="CALL Dms_DakProjectDashBoardCount(:projectId,:fromDate,:toDate)";
		private static final String PROJECTSCARDSCOUNT="CALL Dms_DakProjectCardsCount(:fromDate,:toDate)";
		private static final String GROUPCARDSCOUNT="CALL Dms_DakGroupCardsCount(:fromDate,:toDate)";
		private static final String GROUPWISECOUNT="CALL Dms_DakGroupDashBoardCount(:dakMemberTypeId,:fromDate,:toDate)";
		private static final String POPUPCOUNT="SELECT(SELECT COUNT(*) FROM dak a,dak_marking b WHERE a.DakId=b.DakId AND  b.EmpId=:empId AND a.ReceiptDate=:popupdate) AS 'Dak Received Today',(SELECT COUNT(*) FROM dak a,dak_marking b WHERE a.ActionDueDate=:popupdate AND b.EmpId=:empId AND a.ActionId=2 AND a.DakStatus NOT IN ('RP','FP','AP','DC') AND  a.DakId=b.DakId AND NOT EXISTS ( SELECT 1 FROM dak_reply r WHERE r.DakId = a.DakId AND r.EmpId=:empId))AS 'Dak Pending Today',(SELECT COUNT(*) FROM dak a,dak_marking b WHERE a.ActionDueDate BETWEEN :popupdate AND DATE_ADD(:popupdate, INTERVAL 7 DAY) AND b.EmpId=:empId AND a.ActionId=2 AND a.DakStatus NOT IN ('RP','FP','AP','DC') AND  a.DakId=b.DakId AND NOT EXISTS (SELECT 1 FROM dak_reply r WHERE r.DakId = a.DakId AND r.EmpId=:empId))AS 'Dak Pending Week'";
		private static final String DAKCOUNTS="SELECT(SELECT COUNT(*) FROM dak a,dak_marking b WHERE a.DakStatus IN ('DD','DA') AND a.DakId=b.DakId AND b.EmpId=:empId AND a.ActionId='2' AND a.ReceiptDate >='2023-12-01' AND a.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=a.DakId)) AS 'Dak Pending',(SELECT COUNT(*) FROM dak a,dak_marking b WHERE a.PriorityId='3' AND a.DakStatus IN ('DD','DA') AND a.DakId=b.DakId AND b.EmpId=:empId AND a.ActionId='2' AND a.ReceiptDate >='2023-12-01' AND a.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=a.DakId))AS 'Urgent Daks',(SELECT COUNT(*) FROM dak a,dak_marking b WHERE a.DakStatus IN ('DD','DA') AND a.DakId=b.DakId AND b.EmpId=:empId AND a.ActionId='2' AND a.ReceiptDate >='2023-12-01' AND a.ActionDueDate IS NOT NULL AND DATE(a.ActionDueDate) = :actionDate AND  a.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=a.DakId)) AS 'Today Pending',(SELECT COUNT(*) FROM dak a,dak_marking b WHERE a.DakStatus IN ('DD','DA') AND a.DakId=b.DakId AND b.EmpId=:empId AND a.ActionId='2' AND a.ReceiptDate >='2023-12-01' AND a.ActionDueDate IS NOT NULL AND DATE(a.ActionDueDate) < :actionDate AND  a.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=a.DakId)) AS 'Dak Delay'";
		private static final String UPDATEPARTICULAREMPSMSSTATUS="UPDATE dak_sms_track_insights SET SmsStatus=:smsStatus,SmsSentDate= CAST(CURRENT_TIMESTAMP AS DATETIME),Message=:message WHERE SmsPurpose=:smsPurpose AND EmpId=:empId AND SmsTrackingId=:effectivelyFinalSmsTrackingId";
		private static final String UPADTEDAKSMSTRACKROW="UPDATE dak_sms_track SET SmsSentCount=:successCount,SmsSentStatus='S',SmsSentDateTime= CAST(CURRENT_TIMESTAMP AS DATETIME) WHERE SmsTrackingId=:smsTrackingId AND CreatedDate=CURDATE() AND SmsTrackingType=:trackingType ";
		private static final String UPDATENOSMSPENDINGREPLY="UPDATE dak_sms_track SET SmsSentCount=0 AND SmsSentStatus='NA' WHERE CreatedDate=CURDATE() AND SmsTrackingType=:trackingType ";
		private static final String SMSINTIATEDCOUNT="SELECT COUNT(*) FROM dak_sms_track WHERE CreatedDate = CURDATE() AND SmsTrackingType=:smsTrackingType";
		private static final String DIRECTORDAILYPENDINGREPLYEMPDATA="SELECT  e.empid,e.mobileno FROM employee e,lab_master b WHERE b.labcode=:Lab AND e.empid=b.LabAuthorityId AND e.isactive='1'";
		private static final String DIRECTORDAKCOUNTS="SELECT(SELECT COUNT(*) FROM dak a WHERE a.DakStatus IN ('DD','DA') AND a.ActionId='2' AND a.ReceiptDate >='2023-12-01' AND a.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=a.DakId)) AS 'Dak Pending',(SELECT COUNT(*) FROM dak a WHERE a.PriorityId='3' AND a.DakStatus IN ('DD','DA') AND a.ActionId='2' AND a.ReceiptDate >='2023-12-01' AND a.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=a.DaKId))AS 'Urgent Daks',(SELECT COUNT(*) FROM dak a WHERE a.DakStatus IN ('DD','DA') AND a.ActionId='2' AND a.ReceiptDate >='2023-12-01' AND a.ActionDueDate IS NOT NULL AND DATE(a.ActionDueDate) = :ActionDueDate AND a.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=a.DakId)) AS 'Today Pending',(SELECT COUNT(*) FROM dak a WHERE a.DakStatus IN ('DD','DA') AND a.ActionId='2' AND a.ReceiptDate >='2023-12-01' AND a.ActionDueDate IS NOT NULL AND DATE(a.ActionDueDate) < :ActionDueDate AND a.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=a.DakId)) AS 'Dak Delay'";
		private static final String GETTYPEOFHOSTCOUNT="SELECT COUNT(*) FROM mail_configuration WHERE TypeOfHost=:hostType";
		private static final String MAILCONFIGURATIONEDITDATA="";
		
		
		
		@PersistenceContext
		EntityManager manager;
		
		@Override
		public Long LoginStampingInsert(AuditStamping Stamping) throws Exception 
		{
			manager.persist(Stamping);
			manager.flush();
			return Stamping.getAuditStampingId();
		}
		
		@Override
		public int LoginStampingUpdate(AuditStamping Stamping) throws Exception 
		{
			Query query = manager.createNativeQuery(LOGINSTAMPINGUPDATE);
			query.setParameter("logouttype", Stamping.getLogOutType());
			query.setParameter("logoutdatetime", Stamping.getLogOutDateTime());
			query.setParameter("auditstampingid", Stamping.getAuditStampingId());		
			int LoginStampingUpdate = (int) query.executeUpdate();
			return  LoginStampingUpdate;
		}

		@Override
		public Long LoginValidation(String User, String Password) throws Exception {
			Query query = manager.createNativeQuery(LOGINVALIDATION);
			query.setParameter("user",User);
			query.setParameter("password",Password);
			BigInteger LoginValidation = (BigInteger) query.getSingleResult();
			return LoginValidation.longValue();
		}
		
		@Override
		public List<Object[]> DashBoardFormUrlList(int FormModuleId, int loginId) throws Exception {

			Query query = manager.createNativeQuery(DASHBOARDFORMURLLIST);
			query.setParameter("loginid", loginId);
			query.setParameter("formmoduleid", FormModuleId);
			List<Object[]> DashBoardFormUrlList = query.getResultList();
			return DashBoardFormUrlList;
		}
		
		@Override
		public List<Object[]> MailConfigurationList()throws Exception{
			Query query = manager.createNativeQuery(MAILCONFIGURATIONLIST);
			List<Object[]> MailConfigurationList = query.getResultList();
			return MailConfigurationList;
		}
		
		@Override
		public long AddMailConfiguration( MailConfiguration mailConfigAdd)throws Exception{
			logger.info(new Date() + "Inside DaoImpl AddMailConfiguration");
			try {
				manager.persist(mailConfigAdd);
				manager.flush();
				return mailConfigAdd.getMailConfigurationId();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl AddMailConfiguration", e);
				return 0;
			}
		}
		

		public long DeleteMailConfiguration(long MailConfigurationId, String ModifiedBy)throws Exception{
			logger.info(new Date() + "Inside DaoImpl DeleteMailConfiguration");
			try {
				Query query = manager.createNativeQuery(DELETEMAILCONFIGURATION);
				query.setParameter("mailConfigurationId", MailConfigurationId);
				query.setParameter("modifiedBy", ModifiedBy);
				query.setParameter("modifiedDate", sdf1.format(new Date()));		
				int DeleteMailConfiguration = (int) query.executeUpdate();
				return  DeleteMailConfiguration;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl DeleteMailConfiguration", e);
				return 0;
			}
		}
		

		
		@Override
		public Object[] MailConfigurationEditList(long MailConfigurationId)throws Exception{
			logger.info(new Date() + "Inside DaoImpl MailConfigurationEditList");
			try {
				Query query = manager.createNativeQuery(MAILCONFIGURATIONEDITLIST);
				query.setParameter("mailConfigurationId", MailConfigurationId);
				return (Object[])query.getSingleResult();

			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl MailConfigurationEditList", e);
				return null;
			}
		}
		

		@Override
		public long UpdateMailConfiguration(long MailConfigurationId,String userNameData,String hostType, String modifiedBy,String Host,String Port,String pass)throws Exception{
			logger.info(new Date() + "Inside DaoImpl MailConfigurationEditList");
			try {
				Query query = manager.createNativeQuery(UPDATEMAILCONFIGURATION);
				query.setParameter("mailConfigurationId", MailConfigurationId);
				query.setParameter("userNameData", userNameData);
				query.setParameter("hostType", hostType);
				query.setParameter("Host", Host);
				query.setParameter("Port", Port);
				query.setParameter("pass", pass);
				query.setParameter("modifiedBy", modifiedBy);
				query.setParameter("modifiedDate", sdf1.format(new Date()));	
				int DeleteMailConfiguration = (int) query.executeUpdate();
				return  DeleteMailConfiguration;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl MailConfigurationEditList", e);
				return 0;
			}
			
			
		}
		
		@Override
		public List<Object[]> GetMailPropertiesByTypeOfHost(String typeOfHost)throws Exception{
			Query query = manager.createNativeQuery(MAILPROPERTIESCONFIGURATION);
			query.setParameter("typeOfHost", typeOfHost);
			List<Object[]> GetMailPropertiesByTypeOfHost = query.getResultList();
			return GetMailPropertiesByTypeOfHost;
		}

		@Override
		public List<Object[]> UserManagerList() throws Exception {
			Query query = manager.createNativeQuery(USERMANAGELIST);
			List<Object[]> UserManagerList = query.getResultList();
			return UserManagerList;
		}

		@Override
		public Long LastLoginStampingId(String LoginId) throws Exception {
			Query query = manager.createNativeQuery(LASTLOGINEMPID);
			query.setParameter("loginid", LoginId);
			 Object result = query.getSingleResult(); 
			    if (result instanceof BigInteger) {
			        return ((BigInteger) result).longValue();
			    } else if (result instanceof Long) {
			        return (Long) result;
			    } else {
			        throw new ClassCastException("Unexpected type: " + result.getClass());
			    }
		}
		
		@Override
		public LabMaster LabDetailes() throws Exception {
			LabMaster LabDetailes=manager.find(LabMaster.class, 1);
			return LabDetailes;
		}

		@Override
		public String DesgId(String Empid) throws Exception {
			Query query = manager.createNativeQuery(DESGID);
			query.setParameter("empid", Empid);
			BigInteger DesgId = (BigInteger) query.getSingleResult();
			return DesgId.toString();
		}

		@Override
		public Employee EmployeeInfo(Long empId) throws Exception {
			try {
				Employee emloyee = null;
				CriteriaBuilder cb = manager.getCriteriaBuilder();
				CriteriaQuery<Employee> cq= cb.createQuery(Employee.class);
				Root<Employee> root= cq.from(Employee.class);
				Predicate p1 = cb.equal(root.get("EmpId"), empId);			
				cq=cq.select(root).where(p1);
				TypedQuery<Employee> allQuery = manager.createQuery(cq);
				emloyee = allQuery.getSingleResult();
				return emloyee;
			}catch (Exception e) {
				logger.error(new Date() +" Inside DAO EmployeeInfo "+ e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public EmployeeDesig DesignationInfo(Long desigId) throws Exception {
			try {
				EmployeeDesig emloyee = null;
				CriteriaBuilder cb = manager.getCriteriaBuilder();
				CriteriaQuery<EmployeeDesig> cq= cb.createQuery(EmployeeDesig.class);
				Root<EmployeeDesig> root= cq.from(EmployeeDesig.class);
				Predicate p1 = cb.equal(root.get("DesigId"), desigId);			
				cq=cq.select(root).where(p1);
				TypedQuery<EmployeeDesig> allQuery = manager.createQuery(cq);
				emloyee = allQuery.getSingleResult();
				return emloyee;
			}catch (Exception e) {
				logger.error(new Date() +" Inside DAO DesignationInfo "+ e);
				e.printStackTrace();
				return null;
			}
		}
		
		@Override
		public long GetMailInitiatedCount(String TrackingType) throws Exception {
			logger.info(new Date() + "Inside GetMailInitiatedCount");
			try {
			Query query = manager.createNativeQuery(MAILINITIATEDCOUNT);
		    query.setParameter("trackingType", TrackingType);
		    BigInteger countResult = (BigInteger) query.getSingleResult();
	        return countResult.longValue();
		 } catch (Exception e) {
			 e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl GetMailInitiatedCount", e);
				return 0;
		    }
		}
		
		@Override
		public long GetDailyExpectedPendingReplyCount() throws Exception 
		{
			logger.info(new Date() + "Inside GetDailyPendingReplyCount");
			try {
			 Query query = manager.createNativeQuery(DAILYEXPECTEDPENDINGREPLYCOUNT);
			 BigInteger countResult = (BigInteger) query.getSingleResult();
		        return countResult.longValue();
			 } catch (Exception e) {
				 e.printStackTrace();
					logger.error(new Date() + "Inside DaoImpl GetDailyPendingReplyCount", e);
					return 0;
			    }
		}
		
		@Override
		public long UpdateParticularEmpMailStatus(String MailPurpose,String MailStatus,long empId,long MailTrackingId){
			logger.info(new Date() + "Inside UpdateParticularEmpMailStatus");
			try {
				Query query = manager.createNativeQuery(UPDATEPARTICULAREMPMAILSTATUS);
			    query.setParameter("mailpurpose", MailPurpose);
			    query.setParameter("mailstatus", MailStatus);
			    query.setParameter("mailempid", empId);
			    query.setParameter("mailtrackingid", MailTrackingId);
				return query.executeUpdate();
			 } catch (Exception e) {
				 e.printStackTrace();
					logger.error(new Date() + "Inside DaoImpl UpdateParticularEmpMailStatus", e);
					return 0;
			    }
		}
		
		@Override
		public long GetWeeklyExpectedPendingReplyCount() throws Exception 
		{
			logger.info(new Date() + "Inside GetWeeklyExpectedPendingReplyCount");
			try {
			 Query query = manager.createNativeQuery(WEEKLYEXPECTEDPENDINGREPLYCOUNT);
			 BigInteger countResult = (BigInteger) query.getSingleResult();
		        return countResult.longValue();
			 } catch (Exception e) {
				 e.printStackTrace();
					logger.error(new Date() + "Inside DaoImpl GetWeeklyExpectedPendingReplyCount", e);
					return 0;
			    }
		}
		
		@Override
		public long GetSummaryOfDailyDistributedCount()throws Exception{
			logger.info(new Date() + "Inside GetSummaryOfDailyDistributedCount");
			try {
				 Query query = manager.createNativeQuery(SUMMARYDISTRIBUTEDCOUNT);
				 BigInteger countResult = (BigInteger) query.getSingleResult();
			        return countResult.longValue();
				 } catch (Exception e) {
					    e.printStackTrace();
						logger.error(new Date() + "Inside DaoImpl GetSummaryOfDailyDistributedCount", e);
						return 0;
				    }
		}
		
		@Override
		public long InsertMailTrackRow(DakMailTracking Model)throws Exception{
			logger.info(new Date() + "Inside DAO InsertDailyMailTrack");
			try {
				manager.persist(Model);
				manager.flush();
				return Model.getMailTrackingId();
            } catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl InsertDailyMailTrack", e);
				return 0;
			}
		}
		
		@Override
		public List<Object[]> GetDailyPendingReplyEmpData() throws Exception{
			logger.info(new Date() + "Inside DAO GetDailyPendingReplyEmpData");
			try {
			Query query = manager.createNativeQuery(DAILYPENDINGREPLYEMPDATA);
			List<Object[]> GetDailyPendingReplyEmpData = query.getResultList();
			return GetDailyPendingReplyEmpData;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl GetDailyPendingReplyEmpData", e);
				return null;
			}
		}
		
		
		@Override
		public List<Object[]> GetWeeklyPendingReplyEmpData() throws Exception{
			logger.info(new Date() + "Inside DAO GetWeeklyPendingReplyEmpData");
			try {
			Query query = manager.createNativeQuery(WEEKLYPENDINGREPLYEMPDATA);
			List<Object[]> GetWeeklyPendingReplyEmpData = query.getResultList();
			return GetWeeklyPendingReplyEmpData;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl GetWeeklyPendingReplyEmpData", e);
				return null;
			}
		}
		
		
		@Override
		public List<Object[]> GetSummaryDistributedEmpData() throws Exception{
			logger.info(new Date() + "Inside DAO GetSummaryDistributedEmpData");
			try {
			Query query = manager.createNativeQuery(SUMMARYDISTRIBUTEDEMPDATA);
			List<Object[]> GetSummaryEmpData = query.getResultList();
			return GetSummaryEmpData;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl GetSummaryDistributedEmpData", e);
				return null;
			}
		}
		
		
		@Override
		public long InsertMailTrackInsights(DakMailTrackingInsights Model)throws Exception{
			logger.info(new Date() + "Inside DAO InsertMailTrackInsights");
			try {
				manager.persist(Model);
				manager.flush();
				return Model.getMailTrackingInsightsId();
            } catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl InsertMailTrackInsights", e);
				return 0;
			}
		}
		
		@Override
		public long UpdateDakMailTrackRow(long MailTrackingId,long SuccessCount,String TrackingType)throws Exception{
			logger.info(new Date() + "Inside DAO UpdateDakMailTrackRow");
			try {
				Query query = manager.createNativeQuery(UPDATEWEEKLYMAILTRACK);
				 query.setParameter("mailtrackingid", MailTrackingId);
			    query.setParameter("successcount", SuccessCount);
			    query.setParameter("trackingtype", TrackingType);
				return query.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl UpdateDakMailTrackRow", e);
				return 0;
			}
		}
		
		@Override
		public long UpdateNoPendingReply(String TrackingType)throws Exception{
			logger.info(new Date() + "Inside DAO UpdateNoPendingReply");
			try {
				Query query = manager.createNativeQuery(UPDATENOPENDINGREPLY);
			    query.setParameter("trackingtype", TrackingType);
				return query.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl UpdateNoPendingReply", e);
				return 0;
			}
		}

		@Override
		public Object[] getDashBoardCount(long empId, String fromDate, String toDate, String username,String Source,String Project,String SelSourceType,String selProjectTypeId,String MemberTypeId,String Emp,String Delivery,String Priority) throws Exception {
			try {
				Query query = manager.createNativeQuery(DASHBOARDCOUNTDATA);
				query.setParameter("empId", empId);
				query.setParameter("fromDate", fromDate);
				query.setParameter("toDate",toDate );
				query.setParameter("username", username);
				query.setParameter("Source", Source);
				query.setParameter("Project", Project);
				query.setParameter("SelSourceType", SelSourceType);
				query.setParameter("selProjectTypeId", selProjectTypeId);
				query.setParameter("MemberTypeId", MemberTypeId);
				query.setParameter("Emp", Emp);
				query.setParameter("Delivery", Delivery);
				query.setParameter("Priority", Priority);
				System.out.println("CALL Dms_DakPendingReplyList("+fromDate+","+toDate+","+username+","+empId+","+Source+","+Project+","+SelSourceType+","+selProjectTypeId+","+MemberTypeId+","+Emp+","+Delivery+","+Priority+");");
				return (Object[])query.getSingleResult();
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO getDashBoardCount " + e);
				return null;
			}
		}

		@Override
		public List<Object[]> SourceList() throws Exception {
			logger.info(new Date() + "Inside DAO SourceList");
			try {
				Query query = manager.createNativeQuery(SOURCELIST);
				List<Object[]> resultList = new ArrayList<Object[]>();
				resultList = (List<Object[]>) query.getResultList();
				return resultList;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl SourceList", e);
				return null;
			}
		}

		@Override
		public List<Object[]> AllSourceTypeList() throws Exception {
			logger.info(new Date() + "Inside DAO AllSourceTypeList");
			try {
				Query query = manager.createNativeQuery(ALLSOURCETYPELIST);
				List<Object[]> resultList = new ArrayList<Object[]>();
				resultList = (List<Object[]>) query.getResultList();
				return resultList;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl AllSourceTypeList", e);
				return null;
			}
		}

		@Override
		public List<Object[]> SelectedSourceTypeList(String source) throws Exception {
			logger.info(new Date() + "Inside DAO SelectedSourceTypeList");
			try {
				Query query = manager.createNativeQuery(SELECTEDSOURCETYPELIST);
				query.setParameter("source", source);
				List<Object[]> resultList = new ArrayList<Object[]>();
				resultList = (List<Object[]>) query.getResultList();
				return resultList;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl SelectedSourceTypeList", e);
				return null;
			}
		}

		@Override
		public List<Object[]> ProjectTypeList(String lab) throws Exception {
			logger.info(new Date() + "Inside DAO ProjectTypeList");
			try {
				Query query = manager.createNativeQuery(PROJECTTYPELIST);
				query.setParameter("lab", lab);
				List<Object[]> resultList = new ArrayList<Object[]>();
				resultList = (List<Object[]>) query.getResultList();
				return resultList;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl ProjectTypeList", e);
				return null;
			}
		}

		@Override
		public List<Object[]> SelProjectTypeList(String lab) throws Exception {
			logger.info(new Date() + "Inside DAO SelProjectTypeList");
			try {
				Query query = manager.createNativeQuery(SELPROJECTLIST);
				query.setParameter("lab", lab);
				List<Object[]> resultList = new ArrayList<Object[]>();
				resultList = (List<Object[]>) query.getResultList();
				return resultList;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl SelProjectTypeList", e);
				return null;
			}
		}

		@Override
		public Object getlabcode(long empId) throws Exception {
			logger.info(new Date() + "Inside getlabcode");
			try {
				Query query = manager.createNativeQuery(GETLABCODE);
				query.setParameter("empId", empId);
				Object labcode = query.getSingleResult();
				return labcode;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl getlabcode", e);
				return null;
			}
			
		}

		@Override
		public List<Object[]> SelNonProjectTypeList() throws Exception {
			logger.info(new Date() + "Inside SelNonProjectTypeList");
			try {
				Query query = manager.createNativeQuery(SELNONPROJECTLIST);
				List<Object[]> dakData = (List<Object[]>) query.getResultList();
				return dakData;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl SelNonProjectTypeList", e);
				return null;
			}
			
		}

		@Override
		public List<Object[]> SelOtherProjectTypeList() throws Exception {
			logger.info(new Date() + "Inside SelOtherProjectTypeList");
			try {
				Query query = manager.createNativeQuery(SELOTHERPROJECTLIST);
				List<Object[]> OtherProjectList = (List<Object[]>) query.getResultList();
				return OtherProjectList;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl SelOtherProjectTypeList", e);
				return null;
			}
		}

		@Override
		public List<Object[]> DakSLAMissedDashBoardCount(String fromDate, String toDate, String source, String project,String selSourceType, String selProjectTypeId,String MemberTypeId,String Emp,String Delivery,String Priority) throws Exception {
			logger.info(new Date() + "Inside DakSLAMissedDashBoardCount");    
			try {
				
				Query query = manager.createNativeQuery(DAKSLAMISSEDDASHBOARDCOUNTDATA);
				query.setParameter("fromDate", fromDate);
				query.setParameter("toDate",toDate );
				query.setParameter("source", source);
				query.setParameter("project", project);
				query.setParameter("selSourceType", selSourceType);
				query.setParameter("selProjectTypeId", selProjectTypeId);
				query.setParameter("MemberTypeId", MemberTypeId);
				query.setParameter("Emp", Emp);
				query.setParameter("Delivery", Delivery);
				query.setParameter("Priority", Priority);
				System.out.println("Dms_DakSLAMissedDashBoardCount"+fromDate+","+ toDate +","+source+","+project+","+selSourceType+","+selProjectTypeId+","+MemberTypeId+","+Emp+","+Delivery+","+Priority+"");
				List<Object[]> DakSLAMissedDashBoardCount = (List<Object[]>) query.getResultList();
				return DakSLAMissedDashBoardCount;
				
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO DakSLAMissedDashBoardCount " + e);
				return null;
			}
		}

		@Override
		public List<Object[]> DakSLANearDashBoardCount(String fromDate, String toDate, String source, String project,String selSourceType, String selProjectTypeId,String MemberTypeId,String Emp,String Delivery,String Priority) throws Exception {
			logger.info(new Date() + "Inside DakSLANearDashBoardCount");    
			try {
				
				Query query = manager.createNativeQuery(DAKSLANEARDASHBOARDCOUNTDATA);
				query.setParameter("fromDate", fromDate);
				query.setParameter("toDate",toDate );
				query.setParameter("source", source);
				query.setParameter("project", project);
				query.setParameter("selSourceType", selSourceType);
				query.setParameter("selProjectTypeId", selProjectTypeId);
				query.setParameter("MemberTypeId", MemberTypeId);
				query.setParameter("Emp", Emp);
				query.setParameter("Delivery", Delivery);
				query.setParameter("Priority", Priority);
				List<Object[]> DakSLANearDashBoardCount = (List<Object[]>) query.getResultList();
				return DakSLANearDashBoardCount;
				
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO DakSLANearDashBoardCount " + e);
				return null;
			}
		}

		@Override
		public List<Object[]> DakGroupingListDropDown() throws Exception {
			logger.info(new Date() +"Inside DAOImpl DakGroupingListDropDown");
			try {
			Query query =manager.createNativeQuery(DAKGROUPINGLISTDROPDOWN);
			List<Object[]> DakGroupingListDropDown =(List<Object[]>)query.getResultList();				
			return DakGroupingListDropDown;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl DakGroupingListDropDown() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> StartEmployeeList(String lab) throws Exception {
			logger.info(new Date() +"Inside DAOImpl StartEmployeeList");
			try {
			Query query =manager.createNativeQuery(STARTEMPLOYEELIST);
			query.setParameter("lab", lab);
			List<Object[]> StartEmployeeList =(List<Object[]>)query.getResultList();				
			return StartEmployeeList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl StartEmployeeList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> SelMemberTypeEmployeeList(String memberTypeId, String lab) throws Exception {
			logger.info(new Date() +"Inside DAOImpl SelMemberTypeEmployeeList");
			try {
			Query query =manager.createNativeQuery(SELMEMBERTYPEEMPLOYEELIST);
			query.setParameter("memberTypeId", memberTypeId);
			query.setParameter("lab", lab);
			List<Object[]> StartEmployeeList =(List<Object[]>)query.getResultList();				
			return StartEmployeeList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl SelMemberTypeEmployeeList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> DakDeliveryList() throws Exception {
			logger.info(new Date() + "Inside DAO DakDeliveryList");
			try {
				Query query = manager.createNativeQuery(DAKDELIVERYLIST);
				List<Object[]> resultList = new ArrayList<Object[]>();
				resultList = (List<Object[]>) query.getResultList();
				return resultList;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl DakDeliveryList", e);
				return null;
			}
		}

		@Override
		public List<Object[]> getPriorityList() throws Exception {
			logger.info(new Date() + "Inside DAO getPriorityList");
			try {
				Query query = manager.createNativeQuery(PRIORITYLIST);
				List<Object[]> resultList = new ArrayList<Object[]>();
				resultList = (List<Object[]>) query.getResultList();
				return resultList;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl getPriorityList", e);
				return null;
			}
		}

		@Override
		public Object[] ProjectWiseCount(String projectId,String fromDate, String toDate) throws Exception {
             
			try {
				Query query = manager.createNativeQuery(PROJECTWISECOUNT);
				query.setParameter("projectId", projectId);
				query.setParameter("fromDate", fromDate);
				query.setParameter("toDate", toDate);
				return (Object[])query.getSingleResult();
				
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO ProjectWiseCount " + e);
				return null;
			}
		}

		@Override
		public Object[] ProjectCardsCount(String fromDate, String toDate) throws Exception {
           try {
				Query query = manager.createNativeQuery(PROJECTSCARDSCOUNT);
				query.setParameter("fromDate", fromDate);
				query.setParameter("toDate",toDate );
				return (Object[])query.getSingleResult();
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO ProjectCardsCount " + e);
				return null;
			}
		}

		@Override
		public Object[] GroupCardsCount(String fromDate, String toDate) throws Exception {
			try {
				Query query = manager.createNativeQuery(GROUPCARDSCOUNT);
				query.setParameter("fromDate", fromDate);
				query.setParameter("toDate",toDate );
				return (Object[])query.getSingleResult();
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO GroupCardsCount " + e);
				return null;
			}
		}

		@Override
		public Object[] GroupWiseCount(String dakMemberTypeId, String fromDate, String toDate) throws Exception {
			try {
				Query query = manager.createNativeQuery(GROUPWISECOUNT);
				query.setParameter("dakMemberTypeId", dakMemberTypeId);
				query.setParameter("fromDate", fromDate);
				query.setParameter("toDate", toDate);
				return (Object[])query.getSingleResult();
				
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO GroupWiseCount " + e);
				return null;
			}
		}
	
		@Override
		public long InsertSmsTrackRow(DakSmsTracking model) throws Exception {
			logger.info(new Date() + "Inside DAO InsertSmsTrackRow");
			try {
				manager.persist(model);
				manager.flush();
				return model.getSmsTrackingId();
            } catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl InsertSmsTrackRow", e);
				return 0;
			}
		}
		
		@Override
		public Object[] PopUpCount(long empId,String popupdate) throws Exception {
			try {
				Query query = manager.createNativeQuery(POPUPCOUNT);
				query.setParameter("empId", empId);
				query.setParameter("popupdate", popupdate);
				return (Object[])query.getSingleResult();
				
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO PopUpCount " + e);
				return null;
			}
		}
		
		@Override
		public long InsertSmsTrackInsights(DakSmsTrackingInsights insights) throws Exception {
			logger.info(new Date() + "Inside DAO DakSmsTrackingInsights");
			try {
				manager.persist(insights);
				manager.flush();
				return insights.getSmsTrackingInsightsId();
            } catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl DakSmsTrackingInsights", e);
				return 0;
			}
		}
		
		@Override
		public Object[] DakCounts(long empId, String actionDate) throws Exception {
			try {
				Query query = manager.createNativeQuery(DAKCOUNTS);
				query.setParameter("empId", empId);
				query.setParameter("actionDate", actionDate);
				return (Object[])query.getSingleResult();
				
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO DakCounts " + e);
				return null;
			}
		}
		
		@Override
		public long UpdateParticularEmpSmsStatus(String smsPurpose, String smsStatus, long empId,long effectivelyFinalSmsTrackingId, String message) throws Exception {
			logger.info(new Date() + "Inside UpdateParticularEmpSmsStatus");
			try {
				Query query = manager.createNativeQuery(UPDATEPARTICULAREMPSMSSTATUS);
			    query.setParameter("smsPurpose", smsPurpose);
			    query.setParameter("smsStatus", smsStatus);
			    query.setParameter("empId", empId);
			    query.setParameter("effectivelyFinalSmsTrackingId", effectivelyFinalSmsTrackingId);
			    query.setParameter("message", message);
				return query.executeUpdate();
				
			 } catch (Exception e) {
				 e.printStackTrace();
					logger.error(new Date() + "Inside DaoImpl UpdateParticularEmpSmsStatus", e);
					return 0;
			    }
		}
		
		@Override
		public long UpdateDakSmsTrackRow(long smsTrackingId, long successCount, String trackingType) throws Exception {
			logger.info(new Date() + "Inside DAO UpdateDakSmsTrackRow");
			try {
				Query query = manager.createNativeQuery(UPADTEDAKSMSTRACKROW);
				 query.setParameter("smsTrackingId", smsTrackingId);
			    query.setParameter("successCount", successCount);
			    query.setParameter("trackingType", trackingType);
				return query.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl UpdateDakSmsTrackRow", e);
				return 0;
			}
		}
		
		
		@Override
		public long UpdateNoSmsPendingReply(String trackingType) throws Exception {
			logger.info(new Date() + "Inside DAO UpdateNoSmsPendingReply");
			try {
				Query query = manager.createNativeQuery(UPDATENOSMSPENDINGREPLY);
			    query.setParameter("trackingType", trackingType);
				return query.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl UpdateNoSmsPendingReply", e);
				return 0;

			}
		}
		
		@Override
		public long GetSMSInitiatedCount(String smsTrackingType) throws Exception {
			logger.info(new Date() + "Inside GetSMSInitiatedCount");
			try {
			Query query = manager.createNativeQuery(SMSINTIATEDCOUNT);
		    query.setParameter("smsTrackingType", smsTrackingType);
		    BigInteger countResult = (BigInteger) query.getSingleResult();
	        return countResult.longValue();
		  } catch (Exception e) {
			 e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl GetSMSInitiatedCount", e);
				return 0;
		    }
		}

		@Override
		public List<Object[]> GetDirectorDailyPendingReplyEmpData(String Lab) throws Exception {
			logger.info(new Date() + "Inside DAO GetDirectorDailyPendingReplyEmpData");
			try {
			Query query = manager.createNativeQuery(DIRECTORDAILYPENDINGREPLYEMPDATA);
			query.setParameter("Lab", Lab);
			List<Object[]> GetDailyPendingReplyEmpData = query.getResultList();
			return GetDailyPendingReplyEmpData;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl GetDirectorDailyPendingReplyEmpData", e);
				return null;
			}
		}

		@Override
		public Object[] DirectorDakCounts(String ActionDueDate) throws Exception {
			try {
				Query query = manager.createNativeQuery(DIRECTORDAKCOUNTS);
				query.setParameter("ActionDueDate", ActionDueDate);
				return (Object[])query.getSingleResult();
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO DirectorDakCounts " + e);
				return null;
			}
		}
		
		@Override
		public long getTypeOfHostCount(String hostType) throws Exception {
			logger.info(new Date() + "Inside getTypeOfHostCount");
			try {
			Query query = manager.createNativeQuery(GETTYPEOFHOSTCOUNT);
		    query.setParameter("hostType", hostType);
		    BigInteger getTypeOfHostCount = (BigInteger) query.getSingleResult();
	        return getTypeOfHostCount.longValue();
		  } catch (Exception e) {
			 e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl getTypeOfHostCount", e);
				return 0;
		    }
		}
		
		
		private static final String DIVISIONDATA="SELECT DivisionCode,LabCode FROM division_master WHERE DivisionId=:divisionId";
		@Override
		public Object[] divisionData(Long divisionId) throws Exception {
			logger.info(new Date()+ "Inside divisionData()");
			try {
				Query query = manager.createNativeQuery(DIVISIONDATA);
				query.setParameter("divisionId", divisionId);
				return (Object[])query.getSingleResult();
			}
			catch(Exception e) {
				logger.error(new Date()  + "Inside DAO divisionData() " + e);
				return null;
			}
		}
		
		//auditpatches
				public static final String AUDITPATCHESLIST="SELECT VersionNo,Description,CreatedDate,Attachment,AuditPatchesId,PatchDate FROM  dms_audit_patches order by CreatedDate desc";
				@Override
				public List<Object[]> getAuditPatchesList() throws Exception{
					try {
						Query query = manager.createNativeQuery(AUDITPATCHESLIST);
						return (List<Object[]>)query.getResultList();
					}catch (Exception e) {
						e.printStackTrace();
						return new ArrayList<>();
					}
				}
				
				@Override
				public long auditpatchAddSubmit(AuditPatches model) throws Exception
				{
					manager.merge(model);
					return model.getAuditPatchesId();
				}
				 @Override
				    public AuditPatches getAuditPatchById(Long attachId) {
				        return manager.find(AuditPatches.class, attachId); // Fetches the entity by its ID
				    }
				@Override
				public AuditPatches getAuditDataPatchById(Long auditpatchid) {
					
					return manager.find(AuditPatches.class, auditpatchid);
				}
		
}
