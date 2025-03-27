
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate,java.time.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>Audit Stamping</title>

<style type="text/css">




.border {
	border-style: groove;
	border-radius: 5px 5px;
}

.cardpad {
	padding: 5px;
}

 .auditnavbar{
	margin: 0px 19px;
    border-radius: 6px;
;
}


h6{
	font-family:'Montserrat', sans-serif;
}

.datefont{
	font-family:'Muli', sans-serif;
	font-size: 15px;
}

.badge{
	padding-bottom: 0px !important;
}
 
</style>

</head>
<body>


<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">AUDIT STAMPING</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
			<ol class="breadcrumb" >
				<li class="breadcrumb-item ml-auto"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="AdminDashBoard.htm"><i class="fa fa-user"></i> Admin </a></li>
				
				<li class="breadcrumb-item active">Audit Stamping</li>
			</ol>
				</nav>
			</div>			
		</div>
</div>

			<%
				String Username =(String)session.getAttribute("Username"); 
				List<Object[]> usernamelist = (List<Object[]>) request.getAttribute("usernamelist");
				List<Object[]> auditstampinglist = (List<Object[]>) request.getAttribute("auditstampinglist");
				SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
				SimpleDateFormat sdf1=new SimpleDateFormat("HH:mm:ss");
				SimpleDateFormat sdf2= new SimpleDateFormat("dd-MM-yyyy HH:mm:ss ");
				String Fromdate=(String)request.getAttribute("Fromdate");
				String Todate=(String)request.getAttribute("Todate");
				String ListName=(String)request.getAttribute("Username");
			%>


	<div class="nav navbar auditnavbar" style="background-color: white;">

			<form class="form-inline " method="POST" action="${pageContext.request.contextPath}/AuditStampingView.htm">
				<input type="hidden" name="${_csrf.parameterName}"s	value="${_csrf.token}" /> 
				
				<label style="margin-left: 250px; margin-right: 10px;font-weight: 1000;">User Name: <span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control form-control" name="username" style="margin-left: 12px;" required="required" id="username" >
				
					<%
						for (Object[] Obj : usernamelist) {
					%>
					<option value="<%=Obj[0]%>" <% if(ListName!=null){if(ListName.equalsIgnoreCase(Obj[0].toString())){ %> selected="selected" <%} }%> ><%=Obj[0]%></option>
					<%
						}
					%> 
					</select>

				<label style="margin-left: 150px; margin-right: 20px; font-weight: 800">From Date:</label>
					<input  class="form-control form-control date"  data-date-format="dd-mm-yyyy" id="datepicker1" name="Fromdate"  required="required"  style="width: 120px;"
					 <%if(Fromdate!=null){%> value="<%=(Fromdate) %>" <%} %> >
					  
	
				<label style="margin-left: 20px; margin-right: 20px;font-weight: 800">To Date:</label>
				
					<input  class="form-control form-control" data-date-format="dd-mm-yyyy" id="datepicker3" name="Todate"  style="width: 120px;"
					 	 <%if(Todate!=null){%> value="<%=(Todate) %>" <%} %> 
					>  
	
				<button type="submit" class="btn btn-primary btn-sm submit" style="margin-left: 12px;" id="submit">Submit</button>
	
	
			</form>
	
	</div>


<div class="row">
	<div class="col-md-9">
		<div class="badge badge-info" style="padding: 8px; margin-left: 46%;margin-top:2%">
		<h6><%if(ListName != null){%>Details of <b><%=ListName.toUpperCase()%></b><%}else{%> Details of <b><%=Username.toUpperCase()%></b> <%}%>login from <span class="datefont"><%=Fromdate%></span> to <span class="datefont"><%=Todate %></span></h6>
		</div>
	</div>
	
	<!-- <div class="col-md-3">
		<label style="font-size:13px;font-weight: 600; margin-left: 30px; font-family: 'Muli', sans-serif;">Logout Type (L - Logout , S - Session Expired)</label>
	</div> -->
	
</div>


	
		
		
		
			<div class="row datatables" style="margin-top: 10px;">
				<div class="col-md-12">
				
<div class="card shadow-nohover" >
	<div class="card-body"> 
 			<div class="table-responsive">
	  			<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable1"> 
	   				<thead>
	   					<tr>		
							<th>Login Date</th>
							<th>Login Time</th>
							<th>IP Address</th>
							<th>Mac Address</th>
							<th>Logout Type</th>
							<th>Logout Date Time</th>
						</tr>
	   				</thead>
	   				
    				<tbody>
	    				<%for(Object[] obj:auditstampinglist){ %>	
	    				<tr>
	   						<td><%=sdf.format(obj[1]) %></td>
	    					<td><%=sdf1.format(obj[2])%></td>
	     					<td><%=obj[3] %></td>
	    					<td><%if(obj[4]!= null){%><%=obj[4] %> <% }else{%> - <%} %></td> 
	    					<td><%if(obj[5]!= null){%><%=obj[5] %> <% }else{%> S <%} %> </td> 
	    					<td><%if(obj[6]!= null){%><%= sdf2.format(obj[6]) %> <% }else{%> - <%} %></td> 
	    				</tr>
	    				<%} %>
	    			</tbody>
				</table>
 			</div>
		</div>


</div>
			
			
			
			
			
		</div>
	</div>


</body>


	<script type="text/javascript">
	$(document).ready(function(){
		
		    $("#datepicker1").daterangepicker({
		        minDate: 0,
		        maxDate: "+30D",
		        numberOfMonths: 1,
		        autoclose: true,
		        "singleDatePicker" : true,
				"linkedCalendars" : false,
				"showCustomRangeLabel" : true,
		        onSelect: function(selected) {
		        $("#datepicker3").datepicker("option","minDate", selected)
		        },
		        locale : {
					format : 'DD-MM-YYYY'
				}
		    });
		
		    $("#datepicker3").daterangepicker({
		        minDate: 0,
		        maxDate:"+30D", 
		        numberOfMonths: 1,
		        autoclose: true,
		        "singleDatePicker" : true,
				"linkedCalendars" : false,
				"showCustomRangeLabel" : true,
			    onSelect: function(selected) {
			    $("#datepicker1").datepicker("option","maxDate", selected)
		        },
		        locale : {
					format : 'DD-MM-YYYY'
				}
		    }); 
		
		});
	

	</script> 
	
	<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
    "pagingType": "simple",
     ordering: false

});	

$("#myTableDisp").DataTable({
});

$("#myTable2").DataTable({
});
</script> 
	
	
	
</html>