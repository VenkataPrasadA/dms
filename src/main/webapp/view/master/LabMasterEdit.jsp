<%@page import="com.vts.dms.model.LabMaster"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>LAB MASTER EDIT</title>
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

<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />


 <spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" /> 

</head>
<body>


<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">LAB MASTER EDIT</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="LabDetails.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Lab Master List</a></li>
				    <li class="breadcrumb-item active">Lab Details</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	

<%


Object[] LabMasterEditData=(Object[]) request.getAttribute("LabMasterEditData");

%>

<div class="row"> 


<div class="col-sm-1"></div>

 <div class="col-sm-10"  style="top: 10px;">
<div class="card shadow-nohover" >

<div class="card-body">


<form name="myfrm" action="LabMasterEditSubmit.htm" method="POST" >

  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  

<tr>
  <th>
<label >Lab Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td width="">

 
 
 	<input  class="form-control" type="text" name="LabCode" required="required" maxlength="255" style="font-size: 15px;"  id="LabCode" 
 	 value="<%=LabMasterEditData[1]%> " >
 

 
 
</td>

</tr>
</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  

<tr>
 <th >
<label >Lab Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td width="">

				
			
					
					
 	<input  class="form-control form-control" type="text" name="LabName" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;"  
 	 value="<%=LabMasterEditData[2] %>" > 
			
	
					
</td>

</tr>
</thead>
</table>

<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>


  <th>
<label >Lab Address:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="3">
 
 
					
					
 	<input  class="form-control form-control" type="text" name="LabAddress" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;width:88%" 
 	  value="<%=LabMasterEditData[4] %>" >
			
		
 
</td>

</tr>
</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>



<th>
<label >Lab City:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

					
					
 	<input  class="form-control form-control" type="text" name="LabCity" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;"  
 	 value="<%=LabMasterEditData[5] %>" >  
			

			
</td>

 <th>
<label >Lab Email:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

					
					
 	<input  class="form-control form-control" type="text" name="LabEmail" required="required" maxlength="30" style="font-size: 15px;" 
 	  value="<%=LabMasterEditData[9] %>" >
			
			

</td>

</tr>
</thead>
</table>

<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>

 <th>
<label >Lab Pin:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

					
					
 	<input  class="form-control form-control" type="text" name="LabPin" required="required" maxlength="6" style="font-size: 15px;"  
value="<%=LabMasterEditData[6] %>" > 
			
		

</td>




<th>
<label >Lab Unit Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

					
					
 	<input  class="form-control form-control" type="number" name="LabUnitCode" required="required" maxlength="255" style="font-size: 15px;"  id="LabCode" 
 	 value="<%=LabMasterEditData[3] %>" >  
			
			
			
</td>

</tr>
</thead>
</table>

<table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>

 <th>
<label >Lab Telephone:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

					
					
 	<input  class="form-control form-control" type="text" name="LabTelephone" required="required" maxlength="15" style="font-size: 15px;"  
 	 value="<%=LabMasterEditData[7] %>" >
			
		

</td>




<th>
<label >Lab Fax No:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

					
					
 	<input  class="form-control form-control" type="number" name="LabFaxNo" required="required" maxlength="255" style="font-size: 15px;"  id="" 
  value="<%=LabMasterEditData[8] %>" >
			
	
			
</td>

</tr>



</thead> 
</table>

</div>
</div>

	  <center> <div id="LabAddSubmit" ><input type="submit"  class="btn btn-primary btn-sm submit"         /></div></center>
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
								<input type="hidden" name="LabMasterId" value="<%= LabMasterEditData[0]%>">
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	  
	 <div class="col-sm-1"></div>
	  
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