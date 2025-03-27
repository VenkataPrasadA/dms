package com.vts.dms.controller;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.client.RestTemplate;

import com.vts.dms.dak.dto.SmsDto;
import com.vts.dms.service.DmsService;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CustomSMSProxySender {

    private final RestTemplate restTemplate;
    private static final Logger logger=LogManager.getLogger(CustomSMSProxySender.class);
    
    @Autowired
    DmsService service;

    @Autowired
    private Environment env;
    
    @Autowired
    public CustomSMSProxySender(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    
	/*
	 * @GetMapping("proxySmsSender.htm") public String proxyRequest(@RequestParam
	 * String msg, @RequestParam String mobile) {
	 * System.out.println("CALL PROXY SMS MESSAGE" + msg);
	 * System.out.println("CALL PROXY SMS RECEIVER" + mobile);
	 * 
	 * 
	 * //To the externalUrl pass query parameters msg and mobile String externalUrl
	 * = "http://10.128.5.103/lrdesms/sendSMSApi.php"; String fullUrl = externalUrl
	 * + "?msg=" + msg + "&mobile=" + mobile;
	 * 
	 * try { // Make the proxy request String response =
	 * restTemplate.getForObject(fullUrl, String.class);
	 * 
	 * // Log the message after the request is complete
	 * 
	 * System.out.
	 * println("SMS status request sent for MobileNo@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@: "
	 * + mobile);
	 * 
	 * return response; } catch (Exception e) { e.printStackTrace(); // Handle any
	 * errors as needed return "Error: " + e.getMessage(); } }
	 */
    
    
    public String proxyRequest(@RequestParam String msg, @RequestParam String mobile) {
    	System.out.println("CALL PROXY SMS MESSAGE" + msg);
    	System.out.println("CALL PROXY SMS RECEIVER" + mobile);
        

        //To the externalUrl pass query parameters msg and mobile
    	String externalUrl = env.getProperty("sms_url");
        String fullUrl = externalUrl + "?msg=" + msg + "&mobile=" + mobile;
        
        System.out.println("fullurl:"+fullUrl);

        try {
        	
            // Make the proxy request
            String response = restTemplate.getForObject(fullUrl, String.class);
            
            // Log the message after the request is complete

            System.out.println("SMS status request sent for MobileNo@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@: " + mobile);
            
            return "1";
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any errors as needed
            return "-1";
        }	
    }
  
  
    
    
    //@Scheduled(cron = "0 30 7 * * ?")
    public void myDailySmsSend() {
      logger.info(new Date() + " Inside CONTROLLER myDailySmsSend ");
      try {
          long SmsTrackingId = 0;
          long SmsTrackingInsightsId = 0;
       // Create an AtomicInteger for thread-safe success count updates
          AtomicInteger SmsSendSuccessCount = new AtomicInteger(0);

          long DailyPendingSmSendInitiation = service.GetSMSInitiatedCount("D");
          System.out.println("DailyPendingMailSendInitiation RESULTTTT" + DailyPendingSmSendInitiation);
          if (DailyPendingSmSendInitiation == 0) {
        	  SmsTrackingId = service.InsertSmsTrackInitiator("D");
          }
          
          final long effectivelyFinalSmsTrackingId = SmsTrackingId;

            //the list of daily pending reply details
              List<Object[]> PendingReplyEmpsDetailstoSendSms = service.GetDailyPendingReplyEmpData();
             if (SmsTrackingId > 0 && PendingReplyEmpsDetailstoSendSms != null && PendingReplyEmpsDetailstoSendSms.size() > 0) {
              	 SmsTrackingInsightsId = service.InsertDailySmsPendingInsights(SmsTrackingId);
              	   if(SmsTrackingInsightsId > 0) {
                  
                            // Create a map to store unique EmpId, emails, DakNos, and Sources
                             Map<Object, SmsDto> empToDataMap = new HashMap<>();
      
                            //iterate over the PendingReplyEmpsDetailstoSendMail and constructs a map empToDataMa) to group information by unique EmpId.
                            //It collects the email addresses, DakNos, and Sources for each EmpId.  
                  
                           for (Object[] obj : PendingReplyEmpsDetailstoSendSms) {
                      
                  	           Object empId = obj[1];
                               Object dakNo = obj[4];
                               Object source = obj[5];
                               Object dueDate = obj[6];
                               String MobileNo = null;
                               if(obj[7] != null && !obj[7].toString().trim().isEmpty()) {
                            	   MobileNo = obj[7].toString();
                      	     }

                               if (empId != null && MobileNo != null && !MobileNo.isEmpty()) {
                                   if (!empToDataMap.containsKey(empId)) {
                                   empToDataMap.put(empId, new SmsDto(MobileNo));
                               }

                                   if (dakNo != null && !dakNo.toString().isEmpty()) {
                                       empToDataMap.get(empId).addDakAndSourceAndDueDate(dakNo.toString(), source.toString(), dueDate.toString());
                                   }
                              }
                               
                          }

            
                     // Iterate over the map and sends an email to each unique EmpId
                       //It creates an HTML table in the email body to display the DakNos and Sources related to each EmpId
                
                        // After building the empToDataMap, iterate over it to send Sms
                       for (Map.Entry<Object, SmsDto> SmsMapData : empToDataMap.entrySet()) {
                         Object empId = SmsMapData.getKey();
                         SmsDto emailData = SmsMapData.getValue();
                         String MobileNo = emailData.getMobileNo();
                         
                         // int dakCount = emailData.getDakAndSourceAndDueDateList().size();
                          Object[] DakCounts =service.DakCounts(Long.parseLong(empId.toString()),LocalDate.now().toString());
                            if (MobileNo != null && !MobileNo.equalsIgnoreCase("0") && MobileNo.trim().length()>0 && MobileNo.trim().length()==10 && Integer.parseInt(DakCounts[0].toString())>0) {
                                 // Create and format the Sms content
                                 String message = "Good Morning - DMS Team,\nDAK  P= " +DakCounts[0].toString() + "  U= "+DakCounts[1].toString() +"  T= " +DakCounts[2].toString()+" D= "+DakCounts[3].toString() +".";
                                       // Send the Sms asynchronously within the loop
                                 String sendResult = proxyRequest(message,MobileNo);
                                 CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> sendResult);
                                // Chain actions once the Sms sending is complete
                                       future.thenAcceptAsync(result -> {
                                    	    if ("1".equalsIgnoreCase(result)) {
                                    	        // Successfully sent
                                    	      try {
												 service.UpdateParticularEmpSmsStatus("D", "S", Long.parseLong(empId.toString()), effectivelyFinalSmsTrackingId,message);
											} catch (Exception e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
                                    	        System.out.println("Success");
                                    	        SmsSendSuccessCount.incrementAndGet(); // Increment success count atomically
                                    	    } else {
                                    	        // Failed to send
                                    	        try {
													service.UpdateParticularEmpSmsStatus("D", "N", Long.parseLong(empId.toString()), effectivelyFinalSmsTrackingId,"");
												} catch (Exception e) {
													// TODO Auto-generated catch block
													e.printStackTrace();
												}
                                    	        System.out.println("Failure");
                                    	    }
                                    	}).exceptionally(ex -> {
                                    	    System.out.println("Exception occurred: " + ex.getMessage());
                                    	    return null;
                                    	});

                                    	// Wait for completion if needed
                                    	future.join();
                      }
                  }
                  // After the loop, update the count in your table with the success count
                  // You can call a service method to perform the update
                  // Wait for all asynchronous Sms tasks to complete
                  CompletableFuture<Void> allOf = CompletableFuture.allOf(/* List of CompletableFuture objects */);
                  allOf.join(); // This ensures all tasks have completed

                  if(SmsSendSuccessCount.get()>0) {
                  service.updateSmsSuccessCount(SmsTrackingId, SmsSendSuccessCount.get(), "D");
                  }
              
            }   
              	   
           // if No EmpId is found to send daily message
             } else {
                  service.UpdateNoSmsPendingReply("D");
              }
          
      } catch (Exception e) {
          e.printStackTrace();
          logger.error(new Date() + " Inside CONTROLLER myDailyPendingScheduledSmsTask " + e);
      }
  }
    
    
   // @Scheduled(cron = "0 35 7 * * ?")
    public void DirectorDailySmsSend() {
      logger.info(new Date() + " Inside CONTROLLER DirectorDailySmsSend ");
      try {
    	  long SmsTrackingId = 0;
          long SmsTrackingInsightsId = 0;
       // Create an AtomicInteger for thread-safe success count updates
          AtomicInteger SmsSendSuccessCount = new AtomicInteger(0);

          SmsTrackingId = service.DirectorInsertSmsTrackInitiator("D");
          final long effectivelyFinalSmsTrackingId = SmsTrackingId;
          
          List<Object[]> DirectorPendingReplyEmpsDetailstoSendSms = service.GetDirectorDailyPendingReplyEmpData("LRDE");
          if (SmsTrackingId > 0 && DirectorPendingReplyEmpsDetailstoSendSms != null && DirectorPendingReplyEmpsDetailstoSendSms.size() > 0) {
         	 SmsTrackingInsightsId = service.DirectorInsertDailySmsPendingInsights(SmsTrackingId);
         	   
         	   if(SmsTrackingInsightsId > 0) {
         		   long EmpId=Long.parseLong(DirectorPendingReplyEmpsDetailstoSendSms.get(0)[0].toString());
                   String MobileNo = DirectorPendingReplyEmpsDetailstoSendSms.get(0)[1].toString();
              
                   Object[] DirectorDakCounts =service.DirectorDakCounts(LocalDate.now().toString());
                 if (MobileNo != null && !MobileNo.equalsIgnoreCase("0") && MobileNo.trim().length()>0 && MobileNo.trim().length()==10 && Integer.parseInt(DirectorDakCounts[0].toString())>0) {
                      // Create and format the Sms content
                      String message = "Good Morning - DMS Team,\nDAK  P= " +DirectorDakCounts[0].toString() + "  U= "+DirectorDakCounts[1].toString() +"  T= " +DirectorDakCounts[2].toString()+" D= "+DirectorDakCounts[3].toString() +".";
                      String sendResult = proxyRequest(message,MobileNo);
                      CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> sendResult);
                     // Chain actions once the Sms sending is complete
                      future.thenAcceptAsync(result -> {
                         	    if ("1".equalsIgnoreCase(result)) {
                         	        // Successfully sent
                         	      try {
										 service.UpdateParticularEmpSmsStatus("D", "S", EmpId, effectivelyFinalSmsTrackingId,message);
									} catch (Exception e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
                         	        System.out.println("Success");
                         	        SmsSendSuccessCount.incrementAndGet(); // Increment success count atomically
                         	    } else {
                         	        // Failed to send
                         	        try {
											service.UpdateParticularEmpSmsStatus("D", "N", EmpId, effectivelyFinalSmsTrackingId,"");
										} catch (Exception e) {
											// TODO Auto-generated catch block
											e.printStackTrace();
										}
                         	        System.out.println("Failure");
                         	    }
                         	}).exceptionally(ex -> {
                         	    System.out.println("Exception occurred: " + ex.getMessage());
                         	    return null;
                         	});

                         	// Wait for completion if needed
                         	future.join();
           }
       }
       // After the loop, update the count in your table with the success count
       // You can call a service method to perform the update
       // Wait for all asynchronous Sms tasks to complete
       CompletableFuture<Void> allOf = CompletableFuture.allOf(/* List of CompletableFuture objects */);
       allOf.join(); // This ensures all tasks have completed

       if(SmsSendSuccessCount.get()>0) {
       service.updateSmsSuccessCount(SmsTrackingId, SmsSendSuccessCount.get(), "D");
       }
   
// if No EmpId is found to send daily message
  } else {
       service.UpdateNoSmsPendingReply("D");
   }

      } catch (Exception e) {
          e.printStackTrace();
          logger.error(new Date() + " Inside CONTROLLER DirectorDailySmsSend " + e);
       }
  }
}





//package com.vts.dms.controller;
//import java.util.Date;
//import java.util.List;
//
//import org.apache.logging.log4j.LogManager;
//import org.apache.logging.log4j.Logger;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.core.env.Environment;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.web.client.RestTemplate;
//
//import com.vts.dms.service.DmsService;
//
//import org.springframework.web.bind.annotation.RestController;
//
//@RestController
//public class CustomSMSProxySender {
//
//    private final RestTemplate restTemplate;
//    private static final Logger logger=LogManager.getLogger(CustomSMSProxySender.class);
//    
//    @Autowired
//    DmsService service;
//
//    @Autowired
//    private Environment env;
//    
//    @Autowired
//    public CustomSMSProxySender(RestTemplate restTemplate) {
//        this.restTemplate = restTemplate;
//    }
//
//   // @Scheduled(cron = "0 30 7 * * ?")
//    public void myDailySmsSend() {
//      logger.info(new Date() + " Inside CONTROLLER myDailySmsSend ");
//      try {
//          long SmsTrackingId = 0;
//          long SmsTrackingInsightsId = 0;
//          long DailyPendingSmSendInitiation = service.GetSMSInitiatedCount("D");
//          if (DailyPendingSmSendInitiation == 0) {
//        	  SmsTrackingId = service.InsertSmsTrackInitiator("D");
//          }
//            //the list of daily pending reply details
//              List<Object[]> PendingReplyEmpsDetailstoSendSms = service.GetDailyPendingReplyEmpData();
//             if (SmsTrackingId > 0 && PendingReplyEmpsDetailstoSendSms != null && PendingReplyEmpsDetailstoSendSms.size() > 0) {
//              	 SmsTrackingInsightsId = service.InsertDailySmsPendingInsights(SmsTrackingId);
//              	   if(SmsTrackingInsightsId > 0) {
//              		   System.out.println("SmsTrackingInsightsId:"+SmsTrackingInsightsId);
//                  service.updateSmsSuccessCount(SmsTrackingId, SmsTrackingInsightsId, "D");
//            }   
//           // if No EmpId is found to send daily message
//             } else {
//                  service.UpdateNoSmsPendingReply("D");
//              }
//      } catch (Exception e) {
//          e.printStackTrace();
//          logger.error(new Date() + " Inside CONTROLLER myDailyPendingScheduledSmsTask " + e);
//      }
//  }
//    
//    
//   // @Scheduled(cron = "0 35 7 * * ?")
//    public void DirectorDailySmsSend() {
//      logger.info(new Date() + " Inside CONTROLLER DirectorDailySmsSend ");
//      try {
//    	  long SmsTrackingId = 0;
//          long SmsTrackingInsightsId = 0;
//          SmsTrackingId = service.DirectorInsertSmsTrackInitiator("D");
//          List<Object[]> DirectorPendingReplyEmpsDetailstoSendSms = service.GetDirectorDailyPendingReplyEmpData("LRDE");
//          System.out.println("SmsTrackingId:"+SmsTrackingId);
//          System.out.println("DirectorPendingReplyEmpsDetailstoSendSms:"+DirectorPendingReplyEmpsDetailstoSendSms);
//          if (SmsTrackingId > 0 && DirectorPendingReplyEmpsDetailstoSendSms != null && DirectorPendingReplyEmpsDetailstoSendSms.size() > 0) {
//         	 SmsTrackingInsightsId = service.DirectorInsertDailySmsPendingInsights(SmsTrackingId);
//         	if(SmsTrackingInsightsId > 0) {
//            service.updateSmsSuccessCount(SmsTrackingId, SmsTrackingInsightsId, "D");
//         	}
//         	
//         	} else {
//         		service.UpdateNoSmsPendingReply("D");
//         	}
//          } catch (Exception e) {
//          e.printStackTrace();
//          logger.error(new Date() + " Inside CONTROLLER DirectorDailySmsSend " + e);
//       }
//  }
//}
