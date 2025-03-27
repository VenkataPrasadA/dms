<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>FEED BACK</title>
<style type="text/css">
.table thead tr th {
	background-color: aliceblue;
}

.table thead tr td {
	background-color: #f9fae1;
	text-align: left;
}

.reason{
width: 300px !important;
}
</style>
</head>
<body>


<%String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
<%} %>

<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">FEEDBACK ADD</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
			<ol class="breadcrumb" >
				<li class="breadcrumb-item ml-auto"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="AdminDashBoard.htm"><i class="fa fa-user"></i> Admin </a></li>
				
				<li class="breadcrumb-item active">FeedBack Add</li>
			</ol>
				</nav>
			</div>			
		</div>
</div>
<%List<Object[]> fblist = (List<Object[]>)request.getAttribute("FeedbackList"); %>

	<div class="row">
		<div class="col-md-1 "></div>
		<div class="col-md-10 ">
			<div class="card shadow-nohover" >
				<div class="card-header" style="color: #145374; background-color: #C4DDFF; font-family: Muli; height: 45px; width: 100%;">
					<div class="row">
						<div class="col-md-6"><h4>FEEDBACK</h4></div>
						<div class="col-md-6" style="margin-top: -8px;"><a class="btn btn-sm back" <%if(fblist!=null && fblist.size()>0){%> href="FeedBack.htm" <%}else{%> href="MainDashBoard.htm"<%}%> style="float: right;">BACK</a></div>
					</div>
				</div>
				<div class="card-body">
					<form action="FeedBackAdd.htm" method="POST" id="Feedbackadd" enctype="multipart/form-data">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed " id="myTable16" style="width: 90%;">
								<thead>
									    <tr>
											<th style="text-align: left;"><label style="color: black; font-size: 16px;">Feedback Type: <span class="mandatory" style="color: red;">*</span></label></th>
											<td>
												<select class="form-control selectpicker reason" id="ftype" name="feedbacktype" data-container="body" data-live-search="true"   style="font-size: 15px; color: black;">
													<option value=""  selected="selected"	hidden="true">--Select--</option>
													<option value="B">Bug</option>
													<option value="C">Content Change</option>
													<option value="N">New Requirement</option>
													<option value="U">User Interface</option>
												</select>
											</td>
											<th style="text-align: left;"> <label style="color: black; font-size: 14px;">File :</label> </th>
											<td> <input type="file" name="FileAttach" style="margin-top:10px; color: black;"> </td>
										</tr>
										<tr>
											<th style="text-align: left;"><label style="color: black; font-size: 15px;">Feedback: <span class="mandatory" style="color: red;">*</span></label></th>
											<td colspan="3">
											    <textarea rows="4" style="display:block; margin-top: 10px;" class="form-control"  id="summernote1" name="Feedback"  placeholder="Enter Feedback..!!"  ></textarea>
											</td>
										</tr>
								</thead>
							</table>
						</div>
						<div align="center">
							<input type="submit" class="btn btn-primary btn-sm editbasic"  value="Submit"  name="sub" onclick="return confirm('Are You Sure to Submit?');"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</div>		
					</form>									
				</div>
			</div>
		</div>
	</div>	
</body>
<script type="text/javascript">

	  $("#Feedbackadd").on('submit', function (e) {

		  var data =$('#summernote1').val();;
		  var feedbacktype = $('#ftype').val();
		  if(feedbacktype=='' ){
			  alert("Please Select Feedback Type!");
			  $("#ftype").focus();
			  return false;
		  }else if(data=='' ){
			  alert("Please Enter Feedback!");
			  $("#summernote1").focus();
			  return false;
		  }else if(data.length>999){
			  alert("Feedback data is too long!");
			  $("#summernote1").focus();
			  return false;
	  	  }else{
			  return true;
		  }  
});  
</script>

  
</html>