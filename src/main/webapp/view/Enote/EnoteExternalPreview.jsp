<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>e Note External Preview</title>
<style type="text/css">
#sidebarCollapse{
display:none;
}

#sidebar{
display:none;
}

tr {
    background-color: white;
    border: 1px solid black; /* You can customize the color and width as needed */
  }
  b{
  font-size: 1.2rem;
  }
 span{
 font-size: 1.1rem;
 } 
.downloadDakMainReplyAttachTable {
  width: 350px;

}

.downloadDakMainReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}

.custom-selectEnoteExternalOfficer{
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 280px !important;
  right: 85px;
}

.custom-selectEnoteLab {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 132px !important;
  float:left !important;
  left: 25px;
}
</style>
</head>
<body>
<% String ViewFrom=(String)request.getAttribute("ViewFrom") ;%>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">e Note External Preview</h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteDashBoard.htm"><i class="fa fa-envelope"></i>e Note </a></li>
						<%if(ViewFrom!=null && ViewFrom.equalsIgnoreCase("DakEnoteExternalList")){ %>
						<li class="breadcrumb-item"><a href="DakEnoteExternalList.htm"><i class="fa fa-envelope"></i> e Note External List </a></li>
						<%} %>
						<li class="breadcrumb-item active">e Note External Preview </li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	<%
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	Object[] EnotePreview=(Object[])request.getAttribute("EnotePreview"); 
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
	long EmpId=(Long)session.getAttribute("EmpId");
	Object[] RecommendingDetails=(Object[])request.getAttribute("RecommendingDetails");
	long AttachmentCount=(long)request.getAttribute("AttachmentCount");
	List<Object[]> AllReturnRemarks=(List<Object[]>)request.getAttribute("ReturnRemarks");
	List<Object[]> LabList=(List<Object[]>)request.getAttribute("LabList");
	Object[] WordDocumentData=(Object[])request.getAttribute("WordDocumentData"); 
	Object[] letterDocumentdata=(Object[])request.getAttribute("letterDocumentdata"); 
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
	<div class="col-md-12 row" id="formContainer">
	<div class="col-md-7" id="formCol" style="display: inline-block;" >
	<div class="page card dashboard-card" style="width: 95%; margin: auto;">
		<div class="card-body" align="center">
		<div  class="table-responsive">
		<table class="table table-bordered table-hover table-striped table-condensed"  style="width: 100%; height:55px; margin: auto;">
		<tbody>
		<tr>
		<td style="font-weight: 800; text-decoration: underline; background-color: #005C97; color: white; border-radius: 3px;"><span style="font-size: 20px; float: left;">Note No : <%if(EnotePreview[2]!=null){ %><%=EnotePreview[2].toString() %><%}else{ %>-<%} %></span><span style="font-size: 20px;">Status : <%if(EnotePreview[13]!=null){ %><%=EnotePreview[13].toString() %><%}else{ %>-<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC1")){ %>(<%if(RecommendingDetails[8]!=null){%><%=RecommendingDetails[8].toString()%>-<%}%><%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC2")){ %>(<%if(RecommendingDetails[9]!=null){%><%=RecommendingDetails[9].toString()%>-<%}%><%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC3")){ %>(<%if(RecommendingDetails[10]!=null){%><%=RecommendingDetails[10].toString()%>-<%}%><%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC4")){ %>(<%if(RecommendingDetails[11]!=null){%><%=RecommendingDetails[11].toString()%>-<%}%><%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("RC5")){ %>(<%if(RecommendingDetails[12]!=null){%><%=RecommendingDetails[12].toString()%>-<%}%><%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("EXT")){ %>(<%if(RecommendingDetails[13]!=null){%><%=RecommendingDetails[13].toString()%>-<%}%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(EnotePreview[26]!=null && EnotePreview[26].toString().equalsIgnoreCase("APR")){ %>(<%if(RecommendingDetails[14]!=null){%><%=RecommendingDetails[14].toString()%>-<%}%><%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %>-<%} %>)<%} %>
		</span><span style="font-size: 20px; float: right;">Note Id : <%if(EnotePreview[1]!=null){ %><%=EnotePreview[1].toString() %><%}else{ %>-<%} %></span></td>
		</tr>
		</tbody>
		</table>
		</div>
		
		<div class="row" style="margin-top: 10px;">
			<div class="col-md-3">
			<div class="form-group">
				<label class="control-label" style="float: left;">Ref No</label>
				<input type="text" class="form-control" id="RefNo" name="RefNo" readonly="readonly" style="color: blue;" value="<%if(EnotePreview[3]!=null){ %><%=EnotePreview[3].toString() %><%}else{ %>-<%} %>">
			</div> </div>
			
			
          <div class="col-md-4">
		  <div class="form-group">
			<label class="control-label" style="float: left;">Ref Date</label>
			<input type="text" class="form-control" id="RefDate" name="RefDate" readonly="readonly" style="color: blue;"  value="<%if(EnotePreview[4]!=null){ %><%=sdf.format(EnotePreview[4]) %><%}else{ %>-<%} %>">
			 </div> </div> 
			 
			 <div class="col-md-5">
			<div class="form-group">
		<label class="control-label" style="float: left;">Subject</label>
		<input type="text" class="form-control" id="Subject" name="Subject" readonly="readonly" style="color: blue;" value="<%if(EnotePreview[5]!=null){ %><%=EnotePreview[5].toString() %><%}else{ %>-<%} %>" maxlength="255">
		</div></div>
		</div>	
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Comment</label>
		<textarea rows="7" style="border-bottom-color: gray;width: 100%; color: blue; " maxlength="1000" placeholder="Maximum 1000 characters" id="Comment" readonly="readonly" name="Comment"><%if(EnotePreview[6]!=null){ %><%=EnotePreview[6].toString() %><%}else{ %>-<%} %></textarea>
		</div>
		</div>
		</div>
		<!-- <div class="row">
  	    </div> -->
	
		<%if(AllReturnRemarks!=null && AllReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:AllReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%> (RC1) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %> <%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC2) <%}%>:<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("EXT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(EXT) : <%} %>  &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("ERT")) {%><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %>(ERT) : <%} %>  &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(EnotePreview[15].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
		<div class="col-md-12">
		<div class="col-md-6" style="float: left!important; display: inline-block;">
		<%if(RecommendingDetails!=null){ %>
	<%if(RecommendingDetails[0]!=null ){ %>
   <span style="float: left;"><b>RC - 1 &nbsp;: &nbsp;</b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[0]!=null){%><%=RecommendingDetails[0].toString() %><%}else{ %>-<%} %></span><br><br>
   <%} %>
    <%if(RecommendingDetails[1]!=null) {%>
   <span style="float: left;"><b>RC - 2 &nbsp;: &nbsp;</b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[1]!=null){%><%=RecommendingDetails[1].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
    <%if(RecommendingDetails[2]!=null){%>
    <span style="float: left;"><b>RC - 3 &nbsp;: &nbsp;</b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[2]!=null){%><%=RecommendingDetails[2].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[3]!=null){%>
    <span style="float: left;"><b>RC - 4 &nbsp;: &nbsp;</b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[3]!=null){%><%=RecommendingDetails[3].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[4]!=null){%>
    <span style="float: left;"><b>RC - 5 &nbsp;: &nbsp;</b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[4]!=null){%><%=RecommendingDetails[4].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[5]!=null){%>
    <span style="float: left;"><b>EO &nbsp;: &nbsp;</b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[5]!=null){%><%=RecommendingDetails[5].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[6]!=null){%>
    <span style="float: left;"><b>AO &nbsp;: &nbsp;</b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[6]!=null){%><%=RecommendingDetails[6].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} %>
     <%if(RecommendingDetails[7]!=null){%>
    <span style="float: left;"><b>Initiated By &nbsp;:&nbsp;</b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(RecommendingDetails[7]!=null){%><%=RecommendingDetails[7].toString() %><%}else{ %>-<%} %></span><br><br>
    <%}} %>
 </div>
 <div class="col-md-6" style="float: left!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style="display: none; float: left !important; text-align: left;">
                <label><b>Document: </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	     </div>
           </div>
          </div>
          <form action="#" id="appform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <input type="hidden" form="appform" id=EnoteAttachmentIdforDelete name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="appform" id="enoteidfordelete" name="EnoteId" value="" />
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="ExternalEnotePreview">
  	     </form>
		</div>
		</div>
		<%if(EnotePreview[25]!=null && EnotePreview[25].toString().equalsIgnoreCase("EXT")) {%>
		<div align="center" > 
		<button type="button" class="btn btn-primary btn-sm submit" form="app-form"  onclick="return ExternalApprove()" >
		Recommend </button><br><br>
		<input type="hidden" form="app-form" id="eNoteId" name="eNoteId" value="<%=EnotePreview[0].toString() %>" >
			</div><br>
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

<!-- ---------------------------------------------------------------------------------------------- DakDetailed List ActionRequired Edit Modal Start --------------------------------------------------------->

 <div class="modal bd-example-modal-lg" id="exampleModalExternalApproval"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" style="min-width: 48%;">
 	    <div class="modal-content" style="height: 500px; width: 100%;">
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h6 class="modal-title" id="exampleModalLongTitle" style="color: white;"><span style="color: white;">External Approval </span></h6></div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      	<form action="EnoteForwardSubmit.htm"  method="post" id="EnoteExternalform">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      			<div class="row">&nbsp;&nbsp;
					<label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px; margin-left: 20px;"><b>Lab</b></label>
		         <select class="form-control selectpicker custom-selectEnoteLab" id="LabCode" name="LabCode" onchange="LabcodeSubmit()" data-live-search="true"  required="required">
		        <option value="Select" >Select</option>
				<%
				if (LabList != null && LabList.size() > 0) {
					for (Object[] obj : LabList) {
				%>
				<option value=<%=obj[2].toString()%> <% if(EnotePreview[24]!=null && EnotePreview[24].toString().equalsIgnoreCase(obj[2].toString())) { %>selected="selected"<% }%>><%=obj[2].toString()%></option>
				<%}}%>
				<option value="@EXP" <% if(EnotePreview[24]!=null && EnotePreview[24].toString().equalsIgnoreCase("@EXP")) { %>selected="selected"<%}%>>Expert</option>
				</select>&nbsp;&nbsp;
				<label class="control-label" style="display: inline-block; margin-left:30px; align-items: center; font-size: 15px;"><b>Role</b></label>
				<input class="form-control" type="text" style="width: 11%; margin-left:10px; display: inline-block;" id="ExtRole" name="ExtRole" value="<%if(EnotePreview!=null && EnotePreview[22]!=null){%><%=EnotePreview[22].toString() %><%}%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	      		 <label class="control-label" style="display: inline-block; align-items: center; font-size: 15px; margin-right: 80px; "><b>ExternalOfficer</b></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <select class="form-control selectpicker custom-selectEnoteExternalOfficer" id="ExternalOfficer" required="required" data-live-search="true" name="ApprovalExternalOfficer"  style="width: 50%;" >
				  </select>
  	      			</div><br><br>
  	      			<div class="row">&nbsp;&nbsp;
  	      			<div class="form-group">
  	      				<div class="row">
  	      					<div class="col-md-4" style="margin-left: 5px;">
  	      						<label class="control-label" >Approval Date</label>
			          			<input type="text" class="form-control" id="ApprovalDate" name="ApprovalDate">
  	      					</div>
  	      					<div class="col-md-7">
  	      						<label class="control-label"><b>Remarks :  &nbsp;&nbsp;</b></label>
  	      						<textarea rows="3" cols="60" maxlength="1000" name="remarks" id="Externalremarksarea"></textarea> 
  	      			 		</div>
  	      				</div>
      				</div>
      				</div><br><br>
      				<input type="hidden" name="Action" value="A">
      				<input type="hidden" name="RedirectName" value="External" >
      				<input type="hidden"  id="eNoteId" name="eNoteId" value="<%=EnotePreview[0].toString() %>" >
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return ExternalApprovalSubmit()" > 
  	      		  </div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>  
<!-- ---------------------------------------------------------------------------------------------- Dak Detailed List ActionRequired Edit Modal  End --------------------------------------------------------->
</div>
</div>
</div>
<div id="draftContainer" class="col-md-5" style="display: none;">
<div class="page card dashboard-card" >
<div class="card-body" align="center">
<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #114A86;height: 40px; padding: 5px;">
	Draft
</div>
<%if(WordDocumentData!=null && WordDocumentData[4]!=null && WordDocumentData[4].toString().equalsIgnoreCase("Y")){ %>
<jsp:include page="../static/LetterHead.jsp" />
<%} %>
<br>
<%if(WordDocumentData!=null){ %>
<table style="width: 100%; border-collapse: collapse; border: none;">
<tr style="border: none;">
<%if(WordDocumentData[0]!=null){%>
<td style="float: left;">RefNo : <%=WordDocumentData[0].toString()%></td>
<%} %>
<%if(WordDocumentData[1]!=null){%>
<td style="float: right;">Letter Date : <%=sdf.format(WordDocumentData[1]) %></td>
<%} %>
</tr>
<tr style="border: none;">
<%if(WordDocumentData[6]!=null && WordDocumentData[7]!=null && WordDocumentData[8]!=null && WordDocumentData[9]!=null){ %>
<td colspan="2"><br>
To,<br>
<%=WordDocumentData[6].toString()+"," %><br>
<%=WordDocumentData[7].toString()+"," %><br>
<%=WordDocumentData[8].toString()+"-"+WordDocumentData[9].toString()%><br>
</td>
<%} %>
</tr>
<tr style="border: none;">
<%if(WordDocumentData[2]!=null){ %>
<td colspan="2"><br>
<%="Subject : "+ WordDocumentData[2].toString()%><br><br>
</td>
<%} %>
</tr>
<tr style="border: none;">
<%if(WordDocumentData[3]!=null){ %>
<td colspan="2">
Dear Sir/Madam,<br><br>
<%=WordDocumentData[3].toString() %><br><br><br>
</td>
<%} %>
</tr>
<tr style="border: none;">
<%if(WordDocumentData[5]!=null){ %>
<td colspan="2" style="text-align: right;">
<%=WordDocumentData[5].toString() %>
</td>
<%} %>
</tr>
</table>
<%} %><br><br>
<%if(letterDocumentdata!=null){ %>
<form action="#">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<div class="letterWordDocument" style="width: 100%;">
<div class="row col-md-12">
  <div class="col-md-3" id="letterDocumentLabel"  style="text-align: left;">
  <label><b>Document : </b></label></div>
<div class="col-md-9" id="letterDoc"  style="display: inline-block; position: relative; float: left!important;  width: 100%;"> 
<div style="display: flex; align-items: left;">
<button type="submit" class="btn btn-sm replyAttachWithin-btn" name="LetterDocumentId"  id=<%="LetterDocument"+letterDocumentdata[2]%> value="<%=letterDocumentdata[2] %>"  formaction="LetterDocDownload.htm" formmethod="post" style="margin-right: 5px; flex: 1; color:blue;"><%=letterDocumentdata[1].toString() %></button>
</div><br>
</div>
 </div>
 </div>
 </form>
 <%}%>
</div>
</div>	
</div>
</div>
</body>
<script type="text/javascript">

document.addEventListener("DOMContentLoaded", function () {
	  const enoteValue = '<%=EnotePreview[30]%>'; // Replace this with your dynamic value: EnotePreview[30]

	  // Elements to manipulate
	  const formContainer = document.getElementById("formContainer");
	  const formCol = document.getElementById("formCol");
	  const draftContainer = document.getElementById("draftContainer");

	  // Logic to update classes and visibility
	  if (enoteValue === "Y") {
	    // For "Y", set formCol to col-md-7 and draftContainer to col-md-5, and make draftContainer visible
	    formCol.classList.remove("col-md-12");
	    formCol.classList.add("col-md-7");

	    draftContainer.style.display = "block"; // Show draftContainer
	    draftContainer.classList.remove("col-md-12");
	    draftContainer.classList.add("col-md-5");
	  } else if (enoteValue === "N") {
	    // For "N", set formCol to col-md-12 and hide draftContainer
	    formCol.classList.remove("col-md-7");
	    formCol.classList.add("col-md-12");

	    draftContainer.style.display = "none"; // Hide draftContainer
	    draftContainer.classList.remove("col-md-5");
	    draftContainer.classList.add("col-md-12");
	  } else {
	    console.error("Invalid EnotePreview value:", enoteValue);
	  }
	});
$('#ApprovalDate').daterangepicker({
	  singleDatePicker: true,
	  startDate: new Date(),
	  showDropdowns: true,
	  timePicker: true,
	  timePicker24Hour: true,
	  timePickerIncrement: 10,
	  autoUpdateInput: true,
	  locale: {
	    format: 'DD-MM-YYYY HH:mm:ss'
	  },
	});
/* $('#ApprovalDate').daterangepicker({
	"singleDatePicker" : true,
	"timePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY HH:mm:ss'
	}
}); */

function ExternalApprove() {
	$('#exampleModalExternalApproval').modal('show');
	
}

function ExternalApprovalSubmit() {
	var shouldSubmit = true;
	const form =document.getElementById('EnoteExternalform');
	var LabCode=$('#LabCode').val();
	var ExtRole=$('#ExtRole').val();
	var ExternalOfficer=$('#ExternalOfficer').val();
	var Externalremarksarea=$('#Externalremarksarea').val();
	
	if(LabCode==null || LabCode=== '' || LabCode===" " || typeof(LabCode)=='undefined' || LabCode==='Select'){
		alert("Please Select the LabCode ...!")
		$("#LabCode").focus();
		shouldSubmit=false;
	}else if (ExtRole==null || ExtRole==='' || ExtRole===" "){
		alert("Please Enter the External-Officer Role ...!")
		$("#ExtRole").focus();
		shouldSubmit=false;
	}else if(ExternalOfficer==null || ExternalOfficer==='' || ExternalOfficer===" " || typeof(ExternalOfficer)=='undefined' || ExternalOfficer=='Select'){
		alert("Please Select the External-Officer ...!")
		$("#ExternalOfficer").focus();
		shouldSubmit=false;
	}else if(Externalremarksarea==null || Externalremarksarea==='' || typeof(Externalremarksarea)=='undefined' || Externalremarksarea===" "){
		alert("Please Enter Remarks ...!")
		$("#Externalremarksarea").focus();
		shouldSubmit=false;
	}else{
		if(confirm('Are you Sure To Recommend ...?')){
			  form.submit();/*submit the form */
		}
	}
	
}
$(document).ready(function(){	
 	var Attachcount=<%=AttachmentCount%>;
 	<%if(EnotePreview!=null){%>
 	var EnoteId=<%=EnotePreview[0].toString()%>;
 	$('#eNoteDocumentLabel').css('display','none');
 	if(Attachcount>0){
 		$('.enoteDocuments').css('display','');
 	}
 	
 	$('.downloadDakMainReplyAttachTable').empty();
	var maindoclength=0;
    
 	var mainstr = '';
     $.ajax({
		
		type : "GET",
		url : "GetEnoteAttachmentDetails.htm",
		data : {
			
			EnoteId: EnoteId
			
		},
		datatype : 'json',
		success : function(result) {
		var result = JSON.parse(result);
		var consultVals= Object.keys(result).map(function(e){
	return result[e]
	})
	
		maindoclength=consultVals.length;
	for(var c=0;c<consultVals.length;c++)
	{
		var other = consultVals[c];
		
		 mainstr += '<div style="display: flex; align-items: left;">';
         mainstr += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply" style="margin-right: 5px; flex: 1; color:blue;" value="' + other[2] + '" onclick="Iframepdf(' + other[2] + ')" data-toggle="tooltip" data-placement="top" title="Download">' + other[3] + '</button>';
         mainstr += '    <button type="button" id="EnoteAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="EnoteAttachDelete.htm" formmethod="post" data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;" onclick="deleteEnoteEditAttach(' + other[2] + ',' + other[0] + ')"><img alt="attach" src="view/images/delete.png"></button>';
         mainstr += '</div><br>';
         console.log("maindoclength:"+maindoclength);
		   if(maindoclength>0){
				$('.downloadDakMainReplyAttachTable').html(mainstr);
				$('#eNoteDocumentLabel').css('display','block');
				$('#eNoteDocs').css('display','block');
			}else{
				$('#eNoteDocumentLabel').css('display','none');
				$('#eNoteDocs').css('display','none');
			}
           
	}
		}
     });
 	<%}%>
 });

function validateTextBox() {
    if (document.getElementById("remarksarea").value.trim() != "") {
    	return confirm('Are You Sure To Return?');
    	
    } else {
        alert("Please enter Remarks to Return");
        return false;
    }
}

function deleteEnoteEditAttach(eNoteAttachId,eNoteId){
	 $('#EnoteAttachmentIdforDelete').val(eNoteAttachId);
	 $('#enoteidfordelete').val(eNoteId);
	 
	 var result = confirm ("Are You sure to Delete ?"); 
	 if(result){
		 var formaction=$('#appform');
		 var button = $('#EnoteAttachDelete');
			var action = button.attr('formaction');
		 if(formaction){
			 formaction.attr('action', action);
			 formaction.submit();
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
			url : "getEnoteiframepdf.htm",
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

$(document).ready(function () {
	
	 var LabCode = document.getElementById("LabCode").value;
	 var SelectedValue=<%=EnotePreview[16]%>;
	 console.log("SelectedValue:"+SelectedValue);
	    $('#ExternalOfficer').empty();
	    $.ajax({
	        type: "GET",
	        url: "GetLabcodeEmpList.htm",
	        data: {
	        	LabCode: LabCode
	        },
	        dataType: 'json',
	        success: function(result) {
	            if (result != null && LabCode!='@EXP') {
	                for (var i = 0; i < result.length; i++) {
	                    var data = result[i];
	                    var optionValue = data[0];
	                    var optionText = data[1].trim() + ", " + data[3]; 
	                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                    $('#ExternalOfficer').append(option); 
	                    if(SelectedValue==optionValue){
	                     	 $('#ExternalOfficer option[value="' + optionValue + '"]').prop('selected', true);
	                     }
	                }
	                $('#ExternalOfficer').selectpicker('refresh');
	                }else{
	                	for (var i = 0; i < result.length; i++) {
	                        var data = result[i];
	                        var optionValue = data[0];
	                        var optionText = data[1].trim() + ", " + data[3]; 
	                        var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                        $('#ExternalOfficer').append(option); 
	                        if(SelectedValue==optionValue){
		                     	 $('#ExternalOfficer option[value="' + optionValue + '"]').prop('selected', true);
		                     }
	                    }
	                    $('#ExternalOfficer').selectpicker('refresh');
	                }
	            }
	    });
});
function LabcodeSubmit() {
   var LabCode = document.getElementById("LabCode").value;
   $('#ExternalOfficer').empty();
   $.ajax({
       type: "GET",
       url: "GetLabcodeEmpList.htm",
       data: {
       	LabCode: LabCode
       },
       dataType: 'json',
       success: function(result) {
           if (result != null && LabCode!='@EXP') {
               for (var i = 0; i < result.length; i++) {
                   var data = result[i];
                   var optionValue = data[0];
                   var optionText = data[1].trim() + ", " + data[3]; 
                   var option = $("<option></option>").attr("value", optionValue).text(optionText);
                   $('#ExternalOfficer').append(option); 
               }
               $('#ExternalOfficer').selectpicker('refresh');
               }else{
               	for (var i = 0; i < result.length; i++) {
                       var data = result[i];
                       var optionValue = data[0];
                       var optionText = data[1].trim() + ", " + data[3]; 
                       var option = $("<option></option>").attr("value", optionValue).text(optionText);
                       $('#ExternalOfficer').append(option); 
                   }
                   $('#ExternalOfficer').selectpicker('refresh');
               }
           }
   });
}
</script>
</html>