<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    <%@page import="com.vts.dms.login.Login"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>USER MANAGER EDIT</title>
</head>
<body>

<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">USER EDIT</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
			<ol class="breadcrumb" >
				<li class="breadcrumb-item ml-auto"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item  " aria-current="page"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin </a></li>
				<li class="breadcrumb-item"><a href="UserManagerList.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> User Manager List</a></li>
				<li class="breadcrumb-item active">User Manager Edit</li>
			</ol>
		  </nav> 
		  </div>
		  </div>
</div>

<%
List<Object[]> RoleList=(List<Object[]>)request.getAttribute("RoleList");
Login login=(Login)request.getAttribute("UserManagerEditData");
List<Object[]> EmpList=(List<Object[]>)request.getAttribute("EmpList");
List<Object[]> LoginTypeList=(List<Object[]>)request.getAttribute("LoginTypeList");
%>

<div class="row"> 



	 <div class="col-sm-2"  >
	 </div>
 <div class="col-sm-8"  style="top: 10px;">
<div class="card"  style="background-color: aliceblue;">





<div class="card"  style="background-color: aliceblue;">
 <div align="center"><div class="badge badge-success">LoginType:<%=login.getLoginTypeDms() %>&nbsp;&nbsp;||&nbsp;Username:<%=login.getUsername() %> </div></div>
<div class="card-body">


<form name="myfrm" action="UserManagerEditSubmit.htm" method="POST" >
  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover  table-condensed "  >
      <tr>
      <th><label >USER NAME:<span class="mandatory" style="color: red;">*</span></label></th>
      <td  colspan="4" >
       <input  class="form-control form-control" placeholder="UserName" value="<%=login.getUsername() %>" type="text" name="UserName" required="required" maxlength="255" style="font-size: 15px;"  id="UserName" readonly="readonly">
      </td>
       </tr> 

    <tr>
    
    <th><label >LOGIN TYPE:<span class="mandatory" style="color: red;">*</span></label></th>
    <td >
   <select class="form-control selectpicker" name="LoginType" id="LoginType" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : LoginTypeList) {
				%>
				<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase( login.getLoginTypeDms())) {%> selected="selected" <%} %>><%=obj[1]%></option>
				<%
					}
				%>

			</select> 
 
    </td>
    </tr>
   
    
    
    <tr>
    <th><label >ROLE:<span class="mandatory" style="color: red;">*</span></label></th>
    <td >
    <select class="form-control selectpicker" name="Role" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : RoleList) {
				%>
				<option value="<%=obj[0]%>"  <%if(Integer.parseInt(obj[0].toString())==login.getFormRoleId()) {%> selected="selected" <%} %>><%=obj[1]%></option>
				<%
					}
				%>

			</select> 
     </td>
</tr>

<tr>
 <th>
<label >EMPLOYEE:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="2">
 <select class="form-control selectpicker" name="Employee" id="Employee" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : EmpList) {
				%>
				
				<option value="<%=obj[0]%>"  <%if(Long.parseLong(obj[0].toString())==login.getEmpId()) {%> selected="selected" <%} %>><%=obj[1]%>, <%=obj[2]%></option>
				<%
					}
				%>

			</select> 
</td>
  
   
   
</tr>



</table>

</div>
</div>

	  <div align="center"> 
	  <input type="submit"  class="btn btn-primary btn-sm submit" onclick="return confirm('Are you sure you want to edit this user?')"/>
	 <input type="hidden" name="LoginId" value="<%=login.getLoginId() %>" />
	 <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
		 </div>						
	  </form>
	
	  </div>
	  </div>
	  </div>
	  </div>
	  </div>
<script type="text/javascript">

$(document)
.on(
		"change",
		"#LoginType",

		function() {
			// SUBMIT FORM

	
			var $LoginType = this.value;

		
		
			if($LoginType=="D"||$LoginType=="G"||$LoginType=="T"||$LoginType=="O"||$LoginType=="B"||$LoginType=="S"||$LoginType=="C"||$LoginType=="P"||$LoginType=="U"){
			
				$("#Employee").prop('required',true);
			}
			else{
				$("#Employee").prop('required',false);
			}
	
		});

</script>
</body>
</html>