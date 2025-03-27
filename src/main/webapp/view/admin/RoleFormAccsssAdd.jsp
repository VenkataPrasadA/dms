<%@page import="java.math.BigInteger"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" href="https://cdn.datatables.net/fixedcolumns/3.3.0/js/dataTables.fixedColumns.min.js" /> -->
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>ROLE ADD</title>
<style>
/* .table td, .table th {
	padding-top: 0px;
	padding-bottom: 0px;
	padding-left: 10px;
	vertical-align: middle;
} */

.border {
	border-style: groove;
/* 	border-radius: 15px 50px; */
/*   background: #73AD21; */
/*   padding: 20px;  */
/*   width: 200px; */
/*   height: 150px; */
}
</style>

</head>
<body>

	<%
		String roleName = (String) request.getAttribute("roleName");
		List<Object[]> modulelist = (List<Object[]>) request.getAttribute("moduleList");
		List<Object[]> formlist = (List<Object[]>) request.getAttribute("formlist");
		long roleId = (long) request.getAttribute("roleId");
		String moduleName = (String) request.getAttribute("moduleName");
		String moduleidSel = (String) request.getAttribute("moduleId");
		String accmoduleId = (String) request.getAttribute("accessedmoduleId");
		long accessedmoduleId=0;
		if(accmoduleId!=null){
			accessedmoduleId=Long.parseLong(accmoduleId);
		}
	%>
	<input type="hidden" value="<%=roleId%>" id="roleid">
	<input type="hidden" value="<%=roleName%>" id="roleName">
	<input type="hidden" value="<%=accessedmoduleId%>" id="accessedmoduleId">
	<div id="wrapper">
		<div id=" sub-container">
			<div class="row">
				<div class="col-md-12">
					<section class="content-header">
						<h5>Role Form Access</h5>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="welcome"><i
									class="fa fa-home"></i> Home</a></li>
							<li class="breadcrumb-item"><a href="AdminDashBoard.htm">
									Admin Dashbord</a></li>
							<li class="breadcrumb-item"><a href="FormRole.htm"> Role
									List</a></li>
							<li class="breadcrumb-item active">Role Form Access</li>
						</ol>
					</section>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-1"></div>
				<div class="col-sm-10">
					<div class="card">

						<div class="card-header" style="padding: 5px;">
							<%
								if (roleName != null) {
							%>
							<b style="font-size: 20;">You can Access Form For The Role :
								<%=roleName%></b>
							<%
								}
							%>

							<div style="float: right;">
								<div class="form-inline">
									<div class="form-group ">
										<label style="font-size: 20px;">Select Module: <span
											class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="form-group border">
										<select onchange="getFormRole()" id="moduleid"
											class="selectpicker" data-live-search="true">
											<%
												if (moduleName != null) {
											%>
											<option value="<%=moduleidSel%>--<%=moduleName%>"><%=moduleName%></option>
											<%
												}
											%>
											<%
												if (modulelist != null) {
													for (Object[] obj : modulelist) {
											%>
											<option value="<%=obj[0]%>--<%=obj[1]%>"><%=obj[1]%></option>
											<%
												}
												}
											%>
										</select>
									</div>
								</div>

							</div>
						</div>

						<div class="card-body" style="padding-top: 0px;">
							<div class="form-group"></div>

							<form name="myfrm" action="FormRoleAccessAdd.htm" method="POST">

								<div class="form-group">

									<table
										class=" datatablex table table-bordered table-hover table-striped table-condensed table-sm"
										id="scrolltable">
										<thead>
											<tr style="background-color: #003366; color: #fff;">
												<th>Click For Select All&nbsp;
												<input type="checkbox" name="formdetailId" value="" id="selectall">
												</th>
												<th>Form Name</th>
											</tr>
										</thead>
										<tbody>
										
										<%
										long moduleId = 0;
										if (formlist != null) {
											for (Object[] obj : formlist) {
												BigInteger bigint = (BigInteger) obj[1];
												moduleId = bigint.longValue();
									%>
									
									<tr>
									<td><input type="checkbox" class="checkboxall" name="formdetailId" value="<%=obj[0]%>" required="required"></td>
									<td><%=obj[2]%></td>
									</tr>
									
									<%
										}
										}
									%>
										
										</tbody>
										</table>
								</div>


								<div align="center">
									<input type="submit" class="btn btn-primary btn-sm" />
								</div>
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden" name="roleId"
									value="<%=roleId%>"> 
									<input type="hidden"
									name="moduleId" value="<%=moduleId%>">
									<input type="hidden" value="<%=roleName%>" name="roleName">
							</form>


						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	function getFormRole() {
		var moduleid = $("#moduleid").val();
		var roleid = $("#roleid").val();
		var roleName = $("#roleName").val();
		var accessedmoduleId = $("#accessedmoduleId").val();
		window.location.href = "FormRoleAccessSelected.htm?module=" + moduleid
				+ "&roleid=" + roleid + "&roleName=" + roleName+"&accessedmoduleId="+accessedmoduleId;
	}
</script>
<script type="text/javascript">
	$('#scrolltable').dataTable({
		"scrollY" : "260px",
		"scrollCollapse" : true,
		"paging" : false,
		 columnDefs: [
	            { width: 150, targets: 0 },
	            
	        ],
	        fixedColumns: true
	});
</script>
<script type="text/javascript">

$(document).ready(function(){
	$("#selectall").click(function(){
	        if(this.checked){
	            $('.checkboxall').each(function(){
	                $(".checkboxall").prop('checked', true);
	            })
	        }else{
	            $('.checkboxall').each(function(){
	                $(".checkboxall").prop('checked', false);
	            })
	        }
	    });
	});
</script>


</html>