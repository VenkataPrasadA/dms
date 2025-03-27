package com.vts.dms.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.vts.dms.cfg.ReversibleEncryptionAlg;
import com.vts.dms.controller.DmsController;
import com.vts.dms.dao.DmsDao;
import com.vts.dms.dto.MailConfigurationDto;
import com.vts.dms.master.model.Employee;
import com.vts.dms.master.model.EmployeeDesig;
import com.vts.dms.model.LabMaster;
import com.vts.dms.model.MailConfiguration;
import com.vts.dms.model.AuditPatches;
import com.vts.dms.model.AuditStamping;
import com.vts.dms.model.DakMailTracking;
import com.vts.dms.model.DakMailTrackingInsights;
import com.vts.dms.model.DakSmsTracking;
import com.vts.dms.model.DakSmsTrackingInsights;


@Service
public class DmsServiceImp implements DmsService {

	@Autowired
	DmsDao dao;
	
	@Autowired
	ReversibleEncryptionAlg rea;
	
	private static final Logger logger=LogManager.getLogger(DmsServiceImp.class);
	
    private  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");

	@Override
	public Long LoginStampingInsert(AuditStamping Stamping) throws Exception {		
		return dao.LoginStampingInsert(Stamping);
	}
	
	@Override
	public Long LoginValidation(String User, String Password) throws Exception {
		return dao.LoginValidation(User, Password);
	}

	@Override
	public List<Object[]> DashBoardFormUrlList(String FormModuleId, String loginId) throws Exception {
		int FormModuleIdinput=Integer.parseInt(FormModuleId);
		int LoginIdinput=Integer.parseInt(loginId);
		List<Object[]> DashBoardFormUrlList=dao.DashBoardFormUrlList(FormModuleIdinput, LoginIdinput);
		return DashBoardFormUrlList;
	}
	
	@Override
	public List<Object[]> MailConfigurationList()throws Exception{
		return  dao.MailConfigurationList();
	}
	
	@Override
	public long AddMailConfiguration(String userName, String password, String hostType, String createdBy,String Host,String Port)throws Exception{
		
		long finalResult = 0;
		try {
          System.out.println("Encrypted Password By AesAlgorithm: " + rea.encryptByAesAlg(password));
	    } catch (Exception e) {
		    e.printStackTrace();
		    System.out.println("Password:errror encrpting ");
		}
		
		MailConfiguration mailConfigAdd =  new MailConfiguration();
		mailConfigAdd.setTypeOfHost(hostType);
        mailConfigAdd.setUsername(userName);
        mailConfigAdd.setCreatedBy(createdBy);
	    mailConfigAdd.setCreatedDate(sdf1.format(new Date()));
	    mailConfigAdd.setIsActive(1);
		/////////////////////////////////////////////////////////Just defaut value
System.out.println("The Host Type is :"+hostType);
        mailConfigAdd.setHost(Host);
	    mailConfigAdd.setPort(Port);
		
		////////////////////////////////////////////////////////
//Modern authentication systems typically use one-way hash functions like bcrypt which cannot be decryptes
// (unlike bcrypt, which is designed to be irreversible)that means You can't really "decrypt" a bcrypt-hashed password.
//If you need to support both encryption and decryption of passwords for mail,you  want to use a reversible encryption algorithm
	    mailConfigAdd.setPassword(rea.encryptByAesAlg(password));
	    long count=dao.getTypeOfHostCount(hostType);
	    if(count==0) {
	    finalResult = dao.AddMailConfiguration(mailConfigAdd);
	    }else {
	    	finalResult=-1;
	    }
		return finalResult;
	}
	
	public long DeleteMailConfiguration(long MailConfigurationId, String ModifiedBy)throws Exception{
		long finalResult = 0;
		finalResult = dao.DeleteMailConfiguration(MailConfigurationId,ModifiedBy);
		try {
	    } catch (Exception e) {
		    e.printStackTrace();
		    System.out.println("DeleteMailConfiguration in ServiceImpl ");
		    finalResult = 0;
		}
		return finalResult;
	}
	
	@Override
	public Object[] MailConfigurationEditList(long MailConfigurationId)throws Exception{
		return dao.MailConfigurationEditList(MailConfigurationId);
	}
	
	@Override
	public long UpdateMailConfiguration(long MailConfigurationId,String userName,String hostType, String modifiedBy,String Host,String Port,String Password)throws Exception{
	    logger.info(new Date() + " ServiceImpl  UpdateMailConfiguration");
	    long finalResult = 0;
		try {
			String pass=rea.encryptByAesAlg(Password);
			finalResult = dao.UpdateMailConfiguration(MailConfigurationId,userName,hostType,modifiedBy,Host,Port,pass);
		  }catch (Exception e) {
		    	 logger.error(new Date() +" Login Problem Occures When MailConfiguration.htm was clicked ", e);
		    	 finalResult = 0;
		     }
		return finalResult;
	}
	
	
	@Override
	public MailConfigurationDto getMailConfigByTypeOfHost(String typeOfHost) throws Exception {
	    List<Object[]> mailPropertiesByTypeOfHost = dao.GetMailPropertiesByTypeOfHost(typeOfHost);
	    if (mailPropertiesByTypeOfHost != null && !mailPropertiesByTypeOfHost.isEmpty()) {
	        Object[] obj = mailPropertiesByTypeOfHost.get(0); // Assuming you only expect one result
	        if (obj[2] != null && obj[3] != null && obj[4] != null && obj[5] != null) {
	            MailConfigurationDto dto = new MailConfigurationDto();
	            dto.setHost(obj[2].toString());
	            dto.setPort(obj[3].toString());
	            dto.setUsername(obj[4].toString());
	            // Assuming you have a method to decrypt the password using aes algorithm
	            String decryptedPassword = rea.decryptByAesAlg(obj[5].toString());
	            dto.setPassword(decryptedPassword);
	            return dto;
	        } else {
	            return null;
	        }
	    } else {
	        return null;
	    }
	}


	
	
	@Override
	public List<Object[]> UserManagerList() throws Exception {
		return dao.UserManagerList();
	}

	@Override
	public int LoginStampingUpdate(String Logid ,String LogoutType) throws Exception {
		AuditStamping stamping=new AuditStamping();
        stamping.setAuditStampingId(dao.LastLoginStampingId(Logid));
        stamping.setLogOutType(LogoutType);
        stamping.setLogOutDateTime(sdf1.format(new Date()));
		return dao.LoginStampingUpdate(stamping);
	}


	@Override
	public LabMaster LabDetailes() throws Exception {
		return dao.LabDetailes();
	}

	@Override
	public String DesgId(String Empid) throws Exception {
		return dao.DesgId(Empid);
	}

	@Override
	public Employee EmployeeInfo(Long empId) throws Exception {
		return dao.EmployeeInfo(empId);
	}

	@Override
	public EmployeeDesig DesignationInfo(Long desigId) throws Exception {
		return dao.DesignationInfo(desigId);
	}

	@Override
	public Object[] getDashBoardCount(long empId, String fromDate, String toDate, String username,String Source,String Project,String SelSourceType,String selProjectTypeId,String MemberTypeId,String Emp,String Delivery,String Priority)throws Exception {
		return dao.getDashBoardCount(empId,fromDate,toDate,username,Source,Project,SelSourceType,selProjectTypeId,MemberTypeId,Emp,Delivery,Priority);
	}

	@Override
	public List<Object[]> SourceList() throws Exception {
		return dao.SourceList();
	}

	@Override
	public List<Object[]> AllSourceTypeList() throws Exception {
		return dao.AllSourceTypeList();
	}

	
	@Override
	public long GetMailInitiatedCount(String TrackingType) throws Exception {
		return dao.GetMailInitiatedCount(TrackingType);
	}
	
	@Override
	public long InsertMailTrackInitiator(String TrackingType) throws Exception {
		long rowAddResult = 0;
		DakMailTracking Model  = new DakMailTracking();
		Model.setTrackingType(TrackingType);
		if(TrackingType == "D") {
	          long dailyPendingCount = dao.GetDailyExpectedPendingReplyCount();
	          Model.setMailExpectedCount(dailyPendingCount);
		}else if(TrackingType == "W") {
			long weeklyPendingCount = 	dao.GetWeeklyExpectedPendingReplyCount();
			 Model.setMailExpectedCount(weeklyPendingCount);
		
		}else if(TrackingType == "S") {
			long summaryDistributedCount = 	dao.GetSummaryOfDailyDistributedCount();
			 Model.setMailExpectedCount(summaryDistributedCount);
		}
		Model.setMailSentCount(0);
		Model.setMailSentStatus("N");
		Model.setCreatedDate(sdf2.format(new Date()));
		Model.setCreatedTime(new SimpleDateFormat("HH:mm:ss").format(new Date()));
	    rowAddResult = dao.InsertMailTrackRow(Model);
		return rowAddResult;
	}
	
	@Override
	public List<Object[]> GetDailyPendingReplyEmpData() throws Exception {
		return dao.GetDailyPendingReplyEmpData();
	}
	
	@Override
	public List<Object[]> GetWeeklyPendingReplyEmpData() throws Exception {
		return dao.GetWeeklyPendingReplyEmpData();
	}
	
	@Override
	public List<Object[]> GetSummaryDistributedEmpData() throws Exception {
		return dao.GetSummaryDistributedEmpData();
	}

	
	public long InsertDailyDistributedInsights(long MailTrackingId)throws Exception{
		return 0;
	}
	
	
	public long InsertDailyPendingInsights(long MailTrackingId) throws Exception {
	    long TrackingInsightsResult = 0;

	    List<Object[]> PendingReplyEmpsDetailstoSendMail = dao.GetDailyPendingReplyEmpData();
	    if (PendingReplyEmpsDetailstoSendMail != null && PendingReplyEmpsDetailstoSendMail.size() > 0) {
	        Map<Integer, Set<String>> empDakNosMap = new HashMap();

	        for (Object[] rowData : PendingReplyEmpsDetailstoSendMail) {
	            int empId = Integer.parseInt(rowData[1].toString());
	            String dakNo = rowData[4].toString();

	            if (!empDakNosMap.containsKey(empId)) {
	                empDakNosMap.put(empId, new HashSet<>());
	            }
	            empDakNosMap.get(empId).add(dakNo);
	        }
	        for (Map.Entry<Integer, Set<String>> entry : empDakNosMap.entrySet()) {
	            int empId = entry.getKey();
	            Set<String> dakNosSet = entry.getValue();
	            // Create a new instance of DakMailTrackingInsights for each entry
	            DakMailTrackingInsights Insights = new DakMailTrackingInsights();
	            Insights.setMailTrackingId(MailTrackingId);
	            Insights.setMailPurpose("D");
	            Insights.setMailStatus("N");
	            Insights.setCreatedDate(sdf1.format(new Date()));
	            Insights.setEmpId(empId);
	            Insights.setDakNos(String.join(",", dakNosSet));
	            // Insert the row into the table for this entry
	            long result = dao.InsertMailTrackInsights(Insights);
	            TrackingInsightsResult = result;
	        }
	    }
	    return TrackingInsightsResult;
	}
	
	@Override
	public long UpdateParticularEmpMailStatus(String MailPurpose,String MailStatus,long empId,long MailTrackingId) {
		return dao.UpdateParticularEmpMailStatus(MailPurpose,MailStatus,empId,MailTrackingId);
	}
	
	@Override
	public long InsertWeeklyPendingInsights(long MailTrackingId)throws Exception{
	    long TrackingInsightsResult = 0;
	    List<Object[]> PendingReplyEmpsDetailstoSendMail = dao.GetWeeklyPendingReplyEmpData();
	    if (PendingReplyEmpsDetailstoSendMail != null && PendingReplyEmpsDetailstoSendMail.size() > 0) {
	        Map<Integer, Set<String>> empDakNosMap = new HashMap();
	        for (Object[] rowData : PendingReplyEmpsDetailstoSendMail) {
	            int empId = Integer.parseInt(rowData[1].toString());
	            String dakNo = rowData[4].toString();
                if (!empDakNosMap.containsKey(empId)) {
	                empDakNosMap.put(empId, new HashSet<>());
	            }
	            empDakNosMap.get(empId).add(dakNo);
	     }
	        for (Map.Entry<Integer, Set<String>> entry : empDakNosMap.entrySet()) {
	            int empId = entry.getKey();
	            Set<String> dakNosSet = entry.getValue();
	            // Create a new instance of DakMailTrackingInsights for each entry
	            DakMailTrackingInsights Insights = new DakMailTrackingInsights();
	            Insights.setMailTrackingId(MailTrackingId);
	            Insights.setMailPurpose("W");
	            Insights.setMailStatus("N");
	            Insights.setCreatedDate(sdf1.format(new Date()));
	            Insights.setEmpId(empId);
	            Insights.setDakNos(String.join(",", dakNosSet));
	            // Insert the row into the table for this entry
	            long result = dao.InsertMailTrackInsights(Insights);
	            TrackingInsightsResult = result;
	        }
	    }
	    return TrackingInsightsResult;
	}
	
    @Override
	public long InsertSummaryDistributedInsights(long MailTrackingId)throws Exception{
    	   long TrackingInsightsResult = 0;
    	   List<Object[]> SummaryDistributedtoSendMail = dao.GetSummaryDistributedEmpData();
   	    if (SummaryDistributedtoSendMail != null && SummaryDistributedtoSendMail.size() > 0) {
   	         Map<Integer, Set<String>> empDakNosMap = new HashMap();
   	         for (Object[] rowData : SummaryDistributedtoSendMail) {
   	            int empId = Integer.parseInt(rowData[1].toString());
   	            String dakNo = rowData[4].toString();
                   if (!empDakNosMap.containsKey(empId)) {
   	                empDakNosMap.put(empId, new HashSet<>());
   	        }
              empDakNosMap.get(empId).add(dakNo);
   	      }
   	     for (Map.Entry<Integer, Set<String>> entry : empDakNosMap.entrySet()) {
   	            int empId = entry.getKey();
   	            Set<String> dakNosSet = entry.getValue();
   	            // Create a new instance of DakMailTrackingInsights for each entry
   	            DakMailTrackingInsights Insights = new DakMailTrackingInsights();
   	            Insights.setMailTrackingId(MailTrackingId);
   	            Insights.setMailPurpose("S");
   	            Insights.setMailStatus("N");
   	            Insights.setCreatedDate(sdf1.format(new Date()));
   	            Insights.setEmpId(empId);
   	            Insights.setDakNos(String.join(",", dakNosSet));

   	            // Insert the row into the table for this entry
   	            long result = dao.InsertMailTrackInsights(Insights);
   	            TrackingInsightsResult = result;
   	        }
   	    }
   	 return TrackingInsightsResult;
	}
	
	@Override
	public long updateMailSuccessCount(long MailTrackingId,long MailSendSucessCount,String TrackingType) throws Exception {
		long rowUpdateResult = dao.UpdateDakMailTrackRow(MailTrackingId,MailSendSucessCount,TrackingType);
	    return rowUpdateResult;
	}

	@Override
	public long UpdateNoPendingReply(String TrackingType)throws Exception{
		return dao.UpdateNoPendingReply(TrackingType);
	}

	@Override
	public List<Object[]> SelectedSourceTypeList(String source) throws Exception {
		return dao.SelectedSourceTypeList(source);
	}

	@Override
	public List<Object[]> ProjectTypeList(String lab) throws Exception {
		return dao.ProjectTypeList(lab);
	}

	@Override
	public List<Object[]> SelProjectTypeList(String lab) throws Exception {
		return dao.SelProjectTypeList(lab);
	}

	@Override
	public Object getlabcode(long empId) throws Exception {
		return dao.getlabcode(empId);
	}

	@Override
	public List<Object[]> SelNonProjectTypeList() throws Exception {
		return dao.SelNonProjectTypeList();
	}

	@Override
	public List<Object[]> SelOtherProjectTypeList() throws Exception {
		return dao.SelOtherProjectTypeList();
	}

	@Override
	public List<Object[]> DakSLAMissedDashBoardCount(String fromDate, String toDate, String source, String project,String selSourceType, String selProjectTypeId,String MemberTypeId,String Emp,String Delivery,String Priority) throws Exception {
		return dao.DakSLAMissedDashBoardCount(fromDate,toDate,source,project,selSourceType,selProjectTypeId,MemberTypeId,Emp,Delivery,Priority);
	}

	@Override
	public List<Object[]> DakSLANearDashBoardCount(String fromDate, String toDate, String source, String project,String selSourceType, String selProjectTypeId,String MemberTypeId,String Emp,String Delivery,String Priority) throws Exception {
		return dao.DakSLANearDashBoardCount(fromDate,toDate,source,project,selSourceType,selProjectTypeId,MemberTypeId,Emp,Delivery,Priority);
	}

	@Override
	public List<Object[]> DakGroupingListDropDown() throws Exception {
		return dao.DakGroupingListDropDown();
	}

	@Override
	public List<Object[]> StartEmployeeList(String lab) throws Exception {
		return dao.StartEmployeeList(lab);
	}

	@Override
	public List<Object[]> SelMemberTypeEmployeeList(String memberTypeId, String lab) throws Exception {
		return dao.SelMemberTypeEmployeeList(memberTypeId,lab);
	}

	@Override
	public List<Object[]> DakDeliveryList() throws Exception {
		return dao.DakDeliveryList();
	}

	@Override
	public List<Object[]> getPriorityList() throws Exception {
		return dao.getPriorityList();
	}

	@Override
	public Object[] ProjectWiseCount(String ProjectId,String fromDate, String toDate) throws Exception {
		return dao.ProjectWiseCount(ProjectId,fromDate, toDate);
	}

	@Override
	public Object[] ProjectCardsCount(String fromDate, String toDate) throws Exception {
		return dao.ProjectCardsCount(fromDate,toDate);
	}

	@Override
	public Object[] GroupCardsCount(String fromDate, String toDate) throws Exception {
		return dao.GroupCardsCount(fromDate,toDate);
	}

	@Override
	public Object[] GroupWiseCount(String DakMemberTypeId, String fromDate, String toDate) throws Exception {
		return dao.GroupWiseCount(DakMemberTypeId,fromDate,toDate);
	}
	
	@Override
	public long GetSMSInitiatedCount(String SmsTrackingType) throws Exception {
		return dao.GetSMSInitiatedCount(SmsTrackingType);
	}
	@Override
	public long InsertSmsTrackInitiator(String SmsTrackingType) throws Exception {
		long rowAddResult = 0;
		DakSmsTracking Model  = new DakSmsTracking();
		Model.setSmsTrackingType(SmsTrackingType);
	    long dailyPendingCount = dao.GetDailyExpectedPendingReplyCount();
	    Model.setSmsExpectedCount(dailyPendingCount);
		Model.setSmsSentCount(0);
		Model.setSmsSentStatus("N");
		Model.setCreatedDate(sdf2.format(new Date()));
		Model.setCreatedTime(new SimpleDateFormat("HH:mm:ss").format(new Date()));
	    rowAddResult = dao.InsertSmsTrackRow(Model);
		return rowAddResult;
	}
	
	@Override
	public Object[] PopUpCount(long empId,String popupdate) throws Exception {
		return dao.PopUpCount(empId,popupdate);
	}
	
//	@Override
//	public long InsertDailySmsPendingInsights(long smsTrackingId) throws Exception {
//		  long TrackingInsightsResult = 0;
//		  long count=0;
//		    List<Object[]> PendingReplyEmpsDetailstoSendSms = dao.GetDailyPendingReplyEmpData();
//		    if (PendingReplyEmpsDetailstoSendSms != null && PendingReplyEmpsDetailstoSendSms.size() > 0) {
//		        Map<Integer, Set<String>> empDakNosMap = new HashMap();
//		        for (Object[] rowData : PendingReplyEmpsDetailstoSendSms) {
//		            int empId = Integer.parseInt(rowData[1].toString());
//		            String MobileNo = rowData[7].toString();
//		            if (!empDakNosMap.containsKey(empId)) {
//		                empDakNosMap.put(empId, new HashSet<>());
//		            }
//		            empDakNosMap.get(empId).add(MobileNo);
//		        }
//
//		        for (Map.Entry<Integer, Set<String>> entry : empDakNosMap.entrySet()) {
//		            int empId = entry.getKey();
//		            Set<String> MobileNo = entry.getValue();
//		            String message="";
//		            String mobileNumber = MobileNo.isEmpty() ? null : MobileNo.iterator().next();
//		            Object[] DakCounts =dao.DakCounts(empId,LocalDate.now().toString());
//		            if(mobileNumber != null && !mobileNumber.equalsIgnoreCase("0") && mobileNumber.trim().length()>0 && mobileNumber.trim().length()==10 && Integer.parseInt(DakCounts[0].toString())>0) {
//		            message = "Good Morning DAK  DP= " +DakCounts[0].toString() + "  DU= "+DakCounts[1].toString() +"  DT= " +DakCounts[2].toString()+" DD= "+DakCounts[3].toString() +" - DMS Team.";
//		            // Create a new instance of DakMailTrackingInsights for each entry
//		            DakSmsTrackingInsights Insights = new DakSmsTrackingInsights();
//		            Insights.setSmsTrackingId(smsTrackingId);
//		            Insights.setSmsPurpose("D");
//		            Insights.setSmsStatus("S");
//		            Insights.setDakPendingCount(Long.parseLong(DakCounts[0].toString()));
//		            Insights.setDakUrgentCount(Long.parseLong(DakCounts[1].toString()));
//		            Insights.setDakTodayPending(Long.parseLong(DakCounts[2].toString()));
//		            Insights.setDakDelayCount(Long.parseLong(DakCounts[3].toString()));
//		            Insights.setMessage(message);
//		            Insights.setCreatedDate(sdf1.format(new Date()));
//		            Insights.setSmsSentDate(sdf1.format(new Date()));
//		            Insights.setEmpId(empId);
//		            // Insert the row into the table for this entry
//		            long result = dao.InsertSmsTrackInsights(Insights);
//		            TrackingInsightsResult = result;
//		            if(TrackingInsightsResult>0) {
//		            	count++;
//		            }
//		        }
//		    }
//		    }
//		    return count;
//	}
	
	
	@Override
	public long InsertDailySmsPendingInsights(long smsTrackingId) throws Exception {
		  long TrackingInsightsResult = 0;

		    List<Object[]> PendingReplyEmpsDetailstoSendSms = dao.GetDailyPendingReplyEmpData();
		    if (PendingReplyEmpsDetailstoSendSms != null && PendingReplyEmpsDetailstoSendSms.size() > 0) {
		        Map<Integer, Set<String>> empDakNosMap = new HashMap();

		        for (Object[] rowData : PendingReplyEmpsDetailstoSendSms) {
		            int empId = Integer.parseInt(rowData[1].toString());
		            String dakNo = rowData[4].toString();
		            
		            if (!empDakNosMap.containsKey(empId)) {
		                empDakNosMap.put(empId, new HashSet<>());
		            }

		            empDakNosMap.get(empId).add(dakNo);
		        }

		        for (Map.Entry<Integer, Set<String>> entry : empDakNosMap.entrySet()) {
		            int empId = entry.getKey();
		            Set<String> dakNosSet = entry.getValue();
		            
		            Object[] DakCounts =dao.DakCounts(empId,LocalDate.now().toString());
		            
		            // Create a new instance of DakMailTrackingInsights for each entry
		            DakSmsTrackingInsights Insights = new DakSmsTrackingInsights();
		            Insights.setSmsTrackingId(smsTrackingId);
		            Insights.setSmsPurpose("D");
		            Insights.setSmsStatus("N");
		            Insights.setDakPendingCount(Long.parseLong(DakCounts[0].toString()));
		            Insights.setDakUrgentCount(Long.parseLong(DakCounts[1].toString()));
		            Insights.setDakTodayPending(Long.parseLong(DakCounts[2].toString()));
		            Insights.setDakDelayCount(Long.parseLong(DakCounts[3].toString()));
		            Insights.setCreatedDate(sdf1.format(new Date()));
		            Insights.setEmpId(empId);

		            // Insert the row into the table for this entry
		            long result = dao.InsertSmsTrackInsights(Insights);
		            TrackingInsightsResult = result;
		        }
		    }

		    return TrackingInsightsResult;
	}
	
	@Override
	public Object[] DakCounts(long EmpId, String ActionDate) throws Exception {
		return dao.DakCounts(EmpId,ActionDate);
	}
	
	@Override
	public long UpdateParticularEmpSmsStatus(String SmsPurpose, String SmsStatus, long EmpId,long effectivelyFinalSmsTrackingId, String message) throws Exception {
		return dao.UpdateParticularEmpSmsStatus(SmsPurpose,SmsStatus,EmpId,effectivelyFinalSmsTrackingId,message);
	}
	
	@Override
	public long updateSmsSuccessCount(long smsTrackingId, long SuccessCount, String TrackingType) throws Exception {
		long rowUpdateResult = dao.UpdateDakSmsTrackRow(smsTrackingId,SuccessCount,TrackingType);
	    return rowUpdateResult;
	}
	
	@Override
	public long UpdateNoSmsPendingReply(String TrackingType) throws Exception {
		return dao.UpdateNoSmsPendingReply(TrackingType);
	}
	
	@Override
	public long DirectorInsertSmsTrackInitiator(String TrackingType) throws Exception {
		long rowAddResult = 0;
		DakSmsTracking Model  = new DakSmsTracking();
		Model.setSmsTrackingType(TrackingType);
	    Model.setSmsExpectedCount(1);
		Model.setSmsSentCount(0);
		Model.setSmsSentStatus("N");
		Model.setCreatedDate(sdf2.format(new Date()));
		Model.setCreatedTime(new SimpleDateFormat("HH:mm:ss").format(new Date()));
	    rowAddResult = dao.InsertSmsTrackRow(Model);
		return rowAddResult;
	}
	
	@Override
	public List<Object[]> GetDirectorDailyPendingReplyEmpData(String Lab) throws Exception {
		return dao.GetDirectorDailyPendingReplyEmpData(Lab);
	}

//	@Override
//	public long DirectorInsertDailySmsPendingInsights(long smsTrackingId) throws Exception {
//		 long TrackingInsightsResult = 0;
//		 long count=0;
//		 List<Object[]> DirectorPendingReplyEmpsDetailstoSendSms = dao.GetDirectorDailyPendingReplyEmpData("LRDE");
//		    if (DirectorPendingReplyEmpsDetailstoSendSms != null && DirectorPendingReplyEmpsDetailstoSendSms.size() > 0) {
//		        for (Object[] rowData : DirectorPendingReplyEmpsDetailstoSendSms) {
//		            int empId = Integer.parseInt(rowData[0].toString());
//		            String MobileNo=rowData[1].toString();
//		            Object[] DirectorDakCounts =dao.DirectorDakCounts(LocalDate.now().toString());
//		            // Create a new instance of DakMailTrackingInsights for each entry
//		            if(MobileNo != null && !MobileNo.equalsIgnoreCase("0") && MobileNo.trim().length()>0 && MobileNo.trim().length()==10 && Integer.parseInt(DirectorDakCounts[0].toString())>0) {
//		            String message = "Good Morning DAK  DP= " +DirectorDakCounts[0].toString() + "  DU= "+DirectorDakCounts[1].toString() +"  DT= " +DirectorDakCounts[2].toString()+" DD= "+DirectorDakCounts[3].toString() +" - DMS Team.";
//		            DakSmsTrackingInsights Insights = new DakSmsTrackingInsights();
//		            Insights.setSmsTrackingId(smsTrackingId);
//		            Insights.setSmsPurpose("D");
//		            Insights.setSmsStatus("S");
//		            Insights.setDakPendingCount(Long.parseLong(DirectorDakCounts[0].toString()));
//		            Insights.setDakUrgentCount(Long.parseLong(DirectorDakCounts[1].toString()));
//		            Insights.setDakTodayPending(Long.parseLong(DirectorDakCounts[2].toString()));
//		            Insights.setDakDelayCount(Long.parseLong(DirectorDakCounts[3].toString()));
//		            Insights.setMessage(message);
//		            Insights.setCreatedDate(sdf1.format(new Date()));
//		            Insights.setSmsSentDate(sdf1.format(new Date()));
//		            Insights.setEmpId(empId);
//		            // Insert the row into the table for this entry
//		            long result = dao.InsertSmsTrackInsights(Insights);
//		            TrackingInsightsResult = result;
//		            if(TrackingInsightsResult>0) {
//		            	count++;
//		            }
//		        }
//		    }
//		    }
//		    return count;
//	}
	
	
	@Override
	public long DirectorInsertDailySmsPendingInsights(long smsTrackingId) throws Exception {
		 long TrackingInsightsResult = 0;

		 List<Object[]> DirectorPendingReplyEmpsDetailstoSendSms = dao.GetDirectorDailyPendingReplyEmpData("LRDE");
		    if (DirectorPendingReplyEmpsDetailstoSendSms != null && DirectorPendingReplyEmpsDetailstoSendSms.size() > 0) {

		        for (Object[] rowData : DirectorPendingReplyEmpsDetailstoSendSms) {
		            int empId = Integer.parseInt(rowData[0].toString());
		            Object[] DirectorDakCounts =dao.DirectorDakCounts(LocalDate.now().toString());
		            // Create a new instance of DakMailTrackingInsights for each entry
		            DakSmsTrackingInsights Insights = new DakSmsTrackingInsights();
		            Insights.setSmsTrackingId(smsTrackingId);
		            Insights.setSmsPurpose("D");
		            Insights.setSmsStatus("N");
		            Insights.setDakPendingCount(Long.parseLong(DirectorDakCounts[0].toString()));
		            Insights.setDakUrgentCount(Long.parseLong(DirectorDakCounts[1].toString()));
		            Insights.setDakTodayPending(Long.parseLong(DirectorDakCounts[2].toString()));
		            Insights.setDakDelayCount(Long.parseLong(DirectorDakCounts[3].toString()));
		            Insights.setCreatedDate(sdf1.format(new Date()));
		            Insights.setEmpId(empId);

		            // Insert the row into the table for this entry
		            long result = dao.InsertSmsTrackInsights(Insights);
		            TrackingInsightsResult = result;
		        }
		    }

		    return TrackingInsightsResult;
	}

	@Override
	public Object[] DirectorDakCounts(String actionDue) throws Exception {
		return dao.DirectorDakCounts(actionDue);
	}
	
	@Override
	public Object[] divisionData(Long divisionId) throws Exception {
		return dao.divisionData(divisionId);
	}
	
	//audit patches
	
			@Override
			public List<Object[]> AuditPatchesList() throws Exception
			{
				return dao.getAuditPatchesList();
			}
			@Override
			public long AuditPatchAddSubmit(AuditPatches dto) throws Exception 
			{
				logger.info(new Date() +"Inside SERVICE DesignationAddSubmit ");
				  LocalDateTime currentDateTime = LocalDateTime.now();
			      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			      String formattedDateTime = currentDateTime.format(formatter);
				  dto.setModifiedDate(formattedDateTime);

				
				return dao.auditpatchAddSubmit(dto);
			}
			@Override
		    public AuditPatches getAuditPatchById(Long attachId) {
		        return dao.getAuditPatchById(attachId);
		    }


			@Override
			public AuditPatches findAuditpatch(Long auditpatchid) {
				
				return dao.getAuditDataPatchById(auditpatchid);
			}
}


