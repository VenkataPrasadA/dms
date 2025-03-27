<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
 .custom-selectEnote {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 365px !important;
}

.custom-selectEnote select {
  /* Hide the default select dropdown arrow */
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  /* Add some padding to make room for the arrow */
  padding-right: 20px;
  width: 100%;
  height: 30px;
  /* Customize the look of the dropdown */
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: #fff;
 
}

/* Add a custom arrow */
.custom-selectEnote::after {
  content: '\25BC'; /* Unicode for downward-pointing triangle or arrow */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  /* Customize the arrow appearance */
  font-size: 10px;
  color: #666;
}   
</style>
<title>E Note Edit</title>
</head>
<body>

<%
	List<Object[]> InitiatedByEmployeeList=(List<Object[]>)request.getAttribute("InitiatedByEmployeeList");
	Long EmployeeId=(Long)request.getAttribute("EmployeeId");
	String Action = (String)request.getAttribute("Action");
	%>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb"><h5 style="font-weight: 700 !important">e Note Edit</h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteList.htm"><i class="fa fa-envelope"></i> e Note List</a></li>
						<li class="breadcrumb-item active">e Note Edit </li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	
	
	<div class="page card dashboard-card" style="width: 70%; margin-left: 16%;">
	<div class="card-body" align="center" >	
	<form action="EnoteAddSubmit.htm" method="POST" enctype="multipart/form-data">	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="row">
		<div class="col-md-4">
		<div class="form-group">
			<label class="control-label" style="float: left;">Note No</label>
			<input type="text" class="form-control " id="NoteNo" name="NoteNo" >
		</div></div>
		
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label" style="float: left;">Ref No</label>
				<input type="text" class="form-control" id="RefNo" name="RefNo" >
			</div> </div>
			
			
          <div class="col-md-4">
		  <div class="form-group">
			<label class="control-label" style="float: left;">Ref Date</label>
			<input type="text" class="form-control" id="RefDate" name="RefDate" >
			 </div> </div> 
		</div>	
		<div class="row">
		
			<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Subject</label>
		<input type="text" class="form-control" id="Subject" name="Subject" maxlength="255">
		</div></div>
		</div>
		
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Comment</label>
		<textarea rows="10" style="border-bottom-color: gray;width: 100%" maxlength="3000" placeholder="Maximum 3000 characters" id="Comment" name="Comment"></textarea>
		</div>
		</div>
		</div>
		
		<div class="row">
		<div class="col-md-12">
  	      			<div class="col-md-10 ">
  	      			<table style="float: left;">
			  	      	<tr ><td><label style="font-weight:bold;font-size:16px; float: left;">Document :</label></td>
			  	      		<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_clone">
			  	      			<td><input class="form-control" type="file" name="dakEnoteDocument"  id="dakEnoteDocument" accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>	
			  	     </table>
  	      			</div>
  	      		 <label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>InitiatedBy</b></label>
			<select class="selectpicker custom-selectEnote" id="InitiatedBy" required="required" data-live-search="true" name="InitiatedBy"  >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[3].toString()%> <% if (EmployeeId!=null && EmployeeId.toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	
		
		</div>
		</div>
		<div align="center">
		 <input type="submit" class="btn btn-primary btn-sm submit " id="Preview" value="Preview" name="sub"  onclick="return confirm('Are you sure to Preview?')">
		</div>
		</form>
	</div>
</div>
</body>
	<script type="text/javascript">

var count=1;
$("table").on('click','.tr_clone_addbtn' ,function() {
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.tr_clone_sub' ,function() {
	
var cl=$('.tr_clone').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.tr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});
$('#RefDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"startDate" : new Date(),
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
</script>	
</html>