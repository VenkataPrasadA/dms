<%@page import="java.util.Arrays"%>
<%@page import="com.vts.dms.DateTimeFormatUtil"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
 .custom-selectEnote {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 300px !important;
  left:-30px;
}

.custom-selectEnote select {
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

.downloadDakMainReplyAttachTable {
  width: 350px !important;

}

.downloadDakMainReplyAttachTable td {
    padding: 0.2rem;
    border:none;
} 
 textarea {
            resize: none; /* Disable user resizing */
            overflow-y: hidden; /* Hide vertical scrollbar */
            min-height: 50px; /* Set a minimum height */
        }
</style>
<title>DAK E Note Add</title>
</head>
<body>

<%
	List<Object[]> InitiatedByEmployeeList=(List<Object[]>)request.getAttribute("InitiatedByEmployeeList");
	String Action = (String)request.getAttribute("Action");
	String DakId=(String)request.getAttribute("DakId");
	Object[] EnoteAssignReplyData=(Object[])request.getAttribute("EnoteAssignReplyData");
	
	String EnoteFrom=(String)request.getAttribute("EnoteFrom");
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	//long AttachmentCount=(long)request.getAttribute("AttachmentCount");
	//List<String> ReturnRemarks = Arrays.asList("RC1","RC2","RC3","RC4","RC5","APR","RR1","RR2","RR3","RR4","RR5","RAP");
	//List<Object[]> AllReturnRemarks=(List<Object[]>)request.getAttribute("ReturnRemarks");
	List<Object[]> EnoteAssignReplyAttachmentData=(List<Object[]>)request.getAttribute("EnoteAssignReplyAttachmentData");
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
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb"><h5 style="font-weight: 700 !important">Dak e Note Add</h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteList.htm"><i class="fa fa-envelope"></i>e Note List</a></li>
						<li class="breadcrumb-item active"> Dak e Note Add </li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	
	
	<div class="page card dashboard-card" style="width: 70%; margin-left: 16%;">
	<div class="card-body" align="center" >	
	<%if(Action.equalsIgnoreCase("DakEnoteadd")){ %>
	<form action="DakEnoteReplyAddSubmit.htm" method="POST" id="myform" data-action="DakEnoteReplyAddSubmit.htm" enctype="multipart/form-data">	
	<input type="hidden" name="DakAssignReplyId" id="DakAssignReplyId" value="<%=EnoteAssignReplyData[7].toString()%>">
	<input type="hidden" id="EnoteFrom" name="EnoteFrom" value="<%=EnoteFrom%>">
	<input type="hidden" id="enoteDakId" name="DakId" value="<%if(EnoteAssignReplyData[0]!=null){%><%=EnoteAssignReplyData[0].toString()%><%}%>">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="row">
		<div class="col-md-4">
		<div class="form-group">
			<label class="control-label" style="float: left;">Note No </label>
			<input type="text" class="form-control " id="NoteNo" value="" name="NoteNo" >
		</div></div>
		
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label" style="float: left;">Ref No </label>
				<input type="text" class="form-control" id="RefNo" value="<%if(EnoteAssignReplyData[3]!=null){%><%=EnoteAssignReplyData[3].toString()%><%}%>" name="RefNo" >
			</div> </div>
			
			
          <div class="col-md-4">
		  <div class="form-group">
			<label class="control-label" style="float: left;">Ref Date </label>
			<input type="text" class="form-control" id="RefDate" value="<%if(EnoteAssignReplyData[2]!=null){%><%=DateTimeFormatUtil.SqlToRegularDate(EnoteAssignReplyData[2].toString()) %><%}%>" name="RefDate" >
			 </div> </div> 
		</div>	
		<div class="row">
		<div class="col-md-4">
			<div class="form-group">
		<label class="control-label" style="float: left;">Dak Id</label>
		<input type="text" class="form-control" id="DakNo" value="<%if(EnoteAssignReplyData[1]!=null){%><%=EnoteAssignReplyData[1].toString()%><%}%>" name="DakNo">
		</div></div>
		<div class="col-md-8">
			<div class="form-group">
		<label class="control-label" style="float: left;">Subject </label>
		<input type="text" class="form-control" id="Subject" value="<%if(EnoteAssignReplyData[9]!=null) {%><%=EnoteAssignReplyData[9].toString().trim()%><%} %>" name="Subject" maxlength="255">
		</div></div>
		</div>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Reply </label>
		<textarea style="border-bottom-color: gray;width: 100%" oninput="autoResize()"  maxlength="3000" placeholder="Maximum 3000 characters" id="Reply" name="Reply"><%if(EnoteAssignReplyData[5]!=null){%><%=EnoteAssignReplyData[5].toString().trim()%><%}%></textarea>
		</div>
		</div>
		</div>
		<div class="row">
		 <div class="enoteDocuments" style="width: 100%;">
                  <div class="row col-md-12"  style="float:left!important;">
                  <div class="form-group group2 col-md-3" id="eNoteDocumentLabel"  style=" width: 100%; display: none; float: left !important;">
                 	<label><b>eNote Documents :</b></label></div>
                 	<div class="col-md-9 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 80%;"> 
	  	      		<%
	  	      		if(EnoteFrom!=null && EnoteFrom.equalsIgnoreCase("M") && EnoteAssignReplyAttachmentData!=null && EnoteAssignReplyAttachmentData.size()>0){
	  	      		for(Object[] obj:EnoteAssignReplyAttachmentData) {%>
	  	      		<div  style="display: inline-block; margin-right: 100px; width:100%;">
	  	      		<div class="col-md-10" style=" width:100%; margin-right: 100px;"><button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply" style="float:left!important;" value="<%=obj[2].toString() %>" onclick="Iframepdfmarker(<%=obj[2].toString()%>)" data-toggle="tooltip" data-placement="top" title="Download"><%=obj[3].toString() %></button></div>
	  	      		<div class="col-md-2" style=" width:100%; margin-left: 150px;"><button type="button" id="MarkerEnoteAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="DakMarkerEnoteAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:40%; margin-right:380px;" onclick="deleteMarkerEnoteEditAttach(<%=obj[2].toString() %>, <%=obj[0].toString()%>)"><img alt="attach" src="view/images/delete.png"></button></div>
	  	      		</div><br>
	  	      		<input type="hidden" id="EnoteMarkerAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     			<input type="hidden" id="enoteMarkeridfordelete" name="DakReplyId" value="" />
  	     			<input type="hidden" id="redirval" name="redirval" value="DakEnoteAdd">
  	     			 <input type="hidden" id="markerenoteDakId" name="DakId" value="<%if(EnoteAssignReplyData[0]!=null){%><%=EnoteAssignReplyData[0].toString()%><%}%>">
	  	      		<%}}else if(EnoteFrom!=null && EnoteFrom.equalsIgnoreCase("C") && EnoteAssignReplyAttachmentData!=null && EnoteAssignReplyAttachmentData.size()>0){
	  	      		for(Object[] obj:EnoteAssignReplyAttachmentData) {%>
	  	      		<div  style="display: inline-block; margin-right: 100px; width:100%;">
	  	      		<div class="col-md-10" style=" width:100%; margin-right: 100px;"><button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply" style="float:left!important;" value="<%=obj[2].toString() %>" onclick="Iframepdf(<%=obj[2].toString()%>)" data-toggle="tooltip" data-placement="top" title="Download"><%=obj[3].toString() %></button></div>
	  	      		<div class="col-md-2" style=" width:100%; margin-left: 150px;"><button type="button" id="EnoteAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="DakEnoteAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:40%; margin-right:380px;" onclick="deleteEnoteEditAttach(<%=obj[2].toString() %>, <%=obj[0].toString()%>)"><img alt="attach" src="view/images/delete.png"></button></div>
	  	      		</div><br>
	  	      		<input type="hidden" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	                <input type="hidden" id="enoteidfordelete" name="DakId" value="" />
  	                <input type="hidden" id="redirval" name="redirval" value="DakEnoteAdd">
  	                <input type="hidden" id="markerenoteDakId" name="DakId" value="<%if(EnoteAssignReplyData[0]!=null){%><%=EnoteAssignReplyData[0].toString()%><%}%>">
	  	      		<%}} %>
	  	      		</div>
                 	</div>
                 	</div>
				<div class="col-md-12">
  	      			<div class="col-md-10 "><br><br>
  	      			<table style="float: left; margin-left: -100px;">
			  	      	<tr ><td><label style="font-weight:bold;font-size:16px; float: left;">Document :</label></td>
			  	      		<td align="right"><button type="button" class="tr_clone_editbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_clone">
			  	      			<td><input class="form-control" type="file" name="dakReplyEnoteDocument"  id="EditdakEnoteDocument" accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>	
			  	     </table>
  	      			</div>
  	      		 <label class="control-label" style="display: inline-block; float:left; margin-left:200px; align-items: center; font-size: 15px;"><b>Initiated By</b></label>
			<select class="selectpicker custom-selectEnote" id="InitiatedBy" required="required" data-live-search="true" name="InitiatedBy"  >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[0].toString()%> <% if (EnoteAssignReplyData[4]!=null && EnoteAssignReplyData[4].toString().equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	
		</div>
		</div>
		<div align="center">
		 <input type="button" class="btn btn-primary btn-sm submit " id="Preview" value="Preview" name="sub"  onclick="return forward()">
		</div>
  	     <input type="hidden" id="redirval" name="redirval" value="DakEnoteAdd">
		</form>
		<%} %>
		 <!-- Modal -->
<div id="myModalPreview"  style="margin-left: 10%; margin-top: 50px; width: 80%;"  class="modal">
  <!-- Modal content -->
   <div  class="modal-header" style="background-color: white; border: 1px solid black;">
        <h5 class="modal-title" ></h5>
        <span style="margin-left: 85%; color: red; margin-top: 2px;"></span>
        <button type="button" style="color:red;" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
  <div class="modal-content">
    <div id="modalbody" style="border: 1px solid black;"></div>
  </div>
</div>

<!-- PDF Viewer Modal -->
<div class="modal fade" id="myModallarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
<form action="#">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
      <span style="color: red;">File is too Large to Open & Please download the document !..</span><br><br>
        <button type="submit" class="btn btn-sm icon-btn" name="downloadbtn" id="largedocument" value="'+result[1]+'" formaction="EnoteAttachForDownload.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>
	</div>
</div>
</body>
<script type="text/javascript">
var count=1;
$("table").on('click','.tr_clone_addbtn' ,function() {
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.tr_clone_sub' ,function() {
	
var cl=$('.tr_clone').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.tr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});


var count=1;
$("table").on('click','.tr_clone_editbtn' ,function() {
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.tr_clone_sub' ,function() {
	
var cl=$('.tr_clone').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.tr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});
$('#RefDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

function deleteEnoteEditAttach(eNoteAttachId,eNoteId){
	 $('#EnoteAttachmentIdforDelete').val(eNoteAttachId);
	 $('#enoteidfordelete').val(eNoteId);
	 
	 var result = confirm ("Are You sure to Delete ?"); 
	 if(result){
		var button = $('#EnoteAttachDelete');
		var formAction = button.attr('formaction');
		console.log("act:"+formAction);
		if (formAction) {
			  var form = button.closest('form');
			  console.log("123:"+form);
			  form.attr('action', formAction);
			  form.submit();
			}else{
				console.log('form action not found');
			}
	} else {
	    return false; // or event.preventDefault();
	}
	 
 }
 

function deleteMarkerEnoteEditAttach(eNoteAttachId,eNoteId){
	 $('#EnoteMarkerAttachmentIdforDelete').val(eNoteAttachId);
	 $('#enoteMarkeridfordelete').val(eNoteId);
	 
	 console.log("eNoteAttachId:"+eNoteAttachId);
	 var result = confirm ("Are You sure to Delete ?"); 
	 if(result){
		var button = $('#MarkerEnoteAttachDelete');
		var formAction = button.attr('formaction');
		console.log("act:"+formAction);
		if (formAction) {
			  var form = button.closest('form');
			  console.log("123:"+form);
			  form.attr('action', formAction);
			  form.submit();
			}else{
				console.log('form action not found');
			}
	} else {
	    return false; // or event.preventDefault();
	}
	 
}
function Iframepdf(data){
	 $.ajax({
			
			type : "GET",
			url : "getDakEnoteiframepdf.htm",
			data : {
				
				data: data
				
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			 $('#modalbody').html('');
			if(result[0]==='pdf' || result[0]==='PDF' || result[0]==='Pdf'){
				var fileData = result[1]; // Base64 encoded file data
			    var byteCharacters = atob(fileData); // Decode the base64 data
			    var byteArrays = [];

			    for (var offset = 0; offset < byteCharacters.length; offset += 512) {
			      var slice = byteCharacters.slice(offset, offset + 512);
			      var byteNumbers = new Array(slice.length);

			      for (var i = 0; i < slice.length; i++) {
			        byteNumbers[i] = slice.charCodeAt(i);
			      }

			      var byteArray = new Uint8Array(byteNumbers);
			      byteArrays.push(byteArray);
			    }

			    var fileSize = byteArrays.reduce(function (acc, byteArr) {
			      return acc + byteArr.length;
			    }, 0);
			    var maxSize = 1.5 * 1024 * 1024; // 1.5 MB (in bytes)
			   
			    if (fileSize > maxSize) {
			    	document.getElementById('largedocument').value=data;
			    	$('#myModallarge').modal('show');
			    } else {
			    	 $('#myModalPreview').appendTo('body').modal('show');
			    	
			    	 // Get the base64-encoded PDF content from result[1]
			    	 const base64Content = result[1];

			    	 // Convert the base64 content into a Uint8Array
			    	 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

			    	 // Create a Blob from the Uint8Array
			    	 const blob = new Blob([byteArray], { type: 'application/pdf' });

			    	 // Create a Blob URL for the Blob
			    	 const url = URL.createObjectURL(blob);

			    	 // Create a temporary anchor element for downloading
			    	 const a = document.createElement('a');
			    	 a.href = url;
			    	 a.download = result[2]+''; // Set the desired filename
			    	 a.style.display = 'none';
			    	 document.body.appendChild(a);

			    	 // Trigger the download
			    	 a.click();

			    	 // Clean up the temporary anchor and Blob URL after the download
			    	 document.body.removeChild(a);
			    	 URL.revokeObjectURL(url);


			      $('#modalbody').html("<iframe  src='data:application/pdf;base64," + result[1] + "' width='100%' height='600' id='iframes' style='display: block;' name='showiframes'></iframe>");
			      // $('#modalbody').html(pdfContent);
			    }
			}else if (result[0] === 'xls' || result[0] === 'xlsx' || result[0] === 'XLS' || result[0] === 'XLSX'|| result[0] === 'Xls' || result[0] === 'Xlsx') {
				 $('#myModalPreview').appendTo('body').modal('show');
				 // Get the base64-encoded Excel content from result[1]
				    const base64Content = result[1];

				    // Convert the base64 content into a Uint8Array
				    const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

				    // Create a Blob from the Uint8Array, specifying the MIME type for Excel
				    const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });

				    // Create a temporary anchor element for downloading
				    const a = document.createElement('a');
				    a.href = URL.createObjectURL(blob);
				    a.download = result[2]+''; // Set the desired filename with .xlsx extension

				    // Trigger the download
				    a.click();

				    // Clean up the temporary anchor and Blob URL after the download
				    URL.revokeObjectURL(a.href);
			    //$('#modalbody').html("<iframe src='data:application/vnd.ms-excel;base64," + result[1].toString() + "' width='100%' height='650' id='iframes' type='application/vnd.ms-excel' name='showiframes'></iframe>");
			    $('#myModalPreview').modal('hide');
			} else if (result[0] === 'txt' || result[0] === 'TXT' || result[0] === 'Txt') { // Check for .txt files
				 $('#myModalPreview').appendTo('body').modal('show');
				    const base64Content = result[1];
				    const decodedContent = atob(base64Content);
				    const blob = new Blob([decodedContent], { type: 'text/plain' });
				    const url = URL.createObjectURL(blob);

				    const link = document.createElement('a');
				    link.href = url;
				    link.download = result[2]+''; // You can change the filename here
				    link.click();

				    // Clean up the object URL after the download
				    URL.revokeObjectURL(url);
				  $('#myModalPreview').modal('hide');
			    
			}else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {// Check for .docx files
				 $('#myModalPreview').appendTo('body').modal('show');
				// Get the base64-encoded DOCX content from result[1]
				 const base64Content = result[1];

				 // Convert the base64 content into a Uint8Array
				 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

				 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
				 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });

				 // Create a temporary anchor element for downloading
				 const a = document.createElement('a');
				 a.href = URL.createObjectURL(blob);
				 a.download =result[2]+''; // Set the desired filename with .docx extension

				 // Trigger the download
				 a.click();

				 // Clean up the temporary anchor and Blob URL after the download
				 URL.revokeObjectURL(a.href);

			       $('#myModalPreview').modal('hide');	  
				  
			
			} else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
				$('#myModalPreview').appendTo('body').modal('show');
				$('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.presentationml.presentation;base64," + result[1] + "' width='100%' height='650' id='iframes' type='application/vnd.openxmlformats-officedocument.presentationml.presentation' name='showiframes'></iframe>");

				// Provide a download link
				const downloadLink = document.createElement('a');
				downloadLink.href = 'data:application/octet-stream;base64,' + result[1]; // Set the MIME type to application/octet-stream
				downloadLink.download = result[2]+''; // Set the desired filename
				downloadLink.style.display = 'none'; // Hide the download link
				document.body.appendChild(downloadLink);

				// Trigger the download link click
				downloadLink.click();
				document.body.removeChild(downloadLink); // Clean up the download link

				$('#myModalPreview').modal('hide');
			
			
			}else if (['jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'gif', 'avif', 'png'].includes(result[0].toLowerCase())) {
			    $('#myModalPreview').appendTo('body').modal('show');
			    $('#modalbody').html("<img style='max-width:40cm;max-height:17cm;margin-left:25%; display: block' src='data:image/" + result[0] + ";base64," + result[1] + "'>");
		
			}else {
			
					$('#myModalPreview').modal('hide');

		            const base64Content = result[1];
		            const decodedContent = atob(base64Content);
		            const blob = new Blob([decodedContent], { type: 'application/octet-stream' }); // Set a generic content type
		            const url = URL.createObjectURL(blob);

		            const link = document.createElement('a');
		            link.href = url;
		            link.download = result[2]+''; // You can set a default filename here
		            link.click();

		            // Clean up the object URL after the download
		            URL.revokeObjectURL(url);
			}
			}
			});	
}


function Iframepdfmarker(data){
	 $.ajax({
			
			type : "GET",
			url : "getDakMarkingEnoteiframepdf.htm",
			data : {
				
				data: data
				
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			 $('#modalbody').html('');
			if(result[0]==='pdf' || result[0]==='PDF' || result[0]==='Pdf'){
				var fileData = result[1]; // Base64 encoded file data
			    var byteCharacters = atob(fileData); // Decode the base64 data
			    var byteArrays = [];

			    for (var offset = 0; offset < byteCharacters.length; offset += 512) {
			      var slice = byteCharacters.slice(offset, offset + 512);
			      var byteNumbers = new Array(slice.length);

			      for (var i = 0; i < slice.length; i++) {
			        byteNumbers[i] = slice.charCodeAt(i);
			      }

			      var byteArray = new Uint8Array(byteNumbers);
			      byteArrays.push(byteArray);
			    }

			    var fileSize = byteArrays.reduce(function (acc, byteArr) {
			      return acc + byteArr.length;
			    }, 0);
			    var maxSize = 1.5 * 1024 * 1024; // 1.5 MB (in bytes)
			   
			    if (fileSize > maxSize) {
			    	document.getElementById('largedocument').value=data;
			    	$('#myModallarge').modal('show');
			    } else {
			    	 $('#myModalPreview').appendTo('body').modal('show');
			    	
			    	 // Get the base64-encoded PDF content from result[1]
			    	 const base64Content = result[1];

			    	 // Convert the base64 content into a Uint8Array
			    	 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

			    	 // Create a Blob from the Uint8Array
			    	 const blob = new Blob([byteArray], { type: 'application/pdf' });

			    	 // Create a Blob URL for the Blob
			    	 const url = URL.createObjectURL(blob);

			    	 // Create a temporary anchor element for downloading
			    	 const a = document.createElement('a');
			    	 a.href = url;
			    	 a.download = result[2]+''; // Set the desired filename
			    	 a.style.display = 'none';
			    	 document.body.appendChild(a);

			    	 // Trigger the download
			    	 a.click();

			    	 // Clean up the temporary anchor and Blob URL after the download
			    	 document.body.removeChild(a);
			    	 URL.revokeObjectURL(url);


			      $('#modalbody').html("<iframe  src='data:application/pdf;base64," + result[1] + "' width='100%' height='600' id='iframes' style='display: block;' name='showiframes'></iframe>");
			      // $('#modalbody').html(pdfContent);
			    }
			}else if (result[0] === 'xls' || result[0] === 'xlsx' || result[0] === 'XLS' || result[0] === 'XLSX'|| result[0] === 'Xls' || result[0] === 'Xlsx') {
				 $('#myModalPreview').appendTo('body').modal('show');
				 // Get the base64-encoded Excel content from result[1]
				    const base64Content = result[1];

				    // Convert the base64 content into a Uint8Array
				    const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

				    // Create a Blob from the Uint8Array, specifying the MIME type for Excel
				    const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });

				    // Create a temporary anchor element for downloading
				    const a = document.createElement('a');
				    a.href = URL.createObjectURL(blob);
				    a.download = result[2]+''; // Set the desired filename with .xlsx extension

				    // Trigger the download
				    a.click();

				    // Clean up the temporary anchor and Blob URL after the download
				    URL.revokeObjectURL(a.href);
			    //$('#modalbody').html("<iframe src='data:application/vnd.ms-excel;base64," + result[1].toString() + "' width='100%' height='650' id='iframes' type='application/vnd.ms-excel' name='showiframes'></iframe>");
			    $('#myModalPreview').modal('hide');
			} else if (result[0] === 'txt' || result[0] === 'TXT' || result[0] === 'Txt') { // Check for .txt files
				 $('#myModalPreview').appendTo('body').modal('show');
				    const base64Content = result[1];
				    const decodedContent = atob(base64Content);
				    const blob = new Blob([decodedContent], { type: 'text/plain' });
				    const url = URL.createObjectURL(blob);

				    const link = document.createElement('a');
				    link.href = url;
				    link.download = result[2]+''; // You can change the filename here
				    link.click();

				    // Clean up the object URL after the download
				    URL.revokeObjectURL(url);
				  $('#myModalPreview').modal('hide');
			    
			}else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {// Check for .docx files
				 $('#myModalPreview').appendTo('body').modal('show');
				// Get the base64-encoded DOCX content from result[1]
				 const base64Content = result[1];

				 // Convert the base64 content into a Uint8Array
				 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

				 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
				 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });

				 // Create a temporary anchor element for downloading
				 const a = document.createElement('a');
				 a.href = URL.createObjectURL(blob);
				 a.download =result[2]+''; // Set the desired filename with .docx extension

				 // Trigger the download
				 a.click();

				 // Clean up the temporary anchor and Blob URL after the download
				 URL.revokeObjectURL(a.href);

			       $('#myModalPreview').modal('hide');	  
				  
			
			} else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
				$('#myModalPreview').appendTo('body').modal('show');
				$('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.presentationml.presentation;base64," + result[1] + "' width='100%' height='650' id='iframes' type='application/vnd.openxmlformats-officedocument.presentationml.presentation' name='showiframes'></iframe>");

				// Provide a download link
				const downloadLink = document.createElement('a');
				downloadLink.href = 'data:application/octet-stream;base64,' + result[1]; // Set the MIME type to application/octet-stream
				downloadLink.download = result[2]+''; // Set the desired filename
				downloadLink.style.display = 'none'; // Hide the download link
				document.body.appendChild(downloadLink);

				// Trigger the download link click
				downloadLink.click();
				document.body.removeChild(downloadLink); // Clean up the download link

				$('#myModalPreview').modal('hide');
			
			
			}else if (['jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'gif', 'avif', 'png'].includes(result[0].toLowerCase())) {
			    $('#myModalPreview').appendTo('body').modal('show');
			    $('#modalbody').html("<img style='max-width:40cm;max-height:17cm;margin-left:25%; display: block' src='data:image/" + result[0] + ";base64," + result[1] + "'>");
		
			}else {
			
					$('#myModalPreview').modal('hide');

		            const base64Content = result[1];
		            const decodedContent = atob(base64Content);
		            const blob = new Blob([decodedContent], { type: 'application/octet-stream' }); // Set a generic content type
		            const url = URL.createObjectURL(blob);

		            const link = document.createElement('a');
		            link.href = url;
		            link.download = result[2]+''; // You can set a default filename here
		            link.click();

		            // Clean up the object URL after the download
		            URL.revokeObjectURL(url);
			}
			}
			});	
}


function forward() {
	
	var shouldSubmit=true;
	var DakNo=$('#DakNo').val();
	var RefNo=$('#RefNo').val();
	var RefDate=$('#RefDate').val();
	var Reply=$('#Reply').val();
	var Subject=$('#Subject').val();
	var NoteNo=$('#NoteNo').val();
	if(NoteNo==null || NoteNo==='' || NoteNo===" " || typeof(NoteNo)=='undefined'){
		alert("Please Enter the Note No...!")
		$('#NoteNo').focus();
		shouldSubmit=false;
	}else if(DakNo==null || DakNo==='' || DakNo===" " || typeof(DakNo)=='undefined'){
		alert("Please Enter the Dak No...!")
		$('#DakNo').focus();
		shouldSubmit=false;
	}else if(RefNo==null || RefNo==='' || RefNo===" " || typeof(RefNo)=='undefined'){
		alert("Please Enter the Ref No...!")
		$('#RefNo').focus();
		shouldSubmit=false;
	}else if(RefDate==null || RefDate==='' || RefDate===" " || typeof(RefDate)=='undefined'){
		alert("Please Select the Ref Date...!")
		$('#RefDate').focus();
		shouldSubmit=false;
	}else if(Subject==null || Subject==='' || Subject===" " || typeof(Subject)=='undefined'){
		alert("Please Enter the Subject...!")
		$('#Subject').focus();
		shouldSubmit=false;
	}else if(Reply==null || Reply==='' || Reply===" " || typeof(Reply)=='undefined'){
		alert("Please Enter the Reply...!")
		$('#Reply').focus();
		shouldSubmit=false;
	}else{
		var formAction = $('#myform').data('action');
		if(confirm('Are you Sure To Preview ?')){
			  $('#myform').attr('action', formAction);
	          $('#myform').submit(); /* submit the form */
		}
	}
}

function autoResize() {
    const textarea = document.getElementById('Reply');
    textarea.style.height = 'auto'; // Reset height to auto to calculate the actual height
    textarea.style.height = textarea.scrollHeight + 'px'; // Set the height to the scroll height
}
</script>	
</html>