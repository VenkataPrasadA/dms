<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>ROLE LIST</title>
</head>
<body>
	<div id="wrapper">
		<div id=" sub-container">

<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">ROLE LIST</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin </a></li>
				    <li class="breadcrumb-item active">Role</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>



			<%
				List<Object[]> RoleList = (List<Object[]>) request.getAttribute("RoleList");
			%>
			<%
				String ses = (String) request.getParameter("result");
				String ses1 = (String) request.getParameter("resultfail");
				String status = (String) request.getParameter("msg");
				if (ses1 != null) {
			%>
			<div class="alert alert-danger" role="alert">
				<%=ses1%>
			</div>
			<%
				}
				if (ses != null) {
			%>

			<div class="alert alert-success" role="alert">
				<%=ses%>
			</div>
			<%
				}
			%>
			
			<div align="center">
			<%if(status!=null){ 
			if("S".equalsIgnoreCase(status)){
			%>
			<div class="alert alert-success" role="alert">
				<font>Transaction Successful</font>
			</div>
			<%
				}else if("F".equalsIgnoreCase(status)){
			%>
			
			<div class="alert alert-danger" role="alert">
				<font>Transaction unsuccessful</font>
			</div>
			
			<%
				}}
			%>
			</div>

			<div class="row">
				<div class="col-md-1"></div>
			
				<div class="col-md-10">
				
				<div class="card shadow-nohover" >
					<div class="card-body"> 
    					<form action="FormRoleAdd.htm" method="POST" name="frm1" >
 							<div class="table-responsive">
	   							<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	   								<thead>
	   								<tr >
										<th>Select</th>
										<th>Role Name</th>
										
									</tr>
	   								</thead>
	   								
    								<tbody>
	    								<%for(Object[] obj:RoleList){ %>
	   	 							<tr>
										<td><input type="radio" name="roleId" value=<%=obj[0]%>--<%=obj[1]%>></td>
										<td><%=obj[1]%></td>
										
									</tr>
									<%
										}
									%>
		
								</table>
							</div>



		<center>
	 		<button type="submit" class="btn btn-primary btn-sm add" name="sub" value="add"  style="margin: 4px;">ADD</button>
					
 				<%if(RoleList!=null&&RoleList.size()>0){ %>
					<button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)" style="margin: 4px;" >EDIT</button>
					
					<button type="submit" class="btn btn-info btn-sm roleform" name="sub" value="roleaccess" onclick="Edit(frm1)"  style="margin: 4px;">Form Role Permissions</button>
		
 				<%} %>
 		</center>
 		
 					<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
				
		</form>
								
 	 			  <%-- <div align="center" style="margin-left: 383px;"> 
					<form action="FormRoleAdd.htm" name="frm1" method="post">
						<button type="submit" class="btn btn-primary btn-sm add" name="sub"	value="add" >ADD</button>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					</form> --%>
					
				</div>  
				
			</div>
		</div>
			
	<div class="col-md-1"></div>
				
	</div>
</div>


</div>

		

<script>
function Edit(myfrm){
	
	 var fields = $("input[name='roleId']").serializeArray();

	  if (fields.length === 0){
	alert("PLESE SELECT A RECORD");
	 event.preventDefault();
	return false;
	}
	 

		  return true;
	 
			
	}

</script>


</body>
</html>