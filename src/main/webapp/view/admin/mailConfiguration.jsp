<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Mail Confiuguration</title>
</head>
<body>

<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">MAIL CONFIGURATION LIST</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
			<ol class="breadcrumb" >
				<li class="breadcrumb-item ml-auto"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="AdminDashBoard.htm"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin</a></li>
				<li class="breadcrumb-item active">Mail Configuration List</li>
			</ol>
				</nav>
			</div>			
		</div>
</div>

<%List<Object[]> MailConfigurationList=(List<Object[]>)request.getAttribute("mailConfigurationList"); %>

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
			
				<form  method="POST" name="frm1">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				
				<div class="table-responsive">
	   					<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable1" > 
	   					<thead>
	   							<tr>
	   							<th>Select</th>
	   							<th>Type Of Host</th>
	   							<th>User Name</th>
	   							<th>Host</th>
								<th>Port</th>
	  							</tr>
	   						</thead>
	   						<tbody>
	   						<%if(MailConfigurationList!=null && MailConfigurationList.size()>0){
	   	 						String TypeOfHost = null;
	   							for(Object[] obj:MailConfigurationList){ 
	   							if(obj[3]!=null){
	   								if("L".equalsIgnoreCase(obj[3].toString())){
	   									TypeOfHost = "Lab Email";
	   								}else if("D".equalsIgnoreCase(obj[3].toString())){
	   									TypeOfHost = "Drona Email";
									}
	   							}
	   							%>
	   	 						<tr>
	   	 						<td style="text-align: center; " ><input type="radio" name="Lid" value=<%=obj[0]%>></td>
	   	 						<td><%if(obj[3]!=null){%><%=TypeOfHost%><%}else{ %>-<%} %></td>
	   						 	<td><%if(obj[1]!=null){%><%=obj[1].toString() %><%}else{ %>-<%} %></td>
								<td><%if(obj[2]!=null){%><%=obj[2].toString() %><%}else{ %>-<%} %></td>
								<td><%if(obj[4]!=null){%><%=obj[4].toString() %><%}else{ %>-<%} %></td>
	   	 						</tr>
	   	 						<%} %>
	   	 					<%} else{%>
	   	 					<tr><td colspan="5" style="text-align: center;">No records found.</td></tr>
	   	 					<%} %>
	   						</tbody>
	   					</table>
	   			</div>	
	   			<div align="center">
			<button type="submit" formaction="MailConfigurationAdd.htm" class="btn btn-primary btn-sm add" id="MailConfigAddBtn" >ADD</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   			
	   			
	   			<%if(MailConfigurationList!=null && MailConfigurationList.size()>0){%>
	   			<button type="submit" formaction="MailConfigurationEdit.htm" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   			
	   			  <button type="submit"   formaction="MailConfigurationDelete.htm" class="btn btn-danger btn-sm delete"  onclick="Delete(frm1)" >DELETE</button>
	 <%} %>
	   			</div>
	   				
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
	  var isConfirmed = confirm("Are you sure you want to delete?");
	    
	    if (isConfirmed) {
	        return true;
	    } else {
	        event.preventDefault();
	        return false;
	    }
	 
			
	}
	</script>
</body>
</html>