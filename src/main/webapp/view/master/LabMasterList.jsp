<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>LAB DETAILS</title>


<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />


 <spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" /> 

<style type="text/css">
label{
  font-weight: bold;
  font-size: 15px;
}
.table thead tr th {
	text-align: left;	
}

.table thead tr  {
	color:black !important;
	background: white !important;
}

</style>
</head>
<body>

<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">LAB DETAILS</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item active">Lab Details</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	


<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> LabMasterList=(List<Object[]>) request.getAttribute("LabMasterList");

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
    
    
<%--  <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	   <thead>
	   <tr>
	   <th>Select</th>
	  <th>Lab Code</th>
	  <th>Lab Name</th>
	  <th>Lab Unit Code</th>
	  <th>Lab Address</th>
	  <th>Lab City</th>
	  <th>Lab Pin</th>
	  </tr>
	   </thead>
    <tbody>
	    <%for(Object[] obj:LabMasterList){ %>
	    <tr>
	  <td><input type="radio" name="Did" value=<%=obj[0]%>  ></td> 
	   <td style="text-align: left"><%=obj[1] %></td>
	    <td><%=sdf.format(obj[2]) %></td>
	    <td style="text-align: left"><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
	     <td> <%if(obj[3]!=null){%><%=obj[3] %><%}else{ %>-<%} %></td>
	     <td style="text-align: left"><%if(obj[4]!=null){%><%=obj[4] %><%}else{ %>-<%} %></td>
	   <td style="text-align: left"><%if(obj[5]!=null){%><%=obj[5] %><%}else{ %>-<%} %></td>
	    <td><%if(obj[6]!=null){%><%=obj[6] %><%}else{ %>-<%} %></td>
	    </tr>
	    <%} %>
	    </tbody>
</table>
 	
</div> --%>



<div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
  
<%for(Object[] obj:LabMasterList){ %>

<tr>
  <th style="width:20%" colspan="3">
<label >Lab Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5" >
 
<input value=<%=obj[1]%>  readonly class="form-control form-control" type="text" name="LabCode" required="required" maxlength="10" style="font-size: 15px; "  id="LabCode" >

 
</td>

</tr>


<tr>
 <th colspan="3" >
<label >Lab Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5">
 
  	<input  class="form-control form-control" type="text" name="LabName" required="required" maxlength="255" style="font-size: 15px;text-transform:capitalize;" value="<%=obj[2]%>" readonly >
 

</td>

</tr>


<tr>

<th colspan="3" >
<label >Lab Unit Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5">
 
 <input  value=<%=obj[3]%> readonly class="form-control form-control" type="text" name="" required="required" maxlength="100" style="font-size: 15px;text-transform:capitalize;"  id="LabAddress">

</td>
</tr>


<tr>
<th colspan="3" >
<label >Lab Address:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5" >
 
 <input  value="<%=obj[4]%>"  readonly class="form-control form-control"  type="text" name="LabAddress" required="required" min='1'   maxlength="255" style="font-size: 15px;"  id="LabAddress">

</td>


</tr>


<tr>

<th colspan="3" >
<label >Lab City:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5">
 
<input  value=<%=obj[5]%>  readonly class="form-control form-control"  type="text" name="LabCity" required="required" maxlength="255" style="font-size: 15px;"  id="">

</td>

</tr>


<tr>
 <th colspan="3" >
<label >Lab Pin:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="5" >
 
<input  value=<%=obj[6]%>  readonly class="form-control form-control" type="number" name="LabPin" required="required" maxlength="255" style="font-size: 15px;"  id="">

</td>


</tr>

<input type="hidden" name="Did" value=<%=obj[0]%>  >

<%} %>

</thead> 
</table>

</div>



<%if(LabMasterList.size()== 0){ %>
			<center><h4 style="font-family:'Montserrat', sans-serif;">No Lab Details Found .. !</h4></center><br>
 <center> <button type="submit" class="btn btn-primary btn-sm add" name="sub" value="add">ADD</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<%} %>

<%if(LabMasterList!=null&&LabMasterList.size()>0){ %>
 <center><button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit"   >EDIT</button></center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  	
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
	  var cnf=confirm("Are You Sure To Delete !");
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