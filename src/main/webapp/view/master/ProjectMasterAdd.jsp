<%@page import="com.vts.dms.master.model.DivisionMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label{
  font-weight: bold;
  font-size: 13px;
}
</style>

</head>
<body>





<div class="row">
<div class="col-md-12">
<section class="content-header">
			<h5>PROJECT ADD</h5>
			<ol class="breadcrumb" >
				<li class="breadcrumb-item"><a href="#"><i class="fa fa-home"></i> Home</a></li>
				

				

				

				<li class="breadcrumb-item active">Project Add</li>
			</ol>
		  </section> 
		  </div>
</div>




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



	 <div class="col-sm-3"  >
	 </div>
 <div class="col-sm-6"  style="top: 10px;">
<div class="card" >

<div class="card-body">
<form name="myfrm" action="ProjectMasterSubmit.htm" method="POST" >
  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed"  >
  <thead>
<tr>
  <th>
<label >ProjectCode:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  class="form-control form-control" placeholder="DivisionCode" type="text" name="DivisionCode" required="required" maxlength="3" style="font-size: 10px;">
</td>
</tr>

<tr>
  <th>
<label >ProjectName:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  class="form-control form-control" placeholder="DivisionName" type="text" name="DivisionName" required="required" maxlength="25" style="font-size: 10px;">
</td>
</tr>
<tr>
  <th>
<label >ProjectDescription:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<textarea  class="form-control form-control" placeholder="DivisionDescription"  name="DivisionDescription" required="required" maxlength="255" style="font-size: 10px;"></textarea>
</td>
</tr>
<tr>
  <th>
<label >AuthorityNo:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  class="form-control form-control" placeholder="AuthorityNo" type="text" name="AuthorityNo" required="required" maxlength="25" style="font-size: 10px;">
</td>
</tr>
<tr>
  <th>
<label >AuthorityDate:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  class="form-control form-control" placeholder="AuthorityDate" type="text" name="AuthorityDate" required="required" maxlength="25" style="font-size: 10px;">
</td>
</tr>
<tr>
  <th>
<label >Pdc:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  class="form-control form-control" placeholder="pdc" type="text" name="pdc" required="required" maxlength="25" style="font-size: 10px;">
</td>
</tr>
</thead> 
</table>

</div>
</div>

	  <center><input type="submit"  class="btn btn-primary btn-sm"          /></center>
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	  </div>
</body>
</html>