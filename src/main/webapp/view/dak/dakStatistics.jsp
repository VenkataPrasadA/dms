<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Statistics</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
.custom-selectEmp {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  width: 300px !important;
  padding: 0px !important;
  margin-top: -8px;
  
}

.custom-selectEmp select {
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
.custom-selectEmp::after {
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
</head>
<body>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important"> DAK Statistics </h5>
			</div>
			
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Statistics List </li>
				  </ol>
				</nav>
			</div>			
		</div>
		</div>
		<%
		List<Object[]> EmpListDropDown=(List<Object[]>)request.getAttribute("EmpListDropDown");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		String Emp=(String)request.getAttribute("Emp");
		Object[] MarkedEmpCounts=(Object[])request.getAttribute("MarkedEmpCounts");
		Object[] AssignedEmpCounts=(Object[])request.getAttribute("AssignedEmpCounts");
		%>
		<div class="card" style="width: 99%">
		<div class="card-header" style="height: 3rem">
 <form action="DakStatistics.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
          <label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Employee</b></label>
				<select class="selectpicker custom-selectEmp" id="EmployeeId" required="required" data-live-search="true" name="EmployeeId" style="width: 50%;">
				<option value="All" <% if ( Emp!=null && "All".equalsIgnoreCase(Emp)) { %>selected="selected"<% } %>>All</option>
				<%if (EmpListDropDown != null && EmpListDropDown.size() > 0) {
				for (Object[] obj : EmpListDropDown) {%>
				<option value=<%=obj[0]%> <% if (Emp!=null && Emp.equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
				<%}}%>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label for="fromdate" style="text-align:  center;font-size: 16px;width:40px; ">From	</label>&nbsp;&nbsp;
              <input type="text" style="width:113px; margin-top: -10px; " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label for="todate" style="text-align: center;font-size: 16px;width:20px; ">To</label>&nbsp;&nbsp;
              <input type="text" style="width:113px;  margin-top: -10px;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
              
          </div>
        </div>
      </div>
      </form>
      </div>
      <div class="card-body">
      <div class="row" >
     
   <div class="col-md-5" style="margin-left: 60px;">
     <div class="card-border-secondary" >
			 <div class="card-header" style="text-align:center; background-color: #e3d7fa; width: 110%;">
                    <span class="" style="font-size: 18px;font-weight:bold;">Employee Marking Status</span>
             </div>
             
            <div class="panel-body">
            <div class="table-responsive" style="height: 404px; overflow: auto; width: 110%;">
            	<table class="table table-bordered table-hover table-striped table-condensed" >
            		<thead>
	            		<tr >	
	            			<th>Marked</th>
	            			<th>Replied In Time</th>
	            			<th>Replied Out Time</th>
	            			<th>Not Replied</th>	
	            				
	            		</tr>
	            	</thead>
	            	<tbody>
	            	<tr>
	            	<td><%if(MarkedEmpCounts!=null){ %><%=MarkedEmpCounts[0].toString() %><%}else{ %>-<%} %></td>
	            	<td><%if(MarkedEmpCounts!=null){ %><%=MarkedEmpCounts[1].toString() %><%}else{ %>-<%} %></td>
	            	<td><%if(MarkedEmpCounts!=null){ %><%=MarkedEmpCounts[2].toString() %><%}else{ %>-<%} %></td>
	            	<td><%if(MarkedEmpCounts!=null){ %><%=MarkedEmpCounts[3].toString() %><%}else{ %>-<%} %></td>
	            	</tr>
	            	</tbody>	
            	</table>
            	</div>
            </div>
		</div>
		</div>
       <div class="col-md-5" style="margin-left: 100px;">
     <div class="card-border-secondary" >
			 <div class="card-header" style="text-align:center; background-color: #e3d7fa; width: 110%;">
                    <span class="" style="font-size: 18px;font-weight:bold;">Employee Assign Status</span>
             </div>
             
            <div class="panel-body">
            <div class="table-responsive" style="height: 404px; overflow: auto; width: 110%;">
            	<table class="table table-bordered table-hover table-striped table-condensed" >
            		<thead>
	            		<tr style="font-size: 10px;line-height: 15px;">	
	            			<th>Assigned</th>
	            			<th>Replied In Time</th>
	            			<th>Replied Out Time</th>
	            			<th>Not Replied</th>	
	            				
	            		</tr>
	            	</thead>
	            	<tbody>
	            	
	            	<tr>
	            	<td><%if(AssignedEmpCounts!=null){ %><%=AssignedEmpCounts[0].toString() %><%}else{ %>-<%} %></td>
	            	<td><%if(AssignedEmpCounts!=null){ %><%=AssignedEmpCounts[1].toString() %><%}else{ %>-<%} %></td>
	            	<td><%if(AssignedEmpCounts!=null){ %><%=AssignedEmpCounts[2].toString() %><%}else{ %>-<%} %></td>
	            	<td><%if(AssignedEmpCounts!=null){ %><%=AssignedEmpCounts[3].toString() %><%}else{ %>-<%} %></td>
	            	</tr>
	            	</tbody>	
            	</table>
            	</div>
            </div>
		</div>
		</div>
		</div>
</div>
</div>
</body>
<script type="text/javascript">

$('#fromdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 "startDate" : new Date('<%=frmDt%>'), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$(document).ready(function(){
	   $('#fromdate').change(function(){
	       $('#myform').submit();
	    });
	});
	
var currentDate = new Date();
var maxDate = currentDate.toISOString().split('T')[0];
console.log(maxDate);

	$('#todate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"startDate" : new Date('<%=toDt%>'), 
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	$(document).ready(function(){
		   $('#todate,#EmployeeId').change(function(){
		       $('#myform').submit();
		    });
		});
</script>
</html>