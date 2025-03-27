<%@page import="com.google.gson.Gson"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<%@page import="java.time.LocalTime"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style type="text/css">
.HighlightHighPrior{
    background: rgb(223 42 42 / 50%)!important;
}

/* -------TAB SWITCHING CSS START ----- */
.tabs {
  position: relative;
  display: flex;
  min-height: 500px;
  border-radius: 8px 8px 0 0;
  overflow: scroll;
}
.tabs::-webkit-scrollbar {
    display: none;
}
.tabby-tab {
  flex: 1;
}
#Sample{
display:block;
}
.tabby-tab label {
  display: block;
  box-sizing: border-box;
  /* tab content must clear this */
    height: 37px;
  
  padding: 5px;
  text-align: center;
  background: #114A86;
  cursor: pointer;
  transition: background 0.5s ease;
  color: white;
  font-size: large;
}

.tabby-tab label:hover {
  background: #5488BF ;
}

.tabby-content {
  position: absolute;
  left: 0; bottom: 0; right: 0;
    top: 40px; 
  
  padding: 20px;
  border-radius: 0 0 8px 8px;
  background: white;
  
  transition: 
    opacity 0.8s ease,
    transform 0.8s ease   ;
    opacity: 0;
    transform: scale(0.1);
    transform-origin: top left;
  
}

.tabby-content img {
  float: left;
  margin-right: 20px;
  border-radius: 8px;
}

.tabby-tab [type=radio] { display: none; }
[type=radio]:checked ~ label {
  background: #5488BF ;
  z-index: 2;
}

[type=radio]:checked ~ label ~ .tabby-content {
  z-index: 1;
    opacity: 1;
    transform: scale(1);
}

@media screen and (max-width: 767px) {
  .tabs { min-height: 400px;}
}

@media screen and (max-width: 480px) {
  .tabs { min-height: 580px; }
  .tabby-tab label { 
    height: 60px;
  }
  .tabby-content { top: 60px; }
  .tabby-content img {
    float: none;
    margin-right: 0;
    margin-bottom: 20px;
  }
}
/* -------TAB SWITCHING CSS END ----- */
div.dropdown-menu.open
    {
        max-height: 410px !important;
        overflow: hidden;
    }
    ul.dropdown-menu.inner
    {
        max-height: 410px !important;
       /*  overflow-y: auto; */
    }
  

h1 { font-size: 32px; }
h2 { font-size: 26px; }
h3 { font-size: 18px; }
p { margin: 0 0 15px; line-height: 24px; color: gainsboro; }


.container { 
  max-width: 960px; 
  height: 100%;
  margin: 0 auto; 
  padding: 20px;
}


.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 30px;
	height: 20px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 100px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 30px;
	height: 20px;
	box-sizing: border-box;
	margin: 0 0 0 0;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 4px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 12px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}
body {
   overflow-x: hidden;
}


  .col-2 h6 {
    margin-bottom: 0;
  }
  
.RecordDak {
  
	 /*  background-image: linear-gradient(rgba(255,225,159, .84), rgba(255,240,0, .84) 50%)!important; */
	border-color:rgba(255,240,0);
}

.ActionDak {
background-image: linear-gradient(rgba(211,211,211, .84), rgba(192,192,192, .84) 50%)!important;
	border-color:rgba(192,192,192);
  
}
.completed {
    color: rgba(0,128,0, 0.8);
    font-weight: 700;
    font-size:16px;
}

.completeddelay {
    color: rgba(255,0,0,0.8);
    font-weight: 700;
    font-size:16px;
}
.Urgent{
 color: rgba(242, 23, 7);
    font-weight: 700;
    font-size:16px;
}

.all {
    color:grey;
    font-weight: 700;
    font-size:16px;
}
.ongoing {
    color: rgba(11, 127, 171,0.8);
    font-weight: 700;
    font-size:16px;
}

.ongoingdelay {
    color: rgba(255, 165, 0, 0.9);
    font-weight: 700;
    font-size:16px;
}


.OG{
white-space: normal;
background-image: linear-gradient(rgba(11, 127, 171,0.3), rgba(11, 127, 171,0.8) 50%)!important;
	border-color:rgba(11, 127, 171,0.8);
}

.DO{
white-space: normal;
background-image: linear-gradient(rgba(230, 126, 34, 0.5), rgba(255, 165, 0, 0.9) 50%)!important;
	border-color:rgba(255, 165, 0, 0.9);
}

.CD{
white-space: normal;
background-image: linear-gradient(rgba(255,0,0, 0.5), rgba(255,0,0,0.8) 50%)!important;
	border-color:rgba(255,0,0,0.8);
}

.CO{
white-space: normal;
background-image: linear-gradient(rgba(0,128,0, 0.5), rgba(0,128,0, 0.8) 50%)!important;
	border-color:rgba(0,128,0, 0.8);
}

.float-container {
  width: 100%;
  display: flex;
  justify-content: space-between;
}

.Details {
  display: flex;
  justify-content: space-between;
}

#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
}
.DakListCommonGroupname{
width: 330px !important;
}
.DakListCommonempidSelect{
width: 250px !important;
margin-top: -20px !important;
}
.DakListCommonindividual{
width: 250px !important;
/* margin-left: 20px !important; */
margin-top: -20px !important;
}
.filter-option-inner-inner {
	width: 200px !important;
}

.table a:hover,a:focus {
   text-decoration: underline !important; 
}

.custom-select {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  width: 200px;
}

.custom-select select {
  /* Hide the default select dropdown arrow */
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  /* Add some padding to make room for the arrow */
  padding-right: 20px;
  width: 100%;
  height: 30px;
  /* Customize the look of the dropdown */
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: #fff;
}

/* Add a custom arrow */
.custom-select::after {
  content: '\25BC'; /* Unicode for downward-pointing triangle or arrow */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  /* Customize the arrow appearance */
  font-size: 10px;
  color: #666;
}



@keyframes glow {
    0% {
        box-shadow: 0 0 5px 5px rgba(255, 255, 153, 0.8); /* Initial shadow - Light yellow */
    }
    50% {
        box-shadow: 0 0 20px 10px rgba(255, 255, 153, 0.8); /* Expanded shadow - Light yellow */
    }
    100% {
        box-shadow: 0 0 5px 5px rgba(255, 255, 153, 0.8); /* Return to initial shadow - Light yellow */
    }
}
.spinner {
    position: fixed;
    top: 40%;
    left: 32%;
    margin-left: -50px; /* half width of the spinner gif */
    margin-top: -50px; /* half height of the spinner gif */
    text-align:center;
    z-index:1234;
    overflow: auto;
    width: 1000px; /* width of the spinner gif */
    height: 1020px; /*hight of the spinner gif +2px to fix IE8 issue */
    background: transparent;
}
</style>
</head>
<body>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK List(<%="All" %>)</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK List</li>
				  </ol>
				</nav>
			</div>			
		</div>
		</div>
		<!-- Loading  Modal -->
	
<div id="spinner" class="spinner">
                <img id="img-spinner" style="width: 300px;height: 300px; margin-right: 150px;" src="view/images/load.gif" alt="Loading"/>
                </div>
		<!-- Loading  Modal End-->
		</div>
		
		<%
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		List<Object[]> dakDetailedList=(List<Object[]>)request.getAttribute("DakDetailedList");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		List<Object[]> DakMembers = (List<Object[]>) request.getAttribute("DakMembers");
		List<Object[]> actionList = (List<Object[]>) request.getAttribute("actionList");
		List<Object[]> DakMemberGroup = (List<Object[]>) request.getAttribute("DakMemberGroup");
		String RemarkCount=(String)request.getAttribute("RemarkCount");
		
		String countForMsgMarkerRedirect =(String)request.getAttribute("countForMsgMarkerRedirect");
		String statusFilteration =(String)request.getAttribute("statusValue");
		
		List<Object[]> smsList=(List<Object[]>)request.getAttribute("smsList");
		String jsonSmsList = new Gson().toJson(smsList);
		
		String escapedJsonSmsList = jsonSmsList.replace("'", "\\'");
		//Redir
		//String PageNo=(String)request.getAttribute("PageNumber");
		String Row=(String)request.getAttribute("RowNumber");
		%>
		
		<%
		String ses=(String)request.getParameter("result"); 
 		String ses1=(String)request.getParameter("resultfail");
		if(ses1!=null){
		%>
		<div align="center">
			<div class="alert alert-danger" role="alert">
	    		<%=ses1 %>
	    	</div>
    	</div>
		<%}if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert" >
        		<%=ses %>
        	</div>
    	</div>
    	<%} %>
    	
    	
    	<div class="card loadingCard"  style="display: none;">
    	<div class="card-header"style="height: 2.7rem">
  <form action="DakList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <div class="row">
      <div class="float-container" style="float:right;">
      
        <div id="label1" style="width: 70%; text-align: left;margin-top: -1rem;">
         <table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 13px;text-align: center"> 
									   <button type="button" class="btn btn-sm statusBtn" id="All" onclick="setStatus('All')"><span class="all"></span><span class="all">&nbsp;All&nbsp;</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="Ongoing" onclick="setStatus('Ongoing')"><span class="ongoing">OG</span><span class="ongoing"> &nbsp;:&nbsp; On Going </span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="OngoingDelay" onclick="setStatus('OngoingDelay')"><span class="ongoingdelay">DO</span><span class="ongoingdelay">&nbsp; :&nbsp;Delay - On Going</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="Completed" onclick="setStatus('Completed')"><span class="completed">CO</span><span class="completed">&nbsp; :&nbsp; Completed</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="CompletedDelay" onclick="setStatus('CompletedDelay')"><span class="completeddelay">CD</span><span class="completeddelay">&nbsp; :&nbsp; Completed with  Delay</span></button>&nbsp;&nbsp;
										 <button type="button" class="btn btn-sm statusBtn" id="Urgent" onclick="setStatus('Urgent')"><span class="Urgent">&nbsp; &nbsp;Urgent</span></button>&nbsp;&nbsp;
										<input type="hidden" id="StatusFilterValId" name="StatusFilterVal" value="">
										 
									</p>
								</td>									
							</tr>
							</thead>
							</table>
        </div>
        
        <div class="label2" style="width: 40%; text-align: right">
          <div class="row Details">
          
            <div class="col-1" style="font-size: 16px; padding-left:120px; ">
              <label for="fromdate" style="text-align: center;font-size: 16px;width:50px;">From &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            
            <div class="col-4" style="padding-left:80px;">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <div class="col-1" style="font-size: 16px; padding-left:30px; ">
              <label for="todate" style="text-align: center;font-size: 16px;width:20px;">To &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            <div class="col-4" style="padding: 0; ">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
           <!--  <div class="col-1"></div> Empty column for spacing -->
          </div>
        </div>
      </div>
    </div>
  </form>
</div>
<div class="card-body" style="width: 99%">
	<div class="table-responsive" style="overflow:hidden;">
					<form action="#" method="post"  id="DakDetailedListSubmit">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<%-- <input type="hidden" name="fromDateCmnValue"	value="<%=frmDt%>" /> 
			              <input type="hidden" name="toDateCmnValue"	value="<%=toDt%>" /> --%>
						<input type="hidden" name="viewfrom" value="DakDetailedList">
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
								<tr>
								    <th class="text-nowrap">Expand</th> 
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">DAK Id</th>
									<th class="text-nowrap">Head</th>
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">Ref No & Date </th>
									<th class="text-nowrap">Action Due</th>
								    <th class="text-nowrap">Subject</th> 
								    <th class="text-nowrap">DAK Status</th>
									<th class="text-nowrap">Status</th>
									<th style="width: 170px;">Action</th>
						</tr>
							</thead>
							<tbody>		
							
							
							<%
								 int count=1;
                                 String DakStatus = null;
								if(dakDetailedList!=null && dakDetailedList.size()>0){
									for(Object[] obj:dakDetailedList){
										 if (obj[5] != null){
											 DakStatus = obj[5].toString();
	   
	  //obj[27] - CountOfAllMarkers//obj[28] - CountOfActionMarkers//obj[29] - CountOfMarkersAck//obj[30] - CountOfMarkersReply
	    String StatusCountAck = null;
		String StatusCountReply = null;

        if (!DakStatus.equalsIgnoreCase("DC") && !DakStatus.equalsIgnoreCase("AP")
            && !DakStatus.equalsIgnoreCase("RP") && !DakStatus.equalsIgnoreCase("RM")
            && !DakStatus.equalsIgnoreCase("FP")) {
       //Ack Count
            if (obj[30] != null && Long.parseLong(obj[30].toString()) == 0 && obj[29] != null && Long.parseLong(obj[29].toString()) > 0) {
                StatusCountAck = "Acknowledged<br>[" + obj[29] + "/" + obj[27] + "]";
            }
       //Reply Count
            if (obj[29] != null && Long.parseLong(obj[29].toString()) > 0 && obj[28] != null && Long.parseLong(obj[28].toString()) > 0
                && obj[30] != null && Long.parseLong(obj[30].toString()) > 0) {
                StatusCountReply = "Replied<br>[" + obj[30] + "/" + obj[28] + "]";
            }
        }
        
    
		
								          /////////////////////////////////////////
										   %>
										   <% String clickableRowId = "dakRow"+obj[0].toString();%>
										   <tr  data-row-id=row-<%=count%> <%if(obj[21]!=null && Long.parseLong(obj[21].toString())==3){ %> class="HighlightHighPrior"<%}%> id="<%=clickableRowId%>">
										  <td style="width:2% !important; " class="center">
                                <!-- Add the expand button only if Distributed -->
                               <%if(!"DI".equalsIgnoreCase(DakStatus) ){ %>
									<button class="btn btn-sm btn-success expand-button" type="button" id="btn<%=count %>"
								   data-button-type="MyExpandButton" data-row-id="<%=obj[0] %>" value="<%=obj[0] %>" >
                                 <i class="fa fa-plus" id="fa<%=count%>"></i>
                                   </button>				 
                                   <!--else show expand button with grey color if not distributed -->
									<%}else{ %>
									<button class="btn btn-sm disabledExpand" disabled onclick="disabled('<%=count %>')" > <i class="fa fa-plus"></i>
                                    </button>
									<%} %>
								</td>
                              
								<td style="width:10px;"><%=count %></td>
	 					          <td class="wrap" style="text-align: left;width:80px;">
	 					          	<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakDetailedList')">
                                    <% if (obj[8] != null) { %>
                                    <%= obj[8].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
                                     </td>
                                     <td style="text-align: center;width:10px;"><%if(obj[18]!=null){ %><%=obj[18].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									  <td style="text-align: center;width:80px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
									<td  class="wrap" style="text-align: left;width:180px;"><%if(obj[14]!=null){%><%=obj[14]%><%}else{ %>-<%} %></td> 
									<td class="wrap"  style="text-align: left;width:80px;text-align: center;font-weight:bold;">
								
									<%if(obj[7]!=null) {%>
									
									<%if(StatusCountAck!=null) {%> <%=StatusCountAck%><%}else if(StatusCountReply!=null) {%><%=StatusCountReply%><%}else{%><%=obj[7].toString() %><%}%>
									<%} %>
									
									</td>
									<td  class="<%=obj[13]%>" style="text-align: left;width:40px;text-align: center;font-weight:bold;"><%if(obj[13]!=null) {%><%=obj[13].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;font-weight:bold;width:15%;">
					              
					                  <input type="hidden" name="ActionFrm"	value="DakDetailedList" />	 
				         
				          <%  int itemsPerPage = 10;
							int pageNumber = (count - 1) / itemsPerPage + 1;%>
				            <input type="hidden" name=RedirPageNo<%=obj[0]%> value="<%=pageNumber%>">
						    <input type="hidden" name=RedirRow<%=obj[0]%> value="<%=count%>"> 
					 <!-- Edit Button -->
					 <%if("DI".equalsIgnoreCase(DakStatus) ){ %>
				     <input type="hidden" name="fromDateFetch"	value="<%=frmDt %>" /> 
			         <input type="hidden" name="toDateFetch"	value="<%=toDt%>" />
			          <input type="hidden" name="ActionForm" vaLue="DakDetailedList"> 	
				     <button type="submit" class="btn btn-sm icon-btn" formaction="DakEdit.htm" formmethod="POST" name="DakId" id="myfrm"
				     data-toggle="tooltip" data-placement="top" value="<%=obj[0]%>" title="Edit">
 											<img alt="edit" src="view/images/writing.png">
 										  </button>
				    <%}else{ %>
				    <!--PreviewButton -->
				        <button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]  %> value="<%=obj[0] %>" 
							formaction="DakReceivedView.htm" formmethod="post" formtarget="blank" data-toggle="tooltip" title="Preview"> 
							<img alt="mark" src="view/images/preview3.png">
 						</button>
				    
				    <%} %>
				    
				    
				  
				   <%if(!DakStatus.equalsIgnoreCase("AP") && !DakStatus.equalsIgnoreCase("DC")) {%>
				          <!-- Attach Button -->
				        <button type="button" class="btn btn-sm icon-btn" data-toggle="tooltip" Onclick="uploadDoc(<%=obj[0] %>,'M','<%=obj[8].toString() %>','DakDetailedList','<%=frmDt%>','<%=toDt%>','<%=obj[3].toString() %>',1,<%=count %>)" data-placement="top" title="Attach" data-target="#exampleModalCenter">
 						<img alt="attach" src="view/images/attach.png">
 						</button>
 						
 						 <!-- EditAction Button -->		 		
 		                 <button type="button" class="btn btn-sm icon-btn"  data-toggle="tooltip" data-placement="top" title="EditAction" onclick="EditAction(<%=obj[0]%>,'DakDetailedList','<%=obj[8]%>','<%=obj[3]%>','<%=frmDt %>','<%=toDt %>',1,<%=count%>)">
 								<img alt="EditAction" src="view/images/EditAction.png">
							</button>
					
				     <%} %>
				     
			      <%--  <!-- Marking Button -->		     
				      <%if(Long.parseLong(obj[20].toString())==0){ %> 
		              <button type="button" onclick="DakMarking(<%= obj[0] %>,<%= obj[19] %>,'<%= obj[10] %>','<%= obj[20].toString().trim() %>','DakDetailedList','<%=obj[8] %>','<%=obj[3] %>','<%=frmDt %>','<%=toDt %>')" class="btn btn-sm icon-btn" data-toggle="tooltip" title="Mark Up">
 											<img alt="mark" src="view/images/file-sharing.png">
 										  </button>
				      <%} %>  --%>
				      
			      <!-- Distribute Button -->	       
				       <%if("DI".equalsIgnoreCase(DakStatus)){ %> 
				         <button type="button" data-toggle="tooltip" class="btn btn-sm icon-btn" onclick="DakDistribute(<%=obj[0] %>,'DakDetailedList','<%=obj[8] %>','<%=obj[3] %>','<%=frmDt %>','<%=toDt %>','<%=obj[9].toString() %>',1,<%=count%>)" data-placement="top" title="Distribute">
 											<img alt="mark"  src="view/images/d1.jpg">
 						 </button>
				      <%} %>

 			    <!-- ReMarking Button -->							  
 						<%--  <%if( !"DI".equalsIgnoreCase(DakStatus) &&  !"AP".equalsIgnoreCase(DakStatus) &&  !"DC".equalsIgnoreCase(DakStatus)    ){ %>
 							<button type="button" onclick="DakReMarking(<%= obj[0] %>,'<%=obj[10]%>',<%=obj[19]%>,'<%=obj[9].toString().trim() %>','DakDetailedList','<%=obj[8]%>','<%=obj[3] %>','<%=frmDt %>','<%=toDt %>')" class="btn btn-sm icon-btn" data-toggle="tooltip" title="ReMarkUp">
								<img alt="mark" src="view/images/remark.png">
 							</button>

 						 <%} %>  
 						 
 						 
 			  <!-- ReDistribute Button -->		 
 					 <%if(Long.parseLong(obj[24].toString())>0){%>
 							<button type="button" data-toggle="tooltip" class="btn btn-sm icon-btn" Onclick="DakReDistribute(<%=obj[0] %>,'DakDetailedList','<%=frmDt %>','<%=toDt %>')" data-placement="top" title="Distribute">
 											<img alt="mark"  src="view/images/d1.jpg">
 							</button>  
 										  
 					<%} %>	 --%>
 	
								
			 <!-- Dir Approved Msg -->		 										
					<%if(obj[25]!=null && obj[25].toString().equalsIgnoreCase("R") && DakStatus.equalsIgnoreCase("AP") && !DakStatus.equalsIgnoreCase("DC")){%>
 				              <span style="font-weight:bold;font-size:12px;color:green;padding-right:10px;padding-left:10px;">
 				                Approved
 					          </span>
 			          <%}%>		
			
			 <!-- DAK Closed Msg -->						
						<%if(DakStatus.equalsIgnoreCase("DC") ){%>
 									 <span style="font-weight:bold;font-size:12px;color:red;padding-right:10px;padding-left:10px;">
 									 Closed
 									 </span>
 						<%}%> 
 						  
					 </td> 
				
				</tr>
				<%count++;} } %>
			<%}else{ %>		
	         <tr >
	         <td colspan="11" style="text-align: center" class="center">No List Found</td>
	         </tr>
	      <%} %>	
		</tbody>
	</table>
  </form>
</div>



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
  	      			<input type="hidden" id="DakDetailesActionRequiredFromdate" name="FromDate">
  	      			<input type="hidden" id="DakDetailesActionRequiredtodate" name="ToDate">
  	      			
  	      			<input type="hidden" id="PageNumber" name="PageNumber">
  	      			<input type="hidden" id="RowNumber" name="RowNumber">
  	      			
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

    	</div>
    	</div>

</body>
<script>
$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
});
$(document).ready(function () {
	  // Event delegation for dynamically generated buttons
	  $(document).on("click", "button[data-button-type='MyExpandButton']", function (event) {
	    event.preventDefault();

	// Get the Id of the clicked button
    var expandbuttonId = $(this).attr("id");
	
    // Get the data-row-id of the clicked button
    var dakId =  $(this).data("row-id");
    
    // Extract only the numeric part from the expandbuttonId
    var count = expandbuttonId.match(/\d+/)[0];
    
    console.log($( "#btn"+count ).hasClass( "btn btn-sm btn-success" ).toString());
        if($( "#btn"+count ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
 // Button class is btn-success, so expand using handleExpandButtonClick and add btn-danger to show you can collapse here
        	
    	$( "#btn"+count ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
    	$( "#fa"+count ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
       
    	handleExpandButtonClick(dakId,count);
    	
       }else if($( "#btn"+count ).hasClass( "btn btn-sm btn-danger" ).toString()=='true'){
// Button class is btn-danger, so collapse by destroying exact fixed and dynamic rows using dakid if present
    	
    	$( "#btn"+count ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
    	$( "#fa"+count ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
    	 
    	      $('#fixedtr' + dakId).remove();
    	      // Remove all dynamic rows associated with the same dakId
    	      $('.dynamic-markers-row[id^="dynamicTr' + dakId + '"]').remove();
        }
  });
});
</script>

<script>
function handleExpandButtonClick(dakId,count) {
	  // Get the corresponding row based on its ID
	  var ClickedRowId = '#dakRow'+ dakId;
	  console.log(ClickedRowId);
	  var $btnClickedRow = $(ClickedRowId);
	  
	     
     if ($("#btn" + count).hasClass("btn-danger")) {
	        // Fetch and append expandable rows data via AJAX
	        $.ajax({
	          url: "GetDakMarkersDetailsList.htm",
	          data: { dakid: dakId },
	          type: "GET",
	          success: function(result) {
	            console.log("AJAX call successful.");
	            // Parse the JSON data
	            if (result != null) {
	              var data = JSON.parse(result);

	            
	              // Loop through the data and create dynamic rows
	             
	                     // Create and append the fixed row
                   var fixedRow = '<tr class="fixed-row"  id="fixedtr' + dakId + '">';
                       fixedRow += '<td></td>';
                       fixedRow += '<td colspan="3">Emp Name</td>';
                       fixedRow += '<td>Division</td>';
                       fixedRow += '<td>Ext No</td>';
                       fixedRow += '<td>Status</td>';
                       fixedRow += '<td colspan="2">Action</td>';
                       fixedRow += '<td colspan="3">For Info / For Action</td>';
                       fixedRow += '</tr>';
                       $btnClickedRow.after(fixedRow).show(); // Append the fixed row after $row
	             
        var dynamicRowsHtml = '';     
                 for (var i = 0; i < data.length; i++) {
	                var value = data[i];
	                var empName = '--';
	                if (value[4] != null) {
	                  empName = value[4];
	                }
	                var empDesig = '';
	                if (value[6] != null) {
	                	empDesig = ', '+value[6];
	                }
	              
	                var dynamicRow = '<tr class="dynamic-markers-row" id="dynamicTr' + dakId + '">';
	                dynamicRow += '<td></td>';
	                dynamicRow += '<td colspan="3" style="text-align:left">' + empName + empDesig + '</td>';
	                dynamicRow += '<td style="text-align:center">' + value[7] + '</td>';
	                dynamicRow += '<td style="text-align:center">' + value[5] + '</td>';
	                dynamicRow += '<td style="text-align:center">' + value[8] + '</td>';
	                dynamicRow += '<td colspan="2" style="text-align:left;padding-left:120px;">';
	                <!-- Create an invisible div to store hidden inputs  through js-->
	                dynamicRow += '<div id="HiddenInputsContainer" style="display: none;"></div>';
                    
                	<!-- Individual Reply Preview Button-->
	                if (value[8] != null && typeof value[8] === 'string' && value[8]=== 'Replied' && value[9]!=null ) {
                      dynamicRow += '<button type="button" class="btn btn-sm icon-btn" data-placement="top" title="Preview"  name="DakId"  id="DakId' + value[0] + '" value="' + value[0] + '"  onclick="IndividualReplyPrev('+value[0]+','+value[3]+','+value[9]+','+value[2]+','+value[15]+')">  <img alt="mark" src="view/images/replyPreview.png"></button>';	
                    }
	                
	                <!-- Revoke Button-->
	                if (value[8] != null  && value[8] != 'Replied' && value[13] != null  && value[13] != 'AP' && value[13] != 'DC' ) {
	                	dynamicRow += '<button type="submit" class="btn btn-sm delete-btn" data-toggle="tooltip" data-placement="top" title="Revoke" style="color: red;" name="RevokeDakMarkingId" id="RevokeDakMarkingId" value="' + value[2] + ',DakDetailedList,' + count + '" formaction="RevokeMarking.htm" formmethod="post" onclick="return confirm(\'Are you sure you want to delete?\')"> <i class="fa fa-undo" aria-hidden="true"></i></button>';

	                }
                                                                                                                                                                                                          
					
	                
	                dynamicRow += '</td>';
	                dynamicRow += '<td colspan="3" >';
	                
	                <!-- Create an invisible div to store hidden inputs  through js-->
	                dynamicRow += '<div id="HiddenMarkerActionInputsContainer" style="display: none;"></div>';
	                
	                // Check a condition and add content based MarkerAction and than append
	                if (value[14] != null && typeof value[14] === 'string' && value[14]=== 'A' && value[13] != null  && value[13] != 'AP' && value[13] != 'DC') {
	                	dynamicRow += '<button type="button" class="btn btn-success" title="ForAction"  name="DakIdforMarkerAction"  id="DakIdforMarkerAction' + value[0] + '" value="' + value[0] + '" formaction="UpdateMarkerAction.htm"  style="width: 35%; height: 35px;  padding-top: 4px;" onclick="changeMarkerAction(' + value[0] + ',' + value[2] + ',' + value[3] + ',\'I\',\'For Info\',' + count + ',\'DakDetailedList\',\'' + value[16] + '\')">For Action</button>';
	                } else {
	                	  if (value[16] != null && typeof value[16] === 'string' && value[16]=== 'ACTION' && value[13] != null  && value[13] != 'AP' && value[13] != 'DC') {
	                	 dynamicRow += '<button type="button" style="width: 35%; height: 35px;  padding-top: 4px;" name="DakIdforMarkerAction"  formaction = "UpdateMarkerAction.htm"   id="DakIdforMarkerAction' + value[0] + '" value="' + value[0] + '"  title="ForInfo"  class="btn btn-primary" onclick="changeMarkerAction(' + value[0] + ',' + value[2] + ',' + value[3] + ',\'A\',\'For Action\',' + count + ',\'DakDetailedList\',\'' + value[16] + '\')">For Info</button>';
	                	  } else {
	                	/*  dynamicRow += '<button type="button"  title="ForInfo"   disabled style="width: 35%; height: 35px; padding-top: 4px; color:white; background-color:grey; border-radius: 5px; cursor:not-allowed; " >For Info</button>';
	  	                 */		  
	                	  }
	                }
	          
	                dynamicRow += '</td>';
	                dynamicRow += '</tr>';

	             // Accumulate dynamicRow HTML
	                dynamicRowsHtml += dynamicRow;
	              }
                       
              // Append all dynamic rows after the fixed row
                 $btnClickedRow.next(".fixed-row").after(dynamicRowsHtml);

	            } else {
	              // Handle the case where no data is found (add a row or display a message)
	              console.log("No data found.");
	            }
	          },
	          error: function() {
	            console.error("Error fetching expandable data.");
	          }
	        });
	   

	}

}
</script>
<script>
  // Check if the CountForMsgRedirect string is not null
  var countForMsgMarkerRedirect = "<%= countForMsgMarkerRedirect %>";
  if (countForMsgMarkerRedirect != 'null') {
    // Get the button element by ID
    var buttonElement = document.getElementById('btn' + countForMsgMarkerRedirect);

    // Scroll to the button element to that view
  	var rowElement = document.querySelector('[data-row-id="row-' + countForMsgMarkerRedirect + '"]');

	if (rowElement) {
      	console.log("rowElement"+count);
	                rowElement.scrollIntoView();
                     rowElement.style.animation = "glow 2s infinite"; // Adjust the duration as needed (in seconds)

            }

 
 // Programmatically trigger a click event on the button
    if(buttonElement){
    	buttonElement.click();
    	$( "#btn"+countForMsgMarkerRedirect ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
    	$( "#fa"+countForMsgMarkerRedirect ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
    	var dakId = $("#btn" + countForMsgMarkerRedirect).val();
    	console.log(dakId);
    	if(dakId){
    	handleExpandButtonClick(dakId,countForMsgMarkerRedirect);
    	}
    }
 
  }
</script>

<script>
function changeMarkerAction(DakId, DakMarkingId, DakEmpId,MarkerAction,ActionValue,count,redirvalue,ActionRequired) {
    console.log("DakMarkingIdValue: " + DakMarkingId);
    if (DakMarkingId != null) {
        var fields = [
            { id: "dakidmarkeraction", name: "dakidmarkeraction", value: "" },
            { id: "dakmarkingidforMarkerAction", name: "dakmarkingidforMarkerAction", value: "" },
            { id: "dakempidforMarkerAction", name: "DakempforMarkerAction", value: "" },
            { id: "actionForMarkerAction", name: "ActionForMarkerAction", value: "" },
            { id: "ActionValueForMarkerAction", name: "ActionValueForMarkerAction", value: "" },
            { id: "countForMarkerAction", name: "countForMarkerAction", value: "" },
            { id: "dakdetailedlistredirvalueformarkeraction" , name: "redirvalueformarkeraction", value:""}
        ];

        var hiddenInputsContainer = document.getElementById("HiddenMarkerActionInputsContainer");

        // Clear existing hidden inputs by emptying the container
        hiddenInputsContainer.innerHTML = '';

        fields.forEach(function(field) {
            var input = document.createElement("input");
            input.type = "hidden";
            input.id = field.id;
            input.name = field.name;
            input.value = field.value;
            hiddenInputsContainer.appendChild(input);
        });

    	
    	    document.getElementById("dakidmarkeraction").value = DakId;
    	    document.getElementById("dakmarkingidforMarkerAction").value = DakMarkingId;
    	    document.getElementById("dakempidforMarkerAction").value = DakEmpId;
    	    document.getElementById("actionForMarkerAction").value = MarkerAction;
    	    document.getElementById("ActionValueForMarkerAction").value = ActionValue;
    	    document.getElementById("countForMarkerAction").value = count;
    	    document.getElementById("dakdetailedlistredirvalueformarkeraction").value = redirvalue;

    	    if(ActionRequired==='ACTION'){
      var x = confirm("Are you sure you want to Update this MarkerAction?");
      if (x) {
          var id = "DakIdforMarkerAction" + DakId;
    	// Retrieve the button element by its ID
    	  const submitButton = document.getElementById(id);
    	// Get the formaction attribute of the button
    	  const formAction = submitButton.getAttribute('formaction');
    	  console.log("Formaction: " + formAction);
    	  if (formAction) {
    		  // Update the form's action attribute with the formaction value
    		  const myDirListForm = document.getElementById('DakDetailedListSubmit');
    		  myDirListForm.action = formAction;
    		  myDirListForm.method = 'post';
    		  
    		  // Submit the form
    		  myDirListForm.submit();
    	  } else {
    	    // The formaction is not present
    	    console.log("Form or formaction is not set");
    	  }
     } else {
        return false;
      }
    	    }
    }
  }

</script>
<script type="text/javascript">
$("#myTable1").DataTable({
	"lengthMenu": [10, 25, 50, 75, 100],
    "searching": true,
  /*   "pagingType": "simple", */
    "paging": false,
    "ordering": true

});	

</script> 

<script type="text/javascript">

$('#fromdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 "startDate" : new Date('<%=frmDt%>'), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$(document).ready(function(){
	   $('#fromdate').change(function(){
	       $('#myform').submit();
	    });
	});
	
	
var currentDate = new Date();
var maxDate = currentDate.toISOString().split('T')[0];
console.log(maxDate);

	$('#todate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"startDate" : new Date('<%=toDt%>'), 
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	$(document).ready(function(){
		   $('#todate').change(function(){
		       $('#myform').submit();
		    });
		});




</script>
<script type="text/javascript">
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
</script>

 <script>
 function DakReDistribute(value,redistributeRedirect,fromdate,todate){
	 $('#dakReDistributeId').val(value);   
	 $('#actionData').val(redistributeRedirect);
	 $('#exampleModalRemark').modal('show');
	 $('#dakDetailsRedistributeformdate').val(fromdate);
	 $('#dakDetailsRedistributetodate').val(todate);
	
	 $.ajax({
			
			type : "GET",
			url : "getReDistributedEmps.htm",
			data : {
				
				dakId: value
				
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
			var html = '';
			var selid='Employees';
			var count=1;
			var employeeid=[];
			for (var c = 0; c < consultVals.length; c++) {
			    var Temp = selid + (c+1);
			    html += '<span style="margin-left:4%" id="'+ Temp +'">'+count+'.'+consultVals[c][1]+' , '+consultVals[c][2]+'</span><br>';
			    count++;
			    employeeid.push(consultVals[c][0]);
			}
			$('#ReDistributeEmpId').val(employeeid);
			$('#ReSample').html(html);
			
			}
	 });
			
			
 }
 
 
 function EditAction(ActionRequiredDakId,ActionForm,dakno,source,fromdate,todate,PageNumber,RowNumber) {
	$('#exampleModalActionRequiredEdit').modal('show');
	$('#ActionRequiredEditDakId').val(ActionRequiredDakId);
	$('#DakDetailedActionRequiredEditActionVal').val(ActionForm);
	$('#DakDetailedActionRequiredEditDakNo').html(dakno);
	$('#DakDetailedActionRequiredEditSource').html(source);
	$('#DakDetailesActionRequiredFromdate').val(fromdate);
	$('#DakDetailesActionRequiredtodate').val(todate);
	
	$('#PageNumber').val(PageNumber);
	$('#RowNumber').val(RowNumber); 
	
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

for (var c = 0; c < Data.length; c++) {
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
}

$('.selectpicker').selectpicker('refresh');
		    }
		  }//success close
		});//ajax close
}
 </script>
 <script>
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
 </script>
 <script>
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
</script>
<script>
//onload function for Status Filteration
 $(document).ready(function(){
	  var StatusFilterationVal = "<%=statusFilteration%>";

	  if(StatusFilterationVal !== 'null' && StatusFilterationVal !== ''){
	   // Set the value of the hidden input field to the loaded button's value
	    document.getElementById("StatusFilterValId").value = StatusFilterationVal;
	   
	   //Highlist selected Button by blue background
	    var selectedButton = document.getElementById(StatusFilterationVal);
	    if (selectedButton) {
	    	console.log('reacheddSelectedd');
	        selectedButton.classList.add("raise");
	      }
	  }else{
		  console.log('statusFilteration val not found');
	  }
}); 

//onclick function for Status Filteration
function setStatus(value) {
		    // Set the value of the hidden input field to the clicked button's value
		    document.getElementById("StatusFilterValId").value = value;
		    $('#myform').submit();
}

//URL you are trying to access in your JavaScript code is external to your project and is hosted on a different domain, 
//you may encounter a Same-Origin Policy issue, which prevents web pages from making requests to domains 
//other than the one that served the web page. This is a security measure implemented by web browsers to prevent potential security vulnerabilities.
//If the external server supports JSONP (JSON with Padding), you can use JSONP to make cross-domain requests. This method requires the external server to return data wrapped in a function call.
/* function testSMS() {
	console.log('SMS Test Initiated');
	$.ajax({
	    type: "GET",
	    url: "proxySmsSender.htm", // Endpoint on your Spring Boot server acting as a proxy
	    data: {
	        msg: "Test message by team LRDE-DMS",
	        mobile: "8971728480"
	    },
	    success: function (response) {
	        console.log("SMS status request sent for MobileNo: 8971728480");
	        // Handle the response if needed
	    },
	    error: function (xhr, status, error) {
	        console.error("Failed to send SMS for MobileNo: 8971728480");
	        console.error("Error: " + error);
	    }
	});
} */


</script>
	<script>
	        // Get PageNo and Row from JSP attributes
	        <%-- var pageNoNavigate = <%=PageNo%>; --%>
	        var rowToHighlight  = <%=Row%>;
	        if(rowToHighlight!=null){
		        document.addEventListener("DOMContentLoaded", function () {
		        	  // Navigate to the specified page
		           /*  navigateToPage(pageNoNavigate); */
		        	
		            // Highlight the specified row
		            highlightRow(rowToHighlight);

		        });
	        }
		        
		        function highlightRow(count) {
		        	var rowElement = document.querySelector('[data-row-id="row-' + count + '"]');
		          	console.log("afsdadasd"+count);
		        	if (rowElement) {
		          
			              	console.log("afsdadasd");
			                rowElement.scrollIntoView();
		            	
			                // Apply the glow animation directly to the element's style
		                	console.log("sdfsxdcf"+count);
		                         rowElement.style.animation = "glow 2s infinite"; // Adjust the duration as needed (in seconds)
		        	}
		        }
	  </script>
	  
</html>