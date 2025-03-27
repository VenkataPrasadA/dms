<%@page import="com.vts.dms.enote.model.Enote"%>
<%@page import="com.vts.dms.enote.model.DakEnoteReply"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.dms.DateTimeFormatUtil"%>
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
<title>DAK E Note Edit</title>
</head>
<body>

<%
	List<Object[]> InitiatedByEmployeeList=(List<Object[]>)request.getAttribute("InitiatedByEmployeeList");
	String Action = (String)request.getAttribute("Action");
	Enote EnoteEditData=(Enote)request.getAttribute("EnoteEditData");
	List<Object[]> sourceList=(List<Object[]>)request.getAttribute("SourceList");
	long EmpId=(Long)session.getAttribute("EmpId");
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	//long AttachmentCount=(long)request.getAttribute("AttachmentCount");
	List<String> ReturnRemarks = Arrays.asList("RC1","RC2","RC3","RC4","RC5","APR","RR1","RR2","RR3","RR4","RR5","RAP");
	List<Object[]> DakENoteReplyReturnRemarks=(List<Object[]>)request.getAttribute("DakENoteReplyReturnRemarks");
	List<Object[]> EnoteAssignReplyAttachmentData=(List<Object[]>)request.getAttribute("EnoteAssignReplyAttachmentData");
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
			<div class="col-md-3 heading-breadcrumb"><h5 style="font-weight: 700 !important"><%if(Action.equalsIgnoreCase("DakEnoteadd")){ %>DAK e Note Add<%}else if(Action.equalsIgnoreCase("DakEnoteEdit")) { %>DAK e Note Edit<%} %></h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteList.htm"><i class="fa fa-envelope"></i>e Note List</a></li>
						<li class="breadcrumb-item active"><%if(Action.equalsIgnoreCase("DakEnoteEdit")) { %>Dak e Note Edit<%} %></li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	
	<form action="DakEnoteReplyEditSubmit.htm" method="POST" id="myform" data-action="DakEnoteReplyEditSubmit.htm" enctype="multipart/form-data">
	<div class="col-md-12 row">
	<div class="col-md-6" style="display: inline-block;">
	<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #114A86;height: 40px; padding: 5px;">
								eNote
							</div>
	<div class="page card dashboard-card">
	<div class="card-body" align="center" >	
	<input type="hidden" name="DakAssignReplyId" id="DakAssignReplyId" value="<%=EnoteEditData.getDakReplyId().toString()%>">
	<input type="hidden" id="enoteDakId" name="DakId" value="<%if(EnoteEditData.getDakId()!=null){%><%=EnoteEditData.getDakId()%><%}%>">
	<input type="hidden" id="DakEnoteReplyId" name="eNoteId" value="<%=EnoteEditData.getEnoteId()%>">
	<input type="hidden" name="EnoteRoSoEdit" value="EnoteRoSoEdit">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="row">
		<div class="col-md-4">
		<div class="form-group">
			<label class="control-label" style="float: left;">Note No </label>
			<input type="text" class="form-control " id="NoteNo" value="<%if(EnoteEditData.getNoteNo()!=null){%><%=EnoteEditData.getNoteNo().toString() %><%} %>" name="NoteNo" >
		</div>
		</div>
		
          <div class="col-md-4">
		  <div class="form-group">
			<label class="control-label" style="float: left;">Ref Date </label>
			<input type="text" class="form-control" id="RefDate" value="<%if(EnoteEditData.getRefDate()!=null){%><%=DateTimeFormatUtil.SqlToRegularDate(EnoteEditData.getRefDate().toString()) %><%}%>" name="RefDate" >
			 </div> 
			 </div> 
			 
				 <div class="col-md-4">
				<div class="form-group">
			<label class="control-label" style="float: left;">Dak Id</label>
			<input type="text" class="form-control" id="DakNo" value="<%if(EnoteEditData.getDakNo()!=null){%><%=EnoteEditData.getDakNo().toString()%><%}%>" name="DakNo">
			</div>
			</div>
		    </div>	
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Reply </label>
		<textarea style="border-bottom-color: gray;width: 100%" oninput="autoResize()"  maxlength="1000" placeholder="Maximum 1000 characters" id="Reply" name="Reply"><%if(EnoteEditData.getReply()!=null){%><%=EnoteEditData.getReply().toString()%><%}%></textarea>
		</div>
		</div>
		</div>
		<%if(ReturnRemarks.contains(EnoteEditData.getEnoteStatusCode().toString())){%>
		<%if(DakENoteReplyReturnRemarks!=null && DakENoteReplyReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:DakENoteReplyReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RC1)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RC2)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnoteEditData.getInitiatedBy().toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%}} %>
		<div class="row">
				<div class="col-md-6">
  	      		 <label class="control-label" style=" display: inline-block; float:left; font-size: 15px;"><b>Initiated By</b></label>
			 <select class="selectpicker custom-selectEnote" id="InitiatedBy" required="required" data-live-search="true" name="InitiatedBy"  >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[0].toString()%> <% if (EnoteEditData.getInitiatedBy()!=null && EnoteEditData.getInitiatedBy().toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	 
				</div>
		 <div class="col-md-6 enoteDocuments" style="width: 100%;">
                  <div class="row col-md-12"  style="float:left!important;">
                  <%
                  if(EnoteAssignReplyAttachmentData!=null && EnoteAssignReplyAttachmentData.size()>0){
                  %>
                  <div class="col-md-4" id="eNoteDocumentLabel"  style="float: left !important; text-align: left; margin-left: 5px;">
                 	<label style="font-size: 16px;"><b>Documents : </b></label>&nbsp;&nbsp;&nbsp;&nbsp;
                 	</div><br>
                 	<div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="position: relative; float: left!important; width: 100%;"> 
	  	      		<%
	  	      		for(Object[] obj:EnoteAssignReplyAttachmentData) {%>
	  	      		<div class="row">
	  	      		<div class="col-md-9" style="display: inline-block;"><button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply" style="float:left!important;" value="<%=obj[2].toString() %>" <%if(EnoteEditData.getEnoteFrom()!=null && EnoteEditData.getEnoteFrom().equalsIgnoreCase("C")) {%> onclick="Iframepdf(<%=obj[2].toString()%>)"<%}else if(EnoteEditData.getEnoteFrom()!=null && EnoteEditData.getEnoteFrom().equalsIgnoreCase("M")){ %>onclick="Iframepdfmarker(<%=obj[2].toString()%>)" <%} %> data-toggle="tooltip" data-placement="top" title="Download"><%=obj[3].toString() %></button></div>
	  	      		<div class="col-md-3" style="display: inline-block; float:right!important;"><button type="button"  class="btn btn-sm icon-btn" <%if(EnoteEditData.getEnoteFrom()!=null && EnoteEditData.getEnoteFrom().equalsIgnoreCase("C")) {%> id="EnoteAttachDelete"  name="dakEditReplyDeleteAttachId" formaction="DakEnoteAttachDelete.htm"   onclick="deleteEnoteEditAttach(<%=obj[2].toString() %>, <%=obj[0].toString()%>)" <%}else if(EnoteEditData.getEnoteFrom()!=null && EnoteEditData.getEnoteFrom().equalsIgnoreCase("M")) {%>  id="MarkerEnoteAttachDelete" name="dakEditReplyDeleteAttachId" formaction="DakMarkerEnoteAttachDelete.htm" onclick="deleteMarkerEnoteEditAttach(<%=obj[2].toString() %>, <%=obj[0].toString()%>)" <%} %> data-toggle="tooltip" data-placement="top" title="Delete" style="width:115%; "><img alt="attach" src="view/images/delete.png"></button></div>
	  	      		</div><br>
	  	      		<input type="hidden" id="MarkerenoteDakId" name="DakId" value="<%if(EnoteEditData.getDakId()!=null){%><%=EnoteEditData.getDakId()%><%}%>">
	  	      		<%}}%>
	  	      		</div>
                 	</div>
                 	</div>
				</div>
				</div>
				</div>
				</div>
				
				<div class="col-md-6" style="display: inline-block;">
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
		<option value="<%=obj[0]%>" <% if (EnoteEditData!=null && EnoteEditData.getDestinationId().toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1]%></option>
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
		<textarea style="border-bottom-color: gray;width: 100%" oninput="autoResize()"  maxlength="3000" placeholder="Maximum 3000 characters" id="DraftContent" name="DraftContent"><%if(EnoteEditData!=null && EnoteEditData.getDraftContent()!=null){ %><%=EnoteEditData.getDraftContent().toString() %><%} %></textarea>
		</div>
		</div>
		</div>
		<div class="row" style="margin-top: 7px;">
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
			<input style="margin-left: 30px;" type="checkbox" id="checkbox1" <%if(EnoteEditData!=null && EnoteEditData.getLetterHead()!=null && EnoteEditData.getLetterHead().equalsIgnoreCase("N")) {%>checked="checked"<%} %>  name="LetterHead" class="checkbox"  value="N">
			<label for="checkbox1">No</label>&nbsp;&nbsp;
			<input type="checkbox" id="checkbox2" class="checkbox" name="LetterHead" <%if(EnoteEditData!=null && EnoteEditData.getLetterHead()!=null && EnoteEditData.getLetterHead().equalsIgnoreCase("Y")) {%>checked="checked"<%} %>   value="Y">
			<label for="checkbox2">Yes</label>
			</div>
		</div>
		</div>
		</div>
		</div>
		</div>
		</div><br>
			<div class="col-md-12" style="flex: none !important;">
			<div class="page card dashboard-card" style="width: 98.5%;">
			<div class="card-body">
			<div class="row">
			<div class="col-md-2" style="display: inline-block;">
			<div class="form-group">
				<label class="control-label" style="float: left;">Ref No <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control" id="RefNo" value="<%if(EnoteEditData.getRefNo()!=null){%><%=EnoteEditData.getRefNo().toString()%><%}%>" name="RefNo" >
			</div> 
			</div>
			<div class="col-md-3">
			<div class="form-group">
			<label class="control-label" style="float: left;">Subject <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control" id="Subject" value="<%if(EnoteEditData.getSubject()!=null){%><%=EnoteEditData.getSubject().toString()%><%}%>" name="Subject" maxlength="255">
			</div>
			</div>
			<div class="col-md-3">
						<div>
						<table>
			<tr ><td><label style="font-weight:bold;font-size:16px;">Document :</label></td>
			<td align="right"><button type="button" class="tr_clone_editbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			</tr>
			<tr class="tr_clone">
				<td><input class="form-control" type="file" name="dakReplyEnoteDocument"  id="EditdakEnoteDocument" accept="*/*" ></td>
					<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
				 			</tr>	
				</table>
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
			<input type="hidden" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
			 	     <input type="hidden" id="enoteidfordelete" name="EnoteId" value="" />
			 	     <input type="hidden" id="redirval" name="redirval" value="DakEnoteEdit">
				
				 <form action="#" id="Markerappform" method="post" enctype="multipart/form-data">
				 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				 <input type="hidden" form="Markerappform" id="EnoteMarkedAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
			 	     <input type="hidden" form="Markerappform" id="enoteMarkeridfordelete" name="DakReplyId" value="" />
			 	     <input type="hidden" form="Markerappform" id="redirval" name="redirval" value="DakEnoteEdit">
			 	     <input type="hidden" form="Markerappform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=EnoteEditData.getDakReplyId().toString() %>" />
			 	     <input type="hidden" form="Markerappform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=EnoteEditData.getEnoteId().toString() %>" >
			 	     <input type="hidden" form="Markerappform" id="DakId" name="DakId" value="<%=EnoteEditData.getDakId().toString() %>" >
				 </form>
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
$(document).ready(function(){	
	$("#sourceid").trigger("change");
	$("#pass").hide();
	$("#fail").hide();
});

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
function autoResize() {
    // Get the textarea element
    var textarea = document.getElementById("Reply");

    // Auto-adjust the height of the textarea based on its content
    textarea.style.height = "auto";
    textarea.style.height = (textarea.scrollHeight) + "px";
}

// Call autoResize initially to set the textarea height based on its initial content
autoResize();

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
function Iframepdf(data){
	
	
	 $.ajax({
			
			type : "GET",
			url : "getDakEnoteiframepdf.htm",
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
	
	var shouldSubmit=true;
	var DakNo=$('#DakNo').val();
	var RefNo=$('#RefNo').val();
	var RefDate=$('#RefDate').val();
	var Reply=$('#Reply').val();
	var Subject=$('#Subject').val();
	var NoteNo=$('#NoteNo').val();
	if(NoteNo==null || NoteNo==='' || NoteNo===" " || typeof(NoteNo)=='undefined'){
		alert("Please Enter the Note No...!")
		$('#NoteNo').focus();
		shouldSubmit=false;
	}else if(DakNo==null || DakNo==='' || DakNo===" " || typeof(DakNo)=='undefined'){
		alert("Please Enter the Dak No...!")
		$('#DakNo').focus();
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
	}else if(Reply==null || Reply==='' || Reply===" " || typeof(Reply)=='undefined'){
		alert("Please Enter the Reply...!")
		$('#Reply').focus();
		shouldSubmit=false;
	}else{
		var formAction = $('#myform').data('action');
			  $('#myform').attr('action', formAction);
	          $('#myform').submit(); /* submit the form */
	}
}

function autoResize() {
    const textarea = document.getElementById('Reply');
    textarea.style.height = 'auto'; // Reset height to auto to calculate the actual height
    textarea.style.height = textarea.scrollHeight + 'px'; // Set the height to the scroll height
}

function deleteMarkerEnoteEditAttach(eNoteAttachId,eNoteId){
	 $('#EnoteMarkedAttachmentIdforDelete').val(eNoteAttachId);
	 $('#enoteMarkeridfordelete').val(eNoteId);
	 
	 var result = confirm ("Are You sure to Delete ?"); 
	 if(result){
		 var formaction=$('#Markerappform');
		 var button = $('#MarkerEnoteAttachDelete');
			var action = button.attr('formaction');
			 if(formaction){
				 formaction.attr('action', action);
				 formaction.submit();
			 }else{
				 console.log('form action not found');
			 }
	} else {
	    return false; // or event.preventDefault();
	}
	 
}

function Iframepdfmarker(data){
	 $.ajax({
			
			type : "GET",
			url : "getDakMarkingEnoteiframepdf.htm",
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
</script>	
</html>