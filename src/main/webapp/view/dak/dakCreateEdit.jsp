<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.time.LocalTime"%>
<%@page import="com.vts.dms.dak.model.DakCreate"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.dms.FormatConverter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Create Edit</title>
<jsp:include page="../static/header.jsp"></jsp:include>
</head>
<style type="text/css">
label{
  font-weight: bold;
  font-size: 14px;
}
</style>
<style>
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

/* ------------------- */
/* PEN STYLES      -- */
/* ----------------- */

/* MAKE IT CUTE ----- */
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
  /* clear the tab labels */
    top: 40px; 
  
  padding: 20px;
  border-radius: 0 0 8px 8px;
  background: white;
  
  transition: 
    opacity 0.8s ease,
    transform 0.8s ease   ;
  
  /* show/hide */
    opacity: 0;
    transform: scale(0.1);
    transform-origin: top left;
  
}

.tabby-content img {
  float: left;
  margin-right: 20px;
  border-radius: 8px;
}


/* MAKE IT WORK ----- */

.tabby-tab [type=radio] { display: none; }
[type=radio]:checked ~ label {
  background: #5488BF ;
  z-index: 2;
}

[type=radio]:checked ~ label ~ .tabby-content {
  z-index: 1;
  
  /* show/hide */
    opacity: 1;
    transform: scale(1);
}

/* BREAKPOINTS ----- */
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

.Groupname{
width: 300px !important;
}
.empidSelect{
width: 280px !important;
/* margin-left: 400px !important; */
margin-top: -20px !important;
}
.individual{
width: 290px !important;
margin-left: -5px !important;
margin-top: -20px !important;
}

#scrollable-content {
    /* Set the desired height for the scrollable area */
    height: 100%;
    /* Add a scroll to the content when it overflows */
    overflow-y: auto;
}
#scrollable-contentind {
    /* Set the desired height for the scrollable area */
    height: 100%;
    /* Add a scroll to the content when it overflows */
    overflow-y: auto;
}

.newempidSelect{
width: 350px !important;
margin-left: 15px !important; 
}

</style>
<body>
<%
DakCreate dakcreateData=(DakCreate)request.getAttribute("dakcreateData");
%>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-4 heading-breadcrumb">
				<h5 style="font-weight: 600 !important">New DAK Edit <span>(<%=dakcreateData.getDakNo().toString() %>)</span></h5>
		</div>
		<div class="col-md-8">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb ">
					<li class="breadcrumb-item ml-auto"><a
						href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
					<li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
					<li class="breadcrumb-item active">New DAK Edit </li>
				</ol>
			</nav>
		</div>
	</div>
</div>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> sourceList = (List<Object[]>) request.getAttribute("SourceList");
	List<Object[]> dakDeliveryList = (List<Object[]>) request.getAttribute("DakDeliveryList");
	List<Object[]> priorityList = (List<Object[]>) request.getAttribute("priorityList");
	List<Object[]> letterList = (List<Object[]>) request.getAttribute("letterList");
	List<Object[]> linkList = (List<Object[]>) request.getAttribute("linkList");
	List<Object[]> actionList = (List<Object[]>) request.getAttribute("actionList");
	List<Object[]> dakLinkData=(List<Object[]>)request.getAttribute("dakLinkData");
	String counts=(String)request.getParameter("count");
	String letterno=(String)request.getParameter("letterno");
	List<Object[]> selDestinationTypeList=(List<Object[]>)request.getAttribute("selDestinationTypeList");
	
	System.out.println("selDestinationTypeList:"+selDestinationTypeList.size());
	 for(Object[] obj: selDestinationTypeList){
		 System.out.println("obj[0]:"+obj[0]);
	 }
	 ObjectMapper objectMapper = new ObjectMapper();
	 String selDestinationTypeListJson = objectMapper.writeValueAsString(selDestinationTypeList);
	 
	 List<Object[]> employeeList = (List<Object[]>)request.getAttribute("employeeList");
	 List<Object[]> selectedEmployees = (List<Object[]>)request.getAttribute("selectedEmployees");
	%>


	<%String ses=(String)request.getParameter("result"); 
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
	
	<div class="container-fluid datatables" id="main-div">
		<div class="row" style="margin-top: 0px; margin-bottom: 5px;">

			<div class="col-md-12" style="margin: auto;">

				<div class="card shadow-nohover">
					<div class="card-body">
						<form action="DakCreateEditSubmit.htm" method="POST" name="myfrm" id="myfrm" enctype="multipart/form-data">
							<div class="row">
								<div class="col-sm-2" align="left">
									<div class="form-group">
							
										<label class="control-label ">DAK Type<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="DakDeliveryId" name="DakDeliveryId" data-live-search="true" required="required">
											<%if (dakDeliveryList != null && dakDeliveryList.size() > 0) {
												for (Object[] obj : dakDeliveryList) {
											%>
											<option value=<%=obj[0]%> <%if(obj[0]!=null && obj[0].toString().equalsIgnoreCase(dakcreateData.getDeliveryTypeId().toString())){ %>selected="selected" <%}%>><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">DAK Priority <span class="mandatory" style="color: red; font-weight: normal;">*</span></label> 
										<select class="form-control selectpicker custom-select" id="PriorityId" required="required" data-live-search="true" name="PriorityId">
											<%if (priorityList != null && priorityList.size() > 0) {
												for (Object[] obj : priorityList) {
											%>
											<option value=<%=obj[0]%> <%if(obj[0]!=null && obj[0].toString().equalsIgnoreCase(dakcreateData.getPriorityId().toString())){ %>selected="selected" <%}%>><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">DAK Letter Type <span class="mandatory" style="color: red; font-weight: normal;">*</span></label> 
											<select class="form-control selectpicker custom-select" id="LetterId" required="required" data-live-search="true" name="LetterId">
											<%if (letterList != null && letterList.size() > 0) {
												for (Object[] obj : letterList) {
											%>
											<option value=<%=obj[0]%> <%if(obj[0]!=null && obj[0].toString().equalsIgnoreCase(dakcreateData.getLetterTypeId().toString())) {%>selected="selected" <%} %>><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Destination Type <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="DestinationId" required="required" data-live-search="true" name="DestinationId">
											<%if (sourceList != null && sourceList.size() > 0) {
												for (Object[] obj : sourceList) {
											%>
											<option value=<%=obj[0]%> <%if(obj[0]!=null && obj[0].toString().equalsIgnoreCase(dakcreateData.getDestinationId().toString())) {%>selected="selected" <%} %>><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Destination <span
											class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="DestinationType" multiple="multiple" name="DestinationType" data-live-search="true" required="required">
										</select>
									</div>
								</div>


							</div>
							<div class="row">
								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Receipt Date <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" name="ReceiptDate" value="<%if(dakcreateData.getReceiptDate()!=null){%><%=sdf.format(dakcreateData.getReceiptDate()) %><%} %>" style="font-size: 15px;" id="ReceiptDate">
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Ref No <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" type="text" id="RefNo" name="RefNo" style="font-size: 15px;" value="<%if(dakcreateData.getRefNo()!=null){ %><%=dakcreateData.getRefNo() %><%} %>"/>
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Ref No Dated<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" name="RefDate" style="font-size: 15px;" id="RefDate" value="<%if(dakcreateData.getRefDate()!=null){%><%=sdf.format(dakcreateData.getRefDate())%><%}%>">
									</div>
								</div>
								 <div class="col-md-2">
									<div class="form-group">
									  	 <label class="control-label">Action Required <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										 <select class="form-control  custom-select selectpicker" onchange="changeFunc();" id="Action" name="ActionId">
										    <%if (actionList != null && actionList.size() > 0) {
												for (Object[] obj : actionList) {
											%>
											<option value="<%=obj[0]%>#<%=obj[1]%>" <%if(obj[0]!=null && obj[0].toString().equalsIgnoreCase(dakcreateData.getActionId().toString())){ %> selected="selected" <%} %>><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>
								<div class="col-md-2 ActionDueDate">
									<div class="form-group">
										<label class="control-label">Action Due Date</label>
										<input class="form-control form-control" name="DueDate" style="font-size: 15px;" id="duedate" value="<%if(dakcreateData.getActionDueDate()!=null){ %><%=sdf.format(dakcreateData.getActionDueDate()) %><%} %>">
										<%if(dakcreateData.getActionDueDate()!=null){ %>
                        			    <input type="hidden" id="editDueDate" value="<%= sdf.format(dakcreateData.getActionDueDate())%>">
                        			   <%} %>
									</div>
								</div>
								<div class="col-md-2 ActionTime">
									<div class="form-group">
										<label class="control-label">Action Due Time</label> <input type="text" class="form-control form-control" name="DueTime" value="<%if(dakcreateData.getActionTime()!=null){ %><%=dakcreateData.getActionTime()%><%} %>" style="font-size: 15px;" id="DueTime">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label class="control-label">Subject <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" type="text" name="Subject" id="SubjectVal" maxlength="300" style="font-size: 15px;" required="required" value="<%if(dakcreateData.getSubject()!=null){%><%=dakcreateData.getSubject().toString()%><%}%>">
								 	</div>
								 </div>
							</div>
							<div class="row">
								<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">Link DAK</label>		
                                      <select class="form-control selectpicker" id="DakLinkId" data-live-search="true" multiple="multiple" required="required" name="DakLinkId">
    							         
    							           <%
    							           if(linkList!=null && linkList.size()>0){
    							           for(Object[] type : linkList){
    							        		String Subject="";
												if(type[2]!=null && type[2].toString().trim()!=""){
													Subject = ", "+type[2].toString();
												}  

%>
    							        		   <option <% for (  Object[] obj : dakLinkData){  if(obj[1].equals(type[0])){ %>selected="selected"<%}}%>  value=<%=type[0]%>><%=type[1].toString()%><%=Subject.trim()%>
    							     		    </option>
				                              <%}}%>
				                              
				                              <option value="0" <% for (  Object[] obj : dakLinkData){ if(obj[1].toString().equals("0")){ %>selected="selected"<%}}%>>Not Applicable </option> 
				                              
  									   </select>                        		</div>
                    		</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Keyword 1</label> <input class="form-control form-control" type="text" name="Key1" maxlength="100" style="font-size: 15px;" id="Key1" value="<%if(dakcreateData.getKeyWord1()!=null){%><%=dakcreateData.getKeyWord1().toString()%><%}%>">
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Keyword 2</label> <input class="form-control form-control" type="text" name="Key2" maxlength="100" style="font-size: 15px;" id="Key2" value="<%if(dakcreateData.getKeyWord2()!=null){%><%=dakcreateData.getKeyWord2().toString()%><%}%>">
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Keyword 3</label> <input class="form-control form-control" type="text" name="Key3" maxlength="100" style="font-size: 15px;" id="Key3" value="<%if(dakcreateData.getKeyWord3()!=null){%><%=dakcreateData.getKeyWord3().toString()%><%}%>">
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Keyword 4</label> <input class="form-control form-control" type="text" name="Key4" maxlength="100" style="font-size: 15px;" id="Key4" value="<%if(dakcreateData.getKeyWord4()!=null){%><%=dakcreateData.getKeyWord4().toString()%><%}%>">
									</div>
								</div>
							</div>
							<div class="row">

								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label">Brief on DAK</label> <input class="form-control form-control" type="text" name="Remarks" maxlength="1000" style="font-size: 15px;" value="<%if(dakcreateData.getRemarks()!=null){%><%=dakcreateData.getRemarks()%><%}%>">
									</div>
								</div>
								<div class="col-md-3" >
									<div class="form-group">
										<label class="control-label">Signatory </label> 
										<input class="form-control form-control" type="text" name="Signatory" maxlength="50" style="font-size: 15px;" value="<%if(dakcreateData.getSignatory()!=null){%><%=dakcreateData.getSignatory().toString()%><%}%>">
									</div>
								</div>
								
								 <div class="col-md-2"><br>
										<label class="control-label" style="font-size: 15px;">Document :</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-sm icon-btn" data-toggle="tooltip" onclick="uploadDoc(<%=dakcreateData.getDakCreateId() %>,'<%=dakcreateData.getRefNo() %>','M')" style="padding:8px;" data-placement="top" title="Attach" data-target="#exampleModalCenter">
							  			<img alt="attach" src="view/images/attach.png" style="float:left;">
							            </button>
								</div> 
							</div><br>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" name="dakId"	value="<%=dakcreateData.getDakCreateId() %>" /> 
                             <input type="hidden" name="DakNo"	value="<%=dakcreateData.getDakNo() %>" />
							<input type="hidden" id="actionValue" name="action">
							
							<div class="col-md-2" style="margin-top: 30px;">
									<div class="form-group">
										<label class="control-label">Self </label>
										<input type="radio" name="selfRequired" value="N" <%if(dakcreateData.getIsSelf()!=null && dakcreateData.getIsSelf().equalsIgnoreCase("N")) {%> checked="checked" <%} %> onclick="openEmployee('N')" >&nbsp; No &nbsp;
										<input type="radio" name="selfRequired" value="Y" <%if(dakcreateData.getIsSelf()!=null && dakcreateData.getIsSelf().equalsIgnoreCase("Y")) {%> checked="checked" <%} %>  onclick="openEmployee('Y')">&nbsp; Yes 
									</div>
								</div>
							<div class="row" id="employeeListDrop" style="display: none;">
							<div class="col-md-6">
								<div class="form-group">
								<label class="control-label" style="margin-left: 15px;">Employee </label><br>
								<select onchange='newaddEmpToSelect()' class="form-control selectpicker newempidSelect dropdown" multiple="multiple" id="newempidSelect" name="newempid" data-container="body" data-dropup-auto="true" data-live-search="true">
									<% 
									if (employeeList != null && employeeList.size() > 0) {
										for (Object[] obj : employeeList) {
											String empId = obj[0].toString();
											boolean isSelected = false;
									
											if (selectedEmployees != null && selectedEmployees.size() > 0) {
												for (Object[] selectedObj : selectedEmployees) {
													if (empId.equals(selectedObj[1].toString())) { 
														isSelected = true;
														break;
													}}}
									%>
									<option value="<%=empId%>" <%=isSelected ? "selected" : ""%>><%=obj[1].toString().trim()%>, <%=obj[2].toString()%></option>
									<%}}%>
								</select>

								</div>
							</div>
								<div class="col-md-6">
									<div class="row">
									 <div  class="col-md-12">
										<div class="card" id="scrollable-contentind" style="width: 100%; margin-top:-10px; height: 100px;">
										<div class="card-body">
										<div class="row" id="newIndEmp" style="">
										<input type="hidden" name="newEmpIdIndividual" id="newEmpIdIndividual" value="" />
	  	      									</div>
										</div> 
										</div>
									</div>
									</div>
								</div>
							</div><br>
							
							<div align="center">
								 <input type="button" class="btn btn-primary btn-sm submit" id="Save" value="Update" onclick="return DakUpdateSubmit('update')">
								 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								 <input type="button" class="btn btn-primary btn-sm submit" id="Submit" value="Update & Forward" onclick="return DakUpdateSubmit('updateforward')">
							</div>
							<input type="hidden" name="DakId"	value="<%=dakcreateData.getDakCreateId() %>" />    
   							<input type="hidden" name="DakNo"	value="<%=dakcreateData.getDakNo() %>" />   
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							
							
	<div class="modal fade my-modal " id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
 	  <div class="modal-dialog modal-dialog-centered" role="document">
 	    <div class="modal-content">
  	      <div class="modal-body">
  	       
  	      <div class="tabs">
        <div class="tabby-tab">
      <input type="radio" id="tab-1" name="tabby-tabs" checked  onclick="tabChange('M')">
      <label for="tab-1">Main Document</label>
      <div class="tabby-content">
  	      		<div class="row"> 
  	      			   <div class="col-md-10">
  	      				<input class="form-control" type="file" name="dak_document"  id="DakCreatedakdocument" accept="*/*"  >
  	      			  </div>
  	      
  	      		</div>
  	      		
  	      		<br>
  	      		<table class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtable" >
					<thead>
						<tr>
							<th style="width:5%;" >SN</th>
							<th style="width:65%;"> Item Name </th>
							<th style="width:20%; ">Action</th> 
						</tr>
					</thead>
					<tbody id="other-list-table">
					
					</tbody>
				</table>
				<input type="hidden" name="DakNo" value="<%=dakcreateData.getDakNo()%>" /> 
				<input type="hidden" name="dakattachmentid" id="dakattachmentid"  />
  	      		<input type="hidden" name="DakId" value="<%=dakcreateData.getDakCreateId() %>" />
  	      		<input type="hidden" name="letterno" id="letterno" value="<%=dakcreateData.getRefNo() %>" />
  	      		<input type="hidden" name="dakidvalue" id="dakidvalue" value="" />
  	      		<input type="hidden" name="type" id="type" value="" />
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		</div>
  	      		</div>
  	      		
  	      		<div class="tabby-tab">
      <input type="radio" id="tab-2" name="tabby-tabs" onclick="tabChange('S')">
      <label for="tab-2">Enclosures</label>
      <div class="tabby-content">
  	      		<div class="row">
  	      			<div class="col-md-10">
  	      				<table>
  	      					<tr>
  	      					<td></td>
  	      					<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
  	      					</tr>
  	      					<tr class="tr_clone">
  	      					<td><input class="form-control" type="file" name="dak_sub_document"  id="DakCreatedakdocument2" accept="*/*" ></td>
  	      						<td><button type="button" class="tr_clone_sub btn btn-sm "   data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
  	      					</tr>			  	      				
			  	      	</table>
  	      			</div>
  	      		</div>
  	      		<br>
  	      		<table class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtable" >
					<thead>
						<tr>
							<th style="width:5%;" >SN</th>
							<th style="width:65%;"> Item Name </th>
							<th style="width:20%; ">Action</th> 
						</tr>
					</thead>
					<tbody id="other-list-table2">
					
					</tbody>
				</table>
  	      		<input type="hidden" name="DakNo" value="<%=dakcreateData.getDakNo()%>" /> 
  	      		<input type="hidden" name="DakId"	value="<%=dakcreateData.getDakCreateId() %>" />
  	      		<input type="hidden" name="letterno" id="letterno2" value="<%=dakcreateData.getRefNo() %>" />
  	      		<input type="hidden" name="dakattachmentid" id="dakattachmentid1"  />
  	      		<input type="hidden" name="dakidvalue" id="dakidvalue2" value="" />
  	      		<!-- <input type="hidden" name="letterno" id="letterno2" value="" /> -->
  	      		<input type="hidden" name="type" id="type2" value="" />
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      </div>
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
</form>
</div>
</div>
 
<form action="DakCreateEditDeleteAttach.htm" name="deleteform" id="deleteform" >
		<input type="hidden" name="dakattachmentid" id="dakattachmentid2"  />
		<input type="hidden" name="letterno" id="letterno" value="<%=dakcreateData.getRefNo() %>" />
  	     <input type="hidden" name="dakidvalue" id="dakidvalue" value="" />
  	     <input type="hidden" name="type" id="type2" value="" />
		<input type="hidden" name="DakId"	value="<%=dakcreateData.getDakCreateId() %>" />
</form>
					
					</div>
				</div>
			</div>

</body>
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
</script>
<script type="text/javascript">
$('#RefDate').daterangepicker({
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

$('#duedate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" : $('#editDueDate').val(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#ReceiptDate').daterangepicker({
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

$(document).ready(function() {
	var value='<%=dakcreateData.getIsSelf()%>';
	newaddEmpToSelect();
	openEmployee(value);
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	 var select= document.getElementById("Action").value.trim();
	    var splitValues = select.split("#"); 
	    console.log(splitValues);
	    if(splitValues[1]=='ACTION'){
	    	$('.ActionDueDate').show();
	    	$('.ActionTime').show();
	    }else{
	    	$('.ActionDueDate').hide();
	    	$('.ActionTime').hide();
	    }
});

$(document).ready(function(){	
	
	$("#DestinationId").trigger("change");
	$("#pass").hide();
	$("#fail").hide();
	$("#passNonProject").hide();
	$("#failNonProject").hide();
	$("#passOtherProject").hide();
	$("#failOtherProject").hide();
	
});

function changeFunc() {
    var select= document.getElementById("Action").value.trim();
    var splitValues = select.split("#"); 
    console.log(splitValues);
    if(splitValues[1]=='ACTION'){
    	$('.ActionDueDate').show();
    	$('.ActionTime').show();
    }else{
    	$('.ActionDueDate').hide();
    	$('.ActionTime').hide();
    }};
    
  $(function() {
   $('#DueTime').daterangepicker({
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

$("#DestinationId").change(function(){
    var DestinationId = $("#DestinationId").val();
    var DestinationType = $("#DestinationType").val();

    $.ajax({
        type: "GET",
        url: "getSelectSourceTypeList.htm",
        data: {
            SourceId: DestinationId
        },
        dataType: 'json',  // Corrected `datatype` to `dataType`
        success: function(result) {
            var consultVals = Object.keys(result).map(function(e) {
                return result[e];
            });

            // Assuming selDestinationTypeList is passed as a JSON string
           var selDestinationTypeList = <%= selDestinationTypeListJson %>;

            $('#DestinationType').empty();

            for (var c = 0; c < consultVals.length; c++) {
                var option = $("<option></option>")
                     .attr("value", consultVals[c][0]+'-'+consultVals[c][4]+'-'+consultVals[c][5]+'-'+consultVals[c][6])
                    .text(consultVals[c][3] + '- ' + consultVals[c][2]);

                // Compare with the server-side list (selDestinationTypeList)
                for (var i = 0; i < selDestinationTypeList.length; i++) {
                    if (selDestinationTypeList[i][0] == consultVals[c][0]) {
                        option.prop("selected", true);
                        break;  // Stop comparing once a match is found
                    }
                }

                $('#DestinationType').append(option);
            }

            // Add the "Add New" option
            var addnew = "addnew";
            var $newOption = $("<option></option>")
                .attr("value", addnew)
                .text("Add New")
                .css({
                    "background-color": "blue",
                    "color": "white",
                    // Add more styles as needed
                });

            $('#DestinationType').append($newOption);
            $('#DestinationType').selectpicker('refresh');
        }
    });
});
  
 function openEmployee(value) {
	if(value==='N'){
		$('#employeeListDrop').hide();
	}else if(value==='Y'){
		$('#employeeListDrop').show();
	}
}
 
 
 function newaddEmpToSelect(){
	    /* var selectedItem = $('#empidSelect').val(); */
	    var options = $('#newempidSelect option:selected');
		    var selected = [];
	    var otherHTML = '';
		var id='newindEmployees';
		var count=1;
	    $(options).each(function(){
		    otherHTML += '<span style="margin-left:2%" id="id">'+count+'.  '+' '+$(this).text()+'</span><br>';
		    count++;
		    selected.push($(this).val());
	    });
	    $('#newEmpIdIndividual').val(selected);
	    $('#newIndEmp').html(otherHTML);
	}
</script>
<script>
$(document).ready(function(){
	 var num=<%=counts%>;
	 var letterno=<%=letterno%>;
	 if(num!=null){
		 uploadDoc(num,letterno,'M')
	 }
})

function submitattach1(){
	// Check if the file input is empty
    var fileInput = document.getElementById("DakCreatedakdocument");
    if (!fileInput.files || fileInput.files.length === 0) {
        alert("Please attach a document to submit.");
        return false; // Prevent form submission
    }

    var res = confirm('Your Replacing the old Document! Are You Sure To Submit?');
    if (res) {
        // Programmatically trigger the form submission
        $('#attachform1')[0].submit();
    } else {
        event.preventDefault();
    }
	}
	
	
function submitattach2(){
	  var fileInput = document.getElementById("DakCreatedakdocument2");
	    if (!fileInput.files || fileInput.files.length === 0) {
	        alert("Please attach a document to submit.");
	        return false; // Prevent form submission
	    }

	    var res = confirm('Are You Sure To Submit?');
	    if (res) {
	        // Programmatically trigger the form submission
	        $('#attachform2')[0].submit();
	    } else {
	        event.preventDefault();
	    }
	
	}
	
	function uploadDoc(value,letterno,type){
		
		
		$('#tab-1').prop('checked',true);
		
		$('#dakidvalue').val(value);
		$('#letterno').val(letterno);
		$('#dakidvalue2').val(value);
		$('#letterno2').val(letterno);
		$('#dakattachmentid').val(value);
		$('#dakattachmentid1').val(value);
		$('#type').val(type);
		$('#type2').val(type);
		$('#exampleModalCenter').modal('toggle');
		$('.downloadtable').css('display','none');
		
		
         $.ajax({
			
			type : "GET",
			url : "GetDakCreateAttachmentDetails.htm",
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
			otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >';
			otherHTMLStr +=	'		<button type="submit" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" formaction="DakCreateDownloadAttach.htm" data-toggle="tooltip" data-placement="top" title="Download" ><img alt="attach" src="view/images/download1.png"></button>'; 
/* 				otherHTMLStr +=	'		<button type="submit" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" formaction="DownloadAttach.htm" data-toggle="tooltip" data-placement="top" title="Preview" ><img alt="attach" src="view/images/eye.png"></button>'; 
*/				 /* otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'"  data-toggle="tooltip" data-placement="top" title="Delete"  onclick="deleteForm('+other[2]+')" ><img alt="attach" src="view/images/delete.png"></button>';   */
			otherHTMLStr +=	'</td></tr> ';
			
			var DakAttachmentId=other[2];
			document.getElementById('dakattachmentid').value= DakAttachmentId;
		}
		
		if(consultVals.length>0){
			$('.downloadtable').css('display','block');
		}
		if(type=='M'){
			$('#other-list-table').html('');
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
		url : "GetDakCreateAttachmentDetails.htm",
		data : {
			
			dakid: value,
			attachtype:type
			
		},
		datatype : 'json',
		success : function(result) {
		 if (result !== null && result !== '' && result !=='null') {
		var result = JSON.parse(result);
		var consultVals= Object.keys(result).map(function(e){
		return result[e]
		})
		console.log("hghfg g hgh"+consultVals);
		var otherHTMLStr = '';
		for(var c=0;c<consultVals.length;c++)
		{
			var other = consultVals[c];
		
			otherHTMLStr +=	'<tr> ';
			otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >'+ (c+1) +'.</span> </td> ';
			otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >'+ other[3] +'.</span> </td> ';
			otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >';
			otherHTMLStr +=	'		<button style="align:center; width:60%;" type="submit" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" formaction="DakCreateDownloadAttach.htm" data-toggle="tooltip" data-placement="top" title="Download" ><img alt="attach" src="view/images/download1.png"></button>'; 
/* 				otherHTMLStr +=	'		<button type="submit" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" formaction="DownloadAttach.htm" data-toggle="tooltip" data-placement="top" title="Preview" ><img alt="attach" src="view/images/eye.png"></button>'; 
*/
			if(type='S'){
            otherHTMLStr +=	'<button style="width:60%;" type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'"  data-toggle="tooltip" data-placement="top" title="Delete"  onclick="deleteForm('+other[2]+')" ><img alt="attach" src="view/images/delete.png"></button>'; 
			}
			otherHTMLStr +=	'</td></tr> ';

			var DakAttachmentId=other[2];
			document.getElementById('dakattachmentid1').value= DakAttachmentId;
			
		}
		
		if(consultVals.length>0){
			$('.downloadtable').css('display','block');
		}
		if(type=='M'){
		$('#other-list-table').html('');
		$('#other-list-table').html(otherHTMLStr);
		}else{
			$('#other-list-table2').html('');
			$('#other-list-table2').html(otherHTMLStr);
		}
		$('[data-toggle="tooltip"]').tooltip()
			
			
		}
		 
		}
	});

	}
	
	 function deleteForm(value){
		 $('#dakattachmentid2').val(value);
		 
		 var result = confirm ("Are You sure to Delete ?"); 
		 if(result){
			 $('#deleteform').submit();
		 }
		 
	 }
	 
function DakUpdateSubmit(action) {
    $('#actionValue').val(action);
    if (confirm("Are you sure you want to submit?")) {
        $('#myfrm').submit();
    }
}

</script>
</html>