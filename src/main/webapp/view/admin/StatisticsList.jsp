<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.dms.FormatConverter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<title>DAK Statistics List</title>
<style type="text/css">
 .custom-selectStatistics {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  width: 350px !important;
  padding: 0px !important;
   margin-top: -8px !important;
}

.custom-selectStatistics select {
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
.custom-selectStatistics::after {
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
				<h5 style="font-weight: 700 !important">Dak Statistics List</h5>
			</div>
			
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="AdminDashBoard.htm"><i class="fa fa-envelope" ></i> Admin</a></li>
				    <li class="breadcrumb-item active">Dak Statistics List </li>
				  </ol>
				</nav>
			</div>			
		</div>
		</div>
		<%
		List<Object[]> StatsEmployeeList=(List<Object[]>)request.getAttribute("StatsEmployeeList");
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		Long MemberTypeId=(Long)request.getAttribute("MemberTypeId");
		List<Object[]> employeelist=(List<Object[]>)request.getAttribute("ds");
		List<Object[]> DakGroupingListDropDown=(List<Object[]>)request.getAttribute("DakGroupingListDropDown");
		String EmployeeId=(String)request.getAttribute("EmployeeId");
		
		%>
		<div class="card" style="width: 99%">
		<div class="card-header" style="height: 3rem">
 <form action="StatisticsList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
                <label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Grouping </b></label>
				<select class="selectpicker custom-selectStatistics" id="DakMemberTypeId" required="required" data-live-search="true" name="DakMemberTypeId" >
				
			<%-- 	<option value="All" <% if ( MemberTypeId!=null && "All".equalsIgnoreCase(MemberTypeId.toString())) { %>selected="selected"<% } %>>All</option> --%>
				
				<%if (DakGroupingListDropDown != null && DakGroupingListDropDown.size() > 0) {
				for (Object[] obj : DakGroupingListDropDown) {%>
				<option value=<%=obj[0]%> <% if (MemberTypeId!=null && MemberTypeId.toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1]%></option>
				<%}}%>
			   </select>
              <label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Employee</b></label>
			<select class="selectpicker custom-selectStatistics" id="SelectedEmpId" required="required" data-live-search="true" name="SelectedEmpId"  >
				<%-- <%if(MemberTypeId.equalsIgnoreCase("All")) {%>
				<option value="All" <% if ( EmployeeId!=null && "All".equalsIgnoreCase(EmployeeId.toString())) { %>selected="selected"<% } %>>All</option>
				<%} %> --%>
				<%if (StatsEmployeeList != null && StatsEmployeeList.size() > 0) {
					for (Object[] obj : StatsEmployeeList) {%>
					<option value=<%=obj[0]%> <%if(EmployeeId.toString().equalsIgnoreCase(obj[0].toString())) {%>selected="selected"<%} %>><%=obj[1]%>, <%=obj[2] %></option>
						<%}}%>
			      </select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			       <label for="fromdate" style="text-align:  center;font-size: 16px;width:40px; ">From	</label>&nbsp;&nbsp;
                   <input type="text" style="width:113px; margin-top: -10px; " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   <label for="todate" style="text-align: center;font-size: 16px;width:20px; ">To</label>&nbsp;&nbsp;
                   <input type="text" style="width:113px;  margin-top: -10px;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <button type="submit" formaction="UpdatetheEmployeedata.htm" formmethod="post" style="margin-top: -10px;" class="btn btn-sm icon-btn" name="syncdata" id="syncdata" data-toggle="tooltip" data-placement="top" title="" data-original-title="Refresh"> 
			<img alt="mark" src="view/images/sync.png">
 		</button>
          </div>
        </div>
      </div>
      </form>
      </div>
      
      <div class="card-body"> 
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">Employee</th>
									<th style="text-align: center;">Log Date</th>
									<th style="text-align: center;">Login Count</th>
									<th style="text-align: center;">Distributed</th>
									<th style="text-align: center;">Acknowledged </th>
									<th style="text-align: center;">Marked </th>
									<th style="text-align: center;">Replied </th>
									<th style="text-align: center;">Assigned </th>
									<th style="text-align: center;">Assigned Replied </th>
									<th style="text-align: center;">Seek Response Assigned </th>
									<th style="text-align: center;">Seek Response Replied </th>
									
								</tr>
							</thead>
							<tbody>
								<%
								    int count=1;
								if(employeelist!=null && employeelist.size()>0){
									for (Object[] obj : employeelist) {
										
								%>
							
								<tr>
									<td style="text-align: center;"><%=count%></td>
									<td style="text-align: center;"><%if(obj[1]!=null && obj[2]!=null){ %><%=obj[1].toString()+", "+obj[2].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;"><%if(obj[13]!=null){%><%=sdf.format(obj[13])%><%}else{ %>-<%} %></td>
									<td style="text-align: center;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
 									<td style="text-align: center;;"><%if(obj[5]!=null){ %><%=obj[5].toString()%><%}else{ %>-<%} %></td>
 									<td style="text-align: center;"><%if(obj[6]!=null){ %><%=obj[6].toString()%><%}else{ %>-<%} %></td>
									<td style="text-align: center;"><%if(obj[7]!=null){ %><%=obj[7].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;;"><%if(obj[8]!=null){ %><%=obj[8].toString()%><%}else{ %>-<%} %></td>
 									<td style="text-align: center;"><%if(obj[9]!=null){ %><%=obj[9].toString()%><%}else{ %>-<%} %></td>
									<td style="text-align: center;"><%if(obj[10]!=null){ %><%=obj[10].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;;"><%if(obj[11]!=null){ %><%=obj[11].toString()%><%}else{ %>-<%} %></td>
 									<td style="text-align: center;"><%if(obj[12]!=null){ %><%=obj[12].toString()%><%}else{ %>-<%} %></td>
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
	   $('#fromdate,#todate,#SelectedEmpId').change(function(){
	       $('#myform').submit();
	    });
	});
	
$(document).ready(function(){
	   $('#DakMemberTypeId').change(function(){
		   $("#SelectedEmpId").prop("disabled", true);
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
		"maxDate" : new Date(maxDate),  
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
</script>
<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	
</script> 
</html>