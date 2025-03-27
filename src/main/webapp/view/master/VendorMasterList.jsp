<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
         <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>VENDOR DETAILS</title>

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
				<h5 style="font-weight: 700 !important">VENDOR DETAILS</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item active">Vendor Details</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>

<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> VendorMasterList=(List<Object[]>) request.getAttribute("VendorMasterList");

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
    <form action="#" method="POST" name="frm1">
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	   <thead>
	   <tr>
	   <th>Select</th>
	  <th>Vendor Code</th>
	  <th>Vendor Name</th>
	  <th>Address</th>
	  <th>City</th>
	  <th>Pin Code</th>
	  <th>CPP Register ID</th>
<!-- 	  <th>CONTACT PERSON</th> -->
<!-- 	  <th>TEL NO</th> -->
<!-- 	  <th>FAX NO</th> -->
<!-- 	  <th>EMAIL</th> -->
<!-- 	  <th>CPP REGISTER ID</th> -->
<!-- 	  <th>REGISTRATION NO</th> -->
<!-- 	  <th>REGISTRATION DATE</th> -->
<!-- 	  <th>VALIDITY DATE</th> -->
<!-- 	  <th>PRODUCT RANGE</th> -->
<!-- 	  <th>VENDOR TYPE</th> -->
<!-- 	  <th>GST NO</th> -->
<!-- 	  <th>VENDOR BANK</th> -->
<!-- 	  <th>ACCOUNT NO</th> -->
	  </tr>
	   </thead>
    <tbody>
	    <%for(Object[] obj:VendorMasterList){ %>
	    <tr>
	  <td><input type="radio" name="Did" value=<%=obj[0]%>  ></td> 
	   <td ><%=obj[1] %></td>
<%-- 	    <td><%=sdf.format(obj[2]) %></td> --%>
	    <td style="text-align: left"><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
	     <td style="text-align: left"> <%if(obj[3]!=null){%><%=obj[3] %><%}else{ %>-<%} %></td>
	     <td style="text-align: left"><%if(obj[4]!=null){%><%=obj[4] %><%}else{ %>-<%} %></td>
	   <td><%if(obj[5]!=null){%><%=obj[5] %><%}else{ %>-<%} %></td>
	   	   <td><%if(obj[10]!=null){%><%=obj[10] %><%}else{ %>-<%} %></td>
	   
<%-- 	    <td style="text-align: left"><%if(obj[6]!=null){%><%=obj[6] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[7]!=null){%><%=obj[7] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[8]!=null){%><%=obj[8] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[9]!=null){%><%=obj[9] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[10]!=null){%><%=obj[10] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[11]!=null){%><%=obj[11] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[12]!=null){%><%=obj[12] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[13]!=null){%><%=obj[13] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[14]!=null){%><%=obj[14] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[15]!=null){%><%=obj[15] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[16]!=null){%><%=obj[16] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[17]!=null){%><%=obj[17] %><%}else{ %>-<%} %></td> --%>
<%-- 	    <td style="text-align: left"><%if(obj[18]!=null){%><%=obj[18] %><%}else{ %>-<%} %></td> --%>
	    </tr>
	    <%} %>
	    </tbody>
</table>
 	
</div>

 <center> <button type="submit" class="btn btn-primary btn-sm add" name="sub" value="add">ADD</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<%if(VendorMasterList!=null&&VendorMasterList.size()>0){ %>
 <button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	<button type="submit" class="btn btn-danger btn-sm delete" name="sub" value="delete"  onclick="Delete(frm1)">DELETE</button></center> 
  	<%} %> 
 	<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
 	</form>
</div>


</div>
</div>
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