<%@page import="java.time.LocalTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.dms.FormatConverter"%>
<%@page import="com.vts.dms.dak.model.DakMailAttach"%>
<%@page import="com.vts.dms.dak.model.DakMail"%>
<%@page import="com.vts.dms.master.model.DivisionMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="ISO-8859-1">
<title>DAK Init</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style type="text/css">

label {
	font-weight: bold;
	font-size: 14px;
}

.spinner {
	position: fixed;
	top: 40%;
	left: 25%;
	margin-left: -50px; /* half width of the spinner gif */
	margin-top: -50px; /* half height of the spinner gif */
	text-align: center;
	z-index: 1234;
	overflow: auto;
	width: 1000px; /* width of the spinner gif */
	height: 1020px; /*hight of the spinner gif +2px to fix IE8 issue */
}
</style>
<style>
div.dropdown-menu.open {
	max-height: 410px !important;
	overflow: hidden;
}

ul.dropdown-menu.inner {
	max-height: 410px !important;
	/* overflow-y: auto; */
}

h1 {
	font-size: 32px;
}

h2 {
	font-size: 26px;
}

h3 {
	font-size: 18px;
}

p {
	margin: 0 0 15px;
	line-height: 24px;
	color: gainsboro;
}

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
.tabsAttach {
	position: relative;
	display: flex;
	min-height: 500px;
	border-radius: 8px 8px 0 0;
	overflow: scroll;
}

.tabsAttach::-webkit-scrollbar {
	display: none;
}

.tabby-tabAttach {
	flex: 1;
}

.tabby-tabAttach label {
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

.tabby-tabAttach label:hover {
	background: #5488BF;
}

.tabby-contentAttach {
	position: absolute;
	left: 0;
	bottom: 0;
	right: 0;
	/* clear the tab labels */
	top: 40px;
	padding: 20px;
	border-radius: 0 0 8px 8px;
	background: white;
	transition: opacity 0.8s ease, transform 0.8s ease;
	/* show/hide */
	opacity: 0;
	transform: scale(0.1);
	transform-origin: top left;
}

.tabby-contentAttach img {
	float: left;
	margin-right: 20px;
	border-radius: 8px;
}

/* MAKE IT WORK ----- */
.tabby-tabAttach [type=radio] {
	display: none;
}

[type=radio]:checked ~ label {
	background: #5488BF;
	z-index: 2;
}

[type=radio]:checked ~ label ~ .tabby-contentAttach {
	z-index: 1;
	/* show/hide */
	opacity: 1;
	transform: scale(1);
}

/* BREAKPOINTS ----- */
@media screen and (max-width: 767px) {
	.tabsAttach {
		min-height: 400px;
	}
}

@media screen and (max-width: 480px) {
	.tabsAttach {
		min-height: 580px;
	}
	.tabby-tabAttach label {
		height: 60px;
	}
	.tabby-contentAttach {
		top: 60px;
	}
	.tabby-contentAttach img {
		float: none;
		margin-right: 0;
		margin-bottom: 20px;
	}
}

.delete-btn {
	color: #ffffff;
	background: #DC3545;
	border-color: #DC3545;
}

.filter-option-inner-inner {
	width: 200px !important;
}
.Groupname{
width: 300px !important;
}
.empidSelect{
width: 280px !important;
/* margin-left: 400px !important; */
margin-top: -20px !important;
}

.newempidSelect{
width: 350px !important;
margin-left: 15px !important; 
}

.individual{
width: 290px !important;
margin-left: -5px !important;
margin-top: -20px !important;
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
</style>
</head>
<body>

	<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Initiation</h5>
			</div>
			<div class="col-md-3" style="margin: auto;">
				<input type="radio" name="IsNewDak" checked="checked" onclick="openTab('R')">&nbsp;Received &nbsp;&nbsp;
				<input type="radio" name="IsNewDak" onclick="openTab('N')">&nbsp;New
			</div>
			<div class="col-md-6">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a
							href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="DakDashBoard.htm"><i
								class="fa fa-envelope"></i> DAK</a></li>
						<li class="breadcrumb-item active">DAK Initiation</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>

	<%
	FormatConverter fc = new FormatConverter();
	SimpleDateFormat rdtf = fc.getRegularDateTime();
	SimpleDateFormat sdtf = fc.getSqlDateAndTime();
	SimpleDateFormat sdf = fc.getSqlDate();

	List<Object[]> sourceList = (List<Object[]>) request.getAttribute("SourceList");
	List<Object[]> dakDeliveryList = (List<Object[]>) request.getAttribute("DakDeliveryList");
	List<Object[]> priorityList = (List<Object[]>) request.getAttribute("priorityList");
	List<Object[]> letterList = (List<Object[]>) request.getAttribute("letterList");
	List<Object[]> relaventList = (List<Object[]>) request.getAttribute("relaventList");
	List<Object[]> linkList = (List<Object[]>) request.getAttribute("linkList");
	List<Object[]> nonProjectList = (List<Object[]>) request.getAttribute("nonProjectList");
	List<Object[]> cwList = (List<Object[]>) request.getAttribute("cwList");
	List<Object[]> actionList = (List<Object[]>) request.getAttribute("actionList");
	List<Object[]> divList = (List<Object[]>) request.getAttribute("divList");
	String LabCode=(String)request.getAttribute("LabCode");

	List<Object[]> OtherProjectList = (List<Object[]>) request.getAttribute("OtherProjectList");

	DakMail dakmail = (DakMail) request.getAttribute("DakMail");

	List<Object[]> DakMembers = (List<Object[]>) request.getAttribute("DakMembers");
	
	List<Object[]> DakMemberGroup = (List<Object[]>) request.getAttribute("DakMemberGroup");
	
	List<Object[]> employeeList = (List<Object[]>)request.getAttribute("employeeList");
	%>


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
	<div id="pass" style="margin-left: 35%;" align="center">
		<div  role="alert">
			<span >Source SuccessFully Added..!</span>
	</div>
	</div>
	
	<div id="fail" style="margin-left: 35%;" align="center">
		<div  role="alert">
			<span >Source Added UnSuccessful..!</span>
	</div>
	</div>
	
	
	<div id="passNonProject" style="margin-left: 35%;" align="center">
		<div  role="alert">
			<span >Non Project SuccessFully Added..!</span>
	</div>
	</div>
	 
	<div id="failNonProject" style="margin-left: 35%;"  align="center">
		<div  role="alert">
			<span >Non Project Added UnSuccessful..!</span>
	</div>
	</div>
	
	<div id="passOtherProject" style="margin-left: 35%;" align="center">
		<div  role="alert">
			<span >Other Project SuccessFully Added..!</span>
	</div>
	</div>
	 
	<div id="failOtherProject" style="margin-left: 35%;"  align="center">
		<div  role="alert">
			<span >Other Project Added UnSuccessful..!</span>
	</div>
	</div>
	
	
	<div class="container-fluid datatables" id="received-main-div">
		<div class="row" style="margin-top: 0px; margin-bottom: 5px;">

			<div class="col-md-12">

				<div class="card shadow-nohover">
					<div class="card-body">
						<form action="DakAddSubmit.htm" method="POST" id="ReceivedDakForm"
							enctype="multipart/form-data">
							<div class="row">
								<div class="col-sm-2" align="left">
									<div class="form-group">
										<label class="control-label ">DAK Type<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="DakDeliveryId" name="DakDeliveryId" data-live-search="true" required="required">
											<%
											if (dakDeliveryList != null && dakDeliveryList.size() > 0) {
												for (Object[] obj : dakDeliveryList) {
											%>

											<option value=<%=obj[0]%> ><%=obj[1]%>
											</option>

											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">DAK Priority <span class="mandatory" style="color: red; font-weight: normal;">*</span></label> 
										<select class="form-control selectpicker custom-select" id="PriorityId" required="required" data-live-search="true" name="PriorityId">
											<%
											if (priorityList != null && priorityList.size() > 0) {
												for (Object[] obj : priorityList) {
											%>
											<option value=<%=obj[0]%>><%=obj[1]%></option>

											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">DAK Letter Type <span class="mandatory" style="color: red; font-weight: normal;">*</span></label> 
											<select class="form-control selectpicker custom-select" id="LetterId" required="required" data-live-search="true" name="LetterId">
											<%
											if (letterList != null && letterList.size() > 0) {
												for (Object[] obj : letterList) {
											%>
											<option value=<%=obj[0]%>><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Source Type <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="sourceid" required="required" data-live-search="true" name="SourceId">
											<%
											if (sourceList != null && sourceList.size() > 0) {
												for (Object[] obj : sourceList) {
											%>
											<option value=<%=obj[0]%>><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Source <span
											class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="SourceType" name="SourceType" data-live-search="true" required="required">
										</select>
									</div>
								</div>


							</div>
							<div class="row">
								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Receipt Date <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" name="ReceiptDate" style="font-size: 15px;" id="ReceiptDate" required="required">
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Ref No <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" type="text" id="RefNo" name="RefNo" style="font-size: 15px;" required="required" />
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Ref No Dated<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" name="RefDate" style="font-size: 15px;" id="RefDate" required="required">
									</div>
								</div>


								<div class="col-md-2" id="nonprojtype">
									<div class="form-group">
										<label class="control-label">Non-Project/Project<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="RelaventId" required="required" data-live-search="true" name="ProjectType" onchange="changeProject()">
											<option value="N">Non-Project</option>
											<option value="P">Project</option>
											<option value="O">Project (Others)</option>
										</select>
									</div>
								</div>
								
								<div class="col-md-4" id="prodiv1">
									<div class="form-group">
										<label class="control-label" id="proname1">Project Type<span class="mandatory" style="color: red; font-weight: normal;">*</span></label> 
										<select class="form-control selectpicker custom-select" id="ProId1" data-live-search="true" name="ProId">
											<%-- option appended through ajax--%>
										</select>
									</div>
								</div>

								<div class="col-md-4" hidden="true" id="prodiv">
									<div class="form-group">
										<label class="control-label" id="proname">Project Type<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control select " id="ProId" 
										onchange = "return projectDirectorAutoSelect()"
										data-live-search="true" data-live-search="true" name="ProId">
											<%
											if (relaventList != null && relaventList.size() > 0) {
												for (Object[] obj : relaventList) {
											%>
											<option value=<%=obj[0]%>><%=obj[1] + " - " + obj[2]%></option>
											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-4" hidden="true" id="prodiv2">
									<div class="form-group">
										<label class="control-label" id="proname2">Project Type<span class="mandatory"style="color: red; font-weight: normal;">*</span></label>
										 <select class="form-control selectpicker custom-select" id="ProId2"data-live-search="true" name="ProId">
													<%-- options appended through ajax--%>
										</select>
									</div>
								</div>
							</div>
							<div class="row">

								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label">Subject <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" type="text" name="Subject" id="SubjectVal" maxlength="300" style="font-size: 15px;" required="required">
								 	</div>
								 </div>

								 <div class="col-md-2">
									<div class="form-group">
									  	 <label class="control-label">Action Required <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										 <select class="form-control  custom-select selectpicker" onchange="changeFunc();" id="Action" required="required" name="ActionId">
										<%
											if (actionList != null && actionList.size() > 0) {
												for (Object[] obj : actionList) {
											%>
											<option value="<%=obj[0]%>#<%=obj[1]%>"><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>
								<div class="col-md-2 ActionDueDate">
									<div class="form-group">
										<label class="control-label">Action Due Date</label>
										<input class="form-control form-control" name="DueDate" style="font-size: 15px;" id="duedate" required="required">
									</div>
								</div>
								<div class="col-md-2 ActionTime">
									<div class="form-group">
										<label class="control-label">Action Due Time</label> <input type="text" class="form-control form-control" name="DueTime" value="<%=LocalTime.of(16, 30)%>" style="font-size: 15px;" id="DueTime" required="required">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Link DAK</label> 
										<select class="form-control selectpicker " style="overflow-x: auto;!important" id="DakLinkId" data-live-search="true" required="required" multiple="multiple" name="DakLinkId" onchange="handleSelectChange(this)">
											<option selected value="0">Not Applicable</option>
											<%
											if (linkList != null && linkList.size() > 0) {
												for (Object[] obj : linkList) {
													String Subject="";
													if(obj[2]!=null && obj[2].toString().trim()!=""){
														Subject = ", "+obj[2].toString();
													}
											%>

											<option id=<%="DakId" + obj[0]%> value=<%=obj[0]%>><%=obj[1].toString().trim()%><%=Subject.trim()%></option>

											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Keyword 1</label> <input class="form-control form-control" type="text" name="Key1" maxlength="100" style="font-size: 15px;" id="Key1">
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Keyword 2</label> <input class="form-control form-control" type="text" name="Key2" maxlength="100" style="font-size: 15px;" id="Key2">
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Keyword 3</label> <input class="form-control form-control" type="text" name="Key3" maxlength="100" style="font-size: 15px;" id="Key3">
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Keyword 4</label> <input class="form-control form-control" type="text" name="Key4" maxlength="100" style="font-size: 15px;" id="Key4">
									</div>
								</div>
							</div>
							<div class="row">

								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label">Brief on DAK</label> <input class="form-control form-control" type="text" name="Remarks" maxlength="1000" style="font-size: 15px;">
									</div>
								</div>
								<div class="col-md-3" >
									<div class="form-group">
										<label class="control-label">Signatory </label> 
										<input class="form-control form-control" type="text" name="Signatory" maxlength="50" style="font-size: 15px;">
									</div>
								</div>
								
								
									<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Closing Authority<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="ClosingAuthorityInitId" required="required" data-live-search="true" name="closingAuthorityVal">
											<option value="select" disabled="disabled" selected>Select</option>
											<option value="P">P&C DO</option>
											<option value="K">D-KRM</option>
											<option value="A">D-Adm</option>
											<option value="R">DFMM</option>
											<option value="Q">DQA</option>
											<option value="O">Others</option>
										</select>
									</div>
								</div>
									
									
								
		
								
								 <div class="col-md-1"><br>
										<!-- <label class="control-label" style="font-size: 15px;">Document :</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
										<button type="button" class="btn btn-sm icon-btn" data-toggle="tooltip" onclick="uploadDoc()" 
										style="padding:8px;" data-placement="top" title="Attach" data-target="#exampleModalCenter">
							  	<img alt="attach" src="view/images/attach.png" style="float:left;">
							</button>
								</div> 
							</div>
							<hr>
							<div class="row">
							<div class="col-md-6">
									<div align="left">
										<h6 style="text-decoration: underline;">
											<b>Group Marking</b>
										</h6>
									</div>
									<div align="right">
									<label style="margin-left: 30px;">Grouping </label>
									&nbsp;&nbsp;&nbsp;
									<select class="form-control selectpicker  Groupname "  multiple="multiple"  id="Groupname" style="width: 20%; " data-live-search="true" name="groupname[]" >
									<%
											if (DakMemberGroup != null && DakMemberGroup.size() > 0) {
												for (Object[] obj : DakMemberGroup) {
									%>
										<option	value=<%=obj[0].toString()%>><%=obj[1].toString()%></option>
											<%}}%>
									</select> </div>	
										<hr>
									<div align="left">
										<h6 style="text-decoration: underline; ">
											<b>Individual Marking</b>
										</h6>
									</div><br>
									<select  class="form-control selectpicker  individual " multiple="multiple" id="individual" name="individual[]" data-live-search="true">
										<%
										if (DakMembers != null && DakMembers.size() > 0) {
											for (Object[] obj : DakMembers) {
										%>
								        <option value=<%=obj[0].toString()%>><%=obj[1].toString()%></option>
									    <%}}%>
										<option value="0">Individual</option>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<select   onchange='addEmpToSelect()' class="form-control selectpicker empidSelect dropup" multiple="multiple" data-dropup-auto="true"  id="empidSelect" name="empid" data-live-search="true">
										</select> 
								</div>
							
								<div class="col-md-6">
									
									<div class="row">
									<div  class="col-md-12">
										<div class="card" id="scrollable-content" style="width: 100%; height: 100px; ">
										<div class="card-body">
											<input type="hidden" name="EmpIdGroup" id="EmpIdGroup" value="" />
										<div class="row" id="GroupEmp"style="" >
									
	  	      									</div>
										</div> 
										</div>
									</div></div><br><br>
									<div class="row">
									 <div  class="col-md-12">
										<div class="card" id="scrollable-contentind" style="width: 100%;   margin-top:-10px; height: 100px; ">
										<div class="card-body">
										<div class="row" id="IndEmp" style="">
										<input type="hidden" name="EmpIdIndividual" id="EmpIdIndividual" value="" />
	  	      									</div>
										</div> 
										</div>
									</div>
									</div>
								</div>
							</div>
							<!--(Start) If Project Type P selected only then show this div otherwise hide -->
							<div class="row" style="margin-top:-2rem;display:none;" id="projectDirectorSelected">
							<div class="col-md-6">
							<div class="form-group">
							<label class="control-label">Project Director </label> 
							<input type="hidden" name="projectDirectorEmpId" id="projectDirEmpIdVal" value="">
                            <input class="form-control form-control" type="text" id="projectDirEmpName" readonly="readonly" style="font-size: 15px;background-color: white;width:300px;">
							</div>
							</div>
							</div>
							<!--(End)-->
							<hr>
							<!-- <div id="NotattachedDocs" style="color:orange;"> Note : File Not Attached </div>
							<div id="attachedDocs" style="color:green;"> Note : File  Attached </div> -->
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div align="center">
								 <input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub" onclick="return DakInitSubmit()">
							</div>

							<%
							if (dakmail == null) {
							%>
							<input type="hidden" name="DakMailId" value="0">
							<%
							} else {
							%>
							<input type="hidden" name="DakMailId"
								value="<%=dakmail.getDakMailId()%>">
							<%
							}
							%>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />

							<div class="modal fade my-modal " id="exampleModalCenterAttach" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-body">

											<div class="tabsAttach">
												<div class="tabby-tabAttach">
													<input type="radio" id="tabAttach-1" name="tabby-tabsAttach"> <label for="tabAttach-1">Main Document</label>
													<div class="tabby-contentAttach">
														<div class="row">
															<div class="col-md-10">
																<input class="form-control" type="file" name="dak_document" id="dakdocument"  accept="*/*" >
															</div>
														</div>

														<br>
														<table
															class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtableAttach">
															<thead>
																<tr>
																	<th style="width: 5%;">SN</th>
																	<th style="width: 65%;">Item Name</th>
																	<th style="width: 20%;">Action</th>
																</tr>
															</thead>
															<tbody id="other-list-table">

															</tbody>
														</table>

														<input type="hidden" name="dakidvalue" id="dakidvalue"value="" /> 
														<input type="hidden" name="RefNo" id="RefNo" value="" /> 
														<input type="hidden" name="type" id="type" value="" /> 
												        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													</div>
												</div>

												<div class="tabby-tabAttach">
													<input type="radio" id="tabAttach-2"
														name="tabby-tabsAttach"> <label for="tabAttach-2">Enclosures</label>
													<div class="tabby-contentAttach">
														<div class="row">
															<div class="col-md-10 ">
																<table>
																	<tr>
																		<td></td>
																		<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents">
																				<i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px;"></i>
																			</button></td>
																	</tr>
																	<tr class="tr_clone">
																		<td><input class="form-control" type="file" name="dak_sub_document" id="dakdocument2" accept="*/*"></td>
																		<td><button type="button" class="tr_clone_sub btn btn-sm " data-toggle="tooltip" data-placement="top" title="Remove this Document">
																				<i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px;"> </i>
																			</button></td>
																	</tr>
																</table>
															</div>
														</div>
														<br>
														<table
															class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtableAttach">
															<thead>
																<tr>
																	<th style="width: 5%;">SN</th>
																	<th style="width: 65%;">Item Name</th>
																	<th style="width: 20%;">Action</th>
																</tr>
															</thead>
															<tbody id="other-list-table2">

															</tbody>
														</table>

														<input type="hidden" name="dakidvalue" id="dakidvalue2" value="" />
														<input type="hidden" name="RefNo" id="RefNo2" value="" />
														<input type="hidden" name="type" id="type2" value="" /> 
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													</div>
												</div>
												<div class="tabby-tabAttach">
													<input type="radio" id="tabAttach-3" name="tabby-tabsAttach" data-dismiss="modal" aria-label="Close"> <label for="tab-3">
													<button type="button" class="close" style="color: white;  margin-right: 10px;" onclick="attach()" data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												   </button></label>
													<div class="tabby-contentAttach"></div>
												</div>

											</div>
										</div>
										<div class="modal-footer" style="background-color: #114A86">
											<button type="button" class="btn btn-sm delete-btn" style="text-align: center; margin-right: 195px;" onclick="attach()" data-dismiss="modal">CLOSE</button>
										</div>
									</div>
								</div>
							</div>

							<div class="modal fade bd-example-modal-lg"	id="exampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true">
								<div class="modal-dialog modal-lg modal-dialog-centered" style="min-width: 85% !important; min-height: 80% !important;">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLongTitle">
												<b>Content</b>
											</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<div id="contentModal" style="word-wrap: break-word;">
											</div>
										</div>
										<div class="modal-footer"></div>
									</div>
								</div>
							</div>
							
						</form>
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

<!--------------------------------------------------------Non-Project Modal start--------------------------------------------->

<div class="modal fade" id="modalNonProject" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content" style="height: 250px; border:black 1px solid; ">
      <div class="modal-header" style="background-color: #005C97;">
        <h5 class="modal-title" style="color:white;"><b>Add Non-Project</b></h5>
        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div><br>
      <div class="col-md-12">
                		<div class="row">
                   
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Non-Project Short Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="NonShortName" type="text"  name="ShortName" required="required" maxlength="20" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Non-Project Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="NonProjectName" type="text" name="NonProjectName" required="required"  maxlength="100" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                		</div>
                		<div class="col-md-12" align="center" style="margin-top: 2.4rem">
	 						     <input type="button" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="addNonProject()" > 
                    		</div>
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!---------------------------------------------------------Non-Project Modal Ends--------------------------------------------->


<!--------------------------------------------------------Other-Project Modal start--------------------------------------------->

<div class="modal fade" id="modalotherproject" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content" style="height: 250px; border: black 1px solid; width: 100%;">
      <div class="modal-header" style="background-color: #005C97;">
        <h5 class="modal-title" style="color:white;" ><b>Add Other-Project</b></h5>
        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div><br>
      <div class="col-md-12">
      <form action="#" >
      <div class="row">
                		
                		    <div class="col-md-3">
                        		<div class="form-group">
                            		<label >Lab Code <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="LabCode" type="text" name="LabCode" required="required"  maxlength="20" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                            
                            <div class="col-md-3">
                        		<div class="form-group">
                            		<label >Project Code <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="ProjectCode" type="text"  name="ProjectCode" required="required" maxlength="20" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                           
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label >Project Short Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="OtherShortName" type="text"  name="ShortName" required="required" maxlength="20" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label >Project Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="OtherProjectName" type="text" name="OtherProjectName" required="required"  maxlength="100" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                		</div>
                		<div class="col-md-12" align="center" style="margin-top: 2.4rem">
	 						     <input type="button" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="addOtherProject()" > 
                    		</div>
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
      </form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!---------------------------------------------------------Other-Project Modal Ends--------------------------------------------->
							
					</div>
				</div>
			</div>
		</div>
	</div>


<div class="container-fluid datatables" id="sub-main-div" style="display: none;">
		<div class="row" style="margin-top: 0px; margin-bottom: 5px;">

			<div class="col-md-12" style="margin: auto;">

				<div class="card shadow-nohover">
					<div class="card-body">
						<form action="DakCreate.htm" method="POST" id="NewDakForm"
							enctype="multipart/form-data">
							<div class="row">
								<div class="col-sm-2" align="left">
									<div class="form-group">
							
										<label class="control-label ">DAK Type<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="NewDakDeliveryId" name="DakDeliveryId" data-live-search="true" required="required">
											<%if (dakDeliveryList != null && dakDeliveryList.size() > 0) {
												for (Object[] obj : dakDeliveryList) {
											%>
											<option value=<%=obj[0]%> ><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">DAK Priority <span class="mandatory" style="color: red; font-weight: normal;">*</span></label> 
										<select class="form-control selectpicker custom-select" id="NewPriorityId" required="required" data-live-search="true" name="PriorityId">
											<%if (priorityList != null && priorityList.size() > 0) {
												for (Object[] obj : priorityList) {
											%>
											<option value=<%=obj[0]%>><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">DAK Letter Type <span class="mandatory" style="color: red; font-weight: normal;">*</span></label> 
											<select class="form-control selectpicker custom-select" id="NewLetterId" required="required" data-live-search="true" name="LetterId">
											<%if (letterList != null && letterList.size() > 0) {
												for (Object[] obj : letterList) {
											%>
											<option value=<%=obj[0]%>><%=obj[1]%></option>
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
											<option value=<%=obj[0]%>><%=obj[1]%></option>
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
										<input class="form-control form-control" name="ReceiptDate" style="font-size: 15px;" id="NewReceiptDate" required="required">
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Ref No <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" type="text" id="NewRefNo" name="RefNo" style="font-size: 15px;" required="required" />
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Ref No Dated<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" name="RefDate" style="font-size: 15px;" id="NewRefDate" required="required">
									</div>
								</div>
								 <div class="col-md-2">
									<div class="form-group">
									  	 <label class="control-label">Action Required <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										 <select class="form-control  custom-select selectpicker" onchange="newChangeFunc();" id="NewAction" required="required" name="ActionId">
										    <%if (actionList != null && actionList.size() > 0) {
												for (Object[] obj : actionList) {
											%>
											<option value="<%=obj[0]%>#<%=obj[1]%>"><%=obj[1]%></option>
											<%}}%>
										</select>
									</div>
								</div>
								<div class="col-md-2 NewActionDueDate">
									<div class="form-group">
										<label class="control-label">Action Due Date</label>
										<input class="form-control form-control" name="DueDate" style="font-size: 15px;" id="Newduedate" required="required">
									</div>
								</div>
								<div class="col-md-2 NewActionTime">
									<div class="form-group">
										<label class="control-label">Action Due Time</label> <input type="text" class="form-control form-control" name="DueTime" value="<%=LocalTime.of(16, 30)%>" style="font-size: 15px;" id="NewDueTime" required="required">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label class="control-label">Subject <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" type="text" name="Subject" id="NewSubjectVal" maxlength="300" style="font-size: 15px;" required="required">
								 	</div>
								 </div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Link DAK</label> 
										<select class="form-control selectpicker " style="overflow-x: auto;!important" id="NewDakLinkId" data-live-search="true" required="required" multiple="multiple" name="DakLinkId" onchange="NewHandleSelectChange(this)">
											<option selected value="0">Not Applicable</option>
											<%if (linkList != null && linkList.size() > 0) {
												for (Object[] obj : linkList) {
													String Subject="";
													if(obj[2]!=null && obj[2].toString().trim()!=""){
														Subject = ", "+obj[2].toString();
													}
											%>
											<option id=<%="DakId" + obj[0]%> value=<%=obj[0]%>><%=obj[1].toString().trim()%><%=Subject.trim()%></option>
											<%}}%>
										</select>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Keyword 1</label> <input class="form-control form-control" type="text" name="Key1" maxlength="100" style="font-size: 15px;" id="NewKey1">
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Keyword 2</label> <input class="form-control form-control" type="text" name="Key2" maxlength="100" style="font-size: 15px;" id="NewKey2">
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Keyword 3</label> <input class="form-control form-control" type="text" name="Key3" maxlength="100" style="font-size: 15px;" id="NewKey3">
									</div>
								</div>
								<div class="col-md-2 ">
									<div class="form-group">
										<label class="control-label">Keyword 4</label> <input class="form-control form-control" type="text" name="Key4" maxlength="100" style="font-size: 15px;" id="NewKey4">
									</div>
								</div>
							</div>
							<div class="row">

								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label">Brief on DAK</label> <input class="form-control form-control" type="text" name="Remarks" maxlength="1000" style="font-size: 15px;">
									</div>
								</div>
								<div class="col-md-3" >
									<div class="form-group">
										<label class="control-label">Signatory </label> 
										<input class="form-control form-control" type="text" name="Signatory" maxlength="50" style="font-size: 15px;">
									</div>
								</div>
								
								 <div class="col-md-2"><br>
										<label class="control-label" style="font-size: 15px;">Document :</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-sm icon-btn" data-toggle="tooltip" onclick="newuploadDoc()" 
										style="padding:8px;" data-placement="top" title="Attach" data-target="#exampleModalCenter">
							  	<img alt="attach" src="view/images/attach.png" style="float:left;">
							</button>
								</div> 
							</div>
							<div class="col-md-2" style="margin-top: 30px;">
									<div class="form-group">
										<label class="control-label">Self </label>
										<input type="radio" name="selfRequired" value="N" checked="checked" onclick="openEmployee('N')">&nbsp; No &nbsp;
										<input type="radio" name="selfRequired" value="Y" onclick="openEmployee('Y')">&nbsp; Yes 
									</div>
								</div>
							<div class="row" id="employeeListDrop" style="display: none;">
							<div class="col-md-6">
								<div class="form-group">
								<label class="control-label" style="margin-left: 15px;">Employee </label><br>
								<select onchange='newaddEmpToSelect()' class="form-control selectpicker newempidSelect dropdown" multiple="multiple" id="newempidSelect" name="newempid" data-container="body" data-dropup-auto="false" data-live-search="true">
											<%if (employeeList != null && employeeList.size() > 0) {
												for (Object[] obj : employeeList) {
											%>
											<option value=<%=obj[0]%>><%=obj[1].toString().trim()%>, <%=obj[2].toString()%></option>
											<%}}%>
								</select> 
								</div>
							</div>
								<div class="col-md-6">
									<div class="row">
									 <div  class="col-md-12">
										<div class="card" id="scrollable-contentind" style="width: 100%;   margin-top:-10px; height: 100px; ">
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
							<!-- <div id="NotattachedDocs" style="color:orange;"> Note : File Not Attached </div>
							<div id="attachedDocs" style="color:green;"> Note : File  Attached </div> -->
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" id="actionValue" name="action">
							<div align="center">
								  <!-- <input type="button" class="btn btn-primary btn-sm submit" id="NewSave" value="Save" onclick="return NewDakInitSubmit('save')"> -->
								 <input type="button" class="btn btn-primary btn-sm submit" id="NewSubmit" value="Forward" onclick="return NewDakInitSubmit('saveforward')">
							</div>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div class="modal fade my-modal " id="NewExampleModalCenterAttach" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-body">

											<div class="tabsAttach">
												<div class="tabby-tabAttach">
													<input type="radio" id="newtabAttach-1" name="tabby-tabsAttach"> <label for="newtabAttach-1">Main Document</label>
													<div class="tabby-contentAttach">
														<div class="row">
															<div class="col-md-10">
																<input class="form-control" type="file" name="dak_document" id="newdakdocument"  accept="*/*" >
															</div>
														</div>

														<br>
														<table
															class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover newdownloadtableAttach">
															<thead>
																<tr>
																	<th style="width: 5%;">SN</th>
																	<th style="width: 65%;">Item Name</th>
																	<th style="width: 20%;">Action</th>
																</tr>
															</thead>
															<tbody id="other-list-table">

															</tbody>
														</table>

														<input type="hidden" name="dakidvalue" id="dakidvalue"value="" /> 
														<input type="hidden" name="RefNo" id="RefNo" value="" /> 
														<input type="hidden" name="type" id="type" value="" /> 
												        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													</div>
												</div>

												<div class="tabby-tabAttach">
													<input type="radio" id="newtabAttach-2"
														name="tabby-tabsAttach"> <label for="newtabAttach-2">Enclosures</label>
													<div class="tabby-contentAttach">
														<div class="row">
															<div class="col-md-10 ">
																<table>
																	<tr>
																		<td></td>
																		<td align="right"><button type="button" class="new_tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents">
																				<i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px;"></i>
																			</button></td>
																	</tr>
																	<tr class="new_tr_clone">
																		<td><input class="form-control" type="file" name="dak_sub_document" id="newdakdocument2" accept="*/*"></td>
																		<td><button type="button" class="new_tr_clone_sub btn btn-sm " data-toggle="tooltip" data-placement="top" title="Remove this Document">
																				<i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px;"> </i>
																			</button></td>
																	</tr>
																</table>
															</div>
														</div>
														<br>
														<table
															class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover newdownloadtableAttach">
															<thead>
																<tr>
																	<th style="width: 5%;">SN</th>
																	<th style="width: 65%;">Item Name</th>
																	<th style="width: 20%;">Action</th>
																</tr>
															</thead>
															<tbody id="other-list-table2">

															</tbody>
														</table>

														<input type="hidden" name="dakidvalue" id="dakidvalue2" value="" />
														<input type="hidden" name="RefNo" id="RefNo2" value="" />
														<input type="hidden" name="type" id="type2" value="" /> 
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													</div>
												</div>
												<div class="tabby-tabAttach">
													<input type="radio" id="newtabAttach-3" name="tabby-tabsAttach" data-dismiss="modal" aria-label="Close"> <label for="tab-3">
													<button type="button" class="close" style="color: white;  margin-right: 10px;" onclick="newattach()" data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												   </button></label>
													<div class="tabby-contentAttach"></div>
												</div>

											</div>
										</div>
										<div class="modal-footer" style="background-color: #114A86">
											<button type="button" class="btn btn-sm delete-btn" style="text-align: center; margin-right: 195px;" onclick="newattach()" data-dismiss="modal">CLOSE</button>
										</div>
									</div>
								</div>
							</div>

							<div class="modal fade bd-example-modal-lg"	id="exampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true">
								<div class="modal-dialog modal-lg modal-dialog-centered" style="min-width: 85% !important; min-height: 80% !important;">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLongTitle">
												<b>Content</b>
											</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<div id="contentModal" style="word-wrap: break-word;">
											</div>
										</div>
										<div class="modal-footer"></div>
									</div>
								</div>
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>



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

var details=null;
function NewHandleSelectChange(selectElement) {
    var id= $('#NewDakLinkId').val();
  
   var selectedOptions = selectElement.selectedOptions;

   for (var i = 0; i < selectedOptions.length; i++) {
     var option = selectedOptions[i];
     var optionValue = option.value;

     if (optionValue !== '0') {
       var notApplicableOption = selectElement.querySelector('option[value="0"]');
       notApplicableOption.selected = false;
     }else{
    	 var notApplicableOption = selectElement.querySelector('option[value="0"]');
         notApplicableOption.selected = true;
     }
   } 
   details=view(id);
}

function view(id) {
	var temp=null;
	 for (var i = 0; i < id.length; i++) {
	        if (i === id.length - 1) {
	            temp = id[i];	
	           if(details<=id.length){
	        	   
	           Preview(id[i],id[i]); 
	        	   
	           }
	        }
	    }
	 count=id.length;

	return count;
}

function openTab(value) {
	if(value==='R'){
		$('#received-main-div').css('display', 'block');
		$('#sub-main-div').css('display', 'none');
	}else if(value==='N'){
		$('#received-main-div').css('display', 'none');
		$('#sub-main-div').css('display', 'block');
	}
	
}

function openEmployee(value) {
	if(value==='N'){
		$('#employeeListDrop').hide();
	}else if(value==='Y'){
		$('#employeeListDrop').show();
	}
}
</script>

<script>
function submitattach(){
		var res=confirm('Are You Sure To Submit ?');

		if(res){
			$('#attachform').submit();
		}else{
			event.preventDefault();
		}
	}

function attach(){
	var inputElement = document.getElementById('dakdocument2');
	if (inputElement.files.length > 0) {
		$('#attachedDocs').show();
		$('#NotattachedDocs').hide();
	    }
		
		}

	function uploadDoc(){
		
		$('#tabAttach-1').prop('checked',true);
		$('#exampleModalCenterAttach').modal('toggle');
		$('.downloadtableAttach').css('display','none');
		
			}
</script>



<script type="text/javascript">

$('#RefDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"startDate" : new Date(),
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#NewRefDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"startDate" : new Date(),
	"maxDate" : new Date(),
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
	<%if (dakmail != null) {%>
		"startDate" : new Date('<%=sdf.format(sdtf.parse(dakmail.getRecievedDate()))%>'),
	<%} else {%>
		"startDate" : new Date(),
	<%}%>
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#NewReceiptDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	<%if (dakmail != null) {%>
		"startDate" : new Date('<%=sdf.format(sdtf.parse(dakmail.getRecievedDate()))%>'),
	<%} else {%>
		"startDate" : new Date(),
	<%}%>
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$(document).ready(function() {
	var currentDate = new Date();
	  var weekAgo = new Date();
	  weekAgo.setDate(currentDate.getDate() - 7);
$('#duedate').daterangepicker({
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

$(document).ready(function() {
	var currentDate = new Date();
	  var weekAgo = new Date();
	  weekAgo.setDate(currentDate.getDate() - 7);
$('#Newduedate').daterangepicker({
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

function changeSource(){
	if($('#LetterFrom').val()=='E'){
		$('#sourcename').html('Source');
		$('#sourcediv').prop('hidden',false);
		$('#sourceid').prop('disabled',false);
		$('#sourcediv1').prop('hidden',true);
		$('#sourceid1').prop('disabled',true);
		$('.select').select('refresh');
	}else if($('#LetterFrom').val()=='I'){
		$('#sourcename1').html('Division');
		$('#sourcediv1').prop('hidden',false);
		$('#sourceid1').prop('disabled',false);
		$('#sourcediv').prop('hidden',true);
		$('#sourceid').prop('disabled',true);
		$('.select').select('refresh');
	}
}


function changeProject(){
	var hiddenElement = document.getElementById("projectDirectorSelected");

	if($('#RelaventId').val()=='N'){
		$('#proname1').html('<span>Project Type</span><span class="mandatory" style="color: red; font-weight: normal;">*</span>');
		$('#prodiv').prop('hidden',true);
		$('#ProId').prop('disabled',true);
		$('#prodiv1').prop('hidden',false);
		$('#prodiv2').prop('hidden',true);
		$('#ProId1').prop('disabled',false);
		$('#projectDirEmpIdVal').prop('disabled', true);
		hiddenElement.style.display = "none";
	}else if($('#RelaventId').val()=='P'){
		$('#proname').html('<span>Project Type</span><span class="mandatory" style="color: red; font-weight: normal;">*</span>');
		$('#prodiv1').prop('hidden',true);
		$('#ProId').prop('disabled',false);
		$('#prodiv').prop('hidden',false);
		$('#prodiv2').prop('hidden',true);
		$('#ProId1').prop('disabled',true);
		$('#ProId1').prop('disabled',true);
		$('#projectDirEmpIdVal').prop('disabled', false);
	    hiddenElement.style.display = "block";
	    projectDirectorAutoSelect();//call function projectDirectorAutoSelect onchange of project type to get First projects PrjDirector
	}else if($('#RelaventId').val()=='O'){
		$('#proname2').html('<span>Project Type</span><span class="mandatory" style="color: red; font-weight: normal;">*</span>');
		$('#prodiv1').prop('hidden',true);
		$('#prodiv').prop('hidden',true);
		$('#ProId').prop('disabled',true);
		$('#prodiv2').prop('hidden',false);
		$('#ProId1').prop('disabled',true);
		$('#projectDirEmpIdVal').prop('disabled', true);
		hiddenElement.style.display = "none";
	}
}
</script>

<script>
//call function projectDirectorAutoSelect onchange of projects to get PrjDirector

function projectDirectorAutoSelect() {
	
	
    var ProjectIdSel = document.getElementById("ProId").value;

    $('#projectDirEmpIdVal').empty();
    $('#projectDirEmpName').empty();
    
    $.ajax({
        type: "GET",
        url: "getProjectDetails.htm",
        data: {
            projectId: ProjectIdSel
        },
        datatype: 'json',
        success: function (result) {
            if (result != null && result != "") {
                var resultData = JSON.parse(result);

                if (resultData.length > 0) {
                    var data = resultData[0]; // Assuming you only get one row
                    $('#projectDirEmpIdVal').val(data[0]);
                    $('#projectDirEmpName').val(data[1]);
                    // Check if ProjectDirectorEmpId is not null
                   
                }
            }
        }
    });
} 

// so i will  use ProjectDirectorEmpId if its not null




</script>



	<script type="text/javascript">

function getContentExt(value){	
	$.ajax({
				type : "GET",
				url : "getMailExtContent.htm",
				data : {
					
					messageid: value
					
				},
				datatype : 'json',
				success : function(result) {
				var result = JSON.parse(result);
				
			    $('#contentModal').html(result);
			    $('body').css("filter", "blur(0.0px)");
			    $('body').css("pointer-events", "auto");
		        $('#main-div').show();
		        $('#spinner').hide();
			    $('#exampleModalReply').modal('toggle');
				}
			});

	}

function getContentInt(value){	
	$.ajax({
				type : "GET",
				url : "getMailContent.htm",
				data : {
					
					messageid: value
					
				},
				datatype : 'json',
				success : function(result) {
				var result = JSON.parse(result);
				
			    $('#contentModal').html(result);
			    $('body').css("filter", "blur(0.0px)");
			    $('body').css("pointer-events", "auto");
		        $('#main').show();
		        $('#spinner').hide();
			    $('#exampleModalReply').modal('toggle');
				}
			});

	}
	$(document).ready(function(){
	    $('.btnspin').click(function() {
	        $('body').css("filter", "blur(0.5px)");
	         $('body').css("pointer-events", "none");
	        $('#main-div').hide();
	        $('#spinner').show();
	       
	    });

	});
</script>
	<script>
$(document).ready(function(){	
	$("#sourceid").trigger("change");
	$("#pass").hide();
	$("#fail").hide();
	$("#passNonProject").hide();
	$("#failNonProject").hide();
	$("#passOtherProject").hide();
	$("#failOtherProject").hide();
	
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
</script>
<script>
$(document).ready(function(){	
	$("#RelaventId").trigger("change");
});
$("#RelaventId").change(function(){
	var RelaventId=$("#RelaventId").val();
   $.ajax({
			
			type : "GET",
			url : "getSelectNonProjectList.htm",
			data : {
				
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
          $('#ProId1').empty();
			
	        var addnew = "addnonproject";
			var $newOption = $("<option></option>")
			  .attr("value", addnew)
			  .text("Add New")
			  .css({
			    "background-color": "blue",
			    "color": "white",
			    // Add more styles as needed
			  });

			$('#ProId1').append($newOption);
			
			for(var c=0;c<consultVals.length;c++)
			{
				
				 $('#ProId1')
		         .append($("<option></option>")
		                    .attr("value", consultVals[c][0])
		                    .text(consultVals[c][1])); 
			}
			 $('#ProId1').selectpicker('refresh');
			 $('#ProId1 option:eq(1)').prop('selected', true);
			 $('#ProId1').selectpicker('refresh');
			}
});
});
</script>


<script>
$(document).ready(function(){	
	$("#RelaventId").trigger("change");
});
$("#RelaventId").change(function(){
	var RelaventId=$("#RelaventId").val();
   $.ajax({
			
			type : "GET",
			url : "getSelectOtehrProjectList.htm",
			data : {
				
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
          $('#ProId2').empty();
			
			var addnew = "addotherproject";
			var $newOption = $("<option></option>")
			  .attr("value", addnew)
			  .text("Add New")
			  .css({
			    "background-color": "blue",
			    "color": "white",
			    // Add more styles as needed
			  });

			$('#ProId2').append($newOption);
			
			
			for(var c=0;c<consultVals.length;c++)
			{
				
				 $('#ProId2')
		         .append($("<option></option>")
		                    .attr("value", consultVals[c][0])
		                    .text(consultVals[c][1])); 
			}
			 $('#ProId2').selectpicker('refresh');
			 $('#ProId2 option:eq(1)').prop('selected', true);
			 $('#ProId2').selectpicker('refresh');
			}
});
});
</script>

	<script>
$(document).ready(function(){
	$('.ActionDueDate').hide();
	$('.ActionTime').hide();
});
function changeFunc() {
    var select= document.getElementById("Action").value.trim();
    var splitValues = select.split("#"); 
    if(splitValues[1]=='ACTION'){
    	$('.ActionDueDate').show();
    	$('.ActionTime').show();
    }else{
    	$('.ActionDueDate').hide();
    	$('.ActionTime').hide();
    }};
    
$(document).ready(function(){
	$('.NewActionDueDate').hide();
	$('.NewActionTime').hide();
});
function newChangeFunc() {
    var select= document.getElementById("NewAction").value.trim();
    var splitValues = select.split("#"); 
    if(splitValues[1]=='ACTION'){
    	$('.NewActionDueDate').show();
    	$('.NewActionTime').show();
    }else{
    	$('.NewActionDueDate').hide();
    	$('.NewActionTime').hide();
    }};
</script>
<script type="text/javascript">
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
$(function() {
	   $('#NewDueTime').daterangepicker({
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
var details=null;
function handleSelectChange(selectElement) {
    var id= $('#DakLinkId').val();
  
   var selectedOptions = selectElement.selectedOptions;

   for (var i = 0; i < selectedOptions.length; i++) {
     var option = selectedOptions[i];
     var optionValue = option.value;

     if (optionValue !== '0') {
       var notApplicableOption = selectElement.querySelector('option[value="0"]');
       notApplicableOption.selected = false;
     }else{
    	 var notApplicableOption = selectElement.querySelector('option[value="0"]');
         notApplicableOption.selected = true;
     }
   } 
   details=view(id);
}

function view(id) {
	var temp=null;
	 for (var i = 0; i < id.length; i++) {
	        if (i === id.length - 1) {
	            temp = id[i];	
	           if(details<=id.length){
	        	   
	           Preview(id[i],id[i]); 
	        	   
	           }
	        }
	    }
	 count=id.length;

	return count;
}

</script>

<script type="text/javascript">

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
	
	
$('#ProId1').change(function(){
	var ProId1=document.getElementById("ProId1").value;
	  if(ProId1=='addnonproject'){ 
	  $('#modalNonProject').modal('show');
	  $("#ProId1").prop("selectedIndex", 0);
	  }
	  else{
		  $('#modalNonProject').modal('hide');
	  }
	});  
$('#ProId2').change(function(){
	var ProId2=document.getElementById("ProId2").value;
	  if(ProId2=='addotherproject'){ 
	  $('#modalotherproject').modal('show');
	  $("#ProId2").prop("selectedIndex", 0);
}
	  else{
		  $('#modalotherproject').modal('hide');
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

		 
		 function addNonProject(){
			 
			  var ShortName=$("#NonShortName").val();
			  var NonProjectName=$("#NonProjectName").val();
			 
			  if(ShortName==null || ShortName==='' || ShortName==="" || typeof(ShortName)=='undefined')
			  {
				  alert("Enter Non-Project Short Name..!");
				  $("#NonShortName").focus();
				  return false;
			  }
			  else if(NonProjectName==null || NonProjectName==='' || NonProjectName==="" || typeof(NonProjectName)=='undefined')
			  {
				  alert("Enter Non-Project Name..!");
				  $("#NonProjectName").focus();
				  return false;
			  }
			  else
				  {
				  var x=confirm("Are You Sure To Add ?");
				  if(x)
				  {
				  $.ajax({
					  type : "GET",
						url : "dakNonProjectAddSubmit.htm",
						data : {
							
							ShortName: ShortName,
							NonProjectName:NonProjectName
						},
						datatype : 'json',
						success : function(result) {
						var result = JSON.parse(result);
						if(result==1){
							$('#modalNonProject').modal('hide');
							$("#RelaventId").trigger("change");
							$("#passNonProject").addClass("alert alert-success");
							 $("#passNonProject").show();
							 setTimeout(function() {
							        $("#passNonProject").hide();
							      }, 2000);
							 $("#NonShortName").val("");
							 $("#NonProjectName").val(""); 
						}else{
							$('#modalNonProject').modal('hide');
							$("#RelaventId").trigger("change");
							$("#failNonProject").addClass("alert alert-danger");
							 $("#failNonProject").show();
							 setTimeout(function() {
							        $("#failNonProject").hide();
							      }, 2000);
							 $("#NonShortName").val("");	
							 $("#NonProjectName").val("");
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

		 
		 
		 function addOtherProject()
			{
			  var ShortName=$("#OtherShortName").val();   
			  var OtherProjectName=$("#OtherProjectName").val();   
			  var ProjectCode=$("#ProjectCode").val();
			  var LabCode=$("#LabCode").val();
			  
			 if(LabCode==null || LabCode==='' || LabCode==="" || typeof(LabCode)=='undefined')
			  {
				  alert("EnterLab Code..!");
				  $("#LabCode").focus();
				  return false;
			  }
			 else if(ProjectCode==null || ProjectCode==='' || ProjectCode==="" || typeof(ProjectCode)=='undefined')
			  {
				  alert("Enter Project Code..!");
				  $("#ProjectCode").focus();
				  return false;
			  }
			  else if(ShortName==null || ShortName==='' || ShortName==="" || typeof(ShortName)=='undefined')
			  {
				  alert("Enter Other Project Short Name..!");
				  $("#OtherShortName").focus();
				  return false;
			  }
			  else if(OtherProjectName==null || OtherProjectName==='' || OtherProjectName==="" || typeof(OtherProjectName)=='undefined')
			  {
				  alert("Enter Other-Project Name..!");
				  $("#OtherProjectName").focus();
				  return false;
			  }
			  else
			  {
				  var x=confirm("Are You Sure To Add ?");
				  if(x)
				  {
				  $.ajax({
					  type : "GET",
						url : "dakOtherProjectAddSubmit.htm",
						data : {
							
							ShortName: ShortName,
							OtherProjectName:OtherProjectName,
							ProjectCode:ProjectCode,
							LabCode:LabCode
							
						},
						datatype : 'json',
						success : function(result) {
						var result = JSON.parse(result);
						if(result==1){
							$('#modalotherproject').modal('hide');
							$("#RelaventId").trigger("change");
							$("#passOtherProject").addClass("alert alert-success");
							 $("#passOtherProject").show();
							 setTimeout(function() {
							        $("#passOtherProject").hide();
							      }, 2000);
							 $("#OtherShortName").val("");
							 $("#OtherProjectName").val("");
							 $("#ProjectCode").val("");
							 $("#LabCode").val("");
						}else{
							$('#modalotherproject').modal('hide');
							$("#RelaventId").trigger("change");
							$("#failOtherProject").addClass("alert alert-danger");
							 $("#failOtherProject").show();
							 setTimeout(function() {
							        $("#failOtherProject").hide();
							      }, 2000);
							 $("#OtherShortName").val("");	
							 $("#OtherProjectName").val("");
							 $("#ProjectCode").val("");
							 $("#LabCode").val("");
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

		 
</script>




<script>



$(document).ready(function(){	
	$("#Groupname").trigger("change");
});
$("#Groupname").change(function(){

	  var selGroupdIds = [];
	  $("select[name='groupname[]'] option:selected").each(function() { // Fix the selector here
		  selGroupdIds.push($(this).val());
	  });
	
	  $('#GroupEmp').empty();
	  
	    if (selGroupdIds.length === 0) {
	        // Clear data and perform necessary actions when no options are selected
	        $('#GroupEmp').empty();
	        $('#EmpIdGroup').val('');
	        return; // Exit the function
	    }

   $.ajax({
	   
			type : "GET",
			url : "getDakmemberGroupEmpList.htm",
			datatype : 'json',
			data : {
				
				  Group: selGroupdIds
				
			},
			
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
			var otherHTMLStr = '';
			var id='Employees';
			var count=1;
			var EmpId=[];
			
			for (var c = 0; c < consultVals.length; c++) {
			    var Temp = id + (c+1);
			    otherHTMLStr += '<span style="margin-left:2%" id="name_'+ Temp +'">'+count+'. '+' '+consultVals[c][1]+' , '+' '+ ' '+consultVals[c][2]+'</span><br>';
			    count++;
			    var str=consultVals[c][0]+'/'+consultVals[c][3];
			    EmpId.push(str); 
			}
			var id= $('#EmpIdGroup').val(EmpId);
			$('#GroupEmp').html(otherHTMLStr);
			}
			
});
});
</script>
<script type="text/javascript">
$(document).ready(function(){	
	
	
	$("#individual").trigger("change");
	
});

$("#individual").change(function(){
	  var value = [];
	  $("select[name='individual[]'] option:selected").each(function() { // Fix the selector here
		  value.push($(this).val());
		  });
	  
	  
	  $.ajax({
	    type: "GET",
	    url: "getSelectEmpList.htm",
	    data: {
	      empId: value
	    },
	    datatype: 'json',
	    success: function (result) {
	      var result = JSON.parse(result);
	      var consultVals = Object.keys(result).map(function (e) {
	        return result[e];
	      });

	      var selectedEmployees = [];
	      $("#empidSelect option:selected").each(function () {
	        selectedEmployees.push($(this).val().split(",")[0]);
	       
	      });
	      $('#empidSelect').empty();
		  
	      for (var c = 0; c < consultVals.length; c++) {
	    	  
	        var optionValue = consultVals[c][0] + '/' + consultVals[c][3];
	        var optionText = consultVals[c][1] + ', ' + consultVals[c][2];
	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
	        if (selectedEmployees.includes(optionValue.split(",")[0])) {
	          option.prop('selected', true);
	          
	        }
	        $('#empidSelect').append(option);
	        
	        
	        
	      }
	      $('.selectpicker').selectpicker('refresh');
	     
	    }
	  });
	});
	
	
function addEmpToSelect(){
    /* var selectedItem = $('#empidSelect').val(); */
    var options = $('#empidSelect option:selected');
	    var selected = [];
    var otherHTML = '';
	var id='indEmployees';
	var count=1;
    $(options).each(function(){
	    otherHTML += '<span style="margin-left:2%" id="id">'+count+'.  '+' '+$(this).text()+'</span><br>';
	    count++;
	    selected.push($(this).val());
    });
    $('#EmpIdIndividual').val(selected);
    $('#IndEmp').html(otherHTML);
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




function DakInitSubmit() {
	var shouldSubmit = true;
	const form =document.getElementById('ReceivedDakForm');
	var Action=$('#Action').val();
	console.log('Action',Action);
	var Source=$('#SourceType').val();
	var refno=$('#RefNo').val();
	var subject=$('#SubjectVal').val();
	var Project=$('#RelaventId').val();
	var ProjectType=$('#ProId').val();
	var NonProjectType=$('#ProId1').val();
	var OtherProjectType=$('#ProId2').val();
	  // Use jQuery to select the "Closing Authority" dropdown
    var closingAuthority = $("#ClosingAuthorityInitId").val();

    console.log('ClosingAuthority', closingAuthority);
	
	var ProjectId=null;
	if(Project==='N'){
		ProjectId=$('#ProId1').val();
	}else if(Project==='N'){
		ProjectId=$('#ProId').val();
	}else if(Project==='O'){
		ProjectId=$('#ProId2').val();
	}
	
	if(Source==null || Source==='' || Source==="" || typeof(Source)=='undefined' ||Source==0){
		alert("Please Select the Source..!");
		  $("#SourceType").focus();
		  shouldSubmit = false;
	}else if(refno==null || refno==='' || refno==="" || typeof(refno)=='undefined'){
		alert("Please Enter the RefNo..!");
		  $("#RefNo").focus();
		  shouldSubmit = false;	
	}else if(ProjectId!=null && ProjectId==='' || ProjectId==="" || typeof(ProjectId)=='undefined' ||ProjectId==0){
		alert("Please Select the Project Type..!");
		  $("#ProId1").focus();
		  shouldSubmit = false;
	}else if(subject==null || subject==='' || subject==="" || typeof(subject)=='undefined'){
		alert("Please Enter the Subject..!");
		  $("#Subject").focus();
		  shouldSubmit = false;
 	} else if (!Action.includes('RECORDS') && closingAuthority !== 'P' && closingAuthority !== 'O' && closingAuthority !== 'A' && closingAuthority !== 'K' && closingAuthority !== 'R') {
          alert("Please Select Closing Authority..!");
   		  $("#ClosingAuthorityInitId").focus();
  		  shouldSubmit = false; 
    }else{
		if(confirm('Are you Sure To Add ?')){
			  form.submit();/*submit the form */
		}
	}
}

function NewDakInitSubmit(action) {
	$('#actionValue').val(action);
	var shouldSubmit = true;
	const form =document.getElementById('NewDakForm');
	var Source=$('#DestinationType').val();
	var refno=$('#NewRefNo').val();
	var subject=$('#NewSubjectVal').val();
	
	if(Source==null || Source==='' || Source==="" || typeof(Source)=='undefined' ||Source==0){
		alert("Please Select the Destination..!");
		  $("#DestinationType").focus();
		  shouldSubmit = false;
	}else if(refno==null || refno==='' || refno==="" || typeof(refno)=='undefined'){
		alert("Please Enter the RefNo..!");
		  $("#NewRefNo").focus();
		  shouldSubmit = false;	
	}else if(subject==null || subject==='' || subject==="" || typeof(subject)=='undefined'){
		alert("Please Enter the Subject..!");
		  $("#NewSubject").focus();
		  shouldSubmit = false;
	}else{
		if(confirm('Are you Sure To Forward ?')){
			  form.submit();/*submit the form */
		}
	}
}

$(document).ready(function(){	
	$("#DestinationId").trigger("change");
	$("#pass").hide();
	$("#fail").hide();
});
$("#DestinationId").change(function(){
	var SourceId=$("#DestinationId").val();
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
          $('#DestinationType').empty();
			
			for(var c=0;c<consultVals.length;c++)
			{
				
				 $('#DestinationType')
		         .append($("<option></option>")
		                    .attr("value", consultVals[c][0]+'-'+consultVals[c][4]+'-'+consultVals[c][5]+'-'+consultVals[c][6])
		                    .text(consultVals[c][3]+' - '+consultVals[c][2])); 
			}
			 $('#DestinationType').selectpicker('refresh');
			}
});
});

$('#DestinationType').change(function(){
	  var SourceType=document.getElementById("DestinationType").value;
	  if(SourceType=='addnew'){ 
	  $('#modalsource').modal('show');
	  $("#DestinationType").prop("selectedIndex", 0);
    }
	  else{
		  $('#modalsource').modal('hide');
	  }
	});  
	
var count=1;
$("table").on('click','.new_tr_clone_addbtn' ,function() {
   var $tr = $('.new_tr_clone').last('.new_tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.new_tr_clone_sub' ,function() {
	
var cl=$('.new_tr_clone').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.new_tr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});

function newsubmitattach(){
		var res=confirm('Are You Sure To Submit ?');

		if(res){
			$('#newattachform').submit();
		}else{
			event.preventDefault();
		}
	}

function newattach(){
	var inputElement = document.getElementById('newdakdocument2');
	if (inputElement.files.length > 0) {
		$('#newattachedDocs').show();
		$('#newNotattachedDocs').hide();
	    }
}

function newuploadDoc(){
	$('#newtabAttach-1').prop('checked',true);
	$('#NewExampleModalCenterAttach').modal('toggle');
	$('.newdownloadtableAttach').css('display','none');
	
}
</script>
</body>
</html>