<%@page import="com.vts.dms.enote.model.DakEnoteReply"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>DAK E Note Preview</title>
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
 .custom-selectEnote {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 300px !important;
  float: left !important;
  left:40px;
 
}

.custom-selectEnoteSanction {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  float: left !important;
  left:40px;
  width: 300px !important;	
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
.custom-selectEnoteExternalOfficer{
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 280px !important;
  right: 85px;
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

.dropup .dropdown-toggle::after {
display: none;
}

.downloadDakMainReplyAttachTable {
  width: 350px;

}

.downloadDakMainReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}
.SkipApprovalRemarks{
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 170px !important;
}

.ChangeApprovalRemarks{
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 100px !important;
  
}

.ChangeRecOfficer{
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 160px !important;
}
#Reply {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            resize: none; /* Disable textarea resizing */
            overflow-y: hidden; /* Hide vertical scrollbar initially */
        }
</style>
</head>
<body>
<%String ViewFrom=(String)request.getAttribute("ViewFrom"); %>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">Dak e Note Preview</h5>
			</div>
			<div class="col-md-9 ">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb ">
						<li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
						<li class="breadcrumb-item"><a href="ENoteDashBoard.htm"><i class="fa fa-envelope"></i> e Note</a></li>
						<%if(ViewFrom!=null && ViewFrom.equalsIgnoreCase("EnoteList")){ %>
						<li class="breadcrumb-item"><a href="ENoteList.htm"><i class="fa fa-envelope"></i>e Note List</a></li>
						<%}else if(ViewFrom!=null && ViewFrom.equalsIgnoreCase("EnoteApprovalList")){ %>
						<li class="breadcrumb-item"><a href="EnoteApprovalList.htm"><i class="fa fa-envelope"></i> e Note ( Recommendation / Approval ) List </a></li>
						<%}else if(ViewFrom!=null && ViewFrom.equalsIgnoreCase("SkipApprovalList")){ %>
						<li class="breadcrumb-item"><a href="SkipApprovals.htm"><i class="fa fa-envelope"></i> Skip Approval List </a></li>
						<%} %>
						<li class="breadcrumb-item active">Dak e Note Preview </li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	
	<%
	String Username=(String)session.getAttribute("Username");
	String EnoteRoSoEdit=(String)request.getAttribute("EnoteRoSoEdit");
	long EmpId=(Long)session.getAttribute("EmpId");
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	Object[] DakEnotePreview=(Object[])request.getAttribute("DakEnotePreview"); 
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
	List<Object[]> RecommendingOfficerList=(List<Object[]>)request.getAttribute("RecommendingOfficerList");
	Object[] DakRecommendingDetails=(Object[])request.getAttribute("DakRecommendingDetails");
	long DakReplyAttachmentCount=(long)request.getAttribute("DakReplyAttachmentCount");
	String Approval=(String)request.getAttribute("Approval");
	String IntiatePreview=(String)request.getAttribute("IntiatePreview");
	Object[] EnoteRoSoRoledetails=(Object[])request.getAttribute("EnoteRoSoRoledetails");
	Object[] WordDocumentData=(Object[])request.getAttribute("WordDocumentData"); 
	Object[] letterDocumentdata=(Object[])request.getAttribute("letterDocumentdata");
	List<Object[]> DakENoteReplyReturnRemarks=(List<Object[]>)request.getAttribute("DakENoteReplyReturnRemarks");
	
	String preview=(String)request.getAttribute("preview");
	String SkipPreview=(String)request.getAttribute("SkipPreview");
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
	
	<div class="col-md-12 row" id="formContainer">
	<div class="col-md-7" id="formCol" style="display: inline-block;" >
	<div class="page card dashboard-card" style="width: 95%; margin: auto;">
		<div class="card-body" align="center">
		<div  class="table-responsive">
		<table class="table table-bordered table-hover table-striped table-condensed"  style="width: 100%; height:55px; margin: auto;">
		<tbody>
		<tr>
		<td style="font-weight: 800; text-decoration: underline; background-color: #005C97; color: white; border-radius: 3px;"><span style="font-size: 20px; float: left;">Note No : <%if(DakEnotePreview[2]!=null){ %><%=DakEnotePreview[2].toString() %><%}else{ %>-<%} %></span><span style="font-size: 20px;">eNote Status : <%if(DakEnotePreview[11]!=null){ %><%=DakEnotePreview[11].toString() %><%}else{ %>-<%} %>
		<%if(DakEnotePreview[21]!=null && DakEnotePreview[21].toString().equalsIgnoreCase("RC1")){ %>(<%if(DakRecommendingDetails[7]!=null){%><%=DakRecommendingDetails[7].toString()%>-<%}%><%if(DakRecommendingDetails[0]!=null){%><%=DakRecommendingDetails[0].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(DakEnotePreview[21]!=null && DakEnotePreview[21].toString().equalsIgnoreCase("RC2")){ %>(<%if(DakRecommendingDetails[8]!=null){%><%=DakRecommendingDetails[8].toString()%>-<%}%><%if(DakRecommendingDetails[1]!=null){%><%=DakRecommendingDetails[1].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(DakEnotePreview[21]!=null && DakEnotePreview[21].toString().equalsIgnoreCase("RC3")){ %>(<%if(DakRecommendingDetails[9]!=null){%><%=DakRecommendingDetails[9].toString()%>-<%}%><%if(DakRecommendingDetails[2]!=null){%><%=DakRecommendingDetails[2].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(DakEnotePreview[21]!=null && DakEnotePreview[21].toString().equalsIgnoreCase("RC4")){ %>(<%if(DakRecommendingDetails[10]!=null){%><%=DakRecommendingDetails[10].toString()%>-<%}%><%if(DakRecommendingDetails[3]!=null){%><%=DakRecommendingDetails[3].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(DakEnotePreview[21]!=null && DakEnotePreview[21].toString().equalsIgnoreCase("RC5")){ %>(<%if(DakRecommendingDetails[11]!=null){%><%=DakRecommendingDetails[11].toString()%>-<%}%><%if(DakRecommendingDetails[4]!=null){%><%=DakRecommendingDetails[4].toString() %><%}else{ %>-<%} %>)<%} %>
		<%if(DakEnotePreview[21]!=null && DakEnotePreview[21].toString().equalsIgnoreCase("APR")){ %>(<%if(DakRecommendingDetails[12]!=null){%><%=DakRecommendingDetails[12].toString()%>-<%}%><%if(DakRecommendingDetails[5]!=null){%><%=DakRecommendingDetails[5].toString() %><%}else{ %>-<%} %>)<%} %>
		
		</span><span style="font-size: 20px; float: right;">Dak Id : <%if(DakEnotePreview[25]!=null){ %><%=DakEnotePreview[25].toString() %><%}else{ %>-<%} %></span></td>
		</tr>
		</tbody>
		</table>
		</div>
		
		<div class="row" style="margin-top: 10px;">
			<div class="col-md-3">
			<div class="form-group">
				<label class="control-label" style="float: left;">Ref No</label>
				<input type="text" class="form-control" id="RefNo" name="RefNo" readonly="readonly" style="color: blue;" value="<%if(DakEnotePreview[3]!=null){ %><%=DakEnotePreview[3].toString() %><%}else{ %>-<%} %>">
			</div> </div>
			
			
          <div class="col-md-4">
		  <div class="form-group">
			<label class="control-label" style="float: left;">Ref Date</label>
			<input type="text" class="form-control" id="RefDate" name="RefDate" readonly="readonly" style="color: blue;"  value="<%if(DakEnotePreview[4]!=null){ %><%=sdf.format(DakEnotePreview[4]) %><%}else{ %>-<%} %>">
			 </div> </div> 
			 
			 <div class="col-md-5">
			<div class="form-group">
		<label class="control-label" style="float: left;">Subject</label>
		<input type="text" class="form-control" id="Subject" name="Subject" readonly="readonly" style="color: blue;" value="<%if(DakEnotePreview[28]!=null){ %><%=DakEnotePreview[28].toString() %><%}else{ %>-<%} %>" maxlength="255">
		</div></div>
		
		</div>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Reply</label>
		<textarea style=" color: blue; " maxlength="1000" placeholder="Maximum 1000 characters" id="Reply" readonly="readonly" name="Reply" oninput="autoResize()"><%if(DakEnotePreview[27]!=null){ %><%=DakEnotePreview[27].toString() %><%}else{ %>-<%} %></textarea>
		</div>
		</div>
		</div>
		<!-- <div class="row">
  	    </div> -->
	
		<%if(IntiatePreview!=null && IntiatePreview.equalsIgnoreCase("AddEdit")){ %>
		<div class="col-md-12">
		<form action="EnoteForwardSubmit.htm" method="POST" id="DakeNoteForm">	
		<div class="col-md-6" style="float: left!important;">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="DakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
	<input type="hidden" name="IntiatePreview" value="<%=IntiatePreview%>">
	<input type="hidden" name="EnoteRoSoId" value="<%if(DakEnotePreview[30]!=null){ %><%=DakEnotePreview[30].toString() %><%}%>">
	<input type="hidden" id="InitiatedByEmpId" name="InitiatedByEmpId" value="<%=DakEnotePreview[12].toString() %>" >
	<input type="hidden" id="EnoteRoSoEdit" name="EnoteRoSoEdit" value="<%if(EnoteRoSoEdit!=null){ %><%=EnoteRoSoEdit%><%} %>" >
	<span style="float: left;"><b>InitiatedBy :</b> <b style="color: blue;"><%if(DakEnotePreview[23]!=null){%><%=DakEnotePreview[23] %><%} %></b></span><br>
	<div class="row" style="width: 100%; margin-left: 80px;"><b>Role</b></div>
		<div class="row" >
		<div class="col-md-12">
  	      		 <label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px;"><b>RC - 1</b><span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
  	      		 <input class="form-control" type="text" style="width: 15%; float:left; margin-left: 10px;" id="Rec1Role" name="Rec1Role" value="<%if(DakEnotePreview[13]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[2]!=null){%><%=EnoteRoSoRoledetails[2].toString()%><%}else if(DakEnotePreview[13]!=null){%><%=DakEnotePreview[13].toString()%><%}%>">
			<select class="form-control selectpicker custom-selectEnote" id="RecommendingOfficer1" required="required" data-live-search="true" onchange="firstDropdownChange()" name="RecommendingOfficer1" style="width:50%; "  >
			  <option value="Select">Select</option>
			   <%if (RecommendingOfficerList != null && RecommendingOfficerList.size() > 0) {
				   for (Object[] obj : RecommendingOfficerList) {%>
				    <option value=<%=obj[0].toString()%> <%if(DakEnotePreview!=null && DakEnotePreview[5]!=null && DakEnotePreview[5].toString().equalsIgnoreCase(obj[0].toString()))  { %>selected="selected"<% }else if(DakEnotePreview[5]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[1]!=null && EnoteRoSoRoledetails[1].toString().equalsIgnoreCase(obj[0].toString())){ %>selected="selected"<%} %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
				   <%}}%>
				</select>	
		</div>
		</div>
		<div class="row tr_cloneRecommend2" style=" margin-top: 10px;">
		<div class="col-md-12">
  	      		 <label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px;"><b>RC - 2</b><span class="mandatory" style="color: white; font-weight: normal;">*</span></label>
  	      		 <input class="form-control" type="text" style="width: 15%; float:left; margin-left: 10px;" id="Rec2Role" name="Rec2Role" value="<%if(DakEnotePreview[14]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[4]!=null){%><%=EnoteRoSoRoledetails[4].toString()%><%}else if(DakEnotePreview[14]!=null){%><%=DakEnotePreview[14].toString()%><%}%>">
			<select class="form-control selectpicker custom-selectEnote" id="RecommendingOfficer2" required="required" data-live-search="true" name="RecommendingOfficer2" onchange="secondDropdownChange()"  style="width: 50%;">
			</select>
			<button type="button" class="tr_clone_subRecommend2 btn btn-sm " id="RecommendOfficer2"  data-toggle="tooltip" data-placement="top" title="Remove this RecommendOfficer2" style="margin-left: 115%; margin-top: -70px;"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button>
		</div>
		</div>
		<div class="row tr_cloneRecommend3" >
		<div class="col-md-12">
  	      		 <label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px;"><b>RC - 3</b><span class="mandatory" style="color: white; font-weight: normal;">*</span></label>
  	      		 <input class="form-control" type="text" style="width: 15%; float:left; margin-left: 10px;" id="Rec3Role" name="Rec3Role" value="<%if(DakEnotePreview[15]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[6]!=null){%><%=EnoteRoSoRoledetails[6].toString()%><%}else if(DakEnotePreview[15]!=null){%><%=DakEnotePreview[15].toString()%><%}%>">
			<select class="form-control selectpicker custom-selectEnote" id="RecommendingOfficer3" required="required" data-live-search="true" name="RecommendingOfficer3" onchange="thirdDropdownChange()" style="width: 50%;" >
			</select>
			<button type="button" class="tr_clone_subRecommend3 btn btn-sm " id="RecommendOfficer3"  data-toggle="tooltip" data-placement="top" title="Remove this RecommendOfficer3" style="margin-left:115%; margin-top: -70px;"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button>
		</div>
		</div>
		<br>
		<div class="row Sanctionofficerrow" >
		<div class="col-md-12">
  	      		 <label class="control-label" style="display: inline-block; float:left; align-items: center; font-size: 15px;"><b>AO</b><span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
  	      		 <input class="form-control" type="text" style="width: 15%; float:left; margin-left: 30px;" id="SancRole" name="SancRole" value="<%if(DakEnotePreview[18]==null && EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[14]!=null){%><%=EnoteRoSoRoledetails[14].toString()%><%}else if(DakEnotePreview[18]!=null){%><%=DakEnotePreview[18].toString()%><%}%>">
			<select class="form-control selectpicker custom-selectEnoteSanction"  id="SanctioningOfficer" required="required" data-live-search="true" name="SanctioningOfficer">
			</select>
		</div>
		</div><br>
		<%if(DakEnotePreview[21]!=null && !DakEnotePreview[21].toString().equalsIgnoreCase("INI") && IntiatePreview!=null && IntiatePreview.equalsIgnoreCase("AddEdit")) {%>
		<div align="left" style="margin-left: 5px;">
		   <b >Remarks :</b><br>
		   <textarea  form="DakeNoteForm" rows="3" cols="65" name="remarks" maxlength="1000"  id="forwardremarksarea"></textarea> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    </div>
	    <%} %>
		<div align="center">
		<%if(EmpId==Long.parseLong(DakEnotePreview[12].toString()) && forwardstatus.contains(DakEnotePreview[21].toString())) {%>
		 <button type="button" class="btn btn-primary btn-sm submit " id="Forward" name="Action" value="A" onclick="return EnoteForwardSubmit()">Forward</button>
		 <input type="hidden" name="RedirectName" value="forward">
		<%}else if(DakEnotePreview[22].toString().equalsIgnoreCase(Username)){ %>
		 <button type="button" class="btn btn-primary btn-sm submit " id="Forward" name="Action" value="A" onclick="return EnoteForwardSubmit()">Save</button>
		 <input type="hidden" name="save" value="save">
		 <input type="hidden" id="RedirectName" name="RedirectName" value="ActionSave">
		 <%} %>
		 <input type="hidden" name="Action" value="A">
		</div>
		</div>
		<div class="col-md-5" style="float: right!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents: </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	     </div>
           </div>
          </div>
		</div>
		</form>
		  <form action="#" id="appform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	   <!--   <input type="hidden" form="appform" id="enoteidfordelete" name="EnoteId" value="" /> -->
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="DakEnotePreview">
  	     <input type="hidden" form="appform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
  	      <input type="hidden" form="appform" id="IntiatePreview" name="IntiatePreview" value="<%=IntiatePreview%>">
  	     <input type="hidden"  form="appform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
  	     <input type="hidden"  form="appform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
  	     <input type="hidden" form="appform" name="ViewFrom"  value="<%=ViewFrom%>">
  	     </form>
  	     
  	      <form action="#" id="Markerappform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <input type="hidden" form="Markerappform" id="EnotemarkerdAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="Markerappform" id="enoteMarkeridfordelete" name="DakReplyId" value="" /> 
  	     <input type="hidden" form="Markerappform" id="redirval" name="redirval" value="DakEnotePreview">
  	     <input type="hidden" form="Markerappform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
  	      <input type="hidden" form="Markerappform" id="IntiatePreview" name="IntiatePreview" value="<%=IntiatePreview%>">
  	     <input type="hidden"  form="Markerappform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
  	     <input type="hidden"  form="Markerappform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
  	     </form>
		</div>
		<%} %>
		
		
		<%if(preview!=null && preview.equalsIgnoreCase("preview")){ %>
		<%if(DakENoteReplyReturnRemarks!=null && DakENoteReplyReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:DakENoteReplyReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC1)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC2)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
        <div class="row">
	    <div class="col-md-12">
		<div class="col-md-6" style="float: left!important;">
		<%if(DakRecommendingDetails!=null){ %>
	  <%if(DakRecommendingDetails[0]!=null){ %>
      <span style="float: left;"><b>RC - 1  &nbsp;: &nbsp;</b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[7]!=null){%><%=DakRecommendingDetails[7].toString()%>-<%}%><%if(DakRecommendingDetails[0]!=null){%><%=DakRecommendingDetails[0].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
      <%if(DakRecommendingDetails[1]!=null) {%>
     <span style="float: left;"><b>RC - 2   &nbsp;:&nbsp;  </b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[8]!=null){%><%=DakRecommendingDetails[8].toString()%>-<%}%><%if(DakRecommendingDetails[1]!=null){%><%=DakRecommendingDetails[1].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[2]!=null){%>
     <span style="float: left;"><b>RC - 3  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[9]!=null){%><%=DakRecommendingDetails[9].toString()%>-<%}%><%if(DakRecommendingDetails[2]!=null){%><%=DakRecommendingDetails[2].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[3]!=null){%>
     <span style="float: left;"><b>RC - 4  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[10]!=null){%><%=DakRecommendingDetails[10].toString()%>-<%}%><%if(DakRecommendingDetails[3]!=null){%><%=DakRecommendingDetails[3].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[4]!=null){%>
     <span style="float: left;"><b>RC - 5 &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[11]!=null){%><%=DakRecommendingDetails[11].toString()%>-<%}%><%if(DakRecommendingDetails[4]!=null){%><%=DakRecommendingDetails[4].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[5]!=null){%>
     <span style="float: left;"><b>AO   &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[12]!=null){%><%=DakRecommendingDetails[12].toString()%>-<%}%><%if(DakRecommendingDetails[5]!=null){%><%=DakRecommendingDetails[5].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[6]!=null){%>
     <span style="float: left;"><b>Initiated By  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[6]!=null){%><%=DakRecommendingDetails[6].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} }%>
		</div>
       <div class="col-md-6" style="float: left!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents:</b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	     </div>
           </div>
          </div>
          <form action="#" id="appform" method="post" enctype="multipart/form-data">
         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="appform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="DakEnotePreview">
  	     <input type="hidden" form="appform" id="preview" name="preview" value="<%=preview%>"> 
  	       <input type="hidden"  form="appform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
  	        <input type="hidden"  form="appform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
  	       <input type="hidden" form="appform" name="ViewFrom"  value="<%=ViewFrom%>">
  	     </form>
  	     
  	     <form action="#" id="Markerappform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <input type="hidden" form="Markerappform" id="EnotemarkerdAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="Markerappform" id="enoteMarkeridfordelete" name="DakReplyId" value="" /> 
  	     <input type="hidden" form="Markerappform" id="redirval" name="redirval" value="DakEnotePreview">
  	     <input type="hidden" form="Markerappform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
  	     <input type="hidden" form="Markerappform" id="preview" name="preview" value="<%=preview%>"> 
  	     <input type="hidden"  form="Markerappform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
  	     <input type="hidden"  form="Markerappform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
  	     <input type="hidden" form="Markerappform" name="ViewFrom"  value="<%=ViewFrom%>">
  	     </form>
		</div>
		</div>
		</div>
		<%if(DakEnotePreview[5]!=null && DakEnotePreview[21]!=null && EmpId==Long.parseLong(DakEnotePreview[12].toString()) && DakEnotePreview[21].toString().equalsIgnoreCase("INI")) {%>
			     <form action="#" method="post">
				 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				 <button type="submit" class="btn btn-primary btn-sm submit " id="" name="Action" value="A" formaction="EnoteForwardSubmit.htm" formmethod="post" onclick="return confirm('Are you sure to forward..?')">Forward</button>
		 		 <input type="hidden" name="RedirectName" value="forward">
		 		 <input type="hidden" id="DakeNoteIdsel" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
		 		 <input type="hidden" name="RecommendingOfficer1" value="<%if(DakEnotePreview[5]!=null) { %><%=DakEnotePreview[5]%><% } %>">
		 		 <input type="hidden" name="RecommendingOfficer2" value="<%if(DakEnotePreview[6]!=null) { %><%=DakEnotePreview[6]%><% } %>">
		 		 <input type="hidden" name="RecommendingOfficer3" value="<%if(DakEnotePreview[7]!=null) { %><%=DakEnotePreview[7]%><% } %>">
		 		 <input type="hidden" name="RecommendingOfficer4" value="<%if(DakEnotePreview[8]!=null) { %><%=DakEnotePreview[8]%><% } %>">
		 		 <input type="hidden" name="RecommendingOfficer5" value="<%if(DakEnotePreview[9]!=null)	{ %><%=DakEnotePreview[9]%><% } %>">
		 		 <input type="hidden" name="SanctioningOfficer"   value="<%if(DakEnotePreview[10]!=null){ %><%=DakEnotePreview[10]%><%} %>">
				 </form>
		 		 <%} %>
		<%} %>
		
		<%if(Approval!=null && Approval.equalsIgnoreCase("Y")) {%>
		<%if(DakENoteReplyReturnRemarks!=null && DakENoteReplyReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:DakENoteReplyReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC1)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC2)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
        <div class="row">
	    <div class="col-md-12">
		<div class="col-md-6" style="float: left!important;">
		<%if(DakRecommendingDetails!=null){ %>
	  <%if(DakRecommendingDetails[0]!=null){ %>
      <span style="float: left;"><b>RC - 1  &nbsp;: &nbsp;</b></span> &nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[7]!=null){%><%=DakRecommendingDetails[7].toString()%>-<%}%><%if(DakRecommendingDetails[0]!=null){%><%=DakRecommendingDetails[0].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
      <%if(DakRecommendingDetails[1]!=null) {%>
     <span style="float: left;"><b>RC - 2   &nbsp;:&nbsp;  </b></span> &nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[8]!=null){%><%=DakRecommendingDetails[8].toString()%>-<%}%><%if(DakRecommendingDetails[1]!=null){%><%=DakRecommendingDetails[1].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[2]!=null){%>
     <span style="float: left;"><b>RC - 3  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[9]!=null){%><%=DakRecommendingDetails[9].toString()%>-<%}%><%if(DakRecommendingDetails[2]!=null){%><%=DakRecommendingDetails[2].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[3]!=null){%>
     <span style="float: left;"><b>RC - 4  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[10]!=null){%><%=DakRecommendingDetails[10].toString()%>-<%}%><%if(DakRecommendingDetails[3]!=null){%><%=DakRecommendingDetails[3].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[4]!=null){%>
     <span style="float: left;"><b>RC - 5  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[11]!=null){%><%=DakRecommendingDetails[11].toString()%>-<%}%><%if(DakRecommendingDetails[4]!=null){%><%=DakRecommendingDetails[4].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[5]!=null){%>
     <span style="float: left;"><b>AO  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[12]!=null){%><%=DakRecommendingDetails[12].toString()%>-<%}%><%if(DakRecommendingDetails[5]!=null){%><%=DakRecommendingDetails[5].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[6]!=null){%>
     <span style="float: left;"><b>Initiated By  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[6]!=null){%><%=DakRecommendingDetails[6].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} }%>
		</div>
       <div class="col-md-6" style="float: left!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents : </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important;  width: 100%;"> 
	  	     </div>
           </div>
          </div>
          <form action="#" id="appform" method="post" enctype="multipart/form-data">
		          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		          <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
		 	      <input type="hidden" form="appform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
		 	      <input type="hidden" form="appform" id="redirval" name="redirval" value="DakEnotePreview">
		 	      <input type="hidden"  form="appform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
		 	      <input type="hidden"  form="appform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
		 	      <input type="hidden" form="appform" name="ViewFrom"  value="<%=ViewFrom%>">
		 	      <input type="hidden" form="appform" id="Approval" name="Approval" value="<%=Approval%>"> 
  	     </form>
  	     
  	      <form action="#" id="Markerappform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		          <input type="hidden" form="Markerappform" id="EnotemarkerdAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
		  	      <input type="hidden" form="Markerappform" id="enoteMarkeridfordelete" name="DakReplyId" value="" /> 
		  	      <input type="hidden" form="Markerappform" id="redirval" name="redirval" value="DakEnotePreview">
		  	      <input type="hidden" form="Markerappform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
		  	      <input type="hidden" form="Markerappform" id="Approval" name="Approval" value="<%=Approval%>"> 
		  	      <input type="hidden" form="Markerappform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
		  	      <input type="hidden" form="Markerappform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
		  	      <input type="hidden" form="Markerappform" name="ViewFrom"  value="<%=ViewFrom%>">
  	      </form>
		</div>
	 </div>
  </div>
		<form action="#" method="post" id="app-form">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
		<div align="left" style="margin-left: 5px;">
		   <label ><b>Remarks :</b></label><br>
		   <textarea form="app-form" rows="3" cols="65" maxlength="1000" name="remarks" id="remarksarea"></textarea> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    </div>
		<div align="center">
		<%if(DakEnotePreview!=null && DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("APR")){%>
		<button type="submit" class="btn btn-primary btn-sm submit" form="app-form" formaction="EnoteForwardSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" >
		Approve 
		</button>
		<input type="hidden" name="Approve" form="app-form" value="Approve">
		<%}else{ %>
		<button type="submit" class="btn btn-primary btn-sm submit" form="app-form" formaction="EnoteForwardSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" >
		Recommend
		</button>
		<%} %>
		<input type="hidden" name="RedirectName" form="app-form" value="Recommend">
		<button type="submit" class="btn btn-sm btn-danger" form="app-form" name="Action" formaction="EnoteForwardSubmit.htm" value="R" onclick="return validateTextBox();">
		Return
		</button>
		</div>
		<input type="hidden" form="app-form" id="eNoteId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
		<%} %>
		
		
		<%if(Approval!=null && Approval.equalsIgnoreCase("N")) {%>
		<%if(DakENoteReplyReturnRemarks!=null && DakENoteReplyReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:DakENoteReplyReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC1)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC2)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
        <div class="row">
	    <div class="col-md-12">
		<div class="col-md-6" style="float: left!important;">
		<%if(DakRecommendingDetails!=null){ %>
	  <%if(DakRecommendingDetails[0]!=null){ %>
      <span style="float: left;"><b>RC - 1  &nbsp;:&nbsp;</b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[7]!=null){%><%=DakRecommendingDetails[7].toString()%>-<%}%><%if(DakRecommendingDetails[0]!=null){%><%=DakRecommendingDetails[0].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
      <%if(DakRecommendingDetails[1]!=null) {%>
     <span style="float: left;"><b>RC - 2   &nbsp;:&nbsp;  </b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[8]!=null){%><%=DakRecommendingDetails[8].toString()%>-<%}%><%if(DakRecommendingDetails[1]!=null){%><%=DakRecommendingDetails[1].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[2]!=null){%>
     <span style="float: left;"><b>RC - 3  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[9]!=null){%><%=DakRecommendingDetails[9].toString()%>-<%}%><%if(DakRecommendingDetails[2]!=null){%><%=DakRecommendingDetails[2].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[3]!=null){%>
     <span style="float: left;"><b>RC - 4  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[10]!=null){%><%=DakRecommendingDetails[10].toString()%>-<%}%><%if(DakRecommendingDetails[3]!=null){%><%=DakRecommendingDetails[3].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[4]!=null){%>
     <span style="float: left;"><b>RC - 5  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[11]!=null){%><%=DakRecommendingDetails[11].toString()%>-<%}%><%if(DakRecommendingDetails[4]!=null){%><%=DakRecommendingDetails[4].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[5]!=null){%>
     <span style="float: left;"><b>AO  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[12]!=null){%><%=DakRecommendingDetails[12].toString()%>-<%}%><%if(DakRecommendingDetails[5]!=null){%><%=DakRecommendingDetails[5].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[6]!=null){%>
     <span style="float: left;"><b>Initiated By  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[6]!=null){%><%=DakRecommendingDetails[6].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} }%>
		</div>
       <div class="col-md-6" style="float: left!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents : </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	     </div>
           </div>
          </div>
          <form action="#" id="appform" method="post" enctype="multipart/form-data">
         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="appform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="DakEnotePreview">
  	       <input type="hidden"  form="appform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
  	        <input type="hidden"  form="appform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
  	       <input type="hidden" form="appform" name="ViewFrom"  value="<%=ViewFrom%>">
  	        <input type="hidden" form="appform" id="Approval" name="Approval" value="<%=Approval%>"> 
  	     </form>
  	     
  	      <form action="#" id="Markerappform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <input type="hidden" form="Markerappform" id="EnotemarkerdAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="Markerappform" id="enoteMarkeridfordelete" name="DakReplyId" value="" /> 
  	     <input type="hidden" form="Markerappform" id="redirval" name="redirval" value="DakEnotePreview">
  	     <input type="hidden" form="Markerappform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
  	     <input type="hidden" form="Markerappform" id="Approval" name="Approval" value="<%=Approval%>"> 
  	     <input type="hidden"  form="Markerappform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
  	     <input type="hidden"  form="Markerappform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
  	     <input type="hidden" form="Markerappform" name="ViewFrom"  value="<%=ViewFrom%>">
  	     </form>
  	     
		</div>
		<input type="hidden" form="app-form" id="eNoteId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
		</div>
		</div>
		<%} %>
		
		<%if(SkipPreview!=null && SkipPreview.equalsIgnoreCase("SkipPreview")){ %>
		<%if(DakENoteReplyReturnRemarks!=null && DakENoteReplyReturnRemarks.size()>0){%>
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
			<label class="control-label" style="float: left;">Remarks  :  </label>
			<%for(Object[] obj:DakENoteReplyReturnRemarks){%>
			<textarea rows="2" style="border-bottom-color: gray;width: 100%; color: blue;" maxlength="1000" placeholder="Maximum 1000 characters" id="ReturnRemarks" readonly="readonly" name="ReturnRemarks"><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC1)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC2)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}}%><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC3)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC4)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RC5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RC5)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("APR")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(APR)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR1")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR1)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR2")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR2)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR3")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR3)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR4")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR4)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RR5")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RR5)<%} %> : <%} %>&nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %><%if(obj[1]!=null && obj[1].toString().equalsIgnoreCase("RAP")) {%><%if(obj[0]!=null){%><%=obj[0].toString() %><%if(EmpId!=Long.parseLong(DakEnotePreview[12].toString())){%>(RAP)<%} %> :<%} %> &nbsp; <%if(obj[2]!=null){%><%=obj[2].toString() %><%}} %></textarea><%}%>
			</div>
		</div>
		</div>
			<%} %>
        <div class="row">
	    <div class="col-md-12">
		<div class="col-md-6" style="float: left!important;">
		<%if(DakRecommendingDetails!=null){ %>
	  <%if(DakRecommendingDetails[0]!=null){ %>
      <span style="float: left;"><b>RC - 1  &nbsp;: &nbsp;</b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[7]!=null){%><%=DakRecommendingDetails[7].toString()%>-<%}%><%if(DakRecommendingDetails[0]!=null){%><%=DakRecommendingDetails[0].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
      <%if(DakRecommendingDetails[1]!=null) {%>
     <span style="float: left;"><b>RC - 2   &nbsp;:&nbsp;  </b></span> &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[8]!=null){%><%=DakRecommendingDetails[8].toString()%>-<%}%><%if(DakRecommendingDetails[1]!=null){%><%=DakRecommendingDetails[1].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[2]!=null){%>
     <span style="float: left;"><b>RC - 3  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[9]!=null){%><%=DakRecommendingDetails[9].toString()%>-<%}%><%if(DakRecommendingDetails[2]!=null){%><%=DakRecommendingDetails[2].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[3]!=null){%>
     <span style="float: left;"><b>RC - 4  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[10]!=null){%><%=DakRecommendingDetails[10].toString()%>-<%}%><%if(DakRecommendingDetails[3]!=null){%><%=DakRecommendingDetails[3].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[4]!=null){%>
     <span style="float: left;"><b>RC - 5  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[11]!=null){%><%=DakRecommendingDetails[11].toString()%>-<%}%><%if(DakRecommendingDetails[4]!=null){%><%=DakRecommendingDetails[4].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[5]!=null){%>
     <span style="float: left;"><b>AO  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[12]!=null){%><%=DakRecommendingDetails[12].toString()%>-<%}%><%if(DakRecommendingDetails[5]!=null){%><%=DakRecommendingDetails[5].toString() %><%}else{ %>-<%} %></span><br><br>
     <%} %>
     <%if(DakRecommendingDetails[6]!=null){%>
     <span style="float: left;"><b>Initiated By  &nbsp;:&nbsp;  </b></span>&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: blue; float: left; margin-top: 3px;"><%if(DakRecommendingDetails[6]!=null){%><%=DakRecommendingDetails[6].toString() %><%}else{ %>-<%} %></span><br><br>
    <%} }%>
		</div>
       <div class="col-md-6" style="float: left!important;">
		<div class="enoteDocuments" style="width: 100%;">
           <div class="row col-md-12">
             <div class="col-md-4" id="eNoteDocumentLabel"  style=" display: none; float: left !important; text-align: left;">
                <label><b>Documents : </b></label></div>&nbsp;
              <div class="col-md-8 downloadDakMainReplyAttachTable" id="eNoteDocs"  style="display: inline-block; position: relative; float: left!important;width: 100%;"> 
	  	     </div>
           </div>
          </div>
          <form action="#" id="appform" method="post" enctype="multipart/form-data">
         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <input type="hidden" form="appform" id="EnoteAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="appform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
  	     <input type="hidden" form="appform" id="redirval" name="redirval" value="DakEnotePreview">
  	       <input type="hidden"  form="appform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
  	        <input type="hidden"  form="appform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
  	       <input type="hidden" form="appform" name="ViewFrom"  value="<%=ViewFrom%>">
  	       <input type="hidden" form="appform" id="SkipPreview" name="SkipPreview" value="<%=SkipPreview%>">
  	     </form>
  	     
  	      <form action="#" id="Markerappform" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <input type="hidden" form="Markerappform" id="EnotemarkerdAttachmentIdforDelete" name="EnoteAttachmentIdforDelete" value="" />
  	     <input type="hidden" form="Markerappform" id="enoteMarkeridfordelete" name="DakReplyId" value="" /> 
  	     <input type="hidden" form="Markerappform" id="redirval" name="redirval" value="DakEnotePreview">
  	     <input type="hidden" form="Markerappform" id="DakAssignReplyId" name="DakAssignReplyId" value="<%=DakEnotePreview[26].toString() %>" />
  	     <input type="hidden" form="Markerappform" id="SkipPreview" name="SkipPreview" value="<%=SkipPreview%>"> 
  	     <input type="hidden"  form="Markerappform" id="PreviewDakEnoteReplyId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
  	     <input type="hidden"  form="Markerappform" id="DakId" name="DakId" value="<%=DakEnotePreview[24].toString() %>" >
  	     <input type="hidden" form="Markerappform" name="ViewFrom"  value="<%=ViewFrom%>">
  	     </form>
  	     
  	     <form action="#" id="SkipApproval"></form>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div align="left" class="row" >
		<div class="col-md-3" > 
		<input type="radio" name="SkipChange" value="skip" checked="checked"> Skip <br>
		<input type="radio" name="SkipChange" value="change"> Change
		</div>
		<div align="left" class="col-md-9" > 
		<div id="enoteskip" class="SkipChange">
		<select class="form-control selectpicker SkipApprovalRemarks" form="SkipApproval" id="SkipApprovalRemarks" required="required" data-live-search="true" name="remarks" >
			<option value="Select">Reason</option> 
			<option value="ON TD">ON TD</option>
			<option value="ON LEAVE">ON LEAVE</option>
		</select>
		<button type="submit" class="btn btn-primary btn-sm submit" form="SkipApproval" style="margin-left:10px;" id="skip" formaction="EnoteForwardSubmit.htm" name="Action" 
		value="A" onclick="return SkipApprovalSubmit()" > Skip </button><br><br>
		<span style="color: blue;">
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC1")){ %>for( <%if(DakRecommendingDetails[7]!=null){%><%=DakRecommendingDetails[7].toString()%> - <%}%>
		<%if(DakRecommendingDetails[0]!=null){%><%=DakRecommendingDetails[0].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[7]!=null){%><%="Skipped because "+DakRecommendingDetails[7].toString()%> - <%}%><%if(DakRecommendingDetails[0]!=null){%><%=DakRecommendingDetails[0].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC2")){ %>for( <%if(DakRecommendingDetails[8]!=null){%><%=DakRecommendingDetails[8].toString()%> - <%}%>
		<%if(DakRecommendingDetails[1]!=null){%><%=DakRecommendingDetails[1].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[8]!=null){%><%="Skipped because "+DakRecommendingDetails[8].toString()%> - <%}%><%if(DakRecommendingDetails[1]!=null){%><%=DakRecommendingDetails[1].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC3")){ %>for( <%if(DakRecommendingDetails[9]!=null){%><%=DakRecommendingDetails[9].toString()%> - <%}%>
		<%if(DakRecommendingDetails[2]!=null){%><%=DakRecommendingDetails[2].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[9]!=null){%><%="Skipped because "+DakRecommendingDetails[9].toString()%> - <%}%><%if(DakRecommendingDetails[2]!=null){%><%=DakRecommendingDetails[2].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC4")){ %>for( <%if(DakRecommendingDetails[10]!=null){%><%=DakRecommendingDetails[10].toString()%> - <%}%>
		<%if(DakRecommendingDetails[3]!=null){%><%=DakRecommendingDetails[3].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[10]!=null){%><%="Skipped because "+DakRecommendingDetails[10].toString()%> - <%}%><%if(DakRecommendingDetails[3]!=null){%><%=DakRecommendingDetails[3].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC5")){ %>for( <%if(DakRecommendingDetails[11]!=null){%><%=DakRecommendingDetails[11].toString()%> - <%}%>
		<%if(DakRecommendingDetails[4]!=null){%><%=DakRecommendingDetails[4].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[11]!=null){%><%="Skipped because "+DakRecommendingDetails[11].toString()%> - <%}%><%if(DakRecommendingDetails[4]!=null){%><%=DakRecommendingDetails[4].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("APR")){ %>for( <%if(DakRecommendingDetails[12]!=null){%><%=DakRecommendingDetails[12].toString()%> - <%}%>
		<%if(DakRecommendingDetails[5]!=null){%><%=DakRecommendingDetails[5].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="SkipApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[12]!=null){%><%="Skipped because "+DakRecommendingDetails[12].toString()%> - <%}%><%if(DakRecommendingDetails[5]!=null){%><%=DakRecommendingDetails[5].toString() %><%}else{ %>-<%} %>"><%} %></span>
		</div>
		<form action="#" id="ChangeApproval"></form>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div id="enotechange" class="SkipChange">
		<label class="control-label" style="float: left;"><b>Officer  </b></label>&nbsp;&nbsp;
		<select class="form-control selectpicker ChangeRecOfficer" form="ChangeApproval" id="ChangeRecOfficer" required="required" data-live-search="true" name="ChangeRecOfficer" >
		</select>
		<select class="form-control selectpicker ChangeApprovalRemarks" form="ChangeApproval" id="ChangeApprovalRemarks" required="required" data-live-search="true" name="ChangeApprovalRemarks" >
			<option value="Select">Reason</option> 
			<option value="ON TD">ON TD</option>
			<option value="ON LEAVE">ON LEAVE</option>
		</select><br><br>
		<label class="control-label" style="float: left;"><b>Role  </b></label>
		<input class="form-control" type="text" style="width: 39%; margin-left:30px; display: inline-block;" form="ChangeApproval" id="RecommendRole" name="RecommendRole">&nbsp;&nbsp; 
		<button type="submit" class="btn btn-primary btn-sm submit" form="ChangeApproval"  id="ChangeRec" formaction="ChangeRecommendOfficer.htm"
		 onclick="return ChangeRecommendingOfficer()" > Change </button>
		 <span style="color: blue;">
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC1")){ %>for( <%if(DakRecommendingDetails[7]!=null){%><%=DakRecommendingDetails[7].toString()%> - <%}%>
		<%if(DakRecommendingDetails[0]!=null){%><%=DakRecommendingDetails[0].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[7]!=null){%><%="Changed because "+DakRecommendingDetails[7].toString()%> - <%}%><%if(DakRecommendingDetails[0]!=null){%><%=DakRecommendingDetails[0].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC2")){ %>for( <%if(DakRecommendingDetails[7]!=null){%><%=DakRecommendingDetails[8].toString()%> - <%}%>
		<%if(DakRecommendingDetails[1]!=null){%><%=DakRecommendingDetails[1].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[8]!=null){%><%="Changed because "+DakRecommendingDetails[8].toString()%> - <%}%><%if(DakRecommendingDetails[1]!=null){%><%=DakRecommendingDetails[1].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC3")){ %>for( <%if(DakRecommendingDetails[9]!=null){%><%=DakRecommendingDetails[9].toString()%> - <%}%>
		<%if(DakRecommendingDetails[2]!=null){%><%=DakRecommendingDetails[2].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[9]!=null){%><%="Changed because "+DakRecommendingDetails[9].toString()%> - <%}%><%if(DakRecommendingDetails[2]!=null){%><%=DakRecommendingDetails[2].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC4")){ %>for( <%if(DakRecommendingDetails[10]!=null){%><%=DakRecommendingDetails[10].toString()%> - <%}%>
		<%if(DakRecommendingDetails[3]!=null){%><%=DakRecommendingDetails[3].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[10]!=null){%><%="Changed because "+DakRecommendingDetails[10].toString()%> - <%}%><%if(DakRecommendingDetails[3]!=null){%><%=DakRecommendingDetails[3].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("RC5")){ %>for( <%if(DakRecommendingDetails[11]!=null){%><%=DakRecommendingDetails[11].toString()%> - <%}%>
		<%if(DakRecommendingDetails[4]!=null){%><%=DakRecommendingDetails[4].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[11]!=null){%><%="Changed because "+DakRecommendingDetails[11].toString()%> - <%}%><%if(DakRecommendingDetails[4]!=null){%><%=DakRecommendingDetails[4].toString() %><%}else{ %>-<%} %>"><%} %>
		<%if(DakEnotePreview[20]!=null && DakEnotePreview[20].toString().equalsIgnoreCase("APR")){ %>for( <%if(DakRecommendingDetails[12]!=null){%><%=DakRecommendingDetails[12].toString()%> - <%}%>
		<%if(DakRecommendingDetails[5]!=null){%><%=DakRecommendingDetails[5].toString() %><%}else{ %> - <%} %> )<input type="hidden" form="ChangeApproval" name="SkipApproval" 
		value="<%if(DakRecommendingDetails[12]!=null){%><%="Changed because "+DakRecommendingDetails[12].toString()%> - <%}%><%if(DakRecommendingDetails[5]!=null){%><%=DakRecommendingDetails[5].toString() %><%}else{ %>-<%} %>"><%} %></span>
		</div>
		</div>
		</div>
				<input type="hidden" form="ChangeApproval" id="StatusCodeNext" name="StatusCodeNext" >
				<input type="hidden" form="ChangeApproval" id="ChangeStatusCode" name="ChangeStatusCode" >
				<input type="hidden" form="ChangeApproval" id="eNoteIdChangeId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
				<input type="hidden" form="ChangeApproval" id="redirval" name="redirval" value="DakEnotePreview">
				<input type="hidden" form="ChangeApproval" id="SkipPreview" name="SkipPreview" value="<%=SkipPreview%>">
				<input type="hidden" form="ChangeApproval" name="ViewFrom"  value="<%=ViewFrom%>">
				<input type="hidden" form="SkipApproval" name="ViewFrom"  value="<%=ViewFrom%>">
				<input type="hidden" form="SkipApproval" id="eNoteId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
				<input type="hidden" form="SkipApproval" name="RedirectName"  value="SkipPreview">
				<input type="hidden" form="SkipApproval" id="SkipPreview" name="SkipPreview" value="<%=SkipPreview%>">
				<input type="hidden" form="SkipApproval" id="redirval" name="redirval" value="DakEnotePreview">
		</div>
		<input type="hidden" form="app-form" id="eNoteId" name="eNoteId" value="<%=DakEnotePreview[0].toString() %>" >
		</div>
		</div>
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
 <%} %>
</div>
</div>	
</div>
</div>
</body>

<script>
document.addEventListener("DOMContentLoaded", function () {
	  const enoteValue = '<%=DakEnotePreview[31]%>'; // Replace this with your dynamic value: EnotePreview[30]

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
	
$(document).ready(function(){ 
	$('#enotechange').hide();
	 $("input[name$='SkipChange']").click(function() {
	        var test = $(this).val();
	        $("div.SkipChange").hide();
	        $("#enote" + test).show();
	    });
});
var status='<%=DakEnotePreview[21]%>';
if(status !==null && status !=='INI'){
	$('#forwardremarksarea').prop('disabled',false);
}else{
	$('#forwardremarksarea').prop('disabled',true);
}

var StatusCodeNext='<%=DakEnotePreview[20]%>';
var StatusCode='<%=DakEnotePreview[21]%>';
$('#StatusCodeNext').val(StatusCodeNext);
$('#ChangeStatusCode').val(StatusCode);
var EmpId=null;
var role=null;
if(StatusCodeNext==='RC1'){
	EmpId='<%=DakEnotePreview[5]%>';
	role='<%if(DakEnotePreview[13]!=null){%><%=DakEnotePreview[13]%><%}%>';
}else if(StatusCodeNext==='RC2'){
	EmpId='<%=DakEnotePreview[6]%>';
	role='<%if(DakEnotePreview[14]!=null){%><%=DakEnotePreview[14]%><%}%>';
}else if(StatusCodeNext==='RC3'){
	EmpId='<%=DakEnotePreview[7]%>';
	role='<%if(DakEnotePreview[15]!=null){%><%=DakEnotePreview[15]%><%}%>';
}else if(StatusCodeNext==='RC4'){
	EmpId='<%=DakEnotePreview[8]%>';
	role='<%if(DakEnotePreview[16]!=null){%><%=DakEnotePreview[16]%><%}%>';
}else if(StatusCodeNext==='RC5'){
	EmpId='<%=DakEnotePreview[9]%>';
	role='<%if(DakEnotePreview[17]!=null){%><%=DakEnotePreview[17]%><%}%>';
}else if(StatusCodeNext==='APR'){
	EmpId='<%=DakEnotePreview[10]%>';
	role='<%if(DakEnotePreview[18]!=null){%><%=DakEnotePreview[18]%><%}%>';
}
$('#RecommendRole').val(role);
$.ajax({
    type: "GET",
    url: "GetChangeRecommendingOfficer.htm",
    data: {
    	EmpId: EmpId
    },
    dataType: 'json',
    success: function(result) {
        if (result != null) {
        	 var consultVals = Object.values(result); // Use Object.values() to get the values of the object
        	 $('#ChangeRecOfficer').empty();
             for (var c = 0; c < consultVals.length; c++) {
            	var optionValue = consultVals[c][0];
     	        var optionText = consultVals[c][1].trim() + ', ' + consultVals[c][2];
     	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
     	       if(EmpId==consultVals[c][0]){
		             option.prop('selected', true);
		          }
     	       $('#ChangeRecOfficer').append(option);
           }
             $
             // Refresh the selectpicker after appending options
             $('#ChangeRecOfficer').selectpicker('refresh');
        }
    }
}); 


$(".tr_cloneRecommend2").on('click', '.tr_clone_subRecommend2', function() {
    var cl = $('.tr_cloneRecommend3').length;
    console.log("lenght:"+cl);
    if (cl == 0) {
        var $tr = $(this).closest('.tr_cloneRecommend2');
        $tr.remove();
        $('#RecommendingOfficer2').prop("disabled",true);
        $('#Rec2Role').prop("disabled", true);
    }
});

$(".tr_cloneRecommend3").on('click', '.tr_clone_subRecommend3', function() {
    var cl = $('.tr_cloneRecommend3').length;
    if (cl > 0) {
        var $tr = $(this).closest('.tr_cloneRecommend3');
        $tr.remove();
        $('#RecommendingOfficer3').prop("disabled",true);
        $('#Rec3Role').prop("disabled", true);
        
    }
});

function EnoteForwardSubmit() {
	var shouldSubmit = true;
	const form =document.getElementById('DakeNoteForm');
	var RecommendingOfficer1=$('#RecommendingOfficer1').val();
	var RecommendingOfficer2=$('#RecommendingOfficer2').val();
	var RecommendingOfficer3=$('#RecommendingOfficer3').val();
	var SanctioningOfficer=$('#SanctioningOfficer').val();
	var Rec1Role=$('#Rec1Role').val();
	var Rec2Role=$('#Rec2Role').val();
	var Rec3Role=$('#Rec3Role').val();
	var SancRole=$('#SancRole').val();
	var ActionSave=$('#RedirectName').val();
	var forwardremarksarea=$('#forwardremarksarea').val();
	
	if(RecommendingOfficer1==null || RecommendingOfficer1==='' || RecommendingOfficer1==="" || typeof(RecommendingOfficer1)=='undefined' ||RecommendingOfficer1==='Select'){
		alert("Please Select the Recommending Officer1..!");
		  $("#RecommendingOfficer1").focus();
		  shouldSubmit = false;
	}else if(RecommendingOfficer3==='' || RecommendingOfficer3==="" || RecommendingOfficer3==='Select'){
		alert("Please Select the Recommending Officer3 Or Remove the Recommending Officer3..!");
		  $("#RecommendingOfficer3").focus();
		  shouldSubmit = false;	
	}else if(RecommendingOfficer2==='' || RecommendingOfficer2==="" || RecommendingOfficer2==='Select'){
		alert("Please Select the Recommending Officer2 Or Remove the Recommending Officer2..!");
		  $("#RecommendingOfficer2").focus();
		  shouldSubmit = false;
	}else if(SanctioningOfficer==null || SanctioningOfficer==='' || SanctioningOfficer==="" || typeof(SanctioningOfficer)=='undefined' ||SanctioningOfficer==='Select'){
		alert("Please Select the Sanctioning Officer..!");
		  $("#SanctioningOfficer").focus();
		  shouldSubmit = false;
   }else if(Rec1Role==null || Rec1Role==='' || Rec1Role==="" || typeof(Rec1Role)=='undefined'){
	      alert("Please Enter the Recommending-Officer1 Role..!");
		  $("#Rec1Role").focus();
		  shouldSubmit = false;
   }else if(Rec2Role==='' || Rec2Role==="" ){
	      alert("Please Enter the Recommending-Officer2 Role..!");
		  $("#Rec2Role").focus();
		  shouldSubmit = false;
   }else if(Rec3Role==='' || Rec3Role==="" ){
	     alert("Please Enter the Recommending-Officer3 Role..!");
		 $("#Rec3Role").focus();
		 shouldSubmit = false;
   }else if(SancRole==='' || SancRole===""){
	     alert("Please Enter the Sanctioning-Officer Role..!");
		 $("#SancRole").focus();
		 shouldSubmit = false;
   }else if(forwardremarksarea==='' || forwardremarksarea===""){
	     alert("Please Enter the Remarks..!");
		 $("#forwardremarksarea").focus();
		 shouldSubmit = false;
   }else{
	   if(ActionSave==='ActionSave'){
			if(confirm('Are you Sure To Save ?')){
				  form.submit();/*submit the form */
					}
		   }else{
			   if(confirm('Are you Sure To Forward ?')){
					  form.submit();/*submit the form */
						}
		   }
	}
}



function validateTextBox() {
    if (document.getElementById("remarksarea").value.trim() != "") {
    	return confirm('Are You Sure To Return?');
    	
    } else {
        alert("Please enter Remarks to Return");
        return false;
    }
}

$(document).ready(function(){	
 	var Attachcount=<%=DakReplyAttachmentCount%>;
 	var DakId=<%=DakEnotePreview[24]%>;
 	var EnoteFrom='<%=DakEnotePreview[29]%>';
 	if(EnoteFrom!=null && EnoteFrom==='C'){
 	if(Attachcount>0){
 		$('.enoteDocuments').css('display','');
 	}
 	
 	$('.downloadDakMainReplyAttachTable').empty();
	var maindoclength=0;
    
 	var mainstr = '';
     $.ajax({
		
		type : "GET",
		url : "GetEnoteAssignReplyAttachmentDetails.htm",
		data : {
			
			DakId: DakId
			
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
         mainstr += '    <button type="button" id="EnoteAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="DakEnoteAttachDelete.htm" formmethod="post" data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;" onclick="deleteEnoteEditAttach(' + other[2] + ',' + other[0] + ')"><img alt="attach" src="view/images/delete.png"></button>';
         mainstr += '</div><br>';
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
}else if(EnoteFrom!=null && EnoteFrom==='M'){
	var ReplyId=<%=DakEnotePreview[26]%>;
	if(Attachcount>0){
 		$('.enoteDocuments').css('display','');
 	}
 	
 	$('.downloadDakMainReplyAttachTable').empty();
	var maindoclength=0;
    
 	var mainstr = '';
     $.ajax({
		
		type : "GET",
		url : "GetEnoteMarkerReplyAttachmentDetails.htm",
		data : {
			
			ReplyId: ReplyId
			
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
         mainstr += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply" style="margin-right: 5px; flex: 1; color:blue;" value="' + other[2] + '" onclick="Iframepdfmarker(' + other[2] + ')" data-toggle="tooltip" data-placement="top" title="Download">' + other[3] + '</button>';
         mainstr += '    <button type="button" id="MarkerEnoteAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="DakMarkerEnoteAttachDelete.htm" formmethod="post" data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;" onclick="deleteMarkerEnoteEditAttach(' + other[2] + ',' + other[0] + ')"><img alt="attach" src="view/images/delete.png"></button>';
         mainstr += '</div><br>';
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
}

});
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
 
function deleteMarkerEnoteEditAttach(eNoteAttachId,eNoteId){
	 $('#EnotemarkerdAttachmentIdforDelete').val(eNoteAttachId);
	 $('#enoteMarkeridfordelete').val(eNoteId);
	 
	 console.log("eNoteAttachId"+eNoteAttachId);
	 console.log("eNoteId"+eNoteId);
	 var result = confirm ("Are You sure to Delete ?"); 
	 if(result){
		 var formaction=$('#Markerappform');
		 var button = $('#MarkerEnoteAttachDelete');
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

function firstDropdownChange() {
    var selectedValue = document.getElementById("RecommendingOfficer1").value;
    
    var SelecctedRecommend2=<%=DakEnotePreview[6]%>;
    
    $('#RecommendingOfficer2').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendingOfficer2').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue) {
        	
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendingOfficer2').append(option);
            if(SelecctedRecommend2==optionValue){
            $('#RecommendingOfficer2 option[value="' + optionValue + '"]').prop('selected', true);
        	}
        }
    <% } %>
    
 // Refresh the selectpicker after appending options
    $('#RecommendingOfficer2').selectpicker('refresh');
 
    var SelecctedRecommend3=<%=DakEnotePreview[7]%>;
    $('#RecommendingOfficer3').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendingOfficer3').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue ) {
        	
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendingOfficer3').append(option);
            if(SelecctedRecommend3==optionValue){
            $('#RecommendingOfficer3 option[value="' + optionValue + '"]').prop('selected', true);
        	}
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendingOfficer3').selectpicker('refresh');
 
 	var SanctioningOfficer=<%=DakEnotePreview[10]%>;

    $('#SanctioningOfficer').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#SanctioningOfficer').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue ) {
        	
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctioningOfficer').append(option);
            if(SanctioningOfficer==optionValue){
            $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
    	}
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctioningOfficer').selectpicker('refresh');
}

function secondDropdownChange() {
    var selectedValue = document.getElementById("RecommendingOfficer1").value;
    var selectedValue2 = document.getElementById("RecommendingOfficer2").value;
    
    
    var SelecctedRecommend3=<%=DakEnotePreview[7]%>;
    
    $('#RecommendingOfficer3').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendingOfficer3').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue && optionValue !== selectedValue2) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendingOfficer3').append(option);
            if(SelecctedRecommend3==optionValue){
                $('#RecommendingOfficer3 option[value="' + optionValue + '"]').prop('selected', true);
           }
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#RecommendingOfficer3').selectpicker('refresh');
 
    var SanctioningOfficer=<%=DakEnotePreview[10]%>;
    
    $('#SanctioningOfficer').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#SanctioningOfficer').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue && optionValue !== selectedValue2 ) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctioningOfficer').append(option);
            if(SanctioningOfficer==optionValue){
                $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
        	}
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctioningOfficer').selectpicker('refresh');

}

function thirdDropdownChange() {
	 var selectedValue = document.getElementById("RecommendingOfficer1").value;
	 var selectedValue2 = document.getElementById("RecommendingOfficer2").value;
	 var selectedValue3 = document.getElementById("RecommendingOfficer3").value;
	    
	    
	 var SanctioningOfficer=<%=DakEnotePreview[10]%>;
	 
    $('#SanctioningOfficer').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#SanctioningOfficer').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        
        if (optionValue !== selectedValue && optionValue !== selectedValue2 && optionValue !== selectedValue3) {
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#SanctioningOfficer').append(option);
            if(SanctioningOfficer==optionValue){
                $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
        	}
        }
    <% } %>
 // Refresh the selectpicker after appending options
    $('#SanctioningOfficer').selectpicker('refresh');

}


$(document).ready(function () {
	 var selectedValue = document.getElementById("RecommendingOfficer1").value;
	 var selectedValue1 = document.getElementById("RecommendingOfficer2").value;
	 var selectedValue2 = document.getElementById("RecommendingOfficer3").value;
	 var SelecctedRecommend2=<%=DakEnotePreview[6]%>;
	 var rosorc2='<%if(EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[3]!=null){%><%=EnoteRoSoRoledetails[3]%><%}%>';
	$('#RecommendingOfficer2').empty();

    var defaultOption = $("<option></option>").attr("value", "").text("Select");
    $('#RecommendingOfficer2').append(defaultOption);
    <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        if(selectedValue!==optionValue){
            var option = $("<option></option>").attr("value", optionValue).text(optionText);
            $('#RecommendingOfficer2').append(option);
            
            if(SelecctedRecommend2==optionValue){
            	 $('#RecommendingOfficer2 option[value="' + optionValue + '"]').prop('selected', true);
            }else if(rosorc2==optionValue && SelecctedRecommend2===null){
            	$('#RecommendingOfficer2 option[value="' + optionValue + '"]').prop('selected', true);
            }
        }
            <% } %>
            
         // Refresh the selectpicker after appending options
            $('#RecommendingOfficer2').selectpicker('refresh');
         
       var SelecctedRecommend3=<%=DakEnotePreview[7]%>;
       var rosorc3='<%if(EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[5]!=null){%><%=EnoteRoSoRoledetails[5]%><%}%>';
       $('#RecommendingOfficer3').empty();

        var defaultOption = $("<option></option>").attr("value", "").text("Select");
        $('#RecommendingOfficer3').append(defaultOption);
        <% for (Object[] type : RecommendingOfficerList) { %>
        var optionValue = '<%= type[0] %>';
        var optionText = '<%= type[1] + ", " + type[2] %>';
        if(selectedValue!==optionValue && selectedValue1!==optionValue){      
        var option = $("<option></option>").attr("value", optionValue).text(optionText);
        $('#RecommendingOfficer3').append(option);
        
        if(SelecctedRecommend3==optionValue){
       	 $('#RecommendingOfficer3 option[value="' + optionValue + '"]').prop('selected', true);
        }else if(rosorc3==optionValue && SelecctedRecommend3===null){
       	 $('#RecommendingOfficer3 option[value="' + optionValue + '"]').prop('selected', true);
          }
        }
       <% } %>
    // Refresh the selectpicker after appending options
       $('#RecommendingOfficer3').selectpicker('refresh');
       
    
       var SanctioningOfficer=<%=DakEnotePreview[10]%>;
       var sanc='<%if(EnoteRoSoRoledetails!=null && EnoteRoSoRoledetails[13]!=null){%><%=EnoteRoSoRoledetails[13]%><%}%>';
       $('#SanctioningOfficer').empty();

       var defaultOption = $("<option></option>").attr("value", "").text("Select");
       $('#SanctioningOfficer').append(defaultOption);
       <% for (Object[] type : RecommendingOfficerList) { %>
       var optionValue = '<%= type[0] %>';
       var optionText = '<%= type[1] + ", " + type[2] %>';
       if(selectedValue!==optionValue && selectedValue1!=optionValue && selectedValue2!==optionValue){ 
       var option = $("<option></option>").attr("value", optionValue).text(optionText);
       $('#SanctioningOfficer').append(option);
       
       if(SanctioningOfficer==optionValue){
      	 $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
       }else if(sanc==optionValue && SanctioningOfficer===null){
      	 $('#SanctioningOfficer option[value="' + optionValue + '"]').prop('selected', true);
        }
       }
       <% } %>
    // Refresh the selectpicker after appending options
       $('#SanctioningOfficer').selectpicker('refresh');
       
});

//Element by Id
function autoResize() {
    // Get the textarea element
    var textarea = document.getElementById("Reply");

    // Auto-adjust the height of the textarea based on its content
    textarea.style.height = "auto";
    textarea.style.height = (textarea.scrollHeight) + "px";
}

// Call autoResize initially to set the textarea height based on its initial content
autoResize();



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

function ChangeRecommendingOfficer() {
	var ChangeRecommendingOfficer=$('#ChangeRecOfficer').val();
	var ChangeApprovalRemarks=$('#ChangeApprovalRemarks').val();
	var RecommendRole=$('#RecommendRole').val();
	var form=$('#ChangeRec').val();
	 if (ChangeRecommendingOfficer==null || ChangeRecommendingOfficer=== '' || ChangeRecommendingOfficer===" " || typeof(ChangeRecommendingOfficer)=='undefined') {
		 alert("Please Select the RecommendingOfficer ...!");
		 $("#ChangeRecOfficer").focus();
	     return false;
	 } else if(ChangeApprovalRemarks==null || ChangeApprovalRemarks=== '' || ChangeApprovalRemarks===" " || typeof(ChangeApprovalRemarks)=='undefined' || ChangeApprovalRemarks==='Select') {
		 alert("Please Select the Reason For Change ...!");
		 $("#ChangeApprovalRemarks").focus();
	     return false;
	 } else if(RecommendRole==null || RecommendRole==='' || RecommendRole==="" || typeof(RecommendRole)=='undefined') {
		 alert("Please Enter the RecommendingOfficer Role...!");
		 $("#RecommendRole").focus();
	     return false;
	 } else {
	    	return confirm('Are You Sure To Change Officer ...?');
	    }
}

function SkipApprovalSubmit() {
	var SkipApprovalRemarks=$('#SkipApprovalRemarks').val();
	 if (SkipApprovalRemarks==null || SkipApprovalRemarks=== '' || SkipApprovalRemarks===" " || typeof(SkipApprovalRemarks)=='undefined' || SkipApprovalRemarks==='Select') {
		 alert("Please Select the Resaon for Skip ...!");
		 $("#SkipApprovalRemarks").focus();
	     return false;
	    } else {
	    	return confirm('Are You Sure To Skip?');
	    }
}
</script>
</html>
