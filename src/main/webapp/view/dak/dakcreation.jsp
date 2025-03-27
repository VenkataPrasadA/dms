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
<title>DAK DG Init</title>
<jsp:include page="../static/header.jsp"></jsp:include>
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
				<h5 style="font-weight: 700 !important">DAK Create</h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a
							href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="DakDashBoard.htm"><i
								class="fa fa-envelope"></i> DAK</a></li>
						<li class="breadcrumb-item active">DAK Create</li>
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
	List<Object[]> linkList = (List<Object[]>) request.getAttribute("linkList");
	List<Object[]> actionList = (List<Object[]>) request.getAttribute("actionList");
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
	<%}%>
	
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
	
	
	<div class="container-fluid datatables" id="main-div">
		<div class="row" style="margin-top: 0px; margin-bottom: 5px;">

			<div class="col-md-10" style="margin: auto;">

				<div class="card shadow-nohover">
					<div class="card-body">
						<form action="DakCreate.htm" method="POST" id="DakForm"
							enctype="multipart/form-data">
							<div class="row">
								<div class="col-sm-2" align="left">
									<div class="form-group">
							
										<label class="control-label ">DAK Type<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<select class="form-control selectpicker custom-select" id="DakDeliveryId" name="DakDeliveryId" data-live-search="true" required="required">
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
										<select class="form-control selectpicker custom-select" id="PriorityId" required="required" data-live-search="true" name="PriorityId">
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
											<select class="form-control selectpicker custom-select" id="LetterId" required="required" data-live-search="true" name="LetterId">
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
								 <div class="col-md-2">
									<div class="form-group">
									  	 <label class="control-label">Action Required <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										 <select class="form-control  custom-select selectpicker" onchange="changeFunc();" id="Action" required="required" name="ActionId">
										    <%if (actionList != null && actionList.size() > 0) {
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
								<div class="col-md-12">
									<div class="form-group">
										<label class="control-label">Subject <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
										<input class="form-control form-control" type="text" name="Subject" id="SubjectVal" maxlength="300" style="font-size: 15px;" required="required">
								 	</div>
								 </div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Link DAK</label> 
										<select class="form-control selectpicker " style="overflow-x: auto;!important" id="DakLinkId" data-live-search="true" required="required" multiple="multiple" name="DakLinkId" onchange="handleSelectChange(this)">
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
								
								 <div class="col-md-2"><br>
										<label class="control-label" style="font-size: 15px;">Document :</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-sm icon-btn" data-toggle="tooltip" onclick="uploadDoc()" 
										style="padding:8px;" data-placement="top" title="Attach" data-target="#exampleModalCenter">
							  	<img alt="attach" src="view/images/attach.png" style="float:left;">
							</button>
								</div> 
							</div><br>
							<!-- <div id="NotattachedDocs" style="color:orange;"> Note : File Not Attached </div>
							<div id="attachedDocs" style="color:green;"> Note : File  Attached </div> -->
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" id="actionValue" name="action">
							<div align="center">
								 <input type="button" class="btn btn-primary btn-sm submit" id="Save" value="Save" onclick="return DakInitSubmit('save')">
								 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								 <input type="button" class="btn btn-primary btn-sm submit" id="Submit" value="Save & Forward" onclick="return DakInitSubmit('saveforward')">
							</div>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
$('#ReceiptDate').daterangepicker({
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

$(document).ready(function(){
    $('.btnspin').click(function() {
        $('body').css("filter", "blur(0.5px)");
         $('body').css("pointer-events", "none");
        $('#main-div').hide();
        $('#spinner').show();
       
    });

});

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
</script>
<script type="text/javascript">
function DakInitSubmit(action) {
	$('#actionValue').val(action);
	var shouldSubmit = true;
	const form =document.getElementById('DakForm');
	var Source=$('#DestinationType').val();
	var refno=$('#RefNo').val();
	var subject=$('#SubjectVal').val();
	
	if(Source==null || Source==='' || Source==="" || typeof(Source)=='undefined' ||Source==0){
		alert("Please Select the Destination..!");
		  $("#DestinationType").focus();
		  shouldSubmit = false;
	}else if(refno==null || refno==='' || refno==="" || typeof(refno)=='undefined'){
		alert("Please Enter the RefNo..!");
		  $("#RefNo").focus();
		  shouldSubmit = false;	
	}else if(subject==null || subject==='' || subject==="" || typeof(subject)=='undefined'){
		alert("Please Enter the Subject..!");
		  $("#Subject").focus();
		  shouldSubmit = false;
	}else{
		if(confirm('Are you Sure To Add ?')){
			  form.submit();/*submit the form */
		}
	}
}
</script>
</body>
</html>