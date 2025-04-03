package com.vts.dms.master.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.dms.DateTimeFormatUtil;
import com.vts.dms.master.dto.DesignationDto;
import com.vts.dms.master.dto.DivisionAssignDto;
import com.vts.dms.master.dto.GroupMasterAdd;
import com.vts.dms.master.service.MasterService;
import com.vts.dms.master.dto.VendorMasterAdd;
import com.vts.dms.master.model.MemberTypeMaster;
import com.vts.dms.master.model.NonProjectMaster;
import com.vts.dms.master.model.OtherProjectMaster;
import com.vts.dms.master.model.Source;
import com.vts.dms.master.dto.LabMasterAdd;
import com.vts.dms.master.dto.OfficerMasterAdd;
import com.vts.dms.master.dto.DivisionMasterAdd;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Controller
public class MasterController {

	@Autowired
	MasterService service;
	
	private static final Logger logger=LogManager.getLogger(MasterController.class);
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@RequestMapping(value = "DivisionMaster.htm", method = RequestMethod.GET)
	public String  DivisionMasterList(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside DivisionMasterList " +  UserId );	
		req.setAttribute("DivisionMasterList", service.DivisionMasterList());
		return "master/DivisionMasterList";
	}
	
	
	@RequestMapping (value= "LabDetails.htm", method= RequestMethod.GET)
	public String LabMasterList(HttpServletRequest req,HttpSession ses) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside LabMasterList " +  UserId );
		req.setAttribute("LabMasterList", service.LabMasterList());
		return "master/LabMasterList";
	}
	
	@RequestMapping(value="Vendor.htm", method=RequestMethod.GET)
	public String VendorMasterList(HttpServletRequest req,HttpSession ses) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside VendorMasterList " +  UserId );
		req.setAttribute("VendorMasterList", service.VendorMasterList());
		return "master/VendorMasterList";
	}
	
	
	@RequestMapping (value="Designation.htm", method= RequestMethod.GET)
	public String DesignationList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside DesignationList " +  UserId );
		req.setAttribute("Designationlist", service.DesignationList());
		return "master/DesignationMasterList";
	}

	
	@RequestMapping (value="DivisionMaster.htm", method= RequestMethod.POST)
	public String DivisionMasterAddEdit(HttpServletRequest req, HttpSession ses, HttpServletResponse res,RedirectAttributes redir) throws Exception {
		
		String Userid = (String) ses.getAttribute("Username");
		String Option= req.getParameter("sub");
		String DivisionId= req.getParameter("Did");
		logger.info(new Date() +"Inside DivisionMasterAddEdit "+ Userid);	
		try {
		if(Option.equalsIgnoreCase("add")) {
			req.setAttribute("DivisionGroupListAdd",service.DivisionGroupList());
			req.setAttribute("DivisionHeadListAdd", service.DivisionHeadList());
			return "master/DivisionMasterAdd";
		}
		else if(Option.equalsIgnoreCase("edit")) {
			req.setAttribute("DivisionMasterEditData", service.DivisionMasterEditData(DivisionId).get(0));
			req.setAttribute("DivisionGroupList",service.DivisionGroupList());
			req.setAttribute("DivisionHeadList", service.DivisionHeadList());
			return "master/DivisionMasterEdit";
		}
		else {
			
		}
		}
		catch(Exception e){
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside ItemDetailsIUpdate "+ Userid, e);
		}
		return "redirect:/DivisionMaster.htm";	
	}
	

	@RequestMapping(value="DivisionAddSubmit.htm", method= RequestMethod.POST)
	public String DivisionMasterAdd (HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception {
		String Userid = (String) ses.getAttribute("Username");
		String DivisionCode= req.getParameter("DivisionCode");
		logger.info(new Date() +" Inside DivisionMasterAdd "+Userid);
		try {
		List<String> checkdivisioncode= service.DivisionCodeCheck();
		boolean Check= checkdivisioncode.contains(DivisionCode.toUpperCase());
			if(Check) {
				redir.addAttribute("resultfail", "Division Code Already Exists");
				return "redirect:/DivisionMaster.htm";
			}
		DivisionMasterAdd add= new DivisionMasterAdd();
		add.setDivisionCode(req.getParameter("DivisionCode").toUpperCase());
		add.setDivisionName(req.getParameter("DivisionName"));
		add.setDivisionHeadName(req.getParameter("DivisionHeadName"));
		add.setGroupName(req.getParameter("GroupName"));
		Long count= 0L;
			count= service.DivisionMasterInsert(add ,Userid);	
		if(count >0) {
			redir.addAttribute("result", "Division Addedd Successfully");
		}
		else {
			redir.addAttribute("resultfail", "Division Add Unsuccessful");
		}
		}
		catch(Exception e){
				e.printStackTrace();
				redir.addAttribute("resultfail", "Technical Issue");
				logger.error(new Date() +" Inside DivisionMasterAdd "+Userid , e);
		}
		return "redirect:/DivisionMaster.htm";
	}
	
	@RequestMapping (value="DivisionMasterEditSubmit.htm" , method=RequestMethod.POST)

	public String DivisionMasterEdit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String Userid = (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside DivisionMasterEdit "+Userid );
		try {
		DivisionMasterAdd add= new DivisionMasterAdd ();
		add.setDivisionCode(req.getParameter("DivisionCode"));
		add.setDivisionName(req.getParameter("DivisionName"));
		add.setDivisionHeadName(req.getParameter("DivisionHeadName"));
		add.setGroupName(req.getParameter("GroupName"));
		add.setDivisionId(req.getParameter("DivisionId"));
		int count = service.DivisionMasterUpdate(add, Userid);
		if(count > 0 ) {
			redir.addAttribute("result", "Division Edited Successfully");
		}
		else {
			redir.addAttribute("result ", "Division Edit Unsuccessful");
		}
		}
		catch(Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside DivisionMasterEdit "+Userid , e);
		}
		return "redirect:/DivisionMaster.htm";
	}	
	
	
	@RequestMapping (value="LabDetails.htm" , method= RequestMethod.POST)
	public String LabMasterAddEdit(HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String Option =req.getParameter("sub");
		String LabId= req.getParameter("Did");
		String Userid= (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside LabMasterAddEdit "+Userid);
		try {
		if(Option.equalsIgnoreCase("add")) {
			return "master/LabMasterAdd";
		}
		else if(Option.equalsIgnoreCase("edit")) {
			req.setAttribute("LabMasterEditData", service.LabMasterEditData(LabId).get(0));
			return "master/LabMasterEdit";
		}
		}
		catch(Exception e){
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside LabMasterAddEdit "+Userid , e);
		}
		return "redirect:/LabDetails.htm";
	}
	
	
	@RequestMapping (value="LabMasterAddSubmit.htm" , method= RequestMethod.POST)
	public String LabMasterAdd (HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{
		String Userid= (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside LabMasterAdd "+Userid);
		try {
		String LabCode=req.getParameter("LabCode");
		List<String> labcodecheck= service.LabCodeCheck();
		boolean Check=labcodecheck.contains(LabCode.toUpperCase());
		if(Check) {
			redir.addAttribute("result", "Lab Code Already Exists");
		}
		LabMasterAdd labmasteradd= new LabMasterAdd();
		labmasteradd.setLabCode(req.getParameter("LabCode"));
		labmasteradd.setLabName(req.getParameter("LabName").toUpperCase());
		labmasteradd.setLabUnitCode(req.getParameter("LabUnitCode"));
		labmasteradd.setLabAddress(req.getParameter("LabAddress"));
		labmasteradd.setLabCity(req.getParameter("LabCity"));
		labmasteradd.setLabPin(req.getParameter("LabPin"));
		labmasteradd.setLabTelephone(req.getParameter("LabTelephone"));
		labmasteradd.setLabFaxNo(req.getParameter("LabFaxNo"));
		labmasteradd.setLabEmail(req.getParameter("LabEmail"));
		Long count = 0L;
		count = service.LabMasterInsert(labmasteradd);
		if(count == 0 ) {
			redir.addAttribute("result", "Lab Details Added Successfully");
		}
		else {
			redir.addAttribute("resutfail", "Lab Details Add Unsuccessful");
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside LabMasterAdd "+Userid , e);
			
		}
		return "redirect:/LabDetails.htm";
	}
	
	
	@RequestMapping(value="LabMasterEditSubmit.htm" , method= RequestMethod.POST)
	public String LabMasterEdit (HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String Userid= (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside LabMasterEdit "+Userid);
		try {
		LabMasterAdd labmasteredit = new LabMasterAdd();
		labmasteredit.setLabCode(req.getParameter("LabCode"));
		labmasteredit.setLabName(req.getParameter("LabName"));
		labmasteredit.setLabUnitCode(req.getParameter("LabUnitCode"));
		labmasteredit.setLabAddress(req.getParameter("LabAddress"));
		labmasteredit.setLabCity(req.getParameter("LabCity"));
		labmasteredit.setLabPin(req.getParameter("LabPin"));
		labmasteredit.setLabMasterId(req.getParameter("LabMasterId"));
		labmasteredit.setLabTelephone(req.getParameter("LabTelephone"));
		labmasteredit.setLabFaxNo(req.getParameter("LabFaxNo"));
		labmasteredit.setLabEmail(req.getParameter("LabEmail"));
		int count = service.LabMasterUpdate(labmasteredit);
		if(count > 0) {
			redir.addAttribute("result" , "Lab Details Edited Successfully ");
		}
		else {
			redir.addAttribute("resultfail", "Lab Details Edit Unsuccessful");
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside LabMasterEdit "+Userid , e);
		}
		return "redirect:/LabDetails.htm";
	}
	
// ***************************************VENDOR STARTS*********************************************************************
	
	@RequestMapping(value="Vendor.htm", method=RequestMethod.POST)
	public String VendorMasterAddEdit (HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside VendorMasterAddEdit "+UserId );
		try {
		String Option= req.getParameter("sub");
		String VendorId=req.getParameter("Did");
		if(Option.equalsIgnoreCase("add")) {
			return "master/VendorMasterAdd";
		}
		else if(Option.equalsIgnoreCase("edit")) {
			req.setAttribute("VendorMasterEditData", service.VendorMasterEditData(VendorId).get(0));
			return "master/VendorMasterEdit";
		}
		else {
			int count =service.VendorMasterDelete(VendorId,UserId );
			if(count >0) {
				redir.addAttribute("result","Vendor Deleted Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Vendor Delete Unsuccessful");
			}
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside VendorMasterAddEdit "+UserId , e);
		}
		return "redirect:/Vendor.htm";
	}
	
	@RequestMapping(value="VendorMasterAddSubmit.htm", method=RequestMethod.POST)
	public String VendorMasterAdd(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside VendorMasterAdd "+UserId );
		 try {
		  String VendorName = req.getParameter("VendorName"); 
		  List<String> CheckVendorName = service.VendorNameCheck();
		  boolean check = CheckVendorName.stream().anyMatch(VendorName::equalsIgnoreCase);
		  if(check) {
			  redir.addAttribute("resultfail", "Vendor Already Exists");
			  return "redirect:/Vendor.htm"; 
		  }
		VendorMasterAdd vendormasteradd = new VendorMasterAdd();
		vendormasteradd.setVendorName(req.getParameter("VendorName"));
		vendormasteradd.setAddress(req.getParameter("Address"));
		vendormasteradd.setCity(req.getParameter("City"));
		vendormasteradd.setPinCode(req.getParameter("PinCode"));
		vendormasteradd.setContactPerson(req.getParameter("ContactPerson"));
		vendormasteradd.setTelNo(req.getParameter("TelNo"));
		vendormasteradd.setFaxNo(req.getParameter("FaxNo"));
		vendormasteradd.setEmail(req.getParameter("Email"));
		vendormasteradd.setRegistrationNo(req.getParameter("RegistrationNo"));
		vendormasteradd.setRegistrationDate(req.getParameter("RegistrationDate"));
		vendormasteradd.setCPPRegisterId(req.getParameter("CPPRegisterId"));
		vendormasteradd.setProductRange(req.getParameter("ProductRange"));
		vendormasteradd.setVendorType(req.getParameter("VendorType"));
		vendormasteradd.setPanNo(req.getParameter("PanNo"));
		vendormasteradd.setGSTNo(req.getParameter("GSTNo"));
		vendormasteradd.setVendorBank(req.getParameter("VendorBank"));
		vendormasteradd.setAccountNo(req.getParameter("AccountNo"));
		String count= null;
		try {
			count= service.VendorMasterInsert(vendormasteradd,UserId);
		}
		catch(Exception e) {
			e.printStackTrace();
			return "redirect:/Vendor.htm";
		}
		if(count != null) {
			redir.addAttribute("result","Vendor Added Successfully with Vendor Code " + "\"" + count + "\"");
		}
		else {
			redir.addAttribute("resultfail", "Vendor Add Unsuccessful");
		}
		 }
		 catch (Exception e){
				e.printStackTrace();
				redir.addAttribute("resultfail", "Technical Issue");
				logger.error(new Date() +" Inside VendorMasterAdd "+UserId , e);
			}
		return "redirect:/Vendor.htm";
	}
	
	@RequestMapping(value="VendorMasterEditSubmit.htm", method=RequestMethod.POST)
	public String VendorMasterEditSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside VendorMasterEditSubmit "+UserId );
		try {
		if(req.getParameter("VendorCode").substring(0, 1).equalsIgnoreCase(req.getParameter("VendorName").substring(0, 1))){
		String VendorCode = req.getParameter("VendorCode");
		VendorMasterAdd vendormasteradd = new VendorMasterAdd();
		vendormasteradd.setVendorName(req.getParameter("VendorName"));
		vendormasteradd.setAddress(req.getParameter("Address"));
		vendormasteradd.setCity(req.getParameter("City"));
		vendormasteradd.setPinCode(req.getParameter("PinCode"));
		vendormasteradd.setContactPerson(req.getParameter("ContactPerson"));
		vendormasteradd.setTelNo(req.getParameter("TelNo"));
		vendormasteradd.setFaxNo(req.getParameter("FaxNo"));
		vendormasteradd.setEmail(req.getParameter("Email"));
		vendormasteradd.setRegistrationNo(req.getParameter("RegistrationNo"));
		vendormasteradd.setRegistrationDate(req.getParameter("RegistrationDate"));
		vendormasteradd.setCPPRegisterId(req.getParameter("CPPRegisterId"));
		vendormasteradd.setProductRange(req.getParameter("ProductRange"));
		vendormasteradd.setVendorType(req.getParameter("VendorType"));
		vendormasteradd.setPanNo(req.getParameter("PanNo"));
		vendormasteradd.setGSTNo(req.getParameter("GSTNo"));
		vendormasteradd.setVendorBank(req.getParameter("VendorBank"));
		vendormasteradd.setAccountNo(req.getParameter("AccountNo"));
		vendormasteradd.setVendorId(req.getParameter("VendorId"));

		int count = service.VendorMasterUpdate(vendormasteradd, UserId);
		if(count >0) {
			redir.addAttribute("result"," Vendor Edited Successfully With Vendor Code " + "\"" + VendorCode + "\"");
		}
		else {
			redir.addAttribute("resultfail"," Vendor Edit Unsuccessful ");
		}
		}else {
			redir.addAttribute("resultfail","VENDOR NAME FIRST LETTER SHOULD BE "+req.getParameter("VendorCode").substring(0, 1));
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside VendorMasterEditSubmit "+UserId , e);
		}
		return "redirect:/Vendor.htm";
	}
	

// ****************************************************PAYMENT ENDS****************************************************************************	

	//*********************************************************GROUP STARTS****************************************************************************
	
	@RequestMapping(value="Group.htm", method=RequestMethod.GET)
	public String GroupMasterList(HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside GroupMasterList "+UserId);
		req.setAttribute("GroupMasterList", service.GroupMasterList());
		return "master/GroupMasterList";
	}
	
	@RequestMapping(value="Group.htm", method=RequestMethod.POST)
	public String GroupMasterAddEdit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside GroupMasterAddEdit "+UserId);
		try {
		String Option=req.getParameter("sub");
		String GroupId= req.getParameter("Did");
		if(Option.equalsIgnoreCase("add")) {
			req.setAttribute("GroupMasterListAdd", service.GroupMasterListAdd());
			return "master/GroupMasterAdd";
		}
		else if(Option.equalsIgnoreCase("edit")) {
			req.setAttribute("GroupMasterEditData", service.GroupMasterEditData(GroupId).get(0));
			req.setAttribute("GroupMasterListAdd", service.GroupMasterListAdd());
			return "master/GroupMasterEdit";
		}
		else {
			
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside GroupMasterAddEdit "+UserId , e);
		}
		return "redirect:/Group.htm";
	}
	
	@RequestMapping(value="GroupMasterAddSubmit.htm", method=RequestMethod.POST)
	public String GroupMasterAddSubmit (HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		
		String UserId= (String )ses.getAttribute("Username");
		logger.info(new Date() +" Inside GroupMasterAddSubmit "+UserId);
		try {
		String GroupCode=req.getParameter("GroupCode");
		List<String> CheckGroupCode= service.CheckGroupCode();
		boolean Check= CheckGroupCode.contains(GroupCode.toUpperCase());
		if(Check)
		{
			redir.addAttribute("resultfail", "Group Code Already Exists");
			return "redirect:/Group.htm";
		}
		GroupMasterAdd groupmasteradd= new GroupMasterAdd();
		groupmasteradd.setGroupCode(req.getParameter("GroupCode").toUpperCase());
		groupmasteradd.setGroupName(req.getParameter("GroupName"));
		groupmasteradd.setGroupHead(req.getParameter("GroupHead"));
		Long count=0L;
		try {
		 count=service.GroupMasterInsert(groupmasteradd, UserId);	
		}
		catch(Exception e){
			e.printStackTrace();
			return "redirect:/Group.htm";
		}
		if(count>0) {
			redir.addAttribute("result", "Group Master Added Successfully ");
		}
		else {
			redir.addAttribute("resultfail", "Group Master Add Unsuccessful");
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside GroupMasterAddSubmit "+UserId , e);
		}
		return "redirect:/Group.htm";
	}
	
	@RequestMapping (value="GroupMasterEditSubmit.htm", method=RequestMethod.POST)
	public String GroupMasterEditSubmit (HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{
		
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside GroupMasterEditSubmit "+UserId);
		try {
		GroupMasterAdd groupmasteradd= new GroupMasterAdd();
		groupmasteradd.setGroupCode(req.getParameter("GroupCode").toUpperCase());
		groupmasteradd.setGroupName(req.getParameter("GroupName"));
		groupmasteradd.setGroupHead(req.getParameter("GroupHead"));
		groupmasteradd.setGroupId(req.getParameter("GroupId"));
		int count = service.GroupMasterUpdate(groupmasteradd,UserId);
		if(count>0) {
			redir.addAttribute("result", "Group Master Edited Successfully ");
		}
		else {
			redir.addAttribute("resultfail", "Group Master Edit UnsuccessfulL");
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside GroupMasterEditSubmit "+UserId , e);
		}
		return "redirect:/Group.htm";
	}
	
	//*********************************************************GROUP ENDS******************************************************************************
	
	@RequestMapping (value="Designation.htm", method=RequestMethod.POST)
	public String DesignationAddEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside DesignationAddEdit "+UserId);
		try {
		String option = req.getParameter("sub");
		String DesginationId= req.getParameter("Did");
		if(option.equalsIgnoreCase("add")) {
			return "master/DesignationMasterAdd";
		}
		else if(option.equalsIgnoreCase("edit")) {
			req.setAttribute("DesignationMasterEditData", service.DesignationMasterEditData(DesginationId).get(0));
			return "master/DesignationMasterEdit";
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside DesignationAddEdit "+UserId , e);
		}
		return "redirect:/Designation.htm";
	}
	
	@RequestMapping(value="DesignationAddSubmit.htm", method=RequestMethod.POST)
	public String DesignationAddSubmit (HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside DesignationAddSubmit "+UserId);
		try {
		String DesignationCode= req.getParameter("DesignationCode").toUpperCase();
		String Designation=req.getParameter("Designation");
		List<String> CheckDesignationId= service.CheckDesignationId();
		boolean check= CheckDesignationId.contains(DesignationCode);
		if(check) {
			redir.addAttribute("resultfail", "Designation Code Already Exists");
			return "redirect:/Designation.htm";
		}
		List<String> CheckDesignation=service.CheckDesignation();
		boolean checkDesignation = CheckDesignation.stream().anyMatch(Designation::equalsIgnoreCase);
		if(checkDesignation) {
			redir.addAttribute("resultfail", "Designation Already Exists");
			return "redirect:/Designation.htm";
		}
		DesignationDto designationdto = new DesignationDto();
		designationdto.setDesigCode(req.getParameter("DesignationCode").toUpperCase());
		designationdto.setDesignation(req.getParameter("Designation"));
		designationdto.setDesigLimit(req.getParameter("DesignationLimit"));
		Long count= service.DesignationInsert(designationdto);
		if(count>0) {
			redir.addAttribute("result", "Designation Added Successfully");
		}
		else {
			redir.addAttribute("resultfail", "Deignation Add Unsuccessful");
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside DesignationAddSubmit "+UserId , e);
		}
		
		return "redirect:/Designation.htm";
	}
	
	@RequestMapping(value="DesignationEditSubmit.htm", method=RequestMethod.POST)
	public String DesignationMasterEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{

		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside DesignationMasterEditSubmit "+UserId);
		try {
		String DesignationId=req.getParameter("Did");
		DesignationDto designationdto = new DesignationDto();
		designationdto.setDesigCode(req.getParameter("DesignationCode").toUpperCase());
		designationdto.setDesignation(req.getParameter("Designation"));
		designationdto.setDesigLimit(req.getParameter("DesignationLimit"));
		int count = service.DesignationUpdate(designationdto,DesignationId);
		if(count>0) {
			redir.addAttribute("result", "Designation Edited Successfully");
		}
		else {
			redir.addAttribute("resultfail","Designation Edit Unsuccessful");
		}
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside DesignationMasterEditSubmit "+UserId , e);
		}
		return "redirect:/Designation.htm";
	}
	
	
	
	@RequestMapping(value="DivisionAssign.htm")
	public String  DivisionAssign(HttpServletRequest req, HttpServletResponse res,RedirectAttributes redir, HttpSession ses) throws Exception{
		
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside DivisionAssign "+UserId);
		try {
			req.setAttribute("DivisionList", service.DivisionList());
		}
		catch (Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside DivisionAssign "+UserId , e);
		}
		return "master/DivisionAssign";
	}
	
	@RequestMapping(value = "DivisionSubmit.htm",method ={RequestMethod.POST,RequestMethod.GET})
	public String DivisionSubmit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String Username = (String) ses .getAttribute("Username");
		String DivisionId=null; 
		logger.info(new Date() +"Inside DivisionSubmit "+Username);
	try {
		if(req.getParameter("DivisionId")!=null) {
			DivisionId=(String)req.getParameter("DivisionId");
		}else {
		 Map md = model.asMap();
		    for (Object modelKey : md.keySet()) {
		    	String	RedirData = (String) md.get(modelKey);
		    	DivisionId=RedirData;
		    }
		}
		if(DivisionId==null) {
			return "redirect:/DivisionAssign.htm";
		}
		req.setAttribute("DivisionAssignList", service.DivisionAssignList(DivisionId));
		req.setAttribute("DivisionList", service.DivisionList());
		req.setAttribute("OfficerList", service.UserList());
		req.setAttribute("DivisionName", service.DivisionName(DivisionId));
		req.setAttribute("DivisionId", DivisionId);
	}
	catch (Exception e) {
		logger.error(new Date() +" Inside DivisionSubmit "+Username, e);
	}
		 return "master/DivisionAssign";
	}
	
	@RequestMapping(value = "DivisionAssignSubmit.htm", method = RequestMethod.POST)
	public String DivisionAssignSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		long count=0;
		String Username = (String) ses .getAttribute("Username");
		String DivisionId= (String)req.getParameter("DivisionId");
		String LogInId= (String)req.getParameter("LogInId");
		DivisionAssignDto divassign = new DivisionAssignDto();
		logger.info(new Date() +"Inside DivisionAssignSubmit "+Username);
	try {
		divassign.setDivisionId(DivisionId);
		divassign.setCreatedBy(Username);
		divassign.setLoginId(LogInId);
		divassign.setSerialNo("1");
		divassign.setIsActive("1");
    	count=service.DivisionAssignAdd(divassign);
    	 if(count>0) 
    	 {
			redir.addAttribute("result","Division Assigned Successfully");
    	 }else
			{
				redir.addAttribute("resultfail","Division Assign  Unsuccessful");	
			} 
    	 redir.addFlashAttribute("ProjectId", req.getParameter("ProjectId"));
	}catch (Exception e) {
		logger.error(new Date() +" Inside ProjectAssign "+Username, e);
	}
	return "redirect:/DivisionSubmit.htm";
	}
	
	// ***************************************************OFFICER STARTS*******************************************************************************
		
		@RequestMapping(value="Officer.htm", method=RequestMethod.GET)
		public String OfficerList(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{
			String UserId= (String)ses.getAttribute("Username");
			logger.info(new Date() +" Inside OfficerList "+UserId);
			req.setAttribute("OfficerList", service.OfficerList());
			return "master/OfficerMasterList";
		}
		
		@RequestMapping(value="Officer.htm", method=RequestMethod.POST)
		public String OfficerListAddEdit(HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
			String UserId= (String)ses.getAttribute("Username");
			logger.info(new Date() +" Inside OfficerList "+UserId);
			try {
			String Option=req.getParameter("sub");
			String OfficerId=req.getParameter("Did");
			if(Option.equalsIgnoreCase("add")) {
				req.setAttribute("DesignationList", service.DesignationList());
				req.setAttribute("OfficerDivisionList", service.OfficerDivisionList());
				return "master/OfficerMasterAdd";
			}else if(Option.equalsIgnoreCase("edit")) {
				req.setAttribute("OfficerEditData", service.OfficerEditData(OfficerId).get(0));
				req.setAttribute("DesignationList", service.DesignationList());
				req.setAttribute("OfficerDivisionList", service.OfficerDivisionList());
				return "master/OfficerMasterEdit";
			}else {
				int count= service.OfficerMasterDelete(OfficerId, UserId);
				if(count>0) {
					redir.addAttribute("result", "Officer Deleted Successfully ");
				}
				else {
					redir.addAttribute("resultfail","Officer Delete Unsuccessful");
				}
			}
			}
			catch (Exception e){
				e.printStackTrace();
				redir.addAttribute("resultfail", "Technical Issue");
				logger.error(new Date() +" Inside OfficerListAddEdit "+UserId , e);
			}
			return "redirect:/Officer.htm";
		}
		
		@RequestMapping (value="OfficerMasterAddSubmit.htm", method=RequestMethod.POST)
		public String OfficerAddSubmit (HttpSession ses, HttpServletRequest  req, HttpServletResponse res, RedirectAttributes redir) throws Exception{
			String UserId= (String)ses.getAttribute("Username");
			logger.info(new Date() +" Inside OfficerAddSubmit "+UserId);
			try {
			String EmpNo=req.getParameter("EmpNo");
			List<String> EmpNoCheck=service.EmpNoCheck();
			boolean check=EmpNoCheck.contains(EmpNo);
			if(check) {
				redir.addAttribute("resultfail","Emp No Already Exists" );
				return "redirect:/Officer.htm";
			}
			OfficerMasterAdd officermasteradd= new OfficerMasterAdd();
			officermasteradd.setEmpNo(req.getParameter("EmpNo"));
			officermasteradd.setEmpName(req.getParameter("EmpName"));
			officermasteradd.setDesignation(req.getParameter("Designation"));
			officermasteradd.setExtNo(req.getParameter("ExtNo"));
			officermasteradd.setEmail(req.getParameter("Email"));
			officermasteradd.setDivision(req.getParameter("Division"));
			Long count=0L;
			try {
			count= service.OfficerMasterInsert(officermasteradd, UserId);	
			}catch(Exception e){
				e.printStackTrace();
				return "redirect:/Officer.htm";
			}
			if(count>0) {
				redir.addAttribute("result", "Officer Added Successfully ");
			}
			else {
				redir.addAttribute("resultfail", "Officer Add Unsuccessful");
			}
			}
			catch (Exception e){
				e.printStackTrace();
				redir.addAttribute("resultfail", "Technical Issue");
				logger.error(new Date() +" Inside OfficerAddSubmit "+UserId , e);
			}
			return "redirect:/Officer.htm";
		}
		

		@RequestMapping (value="OfficerMasterEditSubmit.htm", method=RequestMethod.POST)
		public String OfficerMasterEditSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{
			String UserId= (String)ses.getAttribute("Username");
			logger.info(new Date() +" Inside OfficerMasterEditSubmit "+UserId);
			try {
			OfficerMasterAdd officermasteradd= new OfficerMasterAdd();
			officermasteradd.setEmpNo(req.getParameter("EmpNo"));
			officermasteradd.setEmpName(req.getParameter("EmpName"));
			officermasteradd.setDesignation(req.getParameter("Designation"));
			officermasteradd.setExtNo(req.getParameter("ExtNo"));
			officermasteradd.setEmail(req.getParameter("Email"));
			officermasteradd.setDivision(req.getParameter("Division"));
			officermasteradd.setEmpId(req.getParameter("OfficerId"));
			
			int count= service.OfficerMasterUpdate(officermasteradd, UserId);
			if(count>0) {
				redir.addAttribute("result", "Officer Edited Successfully ");
			}
			else {
				redir.addAttribute("resultfail", "Officer Edit Unsuccessful");
			}
			}
			catch (Exception e){
				e.printStackTrace();
				redir.addAttribute("resultfail", "Technical Issue");
				logger.error(new Date() +" Inside OfficerMasterEditSubmit "+UserId , e);
			}
			return "redirect:/Officer.htm";
		}

		// ***********************************OFFICER ENDS***********************************
		
		/**************SOURCE START****************/
		@RequestMapping(value = "Source.htm", method = RequestMethod.GET)
		public String  SourceMethod(HttpServletRequest req, HttpSession ses) throws Exception {
			
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +" Inside SourceMethod " +  UserId );	
			try {
				String Action=req.getParameter("sub");  
				String SourceDetailId=req.getParameter("Did");
				if(Action!=null)
				{
					req.setAttribute("SourceDropDownList", service.SourceDropDownList());
					if(Action.equalsIgnoreCase("edit"))
					{
						if(SourceDetailId!=null)
						{
							req.setAttribute("ParticularSourceDetails", service.GetParticularSourceDetails(SourceDetailId));
						}
					}
					req.setAttribute("Action", Action);
					return "master/SourceMasterAddEdit";
				}
				else
				{
					req.setAttribute("SourceMasterList", service.SourceMasterList());
					return "master/SourceMasterList";
				}
			}catch (Exception e) {
				 logger.error(new Date() + "Inside DAO SourceMethod() "+e);
					e.printStackTrace();
					return null;
			}
		}
		
		@RequestMapping(value = "SourceAddEditSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String  SourceAddEditSubmit(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception {
			String UserId = (String) ses.getAttribute("Username");
			String labCode=(String) ses.getAttribute("LabCode");
			String DivisionCode = (String) ses.getAttribute("DivisionCode");
			
			logger.info(new Date() +" Inside SourceAddEditSubmit " +  UserId );	
				String Action=req.getParameter("sub");  
				String SourceType=req.getParameter("SourceType");  
				String ShortName=req.getParameter("ShortName"); 
				String SourceName=req.getParameter("SourceName");   
				String SourceId=req.getParameter("SourceId");
				String SourceAddress=req.getParameter("SourceAddress");
				String SourceCity=req.getParameter("SourceCity");
				String SourcePinCode=req.getParameter("SourcePinCode");
				String IsDMS=req.getParameter("IsDMS");
				
				
				String APIURL=req.getParameter("APIURL");
				
				Long Status=0L;
				Source source=new Source();
				source.setSourceId(Long.parseLong(SourceType));
				source.setSourceShortName(ShortName);
				source.setSourceName(SourceName);
				source.setSourceAddress(SourceAddress);
				source.setSourceCity(SourceCity);
				source.setSourcePin(SourcePinCode);
				source.setIsDMS(IsDMS);
				source.setApiUrl(APIURL);
				source.setDivisionCode(DivisionCode);
				source.setLabCode(labCode);
				if(Action.equalsIgnoreCase("Add"))
				{
					source.setCreatedBy(UserId);
					source.setCreatedDate(sdf1.format(new Date()));
					Status=service.InsertSourceDetails(source);
					if(Status>0)
					{
						redir.addAttribute("Status", "Source SuccessFully Added..!");
					}
					else
					{
						redir.addAttribute("StatusFail", "Source Added UnSuccessful..!");
					}
				}
				else
				{
					source.setSourceDetailId(Long.parseLong(SourceId));
					source.setModifiedBy(UserId);
					source.setModifiedDate(sdf1.format(new Date()));
                    Status=service.UpdateSourceDetails(source);
                    
					if(Status>0)
					{
						redir.addAttribute("Status", "Source SuccessFully Updated..!");
					}
					else
					{
						redir.addAttribute("StatusFail", "Source Updated UnSuccessful..!");
					}
				}
			
			return "redirect:/Source.htm";
		}
		
		/**************SOURCE END****************/
		
		 @RequestMapping(value = "ShortNameUniqueCheck.htm")
			public @ResponseBody String ShortNameUniqueCheck(HttpServletRequest request,HttpSession ses) throws Exception {
				String ShortName = request.getParameter("ShortName");   
				String type = request.getParameter("type");
				int Status = service.CheckDuplicateShortName(ShortName,type);
				Gson json = new Gson();
				return json.toJson(Status);
		    }
		
		
		/**************NON-PROJECT START****************/
		@RequestMapping(value = "NonProject.htm", method = RequestMethod.GET)
		public String  NonProjectMethod(HttpServletRequest req, HttpSession ses) throws Exception {
				
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +" Inside NonProjectMethod " +  UserId );	
			try {
				String Action=req.getParameter("sub");  
				String NonProjectId=req.getParameter("Did");
				if(Action!=null)
				{
					if(Action.equalsIgnoreCase("edit"))
					{
						if(NonProjectId!=null)
						{
							req.setAttribute("ParticularNonProjectDetails", service.GetParticularNonProjectDetails(NonProjectId));
						}
					}
					req.setAttribute("Action", Action);
					return "master/NonProjectMasterAddEdit";
				}
				else
				{
					req.setAttribute("NonProjectList", service.GetNonProjectList());
					return "master/NonProjectList";
				}
				
			
			}catch (Exception e) {
				 logger.error(new Date() + "Inside DAO NonProjectMethod() "+e);
					e.printStackTrace();
					return null;
			}
		}
		
		@RequestMapping(value = "NonProjectAddEditSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String  NonProjectAddEditSubmit(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception {
			
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +" Inside NonProjectAddEditSubmit " +  UserId );	
		
				String Action=req.getParameter("sub");  
				String ShortName=req.getParameter("ShortName"); 
				String NonProjectName=req.getParameter("NonProjectName");   
				String NonProjectId=req.getParameter("NonProjectId");
				Long Status=0L;
				NonProjectMaster nonProject=new NonProjectMaster();
				nonProject.setNonShortName(ShortName);
				nonProject.setNonProjectName(NonProjectName);
				if(Action.equalsIgnoreCase("Add"))
				{
					nonProject.setCreatedBy(UserId);
					nonProject.setCreatedDate(sdf1.format(new Date()));
					nonProject.setIsActive(1);
					
					Status=service.InsertNonProjectDetails(nonProject);
					
					if(Status>0)
					{
						redir.addAttribute("Status", "Non-Project SuccessFully Added..!");
					}
					else
					{
						redir.addAttribute("StatusFail", "Non-Project Added UnSuccessFul..!");
					}
				}
				else
				{
					nonProject.setNonProjectId(Long.parseLong(NonProjectId));
					nonProject.setModifiedBy(UserId);
					nonProject.setModifiedDate(sdf1.format(new Date()));
                    Status=service.UpdateNonProjectDetails(nonProject);
					if(Status>0)
					{
						redir.addAttribute("Status", "Non-Project SuccessFully Updated..!");
					}
					else
					{
						redir.addAttribute("StatusFail", "Non-Project Updated UnSuccessFul..!");
					}
				}
			
			return "redirect:/NonProject.htm";
		}
		
		/**************NON-PROJECT END****************/
		
		
		/**************OTHER-PROJECT START****************/
		@RequestMapping(value = "OtherProject.htm", method = RequestMethod.GET)
		public String  OtherProjectMethod(HttpServletRequest req, HttpSession ses) throws Exception {
			
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +" Inside OtherProjectMethod " +  UserId );	
			try {
				String Action=req.getParameter("sub");  
				String OtherProjectId=req.getParameter("Did");
				if(Action!=null)
				{
					if(Action.equalsIgnoreCase("edit"))
					{
						if(OtherProjectId!=null)
						{
							req.setAttribute("ParticularOtherProjectDetails", service.GetParticularOtherProjectDetails(OtherProjectId));
						}
					}
					req.setAttribute("Action", Action);
					return "master/OtherProjectAddEdit";
				}
				else
				{
					req.setAttribute("OtherProjectList", service.GetOtherProjectList());
					return "master/OtherProjectList";
				}
			}catch (Exception e) {
				 logger.error(new Date() + "Inside DAO OtherProjectMethod() "+e);
					e.printStackTrace();
					return null;
			}
		}
		
		@RequestMapping(value = "OtherProjectAddEditSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String  OtherProjectAddEditSubmit(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception {
			
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +" Inside OtherProjectAddEditSubmit " +  UserId );	
		
				String Action=req.getParameter("sub");  
				String ProjectCode=req.getParameter("ProjectCode"); 
				String ShortName=req.getParameter("ShortName"); 
				String OtherProjectName=req.getParameter("OtherProjectName");  
				String LabCode=req.getParameter("LabCode"); 
				String OtherProjectId=req.getParameter("OtherProjectId");
				Long Status=0L;
				OtherProjectMaster OtherProject=new OtherProjectMaster();
				OtherProject.setProjectCode(ProjectCode);
				OtherProject.setProjectShortName(ShortName);
				OtherProject.setProjectName(OtherProjectName);
				OtherProject.setLabCode(LabCode);
				if(Action.equalsIgnoreCase("Add"))
				{
					OtherProject.setIsActive(1);
					OtherProject.setCreatedBy(UserId);
					OtherProject.setCreatedDate(sdf1.format(new Date()));
					Status=service.InsertOtherProjectDetails(OtherProject);
					if(Status>0)
					{
						redir.addAttribute("Status", "Other-Project SuccessFully Added..!");
					}
					else
					{
						redir.addAttribute("StatusFail", "Other-Project Added UnSuccessFul..!");
					}
				}
				else
				{
					OtherProject.setProjectOtherId(Long.parseLong(OtherProjectId));
					OtherProject.setModifiedBy(UserId);
					OtherProject.setModifiedDate(sdf1.format(new Date()));
                    Status=service.UpdateOtherProjectDetails(OtherProject);
					if(Status>0)
					{
						redir.addAttribute("Status", "Other-Project SuccessFully Updated..!");
					}
					else
					{
						redir.addAttribute("StatusFail", "Other-Project Updated UnSuccessFul..!");
					}
				}
			return "redirect:/OtherProject.htm";
		}
		
		/**************OTHER-PROJECT END****************/
		
		/**************MEMBER TYPE	 START****************/
		@RequestMapping(value = "MemberType.htm", method = RequestMethod.GET)
		public String  MemberTypeMethod(HttpServletRequest req, HttpSession ses) throws Exception {
			
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +" Inside MemberTypeMethod " +  UserId );	
			try {
				String Action=req.getParameter("sub");  
				String MemberTypeId=req.getParameter("Did");
				if(Action!=null)
				{
					if(Action.equalsIgnoreCase("edit"))
					{
						if(MemberTypeId!=null)
						{
							req.setAttribute("ParticularMemberTypeDetails", service.GetParticularMemberTypeDetails(MemberTypeId));
						}
					}
					req.setAttribute("Action", Action);
					return "master/MemberTypeAddEdit";
				}
				else
				{
					req.setAttribute("MemberTypeList", service.GetMemberTypeList());
					return "master/MemberTypeList";
				}
			}catch (Exception e) {
				 logger.error(new Date() + "Inside DAO MemberTypeMethod() "+e);
					e.printStackTrace();
					return null;
			}
		}
		
		@RequestMapping(value = "MemberTypeAddEditSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String  MemberTypeAddEditSubmit(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception {
			
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +" Inside MemberTypeAddEditSubmit " +  UserId );	
		
				String Action=req.getParameter("sub");  
				String MemberType=req.getParameter("MemberType"); 
				String MemberTypeId=req.getParameter("MemberTypeId");
				String Grouping=req.getParameter("Grouping");
				System.out.println("Grouping*****"+Grouping);
				Long Status=0L;
				MemberTypeMaster membertype=new MemberTypeMaster();
				membertype.setDakMemberType(MemberType);
				membertype.setMemberTypeGrouping(Grouping);
				if(Action.equalsIgnoreCase("Add"))
				{
					membertype.setCreatedBy(UserId);
					membertype.setCreatedDate(sdf1.format(new Date()));
					
					Status=service.InsertMemberTypeDetails(membertype);
					
					if(Status>0)
					{
						redir.addAttribute("Status", "MemberType SuccessFully Added..!");
					}
					else
					{
						redir.addAttribute("StatusFail", "MemberType Added UnSuccessFul..!");
					}
				}
				else
				{
					membertype.setDakMemberTypeId(Long.parseLong(MemberTypeId));
					membertype.setModifiedBy(UserId);
					membertype.setModifiedDate(sdf1.format(new Date()));
					
                     Status=service.UpdateMemberTypeDetails(membertype);
					
					if(Status>0)
					{
						redir.addAttribute("Status", "MemberType SuccessFully Updated..!");
					}
					else
					{
						redir.addAttribute("StatusFail", "MemberType Updated UnSuccessFul..!");
					}
				}
			
			return "redirect:/MemberType.htm";
		}
		
		/**************MEMBER TYPE END****************/
}

