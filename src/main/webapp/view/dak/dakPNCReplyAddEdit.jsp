<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    	pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
    <%@page import="java.time.LocalTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.dms.FormatConverter"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Consolidated Reply</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style type="text/css">

#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
}



.container-fluid {
    width: 100%;
    padding-right: 15px;
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
}

.commonDivofPnCReply{
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
}
.MarkedReplyDispCard{
margin-top:2%;
border-image: linear-gradient(to right, darkblue, darkorchid) 1;
min-height:600px!important; 
max-height: 600px; /* Limits the height to 533px */
overflow-y: auto; /* Enables vertical scrolling when content overflows */
overflow-x:hidden;
}

.MarkedReplyDispCardBody{
    margin-top: -4px;
    padding:0.25rem!important;
    min-height:590px!important;
    overflow-y: auto; /* Enables vertical scrolling when content overflows */
    overflow-x:hidden;
}

.RTMDOReplycard{
margin-top:2%;
border-image: linear-gradient(to right, darkblue, darkorchid) 1;
  max-height: 600px!important;  
}

.RTMDOReplycardBody{
  margin-top: 0px;
  min-height:590px!important; 
  overflow-y: auto; /* Enables vertical scrolling when content overflows */
  overflow-x:hidden;
}




.CRDakDetailsDisp-btn{
border:none;
color: #005C97;
font-weight: 700 !important;
 cursor: pointer;

}

.CRDakDetailsDisp-btn:focus {
  outline: none; /* Change the color and size as desired */
}

.CRDakDetailsDisp-btn:hover {
   color: royalblue;

}


.MarkedEmpsReplysBasedOnReplyId{

box-shadow: rgba(152,152,152, 0.3)0px 2px 4px 0px, rgba(14, 30, 37, 0.32) 0px 2px 16px 0px;
border-radius:2px;
}

#page-person-header {

  font-size: 1.1rem;
  font-weight: 700;
  color: #8B0000;
  text-shadow: 0 1px 0 #fff;
  padding-top: 10px;
  float: left; 
  margin-left:32px;
}
	
		
.replyDataOfMEmp {
 margin-bottom: 0; /* Remove the bottom margin of the .replyRow */
 margin-right:2px;

 
}	
.ReplyAttachMarkEmpTable {
  width: 330px;

}

.ReplyAttachPnCReplyTableEdit {
  width: 310px;

}

.groupReplyData {
  margin-left:0px;
  display: inline-block;
  max-width: 377px;
  padding-right:16px;
}

.groupReplyAttachments {
 display: inline-block;
   margin-left:0px;
  
}

.groupReplyAttachsOfMEmps {
 display: inline-block;
   margin-left:0px;
  
}

.replymarkedemps-div button,
.replymarkedemps-div span {
  user-select: none;
}

.replymarkedemps-div {
  color: black;
  user-select: all;
  outline: none;
  height: 100px;
/*   border: 1px solid grey; */
  text-align: left;
  padding-left: 10px;
  margin-left: 20px;
  width: 446px !important;
 float: left; 
 border:1px solid grey;
 /* box-shadow: rgba(14, 30, 37, 0.32) 0px 0px 0px 3px; */
border-radius:3px!important;
  
}

.viewmore-btn-click:hover {
background-color: #f9fcff;
background-image: linear-gradient(147deg, #f9fcff 0%, #dee4ea 74%);

}

.viewmore-btn-click{
    /* background-color: Transparent !important; */
    background-repeat: no-repeat;
    border: none;
    cursor: pointer;
    overflow: hidden;
    outline: none;
    text-align: left !important;
    color:#1176ab;
    font-size: 14px;
    background-color:white;
}
.replyMarkEmpAttachTbl-div{
  float: left; 
}

button.deletePnCBtn {
  border: none;
  width: 10% !important;
  cursor: pointer;
  outline: none;
}

button.deletePnCBtn:active {
  outline: none;
}

.fixed-width-td{
        width: 100px; /* Set your desired fixed width here */
        white-space: nowrap; /* Prevent text from wrapping to a new line */
        overflow: hidden; /* Hide any content that overflows the cell */
        text-overflow: ellipsis; /* Show ellipsis (...) for long text */

}
</style>
</head>
<body>
	<%
	FormatConverter fc = new FormatConverter();
	SimpleDateFormat rdtf = fc.getRegularDateTime();
	SimpleDateFormat sdtf = fc.getSqlDateAndTime();
	SimpleDateFormat sdf = fc.getSqlDate();
	
	String Action = (String)request.getAttribute("action");
	String DakId=(String)request.getAttribute("dakid");
	String DakNo=(String)request.getAttribute("dakno");

	List<Object[]> DakDetailsList = (List<Object[]>) request.getAttribute("dakDetailsList");
	List<Object[]> MarkedReplysDetsiledList = (List<Object[]>) request.getAttribute("markedReplysDetsiledList");
	List<Object[]> MarkedReplyAttachmentList = (List<Object[]>) request.getAttribute("markedReplyAttachmentList");
	List<Object[]> consolidatedReplyDataForEdit = (List<Object[]>) request.getAttribute("pnCReplyDetails");
	List<Object[]> consolidatedAttachDataForEdit = (List<Object[]>) request.getAttribute("pnCAttachReplyDetails");
	
	String frmDt=(String)request.getAttribute("fromDateCR");
	String toDt=(String)request.getAttribute("toDateCR");
	
	String RedirVal=(String)request.getAttribute("redirval");
	String viewfrom=(String)request.getAttribute("viewfrom");
	
	String redirview=(String)request.getAttribute("redirview");
	long EmpId =(Long)session.getAttribute("EmpId"); 
	String RedirectVal=(String)request.getAttribute("RedirectValAfterConsoReply");
		System.out.println("redirectVallllllllll"+RedirectVal);
	
	%>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-5 heading-breadcrumb">
			 	<%/*Marker Reply  */
 					String ReplyCounts = "0#0#0";
 					/*Caseworker Reply  */
 					 String CWReplyCounts = "0"; 
 					%>
				<h5 style="font-weight: 700 !important"><%if(Action.equalsIgnoreCase("ConsolidatedReply")){ %>Consolidated Reply
				                          <%}else if(Action.equalsIgnoreCase("ConsolidatedReplyEdit")){ %>Consolidated Reply Edit<%} %> (<button class="CRDakDetailsDisp-btn" id=<%="DakId"+DakId  %> value="<%= DakId %>" onclick="Preview(<%= DakId %>, <%= DakId %>)"><%=DakNo %></button>)</h5>
			</div>
			<div class="col-md-7 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a
							href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
					<li class="breadcrumb-item"><a href="DakDashBoard.htm"><iclass="fa fa-envelope"></i> DAK</a></li>
					<li class="breadcrumb-item">
					<%if(RedirectVal!=null && RedirectVal.equalsIgnoreCase("PNCListRedir")){ %>
					<a href="DakPNCList.htm">DAK P&C List</a>
					<%}else if(RedirectVal!=null && RedirectVal.equalsIgnoreCase("PNCDOListRedir")){ %>
					<a href="DakPNCDOList.htm">DAK P&C DO List</a>
					<%}else if(RedirectVal!=null && RedirectVal.equalsIgnoreCase("DakPendingPNCListRedir")){ %>
					<a href="DakPNCList.htm">DAK Pending P & C List</a>
					<%} %>
					
					
					</li>
						
						
						<li class="breadcrumb-item active"><%if(Action.equalsIgnoreCase("ConsolidatedReply")){ %>Consolidated Reply  <%}else if(Action.equalsIgnoreCase("ConsolidatedReplyEdit")){ %>Consolidated Reply Edit<%} %></li>
					</ol>
				</nav>
			</div>
		</div>
	</div>


<%
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>
	<div align="center">
		<div class="alert alert-danger" id="fail" role="alert">
			<%=ses1%>
		</div>
	</div>
	<%
	}
	if (ses != null) {
	%>
	<div align="center">
		<div class="alert alert-success" id="pass" role="alert">
			<%=ses%>
		</div>
	</div>
	<%
	}
	%>
	
		
	<div class="container-fluid datatables" id="main-div">
		<!-- Dak Present Check Loop Start  -->
		<%if(DakDetailsList!=null && DakDetailsList.size()>0){
		for(Object[] obj:DakDetailsList){
		
		%>
		<div class="commonDivofPnCReply">

 <!---------------------------------------- All Marked Employees Reply Display Start ------------------------------------------>    
		<div class="col-md-7" style="margin-top:-28px;">
	
		
		<div class="card MarkedReplyDispCard"  >
		      <div class="card-body MarkedReplyDispCardBody"  >
         <div class="row AllReplysRow" style="margin-bottom: 10px;">
		
		 <div class="col-md-12 MarkedEmpReplysGroup" id="MarkedReplyDetails"  align="center">	
		
		 	<h6 style="font-weight:bold;padding:10px;">Marked Employees Reply</h6>
		
		 	<form action="#" method="post" id="formId" autocomplete="off"  >
		 	   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	   	<div class="MarkedEmployeesReply" align="center" style="margin-top:-4px;">
		 	 <%
		 	  if(obj[11]!=null && Integer.parseInt(obj[11].toString()) > 0 ){
		 	   if(MarkedReplysDetsiledList!=null && MarkedReplysDetsiledList.size()>0){
		 		  int count = 0;
				  /** Multiple Replys loop start **/
		 		  for(Object[] replyObj :MarkedReplysDetsiledList){ 
		 			   count++;
		 			 String repliedPersonName = null;
		 			 String repliedPersonDesig = null;
		 			String repliedData = null;
		 			 if(replyObj[6]!=null){  repliedPersonName = replyObj[6].toString();}else{repliedPersonName = "--";}
		 			 if(replyObj[7]!=null){  repliedPersonDesig = replyObj[7].toString();}else{repliedPersonDesig = "--";}
		 			 if(replyObj[2]!=null){ 
		 				 if(replyObj[2].toString().length()>150){
		 					repliedData = replyObj[2].toString().substring(0, 150);
		 				 }else{
		 					repliedData = replyObj[2].toString();
		 				 }
		 				 
		 			 }else{repliedData = "--";}
		 	String DateTime=replyObj[5].toString();
		 	DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
	        Date date = inputFormat.parse(DateTime);
	        
	        // Define the desired output date format
	        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
	        String outputDateString = outputFormat.format(date);
		 	   %>
		 	   

				<div class="MarkedEmpsReplysBasedOnReplyId" style="min-width:100px;min-height:100px;">
				    <h4 class="RepliedPersonName" id="page-person-header"><%=count%>. <%=repliedPersonName%>,&nbsp;<%=repliedPersonDesig%>,&nbsp;<span style="color: black; font-size: 15px;"><%=outputDateString %></span></h4>
				   <%String IdData= "MarkerReply"+replyObj[0]; %>
				      <%if(Action.equalsIgnoreCase("ConsolidatedReply")){ %>
				    <button type="button"  class="btn btn-sm icon-btn replyCopyBtn" style="float:right!important;margin-left:10px;"  
				   id=<%=IdData %>
				    data-button-type="copyAndUncopyBtn" data-row-id=<%=replyObj[0]%> 
				     data-toggle="tooltip" data-placement="top" title= "Reply Copy" >
				     <img src="view/images/replyCopy.png"  /></button> 
				     <% }%>
				 
				   <%long DakAssignReplyIdCount = 0;
				   DakAssignReplyIdCount = Long.parseLong(replyObj[11].toString()); //only if any facilitator replied
				   if(DakAssignReplyIdCount>0 ){%>
				   <button type="button"  style="float:right;"  type="button" class="btn btn-sm icon-btn"
				    name="FcilitatorsReplyOfSpecificMarker" data-toggle="tooltip" data-placement="top" title="Facilitator Reply"
				    onclick="FacilitatorsReplyOfSpecificMarker(<%=replyObj[12]%>,<%=replyObj[8]%>,<%=EmpId%>)"  ><img src="view/images/facilitatorReply.png"  /></button>
				    <% }%>
				   
				    
				    <div class="clearfix"></div>
				    <div class="row replyDataOfMEmp">
				    <div class="form-group groupReplyData">
				      <div class="col-md-12 replymarkedemps-div" contenteditable="false">
				      <%=repliedData%>
				      <%if(replyObj[2].toString().length()>150){ %>
				      <button type="button" class="viewmore-btn-click" name="sub" 
				      value="Modify" onclick="replyViewMoreModal(<%=replyObj[0]%>)">...(View More)</button><!-- function & modal present in commanModal jsp -->
				      <!-- <b><span style="color:#1176ab;font-size: 14px;">......</span></b> -->
				      <%} %>
				      </div>
				    </div>
			    <div class="form-group groupReplyAttachsOfMEmps">
				      <div class="col-md-6 replyMarkEmpAttachTbl-div">
				         <table class="table table-hover table-striped table-condensed info shadow-nohover ReplyAttachMarkEmpTable">
				            <!-- looped attachments start -->
				           
				        <% if(replyObj[9] != null && (Integer.parseInt(replyObj[9].toString())) > 0){ %>
				 
						 <%if(MarkedReplyAttachmentList!=null && MarkedReplyAttachmentList.size()>0){%>
					
				        	 <%for(Object[] attachObj : MarkedReplyAttachmentList){%>
				        	 	
							  <%
							  if (replyObj[0].toString().equalsIgnoreCase(attachObj[1].toString())) { %>
							   <!-- Your code here -->
							<tr>
									<td style="text-align: left;">
									<input type="hidden" id="ReplyIframeData" name="markerdownloadbtn">
										<button type="button" class="btn btn-sm replyAttachWithin-btn" name="dakReplyDownloadBtn" value="<%=attachObj[0]%>"  onclick="IframepdfMarkerReply(<%=attachObj[0]%>,1)" data-toggle="tooltip" data-placement="top" title="Download">
											<%=attachObj[4]%>
										</button>
									</td>
								</tr>
					          <% } %>

					   <%} }%>
					     <%}else{%>
					     	<tr><td style="text-align: center;">No Attachments</td></tr>
					     <%} %>
                                <!-- looped attachments end-->
                          </table>
                          </div>
                          </div>
                          </div>
                          </div>
                          	<br>
				<%} %>
				<%} %>
			 <%}else{ %>
		
		 <img src="view/images/infoicon.png"  style="cursor: none; "/>&nbsp;&nbsp;<span style="color:#2196F3">None of the Distributed Employees have replied...</span>
		 
		 
		 <%} %>
				</div>	
		
					
			</form>
		 </div>	
		

			   </div>
			</div>
		</div>
		
		</div>
		
<!---------------------------------------- All Marked Employees Reply Display End ------------------------------------------>    
		
		
<!---------------------------------------- Consolidated Reply from P&C DO Start ------------------------------------------>
 	   <div class="col-md-5" style="margin-top:-22px;margin-left: -25px;">
			 <form action="#"  id="consolidatedReplyByRTMDO" enctype="multipart/form-data" method="post">
			<div class="card RTMDOReplycard"  style="margin-right:-4%;"><!-- RTMDOReplycard div start -->
			 <div class="row RTMDOReplycardBody" style="margin-bottom: 10px;margin-left:4px;"><!-- scrollable div start -->
			  
  	             	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" name="<%if(Action.equalsIgnoreCase("ConsolidatedReplyEdit")){ %>redirValForConsoReplyEdit<%}else{ %>redirValForConsoReplyAdd<%} %>" value="<%=RedirectVal %>" />

<input type="hidden" name="redirview" value="<%=redirview %>" />

<input type="hidden" name="redirval" value="<%=RedirVal %>" />
  	         	
  	         	<%
  	         	System.out.println("fromDateData:"+frmDt);
  	         	System.out.println("toDateData:"+toDt);
  	         	%>
  	         		<input type="hidden" name="DakIdFrPnCReply" value="<%=DakId%>" /><!-- commmon for edit and add -->
  	         		<input type="hidden" name="fromDateData" value="<%=frmDt%>" />
  	         		<input type="hidden" name="toDateData" value="<%=toDt%>" />
  	         		
			   <div class="col-md-12" align="left" style="margin-left: 0px;width:100%;">
			
						<label style="font-size:14px;">Reply :</label>
                         <%String RepliedDataFrEdit = "--";
                         String ReturnCommt = "--";
                         String ApprovedCommt = "--";
                         String EditType = null;
                         if(consolidatedReplyDataForEdit!=null && consolidatedReplyDataForEdit.size()>0) {
						   for(Object[] replydataobj:consolidatedReplyDataForEdit) {
						     if(replydataobj[3]!=null){
						    	 RepliedDataFrEdit = replydataobj[3].toString();
						    	 
						    	 if(replydataobj[10]!=null){
						    	 ReturnCommt= replydataobj[10].toString();
						    	 }
						    	
						    	 if(replydataobj[9]!=null){
						    		 ApprovedCommt= replydataobj[9].toString();
							     }
						    	 
		 if(replydataobj[4]!=null && replydataobj[4].toString().equalsIgnoreCase("D") && 
				 replydataobj[8]!=null && (replydataobj[8].toString().equalsIgnoreCase("RP") || replydataobj[8].toString().equalsIgnoreCase("FP"))){
						    		 EditType = "ReturnedCREdit";
		 }
						    	 
                                 if(replydataobj[8]!=null && replydataobj[8].toString().equalsIgnoreCase("AP")){
                                	 EditType = "ApproveWithCommtCREdit";
						    	 }
						    	 
						     }
						  } //for loop close
						 } //if condition close
						  %>
						 <textarea class="form-control PnCRepliedTextClass" required="required" name="PnCRepliedText" id="PnCRepliedTextt" style="width:750px;%;height: 300px;" maxlength="4000"  oninput="checkCharacterLimit()"><%if(Action!=null && Action.equalsIgnoreCase("ConsolidatedReplyEdit")) {%><%=RepliedDataFrEdit%><%}%></textarea>
				
				  <%if(Action!=null && Action.equalsIgnoreCase("ConsolidatedReplyEdit")) {%>
				  
				    <%if(EditType!=null && EditType.equalsIgnoreCase("ReturnedCREdit") ){ %>
				      <label>Return  Commt :</label>
				      <textarea class="form-control PnCReturnCommt" readonly="readonly" name="PnCReturnCommt" id="PnCReturnCommt" style="width:510px;%;height: 50px;" maxlength="4000" ><%=ReturnCommt%></textarea>
				   <%}%>
				    
				    <%if(EditType!=null && EditType.equalsIgnoreCase("ApproveWithCommtCREdit")){ %>
				   <label>Approved  Commt :</label>
				   <textarea class="form-control PnCReturnCommt" readonly="readonly" name="PnCApprovedCommt" id="PnCApprovedCommt" style="width:510px;%;height: 50px;" maxlength="4000" ><%=ApprovedCommt%></textarea>
				<%} %>
				
				<%} %>
				<br>
	
					    <div style="display: flex;">
				<!------------------------- new file add start --------------------------------->
  <div class="row" style="width:264px!important;">
    <div style="flex: 1;">
	  <table class="AttachNewFilesOfPnC">
		<tr><td></td>
		<td align="right"><button type="button" class="tr_clone_rtmdoAddClone btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
		</tr>
		<tr class="tr_rtmdo_clone">
		<td><input class="form-control" type="file" name="PnCRepliedAttachments"  id="dakrtmdodocuments" accept="*/*" 
			  <%if(Action!=null && Action.equalsIgnoreCase("ConsolidatedReplyEdit")) {%>style="width:220px;"<%}%> ></td>
		<td><button type="button" class="tr_clone_rtmdoSubClone btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
		</tr>			  	      				
	  </table>
	 </div>
   </div>
	    <!------------------------------------- new file add end ------------------------->
			  	    
			  	    
			  	     <!--copy files attached & delete those copy Start-->
			  	      <%if(Action!=null && !Action.equalsIgnoreCase("ConsolidatedReplyEdit")) {%>
  	      			<div class="col-md-5 " style="float:left;margin-top:-20px;">
  	      				<br>
  	      	       <table class="MarkerReplyCopyAttachtable" style="border:none;max-width: 300px !important;overflow-x: auto; " >
					  <tbody id="MarkerReplyCopyAttachDataFill">
					  </tbody>
					</table>
  	      			</div>
  	      			<!--copy files attached & delete those copy End-->
			  	     <%} %>
			  	     
				 
			  	     
			  	     <%if(Action!=null && Action.equalsIgnoreCase("ConsolidatedReplyEdit") && consolidatedAttachDataForEdit!=null && consolidatedAttachDataForEdit.size()>0) {%>
			  	  
			  	       <div style="padding-left:25px;" class="ReplyAttachOfPNCDOForEdit">
			  	    	  <table class="ReplyAttachPnCReplyTableEdit" style="max-width:40px!important;border:none;" >
				           
				            
						    <%for(Object[] replyattachobj:consolidatedAttachDataForEdit) {%>
						    	
							   <tr>
							   <td style="text-align: left;width:6px;">
							   <button type="submit" id="PnCReplyEditAttachDelete" class="deletePnCBtn" name="dakPnCReplyAttachIdFrDelete" 
										formaction="PnCReplyAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;background-color:white;" 
										 onclick="return confirm('Are you sure you want to delete this attachment?')"  value="<%=replyattachobj[0]%>#<%=replyattachobj[1]%>"  ><img alt="attach" src="view/images/delete.png"></button>
									
							   </td>
									<td style="text-align: left;" class="wrap">
								     	<input type="hidden" id="PCReplyIframe" name="pncReplyDownloadBtn">
										
										<button type="button" class="btn btn-sm replyAttachWithin-btn" name="dakPnCReplyDownloadBtn" value="<%=replyattachobj[0]%>" onclick="IframepdfForPnCAttachedDocs(<%=replyattachobj[0]%>,1)" data-toggle="tooltip" data-placement="top" title="Download">
											<%=replyattachobj[4]%>
										</button>
										</td>
								</tr>
						     
						  <%}%>
						 </table>
						   </div>
			  	    <%}%>
			  	  
					</div>
					
  
			  	    <!-- Director Approval Required or not START -->
			  	    <br>
			  	  <div class="row">
			  	  <div class="col-md-10 DirApproval"  style="display: flex; align-items: center;">
			  	    <label style="margin-left: 3px;font-weight:bold;font-size: 14px;color: black;">Director Approval&nbsp;&nbsp;&nbsp;: </label>
									&nbsp;&nbsp;&nbsp;
									 <div class="col-md-6">
                                        <select class="form-control selectpicker " id="DirectorApproval" 
                                        style="width:50%!important;" required="required" name="dirApprovalValFrmPNC" >
                                        <%System.out.println("Director Approvsl Dataa@@@@"+obj[13]); %>
											<option <%if(obj[13]!=null && obj[13].toString().equalsIgnoreCase("R")){ %>selected="selected"<%} %> value="R">Required</option>
											<option <%if(obj[13]!=null && obj[13].toString().equalsIgnoreCase("N")){ %>selected="selected"<%} %> value="N">Not Required</option>
										</select>
										</div>
									</div>
				  </div>
				 <!-- Director Approval Required or not END -->	  
			  	     <br>
				</div>	
           <!-------------------------------------------------- Submit buttons START --------------------------------------------->				
				<div class="col-md-12"  align="center">
  	      		   <!-- for Consolidated Reply Add Submit-->
  	      		   <input type="hidden" id="DakIdForRTMDO" name="DakIdForRTMDOReply" value="<%=DakId%>" /><!-- COMMON HIDDEN -->
  	      		   <%if(Action.equalsIgnoreCase("ConsolidatedReply")){ %>
  	      		      <input type="hidden" id="AttachsFromDakMarker" name="AttachmentsFileNames" value="" />
  	      		  
  	      		
  	      		   
  	      		   <button type="button" formaction="ConsolidatedReplySubmit.htm"  class="btn btn-primary btn-sm submit " id="consolidatedReplyAddAction"   onclick="return PnCReplyValidation()"  >Submit</button>
  	      		   <%}else if(Action.equalsIgnoreCase("ConsolidatedReplyEdit")){ %>
  	      		    <%	String PnCReplyId=(String)request.getAttribute("pncReplyId"); %>
  	      		      <!-- for Consolidated Reply Edit Submit -->
  	      		       <input type="hidden" id="DakIdForRTMDO" name="pncReplyIdForEdit" value="<%=PnCReplyId%>" />
  	      		     <button type="button"  formaction="ConsolidatedReplyEditSubmit.htm"  class="btn btn-primary btn-sm submit " id="consolidatedReplyEditAction"   onclick="return PnCEditReplyValidation()" >Update</button>
  	      		     
  	      		 <%} %>
				   <div style="margin-bottom: 20px;"></div><!-- just to give bottom space -->
			   </div>
          <!----------------------------------------------------- Submit buttons CLOSE --------------------------------------------->				   
			   </div><!-- scrollable div end -->
			</div><!-- RTMDOReplycard div end -->
			</form>
		</div>
<!------------------------------------------ Consolidated Reply Add and Edit from P&C DO End ------------------------------------------------------------->
	   
	   
		</div>
		<% } } %>
			<!-- Dak Present Check Loop Start  -->
</div>


</body>
    	      
  	      <script type="text/javascript">

var count=1;
$("table").on('click','.tr_clone_rtmdoAddClone' ,function() {
   var $tr = $('.tr_rtmdo_clone').last('.tr_rtmdo_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.tr_clone_rtmdoSubClone' ,function() {
	
var cl=$('.tr_rtmdo_clone').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.tr_rtmdo_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});
</script>


     <script type="text/javascript">
     //Initialize an empty array to store the uniqueDakAssignReplyAttach IDs
     var DakMarkerReplyAttachFiles = [];
     
     
 function PnCReplyValidation(){
	  $('#AttachsFromDakMarker').val('');
	 var isValidated = false;
	   var reply = document.getElementsByClassName("PnCRepliedTextClass")[0].value;
	if(reply.trim() == "") { 
  	isValidated = false;
  }else{
  	isValidated = true;
  }
  
  if (!isValidated) {
      event.preventDefault(); // Prevent form submission
      alert("Please Write a Reply!");
    
  
    } else {
    	// Loop through all elements with data-custom-name="MarkerAttachInsert"
 	   $('tr[data-custom-name="MarkerAttachInsert"]').each(function() {
 		   // Get the data-custom-value attribute value and add it to the array
            var AttachedFileNames = $(this).data('custom-value');
            DakMarkerReplyAttachFiles.push(AttachedFileNames);
 	   });

 	   // Set the value of the hidden input field as a comma-separated string
        $('#AttachsFromDakMarker').val(DakMarkerReplyAttachFiles.join(','));

    	
    	
    	var confirmation = confirm("Are you sure you want to submit this consolidated response?");
		if (confirmation) {
    	
    	// If user clicks OK, you can put any further actions here.
        var form = document.getElementById("consolidatedReplyByRTMDO");
      if (form) {
       var consolidatedReplyAddButton = document.getElementById("consolidatedReplyAddAction");
          if (consolidatedReplyAddButton) {
              var formactionValue = consolidatedReplyAddButton.getAttribute("formaction");
               // Now i have the value of formaction for the button with id "consolidatedReplyAddAction"
                console.log(formactionValue);
               // Set the form's action attribute to the formactionValue o submit form
               form.setAttribute("action", formactionValue);
                form.submit();
            }
       }
		}else{
			return false;
		}
    	
    }//else close
    }
</script>


     <script type="text/javascript">
 function PnCEditReplyValidation(){
	 var isValidated = false;
	   var reply = document.getElementsByClassName("PnCRepliedTextClass")[0].value;
	if(reply.trim() == "") { 
  	isValidated = false;
  }else{
  	isValidated = true;
  }
  
  if (!isValidated) {
      event.preventDefault(); // Prevent form submission
      alert("Please Write a Reply.");
    
  
    } else {
    	// If user clicks OK, you can put any further actions here.
    	var confirmation = confirm("Are you sure you want to update this consolidated response?");
		if (confirmation) {
    	
        var form = document.getElementById("consolidatedReplyByRTMDO");
      if (form) {
       var consolidatedReplyEditButton = document.getElementById("consolidatedReplyEditAction");
          if (consolidatedReplyEditButton) {
              var formactionValue = consolidatedReplyEditButton.getAttribute("formaction");
               // Now i have the value of formaction for the button with id "consolidatedReplyEditAction"
                console.log(formactionValue);
               // Set the form's action attribute to the formactionValue o submit form
               form.setAttribute("action", formactionValue);
                form.submit();
            }
       }
    	
		}else{
			return false;
		}
    }//else close
    }
</script>
<script>
function checkCharacterLimit() {
    var textarea = document.getElementById("PnCRepliedTextt");
    var maxlength = textarea.getAttribute("maxlength");
    var textLength = textarea.value.length;

    if (textLength > maxlength) {
        textarea.value = textarea.value.substring(0, maxlength); // Truncate the text to the maxlength
        alert("You have reached the maximum character limit.");
    }
}
</script>
<script>
	 function PnCReplyEditAttach(PnCReplyAttachmentId){
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
	
	</script>
	
	<script>
// object named appendedText to store the reply text associated with each DakAssignReplyId//This object allows us to keep track of the text appended for each button click.
var appendedText = {};


$(document).ready(function () {
	  // Event delegation for dynamically generated buttons
	  $(document).on("click", "button[data-button-type='copyAndUncopyBtn']", function (event) {
	    event.preventDefault();

	
    // Get the data-row-id of the clicked button
    var dakReplyId =  $(this).data("row-id"); // this is the unique Id which will identify particular DakAssignReplyId
    console.log(dakReplyId);
    
         console.log($( "#MarkerReply"+dakReplyId ).hasClass( "btn btn-sm icon-btn replyCopyBtn" ).toString());
  if($( "#MarkerReply"+dakReplyId ).hasClass( "btn btn-sm icon-btn replyCopyBtn" ).toString()=='true'){
        	
    	$( "#MarkerReply"+dakReplyId ).removeClass( "btn btn-sm icon-btn replyCopyBtn" ).addClass( "btn btn-sm icon-btn replyUnCopyBtn" );

        // Change the image source using your code
        $( "#MarkerReply"+dakReplyId ).find('img').attr('src', 'view/images/replyUnCopy.png');
        
        // Change the title
        $( "#MarkerReply"+dakReplyId ).attr('title', 'Reply Uncopy');
   
        copyMarkerReplyToPNCDOReply(dakReplyId);
    	
   }else if($( "#MarkerReply"+dakReplyId ).hasClass( "btn btn-sm icon-btn replyUnCopyBtn" ).toString()=='true'){
    	
    	$( "#MarkerReply"+dakReplyId ).removeClass( "btn btn-sm icon-btn replyUnCopyBtn" ).addClass( "btn btn-sm icon-btn replyCopyBtn" );
    	
    	// Change the image source using your code
        $( "#MarkerReply"+dakReplyId ).find('img').attr('src', 'view/images/replyCopy.png');
        
        // Change the title
        $( "#MarkerReply"+dakReplyId ).attr('title', 'Reply Copy');
        
        //all attachment(tr) with this id will be removed
        $('[id^="CopyMarkerAttachRow' + dakReplyId + '"]').remove(); 
        
        
  
        //retrieve the previously appended text from the appendedText object based on the DakAssignReplyId
        var appended = appendedText[dakReplyId];
        if (appended) {
          var currentText = $('.PnCRepliedTextClass').val();
          // Replace the current text with the text without the appended portion
          //removes only the text appended during the corresponding "Copy" action, leaving the rest of the text area intact.
          var newText = currentText.replace(appended, '');
          $('.PnCRepliedTextClass').val(newText);
          // Remove the appended text from the storage
          delete appendedText[dakReplyId];
        }
    	 
        }
  });
});
</script>

<script>
function copyMarkerReplyToPNCDOReply(dakReplyId){
	console.log(dakReplyId);
	 $.ajax({
	        type: "GET",
	        url: "GetReplyViewMore.htm",
	        data: {
	        	dakreplyid: dakReplyId
	        },
	        dataType: 'json',
	        success: function(result) {
	        	 if (result != null) {
 	            	 for (var i = 0; i < result.length; i++) {
						    var data = result[i];
						    
						   var MarkerReply = data[1];
						    $('.PnCRepliedTextClass').val(function (i, val) {
						          appendedText[dakReplyId] = MarkerReply;
						          return val + MarkerReply;
						        });
						   
						   //DakCSWReplyAttachPreview
						   // Check if data[2] count i.e DakReplyAttachCount is more than 0
					          console.log(data[2]);
						   if (data[2] > 0) {
					        	  // Call a function and pass data[0] i.e DakReplyId
					              DakReplyAttachments(data[0]); 
					            }
				         
 	            	 }
	        	 }
	        },
	         error: function(xhr, status, error) {
	             console.error("AJAX request error:", status, error);
	         }
	 });
}



//Define the ReplyCopyAttachDel function
function ReplyCopyAttachDel(DakReplyAttachmentId) {
console.log(DakReplyAttachmentId);

// Check if an element with the specified class exists
if ($('.ReplyAttachRow' + DakReplyAttachmentId).length > 0) {
    $('.ReplyAttachRow' + DakReplyAttachmentId).remove();
} else {
    console.log('Element not found');
}
}

function DakReplyAttachments(DakReplyIdData) {
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
	        	
	          var ReplyAttachTbody = '';
	          for (var z = 0; z < resultData.length; z++) {
	            var row = resultData[z];
	            DakReplyAttachId = row[1];

	            ReplyAttachTbody += '<tr class="ReplyAttachRow' + row[0] + '" id="CopyMarkerAttachRow' + DakReplyAttachId + '" data-custom-name="MarkerAttachInsert" data-custom-value="' + row[4] + '"> ';
	            ReplyAttachTbody += '    <td><button type="button" style="padding: 0; background: none;" onclick="ReplyCopyAttachDel(' + row[0] + ')" id="ReplyCopyAttachDelete' + row[0] + '" class="btn btn-sm icon-btn" data-toggle="tooltip" data-placement="top" title="Delete"><img alt="attach" src="view/images/delete.png"></button></td>';
	  	        ReplyAttachTbody += '  <td class="fixed-width-td" style="text-align: left;">';
	            ReplyAttachTbody += '    <form action="#" id="ReplyFormCopy">';
	            ReplyAttachTbody += '      <input type="hidden" id="ReplyIframeData" name="markerdownloadbtn">';
	            ReplyAttachTbody += '      <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply" value="' + row[0] + '" onclick="IframepdfMarkerReply(' + row[0] + ',0)" data-toggle="tooltip" data-placement="top" title="Download">' + row[4] + '</button>';
	            ReplyAttachTbody += '    </form>';
	            ReplyAttachTbody += '  </td>';
	            ReplyAttachTbody += '</tr> ';

	          }

	          $('#MarkerReplyCopyAttachDataFill').append(ReplyAttachTbody);
	        }
	      }
	    },
	    error: function(xhr, textStatus, errorThrown) {
	      // Handle error
	    }
	  });
	}


</script>
</html>