<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>ROLE ADD</title>
<style>

.cardpad{
	    padding: 0.35rem 1.25rem !important;
}

.border .btn{
	padding: 2px !important
}
</style>

</head>
<body>

	<%
		List<Object[]> modulelist = (List<Object[]>) request.getAttribute("moduleList");
		List<Object[]> notacccessedFormList = (List<Object[]>) request.getAttribute("notacccessedFormList");
		List<Object[]> acccessedFormList = (List<Object[]>) request.getAttribute("acccessedFormList");
		String moduleNameF = (String) request.getAttribute("moduleName");
		String moduleidSelF = (String) request.getAttribute("moduleidSel");
		String roleId = (String) request.getAttribute("roleId");
		String roleName = (String) request.getAttribute("roleName");
		String message=(String) request.getAttribute("message");
		String moduleName=null;
		String moduleidSel=null;
		if(moduleNameF!=null){
			moduleName=moduleNameF;
		}else{
			moduleName="All";
		}
		if(moduleidSelF!=null){
			moduleidSel=moduleidSelF;
		}else{
			moduleidSel="0";
		}
	%>
	<input type="hidden" value="<%=roleId%>" id="roleid">
	<input type="hidden" value="<%=roleName%>" id="rolename">
	<div id="wrapper">
		<div id=" sub-container">

			<div class="card-header page-top">
				<div class="row">
					<div class="col-md-3 heading-breadcrumb">
						<h5 style="font-weight: 700 !important">ROLE FORM ACCESS </h5>
					</div>
					<div class="col-md-9 " >
						<nav aria-label="breadcrumb">
						  <ol class="breadcrumb ">
						    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						    <li class="breadcrumb-item  " aria-current="page"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin </a></li>
						    <li class="breadcrumb-item "><a href="FormRole.htm"><i class="fa fa-circle" aria-hidden="true"></i> Role </a></li>
						    <li class="breadcrumb-item active">Role Form Access</li>
						  </ol>
						</nav>
					</div>			
				</div>
			</div>
			

			<div class="row">
				<div class="col-sm-12">
				<div align="center">
			<%if(message!=null) {
			if("S".equalsIgnoreCase(message)){
			%>
			<font size="4" color="#00a000">Role Permissions Updated Successfully</font>
			<%}else if("F".equalsIgnoreCase(message)){ %>
			<font size="4" color="#a00000">Role Permissions Not Updated, Try Again!!</font>
			<%}} %>
			</div>

					<div class="row" style="padding: 0px 19px">
						<div class="col-sm-6">
							<div class="card" style="margin: 5px">

								<div class="card-header cardpad ">
									<b><font size="3" color="#800020">Already Added
											Forms</font><font size="3" color="#0000a0"> For The Role : <%=roleName%></font></b>
								</div>

								<div style="margin: 5px">


									<form name="myfrm" action="FormRoleAccessDelete.htm"
										method="POST">
										<input type="hidden" value="<%=roleId%>" name="roleId">
										<input type="hidden" value="<%=roleName%>" name="roleName">
										<input type="hidden" value="<%=moduleidSel%>" name="moduleId">
										<input type="hidden" value="<%=moduleName%>" name="moduleName">
										<table	class="scrolltable datatablex table table-bordered table-hover table-striped table-condensed table-sm ">
											<thead>
												<tr style="background-color: #005C97; color: #fff;">
													<th>Select All &nbsp;<input type="checkbox" id="selectall"></th>
													<th style="text-align: left;">Form Name</th>
												</tr>
											</thead>
											<tbody>
												<%
													for (Object[] obj : acccessedFormList) {
												%>
												<tr>
													<td><input type="checkbox" class="checkboxall" name="roleFormAccessId"
														value=<%=obj[0]%>></td>
													<td style="text-align: left;"><%=obj[2]%></td>
												</tr>
												<%
													}
												%>
											</tbody>
										</table>

										<div align="center">
											<button type="submit" class="btn btn-danger btn-sm delete" onclick="return deleteConform()">Deny Access</button>
										</div>
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
									</form>
								</div>
							</div>
						</div>


						<!-- /////add Forms -->
						<div class="col-sm-6">
							<div class="card" style="margin: 5px">
								<div class="card-header cardpad ">
									<b><font size="3" color="#800020">New Forms</font></b>


									<div style="float: right;">
										<div class="form-inline">
											<div class="form-group ">
												<label style="font-size: 15px;"><b>Module: </b><span
													class="mandatory" style="color: red;">*</span> </label>
											</div>
											<div class="form-group border">
												<select onchange="getFormRoleNew()" id="moduleidNew"
													class="selectpicker" data-live-search="true">
													<%
														if (moduleNameF != null) {
													%>
													<option value="<%=moduleidSel%>--<%=moduleName%>"><%=moduleName%></option>
													<%
														}
													%>
													<option value="0--All">All</option>
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

								<div style="margin: 5px">
									<form name="myfrm" action="FormRoleAccessAdd.htm" method="POST">
										<input type="hidden" value="<%=roleId%>" name="roleId">
										<input type="hidden" value="<%=roleName%>" name="roleName">
										<input type="hidden" value="<%=moduleidSel%>" name="moduleId">
										<input type="hidden" value="<%=moduleName%>" name="moduleName">

										<table
											class="scrolltable datatablex table table-bordered table-hover table-striped table-condensed table-sm">
											<thead>
												<tr style="background-color: #005C97; color: #fff;">
													<th>Select All &nbsp;<input type="checkbox" id="selectall1"></th>
													<th style="text-align: left;">Form Name</th>
												</tr>
											</thead>
											<tbody>
												<%
													if (notacccessedFormList != null) {
														for (Object[] obj : notacccessedFormList) {
												%>
												<tr>
													<td><input type="checkbox" class="checkboxall1" name="formdetailId"
														value=<%=obj[0]%>></td>
													<td style="text-align: left;"><%=obj[1]%></td>
												</tr>
												<%
													}
													}
												%>
											</tbody>
										</table>

										<div align="center">
											<button style="width:20%;" type="submit" class="btn btn-primary btn-sm submit" onclick="return submitChecked()">Allow Access</button>
										</div>
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
									</form>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

</body>


<script type="text/javascript">
	$('.scrolltable').dataTable({
		"scrollY" : "290px",
		"scrollCollapse" : true,
		"paging" : false,
		fixedHeader : true,
		"ordering" : false,
		columnDefs : [ {
			width : 50,
			targets : 0
		},

		],
		fixedColumns : false
	});
</script>


<!-- <script type="text/javascript">
	function getFormRole() {
		var moduleid = $("#moduleid").val();
		var roleid = $("#roleid").val();
		var roleName = $("#rolename").val();
		// 		var accessedmoduleId = $("#accessedmoduleId").val();
		window.location.href = "FormRoleAccessEditSelected.htm?module="
				+ moduleid + "&roleid=" + roleid + "&roleName=" + roleName;

	}
</script> -->


<script type="text/javascript">
	function getFormRoleNew() {
		var moduleid = $("#moduleidNew").val();
		var roleid = $("#roleid").val();
		var roleName = $("#rolename").val();
		// 		var accessedmoduleId = $("#accessedmoduleId").val();
		window.location.href = "FormRoleAccessEditSelected.htm?module="
				+ moduleid + "&roleid=" + roleid + "&roleName=" + roleName;

	}
</script>

<script type="text/javascript">


$(document).ready(function(){
    // Handle the click event on selectall checkbox
    $("#selectall").click(function(){
        // Update the state of all checkboxes based on the selectall checkbox
        $('.checkboxall').prop('checked', this.checked);
    });

    // Handle the click event on individual checkboxes
    $('.checkboxall').click(function(){
        // Check if any of the checkboxes are unchecked
        if ($('.checkboxall:not(:checked)').length > 0) {
            // If at least one checkbox is unchecked, uncheck the selectall checkbox
            $("#selectall").prop('checked', false);
        } else {
            // If all checkboxes are checked, check the selectall checkbox
            $("#selectall").prop('checked', true);
        }
    });
});


/* $(document).ready(function(){
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
	}); */
</script>

<script type="text/javascript">

$(document).ready(function(){
    // Handle the click event on selectall checkbox
    $("#selectall1").click(function(){
        // Update the state of all checkboxes based on the selectall checkbox
        $('.checkboxall1').prop('checked', this.checked);
    });

    // Handle the click event on individual checkboxes
    $('.checkboxall1').click(function(){
        // Check if any of the checkboxes are unchecked
        if ($('.checkboxall1:not(:checked)').length > 0) {
            // If at least one checkbox is unchecked, uncheck the selectall checkbox
            $("#selectall1").prop('checked', false);
        } else {
            // If all checkboxes are checked, check the selectall checkbox
            $("#selectall1").prop('checked', true);
        }
    });
});

/* $(document).ready(function(){
	$("#selectall1").click(function(){
	        if(this.checked){
	            $('.checkboxall1').each(function(){
	                $(".checkboxall1").prop('checked', true);
	            })
	        }else{
	            $('.checkboxall1').each(function(){
	                $(".checkboxall1").prop('checked', false);
	            })
	        }
	    });
	}); */
</script>

<script>
function deleteConform() {
var checkedValue=$("input[name='roleFormAccessId']:checked").val();	
  if(checkedValue>0){
	  var txt;
	  var r = confirm("Are You Sure To Delete!");
	  if (r == true) {
	    return true;
	  } else {
	    return false;
	  }  
  }else{
	  alert("Please Select Checkbox");
	  return false;
  }
  
}


function submitChecked() {
	var checkedValue=$("input[name='formdetailId']:checked").val();	
	  if(checkedValue>0){
		  return true;
	  }else{
		  alert("Please Select Checkbox");
		  return false;
	  }
	  
	}


</script>

</html>