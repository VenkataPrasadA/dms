package com.vts.dms.master.dao;


import java.math.BigInteger;
import java.util.List;

import com.vts.dms.admin.model.LoginDivision;
import com.vts.dms.master.model.DivisionGroup;
import com.vts.dms.master.model.DivisionMaster;
import com.vts.dms.master.model.Employee;
import com.vts.dms.master.model.EmployeeDesig;
import com.vts.dms.master.model.MemberTypeMaster;
import com.vts.dms.master.model.NonProjectMaster;
import com.vts.dms.master.model.OtherProjectMaster;
import com.vts.dms.master.model.Source;
import com.vts.dms.master.model.Vendor;
import com.vts.dms.master.model.VendorParameter;
import com.vts.dms.model.LabMaster;



public interface MasterDao {
	
	public List<Object[]> DivisionMasterList() throws Exception;
	public List<Object[]> DivisionGroupList() throws Exception;
	public List<Object[]> DivisionHeadList() throws Exception;
	public List<String> DivisionCodeCheck() throws Exception;
	public List<Object[]> DivisionCodeList(Long DivisionId) throws Exception;
	public Long DivisionMasterInsert(DivisionMaster divisionmaster) throws Exception;
	public int DivisionMasterUpdate(DivisionMaster divisionmaster) throws Exception;
	public List<Object[]> DivisionMasterEditData(String DivisionId) throws Exception;
	public int DivisionMasterDelete(DivisionMaster divisionmaster) throws Exception;
	
	
	
	
	public List<Object[]> LabMasterList() throws Exception;
	public Long LabMasterInsert(LabMaster labmaster) throws Exception;
	public List<Object[]> LabMasterEditData(String LabId) throws Exception;
	public int LabMasterUpdate(LabMaster labmaster) throws Exception;
	public List<String> LabCodeCheck() throws Exception;

	public List<Object[]> EmployeeList() throws Exception;
	public List<Object[]> ProjectList() throws Exception;
	public List<Object[]> VendorMasterList() throws Exception;
	public List<Object[]> VendorCodeList(Long VendorId) throws Exception;
	public List<String> VendorNameCheck() throws Exception;
	public String VendorMasterInsert(Vendor vendor,VendorParameter vendorparameter,String type) throws Exception;
	public List<Object[]> VendorMasterEditData(String VendorId) throws Exception;
	public int VendorMasterUpdate(Vendor vendor) throws Exception;
	public int VendorMasterDelete(Vendor vendor) throws Exception;
	public String LastVendorCode()throws Exception;
	public VendorParameter VendorParameter(String VendorExt)throws Exception;
	
	
	public List<Object[]> OfficerList() throws Exception;
	public List<Object[]> DesignationList() throws Exception;
	public List<Object[]> OfficerDivisionList() throws Exception;
	public List<String> EmpNoCheck() throws Exception;
	public Long OfficeMasterInsert(Employee employee) throws Exception;
	public List<Object[]> OfficerEditData(String OfficerId) throws Exception;
	public int OfficerMasterUpdate(Employee employee) throws Exception;
	public int OfficerMasterDelete(Employee employee) throws Exception;
	
	public List<Object[]> GroupMasterList() throws Exception;
	public List<Object[]> GroupMasterListAdd() throws Exception;
	public List<String> CheckGroupCode() throws Exception;
	public List<Object[]> GroupCodeList() throws Exception;
	public Long GroupMasterInsert(DivisionGroup divisiongroup) throws Exception;
	public List<Object[]> GroupMasterEditData(String GroupId) throws Exception;
	public int GroupMasterUpdate(DivisionGroup divisiongroup) throws Exception;
	public int GroupMasterDelete(DivisionGroup divisiongroup) throws Exception;

	public Long DivisionId(String EmpId) throws Exception;
	
	
	public List<Object[]> DesignationMasterEditData(String DesignationId) throws Exception;
	public Long DesignationInsert(EmployeeDesig employeedesig) throws Exception;
	public List<String> CheckDesignationId() throws Exception;
	public List<String> CheckDesignation() throws Exception;
	public int DesignationUpdate(EmployeeDesig employeedesig, String DesignationId) throws Exception;
	

	public BigInteger EmpidCount(String Empid)throws Exception;
	public List<Object[]> CfaExternalList() throws Exception;
	public BigInteger EmpCodeCheck(String EmpCode) throws Exception;

	
	public List<Object[]> DivisionList() throws Exception;
	public List<Object[]> DivisionAssignList(String DivisionId) throws Exception;
	public List<Object[]> UserList() throws Exception;
	public Object[] DivisionName(String DivisionId) throws Exception;
	public Long DivisionAssignAdd(LoginDivision logindivision) throws Exception;
	public List<Object[]> SourceMasterList() throws Exception;
	public List<Object[]> SourceDropDownList() throws Exception;
	public Object[] GetParticularSourceDetails(String sourceDetailId) throws Exception;
	public Long InsertSourceDetails(Source source) throws Exception;
	public Long UpdateSourceDetails(Source source) throws Exception;
	public Source GetSourceEditDetails(long sourceDetailId) throws Exception;
	public Object[] GetParticularNonProjectDetails(String nonProjectId) throws Exception;
	public List<Object[]> GetNonProjectList() throws Exception;
	public Long InsertNonProjectDetails(NonProjectMaster nonProject) throws Exception;
	public NonProjectMaster GetNonProjectEditDetails(Long nonProjectId) throws Exception;
	public Long UpdateNonProjectDetails(NonProjectMaster nonProject1) throws Exception;
	public int CheckDuplicateSourceShortName(String shortName) throws Exception;
	public int CheckDuplicateNonProjectShortName(String shortName) throws Exception;
	public List<Object[]> GetOtherProjectList() throws Exception;
	public Object[] GetParticularOtherProjectDetails(String otherProjectId) throws Exception;
	public Long InsertOtherProjectDetails(OtherProjectMaster otherProject) throws Exception;
	public OtherProjectMaster GetOtherProjectEditDetails(Long projectOtherId) throws Exception;
	public Long UpdateOtherProjectDetails(OtherProjectMaster otherProject1) throws Exception;
	public int CheckDuplicateOtherProjectShortName(String shortName) throws Exception;
	public List<Object[]> GetMemberTypeList() throws Exception;
	public Object[] GetParticularMemberTypeDetails(String memberTypeId) throws Exception;
	public Long InsertMemberTypeDetails(MemberTypeMaster membertype) throws Exception;
	public MemberTypeMaster GetMemberTypeEditDetails(Long dakMemberTypeId) throws Exception;
	public Long UpdateMemberTypeDetails(MemberTypeMaster membertype1) throws Exception;
	public Object getlabcode(long empId) throws Exception;

}	

