<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>ROLE EDIT</title>
</head>
<body>

	<%
		String msg = (String) request.getAttribute("");
		List<Object[]> roleList = (List<Object[]>) request.getAttribute("roleDetails");
		long formroleId = 0;
		String formroleName = null;
		if (roleList != null) {
			Object[] roleArray = roleList.get(0);
			formroleId = Long.parseLong(roleArray[0].toString());
			formroleName = roleArray[1].toString();
		}
	%>

	<div id="wrapper">
		<div id=" sub-container">

			<div class="card-header page-top">
				<div class="row">
					<div class="col-md-3 heading-breadcrumb">
						<h5 style="font-weight: 700 !important">ROLE EDIT</h5>
					</div>
					<div class="col-md-9 " >
						<nav aria-label="breadcrumb">
						  <ol class="breadcrumb ">
						    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						    <li class="breadcrumb-item  " aria-current="page"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin</a></li>
						    <li class="breadcrumb-item "><a href="FormRole.htm"><i class="fa fa-circle" aria-hidden="true"></i> Role </a></li>
						    <li class="breadcrumb-item active">Role Edit</li>
						  </ol>
						</nav>
					</div>			
				</div>
			</div>
			



			<div class="row">

				<div class="col-sm-3"></div>
				<div class="col-sm-6" style="top: 10px;">
					<div class="card">
						<div class="card-header" style="font-family: 'Lato',sans-serif;">
							<b>Role Edit Form</b>
							<div align="center">
								<%
									if (msg != null && "AE".equals(msg)) {
								%>
								<font color="red"><b>Role Name</b></font>
								<%
									}
								%>
							</div>
						</div>

						<div class="card-body">
							<form name="myfrm" action="FormRoleAddEdit.htm" method="POST">
								<div class="form-group">
									<div class="table-responsive">
										<table
											class="table table-bordered table-hover table-striped table-condensed">
											<thead>
												<tr>
													<th><label>ROLE NAME: <span class="mandatory"
															style="color: red;">*</span>
													</label></th>
													<td><input class="form-control form-control"
														type="text" name="formroleName" required="required"
														maxlength="255" style="font-size: 15px;"
														value="<%=formroleName%>"> 
														<input type="hidden"
														name="formroleId" value="<%=formroleId %>" /></td>

												</tr>



											</thead>
										</table>

									</div>
								</div>
								<div align="center">
									<input type="submit" class="btn btn-primary btn-sm submit" /> <input
										type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
								</div>
							</form>


						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {

			$("#myTable").DataTable({
				"lengthMenu" : [ 25, 50, 75, 100 ],
				"pagingType" : "simple",
				scrollY : 250,

				scrollCollapse : true,

				dom : 'lBfrtip',
				buttons : [ 'copy', 'csv', 'excel', 'pdf', 'print' ],
				"order" : [],
				"columnDefs" : [ {
					"targets" : 'no-sort',
					"orderable" : false,
				} ]

			});
		});
	</script>
</body>
</html>