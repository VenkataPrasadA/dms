<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>ENOTE RoSo Add</title>
<style type="text/css">
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
<%
List<Object[]> EmployeeListForEnoteRoSo=(List<Object[]>)request.getAttribute("EmployeeListForEnoteRoSo");
List<Object[]> InitiatedEmpList=(List<Object[]>)request.getAttribute("InitiatedEmpList");
List<Object[]> LabList=(List<Object[]>)request.getAttribute("LabList");
 %>

<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb"><h5 style="font-weight: 700 !important">e Note RoSo Add</h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteDashBoard.htm"><i class="fa fa-envelope"></i> e Note </a></li>
						<li class="breadcrumb-item"><a href="DakEnoteRoSoList.htm"><i class="fa fa-envelope"></i> e Note RoSo List</a></li>
						<li class="breadcrumb-item active">e Note RoSo Add</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	<div class="card" style="width: 99%">
	<div class="card-body" align="center" >	
	<form action="InitiateOfficerAddSubmit.htm" id="myform" method="POST" data-action="InitiateOfficerAddSubmit.htm">	
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<div class="row">
	<div class="col-sm-4" align="left">
		<div class="form-group">
			<label class="control-label ">Initiated Employee<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<select class="form-control selectpicker custom-select" id="EmployeeId" name="EmployeeId" data-live-search="true" onchange="firstDropdownChange()" required="required">
				<option value="Select" >Select</option>
				<%
				if (InitiatedEmpList != null && InitiatedEmpList.size() > 0) {
					for (Object[] obj : InitiatedEmpList) {
				%>
				<option value=<%=obj[0].toString()%> ><%=obj[1].toString().trim()+", "+obj[3].toString()%>
				</option>

				<%}}%>
			</select>
			<div style="margin-top: 53%; width: 47%; margin-left: 53%;">
			<label class="control-label">Lab</label>
			<select class="form-control selectpicker custom-select" id="LabCode" name="LabCode" onchange="LabcodeSubmit()" data-live-search="true"  required="required">
			<option value="">Select</option>
				<%
				if (LabList != null && LabList.size() > 0) {
					for (Object[] obj : LabList) {
				%>
				<option value=<%=obj[2].toString()%> ><%=obj[2].toString()%></option>
				<%}}%>
				<option value="@EXP">Expert</option>
			</select>
			</div>
		</div>
	  </div>
	  <div class="col-sm-4" align="left">
		<div class="form-group">
			<label class="control-label ">Recommending-Officer1<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<select class="form-control selectpicker custom-select" id="RecommendOfficer1"  name="RecommendOfficer1" onchange="secondDropdownChange()" data-live-search="true" required="required">
			</select>
			<label class="control-label ">Recommending-Officer2</label>
			<select class="form-control selectpicker custom-select" id="RecommendOfficer2" name="RecommendOfficer2" onchange="thirdDropdownChange()"  data-live-search="true" required="required">
			</select>
			<label class="control-label ">Recommending-Officer3</label>
			<select class="form-control selectpicker custom-select" id="RecommendOfficer3" name="RecommendOfficer3" onchange="fourthDropdownChange()"  data-live-search="true" required="required">
			</select>
			<label class="control-label ">Recommending-Officer4</label>
			<select class="form-control selectpicker custom-select" id="RecommendOfficer4" name="RecommendOfficer4" onchange="fifthDropdownChange()" data-live-search="true"  required="required">
			</select>
			<label class="control-label ">Recommending-Officer5</label>
			<select class="form-control selectpicker custom-select" id="RecommendOfficer5" name="RecommendOfficer5" onchange="SixthDropdownChange()" data-live-search="true"  required="required">
			</select>
			<label class="control-label ">External-Officer</label>
			<select class="form-control selectpicker custom-select" id="ExternalOfficer" name="ExternalOfficer"  data-live-search="true"  required="required">
			</select>
			<label class="control-label ">Approving-Officer<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<select class="form-control selectpicker custom-select" id="SanctionOfficer" name="SanctionOfficer"  data-live-search="true"  required="required">
			</select>
		</div>
	  </div>
	  <div class="col-sm-4" align="left">
		<div class="form-group">
		<label class="control-label ">Recommending-Officer1_Role<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
		<input class="form-control" type="text" name="RO1_Role" id="RO1_Role" >
		<label class="control-label ">Recommending-Officer2_Role</label>
		<input class="form-control" type="text"  name="RO2_Role" id="RO2_Role">
		<label class="control-label ">Recommending-Officer3_Role</label>
		<input class="form-control" type="text"  name="RO3_Role" id="RO3_Role">
		<label class="control-label ">Recommending-Officer4_Role</label>
		<input class="form-control" type="text"  name="RO4_Role" id="RO4_Role">
		<label class="control-label ">Recommending-Officer5_Role</label>
		<input class="form-control" type="text" name="RO5_Role" id="RO5_Role">
		<label class="control-label ">External-Officer_Role</label>
		<input class="form-control" type="text" name="EO_Role" id="EO_Role">
		<label class="control-label ">Approving Officer_Role<span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
		<input class="form-control" type="text" name="SO_Role" id="SO_Role">	
			
		</div>
	  </div>
	</div>
	<div align="center">
		<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub" onclick="return EnoteRoSoSubmit()">
	</div>
	
  </form>
</div>
</div>
</body>
<script type="text/javascript">

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
            if (result != null && LabCode!='Expert') {
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
                        var optionValue = 'Expert';
                        var optionText = data[1].trim() + ", " + data[3]; 
                        var option = $("<option></option>").attr("value", optionValue).text(optionText);
                        $('#ExternalOfficer').append(option); 
                    }
                    $('#ExternalOfficer').selectpicker('refresh');
                }
            }
    });
}

function firstDropdownChange() {
    var selectedValue = document.getElementById("EmployeeId").value;
    $('#RecommendOfficer1').empty();
    var defaultOption = $("<option></option>").attr("value", "Select").text("Select");
    $('#RecommendOfficer1').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer1').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer1').selectpicker('refresh');
 
 <!-------------------------------- ********************************************************** ------------------->
 
    $('#RecommendOfficer2').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer2').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue ) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer2').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer2').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#RecommendOfficer3').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer3').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue ) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer3').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer3').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#RecommendOfficer4').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer4').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue ) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer4').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer4').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#RecommendOfficer5').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer5').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue ) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer5').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer5').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#SanctionOfficer').empty();
    var defaultOption = $("<option></option>").attr("value", "Select").text("Select");
    $('#SanctionOfficer').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue ) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctionOfficer').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctionOfficer').selectpicker('refresh');
}


function secondDropdownChange() {
    var selectedValue = document.getElementById("EmployeeId").value;
    var selectedValue2 = document.getElementById("RecommendOfficer1").value;
    
    $('#RecommendOfficer2').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer2').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer2').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer2').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    
    $('#RecommendOfficer3').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer3').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer3').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer3').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    
    $('#RecommendOfficer4').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer4').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer4').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer4').selectpicker('refresh');
 
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#RecommendOfficer5').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer5').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer5').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer5').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#SanctionOfficer').empty();
    var defaultOption = $("<option></option>").attr("value", "Select").text("Select");
    $('#SanctionOfficer').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctionOfficer').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctionOfficer').selectpicker('refresh');

}

function thirdDropdownChange() {
    var selectedValue = document.getElementById("EmployeeId").value;
    var selectedValue2 = document.getElementById("RecommendOfficer1").value;
    var selectedValue3 = document.getElementById("RecommendOfficer2").value;
    
    $('#RecommendOfficer3').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer3').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer3').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer3').selectpicker('refresh');
 
 
    <!-------------------------------- ********************************************************** ------------------->
    
    
    $('#RecommendOfficer4').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer4').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer4').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer4').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#RecommendOfficer5').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer5').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer5').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer5').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#SanctionOfficer').empty();
    var defaultOption = $("<option></option>").attr("value", "Select").text("Select");
    $('#SanctionOfficer').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctionOfficer').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctionOfficer').selectpicker('refresh');

}


function thirdDropdownChange() {
    var selectedValue = document.getElementById("EmployeeId").value;
    var selectedValue2 = document.getElementById("RecommendOfficer1").value;
    var selectedValue3 = document.getElementById("RecommendOfficer2").value;
    
    $('#RecommendOfficer3').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer3').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer3').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer3').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    
    $('#RecommendOfficer4').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer4').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer4').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer4').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    
    $('#RecommendOfficer5').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer5').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer5').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer5').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    
    $('#SanctionOfficer').empty();
    var defaultOption = $("<option></option>").attr("value", "Select").text("Select");
    $('#SanctionOfficer').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctionOfficer').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctionOfficer').selectpicker('refresh');

}

function fourthDropdownChange() {
    var selectedValue = document.getElementById("EmployeeId").value;
    var selectedValue2 = document.getElementById("RecommendOfficer1").value;
    var selectedValue3 = document.getElementById("RecommendOfficer2").value;
    var selectedValue4 = document.getElementById("RecommendOfficer3").value;
    
    $('#RecommendOfficer4').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer4').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3 && optionValue !== selectedValue4) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer4').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer4').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    
    $('#RecommendOfficer5').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer5').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3 && optionValue !== selectedValue4) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer5').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer5').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#SanctionOfficer').empty();
    var defaultOption = $("<option></option>").attr("value", "Select").text("Select");
    $('#SanctionOfficer').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3 && optionValue !== selectedValue4) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctionOfficer').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctionOfficer').selectpicker('refresh');

}

function fifthDropdownChange() {
    var selectedValue = document.getElementById("EmployeeId").value;
    var selectedValue2 = document.getElementById("RecommendOfficer1").value;
    var selectedValue3 = document.getElementById("RecommendOfficer2").value;
    var selectedValue4 = document.getElementById("RecommendOfficer3").value;
    var selectedValue5 = document.getElementById("RecommendOfficer4").value;
    
    $('#RecommendOfficer5').empty();
    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendOfficer5').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3 && optionValue !== selectedValue4 && optionValue !== selectedValue5) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendOfficer5').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendOfficer5').selectpicker('refresh');
 
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#SanctionOfficer').empty();
    var defaultOption = $("<option></option>").attr("value", "Select").text("Select");
    $('#SanctionOfficer').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3 && optionValue !== selectedValue4 && optionValue !== selectedValue5) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctionOfficer').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctionOfficer').selectpicker('refresh');

}

function SixthDropdownChange() {
    var selectedValue = document.getElementById("EmployeeId").value;
    var selectedValue2 = document.getElementById("RecommendOfficer1").value;
    var selectedValue3 = document.getElementById("RecommendOfficer2").value;
    var selectedValue4 = document.getElementById("RecommendOfficer3").value;
    var selectedValue5 = document.getElementById("RecommendOfficer4").value;
    var selectedValue6 = document.getElementById("RecommendOfficer5").value;
    
    <!-------------------------------- ********************************************************** ------------------->
    
    $('#SanctionOfficer').empty();
    var defaultOption = $("<option></option>").attr("value", "Select").text("Select");
    $('#SanctionOfficer').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3 && optionValue !== selectedValue4 && optionValue !== selectedValue5 && optionValue !== selectedValue6) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctionOfficer').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctionOfficer').selectpicker('refresh');

}

function SevenDropdownChange() {
    var selectedValue = document.getElementById("EmployeeId").value;
    var selectedValue2 = document.getElementById("RecommendOfficer1").value;
    var selectedValue3 = document.getElementById("RecommendOfficer2").value;
    var selectedValue4 = document.getElementById("RecommendOfficer3").value;
    var selectedValue5 = document.getElementById("RecommendOfficer4").value;
    var selectedValue6 = document.getElementById("RecommendOfficer5").value;
    var selectedValue7 = document.getElementById("ExternalOfficer").value;

    $('#SanctionOfficer').empty();
    var defaultOption = $("<option></option>").attr("value", "Select").text("Select");
    $('#SanctionOfficer').append(defaultOption);
    <% for (Object[] type : EmployeeListForEnoteRoSo) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[3] %>';
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3 && optionValue !== selectedValue4  && optionValue !== selectedValue5 && optionValue !== selectedValue6 && optionValue !== selectedValue7) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctionOfficer').append(option);
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctionOfficer').selectpicker('refresh');

}

function EnoteRoSoSubmit() {
	var shouldSubmit = true;
	var InitiatedEmp=$('#EmployeeId').val();
	var RecommendOfficer1=$('#RecommendOfficer1').val();
	var SanctionOfficer=$('#SanctionOfficer').val();
	var RO1_Role=$('#RO1_Role').val();
	var SanctionOfficerRole=$('#SO_Role').val();
	
	if(InitiatedEmp==null || InitiatedEmp=== '' || InitiatedEmp===" " || typeof(InitiatedEmp)=='undefined' || InitiatedEmp==='Select'){
		alert("Please Select the Initiated Employee ...!")
		$("#EmployeeId").focus();
		shouldSubmit=false;
	}else if (RecommendOfficer1==null || RecommendOfficer1==='' || RecommendOfficer1===" " || typeof(RecommendOfficer1)=='undefined' || RecommendOfficer1=='Select'){
		alert("Please Select the Recommending-Officer1 ...!")
		$("#RecommendOfficer1").focus();
		shouldSubmit=false;
	}else if(SanctionOfficer==null || SanctionOfficer==='' || SanctionOfficer===" " || typeof(SanctionOfficer)=='undefined' || SanctionOfficer=='Select'){
		alert("Please Select the Sanctioning Officer ...!")
		$("#SanctionOfficer").focus();
		shouldSubmit=false;
	}else if(RO1_Role==null || RO1_Role==='' || typeof(RO1_Role)=='undefined' || RO1_Role===" "){
		alert("Please Enter Recommending-Officer1 Role...!")
		$("#RO1_Role").focus();
		shouldSubmit=false;
	}else if(SanctionOfficerRole==null || SanctionOfficerRole==='' || SanctionOfficerRole===" " || typeof(SanctionOfficerRole)=='undefined'){
		alert("Please Enter Sanction-Officer Role...!")
		$("#SO_Role").focus();
		shouldSubmit=false;
	}else{
		var formAction = $('#myform').data('action');
		if(confirm('Are you Sure To Submit ?')){
			  $('#myform').attr('action', formAction);
	          $('#myform').submit(); /* submit the form */
	}
	}
}
</script>
</html>