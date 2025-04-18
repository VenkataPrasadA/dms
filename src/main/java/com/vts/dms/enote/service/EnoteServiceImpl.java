package com.vts.dms.enote.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Properties;

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
import org.apache.poi.util.Units;
import org.apache.poi.wp.usermodel.HeaderFooterType;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFHeader;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.dms.DateTimeFormatUtil;
import com.vts.dms.controller.CustomJavaMailSender;
import com.vts.dms.controller.CustomSMSProxySender;
import com.vts.dms.dak.dao.DakDao;
import com.vts.dms.dak.model.AssignReplyAttachment;
import com.vts.dms.dak.model.DakNotification;
import com.vts.dms.dak.model.DakReplyAttach;
import com.vts.dms.dto.MailConfigurationDto;
import com.vts.dms.enote.dao.Enotedao;
import com.vts.dms.enote.dto.DakLetterDocDto;
import com.vts.dms.enote.dto.EnoteAttachDto;
import com.vts.dms.enote.dto.EnoteDto;
import com.vts.dms.enote.dto.EnoteRosoDto;
import com.vts.dms.enote.dto.EnoteflowDto;
import com.vts.dms.enote.model.DakEnoteReply;
import com.vts.dms.enote.model.Enote;
import com.vts.dms.enote.model.EnoteAttachment;
import com.vts.dms.enote.model.EnoteFlow;
import com.vts.dms.enote.model.EnoteRosoModel;
import com.vts.dms.enote.model.EnoteTransaction;
import com.vts.dms.service.DmsServiceImp;
import com.vts.dms.enote.model.DakLetterDoc;

@Service
public class EnoteServiceImpl implements EnoteService{

	private static final Logger logger=LogManager.getLogger(EnoteServiceImpl.class);
	    private  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		private  SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
		private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	    DateTimeFormatUtil dtf=new DateTimeFormatUtil();
	    
	@Autowired
	Enotedao dao;
	
	@Autowired
	DakDao dakdao;
	
	@Autowired
	CustomSMSProxySender smsproxy;
	
	@Autowired
	CustomJavaMailSender mailproxy;
	
	 @Autowired
	 DmsServiceImp dmsser;
	
	  @Autowired
	  private Environment env;
	
	  
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
	public long InsertEnote(EnoteDto dto,String LabCode) throws Exception {
		 Enote enote=dto.getEnote();
		
		 SimpleDateFormat RequiredFormat = new SimpleDateFormat("ddMMMyy");
		 String DayMonYear = RequiredFormat.format(new Date()); //currentDate
		 String enoteStr = "E"+DayMonYear+"_";
		 String letterStr = "L"+DayMonYear+"_";
		 long count;
		 int width = 3;
		 
		 long EnoteIdCount=dao.EnoteCountForGeneration();
		 
		 if(EnoteIdCount>0) {
			 count = EnoteIdCount+1;
		 }else {
			 count = 1;
		 }
		 
		 String formattedCount = String.format("%0" + width + "d", count);
		 String NewEnoteNO=enoteStr+formattedCount;
		 String NewLetterNo= LabCode+"_"+enote.getDivisionCode().toString()+"_"+letterStr+formattedCount;
		 
		 enote.setNoteId(NewEnoteNO);
		 if(enote.getIsDraft()!=null && enote.getIsDraft().equalsIgnoreCase("Y")) {
		 enote.setLetterNo(NewLetterNo);
		 }
		 
		 long EnoteId=dao.insertEnote(enote);
		 if(EnoteId>0) {
			 if(dto!=null && dto.getDakEnoteDocument()!=null && dto.getDakEnoteDocument().length>0 && !dto.getDakEnoteDocument()[0].isEmpty()) {
		        	for(MultipartFile file : dto.getDakEnoteDocument()) {
		        		if(!file.isEmpty()) {
		        		EnoteAttachDto enotedto=new EnoteAttachDto();
		        		enotedto.setEnoteId(EnoteId);
		        		enotedto.setFilePath(env.getProperty("file_upload_path"));
		        		enotedto.setCreatedBy(enote.getCreatedBy());
		        		enotedto.setCreatedDate(enote.getCreatedDate());
		        		enotedto.setNoteId(enote.getNoteId());
		        		
		        		String DynamicPath = enote.getNoteId().replace("/", "_");
		        		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "eNote",DynamicPath);
		        		int count1 = dao.GetAttachmentDetails(enotedto.getEnoteId()).size()+1;
		        		
		        		File theDir = fullpath.toFile();
		        		if (!theDir.exists()){
		        		    theDir.mkdirs();
		        		}
		        		
		        		EnoteAttachment model=new EnoteAttachment();
		        		model.setEnoteId(enotedto.getEnoteId());
		        		model.setFilePath(DynamicPath);
		        		model.setFileName("E"+String.valueOf(count1+"-"+file.getOriginalFilename()));
		        		model.setCreatedBy(enotedto.getCreatedBy());
		        		model.setCreatedDate(enotedto.getCreatedDate());
		        		
		        		saveFile1(fullpath,"E"+String.valueOf(count1)+"-"+file.getOriginalFilename(),file);
		        		long result=dao.EnoteAttachmentFile(model);
		        		}
		        		}
		 }
		 
			// Transaction
				EnoteTransaction transaction = EnoteTransaction.builder()
											   .EnoteId(EnoteId)
											   .EnoteStatusCode("INI")
											   .ActionBy(enote.getInitiatedBy())
											   .ActionDate(sdf1.format(new Date()))
											   .build();
				dao.addEnoteTransaction(transaction);
				
				
				if(enote.getIsDraft()!=null && enote.getIsDraft().equalsIgnoreCase("Y")) {
				Object[] WordDocumentData=dao.WordDocumentData(EnoteId);
			 	XWPFDocument document = new XWPFDocument();
		        
//			 	if(WordDocumentData!=null && WordDocumentData[4]!=null && WordDocumentData[4].toString().equalsIgnoreCase("Y")) {
//			 		 // Create header
//			        XWPFHeader header = document.createHeader(HeaderFooterType.DEFAULT);
//
//			        // Create table for header content with 1 row and 3 columns
//			        XWPFTable table = header.createTable(1, 3);
//			        table.setWidth("100%");
//			        
//			        table.getCTTbl().getTblPr().unsetTblBorders();
//			        // Create a row (already created by createTable)
//			        XWPFTableRow row = table.getRow(0);
//			        
//			        // Create a cell for Hindi text
//			        XWPFTableCell cell1 = row.getCell(0);
//			        XWPFParagraph para1 = cell1.getParagraphs().get(0);
//			        para1.setAlignment(ParagraphAlignment.LEFT);
//			        XWPFRun run1 = para1.createRun();
//			        run1.setFontFamily("Arial Unicode MS");
//			        run1.setText("इलेक्ट्रॉनिक्स तथा रेडार विकास स्थापना");
//			        run1.addBreak();
//			        run1.setText("भारत सरकार - रक्षा मंत्रालय ");
//			        run1.addBreak();
//			        run1.setText("रक्षा अनुसंधान तथा विकास संगठन");
//			        run1.addBreak();
//			        run1.setText("पो.बा.स. , सी. वी. रामन नगर");
//			        run1.addBreak();
//			        run1.setText("बेंगलूर - , भारत");
//			        run1.addBreak();
//			        run1.setText("फैक्स : 080-2524 2916");
//			        run1.addBreak();
//			        run1.setText("फ़ोन :  080-2524 3873");
//			         // Use a more common font
//			        run1.setFontSize(12);
//
//			        // Create a cell for the image
//			        XWPFTableCell cell2 = row.getCell(1);
//			        XWPFParagraph para2 = cell2.getParagraphs().get(0);
//			        para2.setAlignment(ParagraphAlignment.LEFT);  // Center the image
//			        XWPFRun imageRun = para2.createRun();
//			        Path imgfile=Paths.get(env.getProperty("file_upload_path"), "Letter","drdo.png");
//			        try (InputStream imgStream = new FileInputStream(imgfile.toFile())) {
//			            imageRun.addPicture(imgStream, XWPFDocument.PICTURE_TYPE_PNG, "drdo.png", Units.toEMU(70), Units.toEMU(70)); // Adjust width and height as needed
//			        } catch (IOException e) {
//			            e.printStackTrace();
//			        }
//
//			        // Create a cell for English text
//			        XWPFTableCell cell3 = row.getCell(2);
//			        XWPFParagraph para3 = cell3.getParagraphs().get(0);
//			        para3.setAlignment(ParagraphAlignment.LEFT);
//			        XWPFRun run3 = para3.createRun();
//			        run3.setText("Electronics & Radar Development Establishment");
//			        run3.addBreak();
//			        run3.setText("Govt of India, Ministry of Defence");
//			        run3.addBreak();
//			        run3.setText("Defence Research & Development Organisation");
//			        run3.addBreak();
//			        run3.setText("P.B. No: 9324, C V Raman Nagar");
//			        run3.addBreak();
//			        run3.setText("Bengaluru - 560 093. India");
//			        run3.addBreak();
//			        run3.setText("Fax : 080-2524 2916");
//			        run3.addBreak();
//			        run3.setText("Phone : 080-2524 3873");
//			        run3.addBreak();
//			        run3.setText("E-Mail :  director.lrde@gov.in");
//
//			        // Adjust cell widths if needed
//			        cell1.setWidth("40%");
//			        cell2.setWidth("10%");
//			        cell3.setWidth("50%");
//			        run3.addBreak();
//			        run3.addBreak();
//
//			 	}
			 	
			 	if (WordDocumentData != null && WordDocumentData[4] != null && WordDocumentData[4].toString().equalsIgnoreCase("Y")) {
			 	    // Create header
			 	    XWPFHeader header = document.createHeader(HeaderFooterType.DEFAULT);

			 	    // Create a paragraph in the header (it will be used to insert the image)
			 	    XWPFParagraph paragraph = header.createParagraph();
			 	    paragraph.setAlignment(ParagraphAlignment.LEFT); // Align left to start with
			 	    paragraph.setIndentationLeft(50); // Adjust the left indentation as needed (50 EMUs is just an example)

			 	    // Add image to the paragraph (as the header content)
			 	    XWPFRun imageRun = paragraph.createRun();
			 	    Path imgFile = Paths.get(env.getProperty("file_upload_path"), "Letter", "LetterHead.png");

			 	    try (InputStream imgStream = new FileInputStream(imgFile.toFile())) {
			 	        // Add the image to the header (adjust size as needed)
			 	        imageRun.addPicture(imgStream, XWPFDocument.PICTURE_TYPE_PNG, "LetterHead.png", Units.toEMU(500), Units.toEMU(150)); // Adjust width and height
			 	    } catch (IOException e) {
			 	        e.printStackTrace();
			 	    }
			 	}


	            
	            
		        XWPFParagraph RefheaderParagraph = document.createParagraph();
		        RefheaderParagraph.setAlignment(ParagraphAlignment.LEFT);
		        XWPFRun headerRun = RefheaderParagraph.createRun();
		        headerRun.setText("Ref No: "+WordDocumentData[0].toString());
		        headerRun.setText("\t\t\t\t\t\t\t               ");
		        headerRun.setText("Date: "+sdf.format(WordDocumentData[1]));
		        headerRun.addBreak();

		        XWPFParagraph toAddressParagraph = document.createParagraph();
		        toAddressParagraph.setAlignment(ParagraphAlignment.LEFT);
		        XWPFRun toAddressRun = toAddressParagraph.createRun();
		        toAddressRun.setText("To, ");
		        toAddressRun.addBreak();
		        toAddressRun.setText(WordDocumentData[6].toString()+",");
		        toAddressRun.addBreak();
		        toAddressRun.setText(WordDocumentData[7].toString()+",");
		        toAddressRun.addBreak();
		        toAddressRun.setText(WordDocumentData[8].toString()+"-"+WordDocumentData[9].toString());
		        
		     // Create a new paragraph for the subject
		        XWPFParagraph subjectParagraph = document.createParagraph();
		        
		        subjectParagraph.setAlignment(ParagraphAlignment.LEFT);

		        // Create the first run for the "Subject :" part and make it bold
		        XWPFRun subjectRunBold = subjectParagraph.createRun();
		        subjectRunBold.setBold(true);
		        subjectRunBold.setText("Subject : ");

		        // Create the second run for the dynamic part and keep it normal
		        XWPFRun subjectRunNormal = subjectParagraph.createRun();
		        subjectRunNormal.setText(WordDocumentData[2].toString());
		        subjectRunNormal.addBreak();

		        
		        XWPFParagraph ContentParagraph = document.createParagraph();
		        ContentParagraph.setAlignment(ParagraphAlignment.LEFT);
		        XWPFRun ContentRun = ContentParagraph.createRun();
		        ContentRun.setText("Dear Sir/Madam,");
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.setText(WordDocumentData[3].toString());
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.addBreak();

		        XWPFParagraph signatoryParagraph = document.createParagraph();
		        signatoryParagraph.setAlignment(ParagraphAlignment.RIGHT);
		        XWPFRun signatoryRun = signatoryParagraph.createRun();
		        signatoryRun.setText(WordDocumentData[5].toString());

		        try {
		        	Path basefolder=Paths.get(env.getProperty("file_upload_path"), "Letter",NewLetterNo+"_"+"Documents");
		        	File baseDir = basefolder.toFile();
		        	if (!baseDir.exists()) {
		        	    baseDir.mkdirs(); 
		        	}
		        	int count1 = dao.GetLetterDocDetails(EnoteId).size() + 1;
		        	String fileName = "L" + count1 + "-" + NewLetterNo + ".docx";
		        	String filePath = basefolder + File.separator + fileName;
		        	FileOutputStream out = new FileOutputStream(filePath);
		        	
		        	document.write(out);
		        	out.close();
		        	
		        	String DynamicPath1 = enote.getLetterNo().replace("/", "_");
		        	DakLetterDoc doc=new DakLetterDoc();
		        	doc.setEnoteId(EnoteId);
		        	doc.setFilePath(DynamicPath1);
		        	doc.setFileName(fileName);
		        	doc.setCreatedBy(enote.getCreatedBy());
		        	doc.setCreatedDate(enote.getCreatedDate());
	        		dao.DakLetterDocFile(doc);
		            System.out.println("Word document created successfully.");
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
				}
		 }
		return EnoteId;
	}
	
	@Override
	public Object[] EnotePreview(long result) throws Exception {
		return dao.EnotePreview(result);
	}
	
	@Override
	public Object getlabcode(long empId) throws Exception {
		return dao.getlabcode(empId);
	}
	
	@Override
	public List<Object[]> InitiatedByEmployeeList(long divid, String lab) throws Exception {
		return dao.InitiatedByEmployeeList(divid,lab);
	}
	
	
	@Override
	public List<Object[]> RecommendingOfficerList(String lab) throws Exception {
		return dao.RecommendingOfficerList(lab);
	}
	
	@Override
	public long ForwardtoRecommendOfficers(EnoteflowDto dto, String[] employeeIds) throws Exception {
		
		long result=0;
		if(dto!=null ) {
			for(int i=0;i<employeeIds.length;i++) {
				 String[] EmpIds = employeeIds[i].split(",");
	       		 
				String empId = EmpIds[0];
	       		String RecommendNo = EmpIds[1];
				EnoteFlow enoteflow=new EnoteFlow();
				enoteflow.setEnoteId(dto.getEnoteId());
				enoteflow.setRecommendNo(RecommendNo);
				enoteflow.setEmpId(Long.parseLong(empId));
				enoteflow.setCreatedBy(dto.getCreatedBy());
				enoteflow.setCreatedDate(dto.getCreatedDate());
				
				result=dao.InsertForwardRecommendOfficers(enoteflow);
			}
		}
		return result;
	}
	
	@Override
	public List<Object[]> EnoteList(String fromDate, String toDate,String Username,long EmpId) throws Exception {
		return dao.EnoteList(fromDate,toDate,Username,EmpId);
	}
	
	@Override
	public long UpdateEnoteStatus(String eNoteId) throws Exception {
		return dao.UpdateEnoteStatus(eNoteId);
	}
	
	@Override
	public long forwardeNote(EnoteDto dto, long EmpId,String Action,String remarks,String RedirectName) throws Exception {
		try {
			Long enoteId = dto.getEnoteId();
			Enote enote = dao.getEnoteById(enoteId);
			String EnoteStatusCode = enote.getEnoteStatusCode();
			String EnoteStatusCodeNext = enote.getEnoteStatusCodeNext();
			String Role=null;
			List<String> forwardstatus = Arrays.asList("INI","RR1","RR2","RR3","RR4","RR5","RAP","REV");
			List<String> reforwardstatus = Arrays.asList("RR1","RR2","RR3","RR4","RR5","RAP");
			long EmpNumber=0;
			String approveDate=null;
			if(dto.getApprovalExternalOfficer()!=null && dto.getApprovalExternalOfficer().equalsIgnoreCase("")) {
				EmpNumber=Long.parseLong(dto.getApprovalExternalOfficer());
			}
			
			if(dto.getApprovalDate()!=null && dto.getApprovalDate().equalsIgnoreCase("")) {
				approveDate=sdf1.format(dto.getApprovalDate().toString());
			}
			// Forward flow
			if(Action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(EnoteStatusCode)) {

					if(EnoteStatusCode.equalsIgnoreCase("INI") || EnoteStatusCode.equalsIgnoreCase("REV") ) {
						enote.setRecommend1(dto.getRecommend1());
						enote.setRecommend2(dto.getRecommend2());
						enote.setRecommend3(dto.getRecommend3());
						enote.setApprovingOfficer(dto.getApprovingOfficer());
						enote.setExternalOfficer(dto.getExternalOfficer());

						if(dto.getRec1_Role()!=null && !dto.getRec1_Role().equalsIgnoreCase("")) {
							enote.setRec1_Role(dto.getRec1_Role());
						}
						if(dto.getRec2_Role()!=null && !dto.getRec2_Role().equalsIgnoreCase("")) {
							enote.setRec2_Role(dto.getRec2_Role());
						}
						if(dto.getRec3_Role()!=null && !dto.getRec3_Role().equalsIgnoreCase("")) {
							enote.setRec3_Role(dto.getRec3_Role());
						}
						if(dto.getExternal_Role()!=null && !dto.getExternal_Role().equalsIgnoreCase("")) {
							enote.setExternal_Role(dto.getExternal_Role());
						}
						if(dto.getApproving_Role()!=null && !dto.getApproving_Role().equalsIgnoreCase("")) {
							enote.setApproving_Role(dto.getApproving_Role());
						}
						if(dto.getLabCode()!=null && !dto.getLabCode().equalsIgnoreCase("")) {
							enote.setLabCode(dto.getLabCode());
						}
						
						if(dto.getActionsave()==null) {
							enote.setEnoteStatusCode("FWD");
							if(enote.getRecommend1()!=null) {
								enote.setEnoteStatusCodeNext("RC1");
							}
						}
					}
					
					if(reforwardstatus.contains(EnoteStatusCode)) {
						enote.setEnoteStatusCode("RFD");
						if(enote.getRecommend1()!=null) {
							enote.setEnoteStatusCodeNext("RC1");
						}
					}
				}
				else {
					enote.setEnoteStatusCode(EnoteStatusCodeNext);
					if(EnoteStatusCodeNext.equalsIgnoreCase("RC1")) {
						if(enote.getRecommend2()!=null) {
							enote.setEnoteStatusCodeNext("RC2");
						}else if(enote.getRecommend3()!=null) {
							enote.setEnoteStatusCodeNext("RC3");
						}else if(enote.getRecommend4()!=null) {
							enote.setEnoteStatusCodeNext("RC4");
						}else if(enote.getRecommend5()!=null) {
							enote.setEnoteStatusCodeNext("RC5");
						}else if(enote.getExternalOfficer()!=null) {
							enote.setEnoteStatusCodeNext("EXT");
						}else {
							enote.setEnoteStatusCodeNext("APR");
						}

					}
					else if(EnoteStatusCodeNext.equalsIgnoreCase("RC2")) {
						if(enote.getRecommend3()!=null) {
							enote.setEnoteStatusCodeNext("RC3");
						}else if(enote.getRecommend4()!=null) {
							enote.setEnoteStatusCodeNext("RC4");
						}else if(enote.getRecommend5()!=null) {
							enote.setEnoteStatusCodeNext("RC5");
						}else if(enote.getExternalOfficer()!=null) {
							enote.setEnoteStatusCodeNext("EXT");
						}else {
							enote.setEnoteStatusCodeNext("APR");
						}

					}
					else if(EnoteStatusCodeNext.equalsIgnoreCase("RC3")) {
						if(enote.getRecommend4()!=null) {
							enote.setEnoteStatusCodeNext("RC4");
						}else if(enote.getRecommend5()!=null) {
							enote.setEnoteStatusCodeNext("RC5");
						}else if(enote.getExternalOfficer()!=null) {
							enote.setEnoteStatusCodeNext("EXT");
						}else {
							enote.setEnoteStatusCodeNext("APR");
						}

					}
					else if(EnoteStatusCodeNext.equalsIgnoreCase("RC4")) {
						if(enote.getRecommend5()!=null) {
							enote.setEnoteStatusCodeNext("RC5");
						}else if(enote.getExternalOfficer()!=null) {
							enote.setEnoteStatusCodeNext("EXT");
						}else {
							enote.setEnoteStatusCodeNext("APR");
						}

					}
					else if(EnoteStatusCodeNext.equalsIgnoreCase("RC5")) {
						if(enote.getExternalOfficer()!=null) {
							enote.setEnoteStatusCodeNext("EXT");
						}else {
							enote.setEnoteStatusCodeNext("APR");
						}
						
					}else if(EnoteStatusCodeNext.equalsIgnoreCase("EXT")  ) {
						enote.setEnoteStatusCodeNext("APR");
					}else if(EnoteStatusCodeNext.equalsIgnoreCase("APR") ) {
						enote.setEnoteStatusCodeNext("APR");
					}
					
					if(enote.getEnoteStatusCode().equalsIgnoreCase("RC1") || enote.getEnoteStatusCode().equalsIgnoreCase("RR1")) {
						 Role=enote.getRec1_Role().toString();
					 }
					 else if(enote.getEnoteStatusCode().equalsIgnoreCase("RC2") || enote.getEnoteStatusCode().equalsIgnoreCase("RR2")) {
						 Role=enote.getRec2_Role().toString();
					 }
					 else if(enote.getEnoteStatusCode().equalsIgnoreCase("RC3") || enote.getEnoteStatusCode().equalsIgnoreCase("RR3")) {
						 Role=enote.getRec3_Role().toString();
					 }
					 else if(enote.getEnoteStatusCode().equalsIgnoreCase("RC4") || enote.getEnoteStatusCode().equalsIgnoreCase("RR4")) {
						 Role=enote.getRec4_Role().toString();
					 }
					 else if(enote.getEnoteStatusCode().equalsIgnoreCase("RC5") || enote.getEnoteStatusCode().equalsIgnoreCase("RR5")) {
						 Role=enote.getRec5_Role().toString();
					 }
					 else if(enote.getEnoteStatusCode().equalsIgnoreCase("EXT") || enote.getEnoteStatusCode().equalsIgnoreCase("ERT")) {
						 Role=enote.getExternal_Role().toString();
					 }
					 else if(enote.getEnoteStatusCode().equalsIgnoreCase("APR") || enote.getEnoteStatusCode().equalsIgnoreCase("RAP")) {
						 Role=enote.getApproving_Role().toString();
					 }

				}
				dao.updateEnote(enote);
				if(enote.getEnoteStatusCode()!=null && !enote.getEnoteStatusCode().toString().equalsIgnoreCase("APR") && enote.getEnoteStatusCodeNext()!=null && enote.getEnoteStatusCodeNext().toString().equalsIgnoreCase("APR")) {
				Object[] EnotePendingApprovalList=dao.EnotePendingApprovalList(Long.parseLong(enote.getApprovingOfficer().toString()),enoteId);
				
				
	    		if(EnotePendingApprovalList[2]!=null && !EnotePendingApprovalList[2].toString().equalsIgnoreCase("0") && EnotePendingApprovalList[2].toString().trim().length()>0 && EnotePendingApprovalList[2].toString().trim().length()==10) {
	    			String message="eNote" + EnotePendingApprovalList[0].toString() + " is pending for Approval for the day "+sdf.format(new Date());
	    			smsproxy.proxyRequest(message,EnotePendingApprovalList[2].toString());
	    		}
	    		  String Mailmessage = "<p>Dear Sir/Madam,<br><br> </p>";
			    		 Mailmessage += "<p>eNote " + EnotePendingApprovalList[0].toString() + " is pending for Approval for the day " + sdf.format(new Date()) + " . </p>";
			    		 Mailmessage += "Important Note: This is an automated message. Kindly avoid responding. ";
			    		 Mailmessage += "<p></p>";
			    		 Mailmessage += "Regards,<br>LRDE-DMS Team";
	    		System.out.println("Mailmessage:"+Mailmessage);
	    		if(EnotePendingApprovalList[3]!=null && !EnotePendingApprovalList[3].toString().trim().isEmpty()) {
	    			mailproxy.sendScheduledEmailAsync1(EnotePendingApprovalList[3].toString(),"eNote Pending Approval", Mailmessage,true);
	    		}
	    		if(EnotePendingApprovalList[4]!=null && !EnotePendingApprovalList[4].toString().trim().isEmpty()) {
	    			mailproxy.sendScheduledEmailAsync2(EnotePendingApprovalList[4].toString(), "eNote Pending Approval", Mailmessage,true);
	    		}
				}
			}
			// Return flow
			else if(Action.equalsIgnoreCase("R")){
				
				// seting setEnoteStatusCode
				if(EnoteStatusCodeNext.equalsIgnoreCase("RC1")) 
				{
					enote.setEnoteStatusCode("RR1");	
				}
				else if(EnoteStatusCodeNext.equalsIgnoreCase("RC2")) 
				{
					enote.setEnoteStatusCode("RR2");	
				}
				else if(EnoteStatusCodeNext.equalsIgnoreCase("RC3")) 
				{
					enote.setEnoteStatusCode("RR3");	
				}
				else if(EnoteStatusCodeNext.equalsIgnoreCase("APR")) 
				{
					enote.setEnoteStatusCode("RAP");	
				}
				
				// Setting EnoteStatusCodeNext
				if(enote.getEnoteStatusCode().equalsIgnoreCase("RC1") || enote.getEnoteStatusCode().equalsIgnoreCase("RR1")) {
					 Role=enote.getRec1_Role().toString();
				 }
				 else if(enote.getEnoteStatusCode().equalsIgnoreCase("RC2") || enote.getEnoteStatusCode().equalsIgnoreCase("RR2")) {
					 Role=enote.getRec2_Role().toString();
				 }
				 else if(enote.getEnoteStatusCode().equalsIgnoreCase("RC3") || enote.getEnoteStatusCode().equalsIgnoreCase("RR3")) {
					 Role=enote.getRec3_Role().toString();
				 }
				 else if(enote.getEnoteStatusCode().equalsIgnoreCase("RC4") || enote.getEnoteStatusCode().equalsIgnoreCase("RR4")) {
					 Role=enote.getRec4_Role().toString();
				 }
				 else if(enote.getEnoteStatusCode().equalsIgnoreCase("RC5") || enote.getEnoteStatusCode().equalsIgnoreCase("RR5")) {
					 Role=enote.getRec5_Role().toString();
				 }
				 else if(enote.getEnoteStatusCode().equalsIgnoreCase("EXT") || enote.getEnoteStatusCode().equalsIgnoreCase("ERT")) {
					 Role=enote.getExternal_Role().toString();
				 }
				 else if(enote.getEnoteStatusCode().equalsIgnoreCase("APR") || enote.getEnoteStatusCode().equalsIgnoreCase("RAP")) {
					 Role=enote.getApproving_Role().toString();
				 }
				
				dao.updateEnote(enote);	
			}
			// Transaction
			if(dto.getActionsave()==null) {
			EnoteTransaction transaction = EnoteTransaction.builder()
										   .EnoteId(enoteId)
										   .EnoteStatusCode(enote.getEnoteStatusCode())
										   .Remarks(remarks)
										   .Role(!(RedirectName!=null && RedirectName.equalsIgnoreCase("SkipPreview"))? Role : "")
										   .ActionBy(EmpNumber>0 ? EmpNumber:EmpId)
										   .ActionDate(approveDate!=null ? approveDate : sdf1.format(new Date()))
										   .build();
			dao.addEnoteTransaction(transaction);
			}
			
			// Notifications
			Object[] UserName= null;
			UserName=dakdao.getUsername(EmpId);
			DakNotification notification = new DakNotification();
			
			//After final approval sendig notification to user
			if(Action!=null && Action.equalsIgnoreCase("A") && enote.getEnoteStatusCode().equalsIgnoreCase("APR")) {
				notification.setNotificationBy(EmpId);
				notification.setIsActive(1);
				notification.setCreatedBy(enote.getCreatedBy());
				notification.setCreatedDate(enote.getCreatedDate());
				notification.setNotificationMessage("Enote Approved by "+UserName[0].toString()+","+UserName[1].toString()+".");
				notification.setNotificationDate(sdf2.format(new Date()));
				notification.setEmpId(enote.getInitiatedBy());
				if(enote.getEnoteStatusCode().equalsIgnoreCase("APR")) {
				notification.setNotificationUrl("ENoteList.htm");
				}
				if(enote.getEnoteStatusCode().equalsIgnoreCase("EXT")) {
					notification.setNotificationUrl("DakEnoteExternalList.htm");
				}
				
				dakdao.DakNotificationInsert(notification);
				
			}else if(Action!=null && Action.equalsIgnoreCase("A")) {
				String nextcode = enote.getEnoteStatusCodeNext();
				if(nextcode.equalsIgnoreCase("RC1")) {
					notification.setEmpId(enote.getRecommend1());
					notification.setNotificationMessage("Enote Forwarded by "+UserName[0].toString()+","+UserName[1].toString()+".");
					notification.setNotificationUrl("EnoteApprovalList.htm");
				}else if(nextcode.equalsIgnoreCase("RC2")) {
					notification.setEmpId(enote.getRecommend2());
					notification.setNotificationMessage("Enote Recommended by "+UserName[0].toString()+","+UserName[1].toString()+".");
					notification.setNotificationUrl("EnoteApprovalList.htm");
				}else if(nextcode.equalsIgnoreCase("RC3")) {
					notification.setEmpId(enote.getRecommend3());
					notification.setNotificationMessage("Enote Recommended by "+UserName[0].toString()+","+UserName[1].toString()+".");
					notification.setNotificationUrl("EnoteApprovalList.htm");
				}else if(nextcode.equalsIgnoreCase("RC4")) {
					notification.setEmpId(enote.getRecommend4());
					notification.setNotificationMessage("Enote Recommended by "+UserName[0].toString()+","+UserName[1].toString()+".");
					notification.setNotificationUrl("EnoteApprovalList.htm");
				}else if(nextcode.equalsIgnoreCase("RC5")) {
					notification.setEmpId(enote.getRecommend5());
					notification.setNotificationMessage("Enote Recommended by "+UserName[0].toString()+","+UserName[1].toString()+".");
					notification.setNotificationUrl("EnoteApprovalList.htm");
				}else if(nextcode.equalsIgnoreCase("EXT")) {
					notification.setEmpId(enote.getInitiatedBy());
					notification.setNotificationMessage("Enote Recommended by "+UserName[0].toString()+","+UserName[1].toString()+".");
					notification.setNotificationUrl("DakEnoteExternalList.htm");
				}else if(nextcode.equalsIgnoreCase("APR")) {
					notification.setEmpId(enote.getApprovingOfficer());
					notification.setNotificationMessage("Enote Recommended by "+UserName[0].toString()+","+UserName[1].toString()+".");
					notification.setNotificationUrl("EnoteApprovalList.htm");
				}
				
				notification.setNotificationBy(EmpId);
				notification.setIsActive(1);
				notification.setCreatedBy(enote.getCreatedBy());
				notification.setCreatedDate(enote.getCreatedDate());
				notification.setNotificationDate(sdf2.format(new Date()));
				
				dakdao.DakNotificationInsert(notification);
				
			}else if(Action!=null && Action.equalsIgnoreCase("R")) {
				notification.setNotificationBy(EmpId);
				notification.setIsActive(1);
				notification.setCreatedBy(enote.getCreatedBy());
				notification.setCreatedDate(enote.getCreatedDate());
				notification.setNotificationMessage("Enote Returned by "+UserName[0].toString()+","+UserName[1].toString()+".");
				notification.setNotificationDate(sdf2.format(new Date()));
				notification.setEmpId(enote.getInitiatedBy());
				notification.setNotificationUrl("ENoteList.htm");
				
				dakdao.DakNotificationInsert(notification);
				
			}
			
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	@Override
	public Enote EnoteEditData(long EnoteId) throws Exception {
		return dao.getEnoteById(EnoteId);
	}
	
	@Override
	public long AttachmentCount(long EnoteId) throws Exception {
		return dao.AttachmentCount(EnoteId);
	}
	
	@Override
	public List<Object[]> GetAttachmentDetails(long EnoteId) throws Exception {
		return dao.GetAttachmentDetails(EnoteId);
	}
	
	@Override
	public Object[] EnoteAttachmentData(String eNoteAttachId) throws Exception {
		return dao.EnoteAttachmentData(eNoteAttachId);
	}
	
	@Override
	public List<Object[]> EnoteAttachmentData(long EnoteAttachId, long enoteId) throws Exception {
		return dao.EnoteAttachmentData(EnoteAttachId,enoteId);
	}
	
	@Override
	public int DeleteEnoteAttachment(String enoteAttachId) throws Exception {
		return dao.DeleteEnoteAttachment(enoteAttachId);
	}
	
	@Override
	public long UpdateEnote(EnoteDto dto) throws Exception {
		try {
			Long enoteId = dto.getEnoteId();
			Enote enote = dao.getEnoteById(enoteId);
			
			enote.setNoteNo(dto.getNoteNo());
			enote.setRefNo(dto.getRefNo());
			enote.setRefDate(dto.getRefDate());
			enote.setSubject(dto.getSubject());
			enote.setComment(dto.getComment());
			enote.setInitiatedBy(dto.getInitiatedBy());
			enote.setEnoteType(dto.getEnoteType());
			enote.setIsDak(dto.getIsDak());
			enote.setIsDraft(dto.getIsDraft());
			if(dto!=null && dto.getIsDraft()!=null && dto.getIsDraft().equalsIgnoreCase("Y")) {
			enote.setLetterDate(dto.getLetterDate());
			enote.setDestinationId(dto.getDestinationId());
			enote.setDestinationTypeId(dto.getDestinationTypeId());
			enote.setDraftContent(dto.getDraftContent());
			enote.setSignatory(dto.getSignatory());
			enote.setLetterHead(dto.getLetterHead());
			}
			enote.setModifiedBy(dto.getModifiedBy());
			enote.setModifiedDate(dto.getModifiedDate());
			

			long count= dao.updateEnote(enote);
			if(count>0) {
				if(dto!=null && dto.getDakEnoteDocument()!=null && dto.getDakEnoteDocument().length>0 && !dto.getDakEnoteDocument()[0].isEmpty()) {
		        	for(MultipartFile file : dto.getDakEnoteDocument()) {
		        		if(!file.isEmpty()) {
		        		EnoteAttachDto enotedto=new EnoteAttachDto();
		        		enotedto.setEnoteId(enoteId);
		        		enotedto.setFilePath(env.getProperty("file_upload_path"));
		        		enotedto.setCreatedBy(enote.getCreatedBy());
		        		enotedto.setCreatedDate(enote.getCreatedDate());
		        		enotedto.setNoteId(enote.getNoteId());
		        		
		        		String DynamicPath = enote.getNoteId().replace("/", "_");
		        		Path fullpath=Paths.get(env.getProperty("file_upload_path"), "eNote",DynamicPath);
		        		int count1 = dao.GetAttachmentDetails(enotedto.getEnoteId()).size()+1;
		        		
		        		File theDir = fullpath.toFile();
		        		if (!theDir.exists()){
		        		    theDir.mkdirs();
		        		}
		        		
		        		EnoteAttachment model=new EnoteAttachment();
		        		model.setEnoteId(enotedto.getEnoteId());
		        		model.setFilePath(DynamicPath);
		        		model.setFileName("E"+String.valueOf(count1+"-"+file.getOriginalFilename()));
		        		model.setCreatedBy(enotedto.getCreatedBy());
		        		model.setCreatedDate(enotedto.getCreatedDate());
		        		
		        		saveFile1(fullpath,"E"+String.valueOf(count1)+"-"+file.getOriginalFilename(),file);
		        		long result=dao.EnoteAttachmentFile(model);
		        		}
		        		}
		 }
			}
			if(dto!=null && dto.getIsDraft()!=null && dto.getIsDraft().equalsIgnoreCase("Y")) {
			Object[] WordDocumentData=dao.WordDocumentData(enoteId);
		 	XWPFDocument document = new XWPFDocument();
	        
//		 	if(WordDocumentData!=null && WordDocumentData[4]!=null && WordDocumentData[4].toString().equalsIgnoreCase("Y")) {
//		 		 // Create header
//		        XWPFHeader header = document.createHeader(HeaderFooterType.DEFAULT);
//
//		        // Create table for header content with 1 row and 3 columns
//		        XWPFTable table = header.createTable(1, 3);
//		        table.setWidth("100%");
//		        
//		        table.getCTTbl().getTblPr().unsetTblBorders();
//		        // Create a row (already created by createTable)
//		        XWPFTableRow row = table.getRow(0);
//		        
//		        // Create a cell for Hindi text
//		        XWPFTableCell cell1 = row.getCell(0);
//		        XWPFParagraph para1 = cell1.getParagraphs().get(0);
//		        para1.setAlignment(ParagraphAlignment.LEFT);
//		        XWPFRun run1 = para1.createRun();
//		        run1.setFontFamily("Arial Unicode MS");
//		        run1.setText("इलेक्ट्रॉनिक्स तथा रेडार विकास स्थापना");
//		        run1.addBreak();
//		        run1.setText("भारत सरकार - रक्षा मंत्रालय ");
//		        run1.addBreak();
//		        run1.setText("रक्षा अनुसंधान तथा विकास संगठन");
//		        run1.addBreak();
//		        run1.setText("पो.बा.स. , सी. वी. रामन नगर");
//		        run1.addBreak();
//		        run1.setText("बेंगलूर - , भारत");
//		        run1.addBreak();
//		        run1.setText("फैक्स : 080-2524 2916");
//		        run1.addBreak();
//		        run1.setText("फ़ोन :  080-2524 3873");
//		         // Use a more common font
//		        run1.setFontSize(12);
//
//		        // Create a cell for the image
//		        XWPFTableCell cell2 = row.getCell(1);
//		        XWPFParagraph para2 = cell2.getParagraphs().get(0);
//		        para2.setAlignment(ParagraphAlignment.LEFT);  // Center the image
//		        XWPFRun imageRun = para2.createRun();
//		    	Path imgfile=Paths.get(env.getProperty("file_upload_path"), "Letter","drdo.png");
//		        try (InputStream imgStream = new FileInputStream(imgfile.toFile())) {
//		            imageRun.addPicture(imgStream, XWPFDocument.PICTURE_TYPE_PNG, "drdo.png", Units.toEMU(70), Units.toEMU(70)); // Adjust width and height as needed
//		        } catch (IOException e) {
//		            e.printStackTrace();
//		        }
//
//		        // Create a cell for English text
//		        XWPFTableCell cell3 = row.getCell(2);
//		        XWPFParagraph para3 = cell3.getParagraphs().get(0);
//		        para3.setAlignment(ParagraphAlignment.LEFT);
//		        XWPFRun run3 = para3.createRun();
//		        run3.setText("Electronics & Radar Development Establishment");
//		        run3.addBreak();
//		        run3.setText("Govt of India, Ministry of Defence");
//		        run3.addBreak();
//		        run3.setText("Defence Research & Development Organisation");
//		        run3.addBreak();
//		        run3.setText("P.B. No: 9324, C V Raman Nagar");
//		        run3.addBreak();
//		        run3.setText("Bengaluru - 560 093. India");
//		        run3.addBreak();
//		        run3.setText("Fax : 080-2524 2916");
//		        run3.addBreak();
//		        run3.setText("Phone : 080-2524 3873");
//		        run3.addBreak();
//		        run3.setText("E-Mail :  director.lrde@gov.in");
//
//		        // Adjust cell widths if needed
//		        cell1.setWidth("40%");
//		        cell2.setWidth("10%");
//		        cell3.setWidth("50%");
//		        run3.addBreak();
//		        run3.addBreak();
//
//		 	}
		 	
		 	if (WordDocumentData != null && WordDocumentData[4] != null && WordDocumentData[4].toString().equalsIgnoreCase("Y")) {
		 	    // Create header
		 	    XWPFHeader header = document.createHeader(HeaderFooterType.DEFAULT);

		 	    // Create a paragraph in the header (it will be used to insert the image)
		 	    XWPFParagraph paragraph = header.createParagraph();
		 	    paragraph.setAlignment(ParagraphAlignment.LEFT); // Align left to start with
		 	    paragraph.setIndentationLeft(50); // Adjust the left indentation as needed (50 EMUs is just an example)

		 	    // Add image to the paragraph (as the header content)
		 	    XWPFRun imageRun = paragraph.createRun();
		 	    Path imgFile = Paths.get(env.getProperty("file_upload_path"), "Letter", "LetterHead.png");

		 	    try (InputStream imgStream = new FileInputStream(imgFile.toFile())) {
		 	        // Add the image to the header (adjust size as needed)
		 	        imageRun.addPicture(imgStream, XWPFDocument.PICTURE_TYPE_PNG, "LetterHead.png", Units.toEMU(500), Units.toEMU(150)); // Adjust width and height
		 	    } catch (IOException e) {
		 	        e.printStackTrace();
		 	    }
		 	}

            
            
	        XWPFParagraph RefheaderParagraph = document.createParagraph();
	        RefheaderParagraph.setAlignment(ParagraphAlignment.LEFT);
	        XWPFRun headerRun = RefheaderParagraph.createRun();
	        headerRun.setText("Ref No: "+WordDocumentData[0].toString());
	        headerRun.setText("\t\t\t\t\t\t\t               ");
	        headerRun.setText("Date: "+sdf.format(WordDocumentData[1]));
	        headerRun.addBreak();

	        XWPFParagraph toAddressParagraph = document.createParagraph();
	        toAddressParagraph.setAlignment(ParagraphAlignment.LEFT);
	        XWPFRun toAddressRun = toAddressParagraph.createRun();
	        toAddressRun.setText("To, ");
	        toAddressRun.addBreak();
	        toAddressRun.setText(WordDocumentData[6].toString()+",");
	        toAddressRun.addBreak();
	        toAddressRun.setText(WordDocumentData[7].toString()+",");
	        toAddressRun.addBreak();
	        toAddressRun.setText(WordDocumentData[8].toString()+"-"+WordDocumentData[9].toString());
	        
	     // Create a new paragraph for the subject
	        XWPFParagraph subjectParagraph = document.createParagraph();
	        
	        subjectParagraph.setAlignment(ParagraphAlignment.LEFT);

	        // Create the first run for the "Subject :" part and make it bold
	        XWPFRun subjectRunBold = subjectParagraph.createRun();
	        subjectRunBold.setBold(true);
	        subjectRunBold.setText("Subject : ");

	        // Create the second run for the dynamic part and keep it normal
	        XWPFRun subjectRunNormal = subjectParagraph.createRun();
	        subjectRunNormal.setText(WordDocumentData[2].toString());
	        subjectRunNormal.addBreak();

	        
	        XWPFParagraph ContentParagraph = document.createParagraph();
	        ContentParagraph.setAlignment(ParagraphAlignment.LEFT);
	        XWPFRun ContentRun = ContentParagraph.createRun();
	        ContentRun.setText("Dear Sir/Madam,");
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.setText(WordDocumentData[3].toString());
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.addBreak();

	        XWPFParagraph signatoryParagraph = document.createParagraph();
	        signatoryParagraph.setAlignment(ParagraphAlignment.RIGHT);
	        XWPFRun signatoryRun = signatoryParagraph.createRun();
	        signatoryRun.setText(WordDocumentData[5].toString());

	        try {
	        	Path basefolderpath=Paths.get(env.getProperty("file_upload_path"), "Letter",enote.getLetterNo().toString()+"_"+"Documents");
	        	File baseDir = basefolderpath.toFile();
	        	if (!baseDir.exists()) {
	        	    baseDir.mkdirs(); 
	        	}
	        	int count1 = dao.GetLetterDocDetails(enoteId).size() + 1;
	        	String fileName = "L" + count1 + "-" + enote.getLetterNo().toString() + ".docx";
	        	String filePath = basefolderpath + File.separator + fileName;
	        	FileOutputStream out = new FileOutputStream(filePath);
	        	
	        	document.write(out);
	        	out.close();
	        	
	        	String DynamicPath1 = enote.getLetterNo().replace("/", "_");
	        	DakLetterDoc doc=new DakLetterDoc();
	        	doc.setEnoteId(enoteId);
	        	doc.setFilePath(DynamicPath1);
	        	doc.setFileName(fileName);
	        	doc.setCreatedBy(enote.getModifiedBy());
	        	doc.setCreatedDate(enote.getModifiedDate());
        		dao.DakLetterDocFile(doc);
	            System.out.println("Word document created successfully.");
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public Object[] RecommendingDetails(long EnoteId,String lab) throws Exception {
		return dao.RecommendingDetails(EnoteId,lab);
	}
	
	@Override
	public List<Object[]> eNotePendingList(long EmpId) throws Exception {
		return dao.eNotePendingList(EmpId);
	}
	
	@Override
	public List<Object[]> eNoteApprovalList(long EmpId,String fromDate,String toDate) throws Exception {
		return dao.eNoteApprovalList(EmpId,fromDate,toDate);
	}
	
	@Override
	public List<Object[]> EnoteTransactionList(String enoteTrackId) throws Exception {
		return dao.EnoteTransactionList(enoteTrackId);
	}
	
	@Override
	public Object[] EnotePrint(String enotePrintId) throws Exception {
		return dao.EnotePrint(enotePrintId);
	}
	
	@Override
	public List<Object[]> EnotePrintDetails(long EnoteId) throws Exception {
		return dao.EnotePrintDetails(EnoteId);
	}
	
	@Override
	public List<Object[]> EnoteRoSoList(String lab) throws Exception {
		return dao.EnoteRoSoList(lab);
	}
	
	@Override
	public List<Object[]> EmployeeListForEnoteRoSo(String lab) throws Exception {
		return dao.EmployeeListForEnoteRoSo(lab);
	}
	@Override
	public long InsertEnoteRoso(EnoteRosoModel enote) throws Exception {
		return dao.InsertEnoteRoso(enote);
	}
	
	@Override
	public List<Object[]> InitiatedEmpList(String lab) throws Exception {
		return dao.InitiatedEmpList(lab);
	}
	
	@Override
	public EnoteRosoModel EnoteRoSoEditData(long EnoteRoSoId) throws Exception {
		return dao.getEnoteRoSoDataById(EnoteRoSoId);
	}
	
	@Override
	public long UpdateEnoteRoso(EnoteRosoDto enote) throws Exception {
		Long EnoteRoSoId = enote.getEnoteRoSoId();
		EnoteRosoModel model = dao.getEnoteRoSoDataById(EnoteRoSoId);
		
				model.setInitiatingEmpId(enote.getInitiatingEmpId());
				model.setRO1(enote.getRO1());
				model.setRO1_Role(enote.getRO1_Role());
				if(enote.getRO2()!=null && !enote.getRO2().toString().equalsIgnoreCase("")) {
				model.setRO2(enote.getRO2());
				}
				if(enote.getRO2_Role()!=null && !enote.getRO2_Role().toString().equalsIgnoreCase("")) {
				model.setRO2_Role(enote.getRO2_Role());
				}
				if(enote.getRO3()!=null && !enote.getRO3().toString().equalsIgnoreCase("")) {
				model.setRO3(enote.getRO3());
				}
				if(enote.getRO3_Role()!=null && !enote.getRO3_Role().toString().equalsIgnoreCase("")) {
				model.setRO3_Role(enote.getRO3_Role());
				}
				model.setRO4(enote.getRO4());
				model.setRO4_Role(enote.getRO4_Role());
				model.setRO5(enote.getRO5());
				model.setRO5_Role(enote.getRO5_Role());
				if(enote.getExternalOfficer()!=null && !enote.getExternalOfficer().toString().equalsIgnoreCase("")) {
				model.setExternalOfficer(enote.getExternalOfficer());
				}
				if(enote.getExternalOfficer_Role()!=null && !enote.getExternalOfficer_Role().toString().equalsIgnoreCase("")) {
				model.setExternalOfficer_Role(enote.getExternalOfficer_Role());
				}
				if(enote.getExternal_LabCode()!=null && !enote.getExternal_LabCode().toString().equalsIgnoreCase("")) {
				model.setExternal_LabCode(enote.getExternal_LabCode());
				}
				if(enote.getApprovingOfficer()!=null && !enote.getApprovingOfficer().toString().equalsIgnoreCase("")) {
				model.setApprovingOfficer(enote.getApprovingOfficer());	
				}
				if(enote.getApproving_Role()!=null && !enote.getApproving_Role().toString().equalsIgnoreCase("")) {
				model.setApproving_Role(enote.getApproving_Role());
				}
				model.setModifiedBy(enote.getModifiedBy());
				model.setModifiedDate(enote.getModifiedDate());

		long count= dao.updateDakEnoteRoSo(model);
		return count;
	}
	
	@Override
	public Object[] EnoteRoSoDetails(long EnoteRoSoId,String lab) throws Exception {
		return dao.EnoteRoSoDetails(EnoteRoSoId,lab);
	}
	
	@Override
	public Object[] EnoteRoSoRoledetails(long EnoteId) throws Exception {
		return dao.EnoteRoSoRoledetails(EnoteId);
	}
	
	@Override
	public List<Object[]> LabList(String lab) throws Exception {
		return dao.LabList(lab);
	}
	
	@Override
	public List<Object[]> ExpertEmployeeList() throws Exception {
		return dao.ExpertEmployeeList();
	}
	
	@Override
	public Object[] getExternalLabCode(long EnoteRoSoId) throws Exception {
		return dao.getExternalLabCode(EnoteRoSoId);
	}
	
	@Override
	public long EnoteInitiaterRevoke(String enoteRevokeId, String username, long EmpId) throws Exception {
       Enote enote = dao.getEnoteById(Long.parseLong(enoteRevokeId));
		
        enote.setEnoteStatusCode("REV");
        enote.setEnoteStatusCodeNext("FWD");
        enote.setModifiedBy(username);
        enote.setModifiedDate(sdf1.format(new Date()));
		
        EnoteTransaction transaction = EnoteTransaction.builder()
				   .EnoteId(Long.parseLong(enoteRevokeId))
				   .EnoteStatusCode(enote.getEnoteStatusCode())
				   .ActionBy(EmpId)
				   .ActionDate(sdf1.format(new Date()))
				   .build();
        dao.addEnoteTransaction(transaction);
        
        return dao.eNoteRevokeEdit(enote);
	}
	
	@Override
	public Object[] ExternalNameData(long EnoteId) throws Exception {
		return dao.ExternalNameData(EnoteId);
	}
	
	@Override
	public List<Object[]> ReturnRemarks(String eNoteId) throws Exception {
		return dao.ReturnRemarks(eNoteId);
	}
	
	@Override
	public List<Object[]> ExternalList(long EmpId) throws Exception {
		return dao.ExternalList(EmpId);
	}
	
	@Override
	public List<Object[]> ExternalApprovalList(long EmpId, String fromDate, String toDate) throws Exception {
		return dao.ExternalApprovalList(EmpId,fromDate,toDate);
	}
	
	@Override
	public List<Object[]> eNoteSkipApprovalPendingList(String fromDate, String toDate,String Username,long EmpId) throws Exception {
		return dao.eNoteSkipApprovalPendingList(fromDate,toDate,Username,EmpId);
	}
	
	@Override
	public List<Object[]> EnotePrintViewDetails(long EnoteId) throws Exception {
		return dao.EnotePrintViewDetails(EnoteId);
	}
	
	@Override
	public Object getDivisionId(long EmpId) throws Exception {
		return dao.getDivisionId(EmpId);
	}
	
	@Override
	public List<Object[]> GetChangeRecommendingOfficer(String divId) throws Exception {
		return dao.GetChangeRecommendingOfficer(divId);
	}
	
	@Override
	public long ChangeRecommendOfficer(long EnoteId, long RecommendingOfficer, String statusCodeNext,String RecommendRole,String ChangeApprovalRemarks,String ChangeStatusCode,long EmpId) throws Exception {
		EnoteTransaction transaction = EnoteTransaction.builder()
				   .EnoteId(EnoteId)
				   .EnoteStatusCode(ChangeStatusCode)
				   .Remarks(ChangeApprovalRemarks)
				   .ActionBy(EmpId)
				   .ActionDate(sdf1.format(new Date()))
				   .build();
         dao.addEnoteTransaction(transaction);
		return dao.ChangeRecommendOfficer(EnoteId,RecommendingOfficer,statusCodeNext,RecommendRole,ChangeApprovalRemarks);
	}
	
	@Override
	public Object[] DakRecommendingDetails(long DakeNoteReplyId) throws Exception {
		return dao.DakRecommendingDetails(DakeNoteReplyId);
	}
	
	@Override
	public long DakReplyAttachmentCount(long DakeNoteReplyId) throws Exception {
		return dao.DakReplyAttachmentCount(DakeNoteReplyId);
	}
	
	@Override
	public long InsertDakReplyEnote(EnoteDto dto,String DakAssignReplyId,long EmpId,String EnoteFrom,String LabCode) throws Exception {
		 Enote enote=dto.getEnote();
			
		 SimpleDateFormat RequiredFormat = new SimpleDateFormat("ddMMMyy");
		 String DayMonYear = RequiredFormat.format(new Date()); //currentDate
		 String enoteStr = "E"+DayMonYear+"_";
		 String letterStr = "L"+DayMonYear+"_";
		 long count;
		 int width = 3;
		 long DakReplyAttachAddResult = 0;
		 long EnoteIdCount=dao.EnoteCountForGeneration();
		 
		 if(EnoteIdCount>0) {
			 count = EnoteIdCount+1;
		 }else {
			 count = 1;
		 }
		 
		 String formattedCount = String.format("%0" + width + "d", count);
		 String NewEnoteNO=enoteStr+formattedCount;
		 String NewLetterNo= LabCode+"_"+enote.getDivisionCode().toString()+"_"+letterStr+formattedCount;
		 
		 enote.setNoteId(NewEnoteNO);
		 if(enote.getIsDraft()!=null && enote.getIsDraft().equalsIgnoreCase("Y")) {
		 enote.setLetterNo(NewLetterNo);
		 }
		 
		 long EnoteId=dao.insertEnote(enote);
		 if(EnoteId>0) {
			 if(dto!=null && dto.getDakReplyEnoteDocument()!=null && dto.getDakReplyEnoteDocument().length>0 && !dto.getDakReplyEnoteDocument()[0].isEmpty() && EnoteFrom!=null && EnoteFrom.equalsIgnoreCase("C")) {
	        	for(MultipartFile file : dto.getDakReplyEnoteDocument()) {
	        		if(!file.isEmpty()) {
	        			 String dakNoPath = enote.getDakNo().replace("/", "_");
						 String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
	             	     Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
	     				 int ExistingDocsCount = dakdao.GetPrevAssignReplyAttachmentDetails(Long.parseLong(DakAssignReplyId)).size()+1;
	                		
	                		File theDir = fullpath.toFile();
	                		if (!theDir.exists()){
	                		    theDir.mkdirs();
	                		}
	     				AssignReplyAttachment attachment=new AssignReplyAttachment();
	     				attachment.setDakAssignReplyId(Long.parseLong(DakAssignReplyId));
	     				attachment.setDakId(enote.getDakId());
	     				attachment.setEmpId(EmpId);
	     				attachment.setFilePath(DynamicPath);
	     				attachment.setFileName(String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename());
	     				attachment.setCreatedBy(enote.getCreatedBy());
	     				attachment.setCreatedDate(enote.getCreatedDate());
	     				long AttachmentInsert=dakdao.AssignReplyAttachment(attachment);
	     				saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename(),file );
	        		}
	        		}
			 }else if(EnoteFrom!=null && EnoteFrom.equalsIgnoreCase("M") && dto!=null && dto.getDakReplyEnoteDocument()!=null && dto.getDakReplyEnoteDocument().length>0 && !dto.getDakReplyEnoteDocument()[0].isEmpty()) {
				 for(MultipartFile file : dto.getDakReplyEnoteDocument()) {
	     				if(!file.isEmpty()) {
	           		
 					String dakNoPath = enote.getDakNo().replace("/", "_");
					String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();		
	        	    Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
	           		//int ExistingDocsCount = dao.GetReplyAttachmentDetails(ReplyAttachDto.getReplyId(),ReplyAttachDto.getIsMain()).size()+1;
	           		int ExistingDocsCount = dakdao.GetPrevReplyAttachmentDetails(Long.parseLong(DakAssignReplyId)).size()+1;
	           		
	           		
	           		File theDir = fullpath.toFile();
	           		if (!theDir.exists()){
	           		    theDir.mkdirs();
	           		}
	           		DakReplyAttach ReplyAttachModel = new DakReplyAttach();
	           		ReplyAttachModel.setReplyId(Long.parseLong(DakAssignReplyId));
	           		ReplyAttachModel.setEmpId(EmpId);
	           		ReplyAttachModel.setIsMain("Y");
	           		ReplyAttachModel.setFilePath(DynamicPath);
	           	    ReplyAttachModel.setFileName(String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename());
	           		ReplyAttachModel.setCreatedBy(enote.getCreatedBy());
	           		ReplyAttachModel.setCreatedDate(enote.getCreatedDate());
	           		saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename(),file );
	           		DakReplyAttachAddResult=dakdao.DakReplyAttachmentAdd(ReplyAttachModel);
			 }
		}
}	
			 // Transaction
				EnoteTransaction transaction = EnoteTransaction.builder()
											   .EnoteId(EnoteId)
											   .EnoteStatusCode("INI")
											   .ActionBy(enote.getInitiatedBy())
											   .ActionDate(sdf1.format(new Date()))
											   .build();
				dao.addEnoteTransaction(transaction);
				
				if(enote.getIsDraft()!=null && enote.getIsDraft().equalsIgnoreCase("Y")) {
				Object[] WordDocumentData=dao.WordDocumentData(EnoteId);
			 	XWPFDocument document = new XWPFDocument();
		        
//			 	if(WordDocumentData!=null && WordDocumentData[4]!=null && WordDocumentData[4].toString().equalsIgnoreCase("Y")) {
//			 		 // Create header
//			        XWPFHeader header = document.createHeader(HeaderFooterType.DEFAULT);
//
//			        // Create table for header content with 1 row and 3 columns
//			        XWPFTable table = header.createTable(1, 3);
//			        table.setWidth("100%");
//			        
//			        table.getCTTbl().getTblPr().unsetTblBorders();
//			        // Create a row (already created by createTable)
//			        XWPFTableRow row = table.getRow(0);
//			        
//			        // Create a cell for Hindi text
//			        XWPFTableCell cell1 = row.getCell(0);
//			        XWPFParagraph para1 = cell1.getParagraphs().get(0);
//			        para1.setAlignment(ParagraphAlignment.LEFT);
//			        XWPFRun run1 = para1.createRun();
//			        run1.setFontFamily("Arial Unicode MS");
//			        run1.setText("इलेक्ट्रॉनिक्स तथा रेडार विकास स्थापना");
//			        run1.addBreak();
//			        run1.setText("भारत सरकार - रक्षा मंत्रालय ");
//			        run1.addBreak();
//			        run1.setText("रक्षा अनुसंधान तथा विकास संगठन");
//			        run1.addBreak();
//			        run1.setText("पो.बा.स. , सी. वी. रामन नगर");
//			        run1.addBreak();
//			        run1.setText("बेंगलूर - , भारत");
//			        run1.addBreak();
//			        run1.setText("फैक्स : 080-2524 2916");
//			        run1.addBreak();
//			        run1.setText("फ़ोन :  080-2524 3873");
//			         // Use a more common font
//			        run1.setFontSize(12);
//
//			        // Create a cell for the image
//			        XWPFTableCell cell2 = row.getCell(1);
//			        XWPFParagraph para2 = cell2.getParagraphs().get(0);
//			        para2.setAlignment(ParagraphAlignment.LEFT);  // Center the image
//			        XWPFRun imageRun = para2.createRun();
//			        Path imgfile=Paths.get(env.getProperty("file_upload_path"), "Letter","drdo.png");
//			        try (InputStream imgStream = new FileInputStream(imgfile.toFile())) {
//			            imageRun.addPicture(imgStream, XWPFDocument.PICTURE_TYPE_PNG, "drdo.png", Units.toEMU(70), Units.toEMU(70)); // Adjust width and height as needed
//			        } catch (IOException e) {
//			            e.printStackTrace();
//			        }
//
//			        // Create a cell for English text
//			        XWPFTableCell cell3 = row.getCell(2);
//			        XWPFParagraph para3 = cell3.getParagraphs().get(0);
//			        para3.setAlignment(ParagraphAlignment.LEFT);
//			        XWPFRun run3 = para3.createRun();
//			        run3.setText("Electronics & Radar Development Establishment");
//			        run3.addBreak();
//			        run3.setText("Govt of India, Ministry of Defence");
//			        run3.addBreak();
//			        run3.setText("Defence Research & Development Organisation");
//			        run3.addBreak();
//			        run3.setText("P.B. No: 9324, C V Raman Nagar");
//			        run3.addBreak();
//			        run3.setText("Bengaluru - 560 093. India");
//			        run3.addBreak();
//			        run3.setText("Fax : 080-2524 2916");
//			        run3.addBreak();
//			        run3.setText("Phone : 080-2524 3873");
//			        run3.addBreak();
//			        run3.setText("E-Mail :  director.lrde@gov.in");
//
//			        // Adjust cell widths if needed
//			        cell1.setWidth("40%");
//			        cell2.setWidth("10%");
//			        cell3.setWidth("50%");
//			        run3.addBreak();
//			        run3.addBreak();
//
//			 	}
			 	
			 	if (WordDocumentData != null && WordDocumentData[4] != null && WordDocumentData[4].toString().equalsIgnoreCase("Y")) {
			 	    // Create header
			 	    XWPFHeader header = document.createHeader(HeaderFooterType.DEFAULT);

			 	    // Create a paragraph in the header (it will be used to insert the image)
			 	    XWPFParagraph paragraph = header.createParagraph();
			 	    paragraph.setAlignment(ParagraphAlignment.LEFT); // Align left to start with
			 	    paragraph.setIndentationLeft(50); // Adjust the left indentation as needed (50 EMUs is just an example)

			 	    // Add image to the paragraph (as the header content)
			 	    XWPFRun imageRun = paragraph.createRun();
			 	    Path imgFile = Paths.get(env.getProperty("file_upload_path"), "Letter", "LetterHead.png");

			 	    try (InputStream imgStream = new FileInputStream(imgFile.toFile())) {
			 	        // Add the image to the header (adjust size as needed)
			 	        imageRun.addPicture(imgStream, XWPFDocument.PICTURE_TYPE_PNG, "LetterHead.png", Units.toEMU(500), Units.toEMU(150)); // Adjust width and height
			 	    } catch (IOException e) {
			 	        e.printStackTrace();
			 	    }
			 	}

	            
	            
		        XWPFParagraph RefheaderParagraph = document.createParagraph();
		        RefheaderParagraph.setAlignment(ParagraphAlignment.LEFT);
		        XWPFRun headerRun = RefheaderParagraph.createRun();
		        headerRun.setText("Ref No: "+WordDocumentData[0].toString());
		        headerRun.setText("\t\t\t\t\t\t\t               ");
		        headerRun.setText("Date: "+sdf.format(WordDocumentData[1]));
		        headerRun.addBreak();

		        XWPFParagraph toAddressParagraph = document.createParagraph();
		        toAddressParagraph.setAlignment(ParagraphAlignment.LEFT);
		        XWPFRun toAddressRun = toAddressParagraph.createRun();
		        toAddressRun.setText("To, ");
		        toAddressRun.addBreak();
		        toAddressRun.setText(WordDocumentData[6].toString()+",");
		        toAddressRun.addBreak();
		        toAddressRun.setText(WordDocumentData[7].toString()+",");
		        toAddressRun.addBreak();
		        toAddressRun.setText(WordDocumentData[8].toString()+"-"+WordDocumentData[9].toString());
		        
		     // Create a new paragraph for the subject
		        XWPFParagraph subjectParagraph = document.createParagraph();
		        
		        subjectParagraph.setAlignment(ParagraphAlignment.LEFT);

		        // Create the first run for the "Subject :" part and make it bold
		        XWPFRun subjectRunBold = subjectParagraph.createRun();
		        subjectRunBold.setBold(true);
		        subjectRunBold.setText("Subject : ");

		        // Create the second run for the dynamic part and keep it normal
		        XWPFRun subjectRunNormal = subjectParagraph.createRun();
		        subjectRunNormal.setText(WordDocumentData[2].toString());
		        subjectRunNormal.addBreak();

		        
		        XWPFParagraph ContentParagraph = document.createParagraph();
		        ContentParagraph.setAlignment(ParagraphAlignment.LEFT);
		        XWPFRun ContentRun = ContentParagraph.createRun();
		        ContentRun.setText("Dear Sir/Madam,");
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.setText(WordDocumentData[3].toString());
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.addBreak();
		        ContentRun.addBreak();

		        XWPFParagraph signatoryParagraph = document.createParagraph();
		        signatoryParagraph.setAlignment(ParagraphAlignment.RIGHT);
		        XWPFRun signatoryRun = signatoryParagraph.createRun();
		        signatoryRun.setText(WordDocumentData[5].toString());

		        try {
		        	Path basefolderpath=Paths.get(env.getProperty("file_upload_path"), "Letter",NewLetterNo+"_"+"Documents");
		        	File baseDir = basefolderpath.toFile();
		        	if (!baseDir.exists()) {
		        	    baseDir.mkdirs(); 
		        	}
		        	int count1 = dao.GetLetterDocDetails(EnoteId).size() + 1;
		        	String fileName = "L" + count1 + "-" + NewLetterNo + ".docx";
		        	String filePath = basefolderpath +File.separator + fileName;
		        	FileOutputStream out = new FileOutputStream(filePath);
		        	
		        	document.write(out);
		        	out.close();
		        	
		        	String DynamicPath1 = enote.getLetterNo().replace("/", "_");
		        	DakLetterDoc doc=new DakLetterDoc();
		        	doc.setEnoteId(EnoteId);
		        	doc.setFilePath(DynamicPath1);
		        	doc.setFileName(fileName);
		        	doc.setCreatedBy(enote.getCreatedBy());
		        	doc.setCreatedDate(enote.getCreatedDate());
	        		dao.DakLetterDocFile(doc);
		            System.out.println("Word document created successfully.");
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
				}
		 }
		return EnoteId;
	}
	
	@Override
	public Object[] DakEnoteAttachmentData(String eNoteAttachId) throws Exception {
		return dao.DakEnoteAttachmentData(eNoteAttachId);
	}
	
	@Override
	public List<Object[]> DakEnoteAttachmentData(long AttachmentId, long DakEnoteReplyId) throws Exception {
		return dao.DakEnoteAttachmentData(AttachmentId,DakEnoteReplyId);
	}
	
	@Override
	public int DeleteDakEnoteAttachment(String enoteAttachId) throws Exception {
		return dao.DeleteDakEnoteAttachment(enoteAttachId);
	}
	
	@Override
	public List<Object[]> GetEnoteAssignReplyAttachmentDetails(long DakAssignReplyId) throws Exception {
		return dao.GetEnoteAssignReplyAttachmentDetails(DakAssignReplyId);
	}
	
	@Override
	public DakEnoteReply EnoteReplyEditData(long DakEnoteReplyId) throws Exception {
		return dao.getEnoteReplyEditData(DakEnoteReplyId);
	}
	
	@Override
	public long UpdateEnoteReply(EnoteDto dto,long EmpId) throws Exception {
		
		try {
			long DakReplyAttachAddResult=0;
			Long enoteId = dto.getEnoteId();
			Enote enote = dao.getEnoteById(enoteId);
			
			enote.setDakReplyId(dto.getDakReplyId());
			enote.setDakId(dto.getDakId());
			enote.setDakNo(dto.getDakNo());
			enote.setNoteNo(dto.getNoteNo());
			enote.setRefNo(dto.getRefNo());
			enote.setRefDate(dto.getRefDate());
			enote.setReply(dto.getReply());
			enote.setSubject(dto.getSubject());;
			enote.setInitiatedBy(dto.getInitiatedBy());
			enote.setLetterDate(dto.getLetterDate());
			enote.setDestinationId(dto.getDestinationId());
			enote.setDestinationTypeId(dto.getDestinationTypeId());
			enote.setDraftContent(dto.getDraftContent());
			enote.setSignatory(dto.getSignatory());
			enote.setLetterHead(dto.getLetterHead());
			enote.setModifiedBy(dto.getModifiedBy());
			enote.setModifiedDate(dto.getModifiedDate());
			
			long count= dao.updateEnoteReply(enote);
			if(count>0) {
				if(dto!=null && dto.getDakReplyEnoteDocument()!=null && dto.getDakReplyEnoteDocument().length>0 && !dto.getDakReplyEnoteDocument()[0].isEmpty() && enote.getEnoteFrom()!=null && enote.getEnoteFrom().equalsIgnoreCase("C")) {
		        	for(MultipartFile file : dto.getDakReplyEnoteDocument()) {
	        		if(!file.isEmpty()) {
	        			 String dakNoPath = enote.getDakNo().replace("/", "_");
						 String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
		             	    Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
		     				int ExistingDocsCount = dakdao.GetPrevAssignReplyAttachmentDetails(Long.parseLong(dto.getDakReplyId().toString())).size()+1;
		                		
		                		File theDir = fullpath.toFile();
		                		if (!theDir.exists()){
		                		    theDir.mkdirs();
		                		}
		     				AssignReplyAttachment attachment=new AssignReplyAttachment();
		     				attachment.setDakAssignReplyId(Long.parseLong(dto.getDakReplyId().toString()));
		     				attachment.setDakId(dto.getDakId());
		     				attachment.setEmpId(EmpId);
		     				attachment.setFilePath(DynamicPath);
		     				attachment.setFileName(String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename());
		     				attachment.setCreatedBy(dto.getModifiedBy());
		     				attachment.setCreatedDate(dto.getModifiedDate());
		     				long AttachmentInsert=dakdao.AssignReplyAttachment(attachment);
		     				saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"A"+"_"+file.getOriginalFilename(),file );
	        		}
	        		}
				}else if(dto!=null && dto.getDakReplyEnoteDocument()!=null && dto.getDakReplyEnoteDocument().length>0 && !dto.getDakReplyEnoteDocument()[0].isEmpty() && enote.getEnoteFrom()!=null && enote.getEnoteFrom().equalsIgnoreCase("M")) {
					 for(MultipartFile file : dto.getDakReplyEnoteDocument()) {
		     				if(!file.isEmpty()) {
		           		
 						String dakNoPath = enote.getDakNo().replace("/", "_");
					    String DynamicPath = Paths.get(dakNoPath, "Outbox").toString();
		        	    Path fullpath=Paths.get(env.getProperty("file_upload_path"), "Dak",DynamicPath);
		           		//int ExistingDocsCount = dao.GetReplyAttachmentDetails(ReplyAttachDto.getReplyId(),ReplyAttachDto.getIsMain()).size()+1;
		           		int ExistingDocsCount = dakdao.GetPrevReplyAttachmentDetails(Long.parseLong(dto.getDakReplyId().toString())).size()+1;
		           		File theDir = fullpath.toFile();
		           		if (!theDir.exists()){
		           		    theDir.mkdirs();
		           		}
		           		DakReplyAttach ReplyAttachModel = new DakReplyAttach();
		           		ReplyAttachModel.setReplyId(Long.parseLong(dto.getDakReplyId().toString()));
		           		ReplyAttachModel.setEmpId(EmpId);
		           		ReplyAttachModel.setIsMain("Y");
		           		ReplyAttachModel.setFilePath(DynamicPath);
		           	    ReplyAttachModel.setFileName(String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename());
		           		ReplyAttachModel.setCreatedBy(enote.getCreatedBy());
		           		ReplyAttachModel.setCreatedDate(enote.getCreatedDate());

		           		saveFile1(fullpath,String.valueOf(ExistingDocsCount)+"_"+file.getOriginalFilename(),file );
		           		
		           		DakReplyAttachAddResult=dakdao.DakReplyAttachmentAdd(ReplyAttachModel);
				 }
			}
				}
			}
			Object[] WordDocumentData=dao.WordDocumentData(enoteId);
		 	XWPFDocument document = new XWPFDocument();
	        
//		 	if(WordDocumentData!=null && WordDocumentData[4]!=null && WordDocumentData[4].toString().equalsIgnoreCase("Y")) {
//		 		 // Create header
//		        XWPFHeader header = document.createHeader(HeaderFooterType.DEFAULT);
//
//		        // Create table for header content with 1 row and 3 columns
//		        XWPFTable table = header.createTable(1, 3);
//		        table.setWidth("100%");
//		        
//		        table.getCTTbl().getTblPr().unsetTblBorders();
//		        // Create a row (already created by createTable)
//		        XWPFTableRow row = table.getRow(0);
//		        
//		        // Create a cell for Hindi text
//		        XWPFTableCell cell1 = row.getCell(0);
//		        XWPFParagraph para1 = cell1.getParagraphs().get(0);
//		        para1.setAlignment(ParagraphAlignment.LEFT);
//		        XWPFRun run1 = para1.createRun();
//		        run1.setFontFamily("Arial Unicode MS");
//		        run1.setText("इलेक्ट्रॉनिक्स तथा रेडार विकास स्थापना");
//		        run1.addBreak();
//		        run1.setText("भारत सरकार - रक्षा मंत्रालय ");
//		        run1.addBreak();
//		        run1.setText("रक्षा अनुसंधान तथा विकास संगठन");
//		        run1.addBreak();
//		        run1.setText("पो.बा.स. , सी. वी. रामन नगर");
//		        run1.addBreak();
//		        run1.setText("बेंगलूर - , भारत");
//		        run1.addBreak();
//		        run1.setText("फैक्स : 080-2524 2916");
//		        run1.addBreak();
//		        run1.setText("फ़ोन :  080-2524 3873");
//		         // Use a more common font
//		        run1.setFontSize(12);
//
//		        // Create a cell for the image
//		        XWPFTableCell cell2 = row.getCell(1);
//		        XWPFParagraph para2 = cell2.getParagraphs().get(0);
//		        para2.setAlignment(ParagraphAlignment.LEFT);  // Center the image
//		        XWPFRun imageRun = para2.createRun();
//		        Path imgfile=Paths.get(env.getProperty("file_upload_path"), "Letter","drdo.png");
//		        try (InputStream imgStream = new FileInputStream(imgfile.toFile())) {
//		            imageRun.addPicture(imgStream, XWPFDocument.PICTURE_TYPE_PNG, "drdo.png", Units.toEMU(70), Units.toEMU(70)); // Adjust width and height as needed
//		        } catch (IOException e) {
//		            e.printStackTrace();
//		        }
//
//		        // Create a cell for English text
//		        XWPFTableCell cell3 = row.getCell(2);
//		        XWPFParagraph para3 = cell3.getParagraphs().get(0);
//		        para3.setAlignment(ParagraphAlignment.LEFT);
//		        XWPFRun run3 = para3.createRun();
//		        run3.setText("Electronics & Radar Development Establishment");
//		        run3.addBreak();
//		        run3.setText("Govt of India, Ministry of Defence");
//		        run3.addBreak();
//		        run3.setText("Defence Research & Development Organisation");
//		        run3.addBreak();
//		        run3.setText("P.B. No: 9324, C V Raman Nagar");
//		        run3.addBreak();
//		        run3.setText("Bengaluru - 560 093. India");
//		        run3.addBreak();
//		        run3.setText("Fax : 080-2524 2916");
//		        run3.addBreak();
//		        run3.setText("Phone : 080-2524 3873");
//		        run3.addBreak();
//		        run3.setText("E-Mail :  director.lrde@gov.in");
//
//		        // Adjust cell widths if needed
//		        cell1.setWidth("40%");
//		        cell2.setWidth("10%");
//		        cell3.setWidth("50%");
//		        run3.addBreak();
//		        run3.addBreak();
//
//		 	}
		 	
		 	if (WordDocumentData != null && WordDocumentData[4] != null && WordDocumentData[4].toString().equalsIgnoreCase("Y")) {
		 	    // Create header
		 	    XWPFHeader header = document.createHeader(HeaderFooterType.DEFAULT);

		 	    // Create a paragraph in the header (it will be used to insert the image)
		 	    XWPFParagraph paragraph = header.createParagraph();
		 	    paragraph.setAlignment(ParagraphAlignment.LEFT); // Align left to start with
		 	    paragraph.setIndentationLeft(50); // Adjust the left indentation as needed (50 EMUs is just an example)

		 	    // Add image to the paragraph (as the header content)
		 	    XWPFRun imageRun = paragraph.createRun();
		 	    Path imgFile = Paths.get(env.getProperty("file_upload_path"), "Letter", "LetterHead.png");

		 	    try (InputStream imgStream = new FileInputStream(imgFile.toFile())) {
		 	        // Add the image to the header (adjust size as needed)
		 	        imageRun.addPicture(imgStream, XWPFDocument.PICTURE_TYPE_PNG, "LetterHead.png", Units.toEMU(500), Units.toEMU(150)); // Adjust width and height
		 	    } catch (IOException e) {
		 	        e.printStackTrace();
		 	    }
		 	}

            
            
	        XWPFParagraph RefheaderParagraph = document.createParagraph();
	        RefheaderParagraph.setAlignment(ParagraphAlignment.LEFT);
	        XWPFRun headerRun = RefheaderParagraph.createRun();
	        headerRun.setText("Ref No: "+WordDocumentData[0].toString());
	        headerRun.setText("\t\t\t\t\t\t\t               ");
	        headerRun.setText("Date: "+sdf.format(WordDocumentData[1]));
	        headerRun.addBreak();

	        XWPFParagraph toAddressParagraph = document.createParagraph();
	        toAddressParagraph.setAlignment(ParagraphAlignment.LEFT);
	        XWPFRun toAddressRun = toAddressParagraph.createRun();
	        toAddressRun.setText("To, ");
	        toAddressRun.addBreak();
	        toAddressRun.setText(WordDocumentData[6].toString()+",");
	        toAddressRun.addBreak();
	        toAddressRun.setText(WordDocumentData[7].toString()+",");
	        toAddressRun.addBreak();
	        toAddressRun.setText(WordDocumentData[8].toString()+"-"+WordDocumentData[9].toString());
	        
	     // Create a new paragraph for the subject
	        XWPFParagraph subjectParagraph = document.createParagraph();
	        
	        subjectParagraph.setAlignment(ParagraphAlignment.LEFT);

	        // Create the first run for the "Subject :" part and make it bold
	        XWPFRun subjectRunBold = subjectParagraph.createRun();
	        subjectRunBold.setBold(true);
	        subjectRunBold.setText("Subject : ");

	        // Create the second run for the dynamic part and keep it normal
	        XWPFRun subjectRunNormal = subjectParagraph.createRun();
	        subjectRunNormal.setText(WordDocumentData[2].toString());
	        subjectRunNormal.addBreak();

	        
	        XWPFParagraph ContentParagraph = document.createParagraph();
	        ContentParagraph.setAlignment(ParagraphAlignment.LEFT);
	        XWPFRun ContentRun = ContentParagraph.createRun();
	        ContentRun.setText("Dear Sir/Madam,");
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.setText(WordDocumentData[3].toString());
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.addBreak();
	        ContentRun.addBreak();

	        XWPFParagraph signatoryParagraph = document.createParagraph();
	        signatoryParagraph.setAlignment(ParagraphAlignment.RIGHT);
	        XWPFRun signatoryRun = signatoryParagraph.createRun();
	        signatoryRun.setText(WordDocumentData[5].toString());

	        try {
	        	Path basefolderpath=Paths.get(env.getProperty("file_upload_path"), "Letter",enote.getLetterNo().toString()+"_"+"Documents");
	        	File baseDir = basefolderpath.toFile();
	        	if (!baseDir.exists()) {
	        	    baseDir.mkdirs(); 
	        	}
	        	int count1 = dao.GetLetterDocDetails(enoteId).size() + 1;
	        	String fileName = "L" + count1 + "-" + enote.getLetterNo().toString() + ".docx";
	        	String filePath = basefolderpath + File.separator + fileName;
	        	FileOutputStream out = new FileOutputStream(filePath);
	        	
	        	document.write(out);
	        	out.close();
	        	
	        	String DynamicPath1 = enote.getLetterNo().replace("/", "_");
	        	DakLetterDoc doc=new DakLetterDoc();
	        	doc.setEnoteId(enoteId);
	        	doc.setFilePath(DynamicPath1);
	        	doc.setFileName(fileName);
	        	doc.setCreatedBy(enote.getModifiedBy());
	        	doc.setCreatedDate(enote.getModifiedDate());
        		dao.DakLetterDocFile(doc);
	            System.out.println("Word document created successfully.");
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public List<Object[]> DakENoteReplyReturnRemarks(String DakEnoteReplyId) throws Exception {
		return dao.DakENoteReplyReturnRemarks(DakEnoteReplyId);
	}
	
	
	@Override
	public Object[] DakMarkingEnoteAttachmentData(String eNoteAttachId) throws Exception {
		return dao.DakMarkingEnoteAttachmentData(eNoteAttachId);
	}
	
	@Override
	public List<Object[]> DakEnoteMarkerAttachmentData(long AttachmentId, long DakEnoteReplyId) throws Exception {
		return dao.DakEnoteMarkerAttachmentData(AttachmentId,DakEnoteReplyId);
	}
	
	@Override
	public int DeleteMarkerDakEnoteAttachment(String enoteAttachId) throws Exception {
		return dao.DeleteMarkerDakEnoteAttachment(enoteAttachId);
	}
	
	@Override
	public long DakMarkerReplyAttachmentCount(long DakeNoteReplyId) throws Exception {
		return dao.DakMarkerReplyAttachmentCount(DakeNoteReplyId);
	}
	@Override
	public Object[] DakEnotePreview(long DakeNoteReplyId) throws Exception {
		return dao.DakEnotePreview(DakeNoteReplyId);
	}
	
	@Override
	public Object[] EnoteDocumentData(String labCode, long InitiatedBy) throws Exception {
		return dao.EnoteDocumentData(labCode,InitiatedBy);
	}
	
	@Override
	public List<Object[]> TemplateList() throws Exception {
		return dao.TemplateList();
	}
	
	@Override
	public long updateRosoId(String[] eNoteRosoDeleteId) throws Exception {
		return dao.updateRosoId(eNoteRosoDeleteId);
	}
	
	@Override
	public Object[] WordDocumentData(long EnoteId) throws Exception {
		return dao.WordDocumentData(EnoteId);
	}
	
	@Override
	public Object[] letterDocumentData(String letterDocumentid) throws Exception {
		return dao.letterDocumentData(letterDocumentid);
	}
	
	@Override
	public long EnoteDocumentUpload(DakLetterDocDto dto) throws Exception {
		long result=0;
		if (dto != null && dto.getUploadDocument() != null && !dto.getUploadDocument().isEmpty()) {
	        Path basefolderpath=Paths.get(env.getProperty("file_upload_path"), "Letter",dto.getLetterNo().toString() + "_" + "Documents");
	        int count1 = dao.GetLetterDocDetails(dto.getEnoteId()).size() + 1;
	        String fileName = dto.getUploadDocument().getOriginalFilename();
	        String filePath = basefolderpath + File.separator + fileName;
	        String DynamicPath1 = dto.getLetterNo().replace("/", "_");
	        File baseDir = basefolderpath.toFile();
	        if (!baseDir.exists()) {
	            baseDir.mkdirs();
	        }
	        File fileToSave = new File(filePath);
	        dto.getUploadDocument().transferTo(fileToSave);
	        DakLetterDoc attach = new DakLetterDoc();
	        attach.setEnoteId(dto.getEnoteId());
	        attach.setFilePath(DynamicPath1); 
	        attach.setFileName(fileName);
	        attach.setCreatedBy(dto.getCreatedBy());
	        attach.setCreatedDate(dto.getCreatedDate());
	        result=dao.DakLetterDocFile(attach);
	        Object EmpName =dakdao.getEmpName(dto.getEmpId());
	        String emp=EmpName.toString();
	        List<Object[]> LetterAttachmentsFilePath=dao.LetterAttachmentsFilePath(result);
	        
	        if(dto.getReplyPersonSentMail()!=null && dto.getReplyReceivedMail()!=null && dto.getHostType()!=null && dto.getHostType().equalsIgnoreCase("D")) {
     			
     			for(int i=0;i<dto.getReplyReceivedMail().length;i++) {
     			 String subject = "Letter Approval";
                 String message = "<p>Dear Sir/Madam,</p>";
                        message += "<p></p>";
                        message += "<p>"+"Please find the Approved Letter"+"</p>";
                        message += "<p>Regards,<br>"+emp+"</p>";
                        sendMessage1(dto.getReplyPersonSentMail().toString(),dto.getReplyReceivedMail()[i].toString(),subject, message,LetterAttachmentsFilePath);
     			}
     		}else if(dto.getReplyPersonSentMail()!=null && dto.getReplyReceivedMail()!=null && dto.getHostType()!=null && dto.getHostType().equalsIgnoreCase("L")) {
     			for(int i=0;i<dto.getReplyReceivedMail().length;i++) {
        			 String subject = "Letter Approval";
                    String message = "<p>Dear Sir/Madam,</p>";
                           message += "<p></p>";
                           message += "<p>"+"Please find the Approved Letter"+"</p>";
                           message += "<p>Regards,<br>"+emp+"</p>";
                           sendMessage(dto.getReplyPersonSentMail().toString(),dto.getReplyReceivedMail()[i].toString(),subject, message,LetterAttachmentsFilePath);
        			}
     		}
	    }
	    return result;
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
		
		System.out.println("mailAuthentication.getHost():"+mailAuthentication.getHost());
		System.out.println("mailAuthentication.getPort():"+mailAuthentication.getPort());
		System.out.println("mailAuthentication.getUsername():"+mailAuthentication.getUsername());
		System.out.println("mailAuthentication.getPassword():"+mailAuthentication.getPassword());
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

	        for (Object[] obj : AttachmentsFilePath) {
	        	 try {
		        		 String filePath = env.getProperty("file_upload_path") + File.separator+"Letter" + File.separator + obj[0]+"_Documents" + File.separator + obj[1];
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

	        for (Object[] obj : AttachmentsFilePath) {
	        	 try {
		        		 String filePath = env.getProperty("file_upload_path")+ File.separator+"Letter" + File.separator + obj[0]+"_Documents" + File.separator + obj[1];
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
	        message.setContent(multipart);
			Transport.send(message);
			System.out.println("Message Sent");
			mailSendresult++;
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}
		return mailSendresult;
	}
}
