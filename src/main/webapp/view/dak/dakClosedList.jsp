<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,java.text.SimpleDateFormat,com.vts.dms.dak.model.DakAttachment"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Closed List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>

<style type="text/css">
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
  
.bootstrap-select   .filter-option {

    width: 530px !important;
    height: 230px !important;
    white-space: pre-wrap;
  
}
.bootstrap-select  .dropdown-toggle{
 width: 330px !important;
}

.float-container {
  width: 100%;
  display: flex;
  justify-content: space-between;
}

.table a:hover,a:focus {
   text-decoration: underline !important; 
}


.all {
    color:grey;
    font-weight: 700;
    font-size:16px;
}


.completed {
    color: rgba(0,128,0, 0.8);
    font-weight: 700;
    font-size:16px;
}

.completeddelay {
    color: rgba(255,0,0,0.8);
    font-weight: 700;
    font-size:16px;
}

.ongoing {
    color: rgba(11, 127, 171,0.8);
    font-weight: 700;
    font-size:16px;
}



.ongoingdelay {
    color: rgba(255, 165, 0, 0.9);
    font-weight: 700;
    font-size:16px;
}


.OG{
white-space: normal;
background-image: linear-gradient(rgba(11, 127, 171,0.3), rgba(11, 127, 171,0.8) 50%)!important;
	border-color:rgba(11, 127, 171,0.8);
}

.DO{
white-space: normal;
background-image: linear-gradient(rgba(230, 126, 34, 0.5), rgba(255, 165, 0, 0.9) 50%)!important;
	border-color:rgba(255, 165, 0, 0.9);
}

.CD{
white-space: normal;
background-image: linear-gradient(rgba(255,0,0, 0.5), rgba(255,0,0,0.8) 50%)!important;
	border-color:rgba(255,0,0,0.8);
}

.CO{
white-space: normal;
background-image: linear-gradient(rgba(0,128,0, 0.5), rgba(0,128,0, 0.8) 50%)!important;
	border-color:rgba(0,128,0, 0.8);
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
				<h5 style="font-weight: 700 !important">DAK Closed List</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Closed List</li>
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
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>
	<div align="center">
		<div class="alert alert-danger" id="fail" role="alert">
			<%=ses1%>
		</div>
	</div>
	<%
	}
	if (ses != null) {
	%>
	<div align="center">
		<div class="alert alert-success" id="pass" role="alert">
			<%=ses%>
		</div>
	</div>
	<%
	}
	%>
			<%  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
			    String frmDt=(String)request.getAttribute("frmDt");
			    String toDt=(String)request.getAttribute("toDt");
			    List<Object[]> DakClosedList = (List<Object[]>) request.getAttribute("dakClosedList");
			    String statusFilteration =(String)request.getAttribute("statusValue");
             %>

<div class="card loadingCard" style="display: none;">
<div class="card-header"style="height: 2.7rem">
  <form action="DakClosedList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <div class="row ">
      <div class="float-container" style="float:right;">
      
      
        <div id="label1" style="width: 70%; text-align: left;margin-top: -1rem;">
         <table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 13px;text-align: center"> 
									    <button type="button" class="btn btn-sm statusBtn" id="All" onclick="setStatus('All')"><span class="all"></span><span class="all">&nbsp;All&nbsp;</span></button>&nbsp;&nbsp;
                                       <!--<button type="button" class="btn btn-sm statusBtn" id="Ongoing" onclick="setStatus('Ongoing')"><span class="ongoing">OG</span><span class="ongoing"> &nbsp;:&nbsp; On Going </span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="OngoingDelay" onclick="setStatus('OngoingDelay')"><span class="ongoingdelay">DO</span><span class="ongoingdelay">&nbsp; :&nbsp;Delay - On Going</span></button>&nbsp;&nbsp; -->
                                       <button type="button" class="btn btn-sm statusBtn" id="Completed" onclick="setStatus('Completed')"><span class="completed">CO</span><span class="completed">&nbsp; :&nbsp; Completed</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="CompletedDelay" onclick="setStatus('CompletedDelay')"><span class="completeddelay">CD</span><span class="completeddelay">&nbsp; :&nbsp; Completed with  Delay</span></button>&nbsp;&nbsp; 
										<input type="hidden" id="StatusFilterValId" name="StatusFilterVal" value="">
									</p>
								</td>									
							</tr>
							</thead>
							</table>
        </div> 
        
        <div class="label2" style="width: 40%; text-align: right;">
          <div class="row Details" >
         
            <div class="col-1" style="font-size: 16px; padding-left:120px;  ">
              <label for="fromdate" style="text-align: center;font-size: 16px;width:50px;">From &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            
            <div class="col-4" style="padding-left:80px; ">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <div class="col-1" style="font-size: 16px; padding-left:30px;">
              <label for="todate" style="text-align: center;font-size: 16px;width:20px;">To </label>
            </div>
            <div class="col-4" style="padding-left:0;  ">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
           <!--  <div class="col-1"></div> Empty column for spacing -->
          </div>
        </div>
      </div>
    </div>
  </form>
</div>
 <form action="#" method="post" id="ClosedListForm">
   <div class="table-responsive" style="overflow:hidden;">
   <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
							<tr>
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">DAK Id</th>
									<th class="text-nowrap">Head</th>
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">Ref No & Date</th>
									<th class="text-nowrap">Action Due</th>
								    <th class="text-nowrap">Subject</th> 
								    <th class="text-nowrap">Closed By & Date</th> 
									<th style="width: 170px;">Action</th>
						</tr>
							</thead>
							<tbody>	
							<%
								 int count=0;
								if(DakClosedList!=null && DakClosedList.size()>0){
									for(Object[] obj:DakClosedList){
										count++;
										%>
										
									
								 <tr id=buttonbackground<%=obj[0]%>>
									<td style="width:10px;"><%=count %></td>
									 <td class="wrap" style="text-align: left;width:80px;">
	 					          	<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakDetailedList')">
                                    <% if (obj[8] != null) { %>
                                    <%= obj[8].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
                                     </td>
								   <td style="text-align: center;width:10px;"><%if(obj[16]!=null){ %><%=obj[16].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
								   <td style="text-align: center;width:80px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
								   <td  class="wrap" style="text-align: left;width:180px;"><%if(obj[13]!=null){%><%=obj[13]%><%}else{ %>-<%} %></td> 
								   <td class="wrap" style="text-align: center;width:120px;"><%if(obj[20]!=null){ %><%=obj[20].toString() %><%}else{ %>--<%} %><br><%if(obj[12]!=null){%><%=sdf.format(obj[12])%><%}else{ %>-<%} %></td>
								
								   	<td style="text-align: center;font-weight:bold;width:15%;">
								   
									 <button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]  %> value="<%=obj[0] %>" 
									   formaction="DakReceivedView.htm" formtarget="_blank" formmethod="post"
									  data-toggle="tooltip" data-placement="top" title="" data-original-title="Preview"> 
															<img alt="mark" src="view/images/preview3.png">
 										  </button>
								   	</td>
								
								</tr>
								<%}} %>	
							</tbody>
					</table>		
   </div>
    </form>
</div>		
</body>
<script>

$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
});
//onload function for Status Filteration
$(document).ready(function(){
	  var StatusFilterationVal = "<%=statusFilteration%>";

	  if(StatusFilterationVal !== 'null' && StatusFilterationVal !== ''){
	   // Set the value of the hidden input field to the loaded button's value
	    document.getElementById("StatusFilterValId").value = StatusFilterationVal;
	   
	   //Highlist selected Button by blue background
	    var selectedButton = document.getElementById(StatusFilterationVal);
	    if (selectedButton) {
	    	console.log('reacheddSelectedd');
	        selectedButton.classList.add("raise");
	      }
	  }else{
		  console.log('statusFilteration val not found');
	  }
});

//onclick function for Status Filteration
function setStatus(value) {
		    // Set the value of the hidden input field to the clicked button's value
		    document.getElementById("StatusFilterValId").value = value;
		    $('#myform').submit();
}
</script>
 
<script type="text/javascript">
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
		   $('#todate').change(function(){
		       $('#myform').submit();
		    });
		});
	</script> 
</html>