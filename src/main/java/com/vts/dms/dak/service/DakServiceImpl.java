package com.vts.dms.dak.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.Future;

import jakarta.mail.Address;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import com.vts.dms.DateTimeFormatUtil;
import com.vts.dms.controller.CustomJavaMailSender;
import com.vts.dms.dak.dao.DakDao;
import com.vts.dms.dak.dto.DakAddDto;
import com.vts.dms.dak.dto.DakAssignDto;
import com.vts.dms.dak.dto.DakAssignReplyDto;
import com.vts.dms.dak.dto.DakAssignReplyRevDto;
import com.vts.dms.dak.dto.DakAttachmentDto;
import com.vts.dms.dak.dto.DakCreateAttachDto;
import com.vts.dms.dak.dto.DakDestinationDto;
import com.vts.dms.dak.dto.DakPnCReplyDto;
import com.vts.dms.dak.dto.DakReplyAttachDto;
import com.vts.dms.dak.dto.DakReplyDto;
import com.vts.dms.dak.dto.DakSeekResponseAttachDto;
import com.vts.dms.dak.dto.DakSeekResponseDto;
import com.vts.dms.dak.dto.MailDto;
import com.vts.dms.dak.dto.MarkDakDto;
import com.vts.dms.dak.model.AssignReplyAttachment;
import com.vts.dms.dak.model.DakAssign;
import com.vts.dms.dak.model.DakAssignReply;
import com.vts.dms.dak.model.DakAssignReplyAttachRev;
import com.vts.dms.dak.model.DakAssignReplyRev;
import com.vts.dms.dak.model.DakAttachment;
import com.vts.dms.dak.model.DakCreate;
import com.vts.dms.dak.model.DakCreateAttach;
import com.vts.dms.dak.model.DakCreateDestination;
import com.vts.dms.dak.model.DakCreateLink;
import com.vts.dms.dak.model.DakLink;
import com.vts.dms.dak.model.DakMail;
import com.vts.dms.dak.model.DakMailAttach;
import com.vts.dms.dak.model.DakMailSent;
import com.vts.dms.dak.model.DakMailSentAttach;
import com.vts.dms.dak.model.DakMain;
import com.vts.dms.dak.model.DakMarked;
import com.vts.dms.dak.model.DakMarking;
import com.vts.dms.dak.model.DakMember;
import com.vts.dms.dak.model.DakMemberType;
import com.vts.dms.dak.model.DakNotification;
import com.vts.dms.dak.model.DakPnCReply;
import com.vts.dms.dak.model.DakPnCReplyAttach;
import com.vts.dms.dak.model.DakProData;
import com.vts.dms.dak.model.DakRemind;
import com.vts.dms.dak.model.DakReply;
import com.vts.dms.dak.model.DakReplyAttach;
import com.vts.dms.dak.model.DakSeekResponse;
import com.vts.dms.dak.model.DakTransaction;
import com.vts.dms.dak.model.SeekResponseReplyAttachment;
import com.vts.dms.dao.DmsDao;
import com.vts.dms.dto.MailConfigurationDto;
import com.vts.dms.master.model.NonProjectMaster;
import com.vts.dms.master.model.OtherProjectMaster;
import com.vts.dms.master.model.Source;
import com.vts.dms.model.DakMailTracking;
import com.vts.dms.model.DakMailTrackingInsights;
import com.vts.dms.service.DmsServiceImp;


@Service
public class DakServiceImpl  implements DakService{
    private static final Logger logger=LogManager.getLogger(DakServiceImpl.class);
    private  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
    DateTimeFormatUtil dtf=new DateTimeFormatUtil();
    
    @Autowired
    private CustomJavaMailSender customJavaMailSender;
    
	
    @Autowired
	DakDao dao;
    
    @Autowired
    DmsServiceImp dmsser;
    
    @Autowired
    DmsDao dmsdao;
    
    
    @Autowired
    private Environment env;
	
	@Override
	public List<Object[]> SourceList() throws Exception {
		
		return dao.SourceList();
	}

	@Override
	public List<Object[]> DakDeliveryList() throws Exception {
		
		return dao.DakDeliveryList();
	}

	@Override
	public List<Object[]> getLetterTypeList() throws Exception {
		
		return dao.getLetterTypeList();
	}

	@Override
	public List<Object[]> getPriorityList() throws Exception {
		return dao.getPriorityList();
	}

	@Override
	public List<Object[]> getRelaventList(String lab) throws Exception {
		
		return dao.getRelaventList(lab);
	}
	


public static void saveFile(String uploadpath, String fileName, MultipartFile multipartFile) throws IOException 
{
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


public static int saveFile1(Path uploadPath, String fileName, MultipartFile multipartFile) throws IOException {
	logger.info(new Date() + "Inside SERVICE saveFile ");
	int result = 1;

	if (!Files.exists(uploadPath)) {
		Files.createDirectories(uploadPath);
	}
	try (InputStream inputStream = multipartFile.getInputStream()) {
		Path filePath = uploadPath.resolve(fileName);
		Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	} catch (IOException ioe) {
		result = 0;
		throw new IOException("Could not save image file: " + fileName, ioe);
	} catch (Exception e) {
		result = 0;
		logger.error(new Date() + "Inside SERVICE saveFile " + e);
		e.printStackTrace();
	}
	return result;
}

	
	@Override
	public long insertDak(DakAddDto dakdto,long empid,String[] resultArray,String[] DakLinkId) throws Exception {
		DakMain dak = dakdto.getDak();
		DakAttachmentDto dakdto1 = new DakAttachmentDto();
		/***************old code of DAK No creation start*************************/
		/***************new code of DAK No creation start*************************/
		//(DAK No will start with D and than date Month Year and this will change each day and than _ 001 and this number restarts again each day after 10 clock)
		 SimpleDateFormat RequiredFormat = new SimpleDateFormat("ddMMMyy");
		 String DayMonYear = RequiredFormat.format(new Date()); //currentDate
		 String DakStr = "D"+DayMonYear+"_";
		 long count;
		// Determine the desired width of the count (e.g., 3 for "001")
		 int width = 3;
         long DakIdcount=dao.DakCountFrDakNoCreation();
		 //This count will start with 001 after new day starts
		 //Ex if current date is 08/08/23 and we will check DAK counts by comparing current date with all created dates of dak
		 // if it returns>0 then than DakIdcount+1;
		 // if it returns<0 then than DakIdcount i.e 001;
		 if(DakIdcount>0) {
			 count = DakIdcount+1;
		 }else {
			 count = 1;
		 }
		 
		// Format the count with leading zeros
		 String formattedCount = String.format("%0" + width + "d", count);
		 
		 String NewDakNo = dak.getDivisionCode().toString()+"_"+ DakStr+formattedCount;
	     dak.setDakNo(NewDakNo);
	    /***************new code of DAK No creation end*************************/
		
	     
		long DakId=dao.insertDak(dak); 
		
		if(DakId>0) {
			DakProData pro=new DakProData();
			pro.setDakId(DakId);
			pro.setProjectId(dak.getProjectId());
			pro.setCreatedBy(dak.getCreatedBy());
			pro.setCreatedDate(dak.getCreatedDate());
			dao.getDakProInsert(pro);
			if(DakLinkId!=null)
			for(int i=0;i<DakLinkId.length;i++) {
					DakLink link=new DakLink();
					link.setDakId(DakId);
					link.setLinkDakId(Long.parseLong(DakLinkId[i]));
					link.setCreatedBy(dak.getCreatedBy());
					link.setCreatedDate(dak.getCreatedDate());
					dao.getDakLinkDetails(link);
			}
		}
		DakTransaction trans=new DakTransaction();
		trans.setEmpId(empid);
		trans.setDakId(DakId);
		trans.setDakStatus("DI");
		trans.setTransactionDate(sdf1.format(new Date()));
		trans.setRemarks("NA");
        dao.getDakTransInsert(trans);
        
        if(!dakdto.getMainDoc().isEmpty()){
        	dakdto1.setDakId(DakId);
    		dakdto1.setFilePath(env.getProperty("file_upload_path"));
    		dakdto1.setCreatedBy(dak.getCreatedBy());
    		dakdto1.setCreatedDate(dak.getCreatedDate());
    		dakdto1.setFile(dakdto.getMainDoc());
    		dakdto1.setRefNo(dak.getRefNo());
    		dakdto1.setType("M");
    		dakdto1.setDakNo(dak.getDakNo());
    		
    		String dakNoPath = dakdto1.getDakNo().replace("/", "_"); // Replace '/' with '_'
        	String DynamicPath = Paths.get(dakNoPath, "Inbox").toString(); // Create the path with Inbox folder
    		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
    		int count1 = dao.GetAttachmentDetails(dakdto1.getDakId(),dakdto1.getType()).size()+1;
    		
    		File theDir = fullpath.toFile();
    		if (!theDir.exists()){
    		    theDir.mkdirs();
    		}
    		DakAttachment model = new DakAttachment();
    		model.setDakId(dakdto1.getDakId());
    		model.setIsMain(dakdto1.getType());
    		model.setFilePath(DynamicPath);
    		model.setFileName(dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename());
    		model.setCreatedBy(dakdto1.getCreatedBy());
    		model.setCreatedDate(dakdto1.getCreatedDate());
    		
    		
    		saveFile1(fullpath, dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename(), dakdto1.getFile());
    		long result=dao.DakAttachmentFile(model);
    		
        }
		
        if(dakdto!=null && dakdto.getSubDoc()!=null && dakdto.getSubDoc().length>0 && !dakdto.getSubDoc()[0].isEmpty() ) {
        	for(MultipartFile file : dakdto.getSubDoc()) {
        		if(!file.isEmpty()) {
        			
        		DakAttachmentDto dakdto2 = new DakAttachmentDto();
        		dakdto2.setDakId(DakId);
        		dakdto2.setFilePath(env.getProperty("file_upload_path"));
        		dakdto2.setCreatedBy(dak.getCreatedBy());
        		dakdto2.setCreatedDate(dak.getCreatedDate());
        		dakdto2.setSubFile(dakdto.getSubDoc());
        		dakdto2.setRefNo(dak.getRefNo());
        		dakdto2.setType("S");
        		dakdto2.setDakNo(dak.getDakNo());
        		
        		String dakNoPath = dakdto1.getDakNo().replace("/", "_"); // Replace '/' with '_'
            	String DynamicPath = Paths.get(dakNoPath, "Inbox").toString(); // Create the path with Inbox folder
        		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
        		int count1 = dao.GetAttachmentDetails(dakdto2.getDakId(),dakdto2.getType()).size()+1;
        		
        		File theDir = fullpath.toFile();
        		if (!theDir.exists()){
        		    theDir.mkdirs();
        		}
        		DakAttachment model = new DakAttachment();
        		model.setDakId(dakdto2.getDakId());
        		model.setIsMain(dakdto2.getType());
        		model.setFilePath(DynamicPath);
        		model.setFileName(dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename());
        		model.setCreatedBy(dakdto2.getCreatedBy());
        		model.setCreatedDate(dakdto2.getCreatedDate());
        		
        		saveFile1(fullpath, dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename(),file);
        		long result=dao.DakAttachmentFile(model);
        		}
        	}
        }
        	if(resultArray!=null && resultArray.length>0) {
        	for(int i=0;i<resultArray.length;i++) {
        	 String[] EmpandMarkingValues = resultArray[i].split(",");

        	 String empId = EmpandMarkingValues[0];
       		 String markedTypeId = EmpandMarkingValues[1];
        		 
        	DakMarking marking=new DakMarking();
        	marking.setDakId(DakId);
        	marking.setEmpId(Long.parseLong(empId));
        	marking.setDakMemberTypeId(Long.parseLong(markedTypeId));
        	marking.setActionId(dak.getActionId());
        	marking.setReplyOpen(dak.getReplyOpen());
        	marking.setRemarkup("N");
        	marking.setActionDueDate(dak.getActionDueDate());
        	marking.setDakAckStatus("N");
        	marking.setDakAssignStatus("N");
        	marking.setMsgType("N");
        	marking.setFavourites(0);
        	marking.setCreatedBy(dak.getCreatedBy());
        	marking.setCreatedDate(dak.getCreatedDate());
        	marking.setIsActive(1);
        	dao.getDakMarkingInsert(marking);
        	}
        	}//Else Dak Marking can be done in Pending List/ DAK List/DAK Director List
		return DakId;
	}
	
	@Override
	public long GetCountPrjDirEmpIdInPrev(long PrjDirEmpId,long DakId)throws Exception{
		return dao.GetCountPrjDirEmpIdInPrev(PrjDirEmpId,DakId);
	}
	@Override
	public long DeletePrevPrjDirEmpId(long PrjDirEmpId,long DakId)throws Exception{
		return dao.DeletePrevPrjDirEmpId(PrjDirEmpId,DakId);
	}
	
	@Override
	public List<Object[]> DakPendingDistributionList(String DivisionCode,String LabCode,String UserName) throws Exception {
		
		return dao.DakPendingDistributionList(DivisionCode,LabCode,UserName);
	}

	@Override
	public long DakAttachmentFile(DakAttachmentDto dakdto) throws Exception {
        long result=0;
        
        String dakNoPath = dakdto.getDakNo().replace("/", "_"); // Replace '/' with '_'
    	String DynamicPath = Paths.get(dakNoPath, "Inbox").toString(); // Create the path with Inbox folder
		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
		Object DakAttachId=null;
		if(dakdto.getType()!=null && dakdto.getType().toString().equalsIgnoreCase("M")) {
			DakAttachId=dao.getDakAttachId(dakdto.getDakId(),dakdto.getType());
		}
		int count = dao.GetAttachmentDetails(dakdto.getDakId(),dakdto.getType()).size()+1;
		File theDir = fullpath.toFile();
		if (!theDir.exists()){
		    theDir.mkdirs();
		}
		DakAttachment model = new DakAttachment();
		model.setDakId(dakdto.getDakId());
		model.setIsMain(dakdto.getType());
		model.setFilePath(DynamicPath);
		if(dakdto.getType().equalsIgnoreCase("M")) {
		    model.setFileName(dakdto.getType()+"_"+dakdto.getFile().getOriginalFilename());
		}else{
			model.setFileName(dakdto.getType()+String.valueOf(count)+"_"+dakdto.getFile().getOriginalFilename());
		}
		model.setCreatedBy(dakdto.getCreatedBy());
		model.setCreatedDate(dakdto.getCreatedDate());
	
		if(DakAttachId!=null && dao.getDeletedAttachment(Long.parseLong(DakAttachId.toString()))>0) {
			if(count<=2&&dakdto.getType().equalsIgnoreCase("M")) {
				saveFile1(fullpath, dakdto.getType()+"_"+dakdto.getFile().getOriginalFilename(), dakdto.getFile());
				result=dao.DakAttachmentFile(model);
			}else if(dakdto.getType().equalsIgnoreCase("S") ) {
				saveFile1(fullpath, dakdto.getType()+String.valueOf(count)+"_"+dakdto.getFile().getOriginalFilename(), dakdto.getFile());
				result=dao.DakAttachmentFile(model);
			}
	        }else {
        	if(count<2&&dakdto.getType().equalsIgnoreCase("M")) {
    			saveFile1(fullpath, dakdto.getType()+"_"+dakdto.getFile().getOriginalFilename(), dakdto.getFile());
    			result=dao.DakAttachmentFile(model);
    		}else if(dakdto.getType().equalsIgnoreCase("S") ) {
    			saveFile1(fullpath, dakdto.getType()+String.valueOf(count)+"_"+dakdto.getFile().getOriginalFilename(), dakdto.getFile());
    			result=dao.DakAttachmentFile(model);
    		}
        }
		return result;
	}
	
	
	@Override
	public long DakEditAttachmentFile(DakAttachmentDto dakdto,DakAddDto dakdto1) throws Exception {
        long result=0;
        if(dakdto1.getMainDoc()!=null && !dakdto1.getMainDoc().isEmpty()){
        	String dakNoPath = dakdto.getDakNo().replace("/", "_"); // Replace '/' with '_'
        	String DynamicPath = Paths.get(dakNoPath, "Inbox").toString(); // Create the path with Inbox folder
    	Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
		int count = dao.GetAttachmentDetails(dakdto.getDakId(),dakdto.getType()).size()+1;
		File theDir = fullpath.toFile();
		if (!theDir.exists()){
		    theDir.mkdirs();
		}
		DakAttachment model = new DakAttachment();
		model.setDakId(dakdto.getDakId());
		model.setIsMain(dakdto.getType());
		model.setFilePath(DynamicPath);
		model.setFileName(dakdto.getType()+"_"+dakdto.getFile().getOriginalFilename());
		model.setModifiedBy(dakdto.getModifiedBy());
		model.setModifiedDate(dakdto.getModifiedDate());
       
		if(dakdto.getDakAttachmentId()!=null && dao.getDeletedAttachment(dakdto.getDakAttachmentId())>0) {
		if(count<=2&&dakdto.getType().equalsIgnoreCase("M")) {
			saveFile1(fullpath, dakdto.getType()+"_"+dakdto.getFile().getOriginalFilename(), dakdto.getFile());
			result=dao.DakAttachmentFile(model);
		
        }
		}else {
        	if(count<2&&dakdto.getType().equalsIgnoreCase("M")) {
    			saveFile1(fullpath, dakdto.getType()+"_"+dakdto.getFile().getOriginalFilename(), dakdto.getFile());
    			result=dao.DakAttachmentFile(model);
    		}
		}
        }else if(dakdto1!=null &&  dakdto1.getSubDoc()!=null && dakdto1.getSubDoc().length>0 && !dakdto1.getSubDoc()[0].isEmpty()) {
        	for(MultipartFile file : dakdto1.getSubDoc()) {
        		if(!file.isEmpty()) {
    			String dakNoPath = dakdto.getDakNo().replace("/", "_"); // Replace '/' with '_'
            	String DynamicPath = Paths.get(dakNoPath, "Inbox").toString(); // Create the path with Inbox folder
        	    Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
    		int count1 = dao.GetAttachmentDetails(dakdto.getDakId(),dakdto.getType()).size()+1;
    		
    		File theDir = fullpath.toFile();
    		if (!theDir.exists()){
    		    theDir.mkdirs();
    		}
    		DakAttachment model = new DakAttachment();
    		model.setDakId(dakdto.getDakId());
    		model.setIsMain(dakdto.getType());
    		model.setFilePath(DynamicPath);
    		model.setFileName(dakdto.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename());
    		model.setModifiedBy(dakdto.getModifiedBy());
    		model.setModifiedDate(dakdto.getModifiedDate());
    		saveFile1(fullpath, dakdto.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename(),file);
    		result=dao.DakAttachmentFile(model);
        		}
        }
        }
		return result;
	}

	public DakMain dakData(String dakId) throws Exception {
		
		return dao.dakData(Long.parseLong(dakId));
	}

	@Override
	public long saveDakEdit(String DakAttachmentId,DakAddDto dakdto,DakMain dak,String ActionCode,String[] DakLinkId,String[] resultArray) throws Exception {
		long result=0;
		    
			DakMain dakdata=dao.getDakIdDetails(dak.getDakId());
			dakdata.setDakId(dak.getDakId());
			dakdata.setSubject(dak.getSubject());
			dakdata.setDakNo(dak.getDakNo());
			dakdata.setRefNo(dak.getRefNo());
			dakdata.setReceiptDate(dak.getReceiptDate());
			dakdata.setRefDate(dak.getRefDate());
			dakdata.setSourceDetailId(dak.getSourceDetailId());
			dakdata.setSourceId(dak.getSourceId());
			dakdata.setProjectType(dak.getProjectType());
			dakdata.setPriorityId(dak.getPriorityId());
			dakdata.setSignatory(dak.getSignatory());
			dakdata.setDeliveryTypeId(dak.getDeliveryTypeId());
			dakdata.setLetterTypeId(dak.getLetterTypeId());
			dakdata.setProjectId(dak.getProjectId());
			dakdata.setKeyWord1(dak.getKeyWord1());
			dakdata.setKeyWord2(dak.getKeyWord2());
			dakdata.setKeyWord3(dak.getKeyWord3());
			dakdata.setKeyWord4(dak.getKeyWord4());
			dakdata.setRemarks(dak.getRemarks());
			dakdata.setActionId(dak.getActionId());
			
			
			if(ActionCode.equalsIgnoreCase("ACTION") && dak.getActionDueDate()!=null) {
				dakdata.setActionDueDate(dak.getActionDueDate());
				dakdata.setActionTime(dak.getActionTime());
				dakdata.setReplyOpen("Y");
				long updatedakmarking=dao.updatedakmarkingaction(dak.getDakId(),dak.getActionId(),sdf2.format(dak.getActionDueDate()));
				
			}else {
				dakdata.setActionDueDate(dak.getActionDueDate());
				dakdata.setActionTime(dak.getActionTime());
				dakdata.setReplyOpen("N");
				long updatedakmarking=dao.updatedakmarkingrecords(dak.getDakId(),dak.getActionId());
			
			}
			dakdata.setReplyStatus("N");
			dakdata.setDakStatus("DI");
			dakdata.setModifiedBy(dak.getModifiedBy());
			dakdata.setModifiedDate(dak.getModifiedDate());
			String ClosingAuthority = dak.getClosingAuthority();
			if(ClosingAuthority!=null && ClosingAuthority.trim()!="") {
				dakdata.setClosingAuthority(ClosingAuthority);
			}else {
				dakdata.setClosingAuthority("P");
			}
			
			dakdata.setIsActive(1);
			result=dao.saveDak(dakdata);
		    
			//LinK Add Code Starts
			if(result>0 && dao.DeletedDakLink(dak.getDakId())>0 && dao.getDeletedPro(dak.getDakId())>0) {
			for(int i=0;i<DakLinkId.length;i++) {
			DakLink link=new DakLink();
			link.setDakId(result);
			link.setLinkDakId(Long.parseLong(DakLinkId[i]));
			link.setCreatedBy(dak.getModifiedBy());
			link.setCreatedDate(dak.getModifiedDate());
			dao.getDakLinkDetails(link);
			}
		
			
			DakProData pro=new DakProData();
			pro.setDakId(result);
			pro.setProjectId(dak.getProjectId());
			pro.setCreatedBy(dak.getModifiedBy());
			pro.setCreatedDate(dak.getModifiedDate());
			dao.getDakProInsert(pro);

			}
	
	if( resultArray!=null && resultArray.length>0 ){
				for(int i=0;i<resultArray.length;i++) {
		       		 String[] EmpandMarkingValues = resultArray[i].split(",");

		       		 String empId = EmpandMarkingValues[0];
		       		 
		       		 String markedTypeId = EmpandMarkingValues[1];
		       		 
		       	    DakMarking marking=new DakMarking();
		       	    marking.setDakId(result);
		        	marking.setEmpId(Long.parseLong(empId));
		       	    marking.setDakMemberTypeId(Long.parseLong(markedTypeId));
		         	marking.setActionId(dak.getActionId());
		        	marking.setReplyOpen(dak.getReplyOpen());
		        	marking.setRemarkup("N");
		        	marking.setActionDueDate(dak.getActionDueDate());
		        	marking.setDakAckStatus("N");
		       	    marking.setDakAssignStatus("N");
		      	    marking.setMsgType("N");
		      	    marking.setFavourites(0);
		       	    marking.setCreatedBy(dak.getModifiedBy());
		         	marking.setCreatedDate(dak.getModifiedDate());
		       	    marking.setIsActive(1);
		           	dao.getDakMarkingInsert(marking);
				  }
			}

	if(dakdto.getMainDoc()!=null && !dakdto.getMainDoc().isEmpty()){
		 
		DakAttachmentDto dakdto1 = new DakAttachmentDto();
     	dakdto1.setDakId(dak.getDakId());
 		dakdto1.setFilePath(env.getProperty("file_upload_path"));
 		dakdto1.setModifiedBy(dak.getModifiedBy());
 		dakdto1.setModifiedDate(dak.getModifiedDate());
 		dakdto1.setFile(dakdto.getMainDoc());
 		dakdto1.setRefNo(dak.getRefNo());
 		dakdto1.setType("M");
 		dakdto1.setDakNo(dak.getDakNo());
 		if(DakAttachmentId!=null) {
 			 long DakAttachmentIdsel=Long.parseLong(DakAttachmentId);
 		dakdto1.setDakAttachmentId(DakAttachmentIdsel);
 		}
 		
 		String dakNoPath = dakdto1.getDakNo().replace("/", "_"); // Replace '/' with '_'
    	String DynamicPath = Paths.get(dakNoPath, "Inbox").toString(); // Create the path with Inbox folder
 		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
 		int count1 = dao.GetAttachmentDetails(dakdto1.getDakId(),dakdto1.getType()).size()+1;
 		
 		File theDir = fullpath.toFile();
 		if (!theDir.exists()){
 		    theDir.mkdirs();
 		}

 		DakAttachment model = new DakAttachment();
		model.setDakId(dakdto1.getDakId());
		model.setIsMain(dakdto1.getType());
		model.setFilePath(DynamicPath);
		model.setFileName(dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename());
		model.setModifiedBy(dakdto1.getModifiedBy());
		model.setModifiedDate(dakdto1.getModifiedDate());
		
		int AttachId=dao.getDeletedAttachment(Long.parseLong(DakAttachmentId));
		if(DakAttachmentId!=null && AttachId>0){
			if(count1<=2&&dakdto1.getType().equalsIgnoreCase("M")) {
				saveFile1(fullpath, dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename(), dakdto1.getFile());
				result=dao.DakAttachmentFile(model);
			
	        }
			}else {
	        	if(count1<2&&dakdto1.getType().equalsIgnoreCase("M")) {
	    			saveFile1(fullpath, dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename(), dakdto1.getFile());
	    			result=dao.DakAttachmentFile(model);
	    		}
			}  
	 }
	 
	 if(dakdto!=null && dakdto.getSubDoc()!=null && dakdto.getSubDoc().length>0 && !dakdto.getSubDoc()[0].isEmpty()) {
     	for(MultipartFile file : dakdto.getSubDoc()) {
     		if(!file.isEmpty()) {
     		DakAttachmentDto dakdto2 = new DakAttachmentDto();
     		dakdto2.setDakId(dak.getDakId());
     		dakdto2.setFilePath(env.getProperty("file_upload_path"));
     		dakdto2.setModifiedBy(dak.getModifiedBy());
     		dakdto2.setModifiedDate(dak.getModifiedDate());
     		dakdto2.setSubFile(dakdto.getSubDoc());
     		dakdto2.setRefNo(dak.getRefNo());
     		dakdto2.setType("S");
     		dakdto2.setDakNo(dak.getDakNo());
     		if(DakAttachmentId!=null) {
				   long DakAttachmentIdsel=Long.parseLong(DakAttachmentId);
				dakdto2.setDakAttachmentId(DakAttachmentIdsel);
				 }
     		String dakNoPath = dakdto2.getDakNo().replace("/", "_"); // Replace '/' with '_'
        	String DynamicPath = Paths.get(dakNoPath, "Inbox").toString(); // Create the path with Inbox folder
     		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
     		int count1 = dao.GetAttachmentDetails(dakdto2.getDakId(),dakdto2.getType()).size()+1;
     		
     		File theDir = fullpath.toFile();
     		if (!theDir.exists()){
     		    theDir.mkdirs();
     		}
     		DakAttachment model = new DakAttachment();
     		model.setDakId(dakdto2.getDakId());
     		model.setIsMain(dakdto2.getType());
     		model.setFilePath(DynamicPath);
     		model.setFileName(dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename());
     		model.setModifiedBy(dakdto2.getModifiedBy());
     		model.setModifiedDate(dakdto2.getModifiedDate());
     		
     		
     		saveFile1(fullpath, dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename(),file);
     		long count=dao.DakAttachmentFile(model);
     	}
     	}
     }
		return result;
	}

	@Override
	public List<Object[]> GetAttachmentDetails(long  dakid,String type) throws Exception {
		
		return dao.GetAttachmentDetails(dakid,type);
	}
	
	@Override
	public Object[] DakAttachmentData(String  dakattachmentid) throws Exception {
		
		return dao.DakAttachmentData(dakattachmentid);
	}

	@Override
	public int DeleteAttachment(String DakAttachmentId) throws Exception {

		return dao.DeleteAttachment(DakAttachmentId);
	}

	@Override
	public List<Object[]> getDakMembers() throws Exception {
	
		return dao.getDakMembers();
	}

	@Override
	public List<Object[]> EmployeeList() throws Exception {
		
		return dao.EmployeeList();
	}

	@Override
	public long markDak(MarkDakDto markDak) throws Exception {
		long result=0;
		int update=1;
		
		try{
			update=dao.getDeletedMarked(markDak.getDakId());
			if(markDak.getGroupId()!=null) {
				for(String groupid:markDak.getGroupId()){
				DakMarked mark=new DakMarked();
				mark.setDakId(Long.parseLong(markDak.getDakId()));
				mark.setDistributionType("G");
				mark.setDistributionTypeId(Long.parseLong(groupid));
				mark.setCreatedBy(markDak.getUserName());
				mark.setCreatedDate(sdf1.format(new Date()));
				result=dao.insertMarkedDak(mark);
				}}
				if(markDak.getEmpId()!=null) {
				for(String empid:markDak.getEmpId()){
					DakMarked mark=new DakMarked();
					mark.setDakId(Long.parseLong(markDak.getDakId()));
					mark.setDistributionType("I");
					mark.setDistributionTypeId(Long.parseLong(empid));
					mark.setCreatedBy(markDak.getUserName());
					mark.setCreatedDate(sdf1.format(new Date()));
					result=dao.insertMarkedDak(mark);
				}}
				
				DakTransaction trans=new DakTransaction();
				trans.setEmpId(markDak.getDEmpId());
				trans.setDakId(result);
				trans.setDakStatus("DOM");
				trans.setTransactionDate(sdf1.format(new Date()));
				trans.setRemarks("NA");
		        dao.getDakTransInsert(trans);
		        dao.getDakForwarded(markDak.getDakId(), markDak.getDEmpId(), markDak.getUserName(),"DOM");
		}catch (Exception e) {
			update=0;
			e.printStackTrace();
		}
		
		
		return result;
	}

	

	@Override
	public List<Object[]> DakMarkedList(String dakId) throws Exception {
		
		return dao.DakMarkedList(dakId);
	}

	
	@Override
	public List<Object[]> DakLinkList() throws Exception {
		
		return dao.DakLinkList();
	}

	@Override
	public List<Object[]> NonProjectList() throws Exception {
		
		return dao.NonProjectList();
	}
	
	@Override
	public List<DakMemberType> getAllMemberType()throws Exception{
		return dao.getAllMemberType();
	}
	@Override
	public List<Object[]> getAllMemberList(int i,String member,String lab)throws Exception{
		return dao.getAllMemberList(i,member,lab);
	}
	@Override
	public List<Object[]> getAllMemberList2(int i)throws Exception{
		return dao.getAllMemberList2(i);
	}
	
	@Override
	public long addDakMember(String memberType, String member,String UserName)throws Exception{
		DakMember member1 =new DakMember();
		member1.setDakmemberTypeId(Long.parseLong(memberType)) ;
		member1.setEmpId(member);
		member1.setIsActive(1);
		member1.setCreatedBy(UserName);
		member1.setCreatedDate(sdf1.format(new Date()));
		return dao.addDakMember(member1);
	}

	@Override
	public List<Object[]> getActionList() throws Exception {
		
		return dao.getActionList();
	}

	@Override
	public List<Object[]> getCwList() throws Exception {
		
		return dao.getCwList();
	}

	@Override
	public List<Object[]> getDivisionList() throws Exception {
		
		return dao.getDivisionList();
	}

	@Override
	public List<Object[]> getSelectEmpList(String[] empid,String lab) throws Exception {
		
		return dao.getSelectEmpList(empid,lab);
	}

	@Override
	public List<Object[]> getSelectDakEditList(String dakid) throws Exception {
		
		return dao.getSelectDakEditList(dakid);
	}
	

	@Override
	public List<Object[]> getReplyAttachDetails(long replyid,long empId ,String type) throws Exception {
		
		return dao.getReplyAttachDetails(replyid,empId ,type);
	}

	@Override
	public Object[] DakReplyAttachmentData(String DakReplyAttachmentId) throws Exception {
		
		return dao.DakReplyAttachmentData(DakReplyAttachmentId);
	}

	@Override
	public int DeleteReplyAttachment(String DakAttachmentId) throws Exception {
		return dao.DeleteReplyAttachment(DakAttachmentId);
	}

	@Override
	public List<Object[]> dakReceivedList(String fromDate ,String toDate,String statusValue,long EmpId,String Username) throws Exception {
		return dao.dakReceivedList(fromDate,toDate,statusValue,EmpId,Username);
	}
	
	@Override
	public List<Object[]> dakPendingReplyList(String fromDate ,String toDate,String StatusValue,long EmpId,String Username, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String employeeId) throws Exception {
		return dao.dakPendingReplyList(fromDate,toDate,StatusValue,EmpId,Username, lettertypeid, priorityid, sourcedetailid, sourceId, projectType, projectId, dakMemberTypeId, employeeId);
	}

	@Override
	public Object[] dakReceivedView(long empId, long dakId) throws Exception {
		return dao.dakReceivedView(empId,dakId);
	}

	@Override
	public List<Object[]> getDistributedEmps(String dakId) throws Exception {
		return dao.getDistributedEmps(dakId);
	}
	
	@Override
	public List<Object[]> getDistributedAssignedEmps(String dakId) throws Exception {
		return dao.getDistributedAssignedEmps(dakId);
	}

	@Override
	public List<Object[]> getFacilitatorsList(long MarkedEmpId,long dakId) throws Exception {
		return dao.getFacilitatorsList(MarkedEmpId,dakId);
	}

	@Override
	public String getPriorityOfParticularDak(long dakId) throws Exception {
		return dao.getPriorityOfParticularDak(dakId);
	}
	
	@Override
	public long DakDistribute(String dakId, String date,String[] EmpId,long MarkedEmpId,String username,String[] selectedCheck) throws Exception {
		
		Object[] UserName= null;
		UserName=dao.getUsername(MarkedEmpId);
		if(EmpId!=null && EmpId.length>0) {
			for(int i=0;i<EmpId.length;i++) {
			String[] EmpANDMarkingId = EmpId[i].split("/");
       		String empId = EmpANDMarkingId[0];
			DakNotification notification=new DakNotification();
			notification.setNotificationBy(MarkedEmpId);
			notification.setIsActive(1);
			notification.setCreatedBy(username);
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setNotificationMessage("DAK Distributed  by "+UserName[0].toString()+","+UserName[1].toString()+".");
			notification.setNotificationDate(sdf2.format(new Date()));
			notification.setEmpId(Long.parseLong(empId));
			notification.setNotificationUrl("DakReceivedList.htm");
			dao.DakNotificationInsert(notification);
		}
		}
		if(EmpId!=null && EmpId.length>0) {
			List<String> arrayList = new ArrayList<>(Arrays.asList(EmpId));
			List<String> arrayList1 = new ArrayList<>(Arrays.asList(selectedCheck));
			for (String item : arrayList) {
				 String[] parts = item.split("/");
				 if (parts.length == 2) { // Ensure there are two parts after splitting
	                String selectedEmpId = parts[0]; // Extract the value to compare
	                String selMarkedEmpId=parts[1];
	                if (arrayList1.contains(selectedEmpId)) {
	                   long updatemarkedactioninfo=dao.updatemarkedactioninfo(Long.parseLong(dakId),Long.parseLong(selectedEmpId),Long.parseLong(selMarkedEmpId),"A");
	                } else {
	                	long updatemarkedactioninfo=dao.updatemarkedactioninfo(Long.parseLong(dakId),Long.parseLong(selectedEmpId),Long.parseLong(selMarkedEmpId),"I");
	                }
		       }
			}
			
		}
		return dao.DakDistribute(dakId,date);
	}

	@Async
	public Future<Long> SendMailForMarkers(String dakId,long loggedInEmpId)throws Exception {
		logger.info(new Date() +"Inside SendMailForMarkers.htm ");
		Object[] DakDetails = null;
		long MailSendStatus1 = 0;
		long mailSendStatus2=0;
		try {
		DakDetails = dao.dakReceivedView(loggedInEmpId,Long.parseLong(dakId));
		if(DakDetails!=null) {

			
			String ActionTypeData = null;
			if(DakDetails[25]!=null && Long.parseLong(DakDetails[25].toString())==2) {
				//ActionTypeData = "action required(ActionDueDate: "+DakDetails[18]+" "+"ActionTime :"+DakDetails[19]+").";
				ActionTypeData = ".";
			}else if(DakDetails[25]!=null && Long.parseLong(DakDetails[25].toString())==1) {
					ActionTypeData = " from Source: " + DakDetails[4] +"." ;
			}else {
				ActionTypeData =".";
			}
		
		List<Object[]> MarkedEmpsDetailstoSendMail = dao.GetDistributedDakMembers(Long.parseLong(dakId));
		long MailTrackingId = 0;
        long MailTrackingInsightsId = 0;
        long SmsExpectedCount=MarkedEmpsDetailstoSendMail.size();
        //Create an AtomicInteger for thread-safe success count updates
        MailTrackingId = InsertMailTrackInitiator("S",SmsExpectedCount);
        if (MailTrackingId > 0 && MarkedEmpsDetailstoSendMail != null && MarkedEmpsDetailstoSendMail.size() > 0) {
        	MailTrackingInsightsId = InsertSummaryDistributedInsights(MailTrackingId,dakId);
        }
		ArrayList<String> EmailsArrayList= new ArrayList<String>();
		ArrayList<String> DronalEmailsArrayList= new ArrayList<String>();
		for(Object[] obj : MarkedEmpsDetailstoSendMail) {
		  if(obj[5]!=null && obj[5].toString().trim()!=""  && !obj[5].toString().isEmpty()) {
			EmailsArrayList.add(obj[5].toString());
		    }
		  if(obj[8]!=null && obj[8].toString().trim()!=""  && !obj[8].toString().isEmpty()) {
			  DronalEmailsArrayList.add(obj[8].toString());
		    }
		}
	//email ArrayList to array of string in order to take list of recipients for the email.
		String [] Emails = EmailsArrayList.toArray(new String[EmailsArrayList.size()]); //ALL THE EMAILS STORED TO SEND MAIL
		String [] DronaEmails=DronalEmailsArrayList.toArray(new String[DronalEmailsArrayList.size()]);  //ALL THE DRONA EMAILS STORED TO SEND MAIL)
		
	
        String Message = "<p>Dear Sir/Madam, </p>";
               Message += "<p></p>";
               Message += "<p>This is to notify you that DAK Id: " + DakDetails[9] + " has been received"+ ActionTypeData + "";
               Message += "This is for your information, please.(Urgent DAK)</p>";
               
               if(DakDetails[25]!=null && Long.parseLong(DakDetails[25].toString())==2) {
            		String ActionDueDate = "NA";
            	   if(DakDetails[18]!=null && DakDetails[18].toString()!="") {
            		   SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
            		   ActionDueDate = rdf.format(DakDetails[18]);
                    }
           	   
		Message +=    "<table style=\"align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse: collapse;\" >"
			         + "<thead>"
				     + "<tr>"
				     +"<th style=\"text-align: center; width: 200px; border: 1px solid black; padding: 5px; padding-left: 15px\">Source</th>"
				     +"<th style=\"text-align: center; width: 200px; border: 1px solid black; padding: 5px; padding-left: 15px\">Action Due Date</th>"
                     +"<th style=\"text-align: center; width: 200px; border: 1px solid black; padding: 5px; padding-left: 15px\">Action Time</th>"
		             +"</tr>"
		             + "</thead>"
		             + "<tbody>"
		             + "<tr>"
		             + "<td style=\"border: 1px solid black; padding: 5px; text-align: center\"> " + DakDetails[4] + "</td>"
		             + "<td style=\"border: 1px solid black; padding: 5px; text-align: center\"> " + ActionDueDate + "</td>"
		             + "<td style=\"border: 1px solid black; padding: 5px; text-align: center\"> " + DakDetails[19] + "</td>"
                     + "</tr>"
		             + "</tbody>"
                     + "</table>"
		             ;
             }
               Message += "Please <a href=\"" + env.getProperty("Login_link") + "\">Click Here</a> to Go DMS.<br>";
               Message += "Important Note: This is an automated message. Kindly avoid responding. ";
               Message += "<p></p>";
               Message += "Regards,<br>LRDE-DMS Team";

		if (Emails.length>0){
		try{
			// The email is sent using below code using default javaMailSender
	
		
		    // The email is sent using below code using the CustomJavaMailSender
			 String subject = "DAK Id: " + DakDetails[9] + ", Source: " + DakDetails[4];
             String message = Message;
             boolean isHtml = true; // Set this to true if your message is HTML

             if(Message!=null) {
            	 //add  row mail track and mail insights
             }
             
            // Send the email using CustomJavaMailSender
             MailSendStatus1 = customJavaMailSender.sendUrgentDakEmail1(Emails, subject, message, isHtml);
             mailSendStatus2= customJavaMailSender.sendUrgentDakEmail2(DronaEmails, subject, message, isHtml);
             if(MailSendStatus1>0) {
            	 //update n to s
             }
			
		}catch (MailAuthenticationException e) {
			MailSendStatus1 = 0;	
		}
		}else {
			MailSendStatus1 = -3;
		}

		}else {
			MailSendStatus1 = -4;
		}
		}catch (Exception e) {
				
			 	e.printStackTrace(); 
			 	logger.error(new Date() +"Inside SendInvitationLetter.htm ",e);
			 	MailSendStatus1 = -5;
			}
		
		 return new AsyncResult<>(MailSendStatus1);
	}
	
	

	
	
	@Override
	public List<Object[]> getSelectSourceTypeList(String sourceId) throws Exception {
		return dao.getSelectSourceTypeList(sourceId);
	}

	@Override
	public List<Object[]> dakLinkData(long dakId) throws Exception {
		return dao.dakLinkData(dakId);
	}

	@Override
	public long DakAck(long empId,long dakIdSel,String AckDate) throws Exception {
		return dao.DakAck(empId,dakIdSel,AckDate);
	}

	@Override
	public long getDakMarkingInsert(DakMarking marking) throws Exception {
		return dao.getDakMarkingInsert(marking);
	}

	public long DeleteSelMarkedEmployee(long DakId, long EmpId,long DakMemberTypeId,long dakMarkingId)throws Exception{
		return dao.DeleteSelMarkedEmployee(DakId,EmpId,DakMemberTypeId,dakMarkingId);
	}
	
	@Override
	public int RevokeMember(String dakMembersId,String UserName) throws Exception {
		return dao.RevokeMember(dakMembersId,UserName);
	}
	public List<Object[]> DakDistributedList(long EmpId,String fromdate ,String todate) throws Exception {
		return dao.DakDistributedList(EmpId,fromdate,todate);
	}

	@Override
	public long UpdateDakStatus(long dakIdSel) throws Exception {
		return dao.UpdateDakStatus(dakIdSel);
	}

	@Override
	public List<Object[]> OtherProjectList() throws Exception {
		return dao.OtherProjectList();
	}

	@Override
	public List<Object[]> getassignemplist(String projectid,String lab,long EmpId) throws Exception {
		return dao.getassignemplist(projectid,lab,EmpId);
	}

	public List<Object[]> getseekResponseEmplist(String lab ,long EmpId,long divid) throws Exception{
		return dao.getseekResponseEmplist(lab,EmpId,divid);
	}

	@Override
	public Object getlabcode(long empId) throws Exception {
		return dao.getlabcode(empId);
	}

	@Override
	public Object[] getUsername(long empId) throws Exception {
		return dao.getUsername(empId);
	}

	@Override
	public long DakAssignInsert(DakAssignDto dto,String[] DakCaseWorker,long EmpId) throws Exception {
		
		long result=0;
		Object[] UserName= null;
		UserName=dao.getUsername(EmpId);
		if(dto!=null ) {
			//Object[] AssignId=dao.GetAssignId(dto.getDakId(),dto.getDakMarkingId());
			for(int i=0;i<DakCaseWorker.length;i++) {
				long oldAssignEmpCount=dao.oldAssignEmpCount(Long.parseLong(DakCaseWorker[i]),dto.getDakId());
				if(oldAssignEmpCount==0) {
					DakAssign assigninsert=new DakAssign();
					assigninsert.setEmpId(Long.parseLong(DakCaseWorker[i]));
					assigninsert.setDakId(dto.getDakId());
					assigninsert.setDakMarkingId(dto.getDakMarkingId());
					assigninsert.setRemarks(dto.getRemarks());
					assigninsert.setReplyStatus(dto.getReplyStatus());
					assigninsert.setCreatedBy(dto.getCreatedBy());
					assigninsert.setCreatedDate(dto.getCreatedDate());
					assigninsert.setIsActive(dto.getIsActive());
					result=dao.DakAssignInsert(assigninsert);
				}else {
					result=dao.DakAssignUpdate(DakCaseWorker[i].toString(),dto.getDakId().toString(),1,dto.getRemarks());
				}
				DakNotification notification=new DakNotification();
				notification.setNotificationBy(EmpId);
				notification.setIsActive(1);
				notification.setCreatedBy(dto.getCreatedBy());
				notification.setCreatedDate(dto.getCreatedDate());
				notification.setNotificationMessage("DAK Assigned  by "+UserName[0].toString()+","+UserName[1].toString()+".");
				notification.setNotificationDate(sdf2.format(new Date()));
				notification.setEmpId(Long.parseLong(DakCaseWorker[i]));
				notification.setNotificationUrl("DakAssignedList.htm");
				dao.DakNotificationInsert(notification);
			}
		}
		return result;
	}

	@Override
	public long insertDakReply(DakReplyDto dakReplyDto)throws Exception{
		long DakReplyAddResult = 0;
		long DakReplyAttachAddResult = 0;
		long DakCSWReAttachAddResult = 0; 
		long Finalresult = 0;
	
		DakReply replyModel = new DakReply();
		replyModel.setDakId(dakReplyDto.getDakId());
		replyModel.setEmpId(dakReplyDto.getEmpId());
		replyModel.setRemarks(dakReplyDto.getReply());
		replyModel.setReplyStatus("R");
		replyModel.setCreatedBy(dakReplyDto.getCreatedBy());
		replyModel.setCreatedDate(sdf1.format(new Date()));
		Object EmpName =dao.getEmpName(dakReplyDto.getEmpId());
     	DakReplyAddResult=dao.DakReplyInsert(replyModel); 
     	if(DakReplyAddResult>0) {
    		 DakMain DakDetails = dao.GetDakDetails(dakReplyDto.getDakId()); 
///////////////DakFacilitatorAttachmentsAreReattached if provided////////////////////////////////////////////////////////////////
           String[] fileNamesOfReattachments = null;
            if (dakReplyDto.getDakAssignerReAttachs() != null) {
            	fileNamesOfReattachments = dakReplyDto.getDakAssignerReAttachs();
            	for (int i = 0; i < fileNamesOfReattachments.length; i++) {
            		String dakNoPath = DakDetails.getDakNo().replace("/", "_"); // Replace '/' with '_'
                	String DynamicPath = Paths.get(dakNoPath, "Outbox").toString(); // Create the path with Inbox folder
                	DakReplyAttach ReplyAttachModel = new DakReplyAttach();
               		ReplyAttachModel.setReplyId(DakReplyAddResult);
               		ReplyAttachModel.setEmpId(dakReplyDto.getEmpId());
               		ReplyAttachModel.setIsMain("Y");
               		ReplyAttachModel.setFilePath(DynamicPath);
               	    ReplyAttachModel.setFileName(fileNamesOfReattachments[i]);
               		ReplyAttachModel.setCreatedBy(dakReplyDto.getCreatedBy());
               		ReplyAttachModel.setCreatedDate(sdf1.format(new Date()));
               		
               		DakCSWReAttachAddResult=dao.DakReplyAttachmentAdd(ReplyAttachModel);
                }
            } else {
                // Handle the case when DakFacilitatorAttachment are not attached
            	DakCSWReAttachAddResult = 1;
            }
/////////////// User Attached Attachment////////////////////////////////////////////////////////////////
     		
     		if(DakDetails.getDakNo()!=null && dakReplyDto!=null && dakReplyDto.getReplyDocs()!=null && dakReplyDto.getReplyDocs().length>0 && !dakReplyDto.getReplyDocs()[0].isEmpty()) {
     			for(MultipartFile file : dakReplyDto.getReplyDocs()) {
     				if(!file.isEmpty()) {
           		DakReplyAttachDto ReplyAttachDto = new DakReplyAttachDto();
           		ReplyAttachDto.setReplyId(DakReplyAddResult);
           		ReplyAttachDto.setIsMain("Y");
           		ReplyAttachDto.setEmpId(dakReplyDto.getEmpId());
           		ReplyAttachDto.setFilePath(env.getProperty("file_upload_path"));
           		ReplyAttachDto.setCreatedBy(dakReplyDto.getCreatedBy());
           		ReplyAttachDto.setCreatedDate(sdf1.format(new Date()));
           		ReplyAttachDto.setDakNo(DakDetails.getDakNo());
           		ReplyAttachDto.setReplyFile(dakReplyDto.getReplyDocs());
           		String dakNoPath = ReplyAttachDto.getDakNo().replace("/", "_"); // Replace '/' with '_'
            	String DynamicPath = Paths.get(dakNoPath, "Outbox").toString(); // Create the path with Inbox folder
        	    Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
           		//int ExistingDocsCount = dao.GetReplyAttachmentDetails(ReplyAttachDto.getReplyId(),ReplyAttachDto.getIsMain()).size()+1;
           		int ExistingDocsCount = dao.GetPrevReplyAttachmentDetails(ReplyAttachDto.getReplyId()).size()+1;
           		File theDir = fullpath.toFile();
           		if (!theDir.exists()){
           		    theDir.mkdirs();
           		}
           		DakReplyAttach ReplyAttachModel = new DakReplyAttach();
           		ReplyAttachModel.setReplyId(ReplyAttachDto.getReplyId());
           		ReplyAttachModel.setEmpId(ReplyAttachDto.getEmpId());
           		ReplyAttachModel.setIsMain(ReplyAttachDto.getIsMain());
           		ReplyAttachModel.setFilePath(DynamicPath);
           	    ReplyAttachModel.setFileName(String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename());
           		ReplyAttachModel.setCreatedBy(ReplyAttachDto.getCreatedBy());
           		ReplyAttachModel.setCreatedDate(ReplyAttachDto.getCreatedDate());

           		saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename(),file );
           		
           		DakReplyAttachAddResult=dao.DakReplyAttachmentAdd(ReplyAttachModel);
           		
           		if(DakReplyAttachAddResult>0) {
           			Finalresult = 1;
           		}
           	}
     			}
     			
           }else {
        	   
        	   Finalresult = 1;
           }
     		List<Object[]> AttachmentsFilePath=dao.AttachmentsFilePath(DakReplyAddResult);
     		String emp=EmpName.toString();
     		if(dakReplyDto.getReplyPersonSentMail()!=null && dakReplyDto.getReplyReceivedMail()!=null && dakReplyDto.getHostType()!=null && dakReplyDto.getHostType().equalsIgnoreCase("D")) {
     			
     			for(int i=0;i<dakReplyDto.getReplyReceivedMail().length;i++) {
     			 String subject = dakReplyDto.getReplyMailSubject().toString();
                 String message = "<p>Dear Sir/Madam,</p>";
                        message += "<p></p>";
                        message += "<p>"+dakReplyDto.getReply().toString()+"</p>";
                        message += "<p>Regards,<br>"+emp+"</p>";
                        sendMessage1(dakReplyDto.getReplyPersonSentMail().toString(),dakReplyDto.getReplyReceivedMail()[i].toString(),subject, message,AttachmentsFilePath);
     			}
     		}else if(dakReplyDto.getReplyPersonSentMail()!=null && dakReplyDto.getReplyReceivedMail()!=null && dakReplyDto.getHostType()!=null && dakReplyDto.getHostType().equalsIgnoreCase("L")) {
     			for(int i=0;i<dakReplyDto.getReplyReceivedMail().length;i++) {
        			 String subject = dakReplyDto.getReplyMailSubject().toString();
                    String message = "<p>Dear Sir/Madam,</p>";
                           message += "<p></p>";
                           message += "<p>"+dakReplyDto.getReply().toString()+"</p>";
                           message += "<p>Regards,<br>"+emp+"</p>";
                           sendMessage(dakReplyDto.getReplyPersonSentMail().toString(),dakReplyDto.getReplyReceivedMail()[i].toString(),subject, message,AttachmentsFilePath);
        			}
     		}
     	}
		return DakReplyAddResult;
	}
	
	public int sendMessage1(String Frommail, String toEmail, String subject, String msg,List<Object[]> AttachmentsFilePath) throws Exception {
		int mailSendresult = 0;
		
		MailConfigurationDto mailAuthentication=dmsser.getMailConfigByTypeOfHost("D");
		Properties properties = System.getProperties();
		properties.setProperty("mail.smtp.host", mailAuthentication.getHost());
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.port", mailAuthentication.getPort());
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.socketFactory.class", "jakarta.net.ssl.SSLSocketFactory");
		
		Session session = Session.getDefaultInstance(properties, new jakarta.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(mailAuthentication.getUsername(),mailAuthentication.getPassword());
			}
		});
		
		try {
			
			MimeMessage message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress(mailAuthentication.getUsername()));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			message.setSubject(subject);
			
			// Create a multipart message
	        Multipart multipart = new MimeMultipart();

	        // Create the text part
	        MimeBodyPart messageBodyPart = new MimeBodyPart();
	        messageBodyPart.setText(msg);
	        messageBodyPart.setContent(msg, "text/html"); // Set HTML content
	        multipart.addBodyPart(messageBodyPart);

	        if(AttachmentsFilePath!=null && !AttachmentsFilePath.isEmpty()) {
	        for (Object[] obj : AttachmentsFilePath) {
	        	 try {
		        		 String filePath = env.getProperty("file_upload_path") + File.separator + obj[0] + File.separator + obj[1];
		        	     File file = new File(filePath);
	        	        if (file.exists()) {
	        	            MimeBodyPart attachPart = new MimeBodyPart();
	        	            attachPart.attachFile(file);
	        	            attachPart.setFileName(file.getName());
	        	            multipart.addBodyPart(attachPart);
	        	        } else {
	        	            System.err.println("File does not exist: " + filePath);
	        	        }
	        	    } catch (IOException | MessagingException e) {
	        	        e.printStackTrace();
	        	    }
	        }
	        }
	        message.setContent(multipart);
			Transport.send(message);
			System.out.println("Message Sent");
			mailSendresult++;
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}
		return mailSendresult;
		
	}

	public int sendMessage(String Frommail, String toEmail, String subject, String msg,List<Object[]> AttachmentsFilePath)  throws Exception {
		
		int mailSendresult = 0;
		MailConfigurationDto mailAuthentication=dmsser.getMailConfigByTypeOfHost("L");
		Properties properties = System.getProperties();
		properties.setProperty("mail.smtp.host", mailAuthentication.getHost());
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.port", mailAuthentication.getPort());
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.socketFactory.class", "jakarta.net.ssl.SSLSocketFactory");
		
		Session session = Session.getDefaultInstance(properties, new jakarta.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(mailAuthentication.getUsername(),mailAuthentication.getPassword());
			}
		});
		try {
			
			
			MimeMessage message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress(mailAuthentication.getUsername()));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			message.setSubject(subject);
			
			// Create a multipart message
	        Multipart multipart = new MimeMultipart();

	        // Create the text part
	        MimeBodyPart messageBodyPart = new MimeBodyPart();
	        messageBodyPart.setText(msg);
	        messageBodyPart.setContent(msg, "text/html"); // Set HTML content
	        multipart.addBodyPart(messageBodyPart);

	        if(AttachmentsFilePath!=null && !AttachmentsFilePath.isEmpty()) {
	        for (Object[] obj : AttachmentsFilePath) {
	        	 try {
		        		 String filePath = env.getProperty("file_upload_path") + File.separator + obj[0] + File.separator + obj[1];
		        	     File file = new File(filePath);
	        	        if (file.exists()) {
	        	            MimeBodyPart attachPart = new MimeBodyPart();
	        	            attachPart.attachFile(file);
	        	            attachPart.setFileName(file.getName());
	        	            multipart.addBodyPart(attachPart);
	        	        } else {
	        	            System.err.println("File does not exist: " + filePath);
	        	        }
	        	    } catch (IOException | MessagingException e) {
	        	        e.printStackTrace();
	        	    }
	        }
	        }
	        message.setContent(multipart);
			Transport.send(message);
			System.out.println("Message Sent");
			mailSendresult++;
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}
		return mailSendresult;
	}
	
	@Override
	public List<Object[]>  GetReplyModalDetails(long DakId,long EmpId, String Username, String DakAdmin)throws Exception{
		return dao.GetReplyModalDetails(DakId,EmpId,Username,DakAdmin);
	}
	

	@Override
	public List<Object[]>  GetReplyAttachmentList(long DakReplyId)throws Exception{
		return dao.GetReplyAttachmentList(DakReplyId);
	}
	
	
	@Override
	public Object[] DakReplyAttachData(String ReplyAttachmentId) throws Exception {
		
		return dao.DakReplyAttachData(ReplyAttachmentId);
	}

	@Override
	public List<Object[]>  GetDakReplyDetails(long dakReplyId)throws Exception{
		return dao.GetDakReplyDetails(dakReplyId);
	}
	
	public DakReply GetDakReplyEditDetails(long dakReplyId)throws Exception{
		return dao.GetDakReplyEditDetails(dakReplyId);
	}

	public List<Object[]>  ReplyDakAttachmentData (long DakReplyAttachId, long DakReplyId)throws Exception{
		return dao.ReplyDakAttachmentData (DakReplyAttachId,DakReplyId);
	}
	
	public long DeleteReplyAttachment(long DakReplyAttachmentId) throws Exception{
		return dao.DeleteReplyAttachment(DakReplyAttachmentId);
	}

	public long editDakReply(DakReplyDto dakReplyEditdto) throws Exception{
		long DakReplyEditResult = 0;
		long DakReplyAttachEditAddResult = 0;
		long Finalresult = 0;
		DakReply replyModal = new DakReply();
		replyModal.setDakReplyId(dakReplyEditdto.getDakReplyId());
		replyModal.setDakId(dakReplyEditdto.getDakId());
		replyModal.setRemarks(dakReplyEditdto.getReply());
        replyModal.setModifiedBy(dakReplyEditdto.getModifiedBy());
		replyModal.setModifiedDate(sdf1.format(new Date()));
		DakReplyEditResult=dao.DakReplyEditData(replyModal); 
     	if(DakReplyEditResult>0) {
     		 DakMain DakDetails = dao.GetDakDetails(dakReplyEditdto.getDakId()); 
     		if(DakDetails.getDakNo()!=null && dakReplyEditdto!=null && dakReplyEditdto.getReplyDocs()!=null && dakReplyEditdto.getReplyDocs().length>0 && !dakReplyEditdto.getReplyDocs()[0].isEmpty()) {
     			for(MultipartFile file : dakReplyEditdto.getReplyDocs()) {
     			if(!file.isEmpty()) {	
           		DakReplyAttachDto ReplyAttachDto = new DakReplyAttachDto();
           		ReplyAttachDto.setReplyId(dakReplyEditdto.getDakReplyId());
           		ReplyAttachDto.setIsMain("Y");
           		ReplyAttachDto.setEmpId(dakReplyEditdto.getEmpId());
           		ReplyAttachDto.setFilePath(env.getProperty("file_upload_path"));
           		ReplyAttachDto.setCreatedBy(dakReplyEditdto.getCreatedBy());
           		ReplyAttachDto.setCreatedDate(sdf1.format(new Date()));
           		ReplyAttachDto.setDakNo(DakDetails.getDakNo());
           		ReplyAttachDto.setReplyFile(dakReplyEditdto.getReplyDocs());
           		String dakNoPath = ReplyAttachDto.getDakNo().replace("/", "_"); 
            	String DynamicPath = Paths.get(dakNoPath, "Outbox").toString(); 
        	    Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
           		int ExistingDocsCount = dao.GetPrevReplyAttachmentDetails(ReplyAttachDto.getReplyId()).size()+1;
           		File theDir = fullpath.toFile(); //as this is already edit theDir would be already existing
           		if (!theDir.exists()){
           		    theDir.mkdirs();
           		}
           		DakReplyAttach ReplyAttachModel = new DakReplyAttach();
           		ReplyAttachModel.setReplyId(ReplyAttachDto.getReplyId());
           		ReplyAttachModel.setEmpId(ReplyAttachDto.getEmpId());
           		ReplyAttachModel.setIsMain(ReplyAttachDto.getIsMain());
           		ReplyAttachModel.setFilePath(DynamicPath);
           		ReplyAttachModel.setFileName(String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename());
           		ReplyAttachModel.setCreatedBy(ReplyAttachDto.getCreatedBy());
           		ReplyAttachModel.setCreatedDate(ReplyAttachDto.getCreatedDate());
           		saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename(),file );
           		
           		DakReplyAttachEditAddResult=dao.DakReplyAttachmentAdd(ReplyAttachModel);
           		
           		if(DakReplyAttachEditAddResult>0) {
           			Finalresult = 1;
           		}
           	}
     			}
           }else {
        	   
        	   Finalresult = 1;
           }
     		
     		
     	}
		
		return Finalresult;
	}
	
	
	public List<Object[]>  getEmpListForAssigning (long DakId,String lab, long EmpId)throws Exception{
		return dao.getEmpListForAssigning(DakId,lab,EmpId);
	}
	
	@Override
	public DakMain GetDakDetails(long dakId)throws Exception{
		return dao.GetDakDetails(dakId);
	}
	
	@Override
	public List<Object[]>  GetCSWReplyModalDetails(long DakId,long EmpId, String Username, String DakAdmin)throws Exception{
		return dao.GetCSWReplyModalDetails(DakId,EmpId,Username,DakAdmin);
	}
	
	@Override
	public List<Object[]>  GetSpecificMarkersCSWReplyDetails(long DakId,long DakMarkingId)throws Exception{
		return dao.GetSpecificMarkersCSWReplyDetails(DakId,DakMarkingId);
	}
	
	@Override
	public List<Object[]>  GetReplyCSWAttachmentList(long DakAssignReplyId)throws Exception{
		return dao.GetReplyCSWAttachmentList(DakAssignReplyId);
	}
	
	@Override
	public List<Object[]>  GetParticularCSWReplyDetails(long DakAssignReplyId) throws Exception{
		return dao.GetParticularCSWReplyDetails(DakAssignReplyId);
	}
	

	@Override
	public Object[] DakReplyCSWAttachData(String DakAssignReplyAttachmentId) throws Exception {
		
		return dao.DakReplyCSWAttachData(DakAssignReplyAttachmentId);
	}

	@Override
	public List<Object[]> GetDakMarkersDetailsList (long DakId)throws Exception{
		return dao.GetDakMarkersDetailsList(DakId);
	}
	
	
	public List<Object[]> DakDetailedList(String fromdate ,String todate,String StatusValue, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String empId,String DivisionCode,String LabCode,String UserName) throws Exception{
		return dao.DakDetailedList(fromdate,todate,StatusValue,lettertypeid, priorityid, sourcedetailid, sourceId, projectType, projectId, dakMemberTypeId, empId,DivisionCode,LabCode,UserName);
	}
	
	@Override
	public List<Object[]> DakDirectorList(String fromdate ,String todate,String StatusValue) throws Exception {
		return dao.DakDirectorList(fromdate,todate,StatusValue);
	}
	
	@Override
	public List<Object[]> DirPendingApprovalList(String lettertypeid,String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String employeeId) throws Exception {
		return dao.DirPendingApprovalList(lettertypeid,priorityid, sourcedetailid, sourceId, projectType, projectId, dakMemberTypeId, employeeId);
	}
	
	@Override
	public List<Object[]> DakEmpDetailsList(String fromdate ,String todate) throws Exception {
		return dao.DakEmpDetailsList(fromdate,todate);
	}
	
	public long UpdateDakDirAction(DakMarking dakMark,long NotificationBy)throws Exception{
		long EmpId = 0;
		
		DakMarking GetMarkedPersDetails = dao.getGetMarkedPersDetails(dakMark.getDakMarkingId());
		EmpId = GetMarkedPersDetails.getEmpId();//the employee to whom the communication is addressed
		Object[] EmpName= null;
		EmpName=dao.getUsername(NotificationBy);//the employee by whom the communication is addressed
		if(EmpId!=0 && dakMark.getMsgType()!=null) {
			
			DakNotification notification=new DakNotification();
			notification.setNotificationBy(NotificationBy);
			notification.setIsActive(1);
			notification.setCreatedBy(dakMark.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
		    notification.setNotificationDate(sdf2.format(new Date()));
			notification.setEmpId(EmpId);
			notification.setNotificationUrl("DakReceivedList.htm");
			if(dakMark.getMsgType().toString().equalsIgnoreCase("D")) {
				notification.setNotificationMessage("Please Discuss with Director"+","+EmpName[0].toString()+".");
			}else if(dakMark.getMsgType().toString().equalsIgnoreCase("E")) {
				notification.setNotificationMessage("Noted By Director"+","+EmpName[0].toString()+".");
			}
			
			dao.DakNotificationInsert(notification);//Notification Addition
		}
		
		return dao.UpdateDakDirAction(dakMark);
	}
	
	@Override
	public List<Object[]> GetIndividualReplyDetails(long DakReplyId,long EmpId, long DakId)throws Exception{
		return dao.GetIndividualReplyDetails(DakReplyId,EmpId,DakId);
	}
	
	@Override
	public long dakAssignstatus(long DakMarkingIdsel) throws Exception {
		return dao.dakAssignstatus(DakMarkingIdsel);
	}
	
	
	
	@Override
	public List<Object[]> getDakAssignedList(long empId,String fromDate,String toDate,long SelEmpId) throws Exception {
		return dao.getDakAssignedList(empId,fromDate,toDate,SelEmpId);
	}

	@Override
	public Object[] getDaknoviewlist(long dakid) throws Exception {
		return dao.getDaknoviewlist(dakid);
	}

	@Override
	public long InsertDakAssignReply(DakAssignReplyDto dto) throws Exception {
		
		long AssignReplyInsert=0;
		DakAssignReply model=new DakAssignReply();
		model.setDakId(dto.getDakId());
		model.setDakAssignId(dto.getAssignId());
		model.setEmpId(dto.getEmpId());
		model.setReply(dto.getReply());
		model.setReplyStatus(dto.getReplyStatus());
		model.setCreatedBy(dto.getCreatedBy());
		model.setCreatedDate(dto.getCreatedDate());
		AssignReplyInsert=dao.AssignReplyInsert(model);
		
		
		if(dto!=null  &&  dto.getAssignReplyDocs()!=null && dto.getAssignReplyDocs().length>0 && !dto.getAssignReplyDocs()[0].isEmpty()) {
			for(MultipartFile file : dto.getAssignReplyDocs()) {
				if(!file.isEmpty()) {
          		
				String dakNoPath = dto.getDakNo().replace("/", "_");
            	String DynamicPath = Paths.get(dakNoPath, "Outbox").toString(); 
        	    Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
			
				int ExistingDocsCount = dao.GetPrevAssignReplyAttachmentDetails(AssignReplyInsert).size()+1;
           		
           		File theDir = fullpath.toFile();
           		if (!theDir.exists()){
           		    theDir.mkdirs();
           		}
				AssignReplyAttachment attachment=new AssignReplyAttachment();
				attachment.setDakAssignReplyId(AssignReplyInsert);
				attachment.setDakId(dto.getDakId());
				attachment.setEmpId(dto.getEmpId());
				attachment.setFilePath(DynamicPath);
				attachment.setFileName(String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename());
				attachment.setCreatedBy(dto.getCreatedBy());
				attachment.setCreatedDate(dto.getCreatedDate());
				long AttachmentInsert=dao.AssignReplyAttachment(attachment);
				saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename(),file );
				
				}
			}
		}
		return AssignReplyInsert;
	}

	@Override
	public long updateAssignStatus(long DakAssignId) throws Exception {
		return dao.updateAssignStatus(DakAssignId);
	}

	@Override
	public long InsertSourceDetails(Source source) throws Exception {
		
		return dao.InsertSourceDetails(source);
	}

	@Override
	public long InsertNonProjectDetails(NonProjectMaster nonProject) throws Exception {
		return dao.InsertNonProjectDetails(nonProject);
	}

	@Override
	public long InsertOtherProjectDetails(OtherProjectMaster otherProject) throws Exception {
		return dao.InsertOtherProjectDetails(otherProject);
	}

	@Override
	public long EmpIdCountOfDM(long dakIdSel) throws Exception {
		return dao.EmpIdCountOfDM(dakIdSel);
	}

	@Override
	public long DakAckCountOfDM(long dakIdSel) throws Exception {
		return dao.DakAckCountOfDM(dakIdSel);
	}
	
	@Override
	public long DakReplyCountInDR(long dakIdSel) throws Exception{
		return dao.DakReplyCountInDR(dakIdSel);
	}
	@Override
	public long UpdateDakStatusToDR(long dakId)throws Exception{
		return dao.UpdateDakStatusToDR(dakId);
	}
	
	@Override
	public List<Object[]> DakPnCPendingReplyList(long EmpId,String LoginType, String fromDate, String toDate,String StatusValue) throws Exception {
		return dao.DakPnCPendingReplyList(EmpId, LoginType, fromDate, toDate, StatusValue);
	}

	
	
	@Override
	public List<Object[]> DakPnCList(long EmpId,String LoginType, String fromDate, String toDate,String StatusValue) throws Exception{
		return dao.DakPnCList(EmpId,LoginType,fromDate,toDate,StatusValue);
	}

	
	@Override
	public List<Object[]> DakPnCDoList(String fromDate, String toDate,String StatusValue, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String empId, String actionId) throws Exception {
		return dao.DakPnCDoList(fromDate,toDate,StatusValue,lettertypeid, priorityid, sourcedetailid, sourceId, projectType, projectId, dakMemberTypeId, empId, actionId);
	}

	@Override
	public List<Object[]>  DakDetailForPNCDO(long DakId) throws Exception {
		return dao.DakDetailForPNCDO(DakId);
	}

	
	@Override
	public List<Object[]>  GetReplyDetailsFrmDakReply(long DakId,long EmpId, String Username, String DakAdmin)throws Exception{
		return dao.GetReplyDetailsFrmDakReply(DakId,EmpId,Username,DakAdmin);
	}
	
	@Override
	public List<Object[]>  GetReplyAttachsFrmDakReplyAttach() throws Exception{
		return dao.GetReplyAttachsFrmDakReplyAttach();
		}
	
	@Override
	public long  DirApprovalActionUpdate(String DirApprovalVal,long DakId)  throws Exception{
		return dao.DirApprovalActionUpdate(DirApprovalVal,DakId);
	}
	
	@Override
	public long  UpdateDirAprvForwarderIdAndDakStatus(long EmpId,long DakId,String DakStatus)  throws Exception{
		return dao.UpdateDirAprvForwarderIdAndDakStatus(EmpId,DakId,DakStatus);
	}
	
	@Override
	public long insertPnCDakReply(DakPnCReplyDto PnCdto) throws Exception{
		long PnCReplyAddResult = 0;
		long PnCReplyAttachAddResult = 0;
		int  PnCAddCheck = 0;
		long PnCUpdateDakResult = 0;
		long DakMarkerReAttachAddResult = 0;
		long Finalresult = 0;
		
		DakPnCReply pncModel = new DakPnCReply();
		pncModel.setDakId(PnCdto.getDakId());
		pncModel.setEmpId(PnCdto.getEmpId());
		pncModel.setPnCReply(PnCdto.getReply());
		pncModel.setPnCReplyStatus("R");
		pncModel.setCreatedBy(PnCdto.getCreatedBy());
		pncModel.setCreatedDate(sdf1.format(new Date()));
		pncModel.setIsActive(1);
     	PnCReplyAddResult=dao.DakPnCReplyInsert(pncModel); 
    	if(PnCReplyAddResult>0) {
      		 DakMain DakDetails = dao.GetDakDetails(PnCdto.getDakId()); 
///////////////DakMarkerAttachmentsAreReattached if provided////////////////////////////////////////////////////////////////
    String[] fileNamesOfReattachments = null;
    
     if (PnCdto.getDakMarkerReAttachs() != null) {
     	fileNamesOfReattachments = PnCdto.getDakMarkerReAttachs();
     	for (int i = 0; i < fileNamesOfReattachments.length; i++) {
 			 String dakNoPath = DakDetails.getDakNo().replace("/", "_");
 			 String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
             DakPnCReplyAttach attachModel = new DakPnCReplyAttach();
             attachModel.setDakPnCReplyId(PnCReplyAddResult);
             attachModel.setEmpId(PnCdto.getEmpId());
             attachModel.setFilePath(DynamicPath);
        	 attachModel.setFileName(fileNamesOfReattachments[i]);
        	 attachModel.setCreatedBy(PnCdto.getCreatedBy());
        	 attachModel.setCreatedDate(sdf1.format(new Date()));
        		
        		DakMarkerReAttachAddResult=dao.DakPnCAttachmentAdd(attachModel);
         }
     } else {
         // Handle the case when DakFacilitatorAttachment are not attached
    	 DakMarkerReAttachAddResult = 1;
     }
///////////////DakMarkerAttachmentsAreReattached if provided End////////////////////////////////////////////////////////////////

      		 
      		 
      		 
      		if(DakDetails.getDakNo()!=null && PnCdto!=null && PnCdto.getPnCReplyDocs()!=null && PnCdto.getPnCReplyDocs().length>0 && !PnCdto.getPnCReplyDocs()[0].isEmpty()) {
      			
      			for(MultipartFile file : PnCdto.getPnCReplyDocs()) {
      				
      				if(!file.isEmpty()) {
      					
  					String dakNoPath = DakDetails.getDakNo().replace("/", "_");
  		 			String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
      				Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
             	    int ExistingDocsCount = dao.GetPrevPnCReplyAttachmentDetails(PnCReplyAddResult).size()+1;
             	    
             	   File theDir = fullpath.toFile();
              		if (!theDir.exists()){
              		    theDir.mkdirs();
              		}
              		DakPnCReplyAttach attachModel = new DakPnCReplyAttach();
              		attachModel.setDakPnCReplyId(PnCReplyAddResult);
              		attachModel.setEmpId(PnCdto.getEmpId());
              		attachModel.setFilePath(DynamicPath);
              		attachModel.setFileName(String.valueOf(ExistingDocsCount)+"C"+"_"+file.getOriginalFilename());
               	    attachModel.setCreatedBy(PnCdto.getCreatedBy());
               	    attachModel.setCreatedDate(sdf1.format(new Date()));
               	    
               	    saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"C"+"_"+file.getOriginalFilename(),file );
            		
                    PnCReplyAttachAddResult=dao.DakPnCAttachmentAdd(attachModel);
                    
                    if(PnCReplyAttachAddResult>0) {
                    	PnCAddCheck = 1;
                    }
      				}
      			}
      		}else {
      			PnCAddCheck = 1;
      		}
    	}
    	
    	if(PnCAddCheck == 1) {
    		PnCUpdateDakResult = dao.DakPnCUpdateStatus(PnCdto.getDakId());
    	}
    	
    	if(PnCUpdateDakResult > 0) {
    		Finalresult = 1;
    	}else{
    		Finalresult = 0;
    	}
		
    	return Finalresult;
	}
	
	@Override
	  public List<Object[]>  GetMarkerReplySentForApprovalData(long DakId,long DirApvForwarderId)throws Exception{
		  return dao.GetMarkerReplySentForApprovalData(DakId,DirApvForwarderId);
	  }
	  
	@Override
	public List<Object[]>  GetPnCReplyDetails(long DakId) throws Exception {
		
		return dao.GetPnCReplyDetails(DakId);
	}

	@Override
	public List<Object[]>  GetPnCAttachReplyDetails(long DakPnCReplyId) throws Exception {
		
		return dao.GetPnCAttachReplyDetails(DakPnCReplyId);
	}


	@Override
	public Object[] DakPnCReplyAttachData(String PnCReplyAttachId) throws Exception {
		
		return dao.DakPnCReplyAttachData(PnCReplyAttachId);
	}
	
	@Override
	public long DakApprovalUpdate(long DakId,String ApprovedBy,String ApprovedDate)throws Exception{
		return dao.DakApprovalUpdate( DakId, ApprovedBy, ApprovedDate);
	}
	
	@Override
	public long DakApprovalWithCommtUpdate(long DakId,String ApprovalCommt,String ApprovedBy,String ApprovedDate)throws Exception{
		return  dao.DakApprovalWithCommtUpdate( DakId,ApprovalCommt, ApprovedBy, ApprovedDate);
	}

	@Override
	public long DakReturnUpdate(long DakId, String ReturnComment)throws Exception{
		return  dao.DakReturnUpdate( DakId,ReturnComment);
	}
	
	
	@Override
	public long DakPNCForwardUpdate(long DakId, String ForwardBy,String ForwardDate)throws Exception{
		return  dao.DakPNCForwardUpdate( DakId,ForwardBy,ForwardDate);
	}

	@Override
	public List<Object[]>  GetPnCReplyDataDetails(long DakPnCReplyId,long DakId) throws Exception {
		
		return dao.GetPnCReplyDataDetails(DakPnCReplyId,DakId);
	}


	public List<Object[]>  ReplyDakPnCAttachmentData (long DakPnCReplyAttachId, long DakPnCReplyId)throws Exception{
		return dao.ReplyDakPnCAttachmentData (DakPnCReplyAttachId,DakPnCReplyId);
	}
	

	@Override
	public long DeletePnCReplyAttachment(long PnCReplyAttachId,long DakPnCReplyId)  throws Exception {
		return dao.DeletePnCReplyAttachment(PnCReplyAttachId,DakPnCReplyId);
	}
	
	@Override
	public DakPnCReply GetPnCDetails(long DakPnCReplyId) throws Exception{
	return dao.GetPnCDetails(DakPnCReplyId);
  }

	@Override
	public long updatePnCDakReply(DakPnCReplyDto PnCdto) throws Exception{
		long PnCReplyEditResult = 0;
		long PnCReplyAttachAddResult = 0;
		int  PnCEditCheck = 0;
		long PnCUpdateDakResult = 0;
		long Finalresult = 0;
		
		DakPnCReply pncModel = new DakPnCReply();
		pncModel.setDakPnCReplyId(PnCdto.getPnCReplyId());
		pncModel.setDakId(PnCdto.getDakId());
		pncModel.setEmpId(PnCdto.getEmpId());
		pncModel.setPnCReply(PnCdto.getReply());
		pncModel.setPnCReplyStatus("R");
		pncModel.setModifiedBy(PnCdto.getModifiedBy());
		pncModel.setModifiedDate(sdf1.format(new Date()));
		pncModel.setIsActive(1);
		
	
		 
		PnCReplyEditResult=dao.DakPnCReplyUpdate(pncModel); 
     	
    	if(PnCReplyEditResult>0) {
      		 DakMain DakDetails = dao.GetDakDetails(PnCdto.getDakId()); 
      		 
      		if(DakDetails.getDakNo()!=null && PnCdto!=null && PnCdto.getPnCReplyDocs()!=null && PnCdto.getPnCReplyDocs().length>0 && !PnCdto.getPnCReplyDocs()[0].isEmpty()) {
      			
      			for(MultipartFile file : PnCdto.getPnCReplyDocs()) {
      				if(!file.isEmpty()) {
      				String dakNoPath = DakDetails.getDakNo().replace("/", "_");
      		 		String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
      				Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
             	    int ExistingDocsCount = dao.GetPrevPnCReplyAttachmentDetails(PnCdto.getPnCReplyId()).size()+1;
             	    
             	   File theDir = fullpath.toFile();
              		if (!theDir.exists()){
              		    theDir.mkdirs();
              		}
              		DakPnCReplyAttach attachModel = new DakPnCReplyAttach();
              		attachModel.setDakPnCReplyId(PnCdto.getPnCReplyId());
              		attachModel.setEmpId(PnCdto.getEmpId());
              		attachModel.setFilePath(DynamicPath);
              		attachModel.setFileName(String.valueOf(ExistingDocsCount)+"C"+"_"+file.getOriginalFilename());
               	    attachModel.setCreatedBy(PnCdto.getCreatedBy());
               	    attachModel.setCreatedDate(sdf1.format(new Date()));
               	    
               	    saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"C"+"_"+file.getOriginalFilename(),file );
            		
                    PnCReplyAttachAddResult=dao.DakPnCAttachmentAdd(attachModel);
                    
                    if(PnCReplyAttachAddResult>0) {
                    	PnCEditCheck = 1;
                    }
      			}
      			}
      		}else {
      			PnCEditCheck = 1;
      		}
    	}
    	
    	if(PnCEditCheck == 1) {
    		Finalresult = 1;
    	}
    	
    	
		
    	return Finalresult;
	}
	
	
	
	@Override
	public long DakCloseUpdate(long DakId,String closedBy,String closedDateTime,String closedDate, String closingCommt)throws Exception{
		return dao.DakCloseUpdate( DakId, closedBy, closedDateTime,closedDate,closingCommt);
	}
	
	@Override
	public List<Object[]> DakClosedList(String fromDate,String toDate,String StatusValue,String LoginType,String Username,long EmpId, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String employeeId,String DivisionCode,String LabCode)throws Exception {
		
		return dao.DakClosedList(fromDate,toDate,StatusValue,LoginType,Username,EmpId,lettertypeid, priorityid, sourcedetailid, sourceId, projectType, projectId, dakMemberTypeId, employeeId,DivisionCode,LabCode);
	}

	
	@Override
	public long DakReDistribute(String dakId, String date, String[] empId, long markedEmpId, String username) throws Exception {
		
		long NotifiInsert=0;
		Object[] UserName= null;
		UserName=dao.getUsername(markedEmpId);
		if(empId!=null && empId.length>0) {
			for(int i=0;i<empId.length;i++) {
			DakNotification notification=new DakNotification();
			notification.setNotificationBy(markedEmpId);
			notification.setIsActive(1);
			notification.setCreatedBy(username);
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setNotificationMessage("DAK Distributed  by "+UserName[0].toString()+","+UserName[1].toString()+".");
			notification.setNotificationDate(sdf2.format(new Date()));
			notification.setEmpId(Long.parseLong(empId[i]));
			notification.setNotificationUrl("DakReceivedList.htm");
			NotifiInsert=dao.DakNotificationInsert(notification);
		}
		}
		return NotifiInsert;
	}

	@Override
	public long RevokeMarking(String markingId) throws Exception {
		return dao.RevokeMarking(markingId);
	}

	@Override
	public List<Object[]> DakMemberGroup() throws Exception {
		return dao.DakMemberGroup();
	}

	@Override
	public List<Object[]> getDakmemberGroupEmpList(String[] groupid,String labcode) throws Exception {
		return dao.getDakmemberGroupEmpList(groupid,labcode);
	}

	@Override
	public List<Object[]> getIndiMarkedEmpIdsFrmDakId(long DakId) throws Exception{
		return dao.getIndiMarkedEmpIdsFrmDakId(DakId);
	}
	
	@Override
	public List<Object[]>  AssignReplyRemarks(long empId, long dakIdSel) throws Exception {
		return dao.AssignReplyRemarks(empId,dakIdSel);
	}

	@Override
	public List<Object[]> GetAssignReplyAttachmentList(long DakAsssignReplyId) throws Exception {
		return dao.GetAssignReplyAttachmentList(DakAsssignReplyId);
	}

	@Override
	public List<Object[]> GetDakAssignReplyDetails(long DakAsssignReplyId) throws Exception {
		return dao.GetDakAssignReplyDetails(DakAsssignReplyId);
	}

	@Override
	public DakAssignReply GetDakAssignReplyEditDetails(long DakAssignReplyId) throws Exception {
		return dao.GetDakAssignReplyEditDetails(DakAssignReplyId);
	}

	@Override
	public long editDakAssignReply(DakAssignReplyDto dto) throws Exception {
	
		long DakAssignReplyEditResult = 0;
		long DakAssignReplyAttachEditAddResult = 0;
		long Finalresult = 0;
	
		DakAssignReply model=new DakAssignReply();
		model.setDakAssignReplyId(dto.getDakAssignReplyId());
		model.setDakId(dto.getDakId());
		model.setDakAssignId(dto.getAssignId());
		model.setEmpId(dto.getEmpId());
		model.setReply(dto.getReply());
		model.setModifiedBy(dto.getModifiedBy());
		model.setModifiedDate(dto.getModifiedDate());
		DakAssignReplyEditResult=dao.AssignReplyEdit(model);
		
		if(DakAssignReplyEditResult>0) {
     		
			 DakMain DakDetails = dao.GetDakDetails(dto.getDakId()); 
	    		
	    		if(DakDetails.getDakNo()!=null && dto!=null && dto.getAssignReplyDocs()!=null && dto.getAssignReplyDocs().length>0 && !dto.getAssignReplyDocs()[0].isEmpty()) {
	         
    			for(MultipartFile file : dto.getAssignReplyDocs()) {
    				if(!file.isEmpty()) {
    				 String dakNoPath = DakDetails.getDakNo().replace("/", "_");
      		 		 String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
    				 Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
    				int ExistingDocsCount = dao.GetPrevAssignReplyAttachmentDetails(dto.getDakAssignReplyId()).size()+1;
               		
               		File theDir = fullpath.toFile();
               		if (!theDir.exists()){
               		    theDir.mkdirs();
               		}
    				AssignReplyAttachment attachment=new AssignReplyAttachment();
    				attachment.setDakAssignReplyId(dto.getDakAssignReplyId());
    				attachment.setDakId(dto.getDakId());
    				attachment.setEmpId(dto.getEmpId());
    				attachment.setFilePath(DynamicPath);
    				attachment.setFileName(String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename());
    				attachment.setCreatedBy(dto.getCreatedBy());
    				attachment.setCreatedDate(dto.getCreatedDate());
    				
    				saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename(),file );
    				DakAssignReplyAttachEditAddResult=dao.AssignReplyAttachment(attachment);
          		
          		if(DakAssignReplyAttachEditAddResult>0) {
          			Finalresult = 1;
          		}
    			}
          	}
          }else {
       	   
       	   Finalresult = 1;
          }
    		
    	}
		return Finalresult;
	}

	@Override
	public List<Object[]> AssignReplyDakAttachmentData(long DakAssignReplyAttachId, long DakAssignReplyId) throws Exception {
		return dao.AssignReplyDakAttachmentData(DakAssignReplyAttachId,DakAssignReplyId);
	}

	@Override
	public int DeleteAssignReplyAttachment(String dakAssignReplyAttachId) throws Exception {
		return dao.DeleteAssignReplyAttachment(dakAssignReplyAttachId);
	}


	@Override
	public List<Object[]> DakMarkingData(long dakId) throws Exception {
		return dao.DakMarkingData(dakId);
	}

	
	@Override
	public List<Object[]> DakMarkedMemberGroup(String dakId) throws Exception {
		return dao.DakMarkedMemberGroup(dakId);
	}
	
	@Override
	public List<Object[]> DakInactiveMarkedMemberGroup(String dakId) throws Exception {
		return dao.DakInactiveMarkedMemberGroup(dakId);
	}

	@Override
	public long CSWReplyForwardReturn(long DakAssignReplyIdFrReturn,String ReturnRemarks) throws Exception {
		return dao.CSWReplyForwardReturn(DakAssignReplyIdFrReturn,ReturnRemarks);
	}

	@Override
	public long ReplyeditDakAssignReply(DakAssignReplyDto dto) throws Exception {
		long DakAssignReplyEditResult = 0;
		long DakAssignReplyAttachEditAddResult = 0;
		long Finalresult = 0;
	
		DakAssignReply model=new DakAssignReply();
		model.setDakAssignReplyId(dto.getDakAssignReplyId());
		model.setDakId(dto.getDakId());
		model.setDakAssignId(dto.getAssignId());
		model.setEmpId(dto.getEmpId());
		model.setReply(dto.getReply());
		model.setModifiedBy(dto.getModifiedBy());
		model.setModifiedDate(dto.getModifiedDate());
		DakAssignReplyEditResult=dao.AssignReplyEdit(model);
		
		if(DakAssignReplyEditResult>0) {
     		
			 DakMain DakDetails = dao.GetDakDetails(dto.getDakId()); 
	    		
	    		if(DakDetails.getDakNo()!=null && dto!=null && dto.getAssignReplyDocs()!=null && dto.getAssignReplyDocs().length>0 && !dto.getAssignReplyDocs()[0].isEmpty()) {
	         
    			for(MultipartFile file : dto.getAssignReplyDocs()) {
    				if(!file.isEmpty()) {
    				 String dakNoPath = DakDetails.getDakNo().replace("/", "_");
      		 		 String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
    				 Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
    				int ExistingDocsCount = dao.GetPrevAssignReplyAttachmentDetails(dto.getDakAssignReplyId()).size()+1;
               		
               		File theDir = fullpath.toFile();
               		if (!theDir.exists()){
               		    theDir.mkdirs();
               		}
    				AssignReplyAttachment attachment=new AssignReplyAttachment();
    				attachment.setDakAssignReplyId(dto.getDakAssignReplyId());
    				attachment.setDakId(dto.getDakId());
    				attachment.setEmpId(dto.getEmpId());
    				attachment.setFilePath(DynamicPath);
    				attachment.setFileName(String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename());
    				attachment.setCreatedBy(dto.getModifiedBy());
    				attachment.setCreatedDate(dto.getModifiedDate());
    				
    				saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename(),file );
    				DakAssignReplyAttachEditAddResult=dao.AssignReplyAttachment(attachment);
          		
          		if(DakAssignReplyAttachEditAddResult>0) {
          			Finalresult = 1;
          		}
    				}
          	}
          }else {
       	   
       	   Finalresult = 1;
          }
    		
    	}
		return Finalresult;
	}

	@Override
	public long DakAssignReplyRev(DakAssignReplyRevDto rdto,String[] PrevFilePathandFileName) throws Exception {
		long DakAssignReplyRev=0;
		long DakAssignReplyAttachRev=0;
		Long CountRev=dao.CountRevisionNo(rdto.getDakAssignReplyId());
		long intialRev=1;
		if(rdto!=null) {
			DakAssignReplyRev replyRev=new DakAssignReplyRev();
			replyRev.setDakAssignReplyId(rdto.getDakAssignReplyId());
			replyRev.setEmpId(rdto.getEmpId());
			replyRev.setReply(rdto.getPreReply());
			replyRev.setReturnRemarks(rdto.getReturnRemarks());
			if(CountRev!=null) {
				replyRev.setRevisionNo(CountRev+1);
			}else {
				replyRev.setRevisionNo(intialRev);
			}
			replyRev.setCreatedBy(rdto.getCreatedBy());
			replyRev.setCreatedDate(rdto.getCreatedDate());
			DakAssignReplyRev=dao.insertDakAssignReplyRev(replyRev);
			if(PrevFilePathandFileName!=null && PrevFilePathandFileName.length>0) {
	        	for(int i=0;i<PrevFilePathandFileName.length;i++) {
	        	String[] PrevFilePathAndFileName = PrevFilePathandFileName[i].split("#");

	        	String FilePath = PrevFilePathAndFileName[0];
	       		String FileName = PrevFilePathAndFileName[1];
				DakAssignReplyAttachRev AttachRev=new DakAssignReplyAttachRev();
				AttachRev.setDakAssignReplyRevId(DakAssignReplyRev);
				AttachRev.setFilePath(FilePath);
				AttachRev.setFileName(FileName);
				AttachRev.setCreatedBy(rdto.getCreatedBy());
				AttachRev.setCreatedDate(rdto.getCreatedDate());
				DakAssignReplyAttachRev=dao.insertDakAssignReplyAttachRev(AttachRev);
			}
		}
		
	}
	
		return DakAssignReplyAttachRev;
	
}

	@Override
	public List<Object[]> getDakActionRequiredEdit(long actionRequiredDakId) throws Exception {
		return dao.getDakActionRequiredEdit(actionRequiredDakId);
	}

	@Override
	public List<Object[]> ProjectDetailedList(String projectId) throws Exception {
		return dao.ProjectDetailedList(projectId);
	}

	@Override
	public long CSWReplyForwardReturn(long DakAssignReplyIdFrReturn) throws Exception {
		return dao.CSWReplyForwardReturn(DakAssignReplyIdFrReturn);
	}

	@Override
	public long EditActionRequired(long ActionRequiredEditDakId, long ActionRequiredEdit,String ClosingAuthority,String EditRemarks) throws Exception {
		return dao.EditActionRequired(ActionRequiredEditDakId,ActionRequiredEdit,ClosingAuthority,EditRemarks);
	}

	@Override
	public long EditActionRequired(long ActionRequiredEditDakId, long ActionRequiredEdit, String dueDate,String actionTime,String ClosingAuthority,String EditRemarks) throws Exception {
		return dao.EditActionRequired(ActionRequiredEditDakId,ActionRequiredEdit,dueDate,actionTime,ClosingAuthority,EditRemarks);
	}

	@Override
	public long updatedakmarkingaction(long ActionRequiredEditDakId, long actionId,String dueDate) throws Exception {
		return dao.updatedakmarkingaction(ActionRequiredEditDakId,actionId,dueDate);
	}

	@Override
	public long updatedakmarkingrecords(long ActionRequiredEditDakId, long actionId) throws Exception {
	  return dao.updatedakmarkingrecords(ActionRequiredEditDakId,actionId);
	}

	@Override
	public long reupdateremarkstatus(String dakId) throws Exception {
		return dao.reupdateremarkstatus(dakId);
	}

	@Override
	public List<Object[]> getReDistributedEmps(String dakId) throws Exception {
		return dao.getReDistributedEmps(dakId);
	}

	@Override
	public List<Object[]> getOldassignemplist(long DakId) throws Exception {
		return dao.getOldassignemplist(DakId);
	}

	@Override
	public long UpdateMarkerAction(long DakId, long DakMarkingId, long EmpId, String actionValue) throws Exception {
		return dao.UpdateMarkerAction(DakId,DakMarkingId,EmpId,actionValue);
	}

	@Override
	public List<Object[]> DakAssignedByMeList(long EmpId,String fromDate, String toDate,long SelEmpId) throws Exception {
		return dao.DakAssignedByMeList(EmpId,fromDate,toDate,SelEmpId);
	}


	@Override
	public List<Object[]> getalldaklinkdata(long DakId) throws Exception {
		return dao.getalldaklinkdata(DakId);
	}

	@Override
	public List<Object[]> DakRemarknRedistributeList(String fromDate, String toDate, String statusValue) throws Exception {
		return dao.DakRemarknRedistributeList(fromDate,toDate,statusValue);
	}

	@Override
	public long DakSeekResponseInsert(DakSeekResponseDto dto, String[] dakCaseWorker,long EmpId) throws Exception {
		long result=0;
		Object[] UserName= null;
		UserName=dao.getUsername(EmpId);
		if(dto!=null ) {
			//Object[] AssignId=dao.GetAssignId(dto.getDakId(),dto.getDakMarkingId());
			for(int i=0;i<dakCaseWorker.length;i++) {
				DakSeekResponse seekresponseinsert=new DakSeekResponse();
				seekresponseinsert.setSeekEmpId(Long.parseLong(dakCaseWorker[i]));
				seekresponseinsert.setDakId(dto.getDakId());
				seekresponseinsert.setSeekAssignerId(dto.getSeekAssignerId());
				seekresponseinsert.setSeekFrom(dto.getSeekFrom());
				seekresponseinsert.setRemarks(dto.getRemarks());
				seekresponseinsert.setReplyStatus(dto.getReplyStatus());
				seekresponseinsert.setCreatedBy(dto.getCreatedBy());
				seekresponseinsert.setCreatedDate(dto.getCreatedDate());
				seekresponseinsert.setIsActive(dto.getIsActive());
				result=dao.Dakseekresponseinsert(seekresponseinsert);
				
				DakNotification notification=new DakNotification();
				notification.setNotificationBy(EmpId);
				notification.setIsActive(1);
				notification.setCreatedBy(dto.getCreatedBy());
				notification.setCreatedDate(dto.getCreatedDate());
				notification.setNotificationMessage("DAK SeekResponse  by "+UserName[0].toString()+","+UserName[1].toString()+".");
				notification.setNotificationDate(sdf2.format(new Date()));
				notification.setEmpId(Long.parseLong(dakCaseWorker[i]));
				notification.setNotificationUrl("DakSeekResponseList.htm");
				dao.DakNotificationInsert(notification);
			}
		}
		return result;
	}

	@Override
	public List<Object[]> getDakSeekResponseListToMe(long empId, String fromDate, String toDate) throws Exception {
		return dao.getDakSeekResponseListToMe(empId,fromDate,toDate);
	}

	@Override
	public List<Object[]> DakSeekResponseByMeList(long empId, String fromDate, String toDate) throws Exception {
		return dao.DakSeekResponseByMeList(empId,fromDate,toDate);
	}

	@Override
	public long InsertDakSeekResponseReply(DakSeekResponseAttachDto dto) throws Exception {
		long SeekResponseReplyInsert=0;
		SeekResponseReplyInsert=dao.SeekResponseReplyInsert(dto.getReply(),dto.getReplyStatus(),dto.getCreatedBy(),dto.getCreatedDate(),dto.getSeekResponseId());
		
		
		if(dto!=null  &&  dto.getSeekResponsereplydocs()!=null && dto.getSeekResponsereplydocs().length>0 && !dto.getSeekResponsereplydocs()[0].isEmpty()) {
			for(MultipartFile file : dto.getSeekResponsereplydocs()) {
				if(!file.isEmpty()) {
					String dakNoPath = dto.getDakNo().replace("/", "_");
  		 			String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
				Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
				int ExistingDocsCount = dao.GetPrevSeekResponseReplyAttachmentDetails(dto.getSeekResponseId()).size()+1;
           		
           		File theDir = fullpath.toFile();
           		if (!theDir.exists()){
           		    theDir.mkdirs();
           		}
           		SeekResponseReplyAttachment attachment=new SeekResponseReplyAttachment();
				attachment.setSeekResponseId(dto.getSeekResponseId());
				attachment.setDakId(dto.getDakId());
				attachment.setEmpId(dto.getEmpId());
				attachment.setFilePath(DynamicPath);
				attachment.setFileName(String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename());
				attachment.setCreatedBy(dto.getCreatedBy());
				attachment.setCreatedDate(dto.getCreatedDate());
				long SeekResponseAttachmentInsert=dao.SeekResponseReplyAttachment(attachment);
				saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename(),file );
				}
			    
			}
		}
		return SeekResponseReplyInsert;
	}

	@Override
	public List<Object[]> GetSeekResponseRelyModalDetails(long DakId, long empId, String username, String createdBy) throws Exception {
		return dao.GetSeekResponseRelyModalDetails(DakId,empId,username,createdBy);
	}

	@Override
	public List<Object[]> GetSeekResponseReplyAttachmentList(long DakReplyId) throws Exception {
		return dao.GetSeekResponseReplyAttachmentList(DakReplyId);
	}

	@Override
	public List<Object[]> GetDakSeekResponseReplyDetails(long DakReplyId) throws Exception {
		return dao.GetDakSeekResponseReplyDetails(DakReplyId);
	}

	@Override
	public DakSeekResponse GetDakSeekResponseReplyEditDetails(long DakReplyId) throws Exception {
		return dao.GetDakSeekResponseReplyEditDetails(DakReplyId);
	}

	@Override
	public List<Object[]> SeekResponseReplyDakAttachmentData(long DakReplyAttachId, long DakReplyId) throws Exception {
		return dao.SeekResponseReplyDakAttachmentData(DakReplyAttachId,DakReplyId);
	}

	@Override
	public int DeleteSeekResponseReplyAttachment(String dakReplyAttachId) throws Exception {
		return dao.DeleteSeekResponseReplyAttachment(dakReplyAttachId);
	}

	@Override
	public long editSeekResponseDakReply(DakSeekResponseAttachDto dakReplyEditdto) throws Exception {
		long SeekResponseReplyUpdate=0;
		long DakSeekResponseReplyAttachEditAddResult = 0;
		long Finalresult = 0;
	
		SeekResponseReplyUpdate=dao.SeekResponseReplyUpdate(dakReplyEditdto.getReply(),dakReplyEditdto.getModifiedBy(),dakReplyEditdto.getModifiedDate(),dakReplyEditdto.getSeekResponseId());
     	
     	if(SeekResponseReplyUpdate>0) {
     		
     		 DakMain DakDetails = dao.GetDakDetails(dakReplyEditdto.getDakId()); 
     		
     		if(DakDetails.getDakNo()!=null && dakReplyEditdto!=null && dakReplyEditdto.getSeekResponsereplydocs()!=null && dakReplyEditdto.getSeekResponsereplydocs().length>0 && !dakReplyEditdto.getSeekResponsereplydocs()[0].isEmpty()) {
          
     			
     			for(MultipartFile file : dakReplyEditdto.getSeekResponsereplydocs()) {
     				if(!file.isEmpty()) {
     			DakSeekResponseAttachDto ReplyAttachDto = new DakSeekResponseAttachDto();
           		ReplyAttachDto.setSeekResponseId(dakReplyEditdto.getSeekResponseId());
           		ReplyAttachDto.setDakId(dakReplyEditdto.getDakId());
           		ReplyAttachDto.setEmpId(dakReplyEditdto.getEmpId());
           		ReplyAttachDto.setFilePath(env.getProperty("file_upload_path"));
           		ReplyAttachDto.setModifiedBy(dakReplyEditdto.getModifiedBy());
           		ReplyAttachDto.setModifiedDate(dakReplyEditdto.getModifiedDate());
           		ReplyAttachDto.setDakNo(DakDetails.getDakNo());
           		ReplyAttachDto.setSeekResponsereplydocs(dakReplyEditdto.getSeekResponsereplydocs());
           		
           		String dakNoPath = ReplyAttachDto.getDakNo().replace("/", "_");
		 		String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
        	    Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
           		int ExistingDocsCount = dao.GetPrevSeekResponseReplyAttachmentDetails(ReplyAttachDto.getSeekResponseId()).size()+1;
           		
           		
           		File theDir = fullpath.toFile(); //as this is already edit theDir would be already existing
           		if (!theDir.exists()){
           		    theDir.mkdirs();
           		}
           		
           		SeekResponseReplyAttachment attachment=new SeekResponseReplyAttachment();
				attachment.setSeekResponseId(ReplyAttachDto.getSeekResponseId());
				attachment.setDakId(ReplyAttachDto.getDakId());
				attachment.setEmpId(ReplyAttachDto.getEmpId());
				attachment.setFilePath(DynamicPath);
				attachment.setFileName(String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename());
				attachment.setModifiedBy(ReplyAttachDto.getModifiedBy());
				attachment.setModifiedDate(ReplyAttachDto.getModifiedDate());
				saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename(),file );
				DakSeekResponseReplyAttachEditAddResult=dao.SeekResponseReplyAttachment(attachment);
           		
           		if(DakSeekResponseReplyAttachEditAddResult>0) {
           			Finalresult = 1;
           		}
     			}
           	}
           }else {
        	   
        	   Finalresult = 1;
           }
     		
     	}
		
		return Finalresult;
	}

	@Override
	public Object[] DakSeekResponseAttachmentData(String dakattachmentid) throws Exception {
		return dao.DakSeekResponseAttachmentData(dakattachmentid);
	}

	@Override
	public List<Object[]> getoldSeekResponseassignemplist(long DakId) throws Exception {
		return dao.getoldSeekResponseassignemplist(DakId);
	}

	@Override
	public List<Object[]> PrevMarkedEmployees(long DakId) throws Exception {
		return dao.PrevMarkedEmployees(DakId);
	}

	@Override
	public long AddToFavourites(long DakMarkingId) throws Exception {
		return dao.AddToFavourites(DakMarkingId);
	}

	@Override
	public long RemoveFavourites(long DakMarkingId) throws Exception {
		return dao.RemoveFavourites(DakMarkingId);
	}

	@Override
	public List<Object[]> DakRepliedToMeList(String username, String fromDate, String toDate) throws Exception {
		return dao.DakRepliedToMeList(username,fromDate,toDate);
	}
	
@Override
public List<Object[]> DakRepliedByMeList(long empId, String fromDate, String toDate, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String employeeId) throws Exception {
	return dao.DakRepliedByMeList(empId,fromDate,toDate,lettertypeid, priorityid, sourcedetailid, sourceId, projectType, projectId, dakMemberTypeId, employeeId);
}

@Override
public List<Object[]> getEmpListForSeekResponse(long DakId, String lab, long empId) throws Exception {
	return dao.getEmpListForSeekResponse(DakId,lab,empId);
}

@Override
public Object[] getClosedByDetails(String closedBy) throws Exception {
	return dao.getClosedByDetails(closedBy);
}

@Override
public List<Object[]> EmpListDropDown(String lab) throws Exception {
	return dao.EmpListDropDown(lab);
}

@Override
public Object[] MarkedEmpCounts(String emp, String fromDate, String toDate, String username) throws Exception {
	return dao.MarkedEmpCounts(emp,fromDate,toDate,username);
}

@Override
public Object[] AssignedEmpCounts(String emp, String fromDate, String toDate, String username) throws Exception {
	return dao.AssignedEmpCounts(emp,fromDate,toDate,username);
}

@Override
public Object[] dakReceivedViewrecived(long empId, long dakId) throws Exception {
	return dao.dakReceivedViewrecived(empId,dakId);
}


@Override
public List<Object[]> AssignData(long dakId, long empId) throws Exception {
	return dao.AssignData(dakId,empId);
}

@Override
public List<Object[]> SeekResponseData(long dakId, long empId) throws Exception {
	return dao.SeekResponseData(dakId,empId);
}

@Override
public List<Object[]> MarkerData(long dakId, long empId) throws Exception {
	return dao.MarkerData(dakId,empId);
}

@Override
public List<Object[]> getSeekResponseList(long MarkedEmpId, long DakId) throws Exception {
	return dao.getSeekResponseList(MarkedEmpId,DakId);
}

@Override
public List<Object[]> getFacilitatorSeekResponseList(long AssignEmpId, long DakId) throws Exception {
	return dao.getFacilitatorSeekResponseList(AssignEmpId,DakId);
}

@Override
public List<Object[]> getRemindEmployeeList(long DakId) throws Exception {
	return dao.getRemindEmployeeList(DakId);
}

@Override
public long InsertDakRemind(DakRemind modal) throws Exception {
	
	Object[] UserName= null;
	
	DakNotification notification=new DakNotification();
	
	if(modal.getCommentType().equalsIgnoreCase("C")) {
    UserName=dao.getUsername(Long.parseLong(modal.getRemindBy().toString()));
	notification.setNotificationBy(modal.getRemindBy());
	notification.setNotificationMessage("DAK Remind by "+UserName[0].toString()+","+UserName[1].toString()+".");
	notification.setEmpId(modal.getRemindTo());
	}else if(modal.getCommentType().equalsIgnoreCase("R")) {
		UserName=dao.getUsername(Long.parseLong(modal.getRemindTo().toString()));
		notification.setNotificationBy(modal.getRemindTo());
		notification.setNotificationMessage("DAK Remind Replied by "+UserName[0].toString()+","+UserName[1].toString()+".");
		notification.setEmpId(modal.getRemindBy());
	}
	notification.setIsActive(1);
	notification.setCreatedBy(modal.getCreatedBy());
	notification.setCreatedDate(modal.getCreatedDate());
	notification.setNotificationDate(sdf2.format(new Date()));
	notification.setNotificationUrl(modal.getUrl());
	dao.DakNotificationInsert(notification);
	return dao.InsertDakRemind(modal);
}

@Override
public List<Object[]> getRemindToDetailsList(long DakId, long EmpId) throws Exception {
	return dao.getRemindToDetailsList(DakId,EmpId);
}

@Override
public List<Object[]> getPerticularRemindToDetails(long DakId, long empId) throws Exception {
	return dao.getPerticularRemindToDetails(DakId,empId);
}
@Override
public long UpdateDakRemind(String reply, long dakId, long empId, String ReplyDate) throws Exception {
	return dao.UpdateDakRemind(reply,dakId,empId,ReplyDate);
}

public long InsertMailTrackInitiator(String TrackingType,long ExpectedCount) throws Exception {
	long rowAddResult = 0;
	DakMailTracking Model  = new DakMailTracking();
	Model.setTrackingType(TrackingType);
	Model.setMailExpectedCount(ExpectedCount);
	Model.setMailSentCount(ExpectedCount);
	Model.setMailSentStatus("S");
	Model.setCreatedDate(sdf2.format(new Date()));
	Model.setMailSentDateTime(sdf1.format(new Date()));
	Model.setCreatedTime(new SimpleDateFormat("HH:mm:ss").format(new Date()));
    rowAddResult = dmsdao.InsertMailTrackRow(Model);
	return rowAddResult;
}

public long InsertSummaryDistributedInsights(long MailTrackingId,String DakId)throws Exception{
	   long TrackingInsightsResult = 0;
	   List<Object[]> MarkedEmpsDetailstoSendMail = dao.GetDistributedDakMembers(Long.parseLong(DakId));
	    if (MarkedEmpsDetailstoSendMail != null && MarkedEmpsDetailstoSendMail.size() > 0) {
	    	for(Object[] obj:MarkedEmpsDetailstoSendMail) {
	            // Create a new instance of DakMailTrackingInsights for each entry
	            DakMailTrackingInsights Insights = new DakMailTrackingInsights();
	            Insights.setMailTrackingId(MailTrackingId);
	            Insights.setMailPurpose("U");
	            Insights.setMailStatus("S");
	            Insights.setCreatedDate(sdf1.format(new Date()));
	            Insights.setEmpId(Long.parseLong(obj[2].toString()));
	            Insights.setDakNos(obj[9].toString());
	            Insights.setMailSentDate(sdf1.format(new Date()));
	            // Insert the row into the table for this entry
	            long result = dmsdao.InsertMailTrackInsights(Insights);
	            TrackingInsightsResult = result;
	        }
	    }
	 return TrackingInsightsResult;
}

@Override
public Object[] EnoteAssignReplyData(long DakId,long EmpId) throws Exception {
	return dao.EnoteAssignReplyData(DakId,EmpId);
}

@Override
public List<Object[]> EnoteAssignReplyAttachmentData(long DakId) throws Exception {
	return dao.EnoteAssignReplyAttachmentData(DakId);
}

@Override
public List<Object[]> InitiatedByEmployeeList(long divisionId, String lab) throws Exception {
	return dao.InitiatedByEmployeeList(divisionId,lab);
}

@Override
public Object getDivisionId(long empId) throws Exception {
	return dao.getDivisionId(empId);
}

@Override
public Object[] EnoteMarkerReplyData(long DakId, long empId) throws Exception {
	return dao.EnoteMarkerReplyData(DakId,empId);
}

@Override
public List<Object[]> EnoteMarkerReplyAttachmentData(long DakReplyId) throws Exception {
	return dao.EnoteMarkerReplyAttachmentData(DakReplyId);
}

@Override
public Object[] MailSentDetails(String TypeOfHost) throws Exception {
	return dao.MailSentDetails(TypeOfHost);
}

@Override
public List<Object[]> MailReceivedEmpDetails(long empId,String HostType) throws Exception {
	return dao.MailReceivedEmpDetails(empId,HostType);
}


@Override
public long insertDakCreate(DakAddDto dakdto, Long EmpId, String[] dakLinkId) throws Exception {
	DakCreate dak = dakdto.getDakcreate();
	DakCreateAttachDto dakdto1 = new DakCreateAttachDto();
	/***************old code of DAK No creation start*************************/
	/***************new code of DAK No creation start*************************/
	//(DAK No will start with D and than date Month Year and this will change each day and than _ 001 and this number restarts again each day after 10 clock)
	 SimpleDateFormat RequiredFormat = new SimpleDateFormat("ddMMMyy");
	 String DayMonYear = RequiredFormat.format(new Date()); //currentDate
	 String DakStr = "D"+DayMonYear+"_";
	 long count;
	// Determine the desired width of the count (e.g., 3 for "001")
	 int width = 3;
     long DakCreateIdcount=dao.DakCreateCountFrDakNoCreation();
	 //This count will start with 001 after new day starts
	 //Ex if current date is 08/08/23 and we will check DAK counts by comparing current date with all created dates of dak
	 // if it returns>0 then than DakIdcount+1;
	 // if it returns<0 then than DakIdcount i.e 001;
	 if(DakCreateIdcount>0) {
		 count = DakCreateIdcount
				 +1;
	 }else {
		 count = 1;
	 }
	 
	// Format the count with leading zeros
	 String formattedCount = String.format("%0" + width + "d", count);
	 
	 String NewDakNo = dak.getDivisionCode().toString()+"_"+ "C"+ "_"+ DakStr+formattedCount;
     dak.setDakNo(NewDakNo);
    /***************new code of DAK No creation end*************************/
	
     
	long DakCreateId=dao.insertDakCreate(dak); 
	
	if(DakCreateId>0) {
		
		for(int i=0;i<dakLinkId.length;i++) {
			DakCreateLink link=new DakCreateLink();
				link.setDakCreateId(DakCreateId);
				link.setLinkDakCreateId(Long.parseLong(dakLinkId[i]));
				link.setCreatedBy(dak.getCreatedBy());
				link.setCreatedDate(dak.getCreatedDate());
				dao.getDakCreateLinkDetails(link);
		}
	}
	DakTransaction trans=new DakTransaction();
	trans.setEmpId(EmpId);
	trans.setDakId(DakCreateId);
	trans.setDakStatus("DI");
	trans.setTransactionDate(sdf1.format(new Date()));
	trans.setRemarks("NA");
    dao.getDakTransInsert(trans);
    
    if(!dakdto.getMainDoc().isEmpty()){
    	dakdto1.setDakCreateId(DakCreateId);
		dakdto1.setFilePath(env.getProperty("file_upload_path"));
		dakdto1.setCreatedBy(dak.getCreatedBy());
		dakdto1.setCreatedDate(dak.getCreatedDate());
		dakdto1.setFile(dakdto.getMainDoc());
		dakdto1.setRefNo(dak.getRefNo());
		dakdto1.setType("M");
		dakdto1.setDakNo(dak.getDakNo());
		
		String dakNoPath = dakdto1.getDakNo().replace("/", "_");
		String DynamicPath = Paths.get(dakNoPath, "Inbox").toString();
		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
		int count1 = dao.GetDakCreateAttachmentDetails(dakdto1.getDakCreateId(),dakdto1.getType()).size()+1;
		
		File theDir = fullpath.toFile();
		if (!theDir.exists()){
		    theDir.mkdirs();
		}
		DakCreateAttach model = new DakCreateAttach();
		model.setDakCreateId(dakdto1.getDakCreateId());
		model.setIsMain(dakdto1.getType());
		model.setFilePath(DynamicPath);
		model.setFileName(dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename());
		model.setCreatedBy(dakdto1.getCreatedBy());
		model.setCreatedDate(dakdto1.getCreatedDate());
		
		saveFile1(fullpath, dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename(), dakdto1.getFile());
		long result=dao.DakCreateAttachmentFile(model);
		
    }
	
    if(dakdto!=null && dakdto.getSubDoc()!=null && dakdto.getSubDoc().length>0 && !dakdto.getSubDoc()[0].isEmpty() ) {
    	for(MultipartFile file : dakdto.getSubDoc()) {
    		if(!file.isEmpty()) {
    			
    		DakCreateAttachDto dakdto2 = new DakCreateAttachDto();
    		dakdto2.setDakCreateId(DakCreateId);
    		dakdto2.setFilePath(env.getProperty("file_upload_path"));
    		dakdto2.setCreatedBy(dak.getCreatedBy());
    		dakdto2.setCreatedDate(dak.getCreatedDate());
    		dakdto2.setSubFile(dakdto.getSubDoc());
    		dakdto2.setRefNo(dak.getRefNo());
    		dakdto2.setType("S");
    		dakdto2.setDakNo(dak.getDakNo());
    		
    		String dakNoPath = dakdto1.getDakNo().replace("/", "_");
    		String DynamicPath = Paths.get(dakNoPath, "Inbox").toString();
    		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
    		int count1 = dao.GetDakCreateAttachmentDetails(dakdto2.getDakCreateId(),dakdto2.getType()).size()+1;
    		
    		File theDir = fullpath.toFile();
    		if (!theDir.exists()){
    		    theDir.mkdirs();
    		}
    		DakCreateAttach model = new DakCreateAttach();
    		model.setDakCreateId(dakdto2.getDakCreateId());
    		model.setIsMain(dakdto2.getType());
    		model.setFilePath(DynamicPath);
    		model.setFileName(dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename());
    		model.setCreatedBy(dakdto2.getCreatedBy());
    		model.setCreatedDate(dakdto2.getCreatedDate());
    		
    		saveFile1(fullpath, dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename(),file);
    		long result=dao.DakCreateAttachmentFile(model);
    		}
    	}
    }
	return DakCreateId;
}


@Override
public long insertLabDak(DakAddDto dakdto, Long EmpId,MultipartFile maindoc, MultipartFile[] sobdocs) throws Exception {
	DakMain dak = dakdto.getDak();
	DakAttachmentDto dakdto1 = new DakAttachmentDto();
	/***************old code of DAK No creation start*************************/
	/***************new code of DAK No creation start*************************/
	//(DAK No will start with D and than date Month Year and this will change each day and than _ 001 and this number restarts again each day after 10 clock)
	 SimpleDateFormat RequiredFormat = new SimpleDateFormat("ddMMMyy");
	 String DayMonYear = RequiredFormat.format(new Date()); //currentDate
	 String DakStr = "D"+DayMonYear+"_";
	 long count;
	// Determine the desired width of the count (e.g., 3 for "001")
	 int width = 3;
     long DakIdcount=dao.DakCountFrDakNoCreation();
	 //This count will start with 001 after new day starts
	 //Ex if current date is 08/08/23 and we will check DAK counts by comparing current date with all created dates of dak
	 // if it returns>0 then than DakIdcount+1;
	 // if it returns<0 then than DakIdcount i.e 001;
	 if(DakIdcount>0) {
		 count = DakIdcount+1;
	 }else {
		 count = 1;
	 }
	 
	// Format the count with leading zeros
	 String formattedCount = String.format("%0" + width + "d", count);
	 
	 String NewDakNo = dak.getCreateLabCode()+"_"+"R"+"_"+ DakStr+formattedCount;
     dak.setDakNo(NewDakNo);
    /***************new code of DAK No creation end*************************/
	
     
	long DakId=dao.insertDak(dak); 
	
	if(DakId>0) {
    if(!maindoc.isEmpty()){
    	dakdto1.setDakId(DakId);
		dakdto1.setFilePath(env.getProperty("file_upload_path"));
		dakdto1.setCreatedBy(dak.getCreatedBy());
		dakdto1.setCreatedDate(dak.getCreatedDate());
		dakdto1.setFile(maindoc);
		dakdto1.setRefNo(dak.getRefNo());
		dakdto1.setType("M");
		dakdto1.setDakNo(dak.getDakNo());
		
		String dakNoPath = dakdto1.getDakNo().replace("/", "_");
		String DynamicPath = Paths.get(dakNoPath, "Inbox").toString();
		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
		int count1 = dao.GetAttachmentDetails(dakdto1.getDakId(),dakdto1.getType()).size()+1;
		
		File theDir = fullpath.toFile();
		if (!theDir.exists()){
		    theDir.mkdirs();
		}
		DakAttachment model = new DakAttachment();
		model.setDakId(dakdto1.getDakId());
		model.setIsMain(dakdto1.getType());
		model.setFilePath(DynamicPath);
		model.setFileName(dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename());
		model.setCreatedBy(dakdto1.getCreatedBy());
		model.setCreatedDate(dakdto1.getCreatedDate());
		
		
		saveFile1(fullpath, dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename(), dakdto1.getFile());
		long result=dao.DakAttachmentFile(model);
		
    }
	
    if(dakdto!=null && sobdocs!=null && sobdocs.length>0 && !sobdocs[0].isEmpty() ) {
    	for(MultipartFile file : sobdocs) {
    		if(!file.isEmpty()) {
    			
    		DakAttachmentDto dakdto2 = new DakAttachmentDto();
    		dakdto2.setDakId(DakId);
    		dakdto2.setFilePath(env.getProperty("file_upload_path"));
    		dakdto2.setCreatedBy(dak.getCreatedBy());
    		dakdto2.setCreatedDate(dak.getCreatedDate());
    		dakdto2.setSubFile(sobdocs);
    		dakdto2.setRefNo(dak.getRefNo());
    		dakdto2.setType("S");
    		dakdto2.setDakNo(dak.getDakNo());
    		
    		String dakNoPath = dakdto1.getDakNo().replace("/", "_");
    		String DynamicPath = Paths.get(dakNoPath, "Inbox").toString();
    		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
    		int count1 = dao.GetAttachmentDetails(dakdto2.getDakId(),dakdto2.getType()).size()+1;
    		
    		File theDir = fullpath.toFile();
    		if (!theDir.exists()){
    		    theDir.mkdirs();
    		}
    		DakAttachment model = new DakAttachment();
    		model.setDakId(dakdto2.getDakId());
    		model.setIsMain(dakdto2.getType());
    		model.setFilePath(DynamicPath);
    		model.setFileName(dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename());
    		model.setCreatedBy(dakdto2.getCreatedBy());
    		model.setCreatedDate(dakdto2.getCreatedDate());
    		
    		saveFile1(fullpath, dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename(),file);
    		long result=dao.DakAttachmentFile(model);
    		}
    	}
    }
	}
	return DakId;
}

@Override
public long insertDakDestination(DakCreateDestination destination) throws Exception {
	return dao.insertDakDestination(destination);
}


@Override
public Object[] labDakData(long result) throws Exception {
	return dao.labDakData(result);
}

@Override
public List<Object[]> dakCreationList(String fromDate,String toDate) throws Exception {
	return dao.dakCreationList(fromDate,toDate);
}

@Override
public List<Object[]> DakDestinationDetailsList(long DakId,String LabCode) throws Exception {
	 List<Object[]> data = dao.DakDestinationDetailsList(DakId);
	    List<Object[]> finalResponseList = new ArrayList<>();
	    RestTemplate restTemplate = new RestTemplate();

	    for (Object[] row : data) {
	        try {
	            Long dakCreateId = row[0] != null ? Long.parseLong(row[0].toString()) : null;
	            String apiUrl = row[4] != null ? row[4].toString() : null;
	            String reply = row[6] !=null ? row[6].toString() : null;
	            String replyStatus = row[7] !=null ? row[7].toString() : null;
	            if (apiUrl != null && !apiUrl.isEmpty() && dakCreateId != null) {
	                String finalUrl = UriComponentsBuilder.fromHttpUrl(apiUrl)
	                        .path("/getDakData") 
	                        .queryParam("dakCreateId", dakCreateId)
	                        .queryParam("LabCode", LabCode)
	                        .toUriString();

	                ResponseEntity<Object[]> responseEntity = restTemplate.exchange(
	                        finalUrl,
	                        HttpMethod.GET,
	                        null,
	                        Object[].class
	                );

	                Object[] apiResponse = responseEntity.getBody();

	                if (apiResponse != null) {
	                	 Object[] combinedResponse = new Object[apiResponse.length + 3];
	                	 System.arraycopy(apiResponse, 0, combinedResponse, 0, apiResponse.length);
	                	 combinedResponse[apiResponse.length] = apiUrl;
	                	 combinedResponse[apiResponse.length + 1] = reply;
	                	 combinedResponse[apiResponse.length + 2] = replyStatus;
	                	 finalResponseList.add(combinedResponse);
	                } else {
	                    finalResponseList.add(row); 
	                }
	            } else {
	                finalResponseList.add(row);
	            }
	        } catch (Exception apiException) {
	            apiException.printStackTrace();

	            // Add the original row even if API call fails
	            finalResponseList.add(row);
	        }
	    }

	    // Return the final list combining original data and API responses
	    return finalResponseList;
}


@Override
public DakCreate findByDakCreateId(long DakCreateId) throws Exception {
	return dao.findByDakCreateId(DakCreateId);
}

@Override
public List<Object[]> selDestinationTypeList(long DakCreateId) throws Exception {
	return dao.selDestinationTypeList(DakCreateId);
}

@Override
public List<Object[]> DakCreateLinkList() throws Exception {
	return dao.DakCreateLinkList();
}

@Override
public List<Object[]> dakCreateLinkData(long DakCreateId) throws Exception {
	return dao.dakCreateLinkData(DakCreateId);
}

@Override
public List<Object[]> GetDakCreateAttachmentDetails(long DakId, String attachtype) throws Exception {
	return dao.GetDakCreateAttachmentDetails(DakId,attachtype);
}

@Override
public Object[] dakCreateattachmentdata(String dakattachmentid) throws Exception {
	return dao.dakCreateattachmentdata(dakattachmentid);
}

@Override
public int DeleteDakCreateAttachment(String dakattachmentid) throws Exception {
	return dao.DeleteDakCreateAttachment(dakattachmentid);
}

@Override
public long saveDakCreateEdit(String dakAttachmentId, DakAddDto dakdto, DakCreate dak, String actionCode,String[] dakLinkId) throws Exception {
			long result=0;
    
			DakCreate dakdata=dao.findByDakCreateId(dak.getDakCreateId());
			dakdata.setDakCreateId(dak.getDakCreateId());
			dakdata.setSubject(dak.getSubject());
			dakdata.setDakNo(dak.getDakNo());
			dakdata.setRefNo(dak.getRefNo());
			dakdata.setReceiptDate(dak.getReceiptDate());
			dakdata.setRefDate(dak.getRefDate());
			dakdata.setDestinationId(dak.getDestinationId());
			dakdata.setPriorityId(dak.getPriorityId());
			dakdata.setSignatory(dak.getSignatory());
			dakdata.setDeliveryTypeId(dak.getDeliveryTypeId());
			dakdata.setLetterTypeId(dak.getLetterTypeId());
			dakdata.setKeyWord1(dak.getKeyWord1());
			dakdata.setKeyWord2(dak.getKeyWord2());
			dakdata.setKeyWord3(dak.getKeyWord3());
			dakdata.setKeyWord4(dak.getKeyWord4());
			dakdata.setRemarks(dak.getRemarks());
			dakdata.setActionId(dak.getActionId());
			
			
			if(actionCode.equalsIgnoreCase("ACTION") && dak.getActionDueDate()!=null) {
				dakdata.setActionDueDate(dak.getActionDueDate());
				dakdata.setActionTime(dak.getActionTime());
				dakdata.setReplyOpen("Y");
			}else {
				dakdata.setActionDueDate(dak.getActionDueDate());
				dakdata.setActionTime(dak.getActionTime());
				dakdata.setReplyOpen("N");
			}
			dakdata.setReplyStatus("N");
			dakdata.setDakStatus("DI");
			dakdata.setDivisionCode(dak.getDivisionCode());
			dakdata.setLabCode(dak.getLabCode());
			dakdata.setModifiedBy(dak.getModifiedBy());
			dakdata.setModifiedDate(dak.getModifiedDate());
			dakdata.setIsActive(1);
			result=dao.saveDakCreate(dakdata);
		    
			//LinK Add Code Starts
			if(result>0 && dao.DeletedDakCreateLink(dak.getDakCreateId())>0) {
			for(int i=0;i<dakLinkId.length;i++) {
				DakCreateLink link=new DakCreateLink();
			link.setDakCreateId(result);
			link.setLinkDakCreateId(Long.parseLong(dakLinkId[i]));
			link.setCreatedBy(dak.getModifiedBy());
			link.setCreatedDate(dak.getModifiedDate());
			dao.getDakCreateLinkDetails(link);
			}

	
			if(dakdto.getMainDoc()!=null && !dakdto.getMainDoc().isEmpty()){
			 
				DakCreateAttachDto dakdto1 = new DakCreateAttachDto();
				dakdto1.setDakCreateId(dak.getDakCreateId());
				dakdto1.setFilePath(env.getProperty("file_upload_path"));
				dakdto1.setModifiedBy(dak.getModifiedBy());
				dakdto1.setModifiedDate(dak.getModifiedDate());
				dakdto1.setFile(dakdto.getMainDoc());
				dakdto1.setRefNo(dak.getRefNo());
				dakdto1.setType("M");
				dakdto1.setDakNo(dak.getDakNo());
				if(dakAttachmentId!=null) {
					 long DakAttachmentIdsel=Long.parseLong(dakAttachmentId);
				dakdto1.setDakCreateAttachmentId(DakAttachmentIdsel);
				}
				
				String dakNoPath = dakdto1.getDakNo().replace("/", "_");
				String DynamicPath = Paths.get(dakNoPath, "Inbox").toString();
				Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
				int count1 = dao.GetDakCreateAttachmentDetails(dakdto1.getDakCreateId(),dakdto1.getType()).size()+1;
				
				File theDir = fullpath.toFile();
				if (!theDir.exists()){
				    theDir.mkdirs();
				}
			
				DakCreateAttach model = new DakCreateAttach();
				model.setDakCreateId(dakdto1.getDakCreateId());
				model.setIsMain(dakdto1.getType());
				model.setFilePath(DynamicPath);
				model.setFileName(dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename());
				model.setModifiedBy(dakdto1.getModifiedBy());
				model.setModifiedDate(dakdto1.getModifiedDate());
			
				int AttachId=dao.DeleteDakCreateAttachment(dakAttachmentId);
				if(dakAttachmentId!=null && AttachId>0){
				if(count1<=2&&dakdto1.getType().equalsIgnoreCase("M")) {
					saveFile1(fullpath, dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename(), dakdto1.getFile());
					result=dao.DakCreateAttachmentFile(model);
				
			    }
				}else {
			    	if(count1<2&&dakdto1.getType().equalsIgnoreCase("M")) {
						saveFile1(fullpath, dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename(), dakdto1.getFile());
						result=dao.DakCreateAttachmentFile(model);
					}
				}  
			}

			if(dakdto!=null && dakdto.getSubDoc()!=null && dakdto.getSubDoc().length>0 && !dakdto.getSubDoc()[0].isEmpty()) {
				for(MultipartFile file : dakdto.getSubDoc()) {
					if(!file.isEmpty()) {
						DakCreateAttachDto dakdto2 = new DakCreateAttachDto();
					dakdto2.setDakCreateId(dak.getDakCreateId());
					dakdto2.setFilePath(env.getProperty("file_upload_path"));
					dakdto2.setModifiedBy(dak.getModifiedBy());
					dakdto2.setModifiedDate(dak.getModifiedDate());
					dakdto2.setSubFile(dakdto.getSubDoc());
					dakdto2.setRefNo(dak.getRefNo());
					dakdto2.setType("S");
					dakdto2.setDakNo(dak.getDakNo());
					if(dakAttachmentId!=null) {
					   long DakAttachmentIdsel=Long.parseLong(dakAttachmentId);
					dakdto2.setDakCreateAttachmentId(DakAttachmentIdsel);
					 }
					String dakNoPath = dakdto2.getDakNo().replace("/", "_");
					String DynamicPath = Paths.get(dakNoPath, "Inbox").toString();
					Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
					int count1 = dao.GetDakCreateAttachmentDetails(dakdto2.getDakCreateId(),dakdto2.getType()).size()+1;
					
					File theDir = fullpath.toFile();
					if (!theDir.exists()){
					    theDir.mkdirs();
					}
					DakCreateAttach model = new DakCreateAttach();
					model.setDakCreateId(dakdto2.getDakCreateId());
					model.setIsMain(dakdto2.getType());
					model.setFilePath(DynamicPath);
					model.setFileName(dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename());
					model.setModifiedBy(dakdto2.getModifiedBy());
					model.setModifiedDate(dakdto2.getModifiedDate());
					
					
					saveFile1(fullpath, dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename(),file);
					long count=dao.DakCreateAttachmentFile(model);
				}
				}
			}
		}

	return result;
	}


@Override
public long updateIsActiveselDestination(long result, long DestinationTypeId,int isActive) throws Exception {
	return dao.updateIsActiveselDestination(result,DestinationTypeId,isActive);
}

@Override
public List<Object[]> dakCreationPendingList() throws Exception {
	return dao.dakCreationPendingList();
}


@Override
public long DakAssignUpdate(String empIdAssignDelete, String dakIdAssignDelete,int IsActive,String Remarks) throws Exception {
	return dao.DakAssignUpdate(empIdAssignDelete,dakIdAssignDelete,IsActive,Remarks);
}

@Override
public List<Object[]> dakListForTrack(String fromDate, String toDate) throws Exception {
	return dao.dakListForTrack(fromDate,toDate);
}


@Override
public Object[] getDakDataforShow(Long dakCreateId,String labCode) throws Exception {
	return dao.getDakDataforShow(dakCreateId,labCode);
}

@Override
public List<Object[]> LabDakTrackingList(String dakId, String url) throws Exception {
    List<Object[]> finalTrackData = null;
    RestTemplate restTemplate = new RestTemplate();
    
    try {
        // Validate inputs
        Long seldakId = dakId != null ? Long.parseLong(dakId) : null;
        String apiUrl = url != null ? url : null;

        if (apiUrl != null && !apiUrl.isEmpty() && seldakId != null) {
            // Build the API URL
            String finalUrl = UriComponentsBuilder.fromHttpUrl(apiUrl)
                    .path("/labDakTrackingData") 
                    .queryParam("seldakId", seldakId)
                    .toUriString();

            // Call the external API with ParameterizedTypeReference for List<Object[]>
            ResponseEntity<List<Object[]>> responseEntity = restTemplate.exchange(
                    finalUrl,
                    HttpMethod.GET,
                    null,
                    new ParameterizedTypeReference<List<Object[]>>() {}
            );

            List<Object[]> apiResponse = responseEntity.getBody();
            if (apiResponse != null) {
                finalTrackData = apiResponse;
            }
        } else {
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return finalTrackData;
}


@Override
public long insertMainLabDAKReply(DakDestinationDto dto) throws Exception {
    RestTemplate restTemplate = new RestTemplate();
    try {
        if (dto != null) {
            Long seldakCreateId = dto.getDakCreateId();
            Long seldestinationId = dto.getDestinationTypeId();
            String apiUrl = dto.getAppUrl();
            String reply = (dto.getReply() != null) ? dto.getReply() : "";
            String modifiedBy = (dto.getModifiedBy() != null) ? dto.getModifiedBy() : "";
            
            String replyEncoded = URLEncoder.encode(reply, StandardCharsets.UTF_8.name());
            
            Object empNameObj = dao.getEmpName(dto.getEmpId());
            String emp = (empNameObj != null) ? empNameObj.toString() : "Unknown";

            if (apiUrl != null && !apiUrl.isEmpty() && seldakCreateId != null) {
                String finalUrl = UriComponentsBuilder.fromHttpUrl(apiUrl)
                        .path("ReplyForMainLab")
                        .queryParam("seldakCreateId", seldakCreateId)
                        .queryParam("seldestinationId", seldestinationId)
                        .queryParam("reply", replyEncoded)
                        .queryParam("modifiedBy", modifiedBy)
                        .toUriString();

                ResponseEntity<Long> responseEntity = restTemplate.exchange(finalUrl, HttpMethod.GET, null, Long.class);
                Long updatedValue = responseEntity.getBody();
                if (updatedValue != null && updatedValue > 0) {
                    if (dto.getReplyPersonSentMail() != null && dto.getReplyReceivedMail() != null && dto.getHostType() != null) {
                        String subject = (dto.getReplyMailSubject() != null) ? dto.getReplyMailSubject() : "No Subject";
                        String messageBody = (dto.getReply() != null) ? dto.getReply() : "";

                        String message = "<p>Dear Sir/Madam,</p>";
                        message += "<p></p>";
                        message += "<p>" + messageBody + "</p>";
                        message += "<p>Regards,<br>" + emp + "</p>";

                        if (dto.getHostType().equalsIgnoreCase("D")) {
                            for (String recipient : dto.getReplyReceivedMail()) {
                                sendMessage1(dto.getReplyPersonSentMail(), recipient, subject, message, new ArrayList<>());
                            }
                        } else if (dto.getHostType().equalsIgnoreCase("L")) {
                            for (String recipient : dto.getReplyReceivedMail()) {
                                sendMessage(dto.getReplyPersonSentMail(), recipient, subject, message, new ArrayList<>());
                            }
                        }
                    }

                    if (dto.getDakId() != null && dto.getModifiedBy() != null) {
                        dao.DakCloseUpdate(dto.getDakId(), dto.getModifiedBy(), sdf1.format(new Date()), sdf2.format(new Date()), dto.getClosingComment());
                    } else {
                    }

                    return updatedValue;
                } else {
                    return -1;
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1;
}



@Override
public long updateLabReply(Long seldakCreateId, Long seldestinationId, String reply,String modifiedBy,String modifiedDate) throws Exception {
	return dao.updateLabReply(seldakCreateId,seldestinationId,reply,modifiedBy,modifiedDate);
}

@Override
public Object[] SourceDetailData(String labCode) throws Exception {
	return dao.SourceDetailData(labCode);
}


@Override
public long newinsertDak(DakAddDto dakdto, Long empId, String[] dakLinkId) throws Exception {
	DakMain dak = dakdto.getDak();
	DakAttachmentDto dakdto1 = new DakAttachmentDto();
	 SimpleDateFormat RequiredFormat = new SimpleDateFormat("ddMMMyy");
	 String DayMonYear = RequiredFormat.format(new Date());
	 String DakStr = "D"+DayMonYear+"_";
	 long count;
	 int width = 3;
     long DakIdcount=dao.DakCountFrDakNoCreation();
	 if(DakIdcount>0) {
		 count = DakIdcount+1;
	 }else {
		 count = 1;
	 }
	 String formattedCount = String.format("%0" + width + "d", count);
	 String NewDakNo = dak.getLabCode()+"_"+"R"+"_"+ DakStr+formattedCount;
     dak.setDakNo(NewDakNo);
	long DakId=dao.insertDak(dak); 
	if(DakId>0) {
    if(!dakdto.getMainDoc().isEmpty()){
    	dakdto1.setDakId(DakId);
		dakdto1.setFilePath(env.getProperty("file_upload_path"));
		dakdto1.setCreatedBy(dak.getCreatedBy());
		dakdto1.setCreatedDate(dak.getCreatedDate());
		dakdto1.setFile(dakdto.getMainDoc());
		dakdto1.setRefNo(dak.getRefNo());
		dakdto1.setType("M");
		dakdto1.setDakNo(dak.getDakNo());
		
		String dakNoPath = dakdto1.getDakNo().replace("/", "_");
		String DynamicPath = Paths.get(dakNoPath, "Inbox").toString();
		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
		int count1 = dao.GetAttachmentDetails(dakdto1.getDakId(),dakdto1.getType()).size()+1;
		
		File theDir = fullpath.toFile();
		if (!theDir.exists()){
		    theDir.mkdirs();
		}
		DakAttachment model = new DakAttachment();
		model.setDakId(dakdto1.getDakId());
		model.setIsMain(dakdto1.getType());
		model.setFilePath(DynamicPath);
		model.setFileName(dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename());
		model.setCreatedBy(dakdto1.getCreatedBy());
		model.setCreatedDate(dakdto1.getCreatedDate());
		
		
		saveFile1(fullpath, dakdto1.getType()+"_"+dakdto1.getFile().getOriginalFilename(), dakdto1.getFile());
		long result=dao.DakAttachmentFile(model);
		
    }
	
    if(dakdto!=null && dakdto.getSubDoc()!=null && dakdto.getSubDoc().length>0 && !dakdto.getSubDoc()[0].isEmpty() ) {
    	for(MultipartFile file : dakdto.getSubDoc()) {
    		if(!file.isEmpty()) {
    			
    		DakAttachmentDto dakdto2 = new DakAttachmentDto();
    		dakdto2.setDakId(DakId);
    		dakdto2.setFilePath(env.getProperty("file_upload_path"));
    		dakdto2.setCreatedBy(dak.getCreatedBy());
    		dakdto2.setCreatedDate(dak.getCreatedDate());
    		dakdto2.setSubFile(dakdto.getSubDoc());
    		dakdto2.setRefNo(dak.getRefNo());
    		dakdto2.setType("S");
    		dakdto2.setDakNo(dak.getDakNo());
    		
    		String dakNoPath = dakdto1.getDakNo().replace("/", "_");
    		String DynamicPath = Paths.get(dakNoPath, "Inbox").toString();
    		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
    		int count1 = dao.GetAttachmentDetails(dakdto2.getDakId(),dakdto2.getType()).size()+1;
    		
    		File theDir = fullpath.toFile();
    		if (!theDir.exists()){
    		    theDir.mkdirs();
    		}
    		DakAttachment model = new DakAttachment();
    		model.setDakId(dakdto2.getDakId());
    		model.setIsMain(dakdto2.getType());
    		model.setFilePath(DynamicPath);
    		model.setFileName(dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename());
    		model.setCreatedBy(dakdto2.getCreatedBy());
    		model.setCreatedDate(dakdto2.getCreatedDate());
    		
    		saveFile1(fullpath, dakdto2.getType()+String.valueOf(count1)+"_"+file.getOriginalFilename(),file);
    		long result=dao.DakAttachmentFile(model);
    		}
    	}
    }
    
    if(dakdto!=null && dakdto.getMarkedEmps().length>0) {
    	for(int i=0;i<dakdto.getMarkedEmps().length;i++) {
    	 String[] EmpandMarkingValues = dakdto.getMarkedEmps();

    	String selempId = EmpandMarkingValues[i];	 
    	DakMarking marking=new DakMarking();
    	marking.setDakId(DakId);
    	marking.setEmpId(Long.parseLong(selempId)); 
    	marking.setDakMemberTypeId(Long.valueOf(0));
    	marking.setActionId(dak.getActionId());
    	marking.setReplyOpen(dak.getReplyOpen());
    	marking.setRemarkup("N");
    	marking.setActionDueDate(dak.getActionDueDate());
    	marking.setDakAckStatus("N");
    	marking.setDakAssignStatus("N");
    	marking.setMsgType("N");
    	marking.setFavourites(0);
    	marking.setCreatedBy(dak.getCreatedBy());
    	marking.setCreatedDate(dak.getCreatedDate());
    	marking.setIsActive(1);
    	dao.getDakMarkingInsert(marking);
    	}
    	}
    
	}
	return DakId;
}


@Override
public List<Object[]> selectedNewDakEmployees(long dakCreateId,String labCode) throws Exception {
	return dao.selectedNewDakEmployees(dakCreateId,labCode);
}

@Override
public List<Object[]> closingAuthorityList() throws Exception {
	return dao.closingAuthorityList();
}
}

