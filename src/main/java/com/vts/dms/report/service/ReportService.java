package com.vts.dms.report.service;

import java.util.List;

public interface ReportService {
	
	public List<Object[]> DakStatusList(String Username,String LoginType,long EmpId,String fromDate,String toDate) throws Exception;
	public List<Object[]> DakTrackingList(String DakId) throws Exception;
	public List<Object[]> DakTrackingPrintList(String DakId) throws Exception;
	public List<Object[]> GetCreatedByDetails(String InitiatedBy) throws Exception;
	public List<Object[]> GeAcknowledgedMembersList(String DakId) throws Exception;
	public List<Object[]> GetDakNoSearchDetailsList(String DakNo,long EmpId,String Username,String LoginType) throws Exception;
	public List<Object[]>  GetRefNoSearchDetailsList(String RefNo,long EmpId,String Username,String LoginType) throws Exception;
	public List<Object[]>  GetSubjectSearchDetailsList(String Subject,long EmpId,String Username,String LoginType) throws Exception;
	public List<Object[]>  GetKeywordsSearchDetailsList(String Keyword,long EmpId,String Username,String LoginType) throws Exception;
	public List<Object[]> GetRepliedMembersList(String dakId) throws Exception;
	public List<Object[]> GetSelectedTypeDropDown(String filterType) throws Exception;
	public List<Object[]> GetDakFilteredList(String filterType, String selectedDetailsId, String fromDate, String toDate,String LoginType,long EmpId,String Username) throws Exception;
	public List<Object[]> DakGroupingListDropDown() throws Exception;
	public List<Object[]> DakGroupingList(long dakMemberTypeId,long EmpId,String fromDate,String toDate) throws Exception;
	public List<Object[]> intialDakGroupingList(String fromDate,String toDate) throws Exception;
	public List<Object[]> GroupEmpList(long DakMemberTypeId) throws Exception;
	public Object getlabcode(long empId) throws Exception;
	public List<Object[]> StartEmployeeList(String lab) throws Exception;
	public List<Object[]> SelMemberTypeDakGroupingList(String selDakMemberTypeId, String fromDate, String toDate) throws Exception;
	public List<Object[]> SelMemberTypeEmployeeList(String selDakMemberTypeId, String lab) throws Exception;
	public List<Object[]> SelEmployeeTypeDakGroupingList(String selEmpId, String fromDate, String toDate) throws Exception;
	public List<Object[]> SelEmployeeMemberTypeDakGroupingList(String selDakMemberTypeId, String selEmpId, String fromDate,String toDate) throws Exception;
	public List<Object[]> SelProjectTypeList(String lab) throws Exception;
	public List<Object[]> AllProjectWiseList(String fromDate, String toDate) throws Exception;
	public List<Object[]> SelectedProjectWiseList(String projectTypeId, String fromDate, String toDate) throws Exception;
	public List<Object[]> SmsReportList(String fromDate, String toDate) throws Exception;
	public List<Object[]> dakPendingReportList() throws Exception;
	public List<Object[]> holidayDateList() throws Exception;
	public List<Object[]> GetAcknowledgeMembersList(String selDakId) throws Exception;
	public List<Object[]> GetReplyMembersList(String replydakId) throws Exception;
	public List<Object[]> GetAssignedMembersList(String dakId) throws Exception;
	public List<Object[]> GetSeekRepsonseMembersList(String dakId) throws Exception;
	

}
