<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DAK PNC List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
</head>
<style>

.HighlightHighPrior{
    background: rgb(223 42 42 / 50%)!important;
}


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


.disabledExpand{
background-color: #808080;
   border: none;
  outline: none;
 
  &[disabled] {
        opacity: 0.5;
        cursor: not-allowed;
    }

}
.pncReplyAttach-btn{
 color:#0089c7;
 background-color:white;
 font-size:14px;
}

.pncReplyAttach-btn:hover {
   color: royalblue;
  text-decoration: underline;
}
.DakDirectorListCommonGroupname{
width: 330px !important;
}
.DakDirectorListCommonempidSelect{
width: 250px !important;
margin-top: -20px !important;
}
.DakDirectorListCommonindividual{
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
<body>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK P&C List</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK P&C List</li>
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
		<%
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		String SelectedTab = null;
		String TabData = (String)request.getAttribute("selectedTabVal");
		   System.out.println("DakPNCModule%%%%%%%%%%%%%%%%%%%%%"+TabData);
		if(TabData!=null && TabData.trim()!=""){
			SelectedTab = TabData;
		}else{
			SelectedTab = "DakPNCPendingReplyList";  //Default value
		}
		
		
		String statusFilteration =(String)request.getAttribute("statusValue");
		
		List<Object[]> DakPendingPnCReplyList=(List<Object[]>)request.getAttribute("dakPendingPNCReplyList");
		
		List<Object[]> DakPnCList=(List<Object[]>)request.getAttribute("dakPNCList");
		
		%>
		
		<div class="card loadingCard" style="display: none;">
    	<div class="card-header"style="height: 2.7rem">
  <form action="DakPNCList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <div class="row ">
      <div class="float-container" style="float:right;">
      
        <div id="label1" style="width: 70%; text-align: left;margin-top: -1rem;">
         <table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 13px;text-align: center"> 
									   <button type="button" class="btn btn-sm statusBtn" id="All" onclick="setStatus('All')"><span class="all"></span><span class="all">&nbsp;All&nbsp;</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="Ongoing" onclick="setStatus('Ongoing')"><span class="ongoing">OG</span><span class="ongoing"> &nbsp;:&nbsp; On Going </span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="OngoingDelay" onclick="setStatus('OngoingDelay')"><span class="ongoingdelay">DO</span><span class="ongoingdelay">&nbsp; :&nbsp;Delay - On Going</span></button>
                                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                     <!--   <button type="button" class="btn btn-sm statusBtn" id="Completed" onclick="setStatus('Completed')"><span class="completed">CO</span><span class="completed">&nbsp; :&nbsp; Completed</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="CompletedDelay" onclick="setStatus('CompletedDelay')"><span class="completeddelay">CD</span><span class="completeddelay">&nbsp; :&nbsp; Completed with  Delay</span></button>&nbsp;&nbsp; -->
										<input type="hidden" id="StatusFilterValId" name="StatusFilterVal" value="">
									</p>
								</td>									
							</tr>
							</thead>
							</table>
        </div>
        
        <div class="label2" style="width: 40%; text-align: right">
          <div class="row Details" >
         
            <div class="col-1" style="font-size: 16px; padding-left:120px; ">
              <label for="fromdate" style="text-align: center;font-size: 16px;width:50px;">From &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            
            <div class="col-4" style="padding-left:80px;  ">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <div class="col-1" style="font-size: 16px; padding-left:30px;  ">
              <label for="todate" style="text-align: center;font-size: 16px;width:20px;">To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            <div class="col-4" style="padding: 0; float:right;">
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


<br>

	<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  <li class="nav-item" style="width: 50%;"  >
		    <div class="nav-link PendingPNCReply-Tab" style="text-align: center;" id="pills-OPD-tab" data-toggle="pill" data-target="#pills-OPD" role="tab" aria-controls="pills-OPD" aria-selected="true">
			   <span>Pending P&C Reply List
				   <span class="badge badge-danger badge-counter list-Count">
				   		<%if(DakPendingPnCReplyList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DakPendingPnCReplyList.size() %>
						<%} %>				   			
				  </span>  
				</span> 
		    </div>
		  </li>
		  <li class="nav-item"  style="width: 50%;">
		    <div class="nav-link PNC-Tab" style="text-align: center;" id="pills-IPD-tab" data-toggle="pill" data-target="#pills-IPD" role="tab" aria-controls="pills-IPD" aria-selected="false">
		    	 <span>P&C List   
				   <span class="badge badge-danger badge-counter list-Count">
				   		<%if(DakPnCList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DakPnCList.size() %>
						<%} %>				   			
				   </span>  
				</span> 
		    
		    
		    </div>
		  </li>
		</ul>


<div class="tab-content" id="pills-tabContent">

<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DAK Pending PNC Reply List Start @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->

   <div class="card tab-pane PendingPNCReply-Module" id="pills-OPD" role="tabpanel" aria-labelledby="pills-OPD-tab" >
      <div class="table-responsive" style="overflow:hidden;">
         <form action="#" method="post" id="PendingPNCDoListForm">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="fromDateFetch"	value="<%=frmDt%>" />	
 					<input type="hidden" name="toDateFetch"	value="<%=toDt%>"/>	
 					<input type="hidden" name="viewfrom" value="DakPncList">
 					<table class="table table-bordered table-hover table-striped table-condensed " id="myTablePendingPNC">
							<thead>
								<tr >
								    <th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th class="text-nowrap">Head</th>
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">Ref No & Date</th>
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
								if(DakPendingPnCReplyList!=null && DakPendingPnCReplyList.size()>0){
									for(Object[] obj:DakPendingPnCReplyList){
										
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
										   //obj[27] - CountOfAllMarkers
										   //obj[28] - CountOfActionMarkers
										   //obj[29] - CountOfMarkersAck
										   //obj[30] - CountOfMarkersReply
										  
										   String Action=null;
											  
										   if(obj[9]!=null && "ACTION".equalsIgnoreCase(obj[9].toString())){
											   Action="A";
										   }else if(obj[9]!=null && "RECORDS".equalsIgnoreCase(obj[9].toString())){
											   Action="R";
										   }
										
										   
										   String StatusCountAck = null;
											String StatusCountReply = null;
											 
											if(obj[5]!=null  && obj[30]!=null && Long.parseLong(obj[30].toString())==0
												&& obj[29]!=null && Long.parseLong(obj[29].toString())>0
												&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
												&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
												&& !obj[5].toString().equalsIgnoreCase("FP") ){	
												StatusCountAck = "Acknowledged<br>["+obj[29]+"/"+obj[27]+"]";
											   }
											
											 if(obj[5]!=null  && obj[29]!=null && Long.parseLong(obj[29].toString())>0
												&& obj[28]!=null && Long.parseLong(obj[28].toString()) > 0
											    && obj[30]!=null && Long.parseLong(obj[30].toString()) > 0
												&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
												&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
												&& !obj[5].toString().equalsIgnoreCase("FP") ){	
												 StatusCountReply  = "Replied<br>["+obj[30]+"/"+obj[28]+"]";
													   }
								          /////////////////////////////////////////
										   
										   %>
										   <tr <%if(obj[32]!=null && Long.parseLong(obj[32].toString())==3){ %> class="HighlightHighPrior"<%}%>>
										   
										          <td style="width:10px;"><%=count %></td>
										          <td class="wrap" style="text-align: left;width:80px;">
										            <a class="font" href="javascript:void()" style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakPNCList')">
                                                     <% if (obj[8] != null) { %><%= obj[8].toString() %><% } else { %>-<% } %>
                                                    </a>
                                                  </td> 
                                                   <td style="text-align: center;width:10px;"><%if(obj[18]!=null){ %><%=obj[18].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td> 
								     <td style="text-align: center;width:80px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
								     <td  class="wrap" style="text-align: left;width:180px;"><%if(obj[14]!=null){ %><%=obj[14].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap"  style="text-align: left;width:90px;text-align: center;font-weight:bold;">
								
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
									<td style="text-align: center;font-weight:bold;width:15%;">
	<!-----------------------------Preview Action code Start ---------------------------------------------------------------------------------------------------------->									 
									 <button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]  %> value="<%=obj[0] %>" 
									   formaction="DakReceivedView.htm" formmethod="post" formtarget="_blank"
									  data-toggle="tooltip" data-placement="top" title="" data-original-title="Preview"> 
															<img alt="mark" src="view/images/preview3.png">
 										  </button>
 <!---------------------------------Preview Action code End --------------------------------------------------------------------------------------------------------->		
 
  		 <input type="hidden" name="DakNo_<%=obj[0]%>"	value="<%=obj[8]%>" />	 <!-- commonInputTypeHidden -->								
 							
 							
 <!-----------------------consolidatedReply Add Action Check Start --------------------------------------------------------------------------------------------------->
 								
 								              <%if(obj[19]!=null && Long.parseLong(obj[19].toString())!= 1  && obj[25]!=null && obj[25].toString().equalsIgnoreCase("P") ){%>
 								
 		                <%if(obj[5].toString().equalsIgnoreCase("DD")||obj[5].toString().equalsIgnoreCase("DA")||obj[5].toString().equalsIgnoreCase("DR") 
 				                   &&  
 		                        ((!obj[5].toString().equalsIgnoreCase("RP")) &&(!obj[5].toString().equalsIgnoreCase("FP")) &&(!obj[5].toString().equalsIgnoreCase("AP"))&&(!obj[5].toString().equalsIgnoreCase("DC")) )  ){ %>
 		
 										<input type="hidden" name="redirValForConsoReplyAdd"	value="DakPendingPNCListRedir" />
 									
 									 <button type="submit" class="btn btn-sm icon-btn" name="DakIdFromCR"  
 									formaction="ConsolidatedReply.htm"  id=<%="DakIdCR"+obj[0]  %> value="<%=obj[0] %>" 
 									 data-toggle="tooltip" data-placement="top" title="" data-original-title="Consolidated Reply" > 
									<img alt="mark" src="view/images/consolidated.png"> 
 										  </button>	 
 									  
 						       <%}%>
 						<%} %> 
 								
 							
									</td> 
                                                    
										   </tr>
									<%count++;}} %> 
							</tbody>
							</tbody>
					</table>		
 		</form>			
      </div>
   </div>
 
 <!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DAK Pending PNC Reply List End @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
 
 
 
 
 <!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DAK  PNC  List Start @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
 
 <div class=" tab-pane PNC-Module" id="pills-IPD" role="tabpanel" aria-labelledby="pills-IPD-tab" >

<div class="table-responsive" style="overflow:hidden;">
					<form action="#" method="post" id="PNCListForm">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="fromDateFetch"	value="<%=frmDt%>" />	
 					<input type="hidden" name="toDateFetch"	value="<%=toDt%>"/>	
 				
 						<input type="hidden" name="viewfrom" value="DakPncList">
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTablePNC">
							<thead>
								<tr>
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">DAK Id</th>
									<th class="text-nowrap">Head</th>
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">Ref No & Date</th>
									<th class="text-nowrap">Action Due</th>
									<th class="text-nowrap">Subject</th>
								    <th class="text-nowrap">DAK Status</th>
									<th class="text-nowrap">Status</th>
									<th style="width: 170px;">Action</th>
						</tr>
							</thead>
							<tbody>		
							<%
								 int sn=1;
							     String DakStatus = null;
								if(DakPnCList!=null && DakPnCList.size()>0){
									for(Object[] obj:DakPnCList){
									
										if(obj[5]!=null ){
											DakStatus = obj[5].toString();
			                                   ////////////////////////////////////
											   //obj[27] - CountOfAllMarkers
											   //obj[28] - CountOfActionMarkers
											   //obj[29] - CountOfMarkersAck
											   //obj[30] - CountOfMarkersReply
										
										  	String StatusCountAck = null;
			                          		String StatusCountReply = null;

			                                  if (DakStatus.equalsIgnoreCase("DC") && !DakStatus.equalsIgnoreCase("AP")
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
				
										   %>
										   
								 <tr <%if(obj[32]!=null && Long.parseLong(obj[32].toString())==3){ %> class="HighlightHighPrior"<%}%>>
									 <td style="width:10px;"><%=sn%></td>
	 					             <td class="wrap" style="text-align: left;width:100px;">
	 					          	   <a class="font" href="javascript:void()" style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakPNCList')">
                                         <% if (obj[8] != null) { %><%= obj[8].toString() %><% } else { %>-<% } %>
                                       </a>
                                     </td>
                                     <td style="text-align: center;width:10px;"><%if(obj[18]!=null){ %><%=obj[18].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td> 
								     <td style="text-align: center;width:80px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
								     <td  class="wrap" style="text-align: left;width:180px;"><%if(obj[14]!=null){ %><%=obj[14].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap"  style="text-align: left;width:90px;text-align: center;font-weight:bold;">
								
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
									<td style="text-align: center;font-weight:bold;width:15%;">

 <!----Preview Button ----------->									 
								 <button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]  %> value="<%=obj[0] %>" 
									 formaction="DakReceivedView.htm" formmethod="post" formtarget="_blank"
									  data-toggle="tooltip" data-placement="top" title="" data-original-title="Preview"> 
															<img alt="mark" src="view/images/preview3.png">
 								 </button>
           
 <!-----------------------consolidatedReply Add Action Check Start --------------------------------------------------------------------------------------------------->
         
           <!--obj[19]-- signifies ActionId so ActionId 1 i.Records is not allowed for consolidatedReplyAdd-->								
           <!--obj[25]--P&C DO has Closing Authority(P) consolidatedReplyAdd concept comes otherwise no flow of P&C DO bcz When closing authority others(O) is selected that Dak will not come in P&C DO list--> 
                  
                     <%if(obj[19]!=null && Long.parseLong(obj[19].toString())!= 1  && obj[25]!=null && obj[25].toString().equalsIgnoreCase("P") ){%>
 								
 		                <%if(DakStatus.equalsIgnoreCase("DD")||DakStatus.equalsIgnoreCase("DA")||DakStatus.equalsIgnoreCase("DR") 
 				                   &&  
 		                        ((!DakStatus.equalsIgnoreCase("RP")) &&(!DakStatus.equalsIgnoreCase("FP")) &&(!DakStatus.equalsIgnoreCase("AP"))&&(!DakStatus.equalsIgnoreCase("DC")) )  ){ %>
 		
 			                        <input type="hidden" name="redirValForConsoReplyAdd"	value="PNCListRedir" />		  
 		
 									 <button type="submit" class="btn btn-sm icon-btn" name="DakIdFromCR"  
 									formaction="ConsolidatedReply.htm"  id=<%="DakIdCR"+obj[0]  %> value="<%=obj[0] %>" 
 									 data-toggle="tooltip" data-placement="top" title="" data-original-title="Consolidated Reply" > 
									<img alt="mark" src="view/images/consolidated.png"> 
 										  </button>	 
 										  
 						       <%}%>
 						<%} %>		 
<!------------------------------consolidatedReply Add Action Check End ---------------------------------------------------------------------------------------------->
 									
 		 <input type="hidden" name="DakNo_<%=obj[0]%>"	value="<%=obj[8]%>" />	 <!-- commonInputTypeHidden -->
 
			
<!-----------------------consolidatedReply Edit Action Check Start --------------------------------------------------------------------------------------------------->
  		 		
  				 <%
  				String EditType  = "Reply Edit";
  				if(DakStatus.equalsIgnoreCase("RP") && !DakStatus.equalsIgnoreCase("DC")
		        && obj[25]!=null && obj[25].toString().equalsIgnoreCase("P")
				&& obj[21]!=null && obj[21].toString().equalsIgnoreCase("R") 
				&& obj[24]!=null && (obj[24].toString().equalsIgnoreCase("N") || !DakStatus.equalsIgnoreCase("FP"))){ %>
				
				<input type="hidden" name="redirValForConsoReplyEdit"	value="PNCListRedir" />
				
				<button type="submit" class="btn btn-sm icon-btn" name="DakPnCReplyDataForEdit"  
 				formaction="ConsolidatedReplyEdit.htm"  value="<%=obj[22]%>#<%=obj[0] %>" 
 				 data-toggle="tooltip" data-placement="top" title="P&C Reply Edit" 
 				 data-original-title="<%=EditType%>" > 
				<img alt="mark" src="view/images/editPNC.png"> 
				</button>	  
 										  			  
				
		 
		<%}%>		
 								    
 								
<!-----------------------consolidatedReply Edit Action Check End --------------------------------------------------------------------------------------------------->
 
 
			  </td> 
				</tr>
				<%sn++;}}} %>
							</tbody>
						</table>
                       </form>
                       </div>
</div>
</div>

 <!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DAK  PNC  List End @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
 
</div>
		
		 	
</body>
<script type="text/javascript">
$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
});
$(document).ready(function () {
    var selectedTabValue = '<%=SelectedTab%>';
  
    var defaultTab = (selectedTabValue === 'DakPNCList') ? 'PNC' : 'PendingPNCReply';
    console.log("defaultTabValue: " + defaultTab);

    // Set the default tab
    $('.' + defaultTab + '-Tab').addClass('active');
    $('.' + defaultTab + '-Module').addClass('show active');


    var otherTab = (defaultTab === 'PNC') ? 'PendingPNCReply' : 'PNC';
    console.log("otherTabValue: " + otherTab);
    
    // Remove the active class from the other tab
    $('.' + otherTab + '-Tab').removeClass('active');
    $('.' + otherTab + '-Module').removeClass('show active');
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

<script type="text/javascript">
$("#myTablePendingPNC").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	
</script>

<script type="text/javascript">
$("#myTablePNC").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	


</script> 

</html>
