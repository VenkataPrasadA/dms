<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>DIVISION MASTER ADD</title>




<style>
.table thead tr th {
	background-color: aliceblue;
	width: 30%;
	
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


<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DIVISION MASTER ADD</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="DivisionMaster.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Division Master List</a></li>
				    <li class="breadcrumb-item active">Division Master Add</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	



<%

List<Object[]> DivisionGroupListAdd=(List<Object[]>)request.getAttribute("DivisionGroupListAdd");
List<Object[]> DivisionHeadListAdd=(List<Object[]>)request.getAttribute("DivisionHeadListAdd");


%>


  <div class="container-fluid datatables">
	<div class="row" style="margin-top: 0px; margin-bottom: 5px;">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
        		<div class="card-body">
        		
        	     	<form name="myfrm" action="DivisionAddSubmit.htm" method="POST">
                		<div class="row">
                   
                        	<div class="col-sm-2" align="left"  >
	                        	<div class="form-group">
	                            		<label >Division Code: <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
	                              		<input  class="form-control form-control" type="text" name="DivisionCode" required="required" maxlength="3" style="font-size: 15px; text-transform: uppercase;font-weight:1200" onkeypress="return ((event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 8 || event.charCode == 32 || (event.charCode >= 48 && event.charCode <= 57));" >
	                       		</div>
                           	</div>
                           
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label >Division Name: <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control form-control" type="text" name="DivisionName" required="required" maxlength="255" style="font-size: 15px;width:100%;" onkeypress="return ((event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || event.charCode == 8 || event.charCode == 32 || (event.charCode >= 48 && event.charCode <= 57));">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label >Group Name: <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		 	<select class="selectpicker form-control select-wrapper" name="GroupName" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
											<option value="" disabled="disabled" selected="selected"
												hidden="true">--Select--</option>
											
											<% for (  Object[] obj : DivisionGroupListAdd){ %>
									
											<option value=<%=obj[0]%>><%=obj[1]%> </option>
										
											<%} %>
							
										</select> 
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label >Division Head Name: <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<select class="form-control selectpicker select-wrapper" name="DivisionHeadName" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
										<option value="" disabled="disabled" selected="selected"
											hidden="true">--Select--</option>
										
										<% for (  Object[] obj : DivisionHeadListAdd){ %>
								
										<option value=<%=obj[0]%>><%=obj[1]%> </option>
									
										<%} %>
						
									</select> 
                        		</div>
                    		</div>
        
                		</div>
                		
        				<div class="form-group" align="center" >
	 						<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
						</div>
      
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 				</form>
        
     		</div>    
        
			<div class="card-footer form-footer">
       
        	</div>
        	
        	</div>
		</div>
	</div>
</div>
	  
	  
	  
<script type="text/javascript">



</script>
</body>
</html>