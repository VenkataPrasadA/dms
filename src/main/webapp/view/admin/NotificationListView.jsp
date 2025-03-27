<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
         <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>NOTIFICATION LIST</title>

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
<body>


<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">Notification List</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item active">Notification List</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>


<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> NotificationList=(List<Object[]>) request.getAttribute("NotificationList");

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



<div class="row datatables">
<div class="col-md-12">

 <div class="card shadow-nohover" >

<div class="card-body"> 

 
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	   <thead>
	   <tr>
	  
	  <th>DATE</th>
	  <th>NOTIFICATION</th>
	
	  </tr>
	   </thead>
    <tbody>
	    <%
	    if(NotificationList!=null && NotificationList.size()>0){
	    for(Object[] obj:NotificationList){ %>
	    <tr>
	 
	   <td >
	    <%if(obj[2]!=null){ %>
	   <%=sdf.format(obj[2]) %><%}else{ %>--<%} %></td>

	    <td style="text-align: left"><%if(obj[3]!=null){%><%=obj[3] %><%}else{ %>--<%} %></td>

	    </tr>
	    <%} }else{%>
	     <tr>
	    <td colspan="2" >No Records Found.</td>
	    </tr>
	    <%} %>
	    </tbody>
</table>
 	
</div>

 
</div>


</div>
</div>
</div>

<script type="text/javascript">



function Edit(myfrm){
	
	 var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("PLEASE SELECT ONE RECORD");
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
function Delete(myfrm){
	

	var fields = $("input[name='Did']").serializeArray();

	  if (fields.length === 0){
	alert("PLEASE SELECT ONE RECORD");
	 event.preventDefault();
	return false;
	}
	  var cnf=confirm("Are You Sure To Delete!");
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