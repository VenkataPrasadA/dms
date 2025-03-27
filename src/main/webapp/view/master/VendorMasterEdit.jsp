<%@page import="com.vts.dms.master.model.Vendor"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,java.text.SimpleDateFormat"%>
    
         <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>VENDOR MASTER EDIT</title>
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
				<h5 style="font-weight: 700 !important">VENDOR MASTER EDIT</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="Vendor.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Vendor Master List</a></li>
				    <li class="breadcrumb-item active">Vendor Master Edit</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>

<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");


Object[] VendorMasterEditData=(Object[]) request.getAttribute("VendorMasterEditData");

%>

<div class="row datatables"> 



	
 <div class="col-sm-12"  style="top: 10px;">
<div class="card shadow-nohover"  >

<div class="card-body">


<form name="myfrm" id="myfrm" action="VendorMasterEditSubmit.htm" method="POST" >

  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  

<tr>
<%--   <th>
<label >VENDOR CODE:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="2">
 	<%for(Object[] obj : VendorCodeList) {%>
 
 
 	<input  class="form-control" type="text" name="VendorCode" required="required" maxlength="25" style="font-size: 15px;text-transform: uppercase;"  id="" 
 	readonly <%if(Integer.parseInt(obj[0].toString())== vendor.getVendorId()){ %> value="<%=obj[1]%> " ><%}%> 
 
 <%} %>
 
 
</td> --%>


 <th>
<label style="color:black;">Vendor Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="6">
	
 	<input  class="form-control form-control" type="text" name="VendorName" required="required" maxlength="255" style="font-size: 15px;text-transform: capitalize;width: 100%"  id="VendorName"
 	 value="<%=VendorMasterEditData[2] %>" > 
			
			
</td>

<th>
<label style="color:black;">Vendor Type:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td>

<select class="form-control selectpicker" name="VendorType" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;width: 100%">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
			
			<%if (VendorMasterEditData[15]!= null){ %>
			<option value="Public" <%if(VendorMasterEditData[15].toString().equalsIgnoreCase("Public")){ %> selected="selected" <%} %>>Public</option>	
			<option value="MSME" <%if(VendorMasterEditData[15].toString().equalsIgnoreCase("MSME")){ %> selected="selected" <%} %>>MSME</option>
			<option value="NSIC" <%if(VendorMasterEditData[15].toString().equalsIgnoreCase("NSIC")){ %> selected="selected" <%} %>>NSIC</option>
			<%}else {%>
			<option value="Public" >Public</option>	
			<option value="MSME" >MSME</option>
			<option value="NSIC" >NSIC</option>
			
			<%} %>
			</select> 
			
 
</td>


</tr>


<tr>

<th>
<label style="color:black;">Address:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5" >
 

					
					
 	<input  class="form-control form-control" type="text" name="Address" required="required" maxlength="255" style="font-size: 15px;text-transform: capitalize;width: 100%"  id=""
 	  value="<%=VendorMasterEditData[3] %>" >  
			
	
			
</td>


<th>
<label style="color:black;">Pin Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="3">
 

					
					
 	<input  class="form-control form-control" type="number" name="PinCode" required="required" maxlength="6" style="font-size: 15px;"  id=""
 	 value="<%=VendorMasterEditData[5] %>" >
			
		
			
</td>


</tr>

<tr>


  <th>
<label style="color:black;">City:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td  colspan="3" >
 
			
 	<input  class="form-control form-control" type="text" name="City" required="required" maxlength="255" style="font-size: 15px;text-transform: capitalize;"  id="" 
 	 value="<%=VendorMasterEditData[4] %>" >
			
	
 
</td>

<th>
<label style="color:black;">Product Range:</label>
<span class="mandatory" style="color: red;">*</span>

</th>
 <td colspan="5">


 
<input  class="form-control form-control"  type="text" required="required" name="ProductRange"  maxlength="255" style="font-size: 15px;"  id=""
 value="<%if(VendorMasterEditData[14]!=null) {%><%=VendorMasterEditData[14] %><%}else {%> - <%} %>" > 



</td>
 
</tr>

<tr>

 <th>
<label style="color:black;">Tel No:

</label>
</th>
 <td colspan="2">
 

 
<input  class="form-control form-control"  type="number" name="TelNo"  maxlength="10" style="font-size: 15px;"  id=""
 value="<%=VendorMasterEditData[7] %>" >
 

</td>

 <th>
<label style="color:black;">Fax No:

</label>
</th>
 <td colspan="2">
 

 
<input  class="form-control form-control"  type="number" name="FaxNo"  maxlength="15" style="font-size: 15px;"  id=""
 value="<%=VendorMasterEditData[8] %>" > 



</td>


 <th>
<label style="color:black;">CPP Register ID:

</label>
</th>
 <td colspan="3">


 
<input  class="form-control form-control"  type="text" name="CPPRegisterId" maxlength="255" style="font-size: 15px;width:100%"  id=""
 value="<%if(VendorMasterEditData[13]!=null) {%><%=VendorMasterEditData[13]%><%}else{ %> - <%} %>" >



</td>

</tr>

<tr>

 <th>
<label style="color:black;">Email:

</label>
</th>
 <td colspan="4">
 

 
<input  class="form-control form-control"  type="email" name="Email"  maxlength="255" style="font-size: 15px;"  id=""
 value="<%if(VendorMasterEditData[9]!=null){ %><%=VendorMasterEditData[9] %><%}else{ %>  <%} %>" >


</td>

<th>
<label style="color:black;">Contact Person:

</label>
</th>
 <td colspan="6">
 

 
<input  class="form-control form-control"  type="text" name="ContactPerson"  maxlength="255" style="font-size: 15px;text-transform: capitalize;" 
 id=""   value="<%if (VendorMasterEditData[6] != null){ %><%=VendorMasterEditData[6] %> <%}else{ %> - <%} %>" >  



</td>


</tr>

<tr>

 <th>
<label style="color:black;">Registration No:

</label>
</th>
 <td colspan="4">
 

 
<input  class="form-control form-control"  type="text" name="RegistrationNo"  maxlength="255" style="font-size: 15px;"  id=""
  value="<%if(VendorMasterEditData[10]!=null){ %><%=VendorMasterEditData[10] %><%}else{ %> - <%} %>" >



</td>
 


 <th>
<label style="color:black;">Registration Date:

</label>
</th>
 <td colspan="4">


 
<input  class="form-control form-control"   name="RegistrationDate"  maxlength="255" style="font-size: 15px;width:80%"  
id="currentdate"   value="<%if(VendorMasterEditData[11]== null) {%><%=sdf.format(new Date()) %> <%}else{ %><%=VendorMasterEditData[11]%><%} %>" >



</td>

</tr>

<tr>

<th>
<label style="color:black;">Bank Name:

</label>
</th>
 <td colspan="4" >


 
<input  class="form-control form-control"  type="text" name="VendorBank"  maxlength="255" style="font-size: 15px;text-transform: capitalize;"  id=""
  value="<%if(VendorMasterEditData[18]!=null){ %><%=VendorMasterEditData[18] %><%}else{ %> - <%} %>" > 


</td>

<th>
<label style="color:black;">Account No:

</label>
</th>
 <td colspan="4">


 
<input  class="form-control form-control"  type="number" name="AccountNo" maxlength="255" style="font-size: 15px;"  id=""
  value="<%if(VendorMasterEditData[19]!=null){ %><%=VendorMasterEditData[19] %><%}else{ %> - <%} %>" > 


</td>


</tr>

<tr>

 <th>
<label style="color:black;">PAN No:

</label>
</th>
 <td colspan="4">


 
<input  class="form-control form-control"  type="text" name="PanNo"  maxlength="10" style="font-size: 15px;text-transform: uppercase;"  id=""
  value="<%if(VendorMasterEditData[16]!=null){ %><%=VendorMasterEditData[16] %><%}else{ %> - <%} %>" > 



</td>

 <th>
<label style="color:black;">GST No:

</label>
</th>
 <td colspan="4">


 
<input  class="form-control form-control"  type="text" name="GSTNo"  maxlength="15" style="font-size: 15px;"  id=""
  value="<%if(VendorMasterEditData[17]!=null){ %><%=VendorMasterEditData[17] %><%}else{ %> - <%} %>" > 



</td>

</tr>



</thead> 
</table>

</div>
</div>

	  <center> <div id="VendorMasterEditSubmit" ><input type="submit"  class="btn btn-primary btn-sm submit"      onclick="EditVendor(myfrm)"   /></div></center>
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
								<input type="hidden" name="VendorId" value="<%=VendorMasterEditData[0]%>">
	 <input  type="hidden" name="VendorCode" value="<%=VendorMasterEditData[1]%>">
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	  
	
	  
	  </div>
<script type="text/javascript">

$('#currentdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});



function EditVendor(myfrm){

	var VendorCode = "<%=VendorMasterEditData[1].toString().substring(0,1)%>";


	 var VendorName = $("#VendorName").val();

	 var VendorNameFirst =VendorName.charAt(0).toUpperCase();

	
	if(VendorCode == VendorNameFirst){
		  return true;
	}else{
		
		  bootbox.alert("VENDOR NAME FIRST LETTER SHOULD BE "+VendorCode);
			 event.preventDefault();
			return false;
	}

	
/* 	 if(){
		  bootbox.alert("YOU REACHED MAX VALU ODER");
	 event.preventDefault();
	return false;
	} */
		 
	
		  return true;
	 
			
	}



</script>
</body>
</html>