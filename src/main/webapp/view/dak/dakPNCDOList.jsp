<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DAK PnC DO List</title>
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
				<h5 style="font-weight: 700 !important">DAK P&C DO List</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK P&C DO List</li>
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
		String statusFilteration =(String)request.getAttribute("statusValue");
		
		List<Object[]> DakPnCDOList=(List<Object[]>)request.getAttribute("DakP&CList");
		
		%>
		
		<div class="card loadingCard" style="display: none;">
    	<div class="card-header"style="height: 2.7rem">
  <form action="DakPNCDOList.htm" method="POST" id="myform"> 
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
										<button type="submit" class="btn btn-sm ExcelDownLoadBtn" id="DownLoadExcel" formaction="DownloadExcel.htm" formmethod="post"> <img alt="Excel" src="view/images/Excel.png"></button>&nbsp;&nbsp;
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
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="fromDateFetch" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <div class="col-1" style="font-size: 16px; padding-left:30px;  ">
              <label for="todate" style="text-align: center;font-size: 16px;width:20px;">To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            <div class="col-4" style="padding: 0; float:right;">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="toDateFetch" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
           <!--  <div class="col-1"></div> Empty column for spacing -->
          </div>
        </div>
      </div>
    </div>
  </form>
</div>


<div class="table-responsive" style="overflow:hidden;">
					<form action="#" method="post" id="PNCDoListForm">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="fromDateFetch"	value="<%=frmDt%>" />	
 					<input type="hidden" name="toDateFetch"	value="<%=toDt%>"/>	
 					<input type="hidden" name="viewfrom" value="DakPncDoList">
 					
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
								<tr>
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">DAK Id</th>
									<th class="text-nowrap">Email Type</th>
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">DAK Brief</th>
									<th class="text-nowrap">A/R</th>
									<!-- <th class="text-nowrap">Ref No & Date</th> -->
									<th class="text-nowrap">Action Due</th>
								    <th class="text-nowrap">Keyword1</th> 
								    <th class="text-nowrap">Reply  Date</th> 
								    <th style="width: 200px;">Reply Details</th> 
								    <th class="text-nowrap">DAK Status</th>
									<th class="text-nowrap">Status</th>
									<th style="width: 100px;">Action</th>
						</tr>
							</thead>
							<tbody>		
							<%
								 int count=1;
							     String DakStatus = null;
								if(DakPnCDOList!=null && DakPnCDOList.size()>0){
									for(Object[] obj:DakPnCDOList){
									
										if(obj[5]!=null ){
											DakStatus = obj[5].toString();
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
										   String replieddate=null;
										   if(obj[38]!=null && !"NA".equalsIgnoreCase(obj[38].toString())){
											   String[] markerDate=obj[38].toString().split(" ");
											   replieddate=markerDate[0];
										   }
										  	  //obj[27] - CountOfAllMarkers//obj[28] - CountOfActionMarkers//obj[29] - CountOfMarkersAck//obj[30] - CountOfMarkersReply
			                          	   
										  	  
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
				
			           						String EditType = null;
			           					    if(obj[21]!=null && obj[21].toString().equalsIgnoreCase("R")){ 
			         					        EditType="Approved Reply Edit";
			         					    }else if (obj[21]!=null && obj[21].toString().equalsIgnoreCase("D")){ 
			         					    	EditType="Returned Reply Edit";
			         					    }else{
			         					    	EditType = "Reply Edit";
			         					    }
			         					
										   %>
										   
										   <tr <%if(obj[41]!=null && Long.parseLong(obj[41].toString())==3){ %> class="HighlightHighPrior"<%}%>>
									<td style="width:10px;"><%=count %></td>
	 					        <td class="wrap" style="text-align: left;width:100px;">
	 					          	<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakDetailedList')">
                                    <% if (obj[8] != null) { %>
                                    <%= obj[8].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
                                     </td>
                                     <td style="text-align: center;width:10px;"><%if(obj[40]!=null){ %><%=obj[40].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
                                      <td  class="wrap" style="text-align: left;width:180px;"><%if(obj[31]!=null){ %><%=obj[31].toString() %><%}else{ %>-<%} %></td>
                                     <td style="text-align: center;width:10px;"><%=Action %></td>
									<%-- <td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td> --%>
									<td style="text-align: center;width:80px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
									<td  class="wrap" style="text-align: left;width:100px;"><%if(obj[32]!=null){%><%=obj[32]%><%}else{ %>-<%} %></td> 
									<td style="text-align: center;width:80px;"><%if(obj[38]!=null && !"NA".equalsIgnoreCase(obj[38].toString())){ %><%=sdf.format(rdf.parse(replieddate)) %><%}else{ %><%="NA" %><%} %></td>
									 <td style="text-align: left;width:10px;"><%if(obj[39]!=null){ %><%=obj[39].toString() %><%}else{ %>-<%} %></td>
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
 		
 										<input type="hidden" name="redirValForConsoReplyAdd"	value="PNCDOListRedir" />
 									
 									 <button type="submit" class="btn btn-sm icon-btn" name="DakIdFromCR"  
 									formaction="ConsolidatedReply.htm"  id=<%="DakIdCR"+obj[0]  %> value="<%=obj[0] %>" 
 									 data-toggle="tooltip" data-placement="top" title="" data-original-title="Consolidated Reply" > 
									<img alt="mark" src="view/images/consolidated.png"> 
 										  </button>	 
 									  
 						       <%}%>
 						<%} %>		  
<!------------------------------consolidatedReply Add Action Check End ---------------------------------------------------------------------------------------------->
 									
 		  <input type="hidden" name="DakNo_<%=obj[0]%>"	value="<%=obj[8]%>" />	 <!-- commonInputTypeHidden -->
 
          <!--obj[19]-- No need of Action Check as RP update is never allowed for records(by using obj[19]) so consolidatedReply edit will never come for records  -->						 			 
 		   <!--obj[25]--P&C DO has Closing Authority(P) consolidatedReplyAdd concept comes otherwise no flow of P&C DO bcz When closing authority others(O) is selected that Dak will not come in P&C DO list--> 
           <!--obj[24]-- signifire Director Approval if it is R(required) then only await for Director Approval if its N(not required) than directly close option will be provided -->      				
            
  <!------------------------------In P&C Do when its allready then two option i give to edit and as well as forward if director approval R Start------------------------------------------------------------------------------------------------->									
 
  <%if((DakStatus.equalsIgnoreCase("RP") || DakStatus.equalsIgnoreCase("FP"))
		&& obj[25]!=null && obj[25].toString().equalsIgnoreCase("P")
				&& obj[21]!=null && obj[21].toString().equalsIgnoreCase("R") ){%>
				
				<input type="hidden" name="redirValForConsoReplyEdit"	value="PNCDOListRedir" />
				
				<button type="submit" class="btn btn-sm icon-btn" name="DakPnCReplyDataForEdit"  
 				formaction="ConsolidatedReplyEdit.htm"  value="<%=obj[22]%>#<%=obj[0] %>" 
 				 data-toggle="tooltip" data-placement="top" title="P&C Reply Edit" 
 				 data-original-title="<%=EditType%>" > 
				<img alt="mark" src="view/images/editPNC.png"> 
				</button>	  
 										  
 						<%if( obj[24]!=null && obj[24].toString().equalsIgnoreCase("R") && !DakStatus.equalsIgnoreCase("FP")) {%>				  
 				 <button type="submit" class="btn btn-sm icon-btn" name="ForwardPNCDakId"  
 					formaction="ForwardPNCReply.htm"  id="" value="<%=obj[0] %>" 
 				    data-toggle="tooltip" data-placement="top" title="" data-original-title="Forward Reply" 
 				    onclick="return confirm('Are you sure to forward this DAK?');">
				   <img alt="mark" src="view/images/forwardPNCReply.png"> 
 										  </button>	 			
 	           <%} %>		  
				
		 
		<%}%> 
 
 <!------------------------------awaiting dir approval Msg Check Start------------------------------------------------------------------------------------------------->									
 		 
 		      				
                  	 <%if(DakStatus.equalsIgnoreCase("FP") 
 								&& obj[24]!=null && obj[24].toString().equalsIgnoreCase("R")
 								&& obj[25]!=null && obj[25].toString().equalsIgnoreCase("P")
 								&& obj[21]!=null && obj[21].toString().equalsIgnoreCase("R") ){%>
 									 
 								<span style="font-weight:bold;font-size:10px;color:green;padding-right:10px;padding-left:10px;">
 								awaiting dir approval
 								</span>
 					<%}%> 
<!------------------------------awaiting dir approval Msg Check End----------------------------------------------------------------------------------------------------->							  
 								
<!-----------------------consolidatedReply Edit Action Check Start --------------------------------------------------------------------------------------------------->
  		    <!--###Allow Edit when Director Returned P&CDOReply###-- obj[21] signifies PnCReplyStatus not exists for this DAK than it returns NA if exists than it returns [P- Pending P&C DO Reply] OR [R-Replied by P&C DO]  OR [D- Director Returned Reply]  -->
  			<!------------------------------------------------------ obj[22] signifies PnCReplyId just cross checking PnCReplyId exist or not and greater than 0 or not to edit-->
  			<!--###Allow Edit when Director Approve WithComment###-- obj[23] signifies it is approved with comment that time also we will allow consolidated reply edit -->
  			<!------------------------------------------------------ obj[19] No need of Action Check as RP update is never allowed for records(by using obj[19]) so consolidatedReply edit will never come for records  -->						 			 
  			<!------------------------------------------------------ obj[25] signifies Closing Authority only When P i.e P&C DO has Closing Authority consolidatedReplyEdit concept comes otherwise no flow of P&C DO
  					
  						<!--Conditions-->
  						  <%
				
  						 if( 
  							   (
  							    ((DakStatus.equalsIgnoreCase("RP") || DakStatus.equalsIgnoreCase("FP")) && obj[21]!=null && !obj[21].toString().equalsIgnoreCase("NA") && obj[21].toString().equalsIgnoreCase("D")) 
  							    ||
  							    (DakStatus.equalsIgnoreCase("AP")  && obj[23]!=null))
 							   && obj[22]!=null &&  Long.parseLong(obj[22].toString())>0 && !DakStatus.equalsIgnoreCase("DC")  && obj[25]!=null && obj[25].toString().equalsIgnoreCase("P")){%>
 									<input type="hidden" name="redirValForConsoReplyEdit"	value="PNCDOListRedir" />
 								
 								<!-- Its allowed when not approved returned and also When approved with comment but never after Dak is closed-->
 									 <button type="submit" class="btn btn-sm icon-btn" name="DakPnCReplyDataForEdit"  
 									formaction="ConsolidatedReplyEdit.htm"  value="<%=obj[22]%>#<%=obj[0] %>" 
 									 data-toggle="tooltip" data-placement="top" title="" data-original-title="<%=EditType%>"> 
				
										<img alt="mark" src="view/images/editConsolidatedReply.png"> 
									
 										  </button>	  
 									
 									  <%}%> 
 									
<!-----------------------consolidatedReply Edit Action Check End --------------------------------------------------------------------------------------------------->
 
 
 
 <!-----------------------DAK Close Action Check start --------------------------------------------------------------------------------------------------->
 	                          
 	                           <%/*********If Dir Approved with Comment than Dak Close will be available with DakApprovedCommtPopUp *******/
 									String ApprovedCommtData = "--";
 									String ApprovedCommtCheckData = "NA";
 									if(DakStatus.equalsIgnoreCase("AP")&& obj[23]!=null){
 										ApprovedCommtCheckData = "ApproveCommtPopUp";
 										ApprovedCommtData = obj[23].toString();
 									}
 									/****************/%>
 									
 		<!-- No need of Action check as AP update is never allowed for records -->								 
 				 <!--### ALLOW P&CDO CLOSE WHEN DakStatus is not equal to DC and Closing Authority O-->
 				 <!--### ALLOW P&CDO CLOSE WITH DIR APPROVAL WHEN obj[24] is R && DakStatus is AP BECAUSE AP Status update is possible only when obj[24] is R && ###-- obj[24]-DirectorApproval-->
 				 <!--### ALLOW P&CDO CLOSE WITHOUT DIR APPROVAL WHEN obj[24] is N && DakStatus is NOT AP BECAUSE AP Status update is not possible when obj[24] is N-->
 						 <%if( obj[42]==null &&
 							  (!DakStatus.equalsIgnoreCase("DC") &&  obj[25]!=null && obj[25].toString().equalsIgnoreCase("P")
 							     &&
 							     ((obj[24]!=null && obj[24].toString().equalsIgnoreCase("R") && DakStatus.equalsIgnoreCase("AP"))  
 								 ||  
 							     (obj[24]!=null && obj[24].toString().equalsIgnoreCase("N") && !DakStatus.equalsIgnoreCase("AP")))
 							   )){%>
 								<input type="hidden" name="DakNoToClose_<%=obj[0]%>"	value="<%=obj[8] %>" />	
 										
 									<button type="button" class="btn btn-sm icon-btn" 
 									data-toggle="tooltip" data-placement="top" data-original-title="Dak Close" 
 									 data-ApprovedCommt-value="<%=ApprovedCommtData%>"
                                     onclick="return DakCloseValidation('<%=obj[0]%>','<%=ApprovedCommtCheckData%>', this,'<%=obj[8] %>','<%=obj[3] %>')"
                                     ><img alt="mark" src="view/images/dakClose.png"> 
 									</button>	
 									 
 							
 							 <%}%> 
 							 
 							 <%if(obj[5]!=null && obj[42]!=null && obj[5].toString().equalsIgnoreCase("AP")){ %>
 							  <input type="hidden" id="subject<%=obj[0] %>" value="<%=obj[14] %>">
 								 <button type="button" class="btn btn-sm icon-btn" name="MainDakCreateId" onclick="replyMainLabDakReply('<%=obj[0] %>','<%=obj[42] %>','<%=obj[43] %>','<%=obj[44] %>','<%=obj[8] %>','<%=obj[3] %>','<%=obj[14] %>')"
 									 data-toggle="tooltip" data-placement="top" title="" data-original-title="Outside Lab Reply" > 
									<img alt="mark" src="view/images/auto-reply.png"> 
 										  </button>	 
 							<%} %>
 							 
 <!-----------------------DAK Close Action Check End --------------------------------------------------------------------------------------------------->
 			 
 <!-----------------------DAK Close Status show case removed(this is removed as recently Dak Closed will go to DakClosed List) --------------------------------------------------------------------------------------------------->
			  </td> 
				</tr>
				<%count++;}}} %>
							</tbody>
						</table>
                       </form>
</div>
</div>
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
                     <input type="hidden" name="fromDateFetch"   value="<%=frmDt%>" />	
                      <input type="hidden" name="toDateFetch"	 value="<%=toDt%>" />	
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
                     <input type="hidden" name="fromDateFetch"   value="<%=frmDt%>" />	
                      <input type="hidden" name="toDateFetch"	 value="<%=toDt%>" />	
                    </div>
                     
	  	        </form>
	  	      		
	  	      		
	  	      </div>
	  	     </div>
	  	    </div>
		   </div>
		
		 <!----------------------------------------------------  DAK Close Approve With Closing Comment Modal End     ----------------------------------------------------------->
		 
		 
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
  	      				<textarea class="form-control replyTextArea"  name="replyRemarks" style="min-width: 135% !important;min-height: 30vh;"  id="reply" required="required"  maxlength="1000"  oninput="checkCharacterLimit()"> </textarea>
  	      			</div>
  	      			<br>
  	      				<label style="font-weight:bold;font-size:16px;">Dak Closing Comment :</label>
  	      		
  	      		<div class="row">
  	      		    <!-- new file add start -->
  	      			<div class="col-md-5 ">
  	      				<textarea class="form-control DakCloseCommtInputMainLab"  name="DakClosingComment" style="min-width: 115% !important;min-height: 10vh;"  id="closingCommtMain" required="required"  maxlength="1000"  oninput="ClosingCommentcheckCharacterLimit()"> </textarea>
  	      			</div>
  	      			<!-- new file add end -->
  	      			
  	      			<!--copy files attached & delete those copy Start-->
  	      			<div class="col-md-5 " style="float:left;margin-top:-42px;">
  	      				<br>
  	      	      
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
  	      		  <input type="hidden" name="dakCreateId"  id="seldakCreateId" value="" >
  	      		  <input type="hidden" name="appUrl"  id="appUrl" value="" >
  	      		  <input type="hidden" name="SourceDetailId"  id="SourceDetailId" value="" >
  	      		    <input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
					<input type="hidden" name="ReplyFrom" value="DakPandcDoList">
					
					<input type="hidden" id="ReplyMailSubject" name="ReplyMailSubject" value="">
					<input type="hidden" id="HostType" name="HostType" value="">
  	      			<input type="button" formaction="MainLabDAKReply.htm"  class="btn btn-primary btn-sm submit" id="sub" value="Submit" name="sub"  onclick="return dakReplyValidation()" > 
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
 
<!----------------------------------------------------  Reply  Modal End    ----------------------------------------------------------->
</body>
<script>
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
</script>
<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	

function replyMainLabDakReply(DakId,DakCreateId,appUrl,SourceDetailId,DakNo,Source,subject) {

	$('#MainLabDakReplyexampleModalReply').modal('show');
	$('#MainLabDakNo').html(DakNo);
	$('#MainLabSourceNo').html(Source);
	
 	var value=$('#subject'+DakId).val();
	 
	 $('#ReplyMailSubject').val(value);
	 
	$('#dakIdOfReply').val(DakId);
	$('#seldakCreateId').val(DakCreateId);
	$('#appUrl').val(appUrl);
	$('#SourceDetailId').val(SourceDetailId);
}

function checkCharacterLimit() {
    var textarea = document.getElementById("reply");
    var maxlength = textarea.getAttribute("maxlength");
    var textLength = textarea.value.length;

    if (textLength > maxlength) {
        textarea.value = textarea.value.substring(0, maxlength); // Truncate the text to the maxlength
        alert("You have reached the maximum character limit.");
    }
}

function ClosingCommentcheckCharacterLimit() {
    var textarea = document.getElementById("closingCommtMain");
    var maxlength = textarea.getAttribute("maxlength");
    var textLength = textarea.value.length;

    if (textLength > maxlength) {
        textarea.value = textarea.value.substring(0, maxlength); // Truncate the text to the maxlength
        alert("You have reached the maximum character limit.");
    }
}

function dakReplyValidation() {

   var isValidated = false;
   var replyRemark = document.getElementsByClassName("replyTextArea")[0].value;
   var closingcomment = document.getElementsByClassName("DakCloseCommtInputMainLab")[0].value;
   console.log('replyRemark',replyRemark);
   console.log('closingcomment',closingcomment);
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


	function DakCloseValidation(DakId,Action,button,dakno,source){ // this will give particular clicked button

		if(Action == "ApproveCommtPopUp"){
			// Retrieve the data attribute containing ApprovedCommtData 
			var ApproveCommt = button.getAttribute('data-ApprovedCommt-value');
	         console.log('dataAttribute',ApproveCommt);
	        
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


</script>
</html>
