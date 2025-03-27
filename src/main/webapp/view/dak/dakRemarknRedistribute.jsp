<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<%@page import="java.time.LocalTime"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Remark And Redistribute</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style type="text/css">
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

.all {
    color:grey;
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

.float-container {
  width: 100%;
  display: flex;
  justify-content: space-between;
}
.Details {
  display: flex;
  justify-content: space-between;
}
.DakListCommonGroupname{
width: 330px !important;
}
.DakListCommonempidSelect{
width: 250px !important;
margin-top: -20px !important;
}
.DakListCommonindividual{
width: 250px !important;
/* margin-left: 20px !important; */
margin-top: -20px !important;
}
.filter-option-inner-inner {
	width: 200px !important;
}
#ReSample{
display: block!important;
}

@keyframes glow {
    0% {
        box-shadow: 0 0 5px 5px rgba(255, 255, 153, 0.8); /* Initial shadow - Light yellow */
    }
    50% {
        box-shadow: 0 0 20px 10px rgba(255, 255, 153, 0.8); /* Expanded shadow - Light yellow */
    }
    100% {
        box-shadow: 0 0 5px 5px rgba(255, 255, 153, 0.8); /* Return to initial shadow - Light yellow */
    }
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
				<h5 style="font-weight: 700 !important">DAK Remark & Redistribute</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				   <li class="breadcrumb-item" aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-file" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Remark & Redistribute</li>
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
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		String statusFilteration =(String)request.getAttribute("statusValue");
		List<Object[]> DakRemarknRedistributeList=(List<Object[]>)request.getAttribute("DakRemarknRedistributeList");
		List<Object[]> DakMembers = (List<Object[]>) request.getAttribute("DakMembers");
		List<Object[]> DakMemberGroup = (List<Object[]>) request.getAttribute("DakMemberGroup");
		
		String PageNo=(String)request.getAttribute("PageNumber");
		String Row=(String)request.getAttribute("RowNumber");
		System.out.println("PageNo :"+PageNo+" Row :"+Row);
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
		<div class="card loadingCard" style="width: 99%; display: none; ">
		<div class="card-header"style="height: 2.7rem">
  <form action="DakRemarkRedistribute.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <div class="row">
      <div class="float-container" style="float:right;">
      
        <div id="label1" style="width: 70%; text-align: left;margin-top: -1rem;">
         <table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 13px;text-align: center"> 
									   <button type="button" class="btn btn-sm statusBtn" id="All" onclick="setStatus('All')"><span class="all"></span><span class="all">&nbsp;All&nbsp;</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="Ongoing" onclick="setStatus('Ongoing')"><span class="ongoing">OG</span><span class="ongoing"> &nbsp;:&nbsp; On Going </span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="OngoingDelay" onclick="setStatus('OngoingDelay')"><span class="ongoingdelay">DO</span><span class="ongoingdelay">&nbsp; :&nbsp;Delay - On Going</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="Completed" onclick="setStatus('Completed')"><span class="completed">CO</span><span class="completed">&nbsp; :&nbsp; Completed</span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="CompletedDelay" onclick="setStatus('CompletedDelay')"><span class="completeddelay">CD</span><span class="completeddelay">&nbsp; :&nbsp; Completed with  Delay</span></button>&nbsp;&nbsp;
										<input type="hidden" id="StatusFilterValId" name="StatusFilterVal" value="">
									</p>
								</td>									
							</tr>
							</thead>
							</table>
        </div>
        
        <div class="label2" style="width: 40%; text-align: right">
          <div class="row Details">
          
            <div class="col-1" style="font-size: 16px; padding-left:120px; ">
              <label for="fromdate" style="text-align: center;font-size: 16px;width:50px;">From &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            
            <div class="col-4" style="padding-left:80px;">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <div class="col-1" style="font-size: 16px; padding-left:30px; ">
              <label for="todate" style="text-align: center;font-size: 16px;width:20px;">To &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            <div class="col-4" style="padding: 0; ">
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
<div class="card-body" style="width: 99%">
					<div class="table-responsive" style="overflow:hidden;">
					<form action="#" method="post"  id="DakReceivedListForm">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
								<tr>
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">DAK Id</th>
									<th style="text-align: center; width: 5%;">Head</th>
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">Ref No & Date </th>
									<th class="text-nowrap" style="width:10%;">Action Due</th>
								    <th class="text-nowrap">Subject</th> 
									<th class="text-nowrap">Status</th>
									<th class="text-nowrap">DAK Status</th>
									<th style="width: 170px;">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
							int count=1;
							 String DakStatus = null;
							if(DakRemarknRedistributeList!=null){
							for(Object[] obj:DakRemarknRedistributeList){ 
								
							%>
								<tr data-row-id=row-<%=count %>>
									<td style="text-align: center;width:10px;"><%=count %></td>
									<td style="text-align: left;width:80px;">
									<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakRemarknRedistributeList')">
                                    <% if (obj[8] != null) { %>
                                    <%= obj[8].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
									</td>
									<%
										 int itemsPerPage = 10;
                              			 // Calculating the page number based on the count and itemsPerPage
										int pageNumber = (count - 1) / itemsPerPage + 1;
									%>
									<td style="text-align: center;width:10px;"><%if(obj[17]!=null){ %><%=obj[17].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:70px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td class="wrap" style="width: 50px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
									<td class="wrap"  style="text-align: left;width:270px;"><%if(obj[13]!=null){ %><%=obj[13].toString() %><%}else{ %><%="NA"%><%} %></td>
									<td  class="<%=obj[12]%>" style="text-align: left;width:40px;text-align: center;font-weight:bold;"><%if(obj[12]!=null) {%><%=obj[12].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:100px;"><%if(obj[7]!=null){ %><%=obj[7].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:150px;">
									<input type="hidden" name=RedirPageNo<%=obj[0]%> value="<%=pageNumber%>">
									<input type="hidden" name=RedirRow<%=obj[0]%> value="<%=count%>">
									 <!-- ReMarking Button -->							  
 					            	 <%if( !"DI".equalsIgnoreCase(obj[5].toString()) &&  !"AP".equalsIgnoreCase(obj[5].toString()) &&  !"DC".equalsIgnoreCase(obj[5].toString())    ){ %>
 						        	<button type="button" onclick="DakReMarking(<%= obj[0] %>,'<%=obj[10]%>',<%=obj[18]%>,'<%=obj[9].toString().trim() %>','DakRemarknRedistributeList','<%=obj[8]%>','<%=obj[3] %>','<%=frmDt %>','<%=toDt %>',<%=pageNumber %>,<%=count %>)" class="btn btn-sm icon-btn" data-toggle="tooltip" title="ReMarkUp">
						     		<img alt="mark" src="view/images/remark.png">
 						        	</button>

 						          <%} else{%><%="NA" %> <%} %>
 						 
 						 
 			           <!-- ReDistribute Button -->		 
 				        	 <%if(Long.parseLong(obj[21].toString())>0){%>
 							<button type="button" data-toggle="tooltip" class="btn btn-sm icon-btn" Onclick="DakReDistribute(<%=obj[0] %>,'DakRemarknRedistributeList','<%=frmDt %>','<%=toDt %>',<%=pageNumber %>,<%=count %>)" data-placement="top" title="Distribute">
 											<img alt="mark"  src="view/images/d1.jpg">
 							</button>  
 										  
 				         	<%} %>	
									</td>
								</tr>
								<%count++;}} %>
							</tbody>
						</table>
                       </form>
					</div>
					 <!----------------------------------------------------  Dak ReMarkup Modal Start  ----------------------------------------------------------->
 	  
 	   <div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" id="exampleModalREmarkgroup" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
     <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content">
 	      <div class="modal-header" style="background-color: #114A86;max-height:60px;">
 	        <h5 class="modal-title" id="exampleModalLong2TitleRemark" ><b ><span style="color: white;">DAK ReMarking</span> </b>
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	       &nbsp;<span style="color: white;">DAK Id:</span> <span style="color: white;" id="DakRemarkActionRequiredEditDakNo">,</span> &nbsp;&nbsp;<span style="color: white;">Source:</span><span style="color: white;" id="DakRemarkActionRequiredEditSource"></span>&nbsp; </h5>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body">
  	      
  	      	<form action="DakREMark.htm" id='markform' method="POST" >
  	      	<div class="row">
							<div class="col-md-6">
									<div align="left">
										<h6 style="text-decoration: underline;">
											<b>Group Marking</b>
										</h6>
									</div>
									<div align="right">
									<label style="margin-left: 30px;"><b>Grouping </b></label>
									&nbsp;&nbsp;&nbsp;
									<select class="form-control selectpicker  DakListCommonGroupname "  multiple="multiple"  id="DakListCommonGroupname" style="width: 20%; " data-live-search="true" name="DakListCommonGroupname[]" >
								   </select> 
								   </div>	
										<hr>
									<div align="left">
										<h6 style="text-decoration: underline; ">
											<b>Individual Marking</b>
										</h6>
									</div><br>
									<select  class="form-control selectpicker  DakListCommonindividual " multiple id="DakListCommonindividual" name="DakListCommonindividual[]" data-live-search="true">
									</select>
									
									<select   onchange='DakListCommonaddEmpToSelect()' class="form-control selectpicker DakListCommonempidSelect dropup" multiple="multiple" data-dropup-auto="true"  id="DakListCommonempidSelect" name="DakListCommonempidSelect" data-live-search="true">
									</select> 
								</div>
							
								<div class="col-md-6">
									
									<div class="row">
									<div  class="col-md-12">
										<div class="card" id="scrollable-content" style="width: 100%; height: 100px; ">
										<div class="card-body">
											<input type="hidden" name="DakListCommonEmpIdGroup" id="DakListCommonEmpIdGroup" value="" />
										<div class="row" id="DakListCommonGroupEmp"style="" >
									
	  	      									</div>
										</div> 
										</div>
									</div></div><br><br>
									<div class="row">
									 <div  class="col-md-12">
										<div class="card" id="scrollable-contentind" style="width: 100%;   margin-top:-10px; height: 100px; ">
										<div class="card-body">
										<div class="row" id="DakListCommonIndividualEmp" style="">
										<input type="hidden" name="DakListCommonEmpIdIndividual" id="DakListCommonEmpIdIndividual" value="" />
	  	      									</div>
										</div> 
										</div>
									</div>
									</div>
								</div>
							</div>
  	      	
  	      		
  	      		<br>
  	      		<div align="center">
  	      			<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
  	      		</div>
 
  	      		<input type="hidden" name="MarkingActionDueDate" id="MarkingActionDueDate" value="" />
  	      		<input type="hidden" name="MarkDakId" id="MarkDakId" value="" />
  	      		<input type="hidden" name="ActionId" id="ActionId" value="" />
  	      		<input type="hidden" name="ActionRequired" id="ActionRequired" value="" />
  	      		<input type="hidden" name="RemarkRedirectValue" id="RemarkRedirectValue" value="" />
  	      		<input type="hidden" id="dakdetailsremarkfromdate" name="FromDate">
  	      		<input type="hidden" id="dakdetailsremarktodate" name="ToDate">
  	      		
  	      		<input type="hidden" id="RemarkPageNumber" name="PageNumber">
  	      		<input type="hidden" id="RemarkRowNumber" name="RowNumber">
  	      		
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 <!----------------------------------------------------  Dak ReMarkup Modal End  ----------------------------------------------------------->

 <!----------------------------------------------------  Dak ReDistribute Modal Start  ----------------------------------------------------------->

	<div class="modal fade my-modal" id="exampleModalRemark" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document">
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
	 	        <h5 class="modal-title" style="margin-left: 150px;" ><b style="color: white;"><span>DAK ReDistribution</span></b> </h5>
	  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body">
	  	      
	  	      	<form action="DakReDistribute.htm"  method="POST" >
	  	      		<div class="row" id="ReSample" >
	  	      		</div>
	  	      		<br>
	  	      		<div align="center">
	  	      			<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To ReDistribute Dak ?')" > 
	  	      		</div>
	  	      		<input type="hidden" name="dakReDistributeId" id="dakReDistributeId" value="" />
	  	      		<input type="hidden" name="ReDistributeEmpId" id="ReDistributeEmpId" value="" />
	  	      		<input type="hidden" id="dakDetailsRedistributeformdate" name="FromDate">
	  	      		<input type="hidden" id="dakDetailsRedistributetodate" name="ToDate">
	  	      		<input type="hidden" name="RedirectVal" id="actionData" value="" />
	  	      		
	  	      		<input type="hidden" id="RedistributePageNumber" name="PageNumber" value="" />
	  	      		<input type="hidden"  id="RedistributeRowNumber" name="RowNumber" value="" />
	  	      		
	  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  	      	</form>
	  	      		
	  	      		
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  Dak ReDistribute Modal End    ----------------------------------------------------------->
					</div>
					</div>
</body>
<script type="text/javascript">
$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
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
<script>
//onload function for Status Filteration
 $(document).ready(function(){
	  var StatusFilterationVal = '<%=statusFilteration%>';

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

$("#myTableDisp").DataTable({
});

$("#myTable2").DataTable({
});
</script> 
<script>


//////////////////////////////////////////////////////////REMARKUP MODAL POPUP AND GROUP MARKING CHANGE TRIGGER JAVASCRIPT/////////////////////////////////////
var PrevSelAllEmps=[]; ///empty array to store all previously selected(marked) employees
var PrevSelGMEmps=[];//empty array to store only previously selected group marking employees
var PrevSelGMEmpsInactive = []; //empty array to store only previously selected group marking employees but later deleted


function DakReMarking(value,ActionDueDate,ActionId,ActionRequired,Redir,dakno,source,fromdate,todate,PageNumber,RowNumber){
              
	          PrevSelGMEmps=[];//every time opening modal making PrevSelGMEmps empty
	          PrevSelGMEmpsInactive=[];//every time opening modal making PrevSelGMEmpsInactive empty
	          PrevInactiveGMMarkedEmpIds(value);
	          
	          $('#exampleModalREmarkgroup').modal('show');
	          $('#MarkingActionDueDate').val(ActionDueDate);
	          $('#MarkDakId').val(value);
	          $('#ActionId').val(ActionId);
	          $('#ActionRequired').val(ActionRequired);
	          $('#DakRemarkActionRequiredEditDakNo').html(dakno);
	          $('#DakRemarkActionRequiredEditSource').html(source);
	          $('#dakdetailsremarkfromdate').val(fromdate);
	          $('#dakdetailsremarktodate').val(todate);
	          var redirect= $('#RemarkRedirectValue').val(Redir);
	          $('#RemarkPageNumber').val(PageNumber);
	          $('#RemarkRowNumber').val(RowNumber);
	          console.log("page:"+PageNumber);
	          console.log("row:"+RowNumber);
	          
	
	      $.ajax({
			    type : "GET",
			    url : "getMarkedGroupMembersEmps.htm",
			    data : {
				   dakId: value
			    },
			    datatype : 'json',
			    success : function(result) {
			       result = JSON.parse(result);
			       var consultVals= Object.keys(result).map(function(e){
			       return result[e]
			       })
			       $('#DakListCommonGroupname').empty();
			       var id=null;
			          <%for(Object[] type : DakMemberGroup){ %>
			               var optionValue = <%=type[0]%>;
		                   var optionText ='<%=type[1]%>';
		                   var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                   for (var c = 0; c < consultVals.length; c++) {
	        	           var gid =consultVals[c][0];
	        	           var Eid=consultVals[c][2];
	        	           PrevSelGMEmps.push(Eid);
	                           if(optionValue==gid){
	                                 option.prop('selected', true);
	                                 option.prop('disabled', true); // Make the option unselectable
	                              }
	                       }
	                       $('#DakListCommonGroupname').append(option);
	                 <%}%>
	                       $('.selectpicker').selectpicker('refresh');
	                       $("#DakListCommonGroupname").trigger("change"); // onload change is triggered
	      
			}//success close
	 });//ajax close
	
	 AllEmpsAlreadyMarked(value); //call another function
}

//////////////////////////////////////////////////////////GROUP MARKING ONCHANGE IN REMARKUP JAVASCRIPT/////////////////////////////////////

   $("#DakListCommonGroupname").change(function () {//if it is changed or onload triggered change(checkout above function)
	  var selGroupdIds = [];
	  $("select[name='DakListCommonGroupname[]'] option:selected").each(function () {
		  selGroupdIds.push($(this).val()); // by using selGroupdIds[] the current selected and prev sel empids will be fetched using getDakmemberGroupEmpList.htm
	  });
	  $('#DakListCommonGroupEmp').empty();
	  
	  if (selGroupdIds.length === 0) {
	        // Clear data and perform necessary actions when no options are selected
	        $('#DakListCommonGroupEmp').empty();
	        $('#DakListCommonEmpIdGroup').val('');
	        return; // Exit the function
	    }
	  
	  
	  $.ajax({
	      type: "GET",
	      url: "getDakmemberGroupEmpList.htm",
	      datatype: 'json',
	      data: {
	         Group: selGroupdIds
	      },
	      success: function (result) {
	            var result = JSON.parse(result);
	          
	            var consultVals = Object.keys(result).map(function (e) {
	            return result[e];
	            });
	      
	            var selectedEmployees = []; // Change selectedEmployees to an array
	            selectedEmployees=  PrevSelGMEmps;
	            //all previous selected empids from group  marking(checkout ajax getMarkedGroupMembersEmps.htm)
	                 
		        $("#DakListCommonGroupname option:selected").each(function () {
	               selectedEmployees.push($(this).val().split(",")[0]);
	            });
	     
	            
	              var prevInactiveGMEmpIds = []; 
                  prevInactiveGMEmpIds = PrevSelGMEmpsInactive;//previously selected EmpIds of group marking but deleted later
         
	            
	       
		        var otherHTMLStr = '';
	            var id = 'Employees';
	            var count = 1;
	            var EmpId = [];
	            
	            for (var c = 0; c < consultVals.length; c++) {
	                if ( (!selectedEmployees.includes(consultVals[c][0]))  &&  (!prevInactiveGMEmpIds.includes(consultVals[c][0])) )  { //means if current marked Empid and previously marked empids are same than dont push for insertion//consultVals[c][0] is a empids got by passing groupids which is both present and previously selected by user
	        	    var Temp = id + (c + 1);
	                otherHTMLStr += '<span style="margin-left:2%" id="name_' + Temp + '">' + count + '. ' + ' ' + consultVals[c][1] + ' , ' + ' ' + ' ' + consultVals[c][2] + '</span><br>';
	                count++;
	                var str = consultVals[c][0] + '/' + consultVals[c][3];
	                EmpId.push(str); //but this is  not checking all empids before pushing mainly individual ones correct this checkout DakEdit.jsp
	                var id = $('#DakListCommonEmpIdGroup').val(EmpId);//this is where selected Group datas will be pushed to textbox
		            $('#DakListCommonGroupEmp').html(otherHTMLStr);
	              }
	            }//for loop close

	        }//success close

   });//ajax close
});//change funcion close
	
//////////////////////////////////////////////////////////INDIVIDUAL MARKING AND CHANGE TRIGGER IN REMARKUP JAVASCRIPT/////////////////////////////////////



  function AllEmpsAlreadyMarked(DakId){
	  var DakId=DakId;
		
		 $.ajax({
			  type: "GET",
			  url: "getDistributedDakMeberslist.htm",
			  data : {
					
				  DakId: DakId
					
				},
				success: function(result) {
				if (result != null) {
				      result = JSON.parse(result);
				      var Data = Object.keys(result).map(function(e) {
				        return result[e];
				      });

				      $('#DakListCommonindividual').empty();
				var groupid=[];
				
				<%for(Object[] type : DakMembers){ %>
			    var optionValue = <%=type[0]%>;
		        var optionText ='<%=type[1]%>';
		        var option = $("<option></option>").attr("value", optionValue).text(optionText);
		        for (var c = 0; c < Data.length; c++) {
		        	 groupid.push(Data[c][0]);
		        	
		             if(optionValue==Data[c][0]){
		             option.prop('selected', true);
		             option.prop('disabled', true); // Make the option unselectable
		             
		          }
		        }
		          $('#DakListCommonindividual').append(option);
<%}%>	
				for (var c = 0; c < Data.length; c++) {
					PrevSelAllEmps.push(Data[c][1]);
				}
				
				console.log('allEmps',PrevSelAllEmps);

                  var defaultOption = $("<option></option>").attr("value", "0").text("Individual");
                  for (var c = 0; c < Data.length; c++) {
 		        	 groupid.push(Data[c][0]);
 		             if(0==Data[c][0]){
 		            	defaultOption.prop('selected', true);
 		            	defaultOption.prop('disabled', true); // Make the option unselectable
 		          }
                  }
                  
                  $('#DakListCommonindividual').append(defaultOption);

				$('#DakListCommonindividual').trigger('change');// onload change is triggered
				
				}
				}
			});
  }
  
  function PrevInactiveGMMarkedEmpIds(DakId){//Is Active is checked
		 var DAKID=DakId;
		 $.ajax({
			  type: "GET",
			  url: "getMarkedInactiveGroupMembersEmps.htm",
			  data : {
				  dakId: DAKID
				},
				 datatype : 'json',
				success: function(result) {
					console.log(result);
					console.log(result);
					if (result != null) {
						
						   
						   result = JSON.parse(result);
						      var Data = Object.keys(result).map(function(e) {
						        return result[e];
						      });
		                   
						      for (var c = 0; c < Data.length; c++) {
		                	   PrevSelGMEmpsInactive.push(Data[c][2]);
							}    
						      console.log('InactiveEmps',PrevSelGMEmpsInactive);
					}
					
				}//success close
		 });
	}
//////////////////////////////////////////////////////////INDIVIDUAL MARKING ONCHANGE IN REMARKUP JAVASCRIPT/////////////////////////////////////


  $("#DakListCommonindividual").change(function(){ //if it is changed or onload triggered change(checkout above function)
 	  var value = [];
 	  $("select[name='DakListCommonindividual[]'] option:selected").each(function() { // Fix the selector here
 		  value.push($(this).val());
 	  });
 	 
 	  $.ajax({
 	         type: "GET",
 	         url: "getSelectEmpList.htm",
 	         data: {
 	            empId: value
 	         },
 	         datatype: 'json',
 	         success: function (result) {
 	    	
 	                var result = JSON.parse(result);
 	                var consultVals = Object.keys(result).map(function (e) {
 	                return result[e];
 	                });

 	                var selectedEmployees = [];
 	                selectedEmployees=  PrevSelAllEmps;
 	                $("#DakListCommonempidSelect option:selected").each(function () {
 	                selectedEmployees.push($(this).val().split(",")[0]);
 	                });// selectedEmployees array is going to contain all user selected options by user while submit
 	      
 
 	                $('#DakListCommonempidSelect').empty();
 	     
 	                for (var c = 0; c < consultVals.length; c++) {
 	                    var optionValue = consultVals[c][0] + '/' + consultVals[c][3];
 	                    var optionText = consultVals[c][1] + ', ' + consultVals[c][2];
 	                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
 	        
 	                if (selectedEmployees.includes(consultVals[c][0])) { //if selected Employees and priviously inserted employees are same then dont push those
 	                    option.prop('selected', true);
 	                    option.prop('disabled', true);
 	                }
 	                $('#DakListCommonempidSelect').append(option);
 	        
 	      }//consultValsForLoop closed
 	      $('.selectpicker').selectpicker('refresh');
 	     
 	        },
 	       error: function() {
 	         // Handle the error response here
 	       }
 	        
	   });//ajax close
  });//change function close
  

</script>
<script>
////////////////////////////////////////ONCHANGE OF INDIVIDUAL MARKING TRIGGERED FUNCTION///////////////////////////
 
function DakListCommonaddEmpToSelect(){
 	     var options = $('#DakListCommonempidSelect option:selected');
 	     var selected = [];
 	     var otherHTML = '';
 		 var id='employeesSelectedIndividual';
 		 var count=1;
 	   
 		 $(options).each(function(){
 		    otherHTML += '<span style="margin-left:2%" id="id">'+count+'.  '+' '+$(this).text()+'</span><br>';
 		    count++;
 		    selected.push($(this).val());
 	    });
 	    $('#DakListCommonEmpIdIndividual').val(selected);
 	    $('#DakListCommonIndividualEmp').html(otherHTML);
 	    
 }
 </script>
  <script>
 function DakReDistribute(value,redistributeRedirect,fromdate,todate,PageNumber,RowNumber){
	 $('#dakReDistributeId').val(value);   
	 $('#actionData').val(redistributeRedirect);
	 $('#exampleModalRemark').modal('show');
	 $('#dakDetailsRedistributeformdate').val(fromdate);
	 $('#dakDetailsRedistributetodate').val(todate);
	 $('#RedistributePageNumber').val(PageNumber);
	 $('#RedistributeRowNumber').val(RowNumber);
	
	 $.ajax({
			
			type : "GET",
			url : "getReDistributedEmps.htm",
			data : {
				
				dakId: value
				
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
			var html = '';
			var selid='Employees';
			var count=1;
			var employeeid=[];
			for (var c = 0; c < consultVals.length; c++) {
			    var Temp = selid + (c+1);
			    html += '<span style="margin-left:4%" id="'+ Temp +'">'+count+'.'+consultVals[c][1]+' , '+consultVals[c][2]+'</span><br>';
			    count++;
			    employeeid.push(consultVals[c][0]);
			}
			$('#ReDistributeEmpId').val(employeeid);
			$('#ReSample').html(html);
			
			}
	 });
			
			
 }
 </script>
 <script>
	        // Get PageNo and Row from JSP attributes
	        var pageNoNavigate = <%=PageNo%>;
	        var rowToHighlight  = <%=Row%>;
	        console.log('PageNo'+pageNoNavigate+'Row'+rowToHighlight);
	        
	        if(pageNoNavigate!=null && rowToHighlight!=null){
	        document.addEventListener("DOMContentLoaded", function () {
	        	  // Navigate to the specified page
	            navigateToPage(pageNoNavigate);
	        	
	            // Highlight the specified row
	            highlightRow(rowToHighlight);

	        });
	        
	        }
	        
	        
	        function highlightRow(count) {
	        	var rowElement = document.querySelector('[data-row-id="row-' + count + '"]');
	          	console.log("afsdadasd"+count);
	        	if (rowElement) {
	          
		              	console.log("afsdadasd");
		                rowElement.scrollIntoView();
	            	
		                // Apply the glow animation directly to the element's style
	                	console.log("sdfsxdcf"+count);
	                         rowElement.style.animation = "glow 2s infinite"; // Adjust the duration as needed (in seconds)

	                // Set a timeout to remove the animation after a certain duration (e.g., 6 seconds)
	                 /*   setTimeout(function () {
	                  rowElement.style.animation = "none";
	                     }, 5000); */ // Adjust the duration as needed (in milliseconds)
	            }
	        }

	        function navigateToPage(page) {
	        	  // Assuming you have initialized your DataTable with the id 'myTable1'
	            var table = $("#myTable1").DataTable();

	            // Use DataTables API to go to the specified page
	            table.page(page - 1).draw('page');
   }
	        
	        </script>
</html>