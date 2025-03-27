<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>e Note Approval List</title>
<style type="text/css">
#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
}

.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}
</style>
</head>
<body>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">e Note Approval List </h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteDashBoard.htm"><i class="fa fa-envelope"></i> e Note </a></li>
						<li class="breadcrumb-item active">e Note ( Recommendation / Approval ) List </li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	<%
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	    SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		String redirectedvalue=(String)request.getAttribute("redirectedvalueForward");
		
		List<Object[]>  EnoteApprovalPendingList=(List<Object[]>)request.getAttribute("EnoteApprovalPendingList");
		List<Object[]> EnoteApprovedList=(List<Object[]>)request.getAttribute("eNoteApprovalList");
	
	%>
	<%
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
		<%}%>
	<div class="card" style="width: 99%">
	
<div class="card-body">
					<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  <li class="nav-item" style="width: 50%;"  >
		    <div class="nav-link active" style="text-align: center;" id="eNotePendingtab" data-toggle="pill" data-target="#pills-OPD" role="tab" aria-controls="pills-OPD" aria-selected="true">
			   <span>e Note Pending List 
				   <span class="badge badge-danger badge-counter count-badge">
				   		<%if( EnoteApprovalPendingList!=null && EnoteApprovalPendingList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=EnoteApprovalPendingList.size()%>
						<%} %>				   			
				  </span>  
				</span> 
		    </div>
		  </li>
		  <li class="nav-item"  style="width: 50%;">
		    <div class="nav-link" style="text-align: center;" id="eNoteApprovedtab" data-toggle="pill" data-target="#pills-IPD" role="tab" aria-controls="pills-IPD" aria-selected="false">
		    	 <span>e Note Approved List     
				   <span class="badge badge-danger badge-counter count-badge">
				   		<%if(EnoteApprovedList!=null && EnoteApprovedList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=EnoteApprovedList.size()%>
						<%} %>				   			
				   </span>  
				</span> 
		    
		    
		    </div>
		  </li>
		</ul>
			

	<div class="tab-content" id="pills-tabContent">
			<div class=" tab-pane  show active" id="pills-OPD" role="tabpanel" aria-labelledby="eNotePendingtab" >
					<div class="table-responsive">
					  <form action="#" method="post" id="eNoteListForm">
					  <input type="hidden" name="Approval" value="Y">
					  <input type="hidden" name="ViewFrom" value="EnoteApprovalList">
					  <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">eNote Id</th>
									<th style="text-align: center;">Dak Id</th>
									<th style="text-align: center;">Note No</th>
									<th style="text-align: center;">Ref No & Date</th>
									<th style="text-align: center;">Subject</th>
									<th style="text-align: center;">Reply</th>
									<th style="text-align: center;">Status</th>	
									<th style="text-align: center;">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
							int count=1;
							if(EnoteApprovalPendingList!=null && EnoteApprovalPendingList.size()>0){
							for(Object[] obj:EnoteApprovalPendingList){ 
							%>
								<tr >
									<td style="text-align: center;width:10px;"><%=count %></td>
									<td style="text-align: left;width:10px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: left;width:10px;"><%if(obj[12]!=null){ %><%=obj[12].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:70px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:100px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %><br><%if(obj[4]!=null){%><%=sdf.format(obj[4])%><%}else{ %><%="NA"%><%} %></td>
									<td class="wrap"  style="text-align: left;width:200px;"><%if(obj[5]!=null){ %><%=obj[5].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:200px;"><%if(obj[13]!=null){ %><%=obj[13].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:80px;">
									<button type="submit" class="btn btn-sm btn-link w-100 btn-status" formaction="EnoteStatusTrack.htm" value="<%=obj[0]%>" name="EnoteTrackId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[9]%>; font-weight: 600;" formtarget="_blank">
								    		&nbsp; <%=obj[8].toString() %> <i class="fa-solid fa-arrow-up-right-from-square" style="float: right;" ></i>
									</button>
									</td>
									<td class="wrap"  style="text-align: center;width:120px;">
									 <button type="submit" class="btn btn-sm icon-btn"  id=<%="SelEnoteId"+obj[0]%> value="<%=obj[0] %>"  <%if(obj[14].toString().equalsIgnoreCase("N")) {%> formaction="EnotePreview.htm" name="eNoteId" <%}else{ %> formaction="DakEnoteReplyPreview.htm" name="eNoteId" <%} %> formmethod="post"
									  data-toggle="tooltip" data-placement="top" title="Preview"> 
										<img alt="mark" src="view/images/preview3.png">
 								     </button>
 								      <button type="submit" class="btn btn-sm icon-btn" name="EnotePrintId"  id=<%="EnoteSel"+obj[0]%> value="<%=obj[0] %>"  formaction="EnoteViewPrint.htm" formmethod="post" formtarget="_blank"
									  data-toggle="tooltip" data-placement="top" title="EnoteView"> 
										<img alt="mark" src="view/images/ViewPrint.png">
 								      </button>
 								      <button type="submit" class="btn btn-sm icon-btn" name="EnotePrintId"  id=<%="EnoteSel"+obj[0]%> value="<%=obj[0] %>"  formaction="EnotePrint.htm" formmethod="post" formtarget="_blank"
									  data-toggle="tooltip" data-placement="top" title="Print"> 
											<i class="fa fa-download" style="color: green;" aria-hidden="true"></i>
 								      </button>
 								      <input type="hidden" name="IsDak" id=<%="IsDak"+obj[14].toString() %> value="<%=obj[14].toString()%>">
									</td>
								</tr>
								<%count++;}} %>
							</tbody>
						</table>
</form>
					</div>
					</div>
				
						<!----------------------------------------------------   eNote Approved List    ----------------------------------------------------------->

	<div class="card tab-pane " id="pills-IPD" role="tabpanel" aria-labelledby="eNoteApprovedtab" >	
       <div class="card-body"> 
       <div class="card-header" style="height: 3rem">
 <form action="EnoteApprovalList.htm" method="post" id="myform"> 

      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
              <label for="fromdate" style="text-align:  center;font-size: 16px;width:40px; ">From	</label>&nbsp;&nbsp;
              <input type="text" style="width:113px; margin-top: -10px; " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label for="todate" style="text-align: center;font-size: 16px;width:20px; ">To</label>&nbsp;&nbsp;
              <input type="text" style="width:113px;  margin-top: -10px;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
              <input type="hidden" id="redirectedvalue" name="redirectedvalue" value="<%if(redirectedvalue!=null){%><%=redirectedvalue %><%}%>">
                 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          </div>
        </div>
      </div>
      </form>
</div>
			<div class="table-responsive">
			<form action="#" method="post">
					  <input type="hidden" name="Approval" value="N">
					  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					  <input type="hidden" name="ViewFrom" value="EnoteApprovalList">
						<table class="table table-bordered table-hover table-striped table-condensed " id="myTablesecond">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">eNote Id</th>
									<th style="text-align: center;">Dak Id</th>
									<th style="text-align: center;">Note No</th>
									<th style="text-align: center;">Ref No & Date</th>
									<th style="text-align: center;">Subject</th>
									<th style="text-align: center;">Reply</th>
									<th style="text-align: center;">Status</th>	
									<th style="text-align: center;">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
							int count1=1;
							if(EnoteApprovedList!=null && EnoteApprovedList.size()>0){
							for(Object[] obj:EnoteApprovedList){ 
							%>
								<tr>
									<td style="text-align: center;width:10px;"><%=count1 %></td>
									<td style="text-align: left;width:10px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: left;width:10px;"><%if(obj[14]!=null){ %><%=obj[14].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:70px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:150px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %><br><%if(obj[4]!=null){%><%=sdf.format(obj[4])%><%}else{ %><%="NA"%><%} %></td>
									<td class="wrap"  style="text-align: left;width:270px;"><%if(obj[5]!=null){ %><%=obj[5].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:270px;"><%if(obj[15]!=null){ %><%=obj[15].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:80px;">
                                     <button type="submit" class="btn btn-sm btn-link w-100 btn-status" formaction="EnoteStatusTrack.htm" value="<%=obj[0]%>" name="EnoteTrackId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[10]%>; font-weight: 600;" formtarget="_blank">
								    		&nbsp; <%=obj[9].toString() %> <i class="fa-solid fa-arrow-up-right-from-square" style="float: right;" ></i>
									</button>
									</td>
									<td class="wrap"  style="text-align: center;width:120px;">
									 <button type="submit" class="btn btn-sm icon-btn" id=<%="SelEnoteId"+obj[0]%> value="<%=obj[0] %>"  <%if(obj[16].toString().equalsIgnoreCase("N")) {%> formaction="EnotePreview.htm" name="eNoteId" <%}else{ %> formaction="DakEnoteReplyPreview.htm" name="eNoteId" <%} %> formmethod="post"
									  data-toggle="tooltip" data-placement="top" title="Preview"> 
										<img alt="mark" src="view/images/preview3.png">
 									 </button>
 									  <button type="submit" class="btn btn-sm icon-btn" name="EnotePrintId"  id=<%="EnoteSel"+obj[0]%> value="<%=obj[0] %>"  formaction="EnoteViewPrint.htm" formmethod="post" formtarget="_blank"
									  data-toggle="tooltip" data-placement="top" title="EnoteView"> 
										<img alt="mark" src="view/images/ViewPrint.png">
 								      </button>
 									  <button type="submit" class="btn btn-sm icon-btn" name="EnotePrintId"  id=<%="EnoteSel"+obj[0]%> value="<%=obj[0] %>"  formaction="EnotePrint.htm" formmethod="post" formtarget="_blank"
									  data-toggle="tooltip" data-placement="top" title="Print"> 
											<i class="fa fa-download" style="color: green;" aria-hidden="true"></i>
 								      </button>
 								      <input type="hidden" name="IsDak" id=<%="IsDak"+obj[16].toString() %> value="<%=obj[16].toString()%>">
									</td>
								</tr>
								<%count1++;}} %>
							</tbody>
						</table>
						</form>

					</div>
					</div>
					</div>
					
	</div>
</div>


</div>
</body>
<script>
  // Check if the CountForMsgRedirect string is not null
  var countForMsgMarkerRedirect = '<%= redirectedvalue %>';
  if (countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='eNotePending') {
    // Get the button element by ID
   var button = document.querySelector('[id="eNotePendingtab"]');

    // Scroll to the button element to that view
 /*    button.scrollIntoView(); */
    // Programmatically trigger a click event on the button
    if (button) {
      // Programmatically trigger a click event on the button
      
      button.click();
      
    }
  }else if(countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='eNoteApproved'){
	  var button = document.querySelector('[id="eNoteApprovedtab"]');

	    // Scroll to the button element to that view
	 /*    button.scrollIntoView(); */
	    // Programmatically trigger a click event on the button
	    if (button) {
      // Programmatically trigger a click event on the button
       
      button.click();
     
    }
  }
</script>

<script>
  // Get references to the elements
  // Add click event handlers to the tab links
  $("#eNotePendingtab").click(function() {
	$("#redirectedvalue").val('');
    $("#redirectedvalue").val('eNotePending');
  });

  $("#eNoteApprovedtab").click(function() {
    $("#redirectedvalue").val('');
    $("#redirectedvalue").val('eNoteApproved');
  });
</script>
<script type="text/javascript">
$("#myTablesecond").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	
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