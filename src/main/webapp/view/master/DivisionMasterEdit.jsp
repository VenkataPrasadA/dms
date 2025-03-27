<%@page import="com.vts.dms.master.model.DivisionMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
.table thead tr th {
	background-color: aliceblue;
	width: 30%
	
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



</head>
<body>


<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DIVISION MASTER EDIT</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="DivisionMaster.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Division Master List</a></li>
				    <li class="breadcrumb-item active">Division Master Edit</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	

<%


List<Object[]> DivisionGroupList=(List<Object[]>)request.getAttribute("DivisionGroupList");

List<Object[]> DivisionHeadList=(List<Object[]>)request.getAttribute("DivisionHeadList");


Object[] DivisionMasterEditData=(Object[])request.getAttribute("DivisionMasterEditData");

%>

<div class="row"> 


 <div class="col-sm-2"  ></div>


 <div class="col-sm-8"  style="top: 10px;">
<div class="card shadow-nohover"  >

<div class="card-body">


<form name="myfrm" action="DivisionMasterEditSubmit.htm" method="POST" >

  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  

<tr>
<th  style="text-align: left; ">
<label >Division Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
			
	
 
 
 	<input  class="form-control" type="text" name="DivisionCode" required="required" maxlength="3" style="font-size: 15px;width:30%;"  readonly
 	 value="<%=DivisionMasterEditData[1]%> " >
 	
 

 
 
</td>
</tr>
</thead>
</table>



 <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  
<tr>
<th  style="text-align: left">
<label >Division Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

			
 
 
 	<input  class="form-control" type="text" name="DivisionName" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;"  
value="<%=DivisionMasterEditData[2]%> " onkeypress="return ((event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 8 || event.charCode == 32 || (event.charCode >= 48 && event.charCode <= 57));" >
 	
 

</td>

</tr>
</thead>
</table>


 <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>

<th  style="text-align: left">
<label >Group Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 <select class="form-control selectpicker" name="GroupName" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				
				<% for (  Object[] obj : DivisionGroupList){ %>
		
				<option value=<%=obj[0]%> <%if(obj[0].toString().equalsIgnoreCase(DivisionMasterEditData[4].toString())) {%> selected="selected"  <%} %>><%=obj[1]%> </option>
			
				<%} %>

			</select> 
</td>
</tr>
</thead>
</table>


 <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>
<th  style="text-align: left">
<label >Division Head Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
  <select class="form-control selectpicker" name="DivisionHeadName" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				
				<% for (  Object[] obj : DivisionHeadList){ %>
		
				<option value=<%=obj[0]%> <%if(obj[0].toString().equalsIgnoreCase(DivisionMasterEditData[3].toString())) {%> selected="selected" <%} %>><%=obj[1]%> </option>
			
				<%} %>

			</select> 
 
</td>

</tr>



</thead> 
</table>

</div>
</div>

	  <center> <div ><input type="submit"  class="btn btn-primary btn-sm submit"         /></div></center>
	  
	  <input type="hidden" name="DivisionId"
								value="<%=DivisionMasterEditData[0] %>" />
	  
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	  
	  <div class="col-sm-2"  ></div>	
	  
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