<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Template List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
</head>
<body>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">Template List</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="ENoteDashBoard.htm"><i class="fa fa-envelope" ></i> e Note </a></li>
				    <li class="breadcrumb-item active">Template List</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>
<%
String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
List<Object[]> TemplateList=(List<Object[]>)request.getAttribute("TemplateList");
List<Object[]> labMasterList=(List<Object[]>)request.getAttribute("labMasterList");
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
   <form action="#" method="post">
   <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						<table class="table table-bordered table-hover table-striped table-condensed "   id="myTable1">
							<thead>
							<tr>
								<th class="text-nowrap">SN</th>
								<th class="text-nowrap">Template Name</th>
								<th class="text-nowrap">Template File</th>
						</tr>
							</thead>
							<tbody>	
							<%
								if(TemplateList!=null && TemplateList.size()>0){
									for(Object[] obj:TemplateList){
										%>
								 <tr>
								   <td class="wrap" style="text-align: left;width:80px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: left;width:80px;"><%if(obj[11]!=null){ %><%=obj[11].toString() %><%}else{ %>-<%} %></td>
								   <td style="text-align: center;width:10px;">
 								   <button type="submit" class="btn btn-sm" formaction="TemplateDownload.htm" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
									<i class="fa fa-download" style="color: green;" aria-hidden="true"></i>
							       </button>
								   </td>
								</tr>
								<%}} %>	
							</tbody>
					</table>		
					<div align="center">
					 <button type="button" class="btn btn-primary btn-sm add" formaction="TemplateInitiation.htm" formmethod="post" onclick="return openTemplate()">Add</button>
					</div><br>
		</form>
		
			<!-- ------------------------------------------------------------------------------------------ eNote Template Modal Start ------------------------------------------------------------------------------------------>
					
			
			<div class="modal fade my-modal" id="exampleModaleNoteTemplate" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
			 <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-jump" role="document">
			   <div class="modal-content" style="height: 400px;">
			<div class="modal-header" style="background-color: #114A86;max-height:55px;">
			<div class="center-div" align="center"><h5 class="modal-title"><b><span style="color: white;">Template Initiation</span></b></h5> </div>
			<button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
			 	          <span aria-hidden="true">&times;</span>
			 	        </button>
			 	      </div>
			 	      <div class="modal-body" >
			 	     <form action="TemplateSubmit.htm" method="post" >
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="row">
  	      		<div class="col-md-2"><b>LabCode</b></div>
  	      		<div class="col-md-10">
  	      			<select class="form-control selectpicker"  id="LabCode" data-live-search="true"  required="required"  name="LabCode">
			      			<%if(labMasterList!=null && labMasterList.size()>0){
							for(Object[] obj:labMasterList){  	      				
			      				%>
			      				<option value="<%=obj[1]%>"><%=obj[1]%></option>
			      				<%}} %>
  	      				</select>
  	      			</div>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return TemplateSubmit()"> 
  	      		  </div>
  	      		</div>
  	      	</form>
			 	      </div>
			 	      <div class="modal-footer">
			 	      </div>
			 	    </div>
			 	  </div>
			</div>
			 
			 <!-- ------------------------------------------------------------------------------------------------- eNote Template Modal End  ---------------------------------------------------------------------------->
     </div>
  </div>
</div>
</div>
</body>
<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true
});	

function openTemplate() {
	$('#exampleModaleNoteTemplate').modal('show');
}
</script>
</html>