package com.vts.dms.report.controller;

import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.font.FontProvider;
import com.vts.dms.CharArrayWriterResponse;
import com.vts.dms.report.service.ReportService;

@Controller
public class ReportController {
	
	private static final Logger logger=LogManager.getLogger(ReportController.class);
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	private  SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
	private SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	
	@Autowired
	ReportService service;
	
	@RequestMapping(value = "DakStatusList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakStatusList(Model model,HttpServletRequest req, HttpSession ses) throws Exception {
		
		String Username=(String)ses.getAttribute("Username");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		long EmpId=(Long)ses.getAttribute("EmpId");
		logger.info(new Date() +"DakStatusList "+req.getUserPrincipal().getName());
		
		Date date=new Date();
		String fromDate=(String)req.getParameter("FromDate");
		String toDate=(String)req.getParameter("ToDate");
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
		req.setAttribute("frmDt", fromDate);
		req.setAttribute("toDt",   toDate);
		req.setAttribute("DakList",service.DakStatusList(Username,LoginType,EmpId,fromDate,toDate));
		return "reports/DakStatusList";

	}
	
	@RequestMapping(value = "DakTracking.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public String DakTracking(Model model,HttpServletRequest req) throws Exception {
		logger.info(new Date() +"DakTracking "+req.getUserPrincipal().getName());
		req.setAttribute("DakTrackingListData",service.DakTrackingList(req.getParameter("dakId")));
		//redirect coding start
		String redirectValOfCommon = req.getParameter("redirectValTracking");
		if(redirectValOfCommon!=null && redirectValOfCommon.trim()!="") {
			req.setAttribute("redirectVal",req.getParameter("redirectValTracking"));
		}
		List<Object[]> holidayDateList=service.holidayDateList();
		req.setAttribute("holidayDateList", holidayDateList);
		//redirect coding end
		return "reports/DakTracking";

	}
	
	@RequestMapping(value = "DakTrackingPrint.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public void DakTrackingPrint(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
		logger.info(new Date() +"DakTrackingPrint.htm "+req.getUserPrincipal().getName());
		String Username=(String)ses.getAttribute("Username");
		List<Object[]> DakTrackingPrintData = null;
		String filename="download";
		try {
			String DakId = (String)req.getParameter("DakIdFrPrint");
			if(DakId!=null) {
				DakTrackingPrintData = service.DakTrackingPrintList(DakId);
				req.setAttribute("DakTrackingPrintData",DakTrackingPrintData);
				if(DakTrackingPrintData!=null && DakTrackingPrintData.size()>0) {
					for(Object obj[] : DakTrackingPrintData) {
						filename = obj[1].toString();
					}
				}
				/////I text///////////
				String path=req.getServletContext().getRealPath("/view/temp");
			  	req.setAttribute("path",path);
				CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
				req.getRequestDispatcher("/view/reports/DakTrackingPrint.jsp").forward(req, customResponse);
				String html = customResponse.getOutput();
				byte[] data = html.getBytes();
				InputStream Is = new ByteArrayInputStream(data);
				PdfDocument pdfFile = new PdfDocument(new PdfWriter(path + "/" + filename +  ".pdf"));
				pdfFile.setTagged();
				Document document = new Document(pdfFile, PageSize.LEGAL);
				document.setMargins(50, 100, 150, 50);
				ConverterProperties converterProperties = new ConverterProperties();
				FontProvider dfp = new DefaultFontProvider(true, true, true);
				converterProperties.setFontProvider(dfp);
				HtmlConverter.convertToPdf(Is, pdfFile, converterProperties);
				res.setContentType("application/pdf");
				res.setHeader("Content-disposition", "inline;filename=" + filename + ".pdf");
				File f = new File(path + "/" + filename +  ".pdf");
				FileInputStream Fs = new FileInputStream(f);
				DataOutputStream os = new DataOutputStream(res.getOutputStream());
				res.setHeader("Content-Length", String.valueOf(f.length()));
				byte[] buffer = new byte[1024];
				int len = 0;
				while ((len = Fs.read(buffer)) >= 0) {
				os.write(buffer, 0, len);
				}
				os.close();
				Fs.close();
				Path pathOfFile2 = Paths.get(path + "/" + filename  + ".pdf");
				Files.delete(pathOfFile2);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside DakTrackingPrint.htm "+Username, e);
			}
	}
	
	
	@CrossOrigin(origins = "*")
	@RequestMapping(value="GetInitiatedByFullName.htm",method=RequestMethod.GET)
	public  @ResponseBody String  BillAddUbNoValidation(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetInitiatedByFullName.htm"+Username);
		Gson json = new Gson();
		String result = null;
		try {
			String InitiatedBy=(String)req.getParameter("initiatedBy");
			List<Object[]> CreatedByDetails = service.GetCreatedByDetails(InitiatedBy);
			if(CreatedByDetails!=null && CreatedByDetails.size()>0) {
				for(Object[] obj:CreatedByDetails) {
					 result = obj[1].toString() + ", " + obj[2].toString();
				}
			}else {
				result = InitiatedBy;
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetInitiatedByFullName.htm "+Username, e);
			}
		return json.toJson(result);

	}
	
	
	@CrossOrigin(origins = "*")
	@RequestMapping(value="RepliedByPAndCFullName.htm",method=RequestMethod.GET)
	public  @ResponseBody String  RepliedByPAndCFullName(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside RepliedByPAndCFullName.htm"+Username);
		Gson json = new Gson();
		String result = null;
		try {
			String RepliedByPAndC=(String)req.getParameter("RepliedByPAndC");
			List<Object[]> ModifiedByDetails = service.GetCreatedByDetails(RepliedByPAndC);
			if(ModifiedByDetails!=null && ModifiedByDetails.size()>0) {
				for(Object[] obj:ModifiedByDetails) {
					 result = obj[1].toString() + ", " + obj[2].toString();
				}
			}else {
				result = RepliedByPAndC;
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside RepliedByPAndCFullName.htm "+Username, e);
			}
		return json.toJson(result);

	}  
	
	
	@CrossOrigin(origins = "*")
	@RequestMapping(value="ApprovedByFullName.htm",method=RequestMethod.GET)
	public  @ResponseBody String  ApprovedByFullName(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside ApprovedByFullName.htm"+Username);
		Gson json = new Gson();
		String result = null;
		try {
			String ApprovedBy=(String)req.getParameter("ApprovedBy");
			List<Object[]> ApprovedByDetails = service.GetCreatedByDetails(ApprovedBy);
				if(ApprovedByDetails!=null && ApprovedByDetails.size()>0) {
					for(Object[] obj:ApprovedByDetails) {
						 result = obj[1].toString() + ", " + obj[2].toString();
					}
				}else {
					result = ApprovedBy;
				}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ApprovedByFullName.htm "+Username, e);
			}
		return json.toJson(result);

	}
	
	
	@CrossOrigin(origins = "*")
	@RequestMapping(value="ClosedByFullName.htm",method=RequestMethod.GET)
	public  @ResponseBody String  ClosedByFullName(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside ClosedByFullName.htm"+Username);
		Gson json = new Gson();
		String result = null;
		try {
			String ClosedBy=(String)req.getParameter("ClosedBy");
			List<Object[]> ClosedByDetails = service.GetCreatedByDetails(ClosedBy);
				if(ClosedByDetails!=null && ClosedByDetails.size()>0) {
					for(Object[] obj:ClosedByDetails) {
						 result = obj[1].toString() + ", " + obj[2].toString();
					}
				}else {
					result = ClosedBy;
				}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ClosedByFullName.htm "+Username, e);
			}
		return json.toJson(result);

	}
	
	
	@CrossOrigin(origins = "*")
	@RequestMapping(value="GetAcknowledgedMembers.htm",method=RequestMethod.GET)   
	public  @ResponseBody String  GetAcknowledgedMembers(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetAcknowledgedMembers.htm"+Username);
		Gson json = new Gson();
		List <Object[]> AcknowledgedMembersData = null;
		try {
			String DakId=(String)req.getParameter("dakId");
			List<Object[]> AcknowledgedMembersList = service.GeAcknowledgedMembersList(DakId);
			if(AcknowledgedMembersList!=null && AcknowledgedMembersList.size()>0) {
				AcknowledgedMembersData = AcknowledgedMembersList;
			}else {
				AcknowledgedMembersData = null;
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetInitiatedByFullName.htm "+Username, e);
			}
		return json.toJson(AcknowledgedMembersData);

	}   
	
	
	@CrossOrigin(origins = "*")
	@RequestMapping(value="GetRepliedMemberName.htm",method=RequestMethod.GET)
	public  @ResponseBody String  GetRepliedMemberName(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetRepliedMemberName.htm"+Username);
		Gson json = new Gson();
		List <Object[]> RepliedMemberData = null;
		try {
			String DakId=(String)req.getParameter("dakId");
			List<Object[]> RepliedMembersList = service.GetRepliedMembersList(DakId);
			if(RepliedMembersList!=null && RepliedMembersList.size()>0) {
				RepliedMemberData = RepliedMembersList;
			}else {
				RepliedMemberData = null;
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetRepliedMemberName.htm "+Username, e);
			}
		return json.toJson(RepliedMemberData);

	}
	
	@RequestMapping(value = "DakSearch.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakSearch(HttpServletRequest req) throws Exception {
		logger.info(new Date() +"DakSearch"+req.getUserPrincipal().getName());
		try {
			System.out.println("Welcome");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "reports/DakSearch";
	}
	

	@RequestMapping(value = "DakNoSearchDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakSearch(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +"DakNoSearchDetails"+req.getUserPrincipal().getName());
		String Username=(String)ses.getAttribute("Username");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		long EmpId=(Long)ses.getAttribute("EmpId");
		List <Object[]> DakIdSearchDetailsList = null;
		try {
			String DakNo = req.getParameter("DakNoVal");
			DakIdSearchDetailsList =  service.GetDakNoSearchDetailsList(DakNo,EmpId,Username,LoginType);
		    if(DakIdSearchDetailsList!=null && DakIdSearchDetailsList.size()>0) {
		    	req.setAttribute("SearchDetailsList",DakIdSearchDetailsList );
		    }
			req.setAttribute("searchAction", "DakIdSearch");
			req.setAttribute("searchType", "DAK Id");
			req.setAttribute("searchValue", DakNo);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside DakNoSearchDetails.htm "+Username, e);
			}
		return "reports/DakSearch";
	}
	
	
	@RequestMapping(value = "RefNoSearchDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String RefNoSearchDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		
		logger.info(new Date() +"RefNoSearchDetails"+req.getUserPrincipal().getName());
		String Username=(String)ses.getAttribute("Username");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		long EmpId=(Long)ses.getAttribute("EmpId");
		List <Object[]> RefNoSearchDetailsList = null;
		try {
			String RefNo = req.getParameter("RefNoVal");
			RefNoSearchDetailsList =  service.GetRefNoSearchDetailsList(RefNo,EmpId,Username,LoginType);
		    if(RefNoSearchDetailsList!=null && RefNoSearchDetailsList.size()>0) {
		    	req.setAttribute("SearchDetailsList",RefNoSearchDetailsList );
		    }
			req.setAttribute("searchAction", "RefNoSearch");
			req.setAttribute("searchType", "Ref No");
			req.setAttribute("searchValue", RefNo);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside RefNoSearchDetails.htm "+Username, e);
			}
		return "reports/DakSearch";
	}
	
	@RequestMapping(value = "SubjectSearchDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String SubjectSearchDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		
		logger.info(new Date() +"SubjectSearchDetails"+req.getUserPrincipal().getName());
		String Username=(String)ses.getAttribute("Username");
		long EmpId=(Long)ses.getAttribute("EmpId");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		List <Object[]> SubjectSearchDetailsList = null;
		try {
			String Subject = req.getParameter("SubjectVal");
			SubjectSearchDetailsList =  service.GetSubjectSearchDetailsList(Subject,EmpId,Username,LoginType);
		    if(SubjectSearchDetailsList!=null && SubjectSearchDetailsList.size()>0) {
		    	req.setAttribute("SearchDetailsList",SubjectSearchDetailsList );
		    }
			req.setAttribute("searchAction", "SubjectSearch");
			req.setAttribute("searchType", "Subject");
			req.setAttribute("searchValue", Subject);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside SubjectSearchDetails.htm "+Username, e);
			}
		return "reports/DakSearch";
	}
	
	
	@RequestMapping(value = "KeywordsSearchDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String KeywordsSearchDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +"KeywordsSearchDetails"+req.getUserPrincipal().getName());
		String Username=(String)ses.getAttribute("Username");
		long EmpId=(Long)ses.getAttribute("EmpId");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		List <Object[]> KeywordsSearchDetailsList = null;
		try {
			String Keyword = req.getParameter("KeywordsVal");
			KeywordsSearchDetailsList =  service.GetKeywordsSearchDetailsList(Keyword,EmpId,Username,LoginType);
		    if(KeywordsSearchDetailsList!=null && KeywordsSearchDetailsList.size()>0) {
		    	req.setAttribute("SearchDetailsList",KeywordsSearchDetailsList );
		    }
			req.setAttribute("searchAction", "KeywordsSearch");
			req.setAttribute("searchType", "Keyword");
			req.setAttribute("searchValue", Keyword);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside KeywordsSearchDetails.htm "+Username, e);
			}
		return "reports/DakSearch";
	}
	
	@RequestMapping(value = "DakFilter.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakFilter(HttpServletRequest req, HttpSession ses) throws Exception {
		String Username=(String)ses.getAttribute("Username");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		long EmpId=(Long)ses.getAttribute("EmpId");
		logger.info(new Date() +"DakFilter"+req.getUserPrincipal().getName());
		try {
				String FilterType=req.getParameter("FilterType");
				String SelectedDetailsId=req.getParameter("SelectedDetails");
				String FromDate=req.getParameter("FromDate");
				String ToDate=req.getParameter("ToDate");
				Date date=new Date();
				Calendar cal = new GregorianCalendar(); cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, -7); Date prevdate = cal.getTime();
				if(FilterType==null && SelectedDetailsId==null && FromDate==null && ToDate==null)
				{
					FilterType="Source";
					SelectedDetailsId="-1";
					FromDate = new SimpleDateFormat("yyyy-MM-dd").format(prevdate);
					ToDate  = LocalDate.now().toString();
				}
				else
				{
					FromDate=sdf2.format(rdf.parse(FromDate));
					ToDate=sdf2.format(rdf.parse(ToDate));
				}
				req.setAttribute("DakFilteredList", service.GetDakFilteredList(FilterType,SelectedDetailsId,FromDate,ToDate,LoginType,EmpId,Username));
				req.setAttribute("FromDate",rdf.format(sdf2.parse(FromDate)));
				req.setAttribute("ToDate",rdf.format(sdf2.parse(ToDate)));
				req.setAttribute("FilterTypeController",FilterType);
				req.setAttribute("SelectedDetailsIdController",SelectedDetailsId);
			} 
		   catch (Exception e) 
		   {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakFilter.htm "+Username, e);
		   }
		return "reports/DakFilter";
	}   
	
	
	@RequestMapping(value="GetSelectedDetailsFilter.htm",method=RequestMethod.GET)   
	public  @ResponseBody String  GetSelectedDetailsFilter(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetSelectedDetailsFilter.htm"+Username);
		Gson json = new Gson();
		List <Object[]> List = null;
		List<Object[]> ResultList =null;
		try {
			String FilterType=(String)req.getParameter("FilterType");
			if(FilterType!=null)
			{
				ResultList = service.GetSelectedTypeDropDown(FilterType);
			}
			if(ResultList!=null && ResultList.size()>0) {
				List = ResultList;
			}else {
				List = null;
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetSelectedDetailsFilter.htm "+Username, e);
			}
		return json.toJson(List);
	}   
	
	@RequestMapping(value = "DakFilterSelection.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakFilterSelection(HttpServletRequest req) throws Exception {
		logger.info(new Date() +"DakFilterSelection"+req.getUserPrincipal().getName());
		String PriorityModal = req.getParameter("PriorityModal");
		String TypeModal = req.getParameter("TypeModal");
		String SourceModal = req.getParameter("SourceModal");
		String ProjectTypeModal = req.getParameter("ProjectTypeModal");
		String ProjectTypeValueModal = req.getParameter("ProjectTypeValueModal");
		if(PriorityModal!=null) {
			//send those list
			List<Object[]> PriorityList = null;
			req.setAttribute("PriorityList", PriorityList);
		}
		if(TypeModal!=null) {
			//send those list
			List<Object[]> TypeModalList = null;
			req.setAttribute("TypeModalList", TypeModalList);
		}
		
		if(SourceModal!=null) {
			//send those list
			List<Object[]> SourceModalList = null;
			req.setAttribute("SourceModalList", SourceModalList);
		}
		
		if(ProjectTypeModal!=null) {
			//send those list
			List<Object[]> ProjectTypeList = null;
			req.setAttribute("ProjectTypeList", ProjectTypeList);
		}
		
        if(ProjectTypeValueModal!=null) {
        	//send those list
        	List<Object[]> ProjectTypeValueList = null;
			req.setAttribute("ProjectTypeValueList", ProjectTypeValueList);
		}

		return "reports/DakFilter";

	}
	
	
	
	@RequestMapping(value = "DakGroupingList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakGroupingList(HttpServletRequest req, HttpSession ses) throws Exception {
		String Username=(String)ses.getAttribute("Username");
		String SelDakMemberTypeId=req.getParameter("DakMemberTypeId");
		String selEmpId=req.getParameter("Employee");
		long EmpId=(Long)ses.getAttribute("EmpId");
		    Object Labcode=service.getlabcode(EmpId);
			String lab=Labcode.toString();
			String membertype=null;
			String EmployeeId=null;
			if(SelDakMemberTypeId==null ||SelDakMemberTypeId.equalsIgnoreCase("All")) {
				membertype="All";
			}else {
				membertype=SelDakMemberTypeId;
			}
			if(selEmpId==null || selEmpId.equalsIgnoreCase("All")) {
				EmployeeId="All";
			}else {
				EmployeeId=selEmpId;
			}
		logger.info(new Date() +"DakGroupingList.htm"+req.getUserPrincipal().getName());
		try {
				
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
				List<Object[]> DakGroupingListDropDown=service.DakGroupingListDropDown();
				if(membertype.equalsIgnoreCase("All") && EmployeeId.equalsIgnoreCase("All")) {
					req.setAttribute("DakGroupingList", service.intialDakGroupingList(fromDate,toDate));
					req.setAttribute("EmployeeList", service.StartEmployeeList(lab));
				}else if(SelDakMemberTypeId!=null && EmployeeId.equalsIgnoreCase("All")){
					req.setAttribute("DakGroupingList", service.SelMemberTypeDakGroupingList(SelDakMemberTypeId,fromDate,toDate));
					req.setAttribute("EmployeeList", service.SelMemberTypeEmployeeList(SelDakMemberTypeId,lab));
				}else if(membertype.equalsIgnoreCase("All") && selEmpId!=null) {
					req.setAttribute("DakGroupingList", service.SelEmployeeTypeDakGroupingList(selEmpId,fromDate,toDate));
					req.setAttribute("EmployeeList", service.StartEmployeeList(lab));
				}else if(SelDakMemberTypeId!=null && selEmpId!=null && !SelDakMemberTypeId.equalsIgnoreCase("All") && !selEmpId.equalsIgnoreCase("All")) {
					req.setAttribute("DakGroupingList", service.SelEmployeeMemberTypeDakGroupingList(SelDakMemberTypeId,selEmpId,fromDate,toDate));
					req.setAttribute("EmployeeList", service.SelMemberTypeEmployeeList(SelDakMemberTypeId,lab));
				}
				req.setAttribute("selEmpId", selEmpId);
				req.setAttribute("SelDakMemberTypeId", SelDakMemberTypeId);
				req.setAttribute("DakGroupingListDropDown", DakGroupingListDropDown);
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
			} 
		   catch (Exception e) 
		   {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakGroupingList.htm "+Username, e);
		   }
		
		return "reports/DakGroupingList";

	}   
	
	
	@RequestMapping(value="getDakGroupingEmpList.htm",method=RequestMethod.GET)   
	public  @ResponseBody String  getDakGroupingEmpList(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		String DakMemberTypeId=req.getParameter("DakMemberTypeId");
		logger.info(new Date() + "Inside getDakGroupingEmpList.htm"+Username);
		Gson json = new Gson();
		List <Object[]> GroupEmpList = null;
		try {
			if(DakMemberTypeId!=null)
			{
				GroupEmpList = service.GroupEmpList(Long.parseLong(DakMemberTypeId));
			}

			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside getDakGroupingEmpList.htm "+Username, e);
			}
		return json.toJson(GroupEmpList);

	}   
	
	
	@RequestMapping(value = "DakProjectWiseReportList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakProjectWiseReportList(HttpServletRequest req, HttpSession ses) throws Exception {
		String Username=(String)ses.getAttribute("Username");
		long EmpId=(Long)ses.getAttribute("EmpId");
		    Object Labcode=service.getlabcode(EmpId);
			String lab=Labcode.toString();
		logger.info(new Date() +"DakProjectWiseReportList.htm"+req.getUserPrincipal().getName());
		try {
				String ProjectTypeId=req.getParameter("ProjectTypeId");
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
				
				String ProjectId=null;
				if(ProjectTypeId==null || ProjectTypeId.equalsIgnoreCase("All")) {
					ProjectId="All";
				}else {
					ProjectId=ProjectTypeId;
				}
				if(ProjectId!=null && ProjectId.equalsIgnoreCase("All")) {
					req.setAttribute("ProjectWiseList", service.AllProjectWiseList(fromDate,toDate));
				}else {
					req.setAttribute("ProjectWiseList", service.SelectedProjectWiseList(ProjectId,fromDate,toDate));
				}
				List<Object[]> selProjectList=service.SelProjectTypeList(lab);
				req.setAttribute("ProjectTypeId", ProjectTypeId);
				req.setAttribute("selProjectList", selProjectList);
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
			} 
		   catch (Exception e) 
		   {
				e.printStackTrace();
				logger.error(new Date() +" Inside DakProjectWiseReportList.htm "+Username, e);
		   }
		
		return "reports/DakProjecWiseReportList";

	}   
	
	
	@RequestMapping(value = "SmsReport.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String SmsReport(HttpServletRequest req, HttpSession ses) throws Exception {
		    String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() +"SmsReport.htm"+req.getUserPrincipal().getName());
		try {
				String fromDate=(String)req.getParameter("FromDate");
				String toDate=(String)req.getParameter("ToDate");
				if(fromDate==null || toDate == null) 
				{
					fromDate = LocalDate.now().toString();
					toDate  = LocalDate.now().toString();
				}else
				{
					fromDate=sdf2.format(rdf.parse(fromDate));
					toDate=sdf2.format(rdf.parse(toDate));
				}
				req.setAttribute("SmsReportList", service.SmsReportList(fromDate,toDate));
				req.setAttribute("frmDt", fromDate);
				req.setAttribute("toDt",   toDate);
			} 
		   catch (Exception e) 
		   {
				e.printStackTrace();
				logger.error(new Date() +" Inside SmsReport.htm "+Username, e);
		   }
		
		return "reports/SmsReportList";

	}
	
	
	@RequestMapping(value = "SmsReportExcel.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void SmsReportExcel(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) throws Exception{
		String UserName=(String)ses.getAttribute("Username");
		int RowNo=0;
		logger.info(new Date() + " Inside SmsReportExcel.htm " + UserName);
		try {
			String fromDate=(String)req.getParameter("FromDate");
			String toDate=(String)req.getParameter("ToDate");
			
			if(fromDate!=null && toDate!=null) {
				fromDate=sdf2.format(rdf.parse(fromDate));
				toDate=sdf2.format(rdf.parse(toDate));
			}
			List<Object[]> SmsReportList=service.SmsReportList(fromDate,toDate);
			Workbook workbook = new XSSFWorkbook();
			Sheet sheet = workbook.createSheet("Download Excel");
			sheet.setColumnWidth(0, 1000);
			sheet.setColumnWidth(1, 7000);
			sheet.setColumnWidth(2, 4000);
			sheet.setColumnWidth(3, 8000);
			sheet.setColumnWidth(4, 3000);
			sheet.setColumnWidth(5, 5000);
			sheet.setColumnWidth(6, 3000);
			sheet.setColumnWidth(7, 4000);
			sheet.setColumnWidth(8, 4000);
			
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
						
						
						String Excel="SMS Report Excel List ";
						Row file_header_row = sheet.createRow(RowNo++);
						sheet.addMergedRegion(new CellRangeAddress(0, 0,0, 8));   // Merging Header Cells 
						Cell cell= file_header_row.createCell(0);
						cell.setCellValue(""+Excel+ " "+"( "+sdf.format(sdf2.parse(fromDate))+" to "+sdf.format(sdf2.parse(toDate)) +")");
						file_header_row.setHeightInPoints((2*sheet.getDefaultRowHeightInPoints()));
						cell.setCellStyle(file_header_Style);
						// File header Row 2
						
						Row t_header_row = sheet.createRow(RowNo++);
						cell= t_header_row.createCell(0); 
						cell.setCellValue("SN"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(1); 
						cell.setCellValue("Employee"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(2); 
						cell.setCellValue("Mobile No"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(3); 
						cell.setCellValue("Messsage"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(4); 
						cell.setCellValue("DAK Pending"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(5); 
						cell.setCellValue("DAK Urgent "); 
						cell.setCellStyle(t_header_style);

						cell= t_header_row.createCell(6); 
						cell.setCellValue("DAK Today Pending"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(7); 
						cell.setCellValue("Dak Delay"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(8); 
						cell.setCellValue("Sms SentDate"); 
						cell.setCellStyle(t_header_style);

						
				long slno=1;
				if(SmsReportList!=null && SmsReportList.size()>0){
					for(Object[] obj:SmsReportList){
						
						
			     	Row t_body_row=sheet.createRow(RowNo);
				
			    	 t_body_row=sheet.createRow(RowNo++);
					
					 cell= t_body_row.createCell(0); 
					 cell.setCellValue(slno); 
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleCenter);
					 
					 
					 cell= t_body_row.createCell(1); 
					 if(obj[0]!=null && obj[1]!=null) {
					 cell.setCellValue(obj[0].toString()+", "+obj[1].toString()); 
					 }else {
						 cell.setCellValue("-");
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleLeft);
					 
				     cell= t_body_row.createCell(2); 
				     if(obj[6]!=null) {
					 cell.setCellValue(obj[6].toString());
				     }else {
				     cell.setCellValue("-");
				     }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleRight);
					 
					 cell= t_body_row.createCell(3); 
				     if(obj[7]!=null) {
					 cell.setCellValue(obj[7].toString());
				     }else {
				     cell.setCellValue("-");
				     }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleRight);
					 
					 cell= t_body_row.createCell(4);
					 if(obj[2]!=null) {
					 cell.setCellValue(obj[2].toString());
					 }else {
					 cell.setCellValue("-");
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleRight);
					 
					 cell= t_body_row.createCell(5); 
					 if(obj[3]!=null) {
					 cell.setCellValue(obj[3].toString()); 
					 }else {
					 cell.setCellValue("-");
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleRight);
					 
					 cell= t_body_row.createCell(6); 
					 if(obj[4]!=null) {
					 cell.setCellValue(obj[4].toString()); 
					 }else {
					 cell.setCellValue("-");	 
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleRight);
					 
					 cell= t_body_row.createCell(7); 
					 if(obj[5]!=null) {
					 cell.setCellValue(obj[5].toString()); 
					 }else {
					 cell.setCellValue("-");
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleRight);
					 
					 cell= t_body_row.createCell(8); 
					 if(obj[8]!=null) {
						 cell.setCellValue(sdf.format(obj[8])); 
				         }else {
				         cell.setCellValue("NA"); 
				         }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleCenter);
					 
					 slno++;
					}
				}
				String path = req.getServletContext().getRealPath("/view/temp");
				String fileLocation = path.substring(0, path.length() - 1) + "temp.xlsx";
				FileOutputStream outputStream = new FileOutputStream(fileLocation);
				workbook.write(outputStream);
				workbook.close();
				String filename="SMS Report Excel ";
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
	
	
	@RequestMapping(value = "PendingReportListExcel.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void PendingReportListExcel(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) throws Exception{
		String UserName=(String)ses.getAttribute("Username");
		int RowNo=0;
		logger.info(new Date() + " Inside PendingReportListExcel.htm " + UserName);
		try {
			List<Object[]> dakPendingReportList=service.dakPendingReportList();
			Workbook workbook = new XSSFWorkbook();
			Sheet sheet = workbook.createSheet("Download Excel");
			sheet.setColumnWidth(0, 1000);
			sheet.setColumnWidth(1, 5000);
			sheet.setColumnWidth(2, 4000);
			sheet.setColumnWidth(3, 3000);
			sheet.setColumnWidth(4, 3000);
			sheet.setColumnWidth(5, 5000);
			sheet.setColumnWidth(6, 10000);
			sheet.setColumnWidth(7, 4000);
			sheet.setColumnWidth(8, 4000);
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
						
						String Excel="Pending Report Excel List ";
						Row file_header_row = sheet.createRow(RowNo++);
						sheet.addMergedRegion(new CellRangeAddress(0, 0,0, 8));   // Merging Header Cells 
						Cell cell= file_header_row.createCell(0);
						cell.setCellValue(Excel);
						file_header_row.setHeightInPoints((2*sheet.getDefaultRowHeightInPoints()));
						cell.setCellStyle(file_header_Style);
						// File header Row 2
						
						Row t_header_row = sheet.createRow(RowNo++);
						cell= t_header_row.createCell(0); 
						cell.setCellValue("SN"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(1); 
						cell.setCellValue("DakNo"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(2); 
						cell.setCellValue("Source"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(3); 
						cell.setCellValue("Ref Date"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(4); 
						cell.setCellValue("Ref No"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(5); 
						cell.setCellValue("Receipt Date"); 
						cell.setCellStyle(t_header_style);

						cell= t_header_row.createCell(6); 
						cell.setCellValue("Subject"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(7); 
						cell.setCellValue("Action Due"); 
						cell.setCellStyle(t_header_style);
						
						cell= t_header_row.createCell(8); 
						cell.setCellValue("Status"); 
						cell.setCellStyle(t_header_style);

						
				long slno=1;
				if(dakPendingReportList!=null && dakPendingReportList.size()>0){
					for(Object[] obj:dakPendingReportList){
			     	Row t_body_row=sheet.createRow(RowNo);
			    	 t_body_row=sheet.createRow(RowNo++);
					 cell= t_body_row.createCell(0); 
					 cell.setCellValue(slno); 
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleCenter);
					 
					 cell= t_body_row.createCell(1); 
					 if( obj[1]!=null) {
					 cell.setCellValue(obj[1].toString()); 
					 }else {
						 cell.setCellValue("-");
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleLeft);
					 
				     cell= t_body_row.createCell(2); 
				     if(obj[7]!=null) {
					 cell.setCellValue(obj[7].toString());
				     }else {
				     cell.setCellValue("-");
				     }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleLeft);
					 
					 cell= t_body_row.createCell(3);
					 if(obj[3]!=null) {
					 cell.setCellValue(sdf.format(obj[3]));
					 }else {
					 cell.setCellValue("-");
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleCenter);
					 
					 cell= t_body_row.createCell(4); 
					 if(obj[2]!=null) {
					 cell.setCellValue(obj[2].toString()); 
					 }else {
					 cell.setCellValue("-");
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleLeft);
					 
					 cell= t_body_row.createCell(5); 
					 if(obj[4]!=null) {
					 cell.setCellValue(sdf.format(obj[4])); 
					 }else {
					 cell.setCellValue("-");	 
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleCenter);
					 
					 cell= t_body_row.createCell(6); 
					 if(obj[5]!=null) {
					 cell.setCellValue(obj[5].toString()); 
					 }else {
					 cell.setCellValue("-");
					 }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleLeft);
					 
					 cell= t_body_row.createCell(7); 
					 if(obj[6]!=null) {
						 cell.setCellValue(sdf.format(obj[6])); 
				         }else {
				         cell.setCellValue("NA"); 
				         }
					 cell.setCellStyle(t_body_style);
					 cell.setCellStyle(styleCenter);
					 
					 cell= t_body_row.createCell(8); 
					 if(obj[8]!=null) {
					 cell.setCellValue(obj[8].toString()); 
					 }else {
					 cell.setCellValue("-");
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
				String filename="Pending Report List Excel ";
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
	
	
	@RequestMapping(value = "DMSSmsReportListExcel.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void DMSSmsReportListExcel(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) throws Exception{
        try {
            String fromDate = (String) req.getParameter("FromDate");
            String toDate = (String) req.getParameter("ToDate");
            if (fromDate != null && toDate != null) {
                fromDate = sdf2.format(rdf.parse(fromDate));
                toDate = sdf2.format(rdf.parse(toDate));
            }
            List<Object[]> SmsReportList = service.SmsReportList(fromDate, toDate);
            
            String fileName = "SMS Report.csv";
            resp.setContentType("text/csv");
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

            try (PrintWriter writer = new PrintWriter(new BufferedWriter(new OutputStreamWriter(resp.getOutputStream())))) {
            	writer.println("MobileNo,Message");

                long slno = 1;
                if (SmsReportList != null && SmsReportList.size() > 0) {
                    for (Object[] obj : SmsReportList) {
                        StringBuilder line = new StringBuilder();
                        String MobileNo=obj[6] != null ? obj[6].toString():"";
                        line.append(MobileNo).append(",");
                        String message = "Good Morning " +
                                "DAK  DP=" + (obj[2] != null ? obj[2].toString() : "") + "  " +
                                "DU=" + (obj[3] != null ? obj[3].toString() : "") + "  " +
                                "DT=" + (obj[4] != null ? obj[4].toString() : "") + " " +
                                "DD=" + (obj[5] != null ? obj[5].toString() : "") + "" +
                                "-DMS Team.";
                     // Replace any commas with spaces to avoid CSV issues
                        message = message.replaceAll(",", " ");

                        line.append(message);
                        writer.println(line.toString());
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	 
	@RequestMapping(value = "GetDakDetailsKey.htm" , method = RequestMethod.GET)
	public @ResponseBody String GetDakDetailsKey(HttpServletRequest request ,HttpSession ses) throws Exception
	{
		String Username=(String)ses.getAttribute("Username");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		long EmpId=(Long)ses.getAttribute("EmpId");

		Gson json = new Gson();
		List<Object[]> send = null;
		if (String.valueOf(request.getParameter("Keyword")).length()>0)
		send = service.GetKeywordsSearchDetailsList(request.getParameter("Keyword").toString(),EmpId,Username,LoginType);
		for(int i=0;i<send.size();i++)
		{
			for(int j=0;j<send.get(i).length;j++)
			{
				if(send.get(i)[j]==null)
				{
					send.get(i)[j]="-";
				}
			}
		}
		
		return json.toJson(send);
	}
	
	@RequestMapping(value = "GetDakDetailsSubject.htm" , method = RequestMethod.GET)
	public @ResponseBody String GetDakDetailsSubject(HttpServletRequest request ,HttpSession ses) throws Exception
	{
		String Username=(String)ses.getAttribute("Username");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		long EmpId=(Long)ses.getAttribute("EmpId");

		Gson json = new Gson();
		List<Object[]> send = null;
		if (String.valueOf(request.getParameter("Subject")).length()>0)
		send = service.GetSubjectSearchDetailsList(request.getParameter("Subject").toString(),EmpId,Username,LoginType);
		
		for(int i=0;i<send.size();i++)
		{
			for(int j=0;j<send.get(i).length;j++)
			{
				if(send.get(i)[j]==null)
				{
					send.get(i)[j]="-";
				}
			}
		}
		
		return json.toJson(send);
	}
	
	
	@CrossOrigin(origins = "*")
	@RequestMapping(value="GetAcknowledgeMembers.htm",method=RequestMethod.GET)   
	public  @ResponseBody String  GetAcknowledgeMembers(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetAcknowledgeMembers.htm"+Username);
		Gson json = new Gson();
		List <Object[]> AcknowledgeMembersData = null;
		try {
			String SelDakId=(String)req.getParameter("SelDakId");
			List<Object[]> AcknowledgeMembersList = service.GeAcknowledgeMembersList(SelDakId);
			if(AcknowledgeMembersList!=null && AcknowledgeMembersList.size()>0) {
				AcknowledgeMembersData = AcknowledgeMembersList;
			}else {
				AcknowledgeMembersData = null;
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetAcknowledgeMembers.htm "+Username, e);
			}
		return json.toJson(AcknowledgeMembersData);

	}   
	
	
	@CrossOrigin(origins = "*")
	@RequestMapping(value="GetReplyMemberName.htm",method=RequestMethod.GET)
	public  @ResponseBody String  GetReplyMemberName(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetReplyMemberName.htm"+Username);
		Gson json = new Gson();
		List <Object[]> ReplyMemberData = null;
		try {
			String replydakId=(String)req.getParameter("replydakId");
			List<Object[]> ReplyMembersList = service.GetReplyMembersList(replydakId);
			if(ReplyMembersList!=null && ReplyMembersList.size()>0) {
				ReplyMemberData = ReplyMembersList;
			}else {
				ReplyMemberData = null;
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetReplyMemberName.htm "+Username, e);
			}
		return json.toJson(ReplyMemberData);

	}
}
