<%@page import="com.vts.dms.admin.model.FormDetail"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title></title>



</head>
<body>

			
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">FORM DETAILS</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin </a></li>
				    <li class="breadcrumb-item active">Form Details </li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>

			<%
				List<Object[]> formDetails = (List<Object[]>) request.getAttribute("formDetails");
			%>

			<div class="row datatables">

				<div class="col-md-12">
				 <div class="card shadow-nohover" >

<div class="card-body"> 
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover table-striped table-condensed " id="myTable">
							<thead>
								<tr >
									<th style="text-align: left;">Module</th>
									<th style="text-align: left;">Form Name</th>
									<th style="text-align: left;">Form Display Name</th>
									<th style="text-align: left;">Form Colours</th>
								</tr>
							</thead>
							<tbody>
								<%
									for (Object[] obj : formDetails) {
								%>
								<tr>
									<td style="text-align: left;"><%=obj[0]%></td>
									<td style="text-align: left;"><%=obj[1]%></td>
									<td style="text-align: left;"><%=obj[2]%></td>
									<td style="text-align: left;"><%=obj[3]%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>

					</div>

				</div>


			</div>
		</div>
	</div>

</body>



</html>