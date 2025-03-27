<%@page import="java.util.Arrays"%>
<%@page import="com.vts.dms.DateTimeFormatUtil"%>
<%@page import="com.vts.dms.enote.model.Enote"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
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
  height: 30px;
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

.downloadDakMainReplyAttachTable {
  width: 350px !important;

}

.downloadDakMainReplyAttachTable td {
    padding: 0.2rem;
    border:none;
} 
 textarea {
            resize: none; /* Disable user resizing */
            overflow-y: hidden; /* Hide vertical scrollbar */
            min-height: 50px; /* Set a minimum height */
        }
</style>
<title>E Note Add</title>
</head>
<body>

<%
	List<Object[]> InitiatedByEmployeeList=(List<Object[]>)request.getAttribute("InitiatedByEmployeeList");
	List<Object[]> sourceList=(List<Object[]>)request.getAttribute("SourceList");
	Long EmployeeId=(Long)request.getAttribute("EmployeeId");
	String Action = (String)request.getAttribute("Action");
	
	Enote EnoteEditData=(Enote)request.getAttribute("EnoteEditData");
	
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	long AttachmentCount=(long)request.getAttribute("AttachmentCount");
	List<String> ReturnRemarks = Arrays.asList("RC1","RC2","RC3","RC4","RC5","APR","RR1","RR2","RR3","RR4","RR5","RAP");
	List<Object[]> AllReturnRemarks=(List<Object[]>)request.getAttribute("ReturnRemarks");
	
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
	<%}%>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb"><h5 style="font-weight: 700 !important"><%if(Action.equalsIgnoreCase("add")){ %>e Note Add<%}else if(Action.equalsIgnoreCase("Edit")) { %>e Note Edit<%} %></h5>
			</div>
				 <div class="col-md-3 d-flex justify-content-end" >
			  <span style="margin-top: 8px;">Draft Required</span>&nbsp;&nbsp;
			   <label style="margin-top: 13px;">
			    <input type="radio" name="draftRequired" value="N" <%if(EnoteEditData!=null && EnoteEditData.getIsDraft()!=null && EnoteEditData.getIsDraft().equalsIgnoreCase("N")){ %> checked="checked"<%} %> checked="checked"> &nbsp;&nbsp;No&nbsp;&nbsp;
			  </label>
			  <label style="margin-top: 13px;">
			    <input type="radio" name="draftRequired" value="Y" <%if(EnoteEditData!=null && EnoteEditData.getIsDraft()!=null && EnoteEditData.getIsDraft().equalsIgnoreCase("Y")){ %> checked="checked"<%} %> >&nbsp;&nbsp; Yes&nbsp;&nbsp;
			  </label>
			</div>
				<div class="col-md-6">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteList.htm"><i class="fa fa-envelope"></i> e Note List</a></li>
						<li class="breadcrumb-item active"><%if(Action.equalsIgnoreCase("add")){ %>e Note Add<%}else if(Action.equalsIgnoreCase("Edit")) { %>e Note Edit<%} %></li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	<%if(Action.equalsIgnoreCase("add")){ %>
	<form action="EnoteAddSubmit.htm" method="POST" id="myform" data-action="EnoteAddSubmit.htm" enctype="multipart/form-data">	
	<%}else{ %>
	<form action="EnoteEditSubmit.htm" method="POST" id="myform" data-action="EnoteEditSubmit.htm" enctype="multipart/form-data">
	<input type="hidden" id="EditenoteId" name="EditenoteId" value="<%if(EnoteEditData!=null){%><%=EnoteEditData.getEnoteId()%><%}%>">
	<%} %>
	<input type="hidden" name="IsDraftVal" id="isDraft">
	 <div class="col-md-12" >
		   <div class="page card dashboard-card" style="width: 98.5%;">
			<div class="card-body">
			<div class="row">
			<div class="col-md-2" style="display: inline-block;">
			<div class="form-group">
				<label class="control-label" style="float: left;">Ref No <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
				<input type="text" class="form-control" id="RefNo" value="<%if(EnoteEditData!=null && EnoteEditData.getRefNo()!=null) {%><%=EnoteEditData.getRefNo().toString()%><%} %>" name="RefNo" >
			</div> 
			</div>
			<div class="col-md-3">
			<div class="form-group">
			<label class="control-label" style="float: left;">Subject <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control" id="Subject" value="<%if(EnoteEditData!=null && EnoteEditData.getSubject()!=null) {%><%=EnoteEditData.getSubject().toString().trim()%><%} %>" name="Subject" maxlength="255">
			</div>
			</div>
			<%if(Action!=null && Action.equalsIgnoreCase("add")){ %>
			<div class="col-md-3">
   			<div>
   			<table>
			<tr ><td><label style="font-weight:bold;font-size:16px;">Document :</label></td>
			<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			</tr>
			<tr class="tr_clone">
				<td><input class="form-control" type="file" name="dakEnoteDocument"  id="dakEnoteDocument" accept="*/*" ></td>
					<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			 			</tr>	
			</table>
				</div>
				</div>
				<%} %>
				<%if(Action!=null && Action.equalsIgnoreCase("Edit")){ %>
				<div class="col-md-3">
				<div>
  	      			<table>
			  	      	<tr ><td><label style="font-weight:bold;font-size:16px; float: left;">Document :</label></td>
			  	      		<td align="right"><button type="button" class="tr_clone_editbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_clone">
			  	      			<td><input class="form-control" type="file" name="dakEnoteDocument"  id="EditdakEnoteDocument" accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>	
			  	     </table>
  	      			</div>
  	      			</div>
				<div class="col-md-4">
				<div class="enoteDocuments" style="width: 100%;">
                  <div class="row col-md-12"  style="float:left!important;">
                  <div class="form-group group2 col-md-3" id="eNoteDocumentLabel"  style=" width: 100%; display: none; float: left !important;">
                 	<label><b>eNote Documents :</b></label></div>
                 	<div class="col-md-9 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 80%;"> 
	  	      		</div>
                 	</div>
                 	</div>
                 	</div>
				<%} %>
			</div>
			</div>
		</div>
		</div><br>
	<div class="col-md-12 row" id="mainRow">
	<div class="col-md-6" id="eNoteContent" style="display: inline-block;">
	<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #114A86;height: 40px; padding: 5px;">
								eNote
							</div>
	<div class="page card dashboard-card">
	<div class="card-body" align="center" >	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="row">
		<div class="col-md-6">
		<div class="form-group">
			<label class="control-label" style="float: left;">Note No <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control " id="NoteNo" pattern="[A-Za-z0-9 ]+" value="<%if(EnoteEditData!=null && EnoteEditData.getNoteNo()!=null) {%><%=EnoteEditData.getNoteNo().toString()%><%} %>" name="NoteNo" >
		</div></div>
		
          <div class="col-md-6">
		  <div class="form-group">
			<label class="control-label" style="float: left;">Ref Date <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control" id="RefDate" value="<%if(EnoteEditData!=null && EnoteEditData.getRefDate()!=null){%><%=DateTimeFormatUtil.SqlToRegularDate(EnoteEditData.getRefDate().toString()) %><%}%>" name="RefDate" >
			 </div> </div> 
		</div>	
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Comment <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
		<textarea style="border-bottom-color: gray;width: 100%" oninput="autoResize()"  maxlength="3000" placeholder="Maximum 3000 characters" id="Comment" name="Comment"><%if(EnoteEditData!=null && EnoteEditData.getComment()!=null) {%><%=EnoteEditData.getComment().toString().trim()%><%}%></textarea>
		</div>	
		</div>
		</div>
		<%if(Action.equalsIgnoreCase("add")){ %>
				<div class="row" >
				<div class="col-md-6" >
				<div class="form-group">
				<label class="control-label" style=" float:left; align-items: center; font-size: 15px;"><b>Initiated By</b></label>
				<select class="selectpicker custom-selectEnote" id="InitiatedBy" required="required" style="float: left !important;" data-live-search="true" name="InitiatedBy"  >
				<%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
				for (Object[] obj : InitiatedByEmployeeList) {%>
				<option value=<%=obj[0].toString()%> <% if (EmployeeId!=null && EmployeeId.toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
				<%}}%>
				</select>	
				</div>
				</div>
				<div class="col-md-6">
				<div class="form-group">
				<label class="control-label" style="align-items: center; font-size: 15px;"><b>External Required</b></label>
				<input type="checkbox" id="checkbox1" checked="checked" name="type" class="checkbox" value="I" style="margin-left: 30px;">
				<label for="checkbox1">No</label>&nbsp;&nbsp;
				<input type="checkbox" id="checkbox2" class="checkbox" name="type" value="E">
				<label for="checkbox2">Yes</label>
				</div>
				</div>
				</div>
		<%}else if(Action.equalsIgnoreCase("Edit")) {%>
		<%if(ReturnRemarks.contains(EnoteEditData.getEnoteStatusCode().toString())){%>
		<%if(AllReturnRemarks!=null && AllReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;"> Remarks  :  </label>
			<%for(Object[] obj:AllReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RC1) :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RC2) :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RC3) :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RC4) :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RC5) :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(APR) :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RR1) : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RR2) : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RR3) : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RR4) : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RR5) : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %>(RAP) :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
		<%} %>
		<div class="row" style="margin-top: 7px;">
			<div class="col-md-7" style="display: inline-block;">
  	      		 <label class="control-label" style="display: inline-block; float:left; font-size: 15px;"><b>Initiated By</b></label>
			<select class="selectpicker custom-selectEnote" id="InitiatedBy" required="required" data-live-search="true" name="InitiatedBy"  >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[0].toString()%> <% if (EnoteEditData.getInitiatedBy()!=null && EnoteEditData.getInitiatedBy().toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	
			      </div>
			      <div class="col-md-5" style="display: inline-block;">
			<div class="form-group">
		<label class="control-label" style="display: inline-block; align-items: center; font-size: 15px;"><b>External Required</b></label>
		<input type="checkbox" id="checkbox1" class="checkbox" name="type" <%if(EnoteEditData.getEnoteType()!=null && EnoteEditData.getEnoteType().equalsIgnoreCase("I")) {%>checked="checked"<%} %> style="margin-left: 30px;" value="I">
		<label for="checkbox1">No</label>
		<input type="checkbox" id="checkbox2" class="checkbox" name="type" <%if(EnoteEditData.getEnoteType()!=null && EnoteEditData.getEnoteType().equalsIgnoreCase("E")) {%>checked="checked"<%} %> value="E">
		<label for="checkbox2">Yes</label>
		</div>
		</div>
		</div>
		<%} %>
		</div>
</div>
</div>
<div class="col-md-6" style="display: none;" id="draftContentData">
		<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #114A86;height: 40px; padding: 5px;">
			Draft
		</div>
		<div class="page card dashboard-card">
		<div class="card-body" align="center" >	
		<div class="row">
			<div class="col-md-4">
			<div class="form-group">
		<label class="control-label" style="float: left;">Letter Date <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control" id="LetterDate" value="<%if(EnoteEditData!=null && EnoteEditData.getLetterDate()!=null){%><%=DateTimeFormatUtil.SqlToRegularDate(EnoteEditData.getLetterDate().toString()) %><%}%>" name="LetterDate" >
		</div>
		</div>
		<div class="col-md-4">
			<div class="form-group">
				<label class="control-label" style="float: left;"> Destination <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
		<select class="form-control selectpicker custom-select" id="sourceid" required="required" data-live-search="true" name="DestinationId">
			<% if (sourceList != null && sourceList.size() > 0) {
		for (Object[] obj : sourceList) {
		%>
		<option value="<%=obj[0]%>" <% if (EnoteEditData!=null && EnoteEditData.getDestinationId()!=null &&EnoteEditData.getDestinationId().toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1]%></option>
		<%}}%>
					</select>
		     </div>
		 </div>
		 <input type="hidden" name="SourcetypeId" id="SourcetypeId" value="<%if(EnoteEditData!=null && EnoteEditData.getDestinationTypeId()!=null){ %><%=EnoteEditData.getDestinationTypeId()%><%}%>">
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
		<textarea style="border-bottom-color: gray;width: 100%" oninput="autoResizeDraftContent()"  maxlength="3000" placeholder="Maximum 3000 characters" id="DraftContent" name="DraftContent"><%if(EnoteEditData!=null && EnoteEditData.getDraftContent()!=null){ %><%=EnoteEditData.getDraftContent().toString() %><%} %></textarea>
		</div>
		</div>
		</div>
		<div class="row" style="margin-top: 7px;">
		<%if(Action!=null && Action.equalsIgnoreCase("add")){ %>
		<div class="col-md-7" style="display: inline-block;">
  	      		 <label class="control-label" style="display: inline-block; float:left; font-size: 15px;"><b>Signatory</b></label>
			<select class="selectpicker Signatory" id="Signatory" required="required"  data-live-search="true" name="Signatory" >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[0].toString()%> <% if (EmployeeId!=null && EmployeeId.toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	
		</div>
		<div class="col-md-5" style="display: inline-block;">
			<div class="form-group">
			<label class="control-label" style="display: inline-block; align-items: center; font-size: 15px; "><b>Letter Head</b></label>
			<input style="margin-left: 30px;" type="checkbox" id="checkboxone" checked="checked" name="LetterHead" class="checkbox" value="N">
			<label for="checkboxone">No</label>&nbsp;&nbsp;
			<input type="checkbox" id="checkboxtwo" class="checkbox" name="LetterHead" value="Y">
			<label for="checkboxtwo">Yes</label>
			</div>
		</div>
		<%} %>
		<%if(Action!=null && Action.equalsIgnoreCase("Edit")){ %>
		<div class="col-md-7" style="display: inline-block;">
  	      		 <label class="control-label" style="display: inline-block; float:left; font-size: 15px;"><b>Signatory</b></label>
			<select class="selectpicker Signatory" id="Signatory" required="required" data-live-search="true" name="Signatory"  >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[0].toString()%> <% if (EnoteEditData.getSignatory()!=null && EnoteEditData.getSignatory().toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	
			      </div>
		<div class="col-md-5" style="display: inline-block;">
			<div class="form-group">
			<label class="control-label" style="display: inline-block; align-items: center; font-size: 15px; "><b>Letter Head</b></label>
			<input style="margin-left: 30px;" type="checkbox" id="checkboxone" <%if(EnoteEditData!=null && EnoteEditData.getLetterHead()!=null && EnoteEditData.getLetterHead().equalsIgnoreCase("N")) {%>checked="checked"<%} %>  name="LetterHead" class="checkbox"  value="N">
			<label for="checkboxone">No</label>&nbsp;&nbsp;
			<input type="checkbox" id="checkboxtwo" class="checkbox" name="LetterHead" <%if(EnoteEditData!=null && EnoteEditData.getLetterHead()!=null && EnoteEditData.getLetterHead().equalsIgnoreCase("Y")) {%>checked="checked"<%} %>   value="Y">
			<label for="checkboxtwo">Yes</label>
			</div>
		</div>
		<%} %>
		</div>
		</div>
		</div>
		</div>
		</div><br>
		 
		  
		<div align="center">
		<input type="button" class="btn btn-primary btn-sm submit " id="Preview" value="Preview" name="sub"  onclick="return forward()">
		</div>
		<%if(Action.equalsIgnoreCase("Edit")) {%>
		 <input type="hidden" id=EnoteAttachmentIdforDelete name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" id="enoteidfordelete" name="EnoteId" value="" />
  	     <input type="hidden" id="redirval" name="redirval" value="EnoteEdit">
		</form>
		<%} else{%>
		</form>
		<%} %>
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
  <div class="modal-content">
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
        <button type="submit" class="btn btn-sm icon-btn" name="downloadbtn" id="largedocument" value="'+result[1]+'" formaction="EnoteAttachForDownload.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>
</body>
<script type="text/javascript">
const checkbox1 = document.getElementById('checkbox1');
const checkbox2 = document.getElementById('checkbox2');

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
	
const checkboxone = document.getElementById('checkboxone');
const checkboxtwo = document.getElementById('checkboxtwo');

checkboxone.addEventListener('change', function() {
  if (this.checked) {
	  checkboxtwo.checked = false;
  }
});

checkboxtwo.addEventListener('change', function() {
  if (this.checked) {
	  checkboxone.checked = false;
  }
});
function sanitizeInput(value) {
    // Remove HTML tags and script content
    return value.replace(/<script.*?>.*?<\/script>/gi, '') // Remove script tags
               .replace(/<\/?[^>]+>/gi, ''); // Remove other HTML tags
}

document.querySelectorAll('input[type="text"], textarea').forEach(function(input) {
    input.addEventListener('input', function() {
        this.value = sanitizeInput(this.value);
    });
});
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
$("table").on('click','.tr_clone_editbtn' ,function() {
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

$('#LetterDate').daterangepicker({
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

function updateLayout() {
	  const selectedValue = document.querySelector('input[name="draftRequired"]:checked').value;
	  const eNoteContent = document.getElementById("eNoteContent");
	  const draftContentData = document.getElementById("draftContentData");

	  console.log('selectedValue',selectedValue);
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

  
$(document).ready(function(){	
 	var Attachcount=<%=AttachmentCount%>;
 	<%if(EnoteEditData!=null){%>
 	var EnoteId=<%=EnoteEditData.getEnoteId()%>;
 	if(Attachcount>0){
 		$('.enoteDocuments').css('display','');
 	}
 	
 	$('.downloadDakMainReplyAttachTable').empty();
	var maindoclength=0;
    
 	var mainstr = '';
     $.ajax({
		
		type : "GET",
		url : "GetEnoteAttachmentDetails.htm",
		data : {
			
			EnoteId: EnoteId
			
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
		
		 mainstr += '<div  style="display: inline-block; width:100%;">';
         mainstr += '<div class="col-md-10" style=" width:100%; display: inline-block;"><button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply" style="float:left!important;" value="' + other[2] + '" onclick="Iframepdf(' + other[2] + ')" data-toggle="tooltip" data-placement="top" title="Download">' + other[3] + '</button></div>';
         mainstr += '<div class="col-md-2" style=" width:100%; display: inline-block;"><button type="button" id="EnoteAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="EnoteAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="margin-right:380px;" onclick="deleteEnoteEditAttach(' + other[2] + ',' + other[0] + ')"><img alt="attach" src="view/images/delete.png"></button></div>';
         mainstr += '</div><br>';
		   if(maindoclength>0){
				$('.downloadDakMainReplyAttachTable').html(mainstr);
				$('#eNoteDocumentLabel').css('display','block');
				$('#eNoteDocs').css('display','block');
			}else{
				$('#eNoteDocumentLabel').css('display','none');
				$('#eNoteDocs').css('display','none');
			}
           
	}
		}
     });
 	<%}%>
 	
 	
 });


function deleteEnoteEditAttach(eNoteAttachId,eNoteId){
	 $('#EnoteAttachmentIdforDelete').val(eNoteAttachId);
	 $('#enoteidfordelete').val(eNoteId);
	 
	 var result = confirm ("Are You sure to Delete ?"); 
	 if(result){
		var button = $('#EnoteAttachDelete');
		var formAction = button.attr('formaction');
		console.log("act:"+formAction);
		if (formAction) {
			  var form = button.closest('form');
			  console.log("123:"+form);
			  form.attr('action', formAction);
			  form.submit();
			}else{
				console.log('form action not found');
			}
	} else {
	    return false; // or event.preventDefault();
	}
	 
 }
$(document).ready(function(){	
	$("#sourceid").trigger("change");
	$("#pass").hide();
	$("#fail").hide();
});
var action='<%=Action%>';
if(action!=null && action=='add'){
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
}else if(action!=null && action=='Edit'){
$("#sourceid").change(function(){
	var SourceId=$("#sourceid").val();
	var SourcetypeId=$("#SourcetypeId").val();
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
			
			for(var c=0;c<consultVals.length;c++)
			{
				 $('#SourceType')
		         var option = $("<option></option>") 
		                    .attr("value", consultVals[c][0])
		                    .text(consultVals[c][3]+'- '+consultVals[c][2]); 
				 if(consultVals[c][0] == SourcetypeId){
					 option.prop("selected", true);
			          }
				 $('#SourceType').append(option);
			}
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
			 $('#SourceType').selectpicker('refresh');
			}
});
});
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
function Iframepdf(data){
	
	
	 $.ajax({
			
			type : "GET",
			url : "getEnoteiframepdf.htm",
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

function forward() {
	
	var isDraft=$('#isDraft').val();
	var action='<%=Action%>';
	var shouldSubmit=true;
	var NoteNo = $('#NoteNo').val().trim();
	var RefNo = $('#RefNo').val().trim();
	var RefDate = $('#RefDate').val().trim();
	var Subject = $('#Subject').val().trim();
	var Comment = $('#Comment').val().trim();

	if(NoteNo==null || NoteNo==='' || NoteNo===" " || typeof(NoteNo)=='undefined'){
		alert("Please Enter the Note No...!")
		$('#NoteNo').focus();
		shouldSubmit=false;
	}else if(RefNo==null || RefNo==='' || RefNo===" " || typeof(RefNo)=='undefined'){
		alert("Please Enter the Ref No...!")
		$('#RefNo').focus();
		shouldSubmit=false;
	}else if(RefDate==null || RefDate==='' || RefDate===" " || typeof(RefDate)=='undefined'){
		alert("Please Select the Ref Date...!")
		$('#RefDate').focus();
		shouldSubmit=false;
	}else if(Subject==null || Subject==='' || Subject===" " || typeof(Subject)=='undefined'){
		alert("Please Enter the Subject...!")
		$('#Subject').focus();
		shouldSubmit=false;
	}else if(Comment==null || Comment==='' || Comment===" " || typeof(Comment)=='undefined'){
		alert("Please Enter the Comment...!")
		$('#Comment').focus();
		shouldSubmit=false;
	}
	else{
		if(action==='add'){
		var formAction = $('#myform').data('action');
		if(confirm('Are you Sure To Preview ?')){
			  $('#myform').attr('action', formAction);
	          $('#myform').submit(); /* submit the form */
		}
		}else{
			var formAction = $('#myform').data('action');
			  $('#myform').attr('action', formAction);
	          $('#myform').submit(); /* submit the form */
		}
	}
}

function autoResize() {
    const textarea = document.getElementById('Comment');
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