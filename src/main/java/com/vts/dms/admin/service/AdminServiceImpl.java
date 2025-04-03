package com.vts.dms.admin.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.dms.DateTimeFormatUtil;
import com.vts.dms.admin.dao.AdminDao;
import com.vts.dms.admin.dto.UserManageAdd;
import com.vts.dms.admin.model.FormRole;
import com.vts.dms.admin.model.FormRoleAccess;
import com.vts.dms.admin.model.dakFeedbackAttach;
import com.vts.dms.cfg.ReversibleEncryptionAlg;
import com.vts.dms.login.Login;
import com.vts.dms.login.RoleRepository;
import com.vts.dms.admin.model.DakHandingOver;
import com.vts.dms.admin.model.DmsStatistics;
import com.vts.dms.admin.model.Feedback;
@Service
public class AdminServiceImpl implements AdminService {
	private static final Logger logger=LogManager.getLogger(AdminServiceImpl.class);
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Autowired
	AdminDao dao;
	@Autowired
	RoleRepository roleRepository;
	
	
	@Autowired
    private Environment env;
	
	private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	
	@Autowired
	ReversibleEncryptionAlg rea;
	//new change
	
	@Override
	public List<Object[]> RoleList() throws Exception {

		return dao.RoleList();
	}

	@Override
	public long RoleInsert(String role, String username) throws Exception {
		String PreFix = "";
		if(role!=null) {
			PreFix=role.trim();
		}
		
		int count = dao.RolePresentCount(PreFix);
		if (count == 0) {
			FormRole roleObj = new FormRole();
			roleObj.setFormRoleName(PreFix);
			roleObj.setIsActive(1);
			roleObj.setCreatedBy(username);
			roleObj.setCreatedDate(sdf1.format(new Date()));
			return dao.RoleInsert(roleObj);
		} else {
			return -1;
		}

	}

	public List<Object[]> getFormDetails() throws Exception {
		List<Object[]> list = dao.getFormDetails();
		return list;
	}
	
	public List<Object[]> getModuleDetails() throws Exception{
		List<Object[]> moduleList=dao.getModuleDetails();
		return moduleList;
	}

	public List<Object[]> getFormNameAsperModule(long formmoduleId) throws Exception{
		List<Object[]> list=dao.getFormNameAsperModule(formmoduleId);
		return list;
	}

	public long addRoleFormAccess(long roleId, String[] formDetailId,String createdBy) {
		long status=0;
		Date date=new Date();
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(int i=0;i<formDetailId.length;i++) {
			FormRoleAccess formRole=new FormRoleAccess();
			formRole.setFormRoleId(roleId);
			formRole.setFormDetailId(Long.parseLong(formDetailId[i]));
			formRole.setIsActive(1);
			formRole.setCreatedBy(createdBy);
			formRole.setCreatedDate(format.format(date));
			status=dao.addRoleFormAccess(formRole);
		}
		return status;
	}
	
	public List<Object[]> getAccessedFormsDetails(long formRoleId,long formModuleId) throws Exception{
		List<Object[]> list=dao.getAccessedFormsDetails(formRoleId, formModuleId);
		return list;
	}
	
	public List<Object[]> getNotAccessedFormsDetails(long FormRoleId, long FormModuleId) throws Exception{
		List<Object[]> list=dao.getNotAccessedFormsDetails(FormRoleId, FormModuleId);
		return list;
	}
	
	
	
	
	public int deleteFormRoleAccess(String[] roleFormAccessId) throws Exception {
		int status=0;
		for(int i=0;i<roleFormAccessId.length;i++) {
			status=dao.deleteFormRoleAccess(Long.parseLong(roleFormAccessId[i]));
		}
		return status;
	}
	
	public List<Object[]> fetchRoleAsperRoleId(long formRoleId) throws Exception{
		List<Object[]> list=dao.fetchRoleAsperRoleId(formRoleId);
		return list;
	}
	
	public int formRoleNameEdir(long formRoleId,String formRoleName) throws Exception{
		int status=dao.formRoleNameEdir(formRoleId, formRoleName);
		return status;
	}

//old change
	
	@Override
	public List<Object[]> UserManagerList() throws Exception {
		return dao.UserManagerList();
	}


	@Override
	public List<Object[]> DivisionList() throws Exception {
		return dao.DivisionList();
	}

	@Override
	public Object[] EmployeeData(String empid ) throws Exception {
		return dao.EmployeeData(empid);
	}

	@Override
	public Long UserManagerInsert(UserManageAdd UserManageAdd, String Userid) throws Exception {
	
		logger.info(new Date() +"Inside SERVICE UserManagerInsert ");
		if(dao.UserNamePresentCount(UserManageAdd.getUserName())==0) {
		Login login=new Login();
		login.setUsername(UserManageAdd.getUserName());
		login.setPassword("$2y$12$QTTMcjGKiCVKNvNa242tVu8SPi0SytTAMpT3XRscxNXHHu1nY4Kui");
		login.setPfms("Y");
		login.setDivisionId(Long.parseLong(UserManageAdd.getDivision()));
		login.setFormRoleId(Long.parseLong(UserManageAdd.getRole()));
		login.setCreatedBy(Userid);
		login.setCreatedDate(sdf1.format(new Date()));
		login.setIsActive(1);
		login.setLoginType(UserManageAdd.getLoginType());
		login.setLoginTypeDms(UserManageAdd.getLoginTypeDms());
		if(UserManageAdd.getEmployee()!=null) {
		login.setEmpId(Long.parseLong(UserManageAdd.getEmployee()));
		}else {	
		login.setEmpId(Long.parseLong("0"));
		}
		return dao.UserManagerInsert(login) ;
		}else {
			throw new Exception();
		}
	}


	@Override
	public Login UserManagerEditData(String LoginId) throws Exception {
		return dao.UserManagerEditData(Long.parseLong(LoginId));
	}


	@Override
	public int UserNamePresentCount(String UserName) throws Exception {
		return dao.UserNamePresentCount(UserName);
	}


	@Override
	public int UserManagerUpdate(UserManageAdd UserManageEdit,String Userid) throws Exception {
		Login login=new Login();
		login.setLoginId(Long.parseLong(UserManageEdit.getLoginId()));
		login.setFormRoleId(Long.parseLong(UserManageEdit.getRole()));
		login.setLoginTypeDms(UserManageEdit.getLoginTypeDms());
		if(UserManageEdit.getEmployee()!=null) {
		login.setEmpId(Long.parseLong(UserManageEdit.getEmployee()));
		}else {
			login.setEmpId(Long.parseLong("0"));
		}
		login.setModifiedBy(Userid);
		login.setModifiedDate(sdf1.format(new Date()));
		return dao.UserManagerUpdate(login);
	}


	@Override
	public int UserManagerDelete(String LoginId, String Userid) throws Exception {
      Login login=new Login();
		login.setLoginId(Long.parseLong(LoginId));
		login.setModifiedBy(Userid);
		login.setModifiedDate(sdf1.format(new Date()));
		return dao.UserManagerDelete(login);
	}


	@Override
	public List<Object[]> EmployeeList(String lab) throws Exception {
		return dao.EmployeeList(lab);
	}


	@Override
	public List<Object[]> LoginTypeList() throws Exception {
		return dao.LoginTypeList();
	}


	@Override
	public int PasswordChange(String OldPassword, String NewPassword, String UserId) throws Exception {
		String actualoldpassword=dao.OldPassword(UserId);
		if(encoder.matches(OldPassword, actualoldpassword)) {
		String oldpassword=encoder.encode(OldPassword);
		String newpassword=encoder.encode(NewPassword);
		return dao.PasswordChange(oldpassword, newpassword, UserId, sdf1.format(new Date()));
	}else {
		return 0;
	}
	}

	@Override
	public int PasswordReset(String LoginId, String ModifiedBy) throws Exception {
		Long loginid=Long.parseLong(LoginId);
		Long modifiedby=Long.parseLong(ModifiedBy);
		return dao.PasswordReset("$2y$12$TMjBUcqvXfaeAAnBNSCfh.vOsLhDlWUqdrr.OyDDMSETA5x6Ze6Pi", loginid, modifiedby, sdf1.format(new Date()));
	}


	@Override
	public Object getlabcode(long empId) throws Exception {
		return dao.getlabcode(empId);
	}
	
	@Override
	public List<Object[]> AuditStampingList(String Username,String Fromdateparam,String Todateparam)  throws Exception {
		 LocalDate Fromdate = null;
		 LocalDate Todate = null;
		 if(Fromdateparam == null || Todateparam == null) 
		 { 
			 Todate = LocalDate.now();
			 Fromdate= Todate.minusMonths(1); 
		 }else { 
		 DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-MM-yyyy");
		 Fromdate = LocalDate.parse(Fromdateparam,formatter);
		 Todate = LocalDate.parse(Todateparam,formatter);
		 
		 }
		return dao.AuditStampingList(Username,Fromdate,Todate);
	}
	

	@Override
	public List<Object[]> UsernameList() throws Exception {
		return dao.UsernameList();
	}

	@Override
	public Long FeedbackInsert(Feedback feedback,MultipartFile FileAttach , String LabCode) throws Exception {
	
		logger.info(new Date() +" Inside SERVICE FeedbackInsert ");
		Long feedbackid = dao.FeedbackInsert(feedback);
		if(!FileAttach.isEmpty()) {
			Timestamp instant= Timestamp.from(Instant.now());
			String timestampstr = instant.toString().replace(" ","").replace(":", "").replace("-", "").replace(".","");
			String Path = Paths.get(LabCode, "Feedback").toString();
			String FullPath = env.getProperty("file_upload_path") +File.separator+ Path;
			dakFeedbackAttach attach = new dakFeedbackAttach();
			attach.setFeedbackId(feedbackid);
			attach.setPath(Path);
			attach.setCreatedBy(feedback.getCreatedBy());
			attach.setCreatedDate(feedback.getCreatedDate());
			attach.setIsActive(1);
			attach.setFileName("Feedback"+timestampstr+"."+FilenameUtils.getExtension(FileAttach.getOriginalFilename()));
			dao.FeedbackAttachInsert(attach);
			saveFile(FullPath, attach.getFileName(), FileAttach);
		}
		return feedbackid;
	}

	 public static void saveFile(String uploadpath, String fileName, MultipartFile multipartFile) throws IOException 
	    {
	    	logger.info(new Date() +"Inside SERVICE saveFile ");
	        Path uploadPath = Paths.get(uploadpath);
	          
	        if (!Files.exists(uploadPath)) {
	            Files.createDirectories(uploadPath);
	        }
	        try (InputStream inputStream = multipartFile.getInputStream()) {
	            Path filePath = uploadPath.resolve(fileName);
	            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	        } catch (IOException ioe) {       
	            throw new IOException("Could not save image file: " + fileName, ioe);
	        }     
	    }
	 
	@Override
	public List<Object[]> FeedbackList() throws Exception {
		return dao.FeedbackList();
	}

	@Override
	public Object[] FeedbackData(String Feedbackid) throws Exception {
		return dao.FeedbackData(Feedbackid);
	}

	@Override
	public List<Object[]> getDakMembers() throws Exception {
		return dao.getDakMembers();
	}

	@Override
	public List<Object[]> StatsEmployeeList(String loginType, long divid, String lab) throws Exception {

		return dao.StatsEmployeeList(loginType,divid,lab);
	}



	@Override
	public List<Object[]> getEmployeeWiseCount(String employeeId, String fromdate,String todate) throws Exception {
		List<Object[]> getEmployeeWiseCount=null;
		getEmployeeWiseCount=dao. getEmployeeWiseCount(employeeId,fromdate, todate);
		return getEmployeeWiseCount;
	}

	@Override
	public int insertEmployeeData() throws Exception {
		List<Object[]>EmployeeList=new ArrayList<>();
		List<DmsStatistics> dmsStatistics=new ArrayList<>();
		List<Object[]>dmsStatisticsTableData=new ArrayList<>();
		dmsStatisticsTableData=dao.dmsStatisticsTableData();
		int result=0;
		String date="";
		LocalDate startDate=LocalDate.now();
		LocalDate curDate=LocalDate.now().minusDays(1);
		if(dmsStatisticsTableData.size()>0) {
			date=dmsStatisticsTableData.stream().max((arr1,arr2) ->
			{
				Date date1=(Date)arr1[1];
				Date date2=(Date)arr2[1];
				return date1.compareTo(date2);
			}).orElse(null)[1].toString();
			// here startdate shouldbe the next day after max date
			 startDate=LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE).plusDays(1);
		}else {
			date = dao.firstDateOfAudit();
			// here the startdate is the date from the date we have information
			 startDate=LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
		}
		
	
	if(!startDate.equals(curDate)) {
		for(LocalDate d = startDate;!d.isAfter(curDate);d = d.plusDays(1)) {
			EmployeeList=dao.getAllEmployeesOfDate(d.toString());
			//checking if that day has anylogin or not
			if(EmployeeList.size()>0) {
			for(Object[]obj:EmployeeList) {
				System.out.println(obj[0].toString());
				Object[]ListOfWorkCounts=dao.ListOfWorkCounts(obj[1].toString(),d.toString(),obj[0].toString());
				DmsStatistics ds= new DmsStatistics();
				ds.setEmpId(Long.parseLong(obj[0].toString()));
				ds.setUserName(obj[1].toString());
				ds.setDakCount(Long.parseLong(ListOfWorkCounts[0].toString()));
				ds.setDistributedCount(Long.parseLong(ListOfWorkCounts[1].toString()));
				ds.setAcknowledgeCount(Long.parseLong(ListOfWorkCounts[2].toString()));
				ds.setMarkedCount(Long.parseLong(ListOfWorkCounts[3].toString()));
				ds.setRepliedCount(Long.parseLong(ListOfWorkCounts[4].toString()));
				ds.setAssignedCount(Long.parseLong(ListOfWorkCounts[5].toString()));
				ds.setAssignRepliedCount(Long.parseLong(ListOfWorkCounts[6].toString()));
				ds.setSeekResponseCount(Long.parseLong(ListOfWorkCounts[7].toString()));
				ds.setSeekResponseRepliedCount(Long.parseLong(ListOfWorkCounts[8].toString()));
				ds.setLogDate(java.sql.Date.valueOf(d));
				ds.setLoginCount(Long.parseLong(obj[2].toString()));
				dmsStatistics.add(ds);
			}
			}
		}
	}
		result=dao.DataInsetrtIntoPfmsStatistics(dmsStatistics);
	return result;
	}
	
	@Override
	public List<Object[]> DakGroupingListDropDown() throws Exception {
		return dao.DakGroupingListDropDown();
	}

	@Override
	public List<Object[]> GroupEmployeeList(long grpId) throws Exception {
		return dao.GroupEmployeeList(grpId);
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
	public List<Object[]> FeedbackListForUser(String lab, String EmpId) throws Exception {
		return dao.FeedbackListForUser(lab,EmpId);
	}
	
	@Override
	public List<Object[]> GetfeedbackAttch() throws Exception {
		return dao.GetfeedbackAttch();
	}
	
	@Override
	public List<Object[]> GetfeedbackAttchForUser(String empid) throws Exception {
		return dao.GetfeedbackAttchForUser(empid);
	}
	
	@Override
	public List<Object[]> FeedbackList(String fromdate, String todate, String EmpId, String lab, String feedbacktype) throws Exception {
		String FromDate = new DateTimeFormatUtil().RegularToSqlDate(fromdate);
		String ToDate = new DateTimeFormatUtil().RegularToSqlDate(todate);
		return dao.FeedbackList(FromDate,ToDate,EmpId ,lab,feedbacktype);
	}

	@Override
	public dakFeedbackAttach FeedbackAttachmentDownload(String achmentid) throws Exception {
		return dao.FeedbackAttachmentDownload(achmentid);
	}
	
	@Override
	public Object[] FeedbackContent(String feedbackid) throws Exception {
		return dao.FeedbackContent(feedbackid);
	}
	
	@Override
	public int CloseFeedback(String feedbackid, String remarks, String username) throws Exception {
		return dao.CloseFeedback(feedbackid , remarks,username);
	}
	
	@Override
	public List<Object[]> GetHandingOverOfficers() throws Exception {
		return dao.GetHandingOverOfficers();
	}
	
	@Override
	public List<Object[]> GetHandingOverToOfficers(String handingOfficer) throws Exception {
		return dao.GetHandingOverToOfficers(handingOfficer);
	}
	
	@Override
	public Long insertHandingOver(DakHandingOver model) throws Exception {
		long value=0;
		if(model.getActionValue()!=null && !model.getActionValue().equalsIgnoreCase("")) {
			DakHandingOver modelupdate=dao.getEditHandingOfficerData(model.getHandingOverId());

			long fromAndtoDateCountEdit=dao.fromAndtoDateCountEdit(model.getFromDate().toString(),model.getToDate().toString(),model.getHandingOverId());
			System.out.println("fromAndtoDateCountEdit:"+fromAndtoDateCountEdit);
			if(fromAndtoDateCountEdit>0) {
				long FromEmployeeCountEdit=dao.FromEmployeeCountEdit(model.getFromEmpId(),model.getHandingOverId(),model.getFromDate().toString(),model.getToDate().toString());
				System.out.println("model.getFromEmpId():"+model.getFromEmpId());
				System.out.println("model.getHandingOverId():"+model.getHandingOverId());
				System.out.println("FromEmployeeCountEdit:"+FromEmployeeCountEdit);
				if(FromEmployeeCountEdit>0) {
					System.out.println("not editing");
					value=-1;
				}else {
					System.out.println("Editing with no employee count");
					modelupdate.setFromEmpId(model.getFromEmpId());
					modelupdate.setToEmpId(model.getToEmpId());
					modelupdate.setFromDate(model.getFromDate());
					modelupdate.setToDate(model.getToDate());
					modelupdate.setModifiedBy(model.getModifiedBy());
					modelupdate.setModifiedDate(model.getModifiedDate());
					value=dao.updateHandingOver(modelupdate);
				}
			}else {
					System.out.println("editing with no fromdate count");
					modelupdate.setFromEmpId(model.getFromEmpId());
					modelupdate.setToEmpId(model.getToEmpId());
					modelupdate.setFromDate(model.getFromDate());
					modelupdate.setToDate(model.getToDate());
					modelupdate.setModifiedBy(model.getModifiedBy());
					modelupdate.setModifiedDate(model.getModifiedDate());
					value=dao.updateHandingOver(modelupdate);
			}
		}else {
			System.out.println("coming inside the insert");
		long fromAndtoDateCount=dao.fromAndtoDateCount(model.getFromDate().toString(),model.getToDate().toString());
		System.out.println("fromAndtoDateCount:"+fromAndtoDateCount);
		if(fromAndtoDateCount>0) {
			long FromEmployeeCount=dao.FromEmployeeCount(model.getFromEmpId(),model.getFromDate().toString(),model.getToDate().toString());
			System.out.println("FromEmployeeCount:"+FromEmployeeCount);
			if(FromEmployeeCount>0) {
				value=-1;
			}else {
				value=dao.insertHandingOver(model);
			}
		}else {
			value=dao.insertHandingOver(model);
		}
		}
		System.out.println("value:"+value);
		return value;
	}
	
	@Override
	public List<Object[]> HandingOverList(String fromDate, String toDate) throws Exception {
		return dao.HandingOverList(fromDate,toDate);
	}
	
	@Override
	public DakHandingOver getEditHandingOfficerData(Long handingOverId) throws Exception {
		return dao.getEditHandingOfficerData(handingOverId);
	}
	
	@Override
	public long updatehandingoverRevoke(long handingOverId) throws Exception {
		return dao.updatehandingoverRevoke(handingOverId);
	}
}
