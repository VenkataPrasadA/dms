<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PASSWORD CHANGE</title>
</head>
<body>


<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">Password Change</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				     <li class="breadcrumb-item  " aria-current="page"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin </a></li>
				    <li class="breadcrumb-item active">Password Change</li>
				  </ol>
				</nav>
			</div>			
		</div>
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

<div class="row"> 



	 <div class="col-sm-2"  >
	 </div>
 <div class="col-sm-8"  style="top: 10px;">
<div class="card" >

<div class="card-body">
<form name="myfrm" action="PasswordChange.htm" method="POST" >
  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed"  >
  <thead>
<tr>
  <th>
<label >OLD PASSWORD:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  class="form-control form-control" placeholder="OldPassword" type="password" name="OldPassword" required="required" maxlength="255" style="font-size: 10px;">
</td>
 <th>
<label >NEW PASSWORD:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  class="form-control form-control" placeholder="NewPassword" type="password" name="NewPassword" required="required" maxlength="255" style="font-size: 10px;">
</td>
</tr>



</thead> 
</table>

</div>
</div>

	  <center><input type="submit"  class="btn btn-primary btn-sm"          /></center>
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	  </div>
<script type="text/javascript">
$(document).ready(function(){
	
	  $("#myTable").DataTable({
	 "lengthMenu": [  25, 50, 75, 100 ],
	 "pagingType": "simple",
	    scrollY:        250,
     
       scrollCollapse: true,
      
  
	        dom: 'lBfrtip',
	        buttons: [
	            'copy', 'csv', 'excel', 'pdf', 'print'
	        ],
	       "order": [],
	      "columnDefs": [ {
	        "targets"  : 'no-sort',
	        "orderable": false,
	      }]
	  
});
  });
</script>
</body>
</html>