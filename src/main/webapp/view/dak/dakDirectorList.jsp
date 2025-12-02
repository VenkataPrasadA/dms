<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<%@page import="java.time.LocalTime"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Director List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
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

.list-Count{
    margin-left: 0.5rem;
    margin-top: -0.15rem;
    font-size:15px;
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
				<h5 style="font-weight: 700 !important"> DAK Director List </h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Director List</li>
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
		SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		String SelectedTab = null;
		String TabData = (String)request.getAttribute("tabSelectedVal");
		if(TabData!=null && TabData.trim()!=""){
			SelectedTab = TabData;
		}else{
			SelectedTab = "PendingAprvList";  //Default value
		}
		
		//String PageValue =(String)request.getAttribute("pageVal");
		String rowValue =(String)request.getAttribute("rowVal");
		System.out.println("RowValueeea@@@@@@@@@@@@"+rowValue+"seecteedTabbbb"+TabData);

		String CountForMsgRedirect =(String)request.getAttribute("countForMsgRedirect");
		List<Object[]> DirPendingApprovalList=(List<Object[]>)request.getAttribute("dirPendingApprovalList");
		List<Object[]> DakDirectorList=(List<Object[]>)request.getAttribute("dakDirectorList");
		List<Object[]> DakMembers = (List<Object[]>) request.getAttribute("DakMembers");
		List<Object[]> DakMemberGroup = (List<Object[]>) request.getAttribute("DakMemberGroup");
		List<Object[]> actionList = (List<Object[]>) request.getAttribute("actionList");
		String statusFilteration =(String)request.getAttribute("statusValue");
		%>
		
		<% String ses=(String)request.getParameter("result"); 
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
    
	
    	<div class="card loadingCard" style="display: none;">
    	


		<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  <li class="nav-item" style="width: 50%;"  >
		    <div class="nav-link Pending-Tab" style="text-align: center;" id="pills-OPD-tab" data-toggle="pill" data-target="#pills-OPD" role="tab" aria-controls="pills-OPD" aria-selected="true">
			   <span>Pending Approvals List
				   <span class="badge badge-danger badge-counter list-Count">
				   		<%if(DirPendingApprovalList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DirPendingApprovalList.size() %>
						<%} %>				   			
				  </span>  
				</span> 
		    </div>
		  </li>
		  <li class="nav-item"  style="width: 50%;">
		    <div class="nav-link Director-Tab" style="text-align: center;" id="pills-IPD-tab" data-toggle="pill" data-target="#pills-IPD" role="tab" aria-controls="pills-IPD" aria-selected="false">
		    	 <span>DAK Director List   
				   <span class="badge badge-danger badge-counter list-Count">
				   		<%if(DakDirectorList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DakDirectorList.size() %>
						<%} %>				   			
				   </span>  
				</span> 
		    
		    
		    </div>
		  </li>
		</ul>





<div class="tab-content" id="pills-tabContent">


<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@DAK PENDING APPROVAL LIST START @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
	
	<div class="card tab-pane Pending-Module" id="pills-OPD" role="tabpanel" aria-labelledby="pills-OPD-tab" >	
	<div class="card-body" style="width: 99%">
	<div class="table-responsive" style="overflow:hidden;">
		<form action="#" method="post" id="DakDirectorApprovalListForm">
		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
		 <input type="hidden" name="fromDateCmnValue"	value="<%=frmDt%>" /> 
		 <input type="hidden" name="toDateCmnValue"	value="<%=toDt%>" />	
		 <input type="hidden" name="viewfrom" value="DakDirectorList">
		 <table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
								<tr>
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
								<tbody>		
								<% int countData = 1;
						       String DakStat = null;
						       String PnCReplyStat = null;
						       String DirApproval = null;
						       String CloseAuthority = null;
						       if (DirPendingApprovalList != null && DirPendingApprovalList.size() > 0) {
						    	    for (Object[] data : DirPendingApprovalList) {
		                            	  if (data[5] != null){
		                            		  DakStat = data[5].toString();
		                            		  
		                            			//obj[27] - CountOfAllMarkers//obj[28] - CountOfActionMarkers//obj[29] - CountOfMarkersAck//obj[30] - CountOfMarkersReply
		                                	    String CountAck = null;
		                                		String CountReply = null;

		                                        if (!DakStat.equalsIgnoreCase("DC") && !DakStat.equalsIgnoreCase("AP")
		                                            && !DakStat.equalsIgnoreCase("RP") && !DakStat.equalsIgnoreCase("RM")
		                                            && !DakStat.equalsIgnoreCase("FP")) {
		                                       //Ack Count
		                                            if (data[30] != null && Long.parseLong(data[30].toString()) == 0 && data[29] != null && Long.parseLong(data[29].toString()) > 0) {
		                                                CountAck = "Acknowledged<br>[" + data[29] + "/" + data[27] + "]";
		                                            }
		                                       //Reply Count
		                                            if (data[29] != null && Long.parseLong(data[29].toString()) > 0 && data[28] != null && Long.parseLong(data[28].toString()) > 0
		                                                && data[30] != null && Long.parseLong(data[30].toString()) > 0) {
		                                                CountReply = "Replied<br>[" + data[30] + "/" + data[28] + "]";
		                                            }
		                                        }    
		      							
						       %>
						        <% String IdData = "dakRow"+data[0].toString();%>
						       	<tr   data-row-id=rowPendingAprvList-<%=countData%>   <%if(data[21]!=null && Long.parseLong(data[21].toString())==3){ %> class="HighlightHighPrior"<%}%> id="<%=IdData%>">
						       	 <td style="width:10px;"><%=countData %></td>
						       	 <td class="wrap" style="text-align: left;width:80px;">
	 					          	<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=data[0] %>','DakDetailedList')">
                                    <% if (data[8] != null) { %>
                                    <%= data[8].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
                                     </td>
                                      <td style="text-align: center;width:10px;"><%if(data[18]!=null){ %><%=data[18].toString() %><%}else{ %>-<%} %></td>
                                      <td class="wrap" style="text-align: center;width:100px;"><%if(data[3]!=null){ %><%=data[3].toString() %><%}else{ %>-<%} %></td>
									  <td class="wrap" style="text-align: left;width:150px;"><%if(data[4]!=null){ %><%=data[4].toString() %><%}else{ %>-<%} %><br><%if(data[6]!=null){%><%=sdf.format(data[6])%><%}else{ %>-<%} %></td>
									  <td style="text-align: center;width:80px;"><%if(data[10]!=null){ %><%=sdf.format(data[10]) %><%}else{ %><%="NA" %><%} %></td>
									  <td  class="wrap" style="text-align: left;width:180px;"><%if(data[14]!=null){%><%=data[14]%><%}else{ %>-<%} %></td> 
									 <td class="wrap"  style="text-align: left;width:80px;text-align: center;font-weight:bold;">
									 
									   <%if(data[7]!=null) {%>
									
									<%if(CountAck!=null) {%> <%=CountAck%><%}else if(CountReply!=null) {%><%=CountReply%>
									     <%}else{%><%=data[7].toString() %> <%}%>
									    <%} %>
									
									  </td>
									    <td  class="<%=data[13]%>" style="text-align: left;width:40px;text-align: center;font-weight:bold;"><%if(data[13]!=null) {%><%=data[13].toString() %><%}else{ %>-<%} %></td>
									  <td style="text-align: left;font-weight:bold;width:12%;">
									  <input type="hidden" name="fromDateFetch"	value="<%=frmDt %>" /> 
			                          <input type="hidden" name="toDateFetch"	value="<%=toDt%>" />	
			                          <input type="hidden" name="ActionForm" vaLue="DakDirectorList"> 
			                          
			                            <%if(!"DI".equalsIgnoreCase(DakStat)) {%>
 			                         <!---DAK Preview Button------->				
			                         <button type="submit" formaction="DakReceivedView.htm" formtarget="_blank" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+data[0]  %> value="<%=data[0] %>" 
 					                  data-toggle="tooltip" formmethod="post" data-placement="top" title="Preview"> 
 								    <img alt="mark" src="view/images/preview3.png">
			                          </button>
			                          
			                         			    
                                     <%--  <input type="hidden"name=PageNoPendingAprvList<%=data[0]%>   id=PageNoPendingAprvList<%=data[0]%> value="<%=PageNo%>" />	 --%>
                                           <input type="hidden" name=RowPendingAprvList<%=data[0]%>  id=RowPendingAprvList<%=data[0]%> value="<%=countData%>"> 
			                          
			                      
			    
			    
			                         
			                         
			                          <!--(COMMON CONDITION FOR BOTH P&CDO  &  OTHERS  START )###Allow DAK Approve ONLY if DirectorApproval(obj[25]) is R no matter closingAuthority(obj[26]) is P or O-->
			
		                       <%if(data[23]!=null && data[24]!="null" && data[25]!="null" && data[24].toString().equalsIgnoreCase("R") && !DakStat.equalsIgnoreCase("AP")){
				                    PnCReplyStat = data[23].toString();
				                    DirApproval = data[24].toString();
							        CloseAuthority = data[25].toString();
		
			            	   %>		

                  <!--------------DAK Approve Button for CLOSING AUTHORITY(P&CDO) Start -------------------------------------->	
		         <%if(CloseAuthority.equalsIgnoreCase("P") && data[5].toString().equalsIgnoreCase("FP")
			          &&!PnCReplyStat.equalsIgnoreCase("NA") && !PnCReplyStat.equalsIgnoreCase("D")){ %>
			      <button type="button" class="btn btn-sm icon-btn" name="DakIdFrApprove"  id=<%="DakIdFrApproval"+data[0]  %> value="<%=data[0] %>" 
 					onclick="ApproveOrViewPNCDORepliedDakByDir(<%=data[0]%>,'PendingAprvList')" data-toggle="tooltip" data-placement="top" title="Director Approval"> 
 					<img alt="mark" src="view/images/approvedAction.png">
			     </button>
		         <%} %>			 
		      
                  <!--------------DAK Approve Button for CLOSING AUTHORITY(OTHERS) Start -------------------------------------->	
    	       <%if((CloseAuthority.equalsIgnoreCase("O")||CloseAuthority.equalsIgnoreCase("K") || CloseAuthority.equalsIgnoreCase("Q") || CloseAuthority.equalsIgnoreCase("R") || CloseAuthority.equalsIgnoreCase("A")) &&  !data[5].toString().equalsIgnoreCase("RP") && !data[5].toString().equalsIgnoreCase("FP")
    	    	&& data[5].toString().equalsIgnoreCase("RM") && data[26]!=null && Long.parseLong(data[26].toString())>0
			    ){ %>   
		    	<button type="button" class="btn btn-sm icon-btn" name="DakIdFrApprove"  id=<%="DakIdFrApproval"+data[0]  %> value="<%=data[0] %>" 
 					onclick="ApproveOrViewMarkerRepliedDakByDir(<%=data[0]%>,<%=data[26]%>,'PendingAprvList')" data-toggle="tooltip" data-placement="top" title="Director Approval"> 
 					<img alt="mark" src="view/images/approverRM.png">
				 </button>	
               <%} %>
		    
 			    
 			    
         <!--------------Director Returned for CLOSING AUTHORITY(P&C DO) Consolidated Reply View Start---------------------------------------->				    				
		     <%if(!PnCReplyStat.equalsIgnoreCase("NA") && PnCReplyStat.equalsIgnoreCase("D") 
				&& CloseAuthority.equalsIgnoreCase("P")&& (DakStat.equalsIgnoreCase("RP") || DakStat.equalsIgnoreCase("FP"))){ %>
									 
									  <!-- Returned Consolidated reply view Button -->	
									   <button type="button" class="btn btn-sm icon-btn" name="DakIdFrApprove"  id=<%="DakIdFrApproval"+data[0]  %> value="<%=data[0] %>" 
 									 onclick="ApproveOrViewPNCDORepliedDakByDir(<%=data[0]%>,'PendingAprvList')" data-toggle="tooltip" data-placement="top" title="P&C Reply Returned"> 
 											  <img alt="mark" src="view/images/returnedPnCReply.png">
									 </button>
 			    <%} %>
 			    
 			    
               <%} %>    		    
   <!--------------Director Returned for CLOSING AUTHORITY(Others) Markers Reply View Start---------------------------------------->	 			    
 				
		    
 
 <!--(COMMON CONDITION FOR BOTH P&CDO  &  OTHERS END )	-------------------------------------->		 
 	
 			     <%} %>
				 
								</td>
									 
						       	</tr>
						       
						       <%}%>
						       <% countData++;  %>	
						       <%}} %>
								</tbody>
								</table>
		</form>
	</div>
	</div>
	</div>
<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@DAK PENDING APPROVAL LIST END @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
	
	
<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@DAK DIRECTOR LIST START @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
  <div class=" tab-pane Director-Module" id="pills-IPD" role="tabpanel" aria-labelledby="pills-IPD-tab" >
  <div class="card-body" style="width: 99%">
  <div class="card-header"style="height: 2.7rem">
  <form action="DakDirectorList.htm" method="POST" id="myform"> 
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
                                       <button type="button" class="btn btn-sm statusBtn" id="OngoingDelay" onclick="setStatus('OngoingDelay')"><span class="ongoingdelay">DO</span><span class="ongoingdelay">&nbsp; :&nbsp;Delay - On Going</span></button>&nbsp;&nbsp;
                                      
							           <!--  <span class="completed">CO</span><span class="completed">&nbsp; :&nbsp; Completed</span> &nbsp;&nbsp; 
										<span class="completeddelay">CD</span><span class="completeddelay">&nbsp; :&nbsp; Completed with Delay</span> &nbsp;&nbsp;  -->
											<input type="hidden" id="StatusFilterValId" name="StatusFilterVal" value="">
									</p>
								</td>									
							</tr>
							</thead>
							</table>
        </div>
        <input type="hidden"  name="tabSelectedData" value="DakDirList">
        
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

  <br>
  
	<div class="table-responsive" style="overflow:hidden;">
					<form action="#" method="post" id="DakDirectorListFormActions">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
			
						<input type="hidden" name="viewfrom" value="DakDirectorList">
						<table class="table table-bordered table-hover table-striped table-condensed"   id="myTable2">
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
						<% int count = 1;
						   String DakStatus = null;
						   String DirectorApproval = null;
						   String ClosingAuthority = null;
						   String PnCReplyStatus = null;
                           if (DakDirectorList != null && DakDirectorList.size() > 0) {
                              for (Object[] obj : DakDirectorList) {
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
                                  
                                  String clickableRowId = "dakRow"+obj[0].toString(); %>
                                  
                                  
					<tr data-row-id=rowDakDirList-<%=count%> <%if(obj[21]!=null && Long.parseLong(obj[21].toString())==3){ %> class="HighlightHighPrior"<%}%> id="<%=clickableRowId%>">
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
	 					<td class="wrap" style="text-align: left;width:80px;"><a class="font" href="javascript:void()" style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakDetailedList')"> <% if (obj[8] != null) { %> <%= obj[8].toString() %>  <% } else { %>  - <% } %> </a> </td>
                        <td style="text-align: center;width:10px;"><%if(obj[18]!=null){ %><%=obj[18].toString() %><%}else{ %>-<%} %></td>
                        <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
						<td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
						<td style="text-align: center;width:80px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
						<td  class="wrap" style="text-align: left;width:180px;"><%if(obj[14]!=null){%><%=obj[14]%><%}else{ %>-<%} %></td> 
						<td class="wrap"  style="text-align: left;width:80px;text-align: center;font-weight:bold;">
						<%if(obj[7]!=null) {%><%if(StatusCountAck!=null) {%> <%=StatusCountAck%><%}else if(StatusCountReply!=null) {%><%=StatusCountReply%>
							 <%}else{%><%=obj[7].toString() %><%}%><%} %>
						</td>
						<td  class="<%=obj[13]%>" style="text-align: left;width:40px;text-align: center;font-weight:bold;"><%if(obj[13]!=null) {%><%=obj[13].toString() %><%}else{ %>-<%} %></td>
						<td style="text-align: left;font-weight:bold;width:12%;">
						<%-- <input type="hidden" name="DakNo"	value="<%=obj[8] %>" />	 --%>	
			
 			           <%if(!"DI".equalsIgnoreCase(DakStatus)) {%>
 			           <!---DAK Preview Button------->				
			              <button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]  %> value="<%=obj[0] %>" 
 					       formaction="DakReceivedView.htm" formmethod="post" formtarget="_blank"  data-toggle="tooltip" data-placement="top" title="Preview"> 
 								<img alt="mark" src="view/images/preview3.png">
			              </button>
 			          <%} %>
				 
		                          
			    <%if(!"DC".equalsIgnoreCase(DakStatus)) {%>
			      <!-- Dir Approved Msg --> <!--### AP concept comes both for Closing authority(obj[25]) i.e P and O only when director Approval is R--->
 				   <%if(obj[24]!=null && obj[24].toString().equalsIgnoreCase("R") && DakStatus.equalsIgnoreCase("AP")){%>
 					<span style="font-weight:bold;font-size:12px;color:green;padding-right:10px;padding-left:10px;">
 					Approved
 					</span>
 			       <%}%>		  							  
 			      <%}%>
	
            <!--(COMMON CONDITION FOR BOTH P&CDO  &  OTHERS  START )###Allow DAK Approve ONLY if DirectorApproval(obj[25]) is R no matter closingAuthority(obj[26]) is P or O-->
			
			   <%if(obj[23]!=null && obj[24]!=null && obj[25]!=null && obj[24].toString().equalsIgnoreCase("R") && !DakStatus.equalsIgnoreCase("AP")){
				            PnCReplyStatus = obj[23].toString();
				            DirectorApproval = obj[24].toString();
							ClosingAuthority = obj[25].toString();
			%>		
			    
            <!--------------DAK Approve Button for CLOSING AUTHORITY(P&CDO) Start -------------------------------------->	
		    <%if(ClosingAuthority.equalsIgnoreCase("P") && obj[5].toString().equalsIgnoreCase("FP")
			&&!PnCReplyStatus.equalsIgnoreCase("NA") && !PnCReplyStatus.equalsIgnoreCase("D")
		     ){ %>
			<button type="button" class="btn btn-sm icon-btn" name="DakIdFrApprove"  id=<%="DakIdFrApproval"+obj[0]  %> value="<%=obj[0] %>" 
 					onclick="ApproveOrViewPNCDORepliedDakByDir(<%=obj[0]%>,'DakDirList')" data-toggle="tooltip" data-placement="top" title="Director Approval"> 
 					<img alt="mark" src="view/images/approvedAction.png">
			</button>
					 
		    <%} %>			 

          <!--------------DAK Approve Button for CLOSING AUTHORITY(OTHERS) Start -------------------------------------->	
    	  <%if(ClosingAuthority.equalsIgnoreCase("O") &&  !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("FP")
    		&& obj[5].toString().equalsIgnoreCase("RM") && obj[26]!=null && Long.parseLong(obj[26].toString())>0
			 ){ %>   
		    	<button type="button" class="btn btn-sm icon-btn" name="DakIdFrApprove"  id=<%="DakIdFrApproval"+obj[0]  %> value="<%=obj[0] %>" 
 					onclick="ApproveOrViewMarkerRepliedDakByDir(<%=obj[0]%>,<%=obj[26]%>,'DakDirList')" data-toggle="tooltip" data-placement="top" title="Director Approval"> 
 					<img alt="mark" src="view/images/approverRM.png">
				 </button>	
          <%} %>
		    
 			    
 			    
        <!--------------Director Returned for CLOSING AUTHORITY(P&C DO) Consolidated Reply View Start---------------------------------------->				    				
		<%if(!PnCReplyStatus.equalsIgnoreCase("NA") && PnCReplyStatus.equalsIgnoreCase("D") 
				&& ClosingAuthority.equalsIgnoreCase("P")&& (DakStatus.equalsIgnoreCase("RP") || DakStatus.equalsIgnoreCase("FP"))){ %>
									 
									  <!-- Returned Consolidated reply view Button -->	
									   <button type="button" class="btn btn-sm icon-btn" name="DakIdFrApprove"  id=<%="DakIdFrApproval"+obj[0]  %> value="<%=obj[0] %>" 
 									    onclick="ApproveOrViewPNCDORepliedDakByDir(<%=obj[0]%>,'DakDirList')" data-toggle="tooltip" data-placement="top" title="P&C Reply Returned"> 
 											  <img alt="mark" src="view/images/returnedPnCReply.png">
									 </button>
 			    <%} %>
 			    
 			    
               <%} %>    		   
      <!--------------Director Returned for CLOSING AUTHORITY(Others) Markers Reply View Start---------------------------------------->	 			    
 				
		    
 
        <!--(COMMON CONDITION FOR BOTH P&CDO  &  OTHERS END )	-------------------------------------->		
 										  
		</td>
	  </tr>
       <%}  count++; } %>	
	  <%}else{ %>		
	     <tr >
	     <td colspan="11" style="text-align: center" class="center">No List Found</td>
	     </tr>
	  <%} %>									
      </tbody>
     </table>
    </form>
   </div>
  </div>
 </div>
<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@DAK DIRECTOR LIST END @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
 

   
   </div><!-- pills-tabContent close -->
</div><!-- div Class="card" close -->
   

         <!---------------loading image------------------------>
                   <div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" id="loading-modal">
                    <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                    <div id="loadingImage" style="display: none;">
                    <!-- Add your loading image or spinner HTML here -->
                    <img src="loader.gif" alt="Loading..." />
                    </div>
                        </div>
                      </div>
                    </div>
  <!----------loading image----------------->

		 

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
                               <input type="hidden" name="FromDtValDir" value="<%=frmDt %>" />
                               <input type="hidden" name="ToDtValDir" value="<%=toDt %>" />
                               <!-- <input type="hidden" id="PageRedirForApprove" value="" /> -->
                               <input type="hidden" id="RowRedirForApprove" name="RowValueFrRedirect" value="" />
                       
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
                            <input type="hidden" name="FromDtValDir" value="<%=frmDt %>" />
                            <input type="hidden" name="ToDtValDir" value="<%=toDt %>" />
                        <!--Common hidden inputs buttons for all 3 Director Action End(value is appended by JS)-->           
                
                            
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
 
 
<script type="text/javascript">
$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
});
$(document).ready(function () {
	  var selectedTabValue = "<%=SelectedTab%>";
	 

	  var defaultTab = (selectedTabValue === 'DakDirList') ? 'Director' : 'Pending';
	  console.log("defaultTabValue: " + defaultTab);
	  
	  // Set the default tab
	  $('.' + defaultTab + '-Tab').addClass('active');
	  $('.' + defaultTab + '-Module').addClass('show active');

	  // Remove the active class from the other tab
	  var otherTab = (defaultTab === 'Director') ? 'Pending' : 'Director';
	   console.log("otherTabValue: " + otherTab);
	  
	  $('.' + otherTab + '-Tab').removeClass('active');
	  $('.' + otherTab + '-Module').removeClass('show active');
	});
</script>
<script type="text/javascript">

$("#myTable1").DataTable({
	"lengthMenu": [10, 25, 50, 75, 100],
    "searching": true,
  /*   "pagingType": "simple", */
    "paging": false,
    "ordering": true

});	

$("#myTable2").DataTable({
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


console.log('frmDate');

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
	
	console.log('toDate');

	$(document).ready(function(){
		   $('#todate').change(function(){
		       $('#myform').submit();
		    });
		});



</script>


<script type="text/javascript">
$(function() {
	   $('#dakdirectorDueTime').daterangepicker({
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
 $(document).ready(function() {
	var currentDate = new Date();
	  var weekAgo = new Date();
	  weekAgo.setDate(currentDate.getDate() - 7);
$('#dakdirectorduedate').daterangepicker({
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
    var selectElement = document.getElementById("DakDirectorActionRequiredEdit");
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
                    
	                <!-- Discuss && Noted-->
	                if (value[13] != null  && value[13] != 'DI' && value[13] != 'DC'){
	                	
	                	    if (value[10] != null  && value[10] === 'N' ){ 

					<!-- Please Discuss Button -->
					dynamicRow += '<button type="button" class="btn btn-sm icon-btn" data-toggle="tooltip" data-placement="top" title="Please Discuss" name="DakId" id="DakIdFrMsg' + dakId + '" value="' + dakId + '" formaction="DakDirectorActionAdd.htm" onclick="return DirectorPassingMsg(' + value[0] + ',' + value[2] + ',' + value[3] + ',' + count + ',\'D\')"> <img alt="mark" src="view/images/pleaseDiscuss.png"></button>';

	             <!-- Noted Button -->	
	             dynamicRow += '<button type="button" class="btn btn-sm icon-btn" data-toggle="tooltip" data-placement="top" title="Noted"  name="DakId" id="DakIdFrMsg'+dakId+'" value="'+dakId+'"  formaction = "DakDirectorActionAdd.htm" onclick="return DirectorPassingMsg(' + value[0] + ',' + value[2] + ',' + value[3] + ',' + count + ',\'E\')"> <img alt="mark" src="view/images/noted.png"></button>';
	     		   
	                	  }else if(value[10] != null  && value[10] === 'D'){
	                		   dynamicRow += ' <span style="font-weight:bold;font-size:14px;color:green;padding-right:10px;padding-left:10px;">Please Discuss</span>';
	                	   }else if(value[10] != null  && value[10] === 'E'){
	                		   dynamicRow += '<span style="font-weight:bold;font-size:14px;color:green;padding-right:10px;padding-left:10px;">Noted</span>';
	                	   } 

	                }
	                
	                
                	<!-- Individual Reply Preview Button-->
	                if (value[8] != null && typeof value[8] === 'string' && value[8]=== 'Replied' && value[9]!=null ) {
                      dynamicRow += '<button type="button" class="btn btn-sm icon-btn" data-placement="top" title="Preview"  name="DakId"  id="DakId' + value[0] + '" value="' + value[0] + '"  onclick="IndividualReplyPrev('+value[0]+','+value[3]+','+value[9]+','+value[2]+','+value[15]+')">  <img alt="mark" src="view/images/replyPreview.png"></button>';	
                    }
	                
	                <!-- Revoke Button-->
	                if (value[8] != null  && value[8] != 'Replied' && value[13] != null  && value[13] != 'AP' && value[13] != 'DC' ) {
	                	dynamicRow += '<button type="submit" class="btn btn-sm delete-btn" data-toggle="tooltip" data-placement="top" title="Revoke" style="color: red;" name="RevokeDakMarkingId" id="RevokeDakMarkingId" value="' + value[2] + ',DakDirectorList,' + count + '" formaction="RevokeMarking.htm" formmethod="post" onclick="return confirm(\'Are you sure you want to delete?\')"> <i class="fa fa-undo" aria-hidden="true"></i></button>';

	                }
                                                                                                                                                                                                          
	               
	                
	                dynamicRow += '</td>';
	                dynamicRow += '<td colspan="3" >';
	                
	                <!-- Create an invisible div to store hidden inputs  through js-->
	                dynamicRow += '<div id="DirectorHiddenMarkerActionInputsContainer" style="display: none;"></div>';
	                
	                // Check a condition and add content based MarkerAction and than append
	                if (value[14] != null && typeof value[14] === 'string' && value[14]=== 'A' ) {
	                	dynamicRow += '<button type="button" class="btn btn-success" title="ForAction"  name="DakIdforMarkerAction"  id="DirectorDakIdforMarkerAction' + value[0] + '" value="' + value[0] + '" formaction="UpdateMarkerAction.htm"  style="width: 35%; height: 35px;  padding-top: 4px;" onclick="DirectorchangeMarkerAction(' + value[0] + ',' + value[2] + ',' + value[3] + ',\'I\',\'For Info\',' + count + ',\'DakDirectorList\',\'' + value[16] + '\')">For Action</button>';
	                } else {
	                	  if (value[16] != null && typeof value[16] === 'string' && value[16]=== 'ACTION' ) {
	                	 dynamicRow += '<button type="button" style="width: 35%; height: 35px;  padding-top: 4px;" name="DakIdforMarkerAction"  formaction = "UpdateMarkerAction.htm"   id="DirectorDakIdforMarkerAction' + value[0] + '" value="' + value[0] + '"  title="ForInfo"  class="btn btn-primary" onclick="DirectorchangeMarkerAction(' + value[0] + ',' + value[2] + ',' + value[3] + ',\'A\',\'For Action\',' + count + ',\'DakDirectorList\',\'' + value[16] + '\')">For Info</button>';
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
  var countForMsgRedirect = "<%= CountForMsgRedirect %>";
  if (countForMsgRedirect != 'null') {
    // Get the button element by ID
    var buttonElement  = document.getElementById('btn' + countForMsgRedirect);

    // Scroll to the button element to that view
 /*    button.scrollIntoView(); */

    // Programmatically trigger a click event on the button
    if (buttonElement) {
    buttonElement.click();
    $( "#btn"+countForMsgRedirect ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
	$( "#fa"+countForMsgRedirect ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
 	var dakId = $("#btn" + countForMsgRedirect).val();
	console.log(dakId);
	if(dakId){
	handleExpandButtonClick(dakId,countForMsgRedirect);
	}
    }
 
  }
</script>
<script>
function DirectorchangeMarkerAction(DakId, DakMarkingId, DakEmpId,MarkerAction,ActionValue,count,redirvalue,ActionRequired) {
    console.log("DakMarkingIdValue: " + DakMarkingId);
    if (DakMarkingId != null) {
        var fields = [
            { id: "directordakidmarkeraction", name: "dakidmarkeraction", value: "" },
            { id: "directordakmarkingidforMarkerAction", name: "dakmarkingidforMarkerAction", value: "" },
            { id: "directordakempidforMarkerAction", name: "DakempforMarkerAction", value: "" },
            { id: "directoractionForMarkerAction", name: "ActionForMarkerAction", value: "" },
            { id: "directorActionValueForMarkerAction", name: "ActionValueForMarkerAction", value: "" },
            { id: "directorcountForMarkerAction", name: "countForMarkerAction", value: "" },
            { id: "dakdirectorlistredirvalueformarkeraction" , name: "redirvalueformarkeraction", value:""}
        ];

        var hiddenInputsContainer = document.getElementById("DirectorHiddenMarkerActionInputsContainer");

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

    	
    	    document.getElementById("directordakidmarkeraction").value = DakId;
    	    document.getElementById("directordakmarkingidforMarkerAction").value = DakMarkingId;
    	    document.getElementById("directordakempidforMarkerAction").value = DakEmpId;
    	    document.getElementById("directoractionForMarkerAction").value = MarkerAction;
    	    document.getElementById("directorActionValueForMarkerAction").value = ActionValue;
    	    document.getElementById("directorcountForMarkerAction").value = count;
    	    document.getElementById("dakdirectorlistredirvalueformarkeraction").value = redirvalue;

    	    
    	    if(ActionRequired==='ACTION'){
      var x = confirm("Are you sure you want to Update this MarkerAction?");
      if (x) {
          var id = "DirectorDakIdforMarkerAction" + DakId;
    	// Retrieve the button element by its ID
    	  const submitButton = document.getElementById(id);
    	// Get the formaction attribute of the button
    	  const formAction = submitButton.getAttribute('formaction');
    	  console.log("Formaction: " + formAction);
    	  if (formAction) {
    		  // Update the form's action attribute with the formaction value
    		  const myDirListForm = document.getElementById('DakDirectorListFormActions');
    		  myDirListForm.action = formAction;
    		  myDirListForm.method = 'post';
    		  
    		  // Submit the form
    		  myDirListForm.submit();
    	  } else {
    		  var id = "DirectorDakIdforMarkerAction" + DakId;
    		    const submitButton = document.getElementById(id);
    		    submitButton.disabled = true;
    		    submitButton.style.backgroundColor = 'gray'; // Change background color to gray
    		    submitButton.style.cursor = 'not-allowed'; //
    	  }
     } else {
        return false;
      }
    	    }else{
    	    	var id = "DirectorDakIdforMarkerAction" + DakId;
    	    	  const submitButton = document.getElementById(id);
    	    	  submitButton.disabled = true;
    	    	  submitButton.style.backgroundColor = 'gray'; // Change background color to gray
    	    	  submitButton.style.cursor = 'not-allowed';
    	    }
    }
  }

</script>
<script type="text/javascript">
  function DirectorPassingMsg(DakId, DakMarkingId, DakEmpId, Count, ActionSelByDir) {
    console.log("DakMarkingIdValue: " + DakMarkingId);
    if (DakMarkingId != null) {
        var fields = [
            { id: "dakidFrMsg", name: "DakidFrMsg", value: "" },
            { id: "dakmarkingidFrMsg", name: "DakmarkingidFrMsg", value: "" },
            { id: "dakempidFrMsg", name: "DakempidFrMsg", value: "" },
            { id: "actionFrMsg", name: "ActionFrMsg", value: "" },
            { id: "countFrMsg", name: "CountFrMsg", value: "" }
        ];

        var hiddenInputsContainer = document.getElementById("HiddenInputsContainer");

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

    	
    	    document.getElementById("dakidFrMsg").value = DakId;
    	    document.getElementById("dakmarkingidFrMsg").value = DakMarkingId;
    	    document.getElementById("dakempidFrMsg").value = DakEmpId;
    	    document.getElementById("actionFrMsg").value = ActionSelByDir;
    	    document.getElementById("countFrMsg").value = Count;

    	    
      var x = confirm("Are you sure you want to send this action?");
      if (x) {
          var id = "DakIdFrMsg" + DakId;
    	// Retrieve the button element by its ID
    	  const submitButton = document.getElementById(id);
    	// Get the formaction attribute of the button
    	  const formAction = submitButton.getAttribute('formaction');
    	  console.log("Formaction: " + formAction);
    	  if (formAction) {
    		  // Update the form's action attribute with the formaction value
    		  const myDirListForm = document.getElementById('DakDirectorListFormActions');
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


</script>

 <script> 

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
     
     
     //code to redirect to page
	/* var redirectPageId   = "PageNo"+RedirectTab+DakId; */
	var redirectRowId =  "Row"+RedirectTab+DakId;
/* 	var pageElement = document.getElementById(redirectPageId); */
	var rowElement = document.getElementById(redirectRowId);
   /*  var pageValue = pageElement ? pageElement.value : null; */
	var rowValue = rowElement ? rowElement.value : null;
	/* $('#PageRedirForApprove').val(pageValue); */
	$('#RowRedirForApprove').val(rowValue);
	//code ends
	  

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
		             console.log('formattedRefDate',formattedRefDate);
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

 </script>
  
    <script>


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
                                    console.log(formactionValue);
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
                              console.log(formactionValue);
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
                            console.log(formactionValue);
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


</script>



 <!------------------------------------------------CLOSE BY MARKER SCRIPTS START--------------------------------------------------------------------------------------------------  -->
 
 <script>
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
		             console.log('formattedRefDate',formattedRefDate);
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

 </script>
 



 <!-- others(Marker Forwarded Reply) Director Approval scripts are written below -->
  <script>
   
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
                                console.log(formactionValue);
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


// Introduce a delay of 100 milliseconds before showing the confirmation popup
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
                       console.log(formactionValue);
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


	// Introduce a delay of 100 milliseconds before showing the confirmation popup
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
	                       console.log(formactionValue);
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
  

</script>
<!--------------------------Redirect Script for pendingAprvLis ------------------------------------  -->
 <script>
	        // Get PageNo and Row from JSP attributes
	        var rowToHighlight1  = '<%=rowValue%>';
	  	  var selTab = '<%=SelectedTab%>';
	 	 

	        console.log('Row'+rowToHighlight1);
	        
	        if(rowToHighlight1!=null && selTab === 'PendingAprvList'){
	        document.addEventListener("DOMContentLoaded", function () {
	            // Highlight the specified row
	            highlightRow1(rowToHighlight1);

	        });
	        
	        }
	        
	        
	        function highlightRow1(count) {
	        	var rowElement = document.querySelector('[data-row-id="rowPendingAprvList-' + count + '"]');
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

	           
	        </script>
	        
	        
<!--------------------------Redirect Script for DakDirList ------------------------------------  -->	        
	     <script>
	        // Get PageNo and Row from JSP attributes
	       var rowToHighlight2  = '<%=rowValue%>';
	  	  var selectedTab = '<%=SelectedTab%>';
	   
	        if(rowToHighlight2!=null && selectedTab === 'DakDirList'){
	        document.addEventListener("DOMContentLoaded", function () {
	            // Highlight the specified row
	            highlightRow2(rowToHighlight2);

	        });
	        
	        }
	        
	        
	        function highlightRow2(count) {
	        	var rowElement = document.querySelector('[data-row-id="rowDakDirList-' + count + '"]');
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


	        </script>

</html>