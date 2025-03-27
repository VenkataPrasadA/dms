package com.vts.dms.admin.service;


import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.vts.dms.admin.dto.UserManageAdd;
import com.vts.dms.admin.model.DakHandingOver;
import com.vts.dms.admin.model.Feedback;
import com.vts.dms.admin.model.dakFeedbackAttach;
import com.vts.dms.login.Login;

public interface AdminService {

	
	//new change
	
	public List<Object[]> RoleList() throws Exception;
    public long RoleInsert(String role, String logid) throws Exception;
    public List<Object[]> getFormDetails() throws Exception;
    public List<Object[]> getModuleDetails() throws Exception;
    public List<Object[]> getFormNameAsperModule(long formmoduleId) throws Exception;
    public long addRoleFormAccess(long roleId, String[] formDetailId,String createdBy);
	public List<Object[]> getAccessedFormsDetails(long formRoleId, long formModuleId) throws Exception;
	public List<Object[]> getNotAccessedFormsDetails(long FormRoleId, long FormModuleId) throws Exception;
	public int deleteFormRoleAccess(String[] roleFormAccessId) throws Exception;
	public List<Object[]> fetchRoleAsperRoleId(long formRoleId) throws Exception;
	public int formRoleNameEdir(long formRoleId,String formRoleName) throws Exception;
	
	
	
	public List<Object[]> UserManagerList()throws Exception;
	public List<Object[]> DivisionList()throws Exception;
	public Object[] EmployeeData(String empid) throws Exception;
	public Long UserManagerInsert(UserManageAdd UserManageAdd, String LogId)throws Exception;
	public Login UserManagerEditData(String LoginId )throws Exception;
	public int UserNamePresentCount(String UserName )throws Exception;
	public int UserManagerUpdate(UserManageAdd UserManageEdit,String Userid)throws Exception;
	public int UserManagerDelete(String LoginId,String Userid)throws Exception;
	public List<Object[]> EmployeeList(String lab)throws Exception;
	public List<Object[]> LoginTypeList()throws Exception;
	public int PasswordChange(String OldPassword,String NewPassword,String UserId)throws Exception;
	public int PasswordReset(String LoginId,String ModifiedBy)throws Exception;
	public Object getlabcode(long empId) throws Exception;
	public List<Object[]> AuditStampingList(String Username,String Fromdateparam,String Todateparam)  throws Exception ;
	public List<Object[]> UsernameList() throws Exception ;
	public Long FeedbackInsert(Feedback feedback ,MultipartFile FileAttach, String labcode)throws Exception;
	public List<Object[]> FeedbackList() throws Exception ;
	public Object[] FeedbackData(String Feedbackid) throws Exception ;
	public List<Object[]> getDakMembers() throws Exception;
	public List<Object[]> StatsEmployeeList(String loginType, long divid, String lab) throws Exception;
	public List<Object[]> getEmployeeWiseCount(String employeeId, String fromdate,String todate) throws Exception;
	public int insertEmployeeData() throws Exception;
	public List<Object[]> DakGroupingListDropDown() throws Exception;
	public List<Object[]> GroupEmployeeList(long grpId) throws Exception;
	
	public List<Object[]> StartEmployeeList(String lab) throws Exception;
	public List<Object[]> SelMemberTypeEmployeeList(String memberTypeId, String lab) throws Exception;
	public List<Object[]> FeedbackListForUser(String lab, String EmpId) throws Exception;
	public List<Object[]> GetfeedbackAttch() throws Exception;
	public List<Object[]> GetfeedbackAttchForUser(String empid) throws Exception;
	public List<Object[]> FeedbackList(String fromdate, String todate, String EmpId, String lab, String feedbacktype) throws Exception;
	public dakFeedbackAttach FeedbackAttachmentDownload(String achmentid) throws Exception;
	public Object[] FeedbackContent(String feedbackid) throws Exception;
	public int CloseFeedback(String feedbackid, String remarks, String username) throws Exception;
	public List<Object[]> GetHandingOverOfficers() throws Exception;
	public List<Object[]> GetHandingOverToOfficers(String handingOfficer) throws Exception;
	public Long insertHandingOver(DakHandingOver model) throws Exception;
	public List<Object[]> HandingOverList(String fromDate, String toDate) throws Exception;
	public DakHandingOver getEditHandingOfficerData(Long handingOverId) throws Exception;
	public long updatehandingoverRevoke(long handingOverId) throws Exception;
}