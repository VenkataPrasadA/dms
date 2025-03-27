package com.vts.dms.master.service;


import java.math.BigInteger;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.dms.admin.model.LoginDivision;
import com.vts.dms.master.dao.MasterDao;
import com.vts.dms.master.dto.DesignationDto;
import com.vts.dms.master.dto.DivisionAssignDto;
import com.vts.dms.master.dto.DivisionMasterAdd;
import com.vts.dms.master.dto.GroupMasterAdd;
import com.vts.dms.master.dto.LabMasterAdd;
import com.vts.dms.master.dto.OfficerMasterAdd;
import com.vts.dms.master.dto.VendorMasterAdd;
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

@Service
public class MasterServiceImpl implements MasterService {
	
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	@Autowired
	MasterDao dao;
	
	@Override
	public List<Object[]>  DivisionMasterList() throws Exception {
		return dao. DivisionMasterList();
	}

	@Override
	public List<Object[]> LabMasterList() throws Exception {
		return dao. LabMasterList();
	}

	@Override
	public List<Object[]> VendorMasterList() throws Exception {
		return dao. VendorMasterList();
	}
	
	@Override
	public List<Object[]> DivisionGroupList() throws Exception{
		return dao.DivisionGroupList();
	}

	@Override
	public List<Object[]> DivisionHeadList() throws Exception {
		return dao.DivisionHeadList();
	}
	
	@Override
	public List<String> DivisionCodeCheck() throws Exception {
		return dao.DivisionCodeCheck();
	}
	
	@Override
	public List<Object[]> DivisionCodeList(String DivisionId) throws Exception {
		return dao.DivisionCodeList(Long.parseLong(DivisionId));
	}
	
	@Override
	public Long DivisionMasterInsert(DivisionMasterAdd add , String Userid) throws Exception {
		DivisionMaster divisionmaster= new DivisionMaster();
		divisionmaster.setDivisionCode(add.getDivisionCode());
		divisionmaster.setDivisionName(add.getDivisionName());
		divisionmaster.setDivisionHeadId(Long.parseLong(add.getDivisionHeadName()));
		divisionmaster.setGroupId(Long.parseLong(add.getGroupName()));
		divisionmaster.setIsActive(1);
		divisionmaster.setCreatedBy(Userid);
		divisionmaster.setCreatedDate(sdf1.format(new Date()));
		return dao.DivisionMasterInsert(divisionmaster);
	}

	@Override
	public int DivisionMasterUpdate(DivisionMasterAdd add, String Userid) throws Exception {
		DivisionMaster divisionmaster = new DivisionMaster();
		divisionmaster.setDivisionCode(add.getDivisionCode());
		divisionmaster.setDivisionName(add.getDivisionName());
		divisionmaster.setDivisionHeadId(Long.parseLong(add.getDivisionHeadName()));
		divisionmaster.setGroupId(Long.parseLong(add.getGroupName()));
		divisionmaster.setModifiedBy(Userid);
		divisionmaster.setModifiedDate(sdf1.format(new Date()));
		divisionmaster.setDivisionId(Long.parseLong(add.getDivisionId()));
		return dao.DivisionMasterUpdate(divisionmaster);
	}

	@Override
	public List<Object[]> DivisionMasterEditData(String DivisionId) throws Exception {
		return dao.DivisionMasterEditData(DivisionId);
	}

	@Override
	public int DivisionMasterDelete(String DivisionId, String Userid) throws Exception {
		DivisionMaster divisionmaster= new DivisionMaster();
		divisionmaster.setDivisionId(Long.parseLong(DivisionId));
		divisionmaster.setModifiedBy(Userid);
		divisionmaster.setModifiedDate(sdf1.format(new Date()));
		return dao.DivisionMasterDelete(divisionmaster);
	}
	
	@Override
	public Long LabMasterInsert(LabMasterAdd labmasteradd) throws Exception {
		LabMaster labmaster = new LabMaster();
		labmaster.setLabCode(labmasteradd.getLabCode());
		labmaster.setLabName(labmasteradd.getLabName());
		labmaster.setLabUnitCode(labmasteradd.getLabUnitCode());
		labmaster.setLabAddress(labmasteradd.getLabAddress());
		labmaster.setLabCity(labmasteradd.getLabCity());
		labmaster.setLabPin(labmasteradd.getLabPin());
		labmaster.setLabTelNo(labmasteradd.getLabTelephone());
		labmaster.setLabFaxNo(labmasteradd.getLabFaxNo());
		labmaster.setLabEmail(labmasteradd.getLabEmail());
		return dao.LabMasterInsert(labmaster);
	}

	@Override
	public List<Object[]> LabMasterEditData(String LabId) throws Exception {
		return dao.LabMasterEditData(LabId);
	}

	@Override
	public List<String> LabCodeCheck() throws Exception {
		return dao.LabCodeCheck() ;
	}
	
	@Override
	public int LabMasterUpdate(LabMasterAdd labmasteredit) throws Exception {
		LabMaster labmaster= new LabMaster();
		labmaster.setLabCode(labmasteredit.getLabCode());
		labmaster.setLabName(labmasteredit.getLabName());
		labmaster.setLabUnitCode(labmasteredit.getLabUnitCode());
		labmaster.setLabAddress(labmasteredit.getLabAddress());
		labmaster.setLabCity(labmasteredit.getLabCity());
		labmaster.setLabPin(labmasteredit.getLabPin());
		labmaster.setLabMasterId(Integer.parseInt(labmasteredit.getLabMasterId()));
		labmaster.setLabTelNo(labmasteredit.getLabTelephone());
		labmaster.setLabFaxNo(labmasteredit.getLabFaxNo());
		labmaster.setLabEmail(labmasteredit.getLabEmail());
		return dao.LabMasterUpdate(labmaster);
	}

	@Override
	public List<Object[]> EmployeeList() throws Exception {
		return dao.EmployeeList();
	}

	@Override
	public List<Object[]> ProjectList() throws Exception {
		return dao.ProjectList();
	}
	
// *************************************************VENDOR STARTS*************************************************	

	@Override
	public List<Object[]> VendorCodeList(String VendorId) throws Exception {
		return dao. VendorCodeList(Long.parseLong(VendorId));
	}
	
	@Override
	public List<String> VendorNameCheck() throws Exception {
		return dao.VendorNameCheck();
	}
	
	@Override
	public String VendorMasterInsert(VendorMasterAdd vendormasteradd, String UserId) throws Exception {
		Vendor vendor= new Vendor();
		VendorParameter vendorparameter=new VendorParameter();
		String type=null;
		Calendar cal = Calendar.getInstance();
		cal.setTime(sdf.parse(vendormasteradd.getRegistrationDate()));
		cal.add(Calendar.YEAR, 3); 
		cal.add(Calendar.DATE,-1);
		Date nextYear = cal.getTime();
		String SerialNo=null;
		System.out.println("vendormasteradd.getVendorName().substring(0, 1).toUpperCase()*******"+vendormasteradd.getVendorName().substring(0, 1).toUpperCase());
		vendorparameter.setVendorExt(vendormasteradd.getVendorName().substring(0, 1).toUpperCase());
		try {
		VendorParameter vendorparameterold=dao.VendorParameter(vendormasteradd.getVendorName().substring(0, 1).toUpperCase());
		System.out.println("vendorparameterold*******"+vendormasteradd.getVendorName().substring(0, 1).toUpperCase());
		Long Serial= vendorparameterold.getVendorExtSerialNo();
	    SerialNo=String.valueOf(Serial+1);
	    vendorparameter.setVendorExtSerialNo(Serial+1);
		for(int i=0;i<=5-SerialNo.length();i++) {
			SerialNo=0+SerialNo;
			}
		type="U";
		}catch (Exception e) {
			e.printStackTrace();
			SerialNo="0001";
		    vendorparameter.setVendorExtSerialNo(Long.parseLong("1") );
		    type="I";
		}
		vendor.setVendorCode(vendormasteradd.getVendorName().substring(0, 1).toUpperCase() +SerialNo);
		vendor.setVendorName(vendormasteradd.getVendorName());
		vendor.setAddress(vendormasteradd.getAddress());
		vendor.setCity(vendormasteradd.getCity());
		vendor.setPinCode(vendormasteradd.getPinCode());
		vendor.setCreatedBy(UserId);
		vendor.setCreatedDate(sdf1.format(new Date()));
		vendor.setIsActive(1);
		vendor.setContactPerson(vendormasteradd.getContactPerson());
		vendor.setTelNo(vendormasteradd.getTelNo());
		vendor.setFaxNo(vendormasteradd.getFaxNo());
		vendor.setEmail(vendormasteradd.getEmail());
		vendor.setRegistrationNo(vendormasteradd.getRegistrationNo());
		vendor.setRegistrationDate(new java.sql.Date(sdf.parse(vendormasteradd.getRegistrationDate()).getTime()));
		vendor.setValidityDate(new java.sql.Date(nextYear.getTime()));
		vendor.setCPPRegisterId(vendormasteradd.getCPPRegisterId());
		vendor.setProductRange(vendormasteradd.getProductRange());
		vendor.setVendorType(vendormasteradd.getVendorType());
		vendor.setPAN(vendormasteradd.getPanNo());
		vendor.setGSTNo(vendormasteradd.getGSTNo());
		vendor.setVendorBank(vendormasteradd.getVendorBank());
		vendor.setAccountNo(vendormasteradd.getAccountNo());
		return dao.VendorMasterInsert(vendor,vendorparameter,type);

	}
	
	@Override
	public List<Object[]> VendorMasterEditData(String VendorId) throws Exception {
		return dao.VendorMasterEditData(VendorId);
	}

	@Override
	public int VendorMasterUpdate(VendorMasterAdd vendormasteradd, String UserId) throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.setTime(sdf.parse(vendormasteradd.getRegistrationDate()));
		cal.add(Calendar.YEAR, 3);
		cal.add(Calendar.DATE,-1);
		Date nextYear = cal.getTime();
		Vendor vendor= new Vendor();
		vendor.setVendorName(vendormasteradd.getVendorName());
		vendor.setAddress(vendormasteradd.getAddress());
		vendor.setCity(vendormasteradd.getCity());
		vendor.setPinCode(vendormasteradd.getPinCode());
		vendor.setModifiedBy(UserId);
		vendor.setModifiedDate(sdf1.format(new Date()));
		vendor.setContactPerson(vendormasteradd.getContactPerson());
		vendor.setTelNo(vendormasteradd.getTelNo());
		vendor.setFaxNo(vendormasteradd.getFaxNo());
		vendor.setEmail(vendormasteradd.getEmail());
		vendor.setRegistrationNo(vendormasteradd.getRegistrationNo());
		vendor.setRegistrationDate(new java.sql.Date(sdf.parse(vendormasteradd.getRegistrationDate()).getTime()));
		vendor.setValidityDate(new java.sql.Date(nextYear.getTime()));
		vendor.setCPPRegisterId(vendormasteradd.getCPPRegisterId());
		vendor.setProductRange(vendormasteradd.getProductRange());
		vendor.setVendorType(vendormasteradd.getVendorType());
		vendor.setPAN(vendormasteradd.getPanNo());
		vendor.setGSTNo(vendormasteradd.getGSTNo());
		vendor.setVendorBank(vendormasteradd.getVendorBank());
		vendor.setAccountNo(vendormasteradd.getAccountNo());
		vendor.setVendorId(Long.parseLong(vendormasteradd.getVendorId()));
		return dao.VendorMasterUpdate(vendor);
	}

	@Override
	public int VendorMasterDelete(String VendorId, String UserId) throws Exception {
		Vendor vendor = new Vendor();
		vendor.setVendorId(Long.parseLong(VendorId));
		vendor.setModifiedBy(UserId);
		vendor.setModifiedDate(sdf1.format(new Date()));
		return dao.VendorMasterDelete(vendor);
	}
	
// *************************************************PAYMENT ENDS****************************************************************************	
	
// *************************************************OFFICER STARTS************************************************************************
	
	@Override
	public List<Object[]> DesignationList() throws Exception {
		return dao.DesignationList();
	}
	
	@Override
	public List<Object[]> OfficerDivisionList() throws Exception {
		return dao.OfficerDivisionList();
	}
	
	@Override
	public List<String> EmpNoCheck() throws Exception {
		return dao.EmpNoCheck();
	}

//**************************************************OFFICER ENDS*****************************************************************************

//************************************************GROUP STARTS********************************************************************************
	
	@Override
	public List<Object[]> GroupMasterList() throws Exception {
		return dao.GroupMasterList();
	}

	@Override
	public List<Object[]> GroupMasterListAdd() throws Exception {
		return dao.GroupMasterListAdd();
	}

	@Override
	public Long GroupMasterInsert(GroupMasterAdd groupmasteradd, String UserId) throws Exception {
		DivisionGroup divisiongroup = new DivisionGroup();
		divisiongroup.setGroupCode(groupmasteradd.getGroupCode());
		divisiongroup.setGroupName(groupmasteradd.getGroupName());
		divisiongroup.setGroupHeadId(Long.parseLong(groupmasteradd.getGroupHead()));
		divisiongroup.setCreatedBy(UserId);
		divisiongroup.setCreatedDate(sdf1.format(new Date()));
		divisiongroup.setIsActive(1);
		return dao.GroupMasterInsert(divisiongroup);
	}
	
	@Override
	public List<String> CheckGroupCode() throws Exception {
		return dao.CheckGroupCode();
	}

	@Override
	public List<Object[]> GroupMasterEditData(String GroupId) throws Exception {
		return dao.GroupMasterEditData(GroupId);
	}
	
	@Override
	public List<Object[]> GroupCodeList() throws Exception {
		return dao.GroupCodeList();
	}

	@Override
	public int GroupMasterUpdate(GroupMasterAdd groupmasteradd, String UserId) throws Exception {
		DivisionGroup divisiongroup = new DivisionGroup();
		divisiongroup.setGroupCode(groupmasteradd.getGroupCode());
		divisiongroup.setGroupName(groupmasteradd.getGroupName());
		divisiongroup.setGroupHeadId(Long.parseLong(groupmasteradd.getGroupHead()));
		divisiongroup.setModifiedBy(UserId);
		divisiongroup.setModifiedDate(sdf1.format(new Date()));
		divisiongroup.setGroupId(Long.parseLong(groupmasteradd.getGroupId()));
		return dao.GroupMasterUpdate(divisiongroup);
	}

	@Override
	public int GroupMasterDelete(String GroupId, String UserId) throws Exception {
		DivisionGroup divisiongroup= new DivisionGroup();
		divisiongroup.setModifiedBy(UserId);
		divisiongroup.setModifiedDate(sdf1.format(new Date()));
		divisiongroup.setIsActive(0);
		divisiongroup.setGroupId(Long.parseLong(GroupId));
		return dao.GroupMasterDelete(divisiongroup);
	}

	//************************************************GROUP ENDS************************************************************************************
	
	//***********************************************ITEM UNIT STARTS******************************************************************************
	@Override
	public List<Object[]> DesignationMasterEditData(String DesignationId) throws Exception {
		return dao.DesignationMasterEditData(DesignationId);
	}

	@Override
	public Long DesignationInsert(DesignationDto designationdto) throws Exception {
		EmployeeDesig employeedesig = new EmployeeDesig();
		employeedesig.setDesigCode(designationdto.getDesigCode());
		employeedesig.setDesignation(designationdto.getDesignation());
		employeedesig.setDesigLimit(Long.parseLong(designationdto.getDesigLimit()));
		return dao.DesignationInsert(employeedesig);
	}

	@Override
	public List<String> CheckDesignationId() throws Exception {
		return dao.CheckDesignationId();
	}

	@Override
	public List<String> CheckDesignation() throws Exception {
		return dao.CheckDesignation();
	}

	
	@Override
	public int Empidcount(String Empid) throws Exception {
		int count=0;
		try {
			BigInteger check=dao.EmpidCount( Empid);
			count=check.intValue();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	@Override
	public int EmpCodeCheck(String EmpCode) throws Exception{
		int count =0;
		try {
			BigInteger check=dao.EmpCodeCheck(EmpCode);
			count=check.intValue();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	@Override
	public List<Object[]> DivisionList() throws Exception{
		return dao.DivisionList();
	}
	
	@Override
	public List<Object[]> DivisionAssignList(String DivisionId) throws Exception{
		return dao.DivisionAssignList(DivisionId);
	}
	
	@Override
	public List<Object[]> UserList() throws Exception {
		return dao.UserList();
	}
	
	@Override
	public Object[] DivisionName(String DivisionId) throws Exception{
		return dao.DivisionName(DivisionId);
	}
	
	@Override
	public Long DivisionAssignAdd(DivisionAssignDto divassign) throws Exception{
		LoginDivision logindivision = new LoginDivision();
		logindivision.setDivisionId(Long.parseLong(divassign.getDivisionId()));
		logindivision.setLoginId(Long.parseLong(divassign.getLoginId()));
		logindivision.setSerialNo(Long.parseLong("1"));
		return dao.DivisionAssignAdd(logindivision);
	}

	@Override
	public List<Object[]> EmployeeListDivisionWise(String DivisionId) throws Exception {
		return null;
	}

	@Override
	public int DesignationUpdate(DesignationDto designationdto, String DesignationId) throws Exception {
		return 0;
	}
	
	// *************************************************OFFICER STARTS************************************************************************
	
		@Override
		public List<Object[]> OfficerList() throws Exception {
			return dao.OfficerList();
		}

		@Override
		public Long OfficerMasterInsert(OfficerMasterAdd officermasteradd, String UserId) throws Exception {
			Employee employee= new Employee();
			employee.setEmpNo(officermasteradd.getEmpNo());
			employee.setEmpName(officermasteradd.getEmpName());
			employee.setDesigId(Long.parseLong(officermasteradd.getDesignation()));
			employee.setExtNo(officermasteradd.getExtNo());
			employee.setEmail(officermasteradd.getEmail());
			employee.setDivisionId(Long.parseLong(officermasteradd.getDivision()));
			employee.setCreatedBy(UserId);
			employee.setCreatedDate(sdf1.format(new Date()));
			employee.setIsActive(1);
			return dao.OfficeMasterInsert(employee);
		}

		@Override
		public List<Object[]> OfficerEditData(String OfficerId) throws Exception {
			return dao.OfficerEditData(OfficerId);
		}

		@Override
		public int OfficerMasterUpdate(OfficerMasterAdd officermasteradd, String UserId) throws Exception {
			Employee employee= new Employee();
			employee.setEmpNo(officermasteradd.getEmpNo());
			employee.setEmpName(officermasteradd.getEmpName());
			employee.setDesigId(Long.parseLong(officermasteradd.getDesignation()));
			employee.setExtNo(officermasteradd.getExtNo());
			employee.setEmail(officermasteradd.getEmail());
			employee.setDivisionId(Long.parseLong(officermasteradd.getDivision()));
			employee.setModifiedBy(UserId);
			employee.setModifiedDate(sdf1.format(new Date()));
			employee.setEmpId(Long.parseLong(officermasteradd.getEmpId()));
			return dao.OfficerMasterUpdate(employee);
		}

		@Override
		public int OfficerMasterDelete(String OfficerId, String UserId) throws Exception {
			Employee employee = new Employee();
			employee.setModifiedBy(UserId);
			employee.setModifiedDate(sdf1.format(new Date()));
			employee.setIsActive(0);
			employee.setEmpId(Long.parseLong(OfficerId));
			return dao.OfficerMasterDelete(employee);
		}

	//**************************************************OFFICER ENDS*****************************************************************************

		/******************** SOURCE START**************/
		@Override
		public List<Object[]> SourceMasterList() throws Exception {
			return dao.SourceMasterList();
		}

	@Override
	public List<Object[]> SourceDropDownList() throws Exception {
		return dao.SourceDropDownList();
	}

	@Override
	public Object[] GetParticularSourceDetails(String SourceDetailId) throws Exception {
		return dao.GetParticularSourceDetails(SourceDetailId);
	}

	@Override
	public Long InsertSourceDetails(Source source) throws Exception {
		return dao.InsertSourceDetails(source);
	}

	@Override
	public Long UpdateSourceDetails(Source source) throws Exception {
		Source source1=dao.GetSourceEditDetails(source.getSourceDetailId());
		source1.setSourceId(source.getSourceId());
		source1.setSourceShortName(source.getSourceShortName());
		source1.setSourceName(source.getSourceName());
		source1.setSourceAddress(source.getSourceAddress());
		source1.setSourceCity(source.getSourceCity());
		source1.setSourcePin(source.getSourcePin());
 		source1.setIsDMS(source.getIsDMS());
	    source1.setApiUrl(source.getApiUrl());
	    source1.setLabCode(source.getLabCode());
	    source1.setDivisionCode(source.getDivisionCode());
		source1.setModifiedBy(source.getModifiedBy());
		source1.setModifiedDate(source.getModifiedDate());
		return dao.UpdateSourceDetails(source1);
	}

	@Override
	public Object[] GetParticularNonProjectDetails(String nonProjectId) throws Exception {
		return dao.GetParticularNonProjectDetails(nonProjectId);
	}

	@Override
	public List<Object[]> GetNonProjectList() throws Exception {
		return dao.GetNonProjectList();
	}

	@Override
	public Long InsertNonProjectDetails(NonProjectMaster nonProject) throws Exception {
		return dao.InsertNonProjectDetails(nonProject);
	}

	@Override
	public Long UpdateNonProjectDetails(NonProjectMaster nonProject) throws Exception {
		NonProjectMaster nonProject1=dao.GetNonProjectEditDetails(nonProject.getNonProjectId());
		nonProject1.setNonShortName(nonProject.getNonShortName());
		nonProject1.setNonProjectName(nonProject.getNonProjectName());
		nonProject1.setModifiedBy(nonProject.getModifiedBy());
		nonProject1.setModifiedDate(nonProject.getModifiedDate());
		return dao.UpdateNonProjectDetails(nonProject1);
	}

	@Override
	public int CheckDuplicateShortName(String shortName, String type) throws Exception {
		int Status=0;
		if(type.equalsIgnoreCase("Source"))
		{
			Status=dao.CheckDuplicateSourceShortName(shortName);
		}
		else if(type.equalsIgnoreCase("NonProject"))   
		{
			Status=dao.CheckDuplicateNonProjectShortName(shortName);
		}
		else if(type.equalsIgnoreCase("OtherProject"))   
		{
			Status=dao.CheckDuplicateOtherProjectShortName(shortName);
		}
		return Status;
	}

	@Override
	public List<Object[]> GetOtherProjectList() throws Exception {
		return dao.GetOtherProjectList();
	}

	@Override
	public Object[] GetParticularOtherProjectDetails(String otherProjectId) throws Exception {
		return dao.GetParticularOtherProjectDetails(otherProjectId);
	}

	@Override
	public Long InsertOtherProjectDetails(OtherProjectMaster otherProject) throws Exception {
		return dao.InsertOtherProjectDetails(otherProject);
	}

	@Override
	public Long UpdateOtherProjectDetails(OtherProjectMaster otherProject) throws Exception {
		OtherProjectMaster otherProject1=dao.GetOtherProjectEditDetails(otherProject.getProjectOtherId());
		otherProject1.setProjectCode(otherProject.getProjectCode());
		otherProject1.setProjectShortName(otherProject.getProjectShortName());
		otherProject1.setProjectName(otherProject.getProjectName());
		otherProject1.setLabCode(otherProject.getLabCode());
		otherProject1.setModifiedBy(otherProject.getModifiedBy());
		otherProject1.setModifiedDate(otherProject.getModifiedDate());
		return dao.UpdateOtherProjectDetails(otherProject1);
	}

	@Override
	public List<Object[]> GetMemberTypeList() throws Exception {
		return dao.GetMemberTypeList();
	}

	@Override
	public Object[] GetParticularMemberTypeDetails(String memberTypeId) throws Exception {
		return dao.GetParticularMemberTypeDetails(memberTypeId);
	}

	@Override
	public Long InsertMemberTypeDetails(MemberTypeMaster membertype) throws Exception {
		return dao.InsertMemberTypeDetails(membertype);
	}

	@Override
	public Long UpdateMemberTypeDetails(MemberTypeMaster membertype) throws Exception {
		MemberTypeMaster membertype1=dao.GetMemberTypeEditDetails(membertype.getDakMemberTypeId());
		membertype1.setDakMemberType(membertype.getDakMemberType());
		membertype1.setModifiedBy(membertype.getModifiedBy());
		membertype1.setModifiedDate(membertype.getModifiedDate());
		membertype1.setMemberTypeGrouping(membertype.getMemberTypeGrouping());
		return dao.UpdateMemberTypeDetails(membertype1);
	}

	@Override
	public Object getlabcode(long empId) throws Exception {
		return dao.getlabcode(empId);
	}
	
}

	

