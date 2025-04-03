package com.vts.dms.header.controller;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.dms.header.service.HeaderService;
import com.vts.dms.report.service.ReportService;

@Controller
public class HeaderController {
	private static final Logger logger=LogManager.getLogger(HeaderController.class);

	@Autowired
	HeaderService service;
	
	@Autowired
	ReportService Reportservice;
	
	@Autowired
    private Environment env;
	
	@RequestMapping(value = "HeaderModuleList.htm" , method = RequestMethod.GET)
	public @ResponseBody String HeaderModuleList(HttpServletRequest request ,HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside HeaderModuleList " );
		String FormRole = ((Long) ses.getAttribute("FormRole")).toString();
		    List<Object[]> HeaderModuleList = service.FormModuleList(FormRole);
		    Gson json = new Gson();
			return json.toJson(HeaderModuleList);
	}
	

	
	@RequestMapping(value = "LoginTypeChange.htm", method = RequestMethod.POST)
	public String LoginTypeChange(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		logger.info(new Date() +" Inside LoginTypeChange " );
		ses.setAttribute("LoginAs", req.getParameter("loginTypeDms"));
		String LoginType = (String) ses.getAttribute("LoginTypeDms");
		  req.setAttribute("loginTypeList", service.loginTypeList(LoginType));
	  	  return "static/MainDashBoard";
	}
	
	
	@RequestMapping(value = "NotificationList.htm" , method = RequestMethod.GET)
	public @ResponseBody String NotificationList(HttpServletRequest request ,HttpSession ses) throws Exception {
		    logger.info(new Date() +" Inside NotificationList " );
		    String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
		    List<Object[]> NotificationList = service.NotificationList(EmpId);
		    Gson json = new Gson();
			return json.toJson(NotificationList);
		
		
	}
	
	
	
	@RequestMapping(value = "NotificationUpdate.htm" , method = RequestMethod.GET)
	public @ResponseBody String NotificationUpdate(HttpServletRequest request ,HttpSession ses) throws Exception {
		Gson json = new Gson();
		int count=0;
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside NotificationUpdate.htm "+UserId);		
		try {
			String NotificationId=request.getParameter("notificationid");
			String notificationurl=request.getParameter("notificationurl");
			String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
		   count= service.NotificationUpdate(notificationurl,EmpId);
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside NotificationUpdate.htm "+UserId, e);
		}
			return json.toJson(count);
	}
	
	
	@RequestMapping(value = "NotificationListView.htm", method = RequestMethod.GET)
	public String  NotificationListView(HttpServletRequest req,HttpSession ses) throws Exception {
		logger.info(new Date() +" Inside NotificationListView " );
		String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
		req.setAttribute("NotificationList", service.NotificationAllList(EmpId));
		return "admin/NotificationListView";
	}
	
	@RequestMapping(value = "EmpNameHeader.htm" , method = RequestMethod.GET)
	public @ResponseBody String EmpNameHeader(HttpServletRequest request ,HttpSession ses) throws Exception {
			logger.info(new Date() +" Inside EmpNameHeader " );
			String LoginId= ((Long) ses.getAttribute("LoginId")).toString();
			Object[] EmpNameHeader= service.EmployeeDetailes(LoginId).get(0);
		    Gson json = new Gson();
			return json.toJson(EmpNameHeader);
	}
	
	@RequestMapping(value = "DivisionNameHeader.htm" , method = RequestMethod.GET)
	public @ResponseBody String DivisionNameHeader(HttpServletRequest request ,HttpSession ses) throws Exception {
		   logger.info(new Date() +" Inside DivisionNameHeader " );
		   String Division= ((Long) ses.getAttribute("DivisionId")).toString();
		   String DivisionName= service.DivisionName(Division);
		   Gson json = new Gson();
		   return json.toJson(DivisionName);
	}
	
	
	@RequestMapping(value = "DmsInstruction.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void  DmsInstruction(HttpServletRequest req,HttpSession ses,HttpServletResponse res) throws Exception {
		logger.info(new Date() +" Inside DmsInstruction.htm " );
	        Path path=Paths.get(env.getProperty("file_upload_path"), "UserManual","DMSusermanual.pdf");
	        res.setContentType("application/pdf");
			res.setHeader("Content-Disposition", String.format("inline; filename=DMSusermanual.pdf"));
	        
			File my_file = path.toFile();

			OutputStream out = res.getOutputStream();
			FileInputStream in = new FileInputStream(my_file);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			in.close();
			out.flush();
			out.close();
	}
	
	@RequestMapping(value = "DmsPpt.htm",  method = {RequestMethod.GET,RequestMethod.POST})
	public void  DmsPpt(HttpServletRequest req,HttpSession ses,HttpServletResponse res) throws Exception {
		logger.info(new Date() +" Inside DmsPpt.htm " );
		    Path path=Paths.get(env.getProperty("file_upload_path"), "UserManual","DMSpptpresentation.pdf");
		    res.setContentType("application/pdf");
			res.setHeader("Content-Disposition", String.format("inline; filename=DMSpptpresentation.pdf"));
	        
			File my_file = path.toFile();

			OutputStream out = res.getOutputStream();
			FileInputStream in = new FileInputStream(my_file);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			in.close();
			out.flush();
			out.close();
	}
	
	@RequestMapping(value = "DmsWorkFlow.htm",  method = {RequestMethod.GET,RequestMethod.POST})
	public void  DmsWorkFlow(HttpServletRequest req,HttpSession ses,HttpServletResponse res) throws Exception {
		logger.info(new Date() +" Inside DmsWorkFlow.htm " );
		    Path path=Paths.get(env.getProperty("file_upload_path"), "UserManual","dakworkflow.pdf");
		    res.setContentType("application/pdf");
			res.setHeader("Content-Disposition", String.format("inline; filename=dakworkflow.pdf"));
	        
			File my_file = path.toFile();

			OutputStream out = res.getOutputStream();
			FileInputStream in = new FileInputStream(my_file);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			in.close();
			out.flush();
			out.close();
	}
	
	@RequestMapping(value = "DmsSms.htm",  method = {RequestMethod.GET,RequestMethod.POST})
	public void  DmsSms(HttpServletRequest req,HttpSession ses,HttpServletResponse res) throws Exception {
		logger.info(new Date() +" Inside DmsSms.htm " );
		    Path path=Paths.get(env.getProperty("file_upload_path"), "UserManual","DMS_SMS Report.pdf");
		    res.setContentType("application/pdf");
			res.setHeader("Content-Disposition", String.format("inline; filename=DakSMSReport.pdf"));
	        
			File my_file = path.toFile();

			OutputStream out = res.getOutputStream();
			FileInputStream in = new FileInputStream(my_file);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			in.close();
			out.flush();
			out.close();
	}
	
	@RequestMapping(value = "SmartSearch.htm" ,  method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String SmartSearch(HttpServletRequest request ,HttpSession ses) throws Exception
	{
		Gson json = new Gson();
		List<Object[]> send = null;
		String input=String.valueOf(request.getParameter("search"));
		input = input.replace(" ", "");
		if (String.valueOf(request.getParameter("search")).length()>0)
		send = service.getFormNameByName(input);
		return json.toJson(send);
	}
	
	@RequestMapping(value = "searchForRole.htm" ,  method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String searchForRole(HttpServletRequest request ,HttpSession ses) throws Exception
	{
		Gson json = new Gson();
		Boolean send = null;
		if (String.valueOf(request.getParameter("search")).length()>0)
		send = service.getRoleAccess(ses.getAttribute("LoginType").toString(),String.valueOf(request.getParameter("search")));
		System.out.println(ses.getAttribute("LoginType").toString());
		return json.toJson(send);
	}
	
	@RequestMapping(value = "dakidtargets.htm" ,  method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String dakidtargets(HttpServletRequest request ,HttpSession ses) throws Exception
	{
		String Username=(String)ses.getAttribute("Username");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		long EmpId=(Long)ses.getAttribute("EmpId");
		System.out.println(request.getParameter("DakNoVal").toString()+EmpId+Username+LoginType);

		Gson json = new Gson();
		List<Object[]> send = null;
		if (String.valueOf(request.getParameter("DakNoVal")).length()>0)
		send = Reportservice.GetDakNoSearchDetailsList(request.getParameter("DakNoVal").toString(),EmpId,Username,LoginType);
		
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
		
		System.out.println(request.getParameter("DakNoVal").toString());
		return json.toJson(send);
	}
	
	@RequestMapping(value = "GetDakDetailsRefNo.htm" ,  method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String GetDakDetailsRefNo(HttpServletRequest request ,HttpSession ses) throws Exception
	{
		String Username=(String)ses.getAttribute("Username");
		String LoginType=(String)ses.getAttribute("LoginTypeDms");
		long EmpId=(Long)ses.getAttribute("EmpId");
		System.out.println(request.getParameter("RefNoValue").toString()+EmpId+Username+LoginType);

		Gson json = new Gson();
		List<Object[]> send = null;
		if (String.valueOf(request.getParameter("RefNoValue")).length()>0)
		send = Reportservice.GetRefNoSearchDetailsList(request.getParameter("RefNoValue").toString(),EmpId,Username,LoginType);
		
		if(send!=null) {
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
		}
		System.out.println(request.getParameter("RefNoValue").toString());
		return json.toJson(send);
	}
	
}
