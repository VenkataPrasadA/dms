package com.vts.dms.master.dao;

import java.math.BigInteger;
import java.util.Date;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

import org.springframework.stereotype.Repository;

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


@Transactional
@Repository
public class MasterDaoImpl implements MasterDao {

	private static final String DIVISIONLIST = "SELECT a.divisionid,a.divisioncode,a.divisionname,b.empname,c.groupname FROM division_master a,employee b,division_group c WHERE a.isactive='1' AND a.divisionheadid=b.empid AND a.groupid=c.groupid ORDER BY a.divisionid DESC ";
	private static final String LABLIST="select labmasterid,labcode,labname,labunitcode,labaddress,labcity,labpin FROM lab_master";
	private static final String VENDORMASTERLIST="select a.vendorid, a.vendorcode, a.vendorname, a.address, a.city, a.pincode, a.contactperson, a.telno, a.faxno, a.email, a.cppregisterid, a.registrationno, a.registrationdate, a.validitydate, a.productrange, a.vendortype, a.pan, a.gstno, a.vendorbank, a.accountno FROM vendor a WHERE isactive=1";
	private static final String OFFICERLIST="SELECT a.empid, a.empno, a.empname, b.designation, a.extno, a.email, c.divisionname, a.desigid, a.divisionid FROM employee a,employee_desig b, division_master c WHERE a.desigid= b.desigid AND a.divisionid= c.divisionid AND a.isactive='1' ORDER BY a.empid DESC ";
	private static final String GROUPMASTERLIST="SELECT a.groupid, a.groupcode, a.groupname, b.empname, a.groupheadid FROM division_group a, employee b WHERE a.isactive=1 AND a.groupheadid=b.empid ";
	
	private static final String DIVISIONGROUPLIST="SELECT a.groupid,a.groupname FROM division_group a WHERE a.isactive=1";
	private static final String DIVISIONUPDATE="UPDATE division_master SET divisioncode=:divisioncode, divisionname=:divisionname, divisionheadid=:divisionheadid , groupid=:groupid, modifiedby=:modifiedby, modifieddate=:modifieddate WHERE divisionid=:divisionid";
	private static final String DIVISIONEDITDATA="select divisionid,divisioncode,divisionname,divisionheadid,groupid from division_master where divisionid=:divisionid";
	private static final String DIVISIONDELETE="UPDATE division_master SET isactive=:isactive, modifiedby=:modifiedby, modifieddate=:modifieddate WHERE divisionid=:divisionid";
	private static final String DIVISIONHEADLIST="SELECT a.empid, a.empname FROM employee a WHERE  a.isactive=1 ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String DIVISIONCODECHECK="SELECT a.divisioncode FROM division_master a WHERE a.isactive=1";
	private static final String DIVISIONCODELIST="SELECT  a.divisionid,a.divisioncode FROM division_master a WHERE a.isactive=1 AND divisionid=:divisionid";
	
	private static final String LABMASTEREDITDATA="select labmasterid,labcode,labname,labunitcode,labaddress,labcity,labpin,labtelno,labfaxno,labemail from lab_master where labmasterid= :labmasterid";
	private static final String LABMASTERUPDATE="UPDATE lab_master SET labcode=:labcode , labname=:labname , labunitcode=:labunitcode, labaddress=:labaddress, labcity=:labcity, labpin= :labpin ,labtelno=:labtelno, labfaxno=:labfaxno, labemail=:labemail WHERE labmasterid=:labmasterid";
	private static final String LABCODECHECK="SELECT labcode FROM lab_master";
	
	private static final String EMPLOYEELIST="SELECT empid, empname FROM employee WHERE isactive=1 ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String PROJECTLIST="SELECT projectid, projectname FROM project_master";

	private static final String VENDORMASTEREDITDATA="select vendorid,vendorcode,vendorname,address,city,pincode,contactperson,telno,faxno,email,registrationno,registrationdate,validitydate,cppregisterid,productrange,vendortype,pan,gstno,vendorbank,accountno from vendor where vendorid=:vendorid";
	private static final String VENDORMASTERUPDATE="UPDATE vendor SET  vendorname=:vendorname, address=:address, city=:city, pincode=:pincode, modifiedby=:modifiedby, modifieddate=:modifieddate, contactperson=:contactperson, telno=:telno, faxno=:faxno, email=:email, registrationno=:registrationno, registrationdate=:registrationdate, validitydate=:validitydate, cppregisterid=:cppregisterid, productrange=:productrange, vendortype=:vendortype, pan=:pan, gstno=:gstno, vendorbank=:vendorbank , accountno=:accountno WHERE vendorid=:vendorid";
	private static final String VENDORMASTERDELETE="UPDATE vendor SET isactive=:isactive, modifiedby=:modifiedby, modifieddate=:modifieddate WHERE vendorid=:vendorid";
	private static final String VENDORNAMECHECK="SELECT vendorname FROM vendor";
	private static final String VENDORCODELIST="SELECT vendorid,vendorcode FROM vendor WHERE vendorid=:vendorid";

	private static final String OFFICEREDITDATA="select empid,empno,empname,desigid,extno,email,divisionid from employee  where empid=:empid";
	private static final String OFFICERMASTERUPDATE="UPDATE employee SET empno=:empno, empname=:empname, desigid=:desigid, extno=:extno, email=:email, divisionid=:divisionid, modifiedby=:modifiedby, modifieddate=:modifieddate WHERE empid=:empid" ;
	private static final String OFFICERMASTERDELETE="UPDATE employee SET isactive=:isactive, modifieddate=:modifieddate, modifiedby=:modifiedby WHERE empid=:empid";
	private static final String EMPNOCHECK="SELECT empno FROM employee";
	private static final String DESIGNATIONLIST="SELECT desigid, desigcode, designation, desiglimit FROM employee_desig";
	private static final String OFFICERDIVISIONLIST="SELECT divisionid, divisionname FROM division_master where isactive='1'";
	
	private static final String GROUPMASTERLISTADD="SELECT empid , empname FROM employee WHERE IsActive=1 ORDER BY CASE WHEN Srno = 0 THEN 1 ELSE 0 END, Srno ASC";
	private static final String CHECKGROUPCODE="SELECT groupcode FROM division_group";
	private static final String GROUPMASTEREDITDATA="select groupid,groupcode,groupname,groupheadid from division_group where groupid=:groupid";
	private static final String GROUPCODELIST="SELECT groupcode, groupid FROM division_group";
	private static final String GROUPMASTERUPDATE="UPDATE division_group SET groupcode=:groupcode, groupname=:groupname, groupheadid=:groupheadid,modifiedby=:modifiedby, modifieddate=:modifieddate WHERE groupid=:groupid";
	private static final String GROUPMASTERDELETE="UPDATE division_group SET isactive=:isactive,modifiedby=:modifiedby, modifieddate=:modifieddate WHERE groupid=:groupid ";
	private static final String LASTVENDORCODE="SELECT vendorcode FROM vendor WHERE vendorid=(SELECT MAX(vendorid) FROM vendor) ";
	private static final String VENDORPARADATA="FROM vendor_parameter WHERE VendorExt=:vendorext "; 
	private static final String VENDORPARAUPDATE="update vendor_parameter set vendorextserialno=:vendorextserialno where vendorext=:vendorext ";
	private static final String DIVISIONID="select divisionid from employee where empid=:empid";
	
	private static final String DESIGNATIONEDITDATA="select desigcode, designation, desiglimit, desigid from employee_desig where desigid=:designationid";
	private static final String CHECKDESIGNATIONID="select desigcode from employee_desig";
	private static final String CHECKDESIGNATION="select designation from employee_desig";
	private static final String DESIGNATIONUPDATE="update employee_desig set desigcode=:desigcode, designation=:designation, desiglimit=:desiglimit where desigid=:designationid";
	
	private static final String EMPIDCHECK="select count(*) from cfa_master where empid=:empid and isactive='1'";
	private static final String CFAEXTERNALLIST="SELECT a.cfaexternalid,b.cfacontype,a.empcode,a.empname,c.designation,a.empemail,a.cfalimit FROM cfa_external a,cfa_con_type b,employee_desig c WHERE a.cfaconcode=b.cfaconcode AND a.desigid=c.desigid AND isactive='1'"; 
	private static final String EMPCODECHECK="SELECT count(*) from cfa_external where empcode=:empcode";
	private static final String DIVISIONASSIGNLIST="SELECT divisionid, divisionname from division_master where isactive='1' ";
	private static final String DIVISIONSUBMITLIST="SELECT a.logindivisionid, b.empid, b.username, a.divisionid, c.empname, d.designation FROM login_division a, login b, employee c, employee_desig d WHERE a.loginid=b.loginid  AND b.empid=c.empid AND c.desigid=d.desigid AND b.isactive='1' AND c.isactive='1' AND a.divisionid=:divisionid " ;
	private static final String USERLIST="select loginid, username, empid from login where isactive=1 ";
	private static final String DIVISIONDATA="select divisionid, divisionname from division_master where isactive=1 and divisionid=:divisionid";
	private static final String SOURCEDETAILSLIST="SELECT a.SourceDetailId,a.SourceId,a.SourceShortName,a.SourceName,b.SourceName as 'SN',a.IsDMS FROM dak_source_details a,dak_source b WHERE a.SourceId=b.SourceId";
	private static final String SOURCEDROPDOWNLIST="SELECT a.SourceId,a.SourceName FROM dak_source a";
	private static final String PARTICULARSOURCEDETAILS="SELECT a.SourceDetailId,a.SourceId,a.SourceShortName,a.SourceName,a.SourceAddress,a.SourceCity,a.SourcePin,a.IsDMS,a.ApiUrl FROM dak_source_details a WHERE a.SourceDetailId=:sourceDetailId";
	private static final String GETNONPROJECTDETAILS="SELECT a.NonProjectId,a.NonShortName,a.NonProjectName FROM dak_non_project a WHERE a.NonProjectId=:NonProjectId";
	private static final String GETNONPROJECTLIST="SELECT a.NonProjectId,a.NonShortName,a.NonProjectName FROM dak_non_project a";
	private static final String CHECKDUPLICATESOURCE="SELECT COUNT(SourceShortName) FROM dak_source_details WHERE SourceShortName=:shortName";
	private static final String CHECKDUPLICATENONPROJECT="SELECT COUNT(NonShortName) FROM dak_non_project WHERE NonShortName=:shortName";
	private static final String GETOTHERPROJECTLIST="SELECT a.ProjectOtherId,a.ProjectCode,a.ProjectShortName,a.ProjectName,a.LabCode FROM dak_others_project a WHERE a.Isactive='1'";
	private static final String PARTICULAROTHERPROJECTDETAILS="SELECT a.ProjectOtherId,a.ProjectCode,a.ProjectShortName,a.ProjectName,a.LabCode FROM dak_others_project a WHERE a.ProjectOtherId=:otherProjectId AND a.Isactive='1'";
	private static final String CHECKDUPLICATEOTHERPROJECT="SELECT COUNT(ProjectShortName) FROM dak_others_project WHERE ProjectShortName=:shortName";
	private static final String GETMEMBERTYPEDETAILS="SELECT a.DakMemberTypeId,a.DakMemberType,a.MemberTypeGrouping FROM dak_member_type a";
	private static final String PARTICULARMEMBERTYPEDETAILS="SELECT a.DakMemberTypeId,a.DakMemberType,a.MemberTypeGrouping FROM dak_member_type a WHERE a.DakMemberTypeId=:memberTypeId";
	private static final String GETLABCODE = "SELECT labcode FROM employee WHERE empid=:empId";
	
	@PersistenceContext       
	EntityManager manager;
	
	
	@Override
	public List<Object[]> DivisionMasterList() throws Exception {
		Query query = manager.createNativeQuery(DIVISIONLIST);
		List<Object[]> DivisionList = (List<Object[]>) query.getResultList();
		return DivisionList;
		
	}

	@Override
	public List<Object[]> DivisionGroupList() throws Exception{
		Query query=manager.createNativeQuery(DIVISIONGROUPLIST);
		List<Object[]> DivisionGroupList=(List<Object[]>)query.getResultList();
		return DivisionGroupList;
	}
	

	
	@Override
	public List<Object[]> DivisionHeadList() throws Exception {
		Query query=manager.createNativeQuery(DIVISIONHEADLIST);
		List<Object[]> DivisionHeadList=(List<Object[]>)query.getResultList();
		return DivisionHeadList;
	}
	


	@Override
	public List<String> DivisionCodeCheck() throws Exception {
		Query query=manager.createNativeQuery(DIVISIONCODECHECK);
		List<String> DivisionCodeCheck=(List<String>)query.getResultList();
		return DivisionCodeCheck;
	}
	
	@Override
	public List<Object[]> DivisionCodeList(Long DivisionId) throws Exception {
		Query query=manager.createNativeQuery(DIVISIONCODELIST);
		query.setParameter("divisionid", DivisionId);
		List<Object[]> DivisionCodeList=(List<Object[]>)query.getResultList();
		return DivisionCodeList;
	}
	
	@Override
	public Long DivisionMasterInsert(DivisionMaster divisionmaster) throws Exception {
		manager.persist(divisionmaster);
		manager.flush();
		return divisionmaster.getDivisionId();
	}


	@Override
	public int DivisionMasterUpdate(DivisionMaster divisionmaster) throws Exception {
		Query query=manager.createNativeQuery(DIVISIONUPDATE);
		query.setParameter("divisioncode", divisionmaster.getDivisionCode());
		query.setParameter("divisionname", divisionmaster.getDivisionName());
		query.setParameter("divisionheadid", divisionmaster.getDivisionHeadId());
		query.setParameter("groupid", divisionmaster.getGroupId());
		query.setParameter("divisionid", divisionmaster.getDivisionId());
		query.setParameter("modifiedby", divisionmaster.getModifiedBy());
		query.setParameter("modifieddate", divisionmaster.getModifiedDate());
		int count = (int)query.executeUpdate();
		return count;
	}


	@Override
	public List<Object[]> DivisionMasterEditData(String DivisionId) throws Exception {
		Query query= manager.createNativeQuery(DIVISIONEDITDATA);
		query.setParameter("divisionid", DivisionId);
		List<Object[]> DivisionMasterEditData=(List<Object[]>) query.getResultList();
		return DivisionMasterEditData;
	}


	@Override
	public int DivisionMasterDelete(DivisionMaster divisionmaster) throws Exception {
		Query query=manager.createNativeQuery(DIVISIONDELETE);
		query.setParameter("isactive", 0);
		query.setParameter("divisionid",divisionmaster.getDivisionId() );
		query.setParameter("modifiedby", divisionmaster.getModifiedBy());
		query.setParameter("modifieddate", divisionmaster.getModifiedDate());
		int count = (int) query.executeUpdate();
		return count;
	}


	@Override
	public List<Object[]> LabMasterList() throws Exception {
			Query query = manager.createNativeQuery(LABLIST);
			List<Object[]> LabList =(List<Object[]>) query.getResultList();
		    return LabList;
	}

	@Override
	public Long LabMasterInsert(LabMaster labmaster) throws Exception {
		manager.persist(labmaster);
		manager.flush();
		return (long) labmaster.getLabMasterId();
	}

	@Override
	public List<Object[]> LabMasterEditData(String LabId) throws Exception {
		Query query = manager.createNativeQuery(LABMASTEREDITDATA);
		query.setParameter("labmasterid",LabId );
		List<Object[]> LabMasterEditData=(List<Object[]>) query.getResultList();
		return LabMasterEditData;
	}
	


	@Override
	public int LabMasterUpdate(LabMaster labmaster) throws Exception {
		Query query=manager.createNativeQuery(LABMASTERUPDATE);
		query.setParameter("labcode", labmaster.getLabCode());
		query.setParameter("labname", labmaster.getLabName());
		query.setParameter("labunitcode", labmaster.getLabUnitCode());
		query.setParameter("labaddress", labmaster.getLabAddress());
		query.setParameter("labcity", labmaster.getLabCity());
		query.setParameter("labpin", labmaster.getLabPin());
		query.setParameter("labmasterid", labmaster.getLabMasterId());
		query.setParameter("labtelno", labmaster.getLabTelNo());
		query.setParameter("labfaxno", labmaster.getLabFaxNo());
		query.setParameter("labemail", labmaster.getLabEmail());
		int count = (int)query.executeUpdate();
		return count;
	}

	@Override
	public List<String> LabCodeCheck() throws Exception {
		Query query= manager.createNativeQuery(LABCODECHECK);
		List<String> LabCodeCheck=(List<String>)query.getResultList();
		return LabCodeCheck ;
	}
	
	
	
	
	
	@Override
	public List<Object[]> EmployeeList() throws Exception {
		Query query= manager.createNativeQuery(EMPLOYEELIST);
		List < Object[]>  EmployeeList =(List <Object[]>)query.getResultList();
		return EmployeeList;
	}

	@Override
	public List<Object[]> ProjectList() throws Exception {
		Query query= manager.createNativeQuery(PROJECTLIST);
		List < Object[]>  ProjectList =(List <Object[]>)query.getResultList();
		return ProjectList;
	}
	
// *****************************************VENDOR STARTS***************************************************************
	
	@Override
	public List<Object[]> VendorCodeList(Long VendorId) throws Exception {
		Query query=manager.createNativeQuery(VENDORCODELIST);
		query.setParameter("vendorid", VendorId);
		List<Object[]> VendorCodeList=(List<Object[]>) query.getResultList();
		return VendorCodeList;
	}
	
	@Override
	public List<String> VendorNameCheck() throws Exception {
		Query query=manager.createNativeQuery(VENDORNAMECHECK);
		List<String> VendorNameCheck=(List<String>) query.getResultList();
		return VendorNameCheck;
	}
	
	@Override
	public String VendorMasterInsert(Vendor vendor,VendorParameter vendorparameter,String type) throws Exception {
		manager.persist(vendor);
		if(type.equalsIgnoreCase("I")) {
			manager.persist(vendorparameter);
		}else {
			Query query=manager.createNativeQuery(VENDORPARAUPDATE);
			query.setParameter("vendorextserialno", vendorparameter.getVendorExtSerialNo());
			query.setParameter("vendorext", vendorparameter.getVendorExt());
			query.executeUpdate();
		}
		manager.flush();
		return vendor.getVendorCode();
	}

	@Override
	public List<Object[]> VendorMasterEditData(String VendorId) throws Exception {
		Query query=manager.createNativeQuery(VENDORMASTEREDITDATA);
		query.setParameter("vendorid", VendorId);
		List<Object[]> VendorMasterEditData=(List<Object[]>)query.getResultList();
		return VendorMasterEditData;
	}

	@Override
	public int VendorMasterUpdate(Vendor vendor) throws Exception {
		Query query=manager.createNativeQuery(VENDORMASTERUPDATE);
		query.setParameter("vendorname", vendor.getVendorName());
		query.setParameter("address", vendor.getAddress());
		query.setParameter("city", vendor.getCity());
		query.setParameter("pincode", vendor.getPinCode());
		query.setParameter("vendorid", vendor.getVendorId());
		query.setParameter("modifiedby", vendor.getModifiedBy());
		query.setParameter("modifieddate", vendor.getModifiedDate());
		query.setParameter("contactperson", vendor.getContactPerson());
		query.setParameter("telno", vendor.getTelNo());
		query.setParameter("faxno", vendor.getFaxNo());
		query.setParameter("email", vendor.getEmail());
		query.setParameter("registrationno",vendor.getRegistrationNo());
		query.setParameter("registrationdate", vendor.getRegistrationDate());
		query.setParameter("validitydate", vendor.getValidityDate());
		query.setParameter("cppregisterid", vendor.getCPPRegisterId());
		query.setParameter("productrange", vendor.getProductRange());
		query.setParameter("vendortype", vendor.getVendorType());
		query.setParameter("pan", vendor.getPAN());
		query.setParameter("gstno", vendor.getGSTNo());
		query.setParameter("vendorbank", vendor.getVendorBank());
		query.setParameter("accountno", vendor.getAccountNo());
		int count=(int) query.executeUpdate();
		return count;
	}
	
	@Override
	public int VendorMasterDelete(Vendor vendor) throws Exception {
		Query query=manager.createNativeQuery(VENDORMASTERDELETE);
		query.setParameter("vendorid", vendor.getVendorId());
		query.setParameter("isactive", 0);
		query.setParameter("modifiedby", vendor.getModifiedBy());
		query.setParameter("modifieddate", vendor.getModifiedDate());
		int count=(int)query.executeUpdate();
		return count;
	}
	
	@Override
	public List<Object[]> VendorMasterList() throws Exception {
		Query query=manager.createNativeQuery(VENDORMASTERLIST);
		List<Object[]> VendorList=(List<Object[]>) query.getResultList();
		return VendorList;
	}

//******************************************************PAYMENT ENDS*************************************************************************

//******************************************************OFFICER STARTS**********************************************************************
	
	@Override
	public List<Object[]> OfficerList() throws Exception {
		Query query=manager.createNativeQuery(OFFICERLIST);
		List<Object[]> OfficerList=(List<Object[]>)query.getResultList();
		return OfficerList;
	}
	
	@Override
	public List<Object[]> DesignationList() throws Exception {
		Query query=manager.createNativeQuery(DESIGNATIONLIST);
		List<Object[]> DesignationList=(List<Object[]>)query.getResultList();
		return DesignationList;
	}

	@Override
	public List<Object[]> OfficerDivisionList() throws Exception {

		Query query=manager.createNativeQuery(OFFICERDIVISIONLIST);
		List<Object[]> DivisionList=(List<Object[]>)query.getResultList();
		return DivisionList;
	}

	@Override
	public List<String> EmpNoCheck() throws Exception {
		Query query=manager.createNativeQuery(EMPNOCHECK);
		List<String> EmpNoCheck=(List<String>)query.getResultList();
		return EmpNoCheck;
	}

	@Override
	public Long OfficeMasterInsert(Employee employee) throws Exception {
		manager.persist(employee);
		manager.flush();
		return employee.getEmpId();
	}


	@Override
	public List<Object[]> OfficerEditData(String OfficerId) throws Exception {
		Query query=manager.createNativeQuery(OFFICEREDITDATA);
		query.setParameter("empid", OfficerId);
		List<Object[]> OfficerEditData= (List<Object[]>) query.getResultList();
		return OfficerEditData;
	}





	@Override
	public int OfficerMasterUpdate(Employee employee) throws Exception {
		Query query=manager.createNativeQuery(OFFICERMASTERUPDATE);
		query.setParameter("empno", employee.getEmpNo());
		query.setParameter("empname", employee.getEmpName());
		query.setParameter("desigid", employee.getDesigId());
		query.setParameter("extno", employee.getExtNo());
		query.setParameter("email", employee.getEmail());
		query.setParameter("divisionid", employee.getDivisionId());
		query.setParameter("empid", employee.getEmpId());
		query.setParameter("modifiedby", employee.getModifiedBy());
		query.setParameter("modifieddate", employee.getModifiedDate());
		int count =(int)query.executeUpdate();
		return count;
	}


	@Override
	public int OfficerMasterDelete(Employee employee) throws Exception {
		Query query=manager.createNativeQuery(OFFICERMASTERDELETE);
		query.setParameter("modifieddate", employee.getModifiedDate());
		query.setParameter("modifiedby", employee.getModifiedBy());
		query.setParameter("isactive", employee.getIsActive());
		query.setParameter("empid", employee.getEmpId());
		int count =(int)query.executeUpdate();
		return count ;
	}

//*****************************************************OFFICER ENDS**************************************************************************
	
//*****************************************************GROUP STARTS*************************************************************************

	@Override
	public List<Object[]> GroupMasterList() throws Exception {
		Query query=manager.createNativeQuery(GROUPMASTERLIST);
		List<Object[]> GroupMasterList=(List<Object[]>)query.getResultList();
		return GroupMasterList;
	}

	@Override
	public List<Object[]> GroupMasterListAdd() throws Exception {
		Query query=manager.createNativeQuery(GROUPMASTERLISTADD);
		List<Object[]> GroupMasterListAdd=(List<Object[]>)query.getResultList();
		return GroupMasterListAdd;	
		
	}

	@Override
	public Long GroupMasterInsert(DivisionGroup divisiongroup) throws Exception {
		manager.persist(divisiongroup);
		manager.flush();
		return divisiongroup.getGroupId();
	}
	
	@Override
	public List<String> CheckGroupCode() throws Exception {
		Query query=manager.createNativeQuery(CHECKGROUPCODE);
		List<String> CheckGroupCode=(List<String>)query.getResultList();
		return CheckGroupCode;	
	}

	@Override
	public List<Object[]> GroupMasterEditData(String GroupId) throws Exception {
		Query query=manager.createNativeQuery(GROUPMASTEREDITDATA);
		query.setParameter("groupid", GroupId);
		List<Object[]> GroupMasterEditData= (List<Object[]>)query.getResultList();
		return GroupMasterEditData;
	}

	@Override
	public List<Object[]> GroupCodeList() throws Exception {
		Query query=manager.createNativeQuery(GROUPCODELIST);
		List<Object[]> GroupCodeList=(List<Object[]>)query.getResultList();
		return GroupCodeList;	
	}

	@Override
	public int GroupMasterUpdate(DivisionGroup divisiongroup) throws Exception {
		Query query=manager.createNativeQuery(GROUPMASTERUPDATE);
		query.setParameter("groupcode", divisiongroup.getGroupCode());
		query.setParameter("groupname", divisiongroup.getGroupName());
		query.setParameter("groupheadid",divisiongroup.getGroupHeadId());
		query.setParameter("modifiedby", divisiongroup.getModifiedBy());
		query.setParameter("modifieddate", divisiongroup.getModifiedDate());
		query.setParameter("groupid", divisiongroup.getGroupId());
		int count=(int) query.executeUpdate();
		return count;
	}

	@Override
	public int GroupMasterDelete(DivisionGroup divisiongroup) throws Exception {
		Query query=manager.createNativeQuery(GROUPMASTERDELETE);
		query.setParameter("modifiedby", divisiongroup.getModifiedBy());
		query.setParameter("modifieddate", divisiongroup.getModifiedDate());
		query.setParameter("isactive", divisiongroup.getIsActive());
		query.setParameter("groupid", divisiongroup.getGroupId());
		int count= (int) query.executeUpdate();
		return count;
	}

//****************************************************GROUP ENDS ***************************************************************************

	@Override
	public String LastVendorCode() throws Exception {
		Query query=manager.createNativeQuery(LASTVENDORCODE);
	    String LastVendorCode = (String) query.getSingleResult();
		return LastVendorCode;
	}

	@Override
	public VendorParameter VendorParameter(String VendorExt) throws Exception {
		Query query=manager.createQuery(VENDORPARADATA);
		query.setParameter("vendorext", VendorExt);
		VendorParameter VendorParameter  =(VendorParameter)query.getSingleResult();	
		return VendorParameter ;
	}

	
	@Override
	public Long DivisionId(String EmpId) throws Exception {
		Query query=manager.createNativeQuery(DIVISIONID);
		query.setParameter("empid", EmpId);
		BigInteger DivisionId = (BigInteger) query.getSingleResult();
		return DivisionId.longValue();
	}



	@Override
	public List<Object[]> DesignationMasterEditData(String DesignationId) throws Exception {
		Query query=manager.createNativeQuery(DESIGNATIONEDITDATA);
		query.setParameter("designationid", DesignationId);
		List<Object[]> DesignationMasterEditData = (List<Object[]>) query.getResultList();
		return DesignationMasterEditData;
	}

	@Override
	public Long DesignationInsert(EmployeeDesig employeedesig) throws Exception {
		manager.persist(employeedesig);
		manager.flush();
		return employeedesig.getDesigId();
	}

	@Override
	public List<String> CheckDesignationId() throws Exception {
		Query query= manager.createNativeQuery(CHECKDESIGNATIONID);
		List<String> CheckDesignationId= query.getResultList();
		return CheckDesignationId;
	}

	@Override
	public List<String> CheckDesignation() throws Exception {
		Query query=manager.createNativeQuery(CHECKDESIGNATION);
		List <String> CheckDesignation= query.getResultList();
		return CheckDesignation;
	}

	@Override
	public int DesignationUpdate(EmployeeDesig employeedesig,String DesignationId) throws Exception {
		Query query= manager.createNativeQuery(DESIGNATIONUPDATE);
		query.setParameter("designationid", DesignationId);
		query.setParameter("desigcode",  employeedesig.getDesigCode());
		query.setParameter("designation", employeedesig.getDesignation());
		query.setParameter("desiglimit", employeedesig.getDesigLimit());
		int count = (int) query.executeUpdate();
		return count;
	}

	
	@Override
	public BigInteger EmpidCount(String Empid) throws Exception {
		Query query=manager.createNativeQuery(EMPIDCHECK);
		query.setParameter("empid", Empid);
		BigInteger EmpidCount = (BigInteger) query.getSingleResult();
		return EmpidCount;
	}

	@Override
	public List<Object[]> CfaExternalList() throws Exception {
		Query query= manager.createNativeQuery(CFAEXTERNALLIST);
		List<Object[]> CfaExternalList = (List<Object[]>)query.getResultList();
		return CfaExternalList;
	}
	

	@Override
	public BigInteger EmpCodeCheck(String EmpCode) throws Exception{
		Query query=manager.createNativeQuery(EMPCODECHECK);
		query.setParameter("empcode", EmpCode);
		BigInteger EmpCodeCheck=(BigInteger)query.getSingleResult();
		return EmpCodeCheck;
	}
	

	
	@Override
	public List<Object[]> DivisionList() throws Exception {
		Query query= manager.createNativeQuery(DIVISIONASSIGNLIST);
		List<Object[]> DivisionList = (List<Object[]>)query.getResultList();
		return DivisionList;
	}
	
	@Override
	public List<Object[]> DivisionAssignList(String DivisionId) throws Exception {
		Query query= manager.createNativeQuery(DIVISIONSUBMITLIST);
		query.setParameter("divisionid", DivisionId);
		List<Object[]> DivisionAssignList = (List<Object[]>)query.getResultList();
		return DivisionAssignList;
	}
	
	@Override
	public List<Object[]> UserList() throws Exception {
		Query query=manager.createNativeQuery(USERLIST);
		List<Object[]> OfficerList=(List<Object[]>)query.getResultList();
		return OfficerList;
	}
	
	@Override
	public Object[] DivisionName(String DivisionId) throws Exception{
		Query query=manager.createNativeQuery(DIVISIONDATA);
		query.setParameter("divisionid",DivisionId);
		Object[] DivisionName=(Object[])query.getSingleResult();
		return DivisionName;
	}

	@Override
	public Long DivisionAssignAdd(LoginDivision logindivision) throws Exception {
		 	manager.persist(logindivision);
			manager.flush();
			return logindivision.getLoginDivisionId();
	}

	@Override
	public List<Object[]> SourceMasterList() throws Exception {
		Query query= manager.createNativeQuery(SOURCEDETAILSLIST);
		List<Object[]> SourceDetailsList = (List<Object[]>)query.getResultList();
		return SourceDetailsList;
	}

	@Override
	public List<Object[]> SourceDropDownList() throws Exception {
		Query query= manager.createNativeQuery(SOURCEDROPDOWNLIST);
		List<Object[]> SourceDropDownList = (List<Object[]>)query.getResultList();
		return SourceDropDownList;
	}

	@Override
	public Object[] GetParticularSourceDetails(String sourceDetailId) throws Exception {
		Query query= manager.createNativeQuery(PARTICULARSOURCEDETAILS);
		query.setParameter("sourceDetailId", sourceDetailId);
		Object[] ParticularSourceDetails = (Object[])query.getSingleResult();
		return ParticularSourceDetails;
	}

	@Override
	public Long InsertSourceDetails(Source source) throws Exception {
		manager.persist(source);
		manager.flush();
		return source.getSourceDetailId();
	}

	@Override
	public Long UpdateSourceDetails(Source source) throws Exception {
		manager.merge(source);
		manager.flush();
		return source.getSourceDetailId();
	}

	@Override
	public Source GetSourceEditDetails(long sourceDetailId) throws Exception {
		Source SourceData= manager.find(Source.class,sourceDetailId);
		return SourceData;
	}

	@Override    
	public Object[] GetParticularNonProjectDetails(String nonProjectId) throws Exception {
		Query query= manager.createNativeQuery(GETNONPROJECTDETAILS);
		query.setParameter("NonProjectId", nonProjectId);
		Object[] NonProjectDetails = (Object[])query.getSingleResult();
		return NonProjectDetails;
	}

	@Override   
	public List<Object[]> GetNonProjectList() throws Exception {
		Query query= manager.createNativeQuery(GETNONPROJECTLIST);
		List<Object[]> NonProjectList = (List<Object[]>)query.getResultList();
		return NonProjectList;
	}

	@Override
	public Long InsertNonProjectDetails(NonProjectMaster nonProject) throws Exception {
		manager.persist(nonProject);
		manager.flush();
		return nonProject.getNonProjectId();
	}

	@Override
	public NonProjectMaster GetNonProjectEditDetails(Long nonProjectId) throws Exception {
		NonProjectMaster NonProjectData= manager.find(NonProjectMaster.class,nonProjectId);
		return NonProjectData;
	}

	@Override
	public Long UpdateNonProjectDetails(NonProjectMaster nonProject1) throws Exception {
		manager.merge(nonProject1);
		manager.flush();
		return nonProject1.getNonProjectId();
	}

	@Override
	public int CheckDuplicateSourceShortName(String shortName) throws Exception {
		Query query = manager.createNativeQuery(CHECKDUPLICATESOURCE);
		query.setParameter("shortName", shortName);		
		Object obj = query.getSingleResult();
		Integer value = Integer.parseInt(obj.toString());
		int result = value;
		return result;
	}

	@Override
	public int CheckDuplicateNonProjectShortName(String shortName) throws Exception {
		Query query = manager.createNativeQuery(CHECKDUPLICATENONPROJECT);
		query.setParameter("shortName", shortName);		
		Object obj = query.getSingleResult();
		Integer value = Integer.parseInt(obj.toString());
		int result = value;
		return result;
	}

	@Override
	public List<Object[]> GetOtherProjectList() throws Exception {
		Query query= manager.createNativeQuery(GETOTHERPROJECTLIST);
		List<Object[]> OtherProjectList = (List<Object[]>)query.getResultList();
		return OtherProjectList;
	}

	@Override          
	public Object[] GetParticularOtherProjectDetails(String otherProjectId) throws Exception {
		Query query= manager.createNativeQuery(PARTICULAROTHERPROJECTDETAILS);
		query.setParameter("otherProjectId", otherProjectId);
		Object[] OtherProjectList = (Object[])query.getSingleResult();
		return OtherProjectList;
	}

	@Override
	public Long InsertOtherProjectDetails(OtherProjectMaster otherProject) throws Exception {
		manager.persist(otherProject);
		manager.flush();
		return otherProject.getProjectOtherId();
	}

	@Override
	public OtherProjectMaster GetOtherProjectEditDetails(Long projectOtherId) throws Exception {
		OtherProjectMaster OtherProjectData= manager.find(OtherProjectMaster.class,projectOtherId);
		return OtherProjectData;
	}

	@Override
	public Long UpdateOtherProjectDetails(OtherProjectMaster otherProject1) throws Exception {
		manager.merge(otherProject1);
		manager.flush();
		return otherProject1.getProjectOtherId();
	}

	@Override
	public int CheckDuplicateOtherProjectShortName(String shortName) throws Exception {
		Query query = manager.createNativeQuery(CHECKDUPLICATEOTHERPROJECT);
		query.setParameter("shortName", shortName);		
		Object obj = query.getSingleResult();
		Integer value = Integer.parseInt(obj.toString());
		int result = value;
		return result;
	}

	@Override    
	public List<Object[]> GetMemberTypeList() throws Exception {
		Query query= manager.createNativeQuery(GETMEMBERTYPEDETAILS);
		List<Object[]> MemberTypeList = (List<Object[]>)query.getResultList();
		return MemberTypeList;
	}

	@Override   
	public Object[] GetParticularMemberTypeDetails(String memberTypeId) throws Exception {
		Query query= manager.createNativeQuery(PARTICULARMEMBERTYPEDETAILS);
		query.setParameter("memberTypeId", memberTypeId);
		Object[] OtherProjectList = (Object[])query.getSingleResult();
		return OtherProjectList;
	}

	@Override
	public Long InsertMemberTypeDetails(MemberTypeMaster membertype) throws Exception {
		manager.persist(membertype);
		manager.flush();
		return membertype.getDakMemberTypeId();
	}

	@Override
	public MemberTypeMaster GetMemberTypeEditDetails(Long dakMemberTypeId) throws Exception {
		MemberTypeMaster MemberTypeData= manager.find(MemberTypeMaster.class,dakMemberTypeId);
		return MemberTypeData;
	}

	@Override
	public Long UpdateMemberTypeDetails(MemberTypeMaster membertype1) throws Exception {
		manager.merge(membertype1);
		manager.flush();
		return membertype1.getDakMemberTypeId();
	}

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
	

}
