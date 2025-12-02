package com.vts.dms.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gargoylesoftware.htmlunit.javascript.host.fetch.Request;
import com.google.gson.Gson;
import com.vts.dms.cfg.ReversibleEncryptionAlg;
import com.vts.dms.header.service.HeaderService;
import com.vts.dms.login.Login;
import com.vts.dms.login.LoginRepository;
import com.vts.dms.master.model.Employee;
import com.vts.dms.service.DmsService;
import com.vts.dms.model.AuditPatches;



@Controller
public class DmsController {
	private static final Logger logger=LogManager.getLogger(DmsController.class);
	
	@Autowired
	LoginRepository Repository; 
	
	@Autowired
	DmsService service;
	
	@Autowired
	ReversibleEncryptionAlg rea;
	
    @RequestMapping(value = { "/validate-user" }, method = {RequestMethod.GET,RequestMethod.POST})
    public ResponseEntity<Map<String, Object>> validate_user(HttpServletRequest req, HttpSession ses) throws Exception {
        logger.info(new Date() + " Login By " + req.getUserPrincipal().getName());
        
        Map<String, Object> response = new HashMap<>();
        try {
            Login login = Repository.findByUsername(req.getUserPrincipal().getName());
            ses.setAttribute("LoginId", login.getLoginId());
            ses.setAttribute("Username", req.getUserPrincipal().getName());
            ses.setAttribute("LoginType", login.getLoginType());
            ses.setAttribute("EmpId", login.getEmpId());
            ses.setAttribute("FormRole", login.getFormRoleId());
            ses.setAttribute("Pfms", login.getPfms());
            ses.setAttribute("LoginTypeDms",login.getLoginTypeDms());
            response.put("success", true);
            response.put("message", "User validated successfully");
            response.put("data", login); // Add more data as needed
        } catch (Exception e) {
            logger.error(new Date() + " Login Problem Occurs When Login By " + req.getUserPrincipal().getName(), e);
            response.put("success", false);
            response.put("message", "User validation failed");
        }
        return ResponseEntity.ok(response);
    }

	@Autowired
	HeaderService headerservice;
	@RequestMapping(value = { "/", "/welcome" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String welcome(Model model, HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() + " Login By " + req.getUserPrincipal().getName());
		try {
			Login login = Repository.findByUsername(req.getUserPrincipal().getName());
			
			ses.setAttribute("LoginId", login.getLoginId());
			ses.setAttribute("Username", req.getUserPrincipal().getName());
			ses.setAttribute("LoginType", login.getLoginType());
			ses.setAttribute("EmpId", login.getEmpId());
			ses.setAttribute("FormRole", login.getFormRoleId());
			ses.setAttribute("Division", login.getFormRoleId());
			ses.setAttribute("DivisionId", login.getDivisionId());
		    ses.setAttribute("Pfms", login.getPfms());
		    ses.setAttribute("LoginTypeDms",login.getLoginTypeDms());
			
			Employee employee = service.EmployeeInfo(login.getEmpId());
			ses.setAttribute("EmpNo", employee.getEmpNo());
			ses.setAttribute("EmpName", employee.getEmpName());
			ses.setAttribute("EmpDesig",service.DesignationInfo(employee.getDesigId()).getDesignation() );
			
			Object[] divisionData=service.divisionData(login.getDivisionId()); 
			System.out.println("divisionData[0]:"+divisionData[0].toString());
			System.out.println("divisionData[1]:"+divisionData[1].toString());
			ses.setAttribute("DivisionCode", divisionData[0].toString());
			ses.setAttribute("LabCode", divisionData[1].toString());
		} catch (Exception e) {
			logger.error(new Date() + " Login Problem Occures When Login By " + req.getUserPrincipal().getName(), e);
		}

		return "redirect:/MainDashBoard.htm";
	}

	@RequestMapping(value = "MainDashBoard.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MainDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() + "Inside MainDashBoard.htm ");
   		String LoginType=(String)ses.getAttribute("LoginTypeDms");
   		
   		
	      try {
	    	    long EmpId=(Long)ses.getAttribute("EmpId");
	    	    Object Labcode=service.getlabcode(EmpId);
	  			String lab=Labcode.toString();
	    	    String Username=req.getUserPrincipal().getName();
				Date date=new Date();
				String Date=(String)req.getParameter("Date");
				String fromDate=null;
				String toDate=null;
				String SourceType=req.getParameter("SourecId");
				String ProjectType=req.getParameter("ProjectType");
				String SourecTypeId=req.getParameter("SourecTypeId");
				String ProjectTypeId=req.getParameter("ProjectTypeId");
				String DakMemberTypeId=req.getParameter("DakMemberTypeId");
				String Employee=req.getParameter("Employee");
				String DeliveryTypeId=req.getParameter("DeliveryTypeId");
				String PriorityId=req.getParameter("PriorityId");
				String Source=null;
				String Project=null;
				String SelSourceType=null;
				String selProjectTypeId=null;
				String MemberTypeId=null;
				String Emp=null;
				String Delivery=null;
				String Priority=null;
				
				String redirectedvalue=req.getParameter("redirectedvalue");
				if(redirectedvalue!=null) {
					req.setAttribute("redirectedvalueForward", redirectedvalue);
                    System.out.println("redirectedValue"+redirectedvalue);
					
				}else {
					req.setAttribute("redirectedvalueForward", "MainDashBoard");
				}
				
				List<Object[]> DakGroupingListDropDown=service.DakGroupingListDropDown();
				
				List<Object[]> selProjectList=service.SelProjectTypeList(lab);
				
				if(DeliveryTypeId==null) {
					Delivery="All";
				}else {
					Delivery=DeliveryTypeId;
				}
				
				if(PriorityId==null) {
					Priority="All";
				}else {
					Priority=PriorityId;
				}
				
				if(SourceType==null) {
					Source="All";
				}else {
					Source=SourceType;
				}
				if(ProjectType==null) {
					Project="All";
				}else {
					Project=ProjectType;
				}
				
				if(SourecTypeId==null) {
					SelSourceType="All";
				}else {
					SelSourceType=SourecTypeId;
				}
				if(ProjectTypeId==null) {
					selProjectTypeId="All";	
				}else {
					selProjectTypeId=ProjectTypeId;
				}
				
				if(DakMemberTypeId==null || DakMemberTypeId.equalsIgnoreCase("All")) {
					MemberTypeId="All";	
				}else {
					MemberTypeId=DakMemberTypeId;
				}
				
				if(Employee==null || Employee.equalsIgnoreCase("All")) {
					Emp="All";	
				}else {
					Emp=Employee;
				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = new GregorianCalendar();
				cal.setTime(date);
				if(Date==null) 
				{
			        cal.add(Calendar.DAY_OF_MONTH, -1);
			        fromDate = sdf.format(cal.getTime());
			        toDate = sdf.format(cal.getTime());
				}else if("Today".equals(Date)){
					fromDate = sdf.format(date);
			        toDate = sdf.format(date);
				}
				else if("Yesterday".equals(Date)){
			        cal.add(Calendar.DAY_OF_MONTH, -1);
			        fromDate = sdf.format(cal.getTime());
			        toDate = sdf.format(cal.getTime());
					
				}else if("week".equals(Date)) {
			        cal.add(Calendar.DAY_OF_MONTH, -7);
			        fromDate = sdf.format(cal.getTime());
			        toDate = sdf.format(date);
				}else if("month".equals(Date)){
					    cal.add(Calendar.DAY_OF_MONTH, -30);
				        fromDate = sdf.format(cal.getTime());
				        toDate = sdf.format(date);
				}else if("threeMonth".equals(Date)) {
					    cal.add(Calendar.DAY_OF_MONTH, -90);
				        fromDate = sdf.format(cal.getTime());
				        toDate = sdf.format(date);
				}else if("sixMonth".equals(Date)) {
					cal.add(Calendar.DAY_OF_MONTH, -180);
			        fromDate = sdf.format(cal.getTime());
			        toDate = sdf.format(date);
				}else {
					cal.add(Calendar.DAY_OF_MONTH, -365);
			        fromDate = sdf.format(cal.getTime());
			        toDate = sdf.format(date);
				}
				
				if(Source.equalsIgnoreCase("All") ) {
					req.setAttribute("AllSourceTypeList", service.AllSourceTypeList());
				}else {
					req.setAttribute("AllSourceTypeList", service.SelectedSourceTypeList(Source));
				}
				if(Project.equalsIgnoreCase("All") ) {
				req.setAttribute("ProjectTypeList", service.ProjectTypeList(lab));
				}else if(selProjectTypeId!=null && Project.equalsIgnoreCase("P")) {
					req.setAttribute("ProjectTypeList", service.SelProjectTypeList(lab));
				}else if(selProjectTypeId!=null && Project.equalsIgnoreCase("N")) {
					req.setAttribute("ProjectTypeList", service.SelNonProjectTypeList());
				}else if(selProjectTypeId!=null && Project.equalsIgnoreCase("O")){
					req.setAttribute("ProjectTypeList", service.SelOtherProjectTypeList());
				}
				List<Object[]> DakSLAMissedDashBoardCount=service.DakSLAMissedDashBoardCount(fromDate,toDate,Source,Project,SelSourceType,selProjectTypeId,MemberTypeId,Emp,Delivery,Priority);
				
				List<Object[]> DakSLANearDashBoardCount=service.DakSLANearDashBoardCount(fromDate,toDate,Source,Project,SelSourceType,selProjectTypeId,MemberTypeId,Emp,Delivery,Priority);
				
				int MissedDistributed=0;
				int MissedReplied=0;
				int MissedRepliedByPnCDo=0;
				int MissedApproved=0;
				int MissedClosed=0;
					
				int NearDistributed=0;
				int NearReplied=0;
				int NearRepliedByPnCDo=0;
				int NearApproved=0;
				int NearClosed=0;
				int TotalNearDak=DakSLANearDashBoardCount.size();
				
				if(DakSLAMissedDashBoardCount!=null) {
				for(Object[] obj: DakSLAMissedDashBoardCount) {
					if(obj[6]!=null && !obj[6].toString().equalsIgnoreCase("DI")) {
						MissedDistributed+=1;
					}
					if(obj[28]!=null && obj[28].toString().equalsIgnoreCase("Replied")) {
						MissedReplied+=1;
					}
					
					if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("RM") ||obj[6]!=null && obj[6].toString().equalsIgnoreCase("RP")|| obj[6]!=null && obj[6].toString().equalsIgnoreCase("FP")) {
						MissedRepliedByPnCDo+=1;
					}
					
					if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("AP")) {
						MissedApproved+=1;
					}
					if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("DC")) {
						MissedClosed+=1;
					}
					
				}
				}
				
				if(DakSLANearDashBoardCount!=null) {
					for(Object[] obj: DakSLANearDashBoardCount) {
						if(obj[6]!=null && !obj[6].toString().equalsIgnoreCase("DI")) {
							NearDistributed+=1;
						}
						if(obj[28]!=null && obj[28].toString().equalsIgnoreCase("Replied")) {
							NearReplied+=1;
						}
						
						if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("RM") || obj[6]!=null && obj[6].toString().equalsIgnoreCase("RP") || obj[6]!=null && obj[6].toString().equalsIgnoreCase("FP")) {
							NearRepliedByPnCDo+=1;
						}
						
						if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("AP")) {
							NearApproved+=1;
						}
						if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("DC")) {
							NearClosed+=1;
						}
						
					}
					}
				
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("Date",Date);
				req.setAttribute("Source", Source);
				req.setAttribute("Project", Project);
				req.setAttribute("MemberTypeId", MemberTypeId);
				req.setAttribute("Emp", Emp);
				req.setAttribute("SourceList",service.SourceList());
				int TotalMissedDak=DakSLAMissedDashBoardCount.size();
				req.setAttribute("TotalMissedDak", TotalMissedDak);
				req.setAttribute("MissedDistributed", MissedDistributed);
				req.setAttribute("MissedReplied", MissedReplied);
				req.setAttribute("MissedRepliedByPnCDo", MissedRepliedByPnCDo);
				req.setAttribute("MissedApproved", MissedApproved);
				req.setAttribute("MissedClosed", MissedClosed);
				
				req.setAttribute("TotalNearDak", TotalNearDak);
				req.setAttribute("NearDistributed", NearDistributed);
				req.setAttribute("NearReplied", NearReplied);
				req.setAttribute("NearRepliedByPnCDo", NearRepliedByPnCDo);
				req.setAttribute("NearApproved", NearApproved);
				req.setAttribute("NearClosed", NearClosed);
				
				req.setAttribute("DakGroupingListDropDown", DakGroupingListDropDown);
				
				if(MemberTypeId.equalsIgnoreCase("All") && Emp.equalsIgnoreCase("All") || MemberTypeId.equalsIgnoreCase("All") && Employee!=null) {
					req.setAttribute("EmployeeList", service.StartEmployeeList(lab));
				}else if(DakMemberTypeId!=null && Emp.equalsIgnoreCase("All") || DakMemberTypeId!=null && Employee!=null){
					req.setAttribute("EmployeeList", service.SelMemberTypeEmployeeList(MemberTypeId,lab));
				}
				
				
				System.out.println("fromDate:"+fromDate);
				System.out.println("toDate:"+toDate);
				req.setAttribute("ProjectCardsCount", service.ProjectCardsCount(fromDate,toDate));
				req.setAttribute("GroupCardsCount", service.GroupCardsCount(fromDate,toDate));
				req.setAttribute("DeliveryTypeId", Delivery);
				req.setAttribute("PriorityId", Priority);
				req.setAttribute("SelSourceType", SelSourceType);
				req.setAttribute("selProjectTypeId", selProjectTypeId);
				req.setAttribute("DakDeliveryList",service.DakDeliveryList());
				req.setAttribute("priorityList",service.getPriorityList());
				req.setAttribute("CountData", service.getDashBoardCount(EmpId,fromDate,toDate,Username,Source,Project,SelSourceType,selProjectTypeId,MemberTypeId,Emp,Delivery,Priority));
				req.setAttribute("loginTypeList", headerservice.loginTypeList(LoginType));
				Map<String,List<Object[]>> multiValueMap = new HashMap<>();
				for (Object[] obj : selProjectList) {
				    Object[] projectWiseCount = service.ProjectWiseCount(obj[0].toString(),fromDate,toDate);
				    List<Object[]> projectCountList = new ArrayList<>();
				   if(projectWiseCount!=null) {
				    projectCountList.add(projectWiseCount);
				    multiValueMap.put(projectWiseCount[11].toString(), projectCountList);
				   }
				}
				req.setAttribute("multiValueMap", multiValueMap);
				
				Map<String,List<Object[]>> multiGroupValueMap = new HashMap<>();
				for (Object[] obj : DakGroupingListDropDown) {
				    Object[] GroupWiseCount = service.GroupWiseCount(obj[0].toString(),fromDate,toDate);
				    List<Object[]> GroupCountList = new ArrayList<>();
				   if(GroupWiseCount!=null) {
					   GroupCountList.add(GroupWiseCount);
					   multiGroupValueMap.put(GroupWiseCount[9].toString(), GroupCountList);
				   }
				}
				String popupdate  = LocalDate.now().toString();
				req.setAttribute("PopUpCount", service.PopUpCount(EmpId,popupdate));
				req.setAttribute("multiGroupValueMap", multiGroupValueMap);
				
				
	     }catch (Exception e) {
	    	
	    	 logger.error(new Date() +" Login Problem Occures When Login By ", e);
	     }

		return "static/MainDashBoard";
	}

	//@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "AdminDashBoard.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String AdminDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside AdminDashBoard " );

		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("1", LogId));

		return "admin/AdminDashBoard";
	}
	//@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "MasterDashBoard.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MasterDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside MasterDashBoard " );

		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("2", LogId));
		return "master/MasterDashBoard";
	}
	
	//@PreAuthorize("hasRole('ROLE_DAK_ADM')")
	@RequestMapping(value = "DakDashBoard.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside DakDashBoard " );

		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("3", LogId));
		return "dak/DakDashBoard";
	}
	
	
	
	@RequestMapping(value = "MailConfigurationList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MailConfigurationList(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside MailConfiguration.htm " );
		   try {
			   req.setAttribute("mailConfigurationList", service.MailConfigurationList());
		    }catch (Exception e) {
		    	
		    	 logger.error(new Date() +" Login Problem Occures When MailConfiguration.htm was clicked ", e);
		     }

		return "admin/mailConfiguration";

	}
	
	@RequestMapping(value = "MailConfigurationAdd.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MailConfigurationAdd(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside MailConfigurationAdd.htm " );
		   try {
			   req.setAttribute("action", "Add");
	System.out.println("Mail Configurationnnnnnnn");
		    }catch (Exception e) {
		    	 logger.error(new Date() +" Login Problem Occures When MailConfiguration.htm was clicked ", e);
		     }
		return "admin/mailConfigurationAddEdit";

	}
	
	
	@RequestMapping(value = "MailConfigurationAddSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MailConfigurationAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		logger.info(new Date() +" Inside MailConfigurationAddSubmit " );
		long result = 0;
		try {
			
			String Username = (String)req.getParameter("UserNameData");
			String Password = (String)req.getParameter("PasswordData");
			String HostType = (String)req.getParameter("HostTypeData");
			String Host = (String)req.getParameter("Host");
			String Port = (String)req.getParameter("Port");
			result = service.AddMailConfiguration(Username,Password,HostType,req.getUserPrincipal().getName(),Host,Port);
			
		}catch (Exception e) {
		 	 logger.error(new Date() +" Login Problem Occures When MailConfigurationAddSubmit.htm was clicked ", e);
		 	 result = 0;
	     }
		if(result >0) {
			redir.addAttribute("result", "Mail Configuration Added Successfully");
		}
		else if(result ==-1){
			redir.addAttribute("resultfail", "TypeOfHost Already Exists ...!");
		}else {
			redir.addAttribute("resultfail", "Mail Configuration Add Unsuccessful");
		}

		return "redirect:/MailConfigurationList.htm";
	}
	
	
	@RequestMapping(value = "MailConfigurationEdit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MailConfigurationEdit(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside MailConfigurationAdd.htm " );
		   try {
			   String MailConfigurationId = (String)req.getParameter("Lid");
			   req.setAttribute("action", "Edit");
			   req.setAttribute("mailConfigIdFrEdit", MailConfigurationId);
			   Object[] MailConfigurationEditObject = service.MailConfigurationEditList(Long.parseLong(MailConfigurationId));
			   if(MailConfigurationEditObject!=null && MailConfigurationEditObject[5]!=null) {
				   String pass=rea.decryptByAesAlg(MailConfigurationEditObject[5].toString());
				   req.setAttribute("pass", pass);
			   }
			   if(MailConfigurationId!=null && MailConfigurationEditObject!=null) {
				   req.setAttribute("mailConfigEditList", MailConfigurationEditObject);
			   }else {
				  return "static/Error";
			   }
	System.out.println("Mail Configurationnnnnnnn");
		    }catch (Exception e) {
		    	 logger.error(new Date() +" Login Problem Occures When MailConfiguration.htm was clicked ", e);
		     }
			return "admin/mailConfigurationAddEdit";

	}
	
	
	@RequestMapping(value = "MailConfigurationEditSubmit.htm", method = {RequestMethod.GET, RequestMethod.POST})
	public String MailConfigurationEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		logger.info(new Date() +" Inside MailConfigurationEditSubmit " );
		long result = 0;
		try {
			String MailConfigurationId = (String)req.getParameter("MailConfigIdFrEditSubmit");
			String Username = (String)req.getParameter("UserNameData");
			String Password = (String)req.getParameter("PasswordData");
			String HostType = (String)req.getParameter("HostTypeData");
			String Host = (String)req.getParameter("Host");
			String Port = (String)req.getParameter("Port");
			if(MailConfigurationId!=null) {
			result = service.UpdateMailConfiguration(Long.parseLong(MailConfigurationId),Username,HostType,req.getUserPrincipal().getName(),Host,Port,Password);
			}else {
				result = 0;
			}
		}catch (Exception e) {
		 	 logger.error(new Date() +" Login Problem Occures When MailConfigurationEditSubmit.htm was clicked ", e);
		 	 result = 0;
	     }
		if(result >0) {
			redir.addAttribute("result", "Mail Configuration Updated Successfully");
		}
		else {
			redir.addAttribute("resultfail", "Mail Configuration Update Unsuccessful");
		}

		return "redirect:/MailConfigurationList.htm";
	}
	
	@RequestMapping(value = "MailConfigurationDelete.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MailConfigurationDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		logger.info(new Date() +" Inside MailConfigurationDelete.htm " );
		long result = 0;
		   try {
			   String MailConfigurationId = (String)req.getParameter("Lid");
			   if(MailConfigurationId!=null) {
				   result = service.DeleteMailConfiguration(Long.parseLong(MailConfigurationId),req.getUserPrincipal().getName());
			   }else {
				   result = 0;
			   }
		    }catch (Exception e) {
		    	 logger.error(new Date() +" Login Problem Occures When MailConfigurationDelete.htm was clicked ", e);
		     }
		   
		   if(result >0) {
				redir.addAttribute("result", "Mail Configuration Delete Successful");
			}
			else {
				redir.addAttribute("resultfail", "Mail Configuration Delete Unsuccessful");
			}

		return "redirect:/MailConfigurationList.htm";

	}
	
	@RequestMapping(value = "ReportsDashBoard.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ReportsDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside ReportsDashBoard " );

		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("4", LogId));
		return "reports/ReportsDashBoard";
	}
	
	@RequestMapping(value = "ENoteDashBoard.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ENoteDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside ENoteDashBoard.htm " );

		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("5", LogId));
		return "Enote/eNoteDashBoard";
	}
	
	@RequestMapping(value = "LetterDashBoard.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String LetterDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside LetterDashBoard.htm " );
		
		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("6", LogId));
		return "letter/LetterDashBoard";
	}
	
	/* ----------------AuditPatches------------------------- */
	@RequestMapping(value = "AuditPatchesView.htm", method = { RequestMethod.GET, RequestMethod.POST })
	public String patchList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside AuditPatchesView.htm " + UserId);
		try {

			req.setAttribute("AuditPatchesList", service.AuditPatchesList());
			return "admin/AuditPatchesList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside AuditPatchesView.htm " + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "AuditPatchEditSubmit.htm", method = RequestMethod.POST)
	public String patchAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
	                             @RequestParam(value = "file") MultipartFile file) {
	    String UserId = (String) ses.getAttribute("Username");
	    logger.info(new Date() + " Inside AuditPatchesubmit.htm " + UserId);
	    
	    try {
	        String versionNo = req.getParameter("versionNo");
	        String Description = req.getParameter("Description");
	        byte[] fileData = null; // To store the file data
	        Long Auditpatchid=Long.parseLong(req.getParameter("auditId"));
	        // Check if the file is not empty
	        if (file != null && !file.isEmpty()) {
	            // Read the file data directly without compression
	            fileData = file.getBytes();
	        }
	        
	        

	        // Create the AuditPatches object and set its fields
	        AuditPatches dto = service.findAuditpatch(Auditpatchid);
	        dto.setVersionNo(versionNo);
	        dto.setDescription(Description);
	        dto.setModifiedBy(UserId);
	        if(fileData!=null) {
	        dto.setAttachment(fileData); // Store the raw file data
	        }
	        dto.setAuditPatchesId(Auditpatchid);

	        // Save the data using the service
	        long count = service.AuditPatchAddSubmit(dto);
	        if (count > 0) {
	            redir.addAttribute("result", "Patch Details Updated Successfully");
	        } else {
	            redir.addAttribute("resultfail", "Patch Details Updated Unsuccessfully");
	        }

	        return "redirect:/AuditPatchesView.htm";
	    } catch (Exception e) {
	        e.printStackTrace();
	        logger.error(new Date() + " Inside AuditPatchesubmit.htm " + UserId, e);
	        return "static/Error"; // Adjust this according to your error handling view
	    }
	}

	
	@RequestMapping(value = "PatchesAttachDownload.htm", method = RequestMethod.GET)
	public ResponseEntity<byte[]> downloadPatchAttachment(@RequestParam("attachid") Long attachId) {
	    try {
	        // Fetch the AuditPatches record based on the attach ID
	        AuditPatches auditPatch = service.getAuditPatchById(attachId);

	        // Check if the file exists
	        if (auditPatch == null || auditPatch.getAttachment() == null) {
	            return ResponseEntity.notFound().build();
	        }

	        // Set the headers for file download
	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.TEXT_PLAIN); // Set content type for .txt file
	        headers.setContentDispositionFormData("attachment", "patch_" + attachId + ".txt"); // Set filename with .txt extension

	        // Return the file as byte array
	        return new ResponseEntity<>(auditPatch.getAttachment(), headers, HttpStatus.OK);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	    }
	}
	
	
	
}

