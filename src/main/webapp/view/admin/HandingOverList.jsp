<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Handing Over List</title>
<style type="text/css">
.modal-dialog-jump {
  animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
</head>
<body>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">Handing Over List</h5>
			</div>
			<div class="col-md-9">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="AdminDashBoard.htm"><i class="fa fa-user"></i> Admin </a></li>
						<li class="breadcrumb-item active">Handing Over List </li>
					</ol>
				</nav>
			</div>
		</div>
	</div>

			<%
			SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String frmDt=(String)request.getAttribute("frmDt");
			String toDt=(String)request.getAttribute("toDt");
			long EmpId=(Long)session.getAttribute("EmpId");
			List<Object[]> HandingOverList = (List<Object[]>) request.getAttribute("HandingOverList");
			List<Object[]> GetHandingOverOfficers = (List<Object[]>) request.getAttribute("GetHandingOverOfficers");
			%>
			<%
			String ses = (String) request.getParameter("result");
			String ses1 = (String) request.getParameter("resultfail");
			String status = (String) request.getParameter("msg");
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
 <form action="HandingOverList.htm" method="POST" id="myform"> 
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
   <form action="#" method="post" id="HandingOverListForm">
   <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
							<tr>
								<th class="text-nowrap">Select</th>
								<th class="text-nowrap">From-Employee</th>
								<th class="text-nowrap">To-Employee</th>
								<th class="text-nowrap">Created Date</th>
								<th class="text-nowrap">From Date</th>
							    <th class="text-nowrap">To Date</th>
						</tr>
							</thead>
							<tbody>	
							<%
								if(HandingOverList!=null && HandingOverList.size()>0){
									for(Object[] obj:HandingOverList){
										String formattedDate = "-";
										if (obj[5] != null) {
									        try {
									            String dateString = obj[5].toString();
									            Date date;
									            if (dateString.contains(":")) {
									                date = inputFormat.parse(dateString);
									            } else {
									                date = dateFormat.parse(dateString);
									            }
									            formattedDate = sdf.format(date);
									        } catch (Exception e) {
									            e.printStackTrace();
									        }
									    }
										%>
								 <tr>
								   <td style="width:10px;"><input type="radio" name="HandingOverId" id="HandingOverId" value=<%=obj[0]%>></td>
								   <td class="wrap" style="text-align: left;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: left;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %></td>
								   <td style="text-align: center;"><%if(obj[5]!=null){ %><%=formattedDate%><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: center;"><%if(obj[3]!=null){ %><%=sdf.format(obj[3]) %><%}else{ %>-<%} %></td>
								   <td style="text-align: center;"><%if(obj[4]!=null){ %><%=sdf.format(obj[4]) %><%}else{ %>-<%} %></td>
								</tr>
								<%}} %>	
							</tbody>
					</table>		
   
		   <div align="center">
		    <button type="button" class="btn btn-primary btn-sm add" id="add" name="Action" value="add" onclick="openHandingOverAdd()"> Add </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <%if(HandingOverList!=null && HandingOverList.size()>0){ %>
		    <button type="button" class="btn btn-warning btn-sm edit" id="edit" name="Action" value="Edit" onclick="Edit(HandingOverListForm)" > Edit </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <button type="button" class="btn btn-danger btn-sm delete" id="Revoke" name="Action" value="Revoke"  onclick="revoke()"> Revoke </button>
		    <%} %>
		   </div><br>
		</form>
     </div>
      <!------------------------------------------------------- Document Upload Modal Start ------------------------------------------------------------------------->
     
		   <div class="modal fade my-modal" id="HandingOverAddModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-jump" role="document">
		  <div class="modal-content" style="height: 450px;  border:black 1px solid;  width: 100%;">
		<form action="HandingOverAddSubmit.htm" method="post" id="myform">
		  <div class="modal-header" style="background-color: #005C97;">
		<h5 class="modal-title" style="color:white;" ><span id="HandingOverHeading"><b></b></span></h5>
		<button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		</div><br>
		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
		<div class="col-md-12 row">
		  	<div class="col-md-6" style="display: inline-block;">
				<label style="font-size: 15px;"><b>From Date</b></label>
				<input type="text" class="form-control input-sm mydate" id="Handingfromdate" name="HandingFromDate" required="required"> 
			</div>
			<div class="col-md-6" style="display: inline-block;">
				<label style="font-size: 15px;"><b>To Date</b></label>
				<input type="text" class="form-control input-sm mydate" id="Handingtodate" name="HandingToDate" required="required">
			</div>
		</div><br>
		<div class="col-md-12 row">
		  	<div class="col-md-6" style="display: inline-block;">
				<label style="font-size: 15px;"><b>Handing Over Officer</b></label>
					<select class="form-control selectpicker HandingOverOfficer "  id="HandingOverOfficer" data-live-search="true" onchange="HandingOverOfficerDropdownChange()" name="HandingOverOfficer">
					   <%-- <%if (GetHandingOverOfficers != null && GetHandingOverOfficers.size() > 0) {
					    for (Object[] obj : GetHandingOverOfficers) {%>
					    <option value=<%=obj[0].toString()%>><%=obj[1].toString()+", "+obj[2].toString()%></option>
					   <%}}%> --%>
					</select>
			</div>
			<div class="col-md-6" style="display: inline-block;">
				<label style="font-size: 15px;"><b>Handing Over To</b></label>
					<select class="form-control selectpicker HandingOverTo "  id="HandingOverTo" data-live-search="true" name="HandingOverTo">
				    </select>
			</div>
		</div><br>
		<div align="center">
		<div class="form-group">
		  		<input type="submit" class="btn btn-primary btn-sm submit" value="Submit" name="sub" onclick="return confirm('Are you sure you want to submit?')" >
		</div>
		</div>
		<input type="hidden" name="ActionValue" id="ActionValue">
		<input type="hidden" name="HandingOverEditId" id="HandingOverEditId">
	</form>
</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
     
     <!--------------------------------------------------------------- Document Upload Modal End ----------------------------------------------------------------------->
</div>
</div>
</body>
<script>
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

function openHandingOverAdd() {
	$('#HandingOverAddModal').modal('show');
	$('#HandingOverHeading').html('Handing Over Add');
	<% for (Object[] type : GetHandingOverOfficers) { %>
    var optionValue = '<%= type[0] %>';
    var optionText = '<%= type[1] + ", " + type[2] %>';
    var option = $("<option></option>").attr("value", optionValue).text(optionText);
    $('#HandingOverOfficer').append(option);
<% } %>
// Refresh the selectpicker after appending options
$('#HandingOverOfficer').selectpicker('refresh');

	var handingOfficer=$('#HandingOverOfficer').val();
	$.ajax({
		type: "GET",
	    url: "GetHandingOverOfficers.htm",
	    data: {
	    	handingOfficer:handingOfficer
	    },
	    dataType: 'json',
	    success: function(result) {
	        if (result != null) {
	        	var consultVals = Object.values(result);
	        	 $('#HandingOverTo').empty();
	             for (var c = 0; c < consultVals.length; c++) {
	            	var optionValue = consultVals[c][0];
	     	        var optionText = consultVals[c][1].trim() + ', ' + consultVals[c][2];
	     	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
	     	       $('#HandingOverTo').append(option);
	           }
	             $
	             $('#HandingOverTo').selectpicker('refresh');
	        }
	    }
	});
	
}

$('#Handingfromdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	 "minDate" :new Date(),  
	 "startDate" : new Date(), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#Handingtodate').daterangepicker({
    "singleDatePicker": true,
    "linkedCalendars": false,
    "showCustomRangeLabel": true,
    "minDate": new Date(),
    "startDate": new Date(),
    "cancelClass": "btn-default",
    "showDropdowns": true,
    "locale": {
        "format": 'DD-MM-YYYY'
    }
});

$('#Handingfromdate').on('apply.daterangepicker', function(ev, picker) {
    var fromDate = picker.startDate;
    $('#Handingtodate').daterangepicker({
        "singleDatePicker": true,
        "linkedCalendars": false,
        "showCustomRangeLabel": true,
        "minDate": fromDate,  // Set minDate to the selected from date
        "startDate": fromDate, // Set startDate to ensure toDate cannot be earlier than fromDate
        "cancelClass": "btn-default",
        "showDropdowns": true,
        "locale": {
            "format": 'DD-MM-YYYY'
        }
    });
});

function Edit(HandingOverListForm){

	var fields = $("input[name='HandingOverId']:checked");
	
	if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}else{
		 var selectedId = fields.val();
		$('#HandingOverEditId').val(selectedId);
	    $.ajax({
	    	type: "GET",
	    	url: "getEditHandingOfficerData.htm",
	    	data:{
	    		selectedId:selectedId
	    	},
	    	dataType: 'json',
	    	success: function(result) {
	    		console.log("hiiiii");
	            if (result != null) {
	            	if (result.FromDate!=null) {
	                    var formattedFromDate = formatDate(result.FromDate);
	                    $('#Handingfromdate').val(formattedFromDate);
	                }
	                if (result.ToDate!=null) {
	                    var formattedToDate = formatDate(result.ToDate);
	                    $('#Handingtodate').val(formattedToDate);
	                }
	                $('#HandingOverAddModal').modal('show');
	                $('#HandingOverHeading').html('Handing Over Edit');
	                <% for (Object[] type : GetHandingOverOfficers) { %>
	                var optionValue = '<%= type[0] %>';
	                var optionText = '<%= type[1] + ", " + type[2] %>';
	                var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                $('#HandingOverOfficer').append(option);
	                if(result.FromEmpId==optionValue){
	                    $('#HandingOverOfficer option[value="' + optionValue + '"]').prop('selected', true);
	                	}
	            <% } %>
	            // Refresh the selectpicker after appending options
	            $('#HandingOverOfficer').selectpicker('refresh');
	            
	            var handingOfficer=$('#HandingOverOfficer').val();
	        	$.ajax({
	        		type: "GET",
	        	    url: "GetHandingOverOfficers.htm",
	        	    data: {
	        	    	handingOfficer:handingOfficer
	        	    },
	        	    dataType: 'json',
	        	    success: function(resultdata) {
	        	        if (resultdata != null) {
	        	        	var consultVals = Object.values(resultdata);
	        	        	 $('#HandingOverTo').empty();
	        	             for (var c = 0; c < consultVals.length; c++) {
	        	            	var optionValue = consultVals[c][0];
	        	     	        var optionText = consultVals[c][1].trim() + ', ' + consultVals[c][2];
	        	     	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
	        	     	       $('#HandingOverTo').append(option);
	        	     	      if(result.ToEmpId==optionValue){
	      	                    $('#HandingOverTo option[value="' + optionValue + '"]').prop('selected', true);
	      	                	} 
	        	           }
	        	             $
	        	             $('#HandingOverTo').selectpicker('refresh');
	        	        }
	        	    }
	        	});
	        	$('#ActionValue').val('Edit');
	            }
	        }
		});
	}
		  
}	

function HandingOverOfficerDropdownChange(){
	openHandingOverAdd();
}

function formatDate(dateStr) {
    // Parse the date using moment
    var date = moment(dateStr, 'MMM DD, YYYY');
    
    // Format the date as DD-MM-YYYY
    return date.format('DD-MM-YYYY');
}

function revoke(){
	var fields = $("input[name='HandingOverId']:checked");
var a= fields.val();
console.log(a + "---"+typeof a)
	if (fields.length === 0){
		alert("Please Select A Record");
		 event.preventDefault();
		return false;
		}else{
		
			if(confirm('Are you sure to revoke?')){
				console.log("Hiiii inside if")
			$.ajax({
				type:"GET",
				url:"HandingOverRevoke.htm",
				data:{
					selectedId:a
				},
				datatype:'json',
			
				success: function(resultdata) {
					console.log(resultdata + "---"+typeof resultdata)
					
					if(Number(a)>0){
					alert("Revoked successfully !")
					}
					window.location.reload()
				}
			})
			}else{
				event.preventDefault();
				return false;
			}
			
		}
}


</script>
</html>