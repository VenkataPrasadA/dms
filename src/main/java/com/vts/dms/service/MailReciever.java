package com.vts.dms.service;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.TimeZone;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import jakarta.mail.BodyPart;
import jakarta.mail.Flags;
import jakarta.mail.Folder;
import jakarta.mail.Header;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.Part;
import jakarta.mail.Session;
import jakarta.mail.Store;
import jakarta.mail.UIDFolder;
import jakarta.mail.Flags.Flag;
import jakarta.mail.event.MessageCountAdapter;
import jakarta.mail.event.MessageCountEvent;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.search.ComparisonTerm;
import jakarta.mail.search.FlagTerm;
import jakarta.mail.search.ReceivedDateTerm;

import org.eclipse.angus.mail.imap.IMAPFolder;
import org.eclipse.angus.mail.imap.IdleManager;
import org.eclipse.angus.mail.imap.SortTerm;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.core.env.Environment;

import com.itextpdf.styledxmlparser.jsoup.Jsoup;
import com.vts.dms.dak.dto.MailConnectDto;
import com.vts.dms.dak.dto.MailDto;

public class MailReciever {

	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	public  List<MailDto> mail(MailConnectDto connectDto) throws MessagingException, IOException {
		    //System.out.println("insid5");
		    IMAPFolder folder = null;
		    Store store = null;
		    String subject = null;
		    Flag flag = null;
		    Message[] messages=null;
		    List<MailDto> mailAll=new ArrayList<MailDto>();
		    //System.out.println("insidi");
		    try 
		    {
		      Properties props = System.getProperties();
		      props.setProperty("mail.store.protocol", connectDto.getProtocol() );
		      props.setProperty("mail."+connectDto.getProtocol()+".usesocketchannels", "true");
		      props.setProperty("mail."+connectDto.getProtocol()+".port",connectDto.getPort());
		      props.setProperty("mail."+connectDto.getProtocol()+".ssl.trust",connectDto.getHost());
		      props.setProperty("mail."+connectDto.getProtocol()+".timeout", "10000");
		      Session session = Session.getDefaultInstance(props, null);
              //System.out.println("insidi2");
		      ExecutorService es = Executors.newCachedThreadPool();
		      final IdleManager idleManager = new IdleManager(session, es);
		      try 
			    {
		      store = session.getStore(connectDto.getProtocol());
		      store.connect(connectDto.getHost(),connectDto.getUsername(),connectDto.getPassword());
		      //System.out.println("insid3");
			    }catch (Exception e) {
					e.printStackTrace();
				}

//		      Folder[] f = store.getDefaultFolder().list();
//		      for(Folder fd:f){
//		          Folder t[]=fd.list();
//
//		            System.out.println("-------"+fd.getName()+"------");
//		          for(Folder f1:t)
//		              System.out.println("->"+f1.getName());
//
//		      }
		      SortTerm[] termos = new SortTerm[1];
	            termos[0] = SortTerm.ARRIVAL;
		      folder = (IMAPFolder) store.getFolder(connectDto.getFolder()); 
	          

		      if(!folder.isOpen())
		      folder.open(Folder.READ_WRITE);

		      folder.addMessageCountListener(new MessageCountAdapter() {
		          public void messagesAdded(MessageCountEvent ev) {
		              Folder folder = (Folder)ev.getSource();
		              //Message[] msgs = ev.getMessages();
		              Message[] msgs=null;
					try {
						msgs = folder.search(
							        new FlagTerm(new Flags(Flags.Flag.SEEN), false));
						
					} catch (MessagingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
		              System.out.println("Folder: " + folder +
		                  " got " + msgs.length + " new messages");
		              try {
		                  // process new messages
		                  idleManager.watch(folder); // keep watching for new messages
		              } catch (MessagingException mex) {
		                  // handle exception related to the Folder
		              }
		          }
		      });
		      idleManager.watch(folder);
		      UIDFolder uf = (UIDFolder)folder;
		      ReceivedDateTerm term  = new ReceivedDateTerm(ComparisonTerm.EQ,connectDto.getMailDate());

		       messages = folder.search(term);
		      //messages = folder.getMessages();
//		      System.out.println("No of Messages : " + folder.getMessageCount());
//		      System.out.println("No of Unread Messages : " + folder.getUnreadMessageCount());
//		      System.out.println(messages.length);
//
//
		     //Message msg4 =folder.getMessageByUID(2775);
		     //System.out.println(msg4.getSubject());
		      for (int i=messages.length-1; i >=0;i--) 
		      {
		    	  String result = "";  
		        Message msg =messages[i];
	            MailDto dto=new MailDto();
	            dto.setMailType(connectDto.getMailType());
	            //System.out.println(msg.getSubject());sdf.format(new Date()))
	            dto.setMessageId(uf.getUID(msg));
		        dto.setSubject(msg.getSubject());
		        dto.setAttachment(downloadAttachments(msg,connectDto.getPath(),dto.getMessageId(),dto.getMailType()));
		        //jakarta.mail.internet.MimeMultipart msger=(jakarta.mail.internet.MimeMultipart)msg.getContent();
		        dto.setRecievedDate(msg.getReceivedDate());
		        dto.setAddressFrom(msg.getFrom());
		        dto.setAddressRecieptant(msg.getAllRecipients());
//		        Collections.list(msg.getAllHeaders()).forEach(obj->{ if (obj.getName().equals("Date")) { 
//		        	SimpleDateFormat sdf =new  SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss Z");
//		        			//sdf.setTimeZone(TimeZone.getTimeZone("GMT+5:30"));
//		        	try {
//						System.out.println(sdf.format(msg.getReceivedDate()));
//					} catch (MessagingException e1) {
//						// TODO Auto-generated catch block
//						e1.printStackTrace();
//					}
//		        	try {
//		        		
//						System.out.println(sdf.parse(obj.getValue().toString().substring(0, 31)));
//					} catch (ParseException e) {
//						// TODO Auto-generated catch block
//						e.printStackTrace();
//					}
//		        	
//		        } });  
//   	            Iterator<Header> it = msg.getAllHeaders().asIterator();
//		        while(it.hasNext()) {
//		        	System.out.println(it.next().getName());
//		        	}
//		        Iterator<Header> it2 = msg.getAllHeaders().asIterator();
//		        while(it2.hasNext()) {
//		        	  System.out.println(it2.next().getValue());
//		        	}
		        //System.out.println(msg.getContentType());
	            if (msg.isMimeType("text/plain")){
	            	//System.out.println("plain");
	    	        dto.setContent(msg.getContent().toString());
	            }else if (msg.isMimeType("multipart/*")) {

	              
	                MimeMultipart mimeMultipart = (MimeMultipart)msg.getContent();
	            	//System.out.println("part"+mimeMultipart.getContentType());
	                int count = mimeMultipart.getCount();
	                for (int j = 0; j < count; j ++){
	                    BodyPart bodyPart = mimeMultipart.getBodyPart(j);
	                    if (bodyPart.isMimeType("text/plain")){
	                    	//System.out.println("plainm");
	                        result = result + "\n" + bodyPart.getContent();
	                        break;  //without break same text appears twice in my tests
	                    } else if (bodyPart.isMimeType("text/html")){
	                    	//System.out.println("html");
	                        String html = (String) bodyPart.getContent();
	                        //result = result + "\n" + Jsoup.parse(html).text();
                            result=html;  
	                    }else if (bodyPart.getContent() instanceof MimeMultipart){
	                        result = result + getTextFromMimeMultipart((MimeMultipart)bodyPart.getContent());
	                    }
	                }
	    	        dto.setContent(result);
	            }else if(msg.isMimeType("text/html")) {
	            	 String html = (String) msg.getContent();
                     //result = result + "\n" + Jsoup.parse(html).text();
                     dto.setContent(html);
	            }
	            mailAll.add(dto);
		       


		      }
		     
		    }
		    catch (Exception e) {
				e.printStackTrace();
			}
		    finally 
		    {
		      if (folder != null && folder.isOpen()) { folder.close(true); }
		      if (store != null) { store.close(); }
		    }
		    return mailAll;
	}
	
	
	public List<String> downloadAttachments(Message message,String path,long uid,String type) throws IOException, MessagingException {
	    List<String> downloadedAttachments = new ArrayList<String>();
	    try {
	    Multipart multiPart = (Multipart) message.getContent();
	    int numberOfParts = multiPart.getCount();
	    for (int partCount = 0; partCount < numberOfParts; partCount++) {
	        MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
	        if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) {
	            String file =type+"_"+uid+"_"+part.getFileName();
	            part.saveFile(path+"\\"+ File.separator +type+"_"+uid+"_"+part.getFileName());
	            downloadedAttachments.add(file);
	        }
	    }
	    }
	    catch (Exception e) {
			// TODO: handle exception
		}
	    return downloadedAttachments;
	}
	
	
	
	private String getTextFromMimeMultipart(
	        MimeMultipart mimeMultipart)  throws MessagingException, IOException{
	    String result = "";
	    int count = mimeMultipart.getCount();
	    for (int i = 0; i < count; i++) {
	        BodyPart bodyPart = mimeMultipart.getBodyPart(i);
	        if (bodyPart.isMimeType("text/plain")) {
	            result = result + "\n" + bodyPart.getContent();
	            break; // without break same text appears twice in my tests
	        } else if (bodyPart.isMimeType("text/html")) {
	            String html = (String) bodyPart.getContent();
	           // result = result + "\n" + Jsoup.parse(html).text();
	            result=html;
	        } else if (bodyPart.getContent() instanceof MimeMultipart){
	        	
	            result = result + getTextFromMimeMultipart((MimeMultipart)bodyPart.getContent());
	        }
	    }
	    return result;
	}
	
	
	public String mailById(MailConnectDto connectDto) throws MessagingException, IOException 
	{
	    //System.out.println("insid5");
	    IMAPFolder folder = null;
	    Store store = null;
	    String subject = null;
	    Flag flag = null;
	    String result = "";  
	    List<MailDto> mailAll=new ArrayList<MailDto>();
	    //System.out.println("insidi");
	    try 
	    {
	      Properties props = System.getProperties();
	      props.setProperty("mail.store.protocol", connectDto.getProtocol() );
	      props.setProperty("mail."+connectDto.getProtocol()+".usesocketchannels", "true");
	      props.setProperty("mail."+connectDto.getProtocol()+".port",connectDto.getPort());
	      props.setProperty("mail."+connectDto.getProtocol()+".ssl.trust",connectDto.getHost());
	      props.setProperty("mail."+connectDto.getProtocol()+".timeout", "10000");
	      Session session = Session.getDefaultInstance(props, null);
          //System.out.println("insidi2");
	      ExecutorService es = Executors.newCachedThreadPool();
	      final IdleManager idleManager = new IdleManager(session, es);
	      try 
		    {
	      store = session.getStore(connectDto.getProtocol());
	      store.connect(connectDto.getHost(),connectDto.getUsername(),connectDto.getPassword());
	      //System.out.println("insid3");
		    }catch (Exception e) {
				e.printStackTrace();
			}
	      SortTerm[] termos = new SortTerm[1];
            termos[0] = SortTerm.ARRIVAL;
	      folder = (IMAPFolder) store.getFolder(connectDto.getFolder()); 
	     

	      if(!folder.isOpen())
	      folder.open(Folder.READ_WRITE);

	      folder.addMessageCountListener(new MessageCountAdapter() {
	          public void messagesAdded(MessageCountEvent ev) {
	              Folder folder = (Folder)ev.getSource();
	              //Message[] msgs = ev.getMessages();
	              Message[] msgs=null;
	              try {
	                  // process new messages
	                  idleManager.watch(folder); // keep watching for new messages
	              } catch (MessagingException mex) {
	                  // handle exception related to the Folder
	              }
	          }
	      });
	      idleManager.watch(folder);
	      Message msg=folder.getMessageByUID(Long.parseLong(connectDto.getMailType()));
	     //System.out.println(msg4.getSubject());
	    	 
            if (msg.isMimeType("text/plain")){
            	//System.out.println("plain");
            	  return msg.getContent().toString();
            }else if (msg.isMimeType("multipart/*")) {

              
                MimeMultipart mimeMultipart = (MimeMultipart)msg.getContent();
            	//System.out.println("part"+mimeMultipart.getContentType());
                int count = mimeMultipart.getCount();
                for (int j = 0; j < count; j ++){
                    BodyPart bodyPart = mimeMultipart.getBodyPart(j);
                    if (bodyPart.isMimeType("text/plain")){
                    	//System.out.println("plainm");
                        result = result + "\n" + bodyPart.getContent();
                        break;  //without break same text appears twice in my tests
                    } else if (bodyPart.isMimeType("text/html")){
                    	//System.out.println("html");
                        String html = (String) bodyPart.getContent();
                        //result = result + "\n" + Jsoup.parse(html).text();
                        result=html;  
                    }else if (bodyPart.getContent() instanceof MimeMultipart){
                        result = result + getTextFromMimeMultipart((MimeMultipart)bodyPart.getContent());
                    }
                }
                return result;
            }else if(msg.isMimeType("text/html")) {
            	 String html = (String) msg.getContent();
                 //result = result + "\n" + Jsoup.parse(html).text();
                 return html;
            }

	     
	    }
	    catch (Exception e) {
			e.printStackTrace();
		}
	    finally 
	    {
	      if (folder != null && folder.isOpen()) { folder.close(true); }
	      if (store != null) { store.close(); }
	    }
	    return result;
}

}
