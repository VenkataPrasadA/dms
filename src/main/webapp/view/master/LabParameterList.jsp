<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
         <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>LAB PARAMETER</title>

<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />


 <spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" />

<style type="text/css">
label{
  font-weight: bold;
  font-size: 13px;
}
</style>
</head>
<body >


<div class="row">
<div class="col-md-12">
<section class="content-header">
			<h5>LAB PARAMETER</h5>
			<ol class="breadcrumb" >
				<li class="breadcrumb-item"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="MasterDashBoard.htm"> Master Dashboard</a></li>
				
				<li class="breadcrumb-item active">Lab Parameter List</li>
			</ol>
		  </section> 
		  </div>
</div>


<%
List<Object[]> LabParameterList=(List<Object[]>) request.getAttribute("LabParameterList");

%>






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


<div class="col-md-2"></div>

<div class="col-md-8">
 <div class="card shadow-nohover" >

<div class="card-body"> 

    <form action="#" method="POST" name="frm1">
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	   <thead>
	   <tr>
	   <th>Select</th>
	  <th>Lab Key</th>
	  <th>Mode Description</th>
	  <th>Lab Value</th>
	  </tr>
	   </thead>
    <tbody>
	    <%for(Object[] obj:LabParameterList){ %>
	    <tr>
	  <td><input type="radio" name="Did" value=<%=obj[0]%>  ></td> 
	   <td style="text-align: left"><%=obj[1] %></td>

	    <td style="text-align: left"><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
	    <td style="text-align: left"><%=obj[3] %></td>
	    </tr>
	    <%} %>
	    </tbody>
</table>
 	
</div>

 <center> 
<%if(LabParameterList!=null&&LabParameterList.size()>0){ %>
 <button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
 
 
	
 
 
  	<%} %> 
 	<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
 	</form>
</div>


</div>
</div>
<div class="col-md-2"></div>
</div>
<script type="text/javascript">



function Edit(myfrm){
	
	 var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
function Delete(myfrm){
	

	var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
	  var cnf=confirm("Are You Sure to Delete !");
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