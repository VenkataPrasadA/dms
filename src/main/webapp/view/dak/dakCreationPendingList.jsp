<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Creation Pending List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
.modal-dialog-jump {
  animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
</head>
<body>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important;font-size: 1.01rem!important;">DAK Creation Pending List </h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active" >DAK Creation Pending List</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>
<%
List<Object[]> dakCreationPendingList=(List<Object[]>)request.getAttribute("dakCreationPendingList");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
	    	<%=ses1 %>
	    </div>
    </div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
        	<%=ses %>
        </div>
    </div>
<%} %>

		<div class="card" style="width: 99%">
			<div class="card-body"> 
				<div class="table-responsive">
					<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
						<thead>
							<tr>
								<th style="text-align: center;">SN</th>
								<th style="text-align: center;">DAK Id</th>
								<th style="text-align: center;">Ref No & Date</th>
								<th style="text-align: center; width: 10%;">Action Due</th>
								<th style="text-align: center;">Subject</th>
								<th style="text-align: center;width:60px;">Status</th>
								<th style="text-align: center; width: 15%;">Action</th>
							</tr>
						</thead>
						  <tbody>
								<%
								    int count=1;
								if(dakCreationPendingList!=null && dakCreationPendingList.size()>0){
									for (Object[] obj : dakCreationPendingList) {
								%>
							
								    <tr>
									<td style="text-align: center;width:10px;"><%=count++%></td>
									<td style="text-align: left;width:80px;"><%=obj[1]%></td>
								    <td class="wrap"  style="text-align: left;width:130px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %><br><%=sdf.format(obj[3])%></td>
								    <td><%if(obj[5]!=null){ %><%=sdf.format(obj[5]) %><%}else{ %><%="NA" %><%} %></td>
									<td class="wrap"  style="text-align: left;width:180px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center;">
									
									<%if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("DI")){ %>
									
									<%="Dak Created" %>
									
									<%}else if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("DI")){ %>
									<%="Dak Distributed" %>
									<%}else{ %>-<%} %>
									</td>
									<td>
									<form action="DakCreateEdit.htm" method="POST" name="myfrm" id="myfrm" >
									<button type="submit" class="btn btn-sm icon-btn" data-toggle="tooltip" data-placement="top" title="Edit">
 											<img alt="edit" src="view/images/writing.png">
 										  </button>
 								    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
			                        <input type="hidden" name="DakCreateId"	value="<%=obj[0] %>" /> 
 								   </form>
									</td>
								</tr>
								<%}}%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
</body>
<script type="text/javascript">
$("#myTable1").DataTable({	
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	
</script> 
</html>