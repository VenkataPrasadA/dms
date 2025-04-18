<%@page import="com.vts.dms.DateTimeFormatUtil"%>
<%@page import="org.apache.logging.log4j.core.pattern.EqualsIgnoreCaseReplacementConverter"%>
<%@page import="jakarta.persistence.criteria.CriteriaBuilder.In"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<%@page import="java.time.LocalTime"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK VIEW</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/webresources/css/ReceivedView.css" var="Receivedcss" />
<link href="${Receivedcss}" rel="stylesheet" />
\<!--Modal Drag.js  -->

<spring:url value="/webresources/js/jquery-ui.js" var="modaldragjs" />
<script src="${modaldragjs}"></script>

<!--Modal Drag.js  -->
<spring:url value="/webresources/js/jquery-ui.min.js" var="modaldragminjs" />
<script src="${modaldragminjs}"></script>
<style type="text/css">
.color-box {
display: inline-block;
width: 15px;
height: 15px;
margin-right: 5px;
}

.RemindDetailscomment {
background-color: #0073FF;
}

.RemindDetailsReply {
background-color: green;
}

.modal-backdrop {
background: transparent !important;
}

.modal-dialog-jump {
  animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
</head>
<body>
<%
		
		String viewfrom=(String)request.getAttribute("viewfrom");
	    Object[] dakReceivedList=(Object[])request.getAttribute("dakReceivedList");
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat outputFormat = new SimpleDateFormat("HH:mm 'Hrs'");
		List<Object[]> actionList = (List<Object[]>) request.getAttribute("actionList");
		long LoginEmpId =(Long)session.getAttribute("EmpId"); 
	    String loginType =(String)session.getAttribute("LoginTypeDms");
	    
		List<Object[]> MailReceivedEmpDetails=(List<Object[]>)request.getAttribute("MailReceivedEmpDetails");
		Object[] MailSentDetails=(Object[])request.getAttribute("MailSentDetails");
		
	    String fromDateFetch=(String)request.getAttribute("fromDateFetch");
	    String toDateFetch=(String)request.getAttribute("toDateFetch");
	    
	    Object[] MarkData=(Object[])request.getAttribute("MarkData");
	    
	    Object[] assigneddata=(Object[])request.getAttribute("assigneddata");
		List<Object[]> dakClosingAuthorityList = (List<Object[]>)request.getAttribute("dakClosingAuthorityList");
	    
	    String LabCode=(String)session.getAttribute("LabCode");
	    
	    Object[] seekdata=(Object[])request.getAttribute("seekdata");
	    String ClosingAuthority="";
	    if(dakReceivedList[46]!=null){
	    		ClosingAuthority = dakReceivedList[46].toString();
	    }
	   /*  if(dakReceivedList!=null && dakReceivedList[20]!=null ){
	    	if(dakReceivedList[20].toString().equalsIgnoreCase("P")){
	    		ClosingAuthority="P&C DO";
	    	}else if(dakReceivedList[20].toString().equalsIgnoreCase("K")){
	    		ClosingAuthority="D-KRM";
	    	}else if(dakReceivedList[20].toString().equalsIgnoreCase("A")){
	    		ClosingAuthority="D-Adm";
	    	}else if(dakReceivedList[20].toString().equalsIgnoreCase("R")){
	    		ClosingAuthority="DFMM";
	    	}else if(dakReceivedList[20].toString().equalsIgnoreCase("Q")){
	    		ClosingAuthority="DQA";
	    	}else if(dakReceivedList[20].toString().equalsIgnoreCase("O")){
	    		ClosingAuthority="OTHERS";
	    	}
	    } */
		%>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK View</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
				    <%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakReceivedList")){ %>
				    <li class="breadcrumb-item"><a href="DakReceivedList.htm"><i class="fa fa-envelope"></i> DAK Received List</a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakDetailedList")){ %>
				    <li class="breadcrumb-item"><a href="DakList.htm"><i class="fa fa-envelope"></i> DAK List (All)</a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakDirectorList")){ %>
				   <li class="breadcrumb-item"><a href="DakDirectorList.htm"><i class="fa fa-envelope"></i> DAK Director List</a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakPncList")) {%>
				   <li class="breadcrumb-item"><a href="DakPNCList.htm"><i class="fa fa-envelope"></i> DAK P&C List</a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakPncDoList")){ %>
				    <li class="breadcrumb-item"><a href="DakPNCDOList.htm"><i class="fa fa-envelope"></i> <%if(LabCode!=null && LabCode.equalsIgnoreCase("ADE")) {%>DAK PPA List<%}else{ %>DAK P&C DO List<%} %></a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakPendingReplyList")){ %>
				    <li class="breadcrumb-item"><a href="DakPendingReplyList.htm"><i class="fa fa-envelope"></i> DAK Pending Reply List</a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakRepliedList")) {%>
				   <li class="breadcrumb-item"><a href="DakRepliedList.htm"><i class="fa fa-envelope"></i> DAK Replied List</a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakAssignedList")) {%>
				   <li class="breadcrumb-item"><a href="DakAssignedList.htm"><i class="fa fa-envelope"></i> DAK Assigned List </a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakSeekResponseList")){ %>
				   <li class="breadcrumb-item"><a href="DakSeekResponseList.htm"><i class="fa fa-envelope"></i> DAK Seek Response List</a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakFilter")){ %>
				   <li class="breadcrumb-item"><a href="DakFilter.htm"><i class="fa fa-envelope"></i> DAK Filter List</a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakSearch")) {%>
				    <li class="breadcrumb-item"><a href="DakSearch.htm"><i class="fa fa-envelope"></i> DAK Search </a></li>
				   <%}else if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakTracking")) {%>
				   <li class="breadcrumb-item"><a href="DakTracking.htm"><i class="fa fa-envelope"></i> DAK Tracking </a></li>
				   <%} %>
				    <li class="breadcrumb-item active">DAK View</li>
				  </ol>		
				</nav>
			</div>			
		</div>
		</div>
		
		<div class="page card dashboard-card">
		
			<div align="center">
					<%String ses=(String)request.getParameter("result"); 
					String ses1=(String)request.getParameter("resultfail");
					if(ses1!=null){ %>
					<div align="center">
						<div class="alert alert-danger" role="alert"  style="margin-top: 5px;">
							<%=ses1 %>
						</div>
						</div>
					<%}if(ses!=null){ %>
						<div align="center">
						<div class="alert alert-success" role="alert"  style="margin-top: 5px;">
							<%=ses %>
						</div>
						</div>
					<%} %>
				</div>
			
				<div class="card" style="padding-top:0px;margin-top: -15px;">
					<div class="card-body" >
   <form action="#" method="POST" > 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
     <div class="row">
      <div class="float-container" style="float: right;">
        <div id="label1" style="width: 100%; text-align: left;margin-top: -1rem;">
         <table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;">
			<thead>
				<tr>
				    <td colspan="7" style="border: 0;">
					   <p style="font-size: 18px;text-align: center; "> 
					<!---------------------------------------------------------- Dak Received List Actions Start ----------------------------------------------------------------->
									
						<%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakReceivedList")){ %>
 							<%if("ACTION".equalsIgnoreCase(dakReceivedList[10].toString().trim()) &&  MarkData[1]!=null  && MarkData[1].toString().equalsIgnoreCase("Y") && dakReceivedList[37]!=null && Long.parseLong(dakReceivedList[37].toString()) <= 0 ){ %>
 								<input type="hidden" id="subject<%=dakReceivedList[1] %>" value="<%=dakReceivedList[15] %>">
 								<button  type="button"  class="btn btn-sm icon-btn btn-hover color-5"  onclick="return replyModalOfMarker('<%=dakReceivedList[1] %>','<%=LoginEmpId%>','<%=dakReceivedList[32] %>','<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>','<%=MarkData[0] %>')" data-toggle="tooltip" data-placement="top" title="Reply">
 								&nbsp; Marker Reply &nbsp;
								</button>
 						<%}%>   
 						    <%if(MarkData[1]!=null && MarkData[1].toString().equalsIgnoreCase("Y") && !dakReceivedList[6].toString().equalsIgnoreCase("RM") && !dakReceivedList[6].toString().equalsIgnoreCase("RP") && !dakReceivedList[6].toString().equalsIgnoreCase("FP") && !dakReceivedList[6].toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC") ){ %>
 						        <button type="button"  class="btn btn-sm icon-btn btn-hover color-9" onclick="return Assign(<%=dakReceivedList[1]%>,<%=MarkData[0] %>,'<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>','DakReceivedViewList')" data-toggle="tooltip" data-placement="top" title="Assign">
 						        &nbsp; Assign &nbsp;
								</button>
 							<%} %>
 							<%if(MarkData[3]!=null && !MarkData[3].toString().equalsIgnoreCase("N")){ %>
 						    <span class="MsgByDir">
 							<%if(MarkData[3].toString().equalsIgnoreCase("D")){ %>
 								    Pls Discuss With Director
 							<%}else if(MarkData[3].toString().equalsIgnoreCase("E")){ %>
 									 Noted By Director
 							<%}%>
 							</span>
 							<%}%>
 										 
 							<%if(MarkData[2]!=null  && MarkData[2].toString().equalsIgnoreCase("Y")){ %>
 							<span <%if(MarkData[2]!=null  && MarkData[2].toString().equalsIgnoreCase("Y") &&  dakReceivedList[32]!=null && Long.parseLong(dakReceivedList[32].toString())>0) { %> style="color:#006400;"<%}else{ %>style="color:blue;"<%} %>>
 							 CW
 							 </span>
 							<%} %>
 								
 							<%if( MarkData[1]!=null && MarkData[1].toString().equalsIgnoreCase("Y") && !dakReceivedList[6].toString().equalsIgnoreCase("RP") && !dakReceivedList[6].toString().equalsIgnoreCase("FP") && !dakReceivedList[6].toString().equalsIgnoreCase("RM") && !dakReceivedList[6].toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC")){ %>
 						    <button type="button" class="btn btn-sm icon-btn btn-hover color-10 " onclick="SeekResponse(<%=dakReceivedList[1]%>,<%=MarkData[0] %>,'<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>','DakReceivedViewList')" data-toggle="tooltip" data-placement="top"  title="SeekResponse">
 							&nbsp;	Seek Response &nbsp;
							</button>
 							<%} %>
 							
 							 <%if((!dakReceivedList[6].toString().equalsIgnoreCase("DC") && !dakReceivedList[6].toString().equalsIgnoreCase("RM") && !dakReceivedList[6].toString().equalsIgnoreCase("AP")
 							 && dakReceivedList[20]!=null && !dakReceivedList[20].toString().equalsIgnoreCase("P") && MarkData[1]!=null && MarkData[1].toString().equalsIgnoreCase("Y") && MarkData[0]!=null
 							 && MarkData[4]!=null && MarkData[4].toString().equalsIgnoreCase("A") && dakReceivedList[37]!=null && Long.parseLong(dakReceivedList[37].toString())>0)){%>
 								
 							<button type="button" class="btn btn-sm icon-btn btn-hover color-11" name="DakCloseSelection" formaction="DakClose.htm"  id="DakCloseByMarker" data-toggle="tooltip" data-placement="top" data-original-title="Dak Close" 
                             onclick="return DakMarkerCloseSelection('<%=dakReceivedList[1]%>','<%=dakReceivedList[6]%>','<%=MarkData[0]%>','<%=dakReceivedList[28]%>','<%=dakReceivedList[29]%>')">
                             &nbsp;  Dak Close &nbsp;
 							</button>	
 									 
 							 <%}%>
 							 
 							 <%if( dakReceivedList[6].toString().equalsIgnoreCase("RM") &&    !dakReceivedList[6].toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC") 
 	  	    				  && dakReceivedList[38]!=null && Long.parseLong(dakReceivedList[38].toString())>0){ %>
 	  	    				 <span style="font-weight:bold;font-size:10px;color:green;padding-right:10px;padding-left:10px;">
 							 awaiting dir approval
 							</span>		
 						    <%}%>
 				
 				 <%
 					String ApprovedCommtData = "--";
 					String ApprovedCommtCheckData = "NA";
 					if(dakReceivedList[6].toString().equalsIgnoreCase("AP")&& dakReceivedList[39]!=null){
 					ApprovedCommtCheckData = "ApproveCommtPopUp";
 					ApprovedCommtData = dakReceivedList[39].toString();
 				 }%>
 					
 					 <% if((dakReceivedList[6].toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC") 
 							 && dakReceivedList[20]!=null && dakReceivedList[20].toString().equalsIgnoreCase("O")
 							 && MarkData[1]!=null && MarkData[1].toString().equalsIgnoreCase("Y") && MarkData[0]!=null
 							 && MarkData[4]!=null && MarkData[4].toString().equalsIgnoreCase("A") 
 							 && dakReceivedList[37]!=null && Long.parseLong(dakReceivedList[37].toString())>0 
 							 && dakReceivedList[38]!=null && Long.parseLong(dakReceivedList[38].toString())>0
 							 && Long.parseLong(dakReceivedList[38].toString())==LoginEmpId)){%>
 						<input type="hidden" name="WithApprovalDakClose" value="DakRecievedListRedirect">
 						<input type="hidden"name="DakIdForClose" value="<%=dakReceivedList[1] %>" >
 						<button type="button" class="btn btn-sm icon-btn btn-hover color-11" formaction="DakClose.htm"  id="DakCloseByMarkerAfterApproval" data-toggle="tooltip" data-placement="top" data-original-title="Dak Close"  data-ApprovedCommt-value="<%=ApprovedCommtData%>"
                         onclick="return MarkerCloseWithDirApproval('<%=dakReceivedList[1]%>','<%=dakReceivedList[6]%>','<%=MarkData[0]%>','<%=ApprovedCommtCheckData%>', this)">
                         &nbsp;  Dak Close &nbsp;
 						</button>	
 							 <%}}%>
               <!------------------------------------------------ Dak Received List Actions End ------------------------------------------------------------>
 							 
 	        <!----------------------------------------------------------- DakList Actions start ----------------------------------------------------------------------->
 							 
 							 <%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakDetailedList")) {%>
 							 
 							 <%if(!dakReceivedList[6].toString().equalsIgnoreCase("DC")) {%>
				     	     <!-- Attach Button -->
				     		    <button type="button" class="btn btn-sm icon-btn btn-hover color-8" data-toggle="tooltip" Onclick="uploadDoc(<%=dakReceivedList[1] %>,'M','<%=dakReceivedList[9].toString() %>','DakViewList','<%=dakReceivedList[4].toString() %>')" data-placement="top" title="Attach" data-target="#exampleModalCenter">
 								&nbsp; Attachment &nbsp;
 								</button>
 							
 							 <!-- EditAction Button -->		 		
 		             	        <button type="button" class="btn btn-sm icon-btn btn-hover color-9"  data-toggle="tooltip" data-placement="top" title="EditAction" onclick="EditAction(<%=dakReceivedList[1]%>,'DakViewList','<%=dakReceivedList[9]%>','<%=dakReceivedList[4]%>')">
 							    &nbsp; Edit Action &nbsp;
							    </button>
					
					         <%} %>
				     
						      <!-- Dir Approved Msg -->		 										
							<%if(dakReceivedList[21]!=null && dakReceivedList[21].toString().equalsIgnoreCase("R") && dakReceivedList[6].toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC")){%>
 				              <span style="font-weight:bold;font-size:12px;color:purple;padding-right:10px;padding-left:10px;">
 				               Approved
 					          </span>
 			    		      <%}%>		
			
							 <!-- DAK Closed Msg -->						
							<%if(dakReceivedList[6].toString().equalsIgnoreCase("DC") ){%>
 							<span style="font-weight:bold;font-size:12px;color:Green;padding-right:10px;padding-left:10px;">
 							Closed
 						    </span>
 						   <%}}%>
				     
     <!-------------------------------------------------------- Dak List Actions end ----------------------------------------------------------------->
     
     
   <!------------------------------------------------------ Dak Director List Actions Start ----------------------------------------------------------------->
				    <%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakDirectorList")) {%>
				     	<%
				     	 String PnCReplyStat = null;
					     String DirApproval = null;
					     String CloseAuthority = null;
				     	%>	  
				      <%if(!"DI".equalsIgnoreCase(dakReceivedList[6].toString())) {%>
			         <!--(COMMON CONDITION FOR BOTH P&CDO  &  OTHERS  START )###Allow DAK Approve ONLY if DirectorApproval(obj[25]) is R no matter closingAuthority(obj[26]) is P or O-->
			         	<%if(!dakReceivedList[6].toString().equalsIgnoreCase("DC")) {%>
				         <!-- Dir Approved Msg --> <!--### AP concept comes both for Closing authority(obj[25]) i.e P and O only when director Approval is R--->
 					      <%if(dakReceivedList[21]!="null" && dakReceivedList[21].toString().equalsIgnoreCase("R") && dakReceivedList[6].toString().equalsIgnoreCase("AP")){%>
 						  <span style="font-weight:bold;font-size:15px;color:green; padding-right:10px;padding-left:10px;">
 						  &nbsp; Approved &nbsp;
 						  </span>
 				       <%}}%>		  							  
			         <%if(dakReceivedList[40]!=null && dakReceivedList[21]!="null" && dakReceivedList[20]!="null" && dakReceivedList[21].toString().equalsIgnoreCase("R") && !dakReceivedList[6].toString().equalsIgnoreCase("AP")){
				          PnCReplyStat = dakReceivedList[40].toString();
				          DirApproval = dakReceivedList[21].toString();
						  CloseAuthority = dakReceivedList[20].toString();
						%>		

   <!-----------------------------------       DAK Approve Button for CLOSING AUTHORITY(P&CDO) Start          -------------------------------------->	
		        
		         <%if(CloseAuthority.equalsIgnoreCase("P") && dakReceivedList[6].toString().equalsIgnoreCase("FP") &&!PnCReplyStat.equalsIgnoreCase("NA") && !PnCReplyStat.equalsIgnoreCase("D")){ %>
			      <button type="button" class="btn btn-sm icon-btn btn-hover color-7" name="DakIdFrApprove"  id=<%="DakIdFrApproval"+dakReceivedList[1]  %> value="<%=dakReceivedList[1] %>" 
 				   onclick="ApproveOrViewPNCDORepliedDakByDir(<%=dakReceivedList[1]%>,'DakViewList')" data-toggle="tooltip" data-placement="top" title="Director Approval"> 
 				   &nbsp;&nbsp; Director Approval(PnC) &nbsp;&nbsp;
			     </button>
		         <%} %>			 
		      
             <!------------------------------      DAK Approve Button for CLOSING AUTHORITY(OTHERS) Start    -------------------------------------->	
             
    	       <%if(CloseAuthority.equalsIgnoreCase("O") &&  !dakReceivedList[6].toString().equalsIgnoreCase("RP") && !dakReceivedList[6].toString().equalsIgnoreCase("FP")
    	    	&& dakReceivedList[6].toString().equalsIgnoreCase("RM") && dakReceivedList[38]!=null && Long.parseLong(dakReceivedList[38].toString())>0){ %>   
		    	<button type="button" class="btn btn-sm icon-btn btn-hover color-1" name="DakIdFrApprove"  id=<%="DakIdFrApproval"+dakReceivedList[1]  %> value="<%=dakReceivedList[1] %>" 
 				 onclick="ApproveOrViewMarkerRepliedDakByDir(<%=dakReceivedList[1]%>,<%=dakReceivedList[38]%>,'DakViewList')" data-toggle="tooltip" data-placement="top" title="Director Approval"> 
 				 &nbsp;&nbsp; Director Approval(M) &nbsp;&nbsp;
				</button>	
               <%} %>
		    
 			    
 			    
         <!--------------Director Returned for CLOSING AUTHORITY(P&C DO) Consolidated Reply View Start---------------------------------------->				    				
		     <%if(!PnCReplyStat.equalsIgnoreCase("NA") && PnCReplyStat.equalsIgnoreCase("D")  && CloseAuthority.equalsIgnoreCase("P")&& (dakReceivedList[6].toString().equalsIgnoreCase("RP") || dakReceivedList[6].toString().equalsIgnoreCase("FP"))){ %>
			<!-- Returned Consolidated reply view Button -->	 
			
			<button type="button" class="btn btn-sm icon-btn btn-hover color-5" name="DakIdFrApprove"  id=<%="DakIdFrApproval"+dakReceivedList[1]  %> value="<%=dakReceivedList[1] %>" 
 			 onclick="ApproveOrViewPNCDORepliedDakByDir(<%=dakReceivedList[1]%>,'DakViewList')" data-toggle="tooltip" data-placement="top" title="P&C Reply Returned"> 
 			 &nbsp;&nbsp; PnC Return Reply &nbsp;&nbsp;
			</button>
 		 <%}}}}%>
   <!-----------------------------------         Director Returned for CLOSING AUTHORITY(Others) Markers Reply View Start---------------------------------------->	 			    
 
 <!--------------------------------------------          (COMMON CONDITION FOR BOTH P&CDO  &  OTHERS END )	------------------------------------------------------->		
 	
<!------------------------------------------------------------------------ Dak Director List Actions end ---------------------------------------------------------->

							
 <!-------------------------------------------------------------- Dak PNC List Actions Start ----------------------------------------------------------------->
 
	
<%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakPncList")){ %>	
						
	 <!-----------------------consolidatedReply Add Action Check Start --------------------------------------------------------------------------------------------------->
 								
 		<%if(dakReceivedList[25]!=null && Long.parseLong(dakReceivedList[25].toString())!= 1  && dakReceivedList[20]!=null && dakReceivedList[20].toString().equalsIgnoreCase("P") ){%>					
 		   <%if(dakReceivedList[6].toString().equalsIgnoreCase("DD")||dakReceivedList[6].toString().equalsIgnoreCase("DA")||dakReceivedList[6].toString().equalsIgnoreCase("DR") 
 			&&  ((!dakReceivedList[6].toString().equalsIgnoreCase("RP")) &&(!dakReceivedList[6].toString().equalsIgnoreCase("FP")) &&(!dakReceivedList[6].toString().equalsIgnoreCase("AP"))&&(!dakReceivedList[6].toString().equalsIgnoreCase("DC")))){ %>
 		
 		    <input type="hidden" name="redirValForConsoReplyAdd"	value="DakPendingPNCListRedir" />
 			<input type="hidden" name="fromDateFetch"	value="<%=fromDateFetch%>" />	
 			<input type="hidden" name="toDateFetch"	value="<%=toDateFetch%>"/>					
 		    <input type="hidden" name="DakNo_<%=dakReceivedList[1]%>"	value="<%=dakReceivedList[9]%>" />	 <!-- commonInputTypeHidden -->
 		    <input type="hidden" name="redirview" value="DakPncList">
 		    <input type="hidden" name="redirval" value="DakViewList" />					
 			 <button type="submit" class="btn btn-sm icon-btn btn-hover color-5" name="DakIdFromCR" formaction="ConsolidatedReply.htm"  id=<%="DakIdCR"+dakReceivedList[1]  %> value="<%=dakReceivedList[1] %>" 
 			  data-toggle="tooltip" data-placement="top" title="" data-original-title="Consolidated Reply" > 
			  &nbsp; Consolidated Reply &nbsp;
 			</button>	 
 			 <%}}%>
 						
 	 <!------------------------------------------ consolidatedReply Edit Action Check Start -------------------------------------------------------------------------->
  		<%
  		String EditType  = "Reply Edit";
  		if(dakReceivedList[6].toString().equalsIgnoreCase("RP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC") && dakReceivedList[20]!=null && dakReceivedList[20].toString().equalsIgnoreCase("P")
		  && dakReceivedList[40]!=null && dakReceivedList[40].toString().equalsIgnoreCase("R") && dakReceivedList[21]!=null && (dakReceivedList[21].toString().equalsIgnoreCase("N") || !dakReceivedList[6].toString().equalsIgnoreCase("FP"))){ %>
				<input type="hidden" name="fromDateFetch"	value="<%=fromDateFetch%>" />	
 			    <input type="hidden" name="toDateFetch"	value="<%=toDateFetch%>"/>	
		       <input type="hidden" name="redirValForConsoReplyEdit"	value="PNCListRedir" />
		       <input type="hidden" name="redirval" value="DakViewList" />	
		       <input type="hidden" name="redirview" value="DakPncList">
		     <button type="submit" class="btn btn-sm icon-btn btn-hover color-9" name="DakPnCReplyDataForEdit" formaction="ConsolidatedReplyEdit.htm"  value="<%=dakReceivedList[41]%>#<%=dakReceivedList[1] %>" 
 		      data-toggle="tooltip" data-placement="top" title="P&C Reply Edit" data-original-title="<%=EditType%>" > 
		      &nbsp; P&C Reply Edit &nbsp;
		     </button>	  
		<%}}%>		
<!-------------------------------------------  consolidatedReply Edit Action Check End -------------------------------------------------------------------------->

 <!------------------------------------------------------------------- Dak PNC List Actions End ----------------------------------------------------------------->
 		 
 <!------------------------------------------------------ Dak PNC Do List Actions Start ------------------------------------------------------------------------->
 
 	<%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakPncDoList")){ %>
 	
 	<!----------------------------DAK Close Action Check start --------------------------------------------------------------------------------------------------->  			
 	 <%  String EditType = null;
	   if(dakReceivedList[40]!=null && dakReceivedList[40].toString().equalsIgnoreCase("R")){ 
			 EditType="Approved Reply Edit";
	   }else if (dakReceivedList[40]!=null && dakReceivedList[40].toString().equalsIgnoreCase("D")){ 
				EditType="Returned Reply Edit";
	   }else{
			EditType = "Reply Edit";
	   }  %>
		  
         <%if(dakReceivedList[25]!=null && Long.parseLong(dakReceivedList[25].toString())!= 1  && dakReceivedList[20]!=null && dakReceivedList[20].toString().equalsIgnoreCase("P") ){%>
 		  <%if(dakReceivedList[6].toString().equalsIgnoreCase("DD")||dakReceivedList[6].toString().equalsIgnoreCase("DA")||dakReceivedList[6].toString().equalsIgnoreCase("DR") 
 			 &&((!dakReceivedList[6].toString().equalsIgnoreCase("RP")) &&(!dakReceivedList[6].toString().equalsIgnoreCase("FP")) &&(!dakReceivedList[6].toString().equalsIgnoreCase("AP"))&&(!dakReceivedList[6].toString().equalsIgnoreCase("DC")) )  ){ %>
 		
 			<input type="hidden" name="redirValForConsoReplyAdd"	value="PNCDOListRedir" />
 			<input type="hidden" name="redirval" value="DakViewList" />
 			<input type="hidden" name="redirview" value="DakPncDoList">	
 			<input type="hidden" name="fromDateFetch"	value="<%=fromDateFetch%>" />	
 			<input type="hidden" name="toDateFetch"	value="<%=toDateFetch%>"/>	
 			 <button type="submit" class="btn btn-sm icon-btn btn-hover color-5" name="DakIdFromCR"  
 			   formaction="ConsolidatedReply.htm"  id=<%="DakIdCR"+dakReceivedList[1]  %> value="<%=dakReceivedList[1] %>" data-toggle="tooltip" data-placement="top" title="" data-original-title="Consolidated Reply" > 
			   &nbsp; Consolidated Reply &nbsp;
 			</button>	 
 									  
 		    <%}}%>
<!------------------------------consolidatedReply Add Action Check End ---------------------------------------------------------------------------------------------->
 									
 <input type="hidden" name="DakNo_<%=dakReceivedList[1]%>"	value="<%=dakReceivedList[9]%>" />	 <!-- commonInputTypeHidden -->
 
  <!------------------------------In P&C Do when its allready then two option i give to edit and as well as forward if director approval R Start---------------------->									
 
 <%if((dakReceivedList[6].toString().equalsIgnoreCase("RP") || dakReceivedList[6].toString().equalsIgnoreCase("FP"))
	&& dakReceivedList[20]!=null && dakReceivedList[20].toString().equalsIgnoreCase("P") && dakReceivedList[40]!=null && dakReceivedList[40].toString().equalsIgnoreCase("R") ){%>
				
	<input type="hidden" name="redirValForConsoReplyEdit"	value="PNCDOListRedir" />
	<input type="hidden" name="redirval" value="DakViewList" />
 	<input type="hidden" name="redirview" value="DakPncDoList">	
 	<input type="hidden" name="fromDateFetch"	value="<%=fromDateFetch%>" />	
 			<input type="hidden" name="toDateFetch"	value="<%=toDateFetch%>"/>	
	<button type="submit" class="btn btn-sm icon-btn btn-hover color-9" name="DakPnCReplyDataForEdit"  
 	 formaction="ConsolidatedReplyEdit.htm"  value="<%=dakReceivedList[41]%>#<%=dakReceivedList[1] %>" data-toggle="tooltip" data-placement="top" title="P&C Reply Edit"  data-original-title="<%=EditType%>" > 
	 &nbsp; P&C Reply Edit &nbsp;
	</button>	  
 										  
   <%if( dakReceivedList[21]!=null && dakReceivedList[21].toString().equalsIgnoreCase("R") && !dakReceivedList[6].toString().equalsIgnoreCase("FP")) {%>				  
 	<input type="hidden" name="redirval" value="DakViewList" />
 	<button type="submit" class="btn btn-sm icon-btn btn-hover color-3" name="ForwardPNCDakId"  
 	formaction="ForwardPNCReply.htm"  id="" value="<%=dakReceivedList[1] %>" 
 	data-toggle="tooltip" data-placement="top" title="" data-original-title="Forward Reply" 
 	 onclick="return confirm('Are you sure to forward this DAK?');">
	&nbsp; Forward Reply &nbsp;
   </button>	 			
  <%} }%>		  
 
 <!-------------------------------------------------awaiting dir approval Msg Check Start--------------------------------------------------------------------->									
 		 
 		      				
                  	<%if(dakReceivedList[6].toString().equalsIgnoreCase("FP") && dakReceivedList[21]!=null && dakReceivedList[21].toString().equalsIgnoreCase("R")
 					&& dakReceivedList[20]!=null && dakReceivedList[20].toString().equalsIgnoreCase("P")&& dakReceivedList[40]!=null && dakReceivedList[40].toString().equalsIgnoreCase("R") ){%>
 					<span style="font-weight:bold;font-size:10px;color:green;padding-right:10px;padding-left:10px;">
 					awaiting dir approval
 					</span>
 					<%}%>
<!--------------------------------------------------------------     awaiting dir approval Msg Check End-------------------------------------------------------->							  

  	 <%if((((dakReceivedList[6].toString().equalsIgnoreCase("RP") || dakReceivedList[6].toString().equalsIgnoreCase("FP")) && dakReceivedList[40]!=null && !dakReceivedList[40].toString().equalsIgnoreCase("NA") && dakReceivedList[40].toString().equalsIgnoreCase("D")) 
  	   ||(dakReceivedList[6].toString().equalsIgnoreCase("AP")  && dakReceivedList[39]!=null)) && dakReceivedList[41]!=null &&  Long.parseLong(dakReceivedList[41].toString())>0 && !dakReceivedList[6].toString().equalsIgnoreCase("DC") 
 		&& dakReceivedList[20]!=null && dakReceivedList[20].toString().equalsIgnoreCase("P")){%>
 	    <input type="hidden" name="redirValForConsoReplyEdit"	value="PNCDOListRedir" />
 		<input type="hidden" name="redirval" value="DakViewList" />
 		<input type="hidden" name="redirview" value="DakPncDoList">					
 	<!-- Its allowed when not approved returned and also When approved with comment but never after Dak is closed-->
 		 <button type="submit" class="btn btn-sm icon-btn btn-hover color-9" name="DakPnCReplyDataForEdit"  
 			formaction="ConsolidatedReplyEdit.htm"  value="<%=dakReceivedList[41]%>#<%=dakReceivedList[1] %>"  data-toggle="tooltip" data-placement="top" title=""  data-original-title="<%=EditType%>" > 
			&nbsp; Consolidated Edit &nbsp;
		</button>	  
 	 <%}%>
 									
<!---------------------------------------------------------- consolidatedReply Edit Action Check End ------------------------------------------------------------->
 
 <!--------------------------------------------------   DAK Close Action Check start ----------------------------------------------------------------------------->
 	                          
 	  <%/*********If Dir Approved with Comment than Dak Close will be available with DakApprovedCommtPopUp *******/
 				String ApprovedCommtData = "--";
 				String ApprovedCommtCheckData = "NA";
 				if(dakReceivedList[6].toString().equalsIgnoreCase("AP")&& dakReceivedList[39]!=null){
 				ApprovedCommtCheckData = "ApproveCommtPopUp";
 				ApprovedCommtData = dakReceivedList[39].toString();
 				}%>
 		
 				<%if((!dakReceivedList[6].toString().equalsIgnoreCase("DC") &&  dakReceivedList[20]!=null && dakReceivedList[20].toString().equalsIgnoreCase("P")
 					&& ((dakReceivedList[21]!=null && dakReceivedList[21].toString().equalsIgnoreCase("R") && dakReceivedList[6].toString().equalsIgnoreCase("AP"))  
 					|| (dakReceivedList[21]!=null && dakReceivedList[21].toString().equalsIgnoreCase("N") && !dakReceivedList[6].toString().equalsIgnoreCase("AP"))))){%>
 					<input type="hidden" name="DakNoToClose_<%=dakReceivedList[1]%>"	value="<%=dakReceivedList[9] %>" />	
 					<input type="hidden" name="redirval" value="DakViewList" />
 			        <input type="hidden" name="redirview" value="DakPncDoList">						
 		      <button type="button" class="btn btn-sm icon-btn btn-hover color-11" data-toggle="tooltip" data-placement="top" data-original-title="Dak Close" 
 					data-ApprovedCommt-value="<%=ApprovedCommtData%>"  onclick="return DakCloseValidation('<%=dakReceivedList[1]%>','<%=ApprovedCommtCheckData%>', this,'<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>')">
                    &nbsp; Dak Close &nbsp;
 		     </button>	
 	        <%}}%>
 							 
 <!------------------------------------------------------DAK Close Action Check End --------------------------------------------------------------------------------->
 			 
 <!------------------------------------------------------DAK Close Status show case removed(this is removed as recently Dak Closed will go to DakClosed List) -------->			

 <!------------------------------------------------------ Dak PNC Do List Actions End ----------------------------------------------------------------->
		
 <!------------------------------------------------------ Dak Pending Reply List Actions Start ----------------------------------------------------------->
		
		<%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakPendingReplyList")){ %>
		  	<%if(!dakReceivedList[6].toString().toString().equalsIgnoreCase("RP") && !dakReceivedList[6].toString().toString().equalsIgnoreCase("FP") && !dakReceivedList[6].toString().toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().toString().equalsIgnoreCase("DC")){ %>
 					 <!-- Reply Display Condition and hide  Condition  -->
 				 <%if("ACTION".equalsIgnoreCase(dakReceivedList[10].toString().trim()) &&  MarkData[1]!=null  &&  MarkData[1].toString().equalsIgnoreCase("Y") && dakReceivedList[37]!=null && Long.parseLong(dakReceivedList[37].toString()) <= 0){ %>
 					 <input type="hidden" id="subject<%=dakReceivedList[1] %>" value="<%=dakReceivedList[15] %>">
 					 <button type="button" class="btn btn-sm icon-btn btn-hover color-5"  onclick="return replyModalOfMarker('<%=dakReceivedList[1] %>','<%=LoginEmpId%>','<%=dakReceivedList[32] %>','<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>','<%=MarkData[0] %>')" 
 						data-toggle="tooltip" data-placement="top" title="Reply">
 						 &nbsp; Marker Reply &nbsp;
					 </button>
 				 <%}} %>
 			<%if(MarkData[2]!=null  && MarkData[2].toString().equalsIgnoreCase("Y")){ %>
 			   <span <%if(MarkData[2]!=null  && MarkData[2].toString().equalsIgnoreCase("Y") &&  dakReceivedList[32]!=null && Long.parseLong(dakReceivedList[32].toString())>0) { %> style="color:#006400;"<%}else{ %>style="color:blue;"<%} %>>
 				CW
 				</span>
 				<%} %>
 			<%if(MarkData[3]!=null && !MarkData[3].toString().equalsIgnoreCase("N")){ %>
 				<span class="MsgByDir">	  
 				<%if(MarkData[3].toString().equalsIgnoreCase("D")){ %>
 				Pls Discuss With Director
 				<%}else if(MarkData[3].toString().equalsIgnoreCase("E")){ %>
 				Noted By Director
 				<%} %>
 			    </span>
 			<%} %>
 				  
 				  <%} %>
 				  
 	<!------------------------------------------------------ Dak Pending Reply List Actions End ----------------------------------------------------------------->
						
      <!---------------------------------------------------- Dak Replied List Actions Start ---------------------------------------------------------------------->
      
      <%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakRepliedList")){
    	  String repliedReply=(String)request.getAttribute("repliedReply");
    	 %>
    	<%if(repliedReply!=null && repliedReply.equalsIgnoreCase("DakRepliedToMe")) {%>
         <input type="hidden" id="subject<%=dakReceivedList[1] %>" value="<%=dakReceivedList[15] %>">
         <button type="button" class="btn btn-sm icon-btn btn-hover color-5"  onclick="return replyModalOfMarker('<%=dakReceivedList[1] %>','<%=LoginEmpId%>','<%=dakReceivedList[32] %>','<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>','<%=MarkData[0] %>')" 
 			data-toggle="tooltip" data-placement="top" title="Reply">
 		    &nbsp; Marker Reply &nbsp;
		 </button>
      <%}else{ %>
       <%if(MarkData[1]!=null && MarkData[1].toString().equalsIgnoreCase("Y") && !dakReceivedList[6].toString().equalsIgnoreCase("RM") && !dakReceivedList[6].toString().equalsIgnoreCase("RP") && !dakReceivedList[6].toString().equalsIgnoreCase("FP") && !dakReceivedList[6].toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC") ){ %>
 			<button type="button" class="btn btn-sm icon-btn btn-hover color-9" onclick="return Assign(<%=dakReceivedList[1]%>,<%=MarkData[0] %>,'<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>','DakReceivedViewList')"
 				data-toggle="tooltip" data-placement="top" title="Assign">
 				&nbsp; Assign &nbsp;
			</button>
		<%} %>
 		<%if(MarkData[1]!=null && MarkData[1].toString().equalsIgnoreCase("Y") && !dakReceivedList[6].toString().equalsIgnoreCase("RP") && !dakReceivedList[6].toString().equalsIgnoreCase("FP") && !dakReceivedList[6].toString().equalsIgnoreCase("RM") && !dakReceivedList[6].toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC")){ %>
 			<button type="button" class="btn btn-sm icon-btn btn-hover color-10" onclick="SeekResponse(<%=dakReceivedList[1]%>,<%=MarkData[0] %>,'<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>','DakReceivedViewList')"
 				data-toggle="tooltip" data-placement="top" title="SeekResponse">
 				&nbsp; Seek Response &nbsp;
			</button>
			<%}}} %>
			
      <!----------------------------------------------------- Dak Replied List Actions End ------------------------------------------------------------------->
			
		<!--------------------------------------------------- Dak Assigned List Actions Start ----------------------------------------------------------------->
		<%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakAssignedList")){ %>
		<%if(assigneddata!=null) {%>
		<%if(assigneddata[0]!=null && assigneddata[0].toString().equalsIgnoreCase("N")){ %>
 			<button type="button" class="btn btn-sm icon-btn btn-hover color-5"  onclick="return replyModal('<%=dakReceivedList[1]%>','<%=assigneddata[1]%>','<%=dakReceivedList[9]%>','<%=dakReceivedList[4] %>','DakReceivedViewList')" 
 				data-toggle="tooltip" data-placement="top" title="Reply">
				&nbsp; Assign Reply &nbsp;
 			</button>
 		<%}else if(assigneddata[0]!=null && assigneddata[0].toString().equalsIgnoreCase("Y")){ %>	
 			Replied
 		<%} %>		
			
	<!----------------------------------------------- DAK Marker SeekResponse Button Start ----------------------------------------------------------------------------> 	
									   
 		<%if( !dakReceivedList[6].toString().equalsIgnoreCase("RP") && !dakReceivedList[6].toString().equalsIgnoreCase("FP") && !dakReceivedList[6].toString().equalsIgnoreCase("RM") && !dakReceivedList[6].toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC")){ %>
 				<button type="button" class="btn btn-sm icon-btn btn-hover color-10" onclick="SeekResponse(<%=dakReceivedList[1]%>,<%=assigneddata[1] %>,'<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>','DakReceivedViewList')"
 					data-toggle="tooltip" data-placement="top" title="SeekResponse">
 				&nbsp; Seek Response &nbsp;
				 </button>
		<%}}} %>
		<!----------------------------------------------- DAK Marker Assign Button End ---------------------------------------------------------------------------------->
			
		<!----------------------------------------------- Dak Assigned List Actions End  --------------------------------------------------------------------------------->
					
		<!----------------------------------------------  Dak Seek Response List Actions Start  -------------------------------------------------------------------------->
		
		<%if(viewfrom!=null && viewfrom.equalsIgnoreCase("DakSeekResponseList")){ %>
		<%if(seekdata!=null) {%>
		<%if(seekdata[0]!=null && seekdata[0].toString().equalsIgnoreCase("N")){ %>
 			<button type="button" class="btn btn-sm icon-btn btn-hover color-5"  onclick="return SeekResponsereplyModal('<%=dakReceivedList[1]%>','<%=dakReceivedList[9]%>','<%=dakReceivedList[4] %>',<%=seekdata[1] %>,'DakReceivedViewList')" 
 				data-toggle="tooltip" data-placement="top" title="Reply">
				&nbsp; Seek Response Reply &nbsp;
 			</button>
 		<%}else if(seekdata[0]!=null && seekdata[0].toString().equalsIgnoreCase("Y")){ %>	
 			Replied
 		<%} %>			
					
	<!--------------------------------------------------------DAK Marker SeekResponse Button Start -----------------------------------------------> 									   
 		<%if( !dakReceivedList[6].toString().equalsIgnoreCase("RP") && !dakReceivedList[6].toString().equalsIgnoreCase("FP") && !dakReceivedList[6].toString().equalsIgnoreCase("RM") && !dakReceivedList[6].toString().equalsIgnoreCase("AP") && !dakReceivedList[6].toString().equalsIgnoreCase("DC")){ %>
 			<button type="button" class="btn btn-sm icon-btn btn-hover color-10" onclick="SeekResponse(<%=dakReceivedList[1]%>,<%=seekdata[1] %>,'<%=dakReceivedList[9] %>','<%=dakReceivedList[4] %>','DakReceivedViewList')"
 				data-toggle="tooltip" data-placement="top" title="SeekResponse">
 				&nbsp; Seek Response &nbsp;
			</button>
			<%}}}%>
      <!----------------------------------------------------------DAK Marker SeekResponse Button End ----------------------------------------------->
      
      
	<!--------------------------------------------------------DAK Enote Initiation status Start -----------------------------------------------> 									   
 		<%if(dakReceivedList[43]!=null && Long.parseLong(dakReceivedList[43].toString())>0){%>
 		<%if(dakReceivedList[45]!=null && dakReceivedList[45].toString().equalsIgnoreCase("Approved")){ %>
 			<span style="font-size: 16px; color: blue; margin: auto;">eNote <%=dakReceivedList[45].toString() %> </span>
			<%}else{%>
 			<span style="font-size: 16px; color: blue; margin: auto;">eNote Initiated by <%=dakReceivedList[44].toString() %> </span>
			<%}}%>
      <!----------------------------------------------------------DAK Enote Initiation status End ----------------------------------------------->
                    
       <!--------------------------------------------- Dak Seek Response List Actions End  ---------------------------------------------------------->
					
				  </p>
				</td>									
			  </tr>
		    </thead>
		  </table>
        </div>
      </div>
    </div>
  </form>
		
	  <!-- -----------DAK Preview Div Starts --------------------------- --> 
			 <div class="group" id="dakDetailsMod" >  
			   <details open>
		      <summary style="background-color: #F0FFFF;" role="button" tabindex="0" >
 	            <span style="color: black; font-size: 18px;"><b>DAK Details</b> </span> &nbsp;&nbsp;&nbsp;
		           <span style="color: blue;"><b>DAK Id :</b></span> &nbsp;&nbsp;<span style="color: black;" id="Dakno"><a class="font" href="javascript:void()" 
	 					          	style="color: #B8860B; text-decoration: underline; font-size: 16px; font-weight: bold;" onclick="TrackingStatusPageRedirect('<%=dakReceivedList[1] %>','DakReceivedViewList')">
                                    <% if (dakReceivedList[9] != null) { %>
                                    <%= dakReceivedList[9].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
		         </span> &nbsp;&nbsp;&nbsp;<span style="color:blue;"><b>Source :</b></span> &nbsp;&nbsp; <span style="color: black;" id="Source"><%if(dakReceivedList!=null && dakReceivedList[4]!=null){ %><%=dakReceivedList[4].toString() %><%}else{ %>-<%} %></span>
		         &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:blue;"><b>Subject :</b></span> &nbsp;&nbsp; <span style="color: black;" id="PreviewSubject"></span>
  	       </summary>
				    <div class="content">
					<div class="row replyRow"><!-- side by side enclosing END -->
					<div class="form-group DakPrev DataPart1" style=" display: inline-block;max-width: 1100px; padding-right: 50px;"><!-- Datapart1 Start -->
					<form action="#" method="post" autocomplete="off"  >
						<table style="width: 100%; margin-left: 10px;" class="previewTable table-hover">
							
							<tr>
								<th  style="padding: 8px;width:10px;" >Letter Type </th>
								<td  colspan="1"style="padding: 8px;width:400px;" id="lettertype"><%if(dakReceivedList!=null && dakReceivedList[2]!=null){ %><%=dakReceivedList[2].toString() %><%}else{ %>-<%} %></td>
								<th style="padding: 8px; margin-left: -50px;" >Priority</th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="Priority"><%if(dakReceivedList!=null && dakReceivedList[3]!=null){ %><%=dakReceivedList[3].toString() %><%}else{ %>-<%} %></td>
							</tr>
							<tr>
								<th style="padding: 8px;width:17%;" >Ref No </th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="LetterNo"><%if(dakReceivedList!=null && dakReceivedList[5]!=null){ %><%=dakReceivedList[5].toString() %><%}else{ %>-<%} %></td>
								<th style="padding: 8px" >Ref Date </th>
								<td colspan="2" style="padding: 8px;" class="tabledata" id="LetterDate"><%if(dakReceivedList!=null && dakReceivedList[7]!=null){ %><%=sdf.format(dakReceivedList[7]) %><%}else{ %>-<%} %></td>
							</tr>
							
							
							<tr>
							    <th style="padding: 8px;width:20%;" >KeyWord1 </th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="KeyWord1"><%if(dakReceivedList!=null && dakReceivedList[11]!=null){ %><%=dakReceivedList[11].toString() %><%}else{ %>-<%} %></td>
								<th style="padding: 8px; width:17%;" > KeyWord2 </th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="KeyWord2"><%if(dakReceivedList!=null && dakReceivedList[12]!=null){ %><%=dakReceivedList[12].toString() %><%}else{ %>-<%} %></td>
								
							</tr>
							
							<tr>
							    	
								<th style="padding: 8px;width:20%;" >KeyWord3 </th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="KeyWord3"><%if(dakReceivedList!=null && dakReceivedList[13]!=null){ %><%=dakReceivedList[13].toString() %><%}else{ %>-<%} %></td>
								<!-- <td style="width: 100px!important;"></td> --> <!-- Adjust the width as desired -->
								<th style="padding: 8px;width:17%;" > KeyWord4 </th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="KeyWord4"><%if(dakReceivedList!=null && dakReceivedList[14]!=null){ %><%=dakReceivedList[14].toString() %><%}else{ %>-<%} %></td>
								
							</tr>
							
							<tr>
							    <th style="padding: 8px;width:20%;" >Action Due</th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="ActionDueDate"><%if(dakReceivedList!=null && dakReceivedList[18]!=null){ %><%=sdf.format(dakReceivedList[18]) %><%}else{ %>-<%} %></td>
								<th style="padding: 8px;width:17%;" > Action Time </th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="ActionTime"><%if(dakReceivedList!=null && dakReceivedList[19]!=null){ %><%=outputFormat.format(dakReceivedList[19])%><%}else{ %>-<%} %></td>
							</tr>
							
								<tr>
							    <th style="padding: 8px;width:20%;" >Closing Authority</th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="ClosingAuthority"><%=ClosingAuthority %></td>
								<th style="padding: 8px;width:17%;" >Director Approval</th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="DirectorApproval"><%if(dakReceivedList!=null && dakReceivedList[21]!=null && dakReceivedList[21].toString().equalsIgnoreCase("R")){ %><%="Required" %><%}else if(dakReceivedList[21]!=null && dakReceivedList[21].toString().equalsIgnoreCase("N")){ %><%="Not Required"%><%}else{ %>-<%} %></td>
							</tr>
							
						<tr>
							    <th style="padding: 8px;width:20%;" >Subject </th>
								<td  colspan="6" style="padding: 8px;" class="tabledata" id="Subject"><%if(dakReceivedList!=null && dakReceivedList[15]!=null){ %><%=dakReceivedList[15].toString() %><%}else{%>-<%}%></td>
							
							</tr>
							
								<tr>
								 <th style="padding: 8px;width:20%;" >Brief on DAK </th>
									<td  colspan="6" style="padding: 8px;" class="tabledata" id="Remarks"><%if(dakReceivedList!=null && dakReceivedList[17]!=null){ %><%=dakReceivedList[17].toString() %><%}else{%>-<%}%></td>
								</tr>
						<%if(dakReceivedList!=null && dakReceivedList[23]!=null && dakReceivedList[6]!=null && dakReceivedList[6].toString().equalsIgnoreCase("DC")){ %>
						   		<tr >
								 <th style="padding: 8px;width:20%;" >Closing Comment </th>
									<td  colspan="6" style="padding: 8px;" class="tabledata" id="closingcomment"></td>
								</tr>
							<%} %>	
							<%if(dakReceivedList!=null && dakReceivedList[6]!=null && dakReceivedList[6].toString().equalsIgnoreCase("DC")){ %>
								<tr >
								 <th style="padding: 8px;width:20%;" >Closed By </th>
									<td  colspan="6" style="padding: 8px;" class="tabledata" id="closedBy"></td>
								</tr>
							<%} %>
						</table>
						<div class="row">
						<label style="text-align: left; color:#114A86; margin-left:33px; font-size: 25px;">Link DAK</label>
	  	        <%if(dakReceivedList!=null && dakReceivedList[24]!=null && Integer.parseInt(dakReceivedList[24].toString())>0) {%>
	  	        <div class="col-md-6" id="AllDakLinkDisplay" style="position: relative; float: left; width: 100%;"> 
	  	      		</div>
	  	      		<%} %>
	  	      		<input type="hidden" name="dakId" id="dakidvalueforlist" value="" />
	  	      		<input type="hidden" name="EmpId" id="empidvalueforlist" value="" />
  	      <!-- 	</div>Datapart2 End -->
  	      	</div>
				
						<input type="hidden"  name="TicketId1" id="TicketId1" value=""> 
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                  </form><br><br>
                  <%if(dakReceivedList!=null &&dakReceivedList[22]!=null && Integer.parseInt(dakReceivedList[22].toString())>0){ %>
                  <div class="dakmainDocumentsTab" style="width: 90%;">
                  <div class="row col-md-12"  style="float:left!important;">
                  <div class="form-group group2 col-md-3" id="maindakdocslabel"  style=" width: 100%; display: none; float: left !important; ">
                 	<label><b>Main Document :</b></label></div>
                 	<div class="col-md-9 downloadDakMainReplyAttachTable" id="maindakdocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	      		</div>
                 	</div>
                 	</div>
                 	<div class="daksubDocumentsTab" style="width: 90%;">
                 	<div class="row col-md-12"  style="float:left!important;">
                 	<div  class="form-group group2 col-md-3" id="subdakdocslabel" style="width: 100%; display: none; float: left; ">
                 	<label ><b>Enclosures :</b></label></div>
                 	<div class="col-md-9 downloadsubDakReplyAttachTable" id="subdakdocs"  style="display: inline-block; position: relative; float: left; width: 100%;"> 
	  	      		</div>
                 	</div>
                 	</div>
                 	<%} %>
                 	
  	      	</div><!-- Datapart1 End -->
  	      	<%if(dakReceivedList!=null && dakReceivedList[6]!=null && (dakReceivedList[6].toString().trim().equalsIgnoreCase("DD")  || dakReceivedList[6].toString().trim().equalsIgnoreCase("DA")  || dakReceivedList[6].toString().trim().equalsIgnoreCase("DR")  || dakReceivedList[6].toString().trim().equalsIgnoreCase("RM") || dakReceivedList[6].toString().trim().equalsIgnoreCase("FP")  || dakReceivedList[6].toString().trim().equalsIgnoreCase("RP") ||  dakReceivedList[6].toString().trim().equalsIgnoreCase("AP")  || dakReceivedList[6].toString().trim().equalsIgnoreCase("DC") )){ %>
  	      	<div class="form-group DakPrev DataPart2" id="dakPrevDataPart2" style="margin-right: 15px;"><!-- Datapart2 Start -->
  	            <div style="overflow: auto; max-height: 500px!important;"> 
                	 <h6 style="font-weight: bold; padding: 5px;; font-size: 15px;color:#353935;float:left;">Employees (
                	  <span class="color-box markersinfo-box"></span>
                	  :
                      <span class="label">Markers Info</span>
                      <span class="color-box markersaction-box"></span>
                	  :
                	  <span class="label">Markers Action</span>
                      <span class="color-box facilitators-box"></span>
                      :
                     <span class="label">Facilitators</span>
                     <span class="color-box seekresponse-box"></span>
                      :
                     <span class="label">Seek Response</span>
                      )
    </h6>
                	 <form action="#"  method="POST" >
	  	        <div class="row" id="DistributedListDisplay" style="display: inline-block; position: relative; left: 0; text-align: left; width: 90%; margin-left: 5px;"> 
	  	      		</div>
	  	      		<input type="hidden" name="dakId" id="dakidvalueforlist" value="" />
	  	      		<input type="hidden" name="EmpId" id="empidvalueforlist" value="" />
	  	      		</form>
            </div> 
  	      	</div><!-- Datapart2 End -->
  	      	<%} %>
  	      	</div><!-- side by side enclosing END -->
  	      	</div>
  	      	</details>  
  	      
  	      	<div class="row btnReplyDetailsPreview" >
  	      	 <details>
		      <summary role="button" tabindex="0" style="margin-left: 15px;">
  	      	  <span style="color: black; font-size: 18px;"><b>Marker Reply</b> </span>  <span class="spacermarker">&nbsp;</span>
			    </summary>
			     <div class="content" style="margin-left: 15px;">
  	     <div class="DakReply" style="margin-left: 15px;">
			</div>
			</div>
			 </details>   
  	      </div>
  	      <div class="row btnCWReplyDetailsPreview">
  	      <details>
		      <summary role="button" tabindex="0" style="margin-left: 15px;">
 	        <span style="color: black; font-size: 18px;"><b>CW Reply</b> </span> <span class="spacercsw">&nbsp;</span>
  	       </summary>
  	        <div class="content" style="margin-left: 15px;">
  	      <div class="CaseworkerDakReplyData" style="margin-left: 15px;" >  
				</div>
				</div>
				</details>
  	      </div>
  	      <div class="row btnPNCDOReplyDetailsPreview" >
  	       <details>
		      <summary role="button" tabindex="0" style="margin-left: 15px;">
  	      	   
 	       <span style="color: black; font-size: 18px;"><b>P&C DO Reply</b> </span> <span class="spacerpnc">&nbsp;</span>
			    </summary>
			     <div class="content" style="margin-left: 15px;">     
  	      <div class="group" id="pncDoReplyMod" >	
		    <form action="#" method="post" id="pncDoReplyPreviewForm" autocomplete="off"  >
		       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		       <div class="modal-body" align="center" style="margin-top:-4px;">
		       
		       <div class="form-inline">
		       <div><h4><b><span id="pncdoreplypersonname" style="color:#8B0000; font-size: 20px;"></span></b>, <b><span id="pncdoreplydeignation" style="color: #8B0000; font-size: 20px;"></span>, <span id="createddate" style="font-size: 20px;"></span></b></h4></div>
		                <!--     <label style="font-weight:bold;font-size:14px;float:left;">Reply :</label> -->
  	      				<textarea class="form-control pncDoReplyData" id="pncDoRepliedData" style="min-width: 100% !important;min-height: 30vh;background-color:white;"   readonly="readonly"  maxlength="500" > </textarea>
  	      			<!--  <label style="font-weight:bold;font-size:14px;float:left;">Document :</label>  -->
  	      			<!-- <div class="col-md-2"><br>Document :</div> -->
  	               
  	               <!--  <div class="col-md-5 "> -->
  	               <br>
  	      			     <table class="pncDoAttachedFilesTbl" >		
  	      			        <!-- data will be filled using ajax -->  	      				
			  	         </table>
  	                <!--  </div> -->
  	      
  	      			<br>
  	      
  	      		</div>
				
		       
		       </div>
		    </form>
		    </div>
		    </div>
		    </details>
  	      </div>
  	      <div class="row btnSeekResponseReplyDetailsPreview">
  	       <details>
		      <summary role="button" tabindex="0" style="margin-left: 15px;">
  	      	 
 	       <span style="color: black; font-size: 18px;"><b>Seek Response Reply</b> </span><span class="spacerseek">&nbsp;</span>
			      </summary>
			       <div class="content" style="margin-left: 15px;">
  	      <div class="DakSeekResponseReply" style="margin-left: 15px;">
			</div>
			</div>
			</details>
  	      </div>
					</div>
					
					 <!-- Modal -->
<div id="myModalPreview"  style="margin-left: 10%; margin-top: 50px; width: 80%;"  class="modal">
  <!-- Modal content -->
   <div  class="modal-header" style="background-color: white; border: 1px solid black;">
        <h5 class="modal-title" ></h5>
        <span style="margin-left: 85%; color: red; margin-top: 2px;"></span>
        <button type="button" style="color:red;" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
  <div class="modal-content" >
    <div id="modalbody" style="border: 1px solid black;"></div>
  </div>
</div>
  


<!-- PDF Viewer Modal -->
<div class="modal fade" id="myModallarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
<form action="#">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
      <span style="color: red;">File is too Large to Open & Please download the document !..</span><br><br>
        <button type="submit" class="btn btn-sm icon-btn" name="downloadbtn" id="largedocument" value="'+result[1]+'" formaction="OpenAttachForDownload.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>

<!----------------------------------------------------   Common Reply  Edit start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="replyCommonEditModal" tabindex="-1" role="dialog" aria-labelledby="replyCommonEditTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 85% !important; min-height: 50vh !important; margin-top:100px !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle" style="color:white;"><b>DAK Reply Edit</b></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReplyEditAndDel" id="attachformReplyEditAndDel" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control replyDataInEditModal"  name="replyEditRemarksVal" style="min-width: 110% !important;min-height: 30vh;"  id="replyEditRemarksData" required="required"  maxlength="1000" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      	<!-- new file add start -->
  	      	<div class="row">
  	      	<div class="col-md-5 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_editreply_addbtnMark btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_editreplyMark">
			  	      			<td><input class="form-control" type="file" name="dak_replyEdit_document"  id="dakdocumenteditreply" accept="*/*"></td>
			  	      				<td><button type="button" class="tr_editreply_subMark btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      </div>
  	      	<!-- new file add end -->

  	      
  	       	<!-- old file delete,open or download start -->
  	      	<div class="col-md-5 " style="float:left">
  	      	<br>
  	      	<table class="ReplyEditAttachtable" style="border:none" >
					
					<tbody id="ReplyAttachEditDataFill">
					
					
					</tbody>
				</table>
  	        </div>
  	        </div>
  	      	<!-- old file delete,open or download end -->
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  	<!-- for delete -->
  	      		 <input type="hidden" id="replyAttachmentIdFrDelete" name="replyAttachmentIdVal" value="" />
  	      		<input type="hidden" id="replyIdFrAttachDelete" name="replyIdVal" value="" />
  	      		<input type="hidden" name="DakId" value="<%=dakReceivedList[1]%>">
  	      		<!-- for edit -->
  	      		  <input type="hidden" name="dakReplyIdValFrReplyEdit"  id="dakReplyIdOfReplyEdit" value="" >
  	      		  <input type="hidden" name="dakIdValFrReplyEdit"  id="dakIdOfReplyEdit" value="" >
  	      		    <input type="hidden" name="empIdValFrValueEdit" id="empIdOfReplyEdit" value="">
  	      		    <input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
  	      		   
  	      		    
  	      			<input type="button" formaction="DAKReplyDataEdit.htm"  class="btn btn-primary btn-sm submit " id="dakCommonReplyEditAction"   onclick="return dakReplyEditValidation()" value="Submit" > 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
	
	<!-- Dak Reply view More Modal Start -->
	
	<div class="modal fade my-modal" id="replyViewMore" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	 <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    	<div class="modal-content" style="min-height: 90%!important;">
	 	     
	 	      <div class="modal-header" style="background-color: #114A86;">
				    	<h4 class="modal-title" id="model-card-header" style="color: white;">Reply Data&nbsp; <span id="replierName"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:white;">
				          <span aria-hidden="true">×</span>
				        </button>
				    </div>
	 	     
	 	  
	  	     <div class="modal-body" style="padding: 0.5rem !important;">
	  	       <div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
	  	           <div class="row" id="replyDetailsDiv">
	  	      		</div>
	  	      	</div>	
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		<!-- Dak Reply view More Modal End -->
		
		<!---------------------------------------------------- Common DakAssignReply  Edit Modal start    ----------------------------------------------------------->
  
  <div class="modal fade my-modal" id="DakAssignreplyCommonEditModal" tabindex="-1" role="dialog" aria-labelledby="replyCommonEditTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 95% !important; min-height: 70vh !important; margin-top:100px !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle" style="color: white;"><b>DAK Assign Reply Edit</b></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReplyEditAndDel" id="cswattachformReplyEditAndDel" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control assignReplyDataInEditModal"  name="assignReplyEditedVal" style="min-width: 110% !important;min-height: 30vh;"  id="cswreplyEditRemarksData" required="required"  maxlength="500" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      	<!-- new file add start -->
  	      	<div class="row">
  	      	<div class="col-md-5 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_editreply_addbtnAssign btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_editreplyAssign">
			  	      			<td><input class="form-control" type="file" name="dak_replyEdit_document"  id="cswdakdocumenteditreply" accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_editreply_subAssign btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      </div>
  	      	<!-- new file add end -->

  	      
  	       	<!-- old file delete,open or download start -->
  	      	<div class="col-md-5 " style="float:left">
  	      	<table class="ReplyEditAttachtable" style="border:none" >
					
					<tbody id="cswReplyAttachEditDataFill">
					
					
					</tbody>
				</table>
  	        </div>
  	        </div>
  	      	<!-- old file delete,open or download end -->
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  	<!-- for delete -->
  	      		 <input type="hidden" id="cswreplyAttachmentIdFrDelete" name="replyAttachmentIdVal" value="" />
  	      	     <input type="hidden" id="cswreplyIdFrAttachDelete" name="replyIdVal" value="" />
  	      		   <!-- for edit -->
  	      		  <input type="hidden" name="dakAssignReplyIdValue"  id="dakAssignReplyIdEdit" value="" >
  	      		  <input type="hidden" name="dakIdFrEdit"  id="dakIdOfAssignReplyEdit" value="" >
  	      		    <input type="hidden" name="empIdFrEdit" id="empIdOfAssignReplyEdit" value="">
  	      		    <input type="hidden" name="dakAssignIdFrEdit" id="dakAssignIdReplyEdit" value="">
  	      		    <input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
  	      		    
  	      			<input type="button" formaction="DAKAssignReplyDataEdit.htm"  class="btn btn-primary btn-sm submit " id="cswdakCommonReplyEditAction"   onclick="return dakAssignReplyEditValidation()" value="Submit" > 
  	      	
  	      	
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
	
	<!-- -----------------------------------------------------------------------------    Common DakAssignReply  Edit Modal End ------------------------------------------- -->
 
 
  <!-------------------------  Dak CSW Reply View more Modal Start    ----------------------------------------------------------->
	<div class="modal fade my-modal" id="replyCSWViewMore" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	 <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    	<div class="modal-content" style="min-height: 90%!important;">
	 	     
	 	      <div class="modal-header" style="background-color: #114A86;">
				    	<h4 class="modal-title" id="casemodel-card-header" style="color: white;">Assign Reply Data&nbsp; <span id="cswreplierName"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
				          <span aria-hidden="true">×</span>
				        </button>
				    </div>
	 	  
	  	     <div class="modal-body" style="padding: 0.5rem !important; height: 50% !importatnt;">
	  	       <div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
	  	           <div class="row" id="replyCSWViewMoreDetailsDiv">
	  	      		</div>
	  	      	</div>	
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  DakCSW  Reply View more Modal end    ----------------------------------------------------------->
		<!-- Marker PDF Viewer Modal -->
<div class="modal fade" id="myModalMarkerlarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
<form action="#">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
      <span style="color: red;">File is too Large to Open & Please download the document !..</span><br><br>
        <button type="submit" class="btn btn-sm icon-btn" name="markerdownloadbtn" id="markerlargedocument"  formaction="ReplyDownloadAttach.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>

		
		
		
		<!-- Case Worker PDF Viewer Modal -->
<div class="modal fade" id="myModalCSWlarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
<form action="#">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
      <span style="color: red;">File is too Large to Open & Please download the document !..</span><br><br>
        <button type="submit" class="btn btn-sm icon-btn" name="cswdownloadbtn" id="cswlargedocument"  formaction="ReplyCSWDownloadAttach.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>

  
  <!--P&C DO Reply PDF Viewer Modal -->
<div class="modal fade" id="myModalPnCReplylarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
<form action="#">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
      <span style="color: red;">File is too Large to Open & Please download the document !..</span><br><br>
        <button type="submit" class="btn btn-sm icon-btn" name="pncReplyDownloadBtn" id="PnClargedocument"  formaction="PnCReplyDownloadAttach.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>

		<!----------------------------------------------------  Dak Seek Response Reply View more Modal Start    ----------------------------------------------------------->
	<div class="modal fade my-modal" id="SeekResponsereplyViewMore" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	 <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    	<div class="modal-content" style="min-height: 90%!important;">
	 	     
	 	      <div class="modal-header" style="background-color: #114A86;">
				    	<h4 class="modal-title" id="model-card-header" style="color: white">Seek Response Reply Data&nbsp; <span id="SeekResponsereplierName"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
				          <span aria-hidden="true">×</span>
				        </button>
				    </div>
	 	     
	 	  
	  	     <div class="modal-body" style="padding: 0.5rem !important;">
	  	       <div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
	  	           <div class="row" id="SeekResponsereplyDetailsDiv">
	  	      		</div>
	  	      	</div>	
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  Dak Seek Response Reply View more Modal Start    ----------------------------------------------------------->
			
			
			 <!----------------------------------------------------  Dak Subject View more Modal Start    ----------------------------------------------------------->
	<div class="modal fade my-modal" id="SubjectViewMore" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	 <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    	<div class="modal-content" style="min-height: 90%!important;">
	 	     
	 	      <div class="modal-header" style="background-color: #114A86;">
				    	<h4 class="modal-title" id="model-card-header" style="color: white">Subject &nbsp; <span id="replierName"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
				          <span aria-hidden="true">×</span>
				        </button>
				    </div>
	 	     
	 	  
	  	     <div class="modal-body" style="padding: 0.5rem !important;">
	  	       <div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
	  	           <div class="row" id="SubjectDiv">
	  	      		</div>
	  	      	</div>	
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  Dak Reply View more Modal Start    ----------------------------------------------------------->
			
			<!----------------------------------------------------   Reply  Modal Start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="exampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 95% !important; min-height: 70vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color:white;">DAK Reply</span></b>
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><span style="color: white;">DAK Id:</span></b> &nbsp;&nbsp;<span style="color: white;" id="RecievedListDakNo">
		         </span> &nbsp;&nbsp;&nbsp;<b><span style="color: white;">Source :</span></b> &nbsp;&nbsp; <span style="color: white;" id="RecievedListSourceNo"></span></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReply" id="attachformReply" enctype="multipart/form-data" method="post" >
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	         
  	      
  	      		   <div class="col-md-12" align="left" style="margin-left: 0px;width:100%;">
  	      	
  	      		<label style="font-weight:bold;font-size:16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<!-- <div class="col-md-2">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></div> -->
  	      		     <div class="col-md-9">
  	      				<textarea class="form-control replyTextArea"  name="replyRemarks" style="min-width: 135% !important;min-height: 30vh;"  id="reply" required="required"  maxlength="1000"  oninput="checkCharacterLimit()"> </textarea>
  	      			</div>
  	      			<br>
  	      				<label style="font-weight:bold;font-size:16px;">Document :</label>
  	      		
  	      		<div class="row">
  	      		    <!-- new file add start -->
  	      			<div class="col-md-5 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_clone_addbtnMark btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_cloneMark">
			  	      			<td><input class="form-control" type="file" name="dak_reply_document"  id="dakdocumentreply" accept="*/*"></td>
			  	      				<td><button type="button" class="tr_clone_subMark btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      			</div>
  	      			<!-- new file add end -->
  	      			
  	      			<!--copy files attached & delete those copy Start-->
  	      			<div class="col-md-5 " style="float:left;margin-top:-42px;">
  	      				<br>
  	      	       <table class="ReplyCopyAttachtable" style="border:none;" >
					
					<tbody id="ReplyCopyAttachDataFill">
					
					
					</tbody>
					</table>
  	      			</div>
  	      			<!--copy files attached & delete those copy End-->
  	      			<div>
  	      			<input type="radio" name="Mail" checked="checked" value="N" onclick="DakReplyMailSent()"> No Mail&nbsp;&nbsp;&nbsp;
  	      			<input type="radio" name="Mail"  value="L" onclick="DakReplyMailSent()"> Lab Mail&nbsp;&nbsp;&nbsp;
  	      			<input type="radio" name="Mail"  value="D" onclick="DakReplyMailSent()"> Drona Mail
  	      			</div>
  	      		</div>
  	     		
  	     		 <div class="row"  id="MailSent" style="display: none;">
  	     		<div class="col-md-6"></div>
  	      		<div class="col-md-3">
				<label style="font-size: 15px;"><b>Sender MailId</b></label>
				<input class="form-control" type="text" name="ReplyPersonSentMail" id="ReplyPersonSentMail" readonly="readonly" value="<%if(MailSentDetails!=null && MailSentDetails[0]!=null){%><%=MailSentDetails[0].toString()%><%}%>">
				</div>
  	      		<div class="col-md-3">
  	      		<label style="font-size: 15px;"><b>Receiver MailId</b></label>
  	      			<select class="form-control selectpicker ReplyReceivedMail "  id="ReplyReceivedMail" multiple="multiple" data-live-search="true"  required="required"  name="ReplyReceivedMail">
  	      				<option value="select">Select</option>
  	      				 <%if (MailReceivedEmpDetails != null && MailReceivedEmpDetails.size() > 0) {
												for (Object[] obj : MailReceivedEmpDetails) {
											%>
											<option value="<%=obj[2]%>"><%=obj[2].toString() %></option>
											<%}}%> 
  	      				</select>
  	      			</div>
  	      		</div>
  	     		
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  <input type="hidden" name="dakIdValFrReply"  id="dakIdOfReply" value="" >
  	      		    <input type="hidden" name="EmpIdValFrValue" id="empIdOfReply" value="">
										<!-- codee -->
					<input type="hidden" name="PageRedirectData" id="PageRedirByReply" value="">
  	      		    <input type="hidden" name="RowRedirectData" id="RowRedirByReply" value="">
  	      		    
					<input type="hidden" id="AttachsFromDakAssigner" name="AttachmentsFileNames" value="">

				<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
	 
					<input type="hidden" id="ReplyMailSubject" name="ReplyMailSubject" value="">
					<input type="hidden" id="Hosttype" name="Hosttype" value="">
  	      		    
  	      			<input type="button" formaction="DAKReply.htm"  class="btn btn-primary btn-sm submit" id="sub" value="Submit" name="sub"  onclick="return dakReplyValidation()" > 
  	      		  </div>
  	      		</div>
  	      		<br>
  	
  	      	</form>
      <!-- -----------DAK MultipleCaseworkerReply Of Specific MarkerDiv Within another Modal START --------------------------- --> 	
		 <div class="group" id=CSWReplyOfParticularMarker style="display:none;">	
		 	<form action="#" method="post" autocomplete="off" id="CSWOfParticularMarkerPreviewForm" >
		 	   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	<div class="modal-body" align="center" style="margin-top:-4px;">
				<div class="col-md-12" id="MarkerReplyModalCaseworkerPreview">
				<h5>Facilitator's Reply Details <span style="color:blue;" class="MarkerNameAndDesigDisplay"></span></h5>
				<div class="MarkerCaseworkersDakReplyData"  style="margin-left: 0px;width:100%;">  
				<!-- all the datas inside this is filled using javascript -->
				</div>
				</div>
					</div>		
					</form>
			
		 </div>
		  <!-- -----------DAK MultipleCaseworkerReply Of Specific MarkerDiv Within another Modal  END--------------------------- --> 
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 
<!----------------------------------------------------  Reply  Modal End    ----------------------------------------------------------->
 
 
 <!-- ------------------------------------------------------------------------------------------Assign Modal Start ------------------------------------------------------------------------------------------>
					

   <div class="modal fade my-modal" id="exampleModalAssign"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" >
 	    <div class="modal-content" style="height: 400px;">
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color: white;">DAK Assign</span></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color: white;">DAK Id:</span> &nbsp;&nbsp;<span style="color: white;" id="DakNo"></span> &nbsp;&nbsp;&nbsp;<span style="color:white;">Source :</span> <span style="color: white;" id="Sourcetype"></span></h5> </div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" ><br>
  	      	<form action="DakAssign.htm" method="post" id="AssignForm">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="row">
  	      		<div class="col-md-3">Facilitator</div>
  	      		<div class="col-md-9">
  	      			<select class="form-control selectpicker cswempidSelect"  id="DakCaseWorker" multiple="multiple" data-live-search="true"  required="required"  name="DakCaseWorker">
  	      								
  	      				</select>
  	      			</div><br><br><br>
  	      			<div class="col-md-3">Remarks</div>
  	      		<div class="col-md-9">
  	      				<textarea class="form-control" style="height: 100px;;"   name="remarks"  id="remarks" required="required"  maxlength="255" > </textarea>
  	      			</div>
  	      			<input type="hidden" name="DakMarkingId" id="DakMarkingdakId" value="">
  	      			<input type="hidden" name="DakMarkingIdsel" id="DakMarkingIdsel" value="">
  	      			<input type="hidden" name="RedirectValue" id="RedirectValue" value="">
					<input type="hidden" id="PageRedirByAssign"  name="PageRedireData" value="">
					<input type="hidden" id="RowRedirByAssign" name="RowRedireData" value="">
					<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
					
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return DakAssignSubmit()"> 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
  
  
  
  <!-- -------------------------------------------------------------------------------------------------Assign Modal End  ----------------------------------------------------------------------------> 
			
			 <!-- ------------------------------------------------------------------------------------------SeekResponse Modal Start ------------------------------------------------------------------------------------------>
					

   <div class="modal fade my-modal" id="exampleModalSeekResponse"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" >
 	    <div class="modal-content" style="height: 400px;">
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color: white;">DAK SeekResponse</span></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color: white;">DAK Id:</span> &nbsp;&nbsp;<span style="color: white;" id="SeekDakNo"></span> &nbsp;&nbsp;&nbsp;<span style="color:white;">Source :</span> <span style="color: white;" id="SeekSourcetype"></span></h5> </div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" ><br>
  	      	<form action="DakSeekResponse.htm" method="post" id="SeekResponseForm">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="row">
  	      		<div class="col-md-3">Employee</div>
  	      		<div class="col-md-9">
  	      			<select class="form-control selectpicker seekResponseempidSelect"  id="DakSeekResponseEmployee" multiple="multiple" data-live-search="true"  required="required"  name="DakSeekCaseWorker">
  	      				
  	      				</select>
  	      			</div>
  	      			<input type="hidden" name="DakMarkingId" id="SeekResponseDakMarkingdakId" value="">
  	      			<input type="hidden" name="DakMarkingIdsel" id="SeekResponseDakMarkingIdsel" value="">
  	      			<input type="hidden" name="SeekResponseRedirectVal" id="SeekResponseRedirectVal" value=""> 
					<input type="hidden" name="PageValBySeekRepsonse" id="PageRedirBySeekRepsonse" value="">
  	      			<input type="hidden" name="RowValBySeekRepsonse" id="RowRedirBySeekRepsonse" value=""> 
  	      			<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
					
					
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return DakSeekResponseSubmit()"> 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
  
  
  
  <!-- -------------------------------------------------------------------------------------------------Assign Modal End  ---------------------------------------------------------------------------->
			<!----------------------------------------------------  DAK Dir Approval Action Change or Marker DAK Close WITHOUT Dir Approval Start ----------------------------------------------------------->

	    <div class="modal fade my-modal " id="DirectorApprovalActionChange" tabindex="-1" role="dialog" aria-labelledby="DirectorApprovalActionChange" aria-hidden="true">
	 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump " role="document"  >
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header"  style="background: linear-gradient(to bottom, #5691c8, #457fca);max-height:55px;">
	 	        <h5 class="modal-title" style="margin-left: 150px;" id="ApprovalAuthorityModalTitle"><b style="color:white;">Approval Authority</b> </h5>
	  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	          <form action="#" id="DakDirApprForwardOrDakClose">
	  	       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	  	          <div class="modal-body" style="min-height: 200px!important;">
	  	            <div class="row">
			  	  <div class="col-md-10 DirApproval"  style="display: flex; align-items: center;">
			  	    <label style="margin-left: 3px;font-weight:bold;font-size: 14px;color: black;">Director Approval&nbsp;&nbsp;&nbsp;: </label>
									&nbsp;&nbsp;&nbsp;
									 <div class="col-md-6">
                                          <select class="form-control selectpickerSimple" id="DirectorApprovalSelVal" 
                                        style="width:100%!important;" required="required" name="dirApprovalValFrmMarker" onchange="AuthorityDakButtonSwitch()">
											<option  value="R">Required</option>
											<option  value="N">Not Required</option>
										</select>
										</div>
				</div>
				
								
							                       
                <div class="col-md-10 ClosingCommt" id="DakClosingComment" style="display:none;">
	  	            	<label  style="margin-left: 3px;font-weight:bold;font-size: 14px;color: black;">Closing Comment&nbsp;&nbsp;&nbsp;:</label>
	  	      		   <textarea class="form-control DakCloseCommtInput" id="closingCommtWithoutDirAprv" name="DakClosingCommtByMarker"
                                 style="width:98%;height:300px;background-color:white;margin-right:-12px;margin-left:5px;" maxlength="500"></textarea>
                            
	  	      		</div>
					
	  	      		  		
				  </div>
	  	      		
                     <div class="col-md-12" align="center"><br>
                                
               <!-- Input hidden Data for Validation -->       
                    <input type="hidden" id="dakStatusAppend" value="">
                    <input type="hidden" id="markingIdAppend" value="">
                    <input type="hidden" id="noOfActionMarkers" value="">
                    <input type="hidden" id="replyCountOfActionMarkers" value="">
                    
                      <!-- Input hidden Data for Insert -->
                    <input type="hidden" id="dakIdFrClose" name="dakIdForMarkerAction" value="">
                    <input type="hidden" id="fromDateRedir" name="fromDateFetch" value="">
                    <input type="hidden" id="toDateRedir" name="toDateFetch"  value="">          
         			<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
                                
                                
                    <button type="button" style="display:none" class="btn btn-success btn-sm" id="DakApprovalForwardByMarker" 
                     formAction="DakApproveForwardByMarker.htm" onclick="ForwardDakForDirApprovalByMarker()">Submit</button>            
     
                    <button type="button" style="display:none" class="btn btn-danger btn-sm delete" id="DakCloseApprovalNotRequired" 
                    formaction="DakCloseByMarker.htm" onclick="MarkerCloseWithoutDirApproval()" >DAK Close</button> 
                    
                    </div>
                     
	  	      		
	  	      </div>
 
	  	      </form>
	  	     </div>
	  	    </div>
		   </div>
<!----------------------------------------------------  DAK Dir Approval Action Change or Marker DAK Close WITHOUT Dir Approval End ----------------------------------------------------------->
  
<!----------------------------------------------------  Marker DAK Close WITH APPROVE OR WITH APPROVE COMMT Modal Start  ----------------------------------------------------------->

	    <div class="modal fade my-modal " id="CommtOfDirApprovFrMarkerClose" tabindex="-1" role="dialog" aria-labelledby="CommtOfDirApprovFrMarkerClose" aria-hidden="true">
	 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  >
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header"  style="background: linear-gradient(to bottom, #5691c8, #457fca);max-height:55px;">
	 	        <h5 class="modal-title" style="margin-left: 150px;" id="directorCommentModalTitle"><b style="color:white;">Director's Comment</b> </h5>
	  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body" style="min-height: 400px!important;">
	  	            <div class="row" id="ApproveCommentMod" >
	  	      		   <textarea class="form-control ApproveCommtDisplay" readonly="readonly"  
                                 style="width:98%;height:300px;background-color:white;margin-right:-12px;margin-left:5px;" maxlength="500"></textarea>
                            
	  	      		</div>
	  	      		
                     <div class="col-md-12" align="center">
                            
                                <br>
                    <button type="button" class="btn btn-danger btn-sm delete"  onclick="return dakCloseAfterPopUp()" >DAK Close</button>
                    </div>
                     
	  	     
	  	      		
	  	      		
	  	      </div>
	  	     </div>
	  	    </div>
		   </div>
		
<!----------------------------------------------------  Marker DAK Close  WITH APPROVE OR WITHOUT APPROVE COMMT Comment Modal End     ----------------------------------------------------------->
 <!----------------------------------------------------  Marker  DAK Close With  Director Approve &&  Closing Comment Modal Start  ----------------------------------------------------------->

	    <div class="modal fade my-modal " id="DakCloseWithAPModal" tabindex="-1" role="dialog" aria-labelledby="DakCloseWithAPModal" aria-hidden="true">
	 	  <div class="modal-dialog modal-dialog-centered " role="document"  >
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
	 	     <div align="center">
	 	       <h5  class="modal-title" style="margin-left: 2px;background-color: rgb(185, 217, 235);color: rgb(17, 74, 134);border-radius: 2px;padding-right: 8px;padding-left: 8px;" id="exampleModalLong2Title"><b>DAK Close</b> </h5>
	  	    </div>   
	  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body" style="min-height: 400px!important;">
	  	         <form action="#" method="post" id="DakCloseWithAPMarkerForm">
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
	  	            <div class="row" id="DakCloseCommt" >
	  	            	<label style="font-weight:bold;margin-left:10px;font-size:16px;margin-top:2px;">Closing Comment :</label>
	  	      		   <textarea class="form-control DakCloseCommtInput" id="closingCommtWithDirAprv" name="DakClosingComment"
                                 style="width:98%;height:300px;background-color:white;margin-right:-12px;margin-left:5px;" maxlength="500"></textarea>
                            
	  	      		</div>
	  	      		
                     <div class="col-md-12" align="center">
                            
                                <br>
                    <button type="button" class="btn btn-danger btn-sm delete" 
                    formaction="DakCloseByMarker.htm"   id="DakCloseWithAPByMarkerBtn" 
                     onclick="return dakCloseByMarkerWithDirApprv()">DAK Close</button>
                    <input type="hidden" name="dakIdForMarkerAction"	id="DakIdFrDakCloseWithAP" value="" />	
                   <input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
                    </div>
                     
	  	        </form>
	  	      		
	  	      		
	  	      </div>
	  	     </div>
	  	    </div>
		   </div>
		
<!---------------------------------------------------- Marker DAK Close With  Director Approve && Closing Comment Modal End ----------------------------------------------------------->
		 
<!----------------------------------------------------Marker  DAK Close Director Approve With  Approval Comment Modal Start  ----------------------------------------------------------->

	    <div class="modal fade my-modal " id="ApproveCommentByDirModal" tabindex="-1" role="dialog" aria-labelledby="ApproveCommentByDirModal" aria-hidden="true">
	 	  <div class="modal-dialog modal-dialog-centered " role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex;align-items: stretch;">
	 	    <div class="modal-content" style="width: 100%;">
            <div class="modal-header" style="background-color: #114A86;max-height:55px;">
		   <h5  class="modal-title" style="margin-left: 2px;background-color: rgb(185, 217, 235);color: rgb(17, 74, 134);border-radius: 2px;padding-right: 8px;padding-left: 8px;" id="exampleModalLong2Title"><b>DAK Close</b> </h5>
	  		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body" style="min-height: 400px!important;">
	  	   <form action="#" method="post" id="DakCloseByMarkerWithDirCommtForm">
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
	  	            <div class="row" id="ApproveCommentMod" >
	  	            <label style="font-weight:bold;margin-left:10px;font-size:16px;">Director's Comment :</label>
	  	      		   <textarea class="form-control ApproveCommtDisplay" readonly="readonly"  
                                 style="width:98%;height:150px;margin-right:-12px;margin-left:5px;" maxlength="500"></textarea>
                            
	  	      		</div>
	  	      <div class="row" id="DakCloseCommt" >
	  	      		<label style="font-weight:bold;margin-left:10px;font-size:16px;margin-top:10px;">Closing Comment :</label>
	  	      		   <textarea class="form-control " id="markerclosingCommtWithDirCommt"  name="DakClosingCommtByMarker"
                                 style="width:98%;height:150px;background-color:white;margin-right:-12px;margin-left:5px;" maxlength="500"></textarea>
                            
	  	      		</div>
	  	      		
                     <div class="col-md-12" align="center">
                            
                                <br>
                   <input type="hidden" name="dakIdForMarkerAction"	id="DakIdFrDakCloseWithAPandComment" value="" />
                  <input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
 					<button type="button" class="btn btn-danger btn-sm delete"  
                     formaction="DakCloseByMarker.htm"  id="DakCloseByMarkerWithDirCommtBtn"
                    onclick="return dakCloseByMarkerWithDirCommtView()" >DAK Close</button>
                    
                    </div>
                     
	  	     </form>
	  	      		
	  	      		
	  	      </div>
	  	     </div>
	  	    </div>
		   </div>
		
		 <!----------------------------------------------------  Marker  DAK Close Director Approve With  Approval Comment Modal Modal End     ----------------------------------------------------------->
			
			
			
			<!---------------------------- Download Attach Start(Common for DAK Pending List and DAK Director & DAK List) --------------------------------------->
		 	<form action="DeleteAttach.htm" name="deleteform" id="deleteform" >
		<input type="hidden" name="dakattachmentid" id="dakattachmentid" value="" />
		<input type="hidden" name="redirectValueFrDelAttach" id="redirectValFrDelAttach" value="" />
		<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
	</form>
	
	
	<div class="modal fade my-modal " id="ModalDakAttachments" tabindex="-1" role="dialog" aria-labelledby="ModalDakAttachments" aria-hidden="true">
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document" style="width:1000px;">
 	    <div class="modal-content">
  	      <div class="modal-body">
  	       <h3 class="modal-title" id="exampleModalLong2Title" style="font-size:18px" ><b>DakId:</b> <span style="color: #114A86;" id="dakAttachmentDakNo"></span> &nbsp;&nbsp; <b>Source :</b> <span style="color: #114A86;" id="dakAttachmentSource"></span>
 	         </h3>
  	      <div class="tabs">
        <div class="tabby-tab">
      <input type="radio" id="tab-1" name="tabby-tabs" checked  onclick="tabChange('M')">
      <label for="tab-1">Main Document</label>
      <div class="tabby-content">
  	      	<form action="DakAttach.htm" name="attachform" id="attachformMainDoc"  method="POST" enctype="multipart/form-data">
  	      		
  	      		
  	      		<div class="row">
  	      			<div class="col-md-10">
  	      				<input class="form-control" type="file" name="dakdocumentupload"  id="dakdocumentMainDoc" accept="*/*"   >
  	      			</div>
  	      			
  	      		   <div class="col-md-2" align="center">
  	      			<input type="button" class="btn btn-primary btn-sm submit "  style="margin:7px 0px 0px -10px; " id="sub" value="Submit" name="sub"  onclick="submitattachMainDoc()" > 
  	      		   </div>
  	      		</div>
  	      		
  	      		<br>
  	      		<table class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtable" >
					<thead>
						<tr>
							<th style="width:5%;" >SN</th>
							<th style="width:60%;"> Item Name </th>
							<th style="width:35%; ">Action</th> 
						</tr>
					</thead>
					<tbody id="other-list-table">
					
					</tbody>
				</table>
  	      		
  	      		<input type="hidden" name="dakidvalue" id="dakidvalue" value="" />
  	      		<input type="hidden" name="daknovalue" id="daknovalue" value="" />
  	      		<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
  	      		
  	      		<input type="hidden" name="type" id="type" value="" />
  	      		<input type="hidden" name="redirectValFrAttach" id="redirectFrAttach" value="" />
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	</form>
  	      		</div>
  	      		</div>
  	      		
  	      		<div class="tabby-tab">
      <input type="radio" id="tab-2" name="tabby-tabs" onclick="tabChange('S')">	
      <label for="tab-2">Enclosures</label>
      <div class="tabby-content">
        	<form action="DakAttach.htm" name="attachform" id="attachformSubDoc"  method="POST" enctype="multipart/form-data">
  	      		<div class="row">
  	      			<div class="col-md-10">
  	      				<input class="form-control" type="file" name="dakdocumentupload"  id="dakdocumentSubDoc" accept="*/*"  >
  	      			</div>
  	      		
  	      		   <div class="col-md-2" align="center">
  	      			<input type="button" class="btn btn-primary btn-sm submit "  style="margin:7px 0px 0px -10px; " id="sub2" value="Submit" name="sub"  onclick="submitattachSubDoc()" > 
  	      		   </div>
  	      		</div>
  	      		
  	      		<br>
  	      		<table class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtable" >
					<thead>
						<tr>
							<th style="width:5%;" >SN</th>
							<th style="width:45%;"> Item Name </th>
							<th style="width:50%; ">Action</th> 
						</tr>
					</thead>
					<tbody id="other-list-table2">
					
					</tbody>
				</table>
  	      		
  	      		<input type="hidden" name="dakidvalue" id="dakidvalue2" value="" />
  	      		<input type="hidden" name="daknovalue" id="daknovalue2" value="" />
  	      		<input type="hidden" name="type" id="type2" value="" />
  	      		<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
  	      		<input type="hidden" name="redirectValFrAttach" id="redirectFrAttach2" value="" />
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	</form>
      </div>
     <br><br>
    </div>
    <div class="tabby-tab">
      <input type="radio" id="tab-3" name="tabby-tabs" data-dismiss="modal" aria-label="Close">
      <label for="tab-3"><button type="button"  class="close" style="color: white;margin-right: 10px;" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button></label>
      		<div class="tabby-content">
      
  	      	</div>
  	      	</div>
  	      	</div>
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
		<!-------------------------------- Download Attach End(Common for DAK Pending List and DAK Attach List) ------------------------------>
			
			<!----------------------------------------------------  Dak Distribute Modal Start  ----------------------------------------------------------->

	<div class="modal fade my-modal " id="exampleModalmark" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	  <div class="modal-dialog modal-lg modal-dialog-jump" role="document">
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header" style="background-color: #114A86;">
	 	        <h3 class="modal-title" id="exampleModalLong2Title" style="color:white;"><b>DAK Distribution</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	 	         <b>DakId:</b> <span style="color: white;" id="dakpendingListDakNo"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	 	         <b>Source :</b> <span style="color: white;" id="dakpendingListSource"></span></h3>
	  	        <button type="button" class="close" style="color:white;" data-dismiss="modal" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body">
	  	      
	  	      	<form action="#"  method="POST" id="DakDistributionForm">
	  	      		<div class="row" id="DakDistributeAppend" style="display:block!important" >
	  	      		</div>
	  	      		<br>
	  	      		<div align="center">
	  	      			<button type="button" style="width: 15%;" class="btn btn-primary btn-sm submit "  formaction="DakDistribute.htm" 
	  	      			id="DakDistriBtn"  onclick="return DakDistributeSubmitValidation()" >Submit</button>
	  	      		</div>
	  	
	  	      		 
	  	      		
	  	      	   <!-- For DAK Distribute only-->
	  	              <input type="hidden" name="EmpIdDistribute" id="EmpIdDistribute" value="" />
	  	              <input type="hidden" name="DakAttachCount" id="dakAttachCountVal" value="" />
	  	              <input type="hidden" name="markedAction" id="markedAction">
	  	      	  <input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
	  	      	  
	  	      	  <input type="hidden" name="TotalCountofEmp" id="TotalCountofEmp" value="" />
	  	              <input type="hidden" name="TotalInfoCount" id="TotalInfoCount" value="" />
	  	              
	  	      	  <!--common for DAK Distribute & Delete-->
	  	      		<input type="hidden" name="dakId" id="dakidDistribute" value="" />
	  	      	    <input type="hidden" name="ActionDataDistribute" id="actionDataDistribute" value="" />
	  	      		
	  	      	 <!-- For Marked Emp Delete only -->
	  	      	   <input type="hidden" name="EmpIdForDelete" id="EmpIdAppendFrDelete" value="" />
	  	      	   <input type="hidden" name="DakMemberTypeIdForDelete" id="DakMemberTypeIdAppendFrDelete" value="" />
	  	      	    <input type="hidden" name="DakMarkingIdForDelete" id="DakMarkingIdAppendFrDelete" value="" />
	  	      	
	  	      	   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  	      	</form>
	  	      		
	  	      		
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  Dak Distribute Modal End    ----------------------------------------------------------->
			
			
			<!-- ---------------------------------------------------------------------------------------------- DakDetailed List ActionRequired Edit Modal Start --------------------------------------------------------->

 <div class="modal fade my-modal" id="exampleModalActionRequiredEdit"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" >
 	    <div class="modal-content" style="height: 500px; width: 90%;">
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h6 class="modal-title" id="exampleModalLongTitle" style="color: white;"><b><span style="color: white;">DAK ActionRequired Edit</span></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        (&nbsp;<span style="color: white;">DAK Id:</span> <span style="color: white;" id="DakDetailedActionRequiredEditDakNo"></span>, &nbsp;&nbsp;<span style="color: white;">Source: </span><span style="color: white;" id="DakDetailedActionRequiredEditSource"></span>&nbsp;)
 	      </h6></div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      	<form action="DakActionRequiredEdit.htm" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="row">
  	      			<div class="col-md-5" style="margin-left: 50px;">
  	      			<div class="form-group">
  	      			<label class="control-label">ActionRequired </label>
  	      			<select class="form-control selectpicker custom-select"  id="ActionRequiredEdit" data-live-search="true" style="width: 60%;" required="required" onchange="changeFunc();" name="ActionRequiredEdit">
  	      				</select>
  	      			</div>
  	      			</div>
  	      			<div class="col-md-5">
  	      			<div class="form-group">
  	      			<label class="control-label">Closing Authority </label>
  	      			<select class="form-control selectpicker custom-select"   id="ClosingAuthorityEdit" data-live-search="true" style="width: 60%;" required="required" name="closingAuthorityValEdit">
  	      			<!-- <option selected value="P">P&C DO</option>
					<option  value="O">Others</option> -->
  	      				</select>
  	      			</div>
  	      			</div>
  	      			</div>
  	      			<div class="row">
  	      			<div class="col-md-5 ActionDueDate" style="margin-left: 50px;">
                        		<div class="form-group">
  	      			<label class="control-label">Action Due Date </label>
					<input class="form-control form-control" name="DueDate" style="font-size: 15px;" id="dakdetailsduedate" required="required">
				</div>
			</div>
				<div class="col-md-5 ActionTime" >
                  <div class="form-group">
  	      		<label class="control-label">Action Time</label>
                  <input type="text" class="form-control form-control" name="DueTime"  style="font-size: 15px;" value="<%=LocalTime.of(16, 30)%>"  id="dakDetailsDueTime" required="required" >
                   </div>
         </div>
  	      			</div>
  	      			<div class="row">
  	      			<div class="col-md-10 EditRemarks" style="margin-left: 50px;">
                        		<div class="form-group">
  	      			<label class="control-label">Brief on DAK </label>
					<input class="form-control form-control" name="EditRemarks" style="font-size: 15px;" id="EditRemarks" required="required">
				</div>
			</div>
				
         </div>
  	      			<input type="hidden" id="ActionRequiredEditDakId" name="ActionRequiredEditDakId" value="">
  	      			<input type="hidden" id="DakDetailedActionRequiredEditActionVal" name="ActionRequiredEditActionVal" value="">
  	      			<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
  	      		  </div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>  
<!-- ---------------------------------------------------------------------------------------------- Dak Detailed List ActionRequired Edit Modal  End --------------------------------------------------------->
			<!----------------------------------------------------Director Actions With P&C DO Consolidated Reply View Start    ----------------------------------------------------------->
	
	<div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" id="consolidated-reply-details">
	
 	  <div class="modal-dialog modal-lg" role="document"  style="min-width: 95%!important; min-height: 70vh !important; display: flex; align-items: stretch;" >
            <div class="modal-content">
					<div class="modal-header" style="background: linear-gradient(to bottom, #5691c8, #457fca);max-height:55px;">
					<h5 class="modal-title" style="color:white;" ><b>P&C Reply For <span class="DakNoAppend"></span> (<span class="DakDetailsAppend"></span>)</b> </h5>
	  	                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	  	                  <span aria-hidden="true">&times;</span>
	  	            </button>
					</div>
			 <form action="#" method="post" id="DirActionsFormPNCDO">
					
					<div class="modal-body" align="center" style="margin-top:-4px;">
					
					
						
						   <div class="forminline">
                         <!--     <label style="font-weight:bold;font-size:14px;float:left;">Reply :</label> -->
                             <textarea class="form-control PnCRepliedTextForApproval" readonly="readonly" id="PnCRepliedTextForApproval" 
                               style="width:100%;height: 300px;background-color:white;margin-right:-1px;" maxlength="4000"></textarea>
                            
                            <label style="font-weight:bold;font-size:14px;float:left;padding-top:10px;">Documents :</label>  
                            <table class="PnCRepliedDocuments">
                               <!-- data will be filled using ajax -->
                                  </table>
                              </div>
                         <div class="clearfix" style="text-align: center;"></div>
                              <!--Hidden if returned message start--> 
                     <div class="ReturnedMessage" >
                      <span style="color:red">Note : The above Consolidated Reply is returned with the following comment.</span>
                            <div class="row" id="returnCommentMod" >
                         <label style="font-weight:bold;margin-left:10px;font-size:16px;">Return Comment :</label>
	  	      		   <textarea class="form-control returnCommtDisplay" readonly="readonly"  
                                 style="width:98%;height:150px;margin-right:-12px;margin-left:5px;background-color:white;" maxlength="500"></textarea>
                  </div>
                        
                         </div>
                           <!--Hidden if returned message ends--> 
                      
                      <!--Comment shown common for all 3 buttons for approve comment is not compulsory for approve with comment & comment its compulsory  -->
                      <!--comment field will be same what type of commt depends on FormUrl -->
                     <div class="forminline" id="commentFieldDiv">
	  	      		   <label style="font-weight:bold;font-size:14px;float:left;padding-top:10px;">Comment :</label>  
	  	      		   <textarea class="form-control DirCommtBasedOnAct" required="required" name="DirectorComment" 
                              style="width:100%;height: 110px;background-color:white;margin-right:-1px;"    maxlength="500"></textarea>
                            
	  	      		</div>
                                
                       
                        <div class="col-md-12" align="center">

						       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <br>
                            <!--Common hidden inputs buttons for all 3 Director Action Start-->    
                               <input type="hidden" id="DakIdAppendForDirActOfPNCDO" name="DakIdFetch" value="" />
                               <input type="hidden" id="DirectorActionOfPNCDO" name="DirectorAct" value="" />
                               <input type="hidden" id="RedirTabOfPNCDO" name="RedirTabValue" value="" />
                               <!-- <input type="hidden" id="PageRedirForApprove" value="" /> -->
                               <input type="hidden" id="RowRedirForApprove" name="RowValueFrRedirect" value="" />
                       
                       
                       			<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
                       			
                            <!--Common hidden inputs buttons for all 3 Director Action End(value is appended by JS)-->           
                
                            <button type="button" formaction="DAKApprovalByDirSubmit.htm" class="btn btn-primary btn-sm submit" 
                            onclick="return dakApproveByDirForPNCDO()"   id="dakApproveOfPNCDOClick" >Approve</button>
                            &nbsp;&nbsp;&nbsp;&nbsp;
              
                              
                            <button type="button"  formaction="DAKApprovalByDirSubmit.htm"  class="btn btn-primary btn-sm submit" 
                            onclick="return dakApproveCommentsByDirOfPNCDO()" id="dakApproveCommtOfPNCDOClick"  >Approve By Comments</button>  
                             &nbsp;&nbsp;&nbsp;&nbsp;
                             
                            <button type="button" formaction="DAKReturnByDirSubmit.htm" class="btn btn-danger btn-sm delete"
                             onclick="return dakReturnByDirOfPNCDO()"  id="dakReturnOfPNCDOClick" >Return</button>
          
                    </div>
               
						
				
					</div>
					               
				 </form>  
			</div>
	</div>
 </div>	
  <!---------------------------------------------------- Director Actions With P&C DO Consolidated Reply View End     ----------------------------------------------------------->			
  <!---------------------------------------------------- Director Actions With Others View Modal Start    ----------------------------------------------------------->
	
	<div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" id="marker-reply-details">
	
 	  <div class="modal-dialog modal-lg" role="document"  style="min-width: 95%!important; min-height: 70vh !important; display: flex; align-items: stretch;" >

			    <div class="modal-content">
					<div class="modal-header" style="background: linear-gradient(to bottom, #5691c8, #457fca);max-height:55px;">
					<h5 class="modal-title" style="color:white;" ><b>Marker(<span class="MarkerDetailsInPreview"></span>) Reply For <span class="DakNoAppendInPreview"></span> (<span class="DakDetailsAppendInPreview"></span>)</b> </h5>
	  	                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	  	                  <span aria-hidden="true">&times;</span>
	  	            </button>
					</div>
					                  
                  				
					<form action="#" method="post" autocomplete="off" id="DirectorActionFormOthers">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="modal-body" align="center" style="margin-top:-4px;">
	
						
						   <div class="forminline">
                         <!--     <label style="font-weight:bold;font-size:14px;float:left;">Reply :</label> -->
                             <textarea class="form-control MarkerRepliedTextForApproval" readonly="readonly" id="MarkerRepliedTextForApproval" 
                               style="width:100%;height: 300px;background-color:white;margin-right:-1px;" maxlength="4000"></textarea>
                            
                            <label style="font-weight:bold;font-size:14px;float:left;padding-top:10px;">Documents :</label>  
                            <table class="MarkerRepliedDocuments">
                               <!-- data will be filled using ajax -->
                                  </table>
                              </div>
                         <div class="clearfix" style="text-align: center;"></div>
                             
        
                              <!--Hidden if returned message--> 
                      <span class="ReturnedMessageMarker" style="color:red">Note : The above Marker Reply is returned with a comment.</span>
                         
                                 <!--Comment shown common for all 3 buttons for approve comment is not compulsory for approve with comment & comment its compulsory  -->
                      <!--comment field will be same what type of commt depends on FormUrl -->
                     <div class="forminline" id="commentValueDiv">
	  	      		   <label style="font-weight:bold;font-size:14px;float:left;padding-top:10px;">Comment :</label>  
	  	      		   <textarea class="form-control DirCommt" required="required" name="DirectorComment" 
                              style="width:100%;height: 110px;background-color:white;margin-right:-1px;"    maxlength="500"></textarea>
                            
	  	      		</div>
                      

                        <div class="col-md-12" align="center">
                            
                                <br>
                         <!--Common hidden inputs buttons for all 3 Director Action Start-->    
                            <input type="hidden" id="DakIdAppendForDirActOfMarker" name="DakIdFetch" value="" />
                            <input type="hidden" id="DirectorActionOfMarker" name="DirectorAct" value="" />
                            <input type="hidden" id="RedirTabOfMarker"  name="RedirTabValue" value="" />
                        <!--Common hidden inputs buttons for all 3 Director Action End(value is appended by JS)-->           
               				<input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
                            
                        <!-- Both of the above hidden input types gets  updated using javascript -->
                            <button type="button" formaction="DAKApprovalByDirSubmit.htm" class="btn btn-primary btn-sm submit"
                             id="dakApproveOfMarkerClick" onclick="return dakMarkersReplyApproveByDirector()" >Approve</button><!-- DAK Approve button common for P&CDO or Marker -->
                             &nbsp;&nbsp;&nbsp;&nbsp;
                               
                            <button type="button"  formaction="DAKApprovalByDirSubmit.htm"  class="btn btn-primary btn-sm submit" 
                            id="dakApproveCommtOfMarkerClick" onclick="return dakApproveCommentsByDirOfMarker()" >Approve By Comments</button>  
                            &nbsp;&nbsp;&nbsp;&nbsp;
                             
                       <!-- <button type="button" formaction="DAKRetutnOfMarkerByDirSubmit.htm" class="btn btn-danger btn-sm delete"
                             id="dakReturnOfMarkerClick" onclick="return dakReturnByDirOfMarker()" >Return</button>    -->        
                             
                             </div>
						   
						
					
					</div>
					</form>
			</div>
	</div>
 </div>	
  <!---------------------------------------------------- Director Actions With Others View Modal End     ----------------------------------------------------------->			
		
		 <!----------------------------------------------------  DAK Close Approve With Comment Modal Start  ----------------------------------------------------------->

	    <div class="modal fade my-modal " id="ApproveCommentModal" tabindex="-1" role="dialog" aria-labelledby="ApproveCommentModal" aria-hidden="true">
	 	  <div class="modal-dialog modal-dialog-centered " role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex;align-items: stretch;">
	 	    <div class="modal-content" style="width: 100%;">
            <div class="modal-header" style="background-color: #114A86;max-height:55px;">
		   <h5  class="modal-title" style="margin-left: 2px;background-color: rgb(185, 217, 235);color: rgb(17, 74, 134);border-radius: 2px;padding-right: 8px;padding-left: 8px;" id="exampleModalLong2Title"><b>DAK Close</b> </h5>
	  		        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body" style="min-height: 400px!important;">
	  	   <form action="#" method="post" id="DakCloseInPNCDOWithDirCommtForm">
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
	  	            <div class="row" id="ApproveCommentMod" >
	  	            <label style="font-weight:bold;margin-left:10px;font-size:16px;">Director's Comment :</label>
	  	      		   <textarea class="form-control ApproveCommtDisplay" readonly="readonly"  
                                 style="width:98%;height:150px;margin-right:-12px;margin-left:5px;" maxlength="500"></textarea>
                            
	  	      		</div>
	  	      <div class="row" id="DakCloseCommt" >
	  	      		<label style="font-weight:bold;margin-left:10px;font-size:16px;margin-top:10px;">Closing Comment :</label>
	  	      		   <textarea class="form-control DakCloseCommtInput"  id="closingCommtWithDirCommt" name="DakClosingComment"
                                 style="width:98%;height:150px;background-color:white;margin-right:-12px;margin-left:5px;" maxlength="500"></textarea>
                            
	  	      		</div>
	  	      		
                     <div class="col-md-12" align="center">
                            
                                <br>
                    <button type="button" class="btn btn-danger btn-sm delete"  
                     formaction="DakClose.htm"  id="DakCloseAfterDirCommtView"
                    onclick="return dakCloseByDirCommtView()" >DAK Close</button>
                    <input type="hidden" name="DakIdForClose"	id="DakCloseDakIdAppend" value="" />
                    <input type="hidden" name="WithApprovalDakClose" value="DakPncDoList">
                    </div>
                     
	  	     </form>
	  	      		
	  	      		
	  	      </div>
	  	     </div>
	  	    </div>
		   </div>
		
		 <!----------------------------------------------------  DAK Close Approve With Comment and Closing Comment Modal End     ----------------------------------------------------------->
		 
		 
		 		 <!----------------------------------------------------  DAK Close With Closing Comment Modal Start  ----------------------------------------------------------->

	    <div class="modal fade my-modal " id="DakCloseCommentModal" tabindex="-1" role="dialog" aria-labelledby="DakCloseCommentModal" aria-hidden="true">
	 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document"  >
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
	 	     <div align="center">
	 	       <h5  class="modal-title" style="margin-left: 2px;background-color: rgb(185, 217, 235);color: rgb(17, 74, 134);border-radius: 2px;padding-right: 8px;padding-left: 8px;" id="exampleModalLong2Title"><b>DAK Close</b> </h5>
	  	    </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	  	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
	  	    <div align="right"><b style="color:white;">DakId : </b> <span id="DakCloseDakNo" style="color:white;"></span>
	  	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	  	    <b style="color:white;">Source : </b> <span id="DakCloseSource" style="color:white;"></span>
	  	    </div>
	  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body" style="min-height: 400px!important;">
	  	         <form action="#" method="post" id="DakCloseInPNCDOForm">
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
	  	            <div class="row" id="DakCloseCommt" >
	  	            	<label style="font-weight:bold;margin-left:10px;font-size:16px;margin-top:2px;">Closing Comment :</label>
	  	      		   <textarea class="form-control DakCloseCommtInput" id="closingCommtMain" name="DakClosingComment"
                                 style="width:98%;height:300px;background-color:white;margin-right:-12px;margin-left:5px;" maxlength="500"></textarea>
                            
	  	      		</div>
	  	      		
                     <div class="col-md-12" align="center">
                            
                                <br>
                    <button type="button" class="btn btn-danger btn-sm delete" 
                    formaction="DakClose.htm"   id="DakCloseByPNCDO" 
                     onclick="return dakCloseByDirApprv()">DAK Close</button>
                    <input type="hidden" name="DakIdForClose"	id="DakIdUpdateFrDakClose" value="" />	
                    </div>
                     
	  	        </form>
	  	      		
	  	      		
	  	      </div>
	  	     </div>
	  	    </div>
		   </div>
		
		 <!----------------------------------------------------  DAK Close Approve With Closing Comment Modal End     ----------------------------------------------------------->
			
			
			<!---------------------------------------------------- Dak Assign  Reply  Modal start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="AssignexampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 50% !important; min-height: 50vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color: white;">DAK Assign Reply</span></b>
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;<span style="color:white;">DAK Id:</span> <span style="color: white;" id="DakAssignReplyDakNo"></span>, &nbsp;&nbsp;<span style="color:white;">Source:</span> <span style="color: white;" id="DakAssignReplySource"></span>&nbsp;
 	      </h5></div>
  	        <button type="button" class="close" style="color: white;" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="AssignattachformReply" id="AssignattachformReply" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control AssignreplyTextArea"    name="AssignreplyRemarks" style="min-width: 110% !important;min-height: 30vh;"  id="reply" required="required"  maxlength="500" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      			<div class="col-md-10 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_clone_addbtnAssign btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_cloneAssign">
			  	      			<td><input class="form-control" type="file" name="dak_Assign_reply_document"  id="dakassigndocumentreply"  accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_clone_subAssign btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      			</div>
  	     
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  <input type="hidden" name="dakIdOfAssignReply"  id="dakIdOfAssignReply" value="" >
  	      		  <input type="hidden" name="DakAssignId" id="AssignId" value="">
  	      		  <input type="hidden" name="DakNo" id="AssignDakNo" value="">
  	      		  <input type="hidden" id="DakAssignRedirVal" name="DakAssignRedirVal" value=""> 
  	      		  <input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
  	      		  
  	      		    
  	      			<input type="button" formaction="DAKAssignReply.htm"  class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return dakAssignReplyValidation()" > 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 
  <!---------------------------------------------------- Dak Assign Reply  Modal End    ----------------------------------------------------------->
		
		
		<!---------------------------------------------------- Dak Seek Response  Reply  Modal start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="SeekexampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 50% !important; min-height: 50vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="SeekResponseexampleModalLongTitle"><b><span style="color: white;">DAK SeekResponse Reply</span></b>
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;<span style="color:white;">DAK Id:</span> <span style="color: white;" id="DakSeekResponseReplyDakNo"></span>, &nbsp;&nbsp;<span style="color:white;">Source:</span> <span style="color: white;" id="DakSeekResponseReplySource"></span>&nbsp;
 	      </h5></div>
  	        <button type="button" class="close" style="color: white;" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="SeekResponseattachformReply" id="SeekResponseattachformReply" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control SeekResponsereplyTextArea"    name="SeekResponsereplyRemarks" style="min-width: 110% !important;min-height: 30vh;"  id="SeekResponseReplyRemarks" required="required"  maxlength="500" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      			<div class="col-md-10 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_clone">
			  	      			<td><input class="form-control" type="file" name="dak_SeekResponse_reply_document"  id="dakSeekResponsedocumentreply"  accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      			</div>
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  <input type="hidden" name="dakIdOfSeekResponseReply"  id="dakIdOfSeekResponseReply" value="" >
  	      		  <input type="hidden" name="DakAssignId" id="DakSeekResponseAssignerId" value="">
  	      		  <input type="hidden" name="DakNo" id="SeekResponseDakNo" value="">
  	      		  <input type="hidden" name="SeekResponseId" id="SeekResponseId" value="">
  	      		   <input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
  	      		  <input type="hidden" name="seekredirval" id="seekredirval">
  	      		  
  	      		    
  	      			<input type="button" formaction="DAKSeekResponseReply.htm"  class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return dakSeekResponseReplyValidation()" > 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 
  <!---------------------------------------------------- Dak Seek response  Reply  Modal End    ----------------------------------------------------------->	
  
  
  <!----------------------------------------------------  Dak Tracking Modal jsp page Start  ----------------------------------------------------------->
	<div class="modal fade my-modal" id="ShowDakTrackingPage" tabindex="-1" role="dialog" aria-labelledby="ShowDakTrackingPage" aria-hidden="true">

	 	    	  <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 95% !important; min-height: 20vh !important; display: flex; align-items: stretch;" >
	 	    	
	 	    	<div class="modal-content" >
	 	     
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header" style="background-color: #114A86;height:2px;">
	 	        <h3 class="modal-title" id="exampleModalLong2Title" style="color:white;"></h3>
	  	        <button type="button" class="close" style="padding-top:0px!important;color:white!important;" data-dismiss="modal" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	 	     
	 	  
	  	      <div class="modal-body" align="center" style="margin-top:-4px;">
	  	   <div id="TrackingPageDataInsert" style=""></div>
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		</div>
		 <!----------------------------------------------------  Dak Tracking Modal jsp page End      ----------------------------------------------------------->


	<form action="DakTracking.htm" name="trackingform" id="dakStatusTrackingForm" method="POST" target="_blank" >
		
		<input type="hidden" name="dakId" id="dakIdFrTrackingDakStatus" />
		<input type="hidden" name="redirectValTracking" id="redirectionByTrackingPage" />
		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	</form>
	
	
	
	<!----------------------------------------------------   Common Seek Response Reply  Edit start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="SeekResponsereplyCommonEditModal" tabindex="-1" role="dialog" aria-labelledby="replyCommonEditTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 85% !important; min-height: 50vh !important; margin-top:100px !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle" style="color: white;"><b>DAK Seek Response Reply Edit</b></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReplyEditAndDel" id="SeekResponseattachformReplyEditAndDel" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control SeekResponsereplyDataInEditModal"  name="replyEditRemarksVal" style="min-width: 110% !important;min-height: 30vh;"  id="SeekResponsereplyEditRemarksData" required="required"  maxlength="500" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      	<!-- new file add start -->
  	      	<div class="row">
  	      	<div class="col-md-5 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_editreply_addbtnSeekresponse btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_editreplySeekResponse">
			  	      			<td><input class="form-control" type="file" name="dak_replyEdit_document"  id="dakdocumenteditreply" accept="*/*"></td>
			  	      				<td><button type="button" class="tr_editreply_subSeekresponse btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      </div>
  	      	<!-- new file add end -->

  	      
  	       	<!-- old file delete,open or download start -->
  	      	<div class="col-md-5 " style="float:left">
  	      	<br>
  	      	<table class="ReplyEditAttachtable" style="border:none" >
					
					<tbody id="SeekResponseReplyAttachEditDataFill">
					
					
					</tbody>
				</table>
  	        </div>
  	        </div>
  	      	<!-- old file delete,open or download end -->
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  	<!-- for delete -->
  	      		 <input type="hidden" id="SeekResponsereplyAttachmentIdFrDelete" name="replyAttachmentIdVal" value="" />
  	      		<input type="hidden" id="SeekResponsereplyIdFrAttachDelete" name="replyIdVal" value="" />
  	      		<!-- for edit -->
  	      		  <input type="hidden" name="dakReplyIdValFrReplyEdit"  id="SeekResponsedakReplyIdOfReplyEdit" value="" >
  	      		  <input type="hidden" name="dakIdValFrReplyEdit"  id="SeekResponsedakIdOfReplyEdit" value="" >
  	      		    <input type="hidden" name="empIdValFrValueEdit" id="SeekResponseempIdOfReplyEdit" value="">
  	      		    <input type="hidden" name="viewfrom"  value="<%=viewfrom%>">
  	      		    
  	      			<input type="button" formaction="DAKSeekResponseReplyDataEdit.htm"  class="btn btn-primary btn-sm submit " id="dakSeekResponseCommonReplyEditAction"   onclick="return dakSeekResponseReplyEditValidation()" value="Submit" > 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
	<!----------------------------------------------------------------------------- Common Seek Response Reply  Edit end  ----------------------------------------------------->
	
	
	<!----------------------------------------------------  Remind Modal start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="RemindSentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 70% !important; min-height: 70vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="SeekResponseexampleModalLongTitle"><b><span style="color: white;">Remind</span></b>
 	      <span style="color: white; margin-left: 150px;">DAK Id:</span> &nbsp;&nbsp;<span style="color: white;" id="RemindViewDakNo"></span> &nbsp;&nbsp;&nbsp;<span style="color:white;">Source :</span> <span style="color: white;" id="RemindSourcetype"></span>
 	      </h5></div>
  	        <button type="button" class="close" style="color: white;" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="RemindEmployeeSubmit" id="RemindEmployeeSubmit" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      			<div class="row">
  	      			<div class="col-md-4">
  	      			<div class="form-group">
  	      			<label class="control-label">Remind To</label>
  	      			<select class="form-control selectpicker custom-select"  id="RemindEmployee" data-live-search="true" style="width: 60%;" required="required" name="RemindEmployee">
  	      				</select>
  	      			</div>
  	      			</div>
  	      			<div class="col-md-8">
  	      			<div class="form-group">
  	      			<label class="control-label">Comment</label>
  	      			<input type="text" class="form-control" name="comment" maxlength="500" id="Remindcomment">
  	      			</div>
  	      			</div>
  	      			</div>
  	      	<br><br><br>
  	      		 <div class="col-md-12"  align="center">
  	      		 <input type="hidden" name="DakId" id="RemindDakId">
  	      			<input type="button" formaction="DakRemindSubmit.htm"  class="btn btn-primary btn-sm submit " id="DakRemindSubValidate"   onclick="return DakRemindSubmit()" value="Submit" > 
  	      		  </div>
  	      		  <br>
  	      		   <div style="overflow: auto; max-height: 200px!important;"> 
  	      		    <h6 style="font-weight: bold; padding: 5px; font-size: 15px;color:#353935; margin-left: 1000px;">
                      <span class="label"> C : Comment </span>
                      <span class="color-box RemindDetailscomment"></span>
                	  <span class="label"> R : Reply  </span>
                	  <span class="color-box RemindDetailsReply"></span>
    					</h6>
  	      		  <div class="row" id="RemindDetails" style="display: inline-block; position: relative; left: 0; text-align: left; width: 90%; margin-left: 5px;">
	  	      		
	  	      		</div>
	  	      		</div>
  	      		</form>
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
  <!----------------------------------------------------  Remind  Modal End    ----------------------------------------------------------->
  <!----------------------------------------------------  Remind Reply Modal start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="RemindReplyview" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 60% !important; min-height: 70vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="SeekResponseexampleModalLongTitle"><b><span style="color: white;">Remind Reply</span></b>
 	     <span style="color: white; margin-left: 150px;">DAK Id:</span> &nbsp;&nbsp;<span style="color: white;" id="RemindReplyViewDakNo"></span> &nbsp;&nbsp;&nbsp;<span style="color:white;">Source :</span> <span style="color: white;" id="RemindReplySourcetype"></span>
 	      </h5></div>
  	        <button type="button" class="close" style="color: white;" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="RemindEmployeeSubmit" id="RemindEmployeeSubmit" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      			<div class="row">
  	      			<div class="col-md-12">
  	      			<div class="form-group">
  	      			<label class="control-label">Reply</label>
  	      			<input type="text" class="form-control" maxlength="500" name="RemindReply" id="RemindReply">
  	      			</div>
  	      			</div>
  	      			</div>
  	      	<br><br><br>
  	      		 <div class="col-md-12"  align="center">
  	      		 <input type="hidden" name="DakId" id="RemindReplyDakId">
  	      		 <input type="hidden" name="RemindById" id="RemindById">
  	      		 <input type="hidden" name="RepliedFrom" id="RepliedFrom">
  	      			<input type="button" formaction="DakRemindReplySubmit.htm"  class="btn btn-primary btn-sm submit " id="DakRemindReplySubValidate"   onclick="return DakRemindReplySubmit()" value="Submit" > 
  	      		  </div>
  	      		  <br>
  	      		  <div style="overflow: auto; max-height: 200px!important;"> 
  	      		    <h6 style="font-weight: bold; padding: 5px; font-size: 15px;color:#353935; margin-left: 15px;">
                     <span class="label"><b>Comment : </b></span></h6>
  	      		  <div class="row" id="RemindPerticularDetails" style="display: inline-block; position: relative; left: 0; text-align: left; width: 90%; margin-left: 5px;">
	  	      		
	  	      		</div>
	  	      		</div>
  	      		</form>
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
  <!----------------------------------------------------  Remind Reply Modal End    ----------------------------------------------------------->
			</div>
					</div>
				</div>
			</div>
</body>
<script>
var result = <%= dakReceivedList[24] %>; // Pass your result array from JSP to JavaScript
var value = <%= dakReceivedList[1] %>; // Pass your value from JSP to JavaScript
if (result > 0) {
    document.getElementById('AllDakLinkDisplay').style.display = 'block';
    AllDakLinkList(value); // Calling the function directly in the script block
} else {
   // document.getElementById('AllDakLinkDisplay').style.display = 'none';
}
var result = '<%= dakReceivedList[6] %>'; // Pass your result array from JSP to JavaScript
var value = <%= dakReceivedList[1] %>; // Pass your value from JSP to JavaScript
if (result!==null && (result.trim()=='DD'  || result.trim()==='DA'  || result.trim()==='DR'  || result.trim()==='RM'|| result.trim()==='FP'  || result.trim()==='RP'  || result.trim()==='AP'  || result.trim()==='DC')) {
	document.getElementById('dakPrevDataPart2').style.display = 'block';
	 MarkedAssigned(value);
} else {
	/*  document.getElementById('dakPrevDataPart2').style.display = 'none'; */
}
//---------Marker Reply Preview Js  Starts--------------------
      //resetPreviewButtons();
       $(".DakReply").empty(); 
		 dakMarkerReplyPreview(value);
//---------Marker Reply Preview Js  ends--------------------/
 //---------CASEWORKER Reply Preview Js  Starts--------------------
       // Call dakCSWReplyPreview function here with the desired parameters to display in modal// Clear previous CSWDakReply div data
               $(".CaseworkerDakReplyData").empty(); 
	           dakCSWReplyPreview(value);
 //---------CASEWORKER Reply Preview Js  Ends--------------------/
  //---------P&C DO Reply Preview Js  Starts--------------------/
		 var logType = "<%= loginType %>";
		 var PncType="<%=dakReceivedList[20]%>";
		 if(result!==null && PncType!=null &&  PncType!="O" && result.trim()!='RM'  && ( result.trim()=='DC' || result.trim()=='AP' || result.trim()=='RP' || result.trim()=='FP' )   ){
			 if(logType=="Z" || logType=="A" || logType=="E"){  //Authorized persons
			 $(".pncDoReplyData").empty(); 
			 $('.btnPNCDOReplyDetailsPreview').show();  
		    	//call the function
		        dakPNCDOeplyPreview(value);
			 }else if(logType!="Z" || logType!="A" || logType!="E"){ //Markers
				  $(".pncDoReplyData").empty(); 
			 $('.btnPNCDOReplyDetailsPreview').show();  
		    	//call the function
		        dakPNCDOeplyPreview(value);
				// $('.btnPNCDOReplyDetailsPreview').prop('disabled', true);
			 }
		 }else{
			 $('.btnPNCDOReplyDetailsPreview').hide();  
	 	        // Clear previous data
	 		     $(".pncDoReplyData").empty(); 
		 }
	 		//---------P&C DO Reply Preview Js  ends--------------------/
	 		  //---------SEEK RESPONSE Reply Preview Js  Starts--------------------
       // Call SEEK RESPONSE ReplyPreview function here with the desired parameters to display in modal// Clear previous SEEK RESPONSE Reply div data
	          //resetPreviewButtons();
               $(".DakSeekResponseReply").empty(); 
	           dakSeekResponseReplyPreview(value);
	             //---------SEEK RESPONSE Reply Preview Js  Ends--------------------/
	    $('#PreviewSubject').html('');        
	    var PreviewSubject = "<%=dakReceivedList[15]%>";
		appendViewMoreButton($('#PreviewSubject'), PreviewSubject, 100, "SubjectViewMoreModal('" + value + "','" + PreviewSubject + "')");
$('.downloadDakMainReplyAttachTable').empty();
var maindoclength=0;
	var mainstr = '';
 $.ajax({
	type : "GET",
	url : "GetAttachmentDetails.htm",
	data : {
		dakid: value,
		attachtype:'M'
	},
	datatype : 'json',
	success : function(result) {
	var result = JSON.parse(result);
	var consultVals= Object.keys(result).map(function(e){
return result[e]
})
	maindoclength=consultVals.length;
for(var c=0;c<consultVals.length;c++)
{
	var other = consultVals[c];
	   mainstr +=   '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply"  style="float:left!important;" value="'+other[2]+'"  onclick="Iframepdf('+other[2]+')"  data-toggle="tooltip" data-placement="top" title="Download"   >' + other[3] + '</button>';
	   if(maindoclength>0){
			$('.downloadDakMainReplyAttachTable').html(mainstr);
			$('#maindakdocslabel').css('display','block');
			$('#maindakdocs').css('display','block');
		}else{
			$('#maindakdocslabel').css('display','none');
			$('#maindakdocs').css('display','none');
		}
}
	}
 });
 //-------------------------- Enclousure code  -------------------------------->
 $('.downloadsubDakReplyAttachTable').empty();
 var subdoclength=0;
 var HTMLStr = '';
 $.ajax({
	type : "GET",
	url : "GetAttachmentDetails.htm",
	data : {
		dakid: value,
		attachtype:'S'
	},
	datatype : 'json',
	success : function(result) {
	var result = JSON.parse(result);
	var consultVals= Object.keys(result).map(function(e){
return result[e]
})
	subdoclength=consultVals.length;
for(var c=0;c<consultVals.length;c++)
{
	var other = consultVals[c];
       HTMLStr +=   '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply"  style="float:left!important;" value="'+other[2]+'"  onclick="Iframepdf('+other[2]+')"  data-toggle="tooltip" data-placement="top" title="Download"   >' + other[3] + '</button>';
       if(subdoclength>0){
   		$('.downloadsubDakReplyAttachTable').html(HTMLStr);
   		$('#subdakdocslabel').css('display','block');
   		$('#subdakdocs').css('display','block');
   	}else{
   		$('#subdakdocslabel').css('display','none');
   		$('#subdakdocs').css('display','none');
   	}
}
	}
 });
 //--------------------------------------- Getting Link Dak in the Preview ---------------------------->
function AllDakLinkList(DakId) {
    $('#dakidvaluefordaklinklist').val(DakId);
    $('#AllDakLinkDisplay').empty();
    $.ajax({
        type: "GET",
        url: "getDakLinkData.htm",
        data: {
        	DakId: DakId
        },
        datatype: 'json',
        success: function (result) {
            if (result != null && result != '') {
                result = JSON.parse(result);
                var consultVals = Object.keys(result).map(function (e) {
                    return result[e]
                })
                var otherHTMLStr = '';
                var id = 'Employees';
                var count = 1;
                var SelDakLinkId = [];
                for (var c = 0; c < consultVals.length; c++) {
                     var Temp = id + (c + 1);
                     if(consultVals[c][0]>0){
                    	 otherHTMLStr += '    <button type="button" class="btn btn-sm DakLinkAttach-btn" style="cursor: auto;" name="DakLinkModalPrevBtn" id="DakId"'+consultVals[c][0]+' >' + count + '.'+ consultVals[c][1] +'</button>';
		                   count++;
		                   SelDakLinkId.push(consultVals[c][0]);
                
                $('#selecteddaklinkidlist').val(SelDakLinkId);
                $('#AllDakLinkDisplay').html(otherHTMLStr);
                }else{
                	document.getElementById('AllDakLinkDisplay').style.display = 'none';
                }
                }
            } else {
                var nOLinkdak = '<img src="view/images/infoicon.png" style="cursor: none; "/>&nbsp;&nbsp;<span style="color:#2196F3">No LinkDaK for this DAK</span>';
                $('#AllDakLinkDisplay').html(nOLinkdak);
            }
        }
    });
}
//---------------------------------------Getting Marked And Assigned Employees ----------------->
function MarkedAssigned(dakIdVal) {
    $('#dakidvalueforlist').val(dakIdVal);
    $('#DistributedListDisplay').empty();
    var loggedInEmpId = <%= LoginEmpId %>; 
     var DakStatus="<%=dakReceivedList[6]%>";
     var ReplyCount=<%=dakReceivedList[42]%>;
     var ActionType="<%=dakReceivedList[10]%>";
     var showview="<%=viewfrom%>";
     var from='DakReceivedList';
    $.ajax({
        type: "GET",
        url: "getDistributedAndAssignedEmps.htm",
        data: {
            dakId: dakIdVal
        },
        datatype: 'json',
        success: function (result) {
            if (result != null && result != '') {
                result = JSON.parse(result);
                var consultVals = Object.keys(result).map(function (e) {
                    return result[e]
                })
                var otherHTMLStr = '';
                var id = 'Employees';
                var count = 1;
                let finalval=0;
                var EmpId = [];
                for (var c = 0; c < consultVals.length; c++) {
                     var Temp = id + (c + 1);
                     if (parseInt(consultVals[c][3]) === 0) {
                    	 if(consultVals[c][8]==0 && consultVals[c][6]==0){
                  		   finalval=1;
                  	   }else if(consultVals[c][8]>=1 && consultVals[c][6]>=1){
                  		   finalval=1;
                  	   }else if(consultVals[c][8]>=1 && consultVals[c][6]==0){
                  		   finalval=0;
                  	   }
                    	 
                       if(consultVals[c][4]==='I'){
		                   	   otherHTMLStr += '<span style="margin-left:2%;color: #0073FF;" id="' + Temp + '"> ' + count + '.' + consultVals[c][1] + ' , ' + consultVals[c][2] ;
		                   		if(consultVals[c][11]>0){
		                   		   otherHTMLStr += '<span style="margin-left:20px; color: blue;">Replied</span>';
		                   	    }else if(consultVals[c][10]==='Y'){
		                   		   otherHTMLStr += '<span style="margin-left:20px; color: blue;">Acknowledged</span>';
		                   	    }
		                   	   if (showview==='DakReceivedList' && loggedInEmpId == consultVals[c][0] && ActionType==='ACTION' && (DakStatus==='DD'|| DakStatus==='DA') && ReplyCount==0 ) {
		                   	   otherHTMLStr += '<span style="margin-left:50px;"><button type="button" class="btn btn-success btn-sm  " onclick="return RemindopenModal('+dakIdVal+')">Remind</button></span>';
		                   	   }
		                  	   if(showview==='DakReceivedList' && loggedInEmpId == consultVals[c][0] && ActionType==='ACTION'  && (DakStatus==='DD'|| DakStatus==='DA') && ReplyCount==0 && consultVals[c][7]>0 && consultVals[c][9]>=0){
		                  	   otherHTMLStr += '<span style="margin-left:50px;"><button type="button" class="btn btn-sm icon-btn" title="Reply" data-toggle="tooltip" onclick="return RemindReplyopenModal(\'' + dakIdVal + '\',\'' + from + '\')"><img alt="Reply" src="view/images/remindview.gif"></button></span>';
		                  	   }
		                   	   otherHTMLStr += '</span><br>';
                       }else{
		                   	   otherHTMLStr += '<span style="margin-left:2%;color: #0B6623;" id="' + Temp + '"> ' + count + '.'+ consultVals[c][1] + ' , ' + consultVals[c][2];
		                   		if(consultVals[c][11]>0){
		                   		   otherHTMLStr += '<span style="margin-left:20px; color: blue;">Replied</span>';
		                   	   }else if(consultVals[c][10]==='Y'){
		                   		   otherHTMLStr += '<span style="margin-left:20px; color: blue;">Acknowledged</span>';
		                   	   }
		                   	   if (showview==='DakReceivedList' && loggedInEmpId == consultVals[c][0] && ActionType==='ACTION'  && (DakStatus==='DD'|| DakStatus==='DA') && ReplyCount==0 ) {
		                   	       otherHTMLStr += '<span style="margin-left:50px;"><button type="button" class="btn btn-success btn-sm  " onclick="return RemindopenModal('+dakIdVal+')">Remind</button></span>';
		                   	   }  
	                  	       if(showview==='DakReceivedList' && loggedInEmpId == consultVals[c][0] && ActionType==='ACTION'  && (DakStatus==='DD'|| DakStatus==='DA') && ReplyCount==0 && consultVals[c][7]>0 && consultVals[c][9]>=0){
	                      	       otherHTMLStr += '<span style="margin-left:50px;"><button type="button" class="btn btn-sm icon-btn" title="Reply" data-toggle="tooltip" onclick="return RemindReplyopenModal(\'' + dakIdVal + '\',\'' + from + '\')"><img alt="Reply" src="view/images/remindview.gif"></button></span>';
	                  	       }
		                   	   otherHTMLStr += '</span><br>';
                       }
                     } else {
                    	 if(consultVals[c][8]==0 && consultVals[c][6]==0){
                  		   finalval=1;
                  	   }else if(consultVals[c][8]>=1 && consultVals[c][6]>=1){
                  		   finalval=1;
                  	   }else if(consultVals[c][8]>=1 && consultVals[c][6]==0){
                  		   finalval=0;
                  	   }
                    	 if(consultVals[c][4]==='I'){
	                        	 otherHTMLStr += '<span style="margin-left:2%;color: #0073FF;" id="' + Temp + '"> ' + count + '.'+ consultVals[c][1] + ' , ' + consultVals[c][2];
	                        	 if(consultVals[c][11]>0){
			                   		   otherHTMLStr += '<span style="margin-left:20px; color: blue;">Replied</span>';
			                   	   }else if(consultVals[c][10]==='Y'){
			                   		   otherHTMLStr += '<span style="margin-left:20px; color: blue;">Acknowledged</span>';
			                   	   }
	                        	 if (showview==='DakReceivedList' && loggedInEmpId == consultVals[c][0] && ActionType==='ACTION'  && (DakStatus==='DD'|| DakStatus==='DA') && ReplyCount==0 ) {
	                      	       otherHTMLStr += '<span style="margin-left:50px;"><button type="button" class="btn btn-success btn-sm  " onclick="return RemindopenModal('+dakIdVal+')">Remind</button></span>';
	                        	 }
	                   	         if(showview==='DakReceivedList' && loggedInEmpId == consultVals[c][0] && ActionType==='ACTION'  && (DakStatus==='DD'|| DakStatus==='DA') && ReplyCount==0 && consultVals[c][7]>0 && consultVals[c][9]>=0){
	                   	         otherHTMLStr += '<span style="margin-left:50px;"><button type="button" class="btn btn-sm icon-btn" title="Reply" data-toggle="tooltip" onclick="return RemindReplyopenModal(\'' + dakIdVal + '\',\'' + from + '\')"><img alt="Reply" src="view/images/remindview.gif"></button></span>';
	                   	         }
	                      	     otherHTMLStr += '</span><br>';  
                    	 }else{
                        	     otherHTMLStr += '<span style="margin-left:2%;color: #0B6623;" id="' + Temp + '"> ' + count + '.'+ consultVals[c][1] + ' , ' + consultVals[c][2];
                        	     if(consultVals[c][11]>0){
			                   		   otherHTMLStr += '<span style="margin-left:20px; color: blue;">Replied</span>';
			                   	   }else if(consultVals[c][10]==='Y'){
			                   		   otherHTMLStr += '<span style="margin-left:20px; color: blue;">Acknowledged</span>';
			                   	   }
                        	     if (showview==='DakReceivedList' && loggedInEmpId == consultVals[c][0] && ActionType==='ACTION'  && (DakStatus==='DD'|| DakStatus==='DA') && ReplyCount==0 ) {
                        	         otherHTMLStr += '<span style="margin-left:50px;"><button type="button" class="btn btn-success btn-sm  " onclick="return RemindopenModal('+dakIdVal+')">Remind</button></span>';
                        	     }
                        	     if(showview==='DakReceivedList' && loggedInEmpId == consultVals[c][0] && ActionType==='ACTION'  && (DakStatus==='DD'|| DakStatus==='DA') && ReplyCount==0 && consultVals[c][7]>0 && consultVals[c][9]>=0){
                       	            otherHTMLStr += '<span style="margin-left:50px;"><button type="button" class="btn btn-sm icon-btn" title="Reply" data-toggle="tooltip" onclick="return RemindReplyopenModal(\'' + dakIdVal + '\',\'' + from + '\')"><img alt="Reply" src="view/images/remindview.gif"></button></span>';
                       	         }
                        	     otherHTMLStr += '</span><br>';  
                    	 }
                           //call function for multiple facilitators below is the ajax code for it
                            MultipleCaseworkersList( consultVals[c][0],dakIdVal,Temp);
                           //from above function facilitators will be added  using ajax
                    }
                    count++;
                    EmpId.push(consultVals[c][0]);
                    if (parseInt(consultVals[c][5]) > 0) {
                  //call function for Seek Response below is the ajax code for it
                    MultipleMarkerSeekResponseList( consultVals[c][0],dakIdVal,Temp);
                   //from above function Seek Response will be added  using ajax
                    }
                }
                $('#empidvalueforlist').val(EmpId);
                $('#DistributedListDisplay').html(otherHTMLStr);
            } else {
                var noEmployeesHTML = '<img src="view/images/infoicon.png" style="cursor: none; "/>&nbsp;&nbsp;<span style="color:#2196F3">No Employees Marked for this DAK</span>';
                $('#DistributedListDisplay').html(noEmployeesHTML);
            }
        }
    });
}
function RemindopenModal(DakId) {
	 $('#RemindSentModal').modal('show');
	 $('#RemindDakId').val(DakId);
	 var loggedInEmpId = <%= LoginEmpId %>;
	 var RemindDakNoView="<%=dakReceivedList[9]%>";
	 var RemindSourceView="<%=dakReceivedList[4]%>";
	 $('#RemindViewDakNo').html(RemindDakNoView);
	 $('#RemindSourcetype').html(RemindSourceView);
	 $.ajax({
	        type: "GET",
	        url: "getRemindemplist.htm",
	        data: {
	        	DakId: DakId
	        },
	        dataType: 'json',
	        success: function(result) {
	            var consultVals = Object.values(result); // Use Object.values() to get the values of the object
	            if (result != null) {
	            	 $('#RemindEmployee').empty();
	                 for (var c = 0; c < consultVals.length; c++) {
	                	 if(consultVals[c][0]!=loggedInEmpId){
	                	var optionValue = consultVals[c][0]+'/'+consultVals[c][5];
	         	        var optionText = consultVals[c][1].trim() + ', ' + consultVals[c][2];
	         	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
	         	       $('#RemindEmployee').append(option);
	                 }
	               }
	                 $
	                 // Refresh the selectpicker after appending options
	                 $('#RemindEmployee').selectpicker('refresh');
	            }
	        }
	    }); 
	 RemindSentViewDetails(DakId,loggedInEmpId);
}

function RemindSentViewDetails(DakId,loggedInEmpId) {
	 $.ajax({
	        type: "GET",
	        url: "getRemindToDetails.htm",
	        data: {
	        	DakId: DakId,
	        	loggedInEmpId:loggedInEmpId
	        },
	        dataType: 'json',
	        success: function(result) {
	            var consultVals = Object.values(result); // Use Object.values() to get the values of the object
	            if (result != null) {
	                 var otherHTMLStr = '';
               		 for (var c = 0; c < consultVals.length; c++) {
	            	 if(consultVals[c][5]!==null && consultVals[c][5]==='C'){
	            		 otherHTMLStr += '<span style="margin-left:2%;color: #0073FF;"><b>'+'C ->  ' + consultVals[c][3] + '  ( RemindBy ' + consultVals[c][1] + ' - To '+ consultVals[c][0] + ' ) On '+consultVals[c][4] +'</b>';
	            		 otherHTMLStr += '</span><br>';
	            	 }else if(consultVals[c][5]!==null && consultVals[c][5]==='R'){
	            		 otherHTMLStr += '<span style="margin-left:2%; color: green;" ><b>'+'R ->  ' + consultVals[c][3] +' ( Replied By ' + consultVals[c][0] + ' )  On ' + consultVals[c][4] +'</b>';
	            		 otherHTMLStr += '</span><br>';
	            	 }
	            }
               		 $('#RemindDetails').html(otherHTMLStr);
	        }
	        }
	    }); 
}

function RemindReplyopenModal(DakId,RepliedFrom) {
	$('#RemindReplyview').modal('show');
	$('#RemindReplyDakId').val(DakId);
	var RemindDakNoView="<%=dakReceivedList[9]%>";
	var RemindSourceView="<%=dakReceivedList[4]%>";
	 $('#RemindReplyViewDakNo').html(RemindDakNoView);
	 $('#RemindReplySourcetype').html(RemindSourceView);
	 $('#RepliedFrom').val(RepliedFrom);
	 $.ajax({
	        type: "GET",
	        url: "getPerticularRemindToDetails.htm",
	        data: {
	        	DakId: DakId,
	        },
	        dataType: 'json',
	        success: function(result) {
	        	var RemindBy='';
	            var consultVals = Object.values(result); // Use Object.values() to get the values of the object
	            if (result != null) {
	            	
	                 var otherHTMLStr = '';
            		 for (var c = 0; c < consultVals.length; c++) {
	            	 if(consultVals[c][2]!==null && consultVals[c][6]!==null && consultVals[c][6]==='C'){
	            		 otherHTMLStr += '<span style="margin-left:2%;color: #0073FF;"><b>'+'C -> ' + consultVals[c][2] + '  ( RemindBy ' + consultVals[c][0] + ' ) On '+consultVals[c][3] +'</b>';
	            		 otherHTMLStr += '</span><br>';
	            	 }else if(consultVals[c][2]!==null && consultVals[c][6]!==null && consultVals[c][6]==='R'){
	            		 otherHTMLStr += '<span style="margin-left:2%;color:green;"><b>'+'R -> ' + consultVals[c][2] + '  ( RepliedBy ' + consultVals[c][5] + ' ) On '+consultVals[c][3] +'</b>';
	            		 otherHTMLStr += '</span><br>';
	            	 }
	            	 RemindBy=consultVals[c][4];
	            }
            		 $('#RemindById').val(RemindBy);
            		 $('#RemindPerticularDetails').html(otherHTMLStr);
	        }
	        }
	    }); 
	
}

function DakRemindReplySubmit() {
	 var isValidated = false;
	   var replyRemark = $('#RemindReply').val();
	if(replyRemark.trim() == "") { 
  	isValidated = false;
  }else{
  	isValidated = true;
  }
  if (!isValidated) {
      event.preventDefault(); // Prevent form submission
      alert("Please fill in the Reply input field.");
    } else {
        // Retrieve the form and submit it
        var confirmation = confirm("Are you sure you want to Reply?");
        if (confirmation) {
      	  var button = $('#DakRemindReplySubValidate');
 			var formAction = button.attr('formaction');
 			if (formAction) {
 				  var form = button.closest('form');
 				  form.attr('action', formAction);
 				  form.submit();
 				}else{
 					console.log('form action not found');
 				}
        } else { return false; }
    }//else close
}
//------------------------------------------- Attachment Download ----------------------------------->
function Iframepdf(data){
	 $.ajax({
			
			type : "GET",
			url : "getiframepdf.htm",
			data : {
				
				data: data
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			 $('#modalbody').html('');
			if(result[0]==='pdf' || result[0]==='PDF' || result[0]==='Pdf'){
				var fileData = result[1]; // Base64 encoded file data
			    var byteCharacters = atob(fileData); // Decode the base64 data
			    var byteArrays = [];
			    for (var offset = 0; offset < byteCharacters.length; offset += 512) {
			      var slice = byteCharacters.slice(offset, offset + 512);
			      var byteNumbers = new Array(slice.length);
			      for (var i = 0; i < slice.length; i++) {
			        byteNumbers[i] = slice.charCodeAt(i);
			      }
			      var byteArray = new Uint8Array(byteNumbers);
			      byteArrays.push(byteArray);
			    }
			    var fileSize = byteArrays.reduce(function (acc, byteArr) {
			      return acc + byteArr.length;
			    }, 0);
			    var maxSize = 1.5 * 1024 * 1024; // 1.5 MB (in bytes)
			    if (fileSize > maxSize) {
			    	document.getElementById('largedocument').value=data;
			    	$('#myModallarge').modal('show');
			    } else {
			    	 $('#myModalPreview').appendTo('body').modal('show');
			    	 // Get the base64-encoded PDF content from result[1]
			    	 const base64Content = result[1];
			    	 // Convert the base64 content into a Uint8Array
			    	 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
			    	 // Create a Blob from the Uint8Array
			    	 const blob = new Blob([byteArray], { type: 'application/pdf' });
			    	 // Create a Blob URL for the Blob
			    	 const url = URL.createObjectURL(blob);
			    	 // Create a temporary anchor element for downloading
			    	 const a = document.createElement('a');
			    	 a.href = url;
			    	 a.download = result[2]+''; // Set the desired filename
			    	 a.style.display = 'none';
			    	 document.body.appendChild(a);
			    	 // Trigger the download
			    	 a.click();
			    	 // Clean up the temporary anchor and Blob URL after the download
			    	 document.body.removeChild(a);
			    	 URL.revokeObjectURL(url);
			      $('#modalbody').html("<iframe  src='data:application/pdf;base64," + result[1] + "' width='100%' height='800' id='iframes' style='display: block;' name='showiframes'></iframe>");
			      // $('#modalbody').html(pdfContent);
			    }
			}else if (result[0] === 'xls' || result[0] === 'xlsx' || result[0] === 'XLS' || result[0] === 'XLSX'|| result[0] === 'Xls' || result[0] === 'Xlsx') {
				 $('#myModalPreview').appendTo('body').modal('show');
				 // Get the base64-encoded Excel content from result[1]
				    const base64Content = result[1];
				    // Convert the base64 content into a Uint8Array
				    const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
				    // Create a Blob from the Uint8Array, specifying the MIME type for Excel
				    const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
				    // Create a temporary anchor element for downloading
				    const a = document.createElement('a');
				    a.href = URL.createObjectURL(blob);
				    a.download = result[2]+''; // Set the desired filename with .xlsx extension
				    // Trigger the download
				    a.click();
				    // Clean up the temporary anchor and Blob URL after the download
				    URL.revokeObjectURL(a.href);
			    //$('#modalbody').html("<iframe src='data:application/vnd.ms-excel;base64," + result[1].toString() + "' width='100%' height='650' id='iframes' type='application/vnd.ms-excel' name='showiframes'></iframe>");
			    $('#myModalPreview').modal('hide');
			} else if (result[0] === 'txt' || result[0] === 'TXT' || result[0] === 'Txt') { // Check for .txt files
				 $('#myModalPreview').appendTo('body').modal('show');
				    const base64Content = result[1];
				    const decodedContent = atob(base64Content);
				    const blob = new Blob([decodedContent], { type: 'text/plain' });
				    const url = URL.createObjectURL(blob);
				    const link = document.createElement('a');
				    link.href = url;
				    link.download = result[2]+''; // You can change the filename here
				    link.click();
				    // Clean up the object URL after the download
				    URL.revokeObjectURL(url);
				  $('#myModalPreview').modal('hide');
			}else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {// Check for .docx files
				 $('#myModalPreview').appendTo('body').modal('show');
				// Get the base64-encoded DOCX content from result[1]
				 const base64Content = result[1];
				 // Convert the base64 content into a Uint8Array
				 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
				 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
				 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });
				 // Create a temporary anchor element for downloading
				 const a = document.createElement('a');
				 a.href = URL.createObjectURL(blob);
				 a.download =result[2]+''; // Set the desired filename with .docx extension
				 // Trigger the download
				 a.click();
				 // Clean up the temporary anchor and Blob URL after the download
				 URL.revokeObjectURL(a.href);
			       $('#myModalPreview').modal('hide');	  
			} else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
				$('#myModalPreview').appendTo('body').modal('show');
				$('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.presentationml.presentation;base64," + result[1] + "' width='100%' height='650' id='iframes' type='application/vnd.openxmlformats-officedocument.presentationml.presentation' name='showiframes'></iframe>");
				// Provide a download link
				const downloadLink = document.createElement('a');
				downloadLink.href = 'data:application/octet-stream;base64,' + result[1]; // Set the MIME type to application/octet-stream
				downloadLink.download = result[2]+''; // Set the desired filename
				downloadLink.style.display = 'none'; // Hide the download link
				document.body.appendChild(downloadLink);
				// Trigger the download link click
				downloadLink.click();
				document.body.removeChild(downloadLink); // Clean up the download link
				$('#myModalPreview').modal('hide');
			}else if (['jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'gif', 'avif', 'png'].includes(result[0].toLowerCase())) {
			    $('#myModalPreview').appendTo('body').modal('show');
			    $('#modalbody').html("<img style='max-width:40cm;max-height:17cm;margin-left:25%; display: block' src='data:image/" + result[0] + ";base64," + result[1] + "'>");
			}else {
					$('#myModalPreview').modal('hide');
		            const base64Content = result[1];
		            const decodedContent = atob(base64Content);
		            const blob = new Blob([decodedContent], { type: 'application/octet-stream' }); // Set a generic content type
		            const url = URL.createObjectURL(blob);
		            const link = document.createElement('a');
		            link.href = url;
		            link.download = result[2]+''; // You can set a default filename here
		            link.click();
		            // Clean up the object URL after the download
		            URL.revokeObjectURL(url);
			}
			}
			});	
	 openDraggableModal();
}
function openDraggableModal() {
    $('#myModalPreview').appendTo('body').modal('show');

    // Make the modal draggable
    $('#myModalPreview').draggable({
        handle: ".modal-header" // Define the handle for dragging
    });
}
//------------------------ Caseworkers emlloyees info ------------------->
function MultipleCaseworkersList(MarkerEmpId,DakId,Temp){
	var loggedInEmpId = <%= LoginEmpId %>; 
    var DakStatus="<%=dakReceivedList[6]%>";
    var ReplyCount=<%=dakReceivedList[42]%>;
    var ActionType="<%=dakReceivedList[10]%>";
    var showview="<%=viewfrom%>";
    
    console.log()
    $.ajax({
        type: "GET",
        url: "getFacilitatorsEmpDetails.htm",
        data: {
        	markerEmpId: MarkerEmpId,
        	dakId: DakId
        },
        datatype: 'json',
        success: function (result) {
        	   if (result != null && result != '') {
                   result = JSON.parse(result);
                   var consultVals = Object.keys(result).map(function (e) {
                       return result[e];
                   });
                   var facilitatorHTMLStr = '';
                   var id = 'Facilitators';
                   var count = 1;
                   var from='DakAssignedList';
                  facilitatorHTMLStr = '<ul>'; // Open the <ul> here
                  for (var c = 0; c < consultVals.length; c++) {
                      var faci = id + (c + 1);
                       facilitatorHTMLStr += '<li style="color: #FF8C00;" id="' + faci + '">' + count + '.' + consultVals[c][4] + ' , ' + consultVals[c][5];
                       if(showview==='DakAssignedList' && loggedInEmpId == consultVals[c][1] && ActionType==='ACTION'  && (DakStatus==='DD'|| DakStatus==='DA') && ReplyCount==0 && consultVals[c][7]>0){
                    	   facilitatorHTMLStr += '<span style="margin-left:50px;"><button type="button" class="btn btn-sm icon-btn" title="Reply" data-toggle="tooltip" onclick="return RemindReplyopenModal(\'' + DakId + '\',\'' + from + '\')"><img alt="Reply" src="view/images/remindview.gif"></button></span>';
	                  	   }
                       facilitatorHTMLStr +='</li>';
                       count++;
                       if(consultVals[c][6]>0){
                    	   MultipleFacilitatorSeekResponseList(consultVals[c][1],DakId,faci);
                       }
                  }
                   facilitatorHTMLStr += '</ul>'; // Close the <ul> here
                   $('#' + Temp).next('ul').remove(); // Remove previous <ul> if exists
                   $('#' + Temp).after(facilitatorHTMLStr); // Append the new <ul>
               } else {
                   $('#' + Temp).next('ul').remove(); // Remove previous <ul> if no data
               }
        }
        });         
}

function MultipleMarkerSeekResponseList(MarkerEmpId,DakId,Temp){
    $.ajax({
        type: "GET",
        url: "getSeekResponseEmpDetails.htm",
        data: {
        	markerEmpId: MarkerEmpId,
        	dakId: DakId
        },
        datatype: 'json',
        success: function (result) {
        	   if (result != null && result != '') {
                   result = JSON.parse(result);
                   var consultVals = Object.keys(result).map(function (e) {
                       return result[e];
                   });
                   var SeekResponseHTMLStr = '';
                   var id = 'SeekResponse';
                   var count = 1;
                   SeekResponseHTMLStr = '<ul>'; // Open the <ul> here
                   for (var c = 0; c < consultVals.length; c++) {
                      var faci = id + (c + 1);
                      SeekResponseHTMLStr += '<li style="color: #A52A2A;" id="' + faci + '">' + count + '.' + consultVals[c][4] + ' , ' + consultVals[c][5] + '</li>';
                       count++;
                  }
                  SeekResponseHTMLStr += '</ul>'; // Close the <ul> here
                   $('#' + Temp).after(SeekResponseHTMLStr); // Append the new <ul>
               } else {
                   $('#' + Temp).next('ul').remove(); // Remove previous <ul> if no data
               }
        }
        });         
} 

function MultipleFacilitatorSeekResponseList(AssignEmpId,DakId,Temp){
    $.ajax({
        type: "GET",
        url: "getFacilitatorSeekResponseEmpDetails.htm",
        data: {
        	markerEmpId: AssignEmpId,
        	dakId: DakId
        },
        datatype: 'json',
        success: function (result) {
        	   if (result != null && result != '') {
                   result = JSON.parse(result);
                   var consultVals = Object.keys(result).map(function (e) {
                       return result[e];
                   });
                   var SeekResponseHTMLStr = '';
                   var id = 'SeekResponse';
                   var count = 1;
                   SeekResponseHTMLStr = '<ul>'; // Open the <ul> here
                  for (var c = 0; c < consultVals.length; c++) {
                      var faci = id + (c + 1);
                      SeekResponseHTMLStr += '<li style="color: #A52A2A;" id="' + faci + '">' + count + '.' + consultVals[c][4] + ' , ' + consultVals[c][5] + '</li>';
                       count++;
                  }
                  SeekResponseHTMLStr += '</ul>'; // Close the <ul> here
                   $('#' + Temp).after(SeekResponseHTMLStr); // Append the new <ul>
               } else {
                   $('#' + Temp).next('ul').remove(); // Remove previous <ul> if no data
               }
        }
        });         
} 
//----------------- marker reply data --------------------->
function dakMarkerReplyPreview(dakId){
	$.ajax({
		 type : "GET",
			url : "GetReplyModalDetails.htm",
			data : {
				dakid: dakId
			},
			datatype : 'json',
			success : function(result) {
				if(result !=null && result!="[]"){
		       	   //display the hidden btnReplyDetailsPreview div 
		        	 $('.btnReplyDetailsPreview').show(); 
		        	 // Clear previous data
				        $(".DakReply").empty();
					 var replyData = JSON.parse(result); // Parse the JSON data
					 const replyCountOverall = parseInt( replyData[0][12]);
			    	 const replyCountByEmpId = parseInt( replyData[0][13]);
			    	 const replyCountByAuthority = parseInt( replyData[0][14]);
			    	 if (  replyCountOverall > 0 || (replyCountByEmpId > 0 ||  replyCountByAuthority > 0)){
					 for (var i = 0; i < replyData.length; i++) {
						    var row = replyData[i];
						    var repliedPersonName = row[6];
							$('#replierName').val(repliedPersonName);
						    var repliedPersonDesig = row[7];
						    var repliedRemarks = row[2];
						    var replyid= row[0];
						    var replyEmpId=row[1];
						    var loggedInEmpId = <%= LoginEmpId %>;
						    var action = row[10];
						    var dakStatus = row[11];
						    var DateTime=row[5];
						    var date = new Date(DateTime);
							 // Format the date and time
							 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
							     month: 'short',
							     day: 'numeric',
							     year: 'numeric',
							     hour: 'numeric',
							     minute: 'numeric'
							 }).format(date);
						    var dynamicReplyDiv = $("<div>", { class: "DAKReplysBasedOnReplyId", style: "min-width:100px;min-height:110px; width:100%;" });
						    dynamicReplyDiv.after("<br>");
						    var h4 = $("<h4>", { 
						    	  class: "RepliedPersonName", 
						    	  id: "model-person-header", 
						    	  html: (i + 1) + ". " + repliedPersonName + ", " + repliedPersonDesig + ",  <span style='color: black; font-size:15px;'> " + formattedDateTime + "</span>" 
						    	});
						    dynamicReplyDiv.append(h4);//appended h4
						    var replyEditButton = $("<button>", {
						    	  type: "button",
						    	  class: "btn btn-sm icon-btn replyedit-click",
						    	  "data-toggle": "tooltip",
						    	  "data-placement": "top",
						    	  title: "Edit",
						    	  onclick: "replyCommonEdit('" + replyid + "')"
						    	});
                           var editImage = $("<img>", { alt: "edit",src: "view/images/writing.png"});
                           replyEditButton.append(editImage);
                           if(replyEmpId == loggedInEmpId && dakStatus!="DC" && dakStatus!="AP"){
							      dynamicReplyDiv.append(replyEditButton);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
							  }
						     var replyForwardForEditBtn  = $("<button>", {
						    	  type: "button",
						    	  class: "btn btn-sm icon-btn replyforwardforedit-click",
						    	  "data-toggle": "tooltip",
						    	  "data-placement": "top",
						    	  title: "Reply Forward",
						    	  onclick: "replyForwardForEdit('" + replyid + "')"
						    	});
                           var forwardForEditImage = $("<img>", { alt: "edit",src: "view/images/replyChange.png"});
                           if(dakStatus!="DC" && dakStatus!="AP"){
                           replyForwardForEditBtn.append(forwardForEditImage);
                           }
                         dynamicReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
						    var innerDiv = $("<div>", { class: "row replyRow" });
						    var formgroup1 = $("<div>", { class: "form-group group1" });
						    var replyText = repliedRemarks.length < 120 ? repliedRemarks : repliedRemarks.substring(0, 120);
						    var replyDiv = $("<div>", { class: "col-md-12 replyremarks-div", contenteditable: "false" }).text(replyText);
						    if (repliedRemarks.length > 120) {
						        var button = $("<button>", {
						            type: "button",
						            class: "viewmore-click",
						            name: "sub",
						            value: "Modify",
						            onclick: "replyViewMoreModal('" + replyid + "')"
						        }).text("...(View More)");
						        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));
						        replyDiv.append(button, b);
						    }
				          formgroup1.append(replyDiv);   
						  innerDiv.append(formgroup1);
                         dynamicReplyDiv.append(innerDiv);
				            // Check if row[9] count i.e DakReplyAttachCount is more than 0
					          if (row[9] > 0) {
					        	  // Call a function and pass row[0] i.e DakReplyId
					              DakReplyAttachPreview(row[0], dynamicReplyDiv);
					            }
                           $(".DakReply").append(dynamicReplyDiv);
                        // Add line break after the textarea and DakReplyDivEnd
                           $(".DakReply").append("<br>");
					 }//for loop close
					//replyCountOverall>0 if condition close but dont have authority then disable else hide
				}else{ 
					 // Clear previous data
			        $(".DakReply").empty();
			      //reset previously selected toggle  its important
		       	     resetPreviewButtons();
			        	 $('.btnReplyDetailsPreview').hide(); 
				}
					//reseult!=null if condition close //when ajax doesnot result queryyyyy
				}else{
					 // Clear previous data
			        $(".DakReply").empty();
		       	   //hide the btnReplyDetailsPreview div 
		        	 $('.btnReplyDetailsPreview').hide(); 
				}
			}
	 });
}
function DakReplyAttachPreview(DakReplyIdData, dynamicReplyDiv) {
	  $.ajax({
	    type: "GET",
	    url: "GetReplyAttachModalList.htm",
	    data: {
	      dakreplyid: DakReplyIdData
	    },
	    datatype: 'json',
	    success: function(result) {
	      if (result != null) {
	        var resultData = JSON.parse(result);
	        if (resultData.length > 0) {
	          var formgroup2 = $("<div>", { class: "form-group group2" });
	          var tableDiv = $("<div>", { class: "col-md-6 replyModAttachTbl-div" });
	          var table = $("<table>", { class: "table table-hover table-striped table-condensed info shadow-nohover downloadReplyAttachTable" });
	          var ReplyAttachTbody = '';
	          for (var z = 0; z < resultData.length; z++) {
	            var row = resultData[z];
	            ReplyAttachTbody += '<tr> ';
	            ReplyAttachTbody += '  <td style="text-align: left;">';   
	            ReplyAttachTbody += '  <form action="#" id="Replyform">';
	            ReplyAttachTbody += '  <input type="hidden" id="ReplyIframeData" name="markerdownloadbtn">';
	            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply"  value="'+row[0]+'"  onclick="IframepdfMarkerReply('+row[0]+',0)" data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
	            ReplyAttachTbody += '  </form>';
	            ReplyAttachTbody += '  </td>';
	            ReplyAttachTbody += '</tr> ';
	          }
	          table.html(ReplyAttachTbody);
	          tableDiv.append(table);
	          formgroup2.append(tableDiv);
	          var innerDiv = dynamicReplyDiv.find('.replyRow');
	          innerDiv.append(formgroup2);
	        }
	      }
	    },
	    error: function(xhr, textStatus, errorThrown) {
	      // Handle error
	    }
	  });
	}
	
function replyCommonEdit(replyid){
	  $.ajax({
		    type: "GET",
		    url: "GetReplyEditDetails.htm",
		    data: {
		    	replyid: replyid
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		    	   var data = JSON.parse(result);
		           // Extract the "Remarks" value
		           $('.replyDataInEditModal').val(data.Remarks);
		           $('#dakReplyIdOfReplyEdit').val(data.DakReplyId);
		           $('#dakIdOfReplyEdit').val(data.DakId);
		           $('#empIdOfReplyEdit').val(data.EmpId);
		           replyAttachCommonEdit(replyid);
				}//if condition close
			}//successClose
	 });//ajaxClose  
	 $('#replyCommonEditModal').appendTo('body').modal('show');
}//functionClose
function replyAttachCommonEdit(replyid){
	 $.ajax({
		    type: "GET",
		    url: "GetReplyAttachModalList.htm",
		    data: {
		      dakreplyid: replyid
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		        var resultData = JSON.parse(result); 
		        var ReplyAttachTbody = '';
		          for (var z = 0; z < resultData.length; z++) {
		            var row = resultData[z];
		            ReplyAttachTbody += '<tr> ';
		            ReplyAttachTbody += '  <td style="text-align: left;">';
		            ReplyAttachTbody += '  <form action="#" id="Replyform">';
		            ReplyAttachTbody += '  <input type="hidden" id="ReplyIframeDataEdit" name="markerdownloadbtn">';
		            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="dakEditReplyDownloadBtn"  value="'+row[0]+'"  onclick="IframepdfMarkerReply('+row[0]+',0)" data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
		            ReplyAttachTbody += '  </form>';
		            ReplyAttachTbody += '  </td>';
		            ReplyAttachTbody += '  <td style="text-align: left;">';
		            ReplyAttachTbody +=	'		<button type="button" id="ReplyEditAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="ReplyAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;"  onclick="deleteReplyEditAttach('+row[0]+','+row[1]+')" ><img alt="attach" src="view/images/delete.png"></button>';
		            ReplyAttachTbody += '  </td>';
		            ReplyAttachTbody += '</tr> ';
		          }
		      	$('#ReplyAttachEditDataFill').html(ReplyAttachTbody);
		      }          //if condition close
			}//successClose
	 });//ajaxClose    
}//functionClose

function  dakReplyEditValidation(){
	 var isValidated = false;
	   var replyRemarkOfEdit = document.getElementsByClassName("replyDataInEditModal")[0].value;
	if(replyRemarkOfEdit.trim() == "") { 
   	isValidated = false;
   }else{
   	isValidated = true;
   }
   if (!isValidated) {
       event.preventDefault(); // Prevent form submission
       alert("Please fill in the remark input field.");
     } else {
         // Retrieve the form and submit it
         var confirmation = confirm("Are you sure you want to edit this reply?");
         if (confirmation) {
       	  var button = $('#dakCommonReplyEditAction');
  			var formAction = button.attr('formaction');
  			if (formAction) {
  				  var form = button.closest('form');
  				  form.attr('action', formAction);
  				  form.submit();
  				}else{
  					console.log('form action not found');
  				}
         } else { return false; }
     }//else close
}

function replyForwardForEdit( replyid ){
	 var result = confirm ("Are You sure to forward this reply for edit ?"); 
	 if(result){
		 
	 }else{
		 return false;
	 }
}

function replyViewMoreModal(replyid) {
	 $('#replyViewMore').appendTo('body').modal('show');
	  $('#replyDetailsDiv').empty();
	  $.ajax({
	    type: "GET",
	    url: "GetReplyViewMore.htm",
	    data: {
	      dakreplyid: replyid
	    },
	    datatype: 'json',
	    success: function(result) {
	      if (result != null) {
	        var resultData = JSON.parse(result);
	        for (var i = 0; i < resultData.length; i++) { // Corrected the loop variable
	          var row = resultData[i];
	          var remarks = row[1];
	          $('#replyDetailsDiv').append(remarks);
	        }
	      }
	    }
	  });
	}
	
function IframepdfMarkerReply(data,ref){
	 $.ajax({
			type : "GET",
			url : "IframeReplyDownloadAttach.htm",
			data : {
				data: data
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			 $('#modalbody').html('');
			 if(result[0]==='pdf' || result[0]==='PDF' || result[0]==='Pdf'){// Check for .pdf files
				var fileData = result[1]; // Base64 encoded file data
			    var byteCharacters = atob(fileData); // Decode the base64 data
			    var byteArrays = [];
			    for (var offset = 0; offset < byteCharacters.length; offset += 512) {
			      var slice = byteCharacters.slice(offset, offset + 512);
			      var byteNumbers = new Array(slice.length);
			      for (var i = 0; i < slice.length; i++) {
			        byteNumbers[i] = slice.charCodeAt(i);
			      }
			      var byteArray = new Uint8Array(byteNumbers);
			      byteArrays.push(byteArray);
			    }
			    var fileSize = byteArrays.reduce(function (acc, byteArr) {
			      return acc + byteArr.length;
			    }, 0);
			    var maxSize = 1.5 * 1024 * 1024; // 1.5 MB (in bytes)
			    if (fileSize > maxSize) {
			    	document.getElementById('markerlargedocument').value=data;
			   	 $('#myModalMarkerlarge').appendTo('body').modal('show');
			    } else {
			    	 $('#myModalPreview').appendTo('body').modal('show');
			    	// Get the base64-encoded PDF content from result[1]
			    	 const base64Content = result[1];
			    	 // Convert the base64 content into a Uint8Array
			    	 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
			    	 // Create a Blob from the Uint8Array
			    	 const blob = new Blob([byteArray], { type: 'application/pdf' });
			    	 // Create a Blob URL for the Blob
			    	 const url = URL.createObjectURL(blob);
			    	 // Create a temporary anchor element for downloading
			    	 const a = document.createElement('a');
			    	 a.href = url;
			    	 a.download = result[2]+''; // Set the desired filename
			    	 a.style.display = 'none';
			    	 document.body.appendChild(a);
			    	 // Trigger the download
			    	 a.click();
			    	 // Clean up the temporary anchor and Blob URL after the download
			    	 document.body.removeChild(a);
			    	 URL.revokeObjectURL(url);
			      $('#modalbody').html("<iframe  src='data:application/pdf;base64," + result[1] + "' width='100%' height='600' id='iframes' style='display: block;' name='showiframes'></iframe>");
			    }
			 }else if (result[0] === 'xls' || result[0] === 'xlsx' || result[0] === 'XLS' || result[0] === 'XLSX'|| result[0] === 'Xls' || result[0] === 'Xlsx') {
				 $('#myModalPreview').appendTo('body').modal('show');
				// Get the base64-encoded Excel content from result[1]
				    const base64Content = result[1];
				    // Convert the base64 content into a Uint8Array
				    const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
				    // Create a Blob from the Uint8Array, specifying the MIME type for Excel
				    const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
				    // Create a temporary anchor element for downloading
				    const a = document.createElement('a');
				    a.href = URL.createObjectURL(blob);
				    a.download = result[2]+''; // Set the desired filename with .xlsx extension
				    // Trigger the download
				    a.click();
				    // Clean up the temporary anchor and Blob URL after the download
				    URL.revokeObjectURL(a.href);
				 //$('#modalbody').html("<iframe src='data:application/vnd.ms-excel;base64," + result[1].toString() + "' width='100%' height='650' id='iframes' type='application/vnd.ms-excel' name='showiframes'></iframe>");
			    $('#myModalPreview').modal('hide');
			} else if (result[0] === 'txt') { // Check for .txt files
				 $('#myModalPreview').appendTo('body').modal('show');
				    const base64Content = result[1];
				    const decodedContent = atob(base64Content);
				    const blob = new Blob([decodedContent], { type: 'text/plain' });
				    const url = URL.createObjectURL(blob);
				    const link = document.createElement('a');
				    link.href = url;
				    link.download = result[2]+''; // You can change the filename here
				    link.click();
				    // Clean up the object URL after the download
				    URL.revokeObjectURL(url);
				  $('#myModalPreview').modal('hide');
			} else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
				if(ref==0)
				{
				const form = document.getElementById('Replyform');
				 $("#ReplyIframeData").val(data);  
				 $("#ReplyIframeDataEdit").val(data);
				 form.action = 'ReplyDownloadAttach.htm';
				 form.submit();
				}
			else if(ref==1)
				{
				const form = document.getElementById('formId');
				 $("#ReplyIframeData").val(data);  
				 form.action = 'ReplyDownloadAttach.htm';
				 form.submit();
				}
			} else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {// Check for .docx files
				 $('#myModalPreview').appendTo('body').modal('show');
			       // $('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64," + result[1] + "' width='100%' height='0' id='iframes' type='application/vnd.openxmlformats-officedocument.wordprocessingml.document' name='showiframes'></iframe>");
			       // Get the base64-encoded DOCX content from result[1]
				 const base64Content = result[1];
				 // Convert the base64 content into a Uint8Array
				 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
				 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
				 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });
				 // Create a temporary anchor element for downloading
				 const a = document.createElement('a');
				 a.href = URL.createObjectURL(blob);
				 a.download = result[2]+''; // Set the desired filename with .docx extension
				 // Trigger the download
				 a.click();
				 // Clean up the temporary anchor and Blob URL after the download
				 URL.revokeObjectURL(a.href);
			       $('#myModalPreview').modal('hide');
			}else if (['jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'gif', 'avif', 'png'].includes(result[0].toLowerCase())) {
			    $('#myModalPreview').appendTo('body').modal('show');
			    $('#modalbody').html("<img style='max-width:40cm;max-height:17cm;margin-left:25%; display: block' src='data:image/" + result[0] + ";base64," + result[1] + "'>");
			}else {
				$('#myModalPreview').modal('hide');
	            const base64Content = result[1];
	            const decodedContent = atob(base64Content);
	            const blob = new Blob([decodedContent], { type: 'application/octet-stream' }); // Set a generic content type
	            const url = URL.createObjectURL(blob);
	            const link = document.createElement('a');
	            link.href = url;
	            link.download = result[2]+''; // You can set a default filename here
	            link.click();
	            // Clean up the object URL after the download
	            URL.revokeObjectURL(url);
		}
			}
			});
}
function deleteReplyEditAttach(ReplyAttachmentId,ReplyId){
	 $('#replyAttachmentIdFrDelete').val(ReplyAttachmentId);
	 $('#replyIdFrAttachDelete').val(ReplyId);
	 var result = confirm ("Are You sure to Delete ?"); 
	 if(result){
		var button = $('#ReplyEditAttachDelete');
		var formAction = button.attr('formaction');
		if (formAction) {
			  var form = button.closest('form');
			  form.attr('action', formAction);
			  form.submit();
			}else{
				console.log('form action not found');
			}
	} else {
	    return false; // or event.preventDefault();
	}
 }
 
function dakCSWReplyPreview(dakId){
	$.ajax({
		 type : "GET",
			url : "GetCSWReplyModalDetails.htm",
			data : {
				
				dakid: dakId
			},
			datatype : 'json',
			success : function(result) {
				if(result !=null && result!="[]"){
					 var replyCSWData = JSON.parse(result); // Parse the JSON data
					 $(".CaseworkerDakReplyData").empty();  
					 const replyCSWCountOverall = parseInt( replyCSWData[0][16]);
					 if(replyCSWCountOverall>0){
		           		//display the hidden btnCWReplyDetailsPreview div 
		            	$('.btnCWReplyDetailsPreview').show();
					 for (var i = 0; i < replyCSWData.length; i++) {
						    var data = replyCSWData[i];
						    var repliedCSWPersonName = data[6];
							$('#cswreplierName').val(repliedCSWPersonName);
						    var repliedCSWPersonDesig = data[7];
						    var repliedData = data[2];
						    var dakAssignReplyId= data[0];
						    var replyEmpId=data[1];
						    var loggedInEmpId = <%= LoginEmpId %>;
						    var action = data[9];
						    var MarkerPersName = data[13];
						    var MarkerPersDesig = data[14];
						    var dakStatus = data[15];
						    var DateTime=data[5];
						    var ReplyStatus=data[17];
						 var date = new Date(DateTime);
						 // Format the date and time
						 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
						     month: 'short',
						     day: 'numeric',
						     year: 'numeric',
						     hour: 'numeric',
						     minute: 'numeric'
						 }).format(date);
						    var dynamicCSWReplyDiv = $("<div>", { class: "DAKCSWReplysBasedOnReplyId", style: "min-width:100px;min-height:100px; width:100%;" });
						    dynamicCSWReplyDiv.after("<br>");
						    var h4 = $("<h4>", {
						    	  class: "CSWRepliedPersonName",
						    	  id: "model-person-header",
						    	  html: (i + 1) + "." + repliedCSWPersonName + "," + repliedCSWPersonDesig + " ( <span style='color: blue'> Marked By - " + MarkerPersName + "," + MarkerPersDesig + "</span> )"+", "+
						    	  "  <span style='color: black; font-size:15px;'> " + formattedDateTime + "</span> "
						    	});
						    dynamicCSWReplyDiv.append(h4);//appended h4
						    if(ReplyStatus==='R'){
						     var replyCSWEditButton = $("<button>", {
						    	  type: "button",
						    	  class: "btn btn-sm icon-btn replycswedit-click",
						    	  "data-toggle": "tooltip",
						    	  "data-placement": "top",
						    	  title: "Edit",
						    	  onclick: "replyCSWCommonEdit('" + dakAssignReplyId + "')"
						    	});
						    	  var editImage = $("<img>", { alt: "edit",src: "view/images/writing.png"});
                          replyCSWEditButton.append(editImage); 
                           if(replyEmpId == loggedInEmpId && dakStatus!="DC" && dakStatus!="AP"){
                          	dynamicCSWReplyDiv.append(replyCSWEditButton);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
                           }
						    }else if(ReplyStatus==='F'){
							   var replyForwardForEditBtn  = $("<button>", {
							    	  type: "button",
							    	  class: "btn btn-sm icon-btn replyforwardforedit-click",
							    	  "data-toggle": "tooltip",
							    	  "data-placement": "top",
							    	  title: "Reply Edit",
							    	  onclick: "returnreplyForwardForEdit('" + dakAssignReplyId + "')"
							    	});
                                var forwardForEditImage = $("<img>", { alt: "edit",src: "view/images/revision.png"});
                                replyForwardForEditBtn.append(forwardForEditImage);
                                if(replyEmpId == loggedInEmpId  ){
                                	dynamicCSWReplyDiv.append(replyForwardForEditBtn);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
     							  }
						   }
							dynamicCSWReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
						    var innerCSWReplyDiv = $("<div>", { class: "row replyRow" });
						    var formgroup1 = $("<div>", { class: "form-group group1" });
						  /*   var replyLabel = $("<label>", { class: "form-control" }).css({ fontweight: "800", fontSize: "16px", color: "#07689f;",display: "inline-block",marginbottom: "0.5rem"}).text("Reply :"); */
						    var replyCSWText = repliedData.length < 120 ? repliedData : repliedData.substring(0, 120);
						    var replyCSWDiv = $("<div>", { class: "col-md-12 replyCSW-div", contenteditable: "false" }).text(replyCSWText);
						    if (repliedData.length > 120) {
						        var button = $("<button>", {
						            type: "button",
						            class: "viewmore-click",
						            name: "sub",
						            value: "Modify",
						            onclick: "replyCSWViewMoreModal('" + dakAssignReplyId + "')"
						        }).text("...(View More)");

						        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));
						        replyCSWDiv.append(button, b);
						    }
				          formgroup1.append(replyCSWDiv);   
				          innerCSWReplyDiv.append(formgroup1);
				          dynamicCSWReplyDiv.append(innerCSWReplyDiv);
				            // Check if row[8] count i.e DakReplyAttachCount is more than 0
					          if (data[8] > 0) {
					        	  // Call a function and pass row[0] i.e DakAssignReplyId
					              DakCSWReplyAttachPreview(data[0], dynamicCSWReplyDiv);
					            }
                          $(".CaseworkerDakReplyData").append(dynamicCSWReplyDiv);
                       // Add line break after the textarea and DakReplyDivEnd
                          $(".CaseworkerDakReplyData").append("<br>");
					 }//for loop close
					//resultCSWOverallCount>0 if condition close
				 }else{
					 $(".CaseworkerDakReplyData").empty();  
		            	$('.btnCWReplyDetailsPreview').hide();
					}
					 //result!=null if condition close
				}else{
					 $(".CaseworkerDakReplyData").empty();  
	            	$('.btnCWReplyDetailsPreview').hide();
				}
			}
	 });
}

function replyCSWCommonEdit(replyid){
	  $.ajax({
		    type: "GET",
		    url: "GetAssignReplyEditDetails.htm",
		    data: {
		    	replyid: replyid
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		    	   var data = JSON.parse(result);
		           // Extract the "Remarks" value
		           $('.assignReplyDataInEditModal').val(data.Reply);
		           $('#dakAssignReplyIdEdit').val(data.DakAssignReplyId);
		           $('#dakIdOfAssignReplyEdit').val(data.DakId);
		           $('#empIdOfAssignReplyEdit').val(data.EmpId);
		           $('#dakAssignIdReplyEdit').val(data.DakAssignId);
		           replyCSWAttachCommonEdit(replyid);
				}//if condition close
			}//successClose
	 });//ajaxClose  
	 $('#DakAssignreplyCommonEditModal').appendTo('body').modal('show');
}//functionClose

function replyCSWViewMoreModal(dakAssignReplyId){
	 $('#replyCSWViewMore').appendTo('body').modal('show');
	  $('#replyCSWViewMoreDetailsDiv').empty();
	  $.ajax({
	    type: "GET",
	    url: "GetAssignReplyViewMore.htm",
	    data: {
	      dakreplyid: dakAssignReplyId
	    },
	    datatype: 'json',
	    success: function(result) {
	      if (result != null) {
	        var resultData = JSON.parse(result);
	        for (var i = 0; i < resultData.length; i++) { // Corrected the loop variable
	          var row = resultData[i];
	          var remarks = row[1];
	          $('#replyCSWViewMoreDetailsDiv').append(remarks);
	        }
	      }
	    }
	  });
}
function DakCSWReplyAttachPreview(DakAssignReplyId, dynamicCSWReplyDiv) {
	  $.ajax({
	    type: "GET",
	    url: "GetCSWReplyAttachModalList.htm",
	    data: {
	      dakassignreplyid: DakAssignReplyId
	    },
	    datatype: 'json',
	    success: function(result) {
	      if (result != null) {
	        var resultData = JSON.parse(result);
	        if (resultData.length > 0) {
	          var formgroup2 = $("<div>", { class: "form-group TblReplyAttachs" });
	          var tableDiv = $("<div>", { class: "col-md-6 replyCSWModAttachTbl-div" });
	          var table = $("<table>", { class: "table table-hover table-striped table-condensed info shadow-nohover downloadReplyCSWAttachTable" });
	          var ReplyAttachTbody = '';
	          for (var z = 0; z < resultData.length; z++) {
	            var row = resultData[z];
	            ReplyAttachTbody += '<tr> ';
	            ReplyAttachTbody += '  <td style="text-align: left;">';
	            ReplyAttachTbody += '  <form action="#" id="CWReplyIframeForm">';
	            ReplyAttachTbody += '  <input type="hidden" id="CWReplyIframe" name="cswdownloadbtn">';
	            ReplyAttachTbody += '  <button type="button" class="btn btn-sm replyCSWAttachWithin-btn"   value="'+row[0]+'"  onclick="IframepdfCaseWorkerReply('+row[0]+')" name="dakReplyCSWDownloadBtn"  data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
	            ReplyAttachTbody += '  </form>';
	            ReplyAttachTbody += '  </td>';
	            ReplyAttachTbody += '</tr> ';
	          }
	          table.html(ReplyAttachTbody);
	          tableDiv.append(table);
	          formgroup2.append(tableDiv);
	          var innerDiv = dynamicCSWReplyDiv.find('.replyRow');
	          innerDiv.append(formgroup2);
	        }
	      }
	    },
	    error: function(xhr, textStatus, errorThrown) {
	      // Handle error
	    }
	  });
	}
	
function replyCSWAttachCommonEdit(replyid){
	 $.ajax({
		    type: "GET",
		    url: "GetAssignReplyAttachModalList.htm",
		    data: {
		      dakreplyid: replyid
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		        var resultData = JSON.parse(result); 
		        var ReplyAttachTbody = '';
		          for (var z = 0; z < resultData.length; z++) {
		            var row = resultData[z];
		            ReplyAttachTbody += '<tr> ';
		            ReplyAttachTbody += '  <td style="text-align: left;">';
		            ReplyAttachTbody += '  <form action="#" id="AssignIframeFormEditForm">';
		            ReplyAttachTbody += '  <input type="hidden" id="assignReplyIframeEdit" name="cswdownloadbtn">';
		            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn"  value="' + row[0] + '" onclick="IframepdfCaseWorkerReply('+row[0]+',1)" name="dakReplyCSWDownloadBtn"   data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
		            ReplyAttachTbody += '  </form>';
		            ReplyAttachTbody += '  </td>';
		            ReplyAttachTbody += '  <td style="text-align: left;">';
		            ReplyAttachTbody +=	'		<button type="button" id="cswReplyEditAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="AssignReplyAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;"  onclick="cswdeleteReplyEditAttach('+row[0]+','+row[1]+')" ><img alt="attach" src="view/images/delete.png"></button>';
		            ReplyAttachTbody += '  </td>';
		            ReplyAttachTbody += '</tr> ';
		          }
		      	$('#cswReplyAttachEditDataFill').html(ReplyAttachTbody);
		      }          //if condition close
			}//successClose
	 });//ajaxClose    
}//functionClose

function IframepdfCaseWorkerReply(data){
	 $.ajax({
			type : "GET",   
			url : "IframeReplyCSWDownloadAttach.htm",
			data : {
				data: data
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			 $('#modalbody').html('');
			 if(result[0]==='pdf' || result[0]==='PDF' || result[0]==='Pdf'){// Check for .pptx files
				var fileData = result[1]; // Base64 encoded file data
			    var byteCharacters = atob(fileData); // Decode the base64 data
			    var byteArrays = [];
			    for (var offset = 0; offset < byteCharacters.length; offset += 512) {
			      var slice = byteCharacters.slice(offset, offset + 512);
			      var byteNumbers = new Array(slice.length);
			      for (var i = 0; i < slice.length; i++) {
			        byteNumbers[i] = slice.charCodeAt(i);
			      }
			      var byteArray = new Uint8Array(byteNumbers);
			      byteArrays.push(byteArray);
			    }
			    var fileSize = byteArrays.reduce(function (acc, byteArr) {
			      return acc + byteArr.length;
			    }, 0);
			    var maxSize = 1.5 * 1024 * 1024; // 1.5 MB (in bytes)
			    if (fileSize > maxSize) {
			    	document.getElementById('cswlargedocument').value=data;
					 $('#myModalCSWlarge').appendTo('body').modal('show'); 
			    } else {
			    	 $('#myModalPreview').appendTo('body').modal('show');
			    	// Get the base64-encoded PDF content from result[1]
			    	 const base64Content = result[1];
			    	 // Convert the base64 content into a Uint8Array
			    	 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
			    	 // Create a Blob from the Uint8Array
			    	 const blob = new Blob([byteArray], { type: 'application/pdf' });
			    	 // Create a Blob URL for the Blob
			    	 const url = URL.createObjectURL(blob);
			    	 // Create a temporary anchor element for downloading
			    	 const a = document.createElement('a');
			    	 a.href = url;
			    	 a.download = result[2]+''; // Set the desired filename
			    	 a.style.display = 'none';
			    	 document.body.appendChild(a);
			    	 // Trigger the download
			    	 a.click();
			    	 // Clean up the temporary anchor and Blob URL after the download
			    	 document.body.removeChild(a);
			    	 URL.revokeObjectURL(url);
			      $('#modalbody').html("<iframe  src='data:application/pdf;base64," + result[1] + "' width='100%' height='600' id='iframes' style='display: block;' name='showiframes'></iframe>");
			    }
			 }else if (result[0] === 'xls' || result[0] === 'xlsx' || result[0] === 'XLS' || result[0] === 'XLSX'|| result[0] === 'Xls' || result[0] === 'Xlsx') {// Check for .xls files
				 $('#myModalPreview').appendTo('body').modal('show');
				// Get the base64-encoded Excel content from result[1]
				    const base64Content = result[1];
				    // Convert the base64 content into a Uint8Array
				    const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
				    // Create a Blob from the Uint8Array, specifying the MIME type for Excel
				    const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
				    // Create a temporary anchor element for downloading
				    const a = document.createElement('a');
				    a.href = URL.createObjectURL(blob);
				    a.download = result[2]+''; // Set the desired filename with .xlsx extension
				    // Trigger the download
				    a.click();
				    // Clean up the temporary anchor and Blob URL after the download
				    URL.revokeObjectURL(a.href);
			 //$('#modalbody').html("<iframe src='data:application/vnd.ms-excel;base64," + result[1].toString() + "' width='100%' height='650' id='iframes' type='application/vnd.ms-excel' name='showiframes'></iframe>");
			    $('#myModalPreview').modal('hide');
			} else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {// Check for .docx files
				 $('#myModalPreview').appendTo('body').modal('show');
			        //$('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64," + result[1] + "' width='100%' height='0' id='iframes' type='application/vnd.openxmlformats-officedocument.wordprocessingml.document' name='showiframes'></iframe>");
			        // Get the base64-encoded DOCX content from result[1]
				 const base64Content = result[1];
				 // Convert the base64 content into a Uint8Array
				 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
				 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
				 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });
				 // Create a temporary anchor element for downloading
				 const a = document.createElement('a');
				 a.href = URL.createObjectURL(blob);
				 a.download = result[2]+''; // Set the desired filename with .docx extension
				 // Trigger the download
				 a.click();
				 // Clean up the temporary anchor and Blob URL after the download
				 URL.revokeObjectURL(a.href);
			        $('#myModalPreview').modal('hide');
			} else if (result[0] === 'txt'|| result[0] === 'TXT' || result[0] === 'Txt') { // Check for .txt files
				 $('#myModalPreview').appendTo('body').modal('show');
				    const base64Content = result[1];
				    const decodedContent = atob(base64Content);
				    const blob = new Blob([decodedContent], { type: 'text/plain' });
				    const url = URL.createObjectURL(blob);
				    const link = document.createElement('a');
				    link.href = url;
				    link.download = result[2]+''; // You can change the filename here
				    link.click();
				    // Clean up the object URL after the download
				    URL.revokeObjectURL(url);
				  $('#myModalPreview').modal('hide');
			    }
				else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
					const form = document.getElementById('CWReplyIframeForm');
					 $("#CWReplyIframe").val(data);  
					 form.action = 'ReplyCSWDownloadAttach.htm';
					 form.submit();
				    }
				else if (['jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'gif', 'avif', 'png'].includes(result[0].toLowerCase())) {
				    $('#myModalPreview').appendTo('body').modal('show');
				    $('#modalbody').html("<img style='max-width:40cm;max-height:17cm;margin-left:25%; display: block' src='data:image/" + result[0] + ";base64," + result[1] + "'>");
				}else {
					$('#myModalPreview').modal('hide');
		            const base64Content = result[1];
		            const decodedContent = atob(base64Content);
		            const blob = new Blob([decodedContent], { type: 'application/octet-stream' }); // Set a generic content type
		            const url = URL.createObjectURL(blob);
		            const link = document.createElement('a');
		            link.href = url;
		            link.download = result[2]+''; // You can set a default filename here
		            link.click();
		            // Clean up the object URL after the download
		            URL.revokeObjectURL(url);
			}
			}
			});
}
// Pnc reply java script
function  dakPNCDOeplyPreview(DakId) {
	  // AJAX call to retrieve reply details of the Dak with DakId
	  $.ajax({
	    type: "GET",
	    url: "GetPnCReplyDetails.htm",
	    data: {
	      dakid: DakId
	    },
	    datatype: 'json',
	    success: function(result) {
	    	 if (result != null) {
	    		 var Data = JSON.parse(result); // Parse the JSON data
	 	        // Clear previous data
	 		     $(".pncDoReplyData").empty(); 
	 		 // Loop through the retrieved data
	 	        for (var i = 0; i < Data.length; i++) {
	 	          var values = Data[i];
	 	         $('.pncDoReplyData').val(values[3]);
	 	        $(".pncDoAttachedFilesTbl").empty().removeAttr('style'); 
	 	         $('#pncdoreplypersonname').html("1."+values[13]);
	 	         $('#pncdoreplydeignation').html(values[14]);
	 	          var DateTime=values[6];
				    var date = new Date(DateTime);
					 // Format the date and time
					 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
					     month: 'short',
					     day: 'numeric',
					     year: 'numeric',
					     hour: 'numeric',
					     minute: 'numeric'
					 }).format(date);
	 	          $('#createddate').html(formattedDateTime);
	 	        if (values[8] > 0) {
		        	// Apply the specific styles for the else condition
		              $('.pncDoAttachedFilesTbl').css({
		                'border': 'none',
		                'width': '294px',
		                'float': 'left',
		                'margin-left': '0px',
		                'margin-top': '6px'
		              });
		        	// If there are attachments, call the function PnCReplyAttachs to retrieve them
		            PnCReplyAttachPreview(values[0]);
		          } else {
		        	  // Apply the specific styles for the else condition
		              $('.pncDoAttachedFilesTbl').css({
		            	    'border': '1px solid #ced4da',
		            	    'border-radius': '0.25rem !important',
		            	    'width': '294px',
		            	    'float': 'left',
		            	    'clear': 'left',
		            	    'margin-left': '0px'
		              });
		              // If there are no attachments, display a message in the corresponding element
			            var emptyRow = '<tr><td style="text-align: center; font-size: 14px;">No Documents Attached</td></tr>';
			            $('.pncDoAttachedFilesTbl').append(emptyRow);
			          }
	    }//for loop ends
	    	 }//result null check ends
	    	 
	    }
	    
	    });
}
	  function PnCReplyAttachPreview(DakPnCReplyId) {
		  // AJAX call to retrieve reply attachments for the DakPnCReplyId
		  $.ajax({
		    type: "GET",
		    url: "GetPnCReplyAttachDetails.htm",
		    data: {
		      dakpncreplyid: DakPnCReplyId
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		        var resultData = JSON.parse(result); // Parse the JSON data
		        var ReplyAttachTbody = '';
		        for (var z = 0; z < resultData.length; z++) {
		          var row = resultData[z];
		          ReplyAttachTbody += '<tr> ';
		          ReplyAttachTbody += '  <td style="text-align: left;">';
		          ReplyAttachTbody += '  <form action="#" id="PCReplyIframeForm">';
		          ReplyAttachTbody += '  <input type="hidden" id="PCReplyIframe" name="pncReplyDownloadBtn">';
		          ReplyAttachTbody += '    <button type="button" class="btn btn-sm pncAttachments-btn" name="pncReplyDownloadBtn" value="'+row[0]+'"  onclick="IframepdfForPnCAttachedDocs('+row[0]+',0)"  data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
		          ReplyAttachTbody += '  </form>';
		          ReplyAttachTbody += '  </td>';
		          ReplyAttachTbody += '</tr> ';
		        }
		        // Append the ReplyAttachTbody to the element with class 'PnCRepliedDocuments'
		        $('.pncDoAttachedFilesTbl').append(ReplyAttachTbody);
		      }
		    }
		  });
		}
	  
	  function IframepdfForPnCAttachedDocs(data,ref){
			 $.ajax({
					type : "GET",
					url : "IframePnCReplyDownloadAttach.htm",
					data : {
						data: data
					},
					datatype : 'json',
					success : function(result) {
					result = JSON.parse(result);
					 $('#modalbody').html('');
					 if(result[0]==='pdf' || result[0]==='PDF' || result[0]==='Pdf'){
						var fileData = result[1]; // Base64 encoded file data
					    var byteCharacters = atob(fileData); // Decode the base64 data
					    var byteArrays = [];
					    for (var offset = 0; offset < byteCharacters.length; offset += 512) {
					      var slice = byteCharacters.slice(offset, offset + 512);
					      var byteNumbers = new Array(slice.length);
					      for (var i = 0; i < slice.length; i++) {
					        byteNumbers[i] = slice.charCodeAt(i);
					      }
					      var byteArray = new Uint8Array(byteNumbers);
					      byteArrays.push(byteArray);
					    }
					    var fileSize = byteArrays.reduce(function (acc, byteArr) {
					      return acc + byteArr.length;
					    }, 0);
					    var maxSize = 1.5 * 1024 * 1024; // 1.5 MB (in bytes)
					    if (fileSize > maxSize) {
					    	document.getElementById('PnClargedocument').value=data;
							 $('#myModalPnCReplylarge').appendTo('body').modal('show');
					    } else {
					    	 $('#myModalPreview').appendTo('body').modal('show');
					    	// Get the base64-encoded PDF content from result[1]
					    	 const base64Content = result[1];
					    	 // Convert the base64 content into a Uint8Array
					    	 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
					    	 // Create a Blob from the Uint8Array
					    	 const blob = new Blob([byteArray], { type: 'application/pdf' });
					    	 // Create a Blob URL for the Blob
					    	 const url = URL.createObjectURL(blob);
					    	 // Create a temporary anchor element for downloading
					    	 const a = document.createElement('a');
					    	 a.href = url;
					    	 a.download = result[2]+''; // Set the desired filename
					    	 a.style.display = 'none';
					    	 document.body.appendChild(a);
					    	 // Trigger the download
					    	 a.click();
					    	 // Clean up the temporary anchor and Blob URL after the download
					    	 document.body.removeChild(a);
					    	 URL.revokeObjectURL(url);
					      $('#modalbody').html("<iframe  src='data:application/pdf;base64," + result[1] + "' width='100%' height='600' id='iframes' style='display: block;' name='showiframes'></iframe>");
					    }
					 }else if (result[0] === 'xls' || result[0] === 'xlsx' || result[0] === 'XLS' || result[0] === 'XLSX'|| result[0] === 'Xls' || result[0] === 'Xlsx') {
						 $('#myModalPreview').appendTo('body').modal('show');
						// Get the base64-encoded Excel content from result[1]
						    const base64Content = result[1];
						    // Convert the base64 content into a Uint8Array
						    const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
						    // Create a Blob from the Uint8Array, specifying the MIME type for Excel
						    const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
						    // Create a temporary anchor element for downloading
						    const a = document.createElement('a');
						    a.href = URL.createObjectURL(blob);
						    a.download = result[2]+''; // Set the desired filename with .xlsx extension
						    // Trigger the download
						    a.click();
						    // Clean up the temporary anchor and Blob URL after the download
						    URL.revokeObjectURL(a.href);
						 // $('#modalbody').html("<iframe src='data:application/vnd.ms-excel;base64," + result[1].toString() + "' width='100%' height='650' id='iframes' type='application/vnd.ms-excel' name='showiframes'></iframe>");
					    $('#myModalPreview').modal('hide');
					} else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {
						$('#myModalPreview').modal('show');
					       // $('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64," + result[1] + "' width='100%' height='0' id='iframes' type='application/vnd.openxmlformats-officedocument.wordprocessingml.document' name='showiframes'></iframe>");
					       // Get the base64-encoded DOCX content from result[1]
						 const base64Content = result[1];
						 // Convert the base64 content into a Uint8Array
						 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
						 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
						 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });
						 // Create a temporary anchor element for downloading
						 const a = document.createElement('a');
						 a.href = URL.createObjectURL(blob);
						 a.download = result[2]+''; // Set the desired filename with .docx extension
						 // Trigger the download
						 a.click();
						 // Clean up the temporary anchor and Blob URL after the download
						 URL.revokeObjectURL(a.href);
					       $('#myModalPreview').modal('hide');
					} else if (result[0] === 'txt' || result[0] === 'Txt' || result[0] === 'TXT') { // Check for .txt files
						 $('#myModalPreview').appendTo('body').modal('show');
						    const base64Content = result[1];
						    const decodedContent = atob(base64Content);
						    const blob = new Blob([decodedContent], { type: 'text/plain' });
						    const url = URL.createObjectURL(blob);
						    const link = document.createElement('a');
						    link.href = url;
						    link.download = result[2]+''; // You can change the filename here
						    link.click();
						    // Clean up the object URL after the download
						    URL.revokeObjectURL(url);
						  $('#myModalPreview').modal('hide');
					    }
						else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
							if(ref==0)
								{
								const form = document.getElementById('PCReplyIframeForm');
								 $("#PCReplyIframe").val(data);
								 form.action = 'PnCReplyDownloadAttach.htm';
								 form.submit();
								}
							else if(ref==1)
								{
								const form = document.getElementById('consolidatedReplyByRTMDO');
								 $("#PCReplyIframe").val(data);
								 form.action = 'PnCReplyDownloadAttach.htm';
								 form.submit();
								}
						    }
						else if (['jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'gif', 'avif', 'png'].includes(result[0].toLowerCase())) {
						    $('#myModalPreview').appendTo('body').modal('show');
						    $('#modalbody').html("<img style='max-width:40cm;max-height:17cm;margin-left:25%; display: block' src='data:image/" + result[0] + ";base64," + result[1] + "'>");
						}else {
							$('#myModalPreview').modal('hide');
				            const base64Content = result[1];
				            const decodedContent = atob(base64Content);
				            const blob = new Blob([decodedContent], { type: 'application/octet-stream' }); // Set a generic content type
				            const url = URL.createObjectURL(blob);
				            const link = document.createElement('a');
				            link.href = url;
				            link.download = result[2]+''; // You can set a default filename here
				            link.click();
				            // Clean up the object URL after the download
				            URL.revokeObjectURL(url);
					}
					}
					});
		}
	  function dakSeekResponseReplyPreview(dakId){
			$.ajax({
				 type : "GET",
					url : "GetSeekResponseReplyModalDetails.htm",
					data : {
						dakid: dakId
					},
					datatype : 'json',
					success : function(result) {
						if(result !=null && result!="[]"){
				       	   //display the hidden btnSeekResponseReplyDetailsPreview div 
				        	 $('.btnSeekResponseReplyDetailsPreview').show(); 
				        	 // Clear previous data
						        $(".DakSeekResponseReply").empty();
							 var replyData = JSON.parse(result); // Parse the JSON data
							 const replyCountOverall = parseInt( replyData[0][11]);
					    	 const replyCountByEmpId = parseInt( replyData[0][12]);
					    	 const replyCountByAuthority = parseInt( replyData[0][13]);
					    	 if (  replyCountOverall > 0 && (replyCountByEmpId > 0 ||  replyCountByAuthority > 0)){
							 for (var i = 0; i < replyData.length; i++) {
								    var row = replyData[i];
								    var repliedPersonName = row[6];
									$('#SeekResponsereplierName').val(repliedPersonName);
								    var repliedPersonDesig = row[7];
								    var repliedRemarks = row[2];
								    var replyid= row[0];
								    var replyEmpId=row[1];
								    var loggedInEmpId = <%= LoginEmpId %>;
								    var dakStatus = row[10];
								    var DateTime=row[5];
								    var date = new Date(DateTime);
									 // Format the date and time
									 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
									     month: 'short',
									     day: 'numeric',
									     year: 'numeric',
									     hour: 'numeric',
									     minute: 'numeric'
									 }).format(date);
								    var dynamicReplyDiv = $("<div>", { class: "DAKSeekResponseReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
								    dynamicReplyDiv.after("<br>");
								    var h4 = $("<h4>", { 
								    	  class: "SeekRepsponseRepliedPersonName", 
								    	  id: "model-person-header", 
								    	  html: (i + 1) + ". " + repliedPersonName + ", " + repliedPersonDesig + ",  <span style='color: black; font-size:15px;'> " + formattedDateTime + "</span>" 
								    	});
								    dynamicReplyDiv.append(h4);//appended h4
								    var replyEditButton = $("<button>", {
								    	  type: "button",
								    	  class: "btn btn-sm icon-btn replyedit-click",
								    	  "data-toggle": "tooltip",
								    	  "data-placement": "top",
								    	  title: "Edit",
								    	  onclick: "replySeekResponseCommonEdit('" + replyid + "')"
								    	});
	                                var editImage = $("<img>", { alt: "edit",src: "view/images/writing.png"});
	                                replyEditButton.append(editImage);
	                                if(replyEmpId == loggedInEmpId && dakStatus!="DC" && dakStatus!="AP"){
	   							      dynamicReplyDiv.append(replyEditButton);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
	   							  }
	                              dynamicReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
								    var innerDiv = $("<div>", { class: "row replyRow" });
								    var formgroup1 = $("<div>", { class: "form-group group1" });
								    var replyText = repliedRemarks.length < 140 ? repliedRemarks : repliedRemarks.substring(0, 140);
								    var replyDiv = $("<div>", { class: "col-md-12 replyremarks-div", contenteditable: "false" }).text(replyText);
								    if (repliedRemarks.length > 140) {
								        var button = $("<button>", {
								            type: "button",
								            class: "viewmore-click",
								            name: "sub",
								            value: "Modify",
								            onclick: "replySeekResponseViewMoreModal('" + replyid + "')"
								        }).text("...(View More)");
								        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));
								        replyDiv.append(button, b);
								    }
						          formgroup1.append(replyDiv);   
								  innerDiv.append(formgroup1);
	                              dynamicReplyDiv.append(innerDiv);
						            // Check if row[9] count i.e DakReplyAttachCount is more than 0
							          if (row[9] > 0) {
							        	  // Call a function and pass row[0] i.e DakReplyId
							              DakSeekResponseReplyAttachPreview(row[0], dynamicReplyDiv);
							            }
	                                $(".DakSeekResponseReply").append(dynamicReplyDiv);
	                             // Add line break after the textarea and DakReplyDivEnd
	                                $(".DakSeekResponseReply").append("<br>");
							 }//for loop close
							//replyCountOverall>0 if condition close but dont have authority then disable else hide
						}else{ 
							 // Clear previous data
					        $(".DakSeekResponseReply").empty();
					        $('.btnSeekResponseReplyDetailsPreview').hide(); 
					      }
							//reseult!=null if condition close //when ajax doesnot result queryyyyy
						}else{
							 // Clear previous data
					        $(".DakSeekResponseReply").empty();
				       	   //hide the btnSeekResponseReplyDetailsPreview div 
				        	 $('.btnSeekResponseReplyDetailsPreview').hide(); 
						}
					}
			 });
		}
	  
	  
		function DakSeekResponseReplyAttachPreview(DakReplyIdData, dynamicReplyDiv) {
			  $.ajax({
			    type: "GET",
			    url: "GetSeekResponseReplyAttachModalList.htm",
			    data: {
			      dakreplyid: DakReplyIdData
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			        var resultData = JSON.parse(result);
			        if (resultData.length > 0) {
			          var formgroup2 = $("<div>", { class: "form-group group2" });
			          var tableDiv = $("<div>", { class: "col-md-6 replyModAttachTbl-div" });
			          var table = $("<table>", { class: "table table-hover table-striped table-condensed info shadow-nohover downloadReplyAttachTable" });
			          var ReplyAttachTbody = '';
			          for (var z = 0; z < resultData.length; z++) {
			            var row = resultData[z];
			            ReplyAttachTbody += '<tr> ';
			            ReplyAttachTbody += '  <td style="text-align: left;">';   
			            ReplyAttachTbody += '  <form action="#" id="SeekResponseReplyform">';
			            ReplyAttachTbody += '  <input type="hidden" id="SeekResponseReplyIframeData" name="markerdownloadbtn">';
			            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply"  value="'+row[0]+'"  onclick="IframepdfSeekResponseReply('+row[0]+',0)" data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
			            ReplyAttachTbody += '  </form>';
			            ReplyAttachTbody += '  </td>';
			            ReplyAttachTbody += '</tr> ';
			          }
			          table.html(ReplyAttachTbody);
			          tableDiv.append(table);
			          formgroup2.append(tableDiv);
			          var innerDiv = dynamicReplyDiv.find('.replyRow');
			          innerDiv.append(formgroup2);
			        }
			      }
			    },
			    error: function(xhr, textStatus, errorThrown) {
			      // Handle error
			    }
			  });
			}
		function replySeekResponseViewMoreModal(replyid) {
			 $('#SeekResponsereplyViewMore').appendTo('body').modal('show');
			  $('#SeekResponsereplyDetailsDiv').empty();
			  $.ajax({
			    type: "GET",
			    url: "GetSeekResponseReplyViewMore.htm",
			    data: {
			      dakreplyid: replyid
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			        var resultData = JSON.parse(result);
			        for (var i = 0; i < resultData.length; i++) { // Corrected the loop variable
			          var row = resultData[i];
			          var remarks = row[1];
			          $('#SeekResponsereplyDetailsDiv').append(remarks);
			        }
			      }
			    }
			  });
			}
		function replySeekResponseCommonEdit(replyid){
			
			  $.ajax({
				    type: "GET",
				    url: "GetSeekResponseReplyEditDetails.htm",
				    data: {
				    	replyid: replyid
				    },
				    datatype: 'json',
				    success: function(result) {
				      if (result != null) {
				    	   var data = JSON.parse(result);
				           // Extract the "Remarks" value
				           $('.SeekResponsereplyDataInEditModal').val(data.Reply);
				           $('#SeekResponsedakReplyIdOfReplyEdit').val(data.SeekResponseId);
				           $('#SeekResponsedakIdOfReplyEdit').val(data.DakId);
				           $('#SeekResponseempIdOfReplyEdit').val(data.SeekEmpId);
				           SeekResponsereplyAttachCommonEdit(replyid);
						}//if condition close
					}//successClose
			 });//ajaxClose  
			 $('#SeekResponsereplyCommonEditModal').appendTo('body').modal('show');
		}//functionClose
		
		function SeekResponsereplyAttachCommonEdit(replyid){
			 $.ajax({
				    type: "GET",
				    url: "GetSeekResponseReplyAttachModalList.htm",
				    data: {
				      dakreplyid: replyid
				    },
				    datatype: 'json',
				    success: function(result) {
				      if (result != null) {
				        var resultData = JSON.parse(result); 
				      
				        var ReplyAttachTbody = '';
				          for (var z = 0; z < resultData.length; z++) {
				            var row = resultData[z];
				            ReplyAttachTbody += '<tr> ';
				            ReplyAttachTbody += '  <td style="text-align: left;">';
				            ReplyAttachTbody += '  <form action="#" id="SeekResponseReplyform">';
				            ReplyAttachTbody += '  <input type="hidden" id="SeekResponseReplyIframeDataEdit" name="markerdownloadbtn">';
				            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="dakEditReplyDownloadBtn"  value="'+row[0]+'"  onclick="IframepdfSeekResponseReply('+row[0]+',0)" data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
				            ReplyAttachTbody += '  </form>';
				            ReplyAttachTbody += '  </td>';
				            ReplyAttachTbody += '  <td style="text-align: left;">';
				            ReplyAttachTbody +=	'		<button type="button" id="SeekResponseReplyEditAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="SeekResponseReplyAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;"  onclick="deleteSeekResponseReplyEditAttach('+row[0]+','+row[1]+')" ><img alt="attach" src="view/images/delete.png"></button>';
				            ReplyAttachTbody += '  </td>';
				            ReplyAttachTbody += '</tr> ';
				          }
				      	$('#SeekResponseReplyAttachEditDataFill').html(ReplyAttachTbody);
				      }          //if condition close
					}//successClose
			 });//ajaxClose    
		}//functionClose
		
		 function deleteSeekResponseReplyEditAttach(ReplyAttachmentId,ReplyId){
	 		 $('#SeekResponsereplyAttachmentIdFrDelete').val(ReplyAttachmentId);
	 		 $('#SeekResponsereplyIdFrAttachDelete').val(ReplyId);
	 		 var result = confirm ("Are You sure to Delete ?"); 
	 		 if(result){
	 			var button = $('#SeekResponseReplyEditAttachDelete');
	 			var formAction = button.attr('formaction');
	 			if (formAction) {
	 				  var form = button.closest('form');
	 				  form.attr('action', formAction);
	 				  form.submit();
	 				}else{
	 					console.log('form action not found');
	 				}
	 		} else {
	 		    return false; // or event.preventDefault();
	 		}
	 	 }
		
		 function  dakSeekResponseReplyEditValidation(){
			 var isValidated = false;
			   var replyRemarkOfEdit = document.getElementsByClassName("SeekResponsereplyDataInEditModal")[0].value;
			if(replyRemarkOfEdit.trim() == "") { 
		    	isValidated = false;
		    }else{
		    	isValidated = true;
		    }
		    if (!isValidated) {
		        event.preventDefault(); // Prevent form submission
		        alert("Please fill in the remark input field.");
		      } else {
		          // Retrieve the form and submit it
		          var confirmation = confirm("Are you sure you want to edit this reply?");
		          if (confirmation) {
		        	var button = $('#dakSeekResponseCommonReplyEditAction');
		   			var formAction = button.attr('formaction');
		   			if (formAction) {
		   				  var form = button.closest('form');
		   				  form.attr('action', formAction);
		   				  form.submit();
		   				}else{
		   					console.log('form action not found');
		   				}
		          } else { return false; }
		      }//else close
		 }
		 
function  DakRemindSubmit(){
			 var isValidated = false;
			   var replyRemarkOfEdit = $('#Remindcomment').val();
			if(replyRemarkOfEdit.trim() == "") { 
		    	isValidated = false;
		    }else{
		    	isValidated = true;
		    }
		    if (!isValidated) {
		        event.preventDefault(); // Prevent form submission
		        alert("Please fill in the Comment input field.");
		      } else {
		          // Retrieve the form and submit it
		          var confirmation = confirm("Are you sure you want to Sent Remind?");
		          if (confirmation) {
		        	  var button = $('#DakRemindSubValidate');
		   			var formAction = button.attr('formaction');
		   			if (formAction) {
		   				  var form = button.closest('form');
		   				  form.attr('action', formAction);
		   				  form.submit();
		   				}else{
		   					console.log('form action not found');
		   				}
		          } else { return false; }
		      }//else close
		 }
		 
		 function IframepdfSeekResponseReply(data){
			 $.ajax({
					type : "GET",
					url : "getSeekResponseiframepdf.htm",
					data : {
						data: data
					},
					datatype : 'json',
					success : function(result) {
					result = JSON.parse(result);
					 $('#modalbody').html('');
					if(result[0]==='pdf' || result[0]==='PDF' || result[0]==='Pdf'){
						var fileData = result[1]; // Base64 encoded file data
					    var byteCharacters = atob(fileData); // Decode the base64 data
					    var byteArrays = [];
					    for (var offset = 0; offset < byteCharacters.length; offset += 512) {
					      var slice = byteCharacters.slice(offset, offset + 512);
					      var byteNumbers = new Array(slice.length);
					      for (var i = 0; i < slice.length; i++) {
					        byteNumbers[i] = slice.charCodeAt(i);
					      }
					      var byteArray = new Uint8Array(byteNumbers);
					      byteArrays.push(byteArray);
					    }
					    var fileSize = byteArrays.reduce(function (acc, byteArr) {
					      return acc + byteArr.length;
					    }, 0);
					    var maxSize = 1.5 * 1024 * 1024; // 1.5 MB (in bytes)
					    if (fileSize > maxSize) {
					    	document.getElementById('largedocument').value=data;
					    	$('#myModallarge').modal('show');
					    } else {
					    	 $('#myModalPreview').appendTo('body').modal('show');
					    	 // Get the base64-encoded PDF content from result[1]
					    	 const base64Content = result[1];
					    	 // Convert the base64 content into a Uint8Array
					    	 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
					    	 // Create a Blob from the Uint8Array
					    	 const blob = new Blob([byteArray], { type: 'application/pdf' });
					    	 // Create a Blob URL for the Blob
					    	 const url = URL.createObjectURL(blob);
					    	 // Create a temporary anchor element for downloading
					    	 const a = document.createElement('a');
					    	 a.href = url;
					    	 a.download = result[2]+''; // Set the desired filename
					    	 a.style.display = 'none';
					    	 document.body.appendChild(a);
					    	 // Trigger the download
					    	 a.click();
					    	 // Clean up the temporary anchor and Blob URL after the download
					    	 document.body.removeChild(a);
					    	 URL.revokeObjectURL(url);
					      $('#modalbody').html("<iframe  src='data:application/pdf;base64," + result[1] + "' width='100%' height='600' id='iframes' style='display: block;' name='showiframes'></iframe>");
					      // $('#modalbody').html(pdfContent);
					    }
					}else if (result[0] === 'xls' || result[0] === 'xlsx' || result[0] === 'XLS' || result[0] === 'XLSX'|| result[0] === 'Xls' || result[0] === 'Xlsx') {
						 $('#myModalPreview').appendTo('body').modal('show');
						 // Get the base64-encoded Excel content from result[1]
						    const base64Content = result[1];
						    // Convert the base64 content into a Uint8Array
						    const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
						    // Create a Blob from the Uint8Array, specifying the MIME type for Excel
						    const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
						    // Create a temporary anchor element for downloading
						    const a = document.createElement('a');
						    a.href = URL.createObjectURL(blob);
						    a.download = result[2]+''; // Set the desired filename with .xlsx extension
						    // Trigger the download
						    a.click();
						    // Clean up the temporary anchor and Blob URL after the download
						    URL.revokeObjectURL(a.href);
					    //$('#modalbody').html("<iframe src='data:application/vnd.ms-excel;base64," + result[1].toString() + "' width='100%' height='650' id='iframes' type='application/vnd.ms-excel' name='showiframes'></iframe>");
					    $('#myModalPreview').modal('hide');
					} else if (result[0] === 'txt' || result[0] === 'TXT' || result[0] === 'Txt') { // Check for .txt files
						 $('#myModalPreview').appendTo('body').modal('show');
						    const base64Content = result[1];
						    const decodedContent = atob(base64Content);
						    const blob = new Blob([decodedContent], { type: 'text/plain' });
						    const url = URL.createObjectURL(blob);
						    const link = document.createElement('a');
						    link.href = url;
						    link.download = result[2]+''; // You can change the filename here
						    link.click();
						    // Clean up the object URL after the download
						    URL.revokeObjectURL(url);
						  $('#myModalPreview').modal('hide');
					}else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {// Check for .docx files
						 $('#myModalPreview').appendTo('body').modal('show');
						// Get the base64-encoded DOCX content from result[1]
						 const base64Content = result[1];
						 // Convert the base64 content into a Uint8Array
						 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));
						 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
						 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });
						 // Create a temporary anchor element for downloading
						 const a = document.createElement('a');
						 a.href = URL.createObjectURL(blob);
						 a.download =result[2]+''; // Set the desired filename with .docx extension
						 // Trigger the download
						 a.click();
						 // Clean up the temporary anchor and Blob URL after the download
						 URL.revokeObjectURL(a.href);
					       $('#myModalPreview').modal('hide');	  
					} else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
						$('#myModalPreview').appendTo('body').modal('show');
						$('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.presentationml.presentation;base64," + result[1] + "' width='100%' height='650' id='iframes' type='application/vnd.openxmlformats-officedocument.presentationml.presentation' name='showiframes'></iframe>");
						// Provide a download link
						const downloadLink = document.createElement('a');
						downloadLink.href = 'data:application/octet-stream;base64,' + result[1]; // Set the MIME type to application/octet-stream
						downloadLink.download = result[2]+''; // Set the desired filename
						downloadLink.style.display = 'none'; // Hide the download link
						document.body.appendChild(downloadLink);
						// Trigger the download link click
						downloadLink.click();
						document.body.removeChild(downloadLink); // Clean up the download link
						$('#myModalPreview').modal('hide');
					}else if (['jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'gif', 'avif', 'png'].includes(result[0].toLowerCase())) {
					    $('#myModalPreview').appendTo('body').modal('show');
					    $('#modalbody').html("<img style='max-width:40cm;max-height:17cm;margin-left:25%; display: block' src='data:image/" + result[0] + ";base64," + result[1] + "'>");
					}else {
							$('#myModalPreview').modal('hide');
				            const base64Content = result[1];
				            const decodedContent = atob(base64Content);
				            const blob = new Blob([decodedContent], { type: 'application/octet-stream' }); // Set a generic content type
				            const url = URL.createObjectURL(blob);
				            const link = document.createElement('a');
				            link.href = url;
				            link.download = result[2]+''; // You can set a default filename here
				            link.click();
				            // Clean up the object URL after the download
				            URL.revokeObjectURL(url);
					}
					}
					});	
		}
//-----------------------View More Button Append in the DakDetails Preview -------------------->
function appendViewMoreButton(container, text, maxLength, modalFunction) {
		 var shortenedText = text.length < maxLength ? text : text.substring(0, maxLength);
			 if (text.length > maxLength) {
			   var button = $("<button>", {
			    type: "button",
			    class: "viewmore-click",
	            name: "sub",
	            value: "Modify",
	            onclick: modalFunction
	        }).text("...(View More)");
        container.text(shortenedText).append(button);
    } else {
        container.text(shortenedText);
	    }
}	
//---------------Dakdetails SubjectViewMoreModal ------------------------------------>
function SubjectViewMoreModal(DakId,subject) {
	 $('#SubjectViewMore').appendTo('body').modal('show');
	 $('#SubjectDiv').empty();
	$('#SubjectDiv').append(subject);
}
<!-------------------------------- Replymodal of marker ----------------------------------------------------->
function replyModalOfMarker(DakIdValue,loggedInEmpId,DakAssignReplyIdCount,dakno,source,DakMarkingId) {
	$('#exampleModalReply').modal('show');
	var value=$('#subject'+DakIdValue).val();
	 
	 $('#ReplyMailSubject').val(value);
	 console.log("value:"+value);
	$('#dakIdOfReply').val(DakIdValue);
	$('#empIdOfReply').val(loggedInEmpId);
	$('#RecievedListDakNo').html(dakno);
	$('#RecievedListSourceNo').html(source);
	$('.replyTextArea').val('');
	$('#ReplyCopyAttachDataFill').empty();
	//code to redirect to page
	var redirectPageId   = "PageNoValFetch"+DakIdValue;
	var redirectRowId =  "RowValFetch"+DakIdValue;
	var pageElement = document.getElementById(redirectPageId);
	var rowElement = document.getElementById(redirectRowId);
    var pageValue = pageElement ? pageElement.value : null;
	var rowValue = rowElement ? rowElement.value : null;
	$('#PageRedirByReply').val(pageValue);
	$('#RowRedirByReply').val(rowValue);
	//code ends
	if(DakAssignReplyIdCount>0 ){
		CSWReplyOfParticularMarkerPreview(DakMarkingId,DakIdValue,loggedInEmpId);
		console.log("DakAssignReplyIdCount is greater than zero callefd");
	}else{
		$('#CSWReplyOfParticularMarker').hide();
	}
}

function DakReplyMailSent(){
	var elements = document.getElementsByName('Mail');
	var value;

	// Loop through all radio buttons to find the checked one
	for (var i = 0; i < elements.length; i++) {
	  if (elements[i].checked) {
	    value = elements[i].value;
	    break;
	  }
	}
	console.log("value: " + value);
	if (value === 'N') {
		$('#MailSent').hide();
		} else {
			$('#MailSent').show();
			$('#HostType').val(value);
			$.ajax({
			        type: "GET",
			        url: "getMailSenderDetails.htm",
			        data: {
			        	value: value
			        },
			        dataType: 'json',
			        success: function(result) {
			            if (result != null) {
			            	$('#ReplyPersonSentMail').val(result[0]);
			                    }
			            }

			    });
		}
}

function CSWReplyOfParticularMarkerPreview(DakMarkingId,DakId,loggedInEmpId){
	console.log("DakAssignReplyIdCount reached");
	  // Clear previous data
	 $('.MarkerReplyModalCaseworkerPreview').empty();
     $('.MarkerNameAndDesigDisplay').empty();
     $('.MarkerCaseworkersDakReplyData').empty();
    $.ajax({
        type: "GET",
        url: "GetAllCSWReplyByMarkingIdDetails.htm",
        data: {
        	dakMarkingId: DakMarkingId,
            dakId: DakId
        },
        dataType: 'json',
        success: function(result) {
        	 try {
        		 if (result != null) {
        	            	$('#CSWReplyOfParticularMarker').show();
        	            	var MarkerNameAndDesig;
        	            	 for (var i = 0; i < result.length; i++) {
 							    var data = result[i];
 							   var repliedCSWPersonName = data[4];
								$('#replierName').val(repliedCSWPersonName);
							    var repliedCSWPersonDesig = data[5];
							    var repliedData = data[6];
							    var dakAssignReplyId= data[2];
							    var replyEmpId=data[3];
							    var loggedInEmpId = <%= LoginEmpId %>;
							    var MarkerPersName = data[8];
							    var MarkerPersDesig = data[9];
							    var dakStatus = data[10];
							    MarkerNameAndDesig = " (Marked By - " + MarkerPersName + "," + MarkerPersDesig + ")";
							    var dynamicCSWReplyDiv = $("<div>", { class: "DAKCSWReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
							    dynamicCSWReplyDiv.after("<br>");
							    var h4 = $("<h4>", {
							    	  class: "CSWRepliedPersonName",
							    	  id: "model-person-header",
							    	  html: (i + 1) + "." + repliedCSWPersonName + "," + repliedCSWPersonDesig + ""
							    	});
							    dynamicCSWReplyDiv.append(h4);//appended h4
							    var facilitatorReplyCopyButton = $("<button>", {
							        type: "button",
							        class: "btn replyCopyBtn",
							        id: "AssignReply" + data[2],
							        "data-button-type": "copyAndUncopyBtn",
							        "data-row-id": data[2],
							        "data-toggle": "tooltip",
							        "data-placement": "top",
							        style: "float:right!important",
							        title: "Reply Copy"
							       /*  onclick: "copyFacilitatorReplyToMarker('" + data[2] + "','" + data[1] + "')" */
							    });
							    var copyImage = $("<img>", { alt: "edit", src: "view/images/replyCopy.png" });
							    facilitatorReplyCopyButton.append(copyImage);
							    $(dynamicCSWReplyDiv).append(facilitatorReplyCopyButton);
   							dynamicCSWReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
							    var innerCSWReplyDiv = $("<div>", { class: "row replyRow" });
							    var formgroup1 = $("<div>", { class: "form-group group1" });
							  /*   var replyLabel = $("<label>", { class: "form-control" }).css({ fontweight: "800", fontSize: "16px", color: "#07689f;",display: "inline-block",marginbottom: "0.5rem"}).text("Reply :"); */
							    var replyCSWText = repliedData.length < 140 ? repliedData : repliedData.substring(0, 140);
							    var replyCSWDiv = $("<div>", { class: "col-md-12 replyCSW-div", contenteditable: "false" }).text(replyCSWText);
							    if (repliedData.length > 140) {
							        var button = $("<button>", {
							            type: "button",
							            class: "viewmore-click",
							            name: "sub",
							            value: "Modify",
							            onclick: "replyCSWViewMoreModal('" + dakAssignReplyId + "')"
							        }).text("...(View More)");
							        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));
							        replyCSWDiv.append(button, b);
							    }
					          formgroup1.append(replyCSWDiv);   
					          innerCSWReplyDiv.append(formgroup1);
					          dynamicCSWReplyDiv.append(innerCSWReplyDiv);
					            // Check if row[7] count i.e DakReplyAttachCount is more than 0
						          if (data[7] > 0) {
						        	  // Call a function and pass row[2] i.e DakAssignReplyId
						              DakCSWReplyAttachPreview(data[2], dynamicCSWReplyDiv); //reusing the DakCSWReplyAttachPreview from common modals.jsp however oneverclick whole diuv will be emptied
						            }
						    $(".MarkerCaseworkersDakReplyData").append(dynamicCSWReplyDiv);
						      // Add line break after the textarea and DakReplyDivEnd
                            $(".MarkerCaseworkersDakReplyData").append("<br>");
        	            	 }//for loop close
    	             	    $('.MarkerNameAndDesigDisplay').append(MarkerNameAndDesig);
        	            }//if condition close
             } catch (error) {
                 console.error("Error parsing JSON:", error);
             }
         },
         error: function(xhr, status, error) {
             console.error("AJAX request error:", status, error);
         }
    });
}

//object named appendedText to store the reply text associated with each DakAssignReplyId//This object allows us to keep track of the text appended for each button click.
var appendedText = {};
$(document).ready(function () {
	  // Event delegation for dynamically generated buttons
	  $(document).on("click", "button[data-button-type='copyAndUncopyBtn']", function (event) {
	    event.preventDefault();
    // Get the data-row-id of the clicked button
    var dakAssignReplyId =  $(this).data("row-id"); // this is the unique Id which will identify particular DakAssignReplyId
         console.log($( "#AssignReply"+dakAssignReplyId ).hasClass( "btn replyCopyBtn" ).toString());
  if($( "#AssignReply"+dakAssignReplyId ).hasClass( "btn replyCopyBtn" ).toString()=='true'){
    	$( "#AssignReply"+dakAssignReplyId ).removeClass( "btn replyCopyBtn" ).addClass( "btn replyUnCopyBtn" );
        // Change the image source using your code
        $( "#AssignReply"+dakAssignReplyId ).find('img').attr('src', 'view/images/replyUnCopy.png');
        // Change the title
        $( "#AssignReply"+dakAssignReplyId ).attr('title', 'Reply Uncopy');
        copyFacilitatorReplyToMarker(dakAssignReplyId);
   }else if($( "#AssignReply"+dakAssignReplyId ).hasClass( "btn replyUnCopyBtn" ).toString()=='true'){
    	$( "#AssignReply"+dakAssignReplyId ).removeClass( "btn replyUnCopyBtn" ).addClass( "btn replyCopyBtn" );
    	// Change the image source using your code
        $( "#AssignReply"+dakAssignReplyId ).find('img').attr('src', 'view/images/replyCopy.png');
        // Change the title
        $( "#AssignReply"+dakAssignReplyId ).attr('title', 'Reply Copy');
        //all attachment(tr) with this id will be removed
        $('[id^="CopyAttachRow' + dakAssignReplyId + '"]').remove(); 
        //retrieve the previously appended text from the appendedText object based on the DakAssignReplyId
        var appended = appendedText[dakAssignReplyId];
        if (appended) {
          var currentText = $('.replyTextArea').val();
          // Replace the current text with the text without the appended portion
          //removes only the text appended during the corresponding "Copy" action, leaving the rest of the text area intact.
          var newText = currentText.replace(appended, '');
          $('.replyTextArea').val(newText);
          // Remove the appended text from the storage
          delete appendedText[dakAssignReplyId];
        }
        }
  });
});
<!------------------------------------ Assigning CaseWorkers  ----------------------------------------------->
function Assign(DakId, dakmarkingid, dakno, Source,RedirVal) {
    $('#exampleModalAssign').modal('show');
    $('#DakNo').html(dakno);
    $('#Sourcetype').html(Source);
    $('#DakMarkingdakId').val(DakId);
    $('#DakMarkingIdsel').val(dakmarkingid);
    $("#RedirectValue").val(RedirVal);
    $('#DakCaseWorker').empty();
	//code to redirect to page
	var redirectPageId   = "PageNoValFetch"+DakId;
	var redirectRowId =  "RowValFetch"+DakId;
	var pageElement = document.getElementById(redirectPageId);
	var rowElement = document.getElementById(redirectRowId);
    var pageValue = pageElement ? pageElement.value : null;
	var rowValue = rowElement ? rowElement.value : null;
	$('#PageRedirByAssign').val(pageValue);
	$('#RowRedirByAssign').val(rowValue);
	//code ends
    $.ajax({
        type: "GET",
        url: "getEmpListForAssigning.htm",
        data: {
            dakid: DakId
        },
        dataType: 'json',
        success: function(result) {
            if (result != null) {
            	$('#DakCaseWorker').empty();
                for (var i = 0; i < result.length; i++) {
                    var data = result[i];
                    var optionValue = data[0];
                    var optionText = data[1] + ", " + data[2]; // Removed the %>; and fixed the concatenation
                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
                    $('#DakCaseWorker').append(option); // Moved this inside the loop
                }
                $('#DakCaseWorker').selectpicker('refresh');
                $.ajax({
                    type: "GET",
                    url: "getoldassignemplist.htm", // Replace with the actual URL
                    data: {
                    	DakId: DakId
                    },
                    dataType: 'json',
                    success: function(result) {
                    	var consultVals = Object.values(result);
                        if (consultVals != null) {
                            // Iterate through the selectedOptions and set the selected and disabled properties
                            for (var c = 0; c < consultVals.length; c++) {
                                var selectedOptionValue = consultVals[c][0];
                                $('#DakCaseWorker option[value="' + selectedOptionValue + '"]').prop('selected', true);
                                $('#DakCaseWorker option[value="' + selectedOptionValue + '"]').prop('disabled', true);
                            }
                            // Refresh the selectpicker after making changes
                            $('#DakCaseWorker').selectpicker('refresh');
                        }
                    }
                });
            }
        }
    });
}

function SeekResponse(DakId,dakmarkingid,dakno,Source,RedirVal) {
    $('#exampleModalSeekResponse').modal('show');
    $('#SeekDakNo').html(dakno);
    $('#SeekSourcetype').html(Source);
    $('#SeekResponseDakMarkingdakId').val(DakId);
    $('#SeekResponseDakMarkingIdsel').val(dakmarkingid);
    $('#SeekResponseRedirectVal').val(RedirVal);
    
  //code to redirect to page
	var redirectPageId   = "PageNoValFetch"+DakId;
	var redirectRowId =  "RowValFetch"+DakId;
	var pageElement = document.getElementById(redirectPageId);
	var rowElement = document.getElementById(redirectRowId);
    var pageValue = pageElement ? pageElement.value : null;
	var rowValue = rowElement ? rowElement.value : null;
	$('#PageRedirBySeekRepsonse').val(pageValue);
	$('#RowRedirBySeekRepsonse').val(rowValue);
	//code ends
    $.ajax({
        type: "GET",
        url: "getEmpListForSeekResponse.htm",
        data: {
            dakid: DakId
        },
        dataType: 'json',
        success: function(result) {
            if (result != null) {
            	$('#DakSeekResponseEmployee').empty();
                for (var i = 0; i < result.length; i++) {
                    var data = result[i];
                    var optionValue = data[0];
                    var optionText = data[1] + ", " + data[2]; // Removed the %>; and fixed the concatenation
                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
                    $('#DakSeekResponseEmployee').append(option); // Moved this inside the loop
                }
                $('#DakSeekResponseEmployee').selectpicker('refresh');
                $.ajax({
                    type: "GET",
                    url: "getoldSeekResponseassignemplist.htm", // Replace with the actual URL
                    data: {
                    	DakId: DakId
                    },
                    dataType: 'json',
                    success: function(result) {
                    	var consultVals = Object.values(result);
                        if (consultVals != null) {
                            // Iterate through the selectedOptions and set the selected and disabled properties
                            for (var c = 0; c < consultVals.length; c++) {
                                var selectedOptionValue = consultVals[c][0];
                                $('#DakSeekResponseEmployee option[value="' + selectedOptionValue + '"]').prop('selected', true);
                                $('#DakSeekResponseEmployee option[value="' + selectedOptionValue + '"]').prop('disabled', true);
                            }
                            // Refresh the selectpicker after making changes
                            $('#DakSeekResponseEmployee').selectpicker('refresh');
                        }
                    }
                });
            }
        }
    });
}

<!-----------------------------Dak Marker close -->
function DakMarkerCloseSelection(DakId,DakStatus,DakMarkingId,CountOfActionMarkers,CountOfActMarkersReply){
	 // Reset the select element to default on every click 
	  $('#DirectorApprovalSelVal').val('R');
	  $('#DakClosingComment').hide();
	  $('#DakApprovalForwardByMarker').show();
	  $('#DakCloseApprovalNotRequired').hide();
	  //ResetDefault values end
	const fields = ['dakIdFrClose', 'fromDateRedir', 'toDateRedir', 'dakStatusAppend', 'markingIdAppend', 'noOfActionMarkers', 'replyCountOfActionMarkers'];
	  fields.forEach(field => $('#' + field).val('')); // Clear all fields
	  $('#dakIdFrClose').val(DakId);
	  $('#dakStatusAppend').val(DakStatus);
	  $('#markingIdAppend').val(DakMarkingId);
	  $('#noOfActionMarkers').val(CountOfActionMarkers);
	  $('#replyCountOfActionMarkers').val(CountOfActMarkersReply);
	  $('#DirectorApprovalActionChange').modal('show');
}

function  MarkerCloseWithDirApproval(DakId,DakStatus,DakMarkingId,ApproveCommtAct,button){
	if(DakStatus === "AP" ){
		$('#dakIdFrClose').empty().append(DakId);
		if(ApproveCommtAct == "ApproveCommtPopUp"){
			// Retrieve the data attribute containing ApprovedCommtData 
			var ApproveCommt = button.getAttribute('data-ApprovedCommt-value');
		     $('.ApproveCommtDisplay').empty();
		     $('.ApproveCommtDisplay').val(ApproveCommt);
		     $('#DakIdFrDakCloseWithAPandComment').empty();
	         $('#DakIdFrDakCloseWithAPandComment').val(DakId);
	        $('#DakCloseWithAPModal').modal('hide');  
			$('#ApproveCommentByDirModal').modal('show');
		}else{
			$("#DakIdFrDakCloseWithAP").empty();
	        $('#DakIdFrDakCloseWithAP').val(DakId);
			$('#ApproveCommentByDirModal').modal('hide');
			$('#DakCloseWithAPModal').modal('show');  
		}//else loop close
	   }else{
		alert('This Dak is not approved by Director!!');
		return false;
	  }
	}
	
function dakCloseByMarkerWithDirApprv(){
	 var closingCommt = $('#closingCommtWithDirAprv').val().trim();
	    if (closingCommt===null || closingCommt === '' || closingCommt.trim()==='') {
	        alert("Please fill in the Closing Comment input field.");
	        return false;
	    }
	 var confirmation = confirm("Are you sure to close this DAK?");
	 if (confirmation) {
		  var form = document.getElementById("DakCloseWithAPMarkerForm");
      if (form) {
	          var DakCloseButton = document.getElementById("DakCloseWithAPByMarkerBtn");
	          if (DakCloseButton) {
	              var formactionValue = DakCloseButton.getAttribute("formaction");
	              if (formactionValue) {
	                    // Set the form's action attribute to the formactionValue and submit the form
	                    form.setAttribute("action", formactionValue);
	                    form.submit();
	              }
	            }
	        }
	    }

	    return false; // Prevents the default behavior of the button/link
}

function dakCloseByMarkerWithDirCommtView(){
		 var closingCommt = $('#markerclosingCommtWithDirCommt').val().trim();
		    if (closingCommt===null || closingCommt === '' || closingCommt.trim()==='') {
		        alert("Please fill in the Closing Comment input field.");
		        return false;
		    }
		 var confirmation = confirm("Are you sure to close this DAK?");
		 if (confirmation) {
			  var form = document.getElementById("DakCloseByMarkerWithDirCommtForm");
             if (form) {
		          var DakCloseButton = document.getElementById("DakCloseByMarkerWithDirCommtBtn");
		          if (DakCloseButton) {
		              var formactionValue = DakCloseButton.getAttribute("formaction");
		              if (formactionValue) {
		                    // Set the form's action attribute to the formactionValue and submit the form
		                    form.setAttribute("action", formactionValue);
		                    form.submit();
		              }
		            }
		        }
		    }
		    return false; // Prevents the default behavior of the button/link
}

function MarkerCloseWithoutDirApproval(){
	/*DakStatus,DakMarkingId,NoOfActMarkers,CountOfActMarkersReply*/
	var DakStatus = $('#dakStatusAppend').val();
	var NoOfActionMarkers = $('#noOfActionMarkers').val();
	var ReplyCountOfActionMarkers = $('#replyCountOfActionMarkers').val();
	 //as it is close without approval its imp to check dakstatus
	if(DakStatus!=null && DakStatus!="" && DakStatus != "AP" &&  NoOfActionMarkers!="" && ReplyCountOfActionMarkers!="")
	{
		   var closingCommt = $('#closingCommtWithoutDirAprv').val().trim();
		    if (closingCommt===null || closingCommt === '' || closingCommt.trim()==='') {
		        alert("Please fill in the Closing Comment input field.");
		        return false;
		    }
		     var confirmationMsg;
		     if(parseInt(NoOfActionMarkers) != parseInt(ReplyCountOfActionMarkers)){
			     confirmationMsg = confirm("Not all Action Markers have replied yet. Do you still want to close it?");
		     }else{
			    confirmationMsg = confirm("Are you sure to close this DAK?");
		     }
		     if(confirmationMsg){
				    var form = document.getElementById("DakDirApprForwardOrDakClose");
				      if (form) {
				       var DakCloseButton = document.getElementById("DakCloseApprovalNotRequired");
				          if (DakCloseButton) {
				              var formactionValue = DakCloseButton.getAttribute("formaction");
				               form.setAttribute("action", formactionValue);
				                form.submit();
				            }
				       }
				}
	}
	 return false; // Prevents the default behavior of the button/link
}

function ForwardDakForDirApprovalByMarker(){
	var DakStatus = $('#dakStatusAppend').val();
	var NoOfActionMarkers = $('#noOfActionMarkers').val();
	var ReplyCountOfActionMarkers = $('#replyCountOfActionMarkers').val();
	 //as it is close without approval its imp to check dakstatus
	if(DakStatus!=null && DakStatus!="" && DakStatus != "AP" &&  NoOfActionMarkers!="" && ReplyCountOfActionMarkers!="")
	{
		    var confirmationMsg;
		     if(parseInt(NoOfActionMarkers) != parseInt(ReplyCountOfActionMarkers)){
			     confirmationMsg = confirm("Not all Action Markers have replied yet. Do you still want to move this DAK for Director Approval?");
		     }else{
			    confirmationMsg = confirm("Are you sure to submit this DAK for Director Approval?");
		     }
		     if(confirmationMsg){
				    var form = document.getElementById("DakDirApprForwardOrDakClose");
				      if (form) {
				       var DirAppForwardButton = document.getElementById("DakApprovalForwardByMarker");
				          if (DirAppForwardButton) {
				              var formactionValue = DirAppForwardButton.getAttribute("formaction");
				               form.setAttribute("action", formactionValue);
				                form.submit();
				            }
				       }
				}
	}
	 return false; // Prevents the default behavior of the button/link
}
$(document).ready(function(){
	  $("#DirectorApprovalSelVal").trigger("change"); 
});
//change
function AuthorityDakButtonSwitch(){
	var DropdownVal = $('#DirectorApprovalSelVal').val();
	if(DropdownVal == "R"){
		$('#DakApprovalForwardByMarker').show();
		$('#DakCloseApprovalNotRequired').hide();
		$('#DakClosingComment').hide();
		
	}else if(DropdownVal == "N"){ 
		$('#DakCloseApprovalNotRequired').show();
		$('#DakApprovalForwardByMarker').hide();
		$('#DakClosingComment').show();
	}
}
function DakSeekResponseSubmit() {
	var Caseworker=$('#DakSeekResponseEmployee').val();
	var shouldSubmit = true;
	var form=document.getElementById('SeekResponseForm');
	if(Caseworker==null || Caseworker=='' || typeof(Caseworker)=='undefined'){
		 alert("Select Employee..!");
	  $("#DakSeekResponseEmployee").focus();
	  shouldSubmit= false;
	}else{
		if(confirm('Are you Sure To Submit ?')){
			  form.submit();/*submit the form */
				}
	}
}

function DakAssignSubmit() {
	var Caseworker=$('#DakCaseWorker').val();
	var shouldSubmit = true;
	var form=document.getElementById('AssignForm');
	if(Caseworker==null || Caseworker=='' || typeof(Caseworker)=='undefined'){
		 alert("Select CaseWorker..!");
	  $("#DakCaseWorker").focus();
	  shouldSubmit= false;
	}else{
		if(confirm('Are you Sure To Submit ?')){
			  form.submit();/*submit the form */
				}
	}
}

//Initialize an empty array to store the uniqueDakAssignReplyAttach IDs
var DakAssignReplyAttachFiles = [];
function dakReplyValidation() {
	  $('#AttachsFromDakAssigner').val('');
	   var isValidated = false;
	   var replyRemark = document.getElementsByClassName("replyTextArea")[0].value;
	if(replyRemark.trim() == "") { 
	isValidated = false;
}else{
	isValidated = true;
}
if (!isValidated) {
    event.preventDefault(); // Prevent form submission
    alert("Please fill in the reply input field.");
  } else {
	// Loop through all elements with data-custom-name="AssignerAttachInsert"
	   $('tr[data-custom-name="AssignerAttachInsert"]').each(function() {
		   // Get the data-custom-value attribute value and add it to the array
          var AttachedFileNames = $(this).data('custom-value');
          DakAssignReplyAttachFiles.push(AttachedFileNames);
	   });
	   // Set the value of the hidden input field as a comma-separated string
      $('#AttachsFromDakAssigner').val(DakAssignReplyAttachFiles.join(','));
      var elements = document.getElementsByName('Mail');
  	   var value;

   	// Loop through all radio buttons to find the checked one
   	for (var i = 0; i < elements.length; i++) {
   	  if (elements[i].checked) {
  	      value = elements[i].value;
  	      break;
  	   }
   	}
   	console.log("value: " + value);
   	if (value === 'Y') {
   		var ReplyReceivedMail= $('#ReplyReceivedMail').val();
   		if(ReplyReceivedMail==null || ReplyReceivedMail=='' || typeof(ReplyReceivedMail)=='undefined' || ReplyReceivedMail=='select'){
   			 alert("Please Select a Mail ...!");
   			 $("#ReplyReceivedMail").focus();
   			  shouldSubmit= false;
   		}else{
   			   // Retrieve the form and submit it
   		       var confirmation = confirm("Are you sure you want to reply?");
   		       if (confirmation) {
   		      var form = document.getElementById("attachformReply");
   		        if (form) {
   		     	   var submitButton = form.querySelector('input[type="button"]');
   		     	    var formAction = submitButton.getAttribute("formaction");
   		     	    if (formAction) {
   		     	        form.setAttribute("action", formAction);
   		     	        form.submit();
   		     	    }
   		        }
   		      }
   		}
   	} else {
   		   // Retrieve the form and submit it
   	       var confirmation = confirm("Are you sure you want to reply?");
   	       if (confirmation) {
   	      var form = document.getElementById("attachformReply");
   	        if (form) {
   	     	   var submitButton = form.querySelector('input[type="button"]');
   	     	    var formAction = submitButton.getAttribute("formaction");
   	     	    if (formAction) {
   	     	        form.setAttribute("action", formAction);
   	     	        form.submit();
   	     	    }
   	        }
   	      }
  		}
  }//else close
}//function close
  
function copyFacilitatorReplyToMarker(DakAssignReplyId){
	 $.ajax({
	        type: "GET",
	        url: "GetParticularCSWReplyDetails.htm",
	        data: {
	        	dakAssignReplyId: DakAssignReplyId
	        },
	        dataType: 'json',
	        success: function(result) {
	        	 if (result != null) {
 	            	 for (var i = 0; i < result.length; i++) {
						    var data = result[i];
						   var FacilitatorReply = data[3];
						    $('.replyTextArea').val(function (i, val) {
						          appendedText[DakAssignReplyId] = FacilitatorReply;
						          return val + FacilitatorReply;
						        });
						  /*   $('.replyTextArea').append(FacilitatorReply); */
						   //DakCSWReplyAttachPreview
						   // Check if data[7] count i.e DakReplyAttachCount is more than 0
						   if (data[7] > 0) {
					        	  // Call a function and pass row[2] i.e DakAssignReplyId
					              copyFacilitatorAttachToMarker(data[0]); 
					            }
 	            	 }
	        	 }
	        },
	         error: function(xhr, status, error) {
	             console.error("AJAX request error:", status, error);
	         }
	 });
}

//Define the ReplyCopyAttachDelete function
function ReplyCopyAttachDelete(DakAssignReplyAttachmentId) {
if ($('.AssignAttachRow' + DakAssignReplyAttachmentId).length > 0) {
$('.AssignAttachRow' + DakAssignReplyAttachmentId).remove();
} else {
    console.log('Element not found');
}
}

function copyFacilitatorAttachToMarker(DakAssignReplyId){
	 $.ajax({
		    type: "GET",
		    url: "GetCSWReplyAttachModalList.htm",
		    data: {
		      dakassignreplyid: DakAssignReplyId
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		        var resultData = JSON.parse(result);

		        if (resultData.length > 0) {
		      
		          var ReplyAttachTbody = '';
		          for (var z = 0; z < resultData.length; z++) {
		            var row = resultData[z];
		            DakAssignReplyAttachId = row[0];
		            ReplyAttachTbody += '<tr class="AssignAttachRow'+row[0]+'" id="CopyAttachRow'+DakAssignReplyId+'"  data-custom-name="AssignerAttachInsert" data-custom-value="'+row[4]+'"> ';
		            ReplyAttachTbody +=	' <td> <button type="button" onclick="ReplyCopyAttachDelete(' + row[0] + ')" id="ReplyCopyAttachDelete' + row[0] + '" class="btn btn-sm icon-btn" data-toggle="tooltip" data-placement="top" title="Delete" ><img alt="attach" src="view/images/delete.png"></button></td>';
                    ReplyAttachTbody += '  <td style="text-align: left;">';
		            ReplyAttachTbody += '  <form action="#" id="CWReplyFormCopy">';
		            ReplyAttachTbody += '  <input type="hidden" id="CWReplyIframe" name="cswdownloadbtn">';
		            ReplyAttachTbody += '  <button type="button" class="btn btn-sm replyCSWAttachWithin-btn"   value="'+row[0]+'"  onclick="IframepdfCaseWorkerReply('+row[0]+')" name="dakReplyCSWDownloadBtn"  data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
		            ReplyAttachTbody += '  </form>';
		            ReplyAttachTbody += '  </td>';
		            ReplyAttachTbody += '</tr> ';
		          }
		          $('#ReplyCopyAttachDataFill').append(ReplyAttachTbody);
		        }
		      }
		    },
		    error: function(xhr, textStatus, errorThrown) {
		      // Handle error
		    }
		  });
  }
  
var count=1;
$("table").on('click','.tr_clone_addbtn' ,function() {
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
});

$("table").on('click','.tr_clone_sub' ,function() {
var cl=$('.tr_clone').length;
if(cl>1){
   var $tr = $(this).closest('.tr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
}
});

var count1=1;
$("table").on('click','.tr_clone_addbtnMark' ,function() {
   var $tr = $('.tr_cloneMark').last('.tr_cloneMark');
   var $clone = $tr.clone();
   $tr.after($clone);
  count1++;
  $clone.find("input").val("").end();
});

$("table").on('click','.tr_clone_subMark' ,function() {
var cl=$('.tr_cloneMark').length;
if(cl>1){
   var $tr = $(this).closest('.tr_cloneMark');
   var $clone = $tr.remove();
   $tr.after($clone);
}
});

var count2=1;
$("table").on('click','.tr_editreply_addbtnMark' ,function() {
   var $tr = $('.tr_editreplyMark').last('.tr_editreplyMark');
   var $clone = $tr.clone();
   $tr.after($clone);
  count2++;
  $clone.find("input").val("").end();
});

$("table").on('click','.tr_editreply_subMark' ,function() {
var cl=$('.tr_editreplyMark').length;
if(cl>1){
   var $tr = $(this).closest('.tr_editreplyMark');
   var $clone = $tr.remove();
   $tr.after($clone);
}
});

var count3=1;
$("table").on('click','.tr_clone_addbtnAssign' ,function() {
   var $tr = $('.tr_cloneAssign').last('.tr_cloneAssign');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
});

$("table").on('click','.tr_clone_subAssign' ,function() {
var cl=$('.tr_cloneAssign').length;
if(cl>1){
   var $tr = $(this).closest('.tr_cloneAssign');
   var $clone = $tr.remove();
   $tr.after($clone);
}
});

var count4=1;
$("table").on('click','.tr_editreply_addbtnAssign' ,function() {
   var $tr = $('.tr_editreplyAssign').last('.tr_editreplyAssign');
   var $clone = $tr.clone();
   $tr.after($clone);
  count4++;
  $clone.find("input").val("").end();
});

$("table").on('click','.tr_editreply_subAssign' ,function() {
var cl=$('.tr_editreplyAssign').length;
if(cl>1){
   var $tr = $(this).closest('.tr_editreplyAssign');
   var $clone = $tr.remove();
   $tr.after($clone);
}
});

var count5=1;
$("table").on('click','.tr_editreply_addbtnSeekresponse' ,function() {
   var $tr = $('.tr_editreplySeekResponse').last('.tr_editreplySeekResponse');
   var $clone = $tr.clone();
   $tr.after($clone);
  count5++;
  $clone.find("input").val("").end();
});

$("table").on('click','.tr_editreply_subSeekresponse' ,function() {
var cl=$('.tr_editreplySeekResponse').length;
if(cl>1){
   var $tr = $(this).closest('.tr_editreplySeekResponse');
   var $clone = $tr.remove();
   $tr.after($clone);
}
});
function uploadDoc(dakIdValue,type,dakNoValue,RedirectVal,Source){
		$('#tab-1').prop('checked',true);
		$('#dakidvalue').val(dakIdValue);
		$('#dakidvalue2').val(dakIdValue);
		$('#type').val(type);
		$('#type2').val(type);
		$('#daknovalue').val(dakNoValue);
		$('#daknovalue2').val(dakNoValue);
		$('#dakAttachmentDakNo').html(dakNoValue);
		$('#dakAttachmentSource').html(Source);
		$('#ModalDakAttachments').modal('toggle');
		$('.downloadtable').css('display','none');
        /*for redirection purpose only*/
	 		$('#redirectFrAttach').val(RedirectVal);
	 		$('#redirectFrAttach2').val(RedirectVal);
	 		$('#redirectValFrDelAttach').val(RedirectVal);
    $.ajax({
			type : "GET",
			url : "GetAttachmentDetails.htm",
			data : {
				dakid: dakIdValue,
				attachtype:type,
				dakNo: dakNoValue
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
		return result[e]
		})
		var otherHTMLStr = '';
		for(var c=0;c<consultVals.length;c++)
		{var other = consultVals[c];
			otherHTMLStr +=	'<tr> ';
			otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >'+ (c+1) +'.</span> </td> ';
			otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >'+ other[3] +'.</span> </td> ';
			otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >';
			otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" onclick="Iframepdf('+other[2]+')" style="width:50%;" data-toggle="tooltip" data-placement="top" ><img alt="attach" src="view/images/download1.png"></button>'; 
				/* otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:35%;"  onclick="deleteForm('+other[2]+')" ><img alt="attach" src="view/images/delete.png"></button>';  */
				otherHTMLStr +=	'</td></tr> ';
        }
		if(consultVals.length>0){
			$('.downloadtable').css('display','');
		}
		if(type=='M'){
		$('#other-list-table').html(otherHTMLStr);
		}else{
			$('#other-list-table2').html(otherHTMLStr);
		}
		$('[data-toggle="tooltip"]').tooltip()
		}
		});
	}
	
	function tabChange(type){
		var value;
		if(type=='M'){
		value=$('#dakidvalue').val();
		$('#type').val(type);
		}else{
			value=$('#dakidvalue2').val();
			$('#type2').val(type);
		}
			$('.downloadtable').css('display','none');
        $.ajax({
		type : "GET",
		url : "GetAttachmentDetails.htm",
		data : {
			dakid: value,
			attachtype:type
		},
		datatype : 'json',
		success : function(result) {
		var result = JSON.parse(result);
		var consultVals= Object.keys(result).map(function(e){
		return result[e]
		})
		var otherHTMLStr = '';
		for(var c=0;c<consultVals.length;c++)
		{
			var other = consultVals[c];
			otherHTMLStr +=	'<tr> ';
			otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >'+ (c+1) +'.</span> </td> ';
			otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >'+ other[3] +'.</span> </td> ';
			otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >';
			otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" onclick="Iframepdf('+other[2]+')" data-toggle="tooltip" data-placement="top" style="width:50%; float:left;" ><img alt="attach" src="view/images/download1.png"></button>'; 
			if(type=='S'){
			otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:50%; float:left;" onclick="deleteForm('+other[2]+')" ><img alt="attach" src="view/images/delete.png"></button>'; 
			}
			otherHTMLStr +=	'</td></tr> ';
      }
		if(consultVals.length>0){
			$('.downloadtable').css('display','');
		}
		if(type=='M'){
		$('#other-list-table').html(otherHTMLStr);
		}else{
			$('#other-list-table2').html(otherHTMLStr);
		}
		$('[data-toggle="tooltip"]').tooltip()
		}
	});
	}
	
	 function deleteForm(value){
		 $('#dakattachmentid').val(value);
		 var result = confirm ("Are You sure to Delete ?"); 
		 if(result){
			 $('#deleteform').submit();
		 }
	 }
	 
	function submitattachMainDoc(){
		// Check if the file input is empty
	    var fileInput = document.getElementById("dakdocumentMainDoc");
	    if (!fileInput.files || fileInput.files.length === 0) {
	        alert("Please attach a document to submit.");
	        return false; // Prevent form submission
	    }
	    var res = confirm('Your Replacing the old Document! Are You Sure To Submit?');
	    if (res) {
	        // Programmatically trigger the form submission
	        $('#attachformMainDoc')[0].submit();
	    } else {
	        event.preventDefault();
	    }
		}
		
	function submitattachSubDoc(){
		  var fileInput = document.getElementById("dakdocumentSubDoc");
		    if (!fileInput.files || fileInput.files.length === 0) {
		        alert("Please attach a document to submit.");
		        return false; // Prevent form submission
		    }
		    var res = confirm('Are You Sure To Submit?');
		    if (res) {
		        // Programmatically trigger the form submission
		        $('#attachformSubDoc')[0].submit();
		    } else {
		        event.preventDefault();
		    }
		}
function EditAction(ActionRequiredDakId,ActionForm,dakno,source) {
	
	var dakClosingAuthorityList = [];
    <% 
        List<Object[]> list = (List<Object[]>)request.getAttribute("dakClosingAuthorityList");
        for (Object[] obj : list) {
    %>
        dakClosingAuthorityList.push({ value: "<%= obj[2] %>", label: "<%= obj[1] %>" });
    <% } %>
    
		$('#exampleModalActionRequiredEdit').modal('show');
		$('#ActionRequiredEditDakId').val(ActionRequiredDakId);
		$('#DakDetailedActionRequiredEditActionVal').val(ActionForm);
		$('#DakDetailedActionRequiredEditDakNo').html(dakno);
		$('#DakDetailedActionRequiredEditSource').html(source);
			$.ajax({
			type : "GET",
			url : "getDakActionRequiredEdit.htm",
			data : {
				ActionRequiredDakId: ActionRequiredDakId
			},
			datatype: 'json',
			  success: function(result) {
			    if (result != null) {
			      result = JSON.parse(result);
			      var Data = Object.keys(result).map(function(e) {
			        return result[e];
			      });
			      $('#ActionRequiredEdit').empty();
			      <%for(Object[] action : actionList){ %>
			      	var selectedvalue= <%=action[0]%>;
			      	var optionValue = '<%= action[0] + "#" + action[1] %>';
				    var optionText = '<%= action[1] %>';
			        var option = $("<option></option>").attr("value", optionValue).text(optionText);
			        for (var c = 0; c < Data.length; c++) {
			             if(selectedvalue==Data[c][0]){
			             option.prop('selected', true);
			          }
			             if(Data[c][1]==='ACTION'){
			     	    	$('.ActionDueDate').show();
			     	    	$('.ActionTime').show();
			     	    }else{
			     	    	$('.ActionDueDate').hide();
			     	    	$('.ActionTime').hide();
			     	    }
			             $('#EditRemarks').val(Data[c][5]);
			             if(Data[c][2]!=null && Data[c][3]!=null){
			            	 var originalActDueDate =Data[c][2];
			    			 var ActdateObj = new Date(originalActDueDate);
			    			 var Actday = ActdateObj.getDate();
			    			 var Actmonth = ActdateObj.getMonth() + 1; 
			    			 var Actyear = ActdateObj.getFullYear();
			                 var formattedActDay = Actday < 10 ? '0' + Actday : Actday;
			    			 var formattedActMonth = Actmonth < 10 ? '0' + Actmonth : Actmonth;
			    			 var formattedActDate = formattedActDay + '-' + formattedActMonth + '-' + Actyear;
			            	 $('#dakdetailsduedate').val(formattedActDate);
			            	 var timeString = Data[c][3];
							  var timeParts = timeString.split(" ");
							  var time = timeParts[0];
							  var period = timeParts[1];
							  var timeParts2 = time.split(":");
							  var hours = parseInt(timeParts2[0]);
							  var minutes = parseInt(timeParts2[1]);
							  if (period === "PM" && hours !== 12) {
							    hours += 12;
							  } else if (period === "AM" && hours === 12) {
							    hours = 0;
							  }
							  var formattedTime = ("0" + hours).slice(-2) + ":" + ("0" + minutes).slice(-2);
							  $('#dakDetailsDueTime').val(formattedTime);
			             }
			        }
			          $('#ActionRequiredEdit').append(option);
	<%}%>	
	$('#ClosingAuthorityEdit').empty();
	/* for (var c = 0; c < Data.length; c++) {
		var option1 = $("<option></option>").attr("value", "P").text("P&C DO");
		var option2 = $("<option></option>").attr("value", "K").text("D-KRM");
		var option3 = $("<option></option>").attr("value", "A").text("D-Adm");
		var option4 = $("<option></option>").attr("value", "R").text("DFMM");
		var option5 = $("<option></option>").attr("value", "Q").text("DQA");
	    var option6 = $("<option></option>").attr("value", "O").text("Others");
	    if (Data[c][4] === "P") {
	        option1.prop('selected', true); 
	    } else if (Data[c][4] === "K") {
	        option2.prop('selected', true);
	    } else if (Data[c][4] === "A") {
	        option3.prop('selected', true);
	    } else if (Data[c][4] === "R") {
	        option4.prop('selected', true);
	    } else if (Data[c][4] === "Q") {
	        option5.prop('selected', true);
	    } else if (Data[c][4] === "O") {
	        option6.prop('selected', true);
	    }
	    $('#ClosingAuthorityEdit').append(option1, option2, option3, option4, option5, option6);
	} */
	
	for (var c = 0; c < Data.length; c++) {
	    $('#ClosingAuthorityEdit').empty(); // Clear existing options

	    for (var i = 0; i < dakClosingAuthorityList.length; i++) {
	        var option = $("<option></option>")
	            .attr("value", dakClosingAuthorityList[i].value)
	            .text(dakClosingAuthorityList[i].label);

	        if (Data[c][4] === dakClosingAuthorityList[i].value) {
	            option.prop("selected", true);
	        }

	        $('#ClosingAuthorityEdit').append(option);
	    }
	}
	$('.selectpicker').selectpicker('refresh');
			    }
			  }//success close
			});//ajax close
}

function changeFunc() {
    var selectElement = document.getElementById("ActionRequiredEdit");
    var selectedOptionIndex = selectElement.selectedIndex;
    var selectedOptionText = selectElement.options[selectedOptionIndex].text;
    if(selectedOptionText==='ACTION'){
    	$('.ActionDueDate').show();
    	$('.ActionTime').show();
    }else{
    	$('.ActionDueDate').hide();
    	$('.ActionTime').hide();
    }};
    $(function() {
 	   $('#dakDetailsDueTime').daterangepicker({
 	            timePicker : true,
 	            singleDatePicker:true,
 	            timePicker24Hour : true,
 	            timePickerIncrement : 1,
 	            timePickerSeconds : false,
 	            locale : {
 	                format : 'HH:mm'
 	            }
 	        }).on('show.daterangepicker', function(ev, picker) {
 	            picker.container.find(".calendar-table").hide();
 	   });
 	})
 	
$(document).ready(function() {
	var currentDate = new Date();
	  var weekAgo = new Date();
	  weekAgo.setDate(currentDate.getDate() - 7);
$('#dakdetailsduedate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"startDate" : new Date(),
	"minDate" : weekAgo,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
});
    function ApproveOrViewPNCDORepliedDakByDir (DakId,RedirectTab) {
   	 // Clear previous click data
   	 $("#DakIdAppendForDirActOfPNCDO").empty();
   	 $('.DirCommtBasedOnAct').empty();
   	 $("#RedirTabOfPNCDO").empty();
        $(".DakNoAppend").empty();
        $(".DakDetailsAppend").empty();
        $(".PnCRepliedTextForApproval").empty();
        $('.returnCommtDisplay').empty();
        $(".PnCRepliedDocuments").empty().removeAttr('style'); 
        // Remove style from the PnCRepliedDocuments table
   	  // AJAX call to retrieve reply details of the Dak with DakId
   	  $.ajax({
   	    type: "GET",
   	    url: "GetPnCReplyDetails.htm",
   	    data: {
   	      dakid: DakId
   	    },
   	    datatype: 'json',
   	    success: function(result) {
   	      if (result != null) {
   	        var Data = JSON.parse(result); // Parse the JSON data
   	        // Loop through the retrieved data
   	        for (var i = 0; i < Data.length; i++) {
   	          var values = Data[i];
   	     	 $("#RedirTabOfPNCDO").val(RedirectTab);
   	      	  $('#DakIdAppendForDirActOfPNCDO').val(DakId);
   	          $('.DakNoAppend').text(values[7]);
   	          $('.PnCRepliedTextForApproval').val(values[3]);
   	             var formattedRefDate = "--";
   	            if(values[10]!=null || values[10]!=''){
   	                 var d = new Date(values[10]),
   		             month = '' + (d.getMonth() + 1),day = '' + d.getDate(),year = d.getFullYear();
   		             if (month.length < 2) month = '0' + month;
   		             if (day.length < 2) day = '0' + day;
   		             formattedRefDate=[day,month,year].join('-');
   	            }
   	            var formattedActionDate = "--";
   	            if(values[12]!=null || values[12]!=''){
   	            	var ActionDue = new Date(values[12]),
   			        month = '' + (ActionDue.getMonth() + 1),day = '' + ActionDue.getDate(),year = ActionDue.getFullYear();
   			       if (month.length < 2) month = '0' + month;
   			       if (day.length < 2) day = '0' + day;
   			       var formattedActionDate=[day,month,year].join('-');
   	            }
   		       $('.DakDetailsAppend').css({ 'font-size' : '15px' });
   	           $('.DakDetailsAppend').text(' Source: '+values[11]+', Ref No & Date: '+values[9]+', '+formattedRefDate+', Action Due: '+formattedActionDate);
   	          if (values[8] > 0) {
   	        	// Apply the specific styles for the else condition
   	              $('.PnCRepliedDocuments').css({
   	                'border': 'none',
   	                'width': '294px',
   	                'float': 'left',
   	                'margin-left': '18px',
   	                'margin-top': '6px'
   	              });
   	        	// If there are attachments, call the function PnCReplyAttachs to retrieve them
   	            PnCReplyAttachs(values[0]);
   	          } else {
   	        	  // Apply the specific styles for the else condition
   	              $('.PnCRepliedDocuments').css({
   	            	    'border': '1px solid #ced4da',
   	            	    'border-radius': '0.25rem !important',
   	            	    'width': '294px',
   	            	    'float': 'left',
   	            	    'clear': 'left',
   	            	    'margin-left': '18px'
   	              });
   	            // If there are no attachments, display a message in the corresponding element
   	            var emptyRow = '<tr><td style="text-align: center; font-size: 14px;">No Documents Attached</td></tr>';
   	            $('.PnCRepliedDocuments').append(emptyRow);
   	          }
   	          if (values[4] == 'D') { //This is view after actions
   	        	  document.getElementById('dakApproveOfPNCDOClick').style.display = 'none';
   	              document.getElementById('dakApproveCommtOfPNCDOClick').style.display = 'none';
   	              document.getElementById('dakReturnOfPNCDOClick').style.display = 'none';
   	              $('.ReturnedMessage').show();
   	              $('.returnCommtDisplay').text( values[15]);
   	              $('#commentFieldDiv').hide();
   	          }else{ //This is actions before view
   	        	  document.getElementById('dakApproveOfPNCDOClick').style.display = 'inline-block';
   	              document.getElementById('dakApproveCommtOfPNCDOClick').style.display = 'inline-block';
   	              document.getElementById('dakReturnOfPNCDOClick').style.display = 'inline-block';
   	              $('.ReturnedMessage').hide();
   	              $('#commentFieldDiv').show();
   	          }
   	        }//for loop close
   	          // Show a modal with the ID 'consolidated-reply-details'
   		  	  $('#consolidated-reply-details').modal('show');
   	      }//if loop close
   	    }//success loop close
   	  });
   	}

   	function PnCReplyAttachs(DakPnCReplyId) {
   	  // AJAX call to retrieve reply attachments for the DakPnCReplyId
   	  $.ajax({
   	    type: "GET",
   	    url: "GetPnCReplyAttachDetails.htm",
   	    data: {
   	      dakpncreplyid: DakPnCReplyId
   	    },
   	    datatype: 'json',
   	    success: function(result) {
   	      if (result != null) {
   	        var resultData = JSON.parse(result); // Parse the JSON data
   	        var ReplyAttachTbody = '';
   	        for (var z = 0; z < resultData.length; z++) {
   	          var row = resultData[z];
   	          ReplyAttachTbody += '<tr> ';
   	          ReplyAttachTbody += '  <td style="text-align: left;">';
   	          ReplyAttachTbody += '  <form action="#" id="PCReplyIframeForm">';
   	          ReplyAttachTbody += '  <input type="hidden" id="PCReplyIframe" name="pncReplyDownloadBtn">';
   	          ReplyAttachTbody += '    <button type="button" class="btn btn-sm pncReplyAttach-btn" name="pncReplyDownloadBtn" value="'+row[0]+'"  onclick="IframepdfForPnCAttachedDocs('+row[0]+',0)"  data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
   	          ReplyAttachTbody += '  </form>';
   	          ReplyAttachTbody += '  </td>';
   	          ReplyAttachTbody += '</tr> ';
   	        }
   	        // Append the ReplyAttachTbody to the element with class 'PnCRepliedDocuments'
   	        $('.PnCRepliedDocuments').append(ReplyAttachTbody);
   	      }
   	    }
   	  });
   	}
   	
   	function dakApproveByDirForPNCDO(){
		$("#DirectorActionOfPNCDO").empty();
		$('#DirectorActionOfPNCDO').val('DakApproval');
		// Introduce a delay of 100 milliseconds before showing the confirmation popup
		setTimeout(function() {
			var confirmation = confirm("Are you sure you want to approve this consolidated response?");
			if (confirmation) {
				// If user clicks OK, you can put any further actions here.
				      var form = document.getElementById("DirActionsFormPNCDO");
                      if (form) {
                       var approveButton = document.getElementById("dakApproveOfPNCDOClick");
                          if (approveButton) {
                              var formactionValue = approveButton.getAttribute("formaction");
                               form.setAttribute("action", formactionValue);
                                form.submit();
                            }
                       }
			} else {
				return false;
			}
		}, 100);
	}

function dakApproveCommentsByDirOfPNCDO(){
	$("#DirectorActionOfPNCDO").empty();
	$('#DirectorActionOfPNCDO').val('DakApprovalWithComments');
	var approveComment = $('.DirCommtBasedOnAct').val();
	// Introduce a delay of 100 milliseconds before showing the confirmation popup
	setTimeout(function() {
		if(approveComment!=null && approveComment!=''){
		var confirmation = confirm("Are you sure you want to approve this consolidated response?");
		if (confirmation) {
			// If user clicks OK, you can put any further actions here.
			      var form = document.getElementById("DirActionsFormPNCDO");
                if (form) {
                 var approveCommtButton = document.getElementById("dakApproveCommtOfPNCDOClick");
                    if (approveCommtButton) {
                        var formactionValue = approveCommtButton.getAttribute("formaction");
                         form.setAttribute("action", formactionValue);
                          form.submit();
                      }
                 }
		} else {
			return false;
		}
		}else{
			alert('Please Fill the Comment Field!');
			return false;
			}
	}, 100);
}
function dakReturnByDirOfPNCDO(){
	$("#DirectorActionOfPNCDO").empty();
	$('#DirectorActionOfPNCDO').val('DakReturn');
	var returnComment = $('.DirCommtBasedOnAct').val();
	// Introduce a delay of 100 milliseconds before showing the confirmation popup
	setTimeout(function() {
		if(returnComment!=null && returnComment!=''){
		var confirmation = confirm("Are you sure you want to return this consolidated response?");
		if (confirmation) {
			// If user clicks OK, you can put any further actions here.
			      var form = document.getElementById("DirActionsFormPNCDO");
              if (form) {
               var returnButton = document.getElementById("dakReturnOfPNCDOClick");
                  if (returnButton) {
                      var formactionValue = returnButton.getAttribute("formaction");
                       form.setAttribute("action", formactionValue);
                        form.submit();
                    }
               }
		} else {
			return false;
		}
		}else{
			alert('Please Fill the Comment Field!');
			return false;
			}
	}, 100);
}

function ApproveOrViewMarkerRepliedDakByDir(DakId,DirApvForwarderId,TabValue) {
	  // AJAX call to retrieve reply details of the DirApvForwarderIds Reply along with DakId
	        // Clear previous data
	        $(".MarkerDetailsInPreview").empty();
	        $(".DakNoAppendInPreview").empty();
	        $(".DakDetailsAppendInPreview").empty();
	        $(".MarkerRepliedTextForApproval").empty();
	        $(".MarkerRepliedDocuments").empty().removeAttr('style'); 
	        $("#DakIdAppendForDirActOfMarker").empty();
	        $("#RedirTabOfMarker").empty();
	        // Remove style from the table
	   $.ajax({
	    type: "GET",
	    url: "GetMarkerReplySentForApprovalData.htm",
	    data: {
	      dakid: DakId,
	      diraprvforwarderid : DirApvForwarderId
	    },
	    datatype: 'json',
	    success: function(result) {
	      if (result != null) {
	        var Data = JSON.parse(result); // Parse the JSON data
	        // Loop through the retrieved data
	        for (var i = 0; i < Data.length; i++) {
	          var values = Data[i];
	          $("#RedirTabOfMarker").val(TabValue);
	      	  $('#DakIdAppendForDirActOfMarker').val(DakId);
	          $('.DakNoAppendInPreview').text(values[7]);
	          $('.MarkerRepliedTextForApproval').val(values[3]);
	             var formattedRefDate = "--";
	            if(values[10]!=null || values[10]!=''){
	                 var d = new Date(values[10]),
		             month = '' + (d.getMonth() + 1),day = '' + d.getDate(),year = d.getFullYear();
		             if (month.length < 2) month = '0' + month;
		             if (day.length < 2) day = '0' + day;
		             formattedRefDate=[day,month,year].join('-');
	            }
	            var formattedActionDate = "--";
	            if(values[12]!=null || values[12]!=''){
	            	var ActionDue = new Date(values[12]),
			        month = '' + (ActionDue.getMonth() + 1),day = '' + ActionDue.getDate(),year = ActionDue.getFullYear();
			       if (month.length < 2) month = '0' + month;
			       if (day.length < 2) day = '0' + day;
			       var formattedActionDate=[day,month,year].join('-');
	            }
		       $('.MarkerDetailsInPreview').append(values[13]+","+values[14]);
		       $('.DakDetailsAppendInPreview').css({ 'font-size' : '15px' });
	           $('.DakDetailsAppendInPreview').text('Source: '+values[11]+',Ref No & Date: '+values[9]+', '+formattedRefDate+',  Action Due: '+formattedActionDate);
	          if (values[8] > 0) {
	        	// Apply the specific styles for the else condition
	              $('.MarkerRepliedDocuments').css({
	                'border': 'none',
	                'width': '294px',
	                'float': 'left',
	                'margin-left': '18px',
	                'margin-top': '6px'
	              });
	        	// If there are attachments, call the function from MarkerReplyAttachs;
	            MarkerReplyAttachs(values[0]);
	          } else {
	        	  // Apply the specific styles for the else condition
	              $('.MarkerRepliedDocuments').css({
	            	    'border': '1px solid #ced4da',
	            	    'border-radius': '0.25rem !important',
	            	    'width': '294px',
	            	    'float': 'left',
	            	    'clear': 'left',
	            	    'margin-left': '18px'
	              });
	            // If there are no attachments, display a message in the corresponding element
	            var emptyRow = '<tr><td style="text-align: center; font-size: 14px;">No Documents Attached</td></tr>';
	            $('.MarkerRepliedDocuments').append(emptyRow);
	          }
	          if (values[4] == 'D') {
	        	  document.getElementById('dakApproveOfMarkerClick').style.display = 'none';
	              document.getElementById('dakApproveCommtOfMarkerClick').style.display = 'none';
	              //document.getElementById('dakReturnOfMarkerClick').style.display = 'none';
	              $('.ReturnedMessageMarker').show();
	              $('#ReturnedMessageMarker').hide();
	          }else{
	        	  document.getElementById('dakApproveOfMarkerClick').style.display = 'inline-block';
	              document.getElementById('dakApproveCommtOfMarkerClick').style.display = 'inline-block';
	              //document.getElementById('dakReturnOfMarkerClick').style.display = 'inline-block';
	              $('.ReturnedMessageMarker').hide();
	              $('#CommentValueDiv').show();
	          }
	        }//for loop close
	        // Show a modal with the ID 'consolidated-reply-details'
		  	  $('#marker-reply-details').modal('show');
	      }//if loop close
	    }//success loop close
		  });
}

function MarkerReplyAttachs(DakReplyId) {
	  // AJAX call to retrieve reply attachments for the DakPnCReplyId
	  $.ajax({
	    type: "GET",
	    url: "GetReplyAttachModalList.htm",
	    data: {
	    	 dakreplyid: DakReplyId
	    },
	    datatype: 'json',
	    success: function(result) {
	      if (result != null) {
	        var resultData = JSON.parse(result); // Parse the JSON data
	        var ReplyAttachTbody = '';
	        for (var z = 0; z < resultData.length; z++) {
	          var row = resultData[z];
	          ReplyAttachTbody += '<tr> ';
	          ReplyAttachTbody += '  <td style="text-align: left;">';
	          ReplyAttachTbody += '  <form action="#" id="Replyform">';
	          ReplyAttachTbody += '  <input type="hidden" id="ReplyIframeData" name="markerdownloadbtn">';
	          ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply" value="'+row[0]+'"  onclick="IframepdfMarkerReply('+row[0]+',0)"  data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
	          ReplyAttachTbody += '  </form>';
	          ReplyAttachTbody += '  </td>';
	          ReplyAttachTbody += '</tr> ';
	        }
	        // Append the ReplyAttachTbody to the element with class 'PnCRepliedDocuments'
	        $('.MarkerRepliedDocuments').append(ReplyAttachTbody);
	      }
	    }
	  });
	}
	
function dakMarkersReplyApproveByDirector(){
	 $("#DirectorActionOfMarker").empty();
	 $('#DirectorActionOfMarker').val('DakApproval');
	// Introduce a delay of 100 milliseconds before showing the confirmation popup
	setTimeout(function() {
		var confirmation = confirm("Are you sure you want to approve this marker response?");
		if (confirmation) {
			// If user clicks OK, you can put any further actions here.
			      var form = document.getElementById("DirectorActionFormOthers");
                 if (form) {
                  var approveButton = document.getElementById("dakApproveOfMarkerClick");
                     if (approveButton) {
                         var formactionValue = approveButton.getAttribute("formaction");
                          form.setAttribute("action", formactionValue);
                           form.submit();
                       }
                  }
		} else {
			return false;
		}
	}, 100);
}

function dakApproveCommentsByDirOfMarker(){
$("#DirectorActionOfMarker").empty();
$('#DirectorActionOfMarker').val('DakApprovalWithComments');
var approveComment = $('.DirCommt').val();
//Introduce a delay of 100 milliseconds before showing the confirmation popup
setTimeout(function() {
if(approveComment!=null && approveComment!=''){
var confirmation = confirm("Are you sure you want to approve this marker response?");
if (confirmation) {
	// If user clicks OK, you can put any further actions here.
	      var form = document.getElementById("DirectorActionFormOthers");
        if (form) {
         var approveButton = document.getElementById("dakApproveCommtOfMarkerClick");
            if (approveButton) {
                var formactionValue = approveButton.getAttribute("formaction");
                 form.setAttribute("action", formactionValue);
                  form.submit();
              }
         }
} else {
	return false;
}
} else {
	alert('Please Fill the Comment Field!');
	return false;
}
}, 100);
}

function dakReturnByDirOfMarker(){
$("#DirectorActionOfMarker").empty();
$('#DirectorActionOfMarker').val('DakReturn');
var returnComment = $('.DirCommt').val();
setTimeout(function() {
if(returnComment!=null && returnComment!=''){
	var confirmation = confirm("Are you sure you want to return this marker response?");
	if (confirmation) {
		// If user clicks OK, you can put any further actions here.
		      var form = document.getElementById("DirectorActionFormOthers");
            if (form) {
             var approveButton = document.getElementById("dakReturnOfMarkerClick");
                if (approveButton) {
                    var formactionValue = approveButton.getAttribute("formaction");
                     form.setAttribute("action", formactionValue);
                      form.submit();
                  }
             }
	} else {
		return false;
	}
} else {
	alert('Please Fill the Comment Field!');
	return false;
}
}, 100);
}

function DakCloseValidation(DakId,Action,button,dakno,source){ // this will give particular clicked button
	if(Action == "ApproveCommtPopUp"){
		// Retrieve the data attribute containing ApprovedCommtData 
		var ApproveCommt = button.getAttribute('data-ApprovedCommt-value');
         $(".ApproveCommtDisplay").empty();
		 $('.ApproveCommtDisplay').val(ApproveCommt);
		 $("#DakCloseDakIdAppend").empty();
         $('#DakCloseDakIdAppend').val(DakId);
         $('#DakCloseDakNo').html(dakno);
         $('#DakCloseSource').html(source);
         $('#DakCloseCommentModal').modal('hide');
		 $('#ApproveCommentModal').modal('show');
	}else{
		$('#ApproveCommentModal').modal('hide');
		$('#DakCloseCommentModal').modal('show');
		$('#DakCloseDakNo').html(dakno);
		 $('#DakCloseSource').html(source);
		$("#DakIdUpdateFrDakClose").empty();
		$('#DakIdUpdateFrDakClose').val(DakId);
	}//else loop close
}
function dakCloseByDirApprv(){
	   var closingCommt = $('#closingCommtMain').val().trim();
	    if (closingCommt===null || closingCommt === '' || closingCommt.trim()==='') {
	        alert("Please fill in the Closing Comment input field.");
	        return false;
	    }
	    var confirmation = confirm("Are you sure to close this DAK?");
	    if (confirmation) {
	        var form = document.getElementById("DakCloseInPNCDOForm");
             if (form) {
	            var DakCloseButton = document.getElementById("DakCloseByPNCDO");
	            if (DakCloseButton) {
	                var formactionValue = DakCloseButton.getAttribute("formaction");
                    if (formactionValue) {
	                    // Set the form's action attribute to the formactionValue and submit the form
	                    form.setAttribute("action", formactionValue);
	                    form.submit();
	                }
	            }
	        }
	    }
	    return false; // Prevents the default behavior of the button/link
	}

function dakCloseByDirCommtView() {
			    var closingCommt = $('#closingCommtWithDirCommt').val().trim();
			    if (closingCommt===null || closingCommt === '' || closingCommt.trim()==='') {
			        alert("Please fill in the Closing Comment input field.");
			        return false;
			    }
			    var confirmation = confirm("Are you sure to close this DAK?");
			    if (confirmation) {
			        var form = document.getElementById("DakCloseInPNCDOWithDirCommtForm");
			        if (form) {
			            var DakCloseButton = document.getElementById("DakCloseAfterDirCommtView");
			            if (DakCloseButton) {
			                var formactionValue = DakCloseButton.getAttribute("formaction");
                              if (formactionValue) {
			                    // Set the form's action attribute to the formactionValue and submit the form
			                    form.setAttribute("action", formactionValue);
			                    form.submit();
			                  }
			              }
			        }
			    }
      return false; 
}

function replyModal(DakId,AssignId,dakno,source,redirval) {
	 $('#AssignexampleModalReply').modal('show');
	$('#dakIdOfAssignReply').val(DakId);
	$('#AssignId').val(AssignId);
	$('#AssignDakNo').val(dakno);
	$('#DakAssignReplyDakNo').html(dakno);
	$('#DakAssignReplySource').html(source);
	$('#DakAssignRedirVal').val(redirval);
}

function dakAssignReplyValidation() {
	   var isValidated = false;
	   var replyRemark = document.getElementsByClassName("AssignreplyTextArea")[0].value;
	if(replyRemark.trim() !== "") { 
 	isValidated = true;
 }else{
 	isValidated = false;
 }
 if (!isValidated) {
     event.preventDefault(); // Prevent form submission
     alert("Please fill in the remark input field.");
   } else {
       // Retrieve the form and submit it
       var confirmation = confirm("Are you sure you want to reply?");
       if (confirmation) {
      var form = document.getElementById("AssignattachformReply");
        if (form) {
     	   var submitButton = form.querySelector('input[type="button"]');
     	    var formAction = submitButton.getAttribute("formaction");
     	    if (formAction) {
     	        form.setAttribute("action", formAction);
     	        form.submit();
     	    }
        }
      }
   }//else close
   }

function SeekResponsereplyModal(DakId,dakno,source,SeekerResponseId,seekredirval) {
	$('#SeekexampleModalReply').modal('show');
	$('#dakIdOfSeekResponseReply').val(DakId);
	$('#SeekResponseDakNo').val(dakno);
	$("#SeekResponseId").val(SeekerResponseId);
	$('#DakSeekResponseReplyDakNo').html(dakno);
	$('#DakSeekResponseReplySource').html(source);
	$('#seekredirval').val(seekredirval);
}

function dakSeekResponseReplyValidation() {
	   var isValidated = false;
	   var replyRemark = document.getElementsByClassName("SeekResponsereplyTextArea")[0].value;
	if(replyRemark.trim() !== "") { 
 	isValidated = true;
 }else{
 	isValidated = false;
 }
 if (!isValidated) {
     event.preventDefault(); // Prevent form submission
     alert("Please fill in the remark input field.");
   } else {
       // Retrieve the form and submit it
       var confirmation = confirm("Are you sure you want to reply?");
       if (confirmation) {
      var form = document.getElementById("SeekResponseattachformReply");
        if (form) {
     	   var submitButton = form.querySelector('input[type="button"]');
     	    var formAction = submitButton.getAttribute("formaction");
     	    if (formAction) {
     	        form.setAttribute("action", formAction);
     	        form.submit();
     	    }
        }
      }
   }//else close
   }

function TrackingStatusPageRedirect(dakid,redirectVal){
		$('#dakIdFrTrackingDakStatus').val(dakid);
		$('#redirectionByTrackingPage').val(redirectVal);
		//Display the received content in new tab
     $('#dakStatusTrackingForm').submit();
	}
function  dakAssignReplyEditValidation(){
	 var isValidated = false;
	   var replyRemarkOfEdit = document.getElementsByClassName("assignReplyDataInEditModal")[0].value;
	if(replyRemarkOfEdit.trim() == "") { 
   	isValidated = false;
   }else{
   	isValidated = true;
   }
   if (!isValidated) {
       event.preventDefault(); // Prevent form submission
       alert("Please fill in the remark input field.");
     } else {
         // Retrieve the form and submit it
         var confirmation = confirm("Are you sure you want to edit this reply?");
         if (confirmation) {
       	  var button = $('#cswdakCommonReplyEditAction');
  			var formAction = button.attr('formaction');
  			if (formAction) {
  				  var form = button.closest('form');
  				  form.attr('action', formAction);
  				  form.submit();
  				}else{
  					console.log('form action not found');
  				}
         } else { return false; }
     }//else close
}

function cswdeleteReplyEditAttach(ReplyAttachmentId,ReplyId){
	 $('#cswreplyAttachmentIdFrDelete').val(ReplyAttachmentId);
	 $('#cswreplyIdFrAttachDelete').val(ReplyId);
	 var result = confirm ("Are You sure to Delete ?"); 
	 if(result){
		var button = $('#cswReplyEditAttachDelete');
		var formAction = button.attr('formaction');
		if (formAction) {
			  var form = button.closest('form');
			  form.attr('action', formAction);
			  form.submit();
			}else{
				console.log('form action not found');
			}
	} else {
	    return false; // or event.preventDefault();
	}
}
</script>
</html>