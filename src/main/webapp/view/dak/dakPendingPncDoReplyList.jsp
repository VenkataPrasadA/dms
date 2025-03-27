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
<title>DAK PnCDo Pending Reply</title>
<style>
div.dropdown-menu.open
    {
        max-height: 410px !important;
        overflow: hidden;
    }
    ul.dropdown-menu.inner
    {
        max-height: 410px !important;
        /* overflow-y: auto; */
    }
  
  .HighlightHighPrior{
    background: rgb(223 42 42 / 50%)!important;
}
  
  
.bootstrap-select   .filter-option {

    width: 530px !important;
    height: 230px !important;
    white-space: pre-wrap;
  
}
.bootstrap-select  .dropdown-toggle{
 width: 330px !important;
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


/* -------TAB SWITCHING CSS START ----- */
.tabs {
  position: relative;
  display: flex;
  min-height: 500px;
  border-radius: 8px 8px 0 0;
  overflow: scroll;
}
.tabs::-webkit-scrollbar {
    display: none;
}
.tabby-tab {
  flex: 1;
}
#Sample{
display:block;
}
.tabby-tab label {
  display: block;
  box-sizing: border-box;
  /* tab content must clear this */
    height: 37px;
  
  padding: 5px;
  text-align: center;
  background: #114A86;
  cursor: pointer;
  transition: background 0.5s ease;
  color: white;
  font-size: large;
}

.tabby-tab label:hover {
  background: #5488BF ;
}

.tabby-content {
  position: absolute;
  left: 0; bottom: 0; right: 0;
    top: 40px; 
  
  padding: 20px;
  border-radius: 0 0 8px 8px;
  background: white;
  
  transition: 
    opacity 0.8s ease,
    transform 0.8s ease   ;
    opacity: 0;
    transform: scale(0.1);
    transform-origin: top left;
  
}

.tabby-content img {
  float: left;
  margin-right: 20px;
  border-radius: 8px;
}

.tabby-tab [type=radio] { display: none; }
[type=radio]:checked ~ label {
  background: #5488BF ;
  z-index: 2;
}

[type=radio]:checked ~ label ~ .tabby-content {
  z-index: 1;
    opacity: 1;
    transform: scale(1);
}

@media screen and (max-width: 767px) {
  .tabs { min-height: 400px;}
}

@media screen and (max-width: 480px) {
  .tabs { min-height: 580px; }
  .tabby-tab label { 
    height: 60px;
  }
  .tabby-content { top: 60px; }
  .tabby-content img {
    float: none;
    margin-right: 0;
    margin-bottom: 20px;
  }
}
/* -------TAB SWITCHING CSS END ----- */


.completed {
    color: rgba(0,128,0, 0.8);
    font-weight: 700;
    font-size:16px;
}
.greenStatus{
white-space: normal;
background-image: linear-gradient(rgba(0,128,0, 0.5), rgba(0,128,0, 0.8) 50%)!important;
	border-color:rgba(0,128,0, 0.8);
}
.completeddelay {
    color: rgba(255,0,0,0.8);
    font-weight: 700;
    font-size:16px;
}
.redStatus{
white-space: normal;
background-image: linear-gradient(rgba(255,0,0, 0.5), rgba(255,0,0,0.8) 50%)!important;
	border-color:rgba(255,0,0,0.8);
}

.ongoing {
    color: rgba(11, 127, 171,0.8);
    font-weight: 700;
    font-size:16px;
}
.blueStatus{
white-space: normal;
background-image: linear-gradient(rgba(11, 127, 171,0.3), rgba(11, 127, 171,0.8) 50%)!important;
	border-color:rgba(11, 127, 171,0.8);
}


.ongoingdelay {
    color: rgba(255, 165, 0, 0.9);
    font-weight: 700;
    font-size:16px;
}

.orangeStatus{
white-space: normal;
background-image: linear-gradient(rgba(230, 126, 34, 0.5), rgba(255, 165, 0, 0.9) 50%)!important;
	border-color:rgba(255, 165, 0, 0.9);
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

#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
}


.disabledExpand{
background-color: #808080;
   border: none;
  outline: none;
 
  &[disabled] {
        opacity: 0.5;
        cursor: not-allowed;
    }
      
.table a:hover,a:focus {
   text-decoration: underline !important; 
}


</style>
</head>
<body>
<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
	String frmDt=(String)request.getAttribute("frmDt");
	String toDt=(String)request.getAttribute("toDt");
	List<Object[]> DakPendingPnCDOList=(List<Object[]>)request.getAttribute("DakPendingP&CDOList");
%>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK P & C DO Pending Reply List</h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a
							href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="DakDashBoard.htm"><i
								class="fa fa-envelope"></i> DAK</a></li>
						<li class="breadcrumb-item active">DAK P & C DO Pending Reply List</li>
					</ol>
				</nav>
			</div>
		</div>
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
	
	<div class="card" style="width: 99%">
<div class="card-header" style="height: 3rem">
 <form action="DakPendingP&CDOList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
 <div class="row ">
      <div class="float-container" style="float:right;">
      
        <div id="label1" style="width: 70%; text-align: left;margin-top: -1rem;">
         <table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 13px;text-align: center"> 
									    <span class="ongoing">OG</span><span class="ongoing"> &nbsp;:&nbsp; On Going </span>&nbsp;&nbsp; 
										<span class="ongoingdelay">DO</span><span class="ongoingdelay">&nbsp; :&nbsp; Delay - On Going</span> &nbsp;&nbsp; 
										
									</p>
								</td>									
							</tr>
							</thead>
							</table>
        </div>
        
        <div class="label2" style="width: 50%; float: right;">
          <div class="row Details" >
          
            <div class="col-1" style="font-size: 16px; padding-left:120px;">
              <label for="fromdate" style="text-align: center;font-size: 16px;width:50px;">From &nbsp;&nbsp;</label>
            </div>
            <div class="col-4" style="padding-left:80px;">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <div class="col-1" style="font-size: 16px; padding-left:30px;">
              <label for="todate" style="text-align: center;font-size: 16px;width:20px;">To &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </div>
            <div class="col-4" style="padding: 0;">
              <input type="text" style="width:113px;margin-top: -0.6rem;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
              <label class="input-group-addon btn" for="testdate"></label>
            </div>
            <!-- <div class="col-1"></div> Empty column for spacing -->
          </div>
        </div>
      </div>
    </div>
  </form>
</div>
			
			
			
			
				<div class="card-body"> 
					<div class="table-responsive" style="overflow:hidden;">
					<form action="#" method="post" id="PNCDoListForm">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="fromDateFetch"	value="<%=frmDt%>" />	
 					<input type="hidden" name="toDateFetch"	value="<%=toDt%>"/>	
 											
						<table
							class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th class="text-nowrap">Email Type</th>
									<th style="text-align: center;">Source</th>
									<th class="text-nowrap">DAK Brief</th>
									<th class="text-nowrap">A/R</th>
									<!-- <th style="text-align: center;">Ref No & Date</th> -->
									<th style="text-align: center; width: 5%;">Action Due</th>
									<th class="text-nowrap">Keyword1</th> 
								    <th class="text-nowrap">Reply  Date</th> 
								    <th class="text-nowrap">Reply Details</th> 
									<!-- <th style="text-align: center;">Subject</th> -->
									<th class="text-nowrap">DAK Status</th>
									<th class="text-nowrap">Status</th>
									<th style="width: 170px;">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								 int count=1;
								if(DakPendingPnCDOList!=null && DakPendingPnCDOList.size()>0){
									for(Object[] obj:DakPendingPnCDOList){
										
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
										   
										   
										   ////////////////////////////////////
										   //obj[27] - CountOfAllMarkers
										   //obj[28] - CountOfActionMarkers
										   //obj[29] - CountOfMarkersAck
										   //obj[30] - CountOfMarkersReply
										  
										   String Action=null;
											  
										   if(obj[9]!=null && "ACTION".equalsIgnoreCase(obj[9].toString())){
											   Action="A";
										   }else if(obj[9]!=null && "RECORDS".equalsIgnoreCase(obj[9].toString())){
											   Action="R";
										   }
										   String replieddate=null;
										   if(obj[38]!=null && !"NA".equalsIgnoreCase(obj[38].toString())){
											   String[] markerDate=obj[38].toString().split(" ");
											   replieddate=markerDate[0];
										   }
										   
										   String StatusCountAck = null;
											String StatusCountReply = null;
											 
											if(obj[5]!=null  && obj[30]!=null && Long.parseLong(obj[30].toString())==0
												&& obj[29]!=null && Long.parseLong(obj[29].toString())>0
												&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
												&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
												&& !obj[5].toString().equalsIgnoreCase("FP")  ){	
												StatusCountAck = "Acknowledged<br>["+obj[29]+"/"+obj[27]+"]";
											   }
											
											 if(obj[5]!=null  && obj[29]!=null && Long.parseLong(obj[29].toString())>0
												&& obj[28]!=null && Long.parseLong(obj[28].toString()) > 0
											    && obj[30]!=null && Long.parseLong(obj[30].toString()) > 0
												&& !obj[5].toString().equalsIgnoreCase("DC") && !obj[5].toString().equalsIgnoreCase("AP")
												&& !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("RM")
												&& !obj[5].toString().equalsIgnoreCase("FP")			   ){	
												 StatusCountReply  = "Replied<br>["+obj[30]+"/"+obj[28]+"]";
													   }
								          /////////////////////////////////////////
										   
										   %>
										   
										   <tr <%if(obj[41]!=null && Long.parseLong(obj[41].toString())==3){ %> class="HighlightHighPrior"<%}%>>
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
                                      <td style="text-align: center;width:10px;"><%if(obj[40]!=null){ %><%=obj[40].toString() %><%}else{ %>-<%} %></td>
                                       <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
                                      <td style="text-align: center;width:10px;"><%if(obj[31]!=null){ %><%=obj[31].toString() %><%}else{ %>-<%} %></td>
                                     <td style="text-align: center;width:10px;"><%=Action %></td>
                                     <%-- <td style="text-align: center;width:10px;"><%if(obj[18]!=null){ %><%=obj[18].toString() %><%}else{ %>-<%} %></td> --%>
                                     <%-- <td class="wrap" style="text-align: center;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td> --%>
									<%-- <td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td> --%>
								<td style="text-align: center;width:80px;"><%if(obj[10]!=null){ %><%=sdf.format(obj[10]) %><%}else{ %><%="NA" %><%} %></td>
									<td  class="wrap" style="text-align: left;width:100px;"><%if(obj[32]!=null){%><%=obj[32]%><%}else{ %>-<%} %></td> 
									<td style="text-align: center;width:80px;"><%if(obj[38]!=null && !"NA".equalsIgnoreCase(obj[38].toString())){ %><%=sdf.format(rdf.parse(replieddate)) %><%}else{ %><%="NA" %><%} %></td>
									 <td style="text-align: center;width:10px;"><%if(obj[39]!=null){ %><%=obj[39].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:80px;text-align: center;font-weight:bold;">
									
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
									<td  class="<%=cssStatClass%>" style="text-align: left;width:40px;text-align: center;font-weight:bold;"><%if(obj[13]!=null) {%><%=obj[13].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;font-weight:bold;width:15%;">

<!-----------------------------Preview Action code Start ---------------------------------------------------------------------------------------------------------->									 
									 <%
										/*Marker Reply  */
									 /* String ReplyCounts = null;
									  if(obj[17]!=null && Integer.parseInt(obj[17].toString())>0) {
										  ReplyCounts = "1#0#1";
									  }else{
										  ReplyCounts = "NA";
									  }
								  	     String CWReplyCounts = null; 
								  	 if(obj[20]!=null){
								  		CWReplyCounts = obj[20].toString();
								  	}else{
								  		CWReplyCounts = "NA";
								  	     } */
									  %>
									 <button type="button" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]  %> value="<%=obj[0] %>" 
									  onclick="Preview(<%=obj[0]%>,<%=obj[0] %>)"
									  data-toggle="tooltip" data-placement="top" title="" data-original-title="Preview"> 
															<img alt="mark" src="view/images/preview3.png">
 										  </button>
 <!---------------------------------Preview Action code End --------------------------------------------------------------------------------------------------------->										
 									
 		              
<!-----------------------consolidatedReply Add Action Check Start --------------------------------------------------------------------------------------------------->
           <!--obj[19]-- signifies ActionId so ActionId 1 i.Records is not allowed for consolidatedReplyAdd-->								
           <!--obj[25]--P&C DO has Closing Authority(P) consolidatedReplyAdd concept comes otherwise no flow of P&C DO bcz When closing authority others(O) is selected that Dak will not come in P&C DO list--> 
                     
                     <%if(obj[19]!=null && Long.parseLong(obj[19].toString())!= 1  && obj[25]!=null && obj[25].toString().equalsIgnoreCase("P") ){%>
 								
 		                        <%if(obj[5].toString().equalsIgnoreCase("DD")||obj[5].toString().equalsIgnoreCase("DA")||obj[5].toString().equalsIgnoreCase("DR") 
 				                   || 
 		                        ((!obj[5].toString().equalsIgnoreCase("RP"))&&(!obj[5].toString().equalsIgnoreCase("FP"))&&(!obj[5].toString().equalsIgnoreCase("AP"))&&(!obj[5].toString().equalsIgnoreCase("DC")) )  ){ %>
 		
 		
 					                 <input type="hidden" name="redirValForConsoReplyAdd"	value="DakPendingPNCDORedir" />
 					                 
 									 <button type="submit" class="btn btn-sm icon-btn" name="DakIdFromCR"  
 									formaction="ConsolidatedReply.htm"  id=<%="DakIdCR"+obj[0]  %> value="<%=obj[0] %>" 
 									 data-toggle="tooltip" data-placement="top" title="" data-original-title="Consolidated Reply" > 
									<img alt="mark" src="view/images/consolidated.png"> 
 										  </button>	 
 									  <input type="hidden" name="DakNo_<%=obj[0]%>"	value="<%=obj[8]%>" />
 						       <%}%>
 						<%} %>		
 						</td>
 						</tr>
 						<%count++;}} %> 
							</tbody>
						</table>

						
						</form>

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
<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	
</script>
</html>