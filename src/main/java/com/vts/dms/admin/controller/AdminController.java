package com.vts.dms.admin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.dms.DateTimeFormatUtil;
import com.vts.dms.admin.dto.UserManageAdd;
import com.vts.dms.admin.service.AdminService;
import com.vts.dms.dak.service.DakService;
import com.vts.dms.admin.model.DakHandingOver;
import com.vts.dms.admin.model.Feedback;
import com.vts.dms.admin.model.dakFeedbackAttach;
@Controller
public class AdminController {
	private static final Logger logger=LogManager.getLogger(AdminController.class);
	
	
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
	private SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");

	@Autowired
	AdminService service;
	
	@Autowired
	DakService dakservice;
	
	@Autowired
    private Environment env;

	
	
	
	@RequestMapping(value = "FormRole.htm", method = RequestMethod.GET)
	public String RoleList(HttpServletRequest req) throws Exception {

		req.setAttribute("RoleList", service.RoleList());

		return "admin/RoleList";

	}
	

	@RequestMapping(value = "FormRoleAdd.htm")
	public String FormRoleAddEdit(HttpServletRequest req, RedirectAttributes redir) throws Exception {

		String Option = req.getParameter("sub");
		String role = req.getParameter("roleId");
		String roleId = "0";
		String roleName = null;
		if (role != null) {
			String[] roleArr = role.split("--");
			roleId = roleArr[0];
			roleName = roleArr[1];
		}

		if (Option.equalsIgnoreCase("add")) {
			
			return "admin/RoleAdd";
			
		} else if (Option.equalsIgnoreCase("edit")) {
			List<Object[]> roleDetails=service.fetchRoleAsperRoleId(Long.parseLong(roleId));
			req.setAttribute("roleDetails", roleDetails);
			return "admin/RoleEdit";
		} else if (Option.equalsIgnoreCase("roleaccess")) {
			List<Object[]> moduleList = service.getModuleDetails();
			List<Object[]> acccessedFormList = service.getAccessedFormsDetails(Long.parseLong(roleId), 0);
			List<Object[]> notacccessedFormList = service.getNotAccessedFormsDetails(Long.parseLong(roleId), 0);
			req.setAttribute("acccessedFormList", acccessedFormList);
			req.setAttribute("moduleList", moduleList);
			req.setAttribute("notacccessedFormList", notacccessedFormList);
			req.setAttribute("roleId", roleId);
			req.setAttribute("roleName", roleName);
			
			return "admin/FormRoleAccessEdit";
		} else {
			return "redirect:/FormRole.htm";
		}

	}

	@RequestMapping(value = "FormRoleAddSubmit.htm", method = RequestMethod.POST)
	public String FormRoleAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		
		String RoleName = req.getParameter("RoleName");
		String username = (String) ses.getAttribute("Username");
		long roleId = service.RoleInsert(RoleName, username);
		if (roleId == 0) {
			redir.addAttribute("resultfail", "Role  Add Unsuccessfull");
			return "redirect:/FormRole.htm";

		} else if (roleId == -1) {
			req.setAttribute("roleName", RoleName);
			req.setAttribute("msg", "AE");
			return "admin/RoleAdd";
		} else {

			List<Object[]> moduleList = service.getModuleDetails();
			List<Object[]> acccessedFormList = service.getAccessedFormsDetails(roleId, 0);
			List<Object[]> notacccessedFormList = service.getNotAccessedFormsDetails(roleId, 0);
			req.setAttribute("acccessedFormList", acccessedFormList);
			req.setAttribute("moduleList", moduleList);
			req.setAttribute("notacccessedFormList", notacccessedFormList);
			req.setAttribute("roleId", String.valueOf(roleId));
			req.setAttribute("roleName", RoleName);
			return "admin/FormRoleAccessEdit";

		}
	}

	@RequestMapping(value = "FormDetail.htm", method = RequestMethod.GET)
	public String formDetails(HttpServletRequest request) throws Exception {
		List<Object[]> formDetails = service.getFormDetails();
		request.setAttribute("formDetails", formDetails);

		return "admin/FormDetailsList";
	}

	@RequestMapping(value = "FormRoleAccessAdd.htm", method = RequestMethod.POST)
	public String formRoleAccessAdd(HttpServletRequest request, HttpSession session, RedirectAttributes redir) throws Exception {
		
		String[] formdetailId = request.getParameterValues("formdetailId");
		String roleId = request.getParameter("roleId");
		String roleName = request.getParameter("roleName");
		String username = (String) session.getAttribute("Username");
		String moduleId = request.getParameter("moduleId");
		String moduleName = request.getParameter("moduleName");
		long status = service.addRoleFormAccess(Long.parseLong(roleId), formdetailId, username);

		List<Object[]> moduleList = service.getModuleDetails();
		request.setAttribute("moduleList", moduleList);
		String message="";
		if (status != 0) {
			message="S";
		} else {
			message="F";
		}
		return "redirect:/FormRoleAccessPage.htm?roleName=" + roleName + "&roleId=" + roleId + "&moduleId="
		+ moduleId+"&moduleName="+moduleName+"&message="+message;

	}

	

	@RequestMapping(value = "FormRoleAccessPage.htm", method = RequestMethod.GET)
	public String FormRoleAccessPage(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		try {
		String roleName = req.getParameter("roleName");
		String roleId = req.getParameter("roleId");
		String moduleId = req.getParameter("moduleId");
		String moduleName = req.getParameter("moduleName");
		String message=req.getParameter("message");
		
		List<Object[]> moduleList = service.getModuleDetails();
		List<Object[]> acccessedFormList = service.getAccessedFormsDetails(Long.parseLong(roleId), Long.parseLong(moduleId));
		List<Object[]> notacccessedFormList = service.getNotAccessedFormsDetails(Long.parseLong(roleId), Long.parseLong(moduleId));
		req.setAttribute("acccessedFormList", acccessedFormList);
		req.setAttribute("moduleList", moduleList);
		req.setAttribute("notacccessedFormList", notacccessedFormList);
		req.setAttribute("roleId", String.valueOf(roleId));
		req.setAttribute("roleName", roleName);
		req.setAttribute("moduleidSel", moduleId);
		req.setAttribute("moduleName", moduleName);
		req.setAttribute("message", message);
		
		return "admin/FormRoleAccessEdit";
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping(value = "FormRoleAccessEditSelected.htm")
	public String FormRoleAccessEditSelected(HttpServletRequest request, HttpSession session) throws Exception {
		
	   try {
		String roleId = request.getParameter("roleid");
		String roleName = request.getParameter("roleName");
		String module = request.getParameter("module");
		String moduleId = null;
		String moduleName = null;
		if (module != null) {
			String[] arr = module.split("--");
			moduleId = arr[0];
			moduleName = arr[1];
		} else {
			moduleId = "0";
			moduleName = "";
		}

		List<Object[]> moduleList = service.getModuleDetails();
		List<Object[]> acccessedFormList = service.getAccessedFormsDetails(Long.parseLong(roleId),
				Long.parseLong(moduleId));
		List<Object[]> notacccessedFormList = service.getNotAccessedFormsDetails(Long.parseLong(roleId),
				Long.parseLong(moduleId));
		request.setAttribute("acccessedFormList", acccessedFormList);
		request.setAttribute("moduleList", moduleList);
		request.setAttribute("notacccessedFormList", notacccessedFormList);
		request.setAttribute("roleId", roleId);
		request.setAttribute("roleName", roleName);
		request.setAttribute("moduleName", moduleName);
		request.setAttribute("moduleidSel", moduleId);

		return "admin/FormRoleAccessEdit";
	   }catch(Exception e) {
		   e.printStackTrace();
		   return null;
	   }

	}

	@RequestMapping(value = "FormRoleAccessDelete.htm", method = RequestMethod.POST)
	public String formRoleAccessDelete(HttpServletRequest request, HttpSession session, RedirectAttributes redir) throws Exception {
		try {
		String[] roleFormAccessId = request.getParameterValues("roleFormAccessId");
		String roleId = request.getParameter("roleId");
		String roleName = request.getParameter("roleName");
		String moduleId = request.getParameter("moduleId");
		String moduleName= request.getParameter("moduleName");
		long status = service.deleteFormRoleAccess(roleFormAccessId);

		List<Object[]> moduleList = service.getModuleDetails();
		request.setAttribute("moduleList", moduleList);
		String message = "";
		if (status != 0) {
			message = "S";
		} else {
			message = "F";
		}
		return "redirect:/FormRoleAccessPage.htm?roleName=" + roleName + "&roleId=" + roleId + "&moduleId=" + moduleId
				+ "&message=" + message+"&moduleName="+moduleName;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	
	@RequestMapping(value = "FormRoleAddEdit.htm", method = RequestMethod.POST)
	public String formRoleEdit(HttpServletRequest request, HttpSession session, RedirectAttributes redir) throws Exception {
		try {
		String formroleName=request.getParameter("formroleName");
		String formroleId=request.getParameter("formroleId");
		int status=service.formRoleNameEdir(Long.parseLong(formroleId), formroleName);
		String result=null;
		if(status>0) {
			result="S";
			redir.addAttribute("msg",result);
			return "redirect:/FormRole.htm";
		}else {
			result="F";
			return "admin/RoleEdit";
		}
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	

	@RequestMapping(value = "PasswordReset.htm", method = RequestMethod.GET)
	public String PasswordReset(HttpServletRequest req, HttpSession ses) throws Exception {

		req.setAttribute("UserManagerList", service.UserManagerList());
		return "admin/PasswordResetList";
	}
	
	@RequestMapping(value = "PasswordReset.htm", method = RequestMethod.POST)
	public String PasswordResetSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		req.setAttribute("UserManagerList", service.UserManagerList());
		try {
		String ModifiedBy = ((Long) ses.getAttribute("LoginId")).toString();
		String LoginId =req.getParameter("Lid");
		int count=service.PasswordReset(LoginId, ModifiedBy);
		if (count > 0) {
			redir.addAttribute("result", "Password Reseted Successfully");
		} else {
			redir.addAttribute("resultfail", "Password Change unuccessfull");
		}

		
		return "redirect:/PasswordReset.htm";
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	
	@RequestMapping(value = "PasswordChange.htm", method = RequestMethod.GET)
	public String PasswordChange(HttpServletRequest req, HttpSession ses) throws Exception {

		
		return "admin/PasswordChange";
	}
	
	
	@RequestMapping(value = "PasswordChange.htm", method = RequestMethod.POST)
	public String PasswordChangeSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		String Username = (String) ses.getAttribute("Username");
		try {
		String NewPassword =req.getParameter("NewPassword");
		String OldPassword =req.getParameter("OldPassword");
		int count=service.PasswordChange(OldPassword, NewPassword, Username);
		if (count > 0) {
			redir.addAttribute("result", "Password Changed Successfully");
			
		} else {
			redir.addAttribute("resultfail", "Password Change Unsuccessful");
			
		}

		return "redirect:/PasswordChange.htm";
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	
	@RequestMapping(value = "FeedBack.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String FeedBack(HttpServletRequest req, HttpSession ses) throws Exception {
		String Userid= (String) ses.getAttribute("Username");
		long EmpId=(Long)ses.getAttribute("EmpId");
		String logintype=(String)ses.getAttribute("LoginTypeDms");
		logger.info(new Date() +" Inside FeedBack.htm "+Userid);
		String LabCode = (String) ses.getAttribute("LabCode");
		req.setAttribute("fromdate", new DateTimeFormatUtil().SqlToRegularDate( LocalDate.now().minusMonths(1).toString()));
		req.setAttribute("todate",new DateTimeFormatUtil().SqlToRegularDate( LocalDate.now().toString()));
		if(logintype!=null && logintype.equalsIgnoreCase("A")) {
			List<Object[]> list = service.FeedbackListForUser(LabCode,"A");
			List<Object[]> Attch = service.GetfeedbackAttch(); 
			if(list!=null && list.size()>0) {
				req.setAttribute("FeedbackList", list);
				req.setAttribute("Attchment", Attch);
				req.setAttribute("feedbacktype", "A");
				return "admin/FeedbackList";
			}else {
				req.setAttribute("FeedbackList", list);
				return "admin/FeedBack";
			}
		}else {
			String empid =  String.valueOf((Long) ses.getAttribute("EmpId"));
			List<Object[]> list = service.FeedbackListForUser(LabCode , empid);
		    List<Object[]> Attch = service.GetfeedbackAttchForUser( empid); 
			if(list!=null && list.size()>0) {
				req.setAttribute("FeedbackList", list);
				req.setAttribute("Attchment", Attch);
				req.setAttribute("feedbacktype", "A");
				return "admin/FeedbackList";
			}else {
				req.setAttribute("FeedbackList", list);
				return "admin/FeedBack";
			}
		}
	}
	
	@RequestMapping(value = "FeedbackAttachDownload.htm", method = RequestMethod.GET)
	 public void FeedbackAttachDownload(HttpServletRequest	 req, HttpSession ses, HttpServletResponse res) throws Exception 
	 {	 
		 String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside FeedbackAttachDownload.htm "+UserId);		
			try { 
		 
					res.setContentType("Application/octet-stream");	
					System.out.println(req.getParameter("attachid"));
					dakFeedbackAttach attach=service.FeedbackAttachmentDownload(req.getParameter("attachid"));
					
					File my_file=null;
				
					String feedbackattachdata = attach.getPath().toString().replaceAll("[/\\\\]", ",");
	        		String[] fileParts = feedbackattachdata.split(",");
			        my_file = new File(env.getProperty("file_upload_path")+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+attach.getFileName());
			        res.setHeader("Content-disposition","attachment; filename="+attach.getFileName().toString()); 
			        OutputStream out = res.getOutputStream();
			        FileInputStream in = new FileInputStream(my_file);
			        byte[] buffer = new byte[4096];
			        int length;
			        while ((length = in.read(buffer)) > 0){
			           out.write(buffer, 0, length);
			        }
			        in.close();
			        out.flush();
			        out.close();

			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside FeedbackAttachDownload.htm "+UserId, e);
			}
	 }
	
	
	@RequestMapping(value = "FeedBackPage.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String FeedBackpage(HttpServletRequest req, HttpSession ses) throws Exception {
		String Userid= (String) ses.getAttribute("Username");
		long EmpId=(Long)ses.getAttribute("EmpId");
		String logintype=(String)ses.getAttribute("LoginTypeDms");
		logger.info(new Date() +" Inside FeedBackPage.htm "+Userid);
		String LabCode = (String) ses.getAttribute("LabCode");
		if(logintype!=null && logintype.equalsIgnoreCase("A")) {
			List<Object[]> list = service.FeedbackListForUser(LabCode,"A");
			req.setAttribute("FeedbackList", list);
		}else {
			String empid =  String.valueOf((Long) ses.getAttribute("EmpId"));
			List<Object[]> list = service.FeedbackListForUser(LabCode , empid);
			req.setAttribute("FeedbackList", list);
		}
		return "admin/FeedBack";
		
	}
	
	@RequestMapping(value = "FeedBackAdd.htm", method = {RequestMethod.GET, RequestMethod.POST})
	public String FeedBackAdd(Model model,HttpServletRequest req, HttpSession ses,RedirectAttributes redir,@RequestPart("FileAttach") MultipartFile FileAttach) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		Long EmpId = (Long) ses.getAttribute("EmpId");
	    try {
	    String LabCode = (String) ses.getAttribute("LabCode");
		String Feedback=req.getParameter("Feedback");
		String feedbacktype=req.getParameter("feedbacktype");	
		if(!FileAttach.isEmpty()){
			
		}
		if(Feedback ==null || Feedback.trim().equalsIgnoreCase("")) {			
			redir.addAttribute("resultfail", "Feedback Field is Empty, Please Enter Feedback");
			return "redirect:/FeedBack.htm";
		}
		if(feedbacktype==null) {
			redir.addAttribute("resultfail", "Please Select the FeedbackType");
			return "redirect:/FeedBack.htm";
		}
		Feedback feedback=new Feedback();
	    feedback.setEmpId(EmpId);
	    feedback.setStatus("O");
	    feedback.setFeedbackType(feedbacktype);
	    feedback.setFeedback(Feedback);
	    feedback.setCreatedBy(UserId);
	    feedback.setCreatedDate(sdf1.format(new Date()));
	    feedback.setIsActive(1);
		Long Feedbackid=service.FeedbackInsert(feedback, FileAttach, LabCode);
		if (Feedbackid>0) {
			redir.addAttribute("result", " Feedback Added Successful");
		} else {
			redir.addAttribute("resultfail", "Feedback Add UnSuccessful");
		}
	    }catch (Exception e) {
	    	e.printStackTrace();
	    	return null;
	    }
	    return "redirect:/FeedBack.htm";
	}
	
	
	@RequestMapping(value = "FeedbackList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
	public String FeedbackList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside FeedbackList.htm "+UserId);
	
		try {
			String empid =  String.valueOf((Long) ses.getAttribute("EmpId"));
			String logintype=(String)ses.getAttribute("LoginTypeDms");
			String LabCode = (String) ses.getAttribute("LabCode");
			String fromdate = req.getParameter("Fromdate");
			String todate = req.getParameter("Todate");
			String feedbacktype = req.getParameter("feedbacktype");
			if(feedbacktype==null) {
				feedbacktype="A";
			}
			if(logintype!=null && logintype.equalsIgnoreCase("A")) {
				List<Object[]> Attch = service.GetfeedbackAttch(); 
				req.setAttribute("FeedbackList", service.FeedbackList(fromdate,todate,"A" ,LabCode,feedbacktype));
				req.setAttribute("Attchment", Attch);
			}else {
				List<Object[]> Attch = service.GetfeedbackAttchForUser( empid); 
				req.setAttribute("FeedbackList", service.FeedbackList(fromdate,todate,empid,LabCode,feedbacktype));
				req.setAttribute("Attchment", Attch);
			}
			req.setAttribute("fromdate", fromdate);
			req.setAttribute("todate", todate);
			req.setAttribute("feedbacktype", feedbacktype);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside FeedbackList.htm "+UserId,e);
		}
		return "admin/FeedbackList";
	}
	
	 @RequestMapping(value = "FeedbackContent.htm", method = RequestMethod.GET)
	  public @ResponseBody String FeedbackContent(HttpSession ses, HttpServletRequest req) throws Exception 
	  {
		String UserId=(String)ses.getAttribute("Username");
		Object[] arr = null;
		logger.info(new Date() +"Inside FeedbackContent.htm "+UserId);
		try
		{	  
			String feedbackid=req.getParameter("feedbackid");					
			arr= service.FeedbackContent(feedbackid);
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside FeedbackContent.htm "+UserId,e);
		}
		  Gson json = new Gson();
		  return json.toJson(arr); 
		  
	}
	 
	 @RequestMapping( value = "CloseFeedBack.htm" , method = RequestMethod.POST)
	 public String CloseFeedback(HttpSession ses, HttpServletRequest req ,RedirectAttributes redir)throws Exception
	 {
		 String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside CloseFeedBack.htm "+UserId);
		 try {
			String feedbackid = req.getParameter("feedbackid");
			 String remarks = req.getParameter("Remarks");
			 int count = service.CloseFeedback(feedbackid , remarks,UserId);
			 if(count > 0) {
					redir.addAttribute("result" , "Feedback Closed Successfully ");
				}else {
					redir.addAttribute("resultfail", "Feedback Close Unsuccessful");
				}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside CloseFeedBack.htm "+UserId,e);
		}
		 return "redirect:/FeedBack.htm";
	 }
	 
	
	@RequestMapping(value = "FeedBackData.htm")
	public String FeedBackData(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String feedbackid=req.getParameter("feedbackid");	
		req.setAttribute("FeedbackData", service.FeedbackData(feedbackid));
		return "admin/FeedbackData";
	}

	
	@RequestMapping(value = "AuditStampingView.htm")
	public String AuditStampingList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		try {
		String Usernameparam=req.getParameter("username");
		String Fromdate=req.getParameter("Fromdate");
		String Todate=req.getParameter("Todate");
		req.setAttribute("usernamelist", service.UsernameList());
	
		if(Usernameparam == null) {
			String Username = (String) ses.getAttribute("Username");
			req.setAttribute("auditstampinglist", service.AuditStampingList(Username,Fromdate, Todate));
			req.setAttribute("Fromdate", LocalDate.now().minusMonths(1).format(DateTimeFormatter.ofPattern("dd-MM-yyyy")));
			req.setAttribute("Todate", LocalDate.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy")));
		}
		
		else {
		req.setAttribute("auditstampinglist", service.AuditStampingList(Usernameparam,Fromdate, Todate));
		req.setAttribute("Username", Usernameparam);
		req.setAttribute("Fromdate", Fromdate);
		req.setAttribute("Todate", Todate);
		}
		
		return "admin/AuditStampingList";
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	@RequestMapping(value = "UserManagerList.htm", method = RequestMethod.GET)
	public String UserManagerList(Model model, HttpServletRequest req, HttpSession ses) throws Exception {
	    logger.info(new Date() + "UserManagerList.htm" + req.getUserPrincipal().getName());
	    long EmpId = (Long) ses.getAttribute("EmpId");
	    String LabCode = (String) ses.getAttribute("LabCode");

	    final String[] LabCodeWrapper = {null};  // Create a final wrapper array

	    try {
	        if (LabCode != null) {
	            LabCodeWrapper[0] = LabCode.toString();  // Assign value to wrapper array element
	            req.setAttribute("UserManagerList", service.UserManagerList()
		                .stream()
		                .filter(e -> LabCodeWrapper[0] != null && LabCodeWrapper[0].equalsIgnoreCase(e[8].toString()))
		                .collect(Collectors.toList()));
	        }else {
	        	 req.setAttribute("UserManagerList", service.UserManagerList());
	        }
	      

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return "admin/UserManagerList";
	}
	

	@RequestMapping(value = "UserManager.htm", method = RequestMethod.POST)
	public String UserManagerAddEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		logger.info(new Date() + "UserManager.htm" + req.getUserPrincipal().getName());
		String Userid = (String) ses.getAttribute("Username");
		try {
		String Option = req.getParameter("sub");
		String LoginId = req.getParameter("Lid");
		long EmpId=(Long)ses.getAttribute("EmpId");
		String LabCode = (String) ses.getAttribute("LabCode");
		
		
		if (Option.equalsIgnoreCase("add")) {
			req.setAttribute("DakMembers", service.getDakMembers());
			req.setAttribute("RoleList", service.RoleList());
			req.setAttribute("EmpList", service.EmployeeList(LabCode));
			req.setAttribute("LoginTypeList", service.LoginTypeList());
			return "admin/UserManagerAdd";
		} else if (Option.equalsIgnoreCase("edit")) {

			req.setAttribute("UserManagerEditData", service.UserManagerEditData(LoginId));
			req.setAttribute("DakMembers", service.getDakMembers());
			req.setAttribute("RoleList", service.RoleList());
			req.setAttribute("EmpList", service.EmployeeList(LabCode));
			req.setAttribute("LoginTypeList", service.LoginTypeList());
			return "admin/UserManagerEdit";
		} else {
			int count = service.UserManagerDelete(LoginId, Userid);
			if (count > 0) {
				redir.addAttribute("result", "User Credentials Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "User Credentials Delete Unsuccessful");
			}

			return "redirect:/UserManagerList.htm";
		}
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	
	@RequestMapping(value = "UserManagerAddSubmit.htm", method = RequestMethod.POST)
	public String UserManagerAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
      String Userid = (String) ses.getAttribute("Username");
	  logger.info(new Date() + "UserManager.htm" + req.getUserPrincipal().getName());
	  
	  try {
		UserManageAdd UserManageAdd=new UserManageAdd();
		UserManageAdd.setUserName(req.getParameter("UserName"));
		UserManageAdd.setLoginType("U");
		UserManageAdd.setLoginTypeDms(req.getParameter("LoginType"));
		UserManageAdd.setRole(req.getParameter("Role"));
		UserManageAdd.setEmployee(req.getParameter("Employee"));
		Object[] employeedata=service.EmployeeData(req.getParameter("Employee"));
		UserManageAdd.setDivision(employeedata[5].toString());
		Long count = 0L;
		try {
			count = service.UserManagerInsert(UserManageAdd, Userid);
			
		} catch (Exception e) {
			e.printStackTrace();
			redir.addAttribute("resultfail", "Something Went Wrong! OR Username Not Available");
			return "redirect:/UserManagerList.htm";
		}

		if (count > 0) {
			redir.addAttribute("result", "User Credentials created Successfully");
		} else {
			redir.addAttribute("resultfail", "User Credentials Creation Unsuccessful! Try Again!!!");
		}

		return "redirect:/UserManagerList.htm";
	  }catch (Exception e) {
		  e.printStackTrace();
		  return null;
	  }

	}


	@RequestMapping(value = "UserNamePresentCount.htm", method = RequestMethod.GET)
	public @ResponseBody String UserNamePresentCount(HttpServletRequest req) throws Exception {
		 logger.info(new Date() + "UserNamePresentCount.htm" + req.getUserPrincipal().getName());
		int UserNamePresentCount = service.UserNamePresentCount(req.getParameter("UserName"));
		Gson json = new Gson();
		return json.toJson(UserNamePresentCount);

	}
	
	@RequestMapping(value = "UserManagerEditSubmit.htm", method = RequestMethod.POST)
	public String UserManagerEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String Userid = (String) ses.getAttribute("Username");
		 logger.info(new Date() + "UserManagerEditSubmit.htm" + req.getUserPrincipal().getName());
	
	   try {
		UserManageAdd UserManageEdit=new UserManageAdd();
        UserManageEdit.setLoginId(req.getParameter("LoginId"));
		UserManageEdit.setLoginTypeDms(req.getParameter("LoginType"));
		UserManageEdit.setRole(req.getParameter("Role"));
		UserManageEdit.setEmployee(req.getParameter("Employee"));
		int count = service.UserManagerUpdate(UserManageEdit, Userid);

		if (count > 0) {
			redir.addAttribute("result", "User Credentials Updated Successfully");
		} else {
			redir.addAttribute("resultfail", "Update Unsuccessful, Try Again!!");
		}
		return "redirect:/UserManagerList.htm";
	    } catch (Exception e) {
		  e.printStackTrace();
		  redir.addAttribute("resultfail", "Some Error Occured OR Username not Available");
		  return "redirect:/UserManagerList.htm";
		}

	}
	
	

	@RequestMapping(value = "StatisticsList.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String StatisticsList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		logger.info(new Date() + "StatisticsList.htm" + req.getUserPrincipal().getName());
		try {
		String SelectedEmpId=req.getParameter("SelectedEmpId");
		String DakMemberTypeId=req.getParameter("DakMemberTypeId");
		
		List<Object[]> DakGroupingListDropDown=service.DakGroupingListDropDown();
		Object[] grplist=DakGroupingListDropDown.get(0);
		
		long GrpId=0;
		
		if(DakMemberTypeId==null) {
			GrpId=Long.parseLong(grplist[0].toString());
		}else {
			GrpId=Long.parseLong(DakMemberTypeId);
		}
		Object[] emplist=null;
		List<Object[]> groupEmployeeList=service.GroupEmployeeList(GrpId);
		if(groupEmployeeList!=null && groupEmployeeList.size()>0) {
		emplist=groupEmployeeList.get(0);
		}
		String EmployeeId=null;
		if(SelectedEmpId==null && emplist!=null) {
			EmployeeId=emplist[0].toString();
		}else {
			EmployeeId=SelectedEmpId;
		}
		String fromDate=(String)req.getParameter("FromDate");
		String toDate=(String)req.getParameter("ToDate");
		if(toDate==null) {
			toDate=LocalDate.now().toString();
		}else {
			fromDate=sdf2.format(rdf.parse(fromDate));
		}
		if(fromDate==null) {
			fromDate=LocalDate.now().minusDays(30).toString();
		}else {
			toDate=sdf2.format(rdf.parse(toDate));
		}
		List<Object[]> ds=service.getEmployeeWiseCount(EmployeeId,fromDate,toDate);
		req.setAttribute("ds", ds);
		req.setAttribute("EmployeeId", EmployeeId);
		req.setAttribute("MemberTypeId", GrpId);
		req.setAttribute("frmDt", fromDate);
		req.setAttribute("toDt",   toDate);
		req.setAttribute("DakGroupingListDropDown", DakGroupingListDropDown);
		req.setAttribute("StatsEmployeeList", groupEmployeeList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/StatisticsList";

	}
	
	
	
	
	@RequestMapping(value = "UpdatetheEmployeedata.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String UpdatetheEmployeedata(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		logger.info(new Date() + "UpdatetheEmployeedata.htm" + req.getUserPrincipal().getName());
		try {
		String SelectedEmpId=req.getParameter("SelectedEmpId");
		String fromDate=(String)req.getParameter("FromDate");
		String toDate=(String)req.getParameter("ToDate");
		int InsertEmployeeData=service.insertEmployeeData();
		redir.addAttribute("FromDate", fromDate);
		redir.addAttribute("ToDate",   toDate);
		redir.addAttribute("SelectedEmpId",   SelectedEmpId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/StatisticsList.htm";

	}
	
	
	
	@RequestMapping(value = "HandingOverList.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String HandingOverList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		logger.info(new Date()+"inside the HandingOverList()");
		try {
			String fromDate=(String)req.getParameter("FromDate");
			String toDate=(String)req.getParameter("ToDate");
			if(toDate == null) 
			{
				toDate=LocalDate.now().plusDays(30).toString();
			}else
			{
				fromDate=sdf2.format(rdf.parse(fromDate));
			}
			
			if(fromDate==null) {
				fromDate=LocalDate.now().toString();
			}else {
				toDate=sdf2.format(rdf.parse(toDate));
			}
			List<Object[]> GetHandingOverOfficers=service.GetHandingOverOfficers();
			List<Object[]> HandingOverList=service.HandingOverList(fromDate,toDate);
			req.setAttribute("GetHandingOverOfficers", GetHandingOverOfficers);
			req.setAttribute("HandingOverList", HandingOverList);
			req.setAttribute("frmDt", fromDate);
			req.setAttribute("toDt",   toDate);
		return "admin/HandingOverList";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+"Inside the HandingOverList()",e);
			return null;
		}
	}
	
	
	
	@RequestMapping(value="GetHandingOverOfficers.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public  @ResponseBody String  GetChangeRecommendingOfficer(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetHandingOverOfficers.htm"+Username);
		Gson json = new Gson();
		List<Object[]> GetHandingOverToOfficers=null;
		try {
			String handingOfficer=req.getParameter("handingOfficer");
			GetHandingOverToOfficers=service.GetHandingOverToOfficers(handingOfficer);
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetHandingOverOfficers.htm "+Username, e);
			}
		return json.toJson(GetHandingOverToOfficers);
	}
	
	
	@RequestMapping(value = "HandingOverAddSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String HandingOverAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
      String Userid = (String) ses.getAttribute("Username");
	  logger.info(new Date() + "HandingOverAddSubmit.htm" + req.getUserPrincipal().getName());
	  Long count = 0L;
	  String ActionValue=req.getParameter("ActionValue");
	  try {
		  String HandingFromDate=req.getParameter("HandingFromDate");
		  String HandingToDate=req.getParameter("HandingToDate");
		  String HandingOverOfficer=req.getParameter("HandingOverOfficer");
		  String HandingOverTo=req.getParameter("HandingOverTo");
		  String HandingOverEditId=req.getParameter("HandingOverEditId");
		
		  DakHandingOver model=new DakHandingOver();
		  model.setFromDate(new java.sql.Date(sdf.parse(HandingFromDate).getTime()));
		  model.setToDate(new java.sql.Date(sdf.parse(HandingToDate).getTime()));
		  model.setFromEmpId(Long.parseLong(HandingOverOfficer));
		  model.setToEmpId(Long.parseLong(HandingOverTo));
		  
		  if(ActionValue!=null && !ActionValue.equalsIgnoreCase("")) {
			  model.setActionValue(ActionValue);
			  model.setModifiedBy(Userid);
			  model.setModifiedDate(sdf1.format(new Date()));
		  }else {
			  model.setCreatedBy(Userid);
			  model.setCreatedDate(sdf1.format(new Date()));
			  model.setIsActive(1);
		  }
		  if(HandingOverEditId!=null && !HandingOverEditId.equalsIgnoreCase("")) {
			  model.setHandingOverId(Long.parseLong(HandingOverEditId));
		  }
		  
		  count=service.insertHandingOver(model);
		  
//		  if(HandingFromDate!=null) {
//			  redir.addAttribute("FromDate", HandingFromDate);
//		  }
//		  if(HandingToDate!=null) {
//			  redir.addAttribute("ToDate", HandingToDate);
//		  }
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	  
	  System.out.println("count:"+count);
	  if (count > 0) {
		  if(ActionValue!=null && ActionValue.equalsIgnoreCase("Edit")) {
			redir.addAttribute("result", "Handing Over Updated Successfully");
		  }else {
			  redir.addAttribute("result", "Handing Over Created Successfully");
		  }
	  } else if(count==-1){
			redir.addAttribute("resultfail", "Handing Over For Employee Already Created!!!");
	  } else {
		  if(ActionValue!=null && ActionValue.equalsIgnoreCase("Edit")) {
		    redir.addAttribute("resultfail", "Handing Over Updation Unsuccessful! Try Again!!!");
		  }else {
			  redir.addAttribute("resultfail", "Handing Over Creation Unsuccessful! Try Again!!!");
		  }
	  }
	  return "redirect:/HandingOverList.htm";
	}
	
	@RequestMapping(value="getEditHandingOfficerData.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public  @ResponseBody String  getEditHandingOfficerData(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside getEditHandingOfficerData.htm"+Username);
		Gson json = new Gson();
		DakHandingOver getEditHandingOfficerData=null;
		try {
			String handingOverId=req.getParameter("selectedId");
			System.out.println("handingOverId"+handingOverId);
			if(handingOverId!=null) {
			getEditHandingOfficerData=service.getEditHandingOfficerData(Long.parseLong(handingOverId));
			}
			System.out.println("getEditHandingOfficerData:"+getEditHandingOfficerData);
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside getEditHandingOfficerData.htm "+Username, e);
			}
		return json.toJson(getEditHandingOfficerData);
	}
	@RequestMapping(value="HandingOverRevoke.htm",method= {RequestMethod.GET})
	public  @ResponseBody String  HandingOverRevoke(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside HandingOverRevoke.htm"+Username);
		Gson json = new Gson();
		String handingOverId=req.getParameter("selectedId");
		long count=0l;
		try {
			DakHandingOver getEditHandingOfficerData =service.getEditHandingOfficerData(Long.parseLong(handingOverId));
			
			getEditHandingOfficerData.setModifiedBy(Username);
			getEditHandingOfficerData.setModifiedDate(sdf1.format(new Date()));
			getEditHandingOfficerData.setIsActive(0);
			 count=service.insertHandingOver(getEditHandingOfficerData);;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside HandingOverRevoke.htm "+Username, e);
		}
		return json.toJson(count);
	}
	
	
	
}
