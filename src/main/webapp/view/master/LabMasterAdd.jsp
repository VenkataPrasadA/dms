<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>LAB MASTER ADD</title>


<style>
.table thead tr th {
	background-color: aliceblue;
	text-align: left;
	width:20%;	
}

.table thead tr td {
	background-color: #f9fae1;
	text-align: left;
}

table{
	box-shadow: 0 4px 6px -2px gray;

}

</style>

</head>
<body>


<div class="row">
<div class="col-md-12">
<section class="content-header">
			<h5>LAB MASTER ADD</h5>
			<ol class="breadcrumb" >
				<li class="breadcrumb-item"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="MasterDashBoard.htm"> Master Dashboard</a></li>
				<li class="breadcrumb-item"><a href="LabDetails.htm">Lab Master List</a></li>
				<li class="breadcrumb-item active">Lab Master Add</li>
			</ol>
		  </section> 
		  </div>
</div>

<%



%>

<div class="row"> 

<div class="col-sm-1"></div>

	
 <div class="col-sm-10"  style="top: 10px;">
<div class="card shadow-nohover"  >

<div class="card-body">


<form name="myfrm" action="LabMasterAddSubmit.htm" method="POST" >

  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
  

<tr>
  <th>
<label >Lab Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td width="" >
 
<input  class="form-control form-control" type="text" name="LabCode" required="required" maxlength="10" style="font-size: 15px; "  id="LabCode" onkeypress="return ((event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 8 || event.charCode == 32 || (event.charCode >= 48 && event.charCode <= 57));">

 
</td>
</tr>
</thead>
</table>

<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
  

<tr>

 <th>
<label >Lab Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td width="">
 
 <input  class="form-control form-control"  type="text" name="LabName" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;"  id="LabName" onkeypress="return ((event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 8 || event.charCode == 32 || (event.charCode >= 48 && event.charCode <= 57));">

</td>

</tr>

</thead>
</table>


  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>

<tr>

<th>
<label >Lab Address:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="3">
 
 <input  class="form-control form-control" type="text" name="LabAddress" required="required" maxlength="100" style="font-size: 15px;text-transform:capitalize; width:88%"  id="LabAddress">

 
</td>




</tr>
</thead>
</table>


  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>

<tr>

<th>
<label >Lab Pin:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
 <input  class="form-control form-control"  type="number" name="LabPin" required="required" min='1'   maxlength="6" style="font-size: 15px;"  id="LabPin">

</td>

<th>
<label >Lab Email:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
<input  class="form-control form-control"  type="email" name="LabEmail" required="required" maxlength="255" style="font-size: 15px;"  id="">

</td>



</tr>
</thead>
</table>


  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
<tr>
  
 <th>
<label >Lab Telephone:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
<input  class="form-control form-control" type="text" name="LabTelephone" required="required" maxlength="10" style="font-size: 15px;"  id="">

</td>


 

<th>
<label >Lab Fax No:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
<input  class="form-control form-control"  type="text" name="LabFaxNo" required="required" maxlength="15" style="font-size: 15px;"  id="">

</td>


</tr>
</thead>
</table>


  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>

<tr>
  
  
  <th>
<label >Lab Unit Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
<input  class="form-control form-control"  type="number" name="LabUnitCode" required="required" maxlength="255" style="font-size: 15px;"  id="LabUnitCode">

</td>
  
  
 <th>
<label >Lab City:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
<input  class="form-control form-control" type="text" name="LabCity" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;"  id="LabCity">

</td>


 



</tr>



</thead> 
</table>

</div>
</div>

	  <center> <div id="LabMasterAddSubmit" ><input type="submit"  class="btn btn-primary btn-sm submit"         /></div></center>
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	
	<div class="col-sm-1"></div>
	
	
	  </div>
<script type="text/javascript">



</script>
</body>
</html>