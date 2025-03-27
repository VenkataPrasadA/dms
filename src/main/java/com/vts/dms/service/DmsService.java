package com.vts.dms.service;

import java.util.List;



import com.vts.dms.model.LabMaster;
import com.vts.dms.model.AuditPatches;
import com.vts.dms.dto.MailConfigurationDto;
import com.vts.dms.master.model.Employee;
import com.vts.dms.model.AuditStamping;
import com.vts.dms.master.model.EmployeeDesig;


public interface DmsService {
	public Long LoginStampingInsert(AuditStamping Stamping) throws Exception;
	public Long LoginValidation(String User,String Password)throws Exception;
	public List<Object[]> DashBoardFormUrlList(String FormModuleId,String loginId )throws Exception;
	public List<Object[]> MailConfigurationList()throws Exception;
	public long AddMailConfiguration(String userName, String password, String hostType, String createdBy,String Host,String Port)throws Exception;
	public long DeleteMailConfiguration(long MailConfigurationId, String ModifiedBy)throws Exception;
	public Object[] MailConfigurationEditList(long MailConfigurationId)throws Exception;
	public long UpdateMailConfiguration(long MailConfigurationId,String userName,String hostType, String modifiedBy,String Host,String Port,String Password)throws Exception; 
	public MailConfigurationDto getMailConfigByTypeOfHost (String typeofHost)throws Exception ;
	public List<Object[]> UserManagerList()throws Exception;
	public int  LoginStampingUpdate(String Logid,String LogoutType)throws Exception;
	public LabMaster LabDetailes()throws Exception;
	public String DesgId(String Empid)throws Exception;
	public Employee EmployeeInfo(Long empId) throws Exception;
	public EmployeeDesig DesignationInfo(Long desigId) throws Exception;
	public long GetMailInitiatedCount(String TrackingType)throws Exception;
	public List<Object[]> GetDailyPendingReplyEmpData() throws Exception;
	public List<Object[]> GetWeeklyPendingReplyEmpData() throws Exception;
	public List<Object[]> GetSummaryDistributedEmpData() throws Exception;
	public long InsertMailTrackInitiator(String TrackingType)throws Exception;
	public long InsertDailyDistributedInsights(long MailTrackingId)throws Exception;
	public long InsertDailyPendingInsights(long MailTrackingId)throws Exception;
	public long InsertWeeklyPendingInsights(long MailTrackingId)throws Exception;
	public long InsertSummaryDistributedInsights(long MailTrackingId)throws Exception;
	public long updateMailSuccessCount(long MailTrackingId,long MailSendSucessCount,String TrackingType)throws Exception;
	public long UpdateParticularEmpMailStatus(String MailPurpose,String MailStatus,long empId,long MailTrackingId) ;
	public long UpdateNoPendingReply(String TrackingType)throws Exception;
	public Object[] getDashBoardCount(long empId, String fromDate, String toDate, String username,String Source,String Project,String SelSourceType,String selProjectTypeId,String MemberTypeId,String Emp,String Delivery,String Priority) throws Exception;
	public List<Object[]> SourceList() throws Exception;
	public List<Object[]> AllSourceTypeList() throws Exception;
	public List<Object[]> SelectedSourceTypeList(String source) throws Exception;
	public List<Object[]> ProjectTypeList(String lab) throws Exception;
	public List<Object[]> SelProjectTypeList(String lab) throws Exception;
	public Object getlabcode(long empId) throws Exception;
	public List<Object[]> SelNonProjectTypeList() throws Exception;
	public List<Object[]> SelOtherProjectTypeList() throws Exception;
	public List<Object[]> DakSLAMissedDashBoardCount(String fromDate, String toDate, String source, String project,String selSourceType, String selProjectTypeId,String MemberTypeId,String Emp,String Delivery,String Priority) throws Exception;
	public List<Object[]> DakSLANearDashBoardCount(String fromDate, String toDate, String source, String project,String selSourceType, String selProjectTypeId,String MemberTypeId,String Emp,String Delivery,String Priority) throws Exception;
	public List<Object[]> DakGroupingListDropDown() throws Exception;
	public List<Object[]> StartEmployeeList(String lab) throws Exception;
	public List<Object[]> SelMemberTypeEmployeeList(String memberTypeId, String lab) throws Exception;
	public List<Object[]> DakDeliveryList() throws Exception;
	public List<Object[]> getPriorityList() throws Exception;
	public Object[] ProjectWiseCount(String ProjectId,String fromDate, String toDate) throws Exception ;
	public Object[] ProjectCardsCount(String fromDate, String toDate) throws Exception;
	public Object[] GroupCardsCount(String fromDate, String toDate) throws Exception;
	public Object[] GroupWiseCount(String DakMemberTypeId, String fromDate, String toDate)throws Exception;
	public long GetSMSInitiatedCount(String SmsTrackingType) throws Exception;
	public Object[] PopUpCount(long empId,String popupdate) throws Exception;
	public long InsertDailySmsPendingInsights(long smsTrackingId) throws Exception;
	public Object[] DakCounts(long EmpId, String ActionDate) throws Exception;
	public long UpdateParticularEmpSmsStatus(String SmsPurpose, String SmsStatus, long EmpId,long effectivelyFinalSmsTrackingId, String message) throws Exception;
	public long updateSmsSuccessCount(long smsTrackingId, long SuccessCount, String TrackingType) throws Exception;
	public long UpdateNoSmsPendingReply(String TrackingType) throws Exception;
	public long InsertSmsTrackInitiator(String  TrackingType) throws Exception;
	public long DirectorInsertSmsTrackInitiator(String TrackingType) throws Exception;
	public List<Object[]> GetDirectorDailyPendingReplyEmpData(String Lab) throws Exception;
	public long DirectorInsertDailySmsPendingInsights(long smsTrackingId) throws Exception;
	public Object[] DirectorDakCounts(String actionDue) throws Exception;
	public Object[] divisionData(Long divisionId) throws Exception;
	
	//audit patches
	//audit patch
			public List<Object[]> AuditPatchesList() throws Exception;
			public long AuditPatchAddSubmit(AuditPatches dto) throws Exception;
			public AuditPatches getAuditPatchById(Long attachId);

			public AuditPatches findAuditpatch(Long auditpatchid);
	

}
