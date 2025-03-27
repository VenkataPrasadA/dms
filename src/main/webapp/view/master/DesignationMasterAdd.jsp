<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>DESIGNATION MASTER ADD</title>




<style>
.table thead tr th {
	background-color: aliceblue;
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


</head>
<body >


<div class="row" >
<div class="col-md-12">
<section class="content-header">
			<h5>DESIGNATION MASTER ADD</h5>
			<ol class="breadcrumb" >
				<li class="breadcrumb-item"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="MasterDashBoard.htm"> Master Dashboard</a></li>
				<li class="breadcrumb-item"><a href="Designation.htm">Designation Master List</a></li>
				<li class="breadcrumb-item active">Designation Master Add</li>
			</ol>
		  </section> 
		  </div>
</div>

<%




%>


	  
<div class="row"> 

<div class="col-sm-2"></div> 

	  <div class="col-sm-8">
	  
	  	<div class="card shadow-nohover" >
  			<div class="card-body" >
  
  				<form name="myfrm" action="DesignationAddSubmit.htm" method="POST" >
  
   					<div class="table-responsive">
	  					<table class="table table-bordered table-hover table-striped table-condensed "  >
   
   				 			<thead>
     							<tr>
									<th  style="text-align: left;" >
										<label >Designation Code :<span class="mandatory" style="color: red; font-size: 125%">*</span></label>
									</th>        
        
        							<td>
        								<input  class="form-control form-control" type="text" name="DesignationCode" required="required" maxlength="3" style="font-size: 15px;width:30%; font-weight:1200;text-transform: uppercase;" onkeypress="return ((event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 8 || event.charCode == 32 || (event.charCode >= 48 && event.charCode <= 57));" >
        							</td>
        						</tr>
        					</thead>
        					</table>
        						
        					<table class="table table-bordered table-hover table-striped table-condensed "  >
   				 				<thead>
        						
        						<tr>
									<th  style="text-align: left;" >
										<label >Designation :<span class="mandatory" style="color: red; font-size: 125%">*</span></label>
									</th>        
        
        							<td>
        								<input  class="form-control form-control" type="text" name="Designation" required="required" maxlength="255" style="font-size: 15px;width:30%; font-weight:1200" onkeypress="return ((event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 8 || event.charCode == 32 || (event.charCode >= 48 && event.charCode <= 57));" >
        							</td>
        						</tr>
        					</thead>
        					</table>
        					
        						
        					<table class="table table-bordered table-hover table-striped table-condensed "  >
   				 				<thead>	
        						<tr>
									<th  style="text-align: left;" >
										<label >Designation Limit :<span class="mandatory" style="color: red; font-size: 125%">*</span></label>
									</th>        
        
        							<td>
        								<input  class="form-control form-control" type="number" name="DesignationLimit" required="required" maxlength="255" style="font-size: 15px;width:30%;font-weight:1200" onkeypress="return ((event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 8 || event.charCode == 32 || (event.charCode >= 48 && event.charCode <= 57));" >
        							</td>
        						</tr>
    					</thead>
    				</table>
    			</div>
    
  	  	<center> <div id="DesignationAddSubmit" ><input type="submit"  class="btn btn-primary btn-sm submit"         /></div></center>

	 		<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}"  />
	 		
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