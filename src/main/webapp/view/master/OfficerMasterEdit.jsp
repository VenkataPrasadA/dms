<%@page import="com.vts.dms.master.model.Employee" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>OFFICER MASTER EDIT</title>
<style>
.table thead tr th {
	background-color: aliceblue;
	text-align: left;
	width:30%;
}

.table thead tr td {
	background-color: #f9fae1;
	text-align: left;
}

label{
	font-size: 15px;
}


table{
	box-shadow: 0 4px 6px -2px gray;
}

</style>
<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />


 <spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" />


</head>
<body>


<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">OFFICER MASTER EDIT</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="Officer.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Officer Master List</a></li>
				    <li class="breadcrumb-item active">Officer Master Edit</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	

<%

Object[] OfficerEditData=(Object[])request.getAttribute("OfficerEditData");
List<Object[]> DesignationList=(List<Object[]>)request.getAttribute("DesignationList");
List<Object[]> DivisionList=(List<Object[]>)request.getAttribute("OfficerDivisionList");




%>

<div class="row"> 


 <div class="col-sm-2" ></div>
	
 <div class="col-sm-8"  style="top: 10px;">
<div class="card shadow-nohover"  >

<div class="card-body">


<form name="myfrm" action="OfficerMasterEditSubmit.htm" method="POST" >

  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
  

<tr>
  <th style="">
<label style="color:black;">Employee No:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
<input  class="form-control form-control"  type="text" name="EmpNo" required="required" maxlength="255" style="font-size: 15px;" readonly
			value="<%=OfficerEditData[1] %>">

</td>
</tr>
</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
<tr>
<th>
<label style="color:black;">Employee Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
<input  class="form-control form-control"  type="text" name="EmpName" required="required" maxlength="255" style=" font-size: 15px;text-transform: capitalize; width: 80%;" 
			value="<%=OfficerEditData[2] %>">

</td>
</tr>
</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
<tr>
<th>
<label style="color:black;">Designation:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

  <select class="form-control selectpicker" name="Designation" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;width: 80%;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
					
			<%  for ( Object[]  obj :DesignationList) {%>
			
			<option value="<%=obj[0] %>" <%if(OfficerEditData[3].toString().equalsIgnoreCase(obj[0].toString())) {%> selected="selected" <%} %>> <%=obj[2] %> </option>
			
			<%} %>

			</select> 
</td>

</tr>
</thead>
</table>

<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
<tr>
 <th >
<label style="color:black;">Extension No:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

 
<input  class="form-control form-control"  type="number" name="ExtNo" required="required" maxlength="255" style="font-size: 15px;width: 80%;" 
			value="<%=OfficerEditData[4] %>">


</td>
</tr>
</thead>
</table>

<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
<tr>
 <th >
<label style="color:black;">Email:
<span class="mandatory" style="color: red;"></span>
</label>
</th>
 <td >
 

 
<input  class="form-control form-control"  type="text" name="Email"  maxlength="255" style="font-size: 15px;width: 80%;" 
		<%if(OfficerEditData[5]!=null){ %>	value="<%=OfficerEditData[5] %>" <%} %>>


</td>
</tr>
</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
<tr>
 <th >
<label style="color:black;">Division:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
 <select class="form-control selectpicker" name="Division" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;width: 80%;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
					
			<%  for ( Object[]  obj :DivisionList) {%>
			
			<option value="<%=obj[0] %>" <%if(OfficerEditData[6].toString().equalsIgnoreCase(obj[0].toString())) {%> selected="selected" <%} %>> <%=obj[1] %></option>
			
			<%} %>

			</select> 
</td>

</tr>


</thead> 
</table>

</div>
</div>

	  <center> <div id="OfficerMasterEditSubmit" ><input type="submit"  class="btn btn-primary btn-sm submit"         /></div></center>
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
								<input type="hidden" name="OfficerId" value="<%=OfficerEditData[0]%>">
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	
	 <div class="col-sm-2" ></div>
	
	  </div>
<script type="text/javascript">

$(document).ready(function(){
	  $("#check").click(function(){
	  
	  });
	});
$("#UsernameSubmit").hide();
$(document)
.ready(function(){
	 $("#check").click(function(){
			// SUBMIT FORM

		$('#UserName').val("");
		 $("#UsernameSubmit").hide();
			var $UserName = $("#UserNameCheck").val();
if($UserName!=""&&$UserName.length>=4){
			
			$
					.ajax({

						type : "GET",
						url : "UserNamePresentCount.htm",
						data : {
							UserName : $UserName
						},
						datatype : 'json',
						success : function(result) {

							var result = JSON.parse(result);
						
							var s = '';
							if(result>0){
								s = "UserName Not Available";	
								$('#UserNameMsg').html(s);
							
								 $("#UsernameSubmit").hide();
							}else{
								$('#UserName').val($UserName);
								
								 $("#UsernameSubmit").show();
							}
							
							
							
							
						}
					});

}
		});
});


$(document)
.on(
		"change",
		"#LoginType",

		function() {
			// SUBMIT FORM

	
			var $LoginType = this.value;

		
		
			if($LoginType=="D"||$LoginType=="G"||$LoginType=="T"||$LoginType=="O"||$LoginType=="B"||$LoginType=="S"||$LoginType=="C"||$LoginType=="P"||$LoginType=="U"){
			
				$("#Employee").prop('required',true);
			}
			else{
				$("#Employee").prop('required',false);
			}
	
		});

</script>
</body>
</html>