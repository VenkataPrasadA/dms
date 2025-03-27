<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SMS Report List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
</head>
<body>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-6 heading-breadcrumb">
				<h5 style="font-weight: 700 !important"> DAK Sms Report List </h5>
			</div>
			<div class="col-md-6 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item"><a href="ReportsDashBoard.htm"><i class="fa fa-envelope"></i> Reports</a></li>
				    <li class="breadcrumb-item active">DAK Sms Report List</li>
				  </ol>
				</nav>
			</div>			
		</div>
		</div>
		<%
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Change the pattern according to your date format
		Date fromdate=dateFormat.parse(frmDt);
		Date todate=dateFormat.parse(toDt);
		List<Object[]> SmsReportList=(List<Object[]>)request.getAttribute("SmsReportList");
		%>
		<%
		String ses=(String)request.getParameter("result"); 
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
			<div class="alert alert-success" role="alert" >
        		<%=ses %>
        	</div>
    	</div>
    	<%} %>
		
		</div>
		
		<div class="card" style="width: 100%;">
		<div class="card-header" style="height: 3rem">
 <form action="SmsReport.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
          <input type="hidden" name="frmdate" value="<%=frmDt%>">
          <input type="hidden" name="tdate" value="<%=toDt%>">
          <span><b>DMS Report (SMS) </b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <button type="submit" style="margin-top: -10px;" formaction="DMSSmsReportListExcel.htm" formmethod="post" class="btn btn-sm icon-btn SmsExcelDownload" ><img alt="Excel" src="view/images/Excel.png"></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <span><b>Dak Pending Report List(As On Date) </b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <button type="submit" style="margin-top: -10px;" formaction="PendingReportListExcel.htm" formmethod="post" class="btn btn-sm icon-btn SmsExcelDownload" ><img alt="Excel" src="view/images/Excel.png"></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <span><b>SMS Report Excel List ( <%=sdf.format(fromdate)+" to "+sdf.format(todate) %> )</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="submit" style="margin-top: -10px;" formaction="SmsReportExcel.htm" formmethod="post" class="btn btn-sm icon-btn SmsExcelDownload" ><img alt="Excel" src="view/images/Excel.png"></button>&nbsp;&nbsp;&nbsp; 
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
									<th class="text-nowrap">EmpName</th>
									<th class="text-nowrap">Mobile No</th>
									<th class="text-nowrap">DAK Pending</th>
									<th class="text-nowrap">DAK Urgent</th>
								    <th class="text-nowrap">DAK Today Pending</th> 
								    <th class="text-nowrap">DAK Delay</th>
								</tr>
							</thead>
							<tbody>
							<%
							 int count=1;
							if(SmsReportList!=null && SmsReportList.size()>0){
							for (Object[] obj : SmsReportList) {
								if(obj[2]!=null && Integer.parseInt(obj[2].toString())>0){
							%>
								<tr>
									<td style="width:10px;"><%=count%></td>
                                     <td class="wrap" style="text-align: left; width:200px;"><%if(obj[0]!=null && obj[1]!=null){ %><%=obj[0].toString().trim()+", "+obj[1].toString() %><%}else{ %>-<%} %></td>
                                    <td class="wrap" style="text-align: center; width:80px;"><%if(obj[6]!=null){ %><%=obj[6].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center; width:60px;" ><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %></td>
									<td  class="wrap" style="text-align: center; width:60px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td> 
									<td  class="wrap" style="text-align: center; width:60px;"><%if(obj[4]!=null){ %><%=obj[4].toString()%><%}else{%>-<%} %></td> 
									<td  class="wrap" style="text-align: center; width:60px;"><%if(obj[5]!=null){ %><%=obj[5].toString()%><%}else{%>-<%} %></td>
									</tr>
									<%
									count++;}}}
									%> 
									</tbody>
						    </table>
						</div>
			</div>
</div>
</body>
<script>
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
		   $('#fromdate,#todate').change(function(){
		       $('#myform').submit();
		    });
		});
</script>
</html>