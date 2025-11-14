<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

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

.AssignedEmpDeleteBtn{
background-color:red;
border: none !important;
border-radius: 6px;
cursor: pointer !important;
margin-right: 10px;
width: 25%;
}
.AssignedEmpDeleteBtn:focus {
    outline: none;
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
	/* transition: all 0.3s ease-out; */
	/* Remove the transition property */
      transition: none;
         backface-visibility: hidden;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	  /* Float the expanded menu down */
    float: none;
    clear: both;
    display: block;
    /* Set a fixed width for the expanded state */
    width: auto;
    /* Add overflow: visible to ensure the content is visible when expanded */
    overflow: visible;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 10;
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
  
#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
}

.MsgByDir{
color:#2196F3!important;
font-size:12px;
}

.replyOfCSWData {
  color: black;
  user-select: all;
  outline: none;
  height: 51px;
/*   border: 1px solid grey; */
  text-align: left;
  padding-left: 10px;
  margin-left: 30px;
  width: 700px !important;
 float: left; 
 box-shadow: rgba(14, 30, 37, 0.32) 0px 0px 0px 3px;
border-radius:3px!important;
  
}

.replyOfCSWData button,
.replyOfCSWData span {
  user-select: none;
}

.CSWAttachDownloadTbl td {
    padding: 0.2rem;
    border:none;
}
.cswempidSelect{
width: 700px !important;
margin-top: -20px !important;
}

.seekResponseempidSelect{
width: 565px !important;
margin-top: -20px !important;
}


#DirectorApprovalSelVal option.selectpickerSimple {
    border-radius: 6px !important; 
}

.table a:hover,a:focus {
   text-decoration: underline !important; 
}

.HighlightHighPrior{
    background: rgb(223 42 42 / 50%)!important;
}

.all {
    color:grey;
    font-weight: 700;
    font-size:16px;
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

.Favourites {
   color: rgba(0, 128, 0, 0.9);
    font-weight: 700;
    font-size:16px;
}

.Urgent{
 color: rgba(242, 23, 7);
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


.star {
    visibility:hidden;
    font-size:25px;
    margin-top: -2px;
    cursor:pointer;
}

.star:before {

content: "\2605";
position: absolute;
color:#CDCDCD;
visibility:visible;
     
}
.star:checked:before {
  /* color:#FFA600; */
  color:#FFD23F;
   position: absolute;
  animation: fav 600ms ease;
}

@keyframes fav {
  60% {
    transform: scale(1.5);
  }
  90% {
    transform: scale(1);
  }
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

.custom-selectEnote {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 330px !important;
}

.custom-selectEnote select {
  /* Hide the default select dropdown arrow */
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  /* Add some padding to make room for the arrow */
  padding-right: 20px;
  width: 100%;
  height: 10px;
  /* Customize the look of the dropdown */
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: #fff;
 
}

/* Add a custom arrow */
.custom-selectEnote::after {
  content: '\25BC'; /* Unicode for downward-pointing triangle or arrow */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  /* Customize the arrow appearance */
  font-size: 10px;
  color: #666;
}  

.ReplyReceivedMail{
width: 430px !important;
margin-top: 0px !important;
}

.Signatory {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 350px !important;

}

.Signatory select {
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
.Signatory::after {
  content: '\25BC'; /* Unicode for downward-pointing triangle or arrow */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  /* Customize the arrow appearance */
  font-size: 10px;
  color: #666;
}  

</style>
<meta charset="ISO-8859-1">
<title>DAK Received List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style type="text/css">
.highlighted {
   background-color: yellow;
   /* You can customize the highlighting styles */
}
textarea {
   resize: none; /* Disable user resizing */
   overflow-y: hidden; /* Hide vertical scrollbar */
   min-height: 50px; /* Set a minimum height */
}
</style>
</head>
<body>
<%
Object[] Username=(Object[])request.getAttribute("Username");
long EmpId =(Long)session.getAttribute("EmpId"); 
String FileName =(String)request.getAttribute("FileName"); 
List<Object[]> sourceList=(List<Object[]>)request.getAttribute("SourceList");
%>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-6 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Received List ( <%if(Username!=null && Username[0]!=null && Username[1]!=null ){ %>  <%=Username[0]+" , "+ Username[1] %><%}else{ %>--<%} %> )</h5>
			</div>
			<div class="col-md-6 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Received List</li>
				  </ol>
				</nav>
			</div>			
		</div>
		</div>
		<%
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		List<Object[]> dakReceivedList=(List<Object[]>)request.getAttribute("dakReceivedList");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		
		List<Object[]> InitiatedByEmployeeList=(List<Object[]>)request.getAttribute("InitiatedByEmployeeList");
		
		List<Object[]> MailReceivedEmpDetails=(List<Object[]>)request.getAttribute("MailReceivedEmpDetails");
		
		Object[] MailSentDetails=(Object[])request.getAttribute("MailSentDetails");
		
		String statusFilteration =(String)request.getAttribute("statusValue");
		//Redir
		String PageNo=(String)request.getAttribute("pageNoRedirected");
		String Row=(String)request.getAttribute("rowRedirected");
	
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
		
			<!-- Loading  Modal -->
	
<div id="spinner" class="spinner">
                <img id="img-spinner" style="width: 300px;height: 300px; margin-right: 150px;" src="view/images/load.gif" alt="Loading"/>
                </div>
		<!-- Loading  Modal End-->
		</div>
	<!-- 	<div class="page card dashboard-card" style="width: 99%">      -->     
<div class="card loadingCard" id="loadingCard"  style="display:none;">


<div class="card-header" style="height: 2.7rem">
  <form action="DakReceivedList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <div class="row">
      <div class="float-container" style="float: right;">
      
        <div id="label1" style="width: 100%; text-align: left;margin-top: -1rem;">
         <table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 13px;text-align: center"> 
									   <button type="button" class="btn btn-sm statusBtn" id="All" onclick="setStatus('All')"><span class="all"></span><span class="all">&nbsp;All&nbsp;</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="Ongoing" onclick="setStatus('Ongoing')"><span class="ongoing">OG</span><span class="ongoing"> &nbsp;:&nbsp; On Going </span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="OngoingDelay" onclick="setStatus('OngoingDelay')"><span class="ongoingdelay">DO</span><span class="ongoingdelay">&nbsp; :&nbsp;Delay - On Going</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="Favourites" onclick="setStatus('Favourites')"><span class="Favourites">&nbsp; &nbsp;Favourites</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="Urgent" onclick="setStatus('Urgent')"><span class="Urgent">&nbsp; &nbsp;Urgent</span></button>&nbsp;&nbsp;
                                       <!-- <button type="button" class="btn btn-sm statusBtn" id="Completed" onclick="setStatus('Completed')"><span class="completed">CO</span><span class="completed">&nbsp; :&nbsp; Completed</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="CompletedDelay" onclick="setStatus('CompletedDelay')"><span class="completeddelay">CD</span><span class="completeddelay">&nbsp; :&nbsp; Completed with  Delay</span></button>&nbsp;&nbsp; -->
										<input type="hidden" id="StatusFilterValId" name="StatusFilterVal" value="">
									</p>
								</td>									
							</tr>
							</thead>
							</table>
        </div>
        
        <div class="label2" style="width: 50%; float: right;">
          <div class="row Details">
            <div class="col-1" style="font-size: 16px; padding-left:120px; ">
              <label for="fromdate" style="text-align: center;font-size: 16px;width:50px;  ">From &nbsp;&nbsp;</label>
            </div>
            
            <div class="col-4" style="padding-left:80px;">
              <input type="text" style="width:113px;margin-top: -0.6rem;  " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            
            <div class="col-1" style="font-size: 16px; padding-left:30px; ">
              <label for="todate" style="text-align: center;font-size: 16px;width:20px; ">To &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            <div class="col-4" style="padding: 0; ">
              <input type="text" style="width:113px;margin-top: -0.6rem; " class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <!-- <div class="col-1"></div> Empty column for spacing -->
          </div>
        </div>
      </div>
    </div>
  </form>
</div>

<div class="card-body" style="width: 99%">
					<div class="table-responsive" style="overflow:hidden;">
					<form action="#" method="post"  id="DakReceivedListForm">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
					<input type="hidden" name="viewfrom" value="DakReceivedList">
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
								<tr >
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">DAK Id</th>
									<th style="text-align: center; width: 5%;">Head</th>
									<!-- <th class="text-nowrap">Priority</th> -->
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">Ref No & Date </th>
									<th class="text-nowrap" style="width:10%;">Action Due</th>
								    <th class="text-nowrap">Subject</th> 
									<th class="text-nowrap">DAK Status</th>
									<th class="text-nowrap">Status</th>
									<th style="width: 170px;">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								 int count=1;
								if(dakReceivedList!=null && dakReceivedList.size()>0){
									for(Object[] obj:dakReceivedList){
										
									    
										   long reassign=0;
										   if(obj[25]!=null){
											reassign=Long.parseLong(obj[25].toString());
										   }
										   
										   
										  	  //obj[33] - CountOfAllMarkers//obj[31] - CountOfActionMarkers//obj[34] - CountOfMarkersAck//obj[32] - CountOfMarkersReply
			                          	    String StatusCountAck = null;
			                          		String StatusCountReply = null;

			                                  if (obj[5] != null && !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
			                                      && !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
			                                      && !obj[5].toString().equalsIgnoreCase("FP")) {
			                                 //Ack Count
			                                      if (obj[32] != null && Long.parseLong(obj[32].toString()) == 0 && obj[34] != null && Long.parseLong(obj[34].toString()) > 0) {
			                                    	  StatusCountAck = "Acknowledged<br>["+obj[34]+"/"+obj[33]+"]";
			                                      }
			                                 //Reply Count
			                                      if (obj[34] != null && Long.parseLong(obj[34].toString()) > 0 && obj[31] != null && Long.parseLong(obj[31].toString()) > 0
			                                          && obj[32] != null && Long.parseLong(obj[32].toString()) > 0) {
			                                    	  StatusCountReply  = "Replied<br>["+obj[32]+"/"+obj[31]+"]";
			                                      }
			                                  }    
										  
								          /////////////////////////////////////////
										   %>

								<tr  data-row-id=row-<%=count %> id=buttonbackground<%=obj[0]%> <%if(obj[35]!=null && Long.parseLong(obj[35].toString())==3){ %> class="HighlightHighPrior" <%}%> >
									<%
									int Favourites=Integer.parseInt(obj[36].toString()); %>
									<td style="width:20px;"> <!-- Increase the width as needed -->
									<%if(obj[36]!=null && Favourites>0) {%>
   <input id="star1" class="star" type="checkbox" title="Add to favourites" checked="checked" value="<%=obj[18]%>"> 
  <% }else{ %>
   <input id="star1" class="star" type="checkbox" title="Add to favourites" value="<%=obj[18]%>"> 
   <%} %>
     <span style="margin-left: 5px;"><%=count %></span> <!-- Add more space between the checkbox and the count -->
    
</td>
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
                                     <td style="text-align: center;width:10px;"><%if(obj[20]!=null){ %><%=obj[20].toString() %><%}else{ %>-<%} %></td>
 					                <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td class="wrap" style="width: 50px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
									<td  class="wrap" style="text-align: left;width:270px;"><%if(obj[14]!=null){%><%=obj[14]%><%}else{ %>-<%} %></td> 
									<td  class="wrap" style="text-align: left;width:80px;text-align: center;font-weight:bold;">
								
									   <%if(obj[7]!=null) {%>
									
									     <%if(StatusCountAck!=null) {%>
									      <%=StatusCountAck%>
									     <%}else if(StatusCountReply!=null) {%>
									      <%=StatusCountReply%>
									     <%}else{%>
									      <%=obj[7].toString() %>
									    <%}%>
									    <%} %>
									
						
									</td>
									<td  class="<%=obj[13]%>" style="text-align: left;width:40px;text-align: center;font-weight:bold;"><%if(obj[13]!=null) {%><%=obj[13].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;font-weight:bold" id="SelectButton">
								 <%
								 
								 int itemsPerPage = 15;
                               // Calculating the page number based on the count and itemsPerPage
								int pageNumber = (count - 1) / itemsPerPage + 1;

							%>
	 <input type="hidden"  name=RedirPageNo<%=obj[0]%>  id=PageNoValFetch<%=obj[0]%> value="<%=pageNumber%>">
	 <input type="hidden"  name=RedirRow<%=obj[0]%>     id=RowValFetch<%=obj[0]%>    value="<%=count%>">
<!--------------DAK Acknowledgment Button Start ------------------------------------------>							         
							          <%if(obj[17]!=null && obj[17].toString().equalsIgnoreCase("N")){ %> 
						 
									     <button id="button-upload" type="submit" class="btn btn-sm icon-btn"
									      formaction="DakAck.htm"  name="dakIdSel" value="<%=obj[0]%>" formmethod="POST"
									       data-toggle="tooltip" data-placement="top" title="Ack">
 										          <img alt="Ack" src="view/images/acknowledgement.png">
										</button>
 							          <%} %>
<!--------------DAK Acknowledgment Button End ------------------------------------------------------------>	

<!--------------DAK Preview Button Start ----------------------------------------------------------------->				          
 							          
 									  <%if(obj[17]!=null && obj[17].toString().equalsIgnoreCase("Y")){ %>
 									  	<%
 									  	/*Marker Reply  */
 									  	/* String ReplyCounts = null;
 									  	     if(obj[22]!=null && obj[23]!=null && obj[24]!=null){
 									  	        ReplyCounts = obj[22].toString()+"#"+obj[23].toString()+"#"+obj[24].toString();
 									  	     }else{
 									  	    	ReplyCounts = "NA";
 									  	     }
 									  	     String CWAssignedReplyId = null; 
 									  	 if(obj[25]!=null){
 									  		CWAssignedReplyId = obj[25].toString();
 									  	}else{
 									  		CWAssignedReplyId = "NA";
									  	     } */
 									  	     
 									  	%>
									  <button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]%> value="<%=obj[0] %>"  
									    formaction="DakReceivedView.htm" formmethod="post" formtarget="_blank" onclick="highlightButton(<%=obj[0]%>)"
									      data-toggle="tooltip" data-placement="top" title="Preview"> 
 										 <img alt="mark" src="view/images/preview3.png">
								       </button>
 										  <%} %>
<!--------------DAK Preview Button End -----------------------------------------------> 										  
 										  
								
 									   <!--------------DAK Marker Reply Button Start -----------------------------------------------> 	
 					 <%if("ACTION".equalsIgnoreCase(obj[9].toString().trim()) &&  obj[17]!=null  &&  
 					 obj[17].toString().equalsIgnoreCase("Y") && obj[23]!=null && Long.parseLong(obj[23].toString()) <= 0 ){ %>
 					  <input type="hidden" id="subject<%=obj[0] %>" value="<%=obj[14] %>">
 							 <button type="button" class="btn btn-sm icon-btn"  onclick="return replyModalOfMarker('<%=obj[0] %>','<%=EmpId%>','<%=obj[25] %>','<%=obj[8] %>','<%=obj[3] %>','<%=obj[18] %>')" 
 								data-toggle="tooltip" data-placement="top" title="Reply">
 								<img alt="Reply" src="view/images/replyy.png">
							</button>
 										    <%} %>   
<!--------------DAK Marker Reply Button End -------------------------------------------------> 		
 									   
<!--------------DAK Marker Assign Button Start -----------------------------------------------> 									   
 									   	<%if(obj[17]!=null && obj[17].toString().equalsIgnoreCase("Y") && !obj[5].toString().equalsIgnoreCase("RM") && !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("FP") && !obj[5].toString().equalsIgnoreCase("AP") && !obj[5].toString().equalsIgnoreCase("DC") ){ %>
 								         <button type="button" class="btn btn-sm icon-btn" onclick="return Assign(<%=obj[0]%>,<%=obj[18] %>,'<%=obj[8] %>','<%=obj[3] %>','DakReceivedList')"
 										  data-toggle="tooltip" data-placement="top" title="Assign">
 											<img alt="Assign" src="view/images/Assign.png">
										 </button>
										
 										<%} %>
<!--------------DAK Marker Assign Button End -----------------------------------------------> 										
 							
<!--------------Message by director Start---------------------------------------------------->   										
 								     <%if(obj[21]!=null && !obj[21].toString().equalsIgnoreCase("N")){ %>
 										           <div style="display: flex; flex-direction: column; align-items: center;">
 										  <span class="MsgByDir">
 										  <%if(obj[21].toString().equalsIgnoreCase("D")){ %>
 										  Pls Discuss With Director
 										   <%}else if(obj[21].toString().equalsIgnoreCase("E")){ %>
 										   Noted By Director
 										   <%} %>
 										  </span>
 										  </div>
 										  <%} %>
<!--------------Message by director End ---------------------------------------------------->  										  		
 										
<!--------------CW Status start ---------------------------------------------------->  											  
 								<%if(obj[19]!=null  && obj[19].toString().equalsIgnoreCase("Y")){ %>
 								<span <%if(obj[19]!=null  && obj[19].toString().equalsIgnoreCase("Y") &&  obj[25]!=null && Long.parseLong(obj[25].toString())>0) { %> style="color:#006400;"<%}else{ %>style="color:blue;"<%} %>>
 								 CW
 								 </span>
 								<%} %>
<!--------------CW Status end  ---------------------------------------------------->  	
<!--------------DAK Marker SeekResponse Button Start -----------------------------------------------> 									   
 									   	<%if( obj[17]!=null && obj[17].toString().equalsIgnoreCase("Y") && !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("FP") && !obj[5].toString().equalsIgnoreCase("RM") && !obj[5].toString().equalsIgnoreCase("AP") && !obj[5].toString().equalsIgnoreCase("DC")){ %>
 								         <button type="button" class="btn btn-sm icon-btn" onclick="SeekResponse(<%=obj[0]%>,<%=obj[18] %>,'<%=obj[8] %>','<%=obj[3] %>','DakReceivedList')"
 										  data-toggle="tooltip" data-placement="top" title="SeekResponse">
 											<img alt="SeekResponse" src="view/images/SeekResponse.png">
										 </button>
										
 										<%} %>
<!--------------DAK Marker Assign Button End -----------------------------------------------> 	
 
<!-------------If Closing Authority O---------------------------------------------------->  	 

      <!--**** Marker Close WITHOUT DIRECTOR APPROVAL or  Director Approval selected by marker sending Start---------------------------------------------------->	            
 	                       
 									
 		<!-- No need of Action check as AP update is never allowed for records -->								 
 				 <!--### ALLOW P&CDO CLOSE WHEN obj[5] is not equal to DC and !=AP because with AP below close button will come 
 				 <!--### ALLOW P&CDO CLOSE WHEN obj[29] Closing Authority O-->
 				 <!--### ALLOW P&CDO CLOSE WHEN obj[17] is  equal to Y means id DAK is acknowledged-->
 				 <!--### ALLOW P&CDO CLOSE WHEN obj[18] sending details of marker who is Closing -->
 				 <!--### ALLOW P&CDO CLOSE WHEN obj[26] MarkerAction is A don't allow Marker Action N type-->
 				 <!--### ALLOW P&CDO CLOSE WHEN obj[23] i.e replyCount of loggedin EmpId marker > 0 then show DAK Close-->
 				
 					 <%if(
 							(!obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("RM") && !obj[5].toString().equalsIgnoreCase("AP")
 							 && obj[29]!=null && !obj[29].toString().equalsIgnoreCase("P")
 							 && obj[17]!=null && obj[17].toString().equalsIgnoreCase("Y") && obj[18]!=null
 							 && obj[26]!=null && obj[26].toString().equalsIgnoreCase("A") 
 							 && obj[23]!=null && Long.parseLong(obj[23].toString())>0 
 							 )
 								 
 							  
 							){%>
 								
 							<button type="button" class="btn btn-sm icon-btn" name="DakCloseSelection"  
 									formaction="DakClose.htm"  id="DakCloseByMarker" 
 									 data-toggle="tooltip" data-placement="top" data-original-title="Dak Close" 
                                     onclick="return DakMarkerCloseSelection('<%=obj[0]%>','<%=obj[5]%>','<%=obj[18]%>','<%=obj[31]%>','<%=obj[32]%>')"
                                     ><img alt="mark" src="view/images/dakClose.png"> 
 							</button>	
 									 
 							 <%}%>
 		 <!--**** Marker Close WITHOUT  DIRECTOR APPROVAL or  Director Approval selected by marker sending End---------------------------------------------------->	            
 	        				 
 					 	 
 	  	 <!--@@@@ Awaiting message if marker forwarded for director approval Start---------------------------------------------------->	
 	  	 
 	  	    				<%if( obj[5].toString().equalsIgnoreCase("RM") &&    !obj[5].toString().equalsIgnoreCase("AP") && !obj[5].toString().equalsIgnoreCase("DC") 
 	  	    										 && obj[30]!=null && Long.parseLong(obj[30].toString())>0){ %>
 	  	    								 <span style="font-weight:bold;font-size:10px;color:green;padding-right:10px;padding-left:10px;">
 								awaiting dir approval
 								</span>		
 								 <%}%>
 								 
 	    <!--@@@@ Awaiting message if marker forwarded for director approval End---------------------------------------------------->							 
 							 
        <!--**** Marker Close WITH DIRECTOR APPROVAL Start---------------------------------------------------->	            
 	                          <%/*********If Dir Approved with Comment than Dak Close will be available with DakApprovedCommtPopUp *******/
 									String ApprovedCommtData = "--";
 									String ApprovedCommtCheckData = "NA";
 									if(obj[5].toString().equalsIgnoreCase("AP")&& obj[27]!=null){
 										ApprovedCommtCheckData = "ApproveCommtPopUp";
 										ApprovedCommtData = obj[27].toString();
 									}
 									/****************/%>
 									
 				 <!--### ALLOW Marker With AP CLOSE WHEN obj[5] is not equal to DC and !=AP because with AP below close button will come 
 				 <!--### ALLOW Marker With AP CLOSE WHEN obj[29] Closing Authority O-->
 				 <!--### ALLOW Marker With AP CLOSE WHEN obj[17] is  equal to Y means id DAK is acknowledged-->
 				 <!--### ALLOW Marker With AP CLOSE WHEN obj[18] MarkingId of marker who is Closing -->
 				 <!--### ALLOW Marker With AP CLOSE WHEN obj[26] MarkerAction is A don't allow Marker Action N type-->
 				 <!--### ALLOW Marker With AP CLOSE WHEN obj[23] i.e replyCount of loggedin EmpId Marker > 0 then show DAK Close-->
 				 <!--### ALLOW P&CDO CLOSE WHEN obj[30] DakAssignApproveForwarderId > 0 
 				                                        AND THEN CHECK DakAssignApproveForwarderId = LoggedINEmpId>-->
 				
 					 <%
 					 if( obj[41]!=null && obj[42]!=null && obj[41].toString().equalsIgnoreCase(obj[42].toString()) &&
 							(obj[5].toString().equalsIgnoreCase("AP") && !obj[5].toString().equalsIgnoreCase("DC") 
 							 && (obj[29]!=null && (obj[29].toString().equalsIgnoreCase("O") || obj[29].toString().equalsIgnoreCase("K") || obj[29].toString().equalsIgnoreCase("Q") || obj[29].toString().equalsIgnoreCase("R") || obj[29].toString().equalsIgnoreCase("A") ))
 							 && obj[17]!=null && obj[17].toString().equalsIgnoreCase("Y") && obj[18]!=null
 							 && obj[26]!=null && obj[26].toString().equalsIgnoreCase("A") 
 							 && obj[23]!=null && Long.parseLong(obj[23].toString())>0 
 							 && obj[30]!=null && Long.parseLong(obj[30].toString())>0
 							 && Long.parseLong(obj[30].toString())==EmpId
 							 )
 								 
 							  
 							){%>
 								<input type="hidden" name="WithApprovalDakClose" value="DakRecievedListRedirect">
 								<input type="hidden"name="DakIdForClose" value="<%=obj[0] %>" >
 							<button type="button" class="btn btn-sm icon-btn" 
 									formaction="DakClose.htm"  id="DakCloseByMarkerAfterApproval"
 									 data-toggle="tooltip" data-placement="top" data-original-title="Dak Close" 
 									 data-ApprovedCommt-value="<%=ApprovedCommtData%>"
                                     onclick="return MarkerCloseWithDirApproval('<%=obj[0]%>','<%=obj[5]%>','<%=obj[18]%>','<%=ApprovedCommtCheckData%>', this)"
                                     ><img alt="mark" src="view/images/dakClose.png"> 
 							</button>	
 									 
 							 <%}%>
 									
 	 <!--*** Marker Close WITH DIRECTOR APPROVAL Start---------------------------------------------------->	    
 	 

 	  	    								
<!--------------If Closing Authority O Marker Close End---------------------------------------------------->	 						
 				<%if(obj[9]!=null && obj[9].toString().equalsIgnoreCase("ACTION") && obj[17]!=null && obj[17].toString().equalsIgnoreCase("Y") && obj[22]!=null && Integer.parseInt(obj[22].toString())==0 && !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("AP") && !obj[5].toString().equalsIgnoreCase("DC") && obj[37]!=null && Long.parseLong(obj[37].toString())==0){ %>
					     <input type="hidden" id="subjectid<%=obj[0] %>" value="<%=obj[14] %>">
					     <button type="button" class="btn btn-sm icon-btn"  onclick="return EnotereplyModalOfMarker('<%=obj[0] %>','<%=EmpId%>','<%=obj[25] %>','<%=obj[8] %>','<%=obj[3] %>','<%=obj[18] %>','<%=obj[4] %>','<%=obj[6] %>')" 
 								data-toggle="tooltip" data-placement="top" title="EnoteReply">
 								<img alt="eNoteReply" src="view/images/enotereply.jpg">
							</button>
				<%}%>
				
				
				 <%if(obj[5]!=null && obj[38]!=null && obj[5].toString().equalsIgnoreCase("AP") && obj[41]!=null && obj[42]!=null && !obj[41].toString().equalsIgnoreCase(obj[42].toString())){ %>
 							  <input type="hidden" id="subject<%=obj[0] %>" value="<%=obj[14] %>">
 								 <button type="button" class="btn btn-sm icon-btn" name="MainDakCreateId" onclick="replyMainLabDakReply('<%=obj[0] %>','<%=obj[38] %>','<%=obj[39] %>','<%=obj[40] %>','<%=obj[8] %>','<%=obj[3] %>')"
 									 data-toggle="tooltip" data-placement="top" title="" data-original-title="Outside Lab Reply" > 
									<img alt="mark" src="view/images/auto-reply.png"> 
 										  </button>	 
 							<%} %>					
 		</td>
 										       
		</tr>
	<%count++;} %>
<%} %>
							</tbody>
						</table>
                       </form>
					</div>
					
					
	<!-- ------------------------------------------------------------------------------------------Assign Modal Start ------------------------------------------------------------------------------------------>
					

   <div class="modal fade my-modal" id="exampleModalAssign"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" style="min-width: 55% !important; min-height: 80vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" style="height: 600px;">
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
  	      			<input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
					<input type="hidden" id="PageRedirByAssign"  name="PageRedireData" value="">
					<input type="hidden" id="RowRedirByAssign" name="RowRedireData" value="">

					
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return DakAssignSubmit()"> 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		<form action="DakAssignUpdate.htm"  method="POST" id="DakAssignUpdate">
	  	      		<div align="center" class="row" id="DakAssignedEmployeeAppend" style="display:block!important" >
	  	      		</div>
	  	      		<br>
	  	      	   <!-- For DAK Distribute only-->
	  	              <input type="hidden" name="EmpIdAssignUpdate" id="EmpIdAssignUpdate" value="" />
	  	              <input type="hidden" name="DakIdAssignUpdate" id="DakIdAssignUpdate" value="" />
	  	              <input type="hidden" name="RemarksAssignUpdate" id="RemarksAssignUpdate" value="" />
	  	              <input type="hidden" name="RedirectValue" id="AssignRedirectValue" value="">
	  	              <input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					  <input type="hidden" name="toDateFetch" value=<%=toDt %>>
					  <input type="hidden" id="AssignPageRedirByAssign"  name="PageRedireData" value="">
					  <input type="hidden" id="AssignRowRedirByAssign" name="RowRedireData" value="">
	  	      	
	  	      	   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
  	      			</div><br><br><br>
  	      			<div class="col-md-3">Remarks</div>
  	      			<div class="col-md-9">
  	      				<textarea class="form-control" style="height: 100px;;"   name="SeekResponseremarks"  id="SeekResponseremarks" required="required"  maxlength="255" > </textarea>
  	      			</div>
  	      			<input type="hidden" name="DakMarkingId" id="SeekResponseDakMarkingdakId" value="">
  	      			<input type="hidden" name="DakMarkingIdsel" id="SeekResponseDakMarkingIdsel" value="">
  	      			<input type="hidden" name="SeekResponseRedirectVal" id="SeekResponseRedirectVal" value=""> 
  	      			<input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
					<input type="hidden" name="PageValBySeekRepsonse" id="PageRedirBySeekRepsonse" value="">
  	      			<input type="hidden" name="RowValBySeekRepsonse" id="RowRedirBySeekRepsonse" value=""> 
  	      			<input type="hidden" name="seekFrom" value="R">
  	      		
					
					
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
  
  
  <!-- ---------------------------------------------------------------------------------------------ReAssign Modal Start ---------------------------------------------------------------------------------->
  
  <div class="modal fade my-modal" id="exampleModalReAssign"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" >
 	    <div class="modal-content" style="height: 400px;">
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px; ">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color:white;">DAK ReAssign</span></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: white;">DAK Id:</span> &nbsp;&nbsp;<span style="color: white;" id="ReAssignDakNo"></span> &nbsp;&nbsp;&nbsp;<span style="color: white;">Source : </span><span style="color: white;" id="ReAssignSourcetype"></span></h5> </div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" ><br>
  	      	<form action="DakReAssign.htm" method="post" id="ReAssignForm">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="row">
  	      		<div class="col-md-3">Facilitator</div>
  	      		<div class="col-md-9">
  	      			<select class="form-control selectpicker cswempidSelect"  id="ReAssignDakCaseWorker" multiple="multiple" data-live-search="true"  required="required"  name="DakCaseWorker">
  	      				
  	      				</select>
  	      			</div><br><br><br>
  	      			<div class="col-md-3">Remarks</div>
  	      		<div class="col-md-9">
  	      				<textarea class="form-control" style="height: 100px;;"   name="remarks"  id="ReAssignremarks" required="required"  maxlength="255" > </textarea>
  	      			</div>
  	      			<input type="hidden" name="DakMarkingId" id="ReAssignDakMarkingdakId" value="">
  	      			<input type="hidden" name="DakMarkingIdsel" id="ReAssignDakMarkingIdsel" value="">
  	      			<input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return DakReAssignSubmit()"> 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
  
  <!-- ------------------------------------------------------------------------------------------ReAssign Modal End --------------------------------------------------------------------------------->
 
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
			  	      		<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_clone">
			  	      			<td><input class="form-control" type="file" name="dak_reply_document"  id="dakdocumentreply" accept="*/*"></td>
			  	      				<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
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
				<input class="form-control" type="text" name="ReplyPersonSentMail" id="ReplyPersonSentMail" readonly="readonly" <%-- value="<%if(MailSentDetails!=null && MailSentDetails[0]!=null){%><%=MailSentDetails[0].toString()%><%}%>" --%>>
				</div>
  	      		<div class="col-md-3">
  	      		<label style="font-size: 15px;"><b>Receiver MailId</b></label>
  	      			<select class="form-control selectpicker ReplyReceivedMail "  id="ReplyReceivedMail" multiple="multiple" data-live-search="true"  required="required"  name="ReplyReceivedMail">
  	      				<option value="select">Select</option>
  	      				 <%-- <%if (MailReceivedEmpDetails != null && MailReceivedEmpDetails.size() > 0) {
												for (Object[] obj : MailReceivedEmpDetails) {
											%>
											<option value="<%=obj[2]%>"><%=obj[2].toString() %></option>
											<%}}%>  --%>
  	      				</select>
  	      			</div>
  	      		</div>
  	      		
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  <input type="hidden" name="dakIdValFrReply"  id="dakIdOfReply" value="" >
  	      		    <input type="hidden" name="EmpIdValFrValue" id="empIdOfReply" value="">
  	      		    <input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
										<!-- codee -->
					<input type="hidden" name="PageRedirectData" id="PageRedirByReply" value="">
  	      		    <input type="hidden" name="RowRedirectData" id="RowRedirByReply" value="">
  	      		    
					<input type="hidden" id="AttachsFromDakAssigner" name="AttachmentsFileNames" value="">

					<input type="hidden" id="RedirectValFrmPending" name="RedirectValFrmPending" value="RedirToDakReceivedList">
					
					<input type="hidden" id="ReplyMailSubject" name="ReplyMailSubject" value="">
					<input type="hidden" id="HostType" name="HostType" value="">
	
					
  	      		    
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


<!----------------------------------------------------  Enote Reply  Modal Start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="exampleModalEnoteReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 100% !important; align-items: stretch;" >
 	    <div class="modal-content" >
 	    <div class="modal-header" style="background-color: #114A86;">
 	     <span style="margin-top: 8px; margin-left:30px; color: white;">Draft Required</span>&nbsp;&nbsp;
			   <label style="margin-top: 13px;">
			    <input type="radio" name="draftRequired" value="N" checked="checked"> &nbsp;&nbsp;<span style="color: white">No </span>&nbsp;&nbsp;
			  </label>
			  <label style="margin-top: 13px;">
			    <input type="radio" name="draftRequired" value="Y">&nbsp;&nbsp; <span style="color: white">Yes</span>&nbsp;&nbsp;
			  </label>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div><br>
  	      
  	      <form action="DakEnoteReplyAddSubmit.htm" method="POST" id="myform1" data-action="DakEnoteReplyAddSubmit.htm" enctype="multipart/form-data">
 	  	 <div class="col-md-12" style="flex: none !important;">
 	  	 <input type="hidden" name="IsDraftVal" id="isDraft">
		   <div class="page card dashboard-card" style="width: 98.5%;">
			<div class="card-body">
			<div class="row">
			<div class="col-md-2" style="display: inline-block;">
			<div class="form-group">
				<label class="control-label" style="float: left;">Ref No <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
				<input type="text" class="form-control" id="EnoteRefNo" value="" name="RefNo" >
			</div> 
			</div>
			<div class="col-md-3">
			<div class="form-group">
			<label class="control-label" style="float: left;">Subject <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control" id="EnoteSubject" value="" name="Subject" maxlength="255">
			</div>
			</div>
			<div class="col-md-3">
   			<div>
   			<table>
			<tr ><td><label style="font-weight:bold;font-size:16px;">Document :</label></td>
			<td align="right"><button type="button" class="Enotetr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			</tr>
			<tr class="Enotetr_clone">
				<td><input class="form-control" type="file" name="dakReplyEnoteDocument"  id="EditdakEnoteDocument" accept="*/*" ></td>
					<td><button type="button" class="Enotetr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			 			</tr>	
			</table>
				</div>
				</div>
			</div>
			</div>
		</div>
		</div><br>
 	    <div class="col-md-12 row" id="mainRow" style="flex:none !important;">
	    <div class="col-md-6" id="eNoteContent" style="display: inline-block;">
			<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #114A86; padding: 5px; height: 40px;">
			<div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color:white;">DAK eNote Reply</span></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      <b><span style="color: white;">DAK Id:</span></b> &nbsp;&nbsp;<span style="color: white;" id="EnoteRecievedListDakNo">
		         </span> &nbsp;&nbsp;&nbsp;<b><span style="color: white;">Source :</span></b> &nbsp;&nbsp; <span style="color: white;" id="EnoteRecievedListSourceNo"></span></h5></div>
		</div>
		<div class="page card dashboard-card">
			<div class="card-body" align="center" >	
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div class="row">
				<div class="col-md-4">
				<div class="form-group">
					<label class="control-label" style="float: left;">Note No <span class="mandatory" style="color: red; font-weight: normal;">*</span> </label>
					<input type="text" class="form-control " id="NoteNo" value="" name="NoteNo" >
				</div></div>
				
				 <div class="col-md-4">
				 <div class="form-group">
				<label class="control-label" style="float: left;">Ref Date </label>
				<input type="text" class="form-control" id="EnoteRefDate" value="" name="RefDate" >
				 </div> 
				 </div> 
				 
				 <div class="col-md-4">
					<div class="form-group">
				<label class="control-label" style="float: left;">Dak Id</label>
				<input type="text" class="form-control" id="EnoteDakNo" value="" readonly="readonly" name="DakNo">
				</div>
				</div>
				</div>	
				<div class="row">
				<div class="col-md-12">
					<div class="form-group">
				<label class="control-label" style="float: left;">Reply <span class="mandatory" style="color: red; font-weight: normal;">*</span> </label>
				<textarea style="border-bottom-color: gray;width: 100%" oninput="autoResize()"  maxlength="3000" placeholder="Maximum 3000 characters" id="EnoteReply" name="Reply"></textarea>
				</div>
				</div>
				</div>
		       <div class="row" style="margin-top: 7px;">
				<div class="col-md-7">
  	      		 <label class="control-label" style=" display: inline-block; float:left; font-size: 15px;"><b>Initiated By</b></label>
			 <select class="selectpicker custom-selectEnote" id="InitiatedBy" required="required" data-live-search="true" name="InitiatedBy"  >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[0].toString()%> <% if (EmpId==Long.parseLong(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	 
				</div>
				</div>
			     <input type="hidden" id="redirval" name="redirval" value="DakEnoteAdd">
			     <input type="hidden" name="dakIdValFrReply"  id="EnotedakIdOfReply" value="" >
			     <input type="hidden" name="EnoteFrom"  id="EnoteFrom" value="M" >
		  <!-- -----------DAK MultipleCaseworkerReply Of Specific MarkerDiv Within another Modal  END--------------------------- --> 
  	      </div>
  	    </div>
  	    </div>
  	    <div class="col-md-6" style="display: none;" id="draftContentData">
		<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #114A86; padding: 5px; height:40px;">
			Draft
		</div>
		<div class="page card dashboard-card">
		<div class="card-body" align="center" >	
		<div class="row">
			<div class="col-md-4">
			<div class="form-group">
		<label class="control-label" style="float: left;">Letter Date <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control" id="DraftLetterDate" value="" name="LetterDate" >
		</div>
		</div>
		<div class="col-md-4">
			<div class="form-group">
				<label class="control-label" style="float: left;"> Destination <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
		<select class="form-control selectpicker custom-select" id="sourceid" required="required" data-live-search="true" name="DestinationId">
			<% if (sourceList != null && sourceList.size() > 0) {
		for (Object[] obj : sourceList) {
		%>
		<option value="<%=obj[0]%>"><%=obj[1]%></option>
		<%}}%>
					</select>
		     </div>
		 </div>
		 <input type="hidden" name="SourcetypeId" id="SourcetypeId" value="">
		<div class="col-md-4">
			<div class="form-group">
				<label class="control-label" style="float: left;"> Destination Type <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
				<select class="form-control selectpicker custom-select" id="SourceType" name="DestinationTypeId" data-live-search="true" required="required">
				</select>
			</div>
		</div>
		</div>
		
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Content </label>
		<textarea style="border-bottom-color: gray;width: 100%" oninput="autoResizeDraftContent()"  maxlength="3000" placeholder="Maximum 3000 characters" id="DraftContent" name="DraftContent"></textarea>
		</div>
		</div>
		</div>
		<div class="row" style="margin-top: 7px;">
		<div class="col-md-7" style="display: inline-block;">
  	      		 <label class="control-label" style="display: inline-block; float:left; font-size: 15px;"><b>Signatory</b></label>
			<select class="selectpicker Signatory" id="Signatory" required="required"  data-live-search="true" name="Signatory" >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[0].toString()%> <% if (EmpId==Long.parseLong(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	
		</div>
		<div class="col-md-5" style="display: inline-block;">
			<div class="form-group">
			<label class="control-label" style="display: inline-block; align-items: center; font-size: 15px; "><b>Letter Head</b></label>
			<input style="margin-left: 30px; width: 7%; opacity: inherit;" type="checkbox" id="checkboxone" checked="checked" name="LetterHead" class="checkbox" value="N">
			<label for="checkboxone">No</label>&nbsp;&nbsp;
			<input type="checkbox" style="width: 7%; opacity: inherit;" id="checkboxtwo" class="checkbox" name="LetterHead" value="Y">
			<label for="checkboxtwo">Yes</label>
			</div>
		</div>
		</div>
		</div>
		</div>
		</div>
  	    </div><br>
  	    
		<div align="center">
		 <input type="button" class="btn btn-primary btn-sm submit " id="Preview" value="Preview" name="sub"  onclick="return forward()">
		</div>
			</form>
  	    </div>
  	    </div>
  	  </div>
	</div>
 
<!---------------------------------------------------- Enote  Reply  Modal End    ----------------------------------------------------------->


  
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
         			<input type="hidden" name="MarkerCloseRedirectval" value="DakReceivedList">
         			
         			<input type="hidden" id="DakClosePageNumber" name="PageRedirectData" >
         			<input type="hidden" id="DakCloseCount" name="RowRedirectData" >
                                
                                
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
                    <input type="hidden" name="MarkerCloseRedirectval" value="DakReceivedList">
                     <input type="hidden" name="fromDateFetch"   value="<%=frmDt%>" />	
                      <input type="hidden" name="toDateFetch"	 value="<%=toDt%>" />	
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
	  	      		   <textarea class="form-control " id="closingCommtWithDirCommt"  name="DakClosingCommtByMarker"
                                 style="width:98%;height:150px;background-color:white;margin-right:-12px;margin-left:5px;" maxlength="500"></textarea>
                            
	  	      		</div>
	  	      		
                     <div class="col-md-12" align="center">
                            
                                <br>
                   <input type="hidden" name="dakIdForMarkerAction"	id="DakIdFrDakCloseWithAPandComment" value="" />
                     <input type="hidden" name="fromDateFetch"   value="<%=frmDt%>" />	
                      <input type="hidden" name="toDateFetch"	 value="<%=toDt%>" />
                      <input type="hidden" name="MarkerCloseRedirectval" value="DakReceivedList">	             
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
  <!--------------------------------------------------------SOURCE Modal start--------------------------------------------->

<div class="modal fade" id="modalsource" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content" style="height: 350px;  border:black 1px solid;  width: 100%;">
      <div class="modal-header" style="background-color: #005C97;">
        <h5 class="modal-title" style="color:white;" ><b>Add Source</b></h5>
        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div><br>
      <div class="col-md-12">
      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
     	<div class="row">
                   
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Source Short Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="ShortName" type="text" name="ShortName" required="required" maxlength="20" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Source Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="SourceName" type="text" name="SourceName" required="required" maxlength="100" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                		</div>
                		<div class="row">
						     <div class="col-md-4">
						          <div class="form-group">
						               <label >Source Address <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
										<input  class="form-control" id="SourceAddress" type="text" name="SourceAddress" required="required" maxlength="100" style="font-size: 15px;width:100%;">
						  		  </div>
							  </div>
						
							  <div class="col-md-4">
								  	<div class="form-group">
								      	<label >Source City <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
										 <input  class="form-control" id="SourceCity" type="text" name="SourceCity" required="required" maxlength="100" style="font-size: 15px;width:100%;">
								     </div>
							  </div>
							  <div class="col-md-4">
								  	<div class="form-group">
								      	<label >Source Pin <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
										 <input  class="form-control" id="SourcePin" type="text" name="SourcePin" required="required" maxlength="6" onkeypress='return event.charCode >= 48 && event.charCode <= 57'  style="font-size: 15px;width:100%;">
								     </div>
							  </div>
						  		
						 </div>
                		<div class="col-md-12" align="center" style="margin-top: 2.4rem">
	 						     <input type="button" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="addsource()" > 
                    		</div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!---------------------------------------------------------SOURCE Modal Ends--------------------------------------------->


 <!----------------------------------------------------  Main Lab Dak Reply  Modal Start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="MainLabDakReplyexampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
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
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><span style="color: white;">DAK Id:</span></b> &nbsp;&nbsp;<span style="color: white;" id="MainLabDakNo">
		         </span> &nbsp;&nbsp;&nbsp;<b><span style="color: white;">Source :</span></b> &nbsp;&nbsp; <span style="color: white;" id="MainLabSourceNo"></span></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      	<form action="#" method="post" id="MainLabFormSubmit">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		   <div class="col-md-12" align="left" style="margin-left: 0px;width:100%;">
  	      		<label style="font-weight:bold;font-size:16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<!-- <div class="col-md-2">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></div> -->
  	      		     <div class="col-md-9">
  	      				<textarea class="form-control MainLabreplyTextArea"  name="replyRemarks" style="min-width: 135% !important;min-height: 30vh;"  id="MainLabreply" required="required"  maxlength="1000"  oninput="checkCharacterLimit()"> </textarea>
  	      			</div>
  	      			<br>
  	      				<label style="font-weight:bold;font-size:16px;">Dak Closing Comment :</label>
  	      		
  	      		<div class="row">
  	      		    <!-- new file add start -->
  	      			<div class="col-md-5 ">
  	      				<textarea class="form-control DakCloseCommtInputMainLab"  name="DakClosingComment" style="min-width: 115% !important;min-height: 10vh;"  id="MainLabclosingCommtMain" required="required"  maxlength="1000"  oninput="ClosingCommentcheckCharacterLimit()"> </textarea>
  	      			</div>
  	      			<!-- new file add end -->
  	      			
  	      			<!--copy files attached & delete those copy Start-->
  	      			<div class="col-md-5 " style="float:left;margin-top:-42px;">
  	      				<br>
  	      	      
  	      			</div>
  	      			<!--copy files attached & delete those copy End-->
  	      			<div>
  	      			<input type="radio" name="MainLabMail" checked="checked" value="N" onclick="MainLabDakReplyMailSent()"> No Mail&nbsp;&nbsp;&nbsp;
  	      			<input type="radio" name="MainLabMail"  value="L" onclick="MainLabDakReplyMailSent()"> Lab Mail&nbsp;&nbsp;&nbsp;
  	      			<input type="radio" name="MainLabMail"  value="D" onclick="MainLabDakReplyMailSent()"> Drona Mail
  	      			</div>
  	      		</div>
  	     
  	     <div class="row"  id="MainLabMailSent" style="display: none;">
  	     		<div class="col-md-6"></div>
  	      		<div class="col-md-3">
				<label style="font-size: 15px;"><b>Sender MailId</b></label>
				<input class="form-control" type="text" name="ReplyPersonSentMail" id="MainLabReplyPersonSentMail" readonly="readonly" <%-- value="<%if(MailSentDetails!=null && MailSentDetails[0]!=null){%><%=MailSentDetails[0].toString()%><%}%>" --%>>
				</div>
  	      		<div class="col-md-3">
  	      		<label style="font-size: 15px;"><b>Receiver MailId</b></label>
  	      			<select class="form-control selectpicker MainLabReplyReceivedMail "  id="MainLabReplyReceivedMail" multiple="multiple" data-live-search="true"  required="required"  name="ReplyReceivedMail">
  	      				<option value="select">Select</option>
  	      				 <%-- <%if (MailReceivedEmpDetails != null && MailReceivedEmpDetails.size() > 0) {
												for (Object[] obj : MailReceivedEmpDetails) {
											%>
											<option value="<%=obj[2]%>"><%=obj[2].toString() %></option>
											<%}}%>  --%>
  	      				</select>
  	      			</div>
  	      		</div>
  	      		
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  <input type="hidden" name="dakIdValFrReply"  id="MainLabdakIdOfReply" value="" >
  	      		  <input type="hidden" name="dakCreateId"  id="MainLabdakCreateId" value="" >
  	      		  <input type="hidden" name="appUrl"  id="MainLabappUrl" value="" >
  	      		  <input type="hidden" name="SourceDetailId"  id="MainLabSourceDetailId" value="" >
  	      		    <input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
					<input type="hidden" name="ReplyFrom" value="DakReceivedList">
					
					<input type="hidden" id="MainLabReplyMailSubject" name="ReplyMailSubject" value="">
					<input type="hidden" id="MainLabHostType" name="HostType" value="">
  	      			<input type="button" formaction="MainLabDAKReply.htm"  class="btn btn-primary btn-sm submit" id="sub" value="Submit" name="sub"  onclick="return MainLabdakReplyValidation()" > 
  	      		  </div>
  	      		</div>
  	      		<br>
  	      	</form>		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 
 
				</div>
		
</body>
<script>

function updateLayout() {
	  const selectedValue = document.querySelector('input[name="draftRequired"]:checked').value;
	  const eNoteContent = document.getElementById("eNoteContent");
	  const draftContentData = document.getElementById("draftContentData");

	  $('#isDraft').val(selectedValue);
	  if (selectedValue === "Y") {
	    // Set eNoteContent to col-md-6
	    eNoteContent.classList.remove("col-md-12");
	    eNoteContent.classList.add("col-md-6");

	    // Show draftContentData and set it to col-md-6
	    draftContentData.style.display = "block";
	    draftContentData.classList.remove("col-md-12");
	    draftContentData.classList.add("col-md-6");
	  } else {
	    // Set eNoteContent to col-md-12
	    eNoteContent.classList.remove("col-md-6");
	    eNoteContent.classList.add("col-md-12");

	    // Hide draftContentData
	    draftContentData.style.display = "none";
	  }
	}

	// Add event listeners for the radio buttons
	document.querySelectorAll('input[name="draftRequired"]').forEach((radio) => {
	  radio.addEventListener("change", updateLayout);
	});

	// Initialize layout on page load
	document.addEventListener("DOMContentLoaded", updateLayout);
	
	
const checkbox1 = document.getElementById('checkboxone');
const checkbox2 = document.getElementById('checkboxtwo');

checkbox1.addEventListener('change', function() {
  if (this.checked) {
    checkbox2.checked = false;
  }
});

checkbox2.addEventListener('change', function() {
  if (this.checked) {
    checkbox1.checked = false;
  }
});
function highlightButton(button) {
	$('[id^="buttonbackground"]').css('background-color', '');
	$('#buttonbackground' + button).css('background-color', 'lightgreen');

}
$(document).ready(function(){	
	$("#sourceid").trigger("change");
	$("#pass").hide();
	$("#fail").hide();
});
$("#sourceid").change(function(){
	var SourceId=$("#sourceid").val();
   $.ajax({
			
			type : "GET",
			url : "getSelectSourceTypeList.htm",
			data : {
				
				SourceId: SourceId
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
          $('#SourceType').empty();
			
			var addnew = "addnew";
		    var $newOption = $("<option></option>")
			  .attr("value", addnew)
			  .text("Add New")
			  .css({
			    "background-color": "blue",
			    "color": "white",
			    // Add more styles as needed
			  });

			$('#SourceType').append($newOption);
			for(var c=0;c<consultVals.length;c++)
			{
				
				 $('#SourceType')
		         .append($("<option></option>")
		                    .attr("value", consultVals[c][0])
		                    .text(consultVals[c][3]+'- '+consultVals[c][2])); 
			}
			 $('#SourceType').selectpicker('refresh');
			 $('#SourceType option:eq(1)').prop('selected', true);
			 $('#SourceType').selectpicker('refresh');
			}
});
});

$('#DraftLetterDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

function addsource()
{
  var SourceType= $("#sourceid").val();
  var ShortName=$("#ShortName").val();
  var SourceName=$("#SourceName").val();
  var SourceAddress=$("#SourceAddress").val();
  var SourceCity=$("#SourceCity").val();
  var SourcePin=$("#SourcePin").val();
  if(SourceType==null || SourceType=='' || typeof(SourceType)=='undefined' || SourceType=="Select Source Type")
  {
	  alert("Select Source Type..!");
	  $("#SourceType").focus();
	  return false;
  }
  else if(ShortName==null || ShortName==='' || ShortName==="" || typeof(ShortName)=='undefined')
  {
	  alert("Enter Source Short Name..!");
	  $("#ShortName").focus();
	  return false;
  }
  else if(SourceName==null || SourceName==='' || SourceName==="" || typeof(SourceName)=='undefined')
  {
	  alert("Enter Source Name..!");
	  $("#SourceName").focus();
	  return false;
  }
  else if(SourceAddress==null || SourceAddress==='' || SourceAddress==="" || typeof(SourceAddress)=='undefined')
  {
	  alert("Enter Source Address..!");
	  $("#SourceAddress").focus();
	  return false;
  }
  else if(SourceCity==null || SourceCity==='' || SourceCity==="" || typeof(SourceCity)=='undefined')
  {
	  alert("Enter Source City..!");
	  $("#SourceCity").focus();
	  return false;
  }
  else if(SourcePin==null || SourcePin==='' || SourcePin==="" || typeof(SourcePin)=='undefined')
  {
	  alert("Enter Source Pin..!");
	  $("#SourcePin").focus();
	  return false;
  }
  else
	  {
			var x=confirm("Are You Sure To Add ?");
	  
	  if(x)
		  {
		  $.ajax({
			  type : "GET",
				url : "dakSourceAddSubmit.htm",
				data : {
					
					SourceType: SourceType,
					ShortName:ShortName,
					SourceName:SourceName,
					SourceAddress:SourceAddress,
					SourceCity:SourceCity,
					SourcePin:SourcePin
				},
				datatype : 'json',
				success : function(result) {
				var result = JSON.parse(result);
				if(result==1){
					$('#modalsource').modal('hide');
					$("#sourceid").trigger("change");
					$("#pass").addClass("alert alert-success");
					 $("#pass").show();
					 setTimeout(function() {
					        $("#pass").hide();
					      }, 2000);
					 $("#ShortName").val("");
					 $("#SourceName").val(""); 
				}else{
					$('#modalsource').modal('hide');
					$("#sourceid").trigger("change");
					$("#fail").addClass("alert alert-danger");
					 $("#fail").show();
					 setTimeout(function() {
					        $("#fail").hide();
					      }, 2000);
					 $("#ShortName").val("");
					 $("#SourceName").val("");
				}
				}
			});
		  }
	  else
		  {
		  return false;
		  }
	
	  }
}

$('#SourceType').change(function(){
	var SourceType=document.getElementById("SourceType").value;
	  if(SourceType=='addnew'){ 
	  $('#modalsource').modal('show');
	  $("#SourceType").prop("selectedIndex", 0);
}
	  else{
		  $('#modalsource').modal('hide');
	  }
	});  
$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
});
//onload function for Status Filteration
$(document).ready(function(){
	  var StatusFilterationVal = '<%=statusFilteration%>';

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


function replyMainLabDakReply(DakId,DakCreateId,appUrl,SourceDetailId,DakNo,Source) {

	$('#MainLabDakReplyexampleModalReply').modal('show');
	$('#MainLabDakNo').html(DakNo);
	$('#MainLabSourceNo').html(Source);
	
 var value=$('#subject'+DakId).val();
	 
	$('#MainLabReplyMailSubject').val(value);
	$('#MainLabdakIdOfReply').val(DakId);
	$('#MainLabdakCreateId').val(DakCreateId);
	$('#MainLabappUrl').val(appUrl);
	$('#MainLabSourceDetailId').val(SourceDetailId);
}

function MainLabdakReplyValidation() {

	   var isValidated = false;
	   var replyRemark = document.getElementsByClassName("MainLabreplyTextArea")[0].value;
	   var closingcomment = document.getElementsByClassName("DakCloseCommtInputMainLab")[0].value;
		if(replyRemark.trim() == "") { 
			isValidated = false;
		}else{
			isValidated = true;
		}
		
		if(closingcomment.trim() == "") { 
			isValidated = false;
		}else{
			isValidated = true;
		}

	if (!isValidated) {
	   event.preventDefault(); // Prevent form submission
	   alert("Please fill in the reply input field.");
	 

	 } else {
	     
	     var elements = document.getElementsByName('MainLabMail');
	 	   var value;

	  	// Loop through all radio buttons to find the checked one
	  	for (var i = 0; i < elements.length; i++) {
	  	  if (elements[i].checked) {
	 	      value = elements[i].value;
	 	      break;
	 	   }
	  	}
	  	if (value === 'L' || value === 'D') {
	  		var ReplyReceivedMail= $('#MainLabReplyReceivedMail').val();
	  		if(ReplyReceivedMail==null || ReplyReceivedMail=='' || typeof(ReplyReceivedMail)=='undefined' || ReplyReceivedMail =='select'){
	  			 alert("Please Select a Mail ...!");
	  			 $("#MainLabReplyReceivedMail").focus();
	  			  shouldSubmit= false;
	  		}else{
	  			   // Retrieve the form and submit it
	  		       var confirmation = confirm("Are you sure you want to reply?");
	  		       if (confirmation) {
	  		      var form = document.getElementById("MainLabFormSubmit");
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
	  	      var form = document.getElementById("MainLabFormSubmit");
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
	
	
function ClosingCommentcheckCharacterLimit() {
    var textarea = document.getElementById("closingCommtMain");
    var maxlength = textarea.getAttribute("maxlength");
    var textLength = textarea.value.length;

    if (textLength > maxlength) {
        textarea.value = textarea.value.substring(0, maxlength); // Truncate the text to the maxlength
        alert("You have reached the maximum character limit.");
    }
}
</script>
    <script>
        $(document).ready(function(){
            $(".star").change(function(){
                if(this.checked) {
                	var value = $(this).val();
                    $.ajax({
                        type: 'GET',
                        url: 'DakAddToFavourites.htm',
                        data: {
                            DakMarkingId:value
                        },
                        success: function(response) {
                         
                        },
                    });
                } 
                if(!this.checked){
                	var value = $(this).val();
                    $.ajax({
                        type: 'GET',
                        url: 'DakRemoveFromFavourites.htm',
                        data: {
                            DakMarkingId:value
                        },
                        success: function(response) {
                         
                        },
                    });
                }
            });
        });
    </script>
<script>
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
function Assign(DakId, dakmarkingid, dakno, Source,RedirVal) {
    $('#exampleModalAssign').modal('show');
    $('#DakNo').html(dakno);
    $('#Sourcetype').html(Source);
    $('#DakMarkingdakId').val(DakId);
    $('#DakMarkingIdsel').val(dakmarkingid);
    $("#RedirectValue").val(RedirVal);
    $('#DakCaseWorker').empty();
    $('#remarks').val('');
    
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
	                var optionText = data[1] + ", " + data[2];
	                var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                $('#DakCaseWorker').append(option);
	            }
	            $('#DakCaseWorker').selectpicker('refresh');

	            $.ajax({
	                type: "GET",
	                url: "getoldassignemplist.htm",
	                data: {
	                    DakId: DakId
	                },
	                dataType: 'json',
	                success: function(result) {
	                    var consultVals = Object.values(result);
	                    if (consultVals != null) {
	                        $('#DakAssignedEmployeeAppend').css('display', 'block').empty();

	                        // Append the table structure once
	                        $('#DakAssignedEmployeeAppend').append(`
    						<table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
      						  <thead>
     						       <tr style="background-color: #f2f2f2;">
      						          <th style="padding: 5px; border: 1px solid #ddd; text-align: center;">SN</th>
      						          <th style="padding: 5px; border: 1px solid #ddd; text-align: center;">EmpName</th>
      						          <th style="padding: 5px; border: 1px solid #ddd; text-align: center;">Action</th>
      							   </tr>
       						  </thead>
       						 <tbody id="employeeTableBody"></tbody>
   							 </table>
							`);


	                        // Populate table rows inside the tbody
								var count = 1;
								for (var c = 0; c < consultVals.length; c++) {
								    var selectedOptionValue = consultVals[c][0];
								    var empName = consultVals[c][2] + ", " + consultVals[c][3]; // Assuming name is at index 2 and 3
								
								    // Set the selected and disabled properties for the option
								    $('#DakCaseWorker option[value="' + selectedOptionValue + '"]').prop('selected', true);
								    $('#DakCaseWorker option[value="' + selectedOptionValue + '"]').prop('disabled', true);
								
								 // Append the row to the table body with styles for table cells
								    $('#employeeTableBody').append(
								        '<tr data-emp-id="' + selectedOptionValue + '" style="background-color: #f9f9f9; border-bottom: 1px solid #ddd;">' +
								            '<td style="padding: 5px; border: 1px solid #ddd; text-align: center;">' + count + '</td>' +
								            '<td style="padding: 5px; border: 1px solid #ddd; color: blue; text-align: left;">' + empName + '</td>' +
								            '<td style="padding: 5px; border: 1px solid #ddd; text-align: center;">' +
								            (consultVals[c][4] == 0 ? 
								                    '<button class="AssignedEmpDeleteBtn" style="height:40px;"  type="button" onclick="assignedEmployeefunc('+DakId+', '+selectedOptionValue+', \''+RedirVal+'\', \''+pageValue+'\', \''+rowValue+'\', \''+consultVals[c][5]+'\')"><i class="fa fa-times" style="color:white;"></i></button>' : 
								                    '<span style="color: green;">Replied</span>') +
								            '</td>' +
								        '</tr>'
								    );

								    count++;
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


function assignedEmployeefunc(DakId,EmpId,RedirVal,pageValue,rowValue,Remarks) {
	var confirmation = window.confirm("Are you sure you want to delete this employee?");

	 // If the user confirms the deletion, proceed with setting values and submitting the form
	if (confirmation) {
	$('#EmpIdAssignUpdate').val(EmpId);
	$('#DakIdAssignUpdate').val(DakId);
	$('#RemarksAssignUpdate').val(Remarks);
	$("#AssignRedirectValue").val(RedirVal);
	$('#AssignPageRedirByAssign').val(pageValue);
	$('#AssignRowRedirByAssign').val(rowValue);
	$('#DakAssignUpdate').submit();
	} else {
        // If the user cancels, do nothing or log cancellation (optional)
        console.log("Deletion canceled");
    }
}
</script>



<script>
function replyModalOfMarker(DakIdValue,loggedInEmpId,DakAssignReplyIdCount,dakno,source,DakMarkingId) {

	$('#exampleModalReply').modal('show');
	 var value=$('#subject'+DakIdValue).val();
	 
	 $('#ReplyMailSubject').val(value);
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
	
	var elements = document.getElementsByName('Mail');
    for (var i = 0; i < elements.length; i++) {
        elements[i].checked = true;
    }

	
	if(DakAssignReplyIdCount>0 ){
		CSWReplyOfParticularMarkerPreview(DakMarkingId,DakIdValue,loggedInEmpId);
		console.log("DakAssignReplyIdCount is greater than zero callefd");
	}else{
		$('#CSWReplyOfParticularMarker').hide();
	}

	var elements = document.getElementsByName('Mail');
    for (var i = 0; i < elements.length; i++) {
        if (elements[i].value === 'N') {
            elements[i].checked = true;
        } else {
            elements[i].checked = false;
        }
    }
}
function formatDate(dateString) {
    var dateParts = dateString.split("-");
    return dateParts[2] + "-" + dateParts[1] + "-" + dateParts[0];
}
		
function EnotereplyModalOfMarker(DakIdValue,loggedInEmpId,DakAssignReplyIdCount,dakno,source,DakMarkingId,RefNo,RefDate) {

	$('#exampleModalEnoteReply').modal('show');
	 var value=$('#subjectid'+DakIdValue).val();
	$('#EnotedakIdOfReply').val(DakIdValue);
	$('#EnoteempIdOfReply').val(loggedInEmpId);
	$('#EnoteRecievedListDakNo').html(dakno);
	$('#EnoteDakNo').val(dakno);
	$('#EnoteRefNo').val(RefNo);
	var formattedDate = formatDate(RefDate);
    $('#EnoteRefDate').val(formattedDate);
    $('#EnoteSubject').val(value);
	$('#EnoteRecievedListSourceNo').html(source);
	$('.EnotereplyTextArea').val('');
	var selectedDate = moment(formattedDate, 'DD-MM-YYYY');
    $('#EnoteRefDate').data('daterangepicker').setStartDate(selectedDate);
    $('#EnoteRefDate').data('daterangepicker').setEndDate(selectedDate);
}
$('#EnoteRefDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
</script>
<!-- JavaScript for showing All Caeworker of particular marker reply view INSIDE ANOTHER MODAL start -->

<script>
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
							    var loggedInEmpId = <%= EmpId %>;
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
</script> 

<script>
// object named appendedText to store the reply text associated with each DakAssignReplyId//This object allows us to keep track of the text appended for each button click.
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
</script>

<!-- JavaScript for showing All Caeworker of particular marker reply view modal INSIDE ANOTHER MODAL  END -->
<script>
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
</script>
<script>

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

</script> 

 <script>   
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
    	if (value === 'L' || value === 'D') {
    		var ReplyReceivedMail= $('#ReplyReceivedMail').val();
    		if(ReplyReceivedMail==null || ReplyReceivedMail=='' || typeof(ReplyReceivedMail)=='undefined' || ReplyReceivedMail =='select'){
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
			            	$.ajax({
						        type: "GET",
						        url: "getMailReceiverDetails.htm",
						        data: {
						        	value: value
						        },
						        dataType: 'json',
						        success: function(result) {
						            if (result != null) {
						            	$('#ReplyReceivedMail').empty();
						                for (var i = 0; i < result.length; i++) {
						                    var data = result[i];
						                    var optionValue = data[2];
						                    var optionText = data[2]; // Removed the %>; and fixed the concatenation
						                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
						                    $('#ReplyReceivedMail').append(option); // Moved this inside the loop
						                }
						                $('#ReplyReceivedMail').selectpicker('refresh');
						            	
						                    }
						            }

						    });
			                    }
			            }

			    });
		}
}


function MainLabDakReplyMailSent(){
	var elements = document.getElementsByName('MainLabMail');
	var value;

	// Loop through all radio buttons to find the checked one
	for (var i = 0; i < elements.length; i++) {
	  if (elements[i].checked) {
	    value = elements[i].value;
	    break;
	  }
	}
	if (value === 'N') {
		$('#MainLabMailSent').hide();
		} else {
			$('#MainLabMailSent').show();
			$('#MainLabHostType').val(value);
			$.ajax({
			        type: "GET",
			        url: "getMailSenderDetails.htm",
			        data: {
			        	value: value
			        },
			        dataType: 'json',
			        success: function(result) {
			            if (result != null) {
			            	$('#MainLabReplyPersonSentMail').val(result[0]);
			            	$.ajax({
						        type: "GET",
						        url: "getMailReceiverDetails.htm",
						        data: {
						        	value: value
						        },
						        dataType: 'json',
						        success: function(result) {
						            if (result != null) {
						            	$('#MainLabReplyReceivedMail').empty();
						                for (var i = 0; i < result.length; i++) {
						                    var data = result[i];
						                    var optionValue = data[2];
						                    var optionText = data[2]; // Removed the %>; and fixed the concatenation
						                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
						                    $('#MainLabReplyReceivedMail').append(option); // Moved this inside the loop
						                }
						                $('#MainLabReplyReceivedMail').selectpicker('refresh');
						            	
						                    }
						            }

						    });
			                    }
			            }

			    });
		}
}


function dakEnoteReplyValidation() {
	   var isValidated = false;
	   var replyRemark = document.getElementsByClassName("EnotereplyTextArea")[0].value;
	if(replyRemark.trim() == "") { 
	isValidated = false;
}else{
	isValidated = true;
}

if (!isValidated) {
   event.preventDefault(); // Prevent form submission
   alert("Please fill in the reply input field.");
 

 } else {
     
     var confirmation = confirm("Are you sure you want to reply?");
     if (confirmation) {
    var form = document.getElementById("EnoteattachformReply");
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
}//function close

 </script>   
 
 
<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [15, 35, 65, 85, 100],
     ordering: true

});	
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

function DakSeekResponseSubmit() {
	var Caseworker=$('#DakSeekResponseEmployee').val();
	var shouldSubmit = true;
	var form=document.getElementById('SeekResponseForm');
	if(Caseworker==null || Caseworker==='' || typeof(Caseworker)=='undefined'){
		 alert("Select Employee..!");
	  $("#DakSeekResponseEmployee").focus();
	  shouldSubmit= false;
	}else{
		if(confirm('Are you Sure To Submit ?')){
			  form.submit();/*submit the form */
				}
	}
}

function DakReAssignSubmit() {
	var Caseworker=$('#ReAssignDakCaseWorker').val();
	var shouldSubmit = true;
	var form=document.getElementById('ReAssignForm');
	if(Caseworker==null || Caseworker==='' || typeof(Caseworker)=='undefined'){
		 alert("Select CaseWorker..!");
	  $("#ReAssignDakCaseWorker").focus();
	  shouldSubmit= false;
	}else{
		if(confirm('Are you Sure To Submit ?')){
			  form.submit();/*submit the form */
				}
	}
}

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


	   $('#fromdate').change(function(){
		   $('#myform').submit();
	    });
	   
	   


	
var currentDate = new Date();
var maxDate = currentDate.toISOString().split('T')[0];

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


var count=1;
$("table").on('click','.Enotetr_clone_addbtn' ,function() {
   var $tr = $('.Enotetr_clone').last('.Enotetr_clone');
   var $clone = $tr.clone();
   
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.Enotetr_clone_sub' ,function() {
	
var cl=$('.Enotetr_clone').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.Enotetr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});
</script>
<script>
function checkCharacterLimit() {
    var textarea = document.getElementById("reply");
    var maxlength = textarea.getAttribute("maxlength");
    var textLength = textarea.value.length;

    if (textLength > maxlength) {
        textarea.value = textarea.value.substring(0, maxlength); // Truncate the text to the maxlength
        alert("You have reached the maximum character limit.");
    }
}
</script>
<script>
//onload
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

//onclick of Dak Close by clicking on Dak Approval Not required
</script>
<script>
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
	  $('#fromDateRedir').val('<%= frmDt %>');
	  $('#toDateRedir').val('<%=toDt%>');
	  $('#dakStatusAppend').val(DakStatus);
	  $('#markingIdAppend').val(DakMarkingId);
	  $('#noOfActionMarkers').val(CountOfActionMarkers);
	  $('#replyCountOfActionMarkers').val(CountOfActMarkersReply);
	  
	//code to redirect to page
		var redirectPageId   = "PageNoValFetch"+DakId;
		var redirectRowId =  "RowValFetch"+DakId;
		var pageElement = document.getElementById(redirectPageId);
		var rowElement = document.getElementById(redirectRowId);
	    var pageValue = pageElement ? pageElement.value : null;
		var rowValue = rowElement ? rowElement.value : null;
		$('#DakClosePageNumber').val(pageValue);
		$('#DakCloseCount').val(rowValue);
		//code ends
		
	  $('#DirectorApprovalActionChange').modal('show');
	
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
		
		 var closingCommt = $('#closingCommtWithDirCommt').val().trim();

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

</script>
	
<script>
// Get PageNo and Row from JSP attributes
var pageNoNavigate = <%=PageNo%>;
var rowToHighlight  = <%=Row%>;
      console.log('PageNo'+pageNoNavigate+'Row'+rowToHighlight);
      
      if(pageNoNavigate!=null && rowToHighlight!=null){
      document.addEventListener("DOMContentLoaded", function () {
      	  // Navigate to the specified page
          navigateToPage(pageNoNavigate);
      	
          // Highlight the specified row
          highlightRow(rowToHighlight);

      });
      
      }
      
      
function highlightRow(count) {
	var rowElement = document.querySelector('[data-row-id="row-' + count + '"]');
	if (rowElement) {
  
         rowElement.scrollIntoView();
    	
         // Apply the glow animation directly to the element's style
                 rowElement.style.animation = "glow 2s infinite"; // Adjust the duration as needed (in seconds)

        // Set a timeout to remove the animation after a certain duration (e.g., 6 seconds)
           /* setTimeout(function () {
          rowElement.style.animation = "none";
             }, 5000); // Adjust the duration as needed (in milliseconds) */
    }
}

function navigateToPage(page) {
	  // Assuming you have initialized your DataTable with the id 'myTable1'
    var table = $("#myTable1").DataTable();

    // Use DataTables API to go to the specified page
    table.page(page - 1).draw('page');
}
	  
function forward() {
	var val=$('#isDraft').val();
	var shouldSubmit=true;
	var DakNo=$('#EnoteDakNo').val();
	var RefNo=$('#EnoteRefNo').val();
	var RefDate=$('#EnoteRefDate').val();
	var Reply=$('#EnoteReply').val();
	var Subject=$('#EnoteSubject').val();
	var NoteNo=$('#NoteNo').val();
	if(NoteNo==null || NoteNo==='' || NoteNo===" " || typeof(NoteNo)=='undefined'){
		alert("Please Enter the Note No...!")
		$('#NoteNo').focus();
		shouldSubmit=false;
	}else if(DakNo==null || DakNo==='' || DakNo===" " || typeof(DakNo)=='undefined'){
		alert("Please Enter the Dak No...!")
		$('#EnoteDakNo').focus();
		shouldSubmit=false;
	}else if(RefNo==null || RefNo==='' || RefNo===" " || typeof(RefNo)=='undefined'){
		alert("Please Enter the Ref No...!")
		$('#EnoteRefNo').focus();
		shouldSubmit=false;
	}else if(RefDate==null || RefDate==='' || RefDate===" " || typeof(RefDate)=='undefined'){
		alert("Please Select the Ref Date...!")
		$('#EnoteRefDate').focus();
		shouldSubmit=false;
	}else if(Subject==null || Subject==='' || Subject===" " || typeof(Subject)=='undefined'){
		alert("Please Enter the Subject...!")
		$('#EnoteSubject').focus();
		shouldSubmit=false;
	}else if(Reply==null || Reply==='' || Reply===" " || typeof(Reply)=='undefined'){
		alert("Please Enter the Reply...!")
		$('#EnoteReply').focus();
		shouldSubmit=false;
	}else{
		var formAction = $('#myform1').data('action');
		if(confirm('Are you Sure To Preview ?')){
			  $('#myform1').attr('action', formAction);
	          $('#myform1').submit(); /* submit the form */
		}
	}
}

function autoResize() {
    const textarea = document.getElementById('EnoteReply');
    textarea.style.height = 'auto'; // Reset height to auto to calculate the actual height
    textarea.style.height = textarea.scrollHeight + 'px'; // Set the height to the scroll height
}
function autoResizeDraftContent() {
    const textarea = document.getElementById('DraftContent');
    textarea.style.height = 'auto'; // Reset height to auto to calculate the actual height
    textarea.style.height = textarea.scrollHeight + 'px'; // Set the height to the scroll height
}
</script>

</html>	