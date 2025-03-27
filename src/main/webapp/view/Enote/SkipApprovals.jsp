<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Skip Approvals</title>
</head>
<body>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">e Note Skip Approval List</h5>
			</div>
			<div class="col-md-9">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteDashBoard.htm"><i class="fa fa-envelope"></i> e Note </a></li>
						<li class="breadcrumb-item active">e Note Skip Approval List </li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	
	<%
	 SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	String frmDt=(String)request.getAttribute("frmDt");
	String toDt=(String)request.getAttribute("toDt");
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	
	List<Object[]> AllSkipApprovalList=(List<Object[]>)request.getAttribute("AllSkipApprovalList");
	
	List<String> forwardstatus = Arrays.asList("INI","REV","RR1","RR2","RR3","RR4","RR5","RAP");
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
		<div class="card-header" style="height: 3rem">
 <form action="SkipApprovals.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
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
<div class="card-body">
	  <div class="table-responsive" style="overflow:hidden;">
   <form action="#" method="post" id="eNoteListForm">
   <input type="hidden" name="SkipPreview" value="SkipPreview">
   <input type="hidden" name="ViewFrom" value="SkipApprovalList">
   <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
							<tr>
								<th class="text-nowrap">SN</th>
								<th class="text-nowrap">eNote Id</th>
								<th class="text-nowrap">Dak Id</th>
								<th class="text-nowrap">Note No</th>
								<th class="text-nowrap">Ref No & Date</th>
							    <th class="text-nowrap">Subject</th>
							    <th class="text-nowrap">Reply</th>
							    <th class="text-nowrap">Status</th>
							    <th class="text-nowrap">Action</th>
						</tr>
							</thead>
							<tbody>	
							<%
							    int count=1;
								if(AllSkipApprovalList!=null && AllSkipApprovalList.size()>0){
									for(Object[] obj:AllSkipApprovalList){
										%>
								 <tr>
								  <td style="text-align: center;width:10px;"><%=count %></td>
								   <td class="wrap" style="text-align: left;width:80px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: left;width:80px;"><%if(obj[11]!=null){ %><%=obj[11].toString() %><%}else{ %>-<%} %></td>
								   <td style="text-align: left;width:10px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: left;width:50px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %><br><%if(obj[4]!=null){%><%=sdf.format(obj[4])%><%}else{ %><%="NA"%><%} %></td>
								   <td style="text-align: left;width:200px;"><%if(obj[5]!=null){ %><%=obj[5].toString() %><%}else{ %>-<%} %></td>
								   <td style="text-align: left;width:200px;"><%if(obj[12]!=null){ %><%=obj[12].toString() %><%}else{ %>-<%} %></td>
								   <td style="text-align: center;width:80px;">
								   <button type="submit" class="btn btn-sm btn-link w-100 btn-status" formaction="EnoteStatusTrack.htm" value="<%=obj[0]%>" name="EnoteTrackId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[7]%>; font-weight: 600;" formtarget="_blank">
								    		&nbsp; <%=obj[6].toString() %> <i class="fa-solid fa-arrow-up-right-from-square" style="float: right;" ></i>
									</button>
								   </td>
								   <td style="text-align: center;width:120px;">
								   <button type="submit" class="btn btn-sm icon-btn" id=<%="SelEnoteId"+obj[0]%> value="<%=obj[0] %>" <%if(obj[13].toString().equalsIgnoreCase("N")) {%> formaction="EnotePreview.htm" name="eNoteId" <%}else{ %> formaction="DakEnoteReplyPreview.htm" name="eNoteId" <%} %> formmethod="post"
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
 								   <%if(obj[8]!=null && obj[8].toString().equalsIgnoreCase("FWD")){ %>
 								   <button type="submit" class="btn btn-sm" name="EnoteRevokeId" id=<%="EnoteRevokeId"+obj[0]%> value="<%=obj[0]%>" formaction="EnoteRevoke.htm" onclick="return confirm('Are you sure to revoke?');" formmethod="post" data-toggle="tooltip" data-placement="top" title="Revoke Submission">
									<i class="fa-solid fa-backward" style="color: red;"></i>
							       </button>
							       <%} %>
							       <input type="hidden" id=<%="IsDak"+obj[13].toString() %> name="IsDak" value="<%=obj[13].toString()%>">
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