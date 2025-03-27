<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
         <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>OTHER-PROJECT DETAILS</title>

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
					<h5 style="font-weight: 700 !important">OTHER-PROJECT DETAILS</h5>
				</div>
				<div class="col-md-9 " >
					<nav aria-label="breadcrumb">
					  <ol class="breadcrumb ">
					    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
					    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
					    <li class="breadcrumb-item active">Other-Project Details</li>
					  </ol>
					</nav>
				</div>			
			</div>
	</div>


	<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> OtherProjectList=(List<Object[]>) request.getAttribute("OtherProjectList");
	%>






	<%String ses=(String)request.getParameter("Status"); 
	 String ses1=(String)request.getParameter("StatusFail");
		if(ses1!=null){%>
		<center>
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
	
	    <form action="OtherProject.htm">
	     <div class="table-responsive">
		   <table class="table table-bordered table-hover table-striped table-condensed	"  id="myTable1"> 
		   <thead>
		   <tr>
		   <th>Select</th>
		   <th class="text-nowarp">Lab Code</th>
		   <th class="text-nowarp">Project Code</th>
		   <th class="text-nowarp">Project Short Name</th>
		   <th class="text-nowarp">Project Name</th>
		  </tr>
		   </thead>
	    <tbody>
		    <%if(OtherProjectList!=null && OtherProjectList.size()>0){for(Object[] obj:OtherProjectList){ %>
		    <tr>
		     <td><input type="radio" name="Did" value=<%=obj[0]%>  ></td> 
		     <td ><%=obj[4] %></td>
		     <td align="center"><%=obj[1] %></td>
		     <td ><%=obj[2] %></td>
		     <td style="text-align: left;"><%=obj[3] %></td>
		    </tr>
		    <%}}else{ %>
		    <tr>
		    <td colspan="5" align="center">No Record Found</td>
		    </tr>
		    <%} %>
		    </tbody>
	</table>
	 	
	</div>

	 <center> <button type="submit" class="btn btn-primary btn-sm add" name="sub" value="add">ADD</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	<%if(OtherProjectList!=null&&OtherProjectList.size()>0){ %>
	 <button type="submit" class="btn btn-warning btn-sm edit" name="sub" value="edit" onclick="EditFunction()"  >EDIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	  	<%} %> 
	 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	 	</form>
	</div>
	
	
	</div>
	</div>
	</div>
	
</body>

<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
    "pagingType": "simple",
      "ordering": false
});

$("#myTableDisp").DataTable({
});

$("#myTable2").DataTable({
});
</script>   

	<script type="text/javascript">
	
	
	
	function EditFunction(){
		
		  var fields =$('input[name="Did"]:checked').val();
	
		  if (fields == null || fields=='' || typeof(fields)=='undefined'){
		     alert("Please Select A Record..!");
		      event.preventDefault();
		       return false;
		       }
	      return true;
	      }
	
	</script>
</html>