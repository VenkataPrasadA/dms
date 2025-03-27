<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>E Note Preview</title>
<style type="text/css">
#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
}

tr {
    background-color: white;
    border: 1px solid black; /* You can customize the color and width as needed */
  }
  b{
  font-size: 1.2rem;
  }
 span{
 font-size: 1.1rem;
 } 
 .custom-selectEnote {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 300px !important;
  float: left !important;
  left:40px;
 
}

.custom-selectEnoteSanction {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 300px !important;
  float: left !important;
  left:40px;
}

.custom-selectEnoteLab {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 132px !important;
  float:left !important;
  left: 25px;
}
.custom-selectEnoteExternalOfficer{
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 280px !important;
  right: 85px;
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

.dropup .dropdown-toggle::after {
display: none;
}

.downloadDakMainReplyAttachTable {
  width: 350px;

}

.downloadDakMainReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}
.SkipApprovalRemarks{
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 170px !important;
}

.ChangeApprovalRemarks{
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 100px !important;
  
}

.ChangeRecOfficer{
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 169px !important;
}
#Comment {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            resize: none; /* Disable textarea resizing */
            overflow-y: hidden; /* Hide vertical scrollbar initially */
        }
</style>
</head>
<body>
<%
String ViewFrom=(String)request.getAttribute("ViewFrom");
String lablogo=(String)request.getAttribute("lablogo");
%>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">e Note Preview</h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteDashBoard.htm"><i class="fa fa-envelope"></i> e Note</a></li>
						<%if(ViewFrom!=null && ViewFrom.equalsIgnoreCase("EnoteList")){ %>
						<li class="breadcrumb-item"><a href="ENoteList.htm"><i class="fa fa-envelope"></i>e Note List</a></li>
						<%}else if(ViewFrom!=null && ViewFrom.equalsIgnoreCase("EnoteApprovalList")){ %>
						<li class="breadcrumb-item"><a href="EnoteApprovalList.htm"><i class="fa fa-envelope"></i> e Note ( Recommendation / Approval ) List</a></li>
						<%}else if(ViewFrom!=null && ViewFrom.equalsIgnoreCase("SkipApprovalList")){ %>
						<li class="breadcrumb-item"><a href="SkipApprovals.htm"><i class="fa fa-envelope"></i>e Note Skip Approval List</a></li>
						<%}%> 
						<li class="breadcrumb-item active">e Note Preview </li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	
	<%
	String Username=(String)session.getAttribute("Username");
	String EnoteRoSoEdit=(String)request.getAttribute("EnoteRoSoEdit");
	long EmpId=(Long)session.getAttribute("EmpId");
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	Object[] EnotePreview=(Object[])request.getAttribute("EnotePreview"); 
	Object[] WordDocumentData=(Object[])request.getAttribute("WordDocumentData"); 
	Object[] letterDocumentdata=(Object[])request.getAttribute("letterDocumentdata"); 
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
	
	List<Object[]> LabList=(List<Object[]>)request.getAttribute("LabList");
	List<Object[]> RecommendingOfficerList=(List<Object[]>)request.getAttribute("RecommendingOfficerList");
	
	Object[] RecommendingDetails=(Object[])request.getAttribute("RecommendingDetails");
	long AttachmentCount=(long)request.getAttribute("AttachmentCount");
	String Approval=(String)request.getAttribute("Approval");
	String IntiatePreview=(String)request.getAttribute("IntiatePreview");
	Object[] EnoteRoSoRoledetails=(Object[])request.getAttribute("EnoteRoSoRoledetails");
	List<Object[]> AllReturnRemarks=(List<Object[]>)request.getAttribute("ReturnRemarks");
	
	String preview=(String)request.getAttribute("preview");
	String SkipPreview=(String)request.getAttribute("SkipPreview");
	List<String> forwardstatus = Arrays.asList("INI","REV","RR1","RR2","RR3","RR4","RR5","RAP");
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
	
	<div class="col-md-12 row" id="formContainer">
	<div class="col-md-7" id="formCol" style="display: inline-block;" >
	<div class="page card dashboard-card" id="PreviewHeight">
		<div class="card-body" align="center">
		<div  class="table-responsive">
		<table class="table table-bordered table-hover table-striped table-condensed"  style="width: 100%; height:55px; margin: auto;">
		<tbody>
		<tr>
		<td style="font-weight: 800; text-decoration: underline; background-color: #005C97; color: white; border-radius: 3px;"><span style="font-size: 20px; float: left;">Note No : <%if(EnotePreview[2]!=null){ %><%=EnotePreview[2].toString() %><%}else{ %>-<%} %></span><span style="font-size: 20px;">eNote Status : <%if(EnotePreview[13]!=null){ %><%=EnotePreview[13].toString() %><%}else{ %>-<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC1")){ %>(<%if(RecommendingDetails[8]!=null){%><%=RecommendingDetails[8].toString()%>-<%}%><%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC2")){ %>(<%if(RecommendingDetails[9]!=null){%><%=RecommendingDetails[9].toString()%>-<%}%><%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC3")){ %>(<%if(RecommendingDetails[10]!=null){%><%=RecommendingDetails[10].toString()%>-<%}%><%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC4")){ %>(<%if(RecommendingDetails[11]!=null){%><%=RecommendingDetails[11].toString()%>-<%}%><%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC5")){ %>(<%if(RecommendingDetails[12]!=null){%><%=RecommendingDetails[12].toString()%>-<%}%><%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("EXT")){ %>(<%if(RecommendingDetails[13]!=null){%><%=RecommendingDetails[13].toString()%>-<%}%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("APR")){ %>(<%if(RecommendingDetails[14]!=null){%><%=RecommendingDetails[14].toString()%>-<%}%><%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %>-<%} %>)<%} %>
		
		</span><span style="font-size: 20px; float: right;">Note Id : <%if(EnotePreview[1]!=null){ %><%=EnotePreview[1].toString() %><%}else{ %>-<%} %></span></td>
		</tr>
		</tbody>
		</table>
		</div>
		
		<div class="row" style="margin-top: 10px;">
			<div class="col-md-3">
			<div class="form-group">
				<label class="control-label" style="float: left;">Ref No</label>
				<input type="text" class="form-control" id="RefNo" name="RefNo" readonly="readonly" style="color: blue;" value="<%if(EnotePreview[3]!=null){ %><%=EnotePreview[3].toString() %><%}else{ %>-<%} %>">
			</div> </div>
			
			
          <div class="col-md-4">
		  <div class="form-group">
			<label class="control-label" style="float: left;">Ref Date</label>
			<input type="text" class="form-control" id="RefDate" name="RefDate" readonly="readonly" style="color: blue;"  value="<%if(EnotePreview[4]!=null){ %><%=sdf.format(EnotePreview[4]) %><%}else{ %>-<%} %>">
			 </div> </div> 
			 
			 <div class="col-md-5">
			<div class="form-group">
		<label class="control-label" style="float: left;">Subject</label>
		<input type="text" class="form-control" id="Subject" name="Subject" readonly="readonly" style="color: blue;" value="<%if(EnotePreview[5]!=null){ %><%=EnotePreview[5].toString() %><%}else{ %>-<%} %>" maxlength="255">
		</div></div>
		</div>	
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Comment</label>
		<textarea style=" color: blue; " maxlength="1000" placeholder="Maximum 1000 characters" id="Comment" readonly="readonly" name="Comment" oninput="autoResize()"><%if(EnotePreview[6]!=null){ %><%=EnotePreview[6].toString() %><%}else{ %>-<%} %></textarea>
		</div>
		</div>
		</div>
		<!-- <div class="row">
  	    </div> -->
  	    <%if(IntiatePreview!=null && IntiatePreview.equalsIgnoreCase("AddEdit")) {%>
  	    <%if(AllReturnRemarks!=null && AllReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:AllReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%> (RC1) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %> <%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC2) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("EXT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(EXT) : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("ERT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>>(ERT) : <%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
		<div class="col-md-12">
		<form action="EnoteForwardSubmit.htm" method="POST" id="eNoteForm">	
		<div class="col-md-7" style="float: left!important;">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="eNoteId" name="eNoteId" value="<%=EnotePreview[0].toString() %>" >
	<input type="hidden" name="IntiatePreview" value="<%=IntiatePreview%>">
	<input type="hidden" name="EnoteRoSoId" value="<%if(EnotePreview[29]!=null){ %><%=EnotePreview[29].toString() %><%}%>">
	<input type="hidden" id="InitiatedByEmpId" name="InitiatedByEmpId" value="<%=EnotePreview[15].toString() %>" >
	<input type="hidden" id="EnoteRoSoEdit" name="EnoteRoSoEdit" value="<%if(EnoteRoSoEdit!=null){ %><%=EnoteRoSoEdit%><%} %>" >
	
	<span style="float: left;"><b>Initiated By :</b> <b style="color: blue;"><%if(EnotePreview[28]!=null){%><%=EnotePreview[28] %><%} %></b></span><br>
	<div class="row" style="width: 100%; margin-left: 80px;"><b>Role</b></div>
		<div class="row">
		<div class="col-md-12">
  	      		 <label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px;"><b>RC - 1</b><span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
  	      		 <input class="form-control" type="text" style="width: 15%; float:left; margin-left: 10px;" id="Rec1Role" name="Rec1Role" value="<%if(EnotePreview[17]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[2]!=null){%><%=EnoteRoSoRoledetails[2].toString()%><%}else if(EnotePreview!=null && EnotePreview[17]!=null){%><%=EnotePreview[17].toString()%><%}%>">
			<select class="form-control selectpicker custom-selectEnote" id="RecommendingOfficer1" required="required" data-live-search="true" onchange="firstDropdownChange()" name="RecommendingOfficer1" style="width:50%;"  >
			  <option value="Select">Select</option>
			   <%if (RecommendingOfficerList != null && RecommendingOfficerList.size() > 0) {
			    for (Object[] obj : RecommendingOfficerList) {%>
			    <option value=<%=obj[0].toString()%> <% if(EnotePreview[7]!=null && EnotePreview[7].toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% }else if(EnotePreview[7]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[1]!=null && EnoteRoSoRoledetails[1].toString().equalsIgnoreCase(obj[0].toString())){ %>selected="selected"<% }%>><%=obj[1].toString()+", "+obj[2].toString()%></option>
			   <%}}%>
			</select>	
		</div>
		</div>
		<div class="row tr_cloneRecommend2" style=" margin-top: 10px;">
		<div class="col-md-12">
  	      		 <label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px;"><b>RC - 2</b><span class="mandatory" style="color: white; font-weight: normal;">*</span></label>
  	      		 <input class="form-control" type="text" style="width: 15%; float:left; margin-left: 10px;" id="Rec2Role" name="Rec2Role" value="<%if(EnotePreview[18]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[4]!=null){%><%=EnoteRoSoRoledetails[4].toString()%><%}else if(EnotePreview!=null && EnotePreview[18]!=null){%><%=EnotePreview[18].toString()%><%}%>">
			<select class="form-control selectpicker custom-selectEnote" id="RecommendingOfficer2" required="required" data-live-search="true" name="RecommendingOfficer2" onchange="secondDropdownChange()"  style="width: 50%;">
			</select>
			<button type="button" class="tr_clone_subRecommend2 btn btn-sm " id="RecommendOfficer2"  data-toggle="tooltip" data-placement="top" title="Remove this RecommendOfficer2" style="margin-left: 85%; margin-top: -70px;"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button>
		</div>
		</div>
		<div class="row tr_cloneRecommend3" >
		<div class="col-md-12">
  	      		 <label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px;"><b>RC - 3</b><span class="mandatory" style="color: white; font-weight: normal;">*</span></label>
  	      		 <input class="form-control" type="text" style="width: 15%; float:left; margin-left: 10px;" id="Rec3Role" name="Rec3Role" value="<%if(EnotePreview[19]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[6]!=null){%><%=EnoteRoSoRoledetails[6].toString()%><%}else if(EnotePreview!=null && EnotePreview[19]!=null){%><%=EnotePreview[19].toString()%><%}%>">
			<select class="form-control selectpicker custom-selectEnote" id="RecommendingOfficer3" required="required" data-live-search="true" name="RecommendingOfficer3" onchange="thirdDropdownChange()" style="width: 50%;" >
			</select>
			<button type="button" class="tr_clone_subRecommend3 btn btn-sm " id="RecommendOfficer3"  data-toggle="tooltip" data-placement="top" title="Remove this RecommendOfficer3" style="margin-left: 85%; margin-top: -70px;"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button>
		</div>
		</div>
		<div class="row tr_cloneExternal" style="display: none;" >
		<div class="col-md-12">
		         <label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px;"><b>Lab</b></label>
		         <select class="form-control selectpicker custom-selectEnoteLab" id="LabCode" name="LabCode" onchange="LabcodeSubmit()" data-live-search="true"  required="required">
		        <option value="Select" >Select</option>
				<%
				if (LabList != null && LabList.size() > 0) {
					for (Object[] obj : LabList) {
				%>
				<option value="<%=obj[2].toString()%>" <% if(EnotePreview[24]!=null && EnotePreview[24].toString().equalsIgnoreCase(obj[2].toString())) { %>selected="selected"<% }else if(EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[15]!=null && EnoteRoSoRoledetails[15].toString().equalsIgnoreCase(obj[2].toString())){ %>selected="selected"<% }%>><%=obj[2].toString()%></option>
				<%}}%>
				<option value="@EXP" <% if(EnotePreview[24]!=null && EnotePreview[24].toString().equalsIgnoreCase("@EXP")) { %>selected="selected"<% }else if(EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[15]!=null && EnoteRoSoRoledetails[15].toString().equalsIgnoreCase("@EXP")){ %>selected="selected"<% }%>>Expert</option>
				</select>
				<input class="form-control" type="text" style="width: 15%; margin-left:50px; display: inline-block;" id="ExtRole" name="ExtRole" value="<%if(EnotePreview!=null && EnotePreview[22]!=null){%><%=EnotePreview[22].toString() %><%}else if(EnotePreview[22]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[12]!=null){%><%=EnoteRoSoRoledetails[12].toString()%><%}%>">
  	      		 <label class="control-label" style="display: inline-block; align-items: center; font-size: 15px; margin-right: 90px; "><b>ExternalOfficer</b></label>
			<select class="form-control selectpicker custom-selectEnoteExternalOfficer" id="ExternalOfficer" required="required" data-live-search="true" name="ExternalOfficer"  style="width: 50%;" >
			</select>
		</div>
		</div>
		<br>
		<div class="row Sanctionofficerrow" >
		<div class="col-md-12">
  	      		 <label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px;"><b>AO</b><span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
  	      		 <input class="form-control" type="text" style="width: 15%; float:left; margin-left: 30px;" id="SancRole" name="SancRole" value="<%if(EnotePreview[23]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[14]!=null){%><%=EnoteRoSoRoledetails[14].toString()%><%}else if(EnotePreview!=null && EnotePreview[23]!=null){%><%=EnotePreview[23].toString()%><%}%>">
			<select class="form-control selectpicker custom-selectEnoteSanction"  id="SanctioningOfficer" required="required" data-live-search="true" name="SanctioningOfficer" >
			</select>
		</div>
		</div><br>
		<%if(EnotePreview[26]!=null && !EnotePreview[26].toString().equalsIgnoreCase("INI")) {%>
		<div align="left" style="margin-left: 5px;">
		   <b >Remarks <span class="mandatory" style="color: red; font-weight: normal;">*</span>  </b><br>
		   <textarea  form="eNoteForm" rows="3" cols="65" name="remarks" maxlength="1000"  id="forwardremarksarea"></textarea> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    </div>
	    <%} %>
		<div align="center">
		<span style="color:blue; float: left;" ><b style="color:red; font-weight: 400;">Note : </b> <%if(EnotePreview[28]!=null){%><%=EnotePreview[28] %><%} %> can Forward This eNote .</span>
		<%if(EmpId==Long.parseLong(EnotePreview[15].toString()) && forwardstatus.contains(EnotePreview[26].toString())) {%>
		 <button type="button" class="btn btn-primary btn-sm submit " id="Forward" name="Action" value="A" onclick="return EnoteForwardSubmit()">Forward</button>
		 <input type="hidden" name="RedirectName" value="forward">
		<%}else if(EnotePreview[27].toString().equalsIgnoreCase(Username)){ %>
		 <button type="button" class="btn btn-primary btn-sm submit " id="Forward" name="Action" value="A" onclick="return EnoteForwardSubmit()">Save</button>
		 <input type="hidden" name="save" value="save">
		 <input type="hidden" id="RedirectName"  name="RedirectName"  value="ActionSave">
		 <%} %>
		 <input type="hidden" name="Action" value="A">
		</div>
		</div>
		<div class="col-md-5" style="float: right!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents: </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	     </div>
           </div>
          </div>
		</div>
		</form>
		  <form action="#" id="appform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="appform" id="enoteidfordelete" name="EnoteId" value="" />
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="EnotePreview">
  	     <input type="hidden" form="appform" name="IntiatePreview" value="<%=IntiatePreview%>">
  	     </form>
		</div>
		<%} %>
	<%if(preview!=null && preview.equalsIgnoreCase("preview") && RecommendingDetails!=null){ %>
	<%if(AllReturnRemarks!=null && AllReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:AllReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%> (RC1) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %> <%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC2) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("EXT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(EXT) : <%} %>  &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("ERT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(ERT) : <%} %>  &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
	<div class="col-md-12">
	<div class="col-md-6" style="float: left!important; display: inline-block;">
	<%if(RecommendingDetails[0]!=null){ %>
   <span style="float: left;"><b>RC - 1  &nbsp;: &nbsp;</b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[8]!=null){%><%=RecommendingDetails[8].toString()%>-<%}%><%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %>-<%} %></span><br><br>
   <%} %>
    <%if(RecommendingDetails[1]!=null) {%>
   <span style="float: left;"><b>RC - 2   &nbsp;:&nbsp;  </b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[9]!=null){%><%=RecommendingDetails[9].toString()%>-<%}%><%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
    <%if(RecommendingDetails[2]!=null){%>
    <span style="float: left;"><b>RC - 3  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[10]!=null){%><%=RecommendingDetails[10].toString()%>-<%}%><%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[3]!=null){%>
    <span style="float: left;"><b>RC - 4  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[11]!=null){%><%=RecommendingDetails[11].toString()%>-<%}%><%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[4]!=null){%>
    <span style="float: left;"><b>RC - 5  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[12]!=null){%><%=RecommendingDetails[12].toString()%>-<%}%><%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[5]!=null){%>
    <span style="float: left;"><b>EX  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[13]!=null){%><%=RecommendingDetails[13].toString()%>-<%}%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[6]!=null){%>
    <span style="float: left;"><b>AO  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[14]!=null){%><%=RecommendingDetails[14].toString()%>-<%}%><%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[7]!=null){%>
    <span style="float: left;"><b>Initiated By  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[7]!=null){%><%=RecommendingDetails[7].toString() %><%}else{ %>-<%} %></span><br><br>
    <%}%>
     </div>
	<div class="col-md-6" style="float: left!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents : </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative;float: left!important;  width: 100%;"> 
	  	     </div>
           </div>
          </div>
		</div>
		</div>
		  <form action="#" id="appform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="appform" id="enoteidfordelete" name="EnoteId" value="" />
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="EnotePreview">
  	     <input type="hidden" form="appform" id="preview" name="preview" value="<%=preview%>">
  	     <input type="hidden" form="appform" id="ViewFrom" name="ViewFrom" value="<%=ViewFrom%>">
  	     </form>
  	     <%if(EnotePreview[7]!=null && EmpId==Long.parseLong(EnotePreview[15].toString()) && EnotePreview[26].toString().equalsIgnoreCase("INI")) {%>
			 
			 <div align="center">
			     <form action="#" method="post">
				 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				 <button type="submit" style="margin-right:36%;" class="btn btn-primary btn-sm submit " id="" name="Action" value="A" formaction="EnoteForwardSubmit.htm" formmethod="post" onclick="return confirm('Are you sure to forward..?')">Forward</button>
		 		 <input type="hidden" name="RedirectName" value="forward">
		 		 <input type="hidden" id="eNoteIdsel" name="eNoteId" value="<%=EnotePreview[0].toString() %>" >
		 		 <input type="hidden" name="RecommendingOfficer1"  value="<%if(EnotePreview[7]!=null) { %><%=EnotePreview[7]%><%} %>">
		 		 <input type="hidden" name="RecommendingOfficer2"  value="<%if(EnotePreview[8]!=null) { %><%=EnotePreview[8]%><%} %>">
		 		 <input type="hidden" name="RecommendingOfficer3"  value="<%if(EnotePreview[9]!=null) { %><%=EnotePreview[9]%><%} %>">
		 		 <input type="hidden" name="RecommendingOfficer4" value="<%if(EnotePreview[10]!=null){ %><%=EnotePreview[10]%><%} %>">
		 		 <input type="hidden" name="RecommendingOfficer5" value="<%if(EnotePreview[11]!=null){ %><%=EnotePreview[11]%><%} %>">
		 		 <input type="hidden" name="SanctioningOfficer"   value="<%if(EnotePreview[12]!=null){ %><%=EnotePreview[12]%><%} %>">
		 		 <input type="hidden" name="ExternalOfficer"      value="<%if(EnotePreview[16]!=null){ %><%=EnotePreview[16]%><%} %>">
					</form>
					</div>
		 		 <%} %>
		
	<%}%>
	
	<%if(Approval!=null && Approval.equalsIgnoreCase("Y")){ %>
	<%if(AllReturnRemarks!=null && AllReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:AllReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%> (RC1) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %> <%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC2) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("EXT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(EXT) : <%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("ERT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(ERT) : <%} %>  &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
	<div class="col-md-12">
	<div class="col-md-6" style="float: left!important;">
	<%if(RecommendingDetails[0]!=null){ %>
   <span style="float: left;"><b>RC - 1  &nbsp;: &nbsp;</b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[8]!=null){%><%=RecommendingDetails[8].toString()%>-<%}%><%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %>-<%} %></span><br><br>
   <%} %>
    <%if(RecommendingDetails[1]!=null) {%>
   <span style="float: left;"><b>RC - 2   &nbsp;:&nbsp;  </b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[9]!=null){%><%=RecommendingDetails[9].toString()%>-<%}%><%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
    <%if(RecommendingDetails[2]!=null){%>
    <span style="float: left;"><b>RC - 3  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[10]!=null){%><%=RecommendingDetails[10].toString()%>-<%}%><%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[3]!=null){%>
    <span style="float: left;"><b>RC - 4  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[11]!=null){%><%=RecommendingDetails[11].toString()%>-<%}%><%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[4]!=null){%>
    <span style="float: left;"><b>RC - 5  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[12]!=null){%><%=RecommendingDetails[12].toString()%>-<%}%><%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[5]!=null){%>
    <span style="float: left;"><b>EO &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[13]!=null){%><%=RecommendingDetails[13].toString()%>-<%}%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[6]!=null){%>
    <span style="float: left;"><b>AO  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[14]!=null){%><%=RecommendingDetails[14].toString()%>-<%}%><%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[7]!=null){%>
    <span style="float: left;"><b>Initiated By &nbsp; :&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[7]!=null){%><%=RecommendingDetails[7].toString() %><%}else{ %>-<%} %></span><br><br>
    <%}%>
     </div>
	<div class="col-md-6" style="float: left!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents : </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	     </div>
           </div>
          </div>
		</div>
		  <form action="#" id="appform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="appform" id="enoteidfordelete" name="EnoteId" value="" />
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="EnotePreview">
  	     <input type="hidden" form="appform" id="Approval" name="Approval" value="<%=Approval%>">
  	     <input type="hidden" form="appform" id="ViewFrom" name="ViewFrom" value="<%=ViewFrom%>">
  	     </form>
		</div><br><br>
		<div class="row">
		   <b >Remarks :</b><br>
		   <textarea form="app-form" rows="3" cols="65" maxlength="1000" name="remarks" id="remarksarea"></textarea> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    </div><br>
		<form action="#" method="post" id="app-form">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
		<div align="center">
		<%if(EnotePreview!=null && EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("APR")){%>
		<button type="submit" class="btn btn-primary btn-sm submit" form="app-form" formaction="EnoteForwardSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" >
		Approve </button>
		<input type="hidden" name="Approve" form="app-form" value="Approve">
		<%}else{ %>
		<button type="submit" class="btn btn-primary btn-sm submit" form="app-form" formaction="EnoteForwardSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" >
		Recommend</button>
		<%} %>
		<input type="hidden" name="RedirectName" form="app-form" value="Recommend">
		<button type="submit" class="btn btn-sm btn-danger" form="app-form" name="Action" formaction="EnoteForwardSubmit.htm" value="R" onclick="return validateTextBox();">
				Return
		</button>
		</div>
		<input type="hidden" form="app-form" id="eNoteId" name="eNoteId" value="<%=EnotePreview[0].toString() %>" >
	<%} %>
	
	<%if(Approval!=null && Approval.equalsIgnoreCase("N")){ %>
	<%if(AllReturnRemarks!=null && AllReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:AllReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%> (RC1) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %> <%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC2) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("EXT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(EXT) : <%} %>  &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("ERT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(ERT) : <%} %>  &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
	<div class="col-md-12">
	<div class="col-md-6" style="float: left!important;">
	<%if(RecommendingDetails[0]!=null){ %>
   <span style="float: left;"><b>RC - 1  &nbsp;: &nbsp;</b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[8]!=null){%><%=RecommendingDetails[8].toString()%>-<%}%><%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %>-<%} %></span><br><br>
   <%} %>
    <%if(RecommendingDetails[1]!=null) {%>
   <span style="float: left;"><b>RC - 2   &nbsp;:&nbsp;  </b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[9]!=null){%><%=RecommendingDetails[9].toString()%>-<%}%><%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
    <%if(RecommendingDetails[2]!=null){%>
    <span style="float: left;"><b>RC - 3  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[10]!=null){%><%=RecommendingDetails[10].toString()%>-<%}%><%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[3]!=null){%>
    <span style="float: left;"><b>RC - 4  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[11]!=null){%><%=RecommendingDetails[11].toString()%>-<%}%><%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[4]!=null){%>
    <span style="float: left;"><b>RC - 5  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[12]!=null){%><%=RecommendingDetails[12].toString()%>-<%}%><%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[5]!=null){%>
    <span style="float: left;"><b>EO  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[13]!=null){%><%=RecommendingDetails[13].toString()%>-<%}%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[6]!=null){%>
    <span style="float: left;"><b>AO  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[14]!=null){%><%=RecommendingDetails[14].toString()%>-<%}%><%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[7]!=null){%>
    <span style="float: left;"><b>Initiated By  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[7]!=null){%><%=RecommendingDetails[7].toString() %><%}else{ %>-<%} %></span><br><br>
    <%}%>
     </div>
	<div class="col-md-6" style="float: left!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents : </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	     </div>
           </div>
          </div>
		</div>
		  <form action="#" id="appform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="appform" id="enoteidfordelete" name="EnoteId" value="" />
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="EnotePreview">
  	     <input type="hidden" form="appform" id="Approval" name="Approval" value="<%=Approval%>">
  	     <input type="hidden" form="appform" id="ViewFrom" name="ViewFrom" value="<%=ViewFrom%>">
  	     </form>
		<input type="hidden" form="app-form" id="eNoteId" name="eNoteId" value="<%=EnotePreview[0].toString() %>" >
		</div>
	<%} %>
	
	<%if(SkipPreview!=null && SkipPreview.equalsIgnoreCase("SkipPreview")){ %>
	<%if(AllReturnRemarks!=null && AllReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:AllReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%> (RC1) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %> <%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC2) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("EXT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(EXT) : <%} %>  &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("ERT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(ERT) : <%} %>  &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
	<div class="col-md-12">
	<div class="col-md-6" style="float: left!important;">
	<%if(RecommendingDetails[0]!=null){ %>
   <span style="float: left;"><b>RC - 1  &nbsp;: &nbsp;</b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[8]!=null){%><%=RecommendingDetails[8].toString()%>-<%}%><%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %>-<%} %></span><br><br>
   <%} %>
    <%if(RecommendingDetails[1]!=null) {%>
   <span style="float: left;"><b>RC - 2   &nbsp;:&nbsp;  </b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[9]!=null){%><%=RecommendingDetails[9].toString()%>-<%}%><%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
    <%if(RecommendingDetails[2]!=null){%>
    <span style="float: left;"><b>RC - 3  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[10]!=null){%><%=RecommendingDetails[10].toString()%>-<%}%><%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[3]!=null){%>
    <span style="float: left;"><b>RC - 4  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[11]!=null){%><%=RecommendingDetails[11].toString()%>-<%}%><%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[4]!=null){%>
    <span style="float: left;"><b>RC - 5  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[12]!=null){%><%=RecommendingDetails[12].toString()%>-<%}%><%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[5]!=null){%>
    <span style="float: left;"><b>EO  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[13]!=null){%><%=RecommendingDetails[13].toString()%>-<%}%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[6]!=null){%>
    <span style="float: left;"><b>AO  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[14]!=null){%><%=RecommendingDetails[14].toString()%>-<%}%><%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[7]!=null){%>
    <span style="float: left;"><b>Initiated By  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[7]!=null){%><%=RecommendingDetails[7].toString() %><%}else{ %>-<%} %></span><br><br>
    <%}%>
     </div>
	<div class="col-md-6" style="float: left!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents : </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	     </div>
           </div>
          </div>
		  <form action="#" id="appform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="appform" id="enoteidfordelete" name="EnoteId" value="" />
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="EnotePreview">
  	     <input type="hidden" form="appform" id="SkipPreview" name="SkipPreview" value="<%=SkipPreview%>">
  	     <input type="hidden" form="appform" id="ViewFrom" name="ViewFrom" value="<%=ViewFrom%>">
  	     </form>
		<input type="hidden" form="app-form" id="eNoteId" name="eNoteId" value="<%=EnotePreview[0].toString() %>" >
		<form action="#" id="SkipApproval"></form>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div align="left" class="row" >
		<div class="col-md-3" > 
		<input type="radio" name="SkipChange" value="skip" checked="checked"> Skip <br>
		<input type="radio" name="SkipChange" value="change"> Change
		</div>
		<div align="left" class="col-md-9" > 
		<div id="enoteskip" class="SkipChange">
		<select class="form-control selectpicker SkipApprovalRemarks" form="SkipApproval" id="SkipApprovalRemarks" required="required" data-live-search="true" name="remarks" >
			<option value="Select">Reason</option> 
			<option value="ON TD">ON TD</option>
			<option value="ON LEAVE">ON LEAVE</option>
		</select>
		<input type="hidden" form="SkipApproval" id="SkipPreview" name="SkipPreview" value="<%=SkipPreview%>">
		<button type="submit" class="btn btn-primary btn-sm submit" form="SkipApproval" style="margin-left:10px;" id="skip" formaction="EnoteForwardSubmit.htm" name="Action" 
		value="A" onclick="return SkipApprovalSubmit()" > Skip </button><br><br>
		<span style="color: blue;">
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC1")){ %>for( <%if(RecommendingDetails[8]!=null){%><%=RecommendingDetails[8].toString()%> - <%}%>
		<%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[8]!=null){%><%="Skipped because "+RecommendingDetails[8].toString()%> - <%}%><%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC2")){ %>for( <%if(RecommendingDetails[9]!=null){%><%=RecommendingDetails[9].toString()%> - <%}%>
		<%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[9]!=null){%><%="Skipped because "+RecommendingDetails[9].toString()%> - <%}%><%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC3")){ %>for( <%if(RecommendingDetails[10]!=null){%><%=RecommendingDetails[10].toString()%> - <%}%>
		<%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[10]!=null){%><%="Skipped because "+RecommendingDetails[10].toString()%> - <%}%><%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC4")){ %>for( <%if(RecommendingDetails[11]!=null){%><%=RecommendingDetails[11].toString()%> - <%}%>
		<%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[11]!=null){%><%="Skipped because "+RecommendingDetails[11].toString()%> - <%}%><%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC5")){ %>for( <%if(RecommendingDetails[12]!=null){%><%=RecommendingDetails[12].toString()%> - <%}%>
		<%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[12]!=null){%><%="Skipped because "+RecommendingDetails[12].toString()%> - <%}%><%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("EXT")){ %>for( <%if(RecommendingDetails[13]!=null){%><%=RecommendingDetails[13].toString()%> - <%}%>
		<%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[13]!=null){%><%="Skipped because "+RecommendingDetails[13].toString()%> - <%}%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("APR")){ %>for( <%if(RecommendingDetails[14]!=null){%><%=RecommendingDetails[14].toString()%> - <%}%>
		<%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[14]!=null){%><%="Skipped because "+RecommendingDetails[14].toString()%> - <%}%><%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %>-<%} %>"><%} %></span>
		</div>
		<form action="#" id="ChangeApproval"></form>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div id="enotechange" class="SkipChange">
		<label class="control-label" style="float: left;"><b>Officer  </b></label>&nbsp;&nbsp;
		<select class="form-control selectpicker ChangeRecOfficer" form="ChangeApproval" id="ChangeRecOfficer" required="required" data-live-search="true" name="ChangeRecOfficer" >
		</select>
		<select class="form-control selectpicker ChangeApprovalRemarks" form="ChangeApproval" id="ChangeApprovalRemarks" required="required" data-live-search="true" name="ChangeApprovalRemarks" >
			<option value="Select">Reason</option> 
			<option value="ON TD">ON TD</option>
			<option value="ON LEAVE">ON LEAVE</option>
		</select><br><br>
		<label class="control-label" style="float: left;"><b>Role  </b></label>
		<input class="form-control" type="text" style="width: 39%; margin-left:30px; display: inline-block;" form="ChangeApproval" id="RecommendRole" name="RecommendRole">&nbsp;&nbsp; 
		<button type="submit" class="btn btn-primary btn-sm submit" form="ChangeApproval"  id="ChangeRec" formaction="ChangeRecommendOfficer.htm"
		 onclick="return ChangeRecommendingOfficer()" > Change </button>
		 <input type="hidden" form="ChangeApproval" id="SkipPreview" name="SkipPreview" value="<%=SkipPreview%>">
		 <span style="color: blue;">
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC1")){ %>for( <%if(RecommendingDetails[8]!=null){%><%=RecommendingDetails[8].toString()%> - <%}%>
		<%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[8]!=null){%><%="Changed because "+RecommendingDetails[8].toString()%> - <%}%><%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC2")){ %>for( <%if(RecommendingDetails[9]!=null){%><%=RecommendingDetails[9].toString()%> - <%}%>
		<%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[9]!=null){%><%="Changed because "+RecommendingDetails[9].toString()%> - <%}%><%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC3")){ %>for( <%if(RecommendingDetails[10]!=null){%><%=RecommendingDetails[10].toString()%> - <%}%>
		<%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[10]!=null){%><%="Changed because "+RecommendingDetails[10].toString()%> - <%}%><%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC4")){ %>for( <%if(RecommendingDetails[11]!=null){%><%=RecommendingDetails[11].toString()%> - <%}%>
		<%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[11]!=null){%><%="Changed because "+RecommendingDetails[11].toString()%> - <%}%><%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("RC5")){ %>for( <%if(RecommendingDetails[12]!=null){%><%=RecommendingDetails[12].toString()%> - <%}%>
		<%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[12]!=null){%><%="Changed because "+RecommendingDetails[12].toString()%> - <%}%><%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("EXT")){ %>for( <%if(RecommendingDetails[13]!=null){%><%=RecommendingDetails[13].toString()%> - <%}%>
		<%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[13]!=null){%><%="Changed because "+RecommendingDetails[13].toString()%> - <%}%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("APR")){ %>for( <%if(RecommendingDetails[14]!=null){%><%=RecommendingDetails[14].toString()%> - <%}%>
		<%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(RecommendingDetails[14]!=null){%><%="Changed because "+RecommendingDetails[14].toString()%> - <%}%><%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %>-<%} %>"><%} %></span>
		</div>
		</div>
		</div>
		    <input type="hidden" form="ChangeApproval" id="StatusCodeNext" name="StatusCodeNext" >
		    <input type="hidden" form="ChangeApproval" id="ChangeStatusCode" name="ChangeStatusCode" >
		    <input type="hidden" form="ChangeApproval" id="eNoteIdChangeId" name="eNoteId" value="<%=EnotePreview[0].toString() %>" >
			<input type="hidden" form="SkipApproval" id="eNoteId" name="eNoteId" value="<%=EnotePreview[0].toString() %>" >
			<input type="hidden" form="SkipApproval" name="RedirectName"  value="SkipPreview">
		</div>
		</div>
	<%} %>
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
</div>
</div>
</div>
<div id="draftContainer" class="col-md-5" style="display: none;" >
<div class="page card dashboard-card" >
<div class="card-body" align="center">
<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #114A86;height: 40px; padding: 5px;">
	Draft
</div>
<%if(WordDocumentData!=null && WordDocumentData[4]!=null && WordDocumentData[4].toString().equalsIgnoreCase("Y")){ %>
<jsp:include page="../static/LetterHead.jsp" />
<%} %>
<br>
<%if(WordDocumentData!=null){ %>
<table style="width: 100%; border-collapse: collapse; border: none;">
<tr style="border: none;">
<%if(WordDocumentData[0]!=null){%>
<td style="float: left;">RefNo : <%=WordDocumentData[0].toString()%></td>
<%} %>
<%if(WordDocumentData[1]!=null){%>
<td style="float: right;">Letter Date : <%=sdf.format(WordDocumentData[1]) %></td>
<%} %>
</tr>
<tr style="border: none;">
<%if(WordDocumentData[6]!=null && WordDocumentData[7]!=null && WordDocumentData[8]!=null && WordDocumentData[9]!=null){ %>
<td colspan="2"><br>
To,<br>
<%=WordDocumentData[6].toString()+"," %><br>
<%=WordDocumentData[7].toString()+"," %><br>
<%=WordDocumentData[8].toString()+"-"+WordDocumentData[9].toString()%><br>
</td>
<%} %>
</tr>
<tr style="border: none;">
<%if(WordDocumentData[2]!=null){ %>
<td colspan="2"><br>
<%="Subject : "+ WordDocumentData[2].toString()%><br><br>
</td>
<%} %>
</tr>
<tr style="border: none;">
<%if(WordDocumentData[3]!=null){ %>
<td colspan="2">
Dear Sir/Madam,<br><br>
<%=WordDocumentData[3].toString() %><br><br><br>
</td>
<%} %>
</tr>
<tr style="border: none;">
<%if(WordDocumentData[5]!=null){ %>
<td colspan="2" style="text-align: right;">
<%=WordDocumentData[5].toString() %>
</td>
<%} %>
</tr>
</table>
<%} %><br><br>
<%if(letterDocumentdata!=null){ %>
<form action="#">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<div class="letterWordDocument" style="width: 100%;">
<div class="row col-md-12">
  <div class="col-md-3" id="letterDocumentLabel"  style="text-align: left;">
  <label><b>Document : </b></label></div>
<div class="col-md-9" id="letterDoc"  style="display: inline-block; position: relative; float: left!important;  width: 100%;"> 
<div style="display: flex; align-items: left;">
<button type="submit" class="btn btn-sm replyAttachWithin-btn" name="LetterDocumentId"  id=<%="LetterDocument"+letterDocumentdata[2]%> value="<%=letterDocumentdata[2] %>"  formaction="LetterDocDownload.htm" formmethod="post" style="margin-right: 5px; flex: 1; color:blue;"><%=letterDocumentdata[1].toString() %></button>
</div><br>
</div>
 </div>
 </div>
 </form>
 <%} %>
</div>
</div>	
</div>
</div>
</body>

<script>

document.addEventListener("DOMContentLoaded", function () {
	  const enoteValue = '<%=EnotePreview[30]%>'; // Replace this with your dynamic value: EnotePreview[30]

	  // Elements to manipulate
	  const formContainer = document.getElementById("formContainer");
	  const formCol = document.getElementById("formCol");
	  const draftContainer = document.getElementById("draftContainer");

	  // Logic to update classes and visibility
	  if (enoteValue === "Y") {
	    // For "Y", set formCol to col-md-7 and draftContainer to col-md-5, and make draftContainer visible
	    formCol.classList.remove("col-md-12");
	    formCol.classList.add("col-md-7");

	    draftContainer.style.display = "block"; // Show draftContainer
	    draftContainer.classList.remove("col-md-12");
	    draftContainer.classList.add("col-md-5");
	  } else if (enoteValue === "N") {
	    // For "N", set formCol to col-md-12 and hide draftContainer
	    formCol.classList.remove("col-md-7");
	    formCol.classList.add("col-md-12");

	    draftContainer.style.display = "none"; // Hide draftContainer
	    draftContainer.classList.remove("col-md-5");
	    draftContainer.classList.add("col-md-12");
	  } else {
	    console.error("Invalid EnotePreview value:", enoteValue);
	  }
	});


$(document).ready(function () {
	
	 var LabCode = document.getElementById("LabCode").value;
	 var ExternalOfficer=null;
	 <%if(EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[11]!=null){%>
	  ExternalOfficer=<%=EnoteRoSoRoledetails[11]%>;
	 <%}%>
	 var SelectedValue=<%=EnotePreview[16]%>;
	    $('#ExternalOfficer').empty();
	    $.ajax({
	        type: "GET",
	        url: "GetLabcodeEmpList.htm",
	        data: {
	        	LabCode: LabCode
	        },
	        dataType: 'json',
	        success: function(result) {
	            if (result != null && LabCode!='@EXP') {
	                for (var i = 0; i < result.length; i++) {
	                    var data = result[i];
	                    var optionValue = data[0];
	                    
	                    var optionText = data[1].trim() + ", " + data[3]; 
	                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                    $('#ExternalOfficer').append(option); 
	                    if(SelectedValue==optionValue){
	                    	console.log("optionValue:"+optionValue);
	                     	 $('#ExternalOfficer option[value="' + optionValue + '"]').prop('selected', true);
	                     }else if(ExternalOfficer==optionValue && SelectedValue===null){
	                   	 $('#ExternalOfficer option[value="' + optionValue + '"]').prop('selected', true);
	                     }
	                }
	                $('#ExternalOfficer').selectpicker('refresh');
	                }else{
	                	for (var i = 0; i < result.length; i++) {
	                        var data = result[i];
	                        var optionValue = data[0];
	                        var optionText = data[1].trim() + ", " + data[3]; 
	                        var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                        $('#ExternalOfficer').append(option); 
	                        if(SelectedValue==optionValue){
		                     	 $('#ExternalOfficer option[value="' + optionValue + '"]').prop('selected', true);
		                     }else if(ExternalOfficer==optionValue && SelectedValue===null){
		                   	 $('#ExternalOfficer option[value="' + optionValue + '"]').prop('selected', true);
		                     }
	                    }
	                    $('#ExternalOfficer').selectpicker('refresh');
	                }
	            }
	    });
});

$(document).ready(function(){ 
	$('#enotechange').hide();
	 $("input[name$='SkipChange']").click(function() {
	        var test = $(this).val();
	        $("div.SkipChange").hide();
	        $("#enote" + test).show();
	    });
	 var height=$('#PreviewHeight').height();
	 $('#LetterHeight').height(height);
});
var External = '<%=EnotePreview[14]%>';
var status='<%=EnotePreview[26]%>';
if(status !==null && status !=='INI'){
	$('#forwardremarksarea').prop('disabled',false);
}else{
	$('#forwardremarksarea').prop('disabled',true);
}

if (External !== null && External === 'E') {
  $('.tr_cloneExternal').show();
}else{
	$('.tr_cloneExternal').hide();
	$('#LabCode').prop('disabled',true);
	$('#ExtRole').prop('disabled',true);
	$('#ExternalOfficer').prop('disabled',true);
}

var StatusCodeNext='<%=EnotePreview[25]%>';
var StatusCode='<%=EnotePreview[26]%>';
$('#StatusCodeNext').val(StatusCodeNext);
$('#ChangeStatusCode').val(StatusCode);
var EmpId=null;
var role=null;
if(StatusCodeNext==='RC1'){
	EmpId='<%=EnotePreview[7]%>';
	role='<%if(EnotePreview[17]!=null){%><%=EnotePreview[17]%><%}%>';
}else if(StatusCodeNext==='RC2'){
	EmpId='<%=EnotePreview[8]%>';
	role='<%if(EnotePreview[18]!=null){%><%=EnotePreview[18]%><%}%>';
}else if(StatusCodeNext==='RC3'){
	EmpId='<%=EnotePreview[9]%>';
	role='<%if(EnotePreview[19]!=null){%><%=EnotePreview[19]%><%}%>';
}else if(StatusCodeNext==='RC4'){
	EmpId='<%=EnotePreview[10]%>';
	role='<%if(EnotePreview[20]!=null){%><%=EnotePreview[20]%><%}%>';
}else if(StatusCodeNext==='RC5'){
	EmpId='<%=EnotePreview[11]%>';
	role='<%if(EnotePreview[21]!=null){%><%=EnotePreview[21]%><%}%>';
}else if(StatusCodeNext==='APR'){
	EmpId='<%=EnotePreview[12]%>';
	role='<%if(EnotePreview[23]!=null){%><%=EnotePreview[23]%><%}%>';
}
$('#RecommendRole').val(role);
$.ajax({
    type: "GET",
    url: "GetChangeRecommendingOfficer.htm",
    data: {
    	EmpId: EmpId
    },
    dataType: 'json',
    success: function(result) {
        if (result != null) {
        	var consultVals = Object.values(result);
        	 $('#ChangeRecOfficer').empty();
             for (var c = 0; c < consultVals.length; c++) {
            	var optionValue = consultVals[c][0];
     	        var optionText = consultVals[c][1].trim() + ', ' + consultVals[c][2];
     	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
     	       if(EmpId==consultVals[c][0]){
		             option.prop('selected', true);
		          }
     	       $('#ChangeRecOfficer').append(option);
           }
             $
             // Refresh the selectpicker after appending options
             $('#ChangeRecOfficer').selectpicker('refresh');
        }
    }
}); 

$(".tr_cloneRecommend2").on('click', '.tr_clone_subRecommend2', function() {
    var cl = $('.tr_cloneRecommend3').length;
    console.log("lenght:"+cl);
    if (cl == 0) {
        var $tr = $(this).closest('.tr_cloneRecommend2');
        $tr.remove();
        $('#RecommendingOfficer2').prop("disabled",true);
        $('#Rec2Role').prop("disabled", true);
    }
});

$(".tr_cloneRecommend3").on('click', '.tr_clone_subRecommend3', function() {
    var cl = $('.tr_cloneRecommend3').length;
    if (cl > 0) {
        var $tr = $(this).closest('.tr_cloneRecommend3');
        $tr.remove();
        $('#RecommendingOfficer3').prop("disabled",true);
        $('#Rec3Role').prop("disabled", true);
        
    }
});

function SkipApprovalSubmit() {
	var SkipApprovalRemarks=$('#SkipApprovalRemarks').val();
	 if (SkipApprovalRemarks==null || SkipApprovalRemarks=== '' || SkipApprovalRemarks===" " || typeof(SkipApprovalRemarks)=='undefined' || SkipApprovalRemarks==='Select') {
		 alert("Please Select the Resaon for Skip ...!");
		 $("#SkipApprovalRemarks").focus();
	     return false;
	    } else {
	    	return confirm('Are You Sure To Skip?');
	    }
}

function ChangeRecommendingOfficer() {
	var ChangeRecommendingOfficer=$('#ChangeRecOfficer').val();
	var ChangeApprovalRemarks=$('#ChangeApprovalRemarks').val();
	var RecommendRole=$('#RecommendRole').val();
	var form=$('#ChangeRec').val();
	 if (ChangeRecommendingOfficer==null || ChangeRecommendingOfficer=== '' || ChangeRecommendingOfficer===" " || typeof(ChangeRecommendingOfficer)=='undefined') {
		 alert("Please Select the RecommendingOfficer ...!");
		 $("#ChangeRecOfficer").focus();
	     return false;
	 } else if(ChangeApprovalRemarks==null || ChangeApprovalRemarks=== '' || ChangeApprovalRemarks===" " || typeof(ChangeApprovalRemarks)=='undefined' || ChangeApprovalRemarks==='Select') {
		 alert("Please Select the Reason For Change ...!");
		 $("#ChangeApprovalRemarks").focus();
	     return false;
	 } else if(RecommendRole==null || RecommendRole==='' || RecommendRole==="" || typeof(RecommendRole)=='undefined') {
		 alert("Please Enter the RecommendingOfficer Role...!");
		 $("#RecommendRole").focus();
	     return false;
	 } else {
	    	return confirm('Are You Sure To Change Officer ...?');
	    }
}
function LabcodeSubmit() {
    var LabCode = document.getElementById("LabCode").value;
    $('#ExternalOfficer').empty();
    $.ajax({
        type: "GET",
        url: "GetLabcodeEmpList.htm",
        data: {
        	LabCode: LabCode
        },
        dataType: 'json',
        success: function(result) {
            if (result != null && LabCode!='@EXP') {
                for (var i = 0; i < result.length; i++) {
                    var data = result[i];
                    var optionValue = data[0];
                    var optionText = data[1].trim() + ", " + data[3]; 
                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
                    $('#ExternalOfficer').append(option); 
                }
                $('#ExternalOfficer').selectpicker('refresh');
                }else{
                	for (var i = 0; i < result.length; i++) {
                        var data = result[i];
                        var optionValue = data[0];
                        var optionText = data[1].trim() + ", " + data[3]; 
                        var option = $("<option></option>").attr("value", optionValue).text(optionText);
                        $('#ExternalOfficer').append(option); 
                    }
                    $('#ExternalOfficer').selectpicker('refresh');
                }
            }
    });
}


function EnoteForwardSubmit() {
	var External = '<%=EnotePreview[14]%>';
	if(External!==null && External === 'I'){
	var shouldSubmit = true;
	const form =document.getElementById('eNoteForm');
	var RecommendingOfficer1=$('#RecommendingOfficer1').val();
	var RecommendingOfficer2=$('#RecommendingOfficer2').val();
	var RecommendingOfficer3=$('#RecommendingOfficer3').val();
	var SanctioningOfficer=$('#SanctioningOfficer').val();
	var Rec1Role=$('#Rec1Role').val();
	var Rec2Role=$('#Rec2Role').val();
	var Rec3Role=$('#Rec3Role').val();
	var SancRole=$('#SancRole').val();
	var forwardremarksarea=$('#forwardremarksarea').val();
	var ActionSave=$('#RedirectName').val();
	
	if(RecommendingOfficer1==null || RecommendingOfficer1==='' || RecommendingOfficer1==="" || typeof(RecommendingOfficer1)=='undefined' ||RecommendingOfficer1==='Select'){
		alert("Please Select the Recommending Officer1..!");
		  $("#RecommendingOfficer1").focus();
		  shouldSubmit = false;
	}else if(RecommendingOfficer3==='' || RecommendingOfficer3==="" || RecommendingOfficer3==='Select'){
		alert("Please Select the Recommending Officer3 Or Remove the Recommending Officer3..!");
		  $("#RecommendingOfficer3").focus();
		  shouldSubmit = false;	
	}else if(RecommendingOfficer2==='' || RecommendingOfficer2==="" || RecommendingOfficer2==='Select'){
		alert("Please Select the Recommending Officer2 Or Remove the Recommending Officer2..!");
		  $("#RecommendingOfficer2").focus();
		  shouldSubmit = false;
	}else if(SanctioningOfficer==null || SanctioningOfficer==='' || SanctioningOfficer==="" || typeof(SanctioningOfficer)=='undefined' ||SanctioningOfficer==='Select'){
		alert("Please Select the Sanctioning Officer..!");
		  $("#SanctioningOfficer").focus();
		  shouldSubmit = false;
   }else if(Rec1Role==null || Rec1Role==='' || Rec1Role==="" || typeof(Rec1Role)=='undefined'){
	      alert("Please Enter the Recommending-Officer1 Role..!");
		  $("#Rec1Role").focus();
		  shouldSubmit = false;
   }else if(Rec2Role==='' || Rec2Role==="" ){
	      alert("Please Enter the Recommending-Officer2 Role..!");
		  $("#Rec2Role").focus();
		  shouldSubmit = false;
   }else if(Rec3Role==='' || Rec3Role==="" ){
	     alert("Please Enter the Recommending-Officer3 Role..!");
		 $("#Rec3Role").focus();
		 shouldSubmit = false;
   }else if(SancRole==='' || SancRole===""){
	     alert("Please Enter the Sanctioning-Officer Role..!");
		 $("#SancRole").focus();
		 shouldSubmit = false;
   }else if(forwardremarksarea==='' || forwardremarksarea===""){
	     alert("Please Enter the Remarks..!");
		 $("#forwardremarksarea").focus();
		 shouldSubmit = false;
   }else{
	   if(ActionSave==='ActionSave'){
		if(confirm('Are you Sure To Save ?')){
			  form.submit();/*submit the form */
				}
	   }else{
		   if(confirm('Are you Sure To Forward ?')){
				  form.submit();/*submit the form */
					}
	   }
	}
}else{
	var shouldSubmit = true;
	const form =document.getElementById('eNoteForm');
	var RecommendingOfficer1=$('#RecommendingOfficer1').val();
	var RecommendingOfficer2=$('#RecommendingOfficer2').val();
	var RecommendingOfficer3=$('#RecommendingOfficer3').val();
	var ExternalOfficer=$('#ExternalOfficer').val();
	var SanctioningOfficer=$('#SanctioningOfficer').val();
	var Rec1Role=$('#Rec1Role').val();
	var Rec2Role=$('#Rec2Role').val();
	var Rec3Role=$('#Rec3Role').val();
	var SancRole=$('#SancRole').val();
	var ExtRole=$('#ExtRole').val();
	var LabCode=$('#LabCode').val();
	var forwardremarksarea=$('#forwardremarksarea').val();
	var ActionSave=$('#RedirectName').val();
	
	if(RecommendingOfficer1==null || RecommendingOfficer1==='' || RecommendingOfficer1==="" || typeof(RecommendingOfficer1)=='undefined' ||RecommendingOfficer1==='Select'){
		alert("Please Select the Recommending Officer1..!");
		  $("#RecommendingOfficer1").focus();
		  shouldSubmit = false;
	}else if(RecommendingOfficer3==='' || RecommendingOfficer3==="" || RecommendingOfficer3==='Select'){
		alert("Please Select the Recommending Officer3 Or Remove the Recommending Officer3..!");
		  $("#RecommendingOfficer3").focus();
		  shouldSubmit = false;	
	}else if(RecommendingOfficer2==='' || RecommendingOfficer2==="" || RecommendingOfficer2==='Select'){
		alert("Please Select the Recommending Officer2 Or Remove the Recommending Officer2..!");
		  $("#RecommendingOfficer2").focus();
		  shouldSubmit = false;
	}else if(LabCode==='' || LabCode==="" || LabCode==='Select'){
		alert("Please Select the Labcode..!");
		  $("#LabCode").focus();
		  shouldSubmit = false;
	}else if(ExternalOfficer==null || ExternalOfficer==='' || ExternalOfficer==="" || typeof(ExternalOfficer)=='undefined' ||ExternalOfficer==='Select'){
		alert("Please Select the External-Officer..!");
		  $("#ExternalOfficer").focus();
		  shouldSubmit = false;
	}else if(SanctioningOfficer==null || SanctioningOfficer==='' || SanctioningOfficer==="" || typeof(SanctioningOfficer)=='undefined' ||SanctioningOfficer==='Select'){
		alert("Please Select the Sanctioning Officer..!");
		  $("#SanctioningOfficer").focus();
		  shouldSubmit = false;
    }else if(Rec1Role==null || Rec1Role==='' || Rec1Role==="" || typeof(Rec1Role)=='undefined'){
	      alert("Please Enter the Recommending-Officer1 Role..!");
		  $("#Rec1Role").focus();
		  shouldSubmit = false;
   }else if(Rec2Role==='' || Rec2Role==="" ){
	      alert("Please Enter the Recommending-Officer2 Role..!");
		  $("#Rec2Role").focus();
		  shouldSubmit = false;
   }else if(Rec3Role==='' || Rec3Role==="" ){
	     alert("Please Enter the Recommending-Officer3 Role..!");
		 $("#Rec3Role").focus();
		 shouldSubmit = false;
   }else if(ExtRole==='' || ExtRole===""){
	     alert("Please Enter the External-Officer Role..!");
		 $("#ExtRole").focus();
		 shouldSubmit = false;
   }else if(SancRole==='' || SancRole===""){
	     alert("Please Enter the Sanctioning-Officer Role..!");
		 $("#SancRole").focus();
		 shouldSubmit = false;
   }else if(forwardremarksarea==='' || forwardremarksarea===""){
	     alert("Please Enter the Remarks..!");
		 $("#forwardremarksarea").focus();
		 shouldSubmit = false;
   }else{
	   if(ActionSave==='ActionSave'){
			if(confirm('Are you Sure To Save ?')){
				  form.submit();/*submit the form */
					}
		   }else{
			   if(confirm('Are you Sure To Forward ?')){
					  form.submit();/*submit the form */
						}
		   }
	}
}
}

function firstDropdownChange() {
    var selectedValue = document.getElementById("RecommendingOfficer1").value;
    
    var SelecctedRecommend2=<%=EnotePreview[8]%>;
    
    $('#RecommendingOfficer2').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendingOfficer2').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue) {
        	
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendingOfficer2').append(option);
            if(SelecctedRecommend2==optionValue){
            $('#RecommendingOfficer2 option[value="' + optionValue + '"]').prop('selected', true);
        	}
        }
    <% } %>
    
 // Refresh the selectpicker after appending options
    $('#RecommendingOfficer2').selectpicker('refresh');
 
    var SelecctedRecommend3=<%=EnotePreview[9]%>;
    $('#RecommendingOfficer3').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendingOfficer3').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue ) {
        	
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendingOfficer3').append(option);
            if(SelecctedRecommend3==optionValue){
            $('#RecommendingOfficer3 option[value="' + optionValue + '"]').prop('selected', true);
        	}
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendingOfficer3').selectpicker('refresh');
 
 	var SanctioningOfficer=<%=EnotePreview[12]%>;

    $('#SanctioningOfficer').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#SanctioningOfficer').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue ) {
        	
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctioningOfficer').append(option);
            if(SanctioningOfficer==optionValue){
            $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
    	}
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctioningOfficer').selectpicker('refresh');
}

function secondDropdownChange() {
    var selectedValue = document.getElementById("RecommendingOfficer1").value;
    var selectedValue2 = document.getElementById("RecommendingOfficer2").value;
    
    
    var SelecctedRecommend3=<%=EnotePreview[9]%>;
    
    $('#RecommendingOfficer3').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendingOfficer3').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue && optionValue !== selectedValue2) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendingOfficer3').append(option);
            if(SelecctedRecommend3==optionValue){
                $('#RecommendingOfficer3 option[value="' + optionValue + '"]').prop('selected', true);
           }
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendingOfficer3').selectpicker('refresh');
 
    var SanctioningOfficer=<%=EnotePreview[12]%>;
    
    $('#SanctioningOfficer').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#SanctioningOfficer').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue && optionValue !== selectedValue2 ) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctioningOfficer').append(option);
            if(SanctioningOfficer==optionValue){
                $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
        	}
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctioningOfficer').selectpicker('refresh');

}

function thirdDropdownChange() {
	 var selectedValue = document.getElementById("RecommendingOfficer1").value;
	 var selectedValue2 = document.getElementById("RecommendingOfficer2").value;
	 var selectedValue3 = document.getElementById("RecommendingOfficer3").value;
	    
	    
	 var SanctioningOfficer=<%=EnotePreview[12]%>;
	 
    $('#SanctioningOfficer').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#SanctioningOfficer').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctioningOfficer').append(option);
            if(SanctioningOfficer==optionValue){
                $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
        	}
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctioningOfficer').selectpicker('refresh');

}


$(document).ready(function () {
	 var selectedValue = document.getElementById("RecommendingOfficer1").value;
	 var selectedValue1 = document.getElementById("RecommendingOfficer2").value;
	 var selectedValue2 = document.getElementById("RecommendingOfficer3").value;
	 var SelecctedRecommend2=<%=EnotePreview[8]%>;
	 var rosorc2='<%if(EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[3]!=null){%><%=EnoteRoSoRoledetails[3]%><%}%>';
	$('#RecommendingOfficer2').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendingOfficer2').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        if(selectedValue!==optionValue){
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendingOfficer2').append(option);
            
            if(SelecctedRecommend2==optionValue){
            	 $('#RecommendingOfficer2 option[value="' + optionValue + '"]').prop('selected', true);
            }else if(rosorc2==optionValue && SelecctedRecommend2===null){
            	$('#RecommendingOfficer2 option[value="' + optionValue + '"]').prop('selected', true);
            }
        }
            <% } %>
            
         // Refresh the selectpicker after appending options
            $('#RecommendingOfficer2').selectpicker('refresh');
         
       var SelecctedRecommend3=<%=EnotePreview[9]%>;
       var rosorc3='<%if(EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[5]!=null){%><%=EnoteRoSoRoledetails[5]%><%}%>';
       $('#RecommendingOfficer3').empty();

        var defaultOption = $("<option></option>").attr("value", "").text("Select");
        $('#RecommendingOfficer3').append(defaultOption);
        <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        if(selectedValue!==optionValue && selectedValue1!==optionValue){      
        var option = $("<option></option>").attr("value", optionValue).text(optionText);
        $('#RecommendingOfficer3').append(option);
        
        if(SelecctedRecommend3==optionValue){
       	 $('#RecommendingOfficer3 option[value="' + optionValue + '"]').prop('selected', true);
       }else if(rosorc3==optionValue && SelecctedRecommend3===null){
    	 $('#RecommendingOfficer3 option[value="' + optionValue + '"]').prop('selected', true);
       }
        }
       <% } %>
    // Refresh the selectpicker after appending options
       $('#RecommendingOfficer3').selectpicker('refresh');
       
    
       var SanctioningOfficer=<%=EnotePreview[12]%>;
       var sanc='<%if(EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[13]!=null){%><%=EnoteRoSoRoledetails[13]%><%}%>';
       $('#SanctioningOfficer').empty();

       var defaultOption = $("<option></option>").attr("value", "").text("Select");
       $('#SanctioningOfficer').append(defaultOption);
       <% for (Object[] type : RecommendingOfficerList) { %>
       var optionValue = '<%= type[0] %>';
       var optionText = '<%= type[1] + ", " + type[2] %>';
       if(selectedValue!==optionValue && selectedValue1!=optionValue && selectedValue2!==optionValue){ 
       var option = $("<option></option>").attr("value", optionValue).text(optionText);
       $('#SanctioningOfficer').append(option);
       
       if(SanctioningOfficer==optionValue){
      	 $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
      }else if(sanc==optionValue && SanctioningOfficer===null){
    	 $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
      }
       }
       <% } %>
    // Refresh the selectpicker after appending options
       $('#SanctioningOfficer').selectpicker('refresh');
       
});

function validateTextBox() {
    if (document.getElementById("remarksarea").value.trim() != "") {
    	return confirm('Are You Sure To Return?');
    	
    } else {
        alert("Please enter Remarks to Return");
        return false;
    }
}

$(document).ready(function(){	
 	var Attachcount=<%=AttachmentCount%>;
 	<%if(EnotePreview!=null){%>
 	var EnoteId=<%=EnotePreview[0].toString()%>;
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
		 mainstr += '<div style="display: flex; align-items: left;">';
         mainstr += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply" style="margin-right: 5px; flex: 1; color:blue;" value="' + other[2] + '" onclick="Iframepdf(' + other[2] + ')" data-toggle="tooltip" data-placement="top" title="Download">' + other[3] + '</button>';
         mainstr += '    <button type="button" id="EnoteAttachDelete" class="btn btn-sm icon-btn"  formaction="EnoteAttachDelete.htm" formmethod="post" data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;" onclick="deleteEnoteEditAttach(' + other[2] + ',' + other[0] + ')"><img alt="attach" src="view/images/delete.png"></button>';
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
		 var formaction=$('#appform');
		 var button = $('#EnoteAttachDelete');
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


// Element by Id
function autoResize() {
    // Get the textarea element
    var textarea = document.getElementById("Comment");

    // Auto-adjust the height of the textarea based on its content
    textarea.style.height = "auto";
    textarea.style.height = (textarea.scrollHeight) + "px";
}

// Call autoResize initially to set the textarea height based on its initial content
autoResize();

</script>
</html>
