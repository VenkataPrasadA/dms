<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Pending Reply List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style>
div.dropdown-menu.open
    {
        max-height: 410px !important;
        overflow: hidden;
    }
    ul.dropdown-menu.inner
    {
        max-height: 410px !important;
        /* overflow-y: auto; */
    }
  
.bootstrap-select   .filter-option {

    width: 530px !important;
    height: 230px !important;
    white-space: pre-wrap;
  
}
.bootstrap-select  .dropdown-toggle{
 width: 330px !important;
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


.completed {
    color: rgba(0,128,0, 0.8);
    font-weight: 700;
    font-size:16px;
}
.greenStatus{
white-space: normal;
background-image: linear-gradient(rgba(0,128,0, 0.5), rgba(0,128,0, 0.8) 50%)!important;
	border-color:rgba(0,128,0, 0.8);
}
.completeddelay {
    color: rgba(255,0,0,0.8);
    font-weight: 700;
    font-size:16px;
}
.redStatus{
white-space: normal;
background-image: linear-gradient(rgba(255,0,0, 0.5), rgba(255,0,0,0.8) 50%)!important;
	border-color:rgba(255,0,0,0.8);
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
.blueStatus{
white-space: normal;
background-image: linear-gradient(rgba(11, 127, 171,0.3), rgba(11, 127, 171,0.8) 50%)!important;
	border-color:rgba(11, 127, 171,0.8);
}


.ongoingdelay {
    color: rgba(255, 165, 0, 0.9);
    font-weight: 700;
    font-size:16px;
}

.orangeStatus{
white-space: normal;
background-image: linear-gradient(rgba(230, 126, 34, 0.5), rgba(255, 165, 0, 0.9) 50%)!important;
	border-color:rgba(255, 165, 0, 0.9);
}


.bootstrap-select .dropdown-menu{
width:500px !important;
height:600px !important;
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
.container { 
  max-width: 960px; 
  height: 100%;
  margin: 0 auto; 
  padding: 20px;
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

body {
   overflow-x: hidden;
}

.table a:hover,a:focus {
   text-decoration: underline !important; 
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

.custom-selectEmp {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  width: 300px !important;
  padding: 0px !important;
  margin-top: -8px;
  
}

.custom-selectEmp select {
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
.custom-selectEmp::after {
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
</head>
<body>
<%
    SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
	String frmDt=(String)request.getAttribute("frmDt");
	String toDt=(String)request.getAttribute("toDt");
	String EmployeeId = (String)request.getAttribute("EmpId");
	List<Object[]> DakPendingReplyList=(List<Object[]>)request.getAttribute("dakPendingReplyList");
	String statusFilteration =(String)request.getAttribute("statusValue");
	
	String PageNo=(String)request.getAttribute("pageNoRedirected");
	String Row=(String)request.getAttribute("rowRedirected");
	
	System.out.println("PageNo:"+PageNo+"Row:"+Row);

%>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Pending Reply List</h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a
							href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
						<li class="breadcrumb-item active">DAK Pending Reply List</li>
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
	
	<div class="card loadingCard" style="width: 99%; display: none;">
<div class="card-header" style="height: 2.7rem">
  <form action="DakPendingReplyList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <div class="row">
      <div class="float-container" style="float:right;">
      
        <div id="label1" style="width: 100%; text-align: left;margin-top: -1rem;">
         <table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 13px;text-align: center"> 
									   <button type="button" class="btn btn-sm statusBtn" id="All" onclick="setStatus('All')"><span class="all"></span><span class="all">&nbsp;All&nbsp;</span></button>&nbsp;&nbsp;
										 <button type="button" class="btn btn-sm statusBtn" id="Ongoing" onclick="setStatus('Ongoing')"><span class="ongoing">OG</span><span class="ongoing"> &nbsp;:&nbsp; On Going </span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="OngoingDelay" onclick="setStatus('OngoingDelay')"><span class="ongoingdelay">DO</span><span class="ongoingdelay">&nbsp; :&nbsp;Delay - On Going</span></button>&nbsp;&nbsp;
										<input type="hidden" id="StatusFilterValId" name="StatusFilterVal" value="">
									</p>
								</td>									
							</tr>
							</thead>
							</table>
        </div>
        
        <div class="label2" style="width: 50%; float: right;">
          <div class="row Details">
            <div class="col-1" style="font-size: 16px; padding-left:120px;">
              <label for="fromdate" style="text-align: center;font-size: 16px;width:50px;">From &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            
            <div class="col-4" style="padding-left:80px;">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <div class="col-1" style="font-size: 16px; padding-left:30px;">
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
					<form action="#" method="post">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					     <input type="hidden"  name="RedirectValFrmPending" value="RedirToDakPendReply">
					<input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
					
					<input type="hidden" name="viewfrom" value="DakPendingReplyList">
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
								<tr>
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
								if(DakPendingReplyList!=null && DakPendingReplyList.size()>0){
									for(Object[] obj:DakPendingReplyList){
										
									    String cssStatClass = "default";
										   if(obj[13]!=null && ("CO").equalsIgnoreCase(obj[13].toString().trim()))  {
											   cssStatClass = "greenStatus";
										   }else if(obj[13]!=null && ("CD").equalsIgnoreCase(obj[13].toString().trim()))  {
												   cssStatClass = "redStatus";
										   }else if(obj[13]!=null && ("OG").equalsIgnoreCase(obj[13].toString().trim()))  {
													   cssStatClass = "blueStatus";
										   }else if(obj[13]!=null && ("DO").equalsIgnoreCase(obj[13].toString().trim()))  {
														   cssStatClass = "orangeStatus";
										   }
										   
										   ////////////////////////////////////
										   //CountOfAllMarkers - obj[33]
										   //CountOfActionMarkers - obj[31]
										   //CountOfMarkersAck - obj[34]
										   //CountOfMarkersReply - - obj[32] 
										  
										   String StatusCountAck = null;
											String StatusCountReply = null;
											 
											if(obj[5]!=null  && obj[32]!=null && Long.parseLong(obj[32].toString())==0
												&& obj[34]!=null && Long.parseLong(obj[34].toString())>0
												&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
												&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
												&& !obj[5].toString().equalsIgnoreCase("FP") ){	
												StatusCountAck = "Acknowledged<br>[" +obj[34]+"/"+obj[33]+"]";
											   }
											
											 if(obj[5]!=null  && obj[34]!=null && Long.parseLong(obj[34].toString())>0
												&& obj[31]!=null && Long.parseLong(obj[31].toString()) > 0
											    && obj[32]!=null && Long.parseLong(obj[32].toString()) > 0
												&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
												&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
												&& !obj[5].toString().equalsIgnoreCase("FP") ){	
												 StatusCountReply  = "Replied<br>["+obj[32]+"/"+obj[31]+"]";
													   }
								          /////////////////////////////////////////
									
								%>
								<tr data-row-id=row-<%=count %> id=buttonbackground<%=obj[0]%> <%if(obj[35]!=null && Long.parseLong(obj[35].toString())==3){ %> class="HighlightHighPrior"<%}%>>
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
                                     <td style="text-align: center;width:10px;"><%if(obj[20]!=null){ %><%=obj[20].toString() %><%}else{ %>-<%} %></td>
 					                <td  class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td  class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td  class="wrap" style="width: 50px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
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
										<td  class="<%=cssStatClass%>" style="text-align: left;width:40px;text-align: center;font-weight:bold;"><%if(obj[13]!=null) {%><%=obj[13].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;font-weight:bold">
								 
							          <%
								 
								      int itemsPerPage = 10;
                                     // Calculating the page number based on the count and itemsPerPage
								     int pageNumber = (count - 1) / itemsPerPage + 1;

							          %>
	                                 <input type="hidden" name=RedirPageNo<%=obj[0]%>  id=PageNoValFetch<%=obj[0]%> value="<%=pageNumber%>">
	 								 <input type="hidden" name=RedirRow<%=obj[0]%>    id=RowValFetch<%=obj[0]%> value="<%=count%>">
							          <%if(obj[17]!=null && obj[17].toString().equalsIgnoreCase("N")){ %> 
						 
									     <button id="button-upload" type="submit" class="btn btn-sm icon-btn" formaction="DakAck.htm"  name="dakIdSel" value="<%=obj[0]%>" formmethod="POST"
									       data-toggle="tooltip" data-placement="top" title="Ack">
 										          <img alt="Ack" src="view/images/acknowledgement.png">
										</button>
 							          <%} %>
 							          
 									  <%if(obj[17]!=null && obj[17].toString().equalsIgnoreCase("Y")){ %>
 									  	<%
 									  	/*Marker Reply  */
 									  /* 	String ReplyCounts = null;
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
									 formaction="DakReceivedView.htm" formtarget="_blank"
									      data-toggle="tooltip" formmethod="post" data-placement="top" title="Preview"> 
 										 <img alt="mark" src="view/images/preview3.png">
								       </button>
 										  <%} %>
 										  
 									   	<%if(!obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("FP") && !obj[5].toString().equalsIgnoreCase("AP") && !obj[5].toString().equalsIgnoreCase("DC")){ %>
 								       <!-- Reply Display Condition and hide  Condition  -->
 									     <%if("ACTION".equalsIgnoreCase(obj[9].toString().trim()) &&  obj[17]!=null  &&  obj[17].toString().equalsIgnoreCase("Y") && obj[23]!=null && Long.parseLong(obj[23].toString()) <= 0){ %>
 										  <button type="button" class="btn btn-sm icon-btn"  onclick="return replyModalOfMarker('<%=obj[0] %>','<%=EmployeeId%>','<%=obj[25] %>','<%=obj[8] %>','<%=obj[3] %>',<%=pageNumber %>,<%=count %>)" 
 										  data-toggle="tooltip" data-placement="top" title="Reply">
 										      <img alt="Reply" src="view/images/replyy.png">
											</button>
 											
 										  <%} %>
 										  
 										    <%} %>
 										  
 										  			  
 								<%if(obj[19]!=null  && obj[19].toString().equalsIgnoreCase("Y")){ %>
 								<span <%if(obj[19]!=null  && obj[19].toString().equalsIgnoreCase("Y") &&  obj[25]!=null && Long.parseLong(obj[25].toString())>0) { %> style="color:#006400;"<%}else{ %>style="color:blue;"<%} %>>
 								 CW
 								 </span>
 								<%} %>
 										  
 										   <div style="display: flex; flex-direction: column; align-items: center;">
 										  <%if(obj[21]!=null && !obj[21].toString().equalsIgnoreCase("N")){ %>
 										          
 										  <span class="MsgByDir">
 										  
 										  <%if(obj[21].toString().equalsIgnoreCase("D")){ %>
 										  Pls Discuss With Director
 										   <%}else if(obj[21].toString().equalsIgnoreCase("E")){ %>
 										   Noted By Director
 										   <%} %>
 										  </span>
 										  <%} %>
 										  </div>
 										  </td>
 										       
								</tr>
								<%count++;} %>
								<%} %>
							</tbody>
							</table>
                       </form>
					</div>
					
					</div>

				</div>
<!----------------------------------------------------   Reply  Modal start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="exampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered" role="document"  style="min-width: 95% !important; min-height: 70vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle" style="color:white;"><b>DAK Reply</b>
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>DAK Id:</b> &nbsp;&nbsp;<span style="color: white;" id="RecievedListDakNo">
		         </span> &nbsp;&nbsp;&nbsp;<b>Source :</b> &nbsp;&nbsp; <span style="color: white;" id="RecievedListSourceNo"></span></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;"> 
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReply" id="attachformReply" enctype="multipart/form-data" method="post" >
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      			     <input type="hidden"  name="RedirectValFrmPending" value="RedirToDakPendReply">
  	         
  	      
  	      		   <div class="col-md-12" align="left" style="margin-left: 0px;width:100%;">
  	      	
  	      		<label style="font-weight:bold;font-size:16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<!-- <div class="col-md-2">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></div> -->
  	      		     <div class="col-md-9">
  	      				<textarea class="form-control replyTextArea"  name="replyRemarks" style="min-width: 135% !important;min-height: 30vh;"  id="reply" required="required"  maxlength="1000"  oninput="checkCharacterLimit()"> </textarea>
  	      			</div>
  	      			<br>
  	      				<label style="font-weight:bold;font-size:16px;">Document :</label>
  	      			<!-- <div class="col-md-2">
  	      			<br>Document :</div> -->
  	      			<div class="col-md-10 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_clone">
			  	      			<td><input class="form-control" type="file" name="dak_reply_document"  id="dakdocumentreply" accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      			</div>
  	     
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  <input type="hidden" name="dakIdValFrReply"  id="dakIdOfReply" value="" >
  	      		    <input type="hidden" name="EmpIdValFrValue" id="empIdOfReply" value="">
  	      		    
  	      			<input type="button" formaction="DAKReply.htm"  class="btn btn-primary btn-sm submit" id="sub" value="Submit" name="sub"  onclick="return dakReplyValidation()" > 
  	      		  </div>
  	      		</div>
  	      		<br>
  	      		 <!-- Assigned CaseWorker reply display starts CaseworkerDakReplyData-->
  	        <div class="CSWReplyOfParticularMarker" style="display:none">
  	        <div class="DAKCSWReplysBasedOnReplyId" style="min-width:100px;min-height:100px;">
  	        <h4 class="CSWName" id="model-person-header"></h4>
  	        <div class="clearfix"></div>
  	        <div class="row replyRow">
  	        
  	        <div class="form-group group1">
  	        <div class="col-md-12 replyOfCSWData" contenteditable="false"></div>
  	        </div>
  	        
  	        <div class="form-group TblReplyAttachs">
  	        <div class="col-md-6 replyCSWModAttachTbl-div">
  	        <table class="table table-hover table-striped table-condensed info shadow-nohover CSWAttachDownloadTbl">
  	      <!-- will be filled using ajax -->
  	         </table>
  	         </div>
  	         </div>
  	         
  	         </div>
  	         </div>
  	         <br>
  	         </div>
  	         <!-- Assigned CaseWorker reply display ends -->
  	         
  	          <input type="hidden" name="PageRedirectData"  id="PendingReplyPageNo" value="" >
  	      	  <input type="hidden" name="RowRedirectData" id="PendingReplyRowNo" value="">
  	      	   <input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
			   <input type="hidden" name="toDateFetch" value=<%=toDt %>>
  	      		
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 
  <!----------------------------------------------------  Reply  Modal End    ----------------------------------------------------------->
  
  
  
</body>

<script type="text/javascript">

$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
});
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	

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
		   $('#fromdate ,#todate').change(function(){
		       $('#myform').submit();
		    });
		});



</script>

<script type="text/javascript">
function replyModalOfMarker(dakIdValue,loggedInEmpId,DakAssignReplyId,dakno,source,PendingReplyPageNo,PendingReplyRowNo) {
	console.log("reaching replyModal Function")
	 $('#exampleModalReply').modal('show');
	
	 console.log(dakIdValue);
	 console.log(loggedInEmpId);
	
	$('#dakIdOfReply').val(dakIdValue);
	$('#empIdOfReply').val(loggedInEmpId);
	$('#RecievedListDakNo').html(dakno);
	$('#RecievedListSourceNo').html(source);
	$('#PendingReplyPageNo').val(PendingReplyPageNo);
	$('#PendingReplyRowNo').val(PendingReplyRowNo);
	
	if(DakAssignReplyId>0 ){
		
		CSWReplyOfParticularMarkerPreview(DakAssignReplyId,dakIdValue,loggedInEmpId);
	}


}


function CSWReplyOfParticularMarkerPreview(DakAssignReplyId,dakId,loggedInEmpId){
    $.ajax({
        type: "GET",
        url: "GetSpecificCSWReplyDetails.htm",
        data: {
            dakAssignReplyId: DakAssignReplyId,
            dakId: dakId
        },
        dataType: 'json',
        success: function(result) {
        	 console.log("Response:", result);
        	 try {
        		 if (result != null && Array.isArray(result) && result.length > 0) {
        	            var AssignedMarkerEmpId = result[0][9];
        	            if (AssignedMarkerEmpId == loggedInEmpId) {
        	            	$('.replyOfCSWData').empty();
        	            	
        	            	$('.CSWReplyOfParticularMarker').show();
                            $('.replyOfCSWData:first').text(result[0][2]);
                            $('.CSWName').text(result[0][4]+','+result[0][5]+'(Marked By'+result[0][10]+')');
                            
                            // result[0][6] count i.e DakReplyAttachCount is more than 0
                            var DakAssignId = result[0][7];
                            console.log(result[0][6]);
					         if (result[0][6] > 0) {
					              CSWReplyAttachmentsJs(DakAssignId); 
					            }
        	            
        	            }
        	        }
             } catch (error) {
                 console.error("Error parsing JSON:", error);
             }
         },
         error: function(xhr, status, error) {
             console.error("AJAX request error:", status, error);
         }
         
    });
}

 function CSWReplyAttachmentsJs(DakAssignId){//so than while marker is replying he can refer his caseworkers reply also
	 
	 $('.CSWAttachDownloadTbl').empty();
	$.ajax({
	    type: "GET",
	    url: "GetCSWReplyAttachModalList.htm",
	    data: {
	      dakassignid: DakAssignId
	    },
	    datatype: 'json',
	    success: function(result) {
	    	console.log(result);
	    	  if (result != null) {
			        var resultData = JSON.parse(result);
			        
			        if (resultData.length > 0) {
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
				          $('.CSWAttachDownloadTbl').append(ReplyAttachTbody);
				          
			        }
	    	  }
	    }
	     });
}  

</script> 
<script type="text/javascript">
function dakReplyValidation() {
	   var isValidated = false;
	   var replyRemark = document.getElementsByClassName("replyTextArea")[0].value;
	if(replyRemark.trim() == "") { 
    	isValidated = false;
    }else{
    	isValidated = true;
    }
    
    if (!isValidated) {
        event.preventDefault(); // Prevent form submission
        alert("Please fill in the remark input field.");
      
    
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
      }//else close
      }


</script>  
<script>
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
	          	console.log("afsdadasd"+count);
	        	if (rowElement) {
	          
		              	console.log("afsdadasd");
		                rowElement.scrollIntoView();
	            	
		                // Apply the glow animation directly to the element's style
	                	console.log("sdfsxdcf"+count);
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
	        
	        </script>
</html>