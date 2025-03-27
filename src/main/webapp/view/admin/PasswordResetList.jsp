<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PASSWORD RESET </title>
</head>
<body>


<div class="card-header page-top">
				<div class="row">
					<div class="col-md-3 heading-breadcrumb">
						<h5 style="font-weight: 700 !important">PASSWORD RESET</h5>
					</div>
					<div class="col-md-9 " >
						<nav aria-label="breadcrumb">
						  <ol class="breadcrumb ">
						    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						    <li class="breadcrumb-item  " aria-current="page"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin </a></li>
						    <li class="breadcrumb-item active">Password Reset</li>
						  </ol>
						</nav>
					</div>			
				</div>
		</div>

<%List<Object[]> UserManagerList=(List<Object[]>)request.getAttribute("UserManagerList"); %>


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

<div class="row datatables">
	<div class="col-md-12">
	
 		<div class="card shadow-nohover" >
			<div class="card-body"> 
			
     			<form action="PasswordReset.htm" method="POST" name="frm1">
 					<div class="table-responsive">
	   					<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" > 
	   						<thead>
	  							<tr>
	   								<th>Select</th>
	  								<th>Username</th>
	  								<th>Division</th>
	  								<th>Role</th>
	  							</tr>
	   						</thead>
   							<tbody>
	    						<%for(Object[] obj:UserManagerList){ %>
	    					<tr>
	 			 				<td><input type="radio" name="Lid" value=<%=obj[0]%>  ></td> 
	   							<td><%=obj[1] %></td>
	    						<td><%=obj[2] %></td>
	     						<td><%=obj[3] %></td>
	    					</tr>
	    						<%} %>
	    					</tbody>
						</table>
					</div>

 		<center><button type="submit" class="btn btn-primary btn-sm reset" name="sub" value="add"  >RESET</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</center>
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
	alert("PLESE SELECT ONE RECORD");
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
function Delete(myfrm){
	

	var fields = $("input[name='Lid']").serializeArray();

	  if (fields.length === 0){
	alert("PLESE SELECT ONE RECORD");
	 event.preventDefault();
	return false;
	}
	  var cnf=confirm("Are U Sure To Delete!");
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