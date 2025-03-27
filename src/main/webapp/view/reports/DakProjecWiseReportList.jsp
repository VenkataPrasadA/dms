<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<title>DAK Project-Wise List</title>
<style type="text/css">
 .custom-selectProject {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  width: 200px;
  padding: 0px !important;
  margin-top: -8px;
}

.custom-selectProject select {
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
.custom-selectProject::after {
  content: '\25BC'; /* Unicode for downward-pointing triangle or arrow */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  /* Customize the arrow appearance */
  font-size: 10px;
  color: #666;
}  
.spinner {
    position: fixed;
    top: 40%;
    left: 32%;
    margin-left: -50px; /* half width of the spinner gif */
    margin-top: -50px; /* half height of the spinner gif */
    text-align:center;
    z-index:1234;
    overflow: auto;
    width: 1000px; /* width of the spinner gif */
    height: 1020px; /*hight of the spinner gif +2px to fix IE8 issue */
    background: transparent;
} 
</style>
</head>
<body>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important"> DAK Project-Wise List </h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				   <li class="breadcrumb-item" aria-current="page"><a href="ReportsDashBoard.htm"><i class="fa fa-file" ></i> Reports</a></li>
				    <li class="breadcrumb-item active">DAK Project-Wise List</li>
				  </ol>
				</nav>
			</div>			
		</div>
		</div>
		<!-- Loading  Modal -->
	
<div id="spinner" class="spinner">
                <img id="img-spinner" style="width: 300px;height: 300px; margin-right: 150px;" src="view/images/load.gif" alt="Loading"/>
                </div>
		<!-- Loading  Modal End-->	
		</div>
		
			
		<%
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		List<Object[]> selProjectList=(List<Object[]>)request.getAttribute("selProjectList");
		List<Object[]> ProjectWiseList=(List<Object[]>)request.getAttribute("ProjectWiseList");
		String ProjectTypeId=(String)request.getAttribute("ProjectTypeId");
		%>
		<div class="card loadingCard" style="width: 100%; display: none;">
		<div class="card-header" style="height: 3rem">
 <form action="DakProjectWiseReportList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
           <label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 18px;"><b>Project Type</b></label>
				<select class="selectpicker custom-selectProject" id="ProjectTypeid" required="required" data-live-search="true" name="ProjectTypeId" style="width: 50%; margin-top: 3px;">
				<option value="All" <%if(ProjectTypeId!=null && ProjectTypeId.equalsIgnoreCase("All")) {%>selected="selected"<% } %> >All</option>
				<%if (selProjectList != null && selProjectList.size() > 0) {	
				for (Object[] obj : selProjectList) {%>
				<option value=<%=obj[0]%> <%if(ProjectTypeId!=null && ProjectTypeId.equalsIgnoreCase(obj[0].toString())) {%>selected="selected"<% } %>><%=obj[1].toString()%></option>
				<%}}%>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
<div class="card-body" >
			<div class="table-responsive">
 	  		  <table class="table table-bordered table-hover table-striped table-condensed" style="width: 100%"   id="myTable1">
							<thead>
								<tr>
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">DAK Id</th>
									<th class="text-nowrap">Head</th>
									<th class="text-nowrap">Source</th>
									<!-- <th class="text-nowrap">Ref No & Date </th> -->
									<th class="text-nowrap">Action Due</th>
								    <th class="text-nowrap">Subject</th> 
								    <th class="text-nowrap">Employee</th>
									<th class="text-nowrap">Status</th>
								</tr>
							</thead>
							<tbody>
							<%
							 int count=1;
							if(ProjectWiseList!=null && ProjectWiseList.size()>0){
							for (Object[] obj : ProjectWiseList) {
							%>
								<tr>
									<td style="width:10px;"><%=count%>.</td>
									 <td class="wrap" style="text-align: left;width:80px;">
	 					          	<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakGroupingList')">
                                    <% if (obj[1] != null) { %>
                                    <%= obj[1].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
                                     </td>
									 <%-- <td class="wrap" style="text-align: left; width:80px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td> --%>
                                     <td class="wrap" style="text-align: center; width:10px;"><%if(obj[10]!=null){ %><%=obj[10].toString() %><%}else{ %>-<%} %></td>
                                    <td class="wrap" style="text-align: center; width:100px;"><%if(obj[9]!=null){ %><%=obj[9].toString() %><%}else{ %>-<%} %></td>
									<%-- <td class="wrap" style="text-align: left; width:150px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %><br><%if(obj[4]!=null){%><%=sdf.format(obj[4])%><%}else{ %>-<%} %></td> --%>
									<td class="wrap" style="text-align: center; width:80px;" ><%if(obj[6]!=null){ %><%=sdf.format(obj[6]) %><%}else{ %><%="NA" %><%} %></td>
									<td  class="wrap" style="text-align: left; width:180px;"><%if(obj[11]!=null){ %><%=obj[11].toString() %><%}else{ %>-<%} %></td> 
									<td  class="wrap" style="text-align: left; width:180px;"><%if(obj[13]!=null && obj[14]!=null){ %><%=obj[13].toString()+", "+ obj[14].toString()%><%}%></td> 
									<td  class="wrap" style="text-align: center; width:80px;">
									
									<%if(obj[15]!=null){ %>
									<%=obj[15].toString() %>
									<%}else{ %>
									-
									<%} %>
									
									<%
									if(obj[15]!=null && "Replied".equalsIgnoreCase(obj[15].toString())){ %>
									<button type="button" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]  %> value="<%=obj[0] %>" 
 									 				onclick="IndividualReplyPrev(<%=obj[0]%>,<%=obj[8]%>,<%=obj[17]%>,<%=obj[16]%>,<%=obj[18]%>)"  data-placement="top" title="Preview"> 
 															  <img alt="mark" src="view/images/replyPreview.png">
									 				</button>
									<%} %>
									</td>
									</tr>
									<%
								count++;	}}
								%> 
									</tbody>
						    </table>
						</div>
			</div>
</div>
</body>
<script type="text/javascript">
$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
});
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	



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
		   $('#fromdate,#todate,#ProjectTypeid').change(function(){
		       $('#myform').submit();
		    });
		});
</script>
</html>