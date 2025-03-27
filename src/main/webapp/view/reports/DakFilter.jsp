<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,java.text.SimpleDateFormat,com.vts.dms.dak.model.DakAttachment"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<title>DAK Filter</title>
<style>
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
				<h5 style="font-weight: 700 !important">DAK Filter</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="ReportsDashBoard.htm"><i class="fa fa-file" ></i> Reports</a></li>
				    <li class="breadcrumb-item active">DAK Filter </li>
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
    String FromDate=(String)request.getAttribute("FromDate");
    String ToDate=(String)request.getAttribute("ToDate");
    String FilterType = (String)request.getAttribute("FilterTypeController");  
    
    if(FilterType==null)
    {
    	FilterType="source";
    }
    
    String SelectedDetailsId=(String)request.getAttribute("SelectedDetailsIdController");
    
	List<Object[]> DakFilteredList = (List<Object[]>) request.getAttribute("DakFilteredList"); 
%>

          <input type="hidden" id="FilterTypeJs" value="<%=FilterType%>">
           <input type="hidden" id="SelectedDetailsIdJs" value="<%=SelectedDetailsId%>">
         
<div class="card loadingCard" style="width: 100%; display: none;">
		<div class="card-header" style="height: 3rem">
  <form action="DakFilter.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float: right; margin-top: -7px;" >
        <div class="col-12" style="width: 100%;" >
    <div class="row">
            <div class="col-md-3 form-inline">
                         <span style="font-weight: bold;">Filter Type&emsp;</span>
                         <select id="FilterType" name="FilterType" class="form-control" required style="width:65%; background-color: #e9ecef;">
							    <option value="Source">Source</option>
							    <option value="Project">Project</option>
							    <option value="NonProject">Non-Project</option>
							    <option value="OtherProject">Project (Others)</option>
					     </select>
                   </div>
                   
                   <div class="col-md-5 form-inline">
                        <span style="font-weight: bold;">Select&emsp;</span>
                        <select id="SelectedDetails" name="SelectedDetails" class="form-control select2" required="required" data-live-search="true" style="width: 23rem; background-color: #e9ecef;">
                                <option value=""></option>
                        </select>
                   </div>
                   
                   <div class="col-md-2 form-inline" style="padding: 0px;">
                        <span style="font-weight: bold;">From&emsp;</span>
                        <input type="text" class="form-control" id="FromDate" name="FromDate"  <%if(FromDate!=null){ %> value="<%=FromDate%>" <%} %> style="width:55%;" readonly="readonly">
                  </div>
                  
                  <div class="col-md-2 form-inline">
                        <span style="font-weight: bold;">To&emsp;</span>
                        <input type="text" class="form-control" id="ToDate" name="ToDate"  <%if(ToDate!=null){ %> value="<%=ToDate%>" <%} %> style="width:65%;" readonly="readonly"> 
                  </div>
             </div>
             </div>
             </div>
         </form>
  </div>
  <div class="card-body" style="padding:1rem!important;" >
  <div class="table-responsive">
  <form action="#" method="post">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
  <input type="hidden" name="viewfrom" value="DakFilter">
 	  		  <table class="table table-bordered table-hover table-striped table-condensed"   id="myTable1">
							<thead>
								<tr>
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">DAK Id</th>
									<th class="text-nowrap">Head</th>
									<th class="text-nowrap">Source</th>
									<th class="text-nowrap">Ref No & Date </th>
									<th class="text-nowrap">Action Due</th>
								    <th class="text-nowrap">Subject</th> 
									<th class="text-nowrap">Status</th>
								    <th style="width: 80px;">Action</th> 
								</tr>
							</thead>
							<tbody>
							<%
								 int count=1;
								if(DakFilteredList!=null && DakFilteredList.size()>0){
									for(Object[] obj:DakFilteredList){ 
									%>
									<tr id=buttonbackground<%=obj[0]%>	>
									<td style="width:10px;"><%=count %></td>
									 <td class="wrap" style="text-align: left;width:120px;">
                                    <% if (obj[8] != null) { %>
                                    <%= obj[8].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </td>
                                    <!-- obj[15] -->
                                    <td class="wrap" style="text-align: center;"><%if(obj[16]!=null){ %><%=obj[16].toString() %><%}else{ %>-<%} %></td>
                                    <td class="wrap" style="text-align: center;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center;"><%if(obj[12]!=null){ %><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td  class="wrap" style="text-align: left;width:180px;"><%if(obj[9]!=null){%><%=obj[9]%><%}else{ %>-<%} %></td> 
									<td  class="wrap" style="text-align: left;width:80px;text-align: center;font-weight:bold;"><%if(obj[7]!=null) {%><%=obj[7].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;font-weight:bold">
									<button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]%> value="<%=obj[0]%>" 
									  formaction="DakReceivedView.htm" formtarget="_blank" > 
											<img alt="mark" src="view/images/preview3.png">
 										  </button>
									</td>
									</tr>
									<%count++;} }%>
									</tbody>
						    </table>
						    </form>
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
$(document).ready(function(){
$("#SelectedDetails,#FromDate,#ToDate,#FilterType").change(function(){
	document.getElementById('myform').submit();
});
});
</script>


<script type="text/javascript">
$("#myTable1").DataTable({
"lengthMenu": [5,10, 25, 50, 75, 100],
"pagingType": "simple",
 ordering: true

});	
</script>

<script type="text/javascript">

$('#FromDate').daterangepicker({
	autoclose: true,
    "singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	showDropdowns : true,
    locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#ToDate').daterangepicker({
	autoclose: true,
    "singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	showDropdowns : true,
    locale : {
		format : 'DD-MM-YYYY'
	}
});

</script>

<script type="text/javascript">
$(document).ready(function(){
	
	var SelectedDetailsId=$("#SelectedDetailsIdJs").val();
	var FilterType=$("#FilterTypeJs").val();

	
		$.get('GetSelectedDetailsFilter.htm', {
			FilterType : FilterType
		}, function(responseJson) {
			var select = $('#SelectedDetails');
			select.find('option').remove();
			$("#SelectedDetails").append("<option value='-1'>All</option>");
			var result = JSON.parse(responseJson);
			$.each(result, function(key, value) {
				$("#SelectedDetails").append("<option value="+value[0]+">"+ value[1]+ "</option>");
			});
			
			$("select[name='FilterType'] option[value='"+FilterType+"']").attr('selected','selected');
			$("select[name='SelectedDetails'] option[value='"+SelectedDetailsId+"']").attr('selected','selected');
		});
	
});

</script>

<script type="text/javascript">
$('#FilterType').change(
					function(event) {
						var FilterType= $("select#FilterType").val();
						
						if(FilterType!=null){
							
						$.get('GetSelectedDetailsFilter.htm', {
							FilterType : FilterType
						}, function(responseJson) {
							var select = $('#SelectedDetails');
							select.find('option').remove();
							$("#SelectedDetails").append("<option value='-1'>All</option>");
							var result = JSON.parse(responseJson);
							$.each(result, function(key, value) {
								$("#SelectedDetails").append("<option value="+value[0]+">"+ value[1]+ "</option>");
							});
							var SelectedDetailsId=$("#SelectedDetailsIdJs").val();
							var FilterType=$("#FilterTypeJs").val();
							$("select[name='FilterType'] option[value='"+FilterType+"']").attr('selected','selected');
							$("select[name='SelectedDetails'] option[value='"+SelectedDetailsId+"']").attr('selected','selected');
						});
						}
					});

</script>

</html>