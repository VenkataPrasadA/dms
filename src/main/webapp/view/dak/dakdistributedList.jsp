<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style type="text/css">
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 30px;
	height: 20px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 100px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 30px;
	height: 20px;
	box-sizing: border-box;
	margin: 0 0 0 0;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 4px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 12px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}
div.dropdown-menu.open
    {
        max-height: 410px !important;
        overflow: hidden;
    }
    ul.dropdown-menu.inner
    {
        max-height: 410px !important;
        overflow-y: auto;
    }
  

h1 { font-size: 32px; }
h2 { font-size: 26px; }
h3 { font-size: 18px; }
p { margin: 0 0 15px; line-height: 24px; color: gainsboro; }


.container { 
  max-width: 960px; 
  height: 100%;
  margin: 0 auto; 
  padding: 20px;
}
#sidebarCollapse{
display:none;
}
#sidebar{
display:none;
}


</style>
<title>DAK Distributed List</title>
</head>
<body>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Distibuted List</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Distributed List </li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>
<div class="card" >
<div class="card-header" style="height: 2.9rem">
 <form action="DakDistributedList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float: right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
              <label for="fromdate" style="text-align:  center;font-size: 16px;width:103px; ">From Date:</label>
              <input type="text" style="width:113px; margin-top: -5px; height: 2rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label for="todate" style="text-align: center;font-size: 16px;width:103px;">To Date:</label>
              <input type="text" style="width:113px;  margin-top: -5px; height: 2rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
          </div>
        </div>
      </div>
      </form>
</div>
<%

String frmDt=(String)request.getAttribute("frmDt");
String toDt=(String)request.getAttribute("toDt");
%>
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
		<div class="alert alert-success" role="alert" >
        	<%=ses %>
        </div>
    </div>
    <%} %>
                    
<%  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> DakDistributedList = (List<Object[]>) request.getAttribute("DakDistributedList");
	
%>


				<div class="card-body"> 
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th style="text-align: center;">Head</th>
									<th style="text-align: center;">Emp Name</th>
									<th style="text-align: center;">Source</th>
									<th style="text-align: center;">Ref No Date</th>
									<th style="text-align: center;">Ack</th>
									<th style="text-align: center;">Action Due</th>
									<th style="text-align: center; width: 5%;">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								 int count=1;
								if(DakDistributedList!=null && DakDistributedList.size()>0){
									for (Object[] obj : DakDistributedList) {
										String Status = null;
								        if(obj[5]!=null && "N".equalsIgnoreCase(obj[5].toString().trim() )){
								            	Status ="No";
								        }else  if("Y".equalsIgnoreCase(obj[5].toString().trim() )){
								        		Status ="Yes";
								        }else{
								        	Status = "-";
								        }
								%>
							
								<tr>
									<td style="text-align: center;width:10px;"><%=count%></td>
									<td style="text-align: left;width:80px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;width:10px;"><%if(obj[8]!=null){ %><%=obj[8].toString() %><%}else{ %>-<%} %></td>
 									<td style="text-align: left;width:150px;"><%if(obj[2]!=null){ %><%=obj[2].toString()+","+obj[11].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: left;width:150px;"><%if(obj[9]!=null){ %><%=obj[9].toString() %><%}else{ %>-<%} %><br><%if(obj[10]!=null){%><%=sdf.format(obj[10])%><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center;width:50px;"><%if(obj[12]!=null){ %><%=obj[12].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center;width:80px;"><%if(obj[6]!=null){ %><%=sdf.format(obj[6]) %><%}else{ %><%="NA" %><%} %></td>
									<td class="wrap"  style="text-align: center;"><button type="button" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]  %> value="<%=obj[0] %>"  onclick="Preview(<%=obj[0]%>,<%=obj[0] %>,'Y',<%=obj[7]%>)"> 
 											<div class="cc-rockmenu" >
													<div class="rolling">
														<figure class="rolling_icon">
															<img alt="mark" src="view/images/preview3.png">
														</figure>
														<span>Preview</span>
													</div>
												</div>
 										  </button></td>
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
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
    "pagingType": "simple",
     ordering: true

});	

$("#myTableDisp").DataTable({
});

$("#myTable2").DataTable({
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
		   $('#fromdate, #todate').change(function(){
		       $('#myform').submit();
		    });
		});



</script>
</html>