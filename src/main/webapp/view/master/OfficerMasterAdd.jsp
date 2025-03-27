<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>OFFICER MASTER ADD</title>
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
				<h5 style="font-weight: 700 !important">OFFICER MASTER ADD</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="Officer.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Officer Master List</a></li>
				    <li class="breadcrumb-item active">Officer Master Add</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	

<%

List<Object[]> DesignationList=(List<Object[]>)request.getAttribute("DesignationList");
List<Object[]> DivisionList=(List<Object[]>)request.getAttribute("OfficerDivisionList");

%>

<div class="row"> 


<div class="col-sm-2"></div> 
	
 <div class="col-sm-8"  style="top: 10px;">
<div class="card shadow-nohover"  >

<div class="card-body">


<form name="myfrm" action="OfficerMasterAddSubmit.htm" method="POST" >

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
 
<input  class="form-control form-control"  type="text" name="EmpNo" required="required" maxlength="255" style="font-size: 15px;width:100%;text-transform: uppercase;"  id="">
 
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
 
<input  class="form-control form-control"  type="text" name="EmpName" required="required" maxlength="255" style="font-size: 15px;width:100%;text-transform: capitalize;"  id="">

</td>
</tr>
</thead></table>


<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>

<tr>
<th>
<label style="color:black;">Designation:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
  <select class="form-control selectpicker" name="Designation" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
					
			<%  for ( Object[]  obj :DesignationList) {%>
			
			<option value="<%=obj[0] %>"> <%=obj[2] %></option>
			
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
 
 <input  class="form-control form-control" type="number" name="ExtNo" required="required" maxlength="255" style="font-size: 15px;width:100%"  id="">

</td>
</tr>
</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>

<tr>
 <th >
<label  style="color:black;">Email:
<span class="mandatory" style="color: red;"></span>
</label>
</th>
 <td >
 
 <input  class="form-control form-control" type="email" name="Email"  maxlength="255" style="font-size: 15px;width:100%"  id="">

</td>
</tr>

</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
<tr>
 <th >
<label  style="color:black;">Division:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
 <select class="form-control selectpicker" name="Division" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
					
			<%  for ( Object[]  obj :DivisionList) {%>
			
			<option value="<%=obj[0] %>"> <%=obj[1] %></option>
			
			<%} %>

			</select> 
</td>

</tr>







</thead> 
</table>

</div>
</div>

	  <center> <div id="OfficerMasterAdd" ><input type="submit"  class="btn btn-primary btn-sm submit"         /></div></center>
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	 
	 <div class="col-sm-2"></div> 
	 
	  </div>
<script type="text/javascript">



</script>
</body>
</html>