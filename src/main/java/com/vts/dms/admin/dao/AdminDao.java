package com.vts.dms.admin.dao;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import com.vts.dms.admin.model.FormRole;
import com.vts.dms.admin.model.FormRoleAccess;
import com.vts.dms.admin.model.LoginDivision;
import com.vts.dms.admin.model.dakFeedbackAttach;
import com.vts.dms.login.Login;
import com.vts.dms.admin.model.DakHandingOver;
import com.vts.dms.admin.model.DmsStatistics;
import com.vts.dms.admin.model.Feedback;

public interface AdminDao {

	//new change
	public List<Object[]> RoleList() throws Exception;
    public int RolePresentCount(String RoleName) throws Exception;
	public long RoleInsert(FormRole role) throws Exception;
    public List<Object[]> getFormDetails() throws Exception;
    public List<Object[]> getModuleDetails() throws Exception;
    public List<Object[]> getFormNameAsperModule(long formmoduleId) throws Exception;
	public long addRoleFormAccess(FormRoleAccess formrole);
	public List<Object[]> getAccessedFormsDetails(long formRoleId,long FormModuleId) throws Exception;
	public List<Object[]> getNotAccessedFormsDetails(long FormRoleId, long FormModuleId) throws Exception;
	public int deleteFormRoleAccess(long roleFormAccessId) throws Exception;
	public List<Object[]> fetchRoleAsperRoleId(long formRoleId) throws Exception;
	public int formRoleNameEdir(long formRoleId,String formRoleName) throws Exception;

	//oldchange
	
	public List<Object[]> UserManagerList()throws Exception;
	public List<Object[]> DivisionList()throws Exception;
	public Object[] EmployeeData(String empid) throws Exception;
	public Long UserManagerInsert(Login login)throws Exception;
	public Login UserManagerEditData(Long LoginId )throws Exception;
	public int UserNamePresentCount(String UserName )throws Exception;
	public int UserManagerUpdate(Login login)throws Exception;
	public int UserManagerDelete(Login login )throws Exception;
	public List<Object[]> EmployeeList(String lab)throws Exception;
	public List<Object[]> LoginTypeList()throws Exception;
	public int PasswordChange(String OldPassword,String NewPassword,String UserName,String ModifiedDate)throws Exception;
	public int PasswordReset(String NewPassword,Long LoginId,Long ModifiedBy,String ModifiedDate)throws Exception;
	public String OldPassword(String UserId)throws Exception;
	public Object getlabcode(long empId) throws Exception;
	public List<Object[]> AuditStampingList(String Username,LocalDate Fromdate,LocalDate Todate)  throws Exception ;
	public List<Object[]> UsernameList() throws Exception ;
	public Long FeedbackInsert(Feedback feedback)throws Exception;
	public List<Object[]> FeedbackList() throws Exception ;
	public Object[] FeedbackData(String Feedbackid) throws Exception ;
	public List<Object[]> getDakMembers() throws Exception;
	public List<Object[]> StatsEmployeeList(String loginType, long divid, String lab) throws Exception;
	public String firstDateOfAudit() throws Exception;
	public List<Object[]> getAllEmployeesOfDate(String date)throws Exception;
	public Object[] ListOfWorkCounts(String UserName, String date,String EmpId) throws Exception;
	public int DataInsetrtIntoPfmsStatistics(List<DmsStatistics> pfmsStatistics)throws Exception;
	public List<Object[]> getEmployeeWiseCount(String employeeId,String fromdate,String todate) throws Exception;
	public List<Object[]> dmsStatisticsTableData()throws Exception;//dms stat total table data
	public List<Object[]> DakGroupingListDropDown() throws Exception;
	public List<Object[]> GroupEmployeeList(long grpId) throws Exception;
	public List<Object[]> StartEmployeeList(String lab) throws Exception;
	public List<Object[]> SelMemberTypeEmployeeList(String memberTypeId, String lab) throws Exception;
	public List<Object[]> FeedbackListForUser(String lab, String EmpId) throws Exception;
	public List<Object[]> GetfeedbackAttch() throws Exception;
	public List<Object[]> GetfeedbackAttchForUser(String empid) throws Exception;
	public long FeedbackAttachInsert(dakFeedbackAttach attach) throws Exception;
	public List<Object[]> FeedbackList(String fromDate, String toDate, String empId, String lab, String feedbacktype) throws Exception;
	public dakFeedbackAttach FeedbackAttachmentDownload(String achmentid) throws Exception;
	public Object[] FeedbackContent(String feedbackid) throws Exception;
	public int CloseFeedback(String feedbackid, String remarks, String username) throws Exception;
	public List<Object[]> GetHandingOverOfficers() throws Exception;
	public List<Object[]> GetHandingOverToOfficers(String handingOfficer) throws Exception;
	public Long insertHandingOver(DakHandingOver model) throws Exception;
	public List<Object[]> HandingOverList(String fromDate, String toDate) throws Exception;
	public long fromAndtoDateCount(String fromDate, String toDate) throws Exception;
	public long FromEmployeeCount(long FromEmpId,String fromDate, String toDate) throws Exception;
	public DakHandingOver getEditHandingOfficerData(Long handingOverId) throws Exception;
	public long fromAndtoDateCountEdit(String fromdate, String todate, Long handingOverId) throws Exception;
	public long updateHandingOver(DakHandingOver modelupdate) throws Exception;
	public long FromEmployeeCountEdit(long FromEmpId, Long handingOverId,String fromdate, String todate) throws Exception;
	public long updatehandingoverRevoke(long handingOverId) throws Exception;
}
