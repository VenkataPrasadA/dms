package com.vts.dms.controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicInteger;

import javax.mail.AuthenticationFailedException;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.core.task.TaskExecutor;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Controller;

import com.vts.dms.DateTimeFormatUtil;
import com.vts.dms.dak.dto.EmailDto;
import com.vts.dms.dto.MailConfigurationDto;
import com.vts.dms.service.DmsService;


@EnableScheduling
@Controller
public class CustomJavaMailSender  {
	private static final Logger logger=LogManager.getLogger(CustomJavaMailSender.class);

	    @Autowired
	    DmsService service;

	    @Autowired
	    private Environment env;
	    
        ////TaskExecutor is an interface in Spring that provides an abstraction for executing tasks asynchronously
	    // Inject a TaskExecutor for asynchronous execution
        @Autowired
        private TaskExecutor taskExecutor; 
     
        public int sendUrgentDakEmail1(String[] emails,String subject, String msg, boolean isHtml) {
            // Call setEmailPassword to set the ValidPassword
      	    String typeOfHost = "L";
    		MailConfigurationDto mailAuthentication;
    		try {
    			mailAuthentication = service.getMailConfigByTypeOfHost(typeOfHost);
    		} catch (Exception e1) {
    			e1.printStackTrace();
    			return (Integer) null;
    		}

    		
    		  if (mailAuthentication == null) {
    		      // Handle the case where mail configuration for the specified typeOfHost is not found
    			  System.out.println("ERRROR -3 ERROR MOT CAUGHTTTTT");
    		      return-3; // You can choose an appropriate error code
    		  }else {

    	    		 System.out.println("URGENTDAKKKSEND @@@@@@@@@@@@@@@@@@@@@@@");
    				 System.out.println("spring.mail.host "+mailAuthentication.getHost());
    				 System.out.println("spring.mail.port "+mailAuthentication.getPort());
    				 System.out.println("spring.mail.username "+mailAuthentication.getUsername());
    				 System.out.println("spring.mail.password "+mailAuthentication.getPassword());
          
    				  JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

    				    // Set mail configuration from the database
    				    mailSender.setHost(mailAuthentication.getHost().toString());
    				    mailSender.setPort(Integer.parseInt(mailAuthentication.getPort().toString()));
    				    mailSender.setUsername(mailAuthentication.getUsername().toString());
    				    mailSender.setPassword(mailAuthentication.getPassword().toString());

    				    Properties properties = System.getProperties();
    					// Setup mail server
    					properties.setProperty("mail.smtp.host", mailSender.getHost());
    					//properties.put("mail.smtp.starttls.enable", "true");
    					// SSL Port
    					properties.put("mail.smtp.port", mailSender.getPort());
    					// enable authentication
    					properties.put("mail.smtp.auth", "true");
    					// SSL Factory
    					properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    				    
    					//properties.put("mail.smtp.starttls.enable", "true");

    				    Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
    						// override the getPasswordAuthentication
    						// method
    						protected PasswordAuthentication getPasswordAuthentication() {
    							return new PasswordAuthentication(mailSender.getUsername(), mailSender.getPassword());
    						}
    					});
    				    int mailSendresult = 0;
    				    try {
    				    	MimeMessage message = new MimeMessage(session);
    						// header field of the header.
    						message.setFrom(new InternetAddress(mailSender.getUsername()));
    						
    						// Adding recipients
    			            InternetAddress[] recipientAddresses = new InternetAddress[emails.length];
    			            for (int i = 0; i < emails.length; i++) {
    			                recipientAddresses[i] = new InternetAddress(emails[i]);
    			            }
    			            message.addRecipients(Message.RecipientType.TO, recipientAddresses);
    						message.setSubject(subject);
    						message.setText(msg);
    						message.setContent(msg, "text/html");// this code is used to make the message in HTML formatting
    						// Send message
    						Transport.send(message);
    						System.out.println("Message Sent");
    						mailSendresult++;
    						
    		        // If the email is sent successfully, complete the CompletableFuture with 1
    		        System.out.println("LAB SUCCESS SENDING URGENT MAIL ");
    		        return mailSendresult;
    		    } catch (AuthenticationFailedException e) {
    		        // Handle authentication failure (wrong password) and complete the CompletableFuture with -2
    		        e.printStackTrace();
    		        System.out.println("ERORRRR -2");
    		         mailSendresult=-2;
    		         return mailSendresult;
    		    } catch (MessagingException e) {
    		        // Handle other email sending exceptions and complete the CompletableFuture with -1
    		        e.printStackTrace();
    		        System.out.println("ERORR -1");
    		        mailSendresult= -1;
    		        return mailSendresult;
    		    }
    				    
    		  }
    		  
        }
        
        
        public int sendUrgentDakEmail2(String[] Dronaemails,String subject, String msg, boolean isHtml) {
            // Call setEmailPassword to set the ValidPassword
      	    String typeOfHost = "D";
    		MailConfigurationDto mailAuthentication;
    		try {
    			mailAuthentication = service.getMailConfigByTypeOfHost(typeOfHost);
    		} catch (Exception e1) {
    			e1.printStackTrace();
    			return (Integer) null;
    		}

    		
    		  if (mailAuthentication == null) {
    		      // Handle the case where mail configuration for the specified typeOfHost is not found
    			  System.out.println("ERRROR -3 ERROR MOT CAUGHTTTTT");
    		      return-3; // You can choose an appropriate error code
    		  }else {

    	    		 System.out.println("URGENTDAKKKSEND @@@@@@@@@@@@@@@@@@@@@@@");
    				 System.out.println("spring.mail.host "+mailAuthentication.getHost());
    				 System.out.println("spring.mail.port "+mailAuthentication.getPort());
    				 System.out.println("spring.mail.username "+mailAuthentication.getUsername());
    				 System.out.println("spring.mail.password "+mailAuthentication.getPassword());
          
    				  JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

    				    // Set mail configuration from the database
    				    mailSender.setHost(mailAuthentication.getHost().toString());
    				    mailSender.setPort(Integer.parseInt(mailAuthentication.getPort().toString()));
    				    mailSender.setUsername(mailAuthentication.getUsername().toString());
    				    mailSender.setPassword(mailAuthentication.getPassword().toString());

    				    Properties properties = System.getProperties();
    					// Setup mail server
    					properties.setProperty("mail.smtp.host", mailSender.getHost());
    					//properties.put("mail.smtp.starttls.enable", "true");
    					// SSL Port
    					properties.put("mail.smtp.port", mailSender.getPort());
    					// enable authentication
    					properties.put("mail.smtp.auth", "true");
    					// SSL Factory
    					//properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    				    
    					properties.put("mail.smtp.starttls.enable", "true");

    				    Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
    						// override the getPasswordAuthentication
    						// method
    						protected PasswordAuthentication getPasswordAuthentication() {
    							return new PasswordAuthentication(mailSender.getUsername(), mailSender.getPassword());
    						}
    					});
    				    int mailSendresult = 0;
    				    try {
    				    	MimeMessage message = new MimeMessage(session);
    						// header field of the header.
    						message.setFrom(new InternetAddress(mailSender.getUsername()));
    						
    						// Adding recipients
    			            InternetAddress[] recipientAddresses = new InternetAddress[Dronaemails.length];
    			            for (int i = 0; i < Dronaemails.length; i++) {
    			                recipientAddresses[i] = new InternetAddress(Dronaemails[i]);
    			            }
    			            message.addRecipients(Message.RecipientType.TO, recipientAddresses);
    						message.setSubject(subject);
    						message.setText(msg);
    						message.setContent(msg, "text/html");// this code is used to make the message in HTML formatting
    						// Send message
    						mailSender.send(message);
    						System.out.println("Message Sent");
    						mailSendresult++;
    						
    		        // If the email is sent successfully, complete the CompletableFuture with 1
    		        System.out.println("DRONA SUCCESS SENDING URGENT MAIL ");
    		        return mailSendresult;
    		    } catch (AuthenticationFailedException e) {
    		        // Handle authentication failure (wrong password) and complete the CompletableFuture with -2
    		        e.printStackTrace();
    		        System.out.println("ERORRRR -2");
    		         mailSendresult=-2;
    		         return mailSendresult;
    		    } catch (MessagingException e) {
    		        // Handle other email sending exceptions and complete the CompletableFuture with -1
    		        e.printStackTrace();
    		        System.out.println("ERORR -1");
    		        mailSendresult= -1;
    		        return mailSendresult;
    		    }
    				    
    		  }
    		  
        }
      
 
    @Async
    public CompletableFuture<Integer> sendScheduledEmailAsync1(String email, String subject, String msg, boolean isHtml) {

        String typeOfHost = "L";
		MailConfigurationDto mailAuthentication;
		try {
			mailAuthentication = service.getMailConfigByTypeOfHost(typeOfHost);
		} catch (Exception e1) {
			e1.printStackTrace();
			return null;
		}
		  if (mailAuthentication == null) {
		      // Handle the case where mail configuration for the specified typeOfHost is not found
			  System.out.println("ERRROR -3 ");
		      return CompletableFuture.completedFuture(-3); // You can choose an appropriate error code
		  }else {

				 System.out.println("spring.mail.host "+mailAuthentication.getHost());
				 System.out.println("spring.mail.port "+mailAuthentication.getPort());
				 System.out.println("spring.mail.username "+mailAuthentication.getUsername());
				 System.out.println("spring.mail.password "+mailAuthentication.getPassword());
      
		  JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

		    // Set mail configuration from the database
		    mailSender.setHost(mailAuthentication.getHost().toString());
		    mailSender.setPort(Integer.parseInt(mailAuthentication.getPort().toString()));
		    mailSender.setUsername(mailAuthentication.getUsername().toString());
		    mailSender.setPassword(mailAuthentication.getPassword().toString());

		    Properties properties = System.getProperties();
			// Setup mail server
			properties.setProperty("mail.smtp.host", mailSender.getHost());
			properties.put("mail.smtp.starttls.enable", "true");
			// SSL Port
			properties.put("mail.smtp.port", mailSender.getPort());
			// enable authentication
			properties.put("mail.smtp.auth", "true");
			// SSL Factory
			properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		    
			//properties.put("mail.smtp.starttls.enable", "true");

		    Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
				// override the getPasswordAuthentication
				// method
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(mailSender.getUsername(), mailSender.getPassword());
				}
			});
		    int mailSendresult = 0;

		    try {
		    	MimeMessage message = new MimeMessage(session);
				// header field of the header.
				message.setFrom(new InternetAddress(mailSender.getUsername()));
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
	           // message.addRecipient(Message.RecipientType.TO, new InternetAddress(DronaEmail));
				message.setSubject(subject);
				message.setText(msg);
				message.setContent(msg, "text/html");// this code is used to make the message in HTML formatting
				// Send message
				Transport.send(message);
				System.out.println("Lab Mail Message Sent");
				mailSendresult++;
		    } catch (AuthenticationFailedException e) {
		        // Handle authentication failure (wrong password) and complete the CompletableFuture with -2
		        e.printStackTrace();
		        System.out.println("ERORRRR -2");
		        return CompletableFuture.completedFuture(-2);
		    } catch (MessagingException e) {
		        // Handle other email sending exceptions and complete the CompletableFuture with -1
		        e.printStackTrace();
		        System.out.println("ERORRRR -1");
		        return CompletableFuture.completedFuture(-1);
		    }
		    return CompletableFuture.completedFuture(mailSendresult);
		  }
    }

    
    
    
    @Async
    public CompletableFuture<Integer> sendScheduledEmailAsync2(String DronaEmail, String subject, String msg, boolean isHtml) {

        String typeOfHost = "D";
		MailConfigurationDto mailAuthentication;
		try {
			mailAuthentication = service.getMailConfigByTypeOfHost(typeOfHost);
		} catch (Exception e1) {
			e1.printStackTrace();
			return null;
		}
		  if (mailAuthentication == null) {
		      // Handle the case where mail configuration for the specified typeOfHost is not found
			  System.out.println("ERRROR -3 ");
		      return CompletableFuture.completedFuture(-3); // You can choose an appropriate error code
		  }else {

				 System.out.println("spring.mail.host "+mailAuthentication.getHost());
				 System.out.println("spring.mail.port "+mailAuthentication.getPort());
				 System.out.println("spring.mail.username "+mailAuthentication.getUsername());
				 System.out.println("spring.mail.password "+mailAuthentication.getPassword());
      
		  JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

		    // Set mail configuration from the database
		    mailSender.setHost(mailAuthentication.getHost().toString());
		    mailSender.setPort(Integer.parseInt(mailAuthentication.getPort().toString()));
		    mailSender.setUsername(mailAuthentication.getUsername().toString());
		    mailSender.setPassword(mailAuthentication.getPassword().toString());

		    Properties properties = System.getProperties();
			// Setup mail server
			properties.setProperty("mail.smtp.host", mailSender.getHost());
			//properties.put("mail.smtp.starttls.enable", "true");
			// SSL Port
			properties.put("mail.smtp.port", mailSender.getPort());
			// enable authentication
			properties.put("mail.smtp.auth", "true");
			// SSL Factory
			//properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		    
			properties.put("mail.smtp.starttls.enable", "true");

		    Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
				// override the getPasswordAuthentication
				// method
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(mailSender.getUsername(), mailSender.getPassword());
				}
			});
		    int mailSendresult = 0;

		    try {
		    	MimeMessage message = new MimeMessage(session);
				// header field of the header.
				message.setFrom(new InternetAddress(mailSender.getUsername()));
	           // message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(DronaEmail));
				message.setSubject(subject);
				message.setText(msg);
				message.setContent(msg, "text/html");// this code is used to make the message in HTML formatting
				// Send message
				mailSender.send(message);
				System.out.println("Drona Mail Message Sent");
				mailSendresult++;
		    } catch (AuthenticationFailedException e) {
		        // Handle authentication failure (wrong password) and complete the CompletableFuture with -2
		        e.printStackTrace();
		        System.out.println("ERORRRR -2");
		        return CompletableFuture.completedFuture(-2);
		    } catch (MessagingException e) {
		        // Handle other email sending exceptions and complete the CompletableFuture with -1
		        e.printStackTrace();
		        System.out.println("ERORRRR -1");
		        return CompletableFuture.completedFuture(-1);
		    }
		    return CompletableFuture.completedFuture(mailSendresult);
		  }
    }

  //0 in the first  position represents the seconds field and indicates the task should start at 0 seconds.
  //0 in the second position represents the minutes field, indicating that the task should start at 0 minutes.
  //10 in the third position represents the hours field, specifying that the task should run at 10 AM.
  //? in the fourth position represents "no specific day of the month" since you want it to run every week.
  //MON in the fifth position represents Monday as the specific day of the week.   


    
////////////////////////////////////////////DAILY PENDING REPLY EMAILS TRIGGERED DAILY AT THE BEGINING OF THE DAY BASED ON PENDING REPLYS //////////////////////////////////////////
//The purpose of the below code is to send daily pending reply reports to employees, grouped by their EmpId. The emails contain information about pending tasks (DAKNos and Sources) that are specific to each employee. The code optimally groups the data by EmpId, reduces the number of emails sent to the same recipient, and provides a clear, tabular format for the information.
  
    
 //@Scheduled(cron = "0 30 7 * * ?")
  public void myDailyPendingScheduledMailTask() {
    logger.info(new Date() + " Inside CONTROLLER myDailyPendingScheduledMailTask ");
    try {
        long MailTrackingId = 0;
        long MailTrackingInsightsId = 0;
        // Create an AtomicInteger for thread-safe success count updates
        
        AtomicInteger mailSendSuccessCount = new AtomicInteger(0);

        long DailyPendingMailSendInitiation = service.GetMailInitiatedCount("D");
        System.out.println("DailyPendingMailSendInitiation RESULTTTT" + DailyPendingMailSendInitiation);
        
        if (DailyPendingMailSendInitiation == 0) {
        	MailTrackingId = service.InsertMailTrackInitiator("D");
        	
        }
        
        final long effectivelyFinalMailTrackingId = MailTrackingId;

          //the list of daily pending reply details
            List<Object[]> PendingReplyEmpsDetailstoSendMail = service.GetDailyPendingReplyEmpData();
           if (MailTrackingId > 0 && PendingReplyEmpsDetailstoSendMail != null && PendingReplyEmpsDetailstoSendMail.size() > 0) {
            	   System.out.println("PendingReplyEmpsDetailstoSendMail details " + PendingReplyEmpsDetailstoSendMail.size()+" And MailTrackingId is : "+effectivelyFinalMailTrackingId);

            	   
            	   MailTrackingInsightsId = service.InsertDailyPendingInsights(MailTrackingId);
            	   System.out.println("And MailTrackingInsightsId is : "+MailTrackingInsightsId);
            	   
            	   if(MailTrackingInsightsId > 0) {
                
                          // Create a map to store unique EmpId, emails, DakNos, and Sources
                           Map<Object, EmailDto> empToDataMap = new HashMap<>();
    
                          //iterate over the PendingReplyEmpsDetailstoSendMail and constructs a map empToDataMa) to group information by unique EmpId.
                          //It collects the email addresses, DakNos, and Sources for each EmpId.  
                
                         for (Object[] obj : PendingReplyEmpsDetailstoSendMail) {
                    
                	         Object empId = obj[1];
                             Object dakNo = obj[4];
                             Object source = obj[5];
                             Object dueDate = obj[6];
                             String email = null;
                             String DronalEmail=null;
                             if(obj[3] != null && !obj[3].toString().trim().isEmpty()) {
                    	            email = obj[3].toString();
                    	     }
                             
                             if(obj[8] != null && !obj[8].toString().trim().isEmpty()) {
                            	 DronalEmail = obj[8].toString();
                 	         }

                             if (empId != null && email != null && !email.isEmpty()) {
                                 if (!empToDataMap.containsKey(empId)) {
                        	     System.out.println("%%%%%%%%%%%%%%%email Data" +email);
                                 empToDataMap.put(empId, new EmailDto(email,DronalEmail));
                             }

                             if (dakNo != null && !dakNo.toString().isEmpty()) {
                                  empToDataMap.get(empId).addDakAndSourceAndDueDate(dakNo.toString(), source.toString(), dueDate.toString());
                              }
                            }
                             
                        }

          
                   // Iterate over the map and sends an email to each unique EmpId
                     //It creates an HTML table in the email body to display the DakNos and Sources related to each EmpId
              
                      // After building the empToDataMap, iterate over it to send emails
                     for (Map.Entry<Object, EmailDto> mailMapData : empToDataMap.entrySet()) {
                       Object empId = mailMapData.getKey();
                       EmailDto emailData = mailMapData.getValue();
                       String email = emailData.getEmail();
                       String DronaEmail=emailData.getDronaEmail();
                        String dakCount;
                        String word;
                        int size = emailData.getDakAndSourceAndDueDateList().size();
                          if(size>1) {
                    	     dakCount = size+" DAKs";
                    	     word ="replies";
                          }else {
                    	     dakCount = size+" DAK";
                    	     word ="reply";
                          }
        
                          if (email != null) {
                               // Create and format the email content
                               String currentDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
                               String subject = "Daily Pending Replies Report - " + currentDate;
                               String message = "<p>Dear Sir/Madam,</p>";
                                      message += "<p></p>";
                                      message += "<p>This email is to inform you that you have " +dakCount + " with actions due today, awaiting your "+word+" to ensure timely completion.</p>";
                                      //The timely completion of these tasks is crucial for our project's progress, so please prioritize them and ensure that your responses are provided as soon as possible.
                                      message += "<p>This is for your information, please take the action.</p>";
                                      // Generate the HTML table for DakNos and Sources
                                      message += "<table style=\"align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse: collapse;\">";
                                      message += "<thead>";
                                      message += "<tr>";
                                      message += "<th style=\"text-align: center; width: 500px; border: 1px solid black; padding: 5px; padding-left: 15px\">DAK No</th>";
                                      message += "<th style=\"text-align: center; width: 200px; border: 1px solid black; padding: 5px; padding-left: 15px\">Source</th>";
                                      message += "</tr>";
                                      message += "</thead>";
                                      message += "<tbody>";
                                    for (Object[] dakAndSource : emailData.getDakAndSourceAndDueDateList()) {
                                      message += "<tr>";
                                      message += "<td style=\"border: 1px solid black; padding: 5px; text-align: left\">" + dakAndSource[0] + "</td>";
                                      message += "<td style=\"border: 1px solid black; padding: 5px; text-align: center\">" + dakAndSource[1] + "</td>";
                                      message += "</tr>";
                                    }
                                      message += "</tbody>";
                                      message += "</table>";
                                      message += "Please <a href=\"" + env.getProperty("Login_link") + "\">Click Here</a> to Go DMS.<br>";
                                      message += "<p>Important Note: This is an automated message. Kindly avoid responding.</p>";
                                      message += "<p>Regards,<br>LRDE-DMS Team</p>";
                                      System.out.println("dakAndSourceList sizeeeeeeeeeeeeee@@@@@@#$$"+size+"for empiddddd :"+empId+"for email  :"+email);
                           
                                     // Send the email asynchronously within the loop
                                     CompletableFuture<Integer> sendResult1 = sendScheduledEmailAsync1(email,subject, message, true);
                                     CompletableFuture<Integer> sendResult2 = sendScheduledEmailAsync2(DronaEmail, subject, message, true);

                        // Chain actions once the email sending is complete
                             sendResult1.thenApply(result -> {
                                 if (result == 1) {
                                       // Successfully sent
                                       service.UpdateParticularEmpMailStatus("D", "S", Long.parseLong(empId.toString()), effectivelyFinalMailTrackingId);
                                       System.out.println("success");
                                        mailSendSuccessCount.incrementAndGet(); // Increment success count atomically
                                } else {
                                      // Failed to send
                                      service.UpdateParticularEmpMailStatus("D", "N", Long.parseLong(empId.toString()), effectivelyFinalMailTrackingId);
                                      System.out.println("failure");
                                }
                                 return result; // Pass the result along
                              });
                    }
                }
                // After the loop, update the count in your table with the success count
                // You can call a service method to perform the update
                // Wait for all asynchronous email tasks to complete
                CompletableFuture<Void> allOf = CompletableFuture.allOf(/* List of CompletableFuture objects */);
                allOf.join(); // This ensures all tasks have completed

                System.out.println("Total Successful Emails: " + mailSendSuccessCount.get());
                service.updateMailSuccessCount(MailTrackingId, mailSendSuccessCount.get(), "D");
            
          }   
            	   
         // if No EmpId is found to send daily message
           } else {
                service.UpdateNoPendingReply("D");
            }
        
    } catch (Exception e) {
        e.printStackTrace();
        logger.error(new Date() + " Inside CONTROLLER myDailyPendingScheduledMailTask " + e);
    }
}
    
 
 
////////////////////////////////////////////DAILY DISTRIBUTING MESSAGE REPLY EMAILS TRIGGERED DAILY AT THE END OF THE DAY BASED ON DISTRIBUTED DATE //////////////////////////////////////////
//The purpose of the below code is to send daily pending reply reports to employees, grouped by their EmpId. The emails contain information about pending tasks (DAKNos and Sources) that are specific to each employee. The code optimally groups the data by EmpId, reduces the number of emails sent to the same recipient, and provides a clear, tabular format for the information.


 // @Scheduled(cron = "0 0 16 * * ?")
    public void mySummaryDistributedMailTask() {
      logger.info(new Date() + " Inside CONTROLLER mySummaryDistributedMailTask ");
      try {
         long MailTrackingId = 0;
         long MailTrackingInsightsId = 0;
         //Create an AtomicInteger for thread-safe success count updates
         AtomicInteger mailSendSuccessCount = new AtomicInteger(0);

         long SummaryMailSendInitiation = service.GetMailInitiatedCount("S");
         System.out.println("SummaryMailSendInitiation RESULTTTT" + SummaryMailSendInitiation);
         
         if (SummaryMailSendInitiation == 0) {
         	MailTrackingId = service.InsertMailTrackInitiator("S");
         }
         final long effectivelyFinalMailTrackingId = MailTrackingId;
         
         //the list of daily distributed details
         List<Object[]> DailyDistributedSummarytoSendMail = service.GetSummaryDistributedEmpData();
        if (MailTrackingId > 0 && DailyDistributedSummarytoSendMail != null && DailyDistributedSummarytoSendMail.size() > 0) {
         	   System.out.println("DailyDistributedSummarytoSendMail details " + DailyDistributedSummarytoSendMail.size()+" And MailTrackingId is : "+effectivelyFinalMailTrackingId);
         	   
         		MailTrackingInsightsId = service.InsertSummaryDistributedInsights(MailTrackingId);
                System.out.println("And MailTrackingInsightsId is : "+MailTrackingInsightsId);

                if(MailTrackingInsightsId > 0) {
                    
                    // Create a map to store unique EmpId, emails, DakNos, and Sources
                     Map<Object, EmailDto> empToDataMap = new HashMap<>();

                    //iterate over the DailyDistributedSummarytoSendMail and constructs a map empToDataMa) to group information by unique EmpId.
                    //It collects the email addresses, DakNos, and Sources for each EmpId.  
          
                   for (Object[] obj : DailyDistributedSummarytoSendMail) {
              
          	         Object empId = obj[1];
                       Object dakNo = obj[4];
                       Object source = obj[5];
                       String dueDate = null;
                       if(obj[6] != null && !obj[6].toString().trim().isEmpty()) {
                    	   SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
                    	   dueDate = rdf.format(obj[6]);
                       	  
                       }else {
                    	   dueDate ="NA";
                       }
                       String email = null;
                       String DronaEmail=null;
                       
                       if(obj[3] != null && !obj[3].toString().trim().isEmpty()) {
              	            email = obj[3].toString();
                       }
                       
                       if(obj[7] != null && !obj[7].toString().trim().isEmpty()) {
                    	   DronaEmail = obj[7].toString();
                      }

                       if (empId != null && email != null && !email.isEmpty()) {
                           if (!empToDataMap.containsKey(empId)) {
                  	     System.out.println("%%%%%%%%%%%%%%%email Data" +email);
                           empToDataMap.put(empId, new EmailDto(email,DronaEmail));
                       }

                       if (dakNo != null && !dakNo.toString().isEmpty()) {
                            empToDataMap.get(empId).addDakAndSourceAndDueDate(dakNo.toString(), source.toString(), dueDate.toString());
                        }
                      }
                  }

   
    
             // Iterate over the map and sends an email to each unique EmpId
               //It creates an HTML table in the email body to display the DakNos and Sources related to each EmpId
        
                // After building the empToDataMap, iterate over it to send emails
               for (Map.Entry<Object, EmailDto> mailMapData : empToDataMap.entrySet()) {
                 Object empId = mailMapData.getKey();
                 EmailDto emailData = mailMapData.getValue();
                 String email = emailData.getEmail();
                 String DronaEmail=emailData.getDronaEmail();
                  String dakCount;
                  
                  String word;
                  int size = emailData.getDakAndSourceAndDueDateList().size();
                    if(size>1) {
              	     dakCount = size+" DAKs";
              	     word ="replies";
                    }else {
              	     dakCount = size+" DAK";
              	     word ="reply";
                    }
  
                    if (email != null) {
                         // Create and format the email content
                         String currentDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
                         String subject = "Distributed Summary Report - " + currentDate;
                         String message = "<p>Dear Sir/Madam,</p>";
                                message += "<p></p>";
                                message += "<p>This email is to notify you that you have received " +dakCount + " today.This is for your information, please take the action.</p>";
                                // Generate the HTML table for DakNos and Sources
                                message += "<table style=\"align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse: collapse;\">";
                                message += "<thead>";
                                message += "<tr>";
                                message += "<th style=\"text-align: center; width: 400px; border: 1px solid black; padding: 5px; padding-left: 15px\">DAK No</th>";
                                message += "<th style=\"text-align: center; width: 200px; border: 1px solid black; padding: 5px; padding-left: 15px\">Source</th>";
                                message += "<th style=\"text-align: center; width: 200px; border: 1px solid black; padding: 5px; padding-left: 15px\">Due Date</th>";
                                message += "</tr>";
                                message += "</thead>";
                                message += "<tbody>";
                             
                                for (Object[] dakAndSource : emailData.getDakAndSourceAndDueDateList()) {
                                  message += "<tr>";
                                  message += "<td style=\"border: 1px solid black; padding: 5px; text-align: left\">"   + dakAndSource[0] + "</td>";
                                  message += "<td style=\"border: 1px solid black; padding: 5px; text-align: center\">" + dakAndSource[1] + "</td>";
                                  message += "<td style=\"border: 1px solid black; padding: 5px; text-align: center\">" + dakAndSource[2] + "</td>";
                                  message += "</tr>";
                               }
                                message += "</tbody>";
                                message += "</table>";
                                message += "Please <a href=\"" + env.getProperty("Login_link") + "\">Click Here</a> to Go DMS.<br>";
                                message += "<p>Important Note: This is an automated message. Kindly avoid responding.</p>";
                                message += "<p>Regards,<br>LRDE-DMS Team</p>";
                                System.out.println("dakAndSourceList sizeeeeeeeeeeeeee@@@@@@#$$"+size+"for empiddddd :"+empId+"for email  :"+email);
                     
                               // Send the email asynchronously within the loop
                               CompletableFuture<Integer> sendResult1 = sendScheduledEmailAsync1(email,subject, message, true);
                               CompletableFuture<Integer> sendResult2 = sendScheduledEmailAsync2(DronaEmail, subject, message, true);


                  
                  // Chain actions once the email sending is complete
                       sendResult1.thenApply(result -> {
                           if (result == 1) {
                                 // Successfully sent
                                 service.UpdateParticularEmpMailStatus("S", "S", Long.parseLong(empId.toString()), effectivelyFinalMailTrackingId);
                                 System.out.println("success");
                                  mailSendSuccessCount.incrementAndGet(); // Increment success count atomically
                          } else {
                                // Failed to send
                                service.UpdateParticularEmpMailStatus("S", "N", Long.parseLong(empId.toString()), effectivelyFinalMailTrackingId);
                                System.out.println("failure");
                          }
                           return result; // Pass the result along
                        });
              }
          }
          // After the loop, update the count in your table with the success count
          // You can call a service method to perform the update
       // Wait for all asynchronous email tasks to complete
          CompletableFuture<Void> allOf = CompletableFuture.allOf(/* List of CompletableFuture objects */);
          allOf.join(); // This ensures all tasks have completed

          System.out.println("Total Successful Emails: " + mailSendSuccessCount.get());
          service.updateMailSuccessCount(MailTrackingId, mailSendSuccessCount.get(), "S");
      
    }   
                
                
         	   
             // if No EmpId is found to send daily message
        } else {
             service.UpdateNoPendingReply("S");
         }
         
         
         

         } catch (Exception e) {
           e.printStackTrace();
            logger.error(new Date() + " Inside CONTROLLER mySummaryDistributedMailTask " + e);
       }
 
   }

 
 
  
////////////////////////////////////////////EVERY WEEK MONDAY MORNING REPLY EMAILS TRIGGERED DAILY ONLY ONCE DATE SCHEDULED   //////////////////////////////////////////

	
    //@Scheduled(cron = "0 0 11 * * MON")// Runs at every week Monday morning by taking data from current Monday to current Sunday
   	public void myWeeklyScheduledMailTask() {
   	     
       	  logger.info(new Date() + " Inside CONTROLLER myWeeklyScheduledMailTask ");
             try {
            	
            	 
            	 long MailTrackingId = 0;
                 long MailTrackingInsightsId = 0;
                 // Create an AtomicInteger for thread-safe success count updates
                   AtomicInteger mailSendSuccessCount = new AtomicInteger(0);

                   long WeeklyMailSendInitiation = service.GetMailInitiatedCount("W");
                   System.out.println("WeeklyPendingMailSendInitiation RESULTTTT" + WeeklyMailSendInitiation);
                   
                   if (WeeklyMailSendInitiation == 0) {
                   	MailTrackingId = service.InsertMailTrackInitiator("W");
                   }
                   
                   final long effectivelyFinalMailTrackingId = MailTrackingId;

    
                       //the list of daily pending reply details
                       List<Object[]> PendingReplyEmpsDetailstoSendMail = service.GetWeeklyPendingReplyEmpData();
                      
                       if (MailTrackingId > 0 && PendingReplyEmpsDetailstoSendMail != null && PendingReplyEmpsDetailstoSendMail.size() > 0) {
                    		System.out.println("PendingReplyEmpsDetailstoSendMail details " + PendingReplyEmpsDetailstoSendMail.size()+" And MailTrackingId is : "+effectivelyFinalMailTrackingId);
                          	MailTrackingInsightsId = service.InsertWeeklyPendingInsights(MailTrackingId);
                          	System.out.println("And MailTrackingInsightsId is : "+MailTrackingInsightsId);
                            if (MailTrackingInsightsId>0) {
                       	 // Create a map to store unique EmpId, emails, DakNos, and Sources
                            Map<Object, EmailDto> empToDataMap = new HashMap<>();
               
                         //iterate over the PendingReplyEmpsDetailstoSendMail and constructs a map empToDataMa) to group information by unique EmpId.
                         //It collects the email addresses, DakNos, and Sources for each EmpId.  
                            
                           for (Object[] obj : PendingReplyEmpsDetailstoSendMail) {
                               
                           	   Object empId = obj[1];
                               Object dakNo = obj[4];
                               Object source = obj[5];
                               
                               			String dueDate = null;
			                            if(obj[6] != null && !obj[6].toString().trim().isEmpty()) {
			                            	 SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
			                            	 dueDate = rdf.format(obj[6]);
			                            }else {
			                            	   dueDate ="--";
			                            }
                               
		                               String email = null;
		                               String DronaEmail=null;
		                               if(obj[3] != null && !obj[3].toString().trim().isEmpty()) {
		                               	  email = obj[3].toString();
		                               }
                               
		                               if(obj[7] != null && !obj[7].toString().trim().isEmpty()) {
		                            	   DronaEmail = obj[7].toString();
		                               }
                               
		                               if (empId != null && email != null && !email.isEmpty()) {
		                                   if (!empToDataMap.containsKey(empId)) {
		                                   	System.out.println("%%%%%%%%%%%%%%%email Data" +email);
		                                       empToDataMap.put(empId, new EmailDto(email,DronaEmail));
		                               }

		                               if (dakNo != null && !dakNo.toString().isEmpty()) {
		                                   empToDataMap.get(empId).addDakAndSourceAndDueDate(dakNo.toString(), source.toString(),dueDate.toString());
		                               }
		                          }
                             }


                           // Iterate over the map and sends an email to each unique EmpId
                           //It creates an HTML table in the email body to display the DakNos and Sources related to each EmpId
                            
                           // After building the empToDataMap, iterate over it to send emails
                              for (Map.Entry<Object, EmailDto> mailMapData : empToDataMap.entrySet()) {
                                  Object empId = mailMapData.getKey();
                                  EmailDto emailData = mailMapData.getValue();
                                  String email = emailData.getEmail();
                                  String DronaEmail=emailData.getDronaEmail();
                                  String dakCount;
                                  String word;
                                  int size = emailData.getDakAndSourceAndDueDateList().size();
                                  if(size>1) {
                                  	dakCount = size+" DAKs";
                                  	word ="replies";
                                  }else {
                                  	dakCount = size+" DAK";
                                  	word ="reply";
                                  }
                      
                                  if (email != null) {
                                      // Create and format the email content
                                      String subject = "Weekly Pending Replies Report from " + DateTimeFormatUtil.getCurrentWeekMonday()+" to "+ DateTimeFormatUtil.getCurrentWeekSunday();
                                      String message = "<p>Dear Sir/Madam,</p>";
                                      message += "<p></p>";
                                      message += "<p>This email is to inform you that you have " +dakCount + " within due date ("+DateTimeFormatUtil.getCurrentWeekMonday()+" - "+DateTimeFormatUtil.getCurrentWeekSunday()+"), awaiting your "+word+" to ensure timely completion.</p>";
                                     //The timely completion of these tasks is crucial for our project's progress, so please prioritize them and ensure that your responses are provided as soon as possible.
                                      message += "<p>This is for your information, please take the action.</p>";

                                      // Generate the HTML table for DakNos and Sources
                                      message += "<table style=\"align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse: collapse;\">";
                                      message += "<thead>";
                                      message += "<tr>";
                                      message += "<th style=\"text-align: center; width: 500px; border: 1px solid black; padding: 5px; padding-left: 15px\">DAK No</th>";
                                      message += "<th style=\"text-align: center; width: 200px; border: 1px solid black; padding: 5px; padding-left: 15px\">Source</th>";
                                      message += "<th style=\"text-align: center; width: 200px; border: 1px solid black; padding: 5px; padding-left: 15px\">Due Date</th>";
                                      message += "</tr>";
                                      message += "</thead>";
                                      message += "<tbody>";

                                      for (Object[] dakAndSource : emailData.getDakAndSourceAndDueDateList()) {
                                          message += "<tr>";
                                          message += "<td style=\"border: 1px solid black; padding: 5px; text-align: left\">" + dakAndSource[0] + "</td>";
                                          message += "<td style=\"border: 1px solid black; padding: 5px; text-align: center\">" + dakAndSource[1] + "</td>";
                                          message += "<td style=\"border: 1px solid black; padding: 5px; text-align: center\">" + dakAndSource[2] + "</td>";
                                          message += "</tr>";
                                      }

                                      message += "</tbody>";
                                      message += "</table>";
                                      message += "Please <a href=\"" + env.getProperty("Login_link") + "\">Click Here</a> to Go DMS.<br>";
                                      message += "<p>Important Note: This is an automated message. Kindly avoid responding.</p>";
                                      message += "<p>Regards,<br>LRDE-DMS Team</p>";

                                      // Send the email using 'email' address and 'message' content
                                      System.out.println("dakAndSourceList sizeeeeeeeeeeeeee@@@@@@#$$"+size+"for empiddddd :"+empId+"for email  :"+email);
                                         
                                   // Send the email asynchronously within the loop
                                      // Send the email asynchronously within the loop
                                      CompletableFuture<Integer> sendResult1 = sendScheduledEmailAsync1(email,subject, message, true);
                                      CompletableFuture<Integer> sendResult2 = sendScheduledEmailAsync2(DronaEmail, subject, message, true);

                                     
//                                    if (sendResult.get() == 1) {
//                                    	service.UpdateParticularEmpMailStatus("D","S",Long.parseLong(empId.toString()),MailTrackingId);
//                                    	 System.out.println("Success");
//                                        MailSendSuccessCount++; // Increment success count for each successful email
//                                    }else {
//                                    	service.UpdateParticularEmpMailStatus("D","N",Long.parseLong(empId.toString()),MailTrackingId);
//                                    	 System.out.println("Fail");
//                                    }
                                      
                                      // Chain actions once the email sending is complete
                                      sendResult1.thenApply(result -> {
                                          if (result == 1) {
                                              // Successfully sent
                                              service.UpdateParticularEmpMailStatus("W", "S", Long.parseLong(empId.toString()), effectivelyFinalMailTrackingId);
                                              System.out.println("success");
                                              mailSendSuccessCount.incrementAndGet(); // Increment success count atomically
                                          } else {
                                              // Failed to send
                                              service.UpdateParticularEmpMailStatus("W", "N", Long.parseLong(empId.toString()), effectivelyFinalMailTrackingId);
                                              System.out.println("failure");
                                          }
                                          return result; // Pass the result along
                                      });
                                  }
                              }
                              // After the loop, update the count in your table with the success count
                              // You can call a service method to perform the update
                           // Wait for all asynchronous email tasks to complete
                              CompletableFuture<Void> allOf = CompletableFuture.allOf(/* List of CompletableFuture objects */);
                              allOf.join(); // This ensures all tasks have completed

                              System.out.println("Total Successful Emails: " + mailSendSuccessCount.get());
                              service.updateMailSuccessCount(MailTrackingId, mailSendSuccessCount.get(), "W");
                         
                       }
                       
                       } else {
                              service.UpdateNoPendingReply("D");
                          }
                      
                  } catch (Exception e) {
                      e.printStackTrace();
                      logger.error(new Date() + " Inside CONTROLLER myWeeklyScheduledMailTask " + e);
                  }
              }

    
/////////////////////////////////////URGENT MAIL SEND//////////////////////////////////////////////////////
    
    
   

   

}

