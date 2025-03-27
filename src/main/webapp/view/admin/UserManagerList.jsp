<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>USER MANAGER</title>
</head>
<body>




<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">USER MANAGER LIST</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
			<ol class="breadcrumb" >
				<li class="breadcrumb-item ml-auto"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="AdminDashBoard.htm"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin</a></li>
				
				<li class="breadcrumb-item active">User Manager List</li>
			</ol>
				</nav>
			</div>			
		</div>
</div>

<%List<Object[]> UserManagerList=(List<Object[]>)request.getAttribute("UserManagerList"); %>


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></div>
                    <%} %>

<div class="row datatables">
	<div class="col-md-12">
	
 		<div class="card shadow-nohover" >
			<div class="card-body"> 
			
    			<form action="UserManager.htm" method="POST" name="frm1">
 					<div class="table-responsive">
	   					<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" > 
	   						<thead>
	   							<tr>
	   							<th>Select</th>
								<th>Employee</th>
								<th>User Name</th>
								<th>Division Name</th>
								<!-- <th style="width: 10%;">DMS Login</th> -->
								<th>Role</th>
	  							</tr>
	   						</thead>
    						<tbody>
	   	 						<%
	   	 						
	   	 						if(UserManagerList!=null && UserManagerList.size()>0){
	   	 						for(Object[] obj:UserManagerList){ %>
	    					<tr>
	  							<td style="text-align: center;"><input type="radio" name="Lid" value=<%=obj[0]%>></td>
	   						    <td style="text-align: left;"><%if(obj[5]!=null && obj[6]!=null){%><%=obj[5].toString()+", "+obj[6].toString() %><%}else{ %>-<%} %></td>
	    						<td><%if(obj[1]!=null){%><%=obj[1].toString() %><%}else{ %>-<%} %></td>
								<td><%if(obj[2]!=null){%><%=obj[2].toString() %><%}else{ %>-<%} %></td>
								<td style="text-align: left;"><%if(obj[3]!=null){%><%=obj[3].toString() %><%}else{ %>-<%} %></td>
	    					</tr>
	    						<%} }%>
	    					</tbody>
						</table>
					</div>

	<div align="center">
			<button type="submit" class="btn btn-primary btn-sm add" name="sub" value="add"  >ADD</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<%if(UserManagerList!=null){ %>
 			<button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<!-- <button type="submit" class="btn btn-danger btn-sm delete" name="sub" value="delete"  onclick="Delete(frm1)">DELETE</button> -->
 			<%} %>
 			
 	</div>
 	
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 </form>
</div>


</div>
</div>
</div>






<script type="text/javascript">

function Edit(myfrm){
	
	 var fields = $("input[name='Lid']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select a Record");
	 event.preventDefault();
	return false;
	}
		  return true;
	 
			
	}
function Delete(myfrm){

	var fields = $("input[name='Lid']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select a Record");
	 event.preventDefault();
	return false;
	}
	  var cnf=confirm("Are You Sure To Delete?");
	  if(cnf){
	
	return true;
	
	}
	  else{
		  event.preventDefault();
			return false;
			}
	
	}

</script>
</body>
</html>