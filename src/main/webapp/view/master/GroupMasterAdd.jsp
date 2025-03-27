<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
         <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>GROUP MASTER ADD</title>
<style>
.table thead tr th {
	background-color: aliceblue;
	text-align: left;
	width:30%
	
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
				<h5 style="font-weight: 700 !important">GROUP MASTER ADD</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="Group.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Group Master List</a></li>
					<li class="breadcrumb-item active">Group Master Add</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>

<%

List<Object[]> GroupMasterListAdd=(List<Object[]>)request.getAttribute("GroupMasterListAdd");


%>

<div class="row"> 

 <div class="col-sm-2"  ></div>
 
 <div class="col-sm-8"  style="top: 10px;">
<div class="card shadow-nohover" >

<div class="card-body">


<form name="myfrm" action="GroupMasterAddSubmit.htm" method="POST" >

  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
  

<tr>
  <th style="">
<label style="color:black;">Group Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td style="width:80%">
 
<input  class="form-control form-control"  type="text" name="GroupCode" required="required" maxlength="3" style="font-size: 15px;text-transform: uppercase;width:50%;" >

 
</td>
</tr>
</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>

<tr>
 <th>
<label style="color:black;">Group Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 
 <input  class="form-control form-control" type="text" name="GroupName" required="required" maxlength="255" style="font-size: 15px;width:100%;"  >

</td>
</tr>

</thead>
</table>


<table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
<tr>
<th>
<label style="color:black;">Group Head:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 

  <select class="form-control selectpicker" name="GroupHead" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;width:100%;	">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
					
			<%  for ( Object[]  obj :GroupMasterListAdd) {%>
			
			<option value="<%=obj[0] %>"> <%=obj[1] %> </option>
			
			<%} %>

			</select> 
			
</td>

</tr>



</thead> 
</table>

</div>
</div>

	  <center> <div id="GroupMasterAddSubmit" ><input type="submit"  class="btn btn-primary btn-sm submit"         /></div></center>
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