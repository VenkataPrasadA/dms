<%@page import="com.vts.dms.master.model.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="../static/header.jsp"></jsp:include>
</head>
<body>

<%List<Object[]> ProjectMasterList=(List<Object[]>)request.getAttribute("ProjectMasterList"); %>




<div class="row">
<div class="col-md-12">
<section class="content-header">
			<h5>PROJECT LIST</h5>
			<ol class="breadcrumb" >
				<li class="breadcrumb-item"><a href="#"><i class="fa fa-home"></i> Home</a></li>
				

				

				

				<li class="breadcrumb-item active">Project List</li>
			</ol>
		  </section> 
		  </div>
</div>







<div class="row"> 



	
 <div class="col-sm-12"  style="top: 10px;">
<div class="card" >

<div class="card-body">
<form name="myfrm" action="ProjectMaster.htm" method="POST" >
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed"  id="myTable">
	  <thead>
	  <tr>
	  <th>SELECT</th>
	 <th>PROJECT CODE</th>
	  
	  <th>PROJECT NAME</th>
	  <th>PROJECT DESCRIPTION</th>
	  <th>DIVISION NAME</th>
	  <th>AUTHORITY NO</th>
	  <!-- <th>AUTHORITY DATE</th>
	  <th>PDC</th> -->
	  </tr>
	  </thead>
	  <tbody>
	  <%for(Object[] master:ProjectMasterList){ %>
	  <tr>
	  <td ><input type="radio" name="Pid" value="<%=master[0]%>"  id="Pid"></td>
	 <td><%=master[1] %></td>
	  <td style="text-align: left;" ><%=master[2] %></td>
	  <td style="text-align: left;"><%=master[3] %></td>
	  <td style="text-align: left;" ><%=master[4] %></td>
	  <td style="text-align: left;" ><%=master[5] %></td>
	 <%--  <td style="text-align: left;" ><%=master[6] %></td>
	  <td style="text-align: left;" ><%=master[7] %></td> --%>
	  </tr>
	  <%} %>
	  </tbody>
	  </table>
	  </div>
	   
	<center>  <button type="submit" class="btn btn-primary btn-sm" name="sub" value="add"  >ADD</button>&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;
 <%if(ProjectMasterList!=null&&ProjectMasterList.size()!=0){ %>
    <button type="submit" class="btn btn-warning btn-sm" name="sub" value="edit" onclick="Edit(myfrm)" >EDIT</button>&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;
  <button type="submit" class="btn btn-danger btn-sm" name="sub" value="delete" onclick="Delete(myfrm)">DISABLE</button>&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; 
	
	<%} %>
	
	  
	  </form>
	
	  </center>
	  </div>
	  </div>
	  </div>
	  </div>
</body>
</html>