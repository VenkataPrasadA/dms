<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dak Closing List</title>
<style type="text/css">

div.dropdown-menu.open
    {
        max-height: 410px !important;
        overflow: hidden;
    }
    ul.dropdown-menu.inner
    {
        max-height: 410px !important;
       /*  overflow-y: auto; */
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

.AssignedEmpDeleteBtn{
background-color:red;
border: none !important;
border-radius: 6px;
cursor: pointer !important;
margin-right: 10px;
width: 25%;
}
.AssignedEmpDeleteBtn:focus {
    outline: none;
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
	/* transition: all 0.3s ease-out; */
	/* Remove the transition property */
      transition: none;
         backface-visibility: hidden;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	  /* Float the expanded menu down */
    float: none;
    clear: both;
    display: block;
    /* Set a fixed width for the expanded state */
    width: auto;
    /* Add overflow: visible to ensure the content is visible when expanded */
    overflow: visible;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 10;
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
body {
   overflow-x: hidden;
}


  .col-2 h6 {
    margin-bottom: 0;
  }
  
#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
}

.MsgByDir{
color:#2196F3!important;
font-size:12px;
}

.replyOfCSWData {
  color: black;
  user-select: all;
  outline: none;
  height: 51px;
/*   border: 1px solid grey; */
  text-align: left;
  padding-left: 10px;
  margin-left: 30px;
  width: 700px !important;
 float: left; 
 box-shadow: rgba(14, 30, 37, 0.32) 0px 0px 0px 3px;
border-radius:3px!important;
  
}

.replyOfCSWData button,
.replyOfCSWData span {
  user-select: none;
}

.CSWAttachDownloadTbl td {
    padding: 0.2rem;
    border:none;
}
.cswempidSelect{
width: 700px !important;
margin-top: -20px !important;
}

.seekResponseempidSelect{
width: 565px !important;
margin-top: -20px !important;
}


#DirectorApprovalSelVal option.selectpickerSimple {
    border-radius: 6px !important; 
}

.table a:hover,a:focus {
   text-decoration: underline !important; 
}

.HighlightHighPrior{
    background: rgb(223 42 42 / 50%)!important;
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

.Favourites {
   color: rgba(0, 128, 0, 0.9);
    font-weight: 700;
    font-size:16px;
}

.Urgent{
 color: rgba(242, 23, 7);
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


.star {
    visibility:hidden;
    font-size:25px;
    margin-top: -2px;
    cursor:pointer;
}

.star:before {

content: "\2605";
position: absolute;
color:#CDCDCD;
visibility:visible;
     
}
.star:checked:before {
  /* color:#FFA600; */
  color:#FFD23F;
   position: absolute;
  animation: fav 600ms ease;
}

@keyframes fav {
  60% {
    transform: scale(1.5);
  }
  90% {
    transform: scale(1);
  }
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

.custom-selectEnote {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 330px !important;
}

.custom-selectEnote select {
  /* Hide the default select dropdown arrow */
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  /* Add some padding to make room for the arrow */
  padding-right: 20px;
  width: 100%;
  height: 10px;
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

.ReplyReceivedMail{
width: 430px !important;
margin-top: 0px !important;
}

.Signatory {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 350px !important;

}

.Signatory select {
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
.Signatory::after {
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
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style type="text/css">
.highlighted {
   background-color: yellow;
   /* You can customize the highlighting styles */
}
textarea {
   resize: none; /* Disable user resizing */
   overflow-y: hidden; /* Hide vertical scrollbar */
   min-height: 50px; /* Set a minimum height */
}
</style>
</head>
<body>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Closing List</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Closing List</li>
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
		<%
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
	
		String statusFilteration =(String)request.getAttribute("statusValue");

		List<Object[]> dakClosingList=(List<Object[]>)request.getAttribute("dakClosingList");
		
		
		%>
		
		<div class="card loadingCard" style="display: none;">
    	<div class="card-header"style="height: 2.7rem">
  <form action="DakClosingList.htm" method="POST" id="myform"> 
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
                                       <button type="button" class="btn btn-sm statusBtn" id="Ongoing" onclick="setStatus('Ongoing')"><span class="ongoing">OG</span><span class="ongoing"> &nbsp;:&nbsp; On Going </span></button>&nbsp;&nbsp;
                                       <button type="button" class="btn btn-sm statusBtn" id="OngoingDelay" onclick="setStatus('OngoingDelay')"><span class="ongoingdelay">DO</span><span class="ongoingdelay">&nbsp; :&nbsp;Delay - On Going</span></button>
                                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="hidden" id="StatusFilterValId" name="StatusFilterVal" value="">
									</p>
								</td>									
							</tr>
							</thead>
							</table>
        </div>
        
        <div class="label2" style="width: 40%; text-align: right">
          <div class="row Details" >
         
            <div class="col-1" style="font-size: 16px; padding-left:120px; ">
              <label for="fromdate" style="text-align: center;font-size: 16px;width:50px;">From &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            
            <div class="col-4" style="padding-left:80px;  ">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <div class="col-1" style="font-size: 16px; padding-left:30px;  ">
              <label for="todate" style="text-align: center;font-size: 16px;width:20px;">To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            <div class="col-4" style="padding: 0; float:right;">
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


<br>

<div class="card-body" style="width: 99%">
      <div class="table-responsive" style="overflow:hidden;">
         <form action="#" method="post" id="dakClosingListForm">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="fromDateFetch"	value="<%=frmDt%>" />	
 					<input type="hidden" name="toDateFetch"	value="<%=toDt%>"/>	
 					<input type="hidden" name="viewfrom" value="DakClosingList">
 					<table class="table table-bordered table-hover table-striped table-condensed " id="myTabledakPendingList">
							<thead>
								<tr >
								    <th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th class="text-nowrap">Head</th>
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">Ref No & Date</th>
									<th class="text-nowrap">Action Due</th>
									<th class="text-nowrap">Subject</th>
								    <th class="text-nowrap">DAK Status</th>
									<th class="text-nowrap">Status</th>
									<th style="width: 170px;">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								 int count=1;
								if(dakClosingList!=null && dakClosingList.size()>0){
									for(Object[] obj:dakClosingList){
										
									    String cssStatClass = "default";
										   if(obj[13]!=null && ("CO").equalsIgnoreCase(obj[13].toString().trim()))  {
											   cssStatClass = "greenStatus";
										   }else if(obj[13]!=null && ("CD").equalsIgnoreCase(obj[13].toString().trim()))  {
												   cssStatClass = "redStatus";
										   }else if(obj[13]!=null && ("OG").equalsIgnoreCase(obj[13].toString().trim()))  {
													   cssStatClass = "blueStatus";
										   }else if(obj[13]!=null && ("DO").equalsIgnoreCase(obj[13].toString().trim()))  {
														   cssStatClass = "orangeStatus";
										   }
										  
										   String Action=null;
											  
										   if(obj[9]!=null && "ACTION".equalsIgnoreCase(obj[9].toString())){
											   Action="A";
										   }else if(obj[9]!=null && "RECORDS".equalsIgnoreCase(obj[9].toString())){
											   Action="R";
										   }
										
										   
										   String StatusCountAck = null;
											String StatusCountReply = null;
											 
											if(obj[5]!=null  && obj[30]!=null && Long.parseLong(obj[28].toString())==0
												&& obj[27]!=null && Long.parseLong(obj[27].toString())>0
												&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
												&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
												&& !obj[5].toString().equalsIgnoreCase("FP") ){	
												StatusCountAck = "Acknowledged<br>["+obj[27]+"/"+obj[25]+"]";
											   }
											
											 if(obj[5]!=null  && obj[27]!=null && Long.parseLong(obj[27].toString())>0
												&& obj[26]!=null && Long.parseLong(obj[26].toString()) > 0
											    && obj[28]!=null && Long.parseLong(obj[28].toString()) > 0
												&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
												&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
												&& !obj[5].toString().equalsIgnoreCase("FP") ){	
												 StatusCountReply  = "Replied<br>["+obj[28]+"/"+obj[26]+"]";
													   }
								          /////////////////////////////////////////
										   
										   %>
										   <tr <%if(obj[30]!=null && Long.parseLong(obj[30].toString())==3){ %> class="HighlightHighPrior"<%}%>>
										   
										          <td style="width:10px;"><%=count %></td>
										          <td class="wrap" style="text-align: left;width:80px;">
										            <a class="font" href="javascript:void()" style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakClosingList')">
                                                     <% if (obj[8] != null) { %><%= obj[8].toString() %><% } else { %>-<% } %>
                                                    </a>
                                                  </td> 
                                                   <td style="text-align: center;width:10px;"><%if(obj[18]!=null){ %><%=obj[18].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td> 
								     <td style="text-align: center;width:80px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
								     <td  class="wrap" style="text-align: left;width:180px;"><%if(obj[14]!=null){ %><%=obj[14].toString() %><%}else{ %>-<%} %></td>
                                     <td class="wrap"  style="text-align: left;width:90px;text-align: center;font-weight:bold;">
								
									<%if(obj[7]!=null) {%>
									
									     <%if(StatusCountAck!=null) {%>
									      <%=StatusCountAck%>
									     <%}else if(StatusCountReply!=null) {%>
									      <%=StatusCountReply%>
									     <%}else{%>
									      <%=obj[7].toString() %>
									    <%}%>
									    
									<%} %>
									
									</td>
									<td  class="<%=obj[13]%>" style="text-align: left;width:40px;text-align: center;font-weight:bold;"><%if(obj[13]!=null) {%><%=obj[13].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;font-weight:bold;width:15%;">
	<!-----------------------------Preview Action code Start ---------------------------------------------------------------------------------------------------------->									 
									 <button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]  %> value="<%=obj[0] %>" 
									   formaction="DakReceivedView.htm" formmethod="post" formtarget="_blank"
									  data-toggle="tooltip" data-placement="top" title="" data-original-title="Preview"> 
															<img alt="mark" src="view/images/preview3.png">
 										  </button>
 <!---------------------------------Preview Action code End --------------------------------------------------------------------------------------------------------->		
 								   <%if(obj[17]!=null && Long.parseLong(obj[17].toString())>0){ %>
 								   <input type="hidden" name="DakNoToClose_<%=obj[0]%>"	value="<%=obj[8] %>" />	
 									<button type="button" class="btn btn-sm icon-btn" 
 									data-toggle="tooltip" data-placement="top" data-original-title="Dak Close" 
 									onclick="DakCloseValidation('<%=obj[0]%>', '<%=obj[8]%>','<%=obj[3]%>')">
                                     <img alt="mark" src="view/images/dakClose.png"> 
 									</button>	
 								   <%} %>
  		 <input type="hidden" name="DakNo_<%=obj[0]%>"	value="<%=obj[8]%>" />	 <!-- commonInputTypeHidden -->								
 												
									</td> 
                                                    
										   </tr>
									<%count++;}} %> 
							</tbody>
							</tbody>
					</table>		
 		</form>			
      </div>
      <div class="modal fade" id="dakCloseModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content" style="height: 300px; border:black 1px solid; width: 100%;">

      <div class="modal-header text-white" style="background-color: #005C97;">
        <h5 class="modal-title" id="dakCloseHeader">Dak Closing</h5>
        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <!-- FORM STARTS -->
      <form action="DakClose.htm" method="post" onsubmit="return confirmSubmit();">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
        <div class="modal-body">
          <input type="hidden" id="closeDakId" name="DakIdForClose" />
          <input type="hidden" id="closeDakNo" name="dakNo" />
          <input type="hidden" name="fromDateFetch"   value="<%=frmDt%>" />	
          <input type="hidden" name="toDateFetch"	 value="<%=toDt%>" />
          <input type="hidden" name="WithApprovalDakClose" value="DakClosingList">

          <label style="font-size: 16px;"><b>Closing Comment</b></label>
          <textarea class="form-control" id="closingComment" name="DakClosingComment" rows="4" required></textarea>
        </div>

        <div class="col-md-12 text-center mb-3">
          <button type="submit" class="btn btn-primary btn-sm submit">Submit</button>
        </div>
      </form>
      <!-- FORM ENDS -->

    </div>
  </div>
</div>

      
   </div>
 
</div>
		
</body>
<script type="text/javascript">
$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
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
	
	function DakCloseValidation(dakId, dakNo, source) {

		  // Fill hidden fields
		  document.getElementById("closeDakId").value = dakId;
		  document.getElementById("closeDakNo").value = dakNo;

		  // Set modal header
		  document.getElementById("dakCloseHeader").innerText = "Dak Closing - " + dakNo +"  " + " Source - " + source;

		  // Clear old comment
		  document.getElementById("closingComment").value = "";

		  // Show modal
		  $("#dakCloseModal").modal("show");
		}
	
	function confirmSubmit() {
	    return confirm("Are you sure you want to close this DAK?");
	}
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
$("#myTabledakPendingList").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	
</script>
</html>