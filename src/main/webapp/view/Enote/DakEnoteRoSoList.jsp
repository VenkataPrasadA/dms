<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Initiate Officer List</title>
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
				<h5 style="font-weight: 700 !important">e Note RoSo List </h5>
			</div>
			<div class="col-md-9">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteDashBoard.htm"><i class="fa fa-envelope"></i> e Note </a></li>
						<li class="breadcrumb-item active">e Note RoSo List</li>
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
	
	List<Object[]> EnoteRoSoList=(List<Object[]>)request.getAttribute("EnoteRoSoList");
	
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
	  <div class="table-responsive" style="overflow:hidden;">
   <form action="#" method="post" id="eNoteListForm">
   <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
							<tr>
									<th class="text-nowrap">SN</th>
									<th class="text-nowrap">Employee</th>
									<th class="text-nowrap">Recommending Officer1</th>
									<th class="text-nowrap">Recommending Officer1_Role </th>
									<th class="text-nowrap">Approving Officer</th>
									<th class="text-nowrap">Approving Officer_Role </th>
									<th class="text-nowrap">View</th>
						</tr>
							</thead>
							<tbody>	
							<%
								if(EnoteRoSoList!=null && EnoteRoSoList.size()>0){
									for(Object[] obj:EnoteRoSoList){
										%>
								 <tr >
								   <td style="width:10px;"><input type="radio" name="eNoteRoSoId" id="eNoteRoSoId" value=<%=obj[0]%>></td>
								   <td class="wrap" style="text-align: left;width:140px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: left;width:80px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: center;width:80px;"><%if(obj[9]!=null){ %><%=obj[9].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: left;width:80px;"><%if(obj[8]!=null){ %><%=obj[8].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: center;width:80px;"><%if(obj[15]!=null){ %><%=obj[15].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: center;width:80px;">
								    <button type="button" class="btn btn-sm icon-btn" onclick="DakEnoteRoSoDetails(<%=obj[0] %>)"
 										  data-toggle="tooltip" data-placement="top" title="Click Here for View RoSo Details">
 											<img alt="view" src="view/images/preview3.png">
									</button>
								   </td>
								</tr>
								<%}} %>	
							</tbody>
					</table>		
   
    <div align="center">
    <button type="submit" class="btn btn-primary btn-sm add" id="add" name="Action" value="add" formaction="DakEnoteRoSoAdd.htm"  >Add</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <button type="submit" class="btn btn-warning btn-sm edit" id="edit" name="Action" value="Edit" formaction="DakEnoteRoSoEdit.htm" onclick="Edit(eNoteListForm)" >Edit</button>
		</div>
		</form>
   </div>
    <!-- ------------------------------------------------------------------------------------------ DakEnoteRoso Details Modal Start ------------------------------------------------------------------------------------------>
					

   <div class="modal fade my-modal" id="exampleModalDakEnoteRoSoDetails"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" >
 	    <div class="modal-content" style="height: 550px;">
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color: white;">DAK Enote RoSo Details</span></b></h5> </div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" ><br>
  	      		<div class="row">
  	      		<div class="col-md-12" id="RoSoDetails">
  	      		<form id="removeForm">
  	      		 <table class="table table-bordered" id="dakEnoteRoSoTable">
                    <!-- Table body will be populated dynamically -->
                </table>
                </form>
  	      		<!-- <div class="row" id="rc1" style="margin-left: 20px; display: none;"><span><b>Recommending-Officer1 : </b> </span>
  	      		&nbsp;&nbsp;&nbsp;&nbsp;<span id="rec1" style="color: blue;"></span></div>
      		    <div class="row" id="rc2" style="margin-left: 20px; display: none;"><span><b>Recommending-Officer2 : </b> </span>
      		    &nbsp;&nbsp;&nbsp;&nbsp;<span id="rec2" style="color: blue;"></span></div>
      		    <div class="row" id="rc3" style="margin-left: 20px; display: none;"><span><b>Recommending-Officer3 : </b> </span>
      		    &nbsp;&nbsp;&nbsp;&nbsp;<span id="rec3" style="color: blue;"></span></div>
      		    <div class="row" id="rc4" style="margin-left: 20px; display: none;"><span><b>Recommending-Officer4 : </b></span>
      		    &nbsp;&nbsp;&nbsp;&nbsp;<span id="rec4" style="color: blue;"></span></div>
      		    <div class="row" id="rc5" style="margin-left: 20px; display: none;"><span><b>Recommending-Officer5 : </b></span>
      		    &nbsp;&nbsp;&nbsp;&nbsp;<span id="rec5" style="color: blue;"></span></div>
      		    <div class="row" id="et" style="margin-left: 20px; display: none;"><span><b>External-Officer : </b></span>
      		    &nbsp;&nbsp;&nbsp;&nbsp;<span id="ext" style="color: blue;"></span></div>
  	      		<div class="row" id="sc" style="margin-left: 20px; display: none;"><span><b>Approving-Officer : </b> </span>
  	      		&nbsp;&nbsp;&nbsp;&nbsp;<span id="sanc" style="color: blue;"></span></div> -->
  	      			</div>
  	      		</div>
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
  
  
  
  <!-- ------------------------------------------------------------------------------------------------- DakEnoteRoso Details Modal End  ---------------------------------------------------------------------------->
   </div>
   </div>
</body>
<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	

function Edit(eNoteListForm){

	 var fields = $("input[name='eNoteRoSoId']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
		  return true;	
	}	

function DakEnoteRoSoDetails(EnoteRoSoId) {
	    $('#exampleModalDakEnoteRoSoDetails').modal('show');
	    $.ajax({
	        type: "GET",
	        url: "getDakEnoteRoSoDetails.htm",
	        data: {
	        	EnoteRoSoId: EnoteRoSoId
	        },
	        dataType: 'json',
	        success: function(result) {
	            var consultVals = Object.values(result);
	            if (result != null) {
	            	 var tableRows = '';
	            	 var tableHeaders = '<tr><th>Recommend Officer</th><th style="text-align:center">Action</th></tr>';
	                 if (result[2] != null && result[9] != null) {
	                     tableRows += '<tr><td>Recommending-Officer1 : <span style="color: blue;">' + result[9] + ' - ' + result[2] + '</span></td><td align="center"></td></tr>';
	                 }
	                 if (result[3] != null && result[10] != null) {
	                     tableRows += '<tr><td>Recommending-Officer2 : <span style="color: blue;">' + result[10] + ' - ' + result[3] + '</span></td><td align="center"><button type="submit" class="btn btn-sm" name="eNoteRosoUpdateId" value="' + 'R2'+ ' - ' +EnoteRoSoId+ '" formaction="eNoteRosoUpdate.htm" onclick="return confirm(\'Are you sure to remove?\');" formmethod="get" data-toggle="tooltip" data-placement="top" title="Remove"><i class="fa fa-trash" style="color:red;" aria-hidden="true"></i></button></td></tr>';
	                 }
	                 if (result[4] != null && result[11] != null) {
	                     tableRows += '<tr><td>Recommending-Officer3 : <span style="color: blue;">' + result[11] + ' - ' + result[4] + '</span></td><td align="center"><button type="submit" class="btn btn-sm" name="eNoteRosoUpdateId" value="' + 'R3'+ ' - ' +EnoteRoSoId+ '" formaction="eNoteRosoUpdate.htm" onclick="return confirm(\'Are you sure to remove?\');" formmethod="get" data-toggle="tooltip" data-placement="top" title="Remove"><i class="fa fa-trash" style="color:red;" aria-hidden="true"></i></button></td></tr>';
	                 }
	                 if (result[5] != null && result[12] != null) {
	                     tableRows += '<tr><td>Recommending-Officer4 : <span style="color: blue;">' + result[12] + ' - ' + result[5] + '</span></td><td align="center"><button type="submit" class="btn btn-sm" name="eNoteRosoUpdateId" value="' + 'R4'+ ' - ' +EnoteRoSoId+ '" formaction="eNoteRosoUpdate.htm" onclick="return confirm(\'Are you sure to remove?\');" formmethod="get" data-toggle="tooltip" data-placement="top" title="Remove"><i class="fa fa-trash" style="color:red;" aria-hidden="true"></i></button></td></tr>';
	                 }
	                 if (result[6] != null && result[13] != null) {
	                     tableRows += '<tr><td>Recommending-Officer5 : <span style="color: blue;">' + result[13] + ' - ' + result[6] + '</span></td><td align="center"><button type="submit" class="btn btn-sm" name="eNoteRosoUpdateId" value="' + 'R5'+ ' - ' +EnoteRoSoId+ '" formaction="eNoteRosoUpdate.htm" onclick="return confirm(\'Are you sure to remove?\');" formmethod="get" data-toggle="tooltip" data-placement="top" title="Remove"><i class="fa fa-trash" style="color:red;" aria-hidden="true"></i></button></td></tr>';
	                 }
	                 if (result[7] != null && result[14] != null) {
	                     tableRows += '<tr><td>External-Officer : <span style="color: blue;">' + result[14] + ' - ' + result[7] + '</span></td><td align="center"><button type="submit" class="btn btn-sm" name="eNoteRosoUpdateId" value="' + 'E'+ ' - ' +EnoteRoSoId+ '" formaction="eNoteRosoUpdate.htm" onclick="return confirm(\'Are you sure to remove?\');" formmethod="get" data-toggle="tooltip" data-placement="top" title="Remove"><i class="fa fa-trash" style="color:red;" aria-hidden="true"></i></button></td></tr>';
	                 }
	                 if (result[8] != null && result[15] != null) {
	                     tableRows += '<tr><td>Approving-Officer : <span style="color: blue;">' + result[15] + ' - ' + result[8] + '</span></td><td align="center"></td></tr>';
	                 }
	                 $('#dakEnoteRoSoTable').html(tableHeaders + tableRows);
	               }
	        }
	    }); 
}
</script>
</html>