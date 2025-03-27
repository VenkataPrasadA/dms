package com.vts.dms.dao;

import java.util.List;

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

public interface DmsDao {
	public Long LoginStampingInsert(AuditStamping Stamping) throws Exception;
	public int LoginStampingUpdate(AuditStamping Stamping) throws Exception;
	public Long LoginValidation(String User,String Password)throws Exception;
	public List<Object[]> DashBoardFormUrlList(int FormModuleId,int loginId )throws Exception;
	public List<Object[]> MailConfigurationList()throws Exception;
	public long AddMailConfiguration( MailConfiguration mailConfigAdd)throws Exception;
	public long DeleteMailConfiguration(long MailConfigurationId, String ModifiedBy)throws Exception;
	public Object[] MailConfigurationEditList(long MailConfigurationId)throws Exception;
	public long UpdateMailConfiguration(long MailConfigurationId,String userName,String hostType, String modifiedBy,String Host,String Port,String pass)throws Exception; 
	public List<Object[]> GetMailPropertiesByTypeOfHost(String typeOfHost)throws Exception;
	public List<Object[]> UserManagerList()throws Exception;
	public Long LastLoginStampingId(String LoginId)throws Exception;
	public LabMaster LabDetailes()throws Exception;
	public String DesgId(String Empid)throws Exception;
	public Employee EmployeeInfo(Long empId) throws Exception;
	public EmployeeDesig DesignationInfo(Long desigId) throws Exception;
	public long GetMailInitiatedCount(String TrackingType)throws Exception;
	public long GetDailyExpectedPendingReplyCount()throws Exception;
	public long GetWeeklyExpectedPendingReplyCount()throws Exception;
	public long GetSummaryOfDailyDistributedCount()throws Exception;
	public long InsertMailTrackRow(DakMailTracking Model)throws Exception;
	public List<Object[]> GetDailyPendingReplyEmpData() throws Exception;
	public List<Object[]> GetWeeklyPendingReplyEmpData() throws Exception;
	public List<Object[]> GetSummaryDistributedEmpData() throws Exception;
	public long InsertMailTrackInsights(DakMailTrackingInsights Model)throws Exception;
	public long UpdateParticularEmpMailStatus(String MailPurpose,String MailStatus,long empId,long MailTrackingId) ;
	public long UpdateDakMailTrackRow(long MailTrackingId,long SuccessCount,String TrackingType)throws Exception;
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
	public Object[] ProjectWiseCount(String projectId,String fromDate, String toDate) throws Exception;
	public Object[] ProjectCardsCount(String fromDate, String toDate) throws Exception;
	public Object[] GroupCardsCount(String fromDate, String toDate) throws Exception;
	public Object[] GroupWiseCount(String dakMemberTypeId, String fromDate, String toDate) throws Exception;
	public long InsertSmsTrackRow(DakSmsTracking model) throws Exception;
	public Object[] PopUpCount(long empId,String popupdate) throws Exception;
	public long InsertSmsTrackInsights(DakSmsTrackingInsights insights) throws Exception;
	public Object[] DakCounts(long empId, String actionDate) throws Exception;
	public long UpdateParticularEmpSmsStatus(String smsPurpose, String smsStatus, long empId,long effectivelyFinalSmsTrackingId, String message) throws Exception;
	public long UpdateDakSmsTrackRow(long smsTrackingId, long successCount, String trackingType) throws Exception;
	public long UpdateNoSmsPendingReply(String trackingType) throws Exception;
	public long GetSMSInitiatedCount(String smsTrackingType) throws Exception;
	public List<Object[]> GetDirectorDailyPendingReplyEmpData(String Lab) throws Exception;
	public Object[] DirectorDakCounts(String string) throws Exception;
	public long getTypeOfHostCount(String hostType) throws Exception;
	public Object[] divisionData(Long divisionId) throws Exception;
	//audit patches
			public List<Object[]> getAuditPatchesList() throws Exception;
			public long auditpatchAddSubmit(AuditPatches model) throws Exception;
			public AuditPatches getAuditPatchById(Long attachId);

			public AuditPatches getAuditDataPatchById(Long auditpatchid);


}
