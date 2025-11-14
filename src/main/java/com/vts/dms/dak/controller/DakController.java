package com.vts.dms.dak.controller;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.dms.dak.dto.DakAddDto;
import com.vts.dms.dak.dto.DakAssignDto;
import com.vts.dms.dak.dto.DakAssignReplyDto;
import com.vts.dms.dak.dto.DakAssignReplyRevDto;
import com.vts.dms.dak.dto.DakAttachmentDto;
import com.vts.dms.dak.dto.DakDestinationDto;
import com.vts.dms.dak.dto.DakPnCReplyDto;
import com.vts.dms.dak.dto.DakReplyDto;
import com.vts.dms.dak.dto.DakSeekResponseAttachDto;
import com.vts.dms.dak.dto.DakSeekResponseDto;
import com.vts.dms.dak.dto.MailConnectDto;
import com.vts.dms.dak.dto.MailDto;
import com.vts.dms.dak.model.DakAssignReply;
import com.vts.dms.dak.model.DakCreate;
import com.vts.dms.dak.model.DakCreateDestination;
import com.vts.dms.dak.model.DakMail;
import com.vts.dms.dak.model.DakMain;
import com.vts.dms.dak.model.DakMarking;
import com.vts.dms.dak.model.DakPnCReply;
import com.vts.dms.dak.model.DakRemind;
import com.vts.dms.dak.model.DakReply;
import com.vts.dms.dak.model.DakSeekResponse;
import com.vts.dms.dak.service.DakService;
import com.vts.dms.master.model.NonProjectMaster;
import com.vts.dms.master.model.OtherProjectMaster;
import com.vts.dms.master.model.Source;
import com.vts.dms.report.service.ReportService;
import com.vts.dms.service.MailReciever;



@Controller
public class DakController {
	private static final Logger logger=LogManager.getLogger(DakController.class);
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	private  SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
	private SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	@Autowired
	DakService service;
	
	@Autowired
    private Environment env;
	
    @Autowired
    private RestTemplate restTemplate;
    
    @Autowired
	ReportService reportservice;
    
	@RequestMapping(value = "DakInit.htm", method = {RequestMethod.GET, RequestMethod.POST})
	public String DakInit(HttpServletRequest req,HttpServletResponse res,HttpSession ses) throws Exception 
	{
		logger.info(new Date() +" In CONTROLLER DakInit.htm "+req.getUserPrincipal().getName());
		try {
			String dakMailId =  req.getParameter("dakMailId");
			if(dakMailId!=null) {
				//DakMail dakmail =service.findByDakMailId(dakMailId);
				//req.setAttribute("DakMail",dakmail);
			}
		    String LabCode = (String) ses.getAttribute("LabCode");
			req.setAttribute("SourceList",service.SourceList());
			req.setAttribute("DakDeliveryList",service.DakDeliveryList());
			req.setAttribute("letterList",service.getLetterTypeList());
			req.setAttribute("priorityList",service.getPriorityList());
			req.setAttribute("relaventList",service.getRelaventList(LabCode));
			req.setAttribute("linkList",service.DakLinkList());
			req.setAttribute("nonProjectList",service.NonProjectList());
			req.setAttribute("OtherProjectList", service.OtherProjectList());
			req.setAttribute("cwList",service.getCwList());
			req.setAttribute("actionList",service.getActionList());
			req.setAttribute("divList",service.getDivisionList());
			req.setAttribute("DakMembers", service.getDakMembers());
			req.setAttribute("DakMemberGroup", service.DakMemberGroup());
			req.setAttribute("LabCode", LabCode);			
			req.setAttribute("employeeList", service.EmpListDropDown(LabCode));
			req.setAttribute("dakClosingAuthorityList", service.closingAuthorityList());
			return "dak/dakInit";
		}catch (Exception e) {
			logger.error(new Date() +" In CONTROLLER DakInit.htm "+req.getUserPrincipal().getName()+"  "+e);
			return "static/Error";
			
		}
	}
	
	@RequestMapping(value= "DakAddSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakAddSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir, 
			@RequestPart(name = "dak_document", required = false) MultipartFile maindoc,
			@RequestPart(name = "dak_sub_document", required = false) MultipartFile[] subdocs
			) {
		logger.info(new Date() +"Dak Add"+req.getUserPrincipal().getName());
		long result=0;
		try {
			 String DivisionCode = (String) ses.getAttribute("DivisionCode");
		     String LabCode = (String) ses.getAttribute("LabCode");
			 String ProjectIdDetails=req.getParameter("ActionId");
			long ActionId=0;
			String ActionCode=null;
			if(ProjectIdDetails!=null)
  			{
  				String[] arr=ProjectIdDetails.split("#");
  				ActionId=Integer.parseInt(arr[0]);
  				ActionCode=arr[1].trim();
  			}
			
			String DakLinkId[]=(String[])req.getParameterValues("DakLinkId");
			String PrjDirectorEmpId = req.getParameter("projectDirectorEmpId");
			String markedEmps[]=(String[])req.getParameterValues("empid");//(Ex:-5/1 12/1 14/1...) Selection of Individual Marking
			
			
				if(PrjDirectorEmpId!=null &&  PrjDirectorEmpId.trim()!="" && !PrjDirectorEmpId.trim().isEmpty()) {
					String EmpSel = PrjDirectorEmpId + "/-1";
					if(markedEmps == null) {
					 markedEmps = new String[]{EmpSel};
					}else {
						     markedEmps = Arrays.copyOf(markedEmps, markedEmps.length + 1);
						    markedEmps[markedEmps.length - 1] = EmpSel;
						    //In above code create a new array with the length of markedEmps plus one to accommodate the EmpSel. We then set the last element of the new array to be the value of EmpSel.
					}
				}
		    String GroupMarkingData=req.getParameter("EmpIdGroup");//(Ex:-13/9 15/9....) Selection of Group Marking
			String[] resultArray = null;
			String FinalEmp[] = null;
			int resultArrayCheck = 0;
				if (GroupMarkingData != null && !GroupMarkingData.trim().equals("") && markedEmps == null)
	             {//WHEN Individual IS NULL
			        	   String GroupMarkingEmps[]=GroupMarkingData.split(",");
		                   int finalLength = GroupMarkingEmps.length;
		                   FinalEmp = new String[finalLength];
					       System.arraycopy(GroupMarkingEmps, 0, FinalEmp, 0, GroupMarkingEmps.length);
					       resultArrayCheck = 1;
			        	  
	             }else if(markedEmps!=null  && GroupMarkingData.trim().equals("") ) {//WHEN GroupMarkingData IS NULL
			                   int finalLength = markedEmps.length;
			                   FinalEmp = new String[finalLength];
						       System.arraycopy(markedEmps, 0, FinalEmp, 0, markedEmps.length);
						       resultArrayCheck = 1;
			        	  
			     }else if(markedEmps!=null && GroupMarkingData!=null  && !GroupMarkingData.trim().equals("")) {//WHEN BOTH ARE NOT NULL
			        	  String GroupMarkingEmps[]=GroupMarkingData.split(",");
		                   int finalLength = markedEmps.length + GroupMarkingEmps.length;
		                   FinalEmp = new String[finalLength];
					       System.arraycopy(markedEmps, 0, FinalEmp, 0, markedEmps.length);
					       System.arraycopy(GroupMarkingEmps, 0, FinalEmp, markedEmps.length, GroupMarkingEmps.length);
					       resultArrayCheck = 1;
			          }else {//WHEN BOTH ARE NULL
			        	  resultArrayCheck = 0;
			          }
				       if(resultArrayCheck>0) {
				       Map<String, String> empIdToMarkedTypeIdMap = new HashMap<>();
		               // Loop through the array to add empIds to the HashSet and store corresponding markedTypeIds
		              for (int i = 0; i < FinalEmp.length; i++) {
		        	       String [] values=FinalEmp[i].split("/");
		                   String empId = values[0];
		                   String markedTypeId = values[1];
		               // Add the empId to the HashMap to automatically remove duplicates and The last occurrence of empId will override previous entries with the same empId
		                   empIdToMarkedTypeIdMap.put(empId, markedTypeId);
		               }
		                 // Convert the HashMap to a String[] array
		                  resultArray = new String[empIdToMarkedTypeIdMap.size()];
		                  int index = 0;
		                   for (Map.Entry<String, String> entry : empIdToMarkedTypeIdMap.entrySet()) {
		                   String empId = entry.getKey();
		                   String markedTypeId = entry.getValue();
		                   String entryString = empId + "," + markedTypeId;
		                   resultArray[index] = entryString;
		                   index++;
		                   }
				       }else {
				    	   
				    	   resultArray = null;
				       }
				DakMain dak=new DakMain();
				dak.setSubject(req.getParameter("Subject").trim());
				dak.setRefNo(req.getParameter("RefNo").trim());
				dak.setReceiptDate(new java.sql.Date(sdf.parse(req.getParameter("ReceiptDate")).getTime()));
				dak.setRefDate(new java.sql.Date(sdf.parse(req.getParameter("RefDate")).getTime()));
				dak.setSourceId(Long.parseLong(req.getParameter("SourceId")));
				dak.setSourceDetailId(Long.parseLong(req.getParameter("SourceType")));
				dak.setProjectType(req.getParameter("ProjectType"));
				dak.setPriorityId(Long.parseLong(req.getParameter("PriorityId")));
				dak.setSignatory(req.getParameter("Signatory").trim());
				dak.setDeliveryTypeId(Long.parseLong(req.getParameter("DakDeliveryId")));
				dak.setLetterTypeId(Long.parseLong(req.getParameter("LetterId")));
				dak.setProjectId(Long.parseLong(req.getParameter("ProId")));
				dak.setKeyWord1(req.getParameter("Key1").trim());
				dak.setKeyWord2(req.getParameter("Key2").trim());
				dak.setKeyWord3(req.getParameter("Key3").trim());
				dak.setKeyWord4(req.getParameter("Key4").trim());
				dak.setRemarks(req.getParameter("Remarks").trim());
				dak.setActionId(ActionId);
				
				if (ActionCode.equalsIgnoreCase("ACTION")) {
					dak.setActionDueDate(new java.sql.Date(sdf.parse(req.getParameter("DueDate")).getTime()));
					dak.setActionTime(req.getParameter("DueTime"));
					dak.setReplyOpen("Y");
				}else {
				dak.setReplyOpen("N");
				}
				dak.setReplyStatus("N");
				dak.setDakStatus("DI");
	            dak.setDirectorApproval("R");
	            dak.setDirApvForwarderId(0);
	            String ClosingAuthority =(String)req.getParameter("closingAuthorityVal");
	            if(ClosingAuthority!=null && ClosingAuthority.trim()!="") {
	            	dak.setClosingAuthority(ClosingAuthority);
	            }else {
	            	dak.setClosingAuthority("P");
	            }
				dak.setClosingAuthority(req.getParameter("closingAuthorityVal"));
				dak.setDivisionCode(DivisionCode);
				dak.setLabCode(LabCode);
				dak.setSourceLabCode(LabCode);
				dak.setCreatedBy(req.getUserPrincipal().getName());
				dak.setCreatedDate(sdf1.format(new Date()));
				dak.setIsActive(1);
				DakAddDto dakdto = DakAddDto.builder().dak(dak).MarkedEmps(resultArray).MainDoc(maindoc).SubDoc(subdocs).build();
				result=service.insertDak(dakdto,(Long)ses.getAttribute("EmpId"),resultArray,DakLinkId);
		}catch (Exception e) {
			logger.error(new Date() +"Dak Add"+e);
		}
		if(result >0) {
			redir.addAttribute("result", "DAK Initiated Successfully");
		}
		else {
			redir.addAttribute("resultfail", "DAK Initiation Unsuccessful");
		}
		return "redirect:/DakInitiationList.htm";
	}
	
	@RequestMapping(value = "DakInitiationList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakList(Model model,HttpServletRequest req,HttpServletResponse res, HttpSession ses) throws Exception {
        logger.info(new Date() +"DakList"+req.getUserPrincipal().getName());
        String DivisionCode = (String) ses.getAttribute("DivisionCode");
        String LabCode = (String) ses.getAttribute("LabCode");
        String UserName=(String)ses.getAttribute("Username");
		String letterno=null;
		String ApiUrl=env.getProperty("app_url");
		if(req.getParameter("letterno")==null) {
			Map md= model.asMap();
			letterno=(String)md.get("letterno");
		}if(letterno!=null) {
			req.setAttribute(letterno, letterno);
		}
		String PageNumber=req.getParameter("PageNumber");
		String RowNumber=req.getParameter("RowNumber");
		
		req.setAttribute("PageNumber", PageNumber);
		req.setAttribute("RowNumber",   RowNumber);
		req.setAttribute("DakList",service.DakPendingDistributionList(DivisionCode,LabCode,UserName));
		req.setAttribute("EmpList", service.EmployeeList());
		req.setAttribute("DakMembers", service.getDakMembers());
		return "dak/dakPendingList";

	}
	
	@RequestMapping(value = "DakEdit.htm" , method = {RequestMethod.GET , RequestMethod.POST})
	public String DakEdit(Model model, HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir) throws Exception {
		logger.info(new Date() +"Dak Edit"+req.getUserPrincipal().getName());
		
		String PageNo=null;
		String Row=null;
		try {
			String dakid=req.getParameter("DakId");
			String dakidsel=(String) req.getParameter("Dakid");
			String ActionCode=(String)req.getParameter("ActionCode");
			String ActionRedirectVal = null;
			//Code for  DAK Director List Redirect Start
			ActionRedirectVal = req.getParameter("ActionForm");
			if(ActionRedirectVal!=null) {
				req.setAttribute("RedirectVal",ActionRedirectVal);	
			}
			//Code for  DAK Director List Redirect End
			DakMain dakData=null;
			long DakId=0;
			if(dakidsel!=null) {
				Map md= model.asMap();
				dakid=(String)md.get("Dakid");
				DakId=(Long.parseLong(dakidsel));
				dakData=service.dakData(dakidsel);
			}else {
			     DakId=(Long.parseLong(dakid));
			     dakData=service.dakData(dakid);
			}
			String LabCode = (String) ses.getAttribute("LabCode");
  			String ActionForm=req.getParameter("ActionForm");
  			if(ActionForm!=null) {
  				req.setAttribute("ActionForm",ActionForm);
  			}
  			String PageName = "RedirPageNo"+dakid;
			PageNo = req.getParameter(PageName);
			String RowName = "RedirRow"+dakid;
			Row = req.getParameter(RowName);
				
			req.setAttribute("dakIdSelFrEdit",dakid);	
			req.setAttribute("dakLinkData", service.dakLinkData(DakId));
			req.setAttribute("DakMarkingData", service.DakMarkingData(DakId));
			req.setAttribute("DakData",dakData);
			req.setAttribute("SourceList",service.SourceList());
			req.setAttribute("DakDeliveryList",service.DakDeliveryList());
			req.setAttribute("letterList",service.getLetterTypeList());
			req.setAttribute("priorityList",service.getPriorityList());
			req.setAttribute("relaventList",service.getRelaventList(LabCode));
			req.setAttribute("linkList",service.DakLinkList());
			req.setAttribute("nonProjectList",service.NonProjectList());
			req.setAttribute("OtherProjectList", service.OtherProjectList());
			req.setAttribute("cwList",service.getCwList());
			req.setAttribute("actionList",service.getActionList());
			req.setAttribute("divList",service.getDivisionList());
			req.setAttribute("DakMembers", service.getDakMembers());
			req.setAttribute("ActionCode", ActionCode);
			req.setAttribute("DakMemberGroup", service.DakMemberGroup());
			req.setAttribute("dakClosingAuthorityList", service.closingAuthorityList());
			
			String fromDate=(String)req.getParameter("fromDateFetch");
			String toDate=(String)req.getParameter("toDateFetch");
			req.setAttribute("fromDateRedir", fromDate);
			req.setAttribute("toDateRedir", toDate);
			
			req.setAttribute("PageNoData", PageNo);
			req.setAttribute("RowData", Row);
			}catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +"Dak Edit"+e);
			}
			return "dak/dakEdit";
	
		}
	
	@RequestMapping(value = "/DakEditSubmit.htm", method = {RequestMethod.GET, RequestMethod.POST})
	public String DakEditSubmit(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir, 
			@RequestPart(name = "dak_document", required = false) MultipartFile maindoc,
			@RequestPart(name = "dak_sub_document", required = false) MultipartFile[] subdocs) {
		logger.info(new Date() +"Dak Add"+req.getUserPrincipal().getName());
		long result=0;
		
		try {
			
			String ProjectIdDetails=req.getParameter("ActionId");
			long ActionId=0;
			String ActionCode=null;
			long EmpIdPresentCount = 0;
			String ProjDirEmpIdAftEdit = req.getParameter("projectDirectorEmpId");
			String DakIdVal = req.getParameter("DakId");
            String ProjIdSelBefEdit =  req.getParameter("prevSelProjectId");
            String ProjectType = req.getParameter("ProjectType");
            String DakAttachmentId=req.getParameter("dakattachmentid");
            String ProjDirEmpIdBefEdit = null;
            
 		   List<Object[]> ProjectDetailsList = service.ProjectDetailedList(ProjIdSelBefEdit);
 		   if(ProjectDetailsList!=null && ProjectDetailsList.size()>0) {
 			   for(Object[] prjobj : ProjectDetailsList) {
 				   ProjDirEmpIdBefEdit = prjobj[0].toString();
 			   }
 		   }
			if(ProjectIdDetails!=null)
  			{
  				String[] arr=ProjectIdDetails.split("#");
  				ActionId=Integer.parseInt(arr[0]);
  				ActionCode=arr[1].trim();
  			}
			String DakLinkId[]=(String[])req.getParameterValues("DakLinkId");
			String[] resultArray = null;
			String markedEmps[]=(String[])req.getParameterValues("empid");//(Ex:-5/1, 12/1, 14/1...) Selection of Individual Marking
		
/**********PD Code Start*******************/	
			//As this is edit check PrjDirectorEmpId is already selected previously or not 
            //if its selected prj previously i.e ProjIdSelBefEdit!=null and now it is change back to non project or others then we have to delete previously selected project Director EmpId
			if(ProjIdSelBefEdit!=null  && !ProjIdSelBefEdit.trim().isEmpty()
					&& ProjectType!=null && (ProjectType.trim().equalsIgnoreCase("N") || ProjectType.trim().equalsIgnoreCase("O"))) {
			
           		       if(ProjDirEmpIdBefEdit!=null) {
           		        service.DeletePrevPrjDirEmpId(Long.parseLong(ProjDirEmpIdBefEdit),Long.parseLong(DakIdVal));
                      }
           		 
			}
			if(ProjectType!=null && ProjectType.trim().equalsIgnoreCase("P") &&  ProjDirEmpIdAftEdit!=null &&  ProjDirEmpIdAftEdit.trim()!="" && !ProjDirEmpIdAftEdit.trim().isEmpty() && DakIdVal!=null &&  !DakIdVal.trim().isEmpty() ) {
				  /*****Delete When project is switched (START)*****/
            	 //If different project is selected than delete previous projectDirEmpId and then add new projectDirEmpId
            	    if(ProjIdSelBefEdit !=null && !ProjIdSelBefEdit.trim().isEmpty() ) {
            		  if(ProjDirEmpIdBefEdit!=null && !ProjDirEmpIdBefEdit.equalsIgnoreCase(ProjDirEmpIdAftEdit)) {
            		         service.DeletePrevPrjDirEmpId(Long.parseLong(ProjDirEmpIdBefEdit),Long.parseLong(DakIdVal));
                       }
            		 }
            	    /*****Delete When project is switched (END)*****/
            	    EmpIdPresentCount = service.GetCountPrjDirEmpIdInPrev(Long.parseLong(ProjDirEmpIdAftEdit),Long.parseLong(DakIdVal));
					if(EmpIdPresentCount == 0) { //EmpIdPresentCount==0 means This projectDirector EmpId is not selected previously
					String EmpSel = ProjDirEmpIdAftEdit + "/-1";
					if(markedEmps == null) {
					 markedEmps = new String[]{EmpSel};
					}else {
						     markedEmps = Arrays.copyOf(markedEmps, markedEmps.length + 1);
						    markedEmps[markedEmps.length - 1] = EmpSel;
						    //In above code create a new array with the length of markedEmps plus one to accommodate the EmpSel. We then set the last element of the new array to be the value of EmpSel.
					}
					}//if its not equal to 0 means EmpIdPresentCount > 0 then no need to add to dak_marking not at all
				}
/**********PD Code End*******************/				
			String GroupMarkingData=req.getParameter("EmpIdGroup");//(Ex:-13/9,15/9....) Selection of Group Marking
			String FinalEmp[] = null;
			int resultArrayCheck = 0;
			if (GroupMarkingData != null && !GroupMarkingData.trim().equals("") && markedEmps == null)
             {//WHEN markedEmps IS NULL
		        	   String GroupMarkingEmps[]=GroupMarkingData.split(",");
	                   int finalLength = GroupMarkingEmps.length;
	                   FinalEmp = new String[finalLength];
				       System.arraycopy(GroupMarkingEmps, 0, FinalEmp, 0, GroupMarkingEmps.length);
				       resultArrayCheck = 1;
		        	  
             }else if(markedEmps!=null  && GroupMarkingData.trim().equals("") ) {//WHEN GroupMarkingData IS NULL
            	  for (int i = 0; i < markedEmps.length; i++) {
		  			    if (i < markedEmps.length - 1) {
		  			    }
		  			}
		                   int finalLength = markedEmps.length;
		                   FinalEmp = new String[finalLength];
					       System.arraycopy(markedEmps, 0, FinalEmp, 0, markedEmps.length);
					       resultArrayCheck = 1;
		        	  
		          }else if(markedEmps!=null && GroupMarkingData!=null  && !GroupMarkingData.trim().equals("")) {//WHEN BOTH ARE NOT NULL
		        	  for (int i = 0; i < markedEmps.length; i++) {
		  			    if (i < markedEmps.length - 1) {
		  			    }
		  			}
		        	  String GroupMarkingEmps[]=GroupMarkingData.split(",");
	                   int finalLength = markedEmps.length + GroupMarkingEmps.length;
	                   FinalEmp = new String[finalLength];
				       System.arraycopy(markedEmps, 0, FinalEmp, 0, markedEmps.length);
				       System.arraycopy(GroupMarkingEmps, 0, FinalEmp, markedEmps.length, GroupMarkingEmps.length);
				       resultArrayCheck = 1;
		         
		          }else {//WHEN BOTH ARE NULL
		        	  resultArrayCheck = 0;
		          }
			       if(resultArrayCheck>0) {
			       Map<String, String> empIdToMarkedTypeIdMap = new HashMap<>();
	               // Loop through the array to add empIds to the HashSet and store corresponding markedTypeIds
	              for (int i = 0; i < FinalEmp.length; i++) {
	        	       String [] values=FinalEmp[i].split("/");
	                   String empId = values[0];
	                   String markedTypeId = values[1];
	               // Add the empId to the HashMap to automatically remove duplicates and The last occurrence of empId will override previous entries with the same empId
	                   empIdToMarkedTypeIdMap.put(empId, markedTypeId);
	               }
	                 // Convert the HashMap to a String[] array
	                  resultArray = new String[empIdToMarkedTypeIdMap.size()];
	                  int index = 0;
	                   for (Map.Entry<String, String> entry : empIdToMarkedTypeIdMap.entrySet()) {
	                   String empId = entry.getKey();
	                   String markedTypeId = entry.getValue();
	                   String entryString = empId + "," + markedTypeId;
	                   resultArray[index] = entryString;
	                   index++;
	                   }
			       }else {
			    	   
			    	   resultArray = null;
			       }
			DakMain dak=new DakMain();
			dak.setDakId(Long.parseLong(req.getParameter("DakId")));
			dak.setSubject(req.getParameter("Subject").trim());
			dak.setDakNo(req.getParameter("DakNo").trim());
			dak.setRefNo(req.getParameter("RefNo").trim());
			dak.setReceiptDate(new java.sql.Date(sdf.parse(req.getParameter("Receiptdate")).getTime()));
			dak.setRefDate(new java.sql.Date(sdf.parse(req.getParameter("RefDate")).getTime()));
			dak.setSourceDetailId(Long.parseLong(req.getParameter("SourceType")));
			dak.setSourceId(Long.parseLong(req.getParameter("SourceId")));
			dak.setProjectType(ProjectType);
			if(ProjectType!=null && ProjectType.equalsIgnoreCase("N")) {
				dak.setProjectId(Long.parseLong(req.getParameter("NonProId")));
			}else if(ProjectType!=null && ProjectType.equalsIgnoreCase("O")) {
				dak.setProjectId(Long.parseLong(req.getParameter("OtherProId")));
            }else if(ProjectType!=null && ProjectType.equalsIgnoreCase("P")) {
            	dak.setProjectId(Long.parseLong(req.getParameter("ProId")));
			}
			
			dak.setSignatory(req.getParameter("Signatory").trim());
			dak.setPriorityId(Long.parseLong(req.getParameter("PriorityId")));
			dak.setDeliveryTypeId(Long.parseLong(req.getParameter("DakDeliveryId")));
			dak.setLetterTypeId(Long.parseLong(req.getParameter("LetterId")));
			dak.setKeyWord1(req.getParameter("Key1").trim());
			dak.setKeyWord2(req.getParameter("Key2").trim());
			dak.setKeyWord3(req.getParameter("Key3").trim());
			dak.setKeyWord4(req.getParameter("Key4").trim());
			dak.setRemarks(req.getParameter("Remarks").trim());
			dak.setActionId(ActionId);
			if(ActionCode.equalsIgnoreCase("ACTION")) {
				dak.setActionDueDate(new java.sql.Date(sdf.parse(req.getParameter("DueDate")).getTime()));
				dak.setActionTime(req.getParameter("DueTime"));
				dak.setReplyOpen("Y");
			}else {
			dak.setReplyOpen("N");
			}
			dak.setReplyStatus("N");
			dak.setDakStatus("DI");
			dak.setDirectorApproval("R");
			dak.setDirApvForwarderId(0);
			dak.setClosingAuthority(req.getParameter("closingAuthorityEditVal"));
			dak.setModifiedBy(req.getUserPrincipal().getName());
			dak.setModifiedDate(sdf1.format(new Date()));
			dak.setIsActive(1);
			DakAddDto dakdto = DakAddDto.builder().dak(dak).MarkedEmps(resultArray).MainDoc(maindoc).SubDoc(subdocs).build();
			result=service.saveDakEdit(DakAttachmentId,dakdto,dak,ActionCode,DakLinkId,resultArray);
			if(result >0) {
				redir.addAttribute("result", "DAK Updated Successfully");
			}
			else {
				redir.addAttribute("resultfail", "DAK Updating Unsuccessful");
			}
			String PageNumber=req.getParameter("PageNumber");
			String RowNumber=req.getParameter("RowNumber");
			redir.addAttribute("PageNumber", PageNumber);
	        redir.addAttribute("RowNumber", RowNumber);
			//redirection code due to common usage in DAK Pending List & DAK Director List
			String fromDate=(String)req.getParameter("FrmDtE");
			String toDate=(String)req.getParameter("ToDtE");
			if (fromDate != null && !"null".equalsIgnoreCase(fromDate) && toDate != null && !"null".equalsIgnoreCase(toDate) && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) {
			        e.printStackTrace();
			    }
			}
		}catch (Exception e) {
			logger.error(new Date() +"Dak Add"+e);
		}
		
		String redirectVal = null;
		redirectVal = req.getParameter("RedirectVal");
		if(redirectVal!=null && "DakDirectorList".equalsIgnoreCase(redirectVal)) {
			   return "redirect:/DakDirectorList.htm";
		 }else if(redirectVal!=null && "DakDetailedList".equalsIgnoreCase(redirectVal)) {
	        	return "redirect:/DakList.htm";
			}else {
				
				return "redirect:/DakInitiationList.htm";
			}
	}               
	
	@RequestMapping(value = "DakOicList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakOicList(HttpServletRequest req) throws Exception {
		logger.info(new Date() +"DakOicList"+req.getUserPrincipal().getName());
		req.setAttribute("EmpList", service.EmployeeList());
		//req.setAttribute("DakList",service.DakList());
		req.setAttribute("DakMembers", service.getDakMembers());
		return "dak/DakOicList";

	}

	
	@RequestMapping (value="DakAttach.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String DakAttach(HttpServletRequest req,HttpServletResponse res,RedirectAttributes redir,
			@RequestParam(name = "dakdocumentupload" ,required = false) MultipartFile dakdocument) throws Exception{
		
		logger.info(new Date() +"DakAttach"+req.getUserPrincipal().getName());
		
		long count =0L;
		String PageNumber=req.getParameter("PageNumber");
		String RowNumber=req.getParameter("RowNumber");
		try {
				
			DakAttachmentDto dakdto = new DakAttachmentDto();
			dakdto.setDakId(Long.parseLong(req.getParameter("dakidvalue")));
			dakdto.setDakNo(req.getParameter("daknovalue"));
			dakdto.setFilePath(env.getProperty("file_upload_path"));
			dakdto.setCreatedBy(req.getUserPrincipal().getName());
			dakdto.setCreatedDate(sdf1.format(new Date()));
			dakdto.setFile(dakdocument);
			dakdto.setType(req.getParameter("type"));
			count=service.DakAttachmentFile(dakdto);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		redir.addAttribute("PageNumber",PageNumber);
		redir.addAttribute("RowNumber",RowNumber);
		if(count>0) 
		{
			
			redir.addAttribute("count",req.getParameter("dakidvalue"));
			redir.addFlashAttribute("letterno",req.getParameter("letterno"));
			redir.addFlashAttribute("type",req.getParameter("type"));
			redir.addAttribute("result","Document Uploaded Successfully");
		}
		else
		{
			redir.addAttribute("count",req.getParameter("dakidvalue"));
			redir.addFlashAttribute("letterno",req.getParameter("letterno"));
			redir.addFlashAttribute("type",req.getParameter("type"));
			redir.addAttribute("resultfail","Document Upload Unsuccessful");
		}
		
		 //redirection code due to common usage in DAK Pending List & DAK Director List
		String fromDate=(String)req.getParameter("fromDateFrmDA");
		String toDate=(String)req.getParameter("toDateFrmDA");
		if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
		    try {
		        fromDate = rdf.format(sdf2.parse(fromDate));
		        toDate = rdf.format(sdf2.parse(toDate));
		        redir.addAttribute("FromDate", fromDate);
		        redir.addAttribute("ToDate", toDate);
		    } catch (ParseException e) {
		        e.printStackTrace();
		        // Handle the exception appropriately (e.g., log the error or provide a default value).
		    }
		}
		        String redirectVal = null;
				redirectVal = req.getParameter("redirectValFrAttach");
				if(redirectVal!=null && redirectVal.equalsIgnoreCase("DakDirectorList")) {
					return "redirect:/DakDirectorList.htm";
				}else if(redirectVal!=null && redirectVal.equalsIgnoreCase("DakDetailedList")) {
					return "redirect:/DakList.htm";
				}else if(redirectVal!=null && redirectVal.equalsIgnoreCase("DakViewList")) {
					redir.addAttribute("DakId", Long.parseLong(req.getParameter("dakidvalue")));
					redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
					return "redirect:/DakReceivedView.htm";
				}else {
					return "redirect:/DakInitiationList.htm";
				}

	}
	
	@RequestMapping (value="DakEditAttach.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String DakEdiAttach(HttpServletRequest req,HttpServletResponse res,RedirectAttributes redir,
			@RequestPart(name = "dak_document", required = false) MultipartFile maindoc,
			@RequestPart(name = "dak_sub_document", required = false) MultipartFile[] subdocs) throws Exception{
		
		logger.info(new Date() +"DakAttach"+req.getUserPrincipal().getName());
		
		        long count =0L;
		        String dakid = req.getParameter("dakidvalue");
		        String DakAttachmentId=req.getParameter("dakattachmentid");
		try {
			DakAddDto dakdto1 = DakAddDto.builder().MainDoc(maindoc).SubDoc(subdocs).build();
			DakAttachmentDto dakdto = new DakAttachmentDto();
			if(dakdto1.getMainDoc()!=null && !dakdto1.getMainDoc().isEmpty()){
			dakdto.setDakId(Long.parseLong(req.getParameter("dakidvalue")));
			dakdto.setFilePath(env.getProperty("file_upload_path"));
			dakdto.setModifiedBy(req.getUserPrincipal().getName());
			dakdto.setModifiedDate(sdf1.format(new Date()));
			dakdto.setFile(dakdto1.getMainDoc());
			dakdto.setRefNo(req.getParameter("letterno"));
			dakdto.setDakNo(req.getParameter("DakNo"));
			dakdto.setType(req.getParameter("type"));
			if(DakAttachmentId!=null) {
			   long DakAttachmentIdsel=Long.parseLong(DakAttachmentId);
			dakdto.setDakAttachmentId(DakAttachmentIdsel);
			 }
			count=service.DakEditAttachmentFile(dakdto,dakdto1);
			}else if(dakdto1!=null && !dakdto1.getSubDoc()[0].isEmpty() && dakdto1.getSubDoc().length>0 ){
				DakAttachmentDto dakdto2 = new DakAttachmentDto();
				dakdto2.setDakId(Long.parseLong(req.getParameter("dakidvalue")));
				dakdto2.setFilePath(env.getProperty("file_upload_path"));
				dakdto2.setModifiedBy(req.getUserPrincipal().getName());
				dakdto2.setModifiedDate(sdf1.format(new Date()));
				dakdto2.setSubFile(dakdto1.getSubDoc());
				dakdto2.setRefNo(req.getParameter("letterno"));
				dakdto2.setDakNo(req.getParameter("DakNo"));
				dakdto2.setType(req.getParameter("type"));
				if(DakAttachmentId!=null) {
					   long DakAttachmentIdsel=Long.parseLong(DakAttachmentId);
					dakdto2.setDakAttachmentId(DakAttachmentIdsel);
					 }
				count=service.DakEditAttachmentFile(dakdto2,dakdto1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		if(count>0) 
		{
			redir.addAttribute("count",req.getParameter("dakidvalue"));
			redir.addFlashAttribute("letterno",req.getParameter("letterno"));
			redir.addFlashAttribute("type",req.getParameter("type"));
			redir.addAttribute("result","Document Uploaded Successfully");
		}
		else
		{
			redir.addAttribute("resultfail","Document Upload Unsuccessful");
		}
		redir.addAttribute("Dakid", dakid);
		
		return "redirect:/DakEdit.htm";
	}
	
	@RequestMapping(value = "DakEditDeleteAttach.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
	public String DakEditDeleteAttachment(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
	{
		logger.info(new Date() +"Inside DeleteAttachment "+ req.getUserPrincipal().getName());
		try
		{
			String dakid = req.getParameter("DakId");
			String dakattachmentid=req.getParameter("dakattachmentid");
			Object[] dakattachmentdata =service.DakAttachmentData(dakattachmentid);
			File my_file=null;
			String dakattachdata = dakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = dakattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+dakattachmentdata[1]);
			boolean result = Files.deleteIfExists(my_file.toPath());
			if(result) 
			{
				service.DeleteAttachment(dakattachmentid);
				redir.addAttribute("result","Document Deleted Successfully");
			}
			else
			{
				redir.addAttribute("resultfail","Document Delete Unsuccessful");
			}
			redir.addAttribute("Dakid", dakid);
		}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside DownloadAttachDak "+ req.getUserPrincipal().getName(),e);
		}
		
		return "redirect:/DakEdit.htm";
	}
	
	
	
	
	@RequestMapping(value = "GetAttachmentDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String GetAttachmentDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
	{
		
		logger.info(new Date() +"Inside GetAttachmentDetails.htm "+req.getUserPrincipal().getName());
				
		List<Object[]> AttachmentData =new ArrayList<Object[]>();
		try {
		
			AttachmentData = service.GetAttachmentDetails(Long.parseLong(req.getParameter("dakid")),req.getParameter("attachtype"));
			req.setAttribute("AttachmentData", AttachmentData);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetOtherItemsListAjax.htm "+req.getUserPrincipal().getName(), e);
		}
		Gson json = new Gson();
		return json.toJson(AttachmentData);
	}
	
	@RequestMapping(value = "DownloadAttach.htm" , method = {RequestMethod.GET,RequestMethod.POST})
	public void DownloadAttachDak(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{

		logger.info(new Date() +"Inside DownloadAttachDak "+ req.getUserPrincipal().getName());
		try
		{
			String dakattachmentid=req.getParameter("downloadbtn");
			res.setContentType("Application/octet-stream");	
			Object[] dakattachmentdata =service.DakAttachmentData(dakattachmentid);
			File my_file=null;

			String dakattachdata = dakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = dakattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+dakattachmentdata[1]);
	        res.setHeader("Content-disposition", "inline; filename=" + dakattachmentdata[1].toString()); // Set the disposition to "inline" to open the file in a new tab
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0){
	           out.write(buffer, 0, length);
	        }
	        in.close();
	        out.flush();
			
		}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside DownloadAttachDak "+ req.getUserPrincipal().getName(),e);
		}
	}
	@RequestMapping(value = "OpenAttachForDownload.htm", method = {RequestMethod.GET, RequestMethod.POST})
	public void OpenAttachDak(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
	    try {
	        String dakattachmentid = req.getParameter("downloadbtn");
	        Object[] dakattachmentdata = service.DakAttachmentData(dakattachmentid);
	        File my_file = null;
	        
	        String dakattachdata = dakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = dakattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+dakattachmentdata[1]);
	         res.setHeader("Content-disposition", "inline; filename=" + dakattachmentdata[1].toString());
	        
	        String mimeType = getMimeType(my_file.getName()); // Get the appropriate MIME type based on the file extension
	        res.setContentType(mimeType);
	        
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0) {
	            out.write(buffer, 0, length);
	        }
	        in.close();
	        out.flush();
	    } catch (Exception e) {
	        e.printStackTrace();
	        logger.error(new Date() + "Inside OpenAttachDak " + req.getUserPrincipal().getName(), e);
	    }
	}
	private String getMimeType(String filename) {
	    String extension = filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
	    switch (extension) {
	        case "pdf":
	            return "application/pdf";
	        case "doc":
	            return "application/msword";
	        case "docx":
	            return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
	        case "xls":
	            return "application/vnd.ms-excel";
	        case "xlsx":
	            return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
	        case "png":
	            return "application/png";
	        // Add more mappings for other file types as needed
	        default:
	            return "application/octet-stream";
	    }
	}
	
	
	@RequestMapping(value = "DeleteAttach.htm" , method = {RequestMethod.GET,RequestMethod.POST})
	public String DeleteAttachment(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
	{

		logger.info(new Date() +"Inside DeleteAttachment "+ req.getUserPrincipal().getName());
		String DakId=null;
		try
		{

			String dakattachmentid=req.getParameter("dakattachmentid");
			Object[] dakattachmentdata =service.DakAttachmentData(dakattachmentid);
			DakId=dakattachmentdata[2].toString();
			File my_file=null;
			String dakattachdata = dakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = dakattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+dakattachmentdata[1]);
			boolean result = Files.deleteIfExists(my_file.toPath());
			if(result) 
			{
				service.DeleteAttachment(dakattachmentid);
				redir.addAttribute("result","Document Deleted Successfully");
			}
			else
			{
				redir.addAttribute("resultfail","Document Delete Unsuccessful");
			}
			
			
		}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside DownloadAttachDak "+ req.getUserPrincipal().getName(),e);
		}
		
		String PageNumber=req.getParameter("PageNumber");
		String RowNumber=req.getParameter("RowNumber");
		
		redir.addAttribute("PageNumber", PageNumber);
		redir.addAttribute("RowNumber", RowNumber);
		
		//redirection code due to common usage in DAK Pending List & DAK Director List
		String fromDate = (String) req.getParameter("fromDateFrmDE");
		String toDate = (String) req.getParameter("toDateFrmDE");
		if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
		    try {
		        fromDate = rdf.format(sdf2.parse(fromDate));
		        toDate = rdf.format(sdf2.parse(toDate));
		        redir.addAttribute("FromDate", fromDate);
		        redir.addAttribute("ToDate", toDate);
		    } catch (ParseException e) {
		        e.printStackTrace();
		        // Handle the exception appropriately (e.g., log the error or provide a default value).
		    }
		}
		String redirectVal= null;
		redirectVal = req.getParameter("redirectValueFrDelAttach");
		if(redirectVal!=null && redirectVal.equalsIgnoreCase("DakDirectorList")) {
			return "redirect:/DakDirectorList.htm";
		 }else if(redirectVal!=null && "DakDetailedList".equalsIgnoreCase(redirectVal)) {
	        	return "redirect:/DakList.htm";
		 }else if(redirectVal!=null && "DakViewList".equalsIgnoreCase(redirectVal)) {
			 redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
			 redir.addAttribute("DakId", DakId);
			 return "redirect:/DakReceivedView.htm";
			}else {
				return "redirect:/DakInitiationList.htm";
			}

	}


	
	@RequestMapping(value = "getMarkedList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String getMarkedList(HttpServletRequest req,HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside getMarkedList "+ req.getUserPrincipal().getName());
				
		List<Object[]> MarkedList = service.DakMarkedList(req.getParameter("dakId"));
		Gson json = new Gson();
		return json.toJson(MarkedList);
	
	}
	

	
	 @RequestMapping(value="dakMember.htm" ,method= {RequestMethod.GET,RequestMethod.POST})
		public String dakMemberMaster(HttpServletRequest request,HttpServletResponse res,HttpSession ses) throws Exception{
	         String MemberType=request.getParameter("MemberType");
	         String member=request.getParameter("Employee");
             String LabCode = (String) ses.getAttribute("LabCode");
	         
	         if(MemberType!=null && member!=null) {
	        	 request.setAttribute("memberType", service.getAllMemberType());
	        	 request.setAttribute("EmpList",  service.getAllMemberList(Integer.parseInt(MemberType),member,LabCode));
	         	 request.setAttribute("MemberList",  service.getAllMemberList2(Integer.parseInt(MemberType)));
	         	 request.setAttribute("type",MemberType);
	         	 request.setAttribute("member",member);
	         	  
	         }else {
	    	     request.setAttribute("memberType", service.getAllMemberType());
	             request.setAttribute("EmpList",  service.getAllMemberList(1,"1",LabCode));
	    	     request.setAttribute("MemberList",  service.getAllMemberList2(1));
	    	     request.setAttribute("type","1");
	         }
			return "dak/dakMember";
		}
	    
	    @RequestMapping(value="addDakmember.htm" ,method= {RequestMethod.POST,RequestMethod.GET})
	   	public String addDakMember(HttpServletRequest request,RedirectAttributes rAtt,HttpSession ses) throws Exception{
	    	String UserName = (String) ses.getAttribute("Username");
	    	String memberType=request.getParameter("MemberType");
	    	String member=request.getParameter("Employee");
	    	long Status=service.addDakMember(memberType,member,UserName);
	    	if(Status>0)
	    	{
	    		rAtt.addAttribute("Status", "DAK Member Added Successfully");
	    	}
	    	else
	    	{
	    		rAtt.addAttribute("StatusFail", "DAK Member Added UnSuccessfully");
	    	}
	    	rAtt.addAttribute("MemberType", memberType);
	    	rAtt.addAttribute("Employee", member);

	    	return "redirect:/dakMember.htm";
	    }
	    
	    @RequestMapping(value = "revokeMember.htm")
		public @ResponseBody String revokeMember(HttpServletRequest request,HttpServletResponse res,HttpSession ses) throws Exception {
	    	String UserName = (String) ses.getAttribute("Username");
			String DakMembersId = request.getParameter("DakMembersId");   
			String project = request.getParameter("project");
			List<Object[]> data = new ArrayList<>();
				int Status = service.RevokeMember(DakMembersId,UserName);
				if(Status>0)
				{
					data = service.getAllMemberList2(Integer.parseInt(project));
				}
				Gson json = new Gson();
				return json.toJson(data);
	    }
	    
	    @RequestMapping(value = "dakMemberAjax.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String dakMemberAjax(HttpServletRequest request,HttpServletResponse res) throws Exception {
			String project = request.getParameter("project");

			List<Object[]> data = new ArrayList<>();
				data = service.getAllMemberList2(Integer.parseInt(project));
				Gson json = new Gson();
				return json.toJson(data);
	    }
	    
	    @RequestMapping(value = "getSelectEmpList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	  	public @ResponseBody String getSelectEmpList(HttpServletRequest request,HttpServletResponse resp,HttpSession ses) throws Exception {
	    	
	  			String empid[] = request.getParameterValues("empId[]");
	  			String LabCode = (String) ses.getAttribute("LabCode");
	  			List<Object[]> data = new ArrayList<>();
	  			if(empid!=null)
	  				data = service.getSelectEmpList(empid,LabCode);
	  			Gson json = new Gson();
	  			return json.toJson(data);
	  	    }
	    
	    
	    
	    @RequestMapping(value = "getIndiMarkedEmpIdsFrmDakId.htm", method = {RequestMethod.GET,RequestMethod.POST})
	  	public @ResponseBody String getIndiMarkedEmpIdsFrmDakId(HttpServletRequest request,HttpServletResponse resp,HttpSession ses) throws Exception {
	    	
	    	String dakid = request.getParameter("DakId");
	    	List<Object[]> data = null;
	    	Gson json = new Gson();
            if(dakid!=null) {
  			data = new ArrayList<>();
  				data = service.getIndiMarkedEmpIdsFrmDakId(Long.parseLong(dakid));
  				
            }
            return json.toJson(data);
	  	    }
	    
	    
	    
	    @RequestMapping(value = "getSelectDakEditList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	  	public @ResponseBody String getSelectDakEditList(HttpServletRequest request,HttpServletResponse res) throws Exception {
	  			String dakid = request.getParameter("dakId");

	  			List<Object[]> data = new ArrayList<>();
	  				data = service.getSelectDakEditList(dakid);
	  				Gson json = new Gson();
	  				return json.toJson(data);
	  	    }


		@RequestMapping(value = "GetReplyAttachmentDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetReplyAttachmentDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside GetReplyAttachmentDetails.htm "+req.getUserPrincipal().getName());
					
			List<Object[]> AttachmentData =new ArrayList<Object[]>();
			try {
			
				AttachmentData = service.getReplyAttachDetails((Long.parseLong(req.getParameter("dakid"))),(Long)ses.getAttribute("EmpId"),req.getParameter("attachtype"));
				req.setAttribute("AttachmentData", AttachmentData);
				
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetReplyAttachmentDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(AttachmentData);
		}
		
		
		@RequestMapping(value = "DownloadReplyAttach.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public void DownloadAttachReply(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
		{

			logger.info(new Date() +"Inside DownloadAttachReply "+ req.getUserPrincipal().getName());
			try
			{
			
				String replyattachmentid=req.getParameter("downloadbtn");
				res.setContentType("Application/octet-stream");	
				Object[] dakattachmentdata =service.DakReplyAttachmentData(replyattachmentid);
				File my_file=null;
				String dakattachdata = dakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
	    		String[] fileParts = dakattachdata.split(",");
				my_file = new File(fileParts[0]+File.separator+fileParts[1]+File.separator+dakattachmentdata[1]); 
		        res.setHeader("Content-disposition","attachment; filename="+dakattachmentdata[1].toString()); 
		        OutputStream out = res.getOutputStream();
		        FileInputStream in = new FileInputStream(my_file);
		        byte[] buffer = new byte[4096];
		        int length;
		        while ((length = in.read(buffer)) > 0){
		           out.write(buffer, 0, length);
		        }
		        in.close();
		        out.flush();
				
			}catch (Exception e) {
					e.printStackTrace(); 
					logger.error(new Date() +"Inside DownloadAttachReply "+ req.getUserPrincipal().getName(),e);
			}
		}
			
		@RequestMapping(value = "MailIntRecieved.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String MailRecieved(HttpSession ses ,HttpServletRequest req,RedirectAttributes redir) throws Exception {
		String date=req.getParameter("dt");
		MailReciever  mr=new MailReciever();
		MailConnectDto connect=new MailConnectDto();
		connect.setHost(env.getProperty("mail_host"));
		connect.setPassword(env.getProperty("mail_password"));
		connect.setUsername(env.getProperty("mail_username"));
		connect.setProtocol(env.getProperty("mail_protocol"));
		connect.setPort(env.getProperty("mail_port"));
		connect.setPath(env.getProperty("file_upload_path"));
		connect.setMailType("I");
		connect.setFolder("Inbox");
		if(date!=null) {
			connect.setMailDate(sdf.parse(date));
		}else {
			date=sdf.format(new Date());
			connect.setMailDate(new Date());
		}
			List<MailDto> mailAll=mr.mail(connect);
			//service.DakMailInsert(mailAll,req.getUserPrincipal().getName());
		    redir.addAttribute("dt",date);
			return "redirect:/MailIntList.htm";
		}
		
		
		@RequestMapping(value = "MailIntSent.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String MailSent(HttpSession ses ,HttpServletRequest req,RedirectAttributes redir) throws Exception {
		String date=req.getParameter("dt");
		MailReciever  mr=new MailReciever();
		MailConnectDto connect=new MailConnectDto();
		connect.setHost(env.getProperty("mail_host"));
		connect.setPassword(env.getProperty("mail_password"));
		connect.setUsername(env.getProperty("mail_username"));
		connect.setProtocol(env.getProperty("mail_protocol"));
		connect.setPort(env.getProperty("mail_port"));
		connect.setPath(env.getProperty("file_upload_path"));
		connect.setMailType("I");
		connect.setFolder("[Gmail]/Sent Mail");
		if(date!=null) {
			connect.setMailDate(sdf.parse(date));
		}else {
			date=sdf.format(new Date());
			connect.setMailDate(new Date());
		}
		List<MailDto> mailAll=mr.mail(connect);
		//service.DakMailSentInsert(mailAll,req.getUserPrincipal().getName());
		    redir.addAttribute("dt",date);
			return "redirect:/SentIntList.htm";
		}
		
		@RequestMapping(value = "MailExtRecieved.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String MailExtRecieved(HttpSession ses ,HttpServletRequest req,RedirectAttributes redir) throws Exception {
		String date=req.getParameter("dt");
		MailReciever  mr=new MailReciever();
		MailConnectDto connect=new MailConnectDto();
		connect.setHost(env.getProperty("ext_host"));
		connect.setPassword(env.getProperty("ext_password"));
		connect.setUsername(env.getProperty("ext_username"));
		connect.setProtocol(env.getProperty("ext_protocol"));
		connect.setPort(env.getProperty("ext_port"));
		connect.setPath(env.getProperty("file_upload_path"));
		connect.setMailType("E");
		connect.setFolder("Inbox");
		if(date!=null) {
			connect.setMailDate(sdf.parse(date));
		}else {
			date=sdf.format(new Date());
			connect.setMailDate(new Date());
		}
		
		List<MailDto> mailAll=mr.mail(connect);
		
		//service.DakMailInsert(mailAll,req.getUserPrincipal().getName());
	    redir.addAttribute("dt",date);
		return "redirect:/MailExtList.htm";

	}
		
		@RequestMapping(value = "MailIntList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String MailIntList(HttpSession ses ,HttpServletRequest req) throws Exception {
		  String date=req.getParameter("dt");
	      //req.setAttribute("MailList",service.DakMailList(date!=null?sdf.parse(date):new Date(),"I"));
	      req.setAttribute("dt",date!=null?date:sdf.format(new Date()));
			return "mail/MailIntList";

		}
		
		@RequestMapping(value = "MailExtList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String MailExtList(HttpSession ses ,HttpServletRequest req) throws Exception {
		  String date=req.getParameter("dt");
	     // req.setAttribute("MailList",service.DakMailList(date!=null?sdf.parse(date):new Date(),"E"));
	      req.setAttribute("dt",date!=null?date:sdf.format(new Date()));
			return "mail/MailExtList";

		}
		
		@RequestMapping(value = "DownloadMailAttach.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public void DownloadMailAttach(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
		{
			logger.info(new Date() +"Inside DownloadMailAttach.htm "+ req.getUserPrincipal().getName());
			try
			{
				String fileName=req.getParameter("fileName");
				res.setContentType("Application/octet-stream");	
				File my_file=null;
				my_file = new File(env.getProperty("file_upload_path")+File.separator+fileName); 
		        res.setHeader("Content-disposition","attachment; filename="+fileName); 
		        OutputStream out = res.getOutputStream();
		        FileInputStream in = new FileInputStream(my_file);
		        byte[] buffer = new byte[4096];
		        int length;
		        while ((length = in.read(buffer)) > 0){
		           out.write(buffer, 0, length);
		        }
		        in.close();
		        out.flush();
				
			}catch (Exception e) {
					e.printStackTrace(); 
					logger.error(new Date() +"Inside DownloadMailAttach.htm "+ req.getUserPrincipal().getName(),e);
			}
		}
		
		
		
		@RequestMapping(value = "getMailContent.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getMailContent(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getMailContent.htm "+req.getUserPrincipal().getName());
			String AttachmentData =null;
			try {
				MailReciever  mr=new MailReciever();
				MailConnectDto connect=new MailConnectDto();
				connect.setHost(env.getProperty("mail_host"));
				connect.setPassword(env.getProperty("mail_password"));
				connect.setUsername(env.getProperty("mail_username"));
				connect.setProtocol(env.getProperty("mail_protocol"));
				connect.setPort(env.getProperty("mail_port"));
				connect.setFolder("Inbox");
				connect.setMailType(req.getParameter("messageid"));
				AttachmentData=mr.mailById(connect);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getMailContent.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(AttachmentData);
		}
		
		
		
		@RequestMapping(value = "getMailExtContent.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getMailExtContent(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getMailContent.htm "+req.getUserPrincipal().getName());
			String AttachmentData =null;
			try {
				MailReciever  mr=new MailReciever();
				MailConnectDto connect=new MailConnectDto();
				connect.setHost(env.getProperty("ext_host"));
				connect.setPassword(env.getProperty("ext_password"));
				connect.setUsername(env.getProperty("ext_username"));
				connect.setProtocol(env.getProperty("ext_protocol"));
				connect.setPort(env.getProperty("ext_port"));
				connect.setFolder("Inbox");
				connect.setMailType(req.getParameter("messageid"));
				AttachmentData=mr.mailById(connect);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getMailExtContent.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(AttachmentData);
		}
		
		@RequestMapping(value = "SentIntList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String SentIntList(HttpSession ses ,HttpServletRequest req) throws Exception {
		  String date=req.getParameter("dt");
	     // req.setAttribute("SentList",service.DakMailSentList(date!=null?sdf.parse(date):new Date(),"I"));
	      req.setAttribute("dt",date!=null?date:sdf.format(new Date()));
			return "mail/SentIntList";

		}
		
		@RequestMapping(value = "getMailSentContent.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String getMailSentContent(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getMailSentContent.htm "+req.getUserPrincipal().getName());
			String AttachmentData =null;
			try {
				MailReciever  mr=new MailReciever();
				MailConnectDto connect=new MailConnectDto();
				connect.setHost(env.getProperty("mail_host"));
				connect.setPassword(env.getProperty("mail_password"));
				connect.setUsername(env.getProperty("mail_username"));
				connect.setProtocol(env.getProperty("mail_protocol"));
				connect.setPort(env.getProperty("mail_port"));
				connect.setFolder("[Gmail]/Sent Mail");
				connect.setMailType(req.getParameter("messageid"));
				AttachmentData=mr.mailById(connect);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getMailSentContent.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(AttachmentData);
		}
		
		
		@RequestMapping(value = "DakReceivedList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakRecievedList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses)  throws Exception{
			logger.info(new Date() +" In CONTROLLER DakReceivedList.htm "+req.getUserPrincipal().getName());
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				String Username=req.getUserPrincipal().getName();
	  			Object[] UserName= null;
				UserName=service.getUsername(EmpId);
				Date date = new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String StatusValue = (String)req.getParameter("StatusFilterVal");
				if(StatusValue == null) {
					StatusValue = "All";
				}
				String PageNoRedirected=(String)req.getParameter("PageNoData");
				String RowRedirected=(String)req.getParameter("RowData");
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -7); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				String LabCode = (String) ses.getAttribute("LabCode");
				Object DivisionId=service.getDivisionId(EmpId);
				long divisionId=Long.parseLong(DivisionId.toString());
				List<Object[]> InitiatedByEmployeeList=service.InitiatedByEmployeeList(divisionId,LabCode);
				Object[] MailSentDetails=service.MailSentDetails("D");
				//List<Object[]> MailReceivedEmpDetails=service.MailReceivedEmpDetails(EmpId);
				req.setAttribute("MailSentDetails", MailSentDetails);
				//req.setAttribute("MailReceivedEmpDetails", MailReceivedEmpDetails);
				req.setAttribute("InitiatedByEmployeeList", InitiatedByEmployeeList);
				req.setAttribute("Username", UserName);
				req.setAttribute("EmpId",   String.valueOf(EmpId));
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("statusValue", StatusValue);
				req.setAttribute("SourceList",service.SourceList());
				req.setAttribute("FileName", "res.docx");
				req.setAttribute("pageNoRedirected", PageNoRedirected);
				req.setAttribute("rowRedirected",   RowRedirected);
				req.setAttribute("dakReceivedList", service.dakReceivedList(fromDate,toDate,StatusValue,EmpId,Username));
				return "dak/dakReceivedList";
			} catch (Exception e) {
				logger.error(new Date() +" In CONTROLLER DakReceivedList.htm "+req.getUserPrincipal().getName()+"  "+e);
				return "static/Error";
				
			}
		}

		@RequestMapping(value = "getEmpListForAssigning.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String  getEmpListForAssigning(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getEmpListForAssigning.htm "+req.getUserPrincipal().getName());
			List<Object[]>  getEmpListForAssigning=null;
			long EmpId=(Long)ses.getAttribute("EmpId");
			String LabCode = (String) ses.getAttribute("LabCode");
			try {
				String dakId=(String)req.getParameter("dakid");
				if(dakId!=null) {
				getEmpListForAssigning=service.getEmpListForAssigning(Long.parseLong(dakId), LabCode,  EmpId);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getEmpListForAssigning.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson( getEmpListForAssigning);
		}
		
		
		
		@RequestMapping(value = "DakReceivedView.htm", method = {RequestMethod.GET, RequestMethod.POST})
		public String DakReceivedView(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) throws Exception{
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				long DakId=(Long.parseLong(req.getParameter("DakId")));
				String viewfrom=req.getParameter("viewfrom");
				String repliedReply=req.getParameter("repliedReply");
				String fromDateFetch=req.getParameter("fromDateFetch");
				String toDateFetch=req.getParameter("toDateFetch");
				List<Object[]> AssignData=service.AssignData(DakId,EmpId);
				List<Object[]> SeekResponseData=service.SeekResponseData(DakId,EmpId);
				List<Object[]> MarkerData=service.MarkerData(DakId,EmpId);
				if(MarkerData!=null && !MarkerData.isEmpty() && MarkerData.size()>0) {
					Object[] MarkData=MarkerData.get(0);
					req.setAttribute("MarkData", MarkData);
					
				}
				if(AssignData!=null && !AssignData.isEmpty() && AssignData.size()>0) {
					Object[] assigneddata=AssignData.get(0);
					req.setAttribute("assigneddata", assigneddata);		
					
					}
				if(SeekResponseData!=null && !SeekResponseData.isEmpty() && SeekResponseData.size()>0) {
					Object[] seekdata=SeekResponseData.get(0);
					req.setAttribute("seekdata", seekdata);		
				}
				Object[] MailSentDetails=service.MailSentDetails("D");
				//List<Object[]> MailReceivedEmpDetails=service.MailReceivedEmpDetails(EmpId);
				req.setAttribute("MailSentDetails", MailSentDetails);
				//req.setAttribute("MailReceivedEmpDetails", MailReceivedEmpDetails);
				req.setAttribute("fromDateFetch", fromDateFetch);
				req.setAttribute("toDateFetch", toDateFetch);
				req.setAttribute("viewfrom", viewfrom);
				req.setAttribute("repliedReply", repliedReply);
				req.setAttribute("actionList",service.getActionList());
				req.setAttribute("dakClosingAuthorityList",service.closingAuthorityList());
				req.setAttribute("dakReceivedList", service.dakReceivedViewrecived(EmpId,DakId));
				return "dak/dakReceivedView";
			} catch (Exception e) {
				logger.error(new Date() +" In CONTROLLER DakReceivedView.htm "+req.getUserPrincipal().getName()+"  "+e);
				return "static/Error";
			}
		}
		
		
		@RequestMapping(value = "getDistributedEmps.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDistributedEmps(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getDistributedEmps.htm "+req.getUserPrincipal().getName());
			List<Object[]> getDistributedEmps=null;
			try {
				String dakId=(String)req.getParameter("dakId");
				getDistributedEmps=service.getDistributedEmps(dakId);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDistributedEmps.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getDistributedEmps);
		}
		
		
		@RequestMapping(value = "getReDistributedEmps.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getReDistributedEmps(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getReDistributedEmps.htm "+req.getUserPrincipal().getName());
			List<Object[]> getDistributedEmps=null;
			try {
				String dakId=(String)req.getParameter("dakId");
				getDistributedEmps=service.getReDistributedEmps(dakId);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getReDistributedEmps.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getDistributedEmps);
		}
		
		
		@RequestMapping(value = "DakDistribute.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakDistribute(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception {
			String fromDate=(String)req.getParameter("FromDate");
			String toDate=(String)req.getParameter("ToDate");
			String PageNumber=req.getParameter("PageNumber");
			String RowNumber=req.getParameter("RowNumber");
			try {
				String username=req.getUserPrincipal().getName();
				long loggedInEmpId=(Long)ses.getAttribute("EmpId");
				String dakId=(String)req.getParameter("dakId");
			    String a=req.getParameter("EmpIdDistribute");
			    String b=req.getParameter("markedAction");
			    String []selectedCheck=b.split(",");
				String []EmpId=a.split(",");
				String date=sdf1.format(new Date());
				 if(fromDate!=null || toDate != null) {
					 try {
						 fromDate=rdf.format(sdf2.parse(fromDate));
						 toDate=rdf.format(sdf2.parse(toDate)); 
						 redir.addAttribute("FromDate", fromDate);
						 redir.addAttribute("ToDate",   toDate);
					 }catch (ParseException e) {
						 e.printStackTrace();
					 }
					 }
				long DakDistribute = service.DakDistribute(dakId,date,EmpId,loggedInEmpId,username,selectedCheck);
				if(DakDistribute>0) {
					redir.addAttribute("result", "DAK Distributed Successfully");
				}else {
					redir.addAttribute("resultfail", "DAK Distributed Unsuccessful");
				}
		//START////////ONLY WHEN PRIORITY IS URGENT DIRECT MAIL otherwise 4:30 scheduler will send///////////////			
					String Priority = service.getPriorityOfParticularDak(Long.parseLong(dakId));
					if(Priority !=null && "Urgent".equalsIgnoreCase(Priority.trim()) && DakDistribute >0) {
					   	service.SendMailForMarkers(dakId,loggedInEmpId);
					//Initiate the sending of emails asynchronously and continue processing without waiting for the emails to be sent
					//long DakMailResult =  service.SendMailForMarkers(dakId,loggedInEmpId);
					//if(DakSendMail==1) {  redir.addAttribute("Mail Sent Successfully !");
			       //}else if( DakSendMail==0) { redir.addAttribute("resultfail", " Mail Sending Unsuccessful.");
			       //}else if( DakSendMail==-2) { redir.addAttribute("resultfail", "  Host Email Authentication Failed, Unable to Send Mail..");	
			       //}else if( DakSendMail==-3) { redir.addAttribute("resultfail", "  Email ID's not found...");	
					 
				    }
		//END////////		
				
					redir.addAttribute("PageNumber",PageNumber);
					redir.addAttribute("RowNumber",RowNumber);
					
			} catch (Exception e) {
				e.printStackTrace();
			}

			String redirectVal = null;
			redirectVal=(String)req.getParameter("ActionDataDistribute");
			if(redirectVal!=null && "DakDirectorList".equalsIgnoreCase(redirectVal)) {
				return "redirect:/DakDirectorList.htm";
			}else if(redirectVal!=null && "DakDetailedList".equalsIgnoreCase(redirectVal)) {
				return "redirect:/DakList.htm";
			}else if(redirectVal!=null && "DakViewList".equalsIgnoreCase(redirectVal)) {
				redir.addAttribute("DakId", req.getParameter("dakId"));
				redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				return "redirect:/DakReceivedView.htm";
			}else {
				return "redirect:/DakInitiationList.htm";
			}
			
		}
		
		
		@RequestMapping(value = "getSelectSourceTypeList.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getSelectSourceTypeList(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside getSelectSourceTypeList.htm "+req.getUserPrincipal().getName());
			List<Object[]> getSelectSourceTypeList=null;
			try {
				String SourceId=(String)req.getParameter("SourceId");
				getSelectSourceTypeList=service.getSelectSourceTypeList(SourceId);
				
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getSelectSourceTypeList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getSelectSourceTypeList);
		}
		
		
		@RequestMapping(value = "getDakDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDakDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside getDakDetails.htm "+req.getUserPrincipal().getName());
			Object[] dakReceivedView=null;
			try {
				
				String value=req.getParameter("DakId");
				long EmpId=(Long)ses.getAttribute("EmpId");
				long DakId=(Long.parseLong(value));
				dakReceivedView=service.dakReceivedView(EmpId,DakId);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDakDetails.htm "+req.getUserPrincipal().getName(), e);
			
			}
			 if (dakReceivedView != null) {
				     Gson json = new Gson();
			        return json.toJson(dakReceivedView);
			    } else {
			       
			        return null; // or return an appropriate response indicating the null object
			    }
		
		}
		
		
		@RequestMapping(value = "DakAck.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakAck(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception {
			String PageNo = null;
			String Row = null;
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				long dakIdSel=(Long.parseLong(req.getParameter("dakIdSel")));
				long DakAck=service.DakAck(EmpId,dakIdSel,sdf1.format(new Date()));
			
				String PageName = "RedirPageNo"+dakIdSel;
				PageNo = req.getParameter(PageName);
				String RowName = "RedirRow"+dakIdSel;
				Row = req.getParameter(RowName);

				if(DakAck>0) {
					 DakMain DakDetails = service.GetDakDetails(dakIdSel); 
	
					long TotalEmpIdCount=service.EmpIdCountOfDM(dakIdSel);
					long TotalDakAckCount=service.DakAckCountOfDM(dakIdSel);
					if(TotalEmpIdCount==TotalDakAckCount && DakDetails.getDakStatus()!=null 
							&& !DakDetails.getDakStatus().equalsIgnoreCase("DR") && !DakDetails.getDakStatus().equalsIgnoreCase("RP") && !DakDetails.getDakStatus().equalsIgnoreCase("AP") && !DakDetails.getDakStatus().equalsIgnoreCase("RM")  ) {
		
					service.UpdateDakStatus(dakIdSel);
					}
					redir.addAttribute("result", "DAK Acknowledged Successfully");
				}else {
					redir.addAttribute("resultfail", "DAK Acknowledged Unsuccessful");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			//redirection
			 redir.addAttribute("PageNoData", PageNo);
			 redir.addAttribute("RowData", Row);
		    
			 String fromDate=(String)req.getParameter("fromDateFetch");
		     String toDate=(String)req.getParameter("toDateFetch");
		     if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) {
			        e.printStackTrace();
			        // Handle the exception appropriately (e.g., log the error or provide a default value).
			    }
			}
			
			//redirect val from dak Pending list
			String RedirectVal=(String)req.getParameter("RedirectValFrmPending");
			if(RedirectVal!=null && RedirectVal.equalsIgnoreCase("RedirToDakPendReply")){
				return "redirect:/DakPendingReplyList.htm";
			}else {
				return "redirect:/DakReceivedList.htm";
			}
		
		}
		
		
		
		
		@RequestMapping(value = "DakMark.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakMark(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir)
		{
			logger.info(new Date() +"DakMark.htm"+req.getUserPrincipal().getName());
			try {
				
				
				String DakMarkingActionDueDate=req.getParameter("DakMarkingActionDueDate");
				String DakMarkingId=req.getParameter("DakMarkingId");
				String DakMarkingAction=req.getParameter("DakMarkingAction");
				String DakMarkingActionRequired=req.getParameter("DakMarkingActionRequired");
				long result=0;
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				
				 if(fromDate!=null || toDate != null) {
					 try {
						 fromDate=rdf.format(sdf2.parse(fromDate));
						 toDate=rdf.format(sdf2.parse(toDate)); 
						 redir.addAttribute("FromDate", fromDate);
						 redir.addAttribute("ToDate",   toDate);
					 }catch (ParseException e) {
						 e.printStackTrace();
					 }
					 }
				String markedEmps[]=(String[])req.getParameterValues("empid");
				String GroupMarkingData=req.getParameter("CommonEmpIdGroup");
				String FinalEmp[] = null;
				int resultArrayCheck = 0;
				  
				if (GroupMarkingData != null && !GroupMarkingData.trim().equals("") && markedEmps == null)
	             {//WHEN markedEmps IS NULL
			        	   String GroupMarkingEmps[]=GroupMarkingData.split(",");
		                   int finalLength = GroupMarkingEmps.length;
		                   FinalEmp = new String[finalLength];
					       System.arraycopy(GroupMarkingEmps, 0, FinalEmp, 0, GroupMarkingEmps.length);
					       resultArrayCheck = 1;
			        	  
	             }else if(markedEmps!=null  && GroupMarkingData.trim().equals("") ) {//WHEN GroupMarkingData IS NULL
			                   int finalLength = markedEmps.length;
			                   FinalEmp = new String[finalLength];
						       System.arraycopy(markedEmps, 0, FinalEmp, 0, markedEmps.length);
						       resultArrayCheck = 1;
			        	  
			          }else if(markedEmps!=null && GroupMarkingData!=null  && !GroupMarkingData.trim().equals("")) {//WHEN BOTH ARE NOT NULL
			        	  String GroupMarkingEmps[]=GroupMarkingData.split(",");
		                   int finalLength = markedEmps.length + GroupMarkingEmps.length;
		                   FinalEmp = new String[finalLength];
					       System.arraycopy(markedEmps, 0, FinalEmp, 0, markedEmps.length);
					       System.arraycopy(GroupMarkingEmps, 0, FinalEmp, markedEmps.length, GroupMarkingEmps.length);
					       resultArrayCheck = 1;
			         
			          }else {//WHEN BOTH ARE NULL
			        	  resultArrayCheck = 0;
			          }
				
			if(resultArrayCheck>0) {

				Map<String, String> empIdToMarkedTypeIdMap = new HashMap<>();
		        // Loop through the array to add empIds to the HashSet and store corresponding markedTypeIds
		        for (int i = 0; i < FinalEmp.length; i++) {
		        	String [] values=FinalEmp[i].split("/");
		            String empId = values[0];
		            String markedTypeId = values[1];
		            // Add the empId to the HashMap to automatically remove duplicates
		            // The last occurrence of empId will override previous entries with the same empId
		            empIdToMarkedTypeIdMap.put(empId, markedTypeId);
		        }

		        // Convert the HashMap to a String[] array
		        String[] resultArray = new String[empIdToMarkedTypeIdMap.size()];
		        int index = 0;
		        for (Map.Entry<String, String> entry : empIdToMarkedTypeIdMap.entrySet()) {
		            String empId = entry.getKey();
		            String markedTypeId = entry.getValue();
		            String entryString = empId + "," + markedTypeId;
		            resultArray[index] = entryString;
		            index++;
		        }
				
				
				
				for(int i=0;i<resultArray.length;i++) {
		       		 String[] EmpandMarkingValues = resultArray[i].split(",");

		       		 String empId = EmpandMarkingValues[0];
		       		 String markedTypeId = EmpandMarkingValues[1];
		       		 
		       	DakMarking marking=new DakMarking();
		       	marking.setDakId(Long.parseLong(DakMarkingId));
		       	marking.setEmpId(Long.parseLong(empId));
		       	marking.setDakMemberTypeId(Long.parseLong(markedTypeId));
		       	marking.setActionId(Long.parseLong(DakMarkingAction));
		       	if(DakMarkingActionRequired.trim().equalsIgnoreCase("ACTION")) {
		       	marking.setReplyOpen("Y");
		       	}else {
		       		marking.setReplyOpen("N");
		       	}
		       	marking.setRemarkup("N");
		       	if(DakMarkingActionDueDate!=null && !DakMarkingActionDueDate.equalsIgnoreCase("null")) {
		       		marking.setActionDueDate(new java.sql.Date(sdf2.parse(req.getParameter("DakMarkingActionDueDate")).getTime()));	
		       	}
		        marking.setDakAckStatus("N");
		        marking.setDakAssignStatus("N");
		        marking.setMsgType("N");
		       	marking.setCreatedBy(req.getUserPrincipal().getName());
		       	marking.setCreatedDate(sdf1.format(new Date()));
		       	marking.setIsActive(1);
		       	
		       	result=service.getDakMarkingInsert(marking);
				}
				
			}else {
				result = -1;
			}
				if(result>0) 
				{
					redir.addAttribute("result","DAK Marked Successfully");
				}else if(result == -1)
				{
					redir.addAttribute("resultfail","At least one employee should be chosen.");
				}else {
					redir.addAttribute("resultfail","DAK Marked Unsuccessful");
				}
				
				
				//redirection code due to common usage in DAK Pending List & DAK Director List
				String redirectVal = null;
				redirectVal = req.getParameter("RedirectVal");
				if(redirectVal!=null && "DakDirectorList".equalsIgnoreCase(redirectVal)) {
					return "redirect:/DakDirectorList.htm";
		        }else if(redirectVal!=null && "DakDetailedList".equalsIgnoreCase(redirectVal)) {
		        	return "redirect:/DakList.htm";
				}else {
					return "redirect:/DakInitiationList.htm";
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			
		}
		
		@RequestMapping(value = "MarkedEmployeeDelete.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String MarkedEmployeeDelete(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir)
		{
			logger.info(new Date() +"MarkedEmployeeDelete.htm"+req.getUserPrincipal().getName());
			try {
				String dakId=(String)req.getParameter("dakId");
				String empId=(String)req.getParameter("EmpIdForDelete");
				String dakMemberTypeId=(String)req.getParameter("DakMemberTypeIdForDelete");
				String dakMarkingId=(String)req.getParameter("DakMarkingIdForDelete");
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				long deleteResult = 0;
				
				if(fromDate!=null || toDate != null) {
					 try {
						 fromDate=rdf.format(sdf2.parse(fromDate));
						 toDate=rdf.format(sdf2.parse(toDate)); 
						 redir.addAttribute("FromDate", fromDate);
						 redir.addAttribute("ToDate",   toDate);
					 }catch (ParseException e) {
						 e.printStackTrace();
					 }
					 }
				
				if(dakId!=null && empId!=null && dakMemberTypeId!=null && dakMarkingId!=null) {
					
					deleteResult = service.DeleteSelMarkedEmployee(Long.parseLong(dakId),Long.parseLong(empId),Long.parseLong(dakMemberTypeId),Long.parseLong(dakMarkingId));
					
					if(deleteResult>0) {
						redir.addAttribute("result","Marked Employee Delete Successfully ");
					}else {
						redir.addAttribute("resultfail","Marked Employee Delete Unsuccessful ");
					}
				}else {
					    redir.addAttribute("resultfail","Employee not selected for delete.");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +"MarkedEmployeeDelete.htm"+req.getUserPrincipal().getName());
				return null;
			}
			String PageNumber=req.getParameter("PageNumber");
			String RowNumber=req.getParameter("RowNumber");
			
			redir.addAttribute("PageNumber", PageNumber);
			redir.addAttribute("RowNumber",RowNumber);
			//redirection code due to common usage in DAK Pending List & DAK Director List
			String redirectVal = null;
			redirectVal = req.getParameter("ActionDataDistribute");
			if(redirectVal!=null && "DakDirectorList".equalsIgnoreCase(redirectVal)) {
				return "redirect:/DakDirectorList.htm";
	        }else if(redirectVal!=null && "DakDetailedList".equalsIgnoreCase(redirectVal)) {
	        	return "redirect:/DakList.htm";
			}else {
				return "redirect:/DakInitiationList.htm";
			}
			
		}	
		
		
		@RequestMapping(value = "DakDistributedList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakDistributedList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) {
			logger.info(new Date() +"DakDistributedList.htm"+req.getUserPrincipal().getName());
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				Date date=new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -7); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("DakDistributedList", service.DakDistributedList(EmpId,fromDate,toDate));
				
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			return "dak/dakdistributedList";
		}
		
		
//getAssignEmpList.htm removed if required replace with getEmpListForAssigning.htm
		
		@RequestMapping(value = "getoldassignemplist.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getoldassignemplist(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside getoldassignemplist.htm "+req.getUserPrincipal().getName());
			List<Object[]> getOldassignemplist=null;
			try {
				String 	DakId=req.getParameter("DakId");
				if( DakId!=null) {
				getOldassignemplist=service.getOldassignemplist(Long.parseLong(DakId));
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getoldassignemplist.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getOldassignemplist);
		}
		
		
		
		
		@RequestMapping(value = "DakAssign.htm" ,method = {RequestMethod.GET , RequestMethod.POST})
		public String DakAssign(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) {
			logger.info(new Date() +"Inside DakAssign.htm "+req.getUserPrincipal().getName());
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				String DakId=req.getParameter("DakMarkingId");
				String remarks=req.getParameter("remarks");
				String DakCaseWorker[]=req.getParameterValues("DakCaseWorker");
				String DakMarkingIdsel=req.getParameter("DakMarkingIdsel");
				
				String RedirectValue=req.getParameter("RedirectValue");
				
				String redirectedvalue=req.getParameter("redirectedvalue");
				if(redirectedvalue!=null) {
					redir.addAttribute("redirectedvalue", redirectedvalue);
				}
				DakAssignDto dto=new DakAssignDto();
				
				dto.setDakId(Long.parseLong(DakId));
				dto.setDakMarkingId(Long.parseLong(DakMarkingIdsel));
				dto.setRemarks(remarks.trim());
				dto.setReplyStatus("N");
				dto.setCreatedBy(req.getUserPrincipal().getName());
				dto.setCreatedDate(sdf1.format(new Date()));
				dto.setIsActive(1);
				
				long DakAssignInsert=service.DakAssignInsert(dto,DakCaseWorker,EmpId);
				if(DakAssignInsert>0) 
				{
					service.dakAssignstatus(Long.parseLong(DakMarkingIdsel));
					redir.addAttribute("result","DAK Assign Successfully ");
				}
				else
				{
					redir.addAttribute("resultfail","DAK Assign Unsuccessful");
				}
				String PageRedir=(String)req.getParameter("PageRedireData");
				String RowRedir=(String)req.getParameter("RowRedireData");
				redir.addAttribute("PageNoData", PageRedir);
			    redir.addAttribute("RowData", RowRedir);
				String fromDate=(String)req.getParameter("fromDateFetch");
				String toDate=(String)req.getParameter("toDateFetch");
				if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
				    try {
				        fromDate = rdf.format(sdf2.parse(fromDate));
				        toDate = rdf.format(sdf2.parse(toDate));
				        redir.addAttribute("FromDate", fromDate);
				        redir.addAttribute("ToDate", toDate);
				    } catch (ParseException e) {
				        e.printStackTrace();
				    }
				}
				redir.addAttribute("DakId", DakId);
				if(RedirectValue.equalsIgnoreCase("DakReceivedList")) {
				return "redirect:/DakReceivedList.htm";
				}else if(RedirectValue.equalsIgnoreCase("DakReceivedViewList")) {
					redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
					return "redirect:/DakReceivedView.htm";
				}else {
					return "redirect:/DakRepliedList.htm";
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakAssign.htm "+req.getUserPrincipal().getName(), e);
				return null;
			}
			
		}

		
		@RequestMapping(value = "DAKReply.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DakReply(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,
				RedirectAttributes redir,@RequestPart(name = "dak_reply_document", required = false) MultipartFile[] replydocs) throws Exception {
            logger.info(new Date() +"DAKReply.htm"+req.getUserPrincipal().getName());
            long result=0;
            String dakId= null;
			try {
	      	dakId=req.getParameter("dakIdValFrReply");
	     	String empIdReply=req.getParameter("EmpIdValFrValue");
	    	String remarksReply=req.getParameter("replyRemarks").replaceAll("\\s+", " ");
	    	String ReplyPersonSentMail=req.getParameter("ReplyPersonSentMail");
	    	String[] ReplyReceivedMail=req.getParameterValues("ReplyReceivedMail");
	    	String ReplyMailSubject=req.getParameter("ReplyMailSubject");
	    	String HostType=req.getParameter("HostType");
	    	String dakAssignerReAttachs = req.getParameter("AttachmentsFileNames");
	    	String[] FilesReAttached=null;
	    	if (dakAssignerReAttachs != null && !dakAssignerReAttachs.trim().equals(""))
            {
		        	   FilesReAttached=dakAssignerReAttachs.split(",");
            }
	     	DakReplyDto dakReplydto = DakReplyDto.builder().ReplyDocs(replydocs).build();
	     	dakReplydto.setDakId(Long.parseLong(dakId));
	     	dakReplydto.setEmpId(Long.parseLong(empIdReply));
	     	dakReplydto.setReply(remarksReply);
	     	dakReplydto.setCreatedBy(req.getUserPrincipal().getName());
            dakReplydto.setDakAssignerReAttachs(FilesReAttached);
            dakReplydto.setReplyPersonSentMail(ReplyPersonSentMail);
            dakReplydto.setReplyReceivedMail(ReplyReceivedMail);
            dakReplydto.setReplyMailSubject(ReplyMailSubject);
            dakReplydto.setHostType(HostType);
			result=service.insertDakReply(dakReplydto);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DAKReply.htm"+req.getUserPrincipal().getName()+e);
			}
			
			
			if(result>0) {
				 DakMain DakDetails = service.GetDakDetails(Long.parseLong(dakId)); 
				long TotalEmpIdCountInDM=service.EmpIdCountOfDM(Long.parseLong(dakId));//WHO are active
				long TotalDakReplyCountInDR=service.DakReplyCountInDR(Long.parseLong(dakId));
				if(TotalEmpIdCountInDM==TotalDakReplyCountInDR && DakDetails.getDakStatus()!=null 
						&& !DakDetails.getDakStatus().equalsIgnoreCase("RP") && !DakDetails.getDakStatus().equalsIgnoreCase("AP") && !DakDetails.getDakStatus().equalsIgnoreCase("RM")  ) {
				service.UpdateDakStatusToDR(Long.parseLong(dakId));
				}
				redir.addAttribute("result","DAK Replied Successfully ");
			}
			else
			{
				redir.addAttribute("resultfail","DAK Replied Unsuccessful");
			}
			String PageRedir=(String)req.getParameter("PageRedirectData");
			String RowRedir=(String)req.getParameter("RowRedirectData");
			redir.addAttribute("PageNoData", PageRedir);
		    redir.addAttribute("RowData", RowRedir);
			String fromDate=(String)req.getParameter("fromDateFetch");
			String toDate=(String)req.getParameter("toDateFetch");
			if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) {
			        e.printStackTrace();
			    }
			}
			
			String RedirectVal=(String)req.getParameter("RedirectValFrmPending");
			if(RedirectVal!=null && RedirectVal.equalsIgnoreCase("RedirToDakPendReply")){
				return "redirect:/DakPendingReplyList.htm";
			}else if(RedirectVal!=null && RedirectVal.equalsIgnoreCase("RedirToDakRepliedList")) {
				return "redirect:/DakRepliedList.htm";
			}else if(RedirectVal!=null && RedirectVal.equalsIgnoreCase("RedirToDakReceivedList")) {
				return "redirect:/DakReceivedList.htm";
			}else {
				redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				redir.addAttribute("DakId", dakId);
			return "redirect:/DakReceivedView.htm";
			}
		}

		
		@RequestMapping(value = "DakAssignedList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakAssignedList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) {
			 logger.info(new Date() +"DakAssignedList.htm"+req.getUserPrincipal().getName());
			try {
				
				long EmpId=(Long)ses.getAttribute("EmpId");
				long divid=(long)ses.getAttribute("DivisionId");
				String LabCode = (String) ses.getAttribute("LabCode");
				Date date=new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String pageNoRedirected=req.getParameter("PageNoData");
				String rowRedirected=req.getParameter("RowData");
				String EmployeeId=req.getParameter("EmployeeId");
				String redirectedvalue=req.getParameter("redirectedvalue");
				if(redirectedvalue!=null) {
					req.setAttribute("redirectedvalueForward", redirectedvalue);
				}
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -30); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				List<Object[]>  EmpListDropDown=service.EmpListDropDown(LabCode);
				List<Object[]> getProjectassignemplis=null;
				List<Object[]> DakAssignedList=null;
				List<Object[]> DakAssignedByMeList=null;
				if(EmployeeId==null|| EmployeeId.equalsIgnoreCase("All")) {
					req.setAttribute("SelEmpId", "All");
					getProjectassignemplis=service.getseekResponseEmplist(LabCode,EmpId,divid);
					 DakAssignedList=service.getDakAssignedList(EmpId,fromDate,toDate,0);
					 DakAssignedByMeList=service.DakAssignedByMeList(EmpId,fromDate,toDate,0);
				}
				else {
					 getProjectassignemplis=service.getseekResponseEmplist(LabCode,EmpId,divid);
					 DakAssignedList=service.getDakAssignedList(EmpId,fromDate,toDate,Long.parseLong(EmployeeId));
					 DakAssignedByMeList=service.DakAssignedByMeList(EmpId,fromDate,toDate,Long.parseLong(EmployeeId));
					req.setAttribute("SelEmpId", EmployeeId);
				}
				Object DivisionId=service.getDivisionId(EmpId);
				long divisionId=Long.parseLong(DivisionId.toString());
				List<Object[]> InitiatedByEmployeeList=service.InitiatedByEmployeeList(divisionId,LabCode);
				req.setAttribute("InitiatedByEmployeeList", InitiatedByEmployeeList);
				req.setAttribute("SourceList",service.SourceList());
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("pageNoRedirected", pageNoRedirected);
				req.setAttribute("rowRedirected",   rowRedirected);
				req.setAttribute("GetAssignEmpList", getProjectassignemplis);
				req.setAttribute("DakAssignedByMeList",DakAssignedByMeList);;
				req.setAttribute("DakAssignedList", DakAssignedList);
				req.setAttribute("EmpListDropDown", EmpListDropDown);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DakAssignedList.htm"+req.getUserPrincipal().getName()+e);
			}
			return "dak/dakAssignedList";
		}

		
		
		@RequestMapping(value = "GetReplyModalDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetReplyModalDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetReplyModalDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> RelyModalData =new ArrayList<Object[]>();
			try {
			   String DakId = req.getParameter("dakid");
			   String Username = req.getUserPrincipal().getName();
			   long EmpId=(Long)ses.getAttribute("EmpId");
			   if(DakId!=null) {
				   DakMain DakDetails = service.GetDakDetails(Long.parseLong(DakId)); 
				   RelyModalData = service.GetReplyModalDetails(Long.parseLong(DakId),EmpId,Username,DakDetails.getCreatedBy());
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetReplyModalDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RelyModalData);
		}
				
		
		//Used both in DAK reply Edit attach preview and DAK edit attach preview
		@RequestMapping(value = "GetReplyAttachModalList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetReplyAttachModalList(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetReplyAttachModalList.htm "+req.getUserPrincipal().getName());
			List<Object[]> RelyAttachModalData =new ArrayList<Object[]>();
			try {
			   String DakReplyId = req.getParameter("dakreplyid");
			   if(DakReplyId!=null) {
				   RelyAttachModalData = service.GetReplyAttachmentList(Long.parseLong(DakReplyId));
				 }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetReplyAttachModalList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RelyAttachModalData);
		}
		
		@RequestMapping(value = "getDaknoviewlist.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDaknoviewlist(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getDaknoviewlist.htm "+req.getUserPrincipal().getName());
			Object[] getDaknoviewlist=null;
			try {
				String DakId=req.getParameter("DakId");
				getDaknoviewlist=service.getDaknoviewlist(Long.parseLong(DakId));
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDaknoviewlist.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getDaknoviewlist);
		}
		
		
		@RequestMapping(value = "getDistributedAndAssignedEmps.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDistributedAndAssignedEmps(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getDistributedAndAssignedEmps.htm "+req.getUserPrincipal().getName());
			List<Object[]> DistributedAndAssignedEmps=null;
			try {
				String dakId=(String)req.getParameter("dakId");
				DistributedAndAssignedEmps=service.getDistributedAssignedEmps(dakId);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDistributedAndAssignedEmps.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(DistributedAndAssignedEmps);
		}
		

		@RequestMapping(value = "getFacilitatorsEmpDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getFacilitatorsEmpDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getFacilitatorsEmpDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> FacilitatorsEmpDetails=null;
			try {
				String MarkerEmpId=(String)req.getParameter("markerEmpId");
				String DakId=(String)req.getParameter("dakId");
				if(MarkerEmpId!=null && DakId!=null) {
				FacilitatorsEmpDetails=service.getFacilitatorsList(Long.parseLong(MarkerEmpId),Long.parseLong(DakId));
				}else {
					FacilitatorsEmpDetails = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getFacilitatorsEmpDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(FacilitatorsEmpDetails);
		}
		
		
		@RequestMapping(value = "GetReplyViewMore.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetReplyViewMore(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetReplyViewMore.htm "+req.getUserPrincipal().getName());
			List<Object[]> RelyViewMoreData =new ArrayList<Object[]>();
			try {
				String DakReplyId=req.getParameter("dakreplyid");
			   if(DakReplyId!=null) {
				   RelyViewMoreData = service.GetDakReplyDetails(Long.parseLong(DakReplyId)); 
			   }else {
				   RelyViewMoreData = null;
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetReplyViewMore.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RelyViewMoreData);
		}
		
		
		@RequestMapping(value = "GetReplyEditDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetReplyEditDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetReplyEditDetails.htm "+req.getUserPrincipal().getName());
			DakReply RelyEditData = null;
			try {
				String DakReplyId=req.getParameter("replyid");
			   if(DakReplyId!=null) {
				   RelyEditData = service.GetDakReplyEditDetails(Long.parseLong(DakReplyId)); 
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetReplyEditDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RelyEditData);
		}

		
		@RequestMapping(value = "ReplyAttachDelete.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String ReplyAttachDelete(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
		{
			logger.info(new Date() +"Inside ReplyAttachDelete.htm "+ req.getUserPrincipal().getName());
			try
			{
				String DakReplyAttachId = req.getParameter("replyAttachmentIdVal");
				String DakReplyId=req.getParameter("replyIdVal");
				int deleteResult = 0;
				List<Object[]> replyDakAttachmentData = null;
				if(DakReplyAttachId!=null && DakReplyId!=null ) {
					replyDakAttachmentData  = service.ReplyDakAttachmentData(Long.parseLong(DakReplyAttachId),Long.parseLong(DakReplyId));
				}
				if(replyDakAttachmentData!=null && replyDakAttachmentData.size() > 0) {
					Object[] data =  replyDakAttachmentData.get(0);
					File my_file=null;
					String replyattachdata = data[0].toString().replaceAll("[/\\\\]", ",");
	        		String[] fileParts = replyattachdata.split(",");

					my_file = new File(env.getProperty("file_upload_path")+ File.separator+"Dak" + File.separator +fileParts[0]+File.separator+fileParts[1]+ File.separator + data[1]);
					boolean result = Files.deleteIfExists(my_file.toPath());
				if(result) 
				{
					deleteResult = service.DeleteReplyAttachment(DakReplyAttachId);
					if(deleteResult>0) {
						redir.addAttribute("result","Document Deleted Successfully");
					}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful"); }
					
				}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful in Folder"); }
				
				}else { redir.addAttribute("resultfail","Document not found"); }
			}catch (Exception e) {
					e.printStackTrace(); 
					logger.error(new Date() +"Inside ReplyAttachDelete.htm "+ req.getUserPrincipal().getName(),e);
			}
			 if(req.getParameter("viewfrom")!=null && req.getParameter("viewfrom").equalsIgnoreCase("DakReceivedList")) {
					redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
					redir.addAttribute("DakId", req.getParameter("DakId"));
					return "redirect:/DakReceivedView.htm";
				}else {
		     	return "redirect:/DakReceivedList.htm";
				}
		}
		
		@RequestMapping(value = "DAKReplyDataEdit.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DAKReplyDataEdit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,
				RedirectAttributes redir,@RequestPart(name = "dak_replyEdit_document", required = false) MultipartFile[] replydocuments) throws Exception {
            logger.info(new Date() +"DAKReplyDataEdit.htm"+req.getUserPrincipal().getName());
            long result=0;
			try {
			String dakReplyId = req.getParameter("dakReplyIdValFrReplyEdit");
	      	String dakId=req.getParameter("dakIdValFrReplyEdit");
	     	String empId=req.getParameter("empIdValFrValueEdit");
	    	String remarksReplyVal=req.getParameter("replyEditRemarksVal").replaceAll("\\s+", " ");
	     	DakReplyDto dakReplyEditdto = DakReplyDto.builder().ReplyDocs(replydocuments).build();
	     	dakReplyEditdto.setDakReplyId(Long.parseLong(dakReplyId));
	     	dakReplyEditdto.setDakId(Long.parseLong(dakId));
	     	dakReplyEditdto.setEmpId(Long.parseLong(empId));
	     	dakReplyEditdto.setReply(remarksReplyVal);
	     	dakReplyEditdto.setModifiedBy(req.getUserPrincipal().getName());
			result=service.editDakReply(dakReplyEditdto);
			redir.addAttribute("DakId", dakId);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DAKReplyDataEdit.htm"+req.getUserPrincipal().getName()+e);
			}
			if(result>0) 
			{
				redir.addAttribute("result","DAK Reply Edit Successfully ");
			}
			else
			{
				redir.addAttribute("resultfail","DAK Reply Edit Unsuccessful");
			}
			redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
			return "redirect:/DakReceivedView.htm";
		}
		

		@RequestMapping(value = "GetCSWReplyModalDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetCSWReplyModalDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetCSWReplyModalDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> CSWRelyModalData =new ArrayList<Object[]>();
			try {
			   String DakId = req.getParameter("dakid");
			   String Username = req.getUserPrincipal().getName();
			   long EmpId=(Long)ses.getAttribute("EmpId");
			   if(DakId!=null) {
				   DakMain DakDetails = service.GetDakDetails(Long.parseLong(DakId)); 
				   CSWRelyModalData = service.GetCSWReplyModalDetails(Long.parseLong(DakId),EmpId,Username,DakDetails.getCreatedBy());
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetCSWReplyModalDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(CSWRelyModalData);
		}
				
		
		@RequestMapping(value = "GetAllCSWReplyByMarkingIdDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetAllCSWReplyDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetAllCSWReplyByMarkingIdDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> AllCSWRelyDataOfParticularMarker =new ArrayList<Object[]>();
			try {
			   String DakId = req.getParameter("dakId");
			   String DakMarkingId = req.getParameter("dakMarkingId");
			   if(DakId!=null && DakMarkingId!=null) {
				   AllCSWRelyDataOfParticularMarker = service.GetSpecificMarkersCSWReplyDetails(Long.parseLong(DakId),Long.parseLong(DakMarkingId));
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetAllCSWReplyByMarkingIdDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(AllCSWRelyDataOfParticularMarker);
		}
				
		
		@RequestMapping(value = "GetCSWReplyAttachModalList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetCSWReplyAttachModalList(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetCSWReplyAttachModalList.htm "+req.getUserPrincipal().getName());
			List<Object[]> RelyCSWAttachModalData =new ArrayList<Object[]>();
			try {
			   String DakAssignReplyId = req.getParameter("dakassignreplyid");
			   if(DakAssignReplyId!=null) {
				   RelyCSWAttachModalData = service.GetReplyCSWAttachmentList(Long.parseLong(DakAssignReplyId));
				 }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetCSWReplyAttachModalList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RelyCSWAttachModalData);
		}
		
		
		@RequestMapping(value = "GetParticularCSWReplyDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetParticularCSWReplyDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetParticularCSWReplyDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> ParticularCSWReplyDetails =new ArrayList<Object[]>();
			try {
			   String DakAssignReplyId = req.getParameter("dakAssignReplyId");
			   if(DakAssignReplyId!=null ) {
				   ParticularCSWReplyDetails = service.GetParticularCSWReplyDetails(Long.parseLong(DakAssignReplyId));
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetParticularCSWReplyDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(ParticularCSWReplyDetails);
		}
				
		
		
		@RequestMapping(value = "GetDakMarkersDetailsList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetDakMarkersDetailsList(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetDakMarkersDetailsList.htm "+req.getUserPrincipal().getName());
			List<Object[]> DakMarkersDetailsList =new ArrayList<Object[]>();
			try {
			   String DakId = req.getParameter("dakid");
			    if(DakId!=null) {
				   DakMarkersDetailsList = service.GetDakMarkersDetailsList(Long.parseLong(DakId));
				 }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetDakMarkersDetailsList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(DakMarkersDetailsList);
		}
		
		
		@RequestMapping(value = "DakList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) {
			logger.info(new Date() +"DakList.htm"+req.getUserPrincipal().getName());
			try {
				
				String DivisionCode = (String) ses.getAttribute("DivisionCode");
			    String LabCode = (String) ses.getAttribute("LabCode");
			    String UserName=(String)ses.getAttribute("Username");
				Date date = new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String lettertypeid=req.getParameter("lettertypeid");
				if(lettertypeid==null) {
					lettertypeid="All";
				}
				String priorityid=req.getParameter("priorityid");
				if(priorityid==null) {
					priorityid="All";
				}
				String sourcedetailid=req.getParameter("sourcedetailid");
				if(sourcedetailid==null) {
					sourcedetailid="All";
				}
				String SourceId=req.getParameter("SourceId");
				if(SourceId==null) {
					SourceId="All";
				}
				String ProjectType=req.getParameter("ProjectType");
				if(ProjectType==null) {
					ProjectType="All";
				}
				String ProjectId=req.getParameter("ProjectId");
				if(ProjectId==null) {
					ProjectId="All";
				}
				String DakMemberTypeId=req.getParameter("DakMemberTypeId");
				if(DakMemberTypeId==null) {
					DakMemberTypeId="All";
				}
				String EmpId=req.getParameter("EmpId");
				if(EmpId==null) {
					EmpId="All";
				}
				String StatusValue = (String)req.getParameter("StatusFilterVal");
				if(StatusValue == null) {
					StatusValue = "All";
				}
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -3); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				String CountFrMsgRedirect = (String)req.getParameter("countFrMsgRedirect");
				if(CountFrMsgRedirect!=null) {
					req.setAttribute("countForMsgMarkerRedirect", CountFrMsgRedirect);
				}
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("statusValue",   StatusValue);
				req.setAttribute("DakMembers", service.getDakMembers());
                req.setAttribute("DakMemberGroup", service.DakMemberGroup());
				req.setAttribute("actionList",service.getActionList());
				req.setAttribute("dakClosingAuthorityList", service.closingAuthorityList());
				req.setAttribute("DakDetailedList", service.DakDetailedList(fromDate,toDate,StatusValue,lettertypeid,priorityid,sourcedetailid,SourceId,ProjectType,ProjectId,DakMemberTypeId,EmpId,DivisionCode,LabCode,UserName));
				String RowNumber=req.getParameter("RowNumber");
				req.setAttribute("RowNumber",   RowNumber);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			return "dak/dakDetailedList";
		}
		
		
		
		@RequestMapping(value = "DakDirectorList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DirectorDakList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) {
			logger.info(new Date() +"DakDirectorList.htm"+req.getUserPrincipal().getName());
			try {
				Date date=new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String StatusValue = (String)req.getParameter("StatusFilterVal");
				if(StatusValue == null) {
					StatusValue = "All";
				}
				String SelectedTabVal = (String)req.getParameter("tabSelectedData");
				if(SelectedTabVal=="null") {
					SelectedTabVal = "PendingAprvList";
				}
				
				String lettertypeid=req.getParameter("lettertypeid");
				if(lettertypeid==null) {
					lettertypeid="All";
				}
				String priorityid=req.getParameter("priorityid");
				if(priorityid==null) {
					priorityid="All";
				}
				String sourcedetailid=req.getParameter("sourcedetailid");
				if(sourcedetailid==null) {
					sourcedetailid="All";
				}
				String SourceId=req.getParameter("SourceId");
				if(SourceId==null) {
					SourceId="All";
				}
				String ProjectType=req.getParameter("ProjectType");
				if(ProjectType==null) {
					ProjectType="All";
				}
				String ProjectId=req.getParameter("ProjectId");
				if(ProjectId==null) {
					ProjectId="All";
				}
				String DakMemberTypeId=req.getParameter("DakMemberTypeId");
				if(DakMemberTypeId==null) {
					DakMemberTypeId="All";
				}
				String EmployeeId=req.getParameter("EmpId");
				if(EmployeeId==null) {
					EmployeeId="All";
				}
				
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -3); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
	            //Code For Msg Update Redirection Start
				String CountFrMsgRedirect = (String)req.getParameter("countFrMsgRedirect");
				if(CountFrMsgRedirect!=null) {
					req.setAttribute("countForMsgRedirect", CountFrMsgRedirect);
				}
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("statusValue",   StatusValue);
				req.setAttribute("tabSelectedVal", SelectedTabVal);
				req.setAttribute("DakMembers", service.getDakMembers());
				req.setAttribute("DakMemberGroup", service.DakMemberGroup());
				req.setAttribute("actionList",service.getActionList());
				req.setAttribute("dirPendingApprovalList",service.DirPendingApprovalList(lettertypeid,priorityid,sourcedetailid,SourceId,ProjectType,ProjectId,DakMemberTypeId,EmployeeId));
				req.setAttribute("dakDirectorList", service.DakDirectorList(fromDate,toDate,StatusValue));
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			return "dak/dakDirectorList";
		}
		
		@RequestMapping(value= "DakDirectorActionAdd.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakAddSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir)throws Exception {

		logger.info(new Date() +"Inside DakDirectorActionAdd.htm "+req.getUserPrincipal().getName());
	    long Status=0;
		int result=0;
	    long EmpId=(Long)ses.getAttribute("EmpId");
	    String fromDate = req.getParameter("fromDateCmnValue");  
		String toDate = req.getParameter("toDateCmnValue");  
		String RedirectTab = req.getParameter("RedirTabValue");  
		String DakId=req.getParameter("DakidFrMsg");  
		String DakMarkingId=req.getParameter("DakmarkingidFrMsg"); 
		String MarkedEmpId=req.getParameter("DakempidFrMsg");  
		String DirAction=req.getParameter("ActionFrMsg"); 
		String CountFrMsgRedir=req.getParameter("CountFrMsg"); 
		try {
			if(DakId!=null && DakMarkingId!=null && MarkedEmpId!=null && DirAction!=null ) {
			DakMarking dakMark = new DakMarking();
			dakMark.setDakId(Long.parseLong(DakId));
			dakMark.setDakMarkingId(Long.parseLong(DakMarkingId));
			dakMark.setEmpId(Long.parseLong(MarkedEmpId));
			dakMark.setMsgType(DirAction);
			dakMark.setCreatedBy(req.getUserPrincipal().getName());//just for notify purpose
			Status=service.UpdateDakDirAction(dakMark,EmpId);
			if(Status>0) {
				result=1;
				redir.addAttribute("result","Message SuccessFully Passed..!");

			}else {
				result=0;
				redir.addAttribute("resultfail","Message Pass UnSuccessful..!");
			}
		
          }else {
        	  result=0;
        	  redir.addAttribute("resultfail","Message Pass UnSuccessful..!");
			}
			if(fromDate!=null || toDate != null) {
				  try {
						 fromDate=rdf.format(sdf2.parse(fromDate));
						 toDate=rdf.format(sdf2.parse(toDate));
						 redir.addAttribute("FromDate", fromDate);
						 redir.addAttribute("ToDate",   toDate);
					 }catch (ParseException e) {
						 e.printStackTrace();
					 }
			 }
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside DakDirectorActionAdd.htm "+req.getUserPrincipal().getName(), e);
		}
		redir.addAttribute("FromDate",fromDate);
		redir.addAttribute("ToDate",toDate);
		redir.addAttribute("countFrMsgRedirect",CountFrMsgRedir);
		redir.addAttribute("tabSelectedData", RedirectTab);
		return "redirect:/DakDirectorList.htm";
		}
		
		
		@RequestMapping(value = "GetIndividualReplyDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String GetIndividualReplyDetails(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {
			logger.info(new Date() +"Inside GetIndividualReplyDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> IndividualRelyData =new ArrayList<Object[]>();
			try {
			   String DakReplyId = req.getParameter("dakreplyid");
			   String EmpId = req.getParameter("empid");
			   String DakId = req.getParameter("dakid");
			   if(DakReplyId!=null && EmpId!=null && DakId!=null) {
				   IndividualRelyData = service.GetIndividualReplyDetails(Long.parseLong(DakReplyId),Long.parseLong(EmpId),Long.parseLong(DakId));
				 }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetIndividualReplyDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(IndividualRelyData);
		}
		
		
		@RequestMapping(value = "getiframepdf.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getiframepdf(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getiframepdf.htm "+req.getUserPrincipal().getName());
			List<String> iframe=new ArrayList<>();
			try {
				 String dakattachmentid = req.getParameter("data");
		         Object[] dakattachmentdata = service.DakAttachmentData(dakattachmentid);
		         File my_file = null;
		         String dakattachdata = dakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
	        	 String[] fileParts = dakattachdata.split(",");
		         my_file = new File(env.getProperty("file_upload_path")+ File.separator+"Dak" + File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+dakattachmentdata[1]);  //this will automatically download
		         res.setHeader("Content-disposition", "inline; filename=" + dakattachmentdata[1].toString());
		         iframe.add(FilenameUtils.getExtension(dakattachmentdata[1]+""));
		         String pdf=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(my_file));
		         String FileName=(String)dakattachmentdata[1];
		         iframe.add(pdf);
		         iframe.add(FileName);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getiframepdf.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(iframe);
		}
		
		
		@RequestMapping(value = "IframeReplyDownloadAttach.htm", method = {RequestMethod.GET, RequestMethod.POST})
		public @ResponseBody String IframeReplyDownloadAttach(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
			List<String> iframe=new ArrayList<>();
			try {
		        String ReplyAttachmentId = req.getParameter("data");
		        Object[] replydakattachmentdata = service.DakReplyAttachData(ReplyAttachmentId);
		        File my_file = null;
		        String replyattachdata = replydakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
	        	String[] fileParts = replyattachdata.split(",");
		        my_file = new File(env.getProperty("file_upload_path")+ File.separator+"Dak" +  File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+replydakattachmentdata[1]);  //this will automatically download
		        res.setHeader("Content-disposition", "inline; filename=" + replydakattachmentdata[1].toString());
		        iframe.add(FilenameUtils.getExtension(replydakattachmentdata[1]+""));
		         String pdf=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(my_file));
		         String FileName=(String)replydakattachmentdata[1];
		         iframe.add(pdf);
		         iframe.add(FileName);
		    } catch (Exception e) {
		        e.printStackTrace();
		        logger.error(new Date() + "Inside ReplyDownloadAttach " + req.getUserPrincipal().getName(), e);
		    }
			Gson json = new Gson();
			return json.toJson(iframe);
		}

		@RequestMapping(value = "ReplyDownloadAttach.htm", method = {RequestMethod.GET, RequestMethod.POST})
		public void ReplyDownloadAttach(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
		    try {
		        String ReplyAttachmentId = req.getParameter("markerdownloadbtn");
		        Object[] replydakattachmentdata = service.DakReplyAttachData(ReplyAttachmentId);
		        File my_file = null;
		        String replyattachdata = replydakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
	        	String[] fileParts = replyattachdata.split(",");
		        my_file = new File(env.getProperty("file_upload_path")+ File.separator+"Dak" + File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+replydakattachmentdata[1]);  //this will automatically download
		        res.setHeader("Content-disposition", "attachment; filename=\"" + replydakattachmentdata[1] + "\"");
		        String mimeType = getMimeType(my_file.getName()); // Get the appropriate MIME type based on the file extension
		        res.setContentType(mimeType);
		        OutputStream out = res.getOutputStream();
		        FileInputStream in = new FileInputStream(my_file);
		        byte[] buffer = new byte[4096];
		        int length;
		        while ((length = in.read(buffer)) > 0) {
		            out.write(buffer, 0, length);
		        }
		        in.close();
		        out.flush();
		    } catch (Exception e) {
		        e.printStackTrace();
		        logger.error(new Date() + "Inside ReplyDownloadAttach " + req.getUserPrincipal().getName(), e);
		    }
		}
		
		
		@RequestMapping(value = "IframeReplyCSWDownloadAttach.htm", method = {RequestMethod.GET, RequestMethod.POST})
		public @ResponseBody String  IframeReplyCSWDownloadAttach(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
			List<String> iframe=new ArrayList<>();
			try {
		        String DakAssignReplyAttachmentId = req.getParameter("data");
		        Object[] replycswdakattachmentdata = service.DakReplyCSWAttachData(DakAssignReplyAttachmentId);
		        File my_file = null;
		        String replycswattachdata = replycswdakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
	        	String[] fileParts = replycswattachdata.split(",");
		        my_file = new File(env.getProperty("file_upload_path") + File.separator+"Dak" + File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+replycswdakattachmentdata[1]);  //this will automatically download
		        res.setHeader("Content-disposition", "attachment; filename=\"" + replycswdakattachmentdata[1] + "\"");
		        iframe.add(FilenameUtils.getExtension(replycswdakattachmentdata[1]+""));
		         String pdf=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(my_file));
		         String FileName=(String)replycswdakattachmentdata[1];
		         iframe.add(pdf);
		         iframe.add(FileName);
		    } catch (Exception e) {
		        e.printStackTrace();
		        logger.error(new Date() + "Inside ReplyCSWDownloadAttach " + req.getUserPrincipal().getName(), e);
		    }
			Gson json = new Gson();
			return json.toJson(iframe);
		}
		
		
		@RequestMapping(value = "ReplyCSWDownloadAttach.htm", method = {RequestMethod.GET, RequestMethod.POST})
		public void ReplyCSWDownloadAttach(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
			try {
		        String DakAssignReplyAttachmentId = req.getParameter("cswdownloadbtn");
		        Object[] replycswdakattachmentdata = service.DakReplyCSWAttachData(DakAssignReplyAttachmentId);
		        File my_file = null;
		        String replycswattachdata = replycswdakattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
	        	String[] fileParts = replycswattachdata.split(",");
		        my_file = new File(env.getProperty("file_upload_path") + File.separator+"Dak" + File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+replycswdakattachmentdata[1]);
		        res.setHeader("Content-disposition", "attachment; filename=\"" + replycswdakattachmentdata[1] + "\"");
		        String mimeType = getMimeType(my_file.getName()); // Get the appropriate MIME type based on the file extension
		        res.setContentType(mimeType);
		        OutputStream out = res.getOutputStream();
		        FileInputStream in = new FileInputStream(my_file);
		        byte[] buffer = new byte[4096];
		        int length;
		        while ((length = in.read(buffer)) > 0) {
		            out.write(buffer, 0, length);
		        }
		        in.close();
		        out.flush();
		    } catch (Exception e) {
		        e.printStackTrace();
		        logger.error(new Date() + "Inside ReplyCSWDownloadAttach " + req.getUserPrincipal().getName(), e);
		    }
		}
		
		
		@RequestMapping(value = "IframePnCReplyDownloadAttach.htm", method = {RequestMethod.GET, RequestMethod.POST})
		public @ResponseBody String  IframePnCReplyDownloadAttach(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
			List<String> iframe=new ArrayList<>();
			try {
		        String PnCReplyAttachId = req.getParameter("data");
		        Object[] replyPnCAttachdata = service.DakPnCReplyAttachData(PnCReplyAttachId);
		        File my_file = null;
		        String replypncattachmentdata = replyPnCAttachdata[0].toString().replaceAll("[/\\\\]", ",");
	        	String[] fileParts = replypncattachmentdata.split(",");
		        my_file = new File(env.getProperty("file_upload_path") + File.separator+"Dak" + File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+replyPnCAttachdata[1]);
		        res.setHeader("Content-disposition", "attachment; filename=\"" + replyPnCAttachdata[1] + "\"");
		         iframe.add(FilenameUtils.getExtension(replyPnCAttachdata[1]+""));
		         String pdf=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(my_file));
		         String FileName=(String)replyPnCAttachdata[1];
		         iframe.add(pdf);
		         iframe.add(FileName);
		    } catch (Exception e) {
		        e.printStackTrace();
		        logger.error(new Date() + "Inside IframePnCReplyDownloadAttach " + req.getUserPrincipal().getName(), e);
		    }
			Gson json = new Gson();
			return json.toJson(iframe);
		}
		
		@RequestMapping(value = "PnCReplyDownloadAttach.htm", method = {RequestMethod.GET, RequestMethod.POST})
		public void PnCReplyDownloadAttach(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
		    try {
		        String PnCReplyAttachId = req.getParameter("pncReplyDownloadBtn");
		        Object[] replyPnCAttachdata = service.DakPnCReplyAttachData(PnCReplyAttachId);
		        File my_file = null;
		        String replypncattachmentdata = replyPnCAttachdata[0].toString().replaceAll("[/\\\\]", ",");
	        	String[] fileParts = replypncattachmentdata.split(",");
		        my_file = new File(env.getProperty("file_upload_path") + File.separator+"Dak" + File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+replyPnCAttachdata[1]);
		        res.setHeader("Content-disposition", "attachment; filename=\"" + replyPnCAttachdata[1] + "\"");
		        String mimeType = getMimeType(my_file.getName()); // Get the appropriate MIME type based on the file extension
		        res.setContentType(mimeType);
		        OutputStream out = res.getOutputStream();
		        FileInputStream in = new FileInputStream(my_file);
		        byte[] buffer = new byte[4096];
		        int length;
		        while ((length = in.read(buffer)) > 0) {
		            out.write(buffer, 0, length);
		        }
		        in.close();
		        out.flush();
		    } catch (Exception e) {
		        e.printStackTrace();
		        logger.error(new Date() + "Inside PnCReplyDownloadAttach " + req.getUserPrincipal().getName(), e);
		    }
		}
		
		@RequestMapping(value = "DAKAssignReply.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DAKAssignReply(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir,
			@RequestPart(name = "dak_Assign_reply_document", required = false) MultipartFile[] Assignreplydocs) {
			logger.info(new Date() +"Inside DAKAssignReply.htm "+req.getUserPrincipal().getName());
			long result=0;
			long EmpId=(Long)ses.getAttribute("EmpId");
			String DakId=req.getParameter("dakIdOfAssignReply");
			String DakAssignId=req.getParameter("DakAssignId");
			String AssignreplyRemarks=req.getParameter("AssignreplyRemarks");
			String DakNo=req.getParameter("DakNo");
			String fromDate=(String)req.getParameter("FromDate");
			String toDate=(String)req.getParameter("ToDate");
			try {
				
				  if(fromDate!=null || toDate != null) {
					  try {
							 fromDate=rdf.format(sdf2.parse(fromDate));
							 toDate=rdf.format(sdf2.parse(toDate));
							 redir.addAttribute("FromDate", fromDate);
							 redir.addAttribute("ToDate",   toDate);
						 }catch (ParseException e) {
							 e.printStackTrace();
						 }
				 }
				DakAssignReplyDto dto=DakAssignReplyDto.builder().AssignReplyDocs(Assignreplydocs).build();
				dto.setDakId(Long.parseLong(DakId));
				dto.setAssignId(Long.parseLong(DakAssignId));
				dto.setEmpId(EmpId);
				dto.setReply(AssignreplyRemarks.trim());
				dto.setReplyStatus("R");
				dto.setCreatedBy(req.getUserPrincipal().getName());
				dto.setCreatedDate(sdf1.format(new Date()));
				dto.setDakNo(DakNo);
				result=service.InsertDakAssignReply(dto);
				String AssignReplyPageNo=req.getParameter("AssignReplyPageNo");
				String AssignReplyRowNo=req.getParameter("AssignReplyRowNo");
				redir.addAttribute("PageNoData", AssignReplyPageNo);
				redir.addAttribute("RowData", AssignReplyRowNo);
				if(result>0) {
					service.updateAssignStatus(Long.parseLong(DakAssignId));
					redir.addAttribute("result","DAK Assign Replied Successfully ");
					
				}else {
					redir.addAttribute("resultfail","DAK Assign Replied Unsuccessful");
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DAKAssignReply.htm "+req.getUserPrincipal().getName(), e);
			}
			
			if(req.getParameter("DakAssignRedirVal")!=null && req.getParameter("DakAssignRedirVal").equalsIgnoreCase("DakReceivedViewList")) {
				redir.addAttribute("DakId", DakId);
				redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				return "redirect:/DakReceivedView.htm";
			}else {
			return "redirect:/DakAssignedList.htm";
			}
			
		}
		
		
		@RequestMapping(value = "getDakMeberslist.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDakMeberslist(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside getDakMeberslist.htm "+req.getUserPrincipal().getName());
			List<Object[]> DakMembers=null;
			try {
				DakMembers=service.getDakMembers();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDakMeberslist.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(DakMembers);
		}
		
		
		@RequestMapping(value = "dakSourceAddSubmit.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String dakSourceAddSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside dakSourceAddSubmit.htm "+req.getUserPrincipal().getName());
			String SourceType=req.getParameter("SourceType");  
			String ShortName=req.getParameter("ShortName"); 
			String SourceName=req.getParameter("SourceName"); 
			String SourceAddress=req.getParameter("SourceAddress"); 
			String SourceCity=req.getParameter("SourceCity"); 
			String SourcePin=req.getParameter("SourcePin"); 
			int result=0;
			try {
				Source source=new Source();
				source.setSourceId(Long.parseLong(SourceType));
				source.setSourceShortName(ShortName);
				source.setSourceName(SourceName);
				source.setSourceAddress(SourceAddress);
				source.setSourceCity(SourceCity);
				source.setSourcePin(SourcePin);
				source.setCreatedBy(req.getUserPrincipal().getName());
				source.setCreatedDate(sdf1.format(new Date()));
				
				long Status=service.InsertSourceDetails(source);
				if(Status>0) {
					result=1;
				}else {
					result=2;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside dakSourceAddSubmit.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(result);
		}
		
		@RequestMapping(value = "getSelectNonProjectList.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getSelectOtehrProjectList(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside getSelectOtehrProjectList.htm "+req.getUserPrincipal().getName());
			List<Object[]> NonProjectList=null;
			try {
				NonProjectList=service.NonProjectList();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getSelectNonProjectList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(NonProjectList);
		}
		
		
		@RequestMapping(value = "dakNonProjectAddSubmit.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String dakNonProjectAddSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside dakNonProjectAddSubmit.htm "+req.getUserPrincipal().getName());
			String ShortName=req.getParameter("ShortName");  
			String NonProjectName=req.getParameter("NonProjectName"); 
			int result=0;
			try {
				NonProjectMaster nonProject=new NonProjectMaster();
				nonProject.setNonShortName(ShortName);
				nonProject.setNonProjectName(NonProjectName);
				nonProject.setCreatedBy(req.getUserPrincipal().getName());
				nonProject.setCreatedDate(sdf1.format(new Date()));
				nonProject.setIsActive(1);
				long Status=service.InsertNonProjectDetails(nonProject);
				if(Status>0) {
					result=1;
				}else {
					result=2;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside dakNonProjectAddSubmit.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(result);
		}
		
		
		@RequestMapping(value = "getSelectOtehrProjectList.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getSelectNonProjectList(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside getSelectNonProjectList.htm "+req.getUserPrincipal().getName());
			List<Object[]> OtherProjectList=null;
			try {
				OtherProjectList=service.OtherProjectList();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getSelectNonProjectList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(OtherProjectList);
		}
		
		
		@RequestMapping(value = "dakOtherProjectAddSubmit.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String dakOtherProjectAddSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside dakOtherProjectAddSubmit.htm "+req.getUserPrincipal().getName());
			String ProjectCode=req.getParameter("ProjectCode"); 
			String ShortName=req.getParameter("ShortName"); 
			String OtherProjectName=req.getParameter("OtherProjectName");  
			String LabCode=req.getParameter("LabCode"); 
			int result=0;
			try {
				OtherProjectMaster OtherProject=new OtherProjectMaster();
				OtherProject.setProjectCode(ProjectCode);
				OtherProject.setProjectShortName(ShortName);
				OtherProject.setProjectName(OtherProjectName);
				OtherProject.setLabCode(LabCode);
				OtherProject.setIsActive(1);
				OtherProject.setCreatedBy(req.getUserPrincipal().getName());
				OtherProject.setCreatedDate(sdf1.format(new Date()));
				
				long Status=service.InsertOtherProjectDetails(OtherProject);
				if(Status>0) {
					result=1;
				}else {
					result=2;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside dakOtherProjectAddSubmit.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(result);
		}
		

		
		@RequestMapping(value = "DakREMark.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakREMark(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir)
		{
			logger.info(new Date() +"DakREMark.htm"+req.getUserPrincipal().getName());
			String PageNo=null;
			String Row=null;
			try {
				String DakMarkingActionDueDate=req.getParameter("MarkingActionDueDate");
				String MarkingDakId=req.getParameter("MarkDakId");
				String ActionId=req.getParameter("ActionId");
				String ActionRequired=req.getParameter("ActionRequired");
				List<Object[]> PrevMarkedEmployees=null;
				
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				
				
				if(fromDate!=null || toDate != null) {
					  try {
							 fromDate=rdf.format(sdf2.parse(fromDate));
							 toDate=rdf.format(sdf2.parse(toDate));
							 redir.addAttribute("FromDate", fromDate);
							 redir.addAttribute("ToDate",   toDate);
						 }catch (ParseException e) {
							 e.printStackTrace();
						 }
				 }
				
				PageNo = req.getParameter("PageNumber");
				Row = req.getParameter("RowNumber");
				
				
				long result=0;
				
			    String[] resultArray = null;
				String markedEmps[]=(String[])req.getParameterValues("DakListCommonempidSelect");//(Ex:-5,1...) Selection of Individual Marking
				String GroupMarkingData=req.getParameter("DakListCommonEmpIdGroup");//(Ex:-13/9,15/9....) Selection of Group Marking
				String FinalEmp[] = null;
				int resultArrayCheck = 0;
				if (GroupMarkingData != null && !GroupMarkingData.trim().equals("") && markedEmps == null)
	             {//WHEN markedEmps IS NULL
			        	   String GroupMarkingEmps[]=GroupMarkingData.split(",");
		                   int finalLength = GroupMarkingEmps.length;
		                   FinalEmp = new String[finalLength];
					       System.arraycopy(GroupMarkingEmps, 0, FinalEmp, 0, GroupMarkingEmps.length);
					       resultArrayCheck = 1;
			        	  
	             }else if(markedEmps!=null  && GroupMarkingData.trim().equals("") ) {//WHEN GroupMarkingData IS NULL
	            	 for (int i = 0; i < markedEmps.length; i++) {
	     			    if (i < markedEmps.length - 1) {
	     			    }
	     			}
			                   int finalLength = markedEmps.length;
			                   FinalEmp = new String[finalLength];
						       System.arraycopy(markedEmps, 0, FinalEmp, 0, markedEmps.length);
						       resultArrayCheck = 1;
			        	  
			          }else if(markedEmps!=null && GroupMarkingData!=null  && !GroupMarkingData.trim().equals("")) {//WHEN BOTH ARE NOT NULL
			        	  String GroupMarkingEmps[]=GroupMarkingData.split(",");
		                   int finalLength = markedEmps.length + GroupMarkingEmps.length;
		                   FinalEmp = new String[finalLength];
					       System.arraycopy(markedEmps, 0, FinalEmp, 0, markedEmps.length);
					       System.arraycopy(GroupMarkingEmps, 0, FinalEmp, markedEmps.length, GroupMarkingEmps.length);
					       resultArrayCheck = 1;
			         
			          }else {//WHEN BOTH ARE NULL
			        	  resultArrayCheck = 0;
			          }
				
				 if(resultArrayCheck>0) {
				
				Map<String, String> empIdToMarkedTypeIdMap = new HashMap<>();
		        // Loop through the array to add empIds to the HashSet and store corresponding markedTypeIds
		        for (int i = 0; i < FinalEmp.length; i++) {
		        	String [] values=FinalEmp[i].split("/");
		            String empId = values[0];
		            String markedTypeId = values[1];
		            // Add the empId to the HashMap to automatically remove duplicates
		            // The last occurrence of empId will override previous entries with the same empId
		            empIdToMarkedTypeIdMap.put(empId, markedTypeId);
		        }

		        // Convert the HashMap to a String[] array
		        resultArray = new String[empIdToMarkedTypeIdMap.size()];
		        int index = 0;
		        for (Map.Entry<String, String> entry : empIdToMarkedTypeIdMap.entrySet()) {
		            String empId = entry.getKey();
		            String markedTypeId = entry.getValue();
		            String entryString = empId + "," + markedTypeId;
		            resultArray[index] = entryString;
		            index++;
		        }
		        if(MarkingDakId!=null) {
				PrevMarkedEmployees=service.PrevMarkedEmployees(Long.parseLong(MarkingDakId));
		        }
		        
		        ArrayList<String>a1= new ArrayList<>();
		        for(Object[] list:PrevMarkedEmployees)
	        	{
		        	a1.add(list[0].toString());
	        	}
		        
		        ArrayList<String>finalArray1=new ArrayList<>();
		        for (int i=0;i<resultArray.length;i++) {
		        	String [] EmpandMarkingValues=resultArray[i].split(",");
		        	String empId = EmpandMarkingValues[0];
		        	String markedTypeId=EmpandMarkingValues[1]; 
		        	if(!a1.contains(empId)) {
		        		finalArray1.add(empId+"-"+markedTypeId);
		        	}
		        }
		        
				for(int i=0;i<finalArray1.size();i++) {
					
					
		       		 String[] EmpandMarkingValues = finalArray1.get(i).split("-");

		       		 String empId = EmpandMarkingValues[0];
		       		 String markedTypeId = EmpandMarkingValues[1];
		       	DakMarking marking=new DakMarking();
		       	marking.setDakId(Long.parseLong(MarkingDakId));
		       	marking.setEmpId(Long.parseLong(empId));
		       	marking.setDakMemberTypeId(Long.parseLong(markedTypeId));
		       	marking.setActionId(Long.parseLong(ActionId));
		       	if(ActionRequired.trim().equalsIgnoreCase("ACTION")) {
		       	marking.setReplyOpen("Y");
		       	}else {
		       		marking.setReplyOpen("N");
		       	}
		       	marking.setRemarkup("Y");
		       	if(DakMarkingActionDueDate!=null && !DakMarkingActionDueDate.equalsIgnoreCase("null")) {
		       		marking.setActionDueDate(new java.sql.Date(sdf2.parse(req.getParameter("MarkingActionDueDate")).getTime()));	
		       	}
		        marking.setDakAckStatus("N");
		        marking.setDakAssignStatus("N");
		        marking.setMsgType("N");
		        marking.setFavourites(0);
		       	marking.setCreatedBy(req.getUserPrincipal().getName());
		       	marking.setCreatedDate(sdf1.format(new Date()));
		       	marking.setIsActive(1);
		       	
		       	result=service.getDakMarkingInsert(marking);
				}
				
				 }else {
					 result = -1;
				 }
				 redir.addAttribute("PageNumber", PageNo);
			     redir.addAttribute("RowNumber", Row);
				if(result>0) 
				{
					redir.addAttribute("result","DAK ReMarked Successfully ");
				}else if(result == -1)
				{
					redir.addAttribute("resultfail","At least one employee should be chosen.");
				}else {
					redir.addAttribute("resultfail","DAK ReMarke Unsuccessful ");
				}
				String redirectVal = null;
				redirectVal = req.getParameter("RemarkRedirectValue");
				if(redirectVal!=null && "DakDetailedList".equalsIgnoreCase(redirectVal)) {
					return "redirect:/DakList.htm";
		        }else if(redirectVal!=null && "DakRemarknRedistributeList".equalsIgnoreCase(redirectVal)){
		        	return "redirect:/DakRemarkRedistribute.htm";
		        }else {
		        	return "redirect:/DakDirectorList.htm";
				}
			
				 
		} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			
		}
		
		
		@RequestMapping(value = "DakReDistribute.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakReDistribute(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception {
			logger.info(new Date() +"DakReDistribute.htm"+req.getUserPrincipal().getName());
			String PageNo=null;
			String Row=null;
			try {
				String username=req.getUserPrincipal().getName();
				long MarkedEmpId=(Long)ses.getAttribute("EmpId");
				String dakId=(String)req.getParameter("dakReDistributeId");
			    String a=req.getParameter("ReDistributeEmpId");
				String []EmpId=a.split(",");
				String date=sdf1.format(new Date());
				
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				
				
				if(fromDate!=null || toDate != null) {
					  try {
							 fromDate=rdf.format(sdf2.parse(fromDate));
							 toDate=rdf.format(sdf2.parse(toDate));
							 redir.addAttribute("FromDate", fromDate);
							 redir.addAttribute("ToDate",   toDate);
						 }catch (ParseException e) {
							 e.printStackTrace();
						 }
				 }
				
				PageNo = req.getParameter("PageNumber");
				Row = req.getParameter("RowNumber");
				
				 redir.addAttribute("PageNumber", PageNo);
			     redir.addAttribute("RowNumber", Row);
				long DakDistribute=service.DakReDistribute(dakId,date,EmpId,MarkedEmpId,username);
				if(DakDistribute>0) {
					service.reupdateremarkstatus(dakId);
					redir.addAttribute("result", "DAK ReDistributed Successfully");
				}else {
					redir.addAttribute("resultfail", "DAK ReDistribution Unsuccessful");
				}
				String redirectVal = null;
				redirectVal = req.getParameter("RedirectVal");
				if(redirectVal!=null && "DakDetailedList".equalsIgnoreCase(redirectVal)) {
					return "redirect:/DakList.htm";
		        }else  if(redirectVal!=null && "DakRemarknRedistributeList".equalsIgnoreCase(redirectVal)){
		        	return "redirect:/DakRemarkRedistribute.htm";
		        }else {
		        	return "redirect:/DakDirectorList.htm";
				}
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
		
		
//		@RequestMapping(value = "DakPendingP&CDOList.htm", method = {RequestMethod.GET,RequestMethod.POST})
//		public String DakPendingPnCDOList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir)  throws Exception{
//			logger.info(new Date() +"Inside DakPendingP&CDOList.htm "+req.getUserPrincipal().getName());
//			try {
//				
//				long EmpId=(Long)ses.getAttribute("EmpId");
//				Date date=new Date();
//				String fromDate=(String)req.getParameter("FromDate");
//				String toDate=(String)req.getParameter("ToDate");
//				Calendar cal = new GregorianCalendar(); cal.setTime(date);
//				cal.add(Calendar.DAY_OF_MONTH, -30); 
//				Date prevdate = cal.getTime();
//				if(fromDate==null || toDate == null) 
//				{
//					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
//					toDate  = LocalDate.now().toString();
//				}else
//				{
//					fromDate=sdf2.format(rdf.parse(fromDate));
//					toDate=sdf2.format(rdf.parse(toDate));
//				}
//				req.setAttribute("frmDt", fromDate);
//				req.setAttribute("toDt",   toDate);
//				req.setAttribute("DakPendingP&CDOList", service.DakPnCPendingReplyList(fromDate,toDate));
//			} catch (Exception e) {
//				e.printStackTrace();
//				   logger.error(new Date() +"DakPendingP&CDOList.htm"+req.getUserPrincipal().getName()+e);
//			}
//			return "dak/dakPendingPncDoReplyList";
//		}
		
	
		
		
		
		@RequestMapping(value = "DakPNCList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakPNCList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) {
			logger.info(new Date() +"DakPNCList.htm"+req.getUserPrincipal().getName());
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				String LoginType = (String)ses.getAttribute("LoginTypeDms");
				Date date = new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String StatusValue = (String)req.getParameter("StatusFilterVal");
			     if(StatusValue == null) {
					StatusValue = "All";
				}
			     
			    String SelectedTabVal = (String)req.getParameter("tabData");
					if(SelectedTabVal==null) {
						SelectedTabVal = "PendingPNCReply";
					}
			
					 
			     
			     
			     
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -7); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("statusValue",   StatusValue);
				req.setAttribute("selectedTabVal",   SelectedTabVal);
				req.setAttribute("dakPendingPNCReplyList", service.DakPnCPendingReplyList(EmpId,LoginType,fromDate,toDate,StatusValue));
				req.setAttribute("dakPNCList", service.DakPnCList(EmpId,LoginType,fromDate,toDate,StatusValue));
				
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			return "dak/dakPNCList";
		}
		
		
		@RequestMapping(value = "DakPNCDOList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String RTMDOList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) {
			logger.info(new Date() +"DakPNCDOList.htm"+req.getUserPrincipal().getName());
			try {
				Date date = new Date();
				String fromDate=(String)req.getParameter("fromDateFetch");
				String toDate=(String)req.getParameter("toDateFetch");
				
				String lettertypeid=req.getParameter("lettertypeid");
				if(lettertypeid==null) {
					lettertypeid="All";
				}
				String priorityid=req.getParameter("priorityid");
				if(priorityid==null) {
					priorityid="All";
				}
				String sourcedetailid=req.getParameter("sourcedetailid");
				if(sourcedetailid==null) {
					sourcedetailid="All";
				}
				String SourceId=req.getParameter("SourceId");
				if(SourceId==null) {
					SourceId="All";
				}
				String ProjectType=req.getParameter("ProjectType");
				if(ProjectType==null) {
					ProjectType="All";
				}
				String ProjectId=req.getParameter("ProjectId");
				if(ProjectId==null) {
					ProjectId="All";
				}
				String DakMemberTypeId=req.getParameter("DakMemberTypeId");
				if(DakMemberTypeId==null) {
					DakMemberTypeId="All";
				}
				String EmpId=req.getParameter("EmpId");
				if(EmpId==null) {
					EmpId="All";
				}
				
				String ActionId=req.getParameter("ActionId");
				if(ActionId==null) {
					ActionId="All";
				}
				
				String StatusValue = (String)req.getParameter("StatusFilterVal");
				if(StatusValue == null) {
					StatusValue = "All";
				}
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -7); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("statusValue",   StatusValue);
				req.setAttribute("DakP&CList", service.DakPnCDoList(fromDate,toDate,StatusValue,lettertypeid,priorityid,sourcedetailid,SourceId,ProjectType,ProjectId,DakMemberTypeId,EmpId,ActionId));
				
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			return "dak/dakPNCDOList";
		}
		
		@RequestMapping(value = "ConsolidatedReply.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String ConsolidatedReply(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) {
			logger.info(new Date() +"ConsolidatedReply.htm"+req.getUserPrincipal().getName());
			try {

				String RedirectionVal = (String)req.getParameter("redirValForConsoReplyAdd");
				String Action = "ConsolidatedReply";
				req.setAttribute("action", Action);
				long EmpId=(Long)ses.getAttribute("EmpId");
				String Username = (String)req.getUserPrincipal().getName();
				String DakId=(String)req.getParameter("DakIdFromCR");
				req.setAttribute("dakid", DakId);
			
				
				if(DakId!=null) {
					String DakNo=(String)req.getParameter("DakNo_"+DakId);
					req.setAttribute("dakno", DakNo);
					req.setAttribute("dakDetailsList", service.DakDetailForPNCDO(Long.parseLong(DakId)));
					  DakMain DakDetails = service.GetDakDetails(Long.parseLong(DakId)); 
					  req.setAttribute("markedReplysDetsiledList",service.GetReplyDetailsFrmDakReply(Long.parseLong(DakId),EmpId,Username,DakDetails.getCreatedBy()) );
					  req.setAttribute("markedReplyAttachmentList",service.GetReplyAttachsFrmDakReplyAttach());
				}
				
				String fromDate=(String)req.getParameter("fromDateFetch");
				String toDate=(String)req.getParameter("toDateFetch");
				req.setAttribute("fromDateCR",fromDate);
				req.setAttribute("toDateCR",toDate);
				
				if(RedirectionVal!=null && RedirectionVal.trim()!="") {
					 req.setAttribute("RedirectValAfterConsoReply",RedirectionVal);
				}else {
					req.setAttribute("RedirectValAfterConsoReply","RedirValNotFound");
				}
				
				req.setAttribute("redirval", req.getParameter("redirval"));
				req.setAttribute("redirview", req.getParameter("redirview"));
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			return "dak/dakPNCReplyAddEdit";
		}
		
		
		@RequestMapping(value = "ConsolidatedReplySubmit.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String ConsolidatedReplySubmit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,
				RedirectAttributes redir,@RequestPart(name = "PnCRepliedAttachments", required = false) MultipartFile[] pncreplydocs) throws Exception {
			
            logger.info(new Date() +"ConsolidatedReplySubmit.htm"+req.getUserPrincipal().getName());
        	long EmpId=(Long)ses.getAttribute("EmpId");
        	long DirApprovalUpdate = 0;
            long result=0;
            String RedirUrl = "null";
            String actionBy = "null";

            
			try {	

				
				String DakId=req.getParameter("DakIdFrPnCReply");	
		        //Code to set DIR approval required or not start
		        String DirApprovalVal=req.getParameter("dirApprovalValFrmPNC");
		        if(DirApprovalVal!=null && DakId!=null) {
		        	DirApprovalUpdate = service.DirApprovalActionUpdate(DirApprovalVal,Long.parseLong(DakId));
		        }
		        //Code to set DIR approval required or not end
	      	String PnCReply=req.getParameter("PnCRepliedText");
	      	DakPnCReplyDto PnCdto = DakPnCReplyDto.builder().PnCReplyDocs(pncreplydocs).build();
	      	PnCdto.setDakId(Long.parseLong(DakId));
	      	PnCdto.setEmpId(EmpId);
	      	PnCdto.setReply(PnCReply.trim());
	      	PnCdto.setCreatedBy(req.getUserPrincipal().getName());

	      	
	      	
            /////////////
	    	String dakMarkerReAttachs = req.getParameter("AttachmentsFileNames");
	    	String[] FilesReAttached=null;
	    	if (dakMarkerReAttachs != null && !dakMarkerReAttachs.trim().equals(""))
            {
		        	   FilesReAttached=dakMarkerReAttachs.split(",");
            }
	    	PnCdto.setDakMarkerReAttachs(FilesReAttached);
            /////////////
	      	
	        result=service.insertPnCDakReply(PnCdto); 
	        

            String RedirectionVal = (String)req.getParameter("redirValForConsoReplyAdd");
            String redirval=req.getParameter("redirval")!=null? req.getParameter("redirval") : "" ;
			if (RedirectionVal != null && !RedirectionVal.trim().isEmpty()) {
			    if (RedirectionVal!=null && RedirectionVal.equalsIgnoreCase("PNCListRedir") && redirval.equalsIgnoreCase("null")) {
			    	         redir.addAttribute("tabData","DakPNCList");
			    	         RedirUrl = "redirect:/DakPNCList.htm";
			    	         actionBy = "P&C";
			    }else if (RedirectionVal!=null && RedirectionVal.equalsIgnoreCase("DakPendingPNCListRedir") && redirval.equalsIgnoreCase("null")) {
					    	redir.addAttribute("tabData","DakPNCPendingReplyList");
					    	RedirUrl = "redirect:/DakPNCList.htm";
					    	actionBy = "P&C";
			    
			    } else if (RedirectionVal!=null && RedirectionVal.equalsIgnoreCase("PNCDOListRedir") && redirval.equalsIgnoreCase("null")) {
			    	RedirUrl = "redirect:/DakPNCDOList.htm";
			    	actionBy = "P&C DO";
			    }else if(RedirectionVal!=null && RedirectionVal.equalsIgnoreCase("PNCDOListRedir") && redirval!=null && redirval.equalsIgnoreCase("DakViewList")) {
			    	if(req.getParameter("redirview").equalsIgnoreCase("DakPncList")) {
				    	actionBy = "P&C";
				    	redir.addAttribute("viewfrom", "DakPncList");
				    	}else {
				    	actionBy = "P&C DO";
					    redir.addAttribute("viewfrom", "DakPncDoList");
				    	}
						redir.addAttribute("DakId", DakId);
				    	RedirUrl = "redirect:/DakReceivedView.htm";
			    }else if(RedirectionVal!=null && RedirectionVal.equalsIgnoreCase("PNCListRedir") && redirval!=null && redirval.equalsIgnoreCase("DakViewList")) {
			    	if(req.getParameter("redirview").equalsIgnoreCase("DakPncList")) {
			    	actionBy = "P&C";
			    	redir.addAttribute("viewfrom", "DakPncList");
			    	}else {
			    	actionBy = "P&C DO";
				    redir.addAttribute("viewfrom", "DakPncDoList");
			    	}
					redir.addAttribute("DakId", DakId);
			    	RedirUrl = "redirect:/DakReceivedView.htm";
			    }else if(RedirectionVal!=null && RedirectionVal.equalsIgnoreCase("DakPendingPNCListRedir") && redirval!=null && redirval.equalsIgnoreCase("DakViewList")) {
			    	if(req.getParameter("redirview").equalsIgnoreCase("DakPncList")) {
				    	actionBy = "P&C";
				    	redir.addAttribute("viewfrom", "DakPncList");
				    	}else {
				    	actionBy = "P&C DO";
					    redir.addAttribute("viewfrom", "DakPncDoList");
				    	}
						redir.addAttribute("DakId", DakId);
				    	RedirUrl = "redirect:/DakReceivedView.htm";
			    }
			} else {
				
				RedirUrl = "static/Error";
			}
			
	        
            if(result>0 && DirApprovalUpdate>0) {
				redir.addAttribute("result",actionBy+" Replied Successfully");
			}else{
				redir.addAttribute("resultfail",actionBy+" Reply Unsuccessful");
			}
	        
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"ConsolidatedReplySubmit.htm"+req.getUserPrincipal().getName()+e);
			}
		
			
			//redirection
			String fromDate=(String)req.getParameter("fromDateData");
			String toDate=(String)req.getParameter("toDateData");
			if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) {
			        e.printStackTrace();
			        // Handle the exception appropriately (e.g., log the error or provide a default value).
			    }
			}
			return RedirUrl;
		
		}

		@RequestMapping(value = "ConsolidatedReplyEdit.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String ConsolidatedReplyEdit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) {
			logger.info(new Date() +"ConsolidatedReplyEdit.htm"+req.getUserPrincipal().getName());
			try {
				String Action = "ConsolidatedReplyEdit";
				req.setAttribute("action", Action);
				long EmpId=(Long)ses.getAttribute("EmpId");
				String Username = (String)req.getUserPrincipal().getName();
				String fromDate = (String) req.getParameter("fromDateFetch");
				String toDate = (String) req.getParameter("toDateFetch");
				String RedirectionVal = (String)req.getParameter("redirValForConsoReplyEdit");
				
				String PnCReplyDataForEdit =(String)req.getParameter("DakPnCReplyDataForEdit");
				if(PnCReplyDataForEdit!=null) {
					String[] splitVal = PnCReplyDataForEdit.split("#");
					String PnCReplyId = splitVal[0];
					String DakId = splitVal[1];
					
					if(PnCReplyId!=null && PnCReplyId.trim()!="" && DakId!=null && DakId.trim()!="") {
						req.setAttribute("pncReplyId", PnCReplyId);
						req.setAttribute("dakid", DakId);
						DakMain  dakDetails = service.GetDakDetails(Long.parseLong(DakId));
						String DakNo=dakDetails.getDakNo();
						req.setAttribute("dakno", DakNo);
						req.setAttribute("dakDetailsList", service.DakDetailForPNCDO(Long.parseLong(DakId)));
						DakMain DakDetails = service.GetDakDetails(Long.parseLong(DakId)); 
						req.setAttribute("markedReplysDetsiledList",service.GetReplyDetailsFrmDakReply(Long.parseLong(DakId),EmpId,Username,DakDetails.getCreatedBy()) );
						req.setAttribute("markedReplyAttachmentList",service.GetReplyAttachsFrmDakReplyAttach());
				        req.setAttribute("pnCReplyDetails", service.GetPnCReplyDataDetails(Long.parseLong(PnCReplyId),Long.parseLong(DakId)));
				        req.setAttribute("pnCAttachReplyDetails", service.GetPnCAttachReplyDetails(Long.parseLong(PnCReplyId)));
					
					}
				}
				
				req.setAttribute("fromDateCR", fromDate);
				req.setAttribute("toDateCR", toDate);
				if(RedirectionVal!=null && RedirectionVal.trim()!="") {
					 req.setAttribute("RedirectValAfterConsoReply",RedirectionVal);
				}else {
					req.setAttribute("RedirectValAfterConsoReply","RedirValNotFound");
				}
				req.setAttribute("redirview", req.getParameter("redirview"));
				req.setAttribute("redirval", req.getParameter("redirval"));
				
				
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
			return "dak/dakPNCReplyAddEdit";
		}
		
		
		@RequestMapping(value = "ConsolidatedReplyEditSubmit.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String ConsolidatedReplyEditSubmit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,
				RedirectAttributes redir,@RequestPart(name = "PnCRepliedAttachments", required = false) MultipartFile[] pncreplyeditdocs) throws Exception {
			
            logger.info(new Date() +"ConsolidatedReplyEditSubmit.htm"+req.getUserPrincipal().getName());
        	long EmpId=(Long)ses.getAttribute("EmpId");
        	long DirApprovalUpdate = 0;
            long result=0;
            String PnCReplyId=null;
            String RedirUrl = "null";
            String actionBy = "null";
			try {

		   	String DakId=req.getParameter("DakIdFrPnCReply");
		      	//Code to set DIR approval required or not start
		        String DirApprovalVal=req.getParameter("dirApprovalValFrmPNC");
		        if(DirApprovalVal!=null && DakId!=null) {
		        	DirApprovalUpdate = service.DirApprovalActionUpdate(DirApprovalVal,Long.parseLong(DakId));
		        }
		        //Code to set DIR approval required or not end
				
			PnCReplyId=req.getParameter("pncReplyIdForEdit");
	      	String PnCReply=req.getParameter("PnCRepliedText");
	      	DakPnCReplyDto PnCdto = DakPnCReplyDto.builder().PnCReplyDocs(pncreplyeditdocs).build();
	      	PnCdto.setPnCReplyId(Long.parseLong(PnCReplyId));
	      	PnCdto.setDakId(Long.parseLong(DakId));
	      	PnCdto.setEmpId(EmpId);
	      	PnCdto.setReply(PnCReply.trim());
	      	PnCdto.setModifiedBy(req.getUserPrincipal().getName());
	    
			 result=service.updatePnCDakReply(PnCdto); 
			 String RedirectionVal = (String)req.getParameter("redirValForConsoReplyEdit");
			 String redirval=req.getParameter("redirval")!=null? req.getParameter("redirval") : "" ;
				if (RedirectionVal != null && !RedirectionVal.trim().isEmpty()) {
					if (RedirectionVal!=null && RedirectionVal.equalsIgnoreCase("PNCListRedir")&& redirval.equalsIgnoreCase("null") ) {
		    	         redir.addAttribute("tabData","DakPNCList");
		    	         RedirUrl = "redirect:/DakPNCList.htm";
		    	         actionBy = "P&C";
		             }else if (RedirectionVal != null && RedirectionVal.equalsIgnoreCase("DakPendingPNCListRedir") && redirval.equalsIgnoreCase("null")) {
				    	redir.addAttribute("tabData","DakPNCPendingReplyList");
				    	RedirUrl = "redirect:/DakPNCList.htm";
				    	actionBy = "P&C";
		    
		            } else if (RedirectionVal != null && RedirectionVal.equalsIgnoreCase("PNCDOListRedir") && redirval.equalsIgnoreCase("null")) {
		    	       RedirUrl = "redirect:/DakPNCDOList.htm";
		    	       actionBy = "P&C DO";
		            }else if(RedirectionVal != null && RedirectionVal.equalsIgnoreCase("PNCDOListRedir") && redirval!=null && redirval.equalsIgnoreCase("DakViewList")) {
		            	if(req.getParameter("redirview").equalsIgnoreCase("DakPncList")) {
							   actionBy = "P&C";
							   redir.addAttribute("viewfrom", "DakPncList");
							   }else {
							   actionBy = "P&C DO";
							   redir.addAttribute("viewfrom", "DakPncDoList");
							  }
						     redir.addAttribute("DakId", DakId);
						    RedirUrl = "redirect:/DakReceivedView.htm";
		            } else if(RedirectionVal!=null && RedirectionVal.equalsIgnoreCase("PNCListRedir") && redirval!=null && redirval.equalsIgnoreCase("DakViewList")) {
		            if(req.getParameter("redirview").equalsIgnoreCase("DakPncList")) {
					   actionBy = "P&C";
					   redir.addAttribute("viewfrom", "DakPncList");
					   }else {
					   actionBy = "P&C DO";
					   redir.addAttribute("viewfrom", "DakPncDoList");
					  }
				     redir.addAttribute("DakId", DakId);
				    RedirUrl = "redirect:/DakReceivedView.htm";
		            }
				} else {
					
					RedirUrl = "static/Error";
				}
				
			 
			if(result>0 && DirApprovalUpdate>0) {
					redir.addAttribute("result",actionBy+" Reply Edit Successfully");
			}else{
					if(PnCReplyId!=null) {
						DakPnCReply pncData= service.GetPnCDetails(Long.parseLong(PnCReplyId));
						redir.addAttribute("DakPnCReplyDataForEdit",PnCReplyId+"#"+pncData.getDakId()   );
						redir.addAttribute("resultfail",actionBy+"Reply Edit Unsuccessful");
						return "redirect:/ConsolidatedReplyEdit.htm";
					}else {
						redir.addAttribute("resultfail",actionBy+" Reply Edit Unsuccessful");
						
						
					}
					
			}
				
				
	
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"ConsolidatedReplyEditSubmit.htm"+req.getUserPrincipal().getName()+e);
			}
		
			//redirection
			String fromDate = (String) req.getParameter("fromDateData");
			String toDate = (String) req.getParameter("toDateData");
			
			if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) {
			        e.printStackTrace();
			        // Handle the exception appropriately (e.g., log the error or provide a default value).
			    }
			}
	
			return RedirUrl;
			
		}
		
		
		@RequestMapping(value = "ForwardPNCReply.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String ForwardPNCReply(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) {
			logger.info(new Date() +"ForwardPNCReply.htm"+req.getUserPrincipal().getName());
			long result = 0;
			String Username = (String)req.getUserPrincipal().getName();
			try {
				 String DakId =  req.getParameter("ForwardPNCDakId");
			     if(DakId!=null && DakId.toString().trim()!="") {
				 result = service.DakPNCForwardUpdate(Long.parseLong(DakId),Username,sdf1.format(new Date())); 
			     }	

					if(result>0) {
						redir.addAttribute("result","DAK Forward Successfully");
					}else{
						redir.addAttribute("resultfail","DAK Forward Unsuccessful");
					}
					
					
					//redirection
					String fromDate  = (String) req.getParameter("fromDateFetch");
					String toDate    = (String) req.getParameter("toDateFetch");
					if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
					    try {
					        fromDate = rdf.format(sdf2.parse(fromDate));
					        toDate = rdf.format(sdf2.parse(toDate));
					        redir.addAttribute("fromDateFetch", fromDate);
					        redir.addAttribute("toDateFetch", toDate);
					        
					        
					    } catch (ParseException e) {
					        e.printStackTrace();
					        // Handle the exception appropriately (e.g., log the error or provide a default value).
					    }
					}

			
		
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"ForwardPNCReply.htm"+req.getUserPrincipal().getName()+e);
			}

			String redirval=req.getParameter("redirval");
			
			if(redirval!=null && redirval.equalsIgnoreCase("DakViewList")) {
				redir.addAttribute("DakId", req.getParameter("ForwardPNCDakId"));
				redir.addAttribute("viewfrom", "DakPncDoList");
				return "redirect:/DakReceivedView.htm";
			}else {
            return "redirect:/DakPNCDOList.htm";
			}
			
		
		}
		
	//others Forwarded Reply Details show case before Approval
		@RequestMapping(value = "GetMarkerReplySentForApprovalData.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetMarkerReplySentForApprovalData(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside GetMarkerReplySentForApprovalData.htm "+req.getUserPrincipal().getName());
					
			List<Object[]> GetMarkerReplySentForApprovalData =new ArrayList<Object[]>();
			try {
			   String DakId = req.getParameter("dakid");
			   String DirApvForwarderId = req.getParameter("diraprvforwarderid");
			   if(DakId!=null && DirApvForwarderId!=null) {
				   GetMarkerReplySentForApprovalData = service.GetMarkerReplySentForApprovalData(Long.parseLong(DakId),Long.parseLong(DirApvForwarderId));
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetMarkerReplySentForApprovalData.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(GetMarkerReplySentForApprovalData);
		}
   //P&CDO Forwarded Reply Details show case before Approval	
		@RequestMapping(value = "GetPnCReplyDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetPnCReplyDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			
			logger.info(new Date() +"Inside GetPnCReplyDetails.htm "+req.getUserPrincipal().getName());
					
			List<Object[]> PnCReplyDataFrModal =new ArrayList<Object[]>();
			try {
			   String DakId = req.getParameter("dakid");
			   if(DakId!=null) {
				   PnCReplyDataFrModal = service.GetPnCReplyDetails(Long.parseLong(DakId));
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetPnCReplyDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(PnCReplyDataFrModal);
		}
		
		@RequestMapping(value = "GetPnCReplyAttachDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetPnCReplyAttachDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetPnCReplyAttachDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> PnCReplyAttachDataFrModal =new ArrayList<Object[]>();
			try {
			   String DakPnCReplyId = req.getParameter("dakpncreplyid");
			   if(DakPnCReplyId!=null) {
				   PnCReplyAttachDataFrModal = service.GetPnCAttachReplyDetails(Long.parseLong(DakPnCReplyId));
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetPnCReplyAttachDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(PnCReplyAttachDataFrModal);
		}
		
		
		
		@RequestMapping(value = "DAKApprovalByDirSubmit.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DAKApprovalByDirSubmit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception {
			
            logger.info(new Date() +"DAKApprovalByDirSubmit.htm"+req.getUserPrincipal().getName());
        	String RedirectTab =  null;
            long result=0;
			try {
			String Username = (String)req.getUserPrincipal().getName();
			RedirectTab =  req.getParameter("RedirTabValue");
            String DakId =  req.getParameter("DakIdFetch");
			String TypeOfApprove = req.getParameter("DirectorAct");
			String ApprovalCommt =  req.getParameter("DirectorComment");
			if(TypeOfApprove!=null && TypeOfApprove.trim()!="" && DakId!=null && DakId.trim()!="" ) {
				if(TypeOfApprove.trim().equalsIgnoreCase("DakApproval")) {
					if(ApprovalCommt!=null && ApprovalCommt.trim()!="" ) {
						result = service.DakApprovalWithCommtUpdate(Long.parseLong(DakId),ApprovalCommt.trim(),Username,sdf1.format(new Date())); 
						}else {
							result = service.DakApprovalUpdate(Long.parseLong(DakId),Username,sdf1.format(new Date())); 
					}
				}else if(TypeOfApprove.trim().equalsIgnoreCase("DakApprovalWithComments")) {
					result = service.DakApprovalWithCommtUpdate(Long.parseLong(DakId),ApprovalCommt.trim(),Username,sdf1.format(new Date())); 
				}else {
					 result=0;
				}
			   }
			if(result>0) {
				redir.addAttribute("result","DAK Approve Successfully");
			}else{
				redir.addAttribute("resultfail","DAK Approve Unsuccessful");
			}
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DAKApprovalByDirSubmit.htm"+req.getUserPrincipal().getName()+e);
			}
			//redirection
			String fromDate  = (String) req.getParameter("FromDtValDir");
			String toDate    = (String) req.getParameter("ToDtValDir");
			if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) {
			        e.printStackTrace();
			        // Handle the exception appropriately (e.g., log the error or provide a default value).
			    }
			}

			if(RedirectTab!=null && RedirectTab.equalsIgnoreCase("DakViewList")) {
			redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
			redir.addAttribute("DakId", req.getParameter("DakIdFetch"));
			return "redirect:/DakReceivedView.htm";
			}else {
			redir.addAttribute("tabSelectedData", RedirectTab);
			return "redirect:/DakDirectorList.htm";
			}
		}

		@RequestMapping(value = "DAKReturnByDirSubmit.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DAKReturnByDirSubmit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception {

            logger.info(new Date() +"DAKReturnByDirSubmit.htm"+req.getUserPrincipal().getName());
            long result=0;
			try {
			String TypeOfAct = req.getParameter("DirectorAct");
			String DakId =  req.getParameter("DakIdFetch");
			String ReturnComment =  req.getParameter("DirectorComment");
			if(TypeOfAct!=null && TypeOfAct.trim()!="" && TypeOfAct.trim().equalsIgnoreCase("DakReturn") && DakId!=null && DakId.trim()!="" && ReturnComment!=null && ReturnComment.trim()!="" ) {
				result = service.DakReturnUpdate(Long.parseLong(DakId),ReturnComment.trim()); 
			}else {
					 result=0;
			}
			if(result>0) {
				redir.addAttribute("result","DAK Return Successfully");
			}else{
				redir.addAttribute("resultfail","DAK Return Unsuccessful");
			}
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DAKReturnByDirSubmit.htm"+req.getUserPrincipal().getName()+e);
			}
			//redirection
			String fromDate  = (String) req.getParameter("FromDtValDir");
			String toDate    = (String) req.getParameter("ToDtValDir");
			if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) {
			        e.printStackTrace();
			        // Handle the exception appropriately (e.g., log the error or provide a default value).
			    }
			}
			if(req.getParameter("RedirTabValue")!=null && req.getParameter("RedirTabValue").equalsIgnoreCase("DakViewList")) {
				redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				redir.addAttribute("DakId", req.getParameter("DakIdFetch"));
				return "redirect:/DakReceivedView.htm";
				}else {
				return "redirect:/DakDirectorList.htm";
				}
			
		}

		
		@RequestMapping(value = "PnCReplyAttachDelete.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String PnCReplyAttachDelete(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
		{
			String PnCReplyAttachId = null;
			String DakPnCReplyId = null;
			long deleteResult = 0;
			logger.info(new Date() +"Inside PnCReplyAttachDelete.htm "+ req.getUserPrincipal().getName());
			try
			{
				String DakPnCReplyAttachVal = req.getParameter("dakPnCReplyAttachIdFrDelete");
				if(DakPnCReplyAttachVal!=null) {
					String[] splitVal = DakPnCReplyAttachVal.split("#");
					PnCReplyAttachId = splitVal[0];
					DakPnCReplyId = splitVal[1];
				}
				List<Object[]> replyDakPnCAttachmentData = null;
				if(PnCReplyAttachId!=null && DakPnCReplyId!=null ) {
					replyDakPnCAttachmentData  = service.ReplyDakPnCAttachmentData(Long.parseLong(PnCReplyAttachId),Long.parseLong(DakPnCReplyId));
				}
				if(replyDakPnCAttachmentData!=null && replyDakPnCAttachmentData.size() > 0) {
					Object[] data =  replyDakPnCAttachmentData.get(0);
					File my_file=null;
					my_file = new File(env.getProperty("file_upload_path") + File.separator+"Dak" + File.separator + data[0] + File.separator + data[1]);
					boolean result = Files.deleteIfExists(my_file.toPath());
				if(result) 
				{
					deleteResult = service.DeletePnCReplyAttachment(Long.parseLong(PnCReplyAttachId),Long.parseLong(DakPnCReplyId));
					if(deleteResult>0) {
						redir.addAttribute("result","Document Deleted Successfully");
					}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful"); }
				}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful in Folder"); }
				}else { redir.addAttribute("resultfail","Document not found"); }
			}catch (Exception e) {
					e.printStackTrace(); 
					logger.error(new Date() +"Inside PnCReplyAttachDelete.htm "+ req.getUserPrincipal().getName(),e);
			}
			if(DakPnCReplyId!=null) {
				DakPnCReply pncData= service.GetPnCDetails(Long.parseLong(DakPnCReplyId));
				redir.addAttribute("DakPnCReplyDataForEdit",DakPnCReplyId+"#"+pncData.getDakId()   );
				return "redirect:/ConsolidatedReplyEdit.htm";
			}else {
				redir.addAttribute("resultfail","Document Delete Unsuccessful");
				return "redirect:/DakPNCDOList.htm";
			}
		}
		
		
		@RequestMapping(value = "DakClose.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DakClose(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception {
            logger.info(new Date() +"DakClose.htm"+req.getUserPrincipal().getName());
            long result=0;
			try {
			String Username = (String)req.getUserPrincipal().getName();
			String DakId =  req.getParameter("DakIdForClose");
			String ClosingComment =  req.getParameter("DakClosingComment");
			String ClosingCommt = null;
			if(ClosingComment!=null && ClosingComment.trim()!="" ) {
				ClosingCommt = ClosingComment;
			}else {
				ClosingCommt = "--";
			}
			if(DakId!=null && DakId.trim()!="" ) {
					result = service.DakCloseUpdate(Long.parseLong(DakId),Username,sdf1.format(new Date()),sdf2.format(new Date()),ClosingCommt.trim()); 
				}else {
					 result=0;
				}
			if(result>0) {
				redir.addAttribute("result","DAK close Successfully");
			}else{
				redir.addAttribute("resultfail","DAK close Unsuccessful");
			}
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DakClose.htm"+req.getUserPrincipal().getName()+e);
				   redir.addAttribute("resultfail","DAK close Interrupted ");
			}
			//redirection
			String fromDate=(String)req.getParameter("fromDateFetch");
			String toDate=(String)req.getParameter("toDateFetch");
			if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) { 
			        e.printStackTrace();
			    }
			}
			String MarkerDakCloseWithApproval =  req.getParameter("WithApprovalDakClose");
			if(MarkerDakCloseWithApproval!=null && MarkerDakCloseWithApproval.equalsIgnoreCase("DakRecievedListRedirect")) {
				redir.addAttribute("viewfrom", "DakReceivedList");
				redir.addAttribute("DakId", req.getParameter("DakIdForClose"));
				return "redirect:/DakReceivedView.htm";
			}else if(MarkerDakCloseWithApproval!=null && MarkerDakCloseWithApproval.equalsIgnoreCase("DakPncDoList")) {
				redir.addAttribute("viewfrom", "DakPncDoList");
				redir.addAttribute("DakId", req.getParameter("DakIdForClose"));
				return "redirect:/DakReceivedView.htm";
			}else {
				return "redirect:/DakPNCDOList.htm";
			}
			
		}

		
		@RequestMapping(value = "DakCloseByMarker.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DakCloseByMarker(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception {
            logger.info(new Date() +"DakCloseByMarker.htm"+req.getUserPrincipal().getName());
        	long dirApprovalChange = 0;
            long result=0;
			try {
			String Username = (String)req.getUserPrincipal().getName();
			String DakId =  req.getParameter("dakIdForMarkerAction");
			String DirApprovalVal =  req.getParameter("dirApprovalValFrmMarker");
			if(DirApprovalVal!=null && DirApprovalVal.trim()!="") {
			    dirApprovalChange = service.DirApprovalActionUpdate(DirApprovalVal,Long.parseLong(DakId));
			}
			String ClosingComment =  req.getParameter("DakClosingCommtByMarker");
			String ClosingCommt = null;
			if(ClosingComment!=null && ClosingComment.trim()!="" ) {
				ClosingCommt = ClosingComment;
			}else {
				ClosingCommt = "--";
			}
			if(DakId!=null && DakId.trim()!="" ) {
					result = service.DakCloseUpdate(Long.parseLong(DakId),Username,sdf1.format(new Date()),sdf2.format(new Date()),ClosingCommt.trim()); 
				}else {
					 result=0;
				}
			if(result>0) {
				redir.addAttribute("result","DAK close Successfully");
			}else{
				redir.addAttribute("resultfail","DAK close Unsuccessful");
			}
			redir.addAttribute("DakId", DakId);
			redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
			//redirection
			String PageRedir=(String)req.getParameter("PageRedirectData");
			String RowRedir=(String)req.getParameter("RowRedirectData");
			redir.addAttribute("PageNoData", PageRedir);
		    redir.addAttribute("RowData", RowRedir);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DakCloseByMarker.htm"+req.getUserPrincipal().getName()+e);
				   redir.addAttribute("resultfail","DAK close Interrupted ");
			}
			//redirection
			String fromDate=(String)req.getParameter("fromDateFetch");
			String toDate=(String)req.getParameter("toDateFetch");
			if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) {
			        e.printStackTrace();
			    }
			}
			if(req.getParameter("MarkerCloseRedirectval")!=null && req.getParameter("MarkerCloseRedirectval").equalsIgnoreCase("DakReceivedList")) {
				return "redirect:/DakReceivedList.htm";
			}else {
			    return "redirect:/DakReceivedView.htm";
			}
			
		}
		@RequestMapping(value = "DakApproveForwardByMarker.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DakApproveForwardByMarker(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception {
			
            logger.info(new Date() +"DakApproveForwardByMarker.htm"+req.getUserPrincipal().getName());
        	long EmpId=(Long)ses.getAttribute("EmpId");
        	long dirApprovalChange=0;
            long result=0;
          
			try {
			String DakId =  req.getParameter("dakIdForMarkerAction");
	        String DirApprovalVal =  req.getParameter("dirApprovalValFrmMarker");
			if(DakId!=null && DakId.trim()!="" && DirApprovalVal!=null && DirApprovalVal.trim()!="") {
				dirApprovalChange = service.DirApprovalActionUpdate(DirApprovalVal,Long.parseLong(DakId));			
				result = service.UpdateDirAprvForwarderIdAndDakStatus(EmpId,Long.parseLong(DakId),"RM");
				}else {
					 result=0;
				}
			if(dirApprovalChange>0 && result>0) {
				redir.addAttribute("result","DAK Forwarded for Director Approval");
			}else{
				redir.addAttribute("resultfail","DAK Forward for Director Approval Unsuccessful");
			}
			//redirection
			String PageRedir=(String)req.getParameter("PageRedirectData");
			String RowRedir=(String)req.getParameter("RowRedirectData");
			redir.addAttribute("PageNoData", PageRedir);
		    redir.addAttribute("RowData", RowRedir);
			redir.addAttribute("DakId", DakId);
			redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DakApproveForwardByMarker.htm"+req.getUserPrincipal().getName()+e);
				   redir.addAttribute("resultfail","DAK Director Approval Forward Interrupted ");
			}
			//redirection
			String fromDate=(String)req.getParameter("fromDateFetch");
			String toDate=(String)req.getParameter("toDateFetch");
			if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
			    try {
			        fromDate = rdf.format(sdf2.parse(fromDate));
			        toDate = rdf.format(sdf2.parse(toDate));
			        redir.addAttribute("FromDate", fromDate);
			        redir.addAttribute("ToDate", toDate);
			    } catch (ParseException e) {
			        e.printStackTrace();
			    }
			}
			if(req.getParameter("MarkerCloseRedirectval")!=null && req.getParameter("MarkerCloseRedirectval").equalsIgnoreCase("DakReceivedList")) {
				return "redirect:/DakReceivedList.htm";
			}else {
				return "redirect:/DakReceivedView.htm";
			}
			
		}
		
		
		
		@RequestMapping(value = "DakClosedList.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DakClosedList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) {
		
			logger.info(new Date() +"DakClosedList.htm"+req.getUserPrincipal().getName());
		
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				String Username=req.getUserPrincipal().getName();
				String LoginType=(String)ses.getAttribute("LoginTypeDms");
				
				String DivisionCode = (String) ses.getAttribute("DivisionCode");
			    String LabCode = (String) ses.getAttribute("LabCode");
			    
				Date date = new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				
				String lettertypeid=req.getParameter("lettertypeid");
				if(lettertypeid==null) {
					lettertypeid="All";
				}
				String priorityid=req.getParameter("priorityid");
				if(priorityid==null) {
					priorityid="All";
				}
				String sourcedetailid=req.getParameter("sourcedetailid");
				if(sourcedetailid==null) {
					sourcedetailid="All";
				}
				String SourceId=req.getParameter("SourceId");
				if(SourceId==null) {
					SourceId="All";
				}
				String ProjectType=req.getParameter("ProjectType");
				if(ProjectType==null) {
					ProjectType="All";
				}
				String ProjectId=req.getParameter("ProjectId");
				if(ProjectId==null) {
					ProjectId="All";
				}
				String DakMemberTypeId=req.getParameter("DakMemberTypeId");
				if(DakMemberTypeId==null) {
					DakMemberTypeId="All";
				}
				String EmployeeId=req.getParameter("EmpId");
				if(EmployeeId==null) {
					EmployeeId="All";
				}
				
				String StatusValue = (String)req.getParameter("StatusFilterVal");
				if(StatusValue == null) {
					StatusValue = "All";
				}
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -7); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("statusValue",   StatusValue);
				req.setAttribute("dakClosedList",service.DakClosedList(fromDate,toDate,StatusValue,LoginType,Username,EmpId,lettertypeid,priorityid,sourcedetailid,SourceId,ProjectType,ProjectId,DakMemberTypeId,EmployeeId,DivisionCode,LabCode));
			} catch (Exception e) {
				e.printStackTrace();
			   logger.error(new Date() +"DakClosedList.htm"+req.getUserPrincipal().getName()+e);
			}
			return "dak/dakClosedList";

		}
		
		@RequestMapping(value = "RevokeMarking.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String RevokeMarking(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) {
			logger.info(new Date() +"RevokeMarking.htm"+req.getUserPrincipal().getName());
			try {
				String MarkingId=req.getParameter("RevokeDakMarkingId");
				String MarkId=null;
				String Action=null;
				String FromDate = req.getParameter("fromDateCmnValue");  
				String ToDate = req.getParameter("toDateCmnValue");  
                String RedirectTab = req.getParameter("RedirTabValue");  
				String Rediectedvalue=null;
				if(MarkingId!=null)
	  			{
	  				String[] arr=MarkingId.split(",");
	  				MarkId=arr[0].toString();
	  				Action=arr[1].toString();
	  				Rediectedvalue=arr[2].toString();
	  			}
				long RevokeMarking=service.RevokeMarking(MarkId);
				 if(FromDate!=null || ToDate != null) {
					 try {
						 FromDate=rdf.format(sdf2.parse(FromDate));
						 ToDate=rdf.format(sdf2.parse(ToDate)); 
						 redir.addAttribute("FromDate", FromDate);
						 redir.addAttribute("ToDate",   ToDate);
					 }catch (ParseException e) {
						 e.printStackTrace();
					 }
					 }
				if(RevokeMarking>0) {
					redir.addAttribute("result", "DAK Revoked Successfully");
				}else {
					redir.addAttribute("resultfail", "DAK Revoked Unsuccessful");
				}
				redir.addAttribute("countFrMsgRedirect",Rediectedvalue);
				if(Action.equalsIgnoreCase("DakDetailedList")) {
					return "redirect:/DakList.htm";
				}else {
					redir.addAttribute("tabSelectedData", RedirectTab);
					return "redirect:/DakDirectorList.htm";
				}
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
		
		
		@RequestMapping(value = "getDakmemberGroupEmpList.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDakmemberGroupEmpList(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getDakmemberGroupEmpList.htm "+req.getUserPrincipal().getName());
			List<Object[]> getDakmemberGroupEmpList=null;
			String[] GroupId = req.getParameterValues("Group[]");
			 String LabCode = (String) ses.getAttribute("LabCode");
			try {
				if(GroupId!=null) {
				getDakmemberGroupEmpList=service.getDakmemberGroupEmpList(GroupId,LabCode);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDakmemberGroupEmpList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getDakmemberGroupEmpList);
		}
		
		
		@RequestMapping(value = "GetAssignReply.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String GetAssignReply(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetAssignReply.htm "+req.getUserPrincipal().getName());
			List<Object[]> AssignReplyRemarks=null;
			long EmpId=(Long)ses.getAttribute("EmpId");
			String DakId=req.getParameter("DakId");
			long DakIdSel=Long.parseLong(DakId);
			try {
				if(DakId!=null) {
				AssignReplyRemarks=service.AssignReplyRemarks(EmpId,DakIdSel);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetAssignReply.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(AssignReplyRemarks);
		}
		
		
		@RequestMapping(value = "getDakGroupMeberslist.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDakGroupMeberslist(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getDakGroupMeberslist.htm "+req.getUserPrincipal().getName());
			List<Object[]> GetMarkedGropList=null;
			try {
				GetMarkedGropList=service.DakMemberGroup();
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDakGroupMeberslist.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(GetMarkedGropList);
		}
		
		
		
		@RequestMapping(value = "GetAssignReplyAttachModalList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetAssignReplyAttachModalList(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetAssignReplyAttachModalList.htm "+req.getUserPrincipal().getName());
			List<Object[]> AssignRelyAttachModalData =new ArrayList<Object[]>();
			try {
			   String DakReplyId = req.getParameter("dakreplyid");
			   if(DakReplyId!=null) {
				   AssignRelyAttachModalData = service.GetAssignReplyAttachmentList(Long.parseLong(DakReplyId));
				 }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetAssignReplyAttachModalList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(AssignRelyAttachModalData);
		}
		
		
		@RequestMapping(value = "GetAssignReplyViewMore.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetAssignReplyViewMore(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetAssignReplyViewMore.htm "+req.getUserPrincipal().getName());
			List<Object[]> RelyViewMoreData =new ArrayList<Object[]>();
			try {
				String DakReplyId=req.getParameter("dakreplyid");
			   if(DakReplyId!=null) {
				   RelyViewMoreData = service.GetDakAssignReplyDetails(Long.parseLong(DakReplyId)); 
			   }else {
				   RelyViewMoreData = null;
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetAssignReplyViewMore.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RelyViewMoreData);
		}
		
		
		@RequestMapping(value = "GetAssignReplyEditDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetAssignReplyEditDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetAssignReplyEditDetails.htm "+req.getUserPrincipal().getName());
			DakAssignReply RelyEditData = null;
			try {
				String DakAssignReplyId=req.getParameter("replyid");
			   if(DakAssignReplyId!=null) {
				   RelyEditData = service.GetDakAssignReplyEditDetails(Long.parseLong(DakAssignReplyId)); 
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetAssignReplyEditDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RelyEditData);
		}
		
		
		
		@RequestMapping(value = "DAKAssignReplyDataEdit.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DAKAssingReplyDataEdit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir,@RequestPart(name = "dak_replyEdit_document", required = false) MultipartFile[] replydocuments) throws Exception {
            logger.info(new Date() +"DAKAssingReplyDataEdit.htm"+req.getUserPrincipal().getName());
            long result=0;
            String fromDate=(String)req.getParameter("FromDate");
			String toDate=(String)req.getParameter("ToDate");
			String dakAssignReplyId = req.getParameter("dakAssignReplyIdValue");
	      	String dakId=req.getParameter("dakIdFrEdit");
	     	String empId=req.getParameter("empIdFrEdit");
	    	String ReplyVal=req.getParameter("assignReplyEditedVal");
	    	String ReplyEditDakAssignId=req.getParameter("dakAssignIdFrEdit");
			try {
				 if(fromDate!=null || toDate != null) {
					 try {
						 fromDate=rdf.format(sdf2.parse(fromDate));
						 toDate=rdf.format(sdf2.parse(toDate)); 
						 redir.addAttribute("FromDate", fromDate);
						 redir.addAttribute("ToDate",   toDate);
					 }catch (ParseException e) {
						 e.printStackTrace();
					 }
				 }
	    	DakAssignReplyDto dto=DakAssignReplyDto.builder().AssignReplyDocs(replydocuments).build();
	    	dto.setDakAssignReplyId(Long.parseLong(dakAssignReplyId));
			dto.setDakId(Long.parseLong(dakId));
			dto.setAssignId(Long.parseLong(ReplyEditDakAssignId));
			dto.setEmpId(Long.parseLong(empId));
			dto.setReply(ReplyVal.trim());
			dto.setModifiedBy(req.getUserPrincipal().getName());
			dto.setModifiedDate(sdf1.format(new Date()));
			result=service.editDakAssignReply(dto);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DAKAssingReplyDataEdit.htm"+req.getUserPrincipal().getName()+e);
			}
			if(result>0) 
			{
				redir.addAttribute("result","DAK Assign Reply Edit Successfully ");
			}
			else
			{
				redir.addAttribute("resultfail","DAK Assign Reply Edit Unsuccessful");
			}
         if(req.getParameter("viewfrom")!=null && req.getParameter("viewfrom").equalsIgnoreCase("DakAssignedList")) {
				redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				redir.addAttribute("DakId", req.getParameter("dakIdFrEdit"));
				return "redirect:/DakReceivedView.htm";
			}else {
			return "redirect:/DakAssignedList.htm";
			}
			
		}
		
		@RequestMapping(value = "AssignReplyAttachDelete.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String AssignReplyAttachDelete(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
		{
			logger.info(new Date() +"Inside AssignReplyAttachDelete.htm "+ req.getUserPrincipal().getName());
			String DakId=null;
			try
			{
				String DakAssignReplyAttachId = req.getParameter("replyAttachmentIdVal");
				String DakAssignReplyId=req.getParameter("replyIdVal");
				int deleteResult = 0;
				List<Object[]> AssignreplyDakAttachmentData = null;
				if(DakAssignReplyAttachId!=null && DakAssignReplyId!=null ) {
					AssignreplyDakAttachmentData  = service.AssignReplyDakAttachmentData(Long.parseLong(DakAssignReplyAttachId),Long.parseLong(DakAssignReplyId));
				}
				if(AssignreplyDakAttachmentData!=null && AssignreplyDakAttachmentData.size() > 0) {
					Object[] data =  AssignreplyDakAttachmentData.get(0);
					DakId=data[9].toString();
					File my_file=null;
					String assignreplyattachmentdata = data[0].toString().replaceAll("[/\\\\]", ",");
		        	String[] fileParts = assignreplyattachmentdata.split(",");
			        my_file = new File(env.getProperty("file_upload_path") + File.separator+"Dak" + File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+data[1]);
					boolean result = Files.deleteIfExists(my_file.toPath());
				if(result) 
				{
					deleteResult = service.DeleteAssignReplyAttachment(DakAssignReplyAttachId);
					if(deleteResult>0) {
						redir.addAttribute("result","Document Deleted Successfully");
					}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful"); }
				}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful in Folder"); }
				
				}else { redir.addAttribute("resultfail","Document not found"); }
			}catch (Exception e) {
					e.printStackTrace(); 
					logger.error(new Date() +"Inside AssignReplyAttachDelete.htm "+ req.getUserPrincipal().getName(),e);
			}
			if(req.getParameter("viewfrom")!=null && req.getParameter("viewfrom").equalsIgnoreCase("DakAssignedList")) {
				redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				redir.addAttribute("DakId", DakId);
				return "redirect:/DakReceivedView.htm";
			}else {
			return "redirect:/DakAssignedList.htm";
			}
		}
		
		//Getting All previously marked Employee details
		@RequestMapping(value = "getDistributedDakMeberslist.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDistributedDakMeberslist(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getDistributedDakMeberslist.htm "+req.getUserPrincipal().getName());
			List<Object[]> getDistributedDakMeberslist=null;
			String DakId=req.getParameter("DakId");
			try {
				getDistributedDakMeberslist=service.DakMarkingData(Long.parseLong(DakId));
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDistributedDakMeberslist.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getDistributedDakMeberslist);
		}
		
		
		//Getting only group marking(Y) previously marked Employee details which are INACTIVE = 1;
		@RequestMapping(value = "getMarkedGroupMembersEmps.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getMarkedGroupMembersEmps(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getMarkedGroupMembersEmps.htm "+req.getUserPrincipal().getName());
			List<Object[]> GetMarkedGropList=null;
			String dakId=req.getParameter("dakId");
			try {
				if(dakId!=null) {
				GetMarkedGropList=service.DakMarkedMemberGroup(dakId);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getMarkedGroupMembersEmps.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(GetMarkedGropList);
		}
		
		//Getting only group marking(Y) previously marked Employee details which are INACTIVE = 0;
		@RequestMapping(value = "getMarkedInactiveGroupMembersEmps.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getMarkedInactiveGroupMembersEmps(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getMarkedInactiveGroupMembersEmps.htm "+req.getUserPrincipal().getName());
			List<Object[]> GetMarkedInactiveGropList=null;
			String dakId=req.getParameter("dakId");
			try {
				if(dakId!=null) {
					GetMarkedInactiveGropList=service.DakInactiveMarkedMemberGroup(dakId);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getMarkedInactiveGroupMembersEmps.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(GetMarkedInactiveGropList);
		}
		

		@RequestMapping(value = "getProjectDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getProjectDetails(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getProjectDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> GetProjectDetailsList=null;
			String projectId=req.getParameter("projectId");
			try {
				if(projectId!=null) {
					GetProjectDetailsList=service.ProjectDetailedList(projectId);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getProjectDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(GetProjectDetailsList);
		}
		
		@RequestMapping(value = "CSWReplyForwardReturn.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String CSWReplyForwardReturn(HttpServletRequest req,HttpServletResponse resp,RedirectAttributes redir) throws Exception {
			logger.info(new Date() +"Inside CSWReplyForwardReturn.htm "+req.getUserPrincipal().getName());
			 long result=0;
			 try {
				String DakAssignReplyIdFrReturn=req.getParameter("DakAssignReplyIdFrReturn");
				String ReturnRemarks=req.getParameter("ReturnReplyremarks");
				if(DakAssignReplyIdFrReturn!=null) {
					result=service.CSWReplyForwardReturn(Long.parseLong(DakAssignReplyIdFrReturn),ReturnRemarks.trim());
				}
			} catch (Exception e) {
				e.printStackTrace();
				  logger.error(new Date() +"CSWReplyForwardReturn.htm"+req.getUserPrincipal().getName()+e);
			}
			if(result>0) 
			{
				redir.addAttribute("result","DAK Forwarded Successfully ");
			}
			else
			{
				redir.addAttribute("resultfail","DAK Forwarded Unsuccessful");
			}
			return "redirect:/DakReceivedList.htm";
			
		}
		
		
		
		@RequestMapping(value = "DAKAssignReplyReturnDataEdit.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DAKAssignReplyReturnDataEdit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir,@RequestPart(name = "dak_replyEdit_document", required = false) MultipartFile[] replydocuments) throws Exception {
			
            logger.info(new Date() +"DAKAssignReplyReturnDataEdit.htm"+req.getUserPrincipal().getName());
            long result=0;
            String dakAssignReplyId = req.getParameter("dakAssignReplyIdValue");
	      	String dakId=req.getParameter("dakIdFrEdit");
	     	String empId=req.getParameter("empIdFrEdit");
	    	String ReplyVal=req.getParameter("assignReplyEditedVal");
	    	String ReplyEditDakAssignId=req.getParameter("dakAssignIdFrEdit");
	    	String PrevReply=req.getParameter("PrevReply");
	    	String a = req.getParameter("PrevFilePathandFileName");
	    	String PrevFilePathandFileName[]=a.split(",");
	    	String MarkedassignReplyEditedVal=req.getParameter("MarkedassignReplyEditedVal");
			try {
	    	DakAssignReplyDto dto=DakAssignReplyDto.builder().AssignReplyDocs(replydocuments).build();
	    	dto.setDakAssignReplyId(Long.parseLong(dakAssignReplyId));
			dto.setDakId(Long.parseLong(dakId));
			dto.setAssignId(Long.parseLong(ReplyEditDakAssignId));
			dto.setEmpId(Long.parseLong(empId));
			dto.setReply(ReplyVal.trim());
			dto.setModifiedBy(req.getUserPrincipal().getName());
			dto.setModifiedDate(sdf1.format(new Date()));
			result=service.ReplyeditDakAssignReply(dto);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DAKAssignReplyReturnDataEdit.htm"+req.getUserPrincipal().getName()+e);
			}
			if(result>0) 
			{
				DakAssignReplyRevDto rdto=DakAssignReplyRevDto.builder().PrevFilePath(PrevFilePathandFileName).build();
				rdto.setDakAssignReplyId(Long.parseLong(dakAssignReplyId));
				rdto.setEmpId(Long.parseLong(empId));
				rdto.setPreReply(PrevReply.trim());
				rdto.setReturnRemarks(MarkedassignReplyEditedVal.trim());
				rdto.setCreatedBy(req.getUserPrincipal().getName());
				rdto.setCreatedDate(sdf1.format(new Date()));
				service.DakAssignReplyRev(rdto,PrevFilePathandFileName);
				redir.addAttribute("result","DAK Assign Reply Return Edit Successfully ");
			}
			else
			{
				redir.addAttribute("resultfail","DAK Assign Reply Return Edit Unsuccessful");
			}
			return "redirect:/DakAssignedList.htm";
			
		}
		
		
		@RequestMapping(value = "GetAssignReplyReturnEditDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetAssignReplyReturnEditDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetAssignReplyReturnEditDetails.htm "+req.getUserPrincipal().getName());
			DakAssignReply RelyEditData = null;
			try {
				String DakAssignReplyId=req.getParameter("replyid");
			   if(DakAssignReplyId!=null) {
				   RelyEditData = service.GetDakAssignReplyEditDetails(Long.parseLong(DakAssignReplyId)); 
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetAssignReplyReturnEditDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RelyEditData);
		}
		
		
		@RequestMapping(value = "GetAssignReplyReturnAttachModalList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetAssignReplyReturnAttachModalList(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetAssignReplyAttachModalList.htm "+req.getUserPrincipal().getName());
			List<Object[]> AssignRelyAttachModalData =new ArrayList<Object[]>();
			try {
			   String DakReplyId = req.getParameter("dakreplyid");
			   if(DakReplyId!=null) {
				   AssignRelyAttachModalData = service.GetAssignReplyAttachmentList(Long.parseLong(DakReplyId));
				 }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetAssignReplyAttachModalList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(AssignRelyAttachModalData);
		}
		
		
		@RequestMapping(value = "getDakActionRequiredEdit.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDakActionRequiredEdit(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getDakActionRequiredEdit.htm "+req.getUserPrincipal().getName());
			List<Object[]> getDakActionRequiredEdit=null;
			String ActionRequiredDakId=req.getParameter("ActionRequiredDakId");
			try {
				if(ActionRequiredDakId!=null) {
					getDakActionRequiredEdit=service.getDakActionRequiredEdit(Long.parseLong(ActionRequiredDakId));
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDakActionRequiredEdit.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getDakActionRequiredEdit);
		}

		
		@RequestMapping(value = "DakActionRequiredEdit.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakActionRequiredEdit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception{
			logger.info(new Date() +"Inside DakActionRequiredEdit.htm "+req.getUserPrincipal().getName());
			long Result=0;
			String PageNumber=req.getParameter("PageNumber");
			String RowNumber=req.getParameter("RowNumber");
			try {
				String ActionRequiredEditDakId=req.getParameter("ActionRequiredEditDakId");
				String ActionRequiredEdit=req.getParameter("ActionRequiredEdit");
				String ClosingAuthority=req.getParameter("closingAuthorityValEdit");
				String EditRemarks=req.getParameter("EditRemarks");
				long ActionId=0;
				String ActionCode=null;
				if(ActionRequiredEdit!=null)
	  			{
	  				String[] arr=ActionRequiredEdit.split("#");
	  				ActionId=Integer.parseInt(arr[0]);
	  				ActionCode=arr[1].trim();
	  			}
				String DueDate=req.getParameter("DueDate");
				String ActionTime=req.getParameter("DueTime");
				String fromDate=(String)req.getParameter("FromDate");
			    String toDate=(String)req.getParameter("ToDate");
				 if(fromDate!=null || toDate != null) {
							 try {
								 fromDate=rdf.format(sdf2.parse(fromDate));
								 toDate=rdf.format(sdf2.parse(toDate)); 
								 redir.addAttribute("FromDate", fromDate);
								 redir.addAttribute("ToDate",   toDate);
							 }catch (ParseException e) {
								 e.printStackTrace();
							 }
						 }
				
				
				if(ActionRequiredEditDakId!=null && ActionCode.equalsIgnoreCase("ACTION") && DueDate!=null && ActionTime!=null) {
					DueDate=sdf2.format(rdf.parse(DueDate));
					Result=service.EditActionRequired(Long.parseLong(ActionRequiredEditDakId),ActionId,DueDate,ActionTime,ClosingAuthority,EditRemarks.trim());
					service.updatedakmarkingaction(Long.parseLong(ActionRequiredEditDakId),ActionId,DueDate);
				}else {
					Result=service.EditActionRequired(Long.parseLong(ActionRequiredEditDakId),ActionId,ClosingAuthority,EditRemarks.trim());
					service.updatedakmarkingrecords(Long.parseLong(ActionRequiredEditDakId),ActionId);
				}
				redir.addAttribute("PageNumber",PageNumber);
				redir.addAttribute("RowNumber",RowNumber);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DakActionRequiredEdit.htm"+req.getUserPrincipal().getName()+e);
			}
			if(Result>0) 
			{
				redir.addAttribute("result","DAK Action Required  Edit Successfully ");
			}
			else
			{
				redir.addAttribute("resultfail","DAK Action Required  Edit Unsuccessful");
			}
			String redirectVal = null;
			redirectVal = req.getParameter("ActionRequiredEditActionVal");
			if(redirectVal!=null && "DakDirectorList".equalsIgnoreCase(redirectVal)) {
				return "redirect:/DakDirectorList.htm";
	        }else if(redirectVal!=null && "DakDetailedList".equalsIgnoreCase(redirectVal)) {
	        	return "redirect:/DakList.htm";
	        }else if(redirectVal!=null && "DakViewList".equalsIgnoreCase(redirectVal)) {
	        	redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				redir.addAttribute("DakId", req.getParameter("ActionRequiredEditDakId"));
	        	return "redirect:/DakReceivedView.htm";
			}else {
				return "redirect:/DakInitiationList.htm";
			}
			
		}
		
		@RequestMapping(value = "DakTransitionHistory.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakTransitionHistory(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception{
			logger.info(new Date() +"Inside DakTransitionHistory.htm "+req.getUserPrincipal().getName());
			try {
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DakTransitionHistory.htm"+req.getUserPrincipal().getName()+e);
			}
			return "dak/dakcswtransition";
		}
		
		@RequestMapping(value = "DakPendingReplyList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakPendingReply(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir)  throws Exception{
			logger.info(new Date() +" In CONTROLLER DakPendingReplyList.htm "+req.getUserPrincipal().getName());
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				String Username=req.getUserPrincipal().getName();
				Date date = new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String StatusValue = (String)req.getParameter("StatusFilterVal");
				String PageNoRedirected=(String)req.getParameter("PageNoData");
				String RowRedirected=(String)req.getParameter("RowData");
				
				String lettertypeid=req.getParameter("lettertypeid");
				if(lettertypeid==null) {
					lettertypeid="All";
				}
				String priorityid=req.getParameter("priorityid");
				if(priorityid==null) {
					priorityid="All";
				}
				String sourcedetailid=req.getParameter("sourcedetailid");
				if(sourcedetailid==null) {
					sourcedetailid="All";
				}
				String SourceId=req.getParameter("SourceId");
				if(SourceId==null) {
					SourceId="All";
				}
				String ProjectType=req.getParameter("ProjectType");
				if(ProjectType==null) {
					ProjectType="All";
				}
				String ProjectId=req.getParameter("ProjectId");
				if(ProjectId==null) {
					ProjectId="All";
				}
				String DakMemberTypeId=req.getParameter("DakMemberTypeId");
				if(DakMemberTypeId==null) {
					DakMemberTypeId="All";
				}
				String EmployeeId=req.getParameter("EmpId");
				if(EmployeeId==null) {
					EmployeeId="All";
				}
				
				
				if(StatusValue == null) {
					StatusValue = "All";
				}
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -30); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				Object[] UserName= null;
				UserName=service.getUsername(EmpId);
				req.setAttribute("pageNoRedirected", PageNoRedirected);
				req.setAttribute("rowRedirected",   RowRedirected);
				req.setAttribute("Username", UserName);
				req.setAttribute("EmpId",   String.valueOf(EmpId));
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("statusValue",   StatusValue);
				req.setAttribute("dakPendingReplyList", service.dakPendingReplyList(fromDate,toDate,StatusValue,EmpId,Username,lettertypeid,priorityid,sourcedetailid,SourceId,ProjectType,ProjectId,DakMemberTypeId,EmployeeId));
				return "dak/dakPendingReplyList";
			} catch (Exception e) {
				logger.error(new Date() +" In CONTROLLER DakPendingReplyList.htm "+req.getUserPrincipal().getName()+"  "+e);
				return "static/Error";
			}
		}

		@RequestMapping(value = "DakReAssign.htm" ,method = RequestMethod.POST)
		public String DakReAssign(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) {
			logger.info(new Date() +"Inside DakReAssign.htm "+req.getUserPrincipal().getName());
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				String DakId=req.getParameter("DakMarkingId");
				String remarks=req.getParameter("remarks");
				String DakCaseWorker[]=req.getParameterValues("DakCaseWorker");
				String DakMarkingIdsel=req.getParameter("DakMarkingIdsel");
				DakAssignDto dto=new DakAssignDto();
				dto.setDakId(Long.parseLong(DakId));
				dto.setDakMarkingId(Long.parseLong(DakMarkingIdsel));
				dto.setRemarks(remarks.trim());
				dto.setReplyStatus("N");
				dto.setCreatedBy(req.getUserPrincipal().getName());
				dto.setCreatedDate(sdf1.format(new Date()));
				long DakAssignInsert=service.DakAssignInsert(dto,DakCaseWorker,EmpId);
				if(DakAssignInsert>0) 
				{
					service.dakAssignstatus(Long.parseLong(DakMarkingIdsel));
					redir.addAttribute("result","DAK ReAssign Successfully ");
				}
				else
				{
					redir.addAttribute("resultfail","DAK ReAssign Unsuccessful");
				}
				//redirection
				String fromDate=(String)req.getParameter("fromDateFetch");
				String toDate=(String)req.getParameter("toDateFetch");
				if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
				    try {
				        fromDate = rdf.format(sdf2.parse(fromDate));
				        toDate = rdf.format(sdf2.parse(toDate));
				        redir.addAttribute("FromDate", fromDate);
				        redir.addAttribute("ToDate", toDate);
				    } catch (ParseException e) {
				        e.printStackTrace();
				        // Handle the exception appropriately (e.g., log the error or provide a default value).
				    }
				}
				return "redirect:/DakReceivedList.htm";
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakReAssign.htm "+req.getUserPrincipal().getName(), e);
				return null;
			}
			
		}
		
		
		@RequestMapping(value = "UpdateMarkerAction.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public  String UpdateMarkerAction(HttpServletRequest req, HttpServletResponse res, HttpSession ses,RedirectAttributes redir) throws Exception 
		{
			logger.info(new Date() +"Inside UpdateMarkerAction.htm "+req.getUserPrincipal().getName());
			long UpdateMarkerAction=0;
			 String FromDate = req.getParameter("fromDateCmnValue");  
			 String ToDate = req.getParameter("toDateCmnValue");  
			 String DakId=req.getParameter("dakidmarkeraction");
			 String DakMarkingId=req.getParameter("dakmarkingidforMarkerAction");
			 String EmpId=req.getParameter("DakempforMarkerAction");
			 String ActionValue=req.getParameter("ActionForMarkerAction");
			 String ActionValueForMarkerAction=req.getParameter("ActionValueForMarkerAction");
			 String countForMarkerAction=req.getParameter("countForMarkerAction");
			 String redirvalueformarkeraction=req.getParameter("redirvalueformarkeraction");
			try {
		   
				if(DakId!=null && DakMarkingId!=null && EmpId!=null && ActionValue!=null && ActionValueForMarkerAction!=null) {
					UpdateMarkerAction=service.UpdateMarkerAction(Long.parseLong(DakId),Long.parseLong(DakMarkingId),Long.parseLong(EmpId),ActionValue);
				}
				if(UpdateMarkerAction>0) {
					redir.addAttribute("result",ActionValueForMarkerAction+" Updated Successfully ");
					
				}else {
					redir.addAttribute("resultfail",ActionValueForMarkerAction+"Update  Unsuccessful");
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside UpdateMarkerAction.htm "+req.getUserPrincipal().getName(), e);
			}
			 if(FromDate!=null || ToDate != null) {
				 try {
					 FromDate=rdf.format(sdf2.parse(FromDate));
					 ToDate=rdf.format(sdf2.parse(ToDate)); 
					 redir.addAttribute("FromDate", FromDate);
					 redir.addAttribute("ToDate",   ToDate);
				 }catch (ParseException e) {
					 e.printStackTrace();
				 }
				 }
			 redir.addAttribute("countFrMsgRedirect",countForMarkerAction);
			 if(redirvalueformarkeraction!=null && "DakDirectorList".equalsIgnoreCase(redirvalueformarkeraction)) {
					return "redirect:/DakDirectorList.htm";
		        }else {
		        	return "redirect:/DakList.htm";
		        }
		}
		
		@RequestMapping(value = "getDakLinkData.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getDakLinkData(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getDakLinkData.htm "+req.getUserPrincipal().getName());
			List<Object[]> getalldaklinkdata=null;
			String DakId=req.getParameter("DakId");
			try {
				if(DakId!=null) {
					getalldaklinkdata=service.getalldaklinkdata(Long.parseLong(DakId));
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getDakLinkData.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getalldaklinkdata);
		}
		
		
		@RequestMapping(value = "DownloadExcel.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public void DownloadExcel(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) throws Exception{
			String UserName=(String)ses.getAttribute("Username");
			int RowNo=0;
			logger.info(new Date() + " Inside DownloadExcel.htm " + UserName);
			try {
				Date date = new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String StatusValue = (String)req.getParameter("StatusFilterVal");
				if(StatusValue == null) {
					StatusValue = "All";
				}
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -7); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				
				String lettertypeid=req.getParameter("lettertypeid");
				if(lettertypeid==null) {
					lettertypeid="All";
				}
				String priorityid=req.getParameter("priorityid");
				if(priorityid==null) {
					priorityid="All";
				}
				String sourcedetailid=req.getParameter("sourcedetailid");
				if(sourcedetailid==null) {
					sourcedetailid="All";
				}
				String SourceId=req.getParameter("SourceId");
				if(SourceId==null) {
					SourceId="All";
				}
				String ProjectType=req.getParameter("ProjectType");
				if(ProjectType==null) {
					ProjectType="All";
				}
				String ProjectId=req.getParameter("ProjectId");
				if(ProjectId==null) {
					ProjectId="All";
				}
				String DakMemberTypeId=req.getParameter("DakMemberTypeId");
				if(DakMemberTypeId==null) {
					DakMemberTypeId="All";
				}
				String EmpId=req.getParameter("EmpId");
				if(EmpId==null) {
					EmpId="All";
				}
				
				String ActionId=req.getParameter("ActionId");
				if(ActionId==null) {
					ActionId="All";
				}
				List<Object[]> PnCDoList=service.DakPnCDoList(fromDate,toDate,StatusValue,lettertypeid,priorityid,sourcedetailid,SourceId,ProjectType,ProjectId,DakMemberTypeId,EmpId,ActionId);
				Workbook workbook = new XSSFWorkbook();
				Sheet sheet = workbook.createSheet("Download Excel");
				sheet.setColumnWidth(0, 1000);
				sheet.setColumnWidth(1, 5000);
				sheet.setColumnWidth(2, 4000);
				sheet.setColumnWidth(3, 4000);
				sheet.setColumnWidth(4, 6000);
				sheet.setColumnWidth(5, 5000);
				sheet.setColumnWidth(6, 3000);
				sheet.setColumnWidth(7, 4000);
				sheet.setColumnWidth(8, 4000);
				sheet.setColumnWidth(9, 4000);
				sheet.setColumnWidth(10,4000);
				sheet.setColumnWidth(11,4000);
				sheet.setColumnWidth(12,4000);
				sheet.setColumnWidth(13,6000);
				sheet.setColumnWidth(14,5000);
				
				
				
				XSSFFont font = ((XSSFWorkbook) workbook).createFont();
				font.setFontName("Times New Roman");
				font.setFontHeightInPoints((short) 10);
				font.setBold(true);
				// style for table header i.e Subtitle or Report Title
							CellStyle t_header_style = workbook.createCellStyle();
							t_header_style.setLocked(true);
							t_header_style.setFont(font);
							t_header_style.setWrapText(true);
							t_header_style.setAlignment(HorizontalAlignment.CENTER);
							t_header_style.setVerticalAlignment(VerticalAlignment.CENTER);
							// style for table cells
							CellStyle t_body_style = workbook.createCellStyle();
							t_body_style.setWrapText(true);
							
							CellStyle styleRight = workbook.createCellStyle();
							styleRight.setAlignment(HorizontalAlignment.RIGHT);
							
							CellStyle styleLeft = workbook.createCellStyle();
							styleLeft.setAlignment(HorizontalAlignment.LEFT);
							
							CellStyle styleCenter = workbook.createCellStyle();
							styleCenter.setAlignment(HorizontalAlignment.CENTER);

							// style for file header
							CellStyle file_header_Style = workbook.createCellStyle();
							file_header_Style.setLocked(true);
							file_header_Style.setFont(font);
							file_header_Style.setWrapText(true);
							file_header_Style.setAlignment(HorizontalAlignment.CENTER);
							file_header_Style.setVerticalAlignment(VerticalAlignment.CENTER);
							
							
							String Excel="P&C DO Excel List ";
							Row file_header_row = sheet.createRow(RowNo++);
							sheet.addMergedRegion(new CellRangeAddress(0, 0,0, 14));   // Merging Header Cells 
							Cell cell= file_header_row.createCell(0);
							cell.setCellValue(""+Excel+ " "+"( "+sdf.format(sdf2.parse(fromDate))+" - "+sdf.format(sdf2.parse(toDate)) +")");
							file_header_row.setHeightInPoints((1*sheet.getDefaultRowHeightInPoints()));
							cell.setCellStyle(file_header_Style);
							// File header Row 2
							
							Row t_header_row = sheet.createRow(RowNo++);
							cell= t_header_row.createCell(0); 
							cell.setCellValue("SN"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(1); 
							cell.setCellValue("DAK No"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(2); 
							cell.setCellValue("Email Type"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(3); 
							cell.setCellValue("Received From"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(4); 
							cell.setCellValue("DAK Brief"); 
							cell.setCellStyle(t_header_style);

							cell= t_header_row.createCell(5); 
							cell.setCellValue("Attachments"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(6); 
							cell.setCellValue("Enclosures"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(7); 
							cell.setCellValue("Action/Records"); 
							cell.setCellStyle(t_header_style);

							cell= t_header_row.createCell(8); 
							cell.setCellValue("DueDate"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(9); 
							cell.setCellValue("Keyword1"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(10); 
							cell.setCellValue("Keyword2"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(11); 
							cell.setCellValue("Keyword3"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(12); 
							cell.setCellValue("Reply Sent Date"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(13); 
							cell.setCellValue("Reply Details"); 
							cell.setCellStyle(t_header_style);
							
							cell= t_header_row.createCell(14); 
							cell.setCellValue("Status"); 
							cell.setCellStyle(t_header_style);
							
					long slno=1;
					if(PnCDoList!=null && PnCDoList.size()>0){
						for(Object[] obj:PnCDoList){
							   String Action=null;
							   if(obj[9]!=null && "ACTION".equalsIgnoreCase(obj[9].toString())){
								   Action="A";
							   }else if(obj[9]!=null && "RECORDS".equalsIgnoreCase(obj[9].toString())){
								   Action="R";
							   }
							   String replieddate=null;
							   if(obj[38]!=null && !"NA".equalsIgnoreCase(obj[38].toString())){
								   String[] markerDate=obj[38].toString().split(" ");
								   replieddate=markerDate[0];
							   }
							   String StatusCountAck = null;
							   String StatusCountReply = null;
								if(obj[5]!=null  && obj[30]!=null && Long.parseLong(obj[30].toString())==0
									&& obj[29]!=null && Long.parseLong(obj[29].toString())>0
									&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
									&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
										   ){	
									StatusCountAck = "Acknowledged["+obj[29]+"/"+obj[27]+"]";
								   }
								 if(obj[5]!=null  && obj[29]!=null && Long.parseLong(obj[29].toString())>0
									&& obj[28]!=null && Long.parseLong(obj[28].toString()) > 0
								    && obj[30]!=null && Long.parseLong(obj[30].toString()) > 0
									&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
									&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
												   ){	
									 StatusCountReply  = "Replied["+obj[30]+"/"+obj[28]+"]";
										   }
					Row t_body_row=sheet.createRow(RowNo);
					 t_body_row=sheet.createRow(RowNo++);
						 cell= t_body_row.createCell(0); 
						 cell.setCellValue(slno); 
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleCenter);
						 
						 cell= t_body_row.createCell(1); 
						 if(obj[8]!=null) {
						 cell.setCellValue(obj[8].toString()); 
						 }else {
							 cell.setCellValue("-");
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
					     cell= t_body_row.createCell(2); 
					     if(obj[40]!=null) {
						 cell.setCellValue(obj[40].toString());
					     }else {
					     cell.setCellValue("-");
					     }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
						 cell= t_body_row.createCell(3);
						 if(obj[3]!=null) {
						 cell.setCellValue(obj[3].toString());
						 }else {
						 cell.setCellValue("-");
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
						 cell= t_body_row.createCell(4); 
						 if(obj[31]!=null) {
						 cell.setCellValue(obj[31].toString()); 
						 }else {
						 cell.setCellValue("-");
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
						 cell= t_body_row.createCell(5); 
						 if(obj[36]!=null) {
						 cell.setCellValue(obj[36].toString()); 
						 }else {
						 cell.setCellValue("NA");	 
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
						 cell= t_body_row.createCell(6); 
						 if(obj[37]!=null) {
						 cell.setCellValue(obj[37].toString()); 
						 }else {
						 cell.setCellValue("NA");
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleCenter);
						 
						 cell= t_body_row.createCell(7); 
						 cell.setCellValue(Action); 
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleCenter);
						 
				         cell= t_body_row.createCell(8); 
				         if(obj[10]!=null) {
						 cell.setCellValue(sdf.format(obj[10])); 
				         }else {
				         cell.setCellValue("NA"); 
				         }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleCenter);
						 
						 cell= t_body_row.createCell(9); 
						 if(obj[32]!=null) {
						 cell.setCellValue(obj[32].toString());
						 }else {
						 cell.setCellValue("-");	 
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
						 cell= t_body_row.createCell(10); 
						 if(obj[33]!=null) {
						 cell.setCellValue(obj[33].toString());
						 }else {
						 cell.setCellValue("-"); 
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
						 cell= t_body_row.createCell(11); 
						 if(obj[34]!=null) {
						 cell.setCellValue(obj[34].toString());
						 }else {
						 cell.setCellValue("-"); 
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
						 cell= t_body_row.createCell(12); 
						 if(obj[38]!=null && !"NA".equalsIgnoreCase(obj[38].toString())) {
							 String repliedDate = obj[38].toString();
					         Date date1 = sdf1.parse(repliedDate);
					         cell.setCellValue(sdf.format(date1));
						 }else {
							 cell.setCellValue("NA");
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleCenter);
						 
						 cell= t_body_row.createCell(13); 
						 if(obj[39]!=null) {
						 cell.setCellValue(obj[39].toString());
						 }else {
						 cell.setCellValue("-"); 
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
						 cell= t_body_row.createCell(14); 
						 if(obj[7]!=null) {
							
					     if(StatusCountAck!=null) {
					    	 cell.setCellValue(StatusCountAck); 
					     }else if(StatusCountReply!=null) {
					    	 cell.setCellValue(StatusCountReply);
					     }else{
						 cell.setCellValue(obj[7].toString()); 
					     }
						 }
						 cell.setCellStyle(t_body_style);
						 cell.setCellStyle(styleLeft);
						 
						 slno++;
						}
					}
					String path = req.getServletContext().getRealPath("/view/temp");
					String fileLocation = path.substring(0, path.length() - 1) + "temp.xlsx";
					FileOutputStream outputStream = new FileOutputStream(fileLocation);
					workbook.write(outputStream);
					workbook.close();
					String filename="P&C DO Excel ";
					resp.setContentType("application/octet-stream");
					resp.setHeader("Content-disposition", "attachment; filename="+filename+".xlsx");
					File f=new File(fileLocation);
					FileInputStream fis = new FileInputStream(f);
				    DataOutputStream os = new DataOutputStream(resp.getOutputStream());
			        resp.setHeader("Content-Length",String.valueOf(f.length()));
					byte[] buffer = new byte[1024];
					int len = 0;
					while ((len = fis.read(buffer)) >= 0)
					{
					    os.write(buffer, 0, len);
					} 
					os.close();
					fis.close();
			
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		@RequestMapping(value = "DakRemarkRedistribute.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public  String DakRemarkRedistribute(HttpServletRequest req, HttpServletResponse res, HttpSession ses,RedirectAttributes redir) throws Exception 
		{
			logger.info(new Date() +"Inside DakRemarkRedistribute.htm "+req.getUserPrincipal().getName());
			try {
				Date date=new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String PageNumber=req.getParameter("PageNumber");
				String RowNumber=req.getParameter("RowNumber");
				String StatusValue = (String)req.getParameter("StatusFilterVal");
				if(StatusValue == null) {
					StatusValue = "All";
				}
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -30); 
				Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				req.setAttribute("PageNumber", PageNumber);
				req.setAttribute("RowNumber",   RowNumber);
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("DakMembers", service.getDakMembers());
                req.setAttribute("DakMemberGroup", service.DakMemberGroup());
				req.setAttribute("statusValue",   StatusValue);
				req.setAttribute("DakRemarknRedistributeList", service.DakRemarknRedistributeList(fromDate,toDate,StatusValue));
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DakRemarkRedistribute.htm"+req.getUserPrincipal().getName()+e);
			}
			return "dak/dakRemarknRedistribute";
			
		}
		
		
		@RequestMapping(value = "DakSeekResponse.htm" ,method = {RequestMethod.GET , RequestMethod.POST})
		public String DakSeekResponse(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) {
			logger.info(new Date() +"Inside DakSeekResponse.htm "+req.getUserPrincipal().getName());
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				String DakId=req.getParameter("DakMarkingId");
				String DakCaseWorker[]=req.getParameterValues("DakSeekCaseWorker");
				String DakMarkingIdsel=req.getParameter("DakMarkingIdsel");
				String SeekResponseRedirectVal=req.getParameter("SeekResponseRedirectVal");
				String redirectedvalue=req.getParameter("redirectedvalue");
				String SeekResponseremarks=req.getParameter("SeekResponseremarks");
				String seekFrom=req.getParameter("seekFrom");
				if(redirectedvalue!=null) {
					redir.addAttribute("redirectedvalue", redirectedvalue);
				}
				DakSeekResponseDto dto=new DakSeekResponseDto();
				dto.setDakId(Long.parseLong(DakId));
				dto.setSeekAssignerId(Long.parseLong(DakMarkingIdsel));
				dto.setSeekFrom(seekFrom);
				dto.setRemarks(SeekResponseremarks);
				dto.setReplyStatus("N");
				dto.setCreatedBy(req.getUserPrincipal().getName());
				dto.setCreatedDate(sdf1.format(new Date()));
				dto.setIsActive(1);
				long DakSeekResponseInsert=service.DakSeekResponseInsert(dto,DakCaseWorker,EmpId);
				if(DakSeekResponseInsert>0) 
				{
					redir.addAttribute("result","DAK SeekResponse Assign Successfully ");
				}
				else
				{
					redir.addAttribute("resultfail","DAK SeekResponse Assign Unsuccessful");
				}
				//redirection
				String Page=(String)req.getParameter("PageValBySeekRepsonse");
				String Row=(String)req.getParameter("RowValBySeekRepsonse");
				redir.addAttribute("PageNoData", Page);
			    redir.addAttribute("RowData", Row);
				String fromDate=(String)req.getParameter("fromDateFetch");
				String toDate=(String)req.getParameter("toDateFetch");
				if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
				    try {
				        fromDate = rdf.format(sdf2.parse(fromDate));
				        toDate = rdf.format(sdf2.parse(toDate));
				        redir.addAttribute("FromDate", fromDate);
				        redir.addAttribute("ToDate", toDate);
				    } catch (ParseException e) {
				        e.printStackTrace();
				        // Handle the exception appropriately (e.g., log the error or provide a default value).
				    }
				}
				redir.addAttribute("DakId", DakId);
				if(SeekResponseRedirectVal!=null && SeekResponseRedirectVal.equalsIgnoreCase("DakReceivedList")) {
				return "redirect:/DakReceivedList.htm";
				}else if(SeekResponseRedirectVal!=null && SeekResponseRedirectVal.equalsIgnoreCase("DakAssignedList")) {
					return "redirect:/DakAssignedList.htm";
				}else  if(SeekResponseRedirectVal!=null && SeekResponseRedirectVal.equalsIgnoreCase("DakRepliedList")){
					return "redirect:/DakRepliedList.htm";
				}else if(SeekResponseRedirectVal!=null && SeekResponseRedirectVal.equalsIgnoreCase("DakReceivedViewList")) {
					redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
					return "redirect:/DakReceivedView.htm";
				}else {
					return "redirect:/DakSeekResponseList.htm";
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakSeekResponse.htm "+req.getUserPrincipal().getName(), e);
				return null;
			}
			
		}
		
		
		@RequestMapping(value = "DakSeekResponseList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakSeekResponseList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) {
			 logger.info(new Date() +"DakSeekResponseList.htm"+req.getUserPrincipal().getName());
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				long divid=(long)ses.getAttribute("DivisionId");
				String LabCode = (String) ses.getAttribute("LabCode");
				Date date=new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String redirectedvalue=req.getParameter("redirectedvalue");
				if(redirectedvalue!=null) {
					req.setAttribute("redirectedvalueForward", redirectedvalue);
				}
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -30); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				
				String PageNoData=req.getParameter("PageNoData");
				String RowData=req.getParameter("RowData");
				req.setAttribute("pageNoRedirected", PageNoData);
				req.setAttribute("rowRedirected",   RowData);
				List<Object[]> DakSeekResponseListToMe=service.getDakSeekResponseListToMe(EmpId,fromDate,toDate);
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				List<Object[]> getProjectassignemplis=service.getseekResponseEmplist(LabCode,EmpId,divid);
				List<Object[]> DakSeekResponseByMeList=service.DakSeekResponseByMeList(EmpId,fromDate,toDate);
				req.setAttribute("GetAssignEmpList", getProjectassignemplis);
				req.setAttribute("DakSeekResponseByMeList",DakSeekResponseByMeList);;
				req.setAttribute("DakSeekResponseListToMe", DakSeekResponseListToMe);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DakSeekResponseList.htm"+req.getUserPrincipal().getName()+e);
			}
			return "dak/dakSeekResponse";
		}
		
		
		@RequestMapping(value = "DAKSeekResponseReply.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DAKSeekResponseReply(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir,
			@RequestPart(name = "dak_SeekResponse_reply_document", required = false) MultipartFile[] SeekResponsereplydocs) {
			logger.info(new Date() +"Inside DAKSeekResponseReply.htm "+req.getUserPrincipal().getName());
			long result=0;
			long EmpId=(Long)ses.getAttribute("EmpId");
			String DakId=req.getParameter("dakIdOfSeekResponseReply");
			String AssignreplyRemarks=req.getParameter("SeekResponsereplyRemarks");
			String DakNo=req.getParameter("DakNo");
			String fromDate=(String)req.getParameter("FromDate");
			String toDate=(String)req.getParameter("ToDate");
			String SeekResponseId=req.getParameter("SeekResponseId");
			String SeekResponseReplyPageNo=req.getParameter("SeekResponseReplyPageNo");
			String SeekResponseReplyRowNo=req.getParameter("SeekResponseReplyRowNo");
			try {
				  if(fromDate!=null || toDate != null) {
					  try {
							 fromDate=rdf.format(sdf2.parse(fromDate));
							 toDate=rdf.format(sdf2.parse(toDate));
							 redir.addAttribute("FromDate", fromDate);
							 redir.addAttribute("ToDate",   toDate);
						 }catch (ParseException e) {
							 e.printStackTrace();
						 }
				 }
				  DakSeekResponseAttachDto dto=DakSeekResponseAttachDto.builder().SeekResponsereplydocs(SeekResponsereplydocs).build();
				dto.setDakId(Long.parseLong(DakId));
				dto.setEmpId(EmpId);
				dto.setSeekResponseId(Long.parseLong(SeekResponseId));
				dto.setReply(AssignreplyRemarks.trim());
				dto.setReplyStatus("Y");
				dto.setCreatedBy(req.getUserPrincipal().getName());
				dto.setCreatedDate(sdf1.format(new Date()));
				dto.setDakNo(DakNo);
				result=service.InsertDakSeekResponseReply(dto);
				redir.addAttribute("PageNoData", SeekResponseReplyPageNo);
				redir.addAttribute("RowData", SeekResponseReplyRowNo);
				if(result>0) {
					redir.addAttribute("result","DAK SeekResponse Replied Successfully ");
					
				}else {
					redir.addAttribute("resultfail","DAK SeekResponse Replied Unsuccessful");
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DAKSeekResponseReply.htm "+req.getUserPrincipal().getName(), e);
			}
			if(req.getParameter("seekredirval")!=null && req.getParameter("seekredirval").equalsIgnoreCase("DakReceivedViewList")) {
				redir.addAttribute("DakId", DakId);
				redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				return "redirect:/DakReceivedView.htm";
			}else {
			return "redirect:/DakSeekResponseList.htm";
			}
			
		}
		
		@RequestMapping(value = "GetSeekResponseReplyModalDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetSeekResponseReplyModalDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetSeekResponseReplyModalDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> SeekResponseRelyModalData =new ArrayList<Object[]>();
			try {
			   String DakId = req.getParameter("dakid");
			   String Username = req.getUserPrincipal().getName();
			   long EmpId=(Long)ses.getAttribute("EmpId");
			   if(DakId!=null) {
				   DakMain DakDetails = service.GetDakDetails(Long.parseLong(DakId)); 
				   SeekResponseRelyModalData = service.GetSeekResponseRelyModalDetails(Long.parseLong(DakId),EmpId,Username,DakDetails.getCreatedBy());
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetSeekResponseReplyModalDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(SeekResponseRelyModalData);
		}
		
		@RequestMapping(value = "GetSeekResponseReplyAttachModalList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetSeekResponseReplyAttachModalList(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetSeekResponseReplyAttachModalList.htm "+req.getUserPrincipal().getName());
			List<Object[]> SeekResponseRelyAttachModalData =new ArrayList<Object[]>();
			try {
			   String DakReplyId = req.getParameter("dakreplyid");
			   if(DakReplyId!=null) {
				   SeekResponseRelyAttachModalData = service.GetSeekResponseReplyAttachmentList(Long.parseLong(DakReplyId));
				 }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetSeekResponseReplyAttachModalList.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(SeekResponseRelyAttachModalData);
		}
		
		
		@RequestMapping(value = "GetSeekResponseReplyViewMore.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetSeekResponseReplyViewMore(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetSeekResponseReplyViewMore.htm "+req.getUserPrincipal().getName());
			List<Object[]> SeekResponseRelyViewMoreData =new ArrayList<Object[]>();
			try {
				String DakReplyId=req.getParameter("dakreplyid");
			   if(DakReplyId!=null) {
				   SeekResponseRelyViewMoreData = service.GetDakSeekResponseReplyDetails(Long.parseLong(DakReplyId)); 
			   }else {
				   SeekResponseRelyViewMoreData = null;
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetSeekResponseReplyViewMore.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(SeekResponseRelyViewMoreData);
		}
		
		
		@RequestMapping(value = "GetSeekResponseReplyEditDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String GetSeekResponseReplyEditDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside GetSeekResponseReplyEditDetails.htm "+req.getUserPrincipal().getName());
			DakSeekResponse SeekResponseRelyEditData = null;
			try {
				String DakReplyId=req.getParameter("replyid");
			   if(DakReplyId!=null) {
				   SeekResponseRelyEditData = service.GetDakSeekResponseReplyEditDetails(Long.parseLong(DakReplyId)); 
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside GetSeekResponseReplyEditDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(SeekResponseRelyEditData);
		}
		
		
		@RequestMapping(value = "SeekResponseReplyAttachDelete.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String SeekResponseReplyAttachDelete(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
		{
			logger.info(new Date() +"Inside SeekResponseReplyAttachDelete.htm "+ req.getUserPrincipal().getName());
			String DakId=null;
			try
			{
				String DakReplyAttachId = req.getParameter("replyAttachmentIdVal");
				String DakReplyId=req.getParameter("replyIdVal");
				int deleteResult = 0;
				List<Object[]> SeekResponsereplyDakAttachmentData = null;
				if(DakReplyAttachId!=null && DakReplyId!=null ) {
					SeekResponsereplyDakAttachmentData  = service.SeekResponseReplyDakAttachmentData(Long.parseLong(DakReplyAttachId),Long.parseLong(DakReplyId));
				}
				if(SeekResponsereplyDakAttachmentData!=null && SeekResponsereplyDakAttachmentData.size() > 0) {
					Object[] data =  SeekResponsereplyDakAttachmentData.get(0);
					DakId=data[9].toString();
					File my_file=null;
					String seekresponseattachdata = data[0].toString().replaceAll("[/\\\\]", ",");
	        		String[] fileParts = seekresponseattachdata.split(",");
			        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+data[1]);
					boolean result = Files.deleteIfExists(my_file.toPath());
				if(result) 
				{
					deleteResult = service.DeleteSeekResponseReplyAttachment(DakReplyAttachId);
					if(deleteResult>0) {
						redir.addAttribute("result","Document Deleted Successfully");
					}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful"); }
					}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful in Folder"); }
					}else { redir.addAttribute("resultfail","Document not found"); }
				
			
			}catch (Exception e) {
					e.printStackTrace(); 
					logger.error(new Date() +"Inside SeekResponseReplyAttachDelete.htm "+ req.getUserPrincipal().getName(),e);
			}
			if(req.getParameter("viewfrom")!=null && req.getParameter("viewfrom").equalsIgnoreCase("DakSeekResponseList")) {
				redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				redir.addAttribute("DakId", DakId);
				return "redirect:/DakReceivedView.htm";
			}else {
			return "redirect:/DakSeekResponseList.htm";
			}
		}
		
		@RequestMapping(value = "DAKSeekResponseReplyDataEdit.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DAKSeekResponseReplyDataEdit(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir,@RequestPart(name = "dak_replyEdit_document", required = false) MultipartFile[] replydocuments) throws Exception {
            logger.info(new Date() +"DAKSeekResponseReplyDataEdit.htm"+req.getUserPrincipal().getName());
            long result=0;
			try {
			String dakReplyId = req.getParameter("dakReplyIdValFrReplyEdit");
	      	String dakId=req.getParameter("dakIdValFrReplyEdit");
	     	String empId=req.getParameter("empIdValFrValueEdit");
	    	String remarksReplyVal=req.getParameter("replyEditRemarksVal");
	    	DakSeekResponseAttachDto dakReplyEditdto = DakSeekResponseAttachDto.builder().SeekResponsereplydocs(replydocuments).build();
	     	dakReplyEditdto.setDakId(Long.parseLong(dakId));
	     	dakReplyEditdto.setSeekResponseId(Long.parseLong(dakReplyId));
	     	dakReplyEditdto.setEmpId(Long.parseLong(empId));
	     	dakReplyEditdto.setReply(remarksReplyVal.trim());
	     	dakReplyEditdto.setModifiedBy(req.getUserPrincipal().getName());
	     	dakReplyEditdto.setModifiedDate(sdf1.format(new Date()));			     	
			result=service.editSeekResponseDakReply(dakReplyEditdto);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DAKSeekResponseReplyDataEdit.htm"+req.getUserPrincipal().getName()+e);
			}
			if(result>0) 
			{
				redir.addAttribute("result","DAK Seek Response Reply Edit Successfully ");
			}
			else
			{
				redir.addAttribute("resultfail","DAK Seek Response Reply Edit Unsuccessful");
			}
			if(req.getParameter("viewfrom")!=null && req.getParameter("viewfrom").equalsIgnoreCase("DakSeekResponseList")) {
				redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
				redir.addAttribute("DakId", req.getParameter("dakIdValFrReplyEdit"));
				return "redirect:/DakReceivedView.htm";
			}else {
			return "redirect:/DakSeekResponseList.htm";
			}
		}
		
		@RequestMapping(value = "getSeekResponseiframepdf.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getSeekResponseiframepdf(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getSeekResponseiframepdf.htm "+req.getUserPrincipal().getName());
			List<String> iframe=new ArrayList<>();
			try {
				 String dakattachmentid = req.getParameter("data");
		         Object[] dakSeekResponseattachmentdata = service.DakSeekResponseAttachmentData(dakattachmentid);
		         File my_file = null;
		         String seekresponseattachdata = dakSeekResponseattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
	        	 String[] fileParts = seekresponseattachdata.split(",");
			     my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+dakSeekResponseattachmentdata[1]);
		         res.setHeader("Content-disposition", "inline; filename=" + dakSeekResponseattachmentdata[1].toString());
		         iframe.add(FilenameUtils.getExtension(dakSeekResponseattachmentdata[1]+""));
		         String pdf=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(my_file));
		         String FileName=(String)dakSeekResponseattachmentdata[1];
		         iframe.add(pdf);
		         iframe.add(FileName);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getSeekResponseiframepdf.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(iframe);
		}
		
		
		
		@RequestMapping(value = "getoldSeekResponseassignemplist.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String getoldSeekResponseassignemplist(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getoldSeekResponseassignemplist.htm "+req.getUserPrincipal().getName());
			List<Object[]> getoldSeekResponseassignemplist = null;
			try {
				String DakId=req.getParameter("DakId");
			   if(DakId!=null) {
				   getoldSeekResponseassignemplist = service.getoldSeekResponseassignemplist(Long.parseLong(DakId)); 
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getoldSeekResponseassignemplist.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getoldSeekResponseassignemplist);
		}
		
		@RequestMapping(value = "DakAddToFavourites.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String DakAddToFavourites(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			 logger.info(new Date() +"Inside DakAddToFavourites.htm "+req.getUserPrincipal().getName());
			 long AddFavourites=0;
			try {
				String DakMarkingId=req.getParameter("DakMarkingId");
			   if(DakMarkingId!=null) {
				   AddFavourites = service.AddToFavourites(Long.parseLong(DakMarkingId)); 
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakAddToFavourites.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(AddFavourites);
		}
		
		@RequestMapping(value = "DakRemoveFromFavourites.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String DakRemoveFromFavourites(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside DakRemoveFromFavourites.htm "+req.getUserPrincipal().getName());
			 long RemoveFavourites=0;
			try {
				String DakMarkingId=req.getParameter("DakMarkingId");
			   if(DakMarkingId!=null) {
				   RemoveFavourites = service.RemoveFavourites(Long.parseLong(DakMarkingId)); 
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakRemoveFromFavourites.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RemoveFavourites);
		}
		
		@RequestMapping(value = "DakRepliedList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakRepliedList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses)  throws Exception{
			logger.info(new Date() +" In CONTROLLER DakRepliedList.htm "+req.getUserPrincipal().getName());
			try {
				long EmpId=(Long)ses.getAttribute("EmpId");
				String Username=req.getUserPrincipal().getName();
	  			Object[] UserName= null;
				UserName=service.getUsername(EmpId);
				Date date = new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String lettertypeid=req.getParameter("lettertypeid");
				if(lettertypeid==null) {
					lettertypeid="All";
				}
				String priorityid=req.getParameter("priorityid");
				if(priorityid==null) {
					priorityid="All";
				}
				String sourcedetailid=req.getParameter("sourcedetailid");
				if(sourcedetailid==null) {
					sourcedetailid="All";
				}
				String SourceId=req.getParameter("SourceId");
				if(SourceId==null) {
					SourceId="All";
				}
				String ProjectType=req.getParameter("ProjectType");
				if(ProjectType==null) {
					ProjectType="All";
				}
				String ProjectId=req.getParameter("ProjectId");
				if(ProjectId==null) {
					ProjectId="All";
				}
				String DakMemberTypeId=req.getParameter("DakMemberTypeId");
				if(DakMemberTypeId==null) {
					DakMemberTypeId="All";
				}
				String EmployeeId=req.getParameter("EmpId");
				if(EmployeeId==null) {
					EmployeeId="All";
				}
				String redirectedvalue=req.getParameter("redirectedvalue");
				if(redirectedvalue!=null) {
					req.setAttribute("redirectedvalueForward", redirectedvalue);
				}
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -7); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				String  PageRedir=req.getParameter("PageNoData");
				String RowRedir=req.getParameter("RowData");
			    req.setAttribute("pageNoRedirected", PageRedir);
				req.setAttribute("rowRedirected",   RowRedir);
				List<Object[]> DakRepliedToMeList=service.DakRepliedToMeList(Username,fromDate,toDate);
				List<Object[]> DakRepliedByMeList=service.DakRepliedByMeList(EmpId,fromDate,toDate,lettertypeid,priorityid,sourcedetailid,SourceId,ProjectType,ProjectId,DakMemberTypeId,EmployeeId);
				req.setAttribute("Username", UserName);
				req.setAttribute("EmpId",   String.valueOf(EmpId));
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				req.setAttribute("DakRepliedToMeList", DakRepliedToMeList);
				req.setAttribute("DakRepliedByMeList", DakRepliedByMeList);
				return "dak/dakRepliedList";
			} catch (Exception e) {
				logger.error(new Date() +" In CONTROLLER DakRepliedList.htm "+req.getUserPrincipal().getName()+"  "+e);
				return "static/Error";
				
			}
		}
		
		@RequestMapping(value = "getEmpListForSeekResponse.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String  getEmpListForSeekResponse(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getEmpListForSeekResponse.htm "+req.getUserPrincipal().getName());
			List<Object[]>  getEmpListForSeekResponse=null;
			long EmpId=(Long)ses.getAttribute("EmpId");
			String LabCode = (String) ses.getAttribute("LabCode");
			try {
				String dakId=(String)req.getParameter("dakid");
				if(dakId!=null) {
					getEmpListForSeekResponse=service.getEmpListForSeekResponse(Long.parseLong(dakId), LabCode,  EmpId);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getEmpListForSeekResponse.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson( getEmpListForSeekResponse);
		}
		
		@RequestMapping(value = "getClosedByName.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public @ResponseBody String getClosedByName(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getClosedByName.htm "+req.getUserPrincipal().getName());
			Object[] getClosedByDetails=null;
			try {
				String ClosedBy=req.getParameter("closedby");
			   if(ClosedBy!=null) {
				   getClosedByDetails = service.getClosedByDetails(ClosedBy); 
			   }
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getClosedByName.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getClosedByDetails);
		}
		
		
		@RequestMapping(value = "DakStatistics.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakStatistics(HttpServletRequest req,HttpServletResponse resp,HttpSession ses)  throws Exception{
			logger.info(new Date() +" In CONTROLLER DakStatistics.htm "+req.getUserPrincipal().getName());
			try {
				String Username=req.getUserPrincipal().getName();
				String LabCode = (String) ses.getAttribute("LabCode");
				Date date = new Date();
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				String EmployeeId=req.getParameter("EmployeeId");
				String Emp=null;
				if(EmployeeId==null) {
					Emp="All";
				}else {
					Emp=EmployeeId;
				}
				String redirectedvalue=req.getParameter("redirectedvalue");
				if(redirectedvalue!=null) {
					req.setAttribute("redirectedvalueForward", redirectedvalue);
				}
				
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -7); Date prevdate = cal.getTime();
				if(fromDate==null || toDate == null) 
				{
					fromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				List<Object[]>  EmpListDropDown=service.EmpListDropDown(LabCode);
				
				Object[] MarkedEmpCounts=service.MarkedEmpCounts(Emp,fromDate,toDate,Username);
				Object[] AssignedEmpCounts=service.AssignedEmpCounts(Emp,fromDate,toDate,Username);
				
				req.setAttribute("EmpListDropDown", EmpListDropDown);
				req.setAttribute("MarkedEmpCounts", MarkedEmpCounts);
				req.setAttribute("AssignedEmpCounts", AssignedEmpCounts);
				req.setAttribute("Emp", Emp);
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
				return "dak/dakStatistics";
			} catch (Exception e) {
				logger.error(new Date() +" In CONTROLLER DakStatistics.htm "+req.getUserPrincipal().getName()+"  "+e);
				return "static/Error";
				
			}
		}
		
		
		@RequestMapping(value = "getSeekResponseEmpDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getSeekResponseEmpDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getSeekResponseEmpDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> SeekResponseEmpDetails=null;
			try {
				String MarkerEmpId=(String)req.getParameter("markerEmpId");
				String DakId=(String)req.getParameter("dakId");
				if(MarkerEmpId!=null && DakId!=null) {
					SeekResponseEmpDetails=service.getSeekResponseList(Long.parseLong(MarkerEmpId),Long.parseLong(DakId));
				}else {
					SeekResponseEmpDetails = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getSeekResponseEmpDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(SeekResponseEmpDetails);
		}
		
		
		@RequestMapping(value = "getFacilitatorSeekResponseEmpDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getFacilitatorSeekResponseEmpDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getFacilitatorSeekResponseEmpDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> FacilitatorSeekResponseEmpDetails=null;
			try {
				String MarkerEmpId=(String)req.getParameter("markerEmpId");
				String DakId=(String)req.getParameter("dakId");
				if(MarkerEmpId!=null && DakId!=null) {
					FacilitatorSeekResponseEmpDetails=service.getFacilitatorSeekResponseList(Long.parseLong(MarkerEmpId),Long.parseLong(DakId));
				}else {
					FacilitatorSeekResponseEmpDetails = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getFacilitatorSeekResponseEmpDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(FacilitatorSeekResponseEmpDetails);
		}
		
		
		@RequestMapping(value = "getRemindemplist.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getRemindemplist(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getRemindemplist.htm "+req.getUserPrincipal().getName());
			List<Object[]> RemindEmployeeList=null;
			try {
				String DakId=(String)req.getParameter("DakId");
				if(DakId!=null) {
					RemindEmployeeList=service.getRemindEmployeeList(Long.parseLong(DakId));
				}else {
					RemindEmployeeList = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getRemindemplist.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(RemindEmployeeList);
		}
		
		@RequestMapping(value = "DakRemindSubmit.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakRemindSubmit(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir) {
			logger.info(new Date() +"Inside DakRemindSubmit.htm "+req.getUserPrincipal().getName());
			long result=0;
			long EmpId=(Long)ses.getAttribute("EmpId");
			String DakId=req.getParameter("DakId");
			String[] RemindTo=req.getParameter("RemindEmployee").split("/");
			String Comment=req.getParameter("comment");
			String RemindToEmployee=RemindTo[0].toString();
			String Url=RemindTo[1].toString();
			try {
				DakRemind modal=new DakRemind();
				modal.setDakId(Long.parseLong(DakId));
				modal.setRemindBy(EmpId);
				modal.setRemindTo(Long.parseLong(RemindToEmployee));
				modal.setComment(Comment);
				modal.setCommentType("C");
				modal.setUrl(Url);
				modal.setCreatedBy(req.getUserPrincipal().getName());
				modal.setCreatedDate(sdf1.format(new Date()));
				result=service.InsertDakRemind(modal);
				redir.addAttribute("DakId", DakId);
				redir.addAttribute("viewfrom", "DakReceivedList");
				if(result>0) {
					redir.addAttribute("result","DAK Remind Sent Successfully ");
				}else {
					redir.addAttribute("resultfail","DAK Remind Sent Unsuccessful");
				}
				return "redirect:/DakReceivedView.htm";
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakRemindSubmit.htm "+req.getUserPrincipal().getName(), e);
				return "redirect:/DakReceivedView.htm";
			}
				
		}
		
		
		@RequestMapping(value = "getRemindToDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getRemindToDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getRemindToDetails.htm "+req.getUserPrincipal().getName());
			List<Object[]> getRemindToDetails=null;
			try {
				String DakId=(String)req.getParameter("DakId");
				String loggedInEmpId=req.getParameter("loggedInEmpId");
				if(DakId!=null && loggedInEmpId!=null) {
					getRemindToDetails=service.getRemindToDetailsList(Long.parseLong(DakId),Long.parseLong(loggedInEmpId));
				}else {
					getRemindToDetails = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getRemindToDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getRemindToDetails);
		}
		
		
		@RequestMapping(value = "getPerticularRemindToDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getPerticularRemindToDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getPerticularRemindToDetails.htm "+req.getUserPrincipal().getName());
			long EmpId=(Long)ses.getAttribute("EmpId");
			List<Object[]> getPerticularRemindToDetails=null;
			try {
				String DakId=(String)req.getParameter("DakId");
				if(DakId!=null) {
					getPerticularRemindToDetails=service.getPerticularRemindToDetails(Long.parseLong(DakId),EmpId);
				}else {
					getPerticularRemindToDetails = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getPerticularRemindToDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(getPerticularRemindToDetails);
		}
		
		@RequestMapping(value = "DakRemindReplySubmit.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DakRemindReplySubmit(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir) {
			logger.info(new Date() +"Inside DakRemindReplySubmit.htm "+req.getUserPrincipal().getName());
			long result=0;
			long EmpId=(Long)ses.getAttribute("EmpId");
			String DakId=req.getParameter("DakId");
			String Reply=req.getParameter("RemindReply");
			String RepliedFrom=req.getParameter("RepliedFrom");
			try {
				String RemindById=req.getParameter("RemindById");
				DakRemind modal=new DakRemind();
				modal.setDakId(Long.parseLong(DakId));
				modal.setRemindBy(Long.parseLong(RemindById));
				modal.setRemindTo(EmpId);
				modal.setComment(Reply);
				modal.setCommentType("R");
				modal.setCreatedBy(req.getUserPrincipal().getName());
				modal.setCreatedDate(sdf1.format(new Date()));
				result=service.InsertDakRemind(modal);
				redir.addAttribute("DakId", DakId);
				redir.addAttribute("viewfrom", RepliedFrom);
				if(result>0) {
					redir.addAttribute("result","DAK Remind Replied Successfully ");
				}else {
					redir.addAttribute("resultfail","DAK Remind Replied Unsuccessful");
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakRemindReplySubmit.htm "+req.getUserPrincipal().getName(), e);
			}
				return "redirect:/DakReceivedView.htm";
		}
		
		
		@RequestMapping(value = "DAKEnoteAssignReply.htm" , method = {RequestMethod.GET,RequestMethod.POST})
		public String DAKEnoteAssignReply(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir,
			@RequestPart(name = "dak_Assign_reply_document", required = false) MultipartFile[] Assignreplydocs) {
			logger.info(new Date() +"Inside DAKEnoteAssignReply.htm "+req.getUserPrincipal().getName());
			long result=0;
			long EmpId=(Long)ses.getAttribute("EmpId");
			String DakId=req.getParameter("dakIdOfAssignReply");
			String DakAssignId=req.getParameter("DakAssignId");
			String AssignreplyRemarks=req.getParameter("AssignreplyRemarks");
			String DakNo=req.getParameter("DakNo");
			try {
				DakAssignReplyDto dto=DakAssignReplyDto.builder().AssignReplyDocs(Assignreplydocs).build();
				dto.setDakId(Long.parseLong(DakId));
				dto.setAssignId(Long.parseLong(DakAssignId));
				dto.setEmpId(EmpId);
				dto.setReply(AssignreplyRemarks.trim());
				dto.setReplyStatus("R");
				dto.setCreatedBy(req.getUserPrincipal().getName());
				dto.setCreatedDate(sdf1.format(new Date()));
				dto.setDakNo(DakNo);
				result=service.InsertDakAssignReply(dto);
				if(result>0) {
					service.updateAssignStatus(Long.parseLong(DakAssignId));
				}else {
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DAKEnoteAssignReply.htm "+req.getUserPrincipal().getName(), e);
			}
				redir.addAttribute("DakId", DakId);
			return "redirect:/DakEnoteAdd.htm";
			
		}
		
		
		@RequestMapping(value = "DakEnoteAdd.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakEnoteAdd(HttpServletRequest req, HttpSession ses) throws Exception {
			long EmpId=(Long)ses.getAttribute("EmpId");
			String DakId=req.getParameter("DakId");
			logger.info(new Date() +"EnoteAdd.htm "+req.getUserPrincipal().getName());
			List<Object[]> EnoteAssignReplyAttachmentData =new ArrayList<Object[]>();
			try {
			String LabCode = (String) ses.getAttribute("LabCode");
			Object[] EnoteAssignReplyData=service.EnoteAssignReplyData(Long.parseLong(DakId),EmpId);
			long InitiatedEmp=Long.parseLong(EnoteAssignReplyData[4].toString());
			EnoteAssignReplyAttachmentData = service.EnoteAssignReplyAttachmentData(Long.parseLong(req.getParameter("DakId")));
			req.setAttribute("EnoteAssignReplyAttachmentData", EnoteAssignReplyAttachmentData);
			req.setAttribute("EnoteAssignReplyData", EnoteAssignReplyData);
			Object DivisionId=service.getDivisionId(InitiatedEmp);
			long divisionId=Long.parseLong(DivisionId.toString());
			List<Object[]> InitiatedByEmployeeList=service.InitiatedByEmployeeList(divisionId,LabCode);
			req.setAttribute("InitiatedByEmployeeList", InitiatedByEmployeeList);
			req.setAttribute("Action", "DakEnoteadd");
			req.setAttribute("EnoteFrom", "C");
			return "Enote/DakEnoteAdd";
			}catch( Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" DakEnoteAdd.htm "+req.getUserPrincipal().getName(), e);
				return "static/Error";	
			}
		}
		
		@RequestMapping(value = "DAKEnoteReply.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
		public String DakEnoteReply(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir,
				@RequestPart(name = "dak_reply_document", required = false) MultipartFile[] replydocs) throws Exception {
            logger.info(new Date() +"DAKEnoteReply.htm"+req.getUserPrincipal().getName());
            long result=0;
            String dakId= null;
			try {
	      	dakId=req.getParameter("dakIdValFrReply");
	     	String empIdReply=req.getParameter("EmpIdValFrValue");
	    	String remarksReply=req.getParameter("replyRemarks").replaceAll("\\s+", " ");
	     	DakReplyDto dakReplydto = DakReplyDto.builder().ReplyDocs(replydocs).build();
	     	dakReplydto.setDakId(Long.parseLong(dakId));
	     	dakReplydto.setEmpId(Long.parseLong(empIdReply));
	     	dakReplydto.setReply(remarksReply);
	     	dakReplydto.setCreatedBy(req.getUserPrincipal().getName());
			result=service.insertDakReply(dakReplydto);
			} catch (Exception e) {
				e.printStackTrace();
				   logger.error(new Date() +"DAKEnoteReply.htm"+req.getUserPrincipal().getName()+e);
			}
			if(result>0) {
				DakMain DakDetails = service.GetDakDetails(Long.parseLong(dakId)); 
				long TotalEmpIdCountInDM=service.EmpIdCountOfDM(Long.parseLong(dakId));//WHO are active
				long TotalDakReplyCountInDR=service.DakReplyCountInDR(Long.parseLong(dakId));
			if(TotalEmpIdCountInDM==TotalDakReplyCountInDR && DakDetails.getDakStatus()!=null 
					&& !DakDetails.getDakStatus().equalsIgnoreCase("RP") && !DakDetails.getDakStatus().equalsIgnoreCase("AP") && !DakDetails.getDakStatus().equalsIgnoreCase("RM")  ) {
			service.UpdateDakStatusToDR(Long.parseLong(dakId));
			}
			}else{
			}
		    redir.addAttribute("DakId", dakId);
		    redir.addAttribute("ReplyId", result);
		    return "redirect:/DakEnoteMarkerAdd.htm";
		}

		
		@RequestMapping(value = "DakEnoteMarkerAdd.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakEnoteMarkerAdd(HttpServletRequest req, HttpSession ses) throws Exception {
			long EmpId=(Long)ses.getAttribute("EmpId");
			String DakId=req.getParameter("DakId");
			logger.info(new Date() +"DakEnoteMarkerAdd.htm "+req.getUserPrincipal().getName());
			List<Object[]> EnoteMarkerReplyAttachmentData =new ArrayList<Object[]>();
			try {
			String LabCode = (String) ses.getAttribute("LabCode");
			Object[] EnoteMarkerReplyData=service.EnoteMarkerReplyData(Long.parseLong(DakId),EmpId);
			long InitiatedEmp=Long.parseLong(EnoteMarkerReplyData[4].toString());
			EnoteMarkerReplyAttachmentData = service.EnoteMarkerReplyAttachmentData(Long.parseLong(EnoteMarkerReplyData[7].toString()));
			req.setAttribute("EnoteAssignReplyAttachmentData", EnoteMarkerReplyAttachmentData);
			req.setAttribute("EnoteAssignReplyData", EnoteMarkerReplyData);
			Object DivisionId=service.getDivisionId(InitiatedEmp);
			long divisionId=Long.parseLong(DivisionId.toString());
			List<Object[]> InitiatedByEmployeeList=service.InitiatedByEmployeeList(divisionId,LabCode);
			req.setAttribute("InitiatedByEmployeeList", InitiatedByEmployeeList);
			req.setAttribute("Action", "DakEnoteadd");
			req.setAttribute("EnoteFrom", "M");
			return "Enote/DakEnoteAdd";
			}catch( Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" DakEnoteMarkerAdd.htm "+req.getUserPrincipal().getName(), e);
				return "static/Error";	
			}
		}
		
		
		@RequestMapping(value = "getMailSenderDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getMailSenderDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getMailSenderDetails.htm "+req.getUserPrincipal().getName());
			Object[] MailSentDetails=null;
			try {
				String HostType=(String)req.getParameter("value");
				System.out.println("HostType:"+HostType);
				if(HostType!=null) {
					MailSentDetails=service.MailSentDetails(HostType);
				}else {
					MailSentDetails = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getMailSenderDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(MailSentDetails);
		}
		
		
		@RequestMapping(value = "getMailReceiverDetails.htm", method = {RequestMethod.GET , RequestMethod.POST})
		public @ResponseBody String getMailReceiverDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
		{
			logger.info(new Date() +"Inside getMailReceiverDetails.htm "+req.getUserPrincipal().getName());
			long EmpId=(Long)ses.getAttribute("EmpId");
			List<Object[]> MailReciverDetails=null;
			try {
				String HostType=(String)req.getParameter("value");
				if(HostType!=null) {
					MailReciverDetails=service.MailReceivedEmpDetails(EmpId,HostType);
				}else {
					MailReciverDetails = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside getMailReceiverDetails.htm "+req.getUserPrincipal().getName(), e);
			}
			Gson json = new Gson();
			return json.toJson(MailReciverDetails);
		}
		
		
		@RequestMapping(value = "DakCreation.htm", method = {RequestMethod.GET, RequestMethod.POST})
		public String DakDGInitiation(HttpServletRequest req,HttpServletResponse res,HttpSession ses) throws Exception 
		{
			logger.info(new Date() +" In CONTROLLER DakDGInitiation.htm "+req.getUserPrincipal().getName());
			try {
				req.setAttribute("SourceList",service.SourceList());
				req.setAttribute("DakDeliveryList",service.DakDeliveryList());
				req.setAttribute("letterList",service.getLetterTypeList());
				req.setAttribute("priorityList",service.getPriorityList());
				req.setAttribute("linkList",service.DakCreateLinkList());
				req.setAttribute("actionList",service.getActionList());
				return "dak/dakcreation";
			}catch (Exception e) {
				logger.error(new Date() +" In CONTROLLER DakCreation.htm "+req.getUserPrincipal().getName()+"  "+e);
				return "static/Error";
				
			}
		}
		
		
		@RequestMapping(value= "DakCreate.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String DakDgAddSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir, 
				@RequestPart(name = "dak_document", required = false) MultipartFile maindoc,
				@RequestPart(name = "dak_sub_document", required = false) MultipartFile[] subdocs
				) {
			logger.info(new Date() +" DakDgAddSubmit.htm "+req.getUserPrincipal().getName());
			long result=0;
			String appUrl=env.getProperty("app_url");
			try {
				 String DivisionCode = (String) ses.getAttribute("DivisionCode");
			     String LabCode = (String) ses.getAttribute("LabCode");
				 String ProjectIdDetails=req.getParameter("ActionId");
				 String self=req.getParameter("selfRequired");
				 String markedEmps[]=(String[])req.getParameterValues("newempid");
				 long ActionId=0;
				 String ActionCode=null;
				 if(ProjectIdDetails!=null)
	  			 {
	  				String[] arr=ProjectIdDetails.split("#");
	  				ActionId=Integer.parseInt(arr[0]);
	  				ActionCode=arr[1].trim();
	  			 }
				 String action=req.getParameter("action");
				 String DakLinkId[]=(String[])req.getParameterValues("DakLinkId");
				 String DestinationId=req.getParameter("DestinationId");
				 String DestinationType[]=req.getParameterValues("DestinationType");
				 DakCreate dak=new DakCreate();
				 dak.setSubject(req.getParameter("Subject").trim());
				 dak.setRefNo(req.getParameter("RefNo").trim());
				 dak.setReceiptDate(new java.sql.Date(sdf.parse(req.getParameter("ReceiptDate")).getTime()));
				 dak.setRefDate(new java.sql.Date(sdf.parse(req.getParameter("RefDate")).getTime()));
				 dak.setPriorityId(Long.parseLong(req.getParameter("PriorityId")));
				 dak.setSignatory(req.getParameter("Signatory").trim());
				 dak.setDeliveryTypeId(Long.parseLong(req.getParameter("DakDeliveryId")));
				 dak.setLetterTypeId(Long.parseLong(req.getParameter("LetterId")));
				 dak.setDestinationId(Long.parseLong(DestinationId));
				 dak.setKeyWord1(req.getParameter("Key1").trim());
				 dak.setKeyWord2(req.getParameter("Key2").trim());
				 dak.setKeyWord3(req.getParameter("Key3").trim());
				 dak.setKeyWord4(req.getParameter("Key4").trim());
				 dak.setRemarks(req.getParameter("Remarks").trim());
				 dak.setActionId(ActionId);
				
				 if (ActionCode.equalsIgnoreCase("ACTION")) {
					dak.setActionDueDate(new java.sql.Date(sdf.parse(req.getParameter("DueDate")).getTime()));
					dak.setActionTime(req.getParameter("DueTime"));
					dak.setReplyOpen("Y");
				 }else {
				    dak.setReplyOpen("N");
				 }
				 dak.setReplyStatus("N");
				 dak.setDakStatus("DI");
				 dak.setDivisionCode(DivisionCode);
				 dak.setLabCode(LabCode);
				 if(action!=null && action.equalsIgnoreCase("save")) {
					 dak.setIsSave("Y");
				 }else if(action!=null && action.equalsIgnoreCase("saveforward")) {
					 dak.setIsSave("N");
				 }
				
				 dak.setIsSelf(self);
				 dak.setCreatedBy(req.getUserPrincipal().getName());
				 dak.setCreatedDate(sdf1.format(new Date()));
				 dak.setIsActive(1);
				 DakAddDto dakdto = DakAddDto.builder().dakcreate(dak).MainDoc(maindoc).SubDoc(subdocs).build();
				 result=service.insertDakCreate(dakdto,(Long)ses.getAttribute("EmpId"),DakLinkId);
				 
				 if(self!=null && self.equalsIgnoreCase("Y")) {
					    Object[] SourceDetailData = service.SourceDetailData(LabCode);
					 	DakMain daklab2=new DakMain();
					 	daklab2.setSubject(req.getParameter("Subject").trim());
					 	daklab2.setRefNo(req.getParameter("RefNo").trim());
					 	daklab2.setReceiptDate(new java.sql.Date(sdf.parse(req.getParameter("ReceiptDate")).getTime()));
					 	daklab2.setRefDate(new java.sql.Date(sdf.parse(req.getParameter("RefDate")).getTime()));
					 	daklab2.setSourceId(Long.parseLong(SourceDetailData[1].toString()));
					 	daklab2.setSourceDetailId(Long.parseLong(SourceDetailData[0].toString()));
					 	daklab2.setPriorityId(Long.parseLong(req.getParameter("PriorityId")));
					 	daklab2.setSignatory(req.getParameter("Signatory").trim());
					 	daklab2.setDeliveryTypeId(Long.parseLong(req.getParameter("DakDeliveryId")));
					 	daklab2.setLetterTypeId(Long.parseLong(req.getParameter("LetterId")));
					 	daklab2.setKeyWord1(req.getParameter("Key1").trim());
					 	daklab2.setKeyWord2(req.getParameter("Key2").trim());
					 	daklab2.setKeyWord3(req.getParameter("Key3").trim());
					 	daklab2.setKeyWord4(req.getParameter("Key4").trim());
					 	daklab2.setRemarks(req.getParameter("Remarks").trim());
					 	daklab2.setActionId(ActionId);
						if (ActionCode.equalsIgnoreCase("ACTION")) {
							daklab2.setActionDueDate(new java.sql.Date(sdf.parse(req.getParameter("DueDate")).getTime()));
							daklab2.setActionTime(req.getParameter("DueTime"));
							daklab2.setReplyOpen("Y");
						}else {
							daklab2.setReplyOpen("N");
						}
						daklab2.setDivisionCode(DivisionCode);
						daklab2.setLabCode(LabCode);
						daklab2.setReplyStatus("N");
						daklab2.setDakStatus("DI");
						daklab2.setProjectType("N");
						daklab2.setProjectId(Long.valueOf(1));
						daklab2.setClosingAuthority("O"); 
						daklab2.setCreatedBy(req.getUserPrincipal().getName());
						daklab2.setCreatedDate(sdf1.format(new Date()));
						daklab2.setIsActive(1);
						daklab2.setCreateLabCode(LabCode);
						daklab2.setDakCreateId(result);
						daklab2.setAppUrl(appUrl);
						daklab2.setSourceLabCode(LabCode);
						
						DakAddDto dakdto2 = DakAddDto.builder().dak(daklab2).MarkedEmps(markedEmps).MainDoc(maindoc).SubDoc(subdocs).build();
						long result1=service.newinsertDak(dakdto2,(Long)ses.getAttribute("EmpId"),DakLinkId);
						if(result1>0) {
							DakCreateDestination destination=new DakCreateDestination();
			       			destination.setDakCreateId(result);
			       			destination.setDestinationTypeId(Long.parseLong(SourceDetailData[0].toString()));
			       			destination.setAcknowledged("N");
			       			destination.setReplyStatus("N");
			       			destination.setIsSent("Y");
			       			destination.setCreatedBy(req.getUserPrincipal().getName());
			       			destination.setCreatedDate(sdf1.format(new Date()));
			       			destination.setIsActive(1);
			       			service.insertDakDestination(destination);
						}
					}
				 
				 if(result>0 && action!=null && action.equalsIgnoreCase("save")) {
					 for(int i=0;i<DestinationType.length;i++) {
						 String[] DestionatinVals = DestinationType[i].split("-");
				        	String destinationtypeid = DestionatinVals[0];
						    DakCreateDestination destination=new DakCreateDestination();
			       			destination.setDakCreateId(result);
			       			destination.setDestinationTypeId(Long.parseLong(destinationtypeid));
			       			destination.setAcknowledged("N");
			       			destination.setReplyStatus("N");
			       			destination.setIsSent("N");
			       			destination.setCreatedBy(req.getUserPrincipal().getName());
			       			destination.setCreatedDate(sdf1.format(new Date()));
			       			destination.setIsActive(1);
			       			service.insertDakDestination(destination);
					 }
				 }else if(result>0 && action!=null && action.equalsIgnoreCase("saveforward")) {
					    try {
					    	for(int i=0;i<DestinationType.length;i++) {
								
					    		String[] DestionatinVals = DestinationType[i].split("-");
					        	String destinationtypeid = DestionatinVals[0];
					       		String destinationurl = DestionatinVals[1]+"DakCreationforLabSubmit.htm";
					       		String SelDivisionCode=DestionatinVals[2];
					       		String SelLabCode=DestionatinVals[3];
					       		DakMain daklab=new DakMain();
					       		daklab.setSubject(req.getParameter("Subject").trim());
					       		daklab.setRefNo(req.getParameter("RefNo").trim());
					       		daklab.setReceiptDate(new java.sql.Date(sdf.parse(req.getParameter("ReceiptDate")).getTime()));
					       		daklab.setRefDate(new java.sql.Date(sdf.parse(req.getParameter("RefDate")).getTime()));
					       		daklab.setSourceId(Long.parseLong(DestinationId));
					       		daklab.setSourceDetailId(Long.parseLong(destinationtypeid));
					       		daklab.setProjectType(req.getParameter("ProjectType"));
					       		daklab.setPriorityId(Long.parseLong(req.getParameter("PriorityId")));
					       		daklab.setSignatory(req.getParameter("Signatory").trim());
					       		daklab.setDeliveryTypeId(Long.parseLong(req.getParameter("DakDeliveryId")));
					       		daklab.setLetterTypeId(Long.parseLong(req.getParameter("LetterId")));
					       		daklab.setKeyWord1(req.getParameter("Key1").trim());
					       		daklab.setKeyWord2(req.getParameter("Key2").trim());
					       		daklab.setKeyWord3(req.getParameter("Key3").trim());
					       		daklab.setKeyWord4(req.getParameter("Key4").trim());
					       		daklab.setRemarks(req.getParameter("Remarks").trim());
					       		daklab.setActionId(ActionId);
								if (ActionCode.equalsIgnoreCase("ACTION")) {
									daklab.setActionDueDate(new java.sql.Date(sdf.parse(req.getParameter("DueDate")).getTime()));
									daklab.setActionTime(req.getParameter("DueTime"));
									daklab.setReplyOpen("Y");
								}else {
									daklab.setReplyOpen("N");
								}
								daklab.setDivisionCode(SelDivisionCode);
								daklab.setLabCode(SelLabCode);
								daklab.setReplyStatus("N");
								daklab.setDakStatus("DI");
								daklab.setCreatedBy(req.getUserPrincipal().getName());
								daklab.setCreatedDate(sdf1.format(new Date()));
								daklab.setIsActive(1);
								daklab.setCreateLabCode(LabCode);
								daklab.setDakCreateId(result);
								daklab.setAppUrl(appUrl);
								daklab.setSourceLabCode(LabCode);
								
								DakAddDto dakdto1 = DakAddDto.builder().dak(daklab).DestinationId(Long.parseLong(DestinationId)).DestinationTypeId(Long.parseLong(destinationtypeid)).build();
								
								HttpHeaders headers = new HttpHeaders();
							    headers.setContentType(MediaType.MULTIPART_FORM_DATA);
							    MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
						        if (maindoc != null && !maindoc.isEmpty()) {
						            HttpHeaders mainDocHeaders = new HttpHeaders();
						            mainDocHeaders.setContentDisposition(ContentDisposition.builder("form-data")
						                    .name("dak_document")
						                    .filename(maindoc.getOriginalFilename())
						                    .build());
						            mainDocHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
						            HttpEntity<ByteArrayResource> mainDocEntity = new HttpEntity<>(new ByteArrayResource(maindoc.getBytes()), mainDocHeaders);
						            body.add("dak_document", mainDocEntity);
						        }
						        if (subdocs != null && subdocs.length>0) {
						            for (MultipartFile file : subdocs) {
						            	if(!file.isEmpty()) {
						                HttpHeaders subDocHeaders = new HttpHeaders();
						                subDocHeaders.setContentDisposition(ContentDisposition.builder("form-data")
						                        .name("dak_sub_document")
						                        .filename(file.getOriginalFilename())
						                        .build());
						                subDocHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
						                HttpEntity<ByteArrayResource> subDocEntity = new HttpEntity<>(new ByteArrayResource(file.getBytes()), subDocHeaders);
						                body.add("dak_sub_document", subDocEntity);
						            }
						            }
						        }
						        if (dakdto1 != null) {
						            HttpHeaders dtoHeaders = new HttpHeaders();
						            dtoHeaders.setContentType(MediaType.APPLICATION_JSON);
						            HttpEntity<DakAddDto> dtoEntity = new HttpEntity<>(dakdto1, dtoHeaders);
						            body.add("dakdto1", dtoEntity);
						        }
						        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
						        String resultdata = "";
						        try {
						            ResponseEntity<String> response = restTemplate.exchange(destinationurl, HttpMethod.POST, requestEntity, String.class);
						            resultdata = response.getBody();
						        } catch (HttpClientErrorException e) {
						            logger.error("HTTP error while calling API: " + e.getMessage());
						            return "redirect:/DakCreationList.htm"; 
						        } catch (ResourceAccessException e) {
						            logger.error("API unreachable: " + e.getMessage());
						            return "redirect:/DakCreationList.htm"; 
						        } catch (Exception e) {
						            logger.error("Unexpected error: " + e.getMessage());
						            return "redirect:/DakCreationList.htm"; 
						        }
							    if (resultdata != null && "success".equalsIgnoreCase(resultdata)) {
					       			DakCreateDestination destination=new DakCreateDestination();
					       			destination.setDakCreateId(result);
					       			destination.setDestinationTypeId(Long.parseLong(destinationtypeid));
					       			destination.setAcknowledged("N");
					       			destination.setReplyStatus("N");
					       			destination.setIsSent("Y");
					       			destination.setCreatedBy(req.getUserPrincipal().getName());
					       			destination.setCreatedDate(sdf1.format(new Date()));
					       			destination.setIsActive(1);
					       			service.insertDakDestination(destination);
					       		}
						}
					    } catch (Exception e) {
					        e.printStackTrace();
					        return "Error during request";
					    }
				 }
				 if(action!=null && action.equalsIgnoreCase("save")) {
						return "redirect:/DakCreationPendingList.htm";
					}else {
						return "redirect:/DakCreationList.htm";
					}
			 }catch (Exception e) {
				logger.error(new Date() +" DakDgAddSubmit.htm "+e);
			 }
			 if(result >0) {
				redir.addAttribute("result", "DAK Created Successfully");
			 }else {
				redir.addAttribute("resultfail", "DAK Create Unsuccessful");
			 }
			 return "redirect:/DakCreationList.htm";
		}
		
		 
		@RequestMapping(value="DakCreationforLabSubmit.htm", method= {RequestMethod.GET, RequestMethod.POST})
		public ResponseEntity<String> handleDakCreation(
					@RequestPart(name = "dak_document", required = false) MultipartFile maindoc,
			        @RequestPart(name = "dak_sub_document", required = false) MultipartFile[] subdocs,
			        @RequestPart(name = "dakdto1", required = false) DakAddDto dakdto1,HttpSession ses) {
				    try {
				        service.insertLabDak(dakdto1, (Long) ses.getAttribute("EmpId"),maindoc,subdocs);
				    } catch (Exception e) {
				        e.printStackTrace();
				        return new ResponseEntity<>("Error during request", HttpStatus.INTERNAL_SERVER_ERROR);
				    }
				    return new ResponseEntity<>("success", HttpStatus.OK);
			}


			@RequestMapping(value = "DakCreationPendingList.htm", method = {RequestMethod.GET,RequestMethod.POST})
			public String DakCreationPendingList(HttpServletRequest req,HttpServletResponse res, HttpSession ses) throws Exception {
		        logger.info(new Date() +"DakCreationPendingList"+req.getUserPrincipal().getName());
				try {
					 List<Object[]> dakCreationPendingList=service.dakCreationPendingList();
					 req.setAttribute("dakCreationPendingList",dakCreationPendingList);
				} catch (Exception e) {
					e.printStackTrace();
				}
				return "dak/dakCreationPendingList";
			}
		
		
			@RequestMapping(value = "GetDakDestinationDetailsList.htm", method = {RequestMethod.GET , RequestMethod.POST})
			public @ResponseBody String GetDakDestinationDetailsList(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
			{
				logger.info(new Date() +"Inside GetDakDestinationDetailsList.htm"+req.getUserPrincipal().getName());
				String LabCode = (String) ses.getAttribute("LabCode");
				List<Object[]> DakDestinationDetailsList=null;
				try {
					String DakId=(String)req.getParameter("dakId");
					if(DakId!=null) {
						DakDestinationDetailsList=service.DakDestinationDetailsList(Long.parseLong(DakId),LabCode);
					}else {
						DakDestinationDetailsList = null;
					}
				} catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside GetDakDestinationDetailsList.htm"+req.getUserPrincipal().getName(), e);
				}
				Gson json = new Gson();
				return json.toJson(DakDestinationDetailsList);
			}
		
		
			@RequestMapping(value = "DakCreateEdit.htm" , method = {RequestMethod.GET , RequestMethod.POST})
			public String DakCreateEdit(Model model, HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir) throws Exception {
				logger.info(new Date() +"Dak DakCreateEdit"+req.getUserPrincipal().getName());
				try {
					 String LabCode = (String) ses.getAttribute("LabCode");
					String DakCreateId=req.getParameter("DakCreateId");
					DakCreate dakcreateData=service.findByDakCreateId(Long.parseLong(DakCreateId));
					List<Object[]> selDestinationTypeList=service.selDestinationTypeList(Long.parseLong(DakCreateId));
					req.setAttribute("dakcreateData",dakcreateData);
					req.setAttribute("selDestinationTypeList",selDestinationTypeList);
					req.setAttribute("SourceList",service.SourceList());
					req.setAttribute("DakDeliveryList",service.DakDeliveryList());
					req.setAttribute("letterList",service.getLetterTypeList());
					req.setAttribute("priorityList",service.getPriorityList());
					req.setAttribute("linkList",service.DakCreateLinkList());
					req.setAttribute("actionList",service.getActionList());
					req.setAttribute("dakLinkData", service.dakCreateLinkData(Long.parseLong(DakCreateId)));
					req.setAttribute("employeeList", service.EmpListDropDown(LabCode));
					req.setAttribute("selectedEmployees", service.selectedNewDakEmployees(Long.parseLong(DakCreateId),LabCode));
				}catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +"Dak DakCreateEdit"+e);
				}
				return "dak/dakCreateEdit";
			}
		
		
			@RequestMapping(value = "GetDakCreateAttachmentDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
			public @ResponseBody String GetDakCreateAttachmentDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
			{
				logger.info(new Date() +"Inside GetDakCreateAttachmentDetails.htm "+req.getUserPrincipal().getName());
				List<Object[]> DakCreateAttachmentData =new ArrayList<Object[]>();
				try {
					DakCreateAttachmentData = service.GetDakCreateAttachmentDetails(Long.parseLong(req.getParameter("dakid")),req.getParameter("attachtype"));
					req.setAttribute("DakCreateAttachmentData", DakCreateAttachmentData);
				} catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside GetDakCreateAttachmentDetails.htm "+req.getUserPrincipal().getName(), e);
				}
				Gson json = new Gson();
				return json.toJson(DakCreateAttachmentData);
			}
		
		
			@RequestMapping(value = "DakCreateDownloadAttach.htm" , method = {RequestMethod.GET,RequestMethod.POST})
			public void DakCreateDownloadAttach(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
			{
				logger.info(new Date() +"Inside DakCreateDownloadAttach "+ req.getUserPrincipal().getName());
				try
				{
					String dakattachmentid=req.getParameter("downloadbtn");
					res.setContentType("Application/octet-stream");	
					Object[] dakCreateattachmentdata =service.dakCreateattachmentdata(dakattachmentid);
					File my_file=null;
					String createattachdata = dakCreateattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
	        		String[] fileParts = createattachdata.split(",");
			        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+dakCreateattachmentdata[1]);
			        res.setHeader("Content-disposition", "inline; filename=" + dakCreateattachmentdata[1].toString()); // Set the disposition to "inline" to open the file in a new tab
			        OutputStream out = res.getOutputStream();
			        FileInputStream in = new FileInputStream(my_file);
			        byte[] buffer = new byte[4096];
			        int length;
			        while ((length = in.read(buffer)) > 0){
			           out.write(buffer, 0, length);
			        }
			        in.close();
			        out.flush();
					
				}catch (Exception e) {
						e.printStackTrace(); 
						logger.error(new Date() +"Inside DakCreateDownloadAttach "+ req.getUserPrincipal().getName(),e);
				}
			}
		
			@RequestMapping(value = "DakCreateEditDeleteAttach.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
			public String DakCreateEditDeleteAttach(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
			{
				logger.info(new Date() +"Inside DakCreateEditDeleteAttach "+ req.getUserPrincipal().getName());
				try
				{
					String dakid = req.getParameter("DakId");
					String dakattachmentid=req.getParameter("dakattachmentid");
					Object[] dakCreateattachmentdata =service.dakCreateattachmentdata(dakattachmentid);
					File my_file=null;
					String createattachdata = dakCreateattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
	        		String[] fileParts = createattachdata.split(",");
			        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+dakCreateattachmentdata[1]);
					boolean result = Files.deleteIfExists(my_file.toPath());
					if(result) 
					{
						service.DeleteDakCreateAttachment(dakattachmentid);
						redir.addAttribute("result","Document Deleted Successfully");
					}
					else
					{
						redir.addAttribute("resultfail","Document Delete Unsuccessful");
					}
					redir.addAttribute("DakCreateId", dakid);
				}catch (Exception e) {
						e.printStackTrace(); 
						logger.error(new Date() +"Inside DakCreateEditDeleteAttach "+ req.getUserPrincipal().getName(),e);
				}
				return "redirect:/DakCreateEdit.htm";
			}
		
		
		
			@RequestMapping(value = "DakCreateEditSubmit.htm", method = {RequestMethod.GET, RequestMethod.POST})
			public String DakCreateEditSubmit(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir,@RequestPart(name = "dak_document", required = false) MultipartFile maindoc,@RequestPart(name = "dak_sub_document", required = false) MultipartFile[] subdocs) {
				logger.info(new Date() +"Dak DakCreateEditSubmit.htm"+req.getUserPrincipal().getName());
				long result=0;
				try {
					String DivisionCode = (String) ses.getAttribute("DivisionCode");
				    String LabCode = (String) ses.getAttribute("LabCode");
		            String DakAttachmentId=req.getParameter("dakattachmentid");
		            String ProjectIdDetails=req.getParameter("ActionId");
					 long ActionId=0;
					 String ActionCode=null;
					 if(ProjectIdDetails!=null)
		  			 {
		  				String[] arr=ProjectIdDetails.split("#");
		  				ActionId=Integer.parseInt(arr[0]);
		  				ActionCode=arr[1].trim();
		  			 }
					String DakLinkId[]=(String[])req.getParameterValues("DakLinkId");
					String DestinationType[]=req.getParameterValues("DestinationType");
					DakCreate dak=new DakCreate();
					dak.setDakCreateId(Long.parseLong(req.getParameter("DakId")));
					dak.setSubject(req.getParameter("Subject").trim());
					dak.setDakNo(req.getParameter("DakNo").trim());
					dak.setRefNo(req.getParameter("RefNo").trim());
					dak.setReceiptDate(new java.sql.Date(sdf.parse(req.getParameter("ReceiptDate")).getTime()));
					dak.setRefDate(new java.sql.Date(sdf.parse(req.getParameter("RefDate")).getTime()));
					dak.setDestinationId(Long.parseLong(req.getParameter("DestinationId")));
					dak.setSignatory(req.getParameter("Signatory").trim());
					dak.setPriorityId(Long.parseLong(req.getParameter("PriorityId")));
					dak.setDeliveryTypeId(Long.parseLong(req.getParameter("DakDeliveryId")));
					dak.setLetterTypeId(Long.parseLong(req.getParameter("LetterId")));
					dak.setKeyWord1(req.getParameter("Key1").trim());
					dak.setKeyWord2(req.getParameter("Key2").trim());
					dak.setKeyWord3(req.getParameter("Key3").trim());
					dak.setKeyWord4(req.getParameter("Key4").trim());
					dak.setRemarks(req.getParameter("Remarks").trim());
					dak.setActionId(ActionId);
					if(ActionCode.equalsIgnoreCase("ACTION")) {
						dak.setActionDueDate(new java.sql.Date(sdf.parse(req.getParameter("DueDate")).getTime()));
						dak.setActionTime(req.getParameter("DueTime"));
						dak.setReplyOpen("Y");
					}else {
					dak.setReplyOpen("N");
					}
					dak.setReplyStatus("N");
					dak.setDakStatus("DI");
					dak.setDivisionCode(DivisionCode);
					dak.setLabCode(LabCode);
					String action=req.getParameter("action");
					 if(action!=null && action.equalsIgnoreCase("update")) {
						 dak.setIsSave("Y");
					 }else if(action!=null && action.equalsIgnoreCase("updateforward")) {
						 dak.setIsSave("N");
					 }
					dak.setModifiedBy(req.getUserPrincipal().getName());
					dak.setModifiedDate(sdf1.format(new Date()));
					dak.setIsActive(1);
					DakAddDto dakdto = DakAddDto.builder().dakcreate(dak).MainDoc(maindoc).SubDoc(subdocs).build();
					result=service.saveDakCreateEdit(DakAttachmentId,dakdto,dak,ActionCode,DakLinkId);
					
					
					 if(result>0 && action!=null && action.equalsIgnoreCase("update")) {
						 List<Object[]> selDestinationTypeList=service.selDestinationTypeList(result);
						 ArrayList<Long> selectedDestination=new ArrayList<Long>();
						 for(Object[] obj:selDestinationTypeList) {
							 service.updateIsActiveselDestination(result,Long.parseLong(obj[0].toString()),0);
							 selectedDestination.add(Long.parseLong(obj[0].toString()));
						 }
						 for(int i=0;i<DestinationType.length;i++) {
							    String[] DestionatinVals = DestinationType[i].split("-");
					        	String destinationtypeid = DestionatinVals[0];
					        	Long destinationTypeIdLong = Long.parseLong(destinationtypeid);
					            if (selectedDestination.contains(destinationTypeIdLong)) {
					                service.updateIsActiveselDestination(result, destinationTypeIdLong,1);
					            } else {
							    DakCreateDestination destination=new DakCreateDestination();
				       			destination.setDakCreateId(result);
				       			destination.setDestinationTypeId(destinationTypeIdLong);
				       			destination.setAcknowledged("N");
				       			destination.setReplyStatus("N");
				       			destination.setIsSent("N");
				       			destination.setCreatedBy(req.getUserPrincipal().getName());
				       			destination.setCreatedDate(sdf1.format(new Date()));
				       			destination.setIsActive(1);
				       			service.insertDakDestination(destination);
						 }
						 }
					 }else if(result>0 && action!=null && action.equalsIgnoreCase("updateforward")) {
						 List<Object[]> selDestinationTypeList=service.selDestinationTypeList(result);
						 ArrayList<Long> selectedDestination=new ArrayList<Long>();
						 for(Object[] obj:selDestinationTypeList) {
							 long updateIsActiveselDestination=service.updateIsActiveselDestination(result,Long.parseLong(obj[0].toString()),0);
							 if(updateIsActiveselDestination>0) {
							 selectedDestination.add(Long.parseLong(obj[0].toString()));
							 }
						 }
						 		try {
						    	for(int i=0;i<DestinationType.length;i++) {
						    		String[] DestionatinVals = DestinationType[i].split("-");
						        	String destinationtypeid = DestionatinVals[0];
						       		String destinationurl = DestionatinVals[1]+"DakCreationforLabSubmit.htm";
						       		String SelDivisionCode=DestionatinVals[2];
						       		String SelLabCode=DestionatinVals[3];
						       		DakMain daklab=new DakMain();
						       		daklab.setSubject(req.getParameter("Subject").trim());
						       		daklab.setRefNo(req.getParameter("RefNo").trim());
						       		daklab.setReceiptDate(new java.sql.Date(sdf.parse(req.getParameter("ReceiptDate")).getTime()));
						       		daklab.setRefDate(new java.sql.Date(sdf.parse(req.getParameter("RefDate")).getTime()));
						       		daklab.setSourceId(Long.parseLong(req.getParameter("DestinationId")));
						       		daklab.setSourceDetailId(Long.parseLong(destinationtypeid));
						       		daklab.setProjectType(req.getParameter("ProjectType"));
						       		daklab.setPriorityId(Long.parseLong(req.getParameter("PriorityId")));
						       		daklab.setSignatory(req.getParameter("Signatory").trim());
						       		daklab.setDeliveryTypeId(Long.parseLong(req.getParameter("DakDeliveryId")));
						       		daklab.setLetterTypeId(Long.parseLong(req.getParameter("LetterId")));
						       		daklab.setKeyWord1(req.getParameter("Key1").trim());
						       		daklab.setKeyWord2(req.getParameter("Key2").trim());
						       		daklab.setKeyWord3(req.getParameter("Key3").trim());
						       		daklab.setKeyWord4(req.getParameter("Key4").trim());
						       		daklab.setRemarks(req.getParameter("Remarks").trim());
						       		daklab.setActionId(ActionId);
									if (ActionCode.equalsIgnoreCase("ACTION")) {
										daklab.setActionDueDate(new java.sql.Date(sdf.parse(req.getParameter("DueDate")).getTime()));
										daklab.setActionTime(req.getParameter("DueTime"));
										daklab.setReplyOpen("Y");
									}else {
										daklab.setReplyOpen("N");
									}
									daklab.setDivisionCode(SelDivisionCode);
									daklab.setLabCode(SelLabCode);
									daklab.setReplyStatus("N");
									daklab.setDakStatus("DI");
									daklab.setSourceLabCode(LabCode);
									daklab.setCreatedBy(req.getUserPrincipal().getName());
									daklab.setCreatedDate(sdf1.format(new Date()));
									daklab.setIsActive(1);
									daklab.setCreateLabCode(LabCode);
									DakAddDto dakdto1 = DakAddDto.builder().dak(daklab).DestinationId(Long.parseLong(req.getParameter("DestinationId"))).DestinationTypeId(Long.parseLong(destinationtypeid)).build();
									HttpHeaders headers = new HttpHeaders();
								    headers.setContentType(MediaType.MULTIPART_FORM_DATA);
								    MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
							        if (maindoc != null && !maindoc.isEmpty()) {
							            HttpHeaders mainDocHeaders = new HttpHeaders();
							            mainDocHeaders.setContentDisposition(ContentDisposition.builder("form-data")
							                    .name("dak_document")
							                    .filename(maindoc.getOriginalFilename())
							                    .build());
							            mainDocHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
							            HttpEntity<ByteArrayResource> mainDocEntity = new HttpEntity<>(new ByteArrayResource(maindoc.getBytes()), mainDocHeaders);
							            body.add("dak_document", mainDocEntity);
							        }
							        if (subdocs != null && subdocs.length>0) {
							            for (MultipartFile file : subdocs) {
							            	if(!file.isEmpty()) {
							                HttpHeaders subDocHeaders = new HttpHeaders();
							                subDocHeaders.setContentDisposition(ContentDisposition.builder("form-data")
							                        .name("dak_sub_document")
							                        .filename(file.getOriginalFilename())
							                        .build());
							                subDocHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
							                HttpEntity<ByteArrayResource> subDocEntity = new HttpEntity<>(new ByteArrayResource(file.getBytes()), subDocHeaders);
							                body.add("dak_sub_document", subDocEntity);
							            }
							            }
							        }
							        if (dakdto1 != null) {
							            HttpHeaders dtoHeaders = new HttpHeaders();
							            dtoHeaders.setContentType(MediaType.APPLICATION_JSON);
							            HttpEntity<DakAddDto> dtoEntity = new HttpEntity<>(dakdto1, dtoHeaders);
							            body.add("dakdto1", dtoEntity);
							        }
							        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
							        String resultdata = "";
							        try {
							            ResponseEntity<String> response = restTemplate.exchange(destinationurl, HttpMethod.POST, requestEntity, String.class);
							            resultdata = response.getBody();
							        } catch (HttpClientErrorException e) {
							            e.printStackTrace();
							        }
							        if (resultdata != null && "success".equalsIgnoreCase(resultdata)) {
							        Long destinationTypeIdLong = Long.parseLong(destinationtypeid);
						            if (selectedDestination.contains(destinationTypeIdLong)) {
						                service.updateIsActiveselDestination(result, destinationTypeIdLong,1);
						            } else {
									    DakCreateDestination destination=new DakCreateDestination();
						       			destination.setDakCreateId(result);
						       			destination.setDestinationTypeId(destinationTypeIdLong);
						       			destination.setAcknowledged("N");
						       			destination.setReplyStatus("N");
						       			destination.setIsSent("Y");
						       			destination.setCreatedBy(req.getUserPrincipal().getName());
						       			destination.setCreatedDate(sdf1.format(new Date()));
						       			destination.setIsActive(1);
						       			service.insertDakDestination(destination);
						            }
							       }
						    	  }
						 		}catch (Exception e) {
									e.printStackTrace();
								}
					         }
					if(result >0) {
						redir.addAttribute("result", "DAK Updated Successfully");
					}
					else {
						redir.addAttribute("resultfail", "DAK Updating Unsuccessful");
					}
					String fromDate=(String)req.getParameter("FrmDtE");
					String toDate=(String)req.getParameter("ToDtE");
					if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
					    try {
					        fromDate = rdf.format(sdf2.parse(fromDate));
					        toDate = rdf.format(sdf2.parse(toDate));
					        redir.addAttribute("FromDate", fromDate);
					        redir.addAttribute("ToDate", toDate);
					    } catch (ParseException e) {
					        e.printStackTrace();
					    }
					}
					if(action!=null && action.equalsIgnoreCase("update")) {
						return "redirect:/DakCreationPendingList.htm";
					}else {
						return "redirect:/DakCreationList.htm";
					}
				}catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +"Dak DakCreateEditSubmit.htm"+e);
				}
					
				return "redirect:/DakCreationList.htm";
			}
			
			
			
			@RequestMapping(value = "DakCreationList.htm", method = {RequestMethod.GET,RequestMethod.POST})
			public String DakCreationList(HttpServletRequest req,HttpServletResponse res, HttpSession ses) throws Exception {
		        logger.info(new Date() +"DakCreationList.htm"+req.getUserPrincipal().getName());
				try {
					String fromDate=(String)req.getParameter("FromDate");
					String toDate=(String)req.getParameter("ToDate");
					if(toDate == null) 
					{
						toDate=LocalDate.now().toString();
					}else
					{
						fromDate=sdf2.format(rdf.parse(fromDate));
					}
					
					if(fromDate==null) {
						fromDate=LocalDate.now().minusDays(30).toString();
					}else {
						toDate=sdf2.format(rdf.parse(toDate));
					}
					 List<Object[]> dakCreationList=service.dakCreationList(fromDate,toDate);
				 	 req.setAttribute("frmDt", fromDate);
					 req.setAttribute("toDt",   toDate);
					 req.setAttribute("dakCreationList",dakCreationList);
				} catch (Exception e) {
					e.printStackTrace();
				}
				return "dak/dakCreationList";
			}
			
			
			@RequestMapping(value = "DakAssignUpdate.htm" ,method = {RequestMethod.GET , RequestMethod.POST})
			public String DakAssignUpdate(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) {
				logger.info(new Date() +"Inside DakAssignUpdate.htm"+req.getUserPrincipal().getName());
				try {
					String EmpIdAssignUpdate=req.getParameter("EmpIdAssignUpdate");
					String DakIdAssignUpdate=req.getParameter("DakIdAssignUpdate");
					String RemarksAssignUpdate=req.getParameter("RemarksAssignUpdate");
					String RedirectValue=req.getParameter("RedirectValue");
					String redirectedvalue=req.getParameter("redirectedvalue");
					if(redirectedvalue!=null) {
						redir.addAttribute("redirectedvalue", redirectedvalue);
					}
					long DakAssignUpdate=service.DakAssignUpdate(EmpIdAssignUpdate,DakIdAssignUpdate,0,RemarksAssignUpdate);
					if(DakAssignUpdate>0) 
					{
						redir.addAttribute("result","DAK Assign Delete Successfully ");
					}
					else
					{
						redir.addAttribute("resultfail","DAK Assign Delete Unsuccessful");
					}
					String PageRedir=(String)req.getParameter("PageRedireData");
					String RowRedir=(String)req.getParameter("RowRedireData");
					redir.addAttribute("PageNoData", PageRedir);
				    redir.addAttribute("RowData", RowRedir);
					String fromDate=(String)req.getParameter("fromDateFetch");
					String toDate=(String)req.getParameter("toDateFetch");
					if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
					    try {
					        fromDate = rdf.format(sdf2.parse(fromDate));
					        toDate = rdf.format(sdf2.parse(toDate));
					        redir.addAttribute("FromDate", fromDate);
					        redir.addAttribute("ToDate", toDate);
					    } catch (ParseException e) {
					        e.printStackTrace();
					    }
					}
					redir.addAttribute("DakId", DakIdAssignUpdate);
					if(RedirectValue.equalsIgnoreCase("DakReceivedList")) {
					return "redirect:/DakReceivedList.htm";
					}else if(RedirectValue.equalsIgnoreCase("DakReceivedViewList")) {
						redir.addAttribute("viewfrom", req.getParameter("viewfrom"));
						return "redirect:/DakReceivedView.htm";
					}else {
						return "redirect:/DakRepliedList.htm";
					}
				} catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside DakAssignUpdate.htm"+req.getUserPrincipal().getName(), e);
					return null;
				}
				
			}
			
			@GetMapping("/getDakData")
			public ResponseEntity<Object[]> getDakData(@RequestParam("dakCreateId") Long dakCreateId,@RequestParam("LabCode") String LabCode) {
			    try {
			        Object[] finalData = service.getDakDataforShow(dakCreateId,LabCode);
			        if (finalData == null) {
			            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new Object[0]);
			        }
			        return ResponseEntity.ok(finalData);
			    } catch (Exception e) {
			        e.printStackTrace();
			        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
			    }
			}
			
			
			@RequestMapping(value = "LabDakTracking.htm", method = {RequestMethod.POST, RequestMethod.GET})
			public String DakTracking(Model model, HttpServletRequest req) throws Exception {
			    String dakId = req.getParameter("dakId"); // Fetch the dakId parameter
			    String url = req.getParameter("url");     // Fetch the url parameter
			    try {
			    	 List<Object[]> LabDakTrackingList=service.LabDakTrackingList(dakId,url);
					    req.setAttribute("DakTrackingListData", LabDakTrackingList);
					    List<Object[]> holidayDateList = reportservice.holidayDateList();
					    req.setAttribute("holidayDateList", holidayDateList);
					    req.setAttribute("url", url);
				} catch (Exception e) {
					e.printStackTrace();
				}
			    return "reports/LabDakTracking";
			}

			
			@GetMapping(value = "labDakTrackingData")
			public ResponseEntity<List<Object[]>> labDakTrackingData(@RequestParam("seldakId") Long seldakId) {
			    try {
			        List<Object[]> finalData = reportservice.DakTrackingList(seldakId.toString());
			        if (finalData == null || finalData.isEmpty()) {
			            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ArrayList<>());
			        }
			        return ResponseEntity.ok(finalData);
			    } catch (Exception e) {
				        e.printStackTrace();
				        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
			    }
			}
			
			
			
			@RequestMapping(value = "MainLabDAKReply.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
			public String MainLabDAKReply(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir) throws Exception {
	            logger.info(new Date() +"MainLabDAKReply.htm"+req.getUserPrincipal().getName());
	            long result=0;
	            long EmpId=(Long)ses.getAttribute("EmpId");
	            String ReplyFrom=req.getParameter("ReplyFrom");
	            try {
			      	String dakId=req.getParameter("dakIdValFrReply");
			      	String DakCreateId=req.getParameter("dakCreateId");
			      	String appUrl=req.getParameter("appUrl");
			    	String remarksReply=req.getParameter("replyRemarks").replaceAll("\\s+", " ");
			    	String closingcomment=req.getParameter("DakClosingComment").replaceAll("\\s+", " ");
			    	String ReplyPersonSentMail=req.getParameter("ReplyPersonSentMail");
			    	String[] ReplyReceivedMail=req.getParameterValues("ReplyReceivedMail");
			    	String ReplyMailSubject=req.getParameter("ReplyMailSubject");
			    	String HostType=req.getParameter("HostType");
			    	String SourceDetailId=req.getParameter("SourceDetailId");
	
			    	DakDestinationDto dto = DakDestinationDto.builder().build();
			    	dto.setDakId(Long.parseLong(dakId));
			    	dto.setDakCreateId(Long.parseLong(DakCreateId));
			    	dto.setReply(remarksReply);
		            dto.setReplyPersonSentMail(ReplyPersonSentMail);
		            dto.setReplyReceivedMail(ReplyReceivedMail);
		            dto.setReplyMailSubject(ReplyMailSubject);
		            dto.setHostType(HostType);
		            dto.setAppUrl(appUrl);
		            dto.setClosingComment(closingcomment);
		            dto.setDestinationTypeId(Long.parseLong(SourceDetailId));
		            dto.setModifiedBy(req.getUserPrincipal().getName());
			    	dto.setModifiedDate(sdf1.format(new Date()));
			    	dto.setEmpId(EmpId);
					result=service.insertMainLabDAKReply(dto);
					
					if(result>0) {
						
						redir.addAttribute("result","DAK Replied & Closed Successfully ");
					}else{
						redir.addAttribute("resultfail","DAK Replied & Closed Unsuccessful");
					}
	
					} catch (Exception e) {
						e.printStackTrace();
						   logger.error(new Date() +"MainLabDAKReply.htm"+req.getUserPrincipal().getName()+e);
					}
					String fromDate=(String)req.getParameter("fromDateFetch");
					String toDate=(String)req.getParameter("toDateFetch");
					if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
					    try {
					        fromDate = rdf.format(sdf2.parse(fromDate));
					        toDate = rdf.format(sdf2.parse(toDate));
					        redir.addAttribute("FromDate", fromDate);
					        redir.addAttribute("ToDate", toDate);
					    } catch (ParseException e) {
					        e.printStackTrace();
					    }
				}
					if(ReplyFrom!=null && ReplyFrom.equalsIgnoreCase("DakReceivedList")) {
						return "redirect:/DakReceivedList.htm";
					}else {
						return "redirect:/DakPNCDOList.htm";
					}
			}

			
			@GetMapping(value = "/ReplyForMainLab")
			public ResponseEntity<Long> ReplyForMainLab(@RequestParam("seldakCreateId") Long seldakCreateId,@RequestParam("seldestinationId") Long seldestinationId,
			        @RequestParam("reply") String reply, @RequestParam("modifiedBy") String modifiedBy ) {
			    try {
			    	 reply = URLDecoder.decode(reply, StandardCharsets.UTF_8.name());
			        long update = service.updateLabReply(seldakCreateId, seldestinationId, reply, modifiedBy, sdf2.format(new Date()));
			        if (update == 0) {
			            return ResponseEntity.ok(-1L);
			        }
			        return ResponseEntity.ok(update);
			    } catch (Exception e) {
			        e.printStackTrace();
			        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(-1L);
			    }
			} 


			
}


