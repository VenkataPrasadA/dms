<%@page import="java.text.DateFormat"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Tracking Print</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<style>

#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
 @page {             
          size: 790px 1120px;
          margin-top: 49px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 3px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
              font-size: 13px;
          }
      }

.border-black{
border: 1px solid black;
border-collapse: collapse;
}
.break
	{
		page-break-after: always;
	} 

.spanDate{
color: #007bff;
font-size: 12px;
}

 .std
 {
 	
 	border: 1px solid black;
 	padding: 3px 2px 2px 2px; 
 	
 }
</style>
</head>
<body>
 <% SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
    List<Object[]> dakTrackingPrintData=(List<Object[]>)request.getAttribute("DakTrackingPrintData");
    DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
    DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
    String LabCode=(String)session.getAttribute("LabCode");
    
String InitiatedBy = null;String InitiatedDateFormatted = null;String DistributedDateFormatted = null;
String AckBy = null;String AckDateFormatted = null;
String ReplyBy = null;String ReplyDateFormatted = null;
String PNCDOReplyBy = null;String PNCDOReplyDateFormatted = null;
String ForwardBy = null;String ForwardDateFormatted = null;
String ApprovedBy = null;String ApprovedDateFormatted = null;
String ClosedBy = null;String ClosedDateFormatted = null;
	
%>

<div id="container pageborder" align="center"  class="firstpage" id="firstpage"  >
			<%if(dakTrackingPrintData!=null && dakTrackingPrintData.size()>0){ %>
			<%for(Object[] obj : dakTrackingPrintData){ %>
			     <%
	    String Status  = obj[4].toString().trim();

        /////
        if(obj[22]!=null && obj[23]!=null){
        	InitiatedBy =  obj[22].toString()+", "+obj[23].toString();
         }else  if(obj[22]!=null){
        	 InitiatedBy =  obj[22].toString();
        }else{
        	InitiatedBy = "--";
        }
        if(obj[6]!=null){
     	   Date initiaateddate = inputFormat.parse(obj[6].toString());
		       InitiatedDateFormatted = outputFormat.format(initiaateddate);
     	}else{InitiatedDateFormatted = "--";}
        /////
        if(obj[7]!=null){
     	   Date distributeddate = inputFormat.parse(obj[7].toString());
     	   DistributedDateFormatted = outputFormat.format(distributeddate);
     	}else{DistributedDateFormatted = "--";}
       /////
        if(obj[24]!=null && obj[25]!=null){
        	AckBy =  obj[24].toString()+", "+obj[25].toString();
         }else  if(obj[24]!=null){
        	AckBy =  obj[24].toString();
        }else{
        	AckBy = "--";
        }
        if(obj[17]!=null){
     	   Date ackdate = inputFormat.parse(obj[17].toString());
     	  AckDateFormatted = outputFormat.format(ackdate);
     	}else{AckDateFormatted = "--";}
        //////
        if(obj[26]!=null && obj[27]!=null){
        	ReplyBy =  obj[26].toString()+", "+obj[27].toString();
         }else  if(obj[26]!=null){
        	 ReplyBy =  obj[26].toString();
        }else{
        	ReplyBy = "--";
        }
        if(obj[18]!=null){
      	   Date replieddate = inputFormat.parse(obj[18].toString());
      	 ReplyDateFormatted = outputFormat.format(replieddate);
      	}else{ReplyDateFormatted = "--";}
        
    //////
        if(obj[28]!=null && obj[29]!=null){
        	PNCDOReplyBy =  obj[28].toString()+", "+obj[29].toString();
         }else  if(obj[28]!=null){
        	 PNCDOReplyBy =  obj[28].toString();
        }else{
        	PNCDOReplyBy = "--";
        }
        if(obj[12]!=null){
      	   Date pncdoreplieddate = inputFormat.parse(obj[12].toString());
      	 PNCDOReplyDateFormatted = outputFormat.format(pncdoreplieddate);
      	}else{PNCDOReplyDateFormatted = "--";}
        
        //////
        if(obj[30]!=null && obj[31]!=null){
        	ApprovedBy =  obj[30].toString()+", "+obj[31].toString();
         }else  if(obj[30]!=null){
        	 ApprovedBy =  obj[30].toString();
        }else{
        	ApprovedBy = "--";
        }
        if(obj[16]!=null){
      	   Date approveddate = inputFormat.parse(obj[16].toString());
      	 ApprovedDateFormatted = outputFormat.format(approveddate);
      	}else{ApprovedDateFormatted = "--";}
        //////
        if(obj[32]!=null && obj[33]!=null){
        	ClosedBy =  obj[32].toString()+", "+obj[33].toString();
         }else  if(obj[32]!=null){
        	 ClosedBy =  obj[32].toString();
        }else{
        	ClosedBy = "--";
        }
        if(obj[14]!=null){
      	   Date closeddate = inputFormat.parse(obj[14].toString());
      	 ClosedDateFormatted = outputFormat.format(closeddate);
      	}else{ClosedDateFormatted = "--";}
        //////
        if(obj[34]!=null && obj[35]!=null){
        	ForwardBy =  obj[34].toString()+", "+obj[35].toString();
         }else  if(obj[34]!=null){
        	 ForwardBy =  obj[34].toString();
        }else{
        	ForwardBy = "--";
        }
        if(obj[36]!=null){
      	   Date forwarddate = inputFormat.parse(obj[36].toString());
      	 ForwardDateFormatted = outputFormat.format(forwarddate);
      	}else{ForwardDateFormatted = "--";}
        
        
        %>
        <br>
<table class="border-black" style="margin-top: 5px; margin-left: 30px; width: 650px">
		    
        <tr>
         <th colspan="10" style="text-align:center;font-size: 17px; height: 30px"><%=obj[1].toString()%></th>
        </tr>
        
 <!--------------------DakInitiation Start------------------------->
     <tr>
     <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Initiated By </td>

    <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=InitiatedBy%> <br> <span style="font-size: 13px;"> &nbsp; [Initiated on :</span> <span class="spanDate"><%=InitiatedDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
            
      </tr> 
      

<!-----------------------DakInitiation End------------------------->
        
<!-----------------------DakDistribute Start----------------------->
         <%if("DD".equalsIgnoreCase(Status) || "DA".equalsIgnoreCase(Status) || "DR".equalsIgnoreCase(Status) || "RM".equalsIgnoreCase(Status)  || "RP".equalsIgnoreCase(Status) || "FP".equalsIgnoreCase(Status) || "AP".equalsIgnoreCase(Status)  || "DC".equalsIgnoreCase(Status)){ %>				
	
           <tr>
     <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Distributed By </td>
  
      <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=InitiatedBy%> <br> <span style="font-size: 13px;"> &nbsp; [Distributed on :</span> <span class="spanDate"><%=DistributedDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
            
      </tr> 
            <%} %>
 
<!-----------------------DakDistribute End----------------------->
        
        
<!-----------------------DakAcknowledged Start----------------------->
     <%if(obj[17]!=null && 
     ("DA".equalsIgnoreCase(Status) || "DR".equalsIgnoreCase(Status) || "RM".equalsIgnoreCase(Status)  || "RP".equalsIgnoreCase(Status) || "FP".equalsIgnoreCase(Status) || "AP".equalsIgnoreCase(Status)  || "DC".equalsIgnoreCase(Status))){ %>								
       <tr>
     <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Acknowledged By </td>
  
      <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=AckBy%> <br> <span style="font-size: 13px;"> &nbsp; [Acknowledged on :</span> <span class="spanDate"><%=AckDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
            
      </tr> 
    
     <%} %>
 
 <!-------------------------DakAcknowledged End------------------------->
 
 <!-----------------------DakReplied Start----------------------->
    <%if(obj[18]!=null && 
    ("DR".equalsIgnoreCase(Status) || "RM".equalsIgnoreCase(Status)  || "RP".equalsIgnoreCase(Status) || "FP".equalsIgnoreCase(Status)  || "AP".equalsIgnoreCase(Status)  || "DC".equalsIgnoreCase(Status))){ %>													
      <tr>
        <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Replied By </td>
        <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=ReplyBy%> <br> <span style="font-size: 13px;"> &nbsp; [Replied on :</span> <span class="spanDate"><%=ReplyDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
     </tr> 
   <%} %>
 <!-------------------------DakReplied End------------------------->
 
 
  <!-----------------------DakPNCDO Start----------------------->
   <!--  Only if closing auhority is P  -->
<%if( obj[20]!=null && "P".equalsIgnoreCase(obj[20].toString()) && !"RM".equalsIgnoreCase(Status) && ("RP".equalsIgnoreCase(Status) || "FP".equalsIgnoreCase(Status) || "AP".equalsIgnoreCase(Status)  || "DC".equalsIgnoreCase(Status) )){ %>													
      
         <tr>
     <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;<%if(LabCode!=null && LabCode.equalsIgnoreCase("ADE")){ %>PPA<%}else{ %>P&C DO<%} %>  Replied By </td>
  
      <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=PNCDOReplyBy%> <br> <span style="font-size: 13px;"> &nbsp; [<%if(LabCode!=null && LabCode.equalsIgnoreCase("ADE")){ %>PPA<%}else{ %>P&C DO<%} %>  Replied on :</span> <span class="spanDate"><%=PNCDOReplyDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
            
      </tr> 
 <% } %>
 <!-------------------------DakPNCDO End------------------------->
 
 
 <!-------------------------DakForward Start(Approve is common for both p&cDO and Others close)------------------------->

  <%if(obj[20]!=null && "P".equalsIgnoreCase(obj[20].toString()) && obj[21]!=null && "R".equalsIgnoreCase(obj[21].toString()) && ("FP".equalsIgnoreCase(Status) || "AP".equalsIgnoreCase(Status) || "DC".equalsIgnoreCase(Status))){ %>													
		
         <tr>
     <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Forwarded By </td>
  
      <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=ForwardBy%> <br> <span style="font-size: 13px;"> &nbsp; [Forward on :</span> <span class="spanDate"><%=ForwardDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
            
      </tr> 
	 <%} %>	
		
   <!-------------------------DakForward End------------------------->
 
 
  <!-------------------------DakApprove Start(Approve is common for both p&cDO and Others close)------------------------->

<%if(obj[21]!=null && "R".equalsIgnoreCase(obj[21].toString()) && ("AP".equalsIgnoreCase(Status) || "DC".equalsIgnoreCase(Status))){ %>													
		
         <tr>
     <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Approved By </td>
  
      <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=ApprovedBy%> <br> <span style="font-size: 13px;"> &nbsp; [Approved on :</span> <span class="spanDate"><%=ApprovedDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
            
      </tr> 
	 <%} %>	
		
   <!-------------------------DakApprove End------------------------->
 
   <!-----------------------DakClosed Start----------------------->
    <%if(obj[13]!=null && "DC".equalsIgnoreCase(Status)){ %>	
     <tr>
     <td colspan="2" style="border: 1px solid black; text-align: left; font-weight: 700; height: 62px">&nbsp;&nbsp;Closed By </td>
      <td colspan="8" style="border: 1px solid black; text-align: left; font-weight: 700;height: 62px "><span style="font-weight: normal;">&nbsp;&nbsp;<%=ClosedBy%> <br> <span style="font-size: 13px;"> &nbsp; [Closed on :</span> <span class="spanDate"><%=ClosedDateFormatted%></span><span style="font-size: 13px;"> ]</span></span></td>
      </tr> 
       <%} %>	
 <!-------------------------DakClosed End------------------------->
    </table> 
     <%} %>
    <%} %>
			</div>

</body>
</html>