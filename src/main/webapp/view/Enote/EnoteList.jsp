<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List,java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>E Note List</title>
<style type="text/css">
.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}
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
				<h5 style="font-weight: 700 !important">e Note List</h5>
			</div>
			<div class="col-md-9">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteDashBoard.htm"><i class="fa fa-envelope"></i> e Note </a></li>
						<li class="breadcrumb-item active">e Note List </li>
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
	
	List<Object[]> EnoteList=(List<Object[]>)request.getAttribute("EnoteList");
	
	List<Object[]> MailReceivedEmpDetails=(List<Object[]>)request.getAttribute("MailReceivedEmpDetails");
	
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
 <form action="ENoteList.htm" method="POST" id="myform"> 
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
   <input type="hidden" name="preview" value="preview">
   <input type="hidden" name="ViewFrom" value="EnoteList">
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
								if(EnoteList!=null && EnoteList.size()>0){
									for(Object[] obj:EnoteList){
										%>
								 <tr>
								   <td style="width:10px;">
								   <%if(forwardstatus.contains(obj[8].toString()) ){ %>
									<input type="radio" name="eNoteId" id="eNoteId" value=<%=obj[0]%>> <%}else{ %>
									<input type="radio" name="eNoteId" id="eNoteId" value=<%=obj[0]%> disabled="disabled">
									<%} %>
								   </td>
								   <td class="wrap" style="text-align: left;width:80px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: left;width:80px;"><%if(obj[11]!=null){ %><%=obj[11].toString() %><%}else{ %>-<%} %></td>
								   <td style="text-align: left;width:5px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %></td>
								   <td class="wrap" style="text-align: left;width:50px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %><br><%if(obj[4]!=null){%><%=sdf.format(obj[4])%><%}else{ %><%="NA"%><%} %></td>
								   <td style="text-align: left;width:200px;"><%if(obj[5]!=null){ %><%=obj[5].toString() %><%}else{ %>-<%} %></td>
								   <td style="text-align: left;width:400px;"><%if(obj[12]!=null){ %><%=obj[12].toString() %><%}else{ %>-<%} %></td>
								   <td style="text-align: center;width:70px;">
								   <button type="submit" class="btn btn-sm btn-link w-100 btn-status" formaction="EnoteStatusTrack.htm" value="<%=obj[0]%>" name="EnoteTrackId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[7]%>; font-weight: 600;" formtarget="_blank">
								    		&nbsp; <%=obj[6].toString() %> <i class="fa-solid fa-arrow-up-right-from-square" style="float: right;" ></i>
									</button>
								   </td>
								   <td style="text-align: center;width:180px;">
								   <button type="submit" class="btn btn-sm icon-btn"   id=<%="SelEnoteId"+obj[0]%> value="<%=obj[0] %>" <%if(obj[13].toString().equalsIgnoreCase("N")) {%> formaction="EnotePreview.htm" name="eNoteId" <%}else{ %> formaction="DakEnoteReplyPreview.htm" name="eNoteId" <%} %>formmethod="post"
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
 								   <button type="submit" class="btn btn-sm" name="EnoteRevokeId" id=<%="EnoteRevokeId"+obj[0]%> value="<%=obj[0]%>" formaction="EnoteRevoke.htm" onclick="return confirm('Are you sure to Revoke?');" formmethod="post" data-toggle="tooltip" data-placement="top" title="Revoke Submission">
									<i class="fa-solid fa-backward" style="color: red;"></i>
							       </button>
							       <%} %>
 								   <%if(obj[6]!=null && obj[6].toString().equalsIgnoreCase("Approved")){ %>
 								   <button type="button" class="btn btn-sm" name="EnoteUploadId" id=<%="EnoteUploadId"+obj[0]%> value="<%=obj[0]%>"  onclick="openUploadModal('<%=obj[0] %>','<%=obj[14] %>','<%=obj[1] %>','<%=obj[5] %>')" formmethod="post" data-toggle="tooltip" data-placement="top" title="Upload">
									<img alt="mark" src="view/images/upload.png">
							       </button>
							       <%} %>
							       <input type="hidden" name="IsDak" id=<%="IsDak"+obj[13].toString() %> value="<%=obj[13].toString()%>">
								   </td>
								</tr>
								<%}} %>	
							</tbody>
					</table>		
   
		   <div align="center">
		    <button type="submit" class="btn btn-primary btn-sm add" id="add" name="Action" value="add" formaction="EnoteAdd.htm"  >Add</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <button type="submit" class="btn btn-warning btn-sm edit" id="edit" name="Action" value="Edit" formaction="EnoteEdit.htm" onclick="Edit(eNoteListForm)" >Edit</button>
		   </div>
		</form>
     </div>
     <!------------------------------------------------------- Document Upload Modal Start ------------------------------------------------------------------------->
     
     <div class="modal fade" id="DocumentUpload" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-jump" role="document">
    <div class="modal-content" style="height: 450px;  border:black 1px solid;  width: 100%;">
    <form action="EnoteDocumentUpload.htm" method="post" id="myform" enctype="multipart/form-data">
      <div class="modal-header" style="background-color: #005C97;">
        <h5 class="modal-title" style="color:white;" ><b>Document Upload</b>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span style="font-size: 17px;">EnoteId &nbsp;:&nbsp; </span>
        <span style="font-size: 17px;" id="noteId"></span>&nbsp;&nbsp;&nbsp;
        <!-- <span style="font-size: 14px;">Subject &nbsp;:&nbsp; </span>
        <span style="font-size: 14px;" id="notesubject"></span> -->
        </h5>
        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div><br>
      <div class="col-md-12">
      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
		<div class="row">
		<div class="col-md-12">
		  	<div class="form-group">
		      <label >Attachment </label>
		        <input  class="form-control" id="UploadDocument" type="file" name="UploadDocument" required="required" style="font-size: 15px;width:100%;">
		</div>
  		</div>
		</div>
      </div>
		<div class="col-md-12" style="margin-left: 35px;">
		<input type="radio" name="Mail" checked="checked" value="N" onclick="DakReplyMailSent()"> No Mail&nbsp;&nbsp;&nbsp;
		<input type="radio" name="Mail"  value="L" onclick="DakReplyMailSent()"> Lab Mail&nbsp;&nbsp;&nbsp;
		<input type="radio" name="Mail"  value="D" onclick="DakReplyMailSent()"> Drona Mail
		</div><br>
		<div class="row"  id="MailSent" style="display: none;">
  	      		<div class="col-md-5" style="margin-left: 35px;">
				<label style="font-size: 15px;"><b>Sender MailId</b></label>
				<input class="form-control" type="text" name="ReplyPersonSentMail" id="ReplyPersonSentMail" readonly="readonly" >
				</div>
  	      		<div class="col-md-5">
  	      		<label style="font-size: 15px;"><b>Receiver MailId</b></label>
  	      			<select class="form-control selectpicker ReplyReceivedMail "  id="ReplyReceivedMail" multiple="multiple" data-live-search="true" name="ReplyReceivedMail">
  	      				<option value="select">Select</option>
  	      				 <%-- <%if (MailReceivedEmpDetails != null && MailReceivedEmpDetails.size() > 0) {
												for (Object[] obj : MailReceivedEmpDetails) {
											%>
											<option value="<%=obj[2]%>"><%=obj[2].toString() %></option>
											<%}}%>  --%>
  	      				</select>
  	      			</div>
  	      		</div><br>
		<div align="center">
		<div class="form-group">
		  		<input type="submit" class="btn btn-primary btn-sm submit" value="Upload" name="sub" onclick="return UploadLetterDoc()" >
		</div>
		</div>
      <input type="hidden" name="EnoteIdForUpload" id="EnoteIdForUpload">
      <input type="hidden" name="LetterNoForUpload" id="LetterNoForUpload">
      </form>
      <span id="FinalDocument" style="color: blue; font-size: 16px; margin-left: 15px;"></span>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
     
     <!--------------------------------------------------------------- Document Upload Modal End ----------------------------------------------------------------------->
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
function DakReplyMailSent(){
	var elements = document.getElementsByName('Mail');
	var value;

	// Loop through all radio buttons to find the checked one
	for (var i = 0; i < elements.length; i++) {
	  if (elements[i].checked) {
	    value = elements[i].value;
	    break;
	  }
	}
	console.log("value: " + value);
	if (value === 'N') {
		$('#MailSent').hide();
		} else {
			$('#MailSent').show();
			$('#HostType').val(value);
			$.ajax({
			        type: "GET",
			        url: "getMailSenderDetails.htm",
			        data: {
			        	value: value
			        },
			        dataType: 'json',
			        success: function(result) {
			            if (result != null) {
			            	$('#ReplyPersonSentMail').val(result[0]);
			            	$.ajax({
						        type: "GET",
						        url: "getMailReceiverDetails.htm",
						        data: {
						        	value: value
						        },
						        dataType: 'json',
						        success: function(result) {
						            if (result != null) {
						            	$('#ReplyReceivedMail').empty();
						                for (var i = 0; i < result.length; i++) {
						                    var data = result[i];
						                    var optionValue = data[2];
						                    var optionText = data[2]; // Removed the %>; and fixed the concatenation
						                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
						                    $('#ReplyReceivedMail').append(option); // Moved this inside the loop
						                }
						                $('#ReplyReceivedMail').selectpicker('refresh');
						            	
						                    }
						            }

						    });
			                    }
			            }

			    });
		}
}	
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
	
function Edit(eNoteListForm){

	 var fields = $("input[name='eNoteId']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
		  return true;	
	}

function openUploadModal(eNoteId,letterNo,noteId,subject) {
	$('#DocumentUpload').modal('show');
	console.log('eNoteId:'+eNoteId);
	console.log('letterNo:'+letterNo);
	$('#EnoteIdForUpload').val(eNoteId);
	$('#LetterNoForUpload').val(letterNo);
	$('#noteId').html(noteId);
	$('#notesubject').html(subject);
	  $.ajax({
			
			type : "GET",
			url : "UploadedDocumentDetails.htm",
			data : {
				
				eNoteId: eNoteId
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			
			if(result!=null){
				var mainstr = '<form action="LetterDocDownload.htm" method="Get">';
				mainstr += '<div style="display: inline-block; width:100%;">';
				mainstr += '<div class="col-md-10" style="width:100%; display: inline-block;">';
				mainstr += '<button type="submit" class="btn btn-sm replyAttachWithin-btn" name="LetterDocumentId" value="' + result[2] + '" data-toggle="tooltip" data-placement="top" title="Download" style="float:left!important; color:blue;">' + result[1] + '</button>';
				mainstr += '</div>';
				mainstr += '</div>';
				mainstr += '</form>';

				$('#FinalDocument').html(mainstr);

			}
			}
			
});
}

function UploadLetterDoc() {
    var fileInput = document.getElementById('UploadDocument');
    if (fileInput.files.length === 0) {
        alert("Please attach a document before proceeding.");
        fileInput.focus();
        return false;
    }
    var elements = document.getElementsByName('Mail');
    var value;
    for (var i = 0; i < elements.length; i++) {
        if (elements[i].checked) {
            value = elements[i].value;
            break;
        }
    }
    console.log("value: " + value);
    if (value === 'N') {
    	var confirmation = confirm("Are you sure you want to Upload?");
        if (!confirmation) {
            return false;
        }
        return true;
    } else if (value === 'L' || value === 'D') {
        var ReplyReceivedMail = $('#ReplyReceivedMail').val();
        console.log("ReplyReceivedMail:" + ReplyReceivedMail);
        if (ReplyReceivedMail == null || ReplyReceivedMail == '' || typeof(ReplyReceivedMail) == 'undefined' || ReplyReceivedMail == 'select') {
            alert("Please Select a Mail ...!");
            $("#ReplyReceivedMail").focus();
            return false;
        } else {
            var confirmation = confirm("Are you sure you want to Upload?");
            if (!confirmation) {
                return false;
            }
        }
    }
    return true;
}

</script>
</html>