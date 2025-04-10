package com.vts.dms.admin.dao;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

import org.springframework.stereotype.Repository;


import com.vts.dms.admin.model.FormRole;
import com.vts.dms.admin.model.FormRoleAccess;
import com.vts.dms.admin.model.LoginDivision;
import com.vts.dms.admin.model.dakFeedbackAttach;
import com.vts.dms.login.Login;
import com.vts.dms.admin.model.DakHandingOver;
import com.vts.dms.admin.model.DmsStatistics;
import com.vts.dms.admin.model.Feedback;
@Transactional
@Repository
public class AdminDaoImpl implements AdminDao {

	
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private static final String ROLELIST = "select formroleid,formrolename ,createdby, createddate from form_role where isactive='1'";	
	private static final String ROLEPRESENTCOUNT = "select count(*) from form_role where formrolename=:formrolename";
	private static final String formdetailslist="SELECT b.FormModuleName,a.FormName, a.FormDispName, a.FormColor FROM dak_form_detail a, dak_form_module b WHERE a.FormModuleId=b.FormModuleId";
	private static final String deleteFormRoleAccess="DELETE FROM dak_form_role_access WHERE FormRoleAccessId =:FormRoleAccessId";
    private static final String USERMANAGELIST = "select a.loginid, a.username, b.divisionname,c.formrolename,a.Pfms,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'empname', d.designation,e.empno ,e.labcode ,lt.logindesc FROM login a , division_master b , form_role c,employee e, employee_desig d,login_type lt  where  a.isactive=1 AND a.empid=e.empid AND e.desigid=d.desigid AND e.divisionid=b.divisionid and a.formroleid=c.formroleid AND a.logintypeDms=lt.logintype ORDER BY CASE WHEN e.Srno = 0 THEN 1 ELSE 0 END, e.Srno ASC";
	private static final String DIVISIONLIST ="select divisionid,divisioncode from division_master where isactive='1'";
	private static final String EMPLOYEEDATA ="SELECT a.empid, a.srno,a.empno,a.empname,a.desigid,a.divisionid ,b.groupid  FROM employee  a , division_master b WHERE a.divisionid =b.divisionid  AND a.empid=:empid";
	private static final String LOGINEDITDATA="FROM Login WHERE loginId=:loginId";
	private static final String USERNAMEPRESENTCOUNT ="select count(*) from login where username=:username and isactive='1'";
	private static final String LOGINUPDATE="update login set LoginTypeDms=:logintype, formroleid=:formroleid,empid=:empid,modifiedby=:modifiedby,modifieddate=:modifieddate where loginid=:loginid";
	private static final String LOGINDELETE="update login set isactive=:isactive,modifiedby=:modifiedby,modifieddate=:modifieddate where loginid=:loginid";
	private static final String EMPLOYEELIST="select a.empid,a.empname,b.divisioncode,c.Designation from employee a,division_master b,employee_desig c where a.divisionid=b.divisionid AND a.DesigId=c.DesigId AND a.isactive='1' AND a.LabCode=:labcode ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String LOGINTYPELIST="select logintype,logindesc from login_type";
	private static final String PASSWORDUPDATECHANGE="update login set password=:newpassword,modifiedby=:modifiedby,modifieddate=:modifieddate where username=:username  ";
	private static final String PASSWORDUPDATERESET="update login set password=:newpassword,modifiedby=:modifiedby,modifieddate=:modifieddate where  loginid=:loginid ";
	private static final String OLDPASSWORD="select password from login where username=:username";
	private static final String AUDITSTAMPING="SELECT a.username,a.logindate, a.logindatetime,a.ipaddress, a.macaddress, (CASE WHEN a.logouttype='L' THEN 'Logout' ELSE 'Session Expired' END) AS logouttype, a.logoutdatetime FROM dak_audit_stamping a , login b WHERE a.`LoginDate` BETWEEN :fromdate AND :todate AND a.username=b.username AND a.`UserName`=:username ORDER BY a.`LoginDateTime` DESC";
	private static final String USERNAMELIST="select username, empid from login where isactive=1";
	private static final String FEEDBACKLIST="SELECT a.feedbackid,b.empname,a.createddate , a.feedback , a.feedbacktype , a.status , a.remarks FROM dak_feedback a,employee b WHERE a.isactive='1' AND a.empid=b.empid  AND CASE WHEN 'A'<>:feedbacktype THEN a.feedbacktype=:feedbacktype ELSE 1=1 END AND CASE WHEN 'A'<>:empid THEN a.empid=:empid ELSE 1=1 END AND CAST(a.createddate AS DATE) BETWEEN :fromdate AND :todate AND b.labcode=:labcode  ORDER BY feedbackid DESC";
	private static final String FEEDBACKDATA="select a.feedback,b.empname,a.createddate  from rfpwizard_feedback a,employee b where a.feedbackid=:feedbackid and a.empid=b.empid ";
	private static final String DAKMEMBERS="SELECT dakmembertypeid,dakmembertype FROM dak_member_type";
	private static final String EMPLOYEELISTDH="SELECT a.EmpId,a.EmpName,b.Designation FROM employee a,employee_desig b WHERE a.labcode=:lab AND a.IsActive=1 AND a.DesigId=b.DesigId AND a.DivisionId=:divid ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String EMPLOYEELISTGH="SELECT a.EmpId,a.EmpName,b.Designation FROM employee a,employee_desig b WHERE a.labcode=:lab AND a.IsActive=1 AND a.DesigId=b.DesigId AND a.DivisionId=:divid ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String ALLEMPLOYEELIST="SELECT a.EmpId,a.EmpName,b.Designation FROM employee a,employee_desig b WHERE a.labcode=:lab AND a.IsActive=1 AND a.DesigId=b.DesigId ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String EMPLIST="SELECT a.empid,a.username,COUNT(b.loginid)AS 'TotalLogInCounts' FROM login a, dak_audit_stamping b WHERE a.loginid=b.loginid AND b.logindate=:logindate GROUP BY b.loginid";
	private static final String WORKCOUNTS="CALL Dms_Dakstatisticsdata(:username,:date,:EmpId)";
	private static final String EMPLOYEECOUNT="SELECT  a.EmpId,a.EmpName,c.Designation, b.LoginCount,b.DakCount, b.DistributedCount,b.AcknowledgeCount,b.MarkedCount,b.RepliedCount,b.AssignedCount,b.AssignRepliedCount,b.SeekResponseCount,b.SeekResponseRepliedCount,b.LogDate FROM employee a JOIN dak_statistics b ON a.EmpId = b.EmpId JOIN employee_desig c ON a.DesigId = c.DesigId WHERE b.EmpId = :employeeId AND b.LogDate  BETWEEN :fromdate AND :todate";
	private static final String DAKGROUPINGLIST="SELECT a.DakMemberTypeId,a.DakMemberType FROM dak_member_type a WHERE a.MemberTypeGrouping='Y'";
	private static final String GROUPINGEMPLOYEELIST="SELECT a.EmpId,a.EmpName,c.Designation FROM dak_members b,employee a,employee_desig c WHERE a.EmpId=b.EmpId AND a.DesigId=c.DesigId AND b.DakMemberTypeId=:grpId ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String STARTEMPLOYEELIST="SELECT a.EmpId, a.EmpName, b.Designation FROM employee a JOIN employee_desig b ON a.DesigId = b.DesigId WHERE a.LabCode = :lab ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String SELMEMBERTYPEEMPLOYEELIST="SELECT DISTINCT a.EmpId, a.EmpName, b.Designation FROM employee a JOIN employee_desig b ON a.DesigId = b.DesigId JOIN dak_members c ON a.EmpId = c.EmpId WHERE c.DakMemberTypeId = :memberTypeId AND a.LabCode = :lab ";
	private static final String ALLEMPLOYEECOUNT="SELECT  a.EmpId,a.EmpName,c.Designation, b.LoginCount,b.DakCount, b.DistributedCount,b.AcknowledgeCount,b.MarkedCount,b.RepliedCount,b.AssignedCount,b.AssignRepliedCount,b.SeekResponseCount,b.SeekResponseRepliedCount,b.LogDate FROM employee a JOIN dak_statistics b ON a.EmpId = b.EmpId JOIN employee_desig c ON a.DesigId = c.DesigId WHERE b.LogDate  BETWEEN :fromdate AND :todate";
	private static final String FEEDBACKLISTFORUSER="SELECT a.feedbackid,b.empname,a.createddate , a.feedback , a.feedbacktype , a.status , a.remarks FROM dak_feedback a,employee b WHERE a.isactive='1' AND a.empid=b.empid  AND CASE WHEN :empid<>'A' THEN a.empid=:empid ELSE 1=1 END AND MONTH(a.createddate)=MONTH(NOW())-1 AND b.labcode=:labcode UNION SELECT a.feedbackid,b.empname,a.createddate , a.feedback , a.feedbacktype , a.status , a.remarks FROM dak_feedback a,employee b WHERE a.isactive='1' AND a.empid=b.empid AND CASE WHEN :empid<>'A' THEN a.empid=:empid ELSE 1=1 END  AND b.labcode=:labcode ORDER BY feedbackid DESC";
	private static final String ATTACHLIST="SELECT a.feedbackid, a.FeedbackAttachId ,a.path , a.filename  FROM dak_feedback_attach a , dak_feedback b WHERE a.feedbackid=b.feedbackid AND a.isactive=1";
	private static final String USERATTCHFEEDBACK="SELECT a.feedbackid,a.FeedbackAttachId ,a.path , a.filename  FROM dak_feedback_attach a , dak_feedback b WHERE a.feedbackid=b.feedbackid AND b.empid=:empid AND a.isactive=1";
	private static final String FEEDBACKCONTENT="SELECT a.feedbackid,b.empname,a.createddate,a.feedback FROM dak_feedback a,employee b WHERE a.isactive='1' AND a.empid=b.empid AND feedbackid=:feedbackid";
	private static final String CLOSEFEEDBACK="UPDATE dak_feedback SET STATUS=:status , remarks=:remarks , ModifiedBy=:modifiedby , ModifiedDate=:modifieddate WHERE feedbackid=:feedbackId";
	
	@PersistenceContext
	EntityManager manager;
	
	
	
	
	
	
	//new change
	
	@Override
	public List<Object[]> RoleList() throws Exception {
		Query query = manager.createNativeQuery(ROLELIST);
		List<Object[]> RoleList = (List<Object[]>) query.getResultList();
		return RoleList;
	}

	@Override
	public int RolePresentCount(String RoleName) throws Exception {
		Query query = manager.createNativeQuery(ROLEPRESENTCOUNT);
		query.setParameter("formrolename", RoleName);

		Long RolePresentCount = (Long) query.getSingleResult();
		return RolePresentCount.intValue();
	}

	@Override
	public long RoleInsert(FormRole role) throws Exception {
		manager.persist(role);
		manager.flush();

		return role.getFormRoleId();
	}

	@Override
	public List<Object[]> getFormDetails() throws Exception {

		Query query = manager.createNativeQuery(formdetailslist);
		List<Object[]> formList = query.getResultList();
		return formList;
	}
	
	
	@Override
	public List<Object[]> getModuleDetails() throws Exception {
		
		Query query = manager.createNativeQuery("SELECT FormModuleId, FormModuleName FROM dak_form_module");
		List<Object[]> formList = query.getResultList();
		return formList;
	}
	
	@Override
	public List<Object[]> getFormNameAsperModule(long formmoduleId) throws Exception {
		Query query = manager.createNativeQuery("SELECT FormDetailId, FormModuleId, FormName FROM dak_form_detail WHERE FormModuleId='"+formmoduleId+"'");
		List<Object[]> formList = query.getResultList();
		return formList;
	}
	@Override
	public long addRoleFormAccess(FormRoleAccess formrole) {
		manager.persist(formrole);
		manager.flush();
		return formrole.getFormRoleAccessId();
	}
	
	@Override
	public List<Object[]> getAccessedFormsDetails(long FormRoleId, long FormModuleId) throws Exception {
		String sqlQuery=null;
		if(FormModuleId>0) {
			sqlQuery="SELECT b.FormRoleAccessId, a.FormDetailId, a.FormName, b.FormRoleId FROM dak_form_detail a, dak_form_role_access b WHERE a.FormDetailId=b.FormDetailId AND b.FormRoleId ='"+FormRoleId+"' AND a.FormModuleId ='"+FormModuleId+"'";
		}else{
			sqlQuery="SELECT b.FormRoleAccessId, a.FormDetailId, a.FormName, b.FormRoleId FROM dak_form_detail a, dak_form_role_access b WHERE a.FormDetailId=b.FormDetailId AND b.FormRoleId ='"+FormRoleId+"'";
		}
		
		Query query = manager.createNativeQuery(sqlQuery);
		
		List<Object[]> formList = query.getResultList();
		return formList;
	}

	@Override
	public List<Object[]> getNotAccessedFormsDetails(long FormRoleId, long FormModuleId) throws Exception {
		String sqlQuery=null;
		if(FormModuleId>0) {
			sqlQuery="SELECT a.FormDetailId, a.FormName FROM dak_form_detail a WHERE a.FormModuleId='"+FormModuleId+"' AND a.FormDetailId NOT IN (SELECT c.FormDetailId FROM dak_form_role_access c WHERE c.FormRoleId='"+FormRoleId+"')";
		}else {
			sqlQuery="SELECT a.FormDetailId, a.FormName FROM dak_form_detail a WHERE  a.FormDetailId NOT IN (SELECT c.FormDetailId FROM dak_form_role_access c WHERE c.FormRoleId='"+FormRoleId+"')";
		}
		Query query = manager.createNativeQuery(sqlQuery);
		List<Object[]> formList = query.getResultList();
		return formList;
	}

	
	
	
	@Override
	public int deleteFormRoleAccess(long FormRoleAccessId) throws Exception {
		Query query = manager.createNativeQuery(deleteFormRoleAccess);
		query.setParameter("FormRoleAccessId", FormRoleAccessId);
		int status=query.executeUpdate();
		return status;
	}
	
	
	@Override
	public List<Object[]> fetchRoleAsperRoleId(long formRoleId) throws Exception {
		Query query = manager.createNativeQuery("SELECT FormRoleId, FormRoleName FROM form_role WHERE FormRoleId='"+formRoleId+"'");
		List<Object[]> rolrDetails=query.getResultList();
		return rolrDetails;
	}
	
	@Override
	public int formRoleNameEdir(long formRoleId,String formRoleName) throws Exception {
		Query query = manager.createNativeQuery("UPDATE form_role SET FormRoleName='"+formRoleName+"' WHERE FormRoleId='"+formRoleId+"'");
		int status=query.executeUpdate();
		return status;
	}

	
	private static final String GETLABCODE = "SELECT labcode FROM employee WHERE empid=:empId";
	@Override
	public Object getlabcode(long empId) throws Exception {

		try {
			Query query = manager.createNativeQuery(GETLABCODE);
			query.setParameter("empId", empId);
			Object labcode = query.getSingleResult();
			return labcode;
		} catch (Exception e) {
			e.printStackTrace();
	
			return null;
		}
		
	}
	
	//old change
	
	@Override
	public List<Object[]> UserManagerList() throws Exception {
		Query query = manager.createNativeQuery(USERMANAGELIST);

		List<Object[]> UserManagerList = query.getResultList();
		return UserManagerList;
	}



	@Override
	public List<Object[]> DivisionList() throws Exception {
		Query query = manager.createNativeQuery(DIVISIONLIST);

		List<Object[]> DivisionList = query.getResultList();
		return DivisionList;
	}

	@Override
	public Object[] EmployeeData(String empid) throws Exception {
		Query query=manager.createNativeQuery(EMPLOYEEDATA);
		query.setParameter("empid",empid );
		List<Object[]> EmployeeData=(List<Object[]>)query.getResultList();		

		return EmployeeData.get(0);
	}


	@Override
	public Long UserManagerInsert(Login login) throws Exception {
	
		manager.persist(login);
		manager.flush();
		return login.getLoginId();
	}



	@Override
	public Login UserManagerEditData(Long LoginId) throws Exception {
		Query query = manager.createQuery(LOGINEDITDATA);
		query.setParameter("loginId", LoginId);
		Login UserManagerEditData = (Login) query.getSingleResult();
	
		return UserManagerEditData;
	}



	@Override
	public int UserNamePresentCount(String UserName) throws Exception {
		Query query = manager.createNativeQuery(USERNAMEPRESENTCOUNT);
		query.setParameter("username", UserName);
		
		Long UserNamePresentCount = (Long) query.getSingleResult();
		return   UserNamePresentCount.intValue();
	}



	@Override
	public int UserManagerUpdate(Login login) throws Exception {
		Query query = manager.createNativeQuery(LOGINUPDATE);

		query.setParameter("loginid", login.getLoginId());
        query.setParameter("logintype", login.getLoginTypeDms());
		query.setParameter("formroleid", login.getFormRoleId());
		query.setParameter("empid", login.getEmpId());
		query.setParameter("modifiedby", login.getModifiedBy());
		query.setParameter("modifieddate", login.getModifiedDate());
		int UserManagerUpdate = (int) query.executeUpdate();

		
		return  UserManagerUpdate;
	}



	@Override
	public int UserManagerDelete(Login login) throws Exception {
		Query query = manager.createNativeQuery(LOGINDELETE);
		query.setParameter("isactive", 0);
		query.setParameter("loginid", login.getLoginId());
		query.setParameter("modifiedby", login.getModifiedBy());
		query.setParameter("modifieddate", login.getModifiedDate());
		int UserManagerDelete = (int) query.executeUpdate();
		return  UserManagerDelete;
	}



	@Override
	public List<Object[]> EmployeeList(String lab) throws Exception {
		Query query=manager.createNativeQuery(EMPLOYEELIST);
		query.setParameter("labcode", lab);
		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();		
		return EmployeeList;
	}



	@Override
	public List<Object[]> LoginTypeList() throws Exception {
		Query query=manager.createNativeQuery(LOGINTYPELIST);
		List<Object[]> LoginTypeList=(List<Object[]>)query.getResultList();		
		return LoginTypeList;
	}



	@Override
	public int PasswordChange(String OldPassword, String NewPassword ,String UserName, String ModifiedDate)
			throws Exception {
		Query query = manager.createNativeQuery(PASSWORDUPDATECHANGE);
		
		
		query.setParameter("newpassword", NewPassword);
		query.setParameter("username", UserName);
		query.setParameter("modifiedby", UserName);
		query.setParameter("modifieddate", ModifiedDate);
		int PasswordChange = (int) query.executeUpdate();
		return  PasswordChange;
	}



	@Override
	public int PasswordReset(String NewPassword,Long LoginId,Long ModifiedBy, String ModifiedDate) throws Exception {
	Query query = manager.createNativeQuery(PASSWORDUPDATERESET);
		
		
		query.setParameter("newpassword", NewPassword);
		query.setParameter("loginid", LoginId);
		query.setParameter("modifiedby", ModifiedBy);
		query.setParameter("modifieddate", ModifiedDate);
		int PasswordReset = (int) query.executeUpdate();
		return  PasswordReset;
	}

	@Override
	public String OldPassword(String UserId) throws Exception {
		Query query = manager.createNativeQuery(OLDPASSWORD);
		query.setParameter("username", UserId);
		
		String OldPassword = (String) query.getSingleResult();
		return   OldPassword;
	}

	@Override
	public List<Object[]> AuditStampingList(String Username,LocalDate Fromdate,LocalDate Todate) throws Exception {
		
		Query query = manager.createNativeQuery(AUDITSTAMPING);
		query.setParameter("username", Username);
		query.setParameter("fromdate", Fromdate);
		query.setParameter("todate", Todate);
		 
		List<Object[]> AuditStampingList=(List<Object[]>) query.getResultList();

		return AuditStampingList;
	}

	@Override
	public List<Object[]> UsernameList() throws Exception {
		
		Query query = manager.createNativeQuery(USERNAMELIST);
		
		List<Object[]> UsernameList=(List<Object[]>) query.getResultList();

		return UsernameList;
	
	}

	@Override
	public Long FeedbackInsert(Feedback feedback) throws Exception {
		manager.persist(feedback);
		manager.flush();
		return feedback.getFeedbackId();
	}

	@Override
	public List<Object[]> FeedbackList() throws Exception {
		
       Query query = manager.createNativeQuery(FEEDBACKLIST);
		
		List<Object[]> FeedbackList=(List<Object[]>) query.getResultList();

		return FeedbackList;
	}

	@Override
	public Object[] FeedbackData(String Feedbackid) throws Exception {
	       Query query = manager.createNativeQuery(FEEDBACKDATA);
			query.setParameter("feedbackid", Feedbackid);
			Object[] FeedbackData=(Object[]) query.getSingleResult();

			return FeedbackData;
	}


	@Override
	public List<Object[]> getDakMembers() throws Exception {
		
       Query query = manager.createNativeQuery(DAKMEMBERS);
		
		List<Object[]> getDakMembers=(List<Object[]>) query.getResultList();

		return getDakMembers;
	}

	
	
	
	@Override
	public List<Object[]> StatsEmployeeList(String loginType, long divid, String lab) throws Exception {
		
		
		if(loginType.equalsIgnoreCase("D")) {
			Query query=manager.createNativeQuery(EMPLOYEELISTDH);
			query.setParameter("divid", divid);
			query.setParameter("lab", lab);
			System.out.println("FIRST");
			return (List<Object[]>)query.getResultList();
		}else if(loginType.equalsIgnoreCase("G")) {
			Query query=manager.createNativeQuery(EMPLOYEELISTGH);
			query.setParameter("divid", divid);
			query.setParameter("lab", lab);
			System.out.println("SECOND");
			return (List<Object[]>)query.getResultList();
		}else if(loginType.equalsIgnoreCase("A")|| loginType.equalsIgnoreCase("X")|| loginType.equalsIgnoreCase("Z")||loginType.equalsIgnoreCase("E") || loginType.equalsIgnoreCase("L")){
			Query query=manager.createNativeQuery(ALLEMPLOYEELIST);
			query.setParameter("lab", lab);
			System.out.println("THIRD");
			return (List<Object[]>)query.getResultList();
		}else {
		 return null;
		}
	}

	private static final String FIRSTDAY="SELECT MIN(logindate) AS 'MINDATE'  FROM dak_audit_stamping";
	@Override
	public String firstDateOfAudit() throws Exception {
		Query query = manager.createNativeQuery(FIRSTDAY);
		 Object result = query.getSingleResult();
		    if(result != null) {
		        // Assuming logindate is of type java.sql.Date
		        java.sql.Date minDate = (java.sql.Date) result;
		        // You can convert the date to a String using a SimpleDateFormat or another method
		        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		        return result.toString();
		    } else {
		        return "No records found";
		    }
	}

	
	@Override
	public List<Object[]> getAllEmployeesOfDate(String date) throws Exception {
			Query query = manager.createNativeQuery(EMPLIST);
			query.setParameter("logindate", date);
			List<Object[]>emplist= new ArrayList<>();
			emplist=(List<Object[]>)query.getResultList();
		return emplist;
	}
	
	
	@Override
	public Object[] ListOfWorkCounts(String UserName, String date,String EmpId) throws Exception {
		Query query=manager.createNativeQuery(WORKCOUNTS);
		query.setParameter("username", UserName);
		query.setParameter("date", date);
		query.setParameter("EmpId", EmpId);
		Object[] workCounts=(Object[])query.getSingleResult();
		return workCounts;
	}
	@Override
	public int DataInsetrtIntoPfmsStatistics(List<DmsStatistics> dmsStatistics) throws Exception {
		for(DmsStatistics d:dmsStatistics) {
			manager.persist(d);
		}
		return 1;
	}
	
	
	
	@Override
	public List<Object[]> getEmployeeWiseCount(String employeeId, String fromdate,String todate) throws Exception {
		
		List<Object[]> dmsstats=null;
		Query query=manager.createNativeQuery(EMPLOYEECOUNT);
		query.setParameter("employeeId", employeeId); 
		query.setParameter("fromdate", fromdate);
		query.setParameter("todate", todate);
		dmsstats=(List<Object[]>)query.getResultList();
		return dmsstats;
	}
	private static final String DMSSTATTABLEDATA="select * from dak_statistics";
	@Override
	public List<Object[]> dmsStatisticsTableData() throws Exception {
		Query query=manager.createNativeQuery(DMSSTATTABLEDATA);
		List<Object[]> totalData=(List<Object[]>)query.getResultList();
		return totalData;
	}
	
	@Override
	public List<Object[]> DakGroupingListDropDown() throws Exception {
		Query query=manager.createNativeQuery(DAKGROUPINGLIST);
		List<Object[]> DakGroupingListDropDown=(List<Object[]>)query.getResultList();
		return DakGroupingListDropDown;
	}
	@Override
	public List<Object[]> GroupEmployeeList(long grpId) throws Exception {
		Query query=manager.createNativeQuery(GROUPINGEMPLOYEELIST);
		query.setParameter("grpId", grpId);
		List<Object[]> GroupEmployeeList=(List<Object[]>)query.getResultList();
		return GroupEmployeeList;
	}
	
	@Override
	public List<Object[]> StartEmployeeList(String lab) throws Exception {
		try {
		Query query =manager.createNativeQuery(STARTEMPLOYEELIST);
		query.setParameter("lab", lab);
		List<Object[]> StartEmployeeList =(List<Object[]>)query.getResultList();				
		return StartEmployeeList;
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<Object[]> SelMemberTypeEmployeeList(String memberTypeId, String lab) throws Exception {
		try {
		Query query =manager.createNativeQuery(SELMEMBERTYPEEMPLOYEELIST);
		query.setParameter("memberTypeId", memberTypeId);
		query.setParameter("lab", lab);
		List<Object[]> StartEmployeeList =(List<Object[]>)query.getResultList();				
		return StartEmployeeList;
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public List<Object[]> FeedbackListForUser(String lab, String EmpId) throws Exception {
		try {
		Query query = manager.createNativeQuery(FEEDBACKLISTFORUSER);
		query.setParameter("labcode", lab);
		query.setParameter("empid", EmpId);
		List<Object[]> FeedbackListForUser = (List<Object[]>) query.getResultList();
		return FeedbackListForUser;
		}catch (Exception e) {
		  e.printStackTrace();
		  return null;
		}
	}

	@Override
	public List<Object[]> GetfeedbackAttch() throws Exception {
		try {
			Query query = manager.createNativeQuery(ATTACHLIST);
			List<Object[]> GetfeedbackAttch = (List<Object[]>) query.getResultList();
			return GetfeedbackAttch;	
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	@Override
	public List<Object[]> GetfeedbackAttchForUser(String empid) throws Exception {
		try {
			Query query = manager.createNativeQuery(USERATTCHFEEDBACK);
			query.setParameter("empid", empid);
			List<Object[]> GetfeedbackAttchForUser = (List<Object[]>) query.getResultList();
			return GetfeedbackAttchForUser;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public long FeedbackAttachInsert(dakFeedbackAttach attach) throws Exception {
	try {
		manager.persist(attach);
		manager.flush();
		return attach.getFeedbackAttachId();
	} catch (Exception e) {
		e.printStackTrace();
		return 0;
	}
	}
	
	@Override
	public List<Object[]> FeedbackList(String fromDate, String toDate, String empId, String lab, String feedbacktype) throws Exception {
		try {
			Query query = manager.createNativeQuery(FEEDBACKLIST);
			query.setParameter("empid", empId);
			query.setParameter("fromdate", fromDate);
			query.setParameter("todate", toDate);
			query.setParameter("labcode", lab);
			query.setParameter("feedbacktype", feedbacktype);
			List<Object[]> FeedbackList = (List<Object[]>) query.getResultList();
			return FeedbackList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public dakFeedbackAttach FeedbackAttachmentDownload(String achmentid) throws Exception {
		dakFeedbackAttach attachment=manager.find(dakFeedbackAttach.class, Long.parseLong(achmentid));
		return attachment;
	}
	
	@Override
	public Object[] FeedbackContent(String feedbackid) throws Exception {
		try {
			 Query query=manager.createNativeQuery(FEEDBACKCONTENT);   
			 query.setParameter("feedbackid", feedbackid);
			 return  (Object[])query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public int CloseFeedback(String feedbackid, String remarks, String username) throws Exception {
		try {
			Query query=manager.createNativeQuery(CLOSEFEEDBACK);   
			query.setParameter("feedbackId", feedbackid);
			query.setParameter("remarks", remarks);
			query.setParameter("status", "C");
			query.setParameter("modifiedby", username);
			query.setParameter("modifieddate", sdf1.format(new Date()));
			int count =(int)query.executeUpdate();
			return count ;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String GETHANDINGOVEROFFICERS="SELECT e.EmpId,e.EmpName,d.Designation,e.EmpNo FROM employee e,employee_desig d WHERE e.DesigId=d.DesigId AND e.IsActive=1 ORDER BY CASE WHEN e.Srno = 0 THEN 1 ELSE 0 END, e.Srno ASC";
	@Override
	public List<Object[]> GetHandingOverOfficers() throws Exception {
		try {
			Query query=manager.createNativeQuery(GETHANDINGOVEROFFICERS);
			return (List<Object[]>)query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	private static final String GETHANDINGOVERTOOFFICERS="SELECT e.EmpId,e.EmpName,d.Designation,e.EmpNo FROM employee e,employee_desig d WHERE e.DesigId=d.DesigId AND e.EmpId<>:handingOfficer AND e.IsActive=1 ORDER BY CASE WHEN e.Srno = 0 THEN 1 ELSE 0 END, e.Srno ASC";
	@Override
	public List<Object[]> GetHandingOverToOfficers(String handingOfficer) throws Exception {
		try {
			Query query=manager.createNativeQuery(GETHANDINGOVERTOOFFICERS);
			query.setParameter("handingOfficer", handingOfficer);
			return (List<Object[]>)query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public Long insertHandingOver(DakHandingOver model) throws Exception {
		try {
			manager.persist(model);
			manager.flush();
			return model.getHandingOverId();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	private static final String HANDINGOVERLIST="SELECT h.HandingOverId,(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE h.FromEmpId=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1) AS 'FromEmployee',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE h.ToEmpId=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1) AS 'ToEmployee',h.FromDate,h.ToDate,h.CreatedDate FROM dak_handingover h WHERE DATE(h.CreatedDate) BETWEEN :fromDate AND :toDate AND h.IsActive=1";
	@Override
	public List<Object[]> HandingOverList(String fromDate, String toDate) throws Exception {
		try {
			Query query=manager.createNativeQuery(HANDINGOVERLIST);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			return (List<Object[]>)query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	private static final String FROMANDTODATECOUNT="SELECT COUNT(*) FROM dak_handingover h WHERE (:fromDate BETWEEN h.fromdate AND h.todate) OR (:toDate BETWEEN h.fromdate AND h.todate)  AND h.IsActive=1";
	@Override
	public long fromAndtoDateCount(String fromDate, String toDate) throws Exception {
		Query query = manager.createNativeQuery(FROMANDTODATECOUNT);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		Long fromAndtoDateCount = (Long) query.getSingleResult();
		return fromAndtoDateCount.longValue();	
	}
	
	
	private static final String FROMEMPLOYEECOUNT="SELECT COUNT(*) FROM dak_handingover h WHERE h.FromEmpId=:FromEmpId AND h.IsActive AND ((:fromDate BETWEEN h.fromdate AND h.todate) OR (:toDate BETWEEN h.fromdate AND h.todate))";
	@Override
	public long FromEmployeeCount(long FromEmpId,String fromDate, String toDate) throws Exception {
		Query query = manager.createNativeQuery(FROMEMPLOYEECOUNT);
		query.setParameter("FromEmpId", FromEmpId);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		Long fromAndtoDateCount = (Long) query.getSingleResult();
		return fromAndtoDateCount.longValue();
	}
	
	@Override
	public DakHandingOver getEditHandingOfficerData(Long handingOverId) throws Exception {
		return manager.find(DakHandingOver.class, handingOverId);
	}
	
	private static final String FROMANDTODATECOUNTEDIT="SELECT COUNT(*) FROM dak_handingover h WHERE ((:fromdate BETWEEN h.fromdate AND h.todate) OR (:todate BETWEEN h.fromdate AND h.todate)) AND h.IsActive=1 AND h.HandingOverId<>:handingOverId";
	@Override
	public long fromAndtoDateCountEdit(String fromdate, String todate, Long handingOverId) throws Exception {
		Query query = manager.createNativeQuery(FROMANDTODATECOUNTEDIT);
		query.setParameter("fromdate", fromdate);
		query.setParameter("todate", todate);
		query.setParameter("handingOverId", handingOverId);
		Long fromAndtoDateCountEdit = (Long) query.getSingleResult();
		return fromAndtoDateCountEdit.longValue();
	}
	
	
	@Override
	public long updateHandingOver(DakHandingOver modelupdate) throws Exception {
		try {
			manager.merge(modelupdate);
			manager.flush();
			return modelupdate.getHandingOverId();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String FROMEMPLOYEECOUNTEDIT="SELECT COUNT(*) FROM dak_handingover h WHERE h.FromEmpId=:FromEmpId AND h.HandingOverId<>:handingOverId AND h.IsActive='1' AND ((:fromDate BETWEEN h.fromdate AND h.todate) OR (:toDate BETWEEN h.fromdate AND h.todate))";
	@Override
	public long FromEmployeeCountEdit(long FromEmpId, Long handingOverId,String fromdate, String todate) throws Exception {
		Query query = manager.createNativeQuery(FROMEMPLOYEECOUNTEDIT);
		query.setParameter("FromEmpId", FromEmpId);
		query.setParameter("handingOverId", handingOverId);
		query.setParameter("fromdate", fromdate);
		query.setParameter("todate", todate);
		Long FromEmployeeCountEdit = (Long) query.getSingleResult();
		return FromEmployeeCountEdit.longValue();
	}
	
	
	private static final String UPDATEHANDINGOVERREVOKE="UPDATE dak_handingover h SET h.IsActive='0' WHERE h.HandingOverId=:handingOverId";
	@Override
	public long updatehandingoverRevoke(long handingOverId) throws Exception {
		Query query = manager.createNativeQuery(UPDATEHANDINGOVERREVOKE);
		query.setParameter("handingOverId", handingOverId);
		long updatehandingoverRevoke = (long) query.executeUpdate();
		return  updatehandingoverRevoke;
	}
	
	
}


