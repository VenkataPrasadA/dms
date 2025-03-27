<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,java.text.SimpleDateFormat,com.vts.dms.dak.model.DakAttachment"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>DAK Status List</title>

<style>
.table .font {
	font-size: 13px;
	font-weight: 700 !important;
	
}

.table a:hover,a:focus {
   text-decoration: underline !important; 
}


.table th{
text-align: center;
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
				<h5 style="font-weight: 700 !important">DAK Status List</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="ReportsDashBoard.htm"><i class="fa fa-file" ></i> Reports</a></li>
				    <li class="breadcrumb-item active">DAK Status List </li>
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
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="left">
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
                    
<%  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> DakList = (List<Object[]>) request.getAttribute("DakList");
	List<DakAttachment> List =(List<DakAttachment>) request.getAttribute("AttachmentData");
	 String letterno=(String)request.getParameter("letterno");
	 String frmDt=(String)request.getAttribute("frmDt");
	 String toDt=(String)request.getAttribute("toDt");
%>
<div class="card loadingCard" style="width: 99%; display: none;">
		<div class="card-header" style="height: 3rem">
 <form action="DakStatusList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float: right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
              <label for="fromdate" style="text-align:  center;font-size: 16px;width:50px;  ">From	</label>
              <input type="text" style="width:115px; margin-top: -10px; " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label for="todate" style="text-align: center;font-size: 16px;width:20px;">To  </label>&nbsp; 
              <input type="text" style="width:115px;  margin-top: -10px; " class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
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
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">DAK Id</th>
									<th class="text-nowrap">Head</th>
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">Ref No & Date </th>
									<th class="text-nowrap">Action Due</th>
									<th class="text-nowrap">Subject</th> 
									<th class="text-nowrap">Status</th>
								</tr>
							</thead>
							<tbody>
								<%
								    int count=1;
									for (Object[] obj : DakList) {
										
								        String type = null;
								        if(obj[1]!=null){
								            if("Restricted".equalsIgnoreCase(obj[1].toString().trim() )){
								            	type ="R";
								        	}else  if("Information".equalsIgnoreCase(obj[1].toString().trim() )){
								        		type ="I";
								        	}else  if("Confidential".equalsIgnoreCase(obj[1].toString().trim() )){	
								        		type ="C";
								        	}else  if("Secret".equalsIgnoreCase(obj[1].toString().trim() )){	
								        		type ="S";
								        	}else  if("Top Secret".equalsIgnoreCase(obj[1].toString().trim() )){
								        		type ="T";
								        	}
								        	
								        }else{
								        	 type = "-";
								        }
								        
								        
								    	
								        String priority = null;
								        if(obj[2]!=null){
								            if("Normal".equalsIgnoreCase(obj[2].toString().trim() )){
								            	priority ="N";
								        	}else  if("Urgent".equalsIgnoreCase(obj[2].toString().trim() )){
								        		priority ="U";
								        	}else  if("Immediate".equalsIgnoreCase(obj[2].toString().trim() )){	
								        		priority ="I";
								        	}
								        	
								        }else{
								        	priority = "-";
								        }
									
										
								%>
								<tr>
									<td style="text-align: center; width:10px;"><%=count%>.</td>
									<td style="text-align: left;width:120px;"><% if (obj[8] != null) { %><%= obj[8].toString() %> <% } else { %>-<% } %></td>
									<td style="text-align: center; width:20px;"><%if(obj[15]!=null){ %><%=obj[15] %><%} %></td>
									<td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td  class="wrap" style="text-align: center;"><%if(obj[12]!=null){%><%=sdf.format(obj[12])%><%}else{ %>-<%} %></td> 
									<td  class="wrap" style="text-align: left;"><%if(obj[9]!=null){%><%=obj[9]%><%}else{ %>-<%} %></td> 
								
									
									<td class="wrap" style="text-align:center;width:105px;">
									<a class="font" href="javascript:void()"  onclick="submitStatusForm('<%=obj[0] %>')"
									
									<%if(obj[5].toString().equalsIgnoreCase("DI")){ %> style="color:#007bff;"<%} %>
									<%if(obj[5].toString().equalsIgnoreCase("DD")){ %> style="color:#F96302;"<%} %>
									<%if(obj[5].toString().equalsIgnoreCase("DA")){ %> style="color:#D61C4E"<%} %>
									<%if(obj[5].toString().equalsIgnoreCase("DF")){ %> style="color:green"<%} %>
									<%if(obj[5].toString().equalsIgnoreCase("DR")){ %> style="color:#1CD6CE;"<%} %>
									<%if(obj[5].toString().equalsIgnoreCase("RP")){ %> style="color:#641cd6"<%} %>
									<%if(obj[5].toString().equalsIgnoreCase("AP")){ %> style="color:#a17627"<%} %>
									<%if(obj[5].toString().equalsIgnoreCase("DC")){ %> style="color:green"<%} %>
									
									><%if(obj[7]!=null && (obj[7].toString()).equalsIgnoreCase("Reply Prepared By P&C")) {%>Reply By P & C<%}else if(obj[7]!=null && !(obj[7].toString()).equalsIgnoreCase("Reply Prepared By P&C")) {%><%=obj[7].toString() %><%}else{ %>-<%} %>
									<i class="fa-solid fa-arrow-up-right-from-square" style="float: right;" ></i></a></td>
								</tr>
								<%
								count++;	}
								%>
							</tbody>
						</table>

					</div>

				</div>

			</div>
	
	<form action="DakTracking.htm" name="trackingform" id="trackingform" method="POST">
		
		<input type="hidden" name="dakId" id="dakId" />
		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	</form>
	
	
 	<script>
 		function submitStatusForm(dakid){
 			$('#dakId').val(dakid)
 			$('#trackingform').submit();
 		}
 	</script>
 
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


</script> 
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
	   $('#fromdate,#todate').change(function(){
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
		   $('#todate').change(function(){
		       $('#myform').submit();
		    });
		});
</script>

</html>