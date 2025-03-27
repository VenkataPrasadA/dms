

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
         <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>LAB  PARAMETER EDIT</title>
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


<div class="row">
<div class="col-md-12">
<section class="content-header">
			<h5>LAB  PARAMETER EDIT</h5>
			<ol class="breadcrumb" >
				<li class="breadcrumb-item"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="MasterDashBoard.htm"> Master Dashboard</a></li>
				<li class="breadcrumb-item"><a href="LabParameter.htm">Lab Parameter List</a></li>
				<li class="breadcrumb-item active">Lab Parameter Edit</li>
			</ol>
		  </section> 
		  </div>
</div>

<%


Object[] LabParameterData=(Object[]) request.getAttribute("LabParameterData");

%>

<div class="row"> 


 <div class="col-sm-2"></div>
	 
 <div class="col-sm-8"  style="top: 10px;">
<div class="card shadow-nohover"  >

<div class="card-body">


<form name="myfrm" action="LabParameterUpdate.htm" method="POST" >

  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
  

<tr>
  <th style="">
<label >Mode Description:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 	
 
 
 	<input  class="form-control" type="text" name="DESCRIPTION" required="required" maxlength="255" style="font-size: 15px;text-transform: capitalize;"  id="" 
 	  value="<%=LabParameterData[2] %>" readonly="readonly" > 

 
 
</td>
</tr>
</thead>
</table>

 <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>
<tr>
 <th>
<label >Lab Value:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >

				
					
					
 	<input  class="form-control form-control" type="number" name="LabValue" required="required"  style="font-size: 15px;"  
 	 value="<%=LabParameterData[3] %>" >
			
			
					
</td>

</tr>


</thead> 
</table>

</div>
</div>

	  <center> <div id="ItemEditSubmit" ><input type="submit"  class="btn btn-primary btn-sm submit"         /></div></center>
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
								<input type="hidden" name="LabParameterId" value="<%= LabParameterData[0] %>">
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	  
	   <div class="col-sm-2"  >
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

</script>
</body>
</html>