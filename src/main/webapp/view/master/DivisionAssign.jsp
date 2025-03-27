<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Division Assign</title>
</head>
<body>
<div class="row">
<div class="col-md-12">
<section class="content-header">
		
			<h5> DIVISION ASSIGN &nbsp;&nbsp;&nbsp;&nbsp;<small><b style="color: green;" id="ProjectName"></b></small></h5>
			
			<ol class="breadcrumb" >
				<li class="breadcrumb-item"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="MasterDashBoard.htm">	Master Dashbord</a></li>
				<li class="breadcrumb-item active">Division Assign</li>
			</ol>
		  </section> 
		  </div>
</div>

<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> DivisionList=(List<Object[]>) request.getAttribute("DivisionList");
List<Object[]> DivisionAssignList=(List<Object[]>) request.getAttribute("DivisionAssignList");
List<Object[]> OfficerList=(List<Object[]>) request.getAttribute("OfficerList");
Object[] DivisionName=(Object[])request.getAttribute("DivisionName");

List<Object[]> ProjectList=(List<Object[]>) request.getAttribute("ProjectList");
String ProjectId=(String)request.getAttribute("ProjectId");

%>


	<div class="nav navbar auditnavbar" style="background-color: white;">

			<form class="form-inline " method="POST" action="DivisionSubmit.htm">
			
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				
				<label style="margin-left: 450px; margin-right: 10px;font-weight: 800">Division: <span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control form-control selectpicker" name="DivisionId" style="margin-left: 12px;" data-width="300"  id="name">
			                <option value="" disabled="disabled" selected="selected">Select Division </option>
			                <%
			                for(Object[] obj:DivisionList ){
	
	                           %>
	                           
								<option value="<%=obj[0] %>" <%if(DivisionName!=null){ if(obj[0].toString().equalsIgnoreCase(DivisionName[0].toString())){%>selected="selected" <%}} %>><%=obj[1].toString() %></option> 
								
								
								
								<%} %>
					</select>
	
	 			<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
			</form>
	
	</div>


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></center>
                    <%} %>
                    
                    
                    
<div class="row" style="margin-top: 0px;">

	<div class="col-md-8">
		<div style="margin-top: 0px;">
		
			<div class="card  border-success " >
				<div class="card-body  shadow-nohover" >
				  
					<form action="ProjectRevokeSubmit.htm" method="POST" name="frm1" >
						<div class="row" style="margin-top: 20px;">
							<div class="col-md-12">
							
								<div class="table-responsive">
									<table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
										<thead>
											<tr>
												<th colspan="5">List Of User Assigned for <%if(DivisionName!=null){ %><%=DivisionName[1]%><%} %></th>
											</tr>
											<tr>
											   	<th style="width:5%; ">Select</th>
											   	<th >User</th>
											   	<th >Employee Name</th>
											 	<th>Desig</th>
											  	
											 </tr>
										</thead>
										
									     <tbody>
										 	<%if(DivisionAssignList!=null){
										 		for(Object[] obj:DivisionAssignList){ %>
										    <tr>
											  	<td><input type="radio" name="logindivisionid" value=<%=obj[0]%>  ></td>
											  	<td style="text-align: left;"><%=obj[2].toString() %></td> 
											    <td style="text-align: left;"><%=obj[4].toString() %></td>
										        <td style="text-align: left;"><%=obj[5].toString() %></td>
										        
										    </tr>
										    
										    <%} }%>
										 </tbody> 
										 
									</table>
								</div>
								
								<div style="text-align: center;">
									<button type="submit" class="btn btn-danger btn-sm "  onclick="Edit(frm1)"  >REVOKE</button>&nbsp;&nbsp;
								</div>
								
							</div>
						</div>

					<input type="hidden" name="DivisionId" <%if(DivisionName!=null){ %>value="<%=DivisionName[0]%>"<%} %> /> 	 						
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					
					</form>
				
				</div>
			</div>
		
		</div>
	</div>



<div class="col-md-4">
<div style="margin-top: 0px;">

<div class="card  border-success " >
		  	
     <div class="card-body  shadow-nohover" >
  <form action="DivisionAssignSubmit.htm" method="POST" name="frm1" >
    <div class="row" style="margin-top: 20px;">
      <div class="col-md-12">
      <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed"  > 
	   <thead>
	   <tr>
	   <th colspan="4">Select User  for <%if(DivisionName!=null){ %><%=DivisionName[1]%><%} %></th>
	  </tr>
	 
	   </thead>
    <tbody>
	    <tr>
	    
	     <td colspan="4">
					<select class="form-control form-control" name="LogInId" style="margin-left: 12px;" required="required" >
				<option value="" disabled="disabled" selected="selected">Select UserName </option>
				<%if(DivisionAssignList!=null){
				for(Object[] protype:OfficerList ){
	
	                           %>
								<option value="<%=protype[0] %>" 
								<%if(DivisionAssignList!=null){
									 for(Object[] obj:DivisionAssignList){ if(obj[2]!=null){ if(protype[1].toString().equalsIgnoreCase(obj[2].toString())){%>
									 hidden="hidden" <%}}}} %>
								
								><%=protype[1].toString() %></option>
								<%}} %>
					</select>
	    </td>
	    </tr>
	    </tbody>
</table>
 	
</div>
<div style="text-align: center;">
 <button type="submit" class="btn btn-success btn-sm " name="sub" value="edit"   >ASSIGN</button>&nbsp;&nbsp;
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" name="DivisionId" <%if(DivisionName!=null){ %>value="<%=DivisionName[0]%>"<%} %> />
</div>
      </div>
      </div>
      </form>
      </div>
      </div>
</div>
</div> 



</div> 



<script>
function Edit(myfrm){
	
	 var fields = $("input[name='logindivisionid']").serializeArray();

			  if (fields.length === 0){
				  bootbox.alert("Please Select One Record");
			 event.preventDefault();
			return false;
			}
			  var cnf=confirm("Are You Sure To Revoke!");
			  

			    
			  
			  if(cnf){
			
			return true;
			
			}
			  else{
				  event.preventDefault();
					return false;
					}
			
			}
</script>
<script>
$(document).ready(function() {
	   $('#name').on('change', function() {
	     $('#submit').click();

	   });
	});

</script>
</body>
</html>