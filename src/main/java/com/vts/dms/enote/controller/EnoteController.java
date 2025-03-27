package com.vts.dms.enote.controller;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.vts.dms.enote.dto.DakLetterDocDto;
import com.vts.dms.enote.dto.EnoteDto;
import com.vts.dms.enote.dto.EnoteRosoDto;
import com.vts.dms.enote.model.DakLetterDoc;
import com.vts.dms.enote.model.Enote;
import com.vts.dms.enote.model.EnoteRosoModel;
import com.vts.dms.enote.service.EnoteService;
import com.vts.dms.master.service.MasterService;
import com.vts.dms.CharArrayWriterResponse;
import com.vts.dms.DmsFileUtils;
import com.vts.dms.dak.dto.DakAssignReplyDto;
import com.vts.dms.dak.dto.DakReplyDto;
import com.vts.dms.dak.model.DakMain;
import com.vts.dms.dak.service.DakService;


@Controller
public class EnoteController {

	private static final Logger logger=LogManager.getLogger(EnoteController.class);
	
	@Autowired
	EnoteService service;
	
	@Autowired
	DakService dakservice;
	
	@Autowired
	MasterService masterservice;
	
	@Autowired
	DmsFileUtils dmsutils;
	
	@Autowired
    private Environment env;
	
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	private  SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
	private SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	
	
	
	
	@RequestMapping(value = "EnoteAdd.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String EnoteAdd(HttpServletRequest req, HttpSession ses) throws Exception {
		
		long divid=(long)ses.getAttribute("DivisionId");
		long EmpId=(Long)ses.getAttribute("EmpId");
		long value=0;
		logger.info(new Date() +"EnoteAdd.htm "+req.getUserPrincipal().getName());
		try {
			
		String LabCode = (String) ses.getAttribute("LabCode");
		List<Object[]> InitiatedByEmployeeList=service.InitiatedByEmployeeList(divid,LabCode);
		req.setAttribute("InitiatedByEmployeeList", InitiatedByEmployeeList);
		req.setAttribute("SourceList",dakservice.SourceList());
		req.setAttribute("EmployeeId", EmpId);
		req.setAttribute("Action", "add");
		req.setAttribute("AttachmentCount", value);
		return "Enote/EnoteAdd";
		}catch( Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" EnoteAdd.htm "+req.getUserPrincipal().getName(), e);
			return "static/Error";	
		}
	}
	
	
	@RequestMapping(value = "EnoteEdit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String EnoteEdit(HttpServletRequest req, HttpSession ses) throws Exception {
		long divid=(long)ses.getAttribute("DivisionId");
		logger.info(new Date() +"EnoteEdit.htm "+req.getUserPrincipal().getName());
		try {
		String LabCode = (String) ses.getAttribute("LabCode");
		String eNoteId=req.getParameter("eNoteId");
		Enote EnoteEditData=service.EnoteEditData(Long.parseLong(eNoteId));
		if(EnoteEditData.getIsDak().equalsIgnoreCase("N")) {
		List<Object[]> InitiatedByEmployeeList=service.InitiatedByEmployeeList(divid,LabCode);
		List<Object[]> ReturnRemarks=service.ReturnRemarks(eNoteId);
		req.setAttribute("ReturnRemarks", ReturnRemarks);
		req.setAttribute("SourceList",dakservice.SourceList());
		req.setAttribute("InitiatedByEmployeeList", InitiatedByEmployeeList);
		long AttachmentCount=service.AttachmentCount(Long.parseLong(eNoteId));
		req.setAttribute("AttachmentCount", AttachmentCount);
		req.setAttribute("EnoteEditData", EnoteEditData);
		req.setAttribute("Action", "Edit");
		return "Enote/EnoteAdd";
		}else {
			List<Object[]> EnoteAssignReplyAttachmentData =new ArrayList<Object[]>();
			long InitiatedEmp=Long.parseLong(EnoteEditData.getInitiatedBy().toString());
			if(EnoteEditData.getEnoteFrom()!=null && EnoteEditData.getEnoteFrom().equalsIgnoreCase("C")) {
			    EnoteAssignReplyAttachmentData = dakservice.EnoteAssignReplyAttachmentData(Long.parseLong(EnoteEditData.getDakId().toString()));
			}else if(EnoteEditData.getEnoteFrom()!=null && EnoteEditData.getEnoteFrom().equalsIgnoreCase("M")) {
				EnoteAssignReplyAttachmentData = dakservice.EnoteMarkerReplyAttachmentData(Long.parseLong(EnoteEditData.getDakReplyId().toString()));
			}
			req.setAttribute("EnoteAssignReplyAttachmentData", EnoteAssignReplyAttachmentData);
			req.setAttribute("EnoteEditData", EnoteEditData);
			List<Object[]> DakENoteReplyReturnRemarks=service.DakENoteReplyReturnRemarks(eNoteId);
			req.setAttribute("DakENoteReplyReturnRemarks", DakENoteReplyReturnRemarks);
			req.setAttribute("SourceList",dakservice.SourceList());
			Object DivisionId=dakservice.getDivisionId(InitiatedEmp);
			long divisionId=Long.parseLong(DivisionId.toString());
			List<Object[]> InitiatedByEmployeeList=service.InitiatedByEmployeeList(divisionId,LabCode);
			req.setAttribute("InitiatedByEmployeeList", InitiatedByEmployeeList);
			req.setAttribute("Action", "DakEnoteEdit");
			return "Enote/DakEnoteEdit";
		}
		}catch( Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" EnoteEdit.htm "+req.getUserPrincipal().getName(), e);
			return "static/Error";	
		}
		

	}
	
	
	@RequestMapping(value = "ENoteList.htm" , method = {RequestMethod.GET,RequestMethod.POST})
	public String ENoteList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) throws Exception {
		logger.info(new Date() +"ENoteList.htm"+req.getUserPrincipal().getName());
		String Username=(String)ses.getAttribute("Username");
		long EmpId=(Long)ses.getAttribute("EmpId");
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
			Object[] MailSentDetails=dakservice.MailSentDetails("D");
			//List<Object[]> MailReceivedEmpDetails=dakservice.MailReceivedEmpDetails(EmpId);
			req.setAttribute("MailSentDetails", MailSentDetails);
			//req.setAttribute("MailReceivedEmpDetails", MailReceivedEmpDetails);
			req.setAttribute("frmDt", fromDate);
			req.setAttribute("toDt",   toDate);
			req.setAttribute("EnoteList", service.EnoteList(fromDate,toDate,Username,EmpId));
			return "Enote/EnoteList";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	@RequestMapping(value= "EnoteAddSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String EnoteAddSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir, @RequestPart(name = "dakEnoteDocument", required = false) MultipartFile[] dakEnoteDocument) throws Exception {
		logger.info(new Date() +"EnoteAddSubmit.htm"+req.getUserPrincipal().getName());
		String LabCode = (String) ses.getAttribute("LabCode");
		long result=0;
		String DivisionCode = (String) ses.getAttribute("DivisionCode");
		try {
			
			String NoteNo=req.getParameter("NoteNo");
			String RefNo=req.getParameter("RefNo");
			String RefDate=req.getParameter("RefDate");
			String Subject=req.getParameter("Subject").replaceAll("\\s+", " ");
			String Comment=req.getParameter("Comment");
			String InitiatedBy=req.getParameter("InitiatedBy");
			String type=req.getParameter("type");
			String letterDate=req.getParameter("LetterDate");
			String DestinationId=req.getParameter("DestinationId");
			String DestinationTypeId=req.getParameter("DestinationTypeId");
			String DraftContent=req.getParameter("DraftContent");
			String Signatory=req.getParameter("Signatory");
			String LetterHead=req.getParameter("LetterHead");
			String IsDraftVal=req.getParameter("IsDraftVal");
			
			Enote enote=new Enote();
			enote.setNoteNo(NoteNo);
			enote.setRefNo(RefNo);
			enote.setRefDate(new java.sql.Date(sdf.parse(RefDate).getTime()));
			enote.setSubject(Subject);
			enote.setComment(Comment);
			enote.setEnoteStatusCode("INI");
			enote.setEnoteStatusCodeNext("INI");
			enote.setLabCode(LabCode);
			enote.setEnoteType(type);
			enote.setIsDak("N");
			enote.setInitiatedBy(Long.parseLong(InitiatedBy));	
			enote.setIsDraft(IsDraftVal);
			if(IsDraftVal!=null && IsDraftVal.equalsIgnoreCase("Y")) {
			enote.setLetterDate(new java.sql.Date(sdf.parse(letterDate).getTime()));
			enote.setDestinationId(Long.parseLong(DestinationId));
			enote.setDestinationTypeId(Long.parseLong(DestinationTypeId));
			enote.setDraftContent(DraftContent);
			enote.setSignatory(Long.parseLong(Signatory));
			enote.setLetterHead(LetterHead);
			}
			enote.setDivisionCode(DivisionCode);
			enote.setCreatedBy(req.getUserPrincipal().getName());
			enote.setCreatedDate(sdf1.format(new Date()));
			enote.setIsActive(1);
			EnoteDto dto=EnoteDto.builder().enote(enote).dakEnoteDocument(dakEnoteDocument).build();
			
			result=service.InsertEnote(dto,LabCode);
			if(result >0) {
				redir.addAttribute("eNoteId", result);
				redir.addAttribute("IntiatePreview", "AddEdit");
				redir.addAttribute("EnoteRoSoEdit", "EnoteRoSoAdd");
				return "redirect:/EnotePreview.htm";
			}
			else {
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"EnoteAddSubmit.htm"+e);
			return null;
		}
		return "Enote/EnotePreview";
	}
	
	@RequestMapping(value= "EnoteEditSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String EnoteEditSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir, @RequestPart(name = "dakEnoteDocument", required = false) MultipartFile[] dakEnoteDocument) throws Exception {
		logger.info(new Date() +"EnoteEditSubmit.htm"+req.getUserPrincipal().getName());
		long result=0;
		try {
			String NoteNo=req.getParameter("NoteNo");
			String RefNo=req.getParameter("RefNo");
			String RefDate=req.getParameter("RefDate");
			String Subject=req.getParameter("Subject").replaceAll("\\s+", " ");
			String Comment=req.getParameter("Comment");
			String InitiatedBy=req.getParameter("InitiatedBy");
			String EditenoteId=req.getParameter("EditenoteId");
			String type=req.getParameter("type");
			String letterDate=req.getParameter("LetterDate");
			String DestinationId=req.getParameter("DestinationId");
			String DestinationTypeId=req.getParameter("DestinationTypeId");
			String DraftContent=req.getParameter("DraftContent");
			String Signatory=req.getParameter("Signatory");
			String LetterHead=req.getParameter("LetterHead");
			String IsDraftVal=req.getParameter("IsDraftVal");
			
			EnoteDto dto=new EnoteDto();
			dto.setEnoteId(Long.parseLong(EditenoteId));
			dto.setNoteNo(NoteNo);
			dto.setRefNo(RefNo);
			dto.setRefDate(new java.sql.Date(sdf.parse(RefDate).getTime()));
			dto.setSubject(Subject);
			dto.setComment(Comment);
			dto.setInitiatedBy(Long.parseLong(InitiatedBy));	
			dto.setEnoteType(type);
			dto.setIsDak("N");
			dto.setIsDraft(IsDraftVal);
			if(IsDraftVal!=null && IsDraftVal.equalsIgnoreCase("Y")) {
			dto.setLetterDate(new java.sql.Date(sdf.parse(letterDate).getTime()));
			dto.setDestinationId(Long.parseLong(DestinationId));
			dto.setDestinationTypeId(Long.parseLong(DestinationTypeId));
			dto.setLetterHead(LetterHead);
			dto.setDraftContent(DraftContent);
			dto.setSignatory(Long.parseLong(Signatory));
			}
			dto.setModifiedBy(req.getUserPrincipal().getName());
			dto.setModifiedDate(sdf1.format(new Date()));
			EnoteDto.EnoteDtoBuilder builder = EnoteDto.builder()
				    .EnoteId(dto.getEnoteId())
				    .NoteNo(dto.getNoteNo())
				    .RefNo(dto.getRefNo())
				    .RefDate(dto.getRefDate())
				    .Subject(dto.getSubject())
				    .Comment(dto.getComment())
				    .InitiatedBy(dto.getInitiatedBy())
				    .EnoteType(dto.getEnoteType())
				    .IsDak(dto.getIsDak())
				    .ModifiedBy(dto.getModifiedBy())
				    .ModifiedDate(dto.getModifiedDate())
				    .dakEnoteDocument(dakEnoteDocument);

				// Conditionally set draft-related fields
				if (IsDraftVal != null && IsDraftVal.equalsIgnoreCase("Y")) {
				    builder
				        .DestinationId(dto.getDestinationId())
				        .DestinationTypeId(dto.getDestinationTypeId())
				        .LetterDate(dto.getLetterDate())
				        .DraftContent(dto.getDraftContent())
				        .Signatory(dto.getSignatory())
				        .LetterHead(dto.getLetterHead());
				}

				// Build the DTO
				dto = builder.build();
			result=service.UpdateEnote(dto);	
			
			if(result >0) {
				redir.addAttribute("eNoteId", result);
				redir.addAttribute("IntiatePreview", "AddEdit");
				redir.addAttribute("EnoteRoSoEdit", "EnoteRoSoEdit");
				return "redirect:/EnotePreview.htm";
			}
			else {
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"EnoteEditSubmit.htm"+e);
			return null;
		}
		return "Enote/EnotePreview";
	}
	
	
	
	@RequestMapping(value= "EnoteForwardSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String EnoteForwardSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir) throws Exception {
		logger.info(new Date() +"EnoteForwardSubmit.htm"+req.getUserPrincipal().getName());
		long EmpId=(Long)ses.getAttribute("EmpId");
		long result=0;
		String Action=req.getParameter("Action");
		String RedirectName=req.getParameter("RedirectName");
		String redirval=req.getParameter("redirval");
		try {
			
			String finalRemarks=null;
			String remarks=req.getParameter("remarks");
			String SkipApproval=req.getParameter("SkipApproval");
			String ActionSave=req.getParameter("save");
			if(SkipApproval!=null) {
				finalRemarks=SkipApproval+" "+remarks;
			}else {
				finalRemarks=remarks;
			}
			String EnoteRoSoId=req.getParameter("EnoteRoSoId");
			String IntiatePreview=req.getParameter("IntiatePreview");
			String InitiatedByEmpId=req.getParameter("InitiatedByEmpId");
			String ViewFrom=req.getParameter("ViewFrom");
			String Rec1Role=req.getParameter("Rec1Role");
			String Rec2Role=req.getParameter("Rec2Role");
			String Rec3Role=req.getParameter("Rec3Role");
			String ExtRole=req.getParameter("ExtRole");
			String SancRole=req.getParameter("SancRole");
			String ExternalOfficer=req.getParameter("ExternalOfficer");
			String LabCode=req.getParameter("LabCode");
			String ApprovalDate=req.getParameter("ApprovalDate");
			String ApprovalExternalOfficer=req.getParameter("ApprovalExternalOfficer");
			String EnoteRoSoEdit=req.getParameter("EnoteRoSoEdit");
			
			EnoteDto dto=new EnoteDto();
			
			if(req.getParameter("RecommendingOfficer1")!=null && !req.getParameter("RecommendingOfficer1").equalsIgnoreCase("")) {
			dto.setRecommend1(Long.parseLong(req.getParameter("RecommendingOfficer1")));
			}
			if(req.getParameter("RecommendingOfficer2")!=null && !req.getParameter("RecommendingOfficer2").equalsIgnoreCase("")) {
			dto.setRecommend2(Long.parseLong(req.getParameter("RecommendingOfficer2")));
			}
			if(req.getParameter("RecommendingOfficer3")!=null && !req.getParameter("RecommendingOfficer3").equalsIgnoreCase("")) {
			dto.setRecommend3(Long.parseLong(req.getParameter("RecommendingOfficer3")));
			}
			if(req.getParameter("SanctioningOfficer")!=null && !req.getParameter("SanctioningOfficer").equalsIgnoreCase("")) {
			dto.setApprovingOfficer(Long.parseLong(req.getParameter("SanctioningOfficer")));
			}
			if(ApprovalDate!=null && !ApprovalDate.equalsIgnoreCase("")) {
			dto.setApprovalDate(ApprovalDate);
			}
			if(ApprovalExternalOfficer!=null) {
			dto.setApprovalExternalOfficer(ApprovalExternalOfficer);
			}
			if(Rec1Role!=null && !Rec1Role.equalsIgnoreCase("")) {
				dto.setRec1_Role(Rec1Role);
			}
			if(Rec2Role!=null && !Rec2Role.equalsIgnoreCase("")) {
				dto.setRec2_Role(Rec2Role);
			}
			if(Rec3Role!=null && !Rec3Role.equalsIgnoreCase("")) {
				dto.setRec3_Role(Rec3Role);
			}
			if(ExtRole!=null && !ExtRole.equalsIgnoreCase("")) {
				dto.setExternal_Role(ExtRole);
			}
			if(SancRole!=null && !SancRole.equalsIgnoreCase("")) {
				dto.setApproving_Role(SancRole);
			}
			if(ExternalOfficer!=null && !ExternalOfficer.equalsIgnoreCase("")) {
				dto.setExternalOfficer(Long.parseLong(ExternalOfficer));
			}
			if(LabCode!=null && !LabCode.equalsIgnoreCase("")) {
				dto.setLabCode(LabCode);
			}
			dto.setEnoteId(Long.parseLong(req.getParameter("eNoteId")));
			dto.setActionsave(ActionSave);
			result=service.forwardeNote(dto,EmpId,Action,finalRemarks,RedirectName);
			
			if(IntiatePreview!=null && IntiatePreview.equalsIgnoreCase("AddEdit") && EnoteRoSoEdit!=null && EnoteRoSoEdit.equalsIgnoreCase("EnoteRoSoAdd")) {
				if(EnoteRoSoId!=null && !EnoteRoSoId.equalsIgnoreCase("")) {
					EnoteRosoDto enote1=new EnoteRosoDto();
					enote1.setEnoteRoSoId(Long.parseLong(EnoteRoSoId));
					enote1.setInitiatingEmpId(Long.parseLong(InitiatedByEmpId));
					enote1.setRO1(Long.parseLong(req.getParameter("RecommendingOfficer1").toString()));
					enote1.setRO1_Role(Rec1Role);
					if(req.getParameter("RecommendingOfficer2")!=null && !req.getParameter("RecommendingOfficer2").equalsIgnoreCase("")) {
						enote1.setRO2(Long.parseLong(req.getParameter("RecommendingOfficer2")));
					}
					if(Rec2Role!=null && !Rec2Role.equalsIgnoreCase("")) {
						enote1.setRO2_Role(Rec2Role);
					}
					if(req.getParameter("RecommendingOfficer3")!=null && !req.getParameter("RecommendingOfficer3").equalsIgnoreCase("")) {
						enote1.setRO3(Long.parseLong(req.getParameter("RecommendingOfficer3")));
					}
					if(Rec3Role!=null && !Rec3Role.equalsIgnoreCase("")) {
						enote1.setRO3_Role(Rec3Role);
					}
					if(ExternalOfficer!=null && !ExternalOfficer.equalsIgnoreCase("")) {
						enote1.setExternalOfficer(Long.parseLong(ExternalOfficer));
					}
					if(ExtRole!=null && !ExtRole.equalsIgnoreCase("")) {
						enote1.setExternalOfficer_Role(ExtRole);
					}
					if(LabCode!=null && !LabCode.equalsIgnoreCase("")) {
						enote1.setExternal_LabCode(LabCode);	
					}
					if(req.getParameter("SanctioningOfficer")!=null && !req.getParameter("SanctioningOfficer").equalsIgnoreCase("")) {
					enote1.setApprovingOfficer(Long.parseLong(req.getParameter("SanctioningOfficer")));	
					}
					if(SancRole!=null && !SancRole.equalsIgnoreCase("")) {
					enote1.setApproving_Role(SancRole);
					}
					enote1.setModifiedBy(req.getUserPrincipal().getName());
					enote1.setModifiedDate(sdf1.format(new Date()));
					
					long count2=service.UpdateEnoteRoso(enote1);
					}else {
						EnoteRosoModel enote=new EnoteRosoModel();
						enote.setInitiatingEmpId(Long.parseLong(InitiatedByEmpId));
						enote.setRO1(Long.parseLong(req.getParameter("RecommendingOfficer1")));
						enote.setRO1_Role(Rec1Role);
						if(req.getParameter("RecommendingOfficer2")!=null && !req.getParameter("RecommendingOfficer2").equalsIgnoreCase("")) {
						enote.setRO2(Long.parseLong(req.getParameter("RecommendingOfficer2")));
						}
						if(Rec2Role!=null && !Rec2Role.equalsIgnoreCase("")) {
						enote.setRO2_Role(Rec2Role);
						}
						if(req.getParameter("RecommendingOfficer3")!=null && !req.getParameter("RecommendingOfficer3").equalsIgnoreCase("")) {
						enote.setRO3(Long.parseLong(req.getParameter("RecommendingOfficer3")));
						}
						if(Rec3Role!=null && !Rec3Role.equalsIgnoreCase("")) {
						enote.setRO3_Role(Rec3Role);
						}
						if(ExternalOfficer!=null && !ExternalOfficer.equalsIgnoreCase("")) {
						enote.setExternalOfficer(Long.parseLong(ExternalOfficer));
						}
						if(ExtRole!=null && !ExtRole.equalsIgnoreCase("")) {
						enote.setExternalOfficer_Role(ExtRole);
						}
						if(LabCode!=null && !LabCode.equalsIgnoreCase("")) {
							enote.setExternal_LabCode(LabCode);	
						}
						if(req.getParameter("SanctioningOfficer")!=null && !req.getParameter("SanctioningOfficer").equalsIgnoreCase("")) {
						enote.setApprovingOfficer(Long.parseLong(req.getParameter("SanctioningOfficer")));	
						}
						
						if(SancRole!=null && !SancRole.equalsIgnoreCase("")) {
						enote.setApproving_Role(SancRole);
						}
						enote.setCreatedBy(req.getUserPrincipal().getName());
						enote.setCreatedDate(sdf1.format(new Date()));
						long count=service.InsertEnoteRoso(enote);
					}
			}else if(IntiatePreview!=null && IntiatePreview.equalsIgnoreCase("AddEdit") && EnoteRoSoEdit!=null && EnoteRoSoEdit.equalsIgnoreCase("EnoteRoSoEdit")) {
			if(EnoteRoSoId!=null && !EnoteRoSoId.equalsIgnoreCase("")) {
			EnoteRosoDto enote1=new EnoteRosoDto();
			enote1.setEnoteRoSoId(Long.parseLong(EnoteRoSoId));
			enote1.setInitiatingEmpId(Long.parseLong(InitiatedByEmpId));
			enote1.setRO1(Long.parseLong(req.getParameter("RecommendingOfficer1").toString()));
			enote1.setRO1_Role(Rec1Role);
			if(req.getParameter("RecommendingOfficer2")!=null && !req.getParameter("RecommendingOfficer2").equalsIgnoreCase("")) {
				enote1.setRO2(Long.parseLong(req.getParameter("RecommendingOfficer2")));
			}
			if(Rec2Role!=null && !Rec2Role.equalsIgnoreCase("")) {
				enote1.setRO2_Role(Rec2Role);
			}
			if(req.getParameter("RecommendingOfficer3")!=null && !req.getParameter("RecommendingOfficer3").equalsIgnoreCase("")) {
				enote1.setRO3(Long.parseLong(req.getParameter("RecommendingOfficer3")));
			}
			if(Rec3Role!=null && !Rec3Role.equalsIgnoreCase("")) {
				enote1.setRO3_Role(Rec3Role);
			}
			if(ExternalOfficer!=null && !ExternalOfficer.equalsIgnoreCase("")) {
				enote1.setExternalOfficer(Long.parseLong(ExternalOfficer));
			}
			if(ExtRole!=null && !ExtRole.equalsIgnoreCase("")) {
				enote1.setExternalOfficer_Role(ExtRole);
			}
			if(LabCode!=null && !LabCode.equalsIgnoreCase("")) {
				enote1.setExternal_LabCode(LabCode);	
			}
			if(req.getParameter("SanctioningOfficer")!=null && !req.getParameter("SanctioningOfficer").equalsIgnoreCase("")) {
			enote1.setApprovingOfficer(Long.parseLong(req.getParameter("SanctioningOfficer")));	
			}
			if(SancRole!=null && !SancRole.equalsIgnoreCase("")) {
			enote1.setApproving_Role(SancRole);
			}
			enote1.setModifiedBy(req.getUserPrincipal().getName());
			enote1.setModifiedDate(sdf1.format(new Date()));
			
			long count2=service.UpdateEnoteRoso(enote1);
			}else {
				EnoteRosoModel enote=new EnoteRosoModel();
				enote.setInitiatingEmpId(Long.parseLong(InitiatedByEmpId));
				enote.setRO1(Long.parseLong(req.getParameter("RecommendingOfficer1")));
				enote.setRO1_Role(Rec1Role);
				if(req.getParameter("RecommendingOfficer2")!=null && !req.getParameter("RecommendingOfficer2").equalsIgnoreCase("")) {
				enote.setRO2(Long.parseLong(req.getParameter("RecommendingOfficer2")));
				}
				if(Rec2Role!=null && !Rec2Role.equalsIgnoreCase("")) {
				enote.setRO2_Role(Rec2Role);
				}
				if(req.getParameter("RecommendingOfficer3")!=null && !req.getParameter("RecommendingOfficer3").equalsIgnoreCase("")) {
				enote.setRO3(Long.parseLong(req.getParameter("RecommendingOfficer3")));
				}
				if(Rec3Role!=null && !Rec3Role.equalsIgnoreCase("")) {
				enote.setRO3_Role(Rec3Role);
				}
				if(ExternalOfficer!=null && !ExternalOfficer.equalsIgnoreCase("")) {
				enote.setExternalOfficer(Long.parseLong(ExternalOfficer));
				}
				if(ExtRole!=null && !ExtRole.equalsIgnoreCase("")) {
				enote.setExternalOfficer_Role(ExtRole);
				}
				if(LabCode!=null && !LabCode.equalsIgnoreCase("")) {
					enote.setExternal_LabCode(LabCode);	
				}
				if(req.getParameter("SanctioningOfficer")!=null && !req.getParameter("SanctioningOfficer").equalsIgnoreCase("")) {
				enote.setApprovingOfficer(Long.parseLong(req.getParameter("SanctioningOfficer")));	
				}
				
				if(SancRole!=null && !SancRole.equalsIgnoreCase("")) {
				enote.setApproving_Role(SancRole);
				}
				enote.setCreatedBy(req.getUserPrincipal().getName());
				enote.setCreatedDate(sdf1.format(new Date()));
				long count=service.InsertEnoteRoso(enote);
			}
			
			}
			String SkipPreview=req.getParameter("SkipPreview");
			if(SkipPreview!=null) {
				redir.addAttribute("SkipPreview", SkipPreview);
				redir.addAttribute("eNoteId", req.getParameter("eNoteId"));
			}
			
			if(ViewFrom!=null) {
				redir.addAttribute("ViewFrom", ViewFrom);
			}
			if(result >0) {
				if(Action!=null && Action.equalsIgnoreCase("A") && (RedirectName!=null && RedirectName.equalsIgnoreCase("Recommend") || RedirectName!=null && RedirectName.equalsIgnoreCase("External"))) {
					if(req.getParameter("Approve")!=null && req.getParameter("Approve").equalsIgnoreCase("Approve")) {
						redir.addAttribute("result", "ENote Approved Successfully");
					}else {
					redir.addAttribute("result", "ENote Recommended Successfully");
					}
				}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("forward")) {
					redir.addAttribute("result", "ENote Forwarded Successfully");
				}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("ActionSave")) {
					redir.addAttribute("result", "ENote Saved Successfully");
				}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("SkipPreview")) {
					redir.addAttribute("result", "ENote Skip Successfully");
				}else {
					redir.addAttribute("result", "ENote Returned Successfully");
				}
			}else {
				if(Action!=null && Action.equalsIgnoreCase("A") && (RedirectName!=null && RedirectName.equalsIgnoreCase("Recommend") || RedirectName!=null && RedirectName.equalsIgnoreCase("External"))) {
					if(req.getParameter("Approve")!=null && req.getParameter("Approve").equalsIgnoreCase("Approve")) {
						redir.addAttribute("result", "ENote Approved Unsuccessful");
					}else {
					redir.addAttribute("result", "ENote Recommended Unsuccessful");
					}
				}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("forward")) {
					redir.addAttribute("resultfail", "ENote Forwarded Unsuccessful");
				}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("ActionSave")) {
					redir.addAttribute("resultfail", "ENote Saved Unsuccessful");
				}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("SkipPreview")) {
					redir.addAttribute("resultfail", "ENote Skip Unsuccessful");
				}else {
					redir.addAttribute("resultfail", "ENote Returned Unsuccessful");
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"EnoteForwardSubmit.htm"+e);
			return null;
		}
		if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("Recommend")) {
			return "redirect:/EnoteApprovalList.htm";
		}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("forward")){
			return "redirect:/ENoteList.htm";
		}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("ActionSave")){
			return "redirect:/ENoteList.htm";
		}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("External")) {
			return "redirect:/DakEnoteExternalList.htm";
		}else if(Action!=null && Action.equalsIgnoreCase("A") && RedirectName!=null && RedirectName.equalsIgnoreCase("SkipPreview")) {
			if(redirval!=null && redirval.equalsIgnoreCase("DakEnotePreview")) {
				redir.addAttribute("eNoteId", req.getParameter("eNoteId"));
				return "redirect:/DakEnoteReplyPreview.htm";
			}else {
			   return "redirect:/EnotePreview.htm";
			}
		}else {
			return "redirect:/EnoteApprovalList.htm";
		}
	}
	
	
	
	@RequestMapping(value = "EnoteApprovalList.htm" , method = {RequestMethod.POST,RequestMethod.GET})
	public String EnoteApprovalList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) throws Exception {
		logger.info(new Date() +"EnoteApprovalList.htm"+req.getUserPrincipal().getName());
		long EmpId=(Long)ses.getAttribute("EmpId");
		try {
			String fromDate=(String)req.getParameter("FromDate");
			String toDate=(String)req.getParameter("ToDate");
			
			String redirectedvalue=req.getParameter("redirectedvalue");
			if(redirectedvalue!=null) {
				req.setAttribute("redirectedvalueForward", redirectedvalue);
			}
			
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
			List<Object[]> eNotePendingList =service.eNotePendingList(EmpId);
			List<Object[]> eNoteApprovalList=service.eNoteApprovalList(EmpId,fromDate,toDate);
			req.setAttribute("eNoteApprovalList", eNoteApprovalList);
			req.setAttribute("EnoteApprovalPendingList", eNotePendingList);
			req.setAttribute("frmDt", fromDate);
			req.setAttribute("toDt",   toDate);
			return "Enote/EnoteApprovalList";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping(value = "GetEnoteAttachmentDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String GetEnoteAttachmentDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
	{
		
		logger.info(new Date() +"Inside GetEnoteAttachmentDetails.htm "+req.getUserPrincipal().getName());
				
		List<Object[]> AttachmentData =new ArrayList<Object[]>();
		try {
		
			AttachmentData = service.GetAttachmentDetails(Long.parseLong(req.getParameter("EnoteId")));
			req.setAttribute("AttachmentData", AttachmentData);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetEnoteAttachmentDetails.htm "+req.getUserPrincipal().getName(), e);
		}
		Gson json = new Gson();
		return json.toJson(AttachmentData);
	}
	
	
	@RequestMapping(value = "getEnoteiframepdf.htm", method = {RequestMethod.GET , RequestMethod.POST})
	public @ResponseBody String getEnoteiframepdf(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
	{
		
		logger.info(new Date() +"Inside getEnoteiframepdf.htm "+req.getUserPrincipal().getName());
		List<String> iframe=new ArrayList<>();
		try {
			
			String eNoteAttachId = req.getParameter("data");
			System.out.println("eNoteAttachId"+eNoteAttachId);
	        Object[] enoteattachmentdata = service.EnoteAttachmentData(eNoteAttachId);
	        System.out.println("enoteattachmentdata"+enoteattachmentdata);
	        File my_file = null;
	        String enoteattachdata = enoteattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = enoteattachdata.split(",");
    		System.out.println("enoteattachdata"+enoteattachdata);
    		System.out.println("fileParts"+fileParts);
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"eNote"+File.separator +fileParts[0]+File.separator+enoteattachmentdata[1]);
	        System.out.println("my_file"+my_file);
	         res.setHeader("Content-disposition", "inline; filename=" + enoteattachmentdata[1].toString());
	         iframe.add(FilenameUtils.getExtension(enoteattachmentdata[1]+""));
	         String pdf=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(my_file));
	         String FileName=(String)enoteattachmentdata[1];
	         iframe.add(pdf);
	         iframe.add(FileName);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside getEnoteiframepdf.htm "+req.getUserPrincipal().getName(), e);
		}
		Gson json = new Gson();
		return json.toJson(iframe);
	}
	
	
	@RequestMapping(value = "EnoteAttachDelete.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
	public String EnoteAttachDelete(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
	{

		logger.info(new Date() +"Inside EnoteAttachDelete.htm "+ req.getUserPrincipal().getName());
		String preview=req.getParameter("preview");
		try
		{
			String EnoteAttachId = req.getParameter("EnoteAttachmentIdforDelete");
			String SkipPreview=req.getParameter("SkipPreview");
			String EnoteId=req.getParameter("EnoteId");
			int deleteResult = 0;
			String IntiatePreview=req.getParameter("IntiatePreview");
			String Approval=req.getParameter("Approval");
			String ViewFrom=req.getParameter("ViewFrom");
			List<Object[]> EnoteDakAttachmentData = null;
			
			if(EnoteAttachId!=null && EnoteId!=null ) {
				EnoteDakAttachmentData  = service.EnoteAttachmentData(Long.parseLong(EnoteAttachId),Long.parseLong(EnoteId));
			}
            
			if(EnoteDakAttachmentData!=null && EnoteDakAttachmentData.size() > 0) {
			
				Object[] data =  EnoteDakAttachmentData.get(0);
				File my_file=null;
				String enoteattachdata = data[0].toString().replaceAll("[/\\\\]", ",");
		    	String[] fileParts = enoteattachdata.split(",");
			    my_file = new File(env.getProperty("file_upload_path")+File.separator+"eNote"+File.separator +fileParts[0]+File.separator+data[1]);
				boolean result = Files.deleteIfExists(my_file.toPath());
				
			if(result) 
			{
				deleteResult = service.DeleteEnoteAttachment(EnoteAttachId);
				
				if(deleteResult>0) {
					redir.addAttribute("result","Document Deleted Successfully");
				
				}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful"); }
				
			}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful in Folder"); }
			
			}else { redir.addAttribute("resultfail","Document not found"); }
			
			redir.addAttribute("eNoteId", EnoteId);
			if(IntiatePreview!=null) {
			redir.addAttribute("IntiatePreview", IntiatePreview);
			}
			if(Approval!=null) {
				redir.addAttribute("Approval", Approval);
			}
			
			if(SkipPreview!=null) {
				redir.addAttribute("SkipPreview", SkipPreview);
			}
			
			if(ViewFrom!=null) {
				redir.addAttribute("ViewFrom" , ViewFrom);
			}
		}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside EnoteAttachDelete.htm "+ req.getUserPrincipal().getName(),e);
		}
		if(req.getParameter("redirval")!=null && req.getParameter("redirval").equalsIgnoreCase("EnoteEdit")) {
		return "redirect:/EnoteEdit.htm";
		}else if(req.getParameter("redirval")!=null && req.getParameter("redirval").equalsIgnoreCase("EnotePreview")){
			if(preview!=null) {
				redir.addAttribute("preview", preview);
			}
			return "redirect:/EnotePreview.htm";
		}else {
			return "redirect:/EnoteExternalPreview.htm";
		}
	}
	
	
	@RequestMapping(value = "EnoteAttachForDownload.htm", method = {RequestMethod.GET, RequestMethod.POST})
	public void EnoteAttachForDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
	    try {
	        String Enoteattachmentid = req.getParameter("downloadbtn");
	        Object[] Enoteattachmentdata = service.EnoteAttachmentData(Enoteattachmentid);
	        File my_file = null;
	        String enoteattachdata = Enoteattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = enoteattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"eNote"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+Enoteattachmentdata[1]);
	         res.setHeader("Content-disposition", "inline; filename=" + Enoteattachmentdata[1].toString());
	        
	        String mimeType = getEnoteMimeType(my_file.getName()); // Get the appropriate MIME type based on the file extension
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
	        logger.error(new Date() + "Inside EnoteAttachForDownload.htm " + req.getUserPrincipal().getName(), e);
	    }
	}
	
	private String getEnoteMimeType(String filename) {
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
	        default:
	            return "application/octet-stream";
	    }
	}
	
	@RequestMapping(value = "EnotePreview.htm" , method = {RequestMethod.GET,RequestMethod.POST})
	public String EnotePreview(HttpServletRequest req,HttpServletResponse resp,HttpSession ses)  throws Exception{
		logger.info(new Date() +"EnotePreview.htm"+req.getUserPrincipal().getName());
		Object[] EnotePreview=null;
		String LabCode = (String) ses.getAttribute("LabCode");
		try {
			
			String result=req.getParameter("eNoteId");
			String ViewFrom=req.getParameter("ViewFrom");
			String IntiatePreview=req.getParameter("IntiatePreview");
			String Approval=req.getParameter("Approval");
			String preview=req.getParameter("preview");
			String SkipPreview=req.getParameter("SkipPreview");
			String EnoteRoSoEdit=req.getParameter("EnoteRoSoEdit");
			if(result!=null) {
				EnotePreview=service.EnotePreview(Long.parseLong(result));
				req.setAttribute("EnotePreview", EnotePreview);
				req.setAttribute("RecommendingOfficerList",service.RecommendingOfficerList(LabCode));
				req.setAttribute("EnoteRoSoRoledetails", service.EnoteRoSoRoledetails(Long.parseLong(result)));
			}
			Object[] RecommendingDetails=service.RecommendingDetails(Long.parseLong(result),LabCode);
			long AttachmentCount=service.AttachmentCount(Long.parseLong(result));
			List<Object[]> LabList=service.LabList(LabCode);
			List<Object[]> ReturnRemarks=service.ReturnRemarks(result);
			req.setAttribute("ReturnRemarks", ReturnRemarks);
			req.setAttribute("LabList", LabList);
			req.setAttribute("AttachmentCount", AttachmentCount);
			req.setAttribute("RecommendingDetails", RecommendingDetails);
			req.setAttribute("IntiatePreview", IntiatePreview);
			req.setAttribute("Approval", Approval);
			req.setAttribute("preview", preview);
			req.setAttribute("SkipPreview", SkipPreview);
			req.setAttribute("ViewFrom", ViewFrom);
			Path imgfile=Paths.get(env.getProperty("file_upload_path"), "Letter","drdo.png");
			File drdoimageFile = imgfile.toFile();
			ImageData drdoLogo = null;
			if (drdoimageFile.exists()) {
		        drdoLogo = ImageDataFactory.create(drdoimageFile.getAbsolutePath());
		        byte[] imageBytes = FileUtils.readFileToByteArray(drdoimageFile);
		        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
		        req.setAttribute("lablogo", base64Image);
		    }
			Object[] letterDocumentdata = service.letterDocumentData(result);
			if(letterDocumentdata!=null) {
				req.setAttribute("letterDocumentdata", letterDocumentdata);
			}
			Object[] WordDocumentData=service.WordDocumentData(Long.parseLong(result));
			if(WordDocumentData!=null) {
				req.setAttribute("WordDocumentData", WordDocumentData);
			}
			
			if(EnoteRoSoEdit!=null) {
				req.setAttribute("EnoteRoSoEdit", EnoteRoSoEdit);
			}
			return "Enote/EnotePreview";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	
	@RequestMapping(value = "EnoteStatusTrack.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String EnoteStatusTrack(HttpServletResponse resp, HttpServletRequest req, HttpSession ses) throws Exception {
		
		logger.info(new Date() +"EnoteStatusTrack.htm"+req.getUserPrincipal().getName());
		
		String EnoteTrackId=req.getParameter("EnoteTrackId");
		String fromDate=(String)req.getParameter("FromDate");
		String toDate=(String)req.getParameter("ToDate");
		if(toDate == null){
			toDate=LocalDate.now().toString();
		}else{
			fromDate=sdf2.format(rdf.parse(fromDate));
		}
		
		if(fromDate==null) {
			fromDate=LocalDate.now().minusDays(30).toString();
		}else {
			toDate=sdf2.format(rdf.parse(toDate));
		}
		
		req.setAttribute("frmDt", fromDate);
		req.setAttribute("toDt",   toDate);
		
		req.setAttribute("EnoteTransactionList",service.EnoteTransactionList(EnoteTrackId));
		return "Enote/EnoteTrack";

	}
	
	@RequestMapping(value = "EnotePrint.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void EnotePrint(HttpServletResponse resp, HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +"EnotePrint.htm"+req.getUserPrincipal().getName());
		String LabCode = (String) ses.getAttribute("LabCode");
		try {
			String EnotePrintId=req.getParameter("EnotePrintId");
			List<Object[]> EnotePrintDetails=service.EnotePrintDetails(Long.parseLong(EnotePrintId));
			Object[] ExternalNameData=service.ExternalNameData(Long.parseLong(EnotePrintId));
			Object[] EnotePrint=service.EnotePrint(EnotePrintId);
			req.setAttribute("EnotePrintDetails", EnotePrintDetails);
			req.setAttribute("EnotePrint",EnotePrint);
			req.setAttribute("ExternalNameData", ExternalNameData);
			List<Object[]> AttachmentData=null;
			if(EnotePrint!=null && EnotePrint[18]!=null && EnotePrint[18].toString().equalsIgnoreCase("N")) {
				AttachmentData = service.GetAttachmentDetails(Long.parseLong(req.getParameter("EnotePrintId")));
				req.setAttribute("AttachmentData", AttachmentData);
			}else if(EnotePrint!=null && EnotePrint[18]!=null && EnotePrint[18].toString().equalsIgnoreCase("Y")) {
				if(EnotePrint!=null && EnotePrint[19]!=null && EnotePrint[19].toString().equalsIgnoreCase("M")) {
					AttachmentData = dakservice.EnoteMarkerReplyAttachmentData(Long.parseLong(EnotePrint[15].toString()));
					req.setAttribute("AttachmentData", AttachmentData);
				}else if(EnotePrint!=null && EnotePrint[19]!=null && EnotePrint[19].toString().equalsIgnoreCase("C")) {
					AttachmentData = dakservice.EnoteAssignReplyAttachmentData(Long.parseLong(EnotePrint[14].toString()));
					req.setAttribute("AttachmentData", AttachmentData);
				}
			}
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
	        
	        CharArrayWriterResponse customResponse = new CharArrayWriterResponse(resp);
	        req.getRequestDispatcher("/view/Enote/EnotePrint.jsp").forward(req, customResponse);

			String html = customResponse.getOutput();        
	        
			String filename="EnotePrint";
	        HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf")) ; 
	         
	        resp.setContentType("application/pdf");
	        resp.setHeader("Content-disposition","inline;filename="+filename+".pdf");
	       
	       
	        dmsutils.addWatermarktoPdf(path +File.separator+ filename+".pdf",path +File.separator+ filename+"1.pdf",LabCode);
	        
	        
	        File f=new File(path +File.separator+ filename+".pdf");
	        FileInputStream fis = new FileInputStream(f);
	        DataOutputStream os = new DataOutputStream(resp.getOutputStream());
	        resp.setHeader("Content-Length",String.valueOf(f.length()));
	        byte[] buffer = new byte[1024];
	        int len = 0;
	        while ((len = fis.read(buffer)) >= 0) {
	            os.write(buffer, 0, len);
	        } 
	        os.close();
	        fis.close();
	       
	       
	        Path pathOfFile= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile);
		} catch (Exception e) {
			logger.info(new Date() +"EnotePrint.htm"+req.getUserPrincipal().getName());
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(value = "DakEnoteRoSoList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String InitiatedOfficerList(HttpServletResponse resp, HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +"DakEnoteRoSoList.htm"+req.getUserPrincipal().getName());
		String LabCode = (String) ses.getAttribute("LabCode");
		req.setAttribute("EnoteRoSoList",service.EnoteRoSoList(LabCode));
		return "Enote/DakEnoteRoSoList";

	}
	
	
	
	
	@RequestMapping(value = "DakEnoteRoSoAdd.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String InitiateOfficerAdd(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +"DakEnoteRoSoAdd.htm "+req.getUserPrincipal().getName());
		try {
		String LabCode = (String) ses.getAttribute("LabCode");
		List<Object[]> InitiatedEmpList=service.InitiatedEmpList(LabCode);
		List<Object[]> EmployeeListForEnoteRoSo=service.EmployeeListForEnoteRoSo(LabCode);
		List<Object[]> LabList=service.LabList(LabCode);
		req.setAttribute("LabList", LabList);
		req.setAttribute("InitiatedEmpList", InitiatedEmpList);
		req.setAttribute("EmployeeListForEnoteRoSo", EmployeeListForEnoteRoSo);
		
		return "Enote/DakEnoteRoSoAdd";
		}catch( Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" DakEnoteRoSoAdd.htm "+req.getUserPrincipal().getName(), e);
			return "static/Error";	
		}
	}
	
	
	@RequestMapping(value= "InitiateOfficerAddSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String InitiateOfficerAddSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir, @RequestPart(name = "dakEnoteDocument", required = false) MultipartFile[] dakEnoteDocument) throws Exception {
		logger.info(new Date() +"InitiateOfficerAddSubmit.htm"+req.getUserPrincipal().getName());
		long result=0;
		try {
			String EmployeeId=req.getParameter("EmployeeId");
			String RecommendOfficer1=req.getParameter("RecommendOfficer1");
			String RecommendOfficer2=req.getParameter("RecommendOfficer2");
			String RecommendOfficer3=req.getParameter("RecommendOfficer3");
			String RecommendOfficer4=req.getParameter("RecommendOfficer4");
			String RecommendOfficer5=req.getParameter("RecommendOfficer5");
			String ExternalOfficer=req.getParameter("ExternalOfficer");
			String SanctionOfficer=req.getParameter("SanctionOfficer");
			String RO1_Role=req.getParameter("RO1_Role");
			String RO2_Role=req.getParameter("RO2_Role");
			String RO3_Role=req.getParameter("RO3_Role");
			String RO4_Role=req.getParameter("RO4_Role");
			String RO5_Role=req.getParameter("RO5_Role");
			String EO_Role=req.getParameter("EO_Role");
			String SO_Role=req.getParameter("SO_Role");
			String ExternalLabCode =req.getParameter("LabCode");
			
			EnoteRosoModel enote=new EnoteRosoModel();
			enote.setInitiatingEmpId(Long.parseLong(EmployeeId));
			enote.setRO1(Long.parseLong(RecommendOfficer1));
			enote.setRO1_Role(RO1_Role);
			if(RecommendOfficer2!=null && !RecommendOfficer2.equalsIgnoreCase("")) {
			enote.setRO2(Long.parseLong(RecommendOfficer2));
			}
			if(RO2_Role!=null && !RO2_Role.equalsIgnoreCase("")) {
			enote.setRO2_Role(RO2_Role);
			}
			if(RecommendOfficer3!=null && !RecommendOfficer3.equalsIgnoreCase("")) {
			enote.setRO3(Long.parseLong(RecommendOfficer3));
			}
			if(RO3_Role!=null && !RO3_Role.equalsIgnoreCase("")) {
			enote.setRO3_Role(RO3_Role);
			}
			if(RecommendOfficer4!=null && !RecommendOfficer4.equalsIgnoreCase("")) {
			enote.setRO4(Long.parseLong(RecommendOfficer4));
			}
			if(RO4_Role!=null && !RO4_Role.equalsIgnoreCase("")) {
			enote.setRO4_Role(RO4_Role);
			}
			if(RecommendOfficer5!=null && !RecommendOfficer5.equalsIgnoreCase("")) {
			enote.setRO5(Long.parseLong(RecommendOfficer5));
			}
			if(RO5_Role!=null && !RO5_Role.equalsIgnoreCase("")) {
			enote.setRO5_Role(RO5_Role);
			}
			if(ExternalOfficer!=null && !ExternalOfficer.equalsIgnoreCase("")) {
			enote.setExternalOfficer(Long.parseLong(ExternalOfficer));
			}
			if(EO_Role!=null && !EO_Role.equalsIgnoreCase("")) {
			enote.setExternalOfficer_Role(EO_Role);
			}
			if(ExternalLabCode!=null && !ExternalLabCode.equalsIgnoreCase("")) {
				enote.setExternal_LabCode(ExternalLabCode);	
			}
			enote.setApprovingOfficer(Long.parseLong(SanctionOfficer));	
			enote.setApproving_Role(SO_Role);
			enote.setCreatedBy(req.getUserPrincipal().getName());
			enote.setCreatedDate(sdf1.format(new Date()));
			
			result=service.InsertEnoteRoso(enote);
			if(result >0) {
				redir.addAttribute("result", "eNote RoSo Created Successfully");
			}
			else {
				redir.addAttribute("resultfail", "eNote RoSo Created Successfully");
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"InitiateOfficerAddSubmit.htm"+e);
			return null;
		}
		return "redirect:/DakEnoteRoSoList.htm";
	}
	
	
	
	
	@RequestMapping(value = "DakEnoteRoSoEdit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakEnoteRoSoEdit(HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +"DakEnoteRoSoEdit.htm "+req.getUserPrincipal().getName());
		try {
		String EnoteRoSoId=req.getParameter("eNoteRoSoId");
		String LabCode = (String) ses.getAttribute("LabCode");
		EnoteRosoModel EnoteRoSoEditData=service.EnoteRoSoEditData(Long.parseLong(EnoteRoSoId));
		List<Object[]> EmployeeListForEnoteRoSo=service.EmployeeListForEnoteRoSo(LabCode);
		List<Object[]> LabList=service.LabList(LabCode);
		req.setAttribute("LabList", LabList);
		req.setAttribute("EmployeeListForEnoteRoSo", EmployeeListForEnoteRoSo);
		req.setAttribute("EnoteRoSoEditData", EnoteRoSoEditData);
		return "Enote/DakEnoteRoSoEdit";
		}catch( Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" DakEnoteRoSoEdit.htm "+req.getUserPrincipal().getName(), e);
			return "static/Error";	
		}
	}
	
	
	@RequestMapping(value= "InitiateOfficerEditSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String InitiateOfficerEditSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir, @RequestPart(name = "dakEnoteDocument", required = false) MultipartFile[] dakEnoteDocument) throws Exception {
		logger.info(new Date() +"InitiateOfficerEditSubmit.htm"+req.getUserPrincipal().getName());
		long result=0;
		try {
			String EmployeeId=req.getParameter("EmployeeId");
			String RecommendOfficer1=req.getParameter("RecommendOfficer1");
			String RecommendOfficer2=req.getParameter("RecommendOfficer2");
			String RecommendOfficer3=req.getParameter("RecommendOfficer3");
			String RecommendOfficer4=req.getParameter("RecommendOfficer4");
			String RecommendOfficer5=req.getParameter("RecommendOfficer5");
			String ExternalOfficer=req.getParameter("ExternalOfficer");
			String SanctionOfficer=req.getParameter("SanctionOfficer");
			String RO1_Role=req.getParameter("RO1_Role");
			String RO2_Role=req.getParameter("RO2_Role");
			String RO3_Role=req.getParameter("RO3_Role");
			String RO4_Role=req.getParameter("RO4_Role");
			String RO5_Role=req.getParameter("RO5_Role");
			String EO_Role=req.getParameter("EO_Role");
			String SO_Role=req.getParameter("SO_Role");
			String ExternalLabCode =req.getParameter("LabCode");
			
			String EnoteRoSoId=req.getParameter("EnoteRoSoId");
			EnoteRosoDto enote=new EnoteRosoDto();
			
			enote.setEnoteRoSoId(Long.parseLong(EnoteRoSoId));
			enote.setInitiatingEmpId(Long.parseLong(EmployeeId));
			enote.setRO1(Long.parseLong(RecommendOfficer1));
			enote.setRO1_Role(RO1_Role);
			if(RecommendOfficer2!=null && !RecommendOfficer2.equalsIgnoreCase("")) {
				enote.setRO2(Long.parseLong(RecommendOfficer2));
			}
			if(RO2_Role!=null && !RO2_Role.equalsIgnoreCase("")) {
				enote.setRO2_Role(RO2_Role);
			}
			if(RecommendOfficer3!=null && !RecommendOfficer3.equalsIgnoreCase("")) {
				enote.setRO3(Long.parseLong(RecommendOfficer3));
			}
			if(RO3_Role!=null && !RO3_Role.equalsIgnoreCase("")) {
				enote.setRO3_Role(RO3_Role);
			}
			if(RecommendOfficer4!=null && !RecommendOfficer4.equalsIgnoreCase("")) {
				enote.setRO4(Long.parseLong(RecommendOfficer4));
			}
			if(RO4_Role!=null && !RO4_Role.equalsIgnoreCase("")) {
				enote.setRO4_Role(RO4_Role);
			}
			if(RecommendOfficer5!=null && !RecommendOfficer5.equalsIgnoreCase("")) {
				enote.setRO5(Long.parseLong(RecommendOfficer5));
			}
			if(RO5_Role!=null && !RO5_Role.equalsIgnoreCase("")) {
				enote.setRO5_Role(RO5_Role);
			}
			if(ExternalOfficer!=null && !ExternalOfficer.equalsIgnoreCase("")) {
				enote.setExternalOfficer(Long.parseLong(ExternalOfficer));
			}
			if(EO_Role!=null && !EO_Role.equalsIgnoreCase("")) {
				enote.setExternalOfficer_Role(EO_Role);
			}
			if(ExternalLabCode!=null && !ExternalLabCode.equalsIgnoreCase("")) {
				enote.setExternal_LabCode(ExternalLabCode);	
			}
			enote.setApprovingOfficer(Long.parseLong(SanctionOfficer));	
			enote.setApproving_Role(SO_Role);
			enote.setModifiedBy(req.getUserPrincipal().getName());
			enote.setModifiedDate(sdf1.format(new Date()));
			
			result=service.UpdateEnoteRoso(enote);
			if(result >0) {
				redir.addAttribute("result", "eNote RoSo Updated Successfully");
			}
			else {
				redir.addAttribute("resultfail", "eNote RoSo Updated Successfully");
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"InitiateOfficerEditSubmit.htm"+e);
			return null;
		}
		return "redirect:/DakEnoteRoSoList.htm";
	}
	
	
	
	@RequestMapping(value="getDakEnoteRoSoDetails.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public  @ResponseBody String  getDakEnoteRoSoDetails(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside getDakEnoteRoSoDetails.htm"+Username);
		Gson json = new Gson();
		Object[] EnoteRoSoDetails=null;
		try {
			String LabCode = (String) ses.getAttribute("LabCode");
			String EnoteRoSoId=(String)req.getParameter("EnoteRoSoId");
			if(EnoteRoSoId!=null) {
			     EnoteRoSoDetails = service.EnoteRoSoDetails(Long.parseLong(EnoteRoSoId),LabCode);
			}else {
				
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside getDakEnoteRoSoDetails.htm "+Username, e);
			}
		return json.toJson(EnoteRoSoDetails);

	}
	
	
	@RequestMapping(value="GetLabcodeEmpList.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public  @ResponseBody String  GetLabcodeEmpList(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetLabcodeEmpList.htm"+Username);
		Gson json = new Gson();
		List<Object[]> GetLabcodeEmpList=null;
		try {
			String LabCode=(String)req.getParameter("LabCode");
			if(LabCode!=null && !LabCode.equalsIgnoreCase("@EXP")) {
				GetLabcodeEmpList=service.EmployeeListForEnoteRoSo(LabCode);
			}else {
				GetLabcodeEmpList=service.ExpertEmployeeList();
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetLabcodeEmpList.htm "+Username, e);
			}
		return json.toJson(GetLabcodeEmpList);

	}
	
	@RequestMapping(value = "EnoteRevoke.htm", method = {RequestMethod.POST,RequestMethod.POST})
	public String EnoteRevoke(HttpServletRequest req, HttpServletResponse response, HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String Username = (String) ses.getAttribute("Username");
		long EmpId=(Long)ses.getAttribute("EmpId");
		logger.info(new Date() +"Inside EnoteRevoke.htm "+Username);
		try {
			String EnoteRevokeId = req.getParameter("EnoteRevokeId");

			long count =service.EnoteInitiaterRevoke(EnoteRevokeId, Username, EmpId);
			if (count > 0) {
				redir.addAttribute("result", "eNote Revoked Successfully");
			}
			else {
				redir.addAttribute("resultfail", "eNote Revoke Unsuccessful");	
			}	

			return "redirect:/ENoteList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside EnoteRevoke.htm "+Username, e);
			return "static/Error";			
		}

	}
	
	
	
	@RequestMapping(value = "DakEnoteExternalList.htm" , method = {RequestMethod.POST,RequestMethod.GET})
	public String DakEnoteExternalList(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) throws Exception {
		logger.info(new Date() +"DakEnoteExternalList.htm"+req.getUserPrincipal().getName());
		long EmpId=(Long)ses.getAttribute("EmpId");
		try {
			String fromDate=(String)req.getParameter("FromDate");
			String toDate=(String)req.getParameter("ToDate");
			
			String redirectedvalue=req.getParameter("redirectedvalue");
			if(redirectedvalue!=null) {
				req.setAttribute("redirectedvalueForward", redirectedvalue);
			}
			
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
			List<Object[]> ExternalList =service.ExternalList(EmpId);
			List<Object[]> ExternalApprovalList=service.ExternalApprovalList(EmpId,fromDate,toDate);
			req.setAttribute("ExternalApprovalList", ExternalApprovalList);
			req.setAttribute("ExternalList", ExternalList);
			req.setAttribute("frmDt", fromDate);
			req.setAttribute("toDt",   toDate);
			return "Enote/EnoteExternalList";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping(value = "EnoteExternalPreview.htm" , method = {RequestMethod.GET,RequestMethod.POST})
	public String EnoteExternalPreview(HttpServletRequest req,HttpServletResponse resp,HttpSession ses)  throws Exception{
		logger.info(new Date() +"EnoteExternalPreview.htm"+req.getUserPrincipal().getName());
		Object[] EnotePreview=null;
		String LabCode = (String) ses.getAttribute("LabCode");
		try {
			
			String result=req.getParameter("eNoteId");
			if(result!=null) {
				EnotePreview=service.EnotePreview(Long.parseLong(result));
				req.setAttribute("EnotePreview", EnotePreview);
			}
			Object[] RecommendingDetails=service.RecommendingDetails(Long.parseLong(result),LabCode);
			long AttachmentCount=service.AttachmentCount(Long.parseLong(result));
			List<Object[]> ReturnRemarks=service.ReturnRemarks(result);
			List<Object[]> LabList=service.LabList(LabCode);
			req.setAttribute("LabList", LabList);
			req.setAttribute("ReturnRemarks", ReturnRemarks);
			req.setAttribute("AttachmentCount", AttachmentCount);
			req.setAttribute("ViewFrom", "DakEnoteExternalList");
			req.setAttribute("RecommendingDetails", RecommendingDetails);
			Object[] letterDocumentdata = service.letterDocumentData(result);
			if(letterDocumentdata!=null) {
				req.setAttribute("letterDocumentdata", letterDocumentdata);
			}
			Object[] WordDocumentData=service.WordDocumentData(Long.parseLong(result));
			if(WordDocumentData!=null) {
				req.setAttribute("WordDocumentData", WordDocumentData);
			}
			Path imgfile=Paths.get(env.getProperty("file_upload_path"), "Letter","drdo.png");
			File drdoimageFile = imgfile.toFile();
			ImageData drdoLogo = null;
			if (drdoimageFile.exists()) {
		        drdoLogo = ImageDataFactory.create(drdoimageFile.getAbsolutePath());
		        byte[] imageBytes = FileUtils.readFileToByteArray(drdoimageFile);
		        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
		        req.setAttribute("lablogo", base64Image);
		    }
			return "Enote/EnoteExternalPreview";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping(value = "SkipApprovals.htm"  , method= {RequestMethod.GET,RequestMethod.POST})
	public String SkipApprovals(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		long EmpId=(Long)ses.getAttribute("EmpId");
		logger.info(new Date() +"Inside SkipApprovals.htm "+UserId);		
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
			
			List<Object[]> eNoteSkipApprovalPendingList =service.eNoteSkipApprovalPendingList(fromDate,toDate,UserId,EmpId);
			req.setAttribute("AllSkipApprovalList", eNoteSkipApprovalPendingList);
			req.setAttribute("frmDt", fromDate);
			req.setAttribute("toDt",   toDate);
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside SkipApprovals.htm "+UserId, e);
		}	
		return "Enote/SkipApprovals";
	}
	
	@RequestMapping(value = "EnoteViewPrint.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void EnoteViewPrint(HttpServletResponse resp, HttpServletRequest req, HttpSession ses) throws Exception {
		logger.info(new Date() +"EnoteViewPrint.htm"+req.getUserPrincipal().getName());
		String LabCode = (String) ses.getAttribute("LabCode");
		try {
			String EnotePrintId=req.getParameter("EnotePrintId");
			List<Object[]> EnotePrintDetails=service.EnotePrintViewDetails(Long.parseLong(EnotePrintId));
			Object[] ExternalNameData=service.ExternalNameData(Long.parseLong(EnotePrintId));
			req.setAttribute("EnotePrintDetails", EnotePrintDetails);
			req.setAttribute("EnotePrint",service.EnotePrint(EnotePrintId));
			req.setAttribute("ExternalNameData", ExternalNameData);
			
			
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
	        
	        CharArrayWriterResponse customResponse = new CharArrayWriterResponse(resp);
	        req.getRequestDispatcher("/view/Enote/EnotePrint.jsp").forward(req, customResponse);

			String html = customResponse.getOutput();        
	        
			String filename="EnotePrint";
	        HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf")) ; 
	         
	        resp.setContentType("application/pdf");
	        resp.setHeader("Content-disposition","inline;filename="+filename+".pdf");
	       
	       
	        dmsutils.addWatermarktoPdf(path +File.separator+ filename+".pdf",path +File.separator+ filename+"1.pdf",LabCode);
	        
	        
	        File f=new File(path +File.separator+ filename+".pdf");
	        FileInputStream fis = new FileInputStream(f);
	        DataOutputStream os = new DataOutputStream(resp.getOutputStream());
	        resp.setHeader("Content-Length",String.valueOf(f.length()));
	        byte[] buffer = new byte[1024];
	        int len = 0;
	        while ((len = fis.read(buffer)) >= 0) {
	            os.write(buffer, 0, len);
	        } 
	        os.close();
	        fis.close();
	       
	       
	        Path pathOfFile= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile);
		} catch (Exception e) {
			logger.info(new Date() +"EnotePrint.htm"+req.getUserPrincipal().getName());
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(value="GetChangeRecommendingOfficer.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public  @ResponseBody String  GetChangeRecommendingOfficer(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetChangeRecommendingOfficer.htm"+Username);
		Gson json = new Gson();
		List<Object[]> GetChangeRecommendingOfficer=null;
		try {
			String EmpId=req.getParameter("EmpId");
			
			if(EmpId!=null && !EmpId.equalsIgnoreCase("")) {
				Object DivisionId=service.getDivisionId(Long.parseLong(EmpId));
				String divId=DivisionId.toString();
				GetChangeRecommendingOfficer=service.GetChangeRecommendingOfficer(divId);
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetChangeRecommendingOfficer.htm "+Username, e);
			}
		return json.toJson(GetChangeRecommendingOfficer);

	}
	
		
	@RequestMapping(value = "ChangeRecommendOfficer.htm",  method = {RequestMethod.GET,RequestMethod.POST})
	public String ChangeRecommendOfficer(HttpServletRequest req, HttpServletResponse response, HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		long EmpId=(Long)ses.getAttribute("EmpId");
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ChangeRecommendOfficer.htm "+Username);
		long RecommendingOfficer=0;
		try {
			
			String finalRemarks=null;
			String remarks=req.getParameter("ChangeApprovalRemarks");
			String SkipApproval=req.getParameter("SkipApproval");
			if(SkipApproval!=null) {
				finalRemarks=SkipApproval+" "+remarks;
			}else {
				finalRemarks=remarks;
			}
			
			String ViewFrom=req.getParameter("ViewFrom");
			String Redirval=req.getParameter("redirval");
			String SkipPreview=req.getParameter("SkipPreview");
			String EnoteId = req.getParameter("eNoteId");
			String ChangeRecOfficer=req.getParameter("ChangeRecOfficer");
			String StatusCodeNext=req.getParameter("StatusCodeNext");
			String RecommendRole=req.getParameter("RecommendRole");
			String ChangeStatusCode=req.getParameter("ChangeStatusCode");
			if(ChangeRecOfficer!=null) {
			RecommendingOfficer=Long.parseLong(ChangeRecOfficer);
			}
			long count =service.ChangeRecommendOfficer(Long.parseLong(EnoteId), RecommendingOfficer, StatusCodeNext,RecommendRole,finalRemarks,ChangeStatusCode,EmpId);
			if(SkipPreview!=null) {
				redir.addAttribute("SkipPreview", SkipPreview);
				redir.addAttribute("eNoteId", EnoteId);
			}
			
			if(ViewFrom!=null) {
				redir.addAttribute("ViewFrom", ViewFrom);
			}
			if (count > 0) {
				redir.addAttribute("result", "Recommending Officer Changed Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Recommending Officer Changed Unsuccessful");	
			}	
			
			if(Redirval!=null && Redirval.equalsIgnoreCase("DakEnotePreview")) {
				return "redirect:/DakEnoteReplyPreview.htm";
			}else {
				return "redirect:/EnotePreview.htm";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ChangeRecommendOfficer.htm "+Username, e);
			return "static/Error";			
		}

	}
	
	
	@RequestMapping(value= "DakEnoteReplyAddSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakEnoteAddSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir, @RequestPart(name = "dakReplyEnoteDocument", required = false) MultipartFile[] dakReplyEnoteDocument) throws Exception {
		logger.info(new Date() +"DakEnoteReplyAddSubmit.htm"+req.getUserPrincipal().getName());
		long EmpId=(Long)ses.getAttribute("EmpId");
		String LabCode = (String) ses.getAttribute("LabCode");
		String DivisionCode = (String) ses.getAttribute("DivisionCode");
		long result=0;
		try {
			Object[] EnoteMarkerReplyData=null;
			long result1=0;
			long result2=0;
            String dakId= null;
            String EnoteFrom=req.getParameter("EnoteFrom");
			String DakNo=req.getParameter("DakNo");
			String RefNo=req.getParameter("RefNo");
			String NoteNo=req.getParameter("NoteNo");
			String RefDate=req.getParameter("RefDate");
			String DakAssignId=req.getParameter("DakAssignId");
			String letterDate=req.getParameter("LetterDate");
			String DestinationId=req.getParameter("DestinationId");
			String DestinationTypeId=req.getParameter("DestinationTypeId");
			String DraftContent=req.getParameter("DraftContent");
			String Signatory=req.getParameter("Signatory");
			String LetterHead=req.getParameter("LetterHead");
			String IsDraftVal=req.getParameter("IsDraftVal");
			
            dakId=req.getParameter("dakIdValFrReply");
            String Reply=req.getParameter("Reply");
            if(EnoteFrom!=null && EnoteFrom.equalsIgnoreCase("M")) {
	     	DakReplyDto dakReplydto = new DakReplyDto();
	     	dakReplydto.setDakId(Long.parseLong(dakId));
	     	dakReplydto.setEmpId(EmpId);
	     	dakReplydto.setReply(Reply);
	     	dakReplydto.setCreatedBy(req.getUserPrincipal().getName());
			result1=dakservice.insertDakReply(dakReplydto);
			
			if(result1>0) {
				DakMain DakDetails = dakservice.GetDakDetails(Long.parseLong(dakId)); 
				long TotalEmpIdCountInDM=dakservice.EmpIdCountOfDM(Long.parseLong(dakId));//WHO are active
				long TotalDakReplyCountInDR=dakservice.DakReplyCountInDR(Long.parseLong(dakId));
			if(TotalEmpIdCountInDM==TotalDakReplyCountInDR && DakDetails.getDakStatus()!=null 
					&& !DakDetails.getDakStatus().equalsIgnoreCase("RP") && !DakDetails.getDakStatus().equalsIgnoreCase("AP") && !DakDetails.getDakStatus().equalsIgnoreCase("RM")  ) {
			long dakStatus=dakservice.UpdateDakStatusToDR(Long.parseLong(dakId));
			}
			}else{
			}
			EnoteMarkerReplyData=dakservice.EnoteMarkerReplyData(Long.parseLong(dakId),EmpId);
            }else if(EnoteFrom!=null && EnoteFrom.equalsIgnoreCase("C")) {
				DakAssignReplyDto dto=new DakAssignReplyDto();
				dto.setDakId(Long.parseLong(dakId));
				dto.setAssignId(Long.parseLong(DakAssignId));
				dto.setEmpId(EmpId);
				dto.setReply(Reply.trim());
				dto.setReplyStatus("R");
				dto.setCreatedBy(req.getUserPrincipal().getName());
				dto.setCreatedDate(sdf1.format(new Date()));
				dto.setDakNo(DakNo);
				result2=dakservice.InsertDakAssignReply(dto);
				if(result2>0) {
					long updateAssignStatus=dakservice.updateAssignStatus(Long.parseLong(DakAssignId));
				}else {
				}
				EnoteMarkerReplyData=dakservice.EnoteAssignReplyData(Long.parseLong(dakId),EmpId);
            }
			
			String InitiatedBy=req.getParameter("InitiatedBy");
			String DakAssignReplyId=EnoteMarkerReplyData[7].toString();
			String Subject=req.getParameter("Subject");
			
			
			Enote enote=new Enote();
			enote.setDakId(Long.parseLong(dakId));
			enote.setDakNo(DakNo);
			enote.setRefNo(RefNo);
			enote.setNoteNo(NoteNo);
			enote.setDakReplyId(Long.parseLong(DakAssignReplyId));
			enote.setRefDate(new java.sql.Date(sdf.parse(RefDate).getTime()));
			enote.setSubject(Subject);
			enote.setReply(Reply);
			enote.setEnoteType("I");
			enote.setIsDak("Y");
			enote.setEnoteFrom(EnoteFrom);
			enote.setEnoteStatusCode("INI");
			enote.setEnoteStatusCodeNext("INI");
			enote.setLabCode(LabCode);
			enote.setIsDraft(IsDraftVal);
			if(IsDraftVal!=null && IsDraftVal.equalsIgnoreCase("Y")) {
			enote.setLetterDate(new java.sql.Date(sdf.parse(letterDate).getTime()));
			enote.setDestinationId(Long.parseLong(DestinationId));
			enote.setDestinationTypeId(Long.parseLong(DestinationTypeId));
			enote.setDraftContent(DraftContent);
			enote.setSignatory(Long.parseLong(Signatory));
			enote.setLetterHead(LetterHead);
			}
			enote.setDivisionCode(DivisionCode);
			enote.setInitiatedBy(Long.parseLong(InitiatedBy));	
			enote.setCreatedBy(req.getUserPrincipal().getName());
			enote.setCreatedDate(sdf1.format(new Date()));
			enote.setIsActive(1);
			EnoteDto dto=EnoteDto.builder().enote(enote).dakReplyEnoteDocument(dakReplyEnoteDocument).build();
			result=service.InsertDakReplyEnote(dto,DakAssignReplyId,EmpId,EnoteFrom,LabCode);
			if(result >0) {
				redir.addAttribute("eNoteId", result);
				redir.addAttribute("IntiatePreview", "AddEdit");
				redir.addAttribute("EnoteRoSoEdit", "EnoteRoSoAdd");
				return "redirect:/DakEnoteReplyPreview.htm";
			}
			else {
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"DakEnoteReplyAddSubmit.htm"+e);
			return null;
		}
		return "Enote/DakEnoteReplyPreview";
	}
	
	
	@RequestMapping(value = "DakEnoteReplyPreview.htm" , method = {RequestMethod.GET,RequestMethod.POST})
	public String DakEnoteReplyPreview(HttpServletRequest req,HttpServletResponse resp,HttpSession ses)  throws Exception{
		logger.info(new Date() +"DakEnoteReplyPreview.htm"+req.getUserPrincipal().getName());
		Object[] DakEnotePreview=null;
		long EmpId=(Long)ses.getAttribute("EmpId");
		String LabCode = (String) ses.getAttribute("LabCode");
		long DakReplyAttachmentCount=0;
		try {
			
			String result=req.getParameter("eNoteId");
			String ViewFrom=req.getParameter("ViewFrom");
			String IntiatePreview=req.getParameter("IntiatePreview");
			String Approval=req.getParameter("Approval");
			String preview=req.getParameter("preview");
			String SkipPreview=req.getParameter("SkipPreview");
			if(result!=null) {
				DakEnotePreview=service.DakEnotePreview(Long.parseLong(result));
				req.setAttribute("DakEnotePreview", DakEnotePreview);
				req.setAttribute("RecommendingOfficerList",service.RecommendingOfficerList(LabCode));
				req.setAttribute("EnoteRoSoRoledetails", service.EnoteRoSoRoledetails(Long.parseLong(result)));
			}
			Object[] DakRecommendingDetails=service.DakRecommendingDetails(Long.parseLong(result));
			if(DakEnotePreview!=null && DakEnotePreview[29]!=null && DakEnotePreview[29].toString().equalsIgnoreCase("C")) {
				DakReplyAttachmentCount=service.DakReplyAttachmentCount(Long.parseLong(DakEnotePreview[26].toString()));
			}else if(DakEnotePreview!=null && DakEnotePreview[29]!=null && DakEnotePreview[29].toString().equalsIgnoreCase("M")){
				DakReplyAttachmentCount=service.DakMarkerReplyAttachmentCount(Long.parseLong(DakEnotePreview[26].toString()));
			}
			List<Object[]> DakENoteReplyReturnRemarks=service.DakENoteReplyReturnRemarks(result);
			req.setAttribute("DakENoteReplyReturnRemarks", DakENoteReplyReturnRemarks);
			req.setAttribute("DakReplyAttachmentCount", DakReplyAttachmentCount);
			req.setAttribute("DakRecommendingDetails", DakRecommendingDetails);
			req.setAttribute("IntiatePreview", IntiatePreview);
			req.setAttribute("Approval", Approval);
			req.setAttribute("preview", preview);
			req.setAttribute("ViewFrom", ViewFrom);
			req.setAttribute("SkipPreview", SkipPreview);
			Path imgfile=Paths.get(env.getProperty("file_upload_path"), "Letter","drdo.png");
			File drdoimageFile = imgfile.toFile();
			ImageData drdoLogo = null;
			if (drdoimageFile.exists()) {
		        drdoLogo = ImageDataFactory.create(drdoimageFile.getAbsolutePath());
		        byte[] imageBytes = FileUtils.readFileToByteArray(drdoimageFile);
		        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
		        req.setAttribute("lablogo", base64Image);
		    }
			Object[] letterDocumentdata = service.letterDocumentData(result);
			if(letterDocumentdata!=null) {
				req.setAttribute("letterDocumentdata", letterDocumentdata);
			}
			Object[] WordDocumentData=service.WordDocumentData(Long.parseLong(result));
			if(WordDocumentData!=null) {
				req.setAttribute("WordDocumentData", WordDocumentData);
			}
			String EnoteRoSoEdit=req.getParameter("EnoteRoSoEdit");
			if(EnoteRoSoEdit!=null) {
				req.setAttribute("EnoteRoSoEdit", EnoteRoSoEdit);
			}
			return "Enote/DakEnoteReplyPreview";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	@RequestMapping(value = "getDakEnoteiframepdf.htm", method = {RequestMethod.GET , RequestMethod.POST})
	public @ResponseBody String getDakEnoteiframepdf(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
	{
		
		logger.info(new Date() +"Inside getDakEnoteiframepdf.htm "+req.getUserPrincipal().getName());
		List<String> iframe=new ArrayList<>();
		try {
			
			String eNoteAttachId = req.getParameter("data");
	        Object[] enoteattachmentdata = service.DakEnoteAttachmentData(eNoteAttachId);
	        File my_file = null;
	        String enoteattachdata = enoteattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = enoteattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+enoteattachmentdata[1]);
	         res.setHeader("Content-disposition", "inline; filename=" + enoteattachmentdata[1].toString());
	         iframe.add(FilenameUtils.getExtension(enoteattachmentdata[1]+""));
	         String pdf=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(my_file));
	         String FileName=(String)enoteattachmentdata[1];
	         iframe.add(pdf);
	         iframe.add(FileName);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside getDakEnoteiframepdf.htm "+req.getUserPrincipal().getName(), e);
		}
		Gson json = new Gson();
		return json.toJson(iframe);
	}
	
	
	@RequestMapping(value = "DakEnoteAttachDelete.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
	public String DakEnoteAttachDelete(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
	{

		logger.info(new Date() +"Inside DakEnoteAttachDelete.htm "+ req.getUserPrincipal().getName());
		String preview=req.getParameter("preview");
		try
		{
			String EnoteAttachId = req.getParameter("EnoteAttachmentIdforDelete");
			String DakId=req.getParameter("DakId");
			String DakEnoteReplyId=req.getParameter("eNoteId");
			String DakAssignReplyId=req.getParameter("DakAssignReplyId");
			int deleteResult = 0;
			String IntiatePreview=req.getParameter("IntiatePreview");
			String Approval=req.getParameter("Approval");
			
			String ViewFrom=req.getParameter("ViewFrom");
			String SkipPreview=req.getParameter("SkipPreview");
			List<Object[]> EnoteDakReplyAttachmentData = null;
			if(EnoteAttachId!=null && DakId!=null ) {
				EnoteDakReplyAttachmentData  = service.DakEnoteAttachmentData(Long.parseLong(EnoteAttachId),Long.parseLong(DakId));
			}
			if(EnoteDakReplyAttachmentData!=null && EnoteDakReplyAttachmentData.size() > 0) {
			
				Object[] data =  EnoteDakReplyAttachmentData.get(0);
				File my_file=null;
				String enoteattachdata = data[0].toString().replaceAll("[/\\\\]", ",");
	    		String[] fileParts = enoteattachdata.split(",");
		        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+data[1]);
				boolean result = Files.deleteIfExists(my_file.toPath());
				
			if(result) 
			{
				deleteResult = service.DeleteDakEnoteAttachment(EnoteAttachId);
				if(deleteResult>0) {
					redir.addAttribute("result","Document Deleted Successfully");
				
				}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful"); }
				
			}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful in Folder"); }
			
			}else { redir.addAttribute("resultfail","Document not found"); }
			
			if(DakEnoteReplyId!=null) {
			redir.addAttribute("eNoteId", DakEnoteReplyId);
			}
			
			if(DakAssignReplyId!=null) {
			redir.addAttribute("DakAssignReplyId", DakAssignReplyId);
			}
			
			if(DakId!=null) {
			redir.addAttribute("DakId", DakId);
			}
			
			if(IntiatePreview!=null) {
			redir.addAttribute("IntiatePreview", IntiatePreview);
			}
			if(Approval!=null) {
				redir.addAttribute("Approval", Approval);
			}
			
			if(ViewFrom!=null) {
				redir.addAttribute("ViewFrom" , ViewFrom);
			}
			
			if(SkipPreview!=null) {
				redir.addAttribute("SkipPreview", SkipPreview);
			}
		}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside DakEnoteAttachDelete.htm "+ req.getUserPrincipal().getName(),e);
		}
		if(req.getParameter("redirval")!=null && req.getParameter("redirval").equalsIgnoreCase("DakEnoteAdd")) {
		return "redirect:/DakEnoteAdd.htm";
		}else if(req.getParameter("redirval")!=null && req.getParameter("redirval").equalsIgnoreCase("DakEnotePreview")) {
			if(preview!=null) {
				redir.addAttribute("preview", preview);
			}
			return "redirect:/DakEnoteReplyPreview.htm";
		}else {
			return "redirect:/EnoteEdit.htm";
		}
		
	}
	
	
	@RequestMapping(value = "GetEnoteAssignReplyAttachmentDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String GetEnoteAssignReplyAttachmentDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
	{
		
		logger.info(new Date() +"Inside GetEnoteAssignReplyAttachmentDetails.htm "+req.getUserPrincipal().getName());
		List<Object[]> AttachmentData =new ArrayList<Object[]>();
		try {
			AttachmentData = dakservice.EnoteAssignReplyAttachmentData(Long.parseLong(req.getParameter("DakId")));
			req.setAttribute("AttachmentData", AttachmentData);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetEnoteAssignReplyAttachmentDetails.htm "+req.getUserPrincipal().getName(), e);
		}
		Gson json = new Gson();
		return json.toJson(AttachmentData);
	}
	
	
	@RequestMapping(value= "DakEnoteReplyEditSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String DakEnoteReplyEditSubmit(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir, @RequestPart(name = "dakReplyEnoteDocument", required = false) MultipartFile[] dakReplyEnoteDocument) throws Exception {
		logger.info(new Date() +"DakEnoteReplyEditSubmit.htm"+req.getUserPrincipal().getName());
		long EmpId=(Long)ses.getAttribute("EmpId");
		long result=0;
		try {
			String DakEnoteReplyId=req.getParameter("eNoteId");
			String DakId=req.getParameter("DakId");
			String DakNo=req.getParameter("DakNo");
			String RefNo=req.getParameter("RefNo");
			String NoteNo=req.getParameter("NoteNo");
			String RefDate=req.getParameter("RefDate");
			String Reply=req.getParameter("Reply");
			String InitiatedBy=req.getParameter("InitiatedBy");
			String DakAssignReplyId=req.getParameter("DakAssignReplyId");
			String Subject=req.getParameter("Subject");
			String letterDate=req.getParameter("LetterDate");
			String DestinationId=req.getParameter("DestinationId");
			String DestinationTypeId=req.getParameter("DestinationTypeId");
			String DraftContent=req.getParameter("DraftContent");
			String Signatory=req.getParameter("Signatory");
			String LetterHead=req.getParameter("LetterHead");
			
			EnoteDto dto=new EnoteDto();
			dto.setEnoteId(Long.parseLong(DakEnoteReplyId));
			dto.setDakReplyId(Long.parseLong(DakAssignReplyId));
			dto.setDakId(Long.parseLong(DakId));
			dto.setDakNo(DakNo);;
			dto.setNoteNo(NoteNo);
			dto.setRefNo(RefNo);
			dto.setSubject(Subject);
			dto.setRefDate(new java.sql.Date(sdf.parse(RefDate).getTime()));
			dto.setReply(Reply);
			dto.setLetterDate(new java.sql.Date(sdf.parse(letterDate).getTime()));
			dto.setDestinationId(Long.parseLong(DestinationId));
			dto.setDestinationTypeId(Long.parseLong(DestinationTypeId));
			dto.setDraftContent(DraftContent);
			dto.setSignatory(Long.parseLong(Signatory));
			dto.setLetterHead(LetterHead);
			dto.setInitiatedBy(Long.parseLong(InitiatedBy));	
			dto.setModifiedBy(req.getUserPrincipal().getName());
			dto.setModifiedDate(sdf1.format(new Date()));
			dto = EnoteDto.builder()
			        .EnoteId(dto.getEnoteId())
			        .DakReplyId(dto.getDakReplyId())
			        .DakId(dto.getDakId())
			        .DakNo(dto.getDakNo())
			        .NoteNo(dto.getNoteNo())
			        .RefNo(dto.getRefNo())
			        .RefDate(dto.getRefDate())
			        .Reply(dto.getReply())
			        .Subject(dto.getSubject())
			        .LetterDate(dto.getLetterDate())
			        .DestinationId(dto.getDestinationId())
			        .DestinationTypeId(dto.getDestinationTypeId())
			        .DraftContent(dto.getDraftContent())
			        .Signatory(dto.getSignatory())
			        .LetterHead(dto.getLetterHead())
			        .InitiatedBy(dto.getInitiatedBy())
			        .ModifiedBy(dto.getModifiedBy())
			        .ModifiedDate(dto.getModifiedDate())
			        .dakReplyEnoteDocument(dakReplyEnoteDocument)
			        .build();
			result=service.UpdateEnoteReply(dto,EmpId);
			
			if(result >0) {
				redir.addAttribute("eNoteId", result);
				redir.addAttribute("EnoteRoSoEdit", "EnoteRoSoEdit");
				redir.addAttribute("IntiatePreview", "AddEdit");
				return "redirect:/DakEnoteReplyPreview.htm";
			}
			else {
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"DakEnoteReplyAddSubmit.htm"+e);
			return null;
		}
		return "Enote/DakEnoteReplyPreview";
	}
	
	@RequestMapping(value = "getDakMarkingEnoteiframepdf.htm", method = {RequestMethod.GET , RequestMethod.POST})
	public @ResponseBody String getDakMarkingEnoteiframepdf(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
	{
		
		logger.info(new Date() +"Inside getDakMarkingEnoteiframepdf.htm "+req.getUserPrincipal().getName());
		List<String> iframe=new ArrayList<>();
		try {
			
			String eNoteAttachId = req.getParameter("data");
	        Object[] enoteattachmentdata = service.DakMarkingEnoteAttachmentData(eNoteAttachId);
	        File my_file = null;
	        String enoteattachdata = enoteattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = enoteattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+enoteattachmentdata[1]);
	         res.setHeader("Content-disposition", "inline; filename=" + enoteattachmentdata[1].toString());
	         iframe.add(FilenameUtils.getExtension(enoteattachmentdata[1]+""));
	         String pdf=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(my_file));
	         String FileName=(String)enoteattachmentdata[1];
	         iframe.add(pdf);
	         iframe.add(FileName);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside getDakMarkingEnoteiframepdf.htm "+req.getUserPrincipal().getName(), e);
		}
		Gson json = new Gson();
		return json.toJson(iframe);
	}
	
	
	@RequestMapping(value = "DakMarkerEnoteAttachDelete.htm" ,method = {RequestMethod.GET,RequestMethod.POST})
	public String DakMarkerEnoteAttachDelete(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
	{

		logger.info(new Date() +"Inside DakMarkerEnoteAttachDelete.htm "+ req.getUserPrincipal().getName());
		try
		{											
			String EnoteAttachId = req.getParameter("EnoteAttachmentIdforDelete");
			String DakReplyId=req.getParameter("DakReplyId");
			String DakEnoteReplyId=req.getParameter("eNoteId");
			String DakAssignReplyId=req.getParameter("DakAssignReplyId");
			String DakId=req.getParameter("DakId");
			String ViewFrom=req.getParameter("ViewFrom");
			String SkipPreview=req.getParameter("SkipPreview");
			String preview=req.getParameter("preview");

			int deleteResult = 0;
			String IntiatePreview=req.getParameter("IntiatePreview");
			String Approval=req.getParameter("Approval");
			
			List<Object[]> EnoteDakMarkerReplyAttachmentData = null;
			if(EnoteAttachId!=null && DakReplyId!=null ) {
				EnoteDakMarkerReplyAttachmentData  = service.DakEnoteMarkerAttachmentData(Long.parseLong(EnoteAttachId),Long.parseLong(DakReplyId));
			}
			if(EnoteDakMarkerReplyAttachmentData!=null && EnoteDakMarkerReplyAttachmentData.size() > 0) {
			
				Object[] data =  EnoteDakMarkerReplyAttachmentData.get(0);
				File my_file=null;
				String dakmarkerenoteattachdata = data[0].toString().replaceAll("[/\\\\]", ",");
	    		String[] fileParts = dakmarkerenoteattachdata.split(",");
		        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+fileParts[1]+File.separator+data[1]);
				boolean result = Files.deleteIfExists(my_file.toPath());
				
			if(result) 
			{
				deleteResult = service.DeleteMarkerDakEnoteAttachment(EnoteAttachId);
				if(deleteResult>0) {
					redir.addAttribute("result","Document Deleted Successfully");
				
				}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful"); }
				
			}else{ redir.addAttribute("resultfail","Document Delete Unsuccessful in Folder"); }
			
			}else { redir.addAttribute("resultfail","Document not found"); }
			
			    if(DakEnoteReplyId!=null) {
				redir.addAttribute("eNoteId", DakEnoteReplyId);
				}
				
				if(DakAssignReplyId!=null) {
				redir.addAttribute("DakAssignReplyId", DakAssignReplyId);
				}
				
				if(DakId!=null) {
				redir.addAttribute("DakId", DakId);
				}
				
				if(IntiatePreview!=null) {
				redir.addAttribute("IntiatePreview", IntiatePreview);
				}
				if(Approval!=null) {
					redir.addAttribute("Approval", Approval);
				}
				
				if(ViewFrom!=null) {
					redir.addAttribute("ViewFrom" , ViewFrom);
				}
				
				if(SkipPreview!=null) {
					redir.addAttribute("SkipPreview", SkipPreview);
				}
				
				if(preview!=null) {
					redir.addAttribute("preview", preview);
				}
		}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside DakMarkerEnoteAttachDelete.htm "+ req.getUserPrincipal().getName(),e);
		}
		if(req.getParameter("redirval")!=null && req.getParameter("redirval").equalsIgnoreCase("DakEnoteAdd")) {
		return "redirect:/DakEnoteMarkerAdd.htm";
		}else if(req.getParameter("redirval")!=null && req.getParameter("redirval").equalsIgnoreCase("DakEnotePreview")) {
			return "redirect:/DakEnoteReplyPreview.htm";
		}else {
			return "redirect:/EnoteEdit.htm";
		}
	}
	
	
	@RequestMapping(value = "GetEnoteMarkerReplyAttachmentDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String GetEnoteMarkerReplyAttachmentDetails(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
	{
		
		logger.info(new Date() +"Inside GetEnoteMarkerReplyAttachmentDetails.htm "+req.getUserPrincipal().getName());
		List<Object[]> AttachmentData =new ArrayList<Object[]>();
		try {
			AttachmentData = dakservice.EnoteMarkerReplyAttachmentData(Long.parseLong(req.getParameter("ReplyId")));
			req.setAttribute("AttachmentData", AttachmentData);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetEnoteMarkerReplyAttachmentDetails.htm "+req.getUserPrincipal().getName(), e);
		}
		Gson json = new Gson();
		return json.toJson(AttachmentData);
	}
	
	
	@RequestMapping(value = "EnoteAttachmentDownload.htm", method = {RequestMethod.GET , RequestMethod.POST})
	public void EnoteAttachmentDownload(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside EnoteAttachmentDownload.htm "+UserId);		
		try {
			String eNoteAttachId = req.getParameter("eNoteAttachId");
			Object[] Enoteattachmentdata = service.EnoteAttachmentData(eNoteAttachId);
	        File my_file = null;
	        
	        String enoteattachdata = Enoteattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = enoteattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"eNote"+File.separator +fileParts[0]+File.separator+Enoteattachmentdata[1]);
	        res.setHeader("Content-disposition", "attachment; filename=" + Enoteattachmentdata[1].toString());
	        String mimeType = getEnoteMimeType(my_file.getName()); 
	        res.setContentType(mimeType);
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0) {
	            out.write(buffer, 0, length);
	        }
	        out.close();
	        in.close();
		}
		catch(Exception e) {	    		
			logger.error(new Date() +" Inside EnoteAttachmentDownload.htm "+UserId, e);
			e.printStackTrace();
		}	
	}
	
	
	@RequestMapping(value = "DakEnoteMarkerAttachmentDownload.htm", method = {RequestMethod.GET , RequestMethod.POST})
	public void DakEnoteMarkerAttachmentDownload(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DakEnoteMarkerAttachmentDownload.htm "+UserId);		
		try {
			String eNoteAttachId = req.getParameter("eNoteAttachId");
			Object[] enoteattachmentdata = service.DakMarkingEnoteAttachmentData(eNoteAttachId);
			File my_file = null;
			String enoteattachdata = enoteattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = enoteattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+enoteattachmentdata[1]);
			res.setHeader("Content-disposition", "attachment; filename=" + enoteattachmentdata[1].toString());
			String mimeType = getEnoteMimeType(my_file.getName()); 
			res.setContentType(mimeType);
			OutputStream out = res.getOutputStream();
			FileInputStream in = new FileInputStream(my_file);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			out.close();
			in.close();
		}
		catch(Exception e) {	    		
			logger.error(new Date() +" Inside DakEnoteMarkerAttachmentDownload.htm "+UserId, e);
			e.printStackTrace();
		}	
	}
	
	
	@RequestMapping(value = "DakEnoteCaseWorkerAttachmentDownload.htm", method = {RequestMethod.GET , RequestMethod.POST})
	public void DakEnoteCaseWorkerAttachmentDownload(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DakEnoteCaseWorkerAttachmentDownload.htm"+UserId);		
		try {
			String eNoteAttachId = req.getParameter("eNoteAttachId");
			Object[] enoteattachmentdata = service.DakEnoteAttachmentData(eNoteAttachId);
			File my_file = null;
			String enoteattachdata = enoteattachmentdata[0].toString().replaceAll("[/\\\\]", ",");
    		String[] fileParts = enoteattachdata.split(",");
	        my_file = new File(env.getProperty("file_upload_path")+File.separator+"Dak"+File.separator +fileParts[0]+File.separator+enoteattachmentdata[1]);
			res.setHeader("Content-disposition", "attachment; filename=" + enoteattachmentdata[1].toString());
			String mimeType = getEnoteMimeType(my_file.getName()); 
			res.setContentType(mimeType);
			OutputStream out = res.getOutputStream();
			FileInputStream in = new FileInputStream(my_file);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			out.close();
			in.close();
		}
		catch(Exception e) {	    		
			logger.error(new Date() +" Inside DakEnoteCaseWorkerAttachmentDownload.htm"+UserId, e);
			e.printStackTrace();
		}	
	}
	
	
	@RequestMapping(value = "eNoteRosoUpdate.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String eNoteRosoDelete(HttpServletRequest req, HttpServletResponse response, HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		logger.info(new Date() +"Inside eNoteRosoUpdate.htm "+req.getUserPrincipal().getName());
		try {
			String[] eNoteRosoUpdateId=req.getParameter("eNoteRosoUpdateId").split("-");
			long updateRosoId=service.updateRosoId(eNoteRosoUpdateId);
			if (updateRosoId > 0) {
				redir.addAttribute("result", "Recommending Officer Updated Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Recommending Officer Update Unsuccessful");	
			}	
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside eNoteRosoUpdate.htm "+req.getUserPrincipal().getName(), e);
		}
		
		return "redirect:/DakEnoteRoSoList.htm";
	}
	
	@RequestMapping(value = "LetterDocDownload.htm", method = {RequestMethod.GET , RequestMethod.POST})
	public void LetterDocDownload(HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LetterDocumentDownload.htm "+UserId);		
		try {
			    String letterDocumentId = req.getParameter("LetterDocumentId");
		        Object[] letterDocumentdata = service.letterDocumentData(letterDocumentId);
		        File my_file = null;
		        my_file = new File(env.getProperty("file_upload_path")+ File.separator+"Letter" + File.separator +letterDocumentdata[0]+"_"+"Documents"+File.separator+letterDocumentdata[1]);  //this will automatically download
		        res.setHeader("Content-disposition", "inline; filename=" + letterDocumentdata[1].toString());
		        
		        String mimeType = getEnoteMimeType(my_file.getName()); 
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
		}catch(Exception e) {	    		
			logger.error(new Date() +" Inside LetterDocumentDownload.htm "+UserId, e);
			e.printStackTrace();
		}	
	}
	
	
	@RequestMapping(value= "EnoteDocumentUpload.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String EnoteDocumentUpload(HttpServletRequest req,HttpServletResponse res, HttpSession ses,RedirectAttributes redir, @RequestPart(name = "UploadDocument", required = false) MultipartFile UploadDocument) throws Exception {
		logger.info(new Date() +"EnoteDocumentUpload.htm"+req.getUserPrincipal().getName());
		String UserId = (String) ses.getAttribute("Username");
		long EmpId=(Long)ses.getAttribute("EmpId");
		long result=0;
		try {
			String EnoteId=req.getParameter("EnoteIdForUpload");
			String letterNo=req.getParameter("LetterNoForUpload");
			
			String ReplyPersonSentMail=req.getParameter("ReplyPersonSentMail");
	    	String[] ReplyReceivedMail=req.getParameterValues("ReplyReceivedMail");
	    	String HostType=req.getParameter("Mail");
	    	
			DakLetterDocDto dto=new DakLetterDocDto();
			dto.setCreatedBy(UserId);
			dto.setCreatedDate(sdf1.format(new Date()));
			dto.setLetterNo(letterNo);
			dto.setEnoteId(Long.parseLong(EnoteId));
			dto.setUploadDocument(UploadDocument);
			dto.setReplyPersonSentMail(ReplyPersonSentMail);
			dto.setReplyReceivedMail(ReplyReceivedMail);
			dto.setHostType(HostType);
			dto.setEmpId(EmpId);
			
			result=service.EnoteDocumentUpload(dto);
			if(result>0) {
				redir.addAttribute("result", "Document Uploaded Successfully ...!");
			}else {
				redir.addAttribute("resultfail", "Document Upload UnSuccessful ...!");
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"EnoteDocumentUpload.htm"+e);
			return null;
		}
		return "redirect:/ENoteList.htm";
	}
	
	@RequestMapping(value = "UploadedDocumentDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String UploadedDocumentDetails(HttpServletRequest req,HttpServletResponse res,HttpSession ses) {
		Object[] letterDocumentdata=null;
		try {
			String result=req.getParameter("eNoteId");
			letterDocumentdata= service.letterDocumentData(result);
			if(letterDocumentdata!=null) {
				req.setAttribute("letterDocumentdata", letterDocumentdata);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+"Inside the UploadedDocumentDetails.htm",e);
		}
		Gson json = new Gson();
		return json.toJson(letterDocumentdata);
	}
}
