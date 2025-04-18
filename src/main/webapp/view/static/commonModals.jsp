<%@page import="com.vts.dms.dak.model.DakReply"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
#pleasewait {
  background: rgba(0, 0, 0, 0.6); /* Semi-transparent background overlay */
}

.loadingContent {
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-width: 75%;
  min-height: 70vh;
}

.loader {
  border: 4px solid #f3f3f3; /* Light gray border */
  border-top: 4px solid #3498db; /* Blue border for animation */
  border-radius: 50%;
  width: 50px;
  height: 50px;
  animation: spin 1s linear infinite; /* Rotation animation */
}

.message {
  margin-top: 20px; /* Adjust the spacing between the spinner and the message */
  font-size: 18px; /* Customize the font size */
  color: #333; /* Customize the text color */
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.color-box {
display: inline-block;
width: 15px;
height: 15px;
margin-right: 5px;
}

.facilitators-box {
background-color: #FF8C00;
}

.markersinfo-box {
background-color: #0073FF;
}

.markersaction-box {
background-color: #0B6623;
}


.checkbox {
  position: relative;
  width: 100%;
  height: 100%;
  padding: 0;
  margin: 0;
  opacity: 0;
  cursor: pointer;
  z-index: 3;
}

/* Modal Related Styles Start */



.dakDocumentsTab {
  position: relative;
  display: flex;
  min-height: 200px;
  border-radius: 8px 8px 0 0;
  overflow: scroll;
}

.dakDocumentsTab::-webkit-scrollbar {
    display: none;
}

.dakParticularDocTab {
  flex: 1;
}

.dakParticularDocTab label {
  display: block;
  box-sizing: border-box;
  /* tab content must clear this */
    height: 37px;
  
  padding: 5px;
  text-align: center;
  background: #114A86;
  cursor: pointer;
  transition: background 0.5s ease;
  color: white;
  font-size: large;
}

.dakParticularDocTab label:hover {
  background: #5488BF ;
}

.docTabContent {
  position: absolute;
  
  left: 0; bottom: 0; right: 0;
  /* clear the tab labels */
    top: 40px; 
  border-radius: 0 0 8px 8px;
  background: white;
  
  transition: 
    opacity 0.8s ease,
    transform 0.8s ease   ;
  
  /* show/hide */
    opacity: 0;
    transform: scale(0.1);
    transform-origin: top left;
    
    width:60%;
  
}

.docTabContent img {
  float: left;
  margin-right: 20px;
  border-radius: 8px;
}


.dakParticularDocTab [type=radio] { display: none; }
[type=radio]:checked ~ label {
  background: #5488BF ;
  z-index: 2;
}

[type=radio]:checked ~ label ~ .docTabContent {
  z-index: 1;
  
  /* show/hide */
    opacity: 1;
    transform: scale(1);
}



/* BREAKPOINTS ----- */
@media screen and (max-width: 767px) {
  .dakDocumentsTab { min-height: 400px;}
}

@media screen and (max-width: 480px) {
  .dakDocumentsTab { min-height: 580px; }
  .dakParticularDocTab label { 
    height: 60px;
  }
  .docTabContent { top: 60px; }
  .docTabContent img {
    float: none;
    margin-right: 0;
    margin-bottom: 20px;
  }
}


.previewTable td {
  font-size: 16px !important;
}

.previewTable th {
  color: #114A86;
  font:size:16px;
}



#model-card-header {
  display: flex;
   color: #114A86;
  justify-content: center;
  align-items: center;
  text-align: center;
  font-size: 1.1 rem;
  font-weight: 700;
  color: #114A86;;
  text-shadow: 0 1px 0 #fff;
}

#model-person-header {

  font-size: 1.1rem;
  font-weight: 700;
  color: #8B0000;
  text-shadow: 0 1px 0 #fff;
  padding-top: 10px;
  float: left; 
  margin-left:32px;
}

.replyedit-click{
float: right; 
margin-left:10px;
margin-top:2px;
}

.replyforwardforedit-click{
float: right;
margin-left:10px;
margin-top:2px;
}

.replycswforwardreturn-click{
float: right;
margin-left:10px;
margin-top:2px;
}

.replycswRevision-click{
float: right;
margin-left:10px;
margin-top:2px;
}

.viewmore-click{
    /* background-color: Transparent !important; */
    background-repeat: no-repeat;
    border: none;
    cursor: pointer;
    overflow: hidden;
    outline: none;
    text-align: left !important;
    color:#1176ab;
    font-size: 14px;
    background-color:white;
}
.viewmore-click:hover {
background-color: #f9fcff;
background-image: linear-gradient(147deg, #f9fcff 0%, #dee4ea 74%);

}

.replyAttachWithin-btn{
 color:#0089c7;
 background-color:white;
 font-size:14px;
}

.replyAttachWithin-btn:hover {
   color: royalblue;
  text-decoration: underline;
}

.replyCSWAttachWithin-btn{
   color:#0089c7;
 background-color:white;
 font-size:14px;
}

.replyCSWAttachWithin-btn:hover {
   color: royalblue;
  text-decoration: underline;
}


.replyRow {
 margin-bottom: 0; /* Remove the bottom margin of the .replyRow */
 margin-right:2px;
 margin-left:2px;
 
}

.form-group {
 flex: 1 0 auto;
 margin-bottom:0px;
}

.group1 {
  margin-left:0px;
  display: inline-block;
  max-width: 700px;
  padding-right:50px;
}

.group2 {
 display: inline-block;
   margin-left:0px;
  
}

.TblReplyAttachs {
 display: inline-block;
   margin-left:0px;
  
}

.replyremarks-div {
  color: black;
  user-select: all;
  outline: none;
  height: 51px;
/*   border: 1px solid grey; */
  text-align: left;
  padding-left: 10px;
  margin-left: 30px;
  width: 700px !important;
 float: right; 
 box-shadow: rgba(14, 30, 37, 0.32) 0px 0px 0px 3px;
border-radius:3px!important;
  
}

.replyremarks-div button,
.replyremarks-div span {
  user-select: none;
}

.replyCSW-div {
  color: black;
  user-select: all;
  outline: none;
  height: 51px;
/*   border: 1px solid grey; */
  text-align: left;
  padding-left: 10px;
  margin-left: 30px;
  width: 700px !important;
 float: left; 
 box-shadow: rgba(14, 30, 37, 0.32) 0px 0px 0px 3px;
border-radius:3px!important;
  
}

.replyCSW-div button,
.replyCSW-div span {
  user-select: none;
}

.replyModAttachTbl-div{
  float: left; 
}

.replyCSWModAttachTbl-div{
  float: left; 
}

.downloadReplyAttachTable {
  width: 350px;

}

.downloadReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}

.downloadDakMainReplyAttachTable {
  width: 350px;

}

.downloadDakMainReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}

.downloadsubDakReplyAttachTable {
  width: 350px;

}

.downloadsubDakReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}

.downloadDakReplyAttachTable {
  width: 350px;

}

.downloadDakReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}

.downloadReplyCSWAttachTable td {
    padding: 0.2rem;
    border:none;
}



.DAKReplysBasedOnReplyId{

box-shadow: rgba(152,152,152, 0.3)0px 2px 4px 0px, rgba(14, 30, 37, 0.32) 0px 2px 16px 0px;
border-radius:2px;
}

.DAKSeekResponseReplysBasedOnReplyId{

box-shadow: rgba(152,152,152, 0.3)0px 2px 4px 0px, rgba(14, 30, 37, 0.32) 0px 2px 16px 0px;
border-radius:2px;
}

.dakDetails{

box-shadow: rgba(152,152,152, 0.3)0px 2px 4px 0px, rgba(14, 30, 37, 0.32) 0px 2px 16px 0px;
border-radius:2px;
}

.DAKCSWReplysBasedOnReplyId{

box-shadow: rgba(152,152,152, 0.3)0px 2px 4px 0px, rgba(14, 30, 37, 0.32) 0px 2px 16px 0px;
border-radius:2px;
}

#MarkedAssignedEmpListMod {
  /* Your styles for the child modal */
  display: none; /* Hide the child modal by default */
}
/* Modal Related Styles End */
#scrollable-content {
    /* Set the desired height for the scrollable area */
    height: 100%;
    /* Add a scroll to the content when it overflows */
    overflow-y: auto;
}
#scrollable-contentind {
    /* Set the desired height for the scrollable area */
    height: 100%;
    /* Add a scroll to the content when it overflows */
    overflow-y: auto;
}

.CommonGroupname{
width: 330px !important;
}
.CommonempidSelect{
width: 330px !important;
margin-top: -20px !important;
}
.Commonindividual{
width: 290px !important;
margin-left: -5px !important;
margin-top: -20px !important;
}
.filter-option-inner-inner {
	width: 200px !important;
}

.MarkedEmpNameDisp{
padding:8px;
}
.MarkedEmpDeleteBtn{
background-color:red;
border: none !important;
border-radius: 6px;
cursor: pointer !important;
float:right;
margin-right: 10px;
}
.MarkedEmpDeleteBtn:focus {
    outline: none;
}

.pncAttachments-btn{
	   color:#0089c7;
	   background-color:white;
	   font-size:14px;
	}

.pncAttachments-btn:hover {
	 color: royalblue;
	 text-decoration: underline;
}

#ShowMarkedEmployeeList {
  /* Default cursor style */
  cursor: pointer; /* Change this to the desired cursor type */
}

		.form-group DakPrev {
    flex: 1 0 auto;
    margin-bottom: 0px;
}



.DataPart2 {
    display: inline-block;
    margin-left: 0px;
    border:1px solid lightgrey;
    width:70px;
    margin-right:8px;
}
 /*switch styles */ 	
.switch {
  position: relative;
  display: inline-block;
  width: 80px;
  height: 45px;
}

/* Hide the default checkbox */
.switch input {
  display: none;
}

/* Style for the slider */
.slider {
  position: absolute;
  top: 3px;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: lightgrey;
  border-radius: 40px;;
  transition: 0.4s;
  width: 100px;
  height:35px;
}

/* Style for the slider when it's checked */
.slider:before {
 
  position: absolute;
  content: " For Info";
  height: 35px;
  width: 100px;
  left: 2px;
  background-color: #0066ff;
  border-radius: 40px;
  transition: 0.4s;
  text-align: center;
  font-size: 15px;
  color:white;
  padding-top: 6px;
}

/* Style for the switch when it's checked */
input:checked + .slider {
  background-color: lightgrey;
}

/* Style for the slider's appearance when it's checked */
input:checked + .slider:before {
  content: "For Action";
  background-color:#138808 ;
  color:white;
  padding-top: 6px;
  font-size: 15px;
  transform: translateX(0px);
}

.switchinfo {
  position: relative;
  display: inline-block;
  width: 80px;
  height: 45px;
}

/* Hide the default checkbox */
.switchinfo input {
  display: none;
}

/* Style for the slider */
.sliderinfo {
  position: absolute;
  top: 3px;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: lightgrey;
  border-radius: 40px;;
  transition: 0.4s;
  width: 100px;
  height:35px;
}

/* Style for the slider when it's checked */
.sliderinfo:before {
 
  position: absolute;
  content: " For Info";
  height: 35px;
  width: 100px;
  left: 2px;
  background-color: grey;
  border-radius: 40px;
  transition: 0.4s;
  text-align: center;
  font-size: 15px;
  color:white;
  padding-top: 6px;
}

/* Style for the switch when it's checked */
input:checked + .sliderinfo {
  background-color: lightgrey;
}

/* Style for the slider's appearance when it's checked */
input:checked + .sliderinfo:before {
  content: "For Action";
  background-color:#138808 ;
  color:white;
  padding-top: 6px;
  font-size: 15px;
  transform: translateX(0px);
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

 .DakLinkAttach-btn{
 color:#0089c7;
 background-color:white;
 font-size:14px;
}

 /*.DakLinkAttach-btn:hover {
   color: royalblue;
  text-decoration: underline;
}  */
 </style>
</head>
<body>
 <% long EmpId =(Long)session.getAttribute("EmpId"); 
    String loginType =(String)session.getAttribute("LoginTypeDms");
    String LabCode=(String)session.getAttribute("LabCode");
 %>
   <!----------------------------------------------------  Dak Markup Modal Start  ----------------------------------------------------------->
   <div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" id="exampleModalmarkgroup" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
     <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 98% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content">
 	      <div class="modal-header" style="background-color: #114A86;">
 	        <h3 class="modal-title" id="exampleModalLong2Title" style="color: white;"><b >DAK Marking  </b>
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	 	         <b style="color: white;">DAKId:</b> <span style="color: white;" id="dakMarkingpendingListDakNo"></span> &nbsp;&nbsp; <b style="color: white;">Source :</b> <span style="color: white;" id="dakMarkingpendingListSource"></span>
 	         </h3>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body">
  	      
  	      	<form action="DakMark.htm" id='markform' method="POST" >
  	      		<div class="row">
  	      		
  	      		<div class="col-md-6">
									<div align="left">
										<h6 style="text-decoration: underline;">
											<b>Group Marking</b>
										</h6>
									</div>
									<div align="center">
									<label style="margin-left: 185px; font-size: 15px;"><b>Grouping</b></label>
									&nbsp;&nbsp;&nbsp;
									<select class="form-control selectpicker  CommonGroupname "  multiple="multiple"  id="CommonGroupname" style="width: 20%; " data-live-search="true" name="CommonGroupname[]" >
									</select> </div>
									<hr>
									<div align="left">
										<h6 style="text-decoration: underline; ">
											<b>Individual Marking</b>
										</h6>
									</div><br>
									 <select  class="form-control selectpicker  Commonindividual " multiple="multiple" id="Commonindividual" name="Commonindividual[]" data-live-search="true">
									<option value="0">Individual</option>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<select    onchange='CommonaddEmpToSelect()'  class="form-control selectpicker CommonempidSelect dropup" multiple="multiple" data-dropup-auto="true"  id="CommonempidSelect" name="empid" data-live-search="true">
										</select> 
			                   	</div>
										<div class="col-md-6">
									<br>
									<div class="row">
									<div  class="col-md-12">
										<div class="card" id="scrollable-content" style="width: 100%; height: 100px; ">
										<div class="card-body">
											<input type="hidden" name="CommonEmpIdGroup" id="CommonEmpIdGroup" value="" />
										<div class="row" id="CommonGroupEmp"style="" >
									
	  	      									</div>
										</div> 
										</div>
									</div></div><br><br>
									<div class="row">
									 <div  class="col-md-12">
										<div class="card" id="scrollable-contentind" style="width: 100%;   margin-top:-10px; height: 100px; ">
										<div class="card-body">
										<div class="row" id="CommonIndEmp" style="">
										<input type="hidden" name="CommonEmpIdIndividual" id="CommonEmpIdIndividual" value="" />
	  	      									</div>
										</div> 
										</div>
									</div>
									</div>
								</div>
  	      			         
  	      			</div>
  	      		<input type="hidden" name="DakMarkingId" id="DakMarkingId">
  	      		<input type="hidden" name="DakMarkingAction" id="DakMarkingAction">
  	      		<input type="hidden" name="DakMarkingActionDueDate" id="DakMarkingActionDueDate">
  	      		<input type="hidden" name="DakMarkingActionRequired" id="DakMarkingActionRequired">
  	      		<input type="hidden" name="RedirectVal" id="RedirectValMarking">
  	      		<input type="hidden" id="dakmarkingfromdate" name="FromDate" value="">
  	      		<input type="hidden" id="dakmarkingTodate" name="ToDate" value="">
  	      		<!-- <h6><b>Selected Employees</b></h6>
  	      		<div class="row">
  	      				        <div class="col-md-2">Employee</div>
								<div class="col-md-8" >
								<select  data-width="330px" data-height="400px" class="form-control selectpicker"  name="empid" id="empid"  data-live-search="true"   title="Select Employee" multiple required="required" >
                                  </select>
  	      			          </div>
  	      		</div> -->
  	      		<br>
  	      		<div align="center">
  	      			<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
  	      		</div>
 
  	      		
  	      		<input type="hidden" name="dakId" id="dakid" value="" />
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 <!----------------------------------------------------  Dak Markup Modal End  ----------------------------------------------------------->
  <!----------------------------------------------------  Dak Distribute Modal Start  ----------------------------------------------------------->

	<div class="modal fade my-modal " id="exampleModalmark" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	  <div class="modal-dialog modal-lg modal-dialog-jump" role="document">
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header" style="background-color: #114A86;">
	 	        <h3 class="modal-title" id="exampleModalLong2Title" style="color:white;"><b>DAK Distribution</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	 	         <b>DAKId:</b> <span style="color: white;" id="dakpendingListDakNo"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	 	         <b>Source :</b> <span style="color: white;" id="dakpendingListSource"></span></h3>
	  	        <button type="button" class="close" style="color:white;" data-dismiss="modal" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body">
	  	      
	  	      	<form action="#"  method="POST" id="DakDistributionForm">
	  	      		<div class="row" id="DakDistributeAppend" style="display:block!important" >
	  	      		</div>
	  	      		<br>
	  	      		<div align="center">
	  	      			<button type="button" style="width: 15%;" class="btn btn-primary btn-sm submit "  formaction="DakDistribute.htm" 
	  	      			id="DakDistriBtn"  onclick="return DakDistributeSubmitValidation()" >Submit</button>
	  	      		</div>
	  	
	  	      		 
	  	      		
	  	      	   <!-- For DAK Distribute only-->
	  	              <input type="hidden" name="EmpIdDistribute" id="EmpIdDistribute" value="" />
	  	              <input type="hidden" name="DakAttachCount" id="dakAttachCountVal" value="" />
	  	              <input type="hidden" name="markedAction" id="markedAction">
	  	              
	  	      	      <input type="hidden" name="Actioninput" id="Actioninput">
	  	      	  
	  	      	      <input type="hidden" name="PageNumber" id="PageNo" value="" />
	  	              <input type="hidden" name="RowNumber" id="RowNo" value="" />
	  	              
	  	               <input type="hidden" name="TotalCountofEmp" id="TotalCountofEmp" value="" />
	  	              <input type="hidden" name="TotalInfoCount" id="TotalInfoCount" value="" />
	  	               
			
	  	              
	  	              
	  	      	  <!--common for DAK Distribute & Delete-->
	  	      		<input type="hidden" name="dakId" id="dakidDistribute" value="" />
	  	      	    <input type="hidden" name="ActionDataDistribute" id="actionDataDistribute" value="" />
	  	      		
	  	      	 <!-- For Marked Emp Delete only -->
	  	      	   <input type="hidden" name="EmpIdForDelete" id="EmpIdAppendFrDelete" value="" />
	  	      	   <input type="hidden" name="DakMemberTypeIdForDelete" id="DakMemberTypeIdAppendFrDelete" value="" />
	  	      	    <input type="hidden" name="DakMarkingIdForDelete" id="DakMarkingIdAppendFrDelete" value="" />
	  	      	   <input type="hidden" id="dakdistributefromdate" name="FromDate" value="">
  	      		   <input type="hidden" id="dakdistributeTodate" name="ToDate" value="">
	  	      	
	  	      	   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  	      	</form>
	  	      		
	  	      		
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  Dak Distribute Modal End    ----------------------------------------------------------->
		 
		 
	
		<!---------------------------- Download Attach Start(Common for DAK Pending List and DAK Director & DAK List) --------------------------------------->
		 	<form action="DeleteAttach.htm" name="deleteform" id="deleteform" >
		<input type="hidden" name="dakattachmentid" id="dakattachmentid" value="" />
		<input type="hidden" name="redirectValueFrDelAttach" id="redirectValFrDelAttach" value="" />
			<input type="hidden" name="fromDateFrmDE" id="DelAttachFrmDt" value="">
  	      	<input type="hidden" name="toDateFrmDE" id="DelAttachToDt"value="">
  	      	<input type="hidden" name="PageNumber" id="DeletePageNumber" value="" />
  	      		<input type="hidden" name="RowNumber" id="DeleteRowNumber" value="" />
	</form>
	
	
	<div class="modal fade my-modal " id="ModalDakAttachments" tabindex="-1" role="dialog" aria-labelledby="ModalDakAttachments" aria-hidden="true">
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document" style="width:1000px;">
 	    <div class="modal-content">
  	      <div class="modal-body">
  	       <h3 class="modal-title" id="exampleModalLong2Title" style="background-color: " ><b>DAKId:</b> <span style="color: #114A86;" id="dakAttachmentDakNo"></span> &nbsp;&nbsp; <b>Source :</b> <span style="color: #114A86;" id="dakAttachmentSource"></span>
 	         </h3>
  	      <div class="tabs">
        <div class="tabby-tab">
      <input type="radio" id="tab-1" name="tabby-tabs" checked  onclick="tabChange('M')">
      <label for="tab-1">Main Document</label>
      <div class="tabby-content">
  	      	<form action="DakAttach.htm" name="attachform" id="attachformMainDoc"  method="POST" enctype="multipart/form-data">
  	      		
  	      		
  	      		<div class="row">
  	      			<div class="col-md-10">
  	      				<input class="form-control" type="file" name="dakdocumentupload"  id="dakdocumentMainDoc" accept="*/*"   >
  	      			</div>
  	      			
  	      		   <div class="col-md-2" align="center">
  	      			<input type="button" class="btn btn-primary btn-sm submit "  style="margin:7px 0px 0px -10px; " id="subdakdocumentMainDoc" value="Submit" name="sub"  onclick="submitattachMainDoc()" > 
  	      		   </div>
  	      		</div>
  	      		
  	      		<br>
  	      		<table class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtable" >
					<thead>
						<tr>
							<th style="width:5%;" >SN</th>
							<th style="width:60%;"> Item Name </th>
							<th style="width:35%; ">Action</th> 
						</tr>
					</thead>
					<tbody id="other-list-table">
					
					</tbody>
				</table>
  	      		
  	      		<input type="hidden" name="dakidvalue" id="dakidvalue" value="" />
  	      		<input type="hidden" name="daknovalue" id="daknovalue" value="" />
  	      		
  	      		<input type="hidden" name="PageNumber" id="PageNumber" value="" />
  	      		<input type="hidden" name="RowNumber" id="RowNumber" value="" />
  	      		
  	      		<input type="hidden" name="type" id="type" value="" />
  	      		<input type="hidden" name="redirectValFrAttach" id="redirectFrAttach" value="" />
  	      		<input type="hidden" name="fromDateFrmDA" id="DakAttachFrmDt" value="">
  	      		<input type="hidden" name="toDateFrmDA" id="DakAttachToDt"value="">
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	</form>
  	      		</div>
  	      		</div>
  	      		
  	      		<div class="tabby-tab">
      <input type="radio" id="tab-2" name="tabby-tabs" onclick="tabChange('S')">	
      <label for="tab-2">Enclosures</label>
      <div class="tabby-content">
        	<form action="DakAttach.htm" name="attachform" id="attachformSubDoc"  method="POST" enctype="multipart/form-data">
  	      		<div class="row">
  	      			<div class="col-md-10">
  	      				<input class="form-control" type="file" name="dakdocumentupload"  id="dakdocumentSubDoc" accept="*/*"  >
  	      			</div>
  	      		
  	      		   <div class="col-md-2" align="center">
  	      			<input type="button" class="btn btn-primary btn-sm submit "  style="margin:7px 0px 0px -10px; " id="sub2dakdocumentSubDoc" value="Submit" name="sub"  onclick="submitattachSubDoc()" > 
  	      		   </div>
  	      		</div>
  	      		
  	      		<br>
  	      		<table class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtable" >
					<thead>
						<tr>
							<th style="width:5%;" >SN</th>
							<th style="width:45%;"> Item Name </th>
							<th style="width:50%; ">Action</th> 
						</tr>
					</thead>
					<tbody id="other-list-table2">
					
					</tbody>
				</table>
  	      		
  	      		<input type="hidden" name="dakidvalue" id="dakidvalue2" value="" />
  	      		<input type="hidden" name="dakCreateId" id="dakCreateId" value="" />
  	      		<input type="hidden" name="daknovalue" id="daknovalue2" value="" />
  	      		<input type="hidden" name="type" id="type2" value="" />
  	      		<input type="hidden" name="redirectValFrAttach" id="redirectFrAttach2" value="" />
  	      		<input type="hidden" name="fromDateFrmDA" id="DakAttachFrmDt2" value="">
  	      		<input type="hidden" name="toDateFrmDA" id="DakAttachToDt2"value="">
  	      		<input type="hidden" name="PageNumber" id="subPageNumber" value="" />
  	      		<input type="hidden" name="RowNumber" id="subRowNumber" value="" />
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	</form>
      </div>
     <br><br>
    </div>
    <div class="tabby-tab">
      <input type="radio" id="tab-3" name="tabby-tabs" data-dismiss="modal" aria-label="Close">
      <label for="tab-3"><button type="button"  class="close" style="color: white;margin-right: 10px;" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button></label>
      		<div class="tabby-content">
      
  	      	</div>
  	      	</div>
  	      	</div>
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
		<!-------------------------------- Download Attach End(Common for DAK Pending List and DAK Attach List) ------------------------------>
 <!---------------------------------------------------- <!-- Child Modal of  (MarkedAssignedEmpListMod)<Dak Distribute and Assingned Employee List Start----------------------------------------------------------->

	<%-- <div class="modal fade my-modal" id="MarkedAssignedEmpListMod"   tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 		  <div class="modal-dialog modal-dialog-centered" role="document" style="min-width: 50% !important;">
	 		 <!--  <div class="modal-dialog  modal-dialog-centered" role="document"  style="min-width: 50% !important; min-height: 20vh !important; display: flex; align-items: stretch;" > -->

	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header" style="background-color:#114A86;height:50px;">
	 	        <h5 class="modal-title" style="margin-left: 150px;" id="exampleModalLong2Title"><b style="color:white;text-align:left;">Marked Employees List</b> </h5>
	  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
	  	          <span aria-hidden="true" style="background-color:white;">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body">
	  	      
	  	      	   <form action="#"  method="POST" >
	  	      		<div class="row" id="DistributedListDisplay" style="display:block;">
	  	      		</div>
	  	      		<br>
	  	      		<div align="center">
	  	      			
	  	      		</div>
	  	      		<input type="hidden" name="dakId" id="dakidvalueforlist" value="" />
	  	      		<input type="hidden" name="EmpId" id="empidvalueforlist" value="" />
	  	      		<input type="hidden" name="ActionData" id="actionData" value="" />
	  	      		
	  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  	      	</form>
	  	      		
	  	      		
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div> --%>

		 <!---------------------------------------------------- DAK Distribute and Assingned Employee List End ----------------------------------------------------------->
		 
	 <!----------------------------------------------------  Dak View Modal Start    ----------------------------------------------------------->
	
	<div class="modal bd-example-modal-lg" tabindex="-1" role="dialog" id="assigned-details">
	
 	  <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 100% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >

			<div class="modal-content">
					<div class="modal-header" style="background-color: #114A86;max-height:55px;">
					 <!-- ----------- COMMON TOGGLE BUTTONS(DAK Preview,DAK reply) STARTS --------------------------- --> 		
		   <div style="float: right;padding:5px;margin-top:-14px; ">
		  	  <div class="btn-group TogglePreviewModal"> 
		         <button class="btn btnDakDetailsPreview"  id="model-card-header" >DAK Details</button>
		         <button class="btn btnReplyDetailsPreview" id="model-card-header" style="display:none;" >Marker Reply</button>
		         <button class="btn btnCWReplyDetailsPreview" id="model-card-header" style="display:none;" >CW Reply</button>
		         <button class="btn btnPNCDOReplyDetailsPreview" id="model-card-header" style="display:none;" ><%if(LabCode!=null && LabCode.equalsIgnoreCase("ADE")){ %>PPA<%}else{ %>P&C DO<%} %>   Reply</button>
		          <button class="btn btnSeekResponseReplyDetailsPreview" id="model-card-header" style="display:none;" >Seek Response Reply</button>
		         <h6 class="modal-title" id="exampleModalLongTitle" style="margin-top: 8px; color: white;">
		          &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
		         &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; <b>DAK Id :</b> &nbsp;&nbsp;<span style="color: white;" id="Dakno">
		         </span> &nbsp;&nbsp;&nbsp;<b>Source :</b> &nbsp;&nbsp; <span style="color: white;" id="Source"></span>
		         &nbsp;&nbsp;&nbsp;&nbsp;<b>Subject :</b> &nbsp;&nbsp; <span style="color: white;" id="PreviewSubject"></span>
		         </h6>
		      </div>
		  </div>	
		 <!-- ----------- COMMON TOGGLE BUTTONS(DAK Preview,DAK reply) ENDS --------------------------- --> 
			 <button type="button" style="color: white;" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				    </div> 
			 <!-- -----------DAK Preview Div Starts --------------------------- --> 
			 <div class="group" id="dakDetailsMod" style="display:none;">    
				    
				<div class="modal-body" align="center" style="margin-top:-4px;">
					<div class="row replyRow"><!-- side by side enclosing END -->
					<div class="form-group DakPrev DataPart1" style=" display: inline-block;max-width: 1100px; padding-right: 50px;"><!-- Datapart1 Start -->
					<form action="#" method="post" autocomplete="off"  >
						<table style="width: 100%;" class="previewTable table-hover">
							
							<tr>
								<!-- <th style="padding: 8px;width:10px;" >DAK Id </th>
								<td colspan="1" style="padding: 8px;width:400px;" id="Dakno"></td>  -->
								<!--  <td style="width: 100px!important;"></td> --> <!-- Adjust the width as desired -->
								<th  style="padding: 8px;width:10px;" >Letter Type </th>
								<td  colspan="1"style="padding: 8px;width:400px;" id="lettertype"></td>
								<th style="padding: 8px; margin-left: -50px;" >Priority</th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="Priority"></td>
							</tr>
							<!-- <tr> -->
								
								<!--  <td style="width: 100px!important;"></td> --> <!-- Adjust the width as desired -->
								<!-- <th style="padding: 8px;width:20%;" >Source </th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="Source"></td> -->
							<!-- </tr> -->
							
							<tr>
								<th style="padding: 8px;width:17%;" >Ref No </th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="LetterNo"></td>
								<!-- <td style="width: 100px!important;"></td> --> <!-- Adjust the width as desired -->
								<th style="padding: 8px" >Ref Date </th>
								<td colspan="2" style="padding: 8px;" class="tabledata" id="LetterDate"></td>
								<!-- <th style="padding: 8px;width:17%;" > Dak Status </th>
								<td colspan="2"  style="padding: 8px;" class="tabledata" id="DakStatus"></td> -->
							</tr>
							
							
							<tr>
							    <th style="padding: 8px;width:20%;" >KeyWord1 </th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="KeyWord1"></td>
								<!--  <td style="width: 100px!important;"></td> --> <!-- Adjust the width as desired -->
								<th style="padding: 8px; width:17%;" > KeyWord2 </th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="KeyWord2"></td>
								
							</tr>
							
							<tr>
							    	
								<th style="padding: 8px;width:20%;" >KeyWord3 </th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="KeyWord3"></td>
								<!-- <td style="width: 100px!important;"></td> --> <!-- Adjust the width as desired -->
								<th style="padding: 8px;width:17%;" > KeyWord4 </th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="KeyWord4"></td>
								
							</tr>
							
							<tr>
							    <th style="padding: 8px;width:20%;" >Action Due</th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="ActionDueDate"></td>
								<!-- <td style="width: 100px!important;"></td> --> <!-- Adjust the width as desired -->
								<th style="padding: 8px;width:17%;" > Action Time </th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="ActionTime"></td>
							</tr>
							
								<tr>
							    <th style="padding: 8px;width:20%;" >Closing Authority</th>
								<td  colspan="1" style="padding: 8px;width:400px;" class="tabledata" id="ClosingAuthority"></td>
								<!-- <td style="width: 100px!important;"></td> --> <!-- Adjust the width as desired -->
								<th style="padding: 8px;width:17%;" >Director Approval</th>
								<td  colspan="2" style="padding: 8px;" class="tabledata" id="DirectorApproval"></td>
							</tr>
							
						<tr>
							    <th style="padding: 8px;width:20%;" >Subject </th>
								<td  colspan="6" style="padding: 8px;" class="tabledata" id="Subject"></td>
							
							</tr>
							
								<tr>
								 <th style="padding: 8px;width:20%;" >Brief on DAK </th>
									<td  colspan="6" style="padding: 8px;" class="tabledata" id="Remarks"></td>
								</tr>
						
						   	<tr  id="ClosingCommtTr" style="display: none;">
								 <th style="padding: 8px;width:20%;" >Closing Comment </th>
									<td  colspan="6" style="padding: 8px;" class="tabledata" id="closingcomment"></td>
								</tr>
								
								<tr  id="ClosedBy" style="display: none;">
								 <th style="padding: 8px;width:20%;" >Closed By </th>
									<td  colspan="6" style="padding: 8px;" class="tabledata" id="closedBy"></td>
								</tr>
								
									<!-- <tr style="display:none" id="DakLinkList">
								 <th style="padding: 8px;width:20%;" >DAK Link</th>
									<td  colspan="6" style="padding: 8px;" class="tabledata" id="AllDakLinkDisplay"></td>
								</tr> -->
								
						</table>
						<div class="row">
						<label style="text-align: left; color:#114A86; margin-left:25px; font-size: 25px;">Link DAK</label>
				<!-- <div class="col-md-12" id="alldakLink" style="display:none; float: left;">Datapart2 Start -->
	  	        <div class="col-md-6" id="AllDakLinkDisplay" style="display:none; position: relative; float: left; width: 100%;"> 
	  	      		</div>
	  	      		<input type="hidden" name="dakId" id="dakidvalueforlist" value="" />
	  	      		<input type="hidden" name="EmpId" id="empidvalueforlist" value="" />
  	      <!-- 	</div>Datapart2 End -->
  	      	</div>
				
						<input type="hidden"  name="TicketId1" id="TicketId1" value=""> 
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                  </form><br><br>
                  
                  <div class="dakmainDocumentsTab" style="width: 90%;">
                  <div class="row col-md-12"  style="float:left!important;">
                 <!--  <div class="col-md-1" id="maindakdocslabel" style="float: left; display: none;" > 
  	            <label style="text-align: left; color:#114A86; margin-left:-31px; font-size: 25px;">Main Document</label>
  	            </div> -->
                  <div class="form-group group2 col-md-3" id="maindakdocslabel"  style=" width: 100%; display: none; float: left !important; margin-left: -80px;">
                 	<label><b>Main Document :</b></label></div>
                 	<!-- <div class="form-group group2 col-md-9"  id="maindakdocs" style=" width: 100%; display: none;">
                 	<table class="table table-hover table-striped table-condensed info shadow-nohover downloadDakMainReplyAttachTable" style="width: 54%;">
                 	
                 	</table>
                 	</div> -->
                 	<div class="col-md-9 downloadDakMainReplyAttachTable" id="maindakdocs"  style="display: inline-block; position: relative; float: left!important; width: 100%;"> 
	  	      		</div>
                 	</div>
                 	</div>
                 	<div class="daksubDocumentsTab" style="width: 90%;">
                 	<div class="row col-md-12"  style="float:left!important;">
                 	<div  class="form-group group2 col-md-3" id="subdakdocslabel" style="width: 100%; display: none; float: left; margin-left: -80px;">
                 	<label style="margin-left: -30px;"><b>Enclosures :</b></label></div>
                 	<div class="col-md-9 downloadsubDakReplyAttachTable" id="subdakdocs"  style="display: inline-block; position: relative; float: left; width: 100%;"> 
	  	      		</div>
                 	</div>
                 	<!-- <div class="form-group group2 col-md-9" id="subdakdocs" style=" width: 100%; display: none;">
                 	<table class="table table-hover table-striped table-condensed info shadow-nohover downloadsubDakReplyAttachTable" style="width: 54%; ">
                 	
                 	</table>
                 	</div> -->
                 	</div>
                 	
  	      	</div><!-- Datapart1 End -->
  	      	<div class="form-group DakPrev DataPart2" id="dakPrevDataPart2" style="display:none;"><!-- Datapart2 Start -->
  	            <div style="overflow: auto; max-height: 500px!important;"> 
                	 <h6 style="font-weight: bold; padding: 5px;; font-size: 15px;color:#353935;float:left;">Employees (
                	  <span class="color-box markersinfo-box"></span>
                	  :
                      <span class="label">Markers Info</span>
                      <span class="color-box markersaction-box"></span>
                	  :
                	  <span class="label">Markers Action</span>
                      <span class="color-box facilitators-box"></span>
                      :
                     <span class="label">Facilitators</span>
                      )
    </h6>
                	 <form action="#"  method="POST" >
	  	        <div class="row" id="DistributedListDisplay" style="display: inline-block; position: relative; left: 0; text-align: left; width: 100%;"> 
	  	      		</div>
	  	      		<input type="hidden" name="dakId" id="dakidvalueforlist" value="" />
	  	      		<input type="hidden" name="EmpId" id="empidvalueforlist" value="" />
	  	      		</form>
            </div> 
  	      	</div><!-- Datapart2 End -->
  	      	
  	      	</div><!-- side by side enclosing END -->
					</div>
			</div>		
		 <!-- -----------DAK Preview Div Ends --------------------------- --> 	
	
				 <!-- -----------DAK Reply Div Starts --------------------------- --> 	
		 <div class="group" id="replyDetailsMod" style="display:none;">	
		 	<form action="#" method="post" autocomplete="off"  >
		 	   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	<div class="modal-body" align="center" style="margin-top:-4px;">
				<div class="DakReply" >  
				<!-- all the datas inside this is filled using javascript -->
				</div>
					
					
					
					</div>		
					</form>
			
		 </div>
		  <!-- -----------DAK Reply Div Ends --------------------------- --> 
		  
		   <!-- -----------DAK CaseworkerReply Div Starts --------------------------- --> 	
		 <div class="group" id=caseworkerReplyMod style="display:none;">	
		 	<form action="#" method="post" autocomplete="off" id="CSWPreviewForm" >
		 	   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	<div class="modal-body" align="center" style="margin-top:-4px;">
				<div class="CaseworkerDakReplyData" >  
				<!-- all the datas inside this is filled using javascript -->
				</div>
					
					
					
					</div>		
					</form>
			
		 </div>
		  <!-- -----------DAK CaseworkerReply Div Ends --------------------------- --> 
					
	 <!-- -----------DAK P&C DO Reply Div Starts --------------------------- --> 
	 
	 
    <div class="group" id="pncDoReplyMod" style="display:none;">	
		    <form action="#" method="post" id="pncDoReplyPreviewForm" autocomplete="off"  >
		       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		       <div class="modal-body" align="center" style="margin-top:-4px;">
		       
		       <div class="form-inline">
		       <div><h4><b><span id="pncdoreplypersonname" style="color:#8B0000; font-size: 20px;"></span></b>, <b><span id="pncdoreplydeignation" style="color: #8B0000; font-size: 20px;"></span>, <span id="createddate" style="font-size: 20px;"></span></b></h4></div>
		                <!--     <label style="font-weight:bold;font-size:14px;float:left;">Reply :</label> -->
  	      				<textarea class="form-control pncDoReplyData" id="pncDoRepliedData" style="min-width: 100% !important;min-height: 50vh;background-color:white;"   readonly="readonly"  maxlength="500" > </textarea>
  	      			<!--  <label style="font-weight:bold;font-size:14px;float:left;">Document :</label>  -->
  	      			<!-- <div class="col-md-2"><br>Document :</div> -->
  	               
  	               <!--  <div class="col-md-5 "> -->
  	               <br>
  	      			     <table class="pncDoAttachedFilesTbl" >		
  	      			        <!-- data will be filled using ajax -->  	      				
			  	         </table>
  	                <!--  </div> -->
  	      
  	      			<br>
  	      
  	      		</div>
				
		       
		       </div>
		    </form>
		    </div>
		 
		  <!-- -----------DAK P&C DO Reply Div Ends --------------------------- --> 
		  
		   <!-- -----------DAK Reply Div Starts --------------------------- --> 	
		 <div class="group" id="SeekResponsereplyDetailsMod" style="display:none;">	
		 	<form action="#" method="post" autocomplete="off"  >
		 	   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	<div class="modal-body" align="center" style="margin-top:-4px;">
				<div class="DakSeekResponseReply" >  
				<!-- all the datas inside this is filled using javascript -->
				</div>
					
					
					
					</div>		
					</form>
			
		 </div>
		  <!-- -----------DAK Reply Div Ends --------------------------- --> 
					
			</div>
		</div>
	</div>
	
	 <!----------------------------------------------------  Dak PrevView Modal End    ----------------------------------------------------------->


 <!----------------------------------------------------  Dak Reply View more Modal Start    ----------------------------------------------------------->
	<div class="modal fade my-modal" id="replyViewMore" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	 <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    	<div class="modal-content" style="min-height: 90%!important;">
	 	     
	 	      <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374">Reply Data&nbsp; <span id="replierName"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">×</span>
				        </button>
				    </div>
	 	     
	 	  
	  	     <div class="modal-body" style="padding: 0.5rem !important;">
	  	       <div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
	  	           <div class="row" id="replyDetailsDiv">
	  	      		</div>
	  	      	</div>	
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  Dak Reply View more Modal Start    ----------------------------------------------------------->
		 
		 <!----------------------------------------------------  Dak Subject View more Modal Start    ----------------------------------------------------------->
	<div class="modal fade my-modal" id="SubjectViewMore" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	 <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    	<div class="modal-content" style="min-height: 90%!important;">
	 	     
	 	      <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374">Subject &nbsp; <span id="replierName"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">×</span>
				        </button>
				    </div>
	 	     
	 	  
	  	     <div class="modal-body" style="padding: 0.5rem !important;">
	  	       <div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
	  	           <div class="row" id="SubjectDiv">
	  	      		</div>
	  	      	</div>	
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  Dak Reply View more Modal Start    ----------------------------------------------------------->

<!----------------------------------------------------   Common Reply  Edit start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="replyCommonEditModal" tabindex="-1" role="dialog" aria-labelledby="replyCommonEditTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 85% !important; min-height: 50vh !important; margin-top:100px !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b>DAK Reply Edit</b></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReplyEditAndDel" id="attachformReplyEditAndDel" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control replyDataInEditModal"  name="replyEditRemarksVal" style="min-width: 110% !important;min-height: 30vh;"  id="replyEditRemarksData" required="required"  maxlength="1000" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      	<!-- new file add start -->
  	      	<div class="row">
  	      	<div class="col-md-5 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_editreply_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_editreply">
			  	      			<td><input class="form-control" type="file" name="dak_replyEdit_document"  id="dakdocumenteditreply" accept="*/*"></td>
			  	      				<td><button type="button" class="tr_editreply_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      </div>
  	      	<!-- new file add end -->

  	      
  	       	<!-- old file delete,open or download start -->
  	      	<div class="col-md-5 " style="float:left">
  	      	<br>
  	      	<table class="ReplyEditAttachtable" style="border:none" >
					
					<tbody id="ReplyAttachEditDataFill">
					
					
					</tbody>
				</table>
  	        </div>
  	        </div>
  	      	<!-- old file delete,open or download end -->
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  	<!-- for delete -->
  	      		 <input type="hidden" id="replyAttachmentIdFrDelete" name="replyAttachmentIdVal" value="" />
  	      		<input type="hidden" id="replyIdFrAttachDelete" name="replyIdVal" value="" />
  	      		<!-- for edit -->
  	      		  <input type="hidden" name="dakReplyIdValFrReplyEdit"  id="dakReplyIdOfReplyEdit" value="" >
  	      		  <input type="hidden" name="dakIdValFrReplyEdit"  id="dakIdOfReplyEdit" value="" >
  	      		    <input type="hidden" name="empIdValFrValueEdit" id="empIdOfReplyEdit" value="">
  	      		    
  	      			<input type="button" formaction="DAKReplyDataEdit.htm"  class="btn btn-primary btn-sm submit " id="dakCommonReplyEditAction"   onclick="return dakReplyEditValidation()" value="Submit" > 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 
 <!---------------------------------------------------- Common DakAssignReply  Edit Modal start    ----------------------------------------------------------->
  
  <div class="modal fade my-modal" id="DakAssignreplyCommonEditModal" tabindex="-1" role="dialog" aria-labelledby="replyCommonEditTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 95% !important; min-height: 70vh !important; margin-top:100px !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b>DAK Assign Reply Edit</b></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReplyEditAndDel" id="cswattachformReplyEditAndDel" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control assignReplyDataInEditModal"  name="assignReplyEditedVal" style="min-width: 110% !important;min-height: 30vh;"  id="cswreplyEditRemarksData" required="required"  maxlength="500" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      	<!-- new file add start -->
  	      	<div class="row">
  	      	<div class="col-md-5 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_editreply_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_editreply">
			  	      			<td><input class="form-control" type="file" name="dak_replyEdit_document"  id="cswdakdocumenteditreply" accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_editreply_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      </div>
  	      	<!-- new file add end -->

  	      
  	       	<!-- old file delete,open or download start -->
  	      	<div class="col-md-5 " style="float:left">
  	      	<table class="ReplyEditAttachtable" style="border:none" >
					
					<tbody id="cswReplyAttachEditDataFill">
					
					
					</tbody>
				</table>
  	        </div>
  	        </div>
  	      	<!-- old file delete,open or download end -->
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  	<!-- for delete -->
  	      		 <input type="hidden" id="cswreplyAttachmentIdFrDelete" name="replyAttachmentIdVal" value="" />
  	      	     <input type="hidden" id="cswreplyIdFrAttachDelete" name="replyIdVal" value="" />
  	      		   <!-- for edit -->
  	      		  <input type="hidden" name="dakAssignReplyIdValue"  id="dakAssignReplyIdEdit" value="" >
  	      		  <input type="hidden" name="dakIdFrEdit"  id="dakIdOfAssignReplyEdit" value="" >
  	      		    <input type="hidden" name="empIdFrEdit" id="empIdOfAssignReplyEdit" value="">
  	      		    <input type="hidden" name="dakAssignIdFrEdit" id="dakAssignIdReplyEdit" value="">
  	      		    
  	      			<input type="button" formaction="DAKAssignReplyDataEdit.htm"  class="btn btn-primary btn-sm submit " id="cswdakCommonReplyEditAction"   onclick="return dakAssignReplyEditValidation()" value="Submit" > 
  	      	
  	      	
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
	
	<!-- -----------------------------------------------------------------------------    Common DakAssignReply  Edit Modal End ------------------------------------------- -->
   
   <!----------------------------------------------------   Common Seek Response Reply  Edit start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="SeekResponsereplyCommonEditModal" tabindex="-1" role="dialog" aria-labelledby="replyCommonEditTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 85% !important; min-height: 50vh !important; margin-top:100px !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b>DAK Seek Response Reply Edit</b></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReplyEditAndDel" id="SeekResponseattachformReplyEditAndDel" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control SeekResponsereplyDataInEditModal"  name="replyEditRemarksVal" style="min-width: 110% !important;min-height: 30vh;"  id="SeekResponsereplyEditRemarksData" required="required"  maxlength="500" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      	<!-- new file add start -->
  	      	<div class="row">
  	      	<div class="col-md-5 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_editreply_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_editreply">
			  	      			<td><input class="form-control" type="file" name="dak_replyEdit_document"  id="dakdocumenteditreply" accept="*/*"></td>
			  	      				<td><button type="button" class="tr_editreply_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      </div>
  	      	<!-- new file add end -->

  	      
  	       	<!-- old file delete,open or download start -->
  	      	<div class="col-md-5 " style="float:left">
  	      	<br>
  	      	<table class="ReplyEditAttachtable" style="border:none" >
					
					<tbody id="SeekResponseReplyAttachEditDataFill">
					
					
					</tbody>
				</table>
  	        </div>
  	        </div>
  	      	<!-- old file delete,open or download end -->
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  	<!-- for delete -->
  	      		 <input type="hidden" id="SeekResponsereplyAttachmentIdFrDelete" name="replyAttachmentIdVal" value="" />
  	      		<input type="hidden" id="SeekResponsereplyIdFrAttachDelete" name="replyIdVal" value="" />
  	      		<!-- for edit -->
  	      		  <input type="hidden" name="dakReplyIdValFrReplyEdit"  id="SeekResponsedakReplyIdOfReplyEdit" value="" >
  	      		  <input type="hidden" name="dakIdValFrReplyEdit"  id="SeekResponsedakIdOfReplyEdit" value="" >
  	      		    <input type="hidden" name="empIdValFrValueEdit" id="SeekResponseempIdOfReplyEdit" value="">
  	      		    
  	      			<input type="button" formaction="DAKSeekResponseReplyDataEdit.htm"  class="btn btn-primary btn-sm submit " id="dakSeekResponseCommonReplyEditAction"   onclick="return dakSeekResponseReplyEditValidation()" value="Submit" > 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
	<!----------------------------------------------------------------------------- Common Seek Response Reply  Edit end  ----------------------------------------------------->
	
  	 		  <!----------------------------------------------------  Dak Individual Reply View Modal Start    ----------------------------------------------------------->
		<div class="modal fade my-modal" id="IndividualReply-detailedModal" tabindex="-1" role="dialog" aria-labelledby="IndividualReply-detailedModal" aria-hidden="true">
	 	   <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header" style="background-color: #114A86; max-height: 55px;">
	 	        <h5  class="modal-title" style="margin-left: 2px;background-color: rgb(185, 217, 235);color: rgb(17, 74, 134);border-radius: 2px;padding-right: 8px;padding-left: 8px;" id="exampleModalLong2Title"><b>Marker Reply Preview</b> </h5>
	  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body" align="center" >
	  	      <div class="IndividualReplyDetails" >  
	  	      	</div>

	  	      </div>
	  	      <br>
	  	         <!-- -----------DAK MultipleCaseworkerReply Of Specific MarkerDiv Within another Modal START --------------------------- --> 	
		 <div class="group" id=FCReplyOfParticularMarker style="display:none;">	
		 	<form action="#" method="post" autocomplete="off" id="FCOfParticularMarkerPreviewForm" >
		 	   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	<div class="modal-body" align="center" style="margin-top:-30px;">
				<div class="col-md-12" id="MarkerReplyModalFacilitatorPreview" style="box-shadow: rgba(3, 102, 214, 0.3) 0px 0px 0px 3px;border-radius:2px;">
				
				<h5>Facilitator's Reply Details <span style="color:blue;margin-top:10px;" class="MarkerNameAndDesig"></span></h5>
				<div class="MarkerFacilitatorDakReplyData"  style="margin-left: 0px;width:100%;">  
				<!-- all the datas inside this is filled using javascript -->
				</div>
				</div>
					</div>		
					</form>
			
		 </div>
		  <!-- -----------DAK MultipleCaseworkerReply Of Specific MarkerDiv Within another Modal  END--------------------------- --> 
  	      		
	  	      
	  	      
	  </div>	      
	 </div>
	  </div>
	  <!----------------------------------------------------  Dak Individual Reply View Modal End    ----------------------------------------------------------->
	 
  <!-------------------------  Dak CSW Reply View more Modal Start    ----------------------------------------------------------->
	<div class="modal fade my-modal" id="replyCSWViewMore" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	 <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    	<div class="modal-content" style="min-height: 90%!important;">
	 	     
	 	      <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="casemodel-card-header" style="color: #145374">Assign Reply Data&nbsp; <span id="cswreplierName"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">×</span>
				        </button>
				    </div>
	 	  
	  	     <div class="modal-body" style="padding: 0.5rem !important; height: 50% !importatnt;">
	  	       <div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
	  	           <div class="row" id="replyCSWViewMoreDetailsDiv">
	  	      		</div>
	  	      	</div>	
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  DakCSW  Reply View more Modal end    ----------------------------------------------------------->

 <!----------------------------------------------------  Dak Seek Response Reply View more Modal Start    ----------------------------------------------------------->
	<div class="modal fade my-modal" id="SeekResponsereplyViewMore" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	 <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    	<div class="modal-content" style="min-height: 90%!important;">
	 	     
	 	      <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374">Seek Response Reply Data&nbsp; <span id="SeekResponsereplierName"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">×</span>
				        </button>
				    </div>
	 	     
	 	  
	  	     <div class="modal-body" style="padding: 0.5rem !important;">
	  	       <div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
	  	           <div class="row" id="SeekResponsereplyDetailsDiv">
	  	      		</div>
	  	      	</div>	
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  Dak Seek Response Reply View more Modal Start    ----------------------------------------------------------->
		 
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
        <button type="submit" class="btn btn-sm icon-btn" name="downloadbtn" id="largedocument" value="'+result[1]+'" formaction="OpenAttachForDownload.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>






<!-- Marker PDF Viewer Modal -->
<div class="modal fade" id="myModalMarkerlarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
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
        <button type="submit" class="btn btn-sm icon-btn" name="markerdownloadbtn" id="markerlargedocument"  formaction="ReplyDownloadAttach.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>


<!-- Case Worker PDF Viewer Modal -->
<div class="modal fade" id="myModalCSWlarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
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
        <button type="submit" class="btn btn-sm icon-btn" name="cswdownloadbtn" id="cswlargedocument"  formaction="ReplyCSWDownloadAttach.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>

  
  <!--P&C DO Reply PDF Viewer Modal -->
<div class="modal fade" id="myModalPnCReplylarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
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
        <button type="submit" class="btn btn-sm icon-btn" name="pncReplyDownloadBtn" id="PnClargedocument"  formaction="PnCReplyDownloadAttach.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>


 <!-- -----------------------------------------------------------DakAssign Return Reply Modal start  ------------------------------------------------------------------------------------------ -->
  
  
<div class="modal fade my-modal" id="exampleModalAssignReplyReturn"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" >
 	    <div class="modal-content" style="height: 400px;">
 	      <div class="modal-header">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b>DAK Assign Return Reply</b></h5> </div>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      	<form action="CSWReplyForwardReturn.htm" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="row">
  	      			<div class="col-md-3"> Return Remarks</div>
  	      		<div class="col-md-9">
  	      				<textarea class="form-control" style="height: 100px;;"   name="ReturnReplyremarks"  id="ReturnReplyremarks" required="required"  maxlength="255" > </textarea>
  	      			</div>
  	      			<input type="hidden" name="DakAssignReplyIdFrReturn" id="CSWForwardReturnId" value="">
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
	<!-------------------------------------------------------------------------------------------------------------------- DakAssign Return Reply Modal end ---------------------------- -->
	
<!----------------------------------------------------   Facilitaor's Reply's of Specific Marker WITH INDEPENDENT MODAL Start    ----------------------------------------------------------->
  <div class="modal fade my-modal" id="FacilitaorsReplyOfSpecificMarkerModal" tabindex="-1" role="dialog" aria-labelledby="FacilitaorsReplyOfSpecificMarkerModal" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 75% !important; min-height: 70vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;">
		 	 <h5 class="modal-title" id="exampleModalLongTitle">
		 	 <b style="color: white;">Facilitator's Reply Details <span style="color:white;" class="NameAndDesigOfMarker"></span></b></h5>
		 	 <button type="button" class="close" data-dismiss="modal"style="float:right; color: white;" aria-label="Close">
  	         <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  
  	     
		 <div class="modal-body" align="center" style="margin-top:-4px;">
		 <form action="#" id="MultipleFavilitatorReplyForm" >
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	         
		 
				<div class="FacilitaorsReplyOfSpecificMarkerData"  style="margin-left: 0px;width:100%;">  
				<!-- all the datas inside this is filled using javaScript -->
				</div>
				</form>
				</div>
			</div>
	 </div>
 </div>

<!----------------------------------------------------   Facilitaor's Reply's of Specific Marker WITH INDEPENDENT MODAL End     ----------------------------------------------------------->

<!----------------------------------------------------  Dak Tracking Modal jsp page Start  ----------------------------------------------------------->
	<div class="modal fade my-modal" id="ShowDakTrackingPage" tabindex="-1" role="dialog" aria-labelledby="ShowDakTrackingPage" aria-hidden="true">

	 	    	  <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 95% !important; min-height: 20vh !important; display: flex; align-items: stretch;" >
	 	    	
	 	    	<div class="modal-content" >
	 	     
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header" style="background-color: #114A86;height:2px;">
	 	        <h3 class="modal-title" id="exampleModalLong2Title" style="color:white;"></h3>
	  	        <button type="button" class="close" style="padding-top:0px!important;color:white!important;" data-dismiss="modal" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	 	     
	 	  
	  	      <div class="modal-body" align="center" style="margin-top:-4px;">
	  	   <div id="TrackingPageDataInsert" style=""></div>
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		</div>
		 <!----------------------------------------------------  Dak Tracking Modal jsp page End      ----------------------------------------------------------->


	<form action="DakTracking.htm" name="trackingform" id="dakStatusTrackingForm" method="POST" target="_blank" >
		
		<input type="hidden" name="dakId" id="dakIdFrTrackingDakStatus" />
		<input type="hidden" name="redirectValTracking" id="redirectionByTrackingPage" />
		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	</form>
	

	<!-- Loading  Modal -->
	
<div class="modal fade my-modal" id="pleasewait" style="display: none;" tabindex="-1" role="dialog" aria-labelledby="pleasewait" aria-hidden="true" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document">
    <div class="modal-content loadingContent">
      <div class="loader"></div>
      <div class="message">Please Wait...</div>
    </div>
  </div>
</div>
		<!-- Loading  Modal End-->

</body>
<script>
  function handleSelectChange() {
    var selectElement = document.getElementById('AllDakLinkId');
    
  } 
  </script>
	
 	<script>
 		function TrackingStatusPageRedirect(dakid,redirectVal){
 			$('#dakIdFrTrackingDakStatus').val(dakid);
 			$('#redirectionByTrackingPage').val(redirectVal);
 			//Display the received content in new tab
             $('#dakStatusTrackingForm').submit();
 			
 			 // Make an AJAX request to your controller method
 		// Make an AJAX request to your controller method
 	        //$.ajax({
 	        //    type: 'GET', // You can use POST if needed
 	         //   url: 'DakTracking.htm', // URL of your controller method
 	         //   data: {
 	           //     dakId: dakid,
 	           //     redirectValTracking: redirectVal
 	          //  },
 	          //  success: function (data) {
 	               // Display the received content in modal
 	 	             // $('#TrackingPageDataInsert').html(data); // Assuming data contains your JSP content
 	 	             // $('#DAKNumber').text('DAK'); // Set the modal title if needed
 	 	             // $('#ShowDakTrackingPage').modal('show');
 	 	    
 	            //},
 	          //  error: function (error) {
 	          //      console.error('Error:', error);
 	          //  }
 	       // });

 	        
 			
 			
 		}
 		
 	</script>

 <script type="text/javascript">
 <!-- Common DAK Attach JS starts(used both in DAK Pending List & DAK Director List) -->
function uploadDoc(dakIdValue,type,dakNoValue,RedirectVal,fromDate,toDate,Source,PageNumber,RowNumber,dakCreateId){
 		$('#tab-1').prop('checked',true);
 		$('#dakidvalue').val(dakIdValue);
 		$('#dakidvalue2').val(dakIdValue);
 		$('#type').val(type);
 		$('#type2').val(type);
 		$('#daknovalue').val(dakNoValue);
 		$('#daknovalue2').val(dakNoValue);
 		$('#DakAttachFrmDt').val('').val(fromDate);
 		$('#DakAttachToDt').val('').val(toDate);
 		$('#DakAttachFrmDt2').val('').val(fromDate);
 		$('#DakAttachToDt2').val('').val(toDate);
 		$('#DelAttachFrmDt').val('').val(fromDate);
 		$('#DelAttachToDt').val('').val(toDate);
 		
 		$('#subPageNumber').val(PageNumber);
 		$('#subRowNumber').val(RowNumber);
 		
 		$('#dakAttachmentDakNo').html(dakNoValue);
 		$('#dakAttachmentSource').html(Source);
 		
 		$('#PageNumber').val(PageNumber);
 		$('#RowNumber').val(RowNumber);
 		$('#dakCreateId').val(dakCreateId);
 		
 		if(dakCreateId==null){
 			$('#dakdocumentMainDoc').css('display','block');
 			$('#subdakdocumentMainDoc').css('display','block');
 			$('#dakdocumentSubDoc').css('display','block');
 			$('#sub2dakdocumentSubDoc').css('display','block');
 		}else{
 			$('#dakdocumentMainDoc').css('display','none');
 			$('#subdakdocumentMainDoc').css('display','none');
 			$('#dakdocumentSubDoc').css('display','none');
 			$('#sub2dakdocumentSubDoc').css('display','none');
 		}
 		$('#ModalDakAttachments').modal('toggle');
 		$('.downloadtable').css('display','none');
 		
            /*for redirection purpose only*/
 	 		$('#redirectFrAttach').val(RedirectVal);
 	 		$('#redirectFrAttach2').val(RedirectVal);
 	 		$('#redirectValFrDelAttach').val(RedirectVal);
 		
 	 		
 	 		$('#DeletePageNumber').val(PageNumber);
 	 		$('#DeleteRowNumber').val(RowNumber);
        $.ajax({
 			
 			type : "GET",
 			url : "GetAttachmentDetails.htm",
 			data : {
 				dakid: dakIdValue,
 				attachtype:type,
 				dakNo: dakNoValue
 			},
 			datatype : 'json',
 			success : function(result) {
 			var result = JSON.parse(result);
 			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
			var otherHTMLStr = '';
			for(var c=0;c<consultVals.length;c++)
			{var other = consultVals[c];
			
				otherHTMLStr +=	'<tr> ';
				otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >'+ (c+1) +'.</span> </td> ';
				otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >'+ other[3] +'.</span> </td> ';
				otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >';
				otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" onclick="Iframepdf('+other[2]+')" style="width:50%;" data-toggle="tooltip" data-placement="top" ><img alt="attach" src="view/images/download1.png"></button>'; 
 				/* otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:35%;"  onclick="deleteForm('+other[2]+')" ><img alt="attach" src="view/images/delete.png"></button>';  */
 				otherHTMLStr +=	'</td></tr> ';
            }
			
			if(consultVals.length>0){
				$('.downloadtable').css('display','');
			}
			if(type=='M'){
			$('#other-list-table').html(otherHTMLStr);
			}else{
				$('#other-list-table2').html(otherHTMLStr);
			}
			$('[data-toggle="tooltip"]').tooltip()
			}
 		});

 	}
 	
 	function tabChange(type){
 		var value;
 		var dakCreateIdVal=$('#dakCreateId').val();
 		if(type=='M'){
			value=$('#dakidvalue').val();
			$('#type').val(type);
			}else{
				value=$('#dakidvalue2').val();
				$('#type2').val(type);
			}
 			$('.downloadtable').css('display','none');
 	 		
            $.ajax({
			
			type : "GET",
			url : "GetAttachmentDetails.htm",
			data : {
				
				dakid: value,
				attachtype:type
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
			
			var otherHTMLStr = '';
			for(var c=0;c<consultVals.length;c++)
			{
				var other = consultVals[c];
			
				otherHTMLStr +=	'<tr> ';
				otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >'+ (c+1) +'.</span> </td> ';
				otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >'+ other[3] +'.</span> </td> ';
				otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >';
				otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" onclick="Iframepdf('+other[2]+')" data-toggle="tooltip" data-placement="top" style="width:50%; float:left;" ><img alt="attach" src="view/images/download1.png"></button>'; 
				if(type=='S' && dakCreateIdVal == null){
				otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:50%; float:left;" onclick="deleteForm('+other[2]+')" ><img alt="attach" src="view/images/delete.png"></button>'; 
				}
				otherHTMLStr +=	'</td></tr> ';
          }
			
			if(consultVals.length>0){
				$('.downloadtable').css('display','');
			}
			if(type=='M'){
			$('#other-list-table').html(otherHTMLStr);
			}else{
				$('#other-list-table2').html(otherHTMLStr);
			}
			$('[data-toggle="tooltip"]').tooltip()
				
				
			}
		});
 	}
 	
 	 function deleteForm(value){
 		 $('#dakattachmentid').val(value);
 		 
 		 var result = confirm ("Are You sure to Delete ?"); 
 		 if(result){
 			 $('#deleteform').submit();
 		 }
 		 
 	 }
 	 
 	function submitattachMainDoc(){
 		// Check if the file input is empty
 	    var fileInput = document.getElementById("dakdocumentMainDoc");
 	    if (!fileInput.files || fileInput.files.length === 0) {
 	        alert("Please attach a document to submit.");
 	        return false; // Prevent form submission
 	    }

 	    var res = confirm('Your Replacing the old Document! Are You Sure To Submit?');
 	    if (res) {
 	        // Programmatically trigger the form submission
 	        $('#attachformMainDoc')[0].submit();
 	    } else {
 	        event.preventDefault();
 	    }
 		}
 		
 		
 	function submitattachSubDoc(){
 		  var fileInput = document.getElementById("dakdocumentSubDoc");
 		    if (!fileInput.files || fileInput.files.length === 0) {
 		        alert("Please attach a document to submit.");
 		        return false; // Prevent form submission
 		    }

 		    var res = confirm('Are You Sure To Submit?');
 		    if (res) {
 		        // Programmatically trigger the form submission
 		        $('#attachformSubDoc')[0].submit();
 		    } else {
 		        event.preventDefault();
 		    }
 		
 		}

 </script>
  <!-- Common DAK Attach JS Ends -->
  <!-- Common DAK Marking JS starts(used both in DAK Pending List & DAK Director List) -->
 <script>
 function DakMarking(value,Action,date,ActionRequired,RedirectVal,dakno,source,fromdate,todate){
	 $('#exampleModalmarkgroup').modal('show');
	 $("#DakMarkingId").val(value);
	 $("#DakMarkingAction").val(Action);
	 $("#DakMarkingActionDueDate").val(date);
	 $("#DakMarkingActionRequired").val(ActionRequired);
	 $('#dakMarkingpendingListDakNo').html(dakno);
	 $('#dakMarkingpendingListSource').html(source);
	 $("#RedirectValMarking").val(RedirectVal);
	 $('#dakmarkingfromdate').val(fromdate);
	 $('#dakmarkingTodate').val(todate);
	
	 $.ajax({
		  type: "GET",
		  url: "getDakMeberslist.htm",
		  datatype: 'json',
		  success: function(result) {
		    if (result != null) {
		      result = JSON.parse(result);
		      var Data = Object.keys(result).map(function(e) {
		        return result[e];
		      });

		      $('#Commonindividual').empty();
		      var option=null;
		      for (var c = 0; c < Data.length; c++) {
		    	  
		        var optionValue = Data[c][0];
		        var optionText = Data[c][1] ;
		        option = $("<option></option>").attr("value", optionValue).text(optionText);
		        $('#Commonindividual').append(option);
		      }
		      option = $("<option></option>")
			  .attr("value", 0)
			  .text("Individual");
		      $('#Commonindividual').append(option);
		      $('.selectpicker').selectpicker('refresh');
		    }
		  }//success close
		});//ajax close
		MarkGroup();
 }
 </Script>
 <Script>
 $(document).ready(function(){	
 	$("#Commonindividual").trigger("change");
 });

 $("#Commonindividual").change(function(){
 	  var value = [];
 	  $("select[name='Commonindividual[]'] option:selected").each(function() { // Fix the selector here
 		  value.push($(this).val());
 		  });

 	  $.ajax({
 	    type: "GET",
 	    url: "getSelectEmpList.htm",
 	    data: {
 	      empId: value
 	    },
 	    datatype: 'json',
 	    success: function (result) {
 	      var result = JSON.parse(result);
 	      var consultVals = Object.keys(result).map(function (e) {
 	        return result[e];
 	      });

 	      var selectedEmployees = [];
 	      $("#CommonempidSelect option:selected").each(function () {
 	        selectedEmployees.push($(this).val().split(",")[0]);
 	       
 	      });
 	      $('#CommonempidSelect').empty();
 		  
 	      for (var c = 0; c < consultVals.length; c++) {
 	    	  
 	        var optionValue = consultVals[c][0] + '/' + consultVals[c][3];
 	        var optionText = consultVals[c][1] + ', ' + consultVals[c][2];
 	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
 	        if (selectedEmployees.includes(optionValue.split(",")[0])) {
 	          option.prop('selected', true);
 	          
 	        }
 	        $('#CommonempidSelect').append(option);
 	        
 	        
 	        
 	      }
 	      $('.selectpicker').selectpicker('refresh');
 	     
 	    }
 	  });
 	});
 

 function CommonaddEmpToSelect(){
	    /* var selectedItem = $('#empidSelect').val(); */
	    var options = $('#CommonempidSelect option:selected');
	    var selected = [];
	    var otherHTML = '';
		var id='indEmployees';
		var count=1;
	    $(options).each(function(){
		    otherHTML += '<span style="margin-left:2%" id="id">'+count+'.  '+' '+$(this).text()+'</span><br>';
		    count++;
		    selected.push($(this).val());
	    });
	    $('#CommonEmpIdIndividual').val(selected);
	    $('#CommonIndEmp').html(otherHTML);
	    
	}
 
 </script>
 
 <script>
	 function MarkGroup(){
	 $.ajax({
		  type: "GET",
		  url: "getDakGroupMeberslist.htm",
		  datatype: 'json',
		  success: function(result) {
		    if (result != null) {
		      result = JSON.parse(result);
		      var Data = Object.keys(result).map(function(e) {
		        return result[e];
		      });

		      $('#CommonGroupname').empty();
		      for (var c = 0; c < Data.length; c++) {
		    	  
		        var optionValue = Data[c][0];
		        var optionText = Data[c][1] ;
		        var option = $("<option></option>").attr("value", optionValue).text(optionText);
		       /*  if(Data[c][1]==='DP-C'){
		        	 option.prop('selected', true);
		        } */
		        $('#CommonGroupname').append(option);
		      }
		      $('.selectpicker').selectpicker('refresh');
		    }
		    $('#CommonGroupname').change();
		  }//success close
	 
		});//ajax close
	 
 }
 </script>
 
 <script>
$("#CommonGroupname").change(function(){
	var data = [];
	  $("select[name='CommonGroupname[]'] option:selected").each(function() { // Fix the selector here
	    data.push($(this).val());
	  });
	 
	  $('#CommonGroupEmp').empty();
	  
	
	  if (data.length === 0) {
	        // Clear data and perform necessary actions when no options are selected
	        $('#GroupEmp').empty();
	        $('#CommonEmpIdGroup').val('');
	        return; // Exit the function
	    }
	 
   $.ajax({
	   
			type : "GET",
			url : "getDakmemberGroupEmpList.htm",
			datatype : 'json',
			data : {
				
				  Group: data
				
			},
			
			success : function(result) {
		    if (result != null) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
			var otherHTMLStr = '';
			var id='Employees';
			var count=1;
			var EmpId=[];
			
			for (var c = 0; c < consultVals.length; c++) {
			    var Temp = id + (c+1);
			    otherHTMLStr += '<span style="margin-left:2%" id="name_'+ Temp +'">'+count+'. '+' '+consultVals[c][1]+' , '+' '+ ' '+consultVals[c][2]+'</span><br>';
			    count++;
			    var str=consultVals[c][0]+'/'+consultVals[c][3];
			    EmpId.push(str); 
			}
			var id= $('#CommonEmpIdGroup').val(EmpId);
			$('#CommonGroupEmp').html(otherHTMLStr);
			
			}
			}
});
});
</script>
 
 <!-- Common DAK Marking JS ends -->
   <!-- Common DAK Distribute JS starts(used both in DAK Pending List & DAK Director List) -->
<script>
 function DakDistribute(value,ActionFrm,dakno,source,fromdate,todate,ActionRequired,PageNo,RowNo){
	 $('#dakidDistribute').val(value);   
	 $('#actionDataDistribute').val(ActionFrm);  
	 $('#exampleModalmark').modal('show');
	 $('#dakAttachCountVal').empty();  
	 $('#dakpendingListDakNo').html(dakno);
	 $('#dakpendingListSource').html(source);
	 $('#dakdistributefromdate').val(fromdate);
	 $('#dakdistributeTodate').val(todate);
	 $('#PageNo').val(PageNo);
	 $('#RowNo').val(RowNo);
	  
	 $.ajax({
			
			type : "GET",
			url : "getDistributedEmps.htm",
			data : {
				
				dakId: value
				
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
			var otherHTMLStr = '';
			var pdHTMLStr = '';
            var id = 'Employees';
            var count = 1;
            var DakAttachCount;
            var EmpId = [];
            var lastCount = consultVals.length;
            otherHTMLStr='<div class="row"><div class="col-md-6"><b><span>&nbsp;&nbsp;&nbsp;&nbsp;SN. &nbsp;&nbsp;NAME & DESIGNATION</span></b></div><div class="col-md-3"><b ><span id="ActionTypeRequired" >ForInfo / ForAction</span></b></div><div class="col-md-3"><b><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Revoke</span></b></div></div><br>';
   
            for (var c = 0; c < consultVals.length; c++) {
                 var Temp = id + (c + 1);
                
                 
                 if(consultVals[c][0] != consultVals[c][6]){
                	 if(ActionRequired==='ACTION'){
                         otherHTMLStr += '<div class="row"><div class="col-md-6"><span class="MarkedEmpNameDisp" style="margin-left:2%" id="'+ Temp +'">'+count+'. '+consultVals[c][1]+' , '+consultVals[c][2]+'</span></div><div class="col-md-4"> <label class="switch"><input  data-identifier="AllMarkersOfDak" type="checkbox" id=markersAction_'+consultVals[c][0]+'  onclick="MarkersActionUpdate('+consultVals[c][0]+')" ><span class="slider"></span></label></div>';
                	 }else{
                     	  otherHTMLStr += '<div class="row"><div class="col-md-6"><span class="MarkedEmpNameDisp" style="margin-left:2%" id="'+ Temp +'">'+count+'. '+consultVals[c][1]+' , '+consultVals[c][2]+'</span></div><div class="col-md-4" "> <label style="display:none;" class="switchinfo"><input  data-identifier="AllMarkersOfDak" type="checkbox" id=markersAction_'+consultVals[c][0]+' disabled unchecked style="background-color: red;"><span class="sliderinfo"></span></label></div>';
                	 }
                	 otherHTMLStr += '<button class="MarkedEmpDeleteBtn" style="width:5%; height:40px;"  type="button" onclick="MarkedEmpsDeleteValidation(\'MarkedEmployeeDelete.htm\','+consultVals[c][0]+','+consultVals[c][3]+','+consultVals[c][4]+')" ><i class="fa fa-times" style="color:white;"></i></button><br>';
                     otherHTMLStr += '<br></div>';
                     count++;
                     //to bring PD atlast start
                 }else{
                     pdHTMLStr += '<div class="row"><div class="col-md-6"><span class="MarkedEmpNameDisp" style="margin-left:2%" id="'+ Temp +'">'+lastCount+'. '+consultVals[c][1]+' , '+consultVals[c][2]+'</span></div><div class="col-md-4"> <label class="switch"><input  data-identifier="AllMarkersOfDak" type="checkbox" checked="checked" id=markersAction_'+consultVals[c][0]+'  onclick="MarkersActionUpdate('+consultVals[c][0]+')" ><span class="slider"></span></label></div>';
                	 pdHTMLStr += '<button class="MarkedEmpDeleteBtn"  type="button"  disabled   style="background-color:green!important;cursor: none;width:4%; height:50px;" onclick="MarkedEmpsDeleteValidation(\'MarkedEmployeeDelete.htm\','+consultVals[c][0]+','+consultVals[c][3]+','+consultVals[c][4]+')" ><span style="color:white;">PD</span></button>';
                	 pdHTMLStr += '</div>';
                 }
                 //to bring PD atlast end
            //code to distribute
                
                 EmpId.push(consultVals[c][0]+'/'+consultVals[c][4]);
                 DakAttachCount = consultVals[c][5];
                 
                 
            }
        
            if(pdHTMLStr!=''){
            otherHTMLStr += pdHTMLStr;
            }
            
			 $('#EmpIdDistribute').val(EmpId);
			
			 $('#DakDistributeAppend').html(otherHTMLStr);
			
			 $('#dakAttachCountVal').val(DakAttachCount);  
			 
			 $('#Actioninput').val(ActionRequired);
			   MarkersDefaultActionUpdate();
			}
			
	 });
			
			
  }
 
 //Marker Action Js
 
function MarkersDefaultActionUpdate(){
	 var inputCheckboxes = document.querySelectorAll('[data-identifier="AllMarkersOfDak"]');
	 var defaultCheckboxvalues=[];
	 var totalEmployeesCount = inputCheckboxes.length;
	 var uncheckedCheckboxCount = 0;
	 for (var i = 0; i < inputCheckboxes.length; i++) {
	        var inputTag = inputCheckboxes[i];
	        inputTag.value = 'I';
	        defaultCheckboxvalues.push(inputTag.value);
	        
	        
	        if (!inputTag.checked) {
	            uncheckedCheckboxCount++;
	        }
	    }
	 
	 console.log("firstvalues:"+defaultCheckboxvalues);
	 $('#defaultCheckboxvalues').val(defaultCheckboxvalues);
	 
	 $('#TotalCountofEmp').val(totalEmployeesCount);
	 
	 $('#TotalInfoCount').val(uncheckedCheckboxCount);
 }
 
/*  $(document).ready(function(){ */
 
	var checkboxValueschecked = []; 
function MarkersActionUpdate(value){

	 var checkbox = document.getElementById("markersAction_"+value);
	 
	    if (checkbox) {
	        if (checkbox.checked) {
	            // Checkbox is checked, set value to 'A'
	           
	            checkbox.value = 'A';
	            if(!checkboxValueschecked.includes(value)){
	            checkboxValueschecked.push(value);
	            }
	        } else {
	            // Checkbox is not checked, set value to 'I'
	            checkbox.value = 'I';
	            if(checkboxValueschecked.includes(value)){
		            checkboxValueschecked=checkboxValueschecked.filter(item => item !== value);
		            }
	        }
	        console.log("****"+checkboxValueschecked);
	         $('#markedAction').val(checkboxValueschecked);
	    }
		    MarkersDefaultActionUpdate();
		 }
	 
	 

/*  }); */
 
 
 function DakDistributeSubmitValidation(){
   var confirmation;
   var dakAttachCount = document.getElementById("dakAttachCountVal");
   var TotalCountofEmp=document.getElementById("TotalCountofEmp");
   var TotalInfoCount=document.getElementById("TotalInfoCount");
   
   var empvalue=TotalCountofEmp.value;
   var infocount=TotalInfoCount.value;
   
     var selval=$('#Actioninput').val();
	 if(dakAttachCount){
		  var countValue = dakAttachCount.value;
		  if(selval==='ACTION' && empvalue===infocount){
		    	alert('Atleast select one Employee As For Action ..!');
		  }else if (countValue !== "" && parseInt(countValue, 10) <= 0) {
		    	confirmation = confirm("There are no attachments for this DAK. Are you sure to distribute this DAK ?");
		   }else{
		    	 confirmation = confirm("Are You Sure To Distribute this DAK ?");
		   }
	 }
	 
	 
	// var confirmation = confirm("Are You Sure To Distribute this DAK ?");
		if (confirmation) {
			var form = document.getElementById("DakDistributionForm");
		      if (form) {
		       var dakDistributeSubmitBtn = document.getElementById("DakDistriBtn");
		          if (dakDistributeSubmitBtn) {
		              var formactionValue = dakDistributeSubmitBtn.getAttribute("formaction");
		                console.log(formactionValue);
		               form.setAttribute("action", formactionValue);
		                form.submit();
                        $('#DakDistriBtn').hide();
                   	    $('#exampleModalmark').modal('hide');
                   	    $('#pleasewait').appendTo('body').modal('show');
		            }
		       }

				}else{
					$('#DakDistriBtn').show();
					$('#pleasewait').appendTo('body').modal('hide');
					$('#exampleModalmark').modal('show');
					
					
					return false;
					
				}
 }
 
 function MarkedEmpsDeleteValidation(formactionValue,empId,dakMemberTypeId,dakMarkingId) {
	 $('#EmpIdAppendFrDelete').val(empId);
	 $('#DakMemberTypeIdAppendFrDelete').val(dakMemberTypeId);
	 $('#DakMarkingIdAppendFrDelete').val(dakMarkingId);
	  var confirmation = confirm("Are You Sure To Delete this employee?");
	  if (confirmation) {
	    var form = document.getElementById("DakDistributionForm");
	    if (form) {
	      var MarkedEmpDeleteBtnFormAction = formactionValue;
	      form.setAttribute("action", MarkedEmpDeleteBtnFormAction); // Use the parameter formactionValue
	      form.submit();
	    }
	  } else {
	    return false;
	  }
	}
 
 </script>
 
<!-------------------------------- Common DAK Distribute JS ends -------------------------------------------->


<!-------------------------------- Common Preview JavaScript End -------------------------------------------->
<script type="text/javascript">


function tabChangeDakAttach(type){
		var value;
		if(type=='M'){
			value=$('#dakidvaluemaindoc').val();
			$('#typemaindoc').val(type);
			}else{
				value=$('#dakidvalueenclosure').val();
				$('#typeenclosure').val(type);
			}
			$('.downloadtabledakattach').css('display','none');
	 		
           $.ajax({
			
			type : "GET",
			url : "GetAttachmentDetails.htm",
			data : {
				
				dakid: value,
				attachtype:type
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
			

			
			var HTMLStr = '';
			for(var c=0;c<consultVals.length;c++)
			{
				var other = consultVals[c];
			
				HTMLStr +=	'<tr> ';
				HTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >'+ (c+1) +'.</span> </td> ';
				HTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >'+ other[3] +'.</span> </td> ';
				HTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >';
				HTMLStr +=	'	<button type="button" class="btn btn-sm icon-btn " style="width:70%;"  name="downloadbtn" value="'+other[2]+'" onclick="Iframepdf('+other[2]+')"  data-toggle="tooltip" data-placement="top"  ><img alt="attach" src="view/images/download1.png"></button>'; 
				HTMLStr +=	'</td></tr> ';

			}
			
			if(consultVals.length>0){
				$('.downloadtabledakattach').css('display','block');
				$('#NoAttachementsub').html('');
			}else{
				
				$('.downloadtabledakattach').css('display','none');
				var Attach='No Attachments Are Available !!';
				$('#NoAttachementsub').html(Attach);
			}
			if(type=='M'){
			$('#other-list-maindoc').html(HTMLStr);
			}else{
				$('#other-list-enclosure').html(HTMLStr);
			}
			$('[data-toggle="tooltip"]').tooltip()
				
				
			}
		});
           
         
           
	}


function tabChangesubDakAttach(type){
	var value;
	if(type=='M'){
		value=$('#dakidvaluemaindoc').val();
		$('#typemaindoc').val(type);
		}else{
			value=$('#dakidvalueenclosure').val();
			$('#typeenclosure').val(type);
		}
		$('.downloadtabledakattach').css('display','none');
 		
       $.ajax({
		
		type : "GET",
		url : "GetAttachmentDetails.htm",
		data : {
			
			dakid: value,
			attachtype:type
			
		},
		datatype : 'json',
		success : function(result) {
		var result = JSON.parse(result);
		var consultVals= Object.keys(result).map(function(e){
		return result[e]
		})
		

		
		var HTMLStr = '';
		for(var c=0;c<consultVals.length;c++)
		{
			var other = consultVals[c];
		
			HTMLStr +=	'<tr> ';
			HTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >'+ (c+1) +'.</span> </td> ';
			HTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >'+ other[3] +'.</span> </td> ';
			HTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >';
			HTMLStr +=	'	<button type="button" class="btn btn-sm icon-btn " style="width:70%;"  name="downloadbtn" value="'+other[2]+'" onclick="Iframepdf('+other[2]+')"  data-toggle="tooltip" data-placement="top"  ><img alt="attach" src="view/images/download1.png"></button>'; 
			HTMLStr +=	'</td></tr> ';

		}
		
		if(consultVals.length>0){
			$('.downloadtabledakattach').css('display','block');
			$('#NoAttachementsub').html('');
		}else{
			
			$('.downloadtabledakattach').css('display','none');
			var Attach='No Attachments Are Available !!';
			$('#NoAttachementsub').html(Attach);
		}
		if(type=='M'){
		$('#other-list-maindoc').html(HTMLStr);
		}else{
			$('#other-list-enclosure').html(HTMLStr);
		}
		$('[data-toggle="tooltip"]').tooltip()
			
			
		}
	});
       
     
       
}
	


function Preview(a,value) {
	//$('#assigned-details').appendTo('body').modal('show');
	$('#assigned-details').modal('show');
	var DakId=$('#DakId'+a).val();
	
	
	$('[id^="buttonbackground"]').css('background-color', '');
	$('#buttonbackground' + a).css('background-color', 'lightgreen');

	// Clear the old data by setting the HTML content of modal elements to an empty string
	  $('#Dakno, #lettertype, #Priority, #Source, #LetterNo, #LetterDate, #DakStatus, #KeyWord1, #KeyWord2, #KeyWord3, #KeyWord4, #Subject, #ProjectType, #Remarks,#ActionDueDate,#ActionTime,#ClosingAuthority,#DirectorApproval, #maindakdocs,#closingcomment, #subdakdocs,#PreviewSubject').html('');

	$.ajax({
		
		type : "GET",
		url : "getDakDetails.htm",
		data : {
			
			DakId: DakId
			
		},
		datatype : 'json',
		success : function(result) {
			if(result!=""){
				
		
		var result = JSON.parse(result);
		var consultVals= Object.keys(result).map(function(e){
		return result[e]
		})
		
		 var PreviewSubject = result[15];
		appendViewMoreButton($('#PreviewSubject'), PreviewSubject, 100, "SubjectViewMoreModal('" + DakId + "','" + PreviewSubject + "')");
      
		 $('#Dakno').html(result[9]);
		 $('#lettertype').html(result[2]);
		 $('#Priority').html(result[3]);
		 $('#Source').html(result[4]);
		 $('#LetterNo').html(result[5]);
		 var originalDate = result[7];
		 var dateObj = new Date(originalDate);
		 var day = dateObj.getDate();
		 var month = dateObj.getMonth() + 1; // Adding 1 because getMonth() returns zero-based month (0-11)
		 var year = dateObj.getFullYear();

		 // Formatting day and month with leading zeros if necessary
		 var formattedDay = day < 10 ? '0' + day : day;
		 var formattedMonth = month < 10 ? '0' + month : month;

		 // Generating the final formatted date string
		 var formattedDate = formattedDay + '-' + formattedMonth + '-' + year;
		 $('#LetterDate').html(formattedDate);
		 $('#DakStatus').html(result[8]);
		 $('#KeyWord1').html(result[11]);
		 $('#KeyWord2').html(result[12]);
		 $('#KeyWord3').html(result[13]);
		 $('#KeyWord4').html(result[14]);
		 $('#Subject').html(result[15]);
		 $('#LinkDak').html(result[9]);
		 $('#LinkDak').val(result[1]);
		 if(result[23]!=null && result[6]!==null && (result[6].trim()=='DC') ){
		 $('#closingcomment').html(result[23]);
		 $('#ClosingCommtTr').show();
		 }else{
			 $('#closingcomment').html('');
			 $('ClosingCommtTr').hide();
		 }
		 
		
		 
		 if(result[18]!=null){
			 var originalActDueDate = result[18];
			 var ActdateObj = new Date(originalActDueDate);
			 var Actday = ActdateObj.getDate();
			 var Actmonth = ActdateObj.getMonth() + 1; 
			 var Actyear = ActdateObj.getFullYear();
             var formattedActDay = Actday < 10 ? '0' + Actday : Actday;
			 var formattedActMonth = Actmonth < 10 ? '0' + Actmonth : Actmonth;
			 var formattedActDate = formattedActDay + '-' + formattedActMonth + '-' + Actyear;
			 
			 
			 $('#ActionDueDate').html(formattedActDate);
			 }else{
				 $('#ActionDueDate').html("NA");
			 }
			 
			 if(result[19]!=null){
				  var timeString = result[19];
				  var timeParts = timeString.split(" ");
				  var time = timeParts[0];
				  var period = timeParts[1];

				  var timeParts2 = time.split(":");
				  var hours = parseInt(timeParts2[0]);
				  var minutes = parseInt(timeParts2[1]);

				  if (period === "PM" && hours !== 12) {
				    hours += 12;
				  } else if (period === "AM" && hours === 12) {
				    hours = 0;
				  }

				  var formattedTime = ("0" + hours).slice(-2) + ":" + ("0" + minutes).slice(-2);
				  $('#ActionTime').html(formattedTime+" "+"Hrs");
			     }else{
				 $('#ActionTime').html("NA");
			     }
			
			 if(result[27]!=null){
				  $('#ClosingAuthority').html(result[27]);
		         }
			 
			 /* if(result[20]!=null &&  result[20]=="P"){
			  $('#ClosingAuthority').html("P&C DO");
	         }else if(result[20]!=null &&  result[20]=="A"){
		      $('#ClosingAuthority').html("Admin");
	         }else if(result[20]!=null &&  result[20]=="K"){
		      $('#ClosingAuthority').html("KRMD");
	         }else if(result[20]!=null &&  result[20]=="R"){
		      $('#ClosingAuthority').html("Purchase");
	         }else if(result[20]!=null &&  result[20]=="O"){
		      $('#ClosingAuthority').html("Others");
	         }else{
		      $('#ClosingAuthority').html("ERROR");
	         } */
			 
			 
			 if(result[21]!=null &&  result[21]=="R"){
				  $('#DirectorApproval').html("Required");
		         }else if(result[21]!=null &&  result[21]=="N"){
			      $('#DirectorApproval').html("Not Required");
		         }else{
			      $('#DirectorApproval').html("ERROR");
		         }
			 
		 if(result[16]=='P'){
		 $('#ProjectType').html('Project');
		 }else{
			 $('#ProjectType').html('Non-Project');
		 }
		 $('#Remarks').html(result[17]);
		 
		 
		 if(result[24]>0){
			 document.getElementById('AllDakLinkDisplay').style.display = 'block';
			 AllDakLinkList(value);
		 }else{
				 document.getElementById('AllDakLinkDisplay').style.display = 'none';
			 }
			 
		
			 
		 if(result[6]!==null && (result[6].trim()=='DD'  || result[6].trim()==='DD'  || result[6].trim()==='DA'  || result[6].trim()==='DR'|| result[6].trim()==='RM'  || result[6].trim()==='RP'  || result[6].trim()==='AP'  || result[6].trim()==='DC')){
			 document.getElementById('dakPrevDataPart2').style.display = 'block';
			 MarkedAssigned(value);
		 }else{
			 document.getElementById('dakPrevDataPart2').style.display = 'none';
		 }
		 
	
		 if(result[22]>0){
			 $('.dakmainDocumentsTab').css('display','');
			 $('.daksubDocumentsTab').css('display','');
		 }else{
			 $('.daksubDocumentsTab').css('display','none');
			 $('.dakmainDocumentsTab').css('display','none');
		 }
	
		 if(result[6].trim()==='DC' && result[26]!==null){
			 $('#ClosedBy').show();
		   var closedby=result[26];
			 DakClosedBy(closedby);
		 }else{
			 $('ClosedBy').hide(); 
		 }
		 
		 //---------P&C DO Reply Preview Js  Starts--------------------/
		 var logType = '<%= loginType %>';
			
		 if(result[6]!==null && result[20]!=null &&  result[20]!="O" && result[6].trim()!='RM'  && ( result[6].trim()=='DC' || result[6].trim()=='AP' || result[6].trim()=='RP' )   ){
			 console.log(result[6]);
			 resetPreviewButtons();
			 if(logType=="Z" || logType=="A" || logType=="E"){  //Authorized persons
			 $(".pncDoReplyData").empty(); 
			 $('.btnPNCDOReplyDetailsPreview').show();  
		    	//call the function
		        dakPNCDOeplyPreview(value);
		    	
			 }else if(logType!="Z" || logType!="A" || logType!="E"){ //Markers
				
				  $(".pncDoReplyData").empty(); 
			 $('.btnPNCDOReplyDetailsPreview').show();  
		    	//call the function
		        dakPNCDOeplyPreview(value);
				// $('.btnPNCDOReplyDetailsPreview').prop('disabled', true);
				  
			 }
		 }else{

			 $('.btnPNCDOReplyDetailsPreview').hide();  
	 	        // Clear previous data
	 		     $(".pncDoReplyData").empty(); 

		 }
			
	 		//---------P&C DO Reply Preview Js  ends--------------------/
	 		
	     //---------Marker Reply Preview Js  Starts--------------------
	       // Call dakMarkerReplyPreview function here with the desired parameters to display in modal    // Clear previous data
	             //resetPreviewButtons();
	             $(".DakReply").empty();
				 dakMarkerReplyPreview(DakId);
		 
	    //---------Marker Reply Preview Js  ends--------------------/
	    

     //---------CASEWORKER Reply Preview Js  Starts--------------------
       // Call dakCSWReplyPreview function here with the desired parameters to display in modal// Clear previous CSWDakReply div data
	          //resetPreviewButtons();
               $(".CaseworkerDakReplyData").empty(); 
	           dakCSWReplyPreview(value);
     
     
	            
	             //---------CASEWORKER Reply Preview Js  Ends--------------------/
	             
	             
	              //---------SEEK RESPONSE Reply Preview Js  Starts--------------------
       // Call SEEK RESPONSE ReplyPreview function here with the desired parameters to display in modal// Clear previous SEEK RESPONSE Reply div data
	          //resetPreviewButtons();
               $(".DakSeekResponseReply").empty(); 
	           dakSeekResponseReplyPreview(value);
     
     
	            
	             //---------CASEWORKER Reply Preview Js  Ends--------------------/
	           
			}
}
	});
	function appendViewMoreButton(container, text, maxLength, modalFunction) {
	    var shortenedText = text.length < maxLength ? text : text.substring(0, maxLength);

	    if (text.length > maxLength) {
	        var button = $("<button>", {
	            type: "button",
	            class: "viewmore-click",
	            name: "sub",
	            value: "Modify",
	            onclick: modalFunction
	        }).text("...(View More)");

	        container.text(shortenedText).append(button);
	    } else {
	        container.text(shortenedText);
	    }
	}	
	
	$('.downloadDakMainReplyAttachTable').empty();
	var maindoclength=0;
    
 	var mainstr = '';
     $.ajax({
		
		type : "GET",
		url : "GetAttachmentDetails.htm",
		data : {
			
			dakid: value,
			attachtype:'M'
			
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
		 //  mainstr +=   '<tr> ';
		//   mainstr +=   '  <td style="text-align: center;">';   
		//   mainstr +=  '  <form action="#" id="MainDocumentDownload" >';
		 //  mainstr +=  '  <input type="hidden" id="iframeData" name="downloadbtn">';
		   mainstr +=   '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply"  style="float:left!important;" value="'+other[2]+'"  onclick="Iframepdf('+other[2]+')"  data-toggle="tooltip" data-placement="top" title="Download"   >' + other[3] + '</button>';
		 //  mainstr +=   '  </form>';
		 //  mainstr +=   '  </td>';
		  // mainstr +=   '</tr> ';	
		   
		   //otherHTMLStr += '    <button type="button" class="btn btn-sm DakLinkAttach-btn" name="DakLinkModalPrevBtn" id="DakId"'+consultVals[c][0]+' data-toggle="tooltip" data-placement="top" title="Download"   >' + count + '.'+ consultVals[c][1] +'</button>';
		   if(maindoclength>0){
				$('.downloadDakMainReplyAttachTable').html(mainstr);
				$('#maindakdocslabel').css('display','block');
				$('#maindakdocs').css('display','block');
			}else{
				$('#maindakdocslabel').css('display','none');
				$('#maindakdocs').css('display','none');
			}
           
	}
		}
     });
     
     
     
     //-------------------------- Enclousure code  -------------------------------->
    
     $('.downloadsubDakReplyAttachTable').empty();
     var subdoclength=0;
     var HTMLStr = '';
     $.ajax({
		
		type : "GET",
		url : "GetAttachmentDetails.htm",
		data : {
			
			dakid: value,
			attachtype:'S'
			
		},
		datatype : 'json',
		success : function(result) {
		var result = JSON.parse(result);
		var consultVals= Object.keys(result).map(function(e){
	return result[e]
	})
	

		subdoclength=consultVals.length;
	for(var c=0;c<consultVals.length;c++)
	{
		var other = consultVals[c];
		 // HTMLStr +=   '<tr> ';
	      // HTMLStr +=   '  <td style="text-align: center;">';   
	      // HTMLStr +=  '  <form action="#" id="EnclosuresDownload">';
	   //    HTMLStr +=  '  <input type="hidden" id="iframeData" name="downloadbtn">';
	       HTMLStr +=   '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply"  style="float:left!important;" value="'+other[2]+'"  onclick="Iframepdf('+other[2]+')"  data-toggle="tooltip" data-placement="top" title="Download"   >' + other[3] + '</button>';
	     //  HTMLStr +=   '  </form>';
	     //  HTMLStr +=   '  </td>';
	     //  HTMLStr +=   '</tr> <br>';
	       if(subdoclength>0){

	   		$('.downloadsubDakReplyAttachTable').html(HTMLStr);
	   		$('#subdakdocslabel').css('display','block');
	   		$('#subdakdocs').css('display','block');
	   	}else{
	   		$('#subdakdocslabel').css('display','none');
	   		$('#subdakdocs').css('display','none');
	   	}
	}
		}
     });

     
    
    
}


function DakClosedBy(closedby){
	 $('#closedBy').empty();
	    console.log("closedby:"+closedby);
	    $.ajax({
	        type: "GET",
	        url: "getClosedByName.htm",
	        data: {
	        	closedby: closedby
	        },
	        datatype: 'json',
	        success: function (result) {
	        	   if (result != null && result != '') {
	                   result = JSON.parse(result);
	                   var consultVals = Object.keys(result).map(function (e) {
	                       return result[e];
	                   });

	                   $('#closedBy').html(result[0]+", "+result[1]);
	        }
	        }
	        }); 
	 
}
</script>

<script>
var details=null;
function handleSelectChange(selectElement) {
    var id= $('#AllDakLinkId').val();
  
   var selectedOptions = selectElement.selectedOptions;

   for (var i = 0; i < selectedOptions.length; i++) {
     var option = selectedOptions[i];
     var optionValue = option.value;

     if (optionValue !== '0') {
       var notApplicableOption = selectElement.querySelector('option[value="0"]');
       notApplicableOption.selected = false;
     }else{
    	 var notApplicableOption = selectElement.querySelector('option[value="0"]');
         notApplicableOption.selected = true;
     }
   } 
   details=view(id);
}

function view(id) {
	var temp=null;
	 for (var i = 0; i < id.length; i++) {
	        if (i === id.length - 1) {
	            temp = id[i];	
	           if(details<=id.length){
	        	   console.log("id@@@"+id[i]);
	        	   
	        	   Preview(id[i],id[i]);
	        	   
	            /* $('#assigned-details').modal('show'); */
	           }
	        }
	    }
	 count=id.length;

	return count;
}

</script>

<!-- JavaScript for Getting Marked and Assigned Employee List Start -->
<script>
function openLinkDak(id) {
	Preview(id,id,'Y','NA','NA');
	
}
function MarkedAssigned(dakIdVal) {
    $('#dakidvalueforlist').val(dakIdVal);
    $('#DistributedListDisplay').empty();
    $.ajax({
        type: "GET",
        url: "getDistributedAndAssignedEmps.htm",
        data: {
            dakId: dakIdVal
        },
        datatype: 'json',
        success: function (result) {
            if (result != null && result != '') {
                result = JSON.parse(result);
                var consultVals = Object.keys(result).map(function (e) {
                    return result[e]
                })
                var otherHTMLStr = '';
                var id = 'Employees';
                var count = 1;
                var EmpId = [];
                for (var c = 0; c < consultVals.length; c++) {
                     var Temp = id + (c + 1);
                     if (parseInt(consultVals[c][3]) === 0) {
                       if(consultVals[c][4]==='I'){
                    	 
                    	 otherHTMLStr += '<span style="margin-left:2%;color: #0073FF;" id="' + Temp + '"> ' + count + '.'+ consultVals[c][1] + ' , ' + consultVals[c][2] + '</span><br>';
                       }else{
                    	   otherHTMLStr += '<span style="margin-left:2%;color: #0B6623;" id="' + Temp + '"> ' + count + '.'+ consultVals[c][1] + ' , ' + consultVals[c][2] + '</span><br>';
                       }
                     
                     
                     } else {
                    	 
                    	 if(consultVals[c][4]==='I'){
                        	 
                        	 otherHTMLStr += '<span style="margin-left:2%;color: #0073FF;" id="' + Temp + '"> ' + count + '.'+ consultVals[c][1] + ' , ' + consultVals[c][2] + '</span>';
                           }else{
                        	   otherHTMLStr += '<span style="margin-left:2%;color: #0B6623;" id="' + Temp + '"> ' + count + '.'+ consultVals[c][1] + ' , ' + consultVals[c][2] + '</span>';
                           }
                           //call function for multiple facilitators below is the ajax code for it
                            MultipleCaseworkersList( consultVals[c][0],dakIdVal,Temp);
                           //from above function facilitators will be added  using ajax
                    }
                    count++;
                    EmpId.push(consultVals[c][0]);
                }
                $('#empidvalueforlist').val(EmpId);
                $('#DistributedListDisplay').html(otherHTMLStr);

            } else {
                var noEmployeesHTML = '<img src="view/images/infoicon.png" style="cursor: none; "/>&nbsp;&nbsp;<span style="color:#2196F3">No Employees Marked for this DAK</span>';
                $('#DistributedListDisplay').html(noEmployeesHTML);
            }
        }
    });
}
function AllDakLinkList(DakId) {
    $('#dakidvaluefordaklinklist').val(DakId);
    $('#AllDakLinkDisplay').empty();
    $.ajax({
        type: "GET",
        url: "getDakLinkData.htm",
        data: {
        	DakId: DakId
        },
        datatype: 'json',
        success: function (result) {
            if (result != null && result != '') {
                result = JSON.parse(result);
                var consultVals = Object.keys(result).map(function (e) {
                    return result[e]
                })
                var otherHTMLStr = '';
                var id = 'Employees';
                var count = 1;
                var SelDakLinkId = [];
                for (var c = 0; c < consultVals.length; c++) {
                     var Temp = id + (c + 1);
                     if(consultVals[c][0]>0){
                    	 
                    	 /* onclick="Preview(' + consultVals[c][0] + ', \'' + consultVals[c][0] + '\', \'Y\', \'NA\', \'NA\', \'N\')" */
                    	
                    	 otherHTMLStr += '    <button type="button" class="btn btn-sm DakLinkAttach-btn" name="DakLinkModalPrevBtn" id="DakId"'+consultVals[c][0]+' data-toggle="tooltip" data-placement="top" title="Download"   >' + count + '.'+ consultVals[c][1] +'</button>';

                    
                    count++;
                    SelDakLinkId.push(consultVals[c][0]);
                
                $('#selecteddaklinkidlist').val(SelDakLinkId);
                $('#AllDakLinkDisplay').html(otherHTMLStr);
                }else{
                	document.getElementById('AllDakLinkDisplay').style.display = 'none';
                }
                }
            } else {
                var nOLinkdak = '<img src="view/images/infoicon.png" style="cursor: none; "/>&nbsp;&nbsp;<span style="color:#2196F3">No LinkDaK for this DAK</span>';
                $('#AllDakLinkDisplay').html(nOLinkdak);
            }
        }
    });
}




function MultipleCaseworkersList(MarkerEmpId,DakId,Temp){
    $('#appendFacilitators').empty();
    
    $.ajax({
        type: "GET",
        url: "getFacilitatorsEmpDetails.htm",
        data: {
        	markerEmpId: MarkerEmpId,
        	dakId: DakId
        },
        datatype: 'json',
        success: function (result) {
        	   if (result != null && result != '') {
                   result = JSON.parse(result);
                   var consultVals = Object.keys(result).map(function (e) {
                       return result[e];
                   });
                   

                   var facilitatorHTMLStr = '';
                   var id = 'Facilitators';
                   var count = 1;

                  facilitatorHTMLStr = '<ul>'; // Open the <ul> here

                  
                  for (var c = 0; c < consultVals.length; c++) {
                      var faci = id + (c + 1);
                       facilitatorHTMLStr += '<li style="color: #FF8C00;" id="' + faci + '">' + count + '.' + consultVals[c][4] + ' , ' + consultVals[c][5] + '</li>';
                       count++;
                  }

                   facilitatorHTMLStr += '</ul>'; // Close the <ul> here
                   $('#' + Temp).next('ul').remove(); // Remove previous <ul> if exists
                   $('#' + Temp).after(facilitatorHTMLStr); // Append the new <ul>
               } else {
                   $('#' + Temp).next('ul').remove(); // Remove previous <ul> if no data
               }
        }
        });         
}

</script>
<!-- JavaScript for Getting Marked and Assigned Employee List End -->
<script>
	function dakMarkerReplyPreview(dakId){

		
		$.ajax({
			 type : "GET",
				url : "GetReplyModalDetails.htm",
				data : {
					
					dakid: dakId
					
					
				},
				datatype : 'json',
				success : function(result) {
					
					if(result !=null && result!="[]"){
						//reset previously selected toggle  its important
			       	     resetPreviewButtons();
			    		
			       	   //display the hidden btnReplyDetailsPreview div 
			        	 $('.btnReplyDetailsPreview').show(); 
			       	   
			        	 // Clear previous data
					        $(".DakReply").empty();
						
						
						 var replyData = JSON.parse(result); // Parse the JSON data
						 
						 const replyCountOverall = parseInt( replyData[0][12]);
				    	 const replyCountByEmpId = parseInt( replyData[0][13]);
				    	 const replyCountByAuthority = parseInt( replyData[0][14]);
				    	 
				    
				    	 if (  replyCountOverall > 0 || (replyCountByEmpId > 0 ||  replyCountByAuthority > 0)){
					
						 
						 for (var i = 0; i < replyData.length; i++) {
							    var row = replyData[i];
							    var repliedPersonName = row[6];
								$('#replierName').val(repliedPersonName);
							    var repliedPersonDesig = row[7];
							    var repliedRemarks = row[2];
							    var replyid= row[0];
							    var replyEmpId=row[1];
							    var loggedInEmpId = <%= EmpId %>;
							    var action = row[10];
							    var dakStatus = row[11];
							    var DateTime=row[5];
							    
							    var date = new Date(DateTime);

								 // Format the date and time
								 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
								     month: 'short',
								     day: 'numeric',
								     year: 'numeric',
								     hour: 'numeric',
								     minute: 'numeric'
								 }).format(date);
							  
							    var dynamicReplyDiv = $("<div>", { class: "DAKReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
							    dynamicReplyDiv.after("<br>");
							    var h4 = $("<h4>", { 
							    	  class: "RepliedPersonName", 
							    	  id: "model-person-header", 
							    	  html: (i + 1) + ". " + repliedPersonName + ", " + repliedPersonDesig + ",  <span style='color: black; font-size:15px;'> " + formattedDateTime + "</span>" 
							    	});
							    dynamicReplyDiv.append(h4);//appended h4
							   
							    var replyEditButton = $("<button>", {
							    	  type: "button",
							    	  class: "btn btn-sm icon-btn replyedit-click",
							    	  "data-toggle": "tooltip",
							    	  "data-placement": "top",
							    	  title: "Edit",
							    	  onclick: "replyCommonEdit('" + replyid + "')"
							    	});
							    
                                var editImage = $("<img>", { alt: "edit",src: "view/images/writing.png"});
                                replyEditButton.append(editImage);
                               
                                if(replyEmpId == loggedInEmpId && dakStatus!="DC" && dakStatus!="AP"){
   							      dynamicReplyDiv.append(replyEditButton);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
   							  }
							    
							    
							     var replyForwardForEditBtn  = $("<button>", {
							    	  type: "button",
							    	  class: "btn btn-sm icon-btn replyforwardforedit-click",
							    	  "data-toggle": "tooltip",
							    	  "data-placement": "top",
							    	  title: "Reply Forward",
							    	  onclick: "replyForwardForEdit('" + replyid + "')"
							    	});
							    
                                var forwardForEditImage = $("<img>", { alt: "edit",src: "view/images/replyChange.png"});
                                if(dakStatus!="DC" && dakStatus!="AP"){
                                replyForwardForEditBtn.append(forwardForEditImage);
                                }
                              
              
                              dynamicReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
                              
                              
							    var innerDiv = $("<div>", { class: "row replyRow" });
							    
							    var formgroup1 = $("<div>", { class: "form-group group1" });
							
							    var replyText = repliedRemarks.length < 140 ? repliedRemarks : repliedRemarks.substring(0, 140);
							    var replyDiv = $("<div>", { class: "col-md-12 replyremarks-div", contenteditable: "false" }).text(replyText);
							    
							    if (repliedRemarks.length > 140) {
							        var button = $("<button>", {
							            type: "button",
							            class: "viewmore-click",
							            name: "sub",
							            value: "Modify",
							            onclick: "replyViewMoreModal('" + replyid + "')"
							        }).text("...(View More)");

							        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));

							        replyDiv.append(button, b);
							    }

							
					          formgroup1.append(replyDiv);   
							  innerDiv.append(formgroup1);
                              dynamicReplyDiv.append(innerDiv);
							    
					            // Check if row[9] count i.e DakReplyAttachCount is more than 0
						          if (row[9] > 0) {
						        	  // Call a function and pass row[0] i.e DakReplyId
						              DakReplyAttachPreview(row[0], dynamicReplyDiv);
						            }
                                $(".DakReply").append(dynamicReplyDiv);
                                
                             // Add line break after the textarea and DakReplyDivEnd
                  

                                $(".DakReply").append("<br>");
							    
							    
						 }//for loop close
						 
						//replyCountOverall>0 if condition close but dont have authority then disable else hide
					}else{ 
						
						 // Clear previous data
				        $(".DakReply").empty();
						 
				      //reset previously selected toggle  its important
			       	     resetPreviewButtons();
				    /*   
				      if(replyCountOverall>0){
			
			       	  
			        	 $('.btnReplyDetailsPreview').show(); 
			     		 $('.btnReplyDetailsPreview').prop('disabled', true);

			     		  // Add CSS styles directly to the disabled elements
			     		  $('.btnReplyDetailsPreview').css({
			     		    'background-color': '#808080',
			     		    'border': 'none',
			     		    'outline': 'none',
			     		    'opacity': '0.5',
			     		    'cursor': 'not-allowed'
			     		  });
				      }else{ */
				       	
				        	 $('.btnReplyDetailsPreview').hide(); 
				     /*  } */
					 
					}
						 
						//reseult!=null if condition close //when ajax doesnot result queryyyyy
					}else{
						 // Clear previous data
				        $(".DakReply").empty();
						 
				    	//reset previously selected toggle  its important
			       	     resetPreviewButtons();
			    		
			       	   //hide the btnReplyDetailsPreview div 
			        	 $('.btnReplyDetailsPreview').hide(); 
					 
					}
					
					
				}
		 });
		
	}
	
	function DakReplyAttachPreview(DakReplyIdData, dynamicReplyDiv) {
		  $.ajax({
		    type: "GET",
		    url: "GetReplyAttachModalList.htm",
		    data: {
		      dakreplyid: DakReplyIdData
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		        var resultData = JSON.parse(result);
		        if (resultData.length > 0) {
		          var formgroup2 = $("<div>", { class: "form-group group2" });
		          var tableDiv = $("<div>", { class: "col-md-6 replyModAttachTbl-div" });
		          var table = $("<table>", { class: "table table-hover table-striped table-condensed info shadow-nohover downloadReplyAttachTable" });

		          var ReplyAttachTbody = '';
		          for (var z = 0; z < resultData.length; z++) {
		            var row = resultData[z];

		            ReplyAttachTbody += '<tr> ';
		            ReplyAttachTbody += '  <td style="text-align: left;">';   
		            ReplyAttachTbody += '  <form action="#" id="Replyform">';
		            ReplyAttachTbody += '  <input type="hidden" id="ReplyIframeData" name="markerdownloadbtn">';
		            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply"  value="'+row[0]+'"  onclick="IframepdfMarkerReply('+row[0]+',0)" data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
		            ReplyAttachTbody += '  </form>';
		            ReplyAttachTbody += '  </td>';
		            ReplyAttachTbody += '</tr> ';
		          }

		          table.html(ReplyAttachTbody);
		          table.css('float', 'left');
		          tableDiv.append(table);
		          formgroup2.append(tableDiv);

		          var innerDiv = dynamicReplyDiv.find('.replyRow');
		          innerDiv.append(formgroup2);
		        }
		      }
		    },
		    error: function(xhr, textStatus, errorThrown) {
		      // Handle error
		    }
		  });
		}

	
	function replyViewMoreModal(replyid) {
		 $('#replyViewMore').appendTo('body').modal('show');
		  $('#replyDetailsDiv').empty();
		  $.ajax({
		    type: "GET",
		    url: "GetReplyViewMore.htm",
		    data: {
		      dakreplyid: replyid
		    },
		    datatype: 'json',
		    success: function(result) {

		      if (result != null) {
		        var resultData = JSON.parse(result);

		        for (var i = 0; i < resultData.length; i++) { // Corrected the loop variable
		          var row = resultData[i];

		          var remarks = row[1];
		      
		          $('#replyDetailsDiv').append(remarks);
		        }
		      }
		    }
		  });
		}
	
	function SubjectViewMoreModal(DakId,subject) {
		 $('#SubjectViewMore').appendTo('body').modal('show');
		  $('#SubjectDiv').empty();
		  $('#SubjectDiv').append(subject);
		}

	
	
	function replyCommonEdit(replyid){
		
		  $.ajax({
			    type: "GET",
			    url: "GetReplyEditDetails.htm",
			    data: {
			    	replyid: replyid
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			    	   var data = JSON.parse(result);
			           
			           // Extract the "Remarks" value
			    
			           $('.replyDataInEditModal').val(data.Remarks);
			           $('#dakReplyIdOfReplyEdit').val(data.DakReplyId);
			           $('#dakIdOfReplyEdit').val(data.DakId);
			           $('#empIdOfReplyEdit').val(data.EmpId);
			           
			           
			           replyAttachCommonEdit(replyid);
			       	
					}//if condition close
					
					
				}//successClose
		 });//ajaxClose  
		 $('#replyCommonEditModal').appendTo('body').modal('show');
	}//functionClose
	
	function replyAttachCommonEdit(replyid){
		 $.ajax({
			    type: "GET",
			    url: "GetReplyAttachModalList.htm",
			    data: {
			      dakreplyid: replyid
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			        var resultData = JSON.parse(result); 
			      
			        var ReplyAttachTbody = '';
			          for (var z = 0; z < resultData.length; z++) {
			            var row = resultData[z];

			            ReplyAttachTbody += '<tr> ';
			            ReplyAttachTbody += '  <td style="text-align: left;">';
			            ReplyAttachTbody += '  <form action="#" id="Replyform">';
			            ReplyAttachTbody += '  <input type="hidden" id="ReplyIframeDataEdit" name="markerdownloadbtn">';
			            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="dakEditReplyDownloadBtn"  value="'+row[0]+'"  onclick="IframepdfMarkerReply('+row[0]+',0)" data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
			            ReplyAttachTbody += '  </form>';
			            ReplyAttachTbody += '  </td>';
			            ReplyAttachTbody += '  <td style="text-align: left;">';
			            ReplyAttachTbody +=	'		<button type="button" id="ReplyEditAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="ReplyAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;"  onclick="deleteReplyEditAttach('+row[0]+','+row[1]+')" ><img alt="attach" src="view/images/delete.png"></button>';
			            ReplyAttachTbody += '  </td>';
			            ReplyAttachTbody += '</tr> ';
			          }
			      	$('#ReplyAttachEditDataFill').html(ReplyAttachTbody);
			        
			        
			      }          //if condition close
					
					
				}//successClose
		 });//ajaxClose    
	}//functionClose
	
	
	 function deleteReplyEditAttach(ReplyAttachmentId,ReplyId){
 		 $('#replyAttachmentIdFrDelete').val(ReplyAttachmentId);
 		 $('#replyIdFrAttachDelete').val(ReplyId);
 		 
 		 var result = confirm ("Are You sure to Delete ?"); 
 		 if(result){
 			var button = $('#ReplyEditAttachDelete');
 			var formAction = button.attr('formaction');
 			 
 			if (formAction) {
 				  var form = button.closest('form');
 				  form.attr('action', formAction);
 				  form.submit();
 				}else{
 					console.log('form action not found');
 				}
 		} else {
 		    return false; // or event.preventDefault();
 		}
 		 
 	 }
	
	
	 function  dakReplyEditValidation(){
		 
		 var isValidated = false;
		   var replyRemarkOfEdit = document.getElementsByClassName("replyDataInEditModal")[0].value;
		if(replyRemarkOfEdit.trim() == "") { 
	    	isValidated = false;
	    }else{
	    	isValidated = true;
	    }
	    
	    if (!isValidated) {
	        event.preventDefault(); // Prevent form submission
	        alert("Please fill in the remark input field.");
	      
	    
	      } else {
	          // Retrieve the form and submit it
	          var confirmation = confirm("Are you sure you want to edit this reply?");
	         
	          if (confirmation) {
	        	  
	        	  var button = $('#dakCommonReplyEditAction');
	   			var formAction = button.attr('formaction');
	   			 
	   			if (formAction) {
	   				  var form = button.closest('form');
	   				  form.attr('action', formAction);
	   				  form.submit();
	   				}else{
	   					console.log('form action not found');
	   				}
	          } else { return false; }
	          
	         
	      }//else close
	 }
	
	 function replyForwardForEdit( replyid ){
		 var result = confirm ("Are You sure to forward this reply for edit ?"); 
		 if(result){
			 
		 }else{
			 return false;
		 }
	 }
	 
	 
</script>
 <!-- JavaScript for Caeworker reply view modal start -->
<script>
<!-- JavaScript for Caeworker reply view modal start -->
	function dakCSWReplyPreview(dakId){
		  // Clear previous data
	    $(".CaseworkerDakReplyData").empty();
		$.ajax({
			 type : "GET",
				url : "GetCSWReplyModalDetails.htm",
				data : {
					
					dakid: dakId
				},
				datatype : 'json',
				success : function(result) {
					
					if(result !=null && result!="[]"){
						
						 var replyCSWData = JSON.parse(result); // Parse the JSON data
						
						 resetPreviewButtons();
						 $(".CaseworkerDakReplyData").empty();  
						 
						 const replyCSWCountOverall = parseInt( replyCSWData[0][16]);
						 
						 if(replyCSWCountOverall>0){
			            	
			           		//display the hidden btnCWReplyDetailsPreview div 
			            	$('.btnCWReplyDetailsPreview').show();
			            	

						 for (var i = 0; i < replyCSWData.length; i++) {
							    var data = replyCSWData[i];
							   
							    var repliedCSWPersonName = data[6];
								$('#cswreplierName').val(repliedCSWPersonName);
							    var repliedCSWPersonDesig = data[7];
							    var repliedData = data[2];
							    var dakAssignReplyId= data[0];
							    var replyEmpId=data[1];
							    var loggedInEmpId = <%= EmpId %>;
							    var action = data[9];
							    var MarkerPersName = data[13];
							    var MarkerPersDesig = data[14];
							    var dakStatus = data[15];
							    var DateTime=data[5];
							    var ReplyStatus=data[17];
							    console.log("replystatus"+ReplyStatus);
							    
							 var date = new Date(DateTime);

							 // Format the date and time
							 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
							     month: 'short',
							     day: 'numeric',
							     year: 'numeric',
							     hour: 'numeric',
							     minute: 'numeric'
							 }).format(date);

							    
							    var dynamicCSWReplyDiv = $("<div>", { class: "DAKCSWReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
							    dynamicCSWReplyDiv.after("<br>");
							    var h4 = $("<h4>", {
							    	  class: "CSWRepliedPersonName",
							    	  id: "model-person-header",
							    	  html: (i + 1) + "." + repliedCSWPersonName + "," + repliedCSWPersonDesig + " ( <span style='color: blue'> Marked By - " + MarkerPersName + "," + MarkerPersDesig + "</span> )"+", "+
							    	  "  <span style='color: black; font-size:15px;'> " + formattedDateTime + "</span> "
							    	});
							    dynamicCSWReplyDiv.append(h4);//appended h4
							   
							    if(ReplyStatus==='R'){
							     var replyCSWEditButton = $("<button>", {
							    	  type: "button",
							    	  class: "btn btn-sm icon-btn replycswedit-click",
							    	  "data-toggle": "tooltip",
							    	  "data-placement": "top",
							    	  title: "Edit",
							    	  onclick: "replyCSWCommonEdit('" + dakAssignReplyId + "')"
							    	});
							    
							    	  var editImage = $("<img>", { alt: "edit",src: "view/images/writing.png"});
                                replyCSWEditButton.append(editImage); 
                               
                                 if(replyEmpId == loggedInEmpId && dakStatus!="DC" && dakStatus!="AP"){
                                	dynamicCSWReplyDiv.append(replyCSWEditButton);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
                                 }
							    }else if(ReplyStatus==='F'){
  								   var replyForwardForEditBtn  = $("<button>", {
  								    	  type: "button",
  								    	  class: "btn btn-sm icon-btn replyforwardforedit-click",
  								    	  "data-toggle": "tooltip",
  								    	  "data-placement": "top",
  								    	  title: "Reply Edit",
  								    	  onclick: "returnreplyForwardForEdit('" + dakAssignReplyId + "')"
  								    	});
  								    
  	                                var forwardForEditImage = $("<img>", { alt: "edit",src: "view/images/revision.png"});
  	                                replyForwardForEditBtn.append(forwardForEditImage);
  							    
  	                                if(replyEmpId == loggedInEmpId  ){
  	                                	dynamicCSWReplyDiv.append(replyForwardForEditBtn);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
  	     							  }
  							   }
							    
							   /*  var replyCSWRevisionBtn  = $("<button>", {
							    	  type: "submit",
							    	  class: "btn btn-sm icon-btn replycswRevision-click",
							    	  "data-toggle": "tooltip",
							    	  "data-placement": "top",
							    	  title: "	CSW Revision",
							    	  onclick: "replyCSWRevisionBtn('" + dakAssignReplyId + "')"
							    	});
							    
   							      replyCSWRevisionBtn.attr("formaction", "DakTransitionHistory.htm");
   							      replyCSWRevisionBtn.attr("formmethod", "post");
                                  var RevisionForEditImage = $("<img>", { alt: "edit",src: "view/images/transition.png"});
                               
                            	replyCSWRevisionBtn.append(RevisionForEditImage);
                          	    dynamicCSWReplyDiv.append(replyCSWRevisionBtn);
   							   */
   							  
                                
                               /*  var replyCSWForwardReturnBtn  = $("<button>", {
							    	  type: "button",
							    	  class: "btn btn-sm icon-btn replycswforwardreturn-click",
							    	  "data-toggle": "tooltip",
							    	  "data-placement": "top",
							    	  title: "	CSW Reply Return",
							    	  onclick: "replyCSWForwardReturn('" + dakAssignReplyId + ")"
							    	});
							    
                                 var forwardForEditImage = $("<img>", { alt: "edit",src: "view/images/replyChange.png"});
                              
                                 
                              if(dakStatus!="DC" && dakStatus!="AP" && action == 'ReplyForward'){
                            	  replyCSWForwardReturnBtn.append(forwardForEditImage);
                            	  dynamicCSWReplyDiv.append(replyCSWForwardReturnBtn);
                              } */
                              
                        
   							dynamicCSWReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
                              
                              
							    var innerCSWReplyDiv = $("<div>", { class: "row replyRow" });
							    
							    var formgroup1 = $("<div>", { class: "form-group group1" });
								
							  /*   var replyLabel = $("<label>", { class: "form-control" }).css({ fontweight: "800", fontSize: "16px", color: "#07689f;",display: "inline-block",marginbottom: "0.5rem"}).text("Reply :"); */
					
							    var replyCSWText = repliedData.length < 140 ? repliedData : repliedData.substring(0, 140);
							    var replyCSWDiv = $("<div>", { class: "col-md-12 replyCSW-div", contenteditable: "false" }).text(replyCSWText);
							    
							    if (repliedData.length > 140) {
							        var button = $("<button>", {
							            type: "button",
							            class: "viewmore-click",
							            name: "sub",
							            value: "Modify",
							            onclick: "replyCSWViewMoreModal('" + dakAssignReplyId + "')"
							        }).text("...(View More)");

							        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));

							        replyCSWDiv.append(button, b);
							    }

							
					          formgroup1.append(replyCSWDiv);   
					          innerCSWReplyDiv.append(formgroup1);
					          dynamicCSWReplyDiv.append(innerCSWReplyDiv);
							    
					            // Check if row[8] count i.e DakReplyAttachCount is more than 0
						          if (data[8] > 0) {
						        	  // Call a function and pass row[0] i.e DakAssignReplyId
						              DakCSWReplyAttachPreview(data[0], dynamicCSWReplyDiv);
						            }
                                $(".CaseworkerDakReplyData").append(dynamicCSWReplyDiv);
                                
                             // Add line break after the textarea and DakReplyDivEnd
                  

                                $(".CaseworkerDakReplyData").append("<br>");
							    
							    
						 }//for loop close
						
						//resultCSWOverallCount>0 if condition close
					 }else{
						//hide the hidden btnCWReplyDetailsPreview div 
						 resetPreviewButtons();
						 $(".CaseworkerDakReplyData").empty();  
			            	$('.btnCWReplyDetailsPreview').hide();
						}
						
						 //result!=null if condition close
					}else{
						//hide the hidden btnCWReplyDetailsPreview div 
						 resetPreviewButtons();
						 $(".CaseworkerDakReplyData").empty();  
		            	$('.btnCWReplyDetailsPreview').hide();
					}
					
					
				}
		 });
		
	}
	
	function DakCSWReplyAttachPreview(DakAssignReplyId, dynamicCSWReplyDiv) {
		  $.ajax({
		    type: "GET",
		    url: "GetCSWReplyAttachModalList.htm",
		    data: {
		      dakassignreplyid: DakAssignReplyId
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		        var resultData = JSON.parse(result);

		        if (resultData.length > 0) {
		          var formgroup2 = $("<div>", { class: "form-group TblReplyAttachs" });
		          var tableDiv = $("<div>", { class: "col-md-6 replyCSWModAttachTbl-div" });
		          var table = $("<table>", { class: "table table-hover table-striped table-condensed info shadow-nohover downloadReplyCSWAttachTable" });

		          var ReplyAttachTbody = '';
		          for (var z = 0; z < resultData.length; z++) {
		            var row = resultData[z];
		            ReplyAttachTbody += '<tr> ';
		            ReplyAttachTbody += '  <td style="text-align: left;">';
		            ReplyAttachTbody += '  <form action="#" id="CWReplyIframeForm">';
		            ReplyAttachTbody += '  <input type="hidden" id="CWReplyIframe" name="cswdownloadbtn">';
		            ReplyAttachTbody += '  <button type="button" class="btn btn-sm replyCSWAttachWithin-btn"   value="'+row[0]+'"  onclick="IframepdfCaseWorkerReply('+row[0]+')" name="dakReplyCSWDownloadBtn"  data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
		            ReplyAttachTbody += '  </form>';
		            ReplyAttachTbody += '  </td>';
		            ReplyAttachTbody += '</tr> ';
		          }


		          table.html(ReplyAttachTbody);
		          table.css('float', 'left');
		          tableDiv.append(table);
		          formgroup2.append(tableDiv);

		          var innerDiv = dynamicCSWReplyDiv.find('.replyRow');
		          innerDiv.append(formgroup2);
		        }
		      }
		    },
		    error: function(xhr, textStatus, errorThrown) {
		      // Handle error
		    }
		  });
		}
	
	function replyCSWViewMoreModal(dakAssignReplyId){
		 $('#replyCSWViewMore').appendTo('body').modal('show');
		  $('#replyCSWViewMoreDetailsDiv').empty();
		  $.ajax({
		    type: "GET",
		    url: "GetAssignReplyViewMore.htm",
		    data: {
		      dakreplyid: dakAssignReplyId
		    },
		    datatype: 'json',
		    success: function(result) {

		      if (result != null) {
		        var resultData = JSON.parse(result);

		        for (var i = 0; i < resultData.length; i++) { // Corrected the loop variable
		          var row = resultData[i];

		          var remarks = row[1];
		      
		          $('#replyCSWViewMoreDetailsDiv').append(remarks);
		        }
		      }
		    }
		  });
	}
	
	
	function replyCSWForwardReturn(dakAssignReplyId,){
		$('#CSWForwardReturnId').empty();
		$('#exampleModalAssignReplyReturn').modal('show');
		 $('#CSWForwardReturnId').val(dakAssignReplyId);
	}
	
	function replyCSWCommonEdit(replyid){
		
		  $.ajax({
			    type: "GET",
			    url: "GetAssignReplyEditDetails.htm",
			    data: {
			    	replyid: replyid
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			    	   var data = JSON.parse(result);
			           
			           // Extract the "Remarks" value
			    
			           $('.assignReplyDataInEditModal').val(data.Reply);
			           $('#dakAssignReplyIdEdit').val(data.DakAssignReplyId);
			           $('#dakIdOfAssignReplyEdit').val(data.DakId);
			           $('#empIdOfAssignReplyEdit').val(data.EmpId);
			           $('#dakAssignIdReplyEdit').val(data.DakAssignId);
			           
			           replyCSWAttachCommonEdit(replyid);
			       	
					}//if condition close
					
					
				}//successClose
		 });//ajaxClose  
		 $('#DakAssignreplyCommonEditModal').appendTo('body').modal('show');
		 /*  $('#replyCommonEditModal').modal('show'); */
	}//functionClose
	
	function replyCSWAttachCommonEdit(replyid){
		 $.ajax({
			    type: "GET",
			    url: "GetAssignReplyAttachModalList.htm",
			    data: {
			      dakreplyid: replyid
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			        var resultData = JSON.parse(result); 
			      
			        var ReplyAttachTbody = '';
			          for (var z = 0; z < resultData.length; z++) {
			            var row = resultData[z];

			            ReplyAttachTbody += '<tr> ';
			            ReplyAttachTbody += '  <td style="text-align: left;">';
			            ReplyAttachTbody += '  <form action="#" id="AssignIframeFormEditForm">';
			            ReplyAttachTbody += '  <input type="hidden" id="assignReplyIframeEdit" name="cswdownloadbtn">';
			            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn"  value="' + row[0] + '" onclick="IframepdfCaseWorkerReply('+row[0]+',1)" name="dakReplyCSWDownloadBtn"   data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
			            ReplyAttachTbody += '  </form>';
			            ReplyAttachTbody += '  </td>';
			            ReplyAttachTbody += '  <td style="text-align: left;">';
			            ReplyAttachTbody +=	'		<button type="button" id="cswReplyEditAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="AssignReplyAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;"  onclick="cswdeleteReplyEditAttach('+row[0]+','+row[1]+')" ><img alt="attach" src="view/images/delete.png"></button>';
			            ReplyAttachTbody += '  </td>';
			            ReplyAttachTbody += '</tr> ';
			          }
			          
			      	$('#cswReplyAttachEditDataFill').html(ReplyAttachTbody);
			        
			        
			      }          //if condition close
					
					
				}//successClose
		 });//ajaxClose    
	}//functionClose
	
	
	 function cswdeleteReplyEditAttach(ReplyAttachmentId,ReplyId){
		 $('#cswreplyAttachmentIdFrDelete').val(ReplyAttachmentId);
		 $('#cswreplyIdFrAttachDelete').val(ReplyId);
		 
		 var result = confirm ("Are You sure to Delete ?"); 
		 if(result){
			var button = $('#cswReplyEditAttachDelete');
			var formAction = button.attr('formaction');
			 
			if (formAction) {
				  var form = button.closest('form');
				  form.attr('action', formAction);
				  form.submit();
				}else{
					console.log('form action not found');
				}
		} else {
		    return false; // or event.preventDefault();
		}
		 
	 }
	
	
	 function  dakAssignReplyEditValidation(){
		 
		 var isValidated = false;
		   var replyRemarkOfEdit = document.getElementsByClassName("assignReplyDataInEditModal")[0].value;
		if(replyRemarkOfEdit.trim() == "") { 
	    	isValidated = false;
	    }else{
	    	isValidated = true;
	    }
	    
	    if (!isValidated) {
	        event.preventDefault(); // Prevent form submission
	        alert("Please fill in the remark input field.");
	      
	    
	      } else {
	          // Retrieve the form and submit it
	          var confirmation = confirm("Are you sure you want to edit this reply?");
	         
	          if (confirmation) {
	        	  
	        	  var button = $('#cswdakCommonReplyEditAction');
	   			var formAction = button.attr('formaction');
	   			 
	   			if (formAction) {
	   				  var form = button.closest('form');
	   				  form.attr('action', formAction);
	   				  form.submit();
	   				}else{
	   					console.log('form action not found');
	   				}
	          } else { return false; }
	          
	         
	      }//else close
	 }
		 </script>
<!-- JavaScript for Caeworker reply view modal end -->
 <!-- JavaScript for P&CDo reply view modal start -->
 <script>
 
 
 function  dakPNCDOeplyPreview(DakId) {
	  // AJAX call to retrieve reply details of the Dak with DakId
	  $.ajax({
	    type: "GET",
	    url: "GetPnCReplyDetails.htm",
	    data: {
	      dakid: DakId
	    },
	    datatype: 'json',
	    success: function(result) {
	    	 if (result != null) {
	    		 var Data = JSON.parse(result); // Parse the JSON data

	 	        // Clear previous data
	 		     $(".pncDoReplyData").empty(); 
	    		 
	 		 // Loop through the retrieved data
	 	        for (var i = 0; i < Data.length; i++) {
	 	          var values = Data[i];
	 	         $('.pncDoReplyData').val(values[3]);
	 	        $(".pncDoAttachedFilesTbl").empty().removeAttr('style'); 
	 	         $('#pncdoreplypersonname').html("1."+values[13]);
	 	         $('#pncdoreplydeignation').html(values[14]);
	 	          var DateTime=values[6];
				    var date = new Date(DateTime);

					 // Format the date and time
					 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
					     month: 'short',
					     day: 'numeric',
					     year: 'numeric',
					     hour: 'numeric',
					     minute: 'numeric'
					 }).format(date);
	 	          
	 	          $('#createddate').html(formattedDateTime);
	 	          
	 	        if (values[8] > 0) {
		        	// Apply the specific styles for the else condition
		              $('.pncDoAttachedFilesTbl').css({
		                'border': 'none',
		                'width': '294px',
		                'float': 'left',
		                'margin-left': '0px',
		                'margin-top': '6px'
		              });
		        	// If there are attachments, call the function PnCReplyAttachs to retrieve them
		            PnCReplyAttachPreview(values[0]);
		          } else {
		        	  // Apply the specific styles for the else condition
		              $('.pncDoAttachedFilesTbl').css({
		            	    'border': '1px solid #ced4da',
		            	    'border-radius': '0.25rem !important',
		            	    'width': '294px',
		            	    'float': 'left',
		            	    'clear': 'left',
		            	    'margin-left': '0px'
		              });
		              // If there are no attachments, display a message in the corresponding element
			            var emptyRow = '<tr><td style="text-align: center; font-size: 14px;">No Documents Attached</td></tr>';
			            $('.pncDoAttachedFilesTbl').append(emptyRow);
			          }
	    }//for loop ends
	    
	    	 }//result null check ends
	    	 
	    }
	    
	    });
	 
 }
 
	  function PnCReplyAttachPreview(DakPnCReplyId) {
		  // AJAX call to retrieve reply attachments for the DakPnCReplyId
		  $.ajax({
		    type: "GET",
		    url: "GetPnCReplyAttachDetails.htm",
		    data: {
		      dakpncreplyid: DakPnCReplyId
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		        var resultData = JSON.parse(result); // Parse the JSON data

		        var ReplyAttachTbody = '';
		        for (var z = 0; z < resultData.length; z++) {
		          var row = resultData[z];
		         
		          ReplyAttachTbody += '<tr> ';
		          ReplyAttachTbody += '  <td style="text-align: left;">';
		          ReplyAttachTbody += '  <form action="#" id="PCReplyIframeForm">';
		            ReplyAttachTbody += '  <input type="hidden" id="PCReplyIframe" name="pncReplyDownloadBtn">';
		          ReplyAttachTbody += '    <button type="button" class="btn btn-sm pncAttachments-btn" name="pncReplyDownloadBtn" value="'+row[0]+'"  onclick="IframepdfForPnCAttachedDocs('+row[0]+',0)"  data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
		          ReplyAttachTbody += '  </form>';
		          ReplyAttachTbody += '  </td>';
		          ReplyAttachTbody += '</tr> ';
		        }

		        // Append the ReplyAttachTbody to the element with class 'PnCRepliedDocuments'
		        $('.pncDoAttachedFilesTbl').append(ReplyAttachTbody);
		      }
		    }
		  });
		}

	 </script>
	 
	 <script>
	function dakSeekResponseReplyPreview(dakId){

		
		$.ajax({
			 type : "GET",
				url : "GetSeekResponseReplyModalDetails.htm",
				data : {
					
					dakid: dakId
					
					
				},
				datatype : 'json',
				success : function(result) {
					
					if(result !=null && result!="[]"){
						//reset previously selected toggle  its important
			       	     resetPreviewButtons();
			    		
			       	   //display the hidden btnSeekResponseReplyDetailsPreview div 
			        	 $('.btnSeekResponseReplyDetailsPreview').show(); 
			       	   
			        	 // Clear previous data
					        $(".DakSeekResponseReply").empty();
						
						
						 var replyData = JSON.parse(result); // Parse the JSON data
						 
						 const replyCountOverall = parseInt( replyData[0][11]);
				    	 const replyCountByEmpId = parseInt( replyData[0][12]);
				    	 const replyCountByAuthority = parseInt( replyData[0][13]);
				    	 
				    
				    	 if (  replyCountOverall > 0 && (replyCountByEmpId > 0 ||  replyCountByAuthority > 0)){
					
						 
						 for (var i = 0; i < replyData.length; i++) {
							    var row = replyData[i];
							    var repliedPersonName = row[6];
								$('#SeekResponsereplierName').val(repliedPersonName);
							    var repliedPersonDesig = row[7];
							    var repliedRemarks = row[2];
							    var replyid= row[0];
							    var replyEmpId=row[1];
							    var loggedInEmpId = <%= EmpId %>;
							    var dakStatus = row[10];
							    var DateTime=row[5];
							    
							    var date = new Date(DateTime);

								 // Format the date and time
								 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
								     month: 'short',
								     day: 'numeric',
								     year: 'numeric',
								     hour: 'numeric',
								     minute: 'numeric'
								 }).format(date);
							  
							    var dynamicReplyDiv = $("<div>", { class: "DAKSeekResponseReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
							    dynamicReplyDiv.after("<br>");
							    var h4 = $("<h4>", { 
							    	  class: "SeekRepsponseRepliedPersonName", 
							    	  id: "model-person-header", 
							    	  html: (i + 1) + ". " + repliedPersonName + ", " + repliedPersonDesig + ",  <span style='color: black; font-size:15px;'> " + formattedDateTime + "</span>" 
							    	});
							    dynamicReplyDiv.append(h4);//appended h4
							   
							    var replyEditButton = $("<button>", {
							    	  type: "button",
							    	  class: "btn btn-sm icon-btn replyedit-click",
							    	  "data-toggle": "tooltip",
							    	  "data-placement": "top",
							    	  title: "Edit",
							    	  onclick: "replySeekResponseCommonEdit('" + replyid + "')"
							    	});
							    
                                var editImage = $("<img>", { alt: "edit",src: "view/images/writing.png"});
                                replyEditButton.append(editImage);
                               
                                if(replyEmpId == loggedInEmpId && dakStatus!="DC" && dakStatus!="AP"){
   							      dynamicReplyDiv.append(replyEditButton);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
   							  }
							    
							    
							     /* var replyForwardForEditBtn  = $("<button>", {
							    	  type: "button",
							    	  class: "btn btn-sm icon-btn replyforwardforedit-click",
							    	  "data-toggle": "tooltip",
							    	  "data-placement": "top",
							    	  title: "Reply Forward",
							    	  onclick: "replyForwardForEdit('" + replyid + "')"
							    	});
							    
                                var forwardForEditImage = $("<img>", { alt: "edit",src: "view/images/replyChange.png"});
                                if(dakStatus!="DC" && dakStatus!="AP"){
                                replyForwardForEditBtn.append(forwardForEditImage);
                                } */
                              
              
                              dynamicReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
                              
                              
							    var innerDiv = $("<div>", { class: "row replyRow" });
							    
							    var formgroup1 = $("<div>", { class: "form-group group1" });
							
							    var replyText = repliedRemarks.length < 140 ? repliedRemarks : repliedRemarks.substring(0, 140);
							    var replyDiv = $("<div>", { class: "col-md-12 replyremarks-div", contenteditable: "false" }).text(replyText);
							    
							    if (repliedRemarks.length > 140) {
							        var button = $("<button>", {
							            type: "button",
							            class: "viewmore-click",
							            name: "sub",
							            value: "Modify",
							            onclick: "replySeekResponseViewMoreModal('" + replyid + "')"
							        }).text("...(View More)");

							        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));

							        replyDiv.append(button, b);
							    }

							
					          formgroup1.append(replyDiv);   
							  innerDiv.append(formgroup1);
                              dynamicReplyDiv.append(innerDiv);
							    
					            // Check if row[9] count i.e DakReplyAttachCount is more than 0
						          if (row[9] > 0) {
						        	  // Call a function and pass row[0] i.e DakReplyId
						              DakSeekResponseReplyAttachPreview(row[0], dynamicReplyDiv);
						            }
                                $(".DakSeekResponseReply").append(dynamicReplyDiv);
                                
                             // Add line break after the textarea and DakReplyDivEnd
                  

                                $(".DakSeekResponseReply").append("<br>");
							    
							    
						 }//for loop close
						 
						//replyCountOverall>0 if condition close but dont have authority then disable else hide
					}else{ 
						
						 // Clear previous data
				        $(".DakSeekResponseReply").empty();
						 
				      //reset previously selected toggle  its important
			       	     resetPreviewButtons();
				      
				      if(replyCountOverall>0){
			
			       	  
			        	 $('.btnSeekResponseReplyDetailsPreview').show(); 
			     		 $('.btnSeekResponseReplyDetailsPreview').prop('disabled', true);

			     		  // Add CSS styles directly to the disabled elements
			     		  $('.btnSeekResponseReplyDetailsPreview').css({
			     		    'background-color': '#808080',
			     		    'border': 'none',
			     		    'outline': 'none',
			     		    'opacity': '0.5',
			     		    'cursor': 'not-allowed'
			     		  });
				      }else{
				       	
				        	 $('.btnSeekResponseReplyDetailsPreview').hide(); 
				      }
					 
					}
						 
						//reseult!=null if condition close //when ajax doesnot result queryyyyy
					}else{
						 // Clear previous data
				        $(".DakSeekResponseReply").empty();
						 
				    	//reset previously selected toggle  its important
			       	     resetPreviewButtons();
			    		
			       	   //hide the btnSeekResponseReplyDetailsPreview div 
			        	 $('.btnSeekResponseReplyDetailsPreview').hide(); 
					 
					}
					
					
				}
		 });
		
	}
	
	function DakSeekResponseReplyAttachPreview(DakReplyIdData, dynamicReplyDiv) {
		  $.ajax({
		    type: "GET",
		    url: "GetSeekResponseReplyAttachModalList.htm",
		    data: {
		      dakreplyid: DakReplyIdData
		    },
		    datatype: 'json',
		    success: function(result) {
		      if (result != null) {
		        var resultData = JSON.parse(result);
		        if (resultData.length > 0) {
		          var formgroup2 = $("<div>", { class: "form-group group2" });
		          var tableDiv = $("<div>", { class: "col-md-6 replyModAttachTbl-div" });
		          var table = $("<table>", { class: "table table-hover table-striped table-condensed info shadow-nohover downloadReplyAttachTable" });

		          var ReplyAttachTbody = '';
		          for (var z = 0; z < resultData.length; z++) {
		            var row = resultData[z];

		            ReplyAttachTbody += '<tr> ';
		            ReplyAttachTbody += '  <td style="text-align: left;">';   
		            ReplyAttachTbody += '  <form action="#" id="SeekResponseReplyform">';
		            ReplyAttachTbody += '  <input type="hidden" id="SeekResponseReplyIframeData" name="markerdownloadbtn">';
		            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="downloadbtnOfMarkedReply"  value="'+row[0]+'"  onclick="IframepdfSeekResponseReply('+row[0]+',0)" data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
		            ReplyAttachTbody += '  </form>';
		            ReplyAttachTbody += '  </td>';
		            ReplyAttachTbody += '</tr> ';
		          }

		          table.html(ReplyAttachTbody);
		          tableDiv.append(table);
		          formgroup2.append(tableDiv);

		          var innerDiv = dynamicReplyDiv.find('.replyRow');
		          innerDiv.append(formgroup2);
		        }
		      }
		    },
		    error: function(xhr, textStatus, errorThrown) {
		      // Handle error
		    }
		  });
		}


	function replySeekResponseViewMoreModal(replyid) {
		 $('#SeekResponsereplyViewMore').appendTo('body').modal('show');
		  $('#SeekResponsereplyDetailsDiv').empty();
		  $.ajax({
		    type: "GET",
		    url: "GetSeekResponseReplyViewMore.htm",
		    data: {
		      dakreplyid: replyid
		    },
		    datatype: 'json',
		    success: function(result) {

		      if (result != null) {
		        var resultData = JSON.parse(result);

		        for (var i = 0; i < resultData.length; i++) { // Corrected the loop variable
		          var row = resultData[i];

		          var remarks = row[1];
		      
		          $('#SeekResponsereplyDetailsDiv').append(remarks);
		        }
		      }
		    }
		  });
		}

	
	
	function replySeekResponseCommonEdit(replyid){
		
		  $.ajax({
			    type: "GET",
			    url: "GetSeekResponseReplyEditDetails.htm",
			    data: {
			    	replyid: replyid
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			    	   var data = JSON.parse(result);
			           
			           // Extract the "Remarks" value
			    
			           $('.SeekResponsereplyDataInEditModal').val(data.Reply);
			           $('#SeekResponsedakReplyIdOfReplyEdit').val(data.SeekResponseId);
			           $('#SeekResponsedakIdOfReplyEdit').val(data.DakId);
			           $('#SeekResponseempIdOfReplyEdit').val(data.SeekEmpId);
			           
			           SeekResponsereplyAttachCommonEdit(replyid);
			       	
					}//if condition close
					
					
				}//successClose
		 });//ajaxClose  
		 $('#SeekResponsereplyCommonEditModal').appendTo('body').modal('show');
	}//functionClose
	
	function SeekResponsereplyAttachCommonEdit(replyid){
		 $.ajax({
			    type: "GET",
			    url: "GetSeekResponseReplyAttachModalList.htm",
			    data: {
			      dakreplyid: replyid
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			        var resultData = JSON.parse(result); 
			      
			        var ReplyAttachTbody = '';
			          for (var z = 0; z < resultData.length; z++) {
			            var row = resultData[z];

			            ReplyAttachTbody += '<tr> ';
			            ReplyAttachTbody += '  <td style="text-align: left;">';
			            ReplyAttachTbody += '  <form action="#" id="SeekResponseReplyform">';
			            ReplyAttachTbody += '  <input type="hidden" id="SeekResponseReplyIframeDataEdit" name="markerdownloadbtn">';
			            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn" name="dakEditReplyDownloadBtn"  value="'+row[0]+'"  onclick="IframepdfSeekResponseReply('+row[0]+',0)" data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
			            ReplyAttachTbody += '  </form>';
			            ReplyAttachTbody += '  </td>';
			            ReplyAttachTbody += '  <td style="text-align: left;">';
			            ReplyAttachTbody +=	'		<button type="button" id="SeekResponseReplyEditAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="SeekResponseReplyAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;"  onclick="deleteSeekResponseReplyEditAttach('+row[0]+','+row[1]+')" ><img alt="attach" src="view/images/delete.png"></button>';
			            ReplyAttachTbody += '  </td>';
			            ReplyAttachTbody += '</tr> ';
			          }
			      	$('#SeekResponseReplyAttachEditDataFill').html(ReplyAttachTbody);
			        
			        
			      }          //if condition close
					
					
				}//successClose
		 });//ajaxClose    
	}//functionClose
	
	
	 function deleteSeekResponseReplyEditAttach(ReplyAttachmentId,ReplyId){
 		 $('#SeekResponsereplyAttachmentIdFrDelete').val(ReplyAttachmentId);
 		 $('#SeekResponsereplyIdFrAttachDelete').val(ReplyId);
 		 
 		 var result = confirm ("Are You sure to Delete ?"); 
 		 if(result){
 			var button = $('#SeekResponseReplyEditAttachDelete');
 			var formAction = button.attr('formaction');
 			 
 			if (formAction) {
 				  var form = button.closest('form');
 				  form.attr('action', formAction);
 				  form.submit();
 				}else{
 					console.log('form action not found');
 				}
 		} else {
 		    return false; // or event.preventDefault();
 		}
 		 
 	 }
	
	
	 function  dakSeekResponseReplyEditValidation(){
		 
		 var isValidated = false;
		   var replyRemarkOfEdit = document.getElementsByClassName("SeekResponsereplyDataInEditModal")[0].value;
		if(replyRemarkOfEdit.trim() == "") { 
	    	isValidated = false;
	    }else{
	    	isValidated = true;
	    }
	    
	    if (!isValidated) {
	        event.preventDefault(); // Prevent form submission
	        alert("Please fill in the remark input field.");
	      
	    
	      } else {
	          // Retrieve the form and submit it
	          var confirmation = confirm("Are you sure you want to edit this reply?");
	         
	          if (confirmation) {
	        	  
	        	  var button = $('#dakSeekResponseCommonReplyEditAction');
	   			var formAction = button.attr('formaction');
	   			 
	   			if (formAction) {
	   				  var form = button.closest('form');
	   				  form.attr('action', formAction);
	   				  form.submit();
	   				}else{
	   					console.log('form action not found');
	   				}
	          } else { return false; }
	          
	         
	      }//else close
	 }
	
	/*  function replyForwardForEdit( replyid ){
		 var result = confirm ("Are You sure to forward this reply for edit ?"); 
		 if(result){
			 
		 }else{
			 return false;
		 }
	 }
	  */
	 
</script>
 <!-- JavaScript for P&CDo reply view modal end -->
 <script>
 
//Simulate btnDakDetailsPreview by default 
$(document).ready(function() {
  var defaultButton = document.querySelector(".TogglePreviewModal .btnDakDetailsPreview");
  defaultButton.click();
});

$('.btnDakDetailsPreview').click(function(event){
	 event.preventDefault(); // 
     event.stopPropagation(); // 
     $('.btnDakDetailsPreview').css('background-color','#B9D9EB');
 	$('.btnDakDetailsPreview').css('color','#114A86');
 	$('.btnReplyDetailsPreview').css('background-color','white');
 	$('.btnReplyDetailsPreview').css('color','#114A86');
 	$('.btnCWReplyDetailsPreview').css('background-color','white');
 	$('.btnCWReplyDetailsPreview').css('color','#114A86');
 	$('.btnPNCDOReplyDetailsPreview').css('background-color','white');
 	$('.btnPNCDOReplyDetailsPreview').css('color','#114A86');
 	$('.btnSeekResponseReplyDetailsPreview').css('background-color','white');
	$('.btnSeekResponseReplyDetailsPreview').css('color','#114A86');
 	
 	
 	document.getElementById('dakDetailsMod').style.display = 'block';
 	document.getElementById('replyDetailsMod').style.display = 'none';
	document.getElementById('caseworkerReplyMod').style.display = 'none';
	document.getElementById('pncDoReplyMod').style.display = 'none';
	document.getElementById('SeekResponsereplyDetailsMod').style.display = 'none';
	
	
});

$('.btnReplyDetailsPreview').click(function(event){
	 event.preventDefault(); // 
     event.stopPropagation(); // 
     $('.btnDakDetailsPreview').css('background-color','white');
 	$('.btnDakDetailsPreview').css('color','#114A86');
 	$('.btnReplyDetailsPreview').css('background-color','#B9D9EB');
 	$('.btnReplyDetailsPreview').css('color','#114A86');
 	$('.btnCWReplyDetailsPreview').css('background-color','white');
 	$('.btnCWReplyDetailsPreview').css('color','#114A86');
 	$('.btnPNCDOReplyDetailsPreview').css('background-color','white');
 	$('.btnPNCDOReplyDetailsPreview').css('color','#114A86');
 	$('.btnSeekResponseReplyDetailsPreview').css('background-color','white');
	$('.btnSeekResponseReplyDetailsPreview').css('color','#114A86');
	
 	document.getElementById('dakDetailsMod').style.display = 'none';
 	document.getElementById('replyDetailsMod').style.display = 'block';
	document.getElementById('caseworkerReplyMod').style.display = 'none';
	document.getElementById('pncDoReplyMod').style.display = 'none';
	document.getElementById('SeekResponsereplyDetailsMod').style.display = 'none';
	
});

$('.btnCWReplyDetailsPreview').click(function(event){
	 event.preventDefault(); // 
    event.stopPropagation(); // 
    $('.btnDakDetailsPreview').css('background-color','white');
	$('.btnDakDetailsPreview').css('color','#114A86');
	$('.btnReplyDetailsPreview').css('background-color','white');
	$('.btnReplyDetailsPreview').css('color','#114A86');
	$('.btnCWReplyDetailsPreview').css('background-color','#B9D9EB');
	$('.btnCWReplyDetailsPreview').css('color','#114A86');
	$('.btnPNCDOReplyDetailsPreview').css('background-color','white');
 	$('.btnPNCDOReplyDetailsPreview').css('color','#114A86');
 	$('.btnSeekResponseReplyDetailsPreview').css('background-color','white');
	$('.btnSeekResponseReplyDetailsPreview').css('color','#114A86');
	
	document.getElementById('dakDetailsMod').style.display = 'none';
	document.getElementById('replyDetailsMod').style.display = 'none';
	document.getElementById('caseworkerReplyMod').style.display = 'block';
	document.getElementById('pncDoReplyMod').style.display = 'none';
	document.getElementById('SeekResponsereplyDetailsMod').style.display = 'none';
	
});


$('.btnPNCDOReplyDetailsPreview').click(function(event){
	 event.preventDefault(); // 
   event.stopPropagation(); // 
   $('.btnDakDetailsPreview').css('background-color','white');
	$('.btnDakDetailsPreview').css('color','#114A86');
	$('.btnReplyDetailsPreview').css('background-color','white');
	$('.btnReplyDetailsPreview').css('color','#114A86');
	$('.btnCWReplyDetailsPreview').css('background-color','white');
	$('.btnCWReplyDetailsPreview').css('color','#114A86');
	$('.btnPNCDOReplyDetailsPreview').css('background-color','#B9D9EB');
	$('.btnPNCDOReplyDetailsPreview').css('color','#114A86');
	$('.btnSeekResponseReplyDetailsPreview').css('background-color','white');
	$('.btnSeekResponseReplyDetailsPreview').css('color','#114A86');
	
	document.getElementById('dakDetailsMod').style.display = 'none';
	document.getElementById('replyDetailsMod').style.display = 'none';
	document.getElementById('caseworkerReplyMod').style.display = 'none';
	document.getElementById('pncDoReplyMod').style.display = 'block';
	document.getElementById('SeekResponsereplyDetailsMod').style.display = 'none';
	
});

$('.btnSeekResponseReplyDetailsPreview').click(function(event){
	 event.preventDefault(); // 
  event.stopPropagation(); // 
  $('.btnDakDetailsPreview').css('background-color','white');
	$('.btnDakDetailsPreview').css('color','#114A86');
	$('.btnReplyDetailsPreview').css('background-color','white');
	$('.btnReplyDetailsPreview').css('color','#114A86');
	$('.btnCWReplyDetailsPreview').css('background-color','white');
	$('.btnCWReplyDetailsPreview').css('color','#114A86');
	$('.btnPNCDOReplyDetailsPreview').css('background-color','white');
	$('.btnPNCDOReplyDetailsPreview').css('color','#114A86');
	$('.btnSeekResponseReplyDetailsPreview').css('background-color','#B9D9EB');
	$('.btnSeekResponseReplyDetailsPreview').css('color','#114A86');
	document.getElementById('dakDetailsMod').style.display = 'none';
	document.getElementById('replyDetailsMod').style.display = 'none';
	document.getElementById('caseworkerReplyMod').style.display = 'none';
	document.getElementById('pncDoReplyMod').style.display = 'none';
	document.getElementById('SeekResponsereplyDetailsMod').style.display = 'block';
	
	
});



function resetPreviewButtons() {
	  var defaultButton = document.querySelector(".TogglePreviewModal .btnDakDetailsPreview");
	  defaultButton.click();
}



</script>
<!-------------------------------- Common Preview JavaScript End -------------------------------------------->


<!-------------------------------- Individual Reply Preview JavaScript Start(Using Commmon style and sharing reply attach js code ) -------------------------------------------->
<script> 
function IndividualReplyPrev(DakId,EmpId,DakReplyId,DakMarkingId,countOfDakAssignReplyId){
	 $('#IndividualReply-detailedModal').appendTo('body').modal('show');
    //$('#IndividualReply-detailedModal').modal('show');

	$.ajax({
		 type : "GET",
			url : "GetIndividualReplyDetails.htm",
			data : {
				
				dakreplyid : DakReplyId,
				empid : EmpId,
				dakid : DakId
				
				
			},
			datatype : 'json',
			success : function(result) {
				
				if(result !=null){
					 var replyData = JSON.parse(result); // Parse the JSON data
					 
					  // Clear previous data
				        $(".IndividualReplyDetails").empty();
					 
					 for (var i = 0; i < replyData.length; i++) {
						    var row = replyData[i];
						    var repliedPersonName = row[6];
							$('#replierName').val(repliedPersonName);
						    var repliedPersonDesig = row[7];
						    var dakStatus = row[9];
						    var repliedRemarks = row[2];
						    var replyid= row[0];
						    var replyEmpId=row[1];
						    var loggedInEmpId = <%= EmpId %>;
						    var action = row[10];
						    var DateTime=row[5];
						    
							 var date = new Date(DateTime);

							 // Format the date and time
							 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
							     month: 'short',
							     day: 'numeric',
							     year: 'numeric',
							     hour: 'numeric',
							     minute: 'numeric'
							 }).format(date);
						    
						    
						    var dynamicReplyDiv = $("<div>", { class: "DAKReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
						    dynamicReplyDiv.after("<br>");
						    var h3 = $("<h3>", { class: "RepliedPersonName", id: "model-person-header" });

						 // Create a span element for formattedDateTime
						var span = $("<span>", { text: formattedDateTime }).css({
   							 color: "black", // Example style properties
  					  		 fontWeight: "bold",
  					  		 fontSize: "15px", 
 							   // Add more style properties as needed
							});

						 // Add the span and other content to the h4 tag
						 h3.append((i + 1) + ". " + repliedPersonName + ", " + repliedPersonDesig + ",&nbsp;");
						 h3.append(span);

						 dynamicReplyDiv.append(h3);
						   
						    var replyEditButton = $("<button>", {
						    	  type: "button",
						    	  class: "btn btn-sm icon-btn replyedit-click",
						    	  "data-toggle": "tooltip",
						    	  "data-placement": "top",
						    	  title: "Edit",
						    	  onclick: "replyCommonEdit('" + replyid + "')"
						    	});
						    
                           var editImage = $("<img>", { alt: "edit",src: "view/images/writing.png"});
                           replyEditButton.append(editImage);
                          
                           if(replyEmpId == loggedInEmpId && dakStatus!="DC" && dakStatus!="AP"){
							      dynamicReplyDiv.append(replyEditButton);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
							  }
						    
						    
						    var replyForwardForEditBtn  = $("<button>", {
						    	  type: "button",
						    	  class: "btn btn-sm icon-btn replyforwardforedit-click",
						    	  "data-toggle": "tooltip",
						    	  "data-placement": "top",
						    	  title: "Reply Forward",
						    	  onclick: "replyForwardForEdit('" + replyid + "')"
						    	});
						    
                           var forwardForEditImage = $("<img>", { alt: "edit",src: "view/images/replyChange.png"});
                          
                           if(dakStatus!="DC" && dakStatus!="AP"){
                           replyForwardForEditBtn.append(forwardForEditImage);
                           }
                        
                        /*  if(action == 'ReplyForward'){
								 dynamicReplyDiv.append(replyForwardForEditBtn);//appended replyForwardForEditBtn //From Procedure if ReplyAction returns ReplyForward than this  button is allowed
							  } */
                         dynamicReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
                         
                         
						    var innerDiv = $("<div>", { class: "row replyRow" });
						    
						    var formgroup1 = $("<div>", { class: "form-group group1" });
							
						  /*   var replyLabel = $("<label>", { class: "form-control" }).css({ fontweight: "800", fontSize: "16px", color: "#07689f;",display: "inline-block",marginbottom: "0.5rem"}).text("Reply :"); */
				
						    var replyText = repliedRemarks.length < 140 ? repliedRemarks : repliedRemarks.substring(0, 140);
						    var replyDiv = $("<div>", { class: "col-md-12 replyCSW-div", contenteditable: "false" }).text(replyText);
						    
						    if (repliedRemarks.length > 140) {
						        var button = $("<button>", {
						            type: "button",
						            class: "viewmore-click",
						            name: "sub",
						            value: "Modify",
						            onclick: "replyViewMoreModal('" + replyid + "')"
						        }).text("...(View More)");

						        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));

						        replyDiv.append(button, b);
						    }

						
				          formgroup1.append(replyDiv);   
						  innerDiv.append(formgroup1);
                        dynamicReplyDiv.append(innerDiv);
						    
				            // Check if row[8] count i.e DakReplyAttachCount is more than 0
					          if (row[8] > 0) {
					        	  // Call a function and pass row[0] i.e DakReplyId
					              DakReplyAttachPreview(row[0], dynamicReplyDiv);
					            }
                           $(".IndividualReplyDetails").append(dynamicReplyDiv);
                           
                        // Add line break after the textarea and DakReplyDivEnd
             

                           $(".IndividualReplyDetails").append("<br>");
						    
						    
					 }//for loop close
				}//if condition close
				
				
			}
	 });
	
	if(countOfDakAssignReplyId > 0){
		CSWReplyOfParticularMarkerPreview(DakMarkingId,DakId, <%= EmpId %>);
		console.log("DakAssignReplyIdCount is greater than zero called");
	}else{
		$('#FCReplyOfParticularMarker').hide();
	}
    
}
</script>
<!---------------------------------------------- Individual Reply Preview JavaScript End ----------------------------------------------->

<!-- JavaScript for showing All Caeworker of particular marker reply view INSIDE ANOTHER MODAL start -->

<script type="text/javascript">
function CSWReplyOfParticularMarkerPreview(DakMarkingId,DakId,loggedInEmpId){
	console.log("DakAssignReplyIdCount reached");

	  // Clear previous data
	  $('.MarkerReplyModalFacilitatorPreview').empty();
	  $('.MarkerNameAndDesig').empty();
      $('.MarkerFacilitatorDakReplyData').empty();
    $.ajax({
        type: "GET",
        url: "GetAllCSWReplyByMarkingIdDetails.htm",
        data: {
        	dakMarkingId: DakMarkingId,
            dakId: DakId
        },
        dataType: 'json',
        success: function(result) {
        	 console.log("Response:", result);
        	 try {
        		 if (result != null) {
   
        			  
        	            	$('#FCReplyOfParticularMarker').show();
        	            	var MarkerNameAndDesig;
        	            	 for (var i = 0; i < result.length; i++) {
 							    var data = result[i];
 							    
 							   var repliedCSWPersonName = data[4];
								$('#replierName').val(repliedCSWPersonName);
							    var repliedCSWPersonDesig = data[5];
							    var repliedData = data[6];
							    var dakAssignReplyId= data[2];
							    var replyEmpId=data[3];
							    var loggedInEmpId = <%= EmpId %>;
							    var MarkerPersName = data[8];
							    var MarkerPersDesig = data[9];
							    var dakStatus = data[10];
							    var DateTime=data[11];
							    
								 var date = new Date(DateTime);

								 // Format the date and time
								 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
								     month: 'short',
								     day: 'numeric',
								     year: 'numeric',
								     hour: 'numeric',
								     minute: 'numeric'
								 }).format(date);
							    
							    
							    MarkerNameAndDesig = " (Marked By - " + MarkerPersName + "," + MarkerPersDesig + ")";
							    var dynamicCSWReplyDiv = $("<div>", { class: "DAKCSWReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
							    dynamicCSWReplyDiv.after("<br>");
							    var h4 = $("<h4>", {
							    	  class: "CSWRepliedPersonName",
							    	  id: "model-person-header",
							    	  html: (i + 1) + "." + repliedCSWPersonName + "," + repliedCSWPersonDesig + " ,"+
							    	  "  <span style='color: black; font-size:15px;'> " + formattedDateTime + "</span> "
							    	});
							    dynamicCSWReplyDiv.append(h4);//appended h4
                        
   							dynamicCSWReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
                              
                              
							    var innerCSWReplyDiv = $("<div>", { class: "row replyRow" });
							    
							    var formgroup1 = $("<div>", { class: "form-group group1" });
								
							  /*   var replyLabel = $("<label>", { class: "form-control" }).css({ fontweight: "800", fontSize: "16px", color: "#07689f;",display: "inline-block",marginbottom: "0.5rem"}).text("Reply :"); */
					
							    var replyCSWText = repliedData.length < 140 ? repliedData : repliedData.substring(0, 140);
							    var replyCSWDiv = $("<div>", { class: "col-md-12 replyCSW-div", contenteditable: "false" }).text(replyCSWText);
							    
							    if (repliedData.length > 140) {
							        var button = $("<button>", {
							            type: "button",
							            class: "viewmore-click",
							            name: "sub",
							            value: "Modify",
							            onclick: "replyCSWViewMoreModal('" + dakAssignReplyId + "')"
							        }).text("...(View More)");

							        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));

							        replyCSWDiv.append(button, b);
							    }

							
					          formgroup1.append(replyCSWDiv);   
					          innerCSWReplyDiv.append(formgroup1);
					          dynamicCSWReplyDiv.append(innerCSWReplyDiv);

					            // Check if row[7] count i.e DakReplyAttachCount is more than 0
						          if (data[7] > 0) {
						        	  // Call a function and pass row[2] i.e DakAssignReplyId
						              DakCSWReplyAttachPreview(data[2], dynamicCSWReplyDiv); //reusing the DakCSWReplyAttachPreview from common modals.jsp however oneverclick whole diuv will be emptied
						            }
					            
						         $(".MarkerFacilitatorDakReplyData").append(dynamicCSWReplyDiv);
						         
						      // Add line break after the textarea and DakReplyDivEnd
				                  

	                                $(".MarkerFacilitatorDakReplyData").append("<br>");
 							    
        	            	 }//for loop close
        	             	  $('.MarkerNameAndDesig').append(MarkerNameAndDesig);
        	   
        	            
        	            }//if condition close
        	        
             } catch (error) {
                 console.error("Error parsing JSON:", error);
             }
         },
         error: function(xhr, status, error) {
             console.error("AJAX request error:", status, error);
         }
         
    });
}
</script> 
<!-- JavaScript for showing All Caeworker of particular marker reply view modal INSIDE ANOTHER MODAL  END -->

<!-- JavaScript for showing All facilitator of specific marker reply view WITH INDEPENDENT MODAL start -->
<script> 


function FacilitatorsReplyOfSpecificMarker(DakMarkingId,DakId,loggedInEmpId){

	  // Clear previous data
	  $('.NameAndDesigOfMarker').empty();
	  $('.FacilitaorsReplyOfSpecificMarkerData').empty();
	  $('#FacilitaorsReplyOfSpecificMarkerModal').modal('show');
    $.ajax({
        type: "GET",
        url: "GetAllCSWReplyByMarkingIdDetails.htm",
        data: {
        	dakMarkingId: DakMarkingId,
            dakId: DakId
        },
        dataType: 'json',
        success: function(result) {
        	 console.log("Response:", result);
        	 try {
        		 if (result != null) {
        	            	var MarkerNameAndDesig;
        	            	 for (var i = 0; i < result.length; i++) {
 							    var data = result[i];
 							    
 							   var repliedCSWPersonName = data[4];
								$('#replierName').val(repliedCSWPersonName);
							    var repliedCSWPersonDesig = data[5];
							    var repliedData = data[6];
							    var dakAssignReplyId= data[2];
							    var replyEmpId=data[3];
							    var loggedInEmpId = <%= EmpId %>;
							    var MarkerPersName = data[8];
							    var MarkerPersDesig = data[9];
							    var dakStatus = data[10];
							    
							    var DateTime=data[11];
							    
								 var date = new Date(DateTime);

								 // Format the date and time
								 var formattedDateTime = new Intl.DateTimeFormat('en-US', {
								     month: 'short',
								     day: 'numeric',
								     year: 'numeric',
								     hour: 'numeric',
								     minute: 'numeric'
								 }).format(date);
							    
							    MarkerNameAndDesig = " (Marked By - " + MarkerPersName + "," + MarkerPersDesig + ")";
							
						
							    var dynamicCSWReplyDiv = $("<div>", { class: "DAKCSWReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
							    dynamicCSWReplyDiv.after("<br>");
							    var h4 = $("<h4>", {
							    	  class: "CSWRepliedPersonName",
							    	  id: "model-person-header",
							    	  html: (i + 1) + "." + repliedCSWPersonName + "," + repliedCSWPersonDesig + ","+
							    	  "  <span style='color: black; font-size:15px;'> " + formattedDateTime + "</span> "
							    	});
							    dynamicCSWReplyDiv.append(h4);//appended h4
							   
		
                              
                        
   							dynamicCSWReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
                              
                              
							    var innerCSWReplyDiv = $("<div>", { class: "row replyRow" });
							    
							    var formgroup1 = $("<div>", { class: "form-group group1" });
								
							  /*   var replyLabel = $("<label>", { class: "form-control" }).css({ fontweight: "800", fontSize: "16px", color: "#07689f;",display: "inline-block",marginbottom: "0.5rem"}).text("Reply :"); */
					
							    var replyCSWText = repliedData.length < 140 ? repliedData : repliedData.substring(0, 140);
							    var replyCSWDiv = $("<div>", { class: "col-md-12 replyCSW-div", contenteditable: "false" }).text(replyCSWText);
							    
							    if (repliedData.length > 140) {
							        var button = $("<button>", {
							            type: "button",
							            class: "viewmore-click",
							            name: "sub",
							            value: "Modify",
							            onclick: "replyCSWViewMoreModal('" + dakAssignReplyId + "')"
							        }).text("...(View More)");

							        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));

							        replyCSWDiv.append(button, b);
							    }

							
					          formgroup1.append(replyCSWDiv);   
					          innerCSWReplyDiv.append(formgroup1);
					          dynamicCSWReplyDiv.append(innerCSWReplyDiv);

					            // Check if row[7] count i.e DakReplyAttachCount is more than 0
						          if (data[7] > 0) {
						        	  // Call a function and pass row[2] i.e DakAssignReplyId
						              DakCSWReplyAttachPreview(data[2], dynamicCSWReplyDiv); //reusing the DakCSWReplyAttachPreview from common modals.jsp however oneverclick whole diuv will be emptied
						            }
					            
						         $(".FacilitaorsReplyOfSpecificMarkerData").append(dynamicCSWReplyDiv);
						         
						      // Add line break after the textarea and DakReplyDivEnd
				                  

	                                $(".FacilitaorsReplyOfSpecificMarkerData").append("<br>");
 							    
        	            	 }//for loop close
        	            	 
        	            	    $('.NameAndDesigOfMarker').append(MarkerNameAndDesig);
        	            	 
        	            	 
        	            
        	            }//if condition close
        	        
             } catch (error) {
                 console.error("Error parsing JSON:", error);
             }
         },
         error: function(xhr, status, error) {
             console.error("AJAX request error:", status, error);
         }
         
    });
}


</script> 
<!-- JavaScript for showing All facilitator of specific marker reply view WITH INDEPENDENT MODAL End -->

<!---------------------------------------------- IFrame pdf  JavaScript Start ----------------------------------------------->

<script>  

function Iframepdf(data){
	
	
	 $.ajax({
			
			type : "GET",
			url : "getiframepdf.htm",
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
</script>



<script>  

function IframepdfMarkerReply(data,ref){
	
	
	 $.ajax({
			
			type : "GET",
			url : "IframeReplyDownloadAttach.htm",
			data : {
				
				data: data
				
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			 $('#modalbody').html('');
			 if(result[0]==='pdf' || result[0]==='PDF' || result[0]==='Pdf'){// Check for .pdf files
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
			    	document.getElementById('markerlargedocument').value=data;
			   	 $('#myModalMarkerlarge').appendTo('body').modal('show');
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
		
			} else if (result[0] === 'txt') { // Check for .txt files
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
			   
			} else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
				if(ref==0)
				{
				const form = document.getElementById('Replyform');
				 $("#ReplyIframeData").val(data);  
				 $("#ReplyIframeDataEdit").val(data);
				 form.action = 'ReplyDownloadAttach.htm';
				 form.submit();
				}
			else if(ref==1)
				{
				const form = document.getElementById('formId');
				 $("#ReplyIframeData").val(data);  
				 form.action = 'ReplyDownloadAttach.htm';
				 form.submit();
				}
			
			} else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {// Check for .docx files
				 $('#myModalPreview').appendTo('body').modal('show');
			       // $('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64," + result[1] + "' width='100%' height='0' id='iframes' type='application/vnd.openxmlformats-officedocument.wordprocessingml.document' name='showiframes'></iframe>");
			      
			       // Get the base64-encoded DOCX content from result[1]
				 const base64Content = result[1];

				 // Convert the base64 content into a Uint8Array
				 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

				 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
				 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });

				 // Create a temporary anchor element for downloading
				 const a = document.createElement('a');
				 a.href = URL.createObjectURL(blob);
				 a.download = result[2]+''; // Set the desired filename with .docx extension

				 // Trigger the download
				 a.click();

				 // Clean up the temporary anchor and Blob URL after the download
				 URL.revokeObjectURL(a.href);
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
</script>


<script>  

function IframepdfCaseWorkerReply(data){
	
	
	 $.ajax({
			
			type : "GET",   
			url : "IframeReplyCSWDownloadAttach.htm",
			data : {
				
				data: data
				
			},
			datatype : 'json',
			success : function(result) {
			result = JSON.parse(result);
			 $('#modalbody').html('');
			 if(result[0]==='pdf' || result[0]==='PDF' || result[0]==='Pdf'){// Check for .pptx files
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
			    	document.getElementById('cswlargedocument').value=data;
					 $('#myModalCSWlarge').appendTo('body').modal('show'); 
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
			    }
			 }else if (result[0] === 'xls' || result[0] === 'xlsx' || result[0] === 'XLS' || result[0] === 'XLSX'|| result[0] === 'Xls' || result[0] === 'Xlsx') {// Check for .xls files
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
			} else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {// Check for .docx files
				 $('#myModalPreview').appendTo('body').modal('show');
			        //$('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64," + result[1] + "' width='100%' height='0' id='iframes' type='application/vnd.openxmlformats-officedocument.wordprocessingml.document' name='showiframes'></iframe>");
			      
			        // Get the base64-encoded DOCX content from result[1]
				 const base64Content = result[1];

				 // Convert the base64 content into a Uint8Array
				 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

				 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
				 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });

				 // Create a temporary anchor element for downloading
				 const a = document.createElement('a');
				 a.href = URL.createObjectURL(blob);
				 a.download = result[2]+''; // Set the desired filename with .docx extension

				 // Trigger the download
				 a.click();

				 // Clean up the temporary anchor and Blob URL after the download
				 URL.revokeObjectURL(a.href);
			        $('#myModalPreview').modal('hide');
			} else if (result[0] === 'txt'|| result[0] === 'TXT' || result[0] === 'Txt') { // Check for .txt files
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
			    }
				else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
					const form = document.getElementById('CWReplyIframeForm');
					 $("#CWReplyIframe").val(data);  
					 form.action = 'ReplyCSWDownloadAttach.htm';
					 form.submit();
				    }
				else if (['jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'gif', 'avif', 'png'].includes(result[0].toLowerCase())) {
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
</script>



<script>  

function IframepdfForPnCAttachedDocs(data,ref){
	
	
	 $.ajax({
			
			type : "GET",
			url : "IframePnCReplyDownloadAttach.htm",
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
			    	document.getElementById('PnClargedocument').value=data;
					 $('#myModalPnCReplylarge').appendTo('body').modal('show');
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
				    
				 
				 // $('#modalbody').html("<iframe src='data:application/vnd.ms-excel;base64," + result[1].toString() + "' width='100%' height='650' id='iframes' type='application/vnd.ms-excel' name='showiframes'></iframe>");
			    $('#myModalPreview').modal('hide');
			} else if (result[0] === 'docx'  || result[0] === 'DOCX' || result[0] === 'Docx') {
				$('#myModalPreview').modal('show');
			       // $('#modalbody').html("<iframe src='data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64," + result[1] + "' width='100%' height='0' id='iframes' type='application/vnd.openxmlformats-officedocument.wordprocessingml.document' name='showiframes'></iframe>");
			       
			       // Get the base64-encoded DOCX content from result[1]
				 const base64Content = result[1];

				 // Convert the base64 content into a Uint8Array
				 const byteArray = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

				 // Create a Blob from the Uint8Array, specifying the MIME type for DOCX
				 const blob = new Blob([byteArray], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });

				 // Create a temporary anchor element for downloading
				 const a = document.createElement('a');
				 a.href = URL.createObjectURL(blob);
				 a.download = result[2]+''; // Set the desired filename with .docx extension

				 // Trigger the download
				 a.click();

				 // Clean up the temporary anchor and Blob URL after the download
				 URL.revokeObjectURL(a.href);
			       $('#myModalPreview').modal('hide');
			} else if (result[0] === 'txt' || result[0] === 'Txt' || result[0] === 'TXT') { // Check for .txt files
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
			    }
				else if (result[0] === 'pptx' || result[0] === 'PPTX' || result[0] === 'Pptx') { // Check for .pptx files
					if(ref==0)
						{
						const form = document.getElementById('PCReplyIframeForm');
						 $("#PCReplyIframe").val(data);
						 form.action = 'PnCReplyDownloadAttach.htm';
						 form.submit();
						}
					else if(ref==1)
						{
						const form = document.getElementById('consolidatedReplyByRTMDO');
						 $("#PCReplyIframe").val(data);
						 form.action = 'PnCReplyDownloadAttach.htm';
						 form.submit();
						}
					
				    }
				else if (['jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'gif', 'avif', 'png'].includes(result[0].toLowerCase())) {
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
</script>

<script>  

function IframepdfSeekResponseReply(data){
	
	
	 $.ajax({
			
			type : "GET",
			url : "getSeekResponseiframepdf.htm",
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
</script>

<!---------------------------------------------- IFrame pdf  JavaScript End ----------------------------------------------->
    	      
  	      <script type="text/javascript">

var count=1;
$("table").on('click','.tr_editreply_addbtn' ,function() {
   var $tr = $('.tr_editreply').last('.tr_editreply');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.tr_editreply_sub' ,function() {
	
var cl=$('.tr_editreply').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.tr_editreply');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});
</script>
</html>