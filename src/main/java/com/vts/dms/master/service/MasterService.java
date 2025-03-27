package com.vts.dms.master.service;

import java.util.List;


import com.vts.dms.master.dto.DesignationDto;
import com.vts.dms.master.dto.DivisionAssignDto;
import com.vts.dms.master.dto.DivisionMasterAdd;
import com.vts.dms.master.dto.GroupMasterAdd;
import com.vts.dms.master.dto.LabMasterAdd;
import com.vts.dms.master.dto.OfficerMasterAdd;
import com.vts.dms.master.dto.VendorMasterAdd;
import com.vts.dms.master.model.MemberTypeMaster;
import com.vts.dms.master.model.NonProjectMaster;
import com.vts.dms.master.model.OtherProjectMaster;
import com.vts.dms.master.model.Source;


public interface MasterService {

	public List<Object[]> DivisionMasterList() throws Exception;
	public List<Object[]> DivisionGroupList() throws Exception;
	public List<Object[]> DivisionHeadList() throws Exception;
	public List<Object[]> DivisionCodeList(String DivisionId) throws Exception;
	public List<String> DivisionCodeCheck() throws Exception;
	public Long  DivisionMasterInsert(DivisionMasterAdd add, String Userid) throws Exception;
	public int DivisionMasterUpdate(DivisionMasterAdd add, String Userid) throws Exception;
	public List<Object[]> DivisionMasterEditData(String DivisionId) throws Exception;
	public int DivisionMasterDelete(String DivisionId, String Userid) throws Exception;
	
	
	

	public List<Object[]>  LabMasterList() throws Exception;
	public Long LabMasterInsert(LabMasterAdd ladmasteradd) throws Exception;
	public List<Object[]> LabMasterEditData(String LabId) throws Exception;
	public int LabMasterUpdate(LabMasterAdd labmasteredit) throws Exception;
	public List<String> LabCodeCheck() throws Exception;
	
	
	

	public List<Object[]> EmployeeList() throws Exception;
	public List<Object[]> ProjectList() throws Exception;




	public List<Object[]>  VendorCodeList(String VendorId) throws Exception;
	public List<String>  VendorNameCheck() throws Exception;
 	public String VendorMasterInsert(VendorMasterAdd vendormasteradd, String UserId) throws Exception;
 	public List<Object[]> VendorMasterEditData(String VendorId) throws Exception;
 	public int VendorMasterUpdate(VendorMasterAdd vendormasteradd, String UserId) throws Exception;
 	public int VendorMasterDelete(String VendorId, String UserId) throws Exception;

	public List<Object[]> DesignationList() throws Exception;
	public List<Object[]> OfficerDivisionList() throws Exception;
	public List<String> EmpNoCheck() throws Exception;

	
	public List<Object[]> GroupMasterList() throws Exception;
	public List<Object[]> GroupMasterListAdd() throws Exception;
	public List<String> CheckGroupCode() throws Exception;
	public List<Object[]> GroupCodeList() throws Exception;
	public Long GroupMasterInsert(GroupMasterAdd groupmasteradd, String UserId) throws Exception;
	public List<Object[]> GroupMasterEditData(String GroupId) throws Exception;
	public int GroupMasterUpdate(GroupMasterAdd groupmasteradd, String UserId) throws Exception;
	public int GroupMasterDelete(String GroupId,String UserId)throws Exception;
	public List<Object[]>  VendorMasterList() throws Exception;
	public List<Object[]> EmployeeListDivisionWise (String DivisionId) throws Exception;
	public List<Object[]> DesignationMasterEditData(String DesignationId) throws Exception;
	public Long DesignationInsert(DesignationDto designationdto) throws Exception;
	public List<String> CheckDesignationId() throws Exception;
	public List<String> CheckDesignation() throws Exception;
	public int DesignationUpdate(DesignationDto designationdto,String DesignationId) throws Exception;
	
	public int Empidcount (String Empid ) throws Exception;
	public int EmpCodeCheck(String EmpCode) throws Exception;

	public List<Object[]> DivisionList() throws Exception;
	public List<Object[]> DivisionAssignList(String DivisionId) throws Exception;
	public List<Object[]> UserList() throws Exception;
	public Object[] DivisionName(String DivisionId) throws Exception;
	public Long DivisionAssignAdd(DivisionAssignDto divassign) throws Exception;
	public List<Object[]> OfficerList() throws Exception;
	public Long OfficerMasterInsert(OfficerMasterAdd officermasteradd, String UserId) throws Exception;
	public List<Object[]> OfficerEditData(String OfficerId) throws Exception;
	public int OfficerMasterUpdate(OfficerMasterAdd officermasteradd, String UserId) throws Exception;
	public int OfficerMasterDelete(String OfficerId, String UserId) throws Exception;
	public List<Object[]> SourceMasterList() throws Exception;
	public List<Object[]> SourceDropDownList() throws Exception;
	public Object[] GetParticularSourceDetails(String SourceDetailId) throws Exception;
	public Long InsertSourceDetails(Source source) throws Exception;
	public Long UpdateSourceDetails(Source source) throws Exception;
	public Object[] GetParticularNonProjectDetails(String nonProjectId) throws Exception;
	public List<Object[]> GetNonProjectList() throws Exception;
	public Long InsertNonProjectDetails(NonProjectMaster nonProject) throws Exception;
	public Long UpdateNonProjectDetails(NonProjectMaster nonProject) throws Exception;
	public int CheckDuplicateShortName(String shortName, String type) throws Exception;
	public List<Object[]> GetOtherProjectList() throws Exception;
	public Object[] GetParticularOtherProjectDetails(String otherProjectId) throws Exception;
	public Long InsertOtherProjectDetails(OtherProjectMaster otherProject) throws Exception;
	public Long UpdateOtherProjectDetails(OtherProjectMaster otherProject) throws Exception;
	public List<Object[]> GetMemberTypeList() throws Exception;
	public Object[] GetParticularMemberTypeDetails(String memberTypeId) throws Exception;
	public Long InsertMemberTypeDetails(MemberTypeMaster membertype) throws Exception;
	public Long UpdateMemberTypeDetails(MemberTypeMaster membertype) throws Exception;
	public Object getlabcode(long empId) throws Exception;
	

}
