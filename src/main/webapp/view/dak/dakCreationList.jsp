<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Creation List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
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
				<h5 style="font-weight: 700 !important;font-size: 1.01rem!important;">DAK Creation List </h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active" >DAK Creation List</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>
<%
List<Object[]> dakCreationList=(List<Object[]>)request.getAttribute("dakCreationList");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
String frmDt=(String)request.getAttribute("frmDt");
String toDt=(String)request.getAttribute("toDt");
String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
System.out.println("ses:"+ses);
System.out.println("ses1:"+ses1);
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

<div class="card-header" style="height: 3rem">
 <form action="DakCreationList.htm" method="POST" id="myform"> 
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
		<div class="card" style="width: 99%">
			<div class="card-body"> 
				<div class="table-responsive">
					<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
						<thead>
							<tr>
								<th style="text-align: center;">SN</th>
								<th style="text-align: center;">DAK Id</th>
								<th style="text-align: center;">Ref No & Date</th>
								<th style="text-align: center; width: 10%;">Action Due</th>
								<th style="text-align: center;">Subject</th>
								<th style="text-align: center;width:60px;">Status</th>
								<th style="text-align: center; width: 15%;">Action</th>
							</tr>
						</thead>
						  <tbody>
								<%
								    int count=1;
									for (Object[] obj : dakCreationList) {
								%>
							
								    <tr>
									<td style="text-align: center;width:10px;"><%=count%></td>
									<td style="text-align: left;width:80px;"><%=obj[1]%></td>
								    <td class="wrap"  style="text-align: left;width:130px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %><br><%=sdf.format(obj[3])%></td>
								    <td><%if(obj[5]!=null){ %><%=sdf.format(obj[5]) %><%}else{ %><%="NA" %><%} %></td>
									<td class="wrap"  style="text-align: left;width:180px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center;">
									
									<%if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("DI")){ %>
									
									<%="Dak Created" %>
									
									<%}else if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("DI")){ %>
									<%="Dak Distributed" %>
									<%}else{ %>-<%} %>
									</td>
									<td>
									<form action="DakCreateEdit.htm" method="POST" name="myfrm" id="myfrm" >
									<%if(obj[7]!=null && obj[7].toString().equalsIgnoreCase("Y")){ %>
									<button type="submit" class="btn btn-sm icon-btn" data-toggle="tooltip" data-placement="top" title="Edit">
 											<img alt="edit" src="view/images/writing.png">
 										  </button>
									<%}else{ %>
									<button type="button" class="btn btn-sm icon-btn" onclick="return OpenDakDestinationDetails('<%=obj[0] %>')" data-toggle="tooltip" data-placement="top" title="Preview"> 
										<img alt="mark" src="view/images/preview3.png">
 								   </button>
 								   <%} %>
 								    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
			                        <input type="hidden" name="DakCreateId"	value="<%=obj[0] %>" /> 
 								   </form>
									</td>
								</tr>
								<%
								count++;}
								%>
							</tbody>
						</table>
					</div>
					
					
	<div class="modal" id="exampleModalDakDestiation"  tabindex="-1" role="dialog" aria-labelledby="exampleModalDakDestiation" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered  modal-dialog-jump" role="document" style="max-width: 60% !important;">
 	    <div class="modal-content" style="height: 500px; ">
 	      <div class="modal-header" style="background-color: #054691 !important;max-height:55px; ">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color: white;">DAK Destination</span></b></h5> </div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" ><br>
  	      		<div class="table-responsive" id="DakDestinationDetailsTable" style="display: none;">					
				   			<table class="table table-bordered table-hover table-striped table-condensed" id="myTable2">
		                      <thead>
		                        <tr>
		                        
		                          <th class="text-nowrap">SN</th>
		                          <th class="text-nowrap">DAK Id</th>
		                          <th class="text-nowrap">Destination</th>
		                          <th class="text-nowrap">Close Reply</th>
		                          <th class="text-nowrap">Status</th>
		                        </tr>
		                      </thead>
		                      <tbody id="DakDestinationDetailsList">
		                      <tr > 
		                      </tr> 
		                      </tbody>
		                     </table><br>
		                </div>
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
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
	

$("#myTable1").DataTable({	
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	

$("#myTable2").DataTable({
    "lengthMenu": [5, 10, 25, 50, 75, 100],
    "pagingType": "simple",
      "ordering": false
});

function OpenDakDestinationDetails(dakId) {
	$('#exampleModalDakDestiation').modal('show');
	$('#DakDestinationDetailsList').empty();
	$.ajax({
        type: "GET",
        url: "GetDakDestinationDetailsList.htm",
        data: {
        	dakId: dakId
        },
        dataType: 'json',
        success: function(result) {
            if (result != null && result.length > 0) {
            	$('#DakDestinationDetailsTable').show();
            	var tbody = $('#DakDestinationDetailsList'); 
            	var count=1;
            	for (var z = 0; z < result.length; z++) {
            		var row = result[z];
            	    var labDakTrackingUrl = "LabDakTracking.htm?dakId=" + row[0] + "&url=" + encodeURIComponent(row[15]);
            	    var rowHTML = '<tr>';
            	    rowHTML += '<td style="text-align: center;">' + count++ + '</td>';   
            	    rowHTML += '<td style="text-align: left;">' + (row[1] != null ? row[1] : '-') + '</td>';
            	    rowHTML += '<td style="text-align: left;">' + (row[5] != null ? row[5] : '-') + ' - ' + (row[6] != null ? row[6] : '-') + '</td>';
            	    rowHTML += '<td style="text-align: left;">' + (row[16] != null ? row[16] : '-') + '</td>';
            	    rowHTML += '<td style="text-align: center; color:blue;"><a href="' + labDakTrackingUrl + '" target="_blank">' + (row[13] != null ? row[13] : '-') + '</a></td>';   
            	    rowHTML += '</tr>';

            	    // Append row to tbody
            	    tbody.append(rowHTML);

            	}
                }
            }
    });
}

</script> 
</html>