<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
         <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>VENDOR MASTER ADD</title>
<style>
.table thead tr th {
	background-color: aliceblue;
	text-align: left;
	
}

.table thead tr td {
	background-color: #f9fae1;
	text-align: left;
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
				<h5 style="font-weight: 700 !important">VENDOR MASTER ADD</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="Vendor.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Vendor Master List</a></li>
				    <li class="breadcrumb-item active">Vendor Master Add</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	

<%



%>

<div class="row datatables"> 



	
 <div class="col-sm-12"  style="top: 10px;">
<div class="card shadow-nohover"  >

<div class="card-body">


<form name="myfrm" action="VendorMasterAddSubmit.htm" method="POST" >

  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
  

<tr>
<!--   <th>
<label >VENDOR CODE:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="2">
 
<input  class="form-control form-control"  type="text" name="VendorCode" required="required" maxlength="12" style="font-size: 15px;text-transform: uppercase;"  id="">

 
</td> -->


 <th>
<label style="color:black;">Vendor Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="6">
 
 <input  class="form-control form-control" type="text" name="VendorName" required="required" maxlength="255" style="font-size: 15px;text-transform: capitalize;width: 100%"  id="">

</td>

<th>
<label style="color:black;">Vendor Type:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
 <select class="form-control selectpicker" name="VendorType" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
			
			<option value="Public">Public</option>	
			<option value="MSME">MSME</option>
			<option value="NSIC">NSIC</option>
			
			</select> 
			
</td>




</tr>



<tr >
<th>
<label style="color:black;">Address:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="6">
 
<input  class="form-control form-control"  type="text" name="Address" required="required" maxlength="255" style="font-size: 15px;width:100%;text-transform: capitalize;"  id="">

</td>

<th>
<label style="color:black;">Pin Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
<input  class="form-control form-control"  type="number" name="PinCode" required="required" maxlength="6" style="font-size: 15px;width: 100%"  id="">

</td>


</tr>


<tr>
<th>
<label style="color:black;">City:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="3">
 
 <input  class="form-control form-control"  type="text" name="City" required="required" maxlength="25" style="font-size: 15px;text-transform: capitalize;"  id="">

 
</td>


 <th>
<label style="color:black;">Product Range:</label>
<span class="mandatory" style="color: red;">*</span>
</th>
 <td colspan="5">
 
<input  class="form-control form-control"  type="text" name="ProductRange" required="required" maxlength="255" style="font-size: 15px;"  id="">

</td>


</tr>

<tr>



 <th>
<label style="color:black;">Tel No:

</label>
</th>
 <td colspan="2">
 
<input  class="form-control form-control"  type="number" name="TelNo"  maxlength="10" style="font-size: 15px;"  id="">

</td>

 <th>
<label style="color:black;">Fax No:

</label>
</th>
 <td colspan="2">
 
<input  class="form-control form-control"  type="number" name="FaxNo"  maxlength="15" style="font-size: 15px;"  id="">

</td>

 <th>
<label style="color:black;">CPP Register ID:
</label>
</th>
 <td colspan="3">
 
<input  class="form-control form-control"  type="text" name="CPPRegisterId"  maxlength="255" style="font-size: 15px;width:100%"  id="">

</td>

</tr>



<tr>

 <th>
<label style="color:black;">Email:
</label>
</th>
 <td colspan="4">
 
<input  class="form-control form-control"  type="email" name="Email"  maxlength="255" style="font-size: 15px;"  id="">

</td>

<th>
<label style="color:black;">Contact Person:

</label>
</th>
 <td colspan="6">
<input  class="form-control form-control"  type="text" name="ContactPerson" maxlength="255" style="font-size: 15px;text-transform: capitalize;"  id="">

</td>

</tr>

<tr>


<th>
<label style="color:black;">Registration No:

</label>
</th>
 <td colspan="4">
 
<input  class="form-control form-control"  type="text" name="RegistrationNo"  maxlength="255" style="font-size: 15px;"  id="">

</td>

 <th>
<label style="color:black;">Registration Date:

</label>
</th>
 <td colspan="4">
 
<input  class="form-control form-control"   name="RegistrationDate"  maxlength="255" style="font-size: 15px;width:80%"  id="currentdate">

</td>
</tr>

<tr>

 <th>
<label style="color:black;">Bank Name:

</label>
</th>
 <td colspan="4" >
 
<input  class="form-control form-control"  type="text" name="VendorBank"  maxlength="255" style="font-size: 15px;text-transform: capitalize;"  id="">

</td>

<!--  <th>
<label >VALIDITY DATE:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
<input  class="form-control form-control"  type="date" name="ValidityDate" required="required" maxlength="255" style="font-size: 15px;width:100%"  id="">

</td> -->

<th>
<label style="color:black;">Account No:

</label>
</th>
 <td colspan="4">
 
<input  class="form-control form-control"  type="number" name="AccountNo"  maxlength="255" style="font-size: 15px;"  id="">

</td>

</tr>

<tr>




 

</tr>

<tr>

 <th>
<label style="color:black;">PAN No:

</label>
</th>
 <td colspan="4">
 
<input  class="form-control form-control"  type="text" name="PanNo"  maxlength="10" style="font-size: 15px;text-transform: uppercase;"  id="">

</td>

 <th>
<label style="color:black;">GST No:

</label>
</th>
 <td colspan="4">
 
<input  class="form-control form-control"  type="text" name="GSTNo"  maxlength="15" style="font-size: 15px;"  id="">

</td>



 

</tr>


</thead> 
</table>

</div>
</div>

	  <center> <div id="VendorMasterAddSubmit" ><input type="submit"  class="btn btn-primary btn-sm submit"         /></div></center>
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	 
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


$('#currentdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"startDate" : new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
</script>
</body>
</html>