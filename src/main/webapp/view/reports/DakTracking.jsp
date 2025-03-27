<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.vts.dms.DmsFileUtils"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.dms.dak.model.DakMain"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,java.text.SimpleDateFormat,com.vts.dms.dak.model.DakAttachment"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Tracking</title>



<style>
.table .font {
	font-size: 13px;
	font-weight: 700 !important;
	
}

.timeline {
    position: relative;
    padding: 10px;
    margin: 0 auto;
    overflow: hidden;
    color: #ffffff;
}

.timeline:after {
    content: "";
    position: absolute;
    top: 0;
    left: 50%;
    margin-left: -1px;
    border-right: 2px dashed #c4d2e2;
    height: 100%;
    display: block;
}

.timeline-row {
    padding-left: 50%;
    position: relative;
    margin-bottom: 30px;
}

.timeline-row .timeline-time {
    position: absolute;
    right: 50%;
    top: 9px;
    text-align: right;
    margin-right: 20px;
    color: #000000;
    font-size: 1.5rem;
}

.timeline-row .timeline-time small {
    display: block;
    font-size: .8rem;
    color: #8796af;
}

.timeline-row .timeline-content {
    position: relative;
    padding: 0px;
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    border-radius: 10px;
}

.timeline-row .timeline-content:after {
    content: "";
    position: absolute;
    top: 8px;
    height: 3px;
    width: 40px;
}

.timeline-row .timeline-content:before {
    content: "";
    position: absolute;
    top: 8px;
    right: -50px;
    width: 20px;
    height: 20px;
    -webkit-border-radius: 100px;
    -moz-border-radius: 100px;
    border-radius: 100px;
    z-index: 100;
    background: #ffffff;
    box-shadow: 0px 0px 10px 5px #00000021;
    border: 2px solid #c4d2e2; 
}

.timeline-row .timeline-content h4 {
    margin: 0 0 20px 0;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    line-height: 150%;
}

.timeline-row .timeline-content p {
    margin-bottom: 0px;
    line-height: 150%;
}

.timeline-row .timeline-content i {
    font-size: 2rem;
    color: #ffffff;
    line-height: 100%;
    padding: 10px;
    display: inline-block;
}

.timeline-row .timeline-content .thumbs {
    margin-bottom: 20px;
}

.timeline-row .timeline-content .thumbs img {
    margin-bottom: 10px;
}


/*left side triangle arrow  styles*/
.timeline-row:nth-child(even) .timeline-content:after {
    right: -49px;
    border-left: 18px solid black;
    border-top: 10px solid transparent;
    border-bottom: 10px solid transparent;
}

/*right side triangle arrow  styles*/
.timeline-row:nth-child(odd) .timeline-content:after {
    left: -48px;
    border-right: 18px solid black;
    border-top: 10px solid transparent;
    border-bottom: 10px solid transparent;
}

.timeline-row:nth-child(odd) .timeline-content:before {
    left: -50px;
    right: initial;
}

.timeline-row:nth-child(even) {
    padding-left: 0;
    padding-right: 50%;
}

.timeline-row:nth-child(even) .timeline-time {
    right: auto;
    left: 50%;
    text-align: left;
    margin-right: 0;
    margin-left: 20px;
}

/*right side rectangle box styles*/
.timeline-row:nth-child(odd) .timeline-content {

   /*  background-color: #ff5000; */
    /* Fallback Color */
  /*   background-image: -webkit-gradient(linear, left top, left bottom, from(#fc6d4c), to(#ff5000)); */
    /* Saf4+, Chrome */
  /*   background-image: -webkit-linear-gradient(top, #fc6d4c, #ff5000); */
    /* Chrome 10+, Saf5.1+, iOS 5+ */
  /*   background-image: -moz-linear-gradient(top, #fc6d4c, #ff5000); */
    /* FF3.6 */
   /*  background-image: -ms-linear-gradient(top, #fc6d4c, #ff5000); */
    /* IE10 */
  /*   background-image: -o-linear-gradient(top, #fc6d4c, #ff5000); */
    /* Opera 11.10+ */
  /*   background-image: linear-gradient(top, #fc6d4c, #ff5000); */
    margin-left: 40px;
    text-align: left;
     margin-right: 65px;
}

/*left side rectangle box styles*/
.timeline-row:nth-child(even) .timeline-content {
   /*  background-color: #5a99ee; */
    /* Fallback Color */
  /*   background-image: -webkit-gradient(linear, left top, left bottom, from(#1379bb), to(#5a99ee)); */
    /* Saf4+, Chrome */
   /*  background-image: -webkit-linear-gradient(top, #1379bb, #5a99ee); */
    /* Chrome 10+, Saf5.1+, iOS 5+ */
   /*  background-image: -moz-linear-gradient(top, #1379bb, #5a99ee); */
    /* FF3.6 */
  /*   background-image: -ms-linear-gradient(top, #1379bb, #5a99ee); */
    /* IE10 */
   /*  background-image: -o-linear-gradient(top, #1379bb, #5a99ee); */
    /* Opera 11.10+ */
   /*  background-image: linear-gradient(top, #1379bb, #5a99ee); */
    margin-right: 40px;
    margin-left: 65px;
    text-align: left;
}


@media (max-width: 767px) {
    .timeline {
        padding: 15px 10px;
    }
    .timeline:after {
        left: 28px;
    }
    .timeline .timeline-row {
        padding-left: 0;
        margin-bottom: 16px;
    }
    .timeline .timeline-row .timeline-time {
        position: relative;
        right: auto;
        top: 0;
        text-align: left;
        margin: 0 0 6px 56px;
    }
    .timeline .timeline-row .timeline-time strong {
        display: inline-block;
        margin-right: 10px;
    }
    .timeline .timeline-row .timeline-icon {
        top: 52px;
        left: -2px;
        margin-left: 0;
    }
    .timeline .timeline-row .timeline-content {
        padding: 15px;
        margin-left: 56px;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        position: relative;
    }
    .timeline .timeline-row .timeline-content:after {
        right: auto;
        left: -39px;
        top: 32px;
    }
    .timeline .timeline-row:nth-child(even) {
        padding-right: 0;
    }
    .timeline .timeline-row:nth-child(even) .timeline-time {
        position: relative;
        right: auto;
        left: auto;
        top: 0;
        text-align: left;
        margin: 0 0 6px 56px;
    }
    .timeline .timeline-row:nth-child(even) .timeline-content {
        margin-right: 0;
        margin-left: 55px;
    }
    .timeline .timeline-row:nth-child(even) .timeline-content:after {
        right: auto;
        left: -39px;
        top: 32px;
        border-right: 18px solid #5a99ee;
        border-left: inherit;
    }
    .timeline.animated .timeline-row:nth-child(even) .timeline-content {
        left: 20px;
    }
    .timeline.animated .timeline-row.active:nth-child(even) .timeline-content {
        left: 0;
    }
}


.timeline-content h6 {
    padding: 10px;
    margin: 0;
    color: #fff;
    font-size: 13px;
    text-transform: uppercase;
    letter-spacing: 0px;
    border-radius: 6px 6px 0 0;
    position: relative;
    font-family: 'Muli',sans-serif;
   
}

.timeline-content ol{
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
  background-color: #f0f2f5;
  color: black;
  min-height:70px;
}


.tooltip {
   position: relative;
   display: inline-block;
}
.tooltip .tooltiptext {
   visibility: hidden;
   background-color: rosybrown;
   color: white;
   border-radius: 7px;
   padding: 5px 10px;
   position: absolute;
   z-index: 1;
}
.tooltip:hover .tooltiptext {
   visibility: visible;
}


</style>

</head>
<body>

 <% SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
    List<Object[]> dakTrackingData=(List<Object[]>)request.getAttribute("DakTrackingListData");
    List<Object[]> holidayDateList=(List<Object[]>)request.getAttribute("holidayDateList");
	SimpleDateFormat month=new SimpleDateFormat("MMM");
	SimpleDateFormat day=new SimpleDateFormat("dd");
	SimpleDateFormat year=new SimpleDateFormat("yyyy");
	SimpleDateFormat time=new SimpleDateFormat("HH:mm");
	
    %>
<% 
String RedirFromCommon = (String) request.getAttribute("redirectVal"); 
//System.out.println("sdfsd@@" + RedirFromCommon);
%>
<% if (RedirFromCommon == null || RedirFromCommon.isEmpty()) { %>
<jsp:include page="../static/header.jsp"></jsp:include>
<% }else{ %>

	<jsp:include page="../static/dependancy.jsp"></jsp:include>
<% } %>
<jsp:include page="../static/commonModals.jsp"></jsp:include>

<div class="card-header page-top">
		<div class="row">
		 <form action="DakTrackingPrint.htm" target="_blank">
			<div class="<% if (RedirFromCommon == null || RedirFromCommon.isEmpty()) { %>col-md-5<%}else{ %>col-md-7<%} %> heading-breadcrumb">
				<h5 style="font-weight: 700 !important;width:600px!important;">DAK TRACKING&nbsp;&nbsp;&nbsp;<%if(dakTrackingData!=null && dakTrackingData.size()>0){ %><span style="font-size: 15px;">(
				DAK Id: <%=dakTrackingData.get(0)[1] %>,&nbsp;Source: <%=dakTrackingData.get(0)[19] %>)<%-- ,&nbsp;Ref No: <%=dakTrackingData.get(0)[2] %><%} %> --%></span>
		      <button type="submit" name="DakIdFrPrint" value="<%=dakTrackingData.get(0)[0] %>" class="btn btn-sm icon-btn TrackingPrint" ><img alt="mark" src="view/images/trackingPrint.png"></button> 
		       </h5> 
		     <%} %>
		</div>
		 </form>	
			<% if (RedirFromCommon == null || RedirFromCommon.isEmpty()) { %>
			<div class="col-md-7" >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item" aria-current="page"><a href="ReportsDashBoard.htm"><i class="fa fa-file" ></i> Reports</a></li>
				     <li class="breadcrumb-item" aria-current="page"><a href="DakStatusList.htm"><i class="fa fa-file" ></i> DAK Status List</a></li>
				    <li class="breadcrumb-item active">DAK Tracking </li>
				  </ol>
				</nav>
			</div>	
			<%} %>		
		</div>
		</div>
			             



<div class="row datatables">
	<div class="col-md-12">
 		<div class="card shadow-nohover" >

			<div class="card-body" style="margin-top:-40px;"> 
  			
 				
 				<hr>
 				
 				<%
 				if(dakTrackingData!=null && dakTrackingData.size()>0){
 					String Status = null;
 				for(Object[] obj:dakTrackingData){ 
 					
 					if (obj[4] != null) { 
 			            Status = obj[4].toString().trim();
 			            LocalDate InitiatedDate = null;
 			            LocalDate DistributedDate = null;
 			            LocalDate AckDate = null;
 			            LocalDate ReplyDate = null;
 			            LocalDate PandCDate = null;
 			            LocalDate ApprovedDate = null;
 			            LocalDate ForwardedDate = null;
 			            LocalDate ClosedDate = null;
 			            SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

 			            if (obj[6] != null) {
 			                InitiatedDate = LocalDate.parse(obj[6].toString().split(" ")[0]);
 			            }

 			            if (obj[7] != null) {
 			                DistributedDate = LocalDate.parse(obj[7].toString().split(" ")[0]);
 			            }

 			            if (obj[17] != null) {
 			                AckDate = LocalDate.parse(obj[17].toString().split(" ")[0]);
 			            }

 			            if (obj[18] != null) {
 			                ReplyDate = LocalDate.parse(obj[18].toString().split(" ")[0]);
 			            }

 			            if (obj[12] != null) {
 			                PandCDate = LocalDate.parse(obj[12].toString().split(" ")[0]);
 			            }

 			            if (obj[16] != null) {
 			                ApprovedDate = LocalDate.parse(obj[16].toString().split(" ")[0]);
 			            }

 			            if (obj[14] != null) {
 			                ClosedDate = LocalDate.parse(obj[14].toString().split(" ")[0]);
 			            }
 			            
 			            if (obj[23] != null) {
 			            	ForwardedDate = LocalDate.parse(obj[23].toString().split(" ")[0]);
 			            }

 			            long ShowDistributedPlace = 0L, ShowAckPlace = 0L, ShowReplyPlace = 0L, ShowPCPlace = 0L, ShowForwardPlace = 0L, ShowApprovedPlace = 0L, ShowClosedPlace = 0L;
						
 			            long DistributedNotificationShowingPlace=0L,AckNotificationShowingPlace=0L,ReplyNotificationShowingPlace=0L,PandCNotificationShowingPlace=0L,ForwardNotificationShowingPlace=0L,ApprovedNotificationShowingPlace=0L,ClosedNotificationShowingPlace=0L;
 			            
 			            if (InitiatedDate != null && DistributedDate != null) {
 			                ShowDistributedPlace = DmsFileUtils.countWeekdays(InitiatedDate, DistributedDate,holidayDateList);
 			            }
 			            
 			            
 			            if (InitiatedDate != null && DistributedDate == null) {
 			            	DistributedNotificationShowingPlace = DmsFileUtils.countWeekdays(InitiatedDate, java.time.LocalDate.now(),holidayDateList);
 			            }
 			            
 			            

 			            if (DistributedDate != null && AckDate != null) {
 			                ShowAckPlace = DmsFileUtils.countWeekdays(DistributedDate, AckDate,holidayDateList);
 			            }
 			            
 			            
 			            if (DistributedDate != null && AckDate == null) {
 			            	AckNotificationShowingPlace = DmsFileUtils.countWeekdays(DistributedDate, java.time.LocalDate.now(),holidayDateList);
 			            }

 			            
 			            if (AckDate != null && ReplyDate != null) {
 			                ShowReplyPlace = DmsFileUtils.countWeekdays(AckDate, ReplyDate,holidayDateList);
 			            }
 			            
 			            if (AckDate != null && ReplyDate == null) {
 			            	
 			            	ReplyNotificationShowingPlace = DmsFileUtils.countWeekdays(AckDate, java.time.LocalDate.now(),holidayDateList);
 			            }
 			            
 			            

 			            if (ReplyDate != null && PandCDate != null) {
 			                ShowPCPlace = DmsFileUtils.countWeekdays(ReplyDate, PandCDate,holidayDateList);
 			            }
 			            
 			            if (ReplyDate != null && PandCDate == null) {
 			            	PandCNotificationShowingPlace = DmsFileUtils.countWeekdays(ReplyDate, java.time.LocalDate.now(),holidayDateList);
 			            	System.out.println("fourth");
 			            }

 			            
 			            
 			            if (PandCDate != null && ForwardedDate != null) {
 			            	ShowForwardPlace = DmsFileUtils.countWeekdays(PandCDate, ForwardedDate,holidayDateList);
 			            }
 			            
 			            
 			            if (PandCDate != null && ForwardedDate == null && ApprovedDate==null && ClosedDate == null) {
 			            	ForwardNotificationShowingPlace = DmsFileUtils.countWeekdays(PandCDate, java.time.LocalDate.now(),holidayDateList);
 			            	System.out.println("fifth");
 			            }
 			            
 			            

 			           if (ApprovedDate != null && ClosedDate != null) {
			                ShowClosedPlace = DmsFileUtils.countWeekdays(ApprovedDate, ClosedDate,holidayDateList);
			            }
 			           
 			           
 			           if (ApprovedDate != null && ClosedDate == null) {
 			        	  ClosedNotificationShowingPlace = DmsFileUtils.countWeekdays(ApprovedDate, java.time.LocalDate.now(),holidayDateList);
 			        	 System.out.println("Sixth");
			            }
 			          
 			            if ( ForwardedDate!= null && ApprovedDate != null) {
 			                ShowApprovedPlace = DmsFileUtils.countWeekdays(ForwardedDate, ApprovedDate,holidayDateList);
 			            }
 			            
 			            
 			            if ( ForwardedDate!= null && ApprovedDate == null && ClosedDate==null) {
 			            	ApprovedNotificationShowingPlace = DmsFileUtils.countWeekdays(ForwardedDate, java.time.LocalDate.now(),holidayDateList);
 			            	System.out.println("Seventh");
 			            }
 			            
 			          // System.out.println("NotificationShowingPlace" + NotificationShowingPlace);
 			            

 			           LocalDate startDate = LocalDate.of(2024, 7, 25);
 			           LocalDate endDate = LocalDate.of(2024, 7, 25);
 			           long weekdays = DmsFileUtils.countWeekdays(startDate, endDate,holidayDateList);
 					    %>
 			<div class="timeline">
 			<form action="#">
 			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 			<input type="hidden" id="createdBy" value="<%=obj[5]%>">
 			<input type="hidden" id="RepliedByPAndC" value="<%=obj[11]%>">
 			<input type="hidden" id="ApprovedBy" value="<%=obj[15]%>">
 			<input type="hidden" id="ClosedByName" value="<%=obj[13]%>">
 			<input type="hidden" id="dakId" value="<%=obj[0]%>">
 			<input type="hidden" name="viewfrom" value="DakTracking">
					 <div class="timeline-row">
					 
						<div class="timeline-time">
						<%if(obj[6]!=null){
							  DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                              Date date = inputFormat.parse(obj[6].toString());
        
					        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
					        String outputDateString = outputFormat.format(date);%>
						
							<div class="form-inline" style="margin-top: -0.5rem;"><span style="font-size: 17px;font-weight: 600"><%=outputDateString %></span></div>
						<%} %>
						</div>
						<div class="timeline-dot fb-bg"></div>
							<div class="timeline-content" >
						<h6 style="background-color:#007bff;"> DAK Inititated By &nbsp;/&nbsp;<span id="InitiatedByFullName"></span>
						<span id="DAKPreviewBtn" style="float:right;">
						 <%--  <%if(obj[17]!=null && obj[17].toString().equalsIgnoreCase("Y")){ %> --%>
 									  	
                           <button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]%> value="<%=obj[0] %>"  
							formaction="DakReceivedView.htm" formmethod="post" formtarget="_blank"
							style="padding:0px;background-color: transparent;"
							 data-toggle="tooltip" data-placement="top" title="Preview"> 
 							<img alt="mark" src="view/images/preview3.png">
						 </button>
						</span>
						</h6> 
						</div>
					</div> 
					
	<%if("DD".equalsIgnoreCase(Status) || "DA".equalsIgnoreCase(Status) || "DR".equalsIgnoreCase(Status)|| "RM".equalsIgnoreCase(Status) || "RP".equalsIgnoreCase(Status) || "FP".equalsIgnoreCase(Status) || "AP".equalsIgnoreCase(Status)  || "DC".equalsIgnoreCase(Status)){ %>				
						<div class="timeline-row">
						<div class="timeline-time">
						<%if(obj[7]!=null){ 
						 DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                              Date date = inputFormat.parse(obj[7].toString());
        
					        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
					        String outputDateString = outputFormat.format(date);
					        %>
							<div class="form-inline" style="margin-top: -0.5rem;"><span style="font-size: 17px;font-weight: 600"><%=outputDateString %></span> 
							&nbsp;(&nbsp;<span style="color: #b91cd6;"><%if(ShowDistributedPlace==0 || ShowDistributedPlace==1){%><%=ShowDistributedPlace %>&nbsp; Day<%}else{ %><%=ShowDistributedPlace %>&nbsp; Days<%} %></span>&nbsp;)
							</div>
							<%} %>
						</div>
						<div class="timeline-dot green-one-bg"></div>
							<div class="timeline-content" >
							<h6  style="background-color:#b91cd6;" >DAK Distributed By &nbsp;/&nbsp;<span id="DistributedByFullName"></span></h6>
						</div>
					</div>
<%} %>	

   <%if(obj[17]!=null || "DA".equalsIgnoreCase(Status) || "DR".equalsIgnoreCase(Status)  || "RM".equalsIgnoreCase(Status)   || "RP".equalsIgnoreCase(Status)|| "FP".equalsIgnoreCase(Status)  ||  "AP".equalsIgnoreCase(Status)  || "DC".equalsIgnoreCase(Status)){ %>								
      					
					<div class="timeline-row" style="margin-bottom: 0.7rem;">
						<div class="timeline-time">
						<%if(obj[17]!=null){
							 DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                             Date date = inputFormat.parse(obj[17].toString());
       
					        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
					        String outputDateString = outputFormat.format(date);
							
							%>
							<div class="form-inline" style="margin-top: -0.5rem;"><span style="font-size: 17px;font-weight: 600"><%=outputDateString %></span>
							&nbsp;(&nbsp;<span style="color: #F96302;"><%if(ShowAckPlace==0 || ShowAckPlace==1){%><%=ShowAckPlace %>&nbsp; Day<%}else{ %><%=ShowAckPlace %>&nbsp; Days<%} %></span>&nbsp;)
							</div>
							<%} %>
						</div>
						<div class="timeline-dot" style="background:grey"></div>
						<div class="timeline-content" >
							<h6 style="background-color:#F96302;" >DAK Acknowledged By Members</h6>
						    <ol id="AcknowledgedMembers" >
								<!-- It will get updated by ajax call -->
							</ol>
						</div>
					</div>
<%} %>						
     <%if(obj[18]!=null || "DR".equalsIgnoreCase(Status) || "RM".equalsIgnoreCase(Status) || "RP".equalsIgnoreCase(Status) || "FP".equalsIgnoreCase(Status)  || "AP".equalsIgnoreCase(Status)  || "DC".equalsIgnoreCase(Status)){ %>													
  					<div class="timeline-row" style="margin-bottom: 0.7rem;">
						<div class="timeline-time">
						<%if(obj[18]!=null){
							 DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                             Date date = inputFormat.parse(obj[18].toString());
       
					        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
					        String outputDateString = outputFormat.format(date);
							
							
							%>
							<div class="form-inline" style="margin-top: -0.5rem;"><span style="font-size: 17px;font-weight: 600"><%=outputDateString %></span>
							&nbsp;(&nbsp;<span style="color: #0aafa8;"><%if(ShowReplyPlace==0 || ShowReplyPlace==1){%><%=ShowReplyPlace %>&nbsp; Day<%}else{ %><%=ShowReplyPlace %>&nbsp; Days<%} %></span>&nbsp;)
							</div>
							<%} %>
						</div>
						<div class="timeline-dot green-one-bg"></div>
							<div class="timeline-content" >
							<h6 style="background-color:#0aafa8;" >DAK Replied By</h6>
							
						   <ol id="RepliedMembers" style="margin: 0px; padding: 6px">
								 <!-- It will get updated by ajax call -->
							</ol>
						</div>
					</div>
<%} %>					

<%-- <%if(obj[24]!=null && ("DD".equalsIgnoreCase(Status) || "DA".equalsIgnoreCase(Status) || "DR".equalsIgnoreCase(Status)|| "RM".equalsIgnoreCase(Status) || "RP".equalsIgnoreCase(Status) || "FP".equalsIgnoreCase(Status) || "AP".equalsIgnoreCase(Status)  || "DC".equalsIgnoreCase(Status))){ %>				
						<div class="timeline-row">
						<div class="timeline-time">
						<%System.out.println("obj[24]:"+obj[24]); %>
						<%if(obj[24]!=null){  
							System.out.println("inside");							
						 DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                              Date date = inputFormat.parse(obj[24].toString());
        
					        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
					        String outputDateString = outputFormat.format(date);
					        %>
							<div class="form-inline" style="margin-top: -0.5rem;"><span style="font-size: 17px;font-weight: 600"><%=outputDateString %></span></div>
							<%} System.out.println("outside");%>
							
						</div>
						<div class="timeline-dot green-one-bg"></div>
							<div class="timeline-content" >
							<h6  style="background-color:#b91cd6;" >DAK Assigned By &nbsp;/&nbsp;<span id="AssignedByFullName"></span></h6>
						</div>
					</div>
<%} %>	 --%>

<!--  Only if closing auhority is P  -->
<%if( obj[20]!=null && "P".equalsIgnoreCase(obj[20].toString()) && !"RM".equalsIgnoreCase(Status) && ("RP".equalsIgnoreCase(Status) || "FP".equalsIgnoreCase(Status)  || "AP".equalsIgnoreCase(Status)  || "DC".equalsIgnoreCase(Status) )){ %>													
  					<div class="timeline-row">
						<div class="timeline-time">
						<%if(obj[12]!=null){ 
							DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                            Date date = inputFormat.parse(obj[12].toString());
      
					        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
					        String outputDateString = outputFormat.format(date);
						%>
							<div class="form-inline" style="margin-top: -0.5rem;"><span style="font-size: 17px;font-weight: 600"><%=outputDateString %></span>
							&nbsp;(&nbsp;<span style="color: #641cd6;"><%if(ShowPCPlace==0 || ShowPCPlace==1){%><%=ShowPCPlace %>&nbsp; Day<%}else{ %><%=ShowPCPlace %>&nbsp; Days<%} %></span>&nbsp;)
							</div>
						<%} %>
						</div>
						
						
						<div class="timeline-dot green-one-bg"></div>
							<div class="timeline-content" >
							<h6 style="background-color:#641cd6;" >DAK Reply By P & C &nbsp;/&nbsp;<span id="RepliedByPandC"></span></h6>
						</div>
					
					</div>
<%} %>					


<!--Forward is only for p&cDO and that to if and only if director approval is required  -->
	<%if(obj[21]!=null && "R".equalsIgnoreCase(obj[21].toString()) &&  obj[20]!=null && "P".equalsIgnoreCase(obj[20].toString()) && ("FP".equalsIgnoreCase(Status) || "AP".equalsIgnoreCase(Status) || "DC".equalsIgnoreCase(Status))){%>
				<div class="timeline-row">
						<div class="timeline-time">
						<%if(obj[23]!=null){ 
							DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                            Date date = inputFormat.parse(obj[23].toString());
      
					        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
					        String outputDateString = outputFormat.format(date);
						%>
							<div class="form-inline" style="margin-top: -0.5rem;"><span style="font-size: 17px;font-weight: 600"><%=outputDateString %></span>
							&nbsp;(&nbsp;<span style="color: #a17627;"><%if(ShowForwardPlace==0 || ShowForwardPlace==1){%><%=ShowForwardPlace %>&nbsp; Day<%}else{ %><%=ShowForwardPlace %>&nbsp; Days<%} %></span>&nbsp;)
							</div>
						<%} %>
						</div>
						<div class="timeline-dot green-one-bg"></div>
							<div class="timeline-content" >
							<h6 style="background-color:#a17627;" >DAK FORWARDED BY &nbsp;/&nbsp;<span id="ForwardedByFullName"><%=obj[22].toString()%></span></h6>
						</div>
					</div>
	<%}%>

				<!--Approve is common for both p&cDO and Others close  -->
				<%if(obj[21]!=null && "R".equalsIgnoreCase(obj[21].toString()) && ("AP".equalsIgnoreCase(Status) || "DC".equalsIgnoreCase(Status))){ %>													
					<div class="timeline-row">
						<div class="timeline-time">
						<%if(obj[16]!=null){ 
							DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                            Date date = inputFormat.parse(obj[16].toString());
      
					        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
					        String outputDateString = outputFormat.format(date);
						%>
							<div class="form-inline" style="margin-top: -0.5rem;"><span style="font-size: 17px;font-weight: 600"><%=outputDateString %></span>
							&nbsp;(&nbsp;<span style="color: #a17627;"><%if(ShowApprovedPlace==0 || ShowApprovedPlace==1){%><%=ShowApprovedPlace %>&nbsp; Day<%}else{ %><%=ShowApprovedPlace %>&nbsp; Days<%} %></span>&nbsp;)
							</div>
						<%} %>
						</div>
						<div class="timeline-dot green-one-bg"></div>
							<div class="timeline-content" >
							<h6 style="background-color:#a17627;" >DAK APPROVED BY &nbsp;/&nbsp;<span id="ApprovedByFullName"></span></h6>
						</div>
					</div>
                 <%} %>		
                 
                 <%if("DC".equalsIgnoreCase(Status)){ %>													
					<div class="timeline-row">
						<div class="timeline-time">
						<%if(obj[14]!=null){
							DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
                            Date date = inputFormat.parse(obj[14].toString());
      
					        DateFormat outputFormat = new SimpleDateFormat("MMM dd, yyyy, h:mm a");
					        String outputDateString = outputFormat.format(date);
							%>
							<div class="form-inline" style="margin-top: -0.5rem;"><span style="font-size: 17px;font-weight: 600"><%=outputDateString %></span>
							&nbsp;(&nbsp;<span style="color: green;"><%if(ShowClosedPlace==0 || ShowClosedPlace==1){%><%=ShowClosedPlace %>&nbsp; Day<%}else{ %><%=ShowClosedPlace %>&nbsp; Days<%} %> </span>&nbsp;)
							</div>
						<%} %>
						</div>
						<div class="timeline-dot green-one-bg"></div>
							<div class="timeline-content" >
							<h6 style="background-color:green;" >DAK CLOSED BY &nbsp;/&nbsp;<span id="ClosedByFullName"></span></h6>
						</div>
					</div>
                 <%} %>					
				</form>
				</div>
				<div style="margin-left: 10%;">
				<%if(DistributedNotificationShowingPlace>0 && obj[8]!=null && Long.parseLong(obj[8].toString())==2){ %>
				<span style="font-size: 18px;"><b>Note : DAK Initiated And Still Not Distributed From <%=DistributedNotificationShowingPlace %> Days </b></span>
				<%} %>
				<%if(AckNotificationShowingPlace>0 && obj[8]!=null && Long.parseLong(obj[8].toString())==2){ %>
				<span style="font-size: 18px;"><b>Note : DAK Distributed And Still Not Acknowledged From <%=AckNotificationShowingPlace %> Days </b></span><br>
						<div>
						    <span id="AcknowledgeMembers" style="color: blue;">
								<!-- It will get updated by ajax call -->
							</span>
						</div>
				<%} %>
				<%if(ReplyNotificationShowingPlace>0 && obj[8]!=null && Long.parseLong(obj[8].toString())==2){ %>
				<span style="font-size: 18px;"><b>Note : DAK Acknowledged And Still Not Replied From <%=ReplyNotificationShowingPlace %> Days </b></span><br>
							<div>
						   <span id="ReplyMembers" style="color: blue;">
								 <!-- It will get updated by ajax call -->
							</span>
						</div>
				<%} %>
				<%if(PandCNotificationShowingPlace>0 && obj[8]!=null && Long.parseLong(obj[8].toString())==2){ %>
				<span style="font-size: 18px;"><b>Note : DAK Replied And Still Not Replied By P&C From <%=PandCNotificationShowingPlace %> Days </b></span>
				<%} %>
				<%if(ForwardNotificationShowingPlace>0 && obj[8]!=null && Long.parseLong(obj[8].toString())==2){ %>
				<span style="font-size: 18px;"><b>Note : DAK P&C Replied And Still Not Forwarded From <%=ForwardNotificationShowingPlace %> Days </b></span>
				<%} %>
				<%if(ApprovedNotificationShowingPlace>0 && obj[8]!=null && Long.parseLong(obj[8].toString())==2){ %>
				<span style="font-size: 18px;"><b>Note : DAK Forwarded And Still Not Approved From <%=ApprovedNotificationShowingPlace %> Days </b></span>
				<%} %>
				<%if(ClosedNotificationShowingPlace>0 && obj[8]!=null && Long.parseLong(obj[8].toString())==2) { %>
				<span style="font-size: 18px;"><b>Note : DAK Approved And Still Not Closed From <%=ClosedNotificationShowingPlace %> Days </b></span>
				<%} %>
				</div>
 				<%} %>
 				
 				<%}} %>
 	
 				
			</div>
		</div>
	</div>
</div><br>


	  	   <div class="modal ShowEmpDetails" tabindex="-1" role="dialog">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header" style="background-color:#114A86;height:50px;">
				        <h5 class="modal-title" style="margin-top: -0.4rem;"><b style="color:white;text-align:left;" id="HeaderTitle"></b> </h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	  	                <span aria-hidden="true" style="background-color:white;">×</span>
	  	                 </button>
				      </div>
				      <div class="modal-body">
				         <ol id="AckDetails" style="margin: 0px; padding: 6px">
				         
				         
							</ol>
				      </div>
				    </div>
				  </div>
				</div>


</body>

   <!-- Js script o fetch createdby fullname and designation -->

<script type="text/javascript">

                /* Setting Initiation And Distribution */

var InitiatedDetails = document.getElementById('createdBy');
if(InitiatedDetails!=null){
	var InitiatedBy =InitiatedDetails.value;
	$.ajax({
		type : "GET",
		url : "GetInitiatedByFullName.htm",	
		datatype : 'json',
		data : {
			initiatedBy : InitiatedBy
		},
		 cache: true, // Enable caching
		success :  function(result){
			 var r=result;
			 if(result!=null){
				 var fullName = result.replace(/"/g, '');
			 document.getElementById('InitiatedByFullName').innerText = fullName;
			 document.getElementById('DistributedByFullName').innerText = fullName;
			 document.getElementById('ForwardedByFullName').innerText = fullName;
			 
		}
		}/*sucess close*/
	 });/*Ajax close*/
}

</script>

<script type="text/javascript">

           /* Setting Acknowledge */

var DakDetails= document.getElementById('dakId');
if(DakDetails!=null){
	var DakId= DakDetails.value;
	$.ajax({
		type : "GET",
		url : "GetAcknowledgedMembers.htm",	
		datatype : 'json',
		data : {
			dakId : DakId
		},
		success :  function(result){
			var result = JSON.parse(result);
			console.log(result);
			if(result.length!=0){
				var values = Object.values(result).map(function(key, value) {
					  return result[key,value]
					});
				  console.log(values);
				// Clear the existing list items
		          var list = document.getElementById("AcknowledgedMembers");
		          list.innerHTML = '';
		          
		          var i=1;
		          
		          // Append new list items with fetched values
		          values.forEach(function (value) {
		        	  if(i<=4){
		            var fullName = value[3];
		            var designation = value[4];
		            var AckDateTime=value[5];
		            var convertedDateString =null;
		            if(AckDateTime!=null)
		            	{
		            	convertedDateString = newFormatDate(AckDateTime);
		            	}
		            else
		            	{
		            	convertedDateString='--';
		            	}
		           
		            var listItem = document.createElement("li");
		            var paragraph = document.createElement("p");

		            var text = document.createTextNode(fullName + ", " + designation+"  /  ");
		            var span = document.createElement("span"); 
		            
		            var anchor =null;
		            if(i==4){
		            	var url = "#"; 
			            var anchor = document.createElement("a");
			            
			            anchor.href = url;
			            anchor.addEventListener("click", function() {
			            	OpenMoreDetails("Ack");
			            	});
			            anchor.text = " ... View More "; 
			            anchor.style.color = "blue"; 
		            }
		            
		        
		            span.textContent = convertedDateString;
		            span.classList.add("DateStyle");

		            paragraph.appendChild(text);
		            paragraph.appendChild(span);
		            
		            if(i==4){
		            	 paragraph.appendChild(anchor);
		            }
		           
		            listItem.appendChild(paragraph);

		            list.appendChild(listItem);

		            var dateStyleElements = document.querySelectorAll('.DateStyle');
		            var styles = {
		              color: 'rgb(183 57 185)',
		              fontSize: '12px',  
		              fontWeight: 'bold',
		            };

		            dateStyleElements.forEach(element => {
		              for (let style in styles) {
		                element.style[style] = styles[style];
		              }
		            });
		        	  
		        	  }i++;
		          });
		          }
		}/*sucess close*/
	 });/*Ajax close*/
}


if(DakDetails!=null){
	var SelDakId= DakDetails.value;
	$.ajax({
		type : "GET",
		url : "GetAcknowledgeMembers.htm",	
		datatype : 'json',
		data : {
			SelDakId : SelDakId
		},
		success :  function(result){
			var result = JSON.parse(result);
			console.log(result);
			if(result.length!=0){
				var values = Object.values(result).map(function(key, value) {
					  return result[key,value]
					});
				  console.log(values);
				// Clear the existing list items
		          var list = document.getElementById("AcknowledgeMembers");
		          list.innerHTML = '';
		          var count=1;
		          // Append new list items with fetched values
		          values.forEach(function (value) {
		            var fullName = value[3];
		            var designation = value[4];
		            var text = document.createTextNode(count +" . "+fullName + ", " + designation +"");
		            var span = document.createElement("span"); 
		            
		            span.appendChild(text);
		            list.appendChild(span);
		            var br = document.createElement("br");
		            list.appendChild(br);
		        	  count++;
		          });
		          }
		}/*sucess close*/
	 });/*Ajax close*/
}
function newFormatDate(UserDate)
{
	var date = new Date(UserDate);

	 // Format the date and time
	 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
	     month: 'short',
	     day: 'numeric',
	     year: 'numeric',
	     hour: 'numeric',
	     minute: 'numeric'
	 }).format(date);
	 return formattedDateTime;
	}

function OpenMoreDetails(data)
{
    $(".ShowEmpDetails").modal('show');
    
    var url1 = "GetAcknowledgedMembers.htm";
    var url2 = "GetRepliedMemberName.htm";
    
    var Url = data=="Ack" ? url1 : url2;
    
    var AckHead="Acknowledged Employees List";
    var ReplyHead="Replied Employees List";
    
    var Head = data=="Ack" ? AckHead : ReplyHead;
    
    $("#HeaderTitle").html(Head);
    
	var DakDetails= document.getElementById('dakId');
	if(DakDetails!=null){
		var DakId= DakDetails.value;
		$.ajax({
			type : "GET",
			url : Url,	
			datatype : 'json',
			data : {
				dakId : DakId
			},
			success :  function(result){
				var result = JSON.parse(result);
				console.log(result);
				if(result!=null && result.length!=0){
					var values = Object.values(result).map(function(key, value) {
						  return result[key,value]
						});
					  console.log(values);
					// Clear the existing list items
			          var list = document.getElementById("AckDetails");
			          list.innerHTML = '';
			          
			          values.forEach(function (value) {
			            var fullName = value[3];
			            var designation = value[4];
			            var AckDateTime=value[5];
			            var convertedDateString =null;
			            if(AckDateTime!=null)
			            	{
			            	convertedDateString = newFormatDate(AckDateTime);
			            	}
			            else
			            	{
			            	convertedDateString='--';
			            	}
			           
			            var listItem = document.createElement("li");
			            var paragraph = document.createElement("p");
			            paragraph.style.display = "flex"; // Use Flexbox to align data inside it to move left or right

			            var text = document.createTextNode(fullName + ", " + designation+"  /  ");
			            var span = document.createElement("span"); 
			            
			            span.textContent = convertedDateString;
			            span.classList.add("DateStyle");
			            span.style.marginTop = "4px"; 

			            paragraph.appendChild(text);
			            paragraph.appendChild(span);
			            
			           
			        
			            if(data === 'Reply'){
			            	 
			            // Create and configure the button container
				         var btnPrevContainer = document.createElement("div");
				         btnPrevContainer.style.marginLeft = "auto"; // Push it to the right


				            var btnSpan = document.createElement("span");
				            btnSpan.style.cssFloat = "right";

				            var markerBtn = document.createElement("button");
				            markerBtn.type = "button";
				            markerBtn.className = "btn btn-sm icon-btn";
				            markerBtn.setAttribute("onclick", "IndividualReplyPrev(" + value[0] + "," + value[1] + "," + value[6] + "," + value[7] + "," + value[8] + ")");
				            markerBtn.style.padding = "0px";
				            markerBtn.style.backgroundColor = "transparent";
				            markerBtn.setAttribute("data-toggle", "tooltip");
				            markerBtn.setAttribute("data-placement", "top");
				            markerBtn.setAttribute("title", "Marker Preview");

				            var img = document.createElement("img");
				            img.alt = "mark";
				            img.src = "view/images/replyPreview.png";

				            markerBtn.appendChild(img);
				            btnSpan.appendChild(markerBtn);
				            btnPrevContainer.appendChild(btnSpan);

				            var RedirectVal = '<%=RedirFromCommon%>';
				            if(RedirectVal != null && RedirectVal!='' && RedirectVal=='DakPendingList'){
				            	
				            }else{
				            paragraph.appendChild(btnPrevContainer);
				            }
			            }
			            listItem.appendChild(paragraph);

			            list.appendChild(listItem);

			            var dateStyleElements = document.querySelectorAll('.DateStyle');
			            var styles = {
			              color: 'rgb(183 57 185)',
			              fontSize: '12px',  
			              fontWeight: 'bold',
			            };

			            dateStyleElements.forEach(element => {
			              for (let style in styles) {
			                element.style[style] = styles[style];
			              }
			            });
			        	  
			          });
			          }
			}/*sucess close*/
		 });/*Ajax close*/
	}
	}



/* Setting Replies */

if(DakDetails!=null){
	var dakId = DakDetails.value;
	$.ajax({
		type : "GET",
		url : "GetRepliedMemberName.htm",	  
		datatype : 'json',
		data : {
			dakId : dakId
		},
		success :  function(result){
			var result = JSON.parse(result);
			console.log(result);
			if(result.length!=0){
				var values = Object.values(result).map(function(key, value) {
					  return result[key,value]
					});
				  console.log(values);
				// Clear the existing list items
		          var list = document.getElementById("RepliedMembers");
		          list.innerHTML = '';
		          
		          var i=1;
		          // Append new list items with fetched values
		          values.forEach(function (value) {
		        	  if(i<=4){ 
		            var fullName = value[3];
		            var designation = value[4];
		            var ReplyDateTime=value[5];
		            
		            var convertedDateString =null;
		            if(ReplyDateTime!=null)
		            	{
		            	convertedDateString = newFormatDate(ReplyDateTime);
		            	}
		            else
		            	{
		            	convertedDateString='--';
		            	}
		            
		            var listItem = document.createElement("li");
		            var paragraph = document.createElement("p");

		            var text = document.createTextNode(fullName + ", " + designation+"  /  ");
		            var span = document.createElement("span");
		            
		            var anchor =null;
		            if(i==4){
		            	var url = "#"; 
			            var anchor = document.createElement("a");
			            
			            anchor.href = url;
			            anchor.addEventListener("click", function() {
			            	OpenMoreDetails("Reply");
			            	});
			            anchor.text = " ... View More "; 
			            anchor.style.color = "blue"; 
		            }
		            
		            span.textContent = convertedDateString;
		            span.classList.add("DateStyle");
		            
		            paragraph.appendChild(text);
		            paragraph.appendChild(span);
		            if(i==4){
		            	 paragraph.appendChild(anchor);
		            }
		            paragraph.style.display = "flex"; // Use Flexbox to align data inside it to move left or right

		         // Create and configure the button container
		         var btnPrevContainer = document.createElement("div");
		         btnPrevContainer.style.marginLeft = "auto"; // Push it to the right


		            var btnSpan = document.createElement("span");
		            btnSpan.style.cssFloat = "right";

		            var markerBtn = document.createElement("button");
		            markerBtn.type = "button";
		            markerBtn.className = "btn btn-sm icon-btn";
		            markerBtn.setAttribute("onclick", "IndividualReplyPrev(" + value[0] + "," + value[1] + "," + value[6] + "," + value[7] + "," + value[8] + ")");
		            markerBtn.style.padding = "0px";
		            markerBtn.style.backgroundColor = "transparent";
		            markerBtn.setAttribute("data-toggle", "tooltip");
		            markerBtn.setAttribute("data-placement", "top");
		            markerBtn.setAttribute("title", "Marker Preview");

		            var img = document.createElement("img");
		            img.alt = "mark";
		            img.src = "view/images/replyPreview.png";

		            markerBtn.appendChild(img);
		            btnSpan.appendChild(markerBtn);
		            btnPrevContainer.appendChild(btnSpan);

		            var RedirectVal = '<%=RedirFromCommon%>';
		            if(RedirectVal != null && RedirectVal!='' && RedirectVal=='DakPendingList'){
		            	
		            }else{
		            paragraph.appendChild(btnPrevContainer);
		            }
		      

		            listItem.appendChild(paragraph);

		            list.appendChild(listItem);

		            var dateStyleElements = document.querySelectorAll('.DateStyle');
		            var styles = {
		              color: 'rgb(183 57 185)',
		              fontSize: '12px',  
		              fontWeight: 'bold',
		            };

		            dateStyleElements.forEach(element => {
		              for (let style in styles) {
		                element.style[style] = styles[style];
		              }
		            });
		          }i++;
		          });
			}
		}
	 });/*Ajax close*/
}



if(DakDetails!=null){
	var replydakId = DakDetails.value;
	$.ajax({
		type : "GET",
		url : "GetReplyMemberName.htm",	  
		datatype : 'json',
		data : {
			replydakId : replydakId
		},
		success :  function(result){
			var result = JSON.parse(result);
			console.log(result);
			if(result.length!=0){
				var values = Object.values(result).map(function(key, value) {
					  return result[key,value]
					});
				  console.log(values);
				// Clear the existing list items
		          var list = document.getElementById("ReplyMembers");
		          list.innerHTML = '';
		          
		          var count=1;
		          // Append new list items with fetched values
		          values.forEach(function (value) {
		            var fullName = value[2];
		            var designation = value[3];
		            var text = document.createTextNode(count+" . "+ fullName + ", " + designation);
		            var span = document.createElement("span");
		            span.appendChild(text);
		            list.appendChild(span);
		            var br = document.createElement("br");
		            list.appendChild(br);
					count++;
		          });
			}
		}
	 });/*Ajax close*/
}

function formatDate(inputDate) {
	  const dateObj = new Date(inputDate);
	  const day = dateObj.getDate();
	  const month = dateObj.toLocaleString('default', { month: 'short' });
	  const year = dateObj.getFullYear();
	  const time = dateObj.toLocaleString('default', { hour: '2-digit', minute: '2-digit' });
	  const timeWithoutAMPM = removeAMPM(time);
	  const outputDate = timeWithoutAMPM+" "+day+" "+month+" "+year;
	  return outputDate;
	}
	
function removeAMPM(timeString) {
	  const [time, ampm] = timeString.split(" ");
	  const [hours, minutes] = time.split(":");
	  const formattedHours = ampm === "AM" ? hours : parseInt(hours) + 12;
	  const formattedTime = formattedHours +":"+minutes ;
	  return formattedTime;
	}

</script>

<script type="text/javascript">

                    

</script>

<script type="text/javascript">

                    /* Setting Dak Replies prepared By P & C */

var RepliedDetails = document.getElementById('RepliedByPAndC');
if(RepliedDetails!=null){
	var RepliedByPAndC =RepliedDetails.value;
	$.ajax({
		type : "GET",
		url : "RepliedByPAndCFullName.htm",	
		datatype : 'json',
		data : {
			RepliedByPAndC : RepliedByPAndC
		},
		success :  function(result){
			 var r=result;
			 if(result!=null){
				 var fullName = result.replace(/"/g, '');
			 document.getElementById('RepliedByPandC').innerText = fullName;
			 
		}
		}/*sucess close*/
	 });/*Ajax close*/
}

</script>

<script type="text/javascript">

                   /* Setting Approved */

var ApprovedDetails = document.getElementById('ApprovedBy');
console.log("345:"+ApprovedDetails);
if(ApprovedDetails!=null){
	var ApprovedBy =ApprovedDetails.value;
	$.ajax({
		type : "GET",
		url : "ApprovedByFullName.htm",	
		datatype : 'json',
		data : {
			ApprovedBy : ApprovedBy
		},
		success :  function(result){
			 var r=result;
			 if(result!=null){
				 var fullName = result.replace(/"/g, '');
			 document.getElementById('ApprovedByFullName').innerText = fullName;
			 
		}
		}/*sucess close*/
	 });/*Ajax close*/
}

</script>


<script type="text/javascript">

          /* Setting Closed */

var ClosedDetails = document.getElementById('ClosedByName');
if(ClosedDetails!=null){
	var ClosedBy = ClosedDetails.value;
	
	$.ajax({
		type : "GET",
		url : "ClosedByFullName.htm",	
		datatype : 'json',
		data : {
			ClosedBy : ClosedBy
		},
		success :  function(result){
			 var r=result;
			 if(result!=null){
				 var fullName = result.replace(/"/g, '');
				 console.log("@@@@@"+fullName);
			 document.getElementById('ClosedByFullName').innerText = fullName;
			 
		}
		}/*sucess close*/
	 });/*Ajax close*/
}

</script>


</html>