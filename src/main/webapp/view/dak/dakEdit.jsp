<%@page import="java.time.LocalTime"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.vts.dms.dak.model.DakMain"%>
<%@page import="com.vts.dms.master.model.DivisionMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="ISO-8859-1">
<title>DAK Edit</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label{
  font-weight: bold;
  font-size: 14px;
}
</style>
<style>
div.dropdown-menu.open
    {
        max-height: 410px !important;
        overflow: hidden;
    }
    ul.dropdown-menu.inner
    {
        max-height: 410px !important;
       /*  overflow-y: auto; */
    }
  

h1 { font-size: 32px; }
h2 { font-size: 26px; }
h3 { font-size: 18px; }
p { margin: 0 0 15px; line-height: 24px; color: gainsboro; }


.container { 
  max-width: 960px; 
  height: 100%;
  margin: 0 auto; 
  padding: 20px;
}

/* ------------------- */
/* PEN STYLES      -- */
/* ----------------- */

/* MAKE IT CUTE ----- */
.tabs {
  position: relative;
  display: flex;
  min-height: 500px;
  border-radius: 8px 8px 0 0;
  overflow: scroll;
}
.tabs::-webkit-scrollbar {
    display: none;
}
.tabby-tab {
  flex: 1;
}

.tabby-tab label {
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

.tabby-tab label:hover {
  background: #5488BF ;
}

.tabby-content {
  position: absolute;
  
  left: 0; bottom: 0; right: 0;
  /* clear the tab labels */
    top: 40px; 
  
  padding: 20px;
  border-radius: 0 0 8px 8px;
  background: white;
  
  transition: 
    opacity 0.8s ease,
    transform 0.8s ease   ;
  
  /* show/hide */
    opacity: 0;
    transform: scale(0.1);
    transform-origin: top left;
  
}

.tabby-content img {
  float: left;
  margin-right: 20px;
  border-radius: 8px;
}


/* MAKE IT WORK ----- */

.tabby-tab [type=radio] { display: none; }
[type=radio]:checked ~ label {
  background: #5488BF ;
  z-index: 2;
}

[type=radio]:checked ~ label ~ .tabby-content {
  z-index: 1;
  
  /* show/hide */
    opacity: 1;
    transform: scale(1);
}

/* BREAKPOINTS ----- */
@media screen and (max-width: 767px) {
  .tabs { min-height: 400px;}
}

@media screen and (max-width: 480px) {
  .tabs { min-height: 580px; }
  .tabby-tab label { 
    height: 60px;
  }
  .tabby-content { top: 60px; }
  .tabby-content img {
    float: none;
    margin-right: 0;
    margin-bottom: 20px;
  }
}
.custom-select {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  width: 200px;
}

.custom-select select {
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
.custom-select::after {
  content: '\25BC'; /* Unicode for downward-pointing triangle or arrow */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  /* Customize the arrow appearance */
  font-size: 10px;
  color: #666;
}

.Groupname{
width: 300px !important;
}
.empidSelect{
width: 280px !important;
/* margin-left: 400px !important; */
margin-top: -20px !important;
}
.individual{
width: 290px !important;
margin-left: -5px !important;
margin-top: -20px !important;
}

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

/* [data-id="RelaventId"] {
    background-color: lightblue; 
}
[data-id="ProId"] {
    background-color: lightblue; 
}
[data-id="ProId1"] {
    background-color: lightblue; 
}
[data-id="ProId2"] {
    background-color: lightblue; 
} */

</style>
</head>
<body>
<%List<Object[]>  sourceList=(List<Object[]>)request.getAttribute("SourceList");
List<Object[]>  dakDeliveryList=(List<Object[]>)request.getAttribute("DakDeliveryList");
List<Object[]>  priorityList=(List<Object[]>)request.getAttribute("priorityList");
List<Object[]>  letterList=(List<Object[]>)request.getAttribute("letterList");
List<Object[]>  relaventList=(List<Object[]>)request.getAttribute("relaventList");
List<Object[]>  linkList=(List<Object[]>)request.getAttribute("linkList");
List<Object[]>  nonProjectList=(List<Object[]>)request.getAttribute("nonProjectList");
List<Object[]>  cwList=(List<Object[]>)request.getAttribute("cwList");
List<Object[]>  actionList=(List<Object[]>)request.getAttribute("actionList");
List<Object[]>  divList=(List<Object[]>)request.getAttribute("divList");

List<Object[]>  OtherProjectList=(List<Object[]>)request.getAttribute("OtherProjectList");
String DakIdSelFrEdit=(String)request.getAttribute("dakIdSelFrEdit");
DakMain dakData=(DakMain)request.getAttribute("DakData");
String counts=(String)request.getParameter("count");
String letterno=(String)request.getParameter("letterno");
String ActionCode=(String)request.getAttribute("ActionCode");

String selectedEmployeeIds=(String)request.getAttribute("selectedEmployeeIds");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> DakMembers = (List<Object[]>) request.getAttribute("DakMembers");
List<Object[]> DakMarkingData=(List<Object[]>)request.getAttribute("DakMarkingData");//All Marked Employees for particular Dak
List<Object[]> dakLinkData=(List<Object[]>)request.getAttribute("dakLinkData");

List<Object[]> DakMemberGroup = (List<Object[]>) request.getAttribute("DakMemberGroup");
List<Object[]> dakClosingAuthorityList = (List<Object[]>)request.getAttribute("dakClosingAuthorityList");
		
String frmDtE=(String)request.getAttribute("fromDateRedir");
String toDtE=(String)request.getAttribute("toDateRedir");	

String PageNoData=(String)request.getAttribute("PageNoData");
String RowData=(String)request.getAttribute("RowData");	

String ActionRedirectVal=(String)request.getAttribute("RedirectVal");//Code for  DAK Director List Redirect
String ActionForm=(String)request.getAttribute("ActionForm");
%>


<div class="card-header page-top">
		<div class="row">
			<div class="col-md-5 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Initiation Edit(DAK Id:<span><%=dakData.getDakNo() %></span>)</h5>
			</div>
			<div class="col-md-7" >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item"><a href="DakDashBoard.htm"><i class="fa fa-envelope"></i> DAK</a></li>
				    <%if(ActionForm.equalsIgnoreCase("DakPendingList")){%>
				    <li class="breadcrumb-item"><a href="DakInitiationList.htm">DAK Pending List</a></li>
				    <%}else if(ActionForm.equalsIgnoreCase("DakDetailedList")) {%>
				    <li class="breadcrumb-item"><a href="DakList.htm">DAK List</a></li>
				    <%}else{ %>
				    <li class="breadcrumb-item"><a href="DakDirectorList.htm">DAK Director List</a></li>
				    <%} %>
				    <li class="breadcrumb-item active">DAK Initiation Edit</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
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
<div id="pass" style="margin-left: 35%;" align="center">
		<div  role="alert">
			<span >Source SuccessFully Added..!</span>
	</div>
	</div>
	
	<div id="fail" style="margin-left: 35%;" align="center">
		<div  role="alert">
			<span >Source Added UnSuccessful..!</span>
	</div>
	</div>
	
	
	<div id="passNonProject" style="margin-left: 35%;" align="center">
		<div  role="alert">
			<span >Non Project SuccessFully Added..!</span>
	</div>
	</div>
	 
	<div id="failNonProject" style="margin-left: 35%;"  align="center">
		<div  role="alert">
			<span >Non Project Added UnSuccessful..!</span>
	</div>
	</div>
	
	<div id="passOtherProject" style="margin-left: 35%;" align="center">
		<div  role="alert">
			<span >Other Project SuccessFully Added..!</span>
	</div>
	</div>
	 
	<div id="failOtherProject" style="margin-left: 35%;"  align="center">
		<div  role="alert">
			<span >Other Project Added UnSuccessful..!</span>
	</div>
	</div>
  
  <div class="container-fluid datatables">
	<div class="row" style="margin-top: 0px; margin-bottom: 5px;">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
			
        
        		<div class="card-body">
        	     			<form action="DakEditSubmit.htm" method="POST" name="myfrm" id="myfrm" enctype="multipart/form-data">
        	     				
        	     				<input type="hidden" name="RedirectVal"  value="<%=ActionRedirectVal%>" /><!-- Code for  DAK Director List Redirect only -->
                		
                		<div class="row">
                          
                          <div class="col-sm-2" align="left"  >
                          <div class="form-group">
                            		<label class="control-label">DAK  Type</label>
                              		<select class="readonly-dropdown form-control custom-select select selectpicker" id="DakDeliveryId" data-live-search="true" required="required" 
                              		 <% if (dakData.getDakCreateId() != null) { %> 
        								style="pointer-events: none; background-color: #e9ecef; opacity: 1;" 
       																		 onfocus="this.blur();"
   																					 <% } %>name="DakDeliveryId" >
    							           <%
    							           if(dakDeliveryList!=null && dakDeliveryList.size()>0){
    							           for (  Object[] obj : dakDeliveryList){ %>
				                          <option value=<%=obj[0]%> <%if(dakData.getDeliveryTypeId()!=null && dakData.getDeliveryTypeId().toString().equals(obj[0].toString())){%> selected="selected" <%} %>><%=obj[1].toString()%> </option>
				                              <%} }%>
  									</select>
                        		</div>
                           </div>
                           <input type="hidden" name="SourcetypeId" id="SourcetypeId" value="<%=dakData.getSourceDetailId()%>">
                           <input type="hidden"  id="getProjectId" value="<%=dakData.getProjectId()%>">
                           <input type="hidden"  id="getProjecttype" value="<%=dakData.getProjectType()%>">
                           
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">DAK Priority  </label>
                              		<select class="readonly-dropdown form-control custom-select selectpicker" id="PriorityId" data-live-search="true" required="required" name="PriorityId">
    							           <% 
											if(priorityList!=null && priorityList.size()>0){    							           
    							           for (  Object[] obj : priorityList){ %>
				                          <option value=<%=obj[0]%>  <%if(dakData.getPriorityId()!=null && dakData.getPriorityId().toString().equals(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[1].toString()%> </option>
			
				                              <%} }%>
  									</select>
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">DAK Letter Type  </label>
                              		<select class="readonly-dropdown form-control custom-select selectpicker" id="LetterId" data-live-search="true" required="required" name="LetterId">
    							           <% 
    							           if(letterList!=null && letterList.size()>0){
    							           for (  Object[] obj : letterList){ %>
				                          <option value=<%=obj[0]%>  <%if(dakData.getLetterTypeId()!=null && dakData.getLetterTypeId().toString().equals(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[1].toString()%> </option>
				                              <%}} %>
  									</select>
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-2" >
                        		<div class="form-group">
                            		<label class="control-label" >SourceType</label>
	                                 <select class="readonly-dropdown form-control custom-select selectpicker" id="sourceid" data-live-search="true" required="required" name="SourceId" >
    							           <% 
    							           if(sourceList!=null && sourceList.size()>0){
    							           for ( Object[] obj : sourceList){ %>
				                       <option   <%if(dakData.getSourceId() !=null &&   dakData.getSourceId().toString().equals(obj[0].toString())){   %> 
								               selected="selected" <%}%>
								                value=<%=obj[0]%>><%=obj[1].toString()%></option>
			
				                              <%}}%>
  									</select>                        		
  								</div>
                    		</div>
                    		<div class="col-md-4" >
                        		<div class="form-group">
                            		<label class="control-label" >Source</label>
	                                 <select class="readonly-dropdown form-control custom-select selectpicker"  id="SourceType" data-live-search="true" name="SourceType" required="required" >
    							           
  									</select>                        		</div>
                    		</div>
                    
                </div>
                	<div class="row">

             
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Receipt Date</label>
                              		<input  class="readonly-dropdown form-control form-control"   name="Receiptdate" value="<%if(dakData.getReceiptDate()!=null){ %><%=sdf.format(dakData.getReceiptDate()) %><%} %>" style="font-size: 15px;" id="Receiptdate">
                        		</div>
                    		</div>
                    		<div class="col-md-2 ">
                        		<div class="form-group">
                            		<label class="control-label">Ref No</label>
                            	   	<input  class="form-control form-control"  type="text" name="RefNo" value="<%if(dakData.getRefNo()!=null){ %><%=dakData.getRefNo().toString() %><%} %>"  style="font-size: 15px;" <%if(dakData.getDakCreateId()!=null){ %>readonly="readonly"<%} %>  id="">
                        		</div>
                    		</div>
                    		<div class="col-md-2 ">
                        		<div class="form-group">
                            		<label class="control-label">RefNo Dated</label>
                            	   	<input  class="readonly-dropdown form-control form-control"   name="RefDate" value="<%if(dakData.getRefDate()!=null){ %><%=sdf.format(dakData.getRefDate()) %><%} %>"  style="font-size: 15px;"  id="docdate">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Non-Project/Project</label>
	                                 <select class="form-control custom-select selectpicker" id="RelaventId" required="required" name="ProjectType" onchange="changeProject()" style="background-color: orange;">
    									<option  value="N" <%if(dakData.getProjectType()!=null && dakData.getProjectType().toString().equals("N")) {%> selected="selected" <%} %>>Non-Project</option>
    									<option  value="P" <%if(dakData.getProjectType()!=null && dakData.getProjectType().toString().equals("P")){%> selected="selected" <%} %>>Project</option>
    							        <option  value="O" <%if(dakData.getProjectType()!=null && dakData.getProjectType().toString().equals("O")){ %> selected="selected" <%} %>>Project(Others)</option>
  									</select>                        		
  								</div>
                    		</div>
                   	        <div class="col-md-4" id="prodiv">
                        		<div class="form-group" >
                            		<label class="control-label" id="proname">Project</label>
                              		<select class="form-control custom-select selectpicker" id="ProId" 
                              		onchange = "return projectDirectorAutoSelect()"
                              		data-live-search="true"  required="required" name="ProId" >
    							          <% 
    							          if(relaventList!=null && relaventList.size()>0){
    							          for (  Object[] obj : relaventList){ %>
    							           <option   <%if(dakData.getProjectId()!=null &&  dakData.getProjectType().toString().equals("P") &&   dakData.getProjectId().toString().equals(obj[0].toString())){ %> 
								               selected="selected"  <%}%>
								                value=<%=obj[0]%>><%=obj[1]+" - "+obj[2]%></option>
				                          <%}} %>
  									</select>
  									<input type="hidden" name="prevSelProjectId" value=" <%if(dakData.getProjectId()!=null &&  dakData.getProjectType().toString().equals("P") ){ %> <%=dakData.getProjectId()%><%}%>">
                        		
                        		
                        		</div>
                    		    </div>
                    		    <div class="col-md-4" hidden="true" id="prodiv1" >
                        		<div class="form-group" >
                            		<label class="control-label" id="proname1"></label>
  									<select class="form-control custom-select selectpicker" id="ProId1" data-live-search="true"  required="required" name="NonProId">
	    							
  									</select>
                        		</div>
                    		    </div>
                    		     <div class="col-md-4" hidden="true" id="prodiv2">
                        		<div class="form-group" >
                              		<label class="control-label" id="proname2">Project (Others)<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  									<select class="form-control custom-select selectpicker" id="ProId2"  data-live-search="true" name="OtherProId">
    							     
  									</select>
                        		</div>
                    		     </div>
                    		</div>
                    		<div class="row">

                               <div class="col-md-6">
                        		<div class="form-group">
                            		<label class="control-label">Subject </label>		
                              		<input  class="form-control form-control"  type="text" name="Subject" value="<%if(dakData.getSubject()!=null){ %><%=dakData.getSubject().toString() %><%} %>"  maxlength="1000" style="font-size: 15px;" <%if(dakData.getDakCreateId()!=null){ %>readonly="readonly" <%} %>>
                        		</div>
                    		</div>
                               <div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Action Required</label>
	                                 <select class="readonly-dropdown form-control custom-select selectpicker" id="Action" onchange="changeFunc();" required="required" name="ActionId">
    							           <%
    							           if(actionList!=null && actionList.size()>0){
    							           for (  Object[] obj : actionList){ %>
											<option  
								<%if(dakData.getActionId()!=null &&   dakData.getActionId().toString().equals(obj[0].toString())){   %> 
								selected="selected" <%}%>
								value="<%=obj[0]%>#<%=obj[1]%>"><%=obj[1].toString()%></option>
				                              <%}} %>
  									</select>                        		</div>
                    		</div>
                    		<div class="col-md-2 ActionDueDate">
                        		<div class="form-group">
                            		<label class="control-label">Action Due Date</label>
                            	   	<input  class="readonly-dropdown form-control form-control"   name="DueDate" <%if(dakData.getActionDueDate()!=null){%> value="<%=sdf.format(dakData.getActionDueDate()) %>"<%} %>  maxlength="255" style="font-size: 15px;"  id="duedate">
                        			<%if(dakData.getActionDueDate()!=null){ %>
                        			<input type="hidden" id="editDueDate" value="<%=sdf.format(dakData.getActionDueDate())%>">
                        			<%} %>
                        		</div>
                    		</div>
                    		<div class="col-md-2 ActionTime" >
                        		<div class="form-group">
                            		<label class="control-label">Action Time</label>
                            	   	<input type="text" class="readonly-dropdown form-control form-control" name="DueTime" <%if(dakData.getActionTime()!=null){%> value="<%=dakData.getActionTime() %>"<%}else{ %>value="<%=LocalTime.of(16, 30)%>"<%} %> style="font-size: 15px;"  id="DueTime" <%if(dakData.getDakCreateId()!=null){ %>readonly="readonly"<%} %> required="required" >
                        		</div>
                        		</div>
                    		</div>
                    		<div class="row">
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">Link DAK</label>		
                                      <select class="readonly-dropdown form-control selectpicker" id="DakLinkId" data-live-search="true" multiple="multiple" name="DakLinkId">
    							         
    							           <%
    							           if(linkList!=null && linkList.size()>0){
    							           for(Object[] type : linkList){
    							        		String Subject="";
												if(type[2]!=null && type[2].toString().trim()!=""){
													Subject = ", "+type[2].toString();
												}  

%>
    							        		   <option <% for (  Object[] obj : dakLinkData){  if(obj[1].equals(type[0])){ %>selected="selected"<%}}%>  value=<%=type[0]%>><%=type[1].toString()%><%=Subject.trim()%>
    							     		    </option>
				                              <%}}%>
				                              
				                              <option value="0" <% for (  Object[] obj : dakLinkData){ if(obj[1].toString().equals("0")){ %>selected="selected"<%}}%>>Not Applicable </option> 
				                              
  									   </select>                        		</div>
                    		</div>
                    		
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Keyword 1</label>
                                  <input  class="form-control form-control"  type="text" name="Key1" value="<%if(dakData.getKeyWord1()!=null){ %><%=dakData.getKeyWord1().toString() %><%} %>" <%if(dakData.getDakCreateId()!=null){ %>readonly="readonly"<%} %> maxlength="100" style="font-size: 15px;"  id="Key1">
     		                   </div>
                    		</div>
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Keyword 2</label>
	                              	<input  class="form-control form-control"  type="text" value="<%if(dakData.getKeyWord2()!=null){ %><%=dakData.getKeyWord2().toString() %><%} %>" name="Key2" <%if(dakData.getDakCreateId()!=null){ %>readonly="readonly"<%} %> maxlength="100" style="font-size: 15px;"  id="Key2">
                       		</div>
                    		</div>
                      		<div class="col-md-2 ">
                         		<div class="form-group">
                            		<label class="control-label">Keyword 3</label>
                            	   	<input  class="form-control form-control"  type="text" value="<%if(dakData.getKeyWord3()!=null){ %><%=dakData.getKeyWord3().toString() %><%} %>" name="Key3"  maxlength="100" style="font-size: 15px;" <%if(dakData.getDakCreateId()!=null){ %>readonly="readonly"<%} %>  id="Key3">
                        		</div>
                    		</div>
                    		<div class="col-md-2 ">
                        		<div class="form-group">
                            		<label class="control-label">Keyword 4</label>
                            	   	<input  class="form-control form-control"  type="text" value="<%if(dakData.getKeyWord4()!=null){ %><%=dakData.getKeyWord4().toString() %><%} %>" name="Key4"  maxlength="100" style="font-size: 15px;"  <%if(dakData.getDakCreateId()!=null){ %>readonly="readonly"<%} %> id="Key4">
                        		</div>
                    		</div>
                    		</div>
                			
                   <div class="row">

                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label class="control-label">Brief on DAK </label>		
                              		<input  class="form-control form-control"  type="text" name="Remarks" value="<%if(dakData.getRemarks()!=null){ %><%=dakData.getRemarks().toString()%><%} %>"  maxlength="1000" style="font-size: 15px;" <%if(dakData.getDakCreateId()!=null){ %>readonly="readonly"<%} %> >
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-3">
	                        		<div class="form-group">
	                            		<label class="control-label">Signatory </label>		
	                              		<input  class="form-control form-control"  type="text" name="Signatory"  value="<%if(dakData.getSignatory()!=null){ %><%=dakData.getSignatory().toString()%><%}%> "maxlength="50" style="font-size: 15px;" <%if(dakData.getDakCreateId()!=null){ %>readonly="readonly"<%} %>>
	                        		</div>
	                    		</div>
	                    		
	                    	
	                    		
	                    			<div class="col-md-2">
									<div class="form-group">
										<label class="control-label">Closing Authority<span class="mandatory" style="color: red; font-weight: normal;">*</span></label> 
                                        <select class="form-control selectpicker " id="ClosingAuthority" required="required" name="closingAuthorityEditVal" >
											<%if(dakClosingAuthorityList!=null && !dakClosingAuthorityList.isEmpty()){
											for(Object[] obj: dakClosingAuthorityList){
											%>
											<option <% if(dakData.getClosingAuthority()!=null && dakData.getClosingAuthority().toString().equalsIgnoreCase(obj[2].toString())){%>selected="selected" <%} %> value="<%=obj[2].toString()%>"><%=obj[1] %></option>
											<%}} %>
											<%-- <option <%if(dakData.getClosingAuthority()!=null && dakData.getClosingAuthority().toString().equals("P")){%> selected="selected" <%} %> value="P">P&C DO</option>
											<option <%if(dakData.getClosingAuthority()!=null && dakData.getClosingAuthority().toString().equals("K")){%> selected="selected" <%} %> value="K">D-KRM</option>
											<option <%if(dakData.getClosingAuthority()!=null && dakData.getClosingAuthority().toString().equals("A")){%> selected="selected" <%} %> value="A">D-Adm</option>
											<option <%if(dakData.getClosingAuthority()!=null && dakData.getClosingAuthority().toString().equals("R")){%> selected="selected" <%} %> value="R">DFMM</option>
											<option <%if(dakData.getClosingAuthority()!=null && dakData.getClosingAuthority().toString().equals("Q")){%> selected="selected" <%} %> value="Q">DQA</option>
											<option <%if(dakData.getClosingAuthority()!=null && dakData.getClosingAuthority().toString().equals("O")){%> selected="selected" <%} %> value="O">Others</option> --%>
										</select>
									</div>
								</div>
	                    		
	                    	
	                     <div class="col-md-1"><br>
	                    		<!-- <label class="control-label" style="font-size: 15px;">Document :</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
      							 <button type="button"  style="padding:8px;" class="btn btn-sm icon-btn" data-toggle="tooltip" Onclick="uploadDoc(<%=dakData.getDakId() %>,'<%=dakData.getRefNo() %>','M','<%=frmDtE%>','<%=toDtE%>')" data-placement="top" title="Attach" data-target="#exampleModalCenter">
 											<img alt="attach" src="view/images/attach.png">
 										  </button>
 										  </div>
 										  
                			    </div>
									<hr>
						<div class="row">
							<div class="col-md-6">
									<div align="left">
										<h6 style="text-decoration: underline;">
											<b>Group Marking</b>
										</h6>
									</div>
									<div align="right">
									<label style="margin-left: 30px;">Grouping </label>
									&nbsp;&nbsp;&nbsp;
									<select class="form-control selectpicker  Groupname "  multiple="multiple"  id="Groupname" style="width: 20%; " data-live-search="true" name="groupname[]" >
									<%
											if (DakMemberGroup != null && DakMemberGroup.size() > 0) {
												for (Object[] obj : DakMemberGroup) {
									%>
										<option	<%for(Object[] type : DakMarkingData){ %>
					     		    <%if(obj[0].equals(type[0])){ %>selected="selected" disabled="disabled"<% }%> 
					     		    <%}%> value=<%=obj[0].toString()%>><%=obj[1].toString()%></option>
											<%}}%>
											
											
									</select> </div>	
										<hr>
									<div align="left">
										<h6 style="text-decoration: underline; ">
											<b>Individual Marking</b>
										</h6>
									</div><br>
									<select  class="form-control selectpicker  individual " multiple="multiple" id="individual" name="individual[]" data-live-search="true">
										<%
										if (DakMembers != null && DakMembers.size() > 0) {
											for (Object[] obj : DakMembers) {
										%>
										<option  <%for(Object[] type : DakMarkingData){ %>
					     		    <%if(obj[0].equals(type[0])){ %>selected="selected" disabled="disabled"<% }%> 
					     		    <%}%> value="<%=obj[0] %>" ><%=obj[1].toString()%></option>
									
										<%}}%>
										<option <% if(DakMarkingData!=null && DakMarkingData.size()>0){
					     		    for(Object[] type : DakMarkingData){ %>
					     		     <%if("0".equalsIgnoreCase(type[0].toString())){ %>selected="selected" disabled="disabled" <% }%> 
					     		   <%}} %> value="0">Individual</option>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<select   onchange='addEmpToSelect()' class="form-control selectpicker empidSelect dropup" multiple="multiple" data-dropup-auto="true"  id="empidSelect" name="empid"  data-live-search="true">
									</select> 
								</div>
							
								<div class="col-md-6">
						           <div class="row">
									<div  class="col-md-12">
										<div class="card" id="scrollable-content" style="width: 100%; height: 100px; ">
										<div class="card-body">
											<input type="hidden" name="EmpIdGroup" id="EmpIdGroup" value="" />
										<div class="row" id="GroupEmp"style="" >
									
	  	      									</div>
										</div> 
										</div>
									</div></div><br><br>
									<div class="row">
									 <div  class="col-md-12">
										<div class="card" id="scrollable-contentind" style="width: 100%;   margin-top:-10px; height: 100px; ">
										<div class="card-body">
										<div class="row" id="IndEmp" style="">
										<input type="hidden" name="EmpIdIndividual" id="EmpIdIndividual" value="" />
	  	      									</div>
										</div> 
										</div>
									</div>
									</div>
								</div>
							</div>
							
							<!--(Start) If Project Type P selected only then show this div otherwise hide -->
							<div class="row" style="margin-top:-2rem;display:none;" id="projectDirectorSelected">
							<div class="col-md-6">
							<div class="form-group">
							<label class="control-label">Project Director </label> 
							<input type="hidden" name="projectDirectorEmpId" id="projectDirEmpIdVal" value="">
                            <input class="form-control form-control" type="text" id="projectDirEmpName" readonly="readonly" style="font-size: 15px;background-color: white;width:300px;">
							</div>
							</div>
							</div>
							<!--(End)-->

					<br>
      				
      	  								  <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
			                              <input type="hidden" name="dakId"	value="<%=dakData.getDakId() %>" /> 
			                              <input type="hidden" name="DakNo"	value="<%=dakData.getDakNo() %>" />
			                              <input type="hidden" name="FrmDtE"	value="<%=frmDtE%>" /> 
			                              <input type="hidden" name="ToDtE"	value="<%=toDtE%>" />
			                              <input type="hidden" name="PageNumber" value="<%=PageNoData%>">
										 <input type="hidden" name="RowNumber" value="<%=RowData%>">
			                              
        <br>
        <div class="form-group" align="center" >
	 		<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
		</div>
   <input type="hidden" name="DakId"	value="<%=dakData.getDakId() %>" />    
   <input type="hidden" name="DakNo"	value="<%=dakData.getDakNo() %>" />    
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
     
        	<div class="modal fade my-modal " id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
 	  <div class="modal-dialog modal-dialog-centered" role="document">
 	    <div class="modal-content">
  	      <div class="modal-body">
  	       
  	      <div class="tabs">
        <div class="tabby-tab">
      <input type="radio" id="tab-1" name="tabby-tabs" checked  onclick="tabChange('M')">
      <label for="tab-1">Main Document</label>
      <div class="tabby-content">
  	      		<div class="row"> 
  	      			   <div class="col-md-10">
  	      			   <%if(dakData.getDakCreateId()==null){ %>
  	      				<input class="form-control" type="file" name="dak_document"  id="dakdocument" accept="*/*"  >
  	      				<%} %>
  	      			  </div>
  	      
  	      		</div>
  	      		
  	      		<br>
  	      		<table class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtable" >
					<thead>
						<tr>
							<th style="width:5%;" >SN</th>
							<th style="width:65%;"> Item Name </th>
							<th style="width:20%; ">Action</th> 
						</tr>
					</thead>
					<tbody id="other-list-table">
					
					</tbody>
				</table>
				<input type="hidden" name="DakNo" value="<%=dakData.getDakNo()%>" /> 
				<input type="hidden" name="dakattachmentid" id="dakattachmentid"  />
  	      		<input type="hidden" name="DakId" value="<%=dakData.getDakId() %>" />
  	      		<input type="hidden" name="letterno" id="letterno" value="<%=dakData.getRefNo() %>" />
  	      		<input type="hidden" name="dakidvalue" id="dakidvalue" value="" />
  	      		<input type="hidden" name="type" id="type" value="" />
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		</div>
  	      		</div>
  	      		
  	      		<div class="tabby-tab">
      <input type="radio" id="tab-2" name="tabby-tabs" onclick="tabChange('S')">
      <label for="tab-2">Enclosures</label>
      <div class="tabby-content">
  	      		<div class="row">
  	      			<div class="col-md-10">
	     				<table>
	     						<%if(dakData.getDakCreateId()==null){ %>
	 	      					<tr><td></td>
	 	      						<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
	 	      					</tr>
	 	      					<tr class="tr_clone">
	 	      					<td><input class="form-control" type="file" name="dak_sub_document"  id="dakdocument2" accept="*/*" ></td>
	 	      						<td><button type="button" class="tr_clone_sub btn btn-sm" data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
	 	      					</tr>
	 	      					<%} %>			  	      				
	 	      				</table>
  	      			</div>
  	     
  	      		</div>
  	      		
  	      		<br>
  	      		<table class="table table-bordered table-hover table-striped table-condensed  info shadow-nohover downloadtable" >
					<thead>
						<tr>
							<th style="width:5%;" >SN</th>
							<th style="width:65%;"> Item Name </th>
							<th style="width:20%; ">Action</th> 
						</tr>
					</thead>
					<tbody id="other-list-table2">
					
					</tbody>
				</table>
  	      		<input type="hidden" name="DakNo" value="<%=dakData.getDakNo()%>" /> 
  	      		<input type="hidden" name="DakId"	value="<%=dakData.getDakId() %>" />
  	      		<input type="hidden" name="letterno" id="letterno2" value="<%=dakData.getRefNo() %>" />
  	      		<input type="hidden" name="dakattachmentid" id="dakattachmentid1"  />
  	      		<input type="hidden" name="dakidvalue" id="dakidvalue2" value="" />
  	      		<!-- <input type="hidden" name="letterno" id="letterno2" value="" /> -->
  	      		<input type="hidden" name="type" id="type2" value="" />
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      </div>
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
	</form>
	</div>   
        </div>
        <form action="DakEditDeleteAttach.htm" name="deleteform" id="deleteform" >
		<input type="hidden" name="dakattachmentid" id="dakattachmentid2"  />
		<input type="hidden" name="letterno" id="letterno" value="<%=dakData.getRefNo() %>" />
  	     <input type="hidden" name="dakidvalue" id="dakidvalue" value="" />
  	     <input type="hidden" name="type" id="type2" value="" />
		<input type="hidden" name="DakId"	value="<%=dakData.getDakId() %>" />
	</form>
	
	<!--------------------------------------------------------SOURCE Modal start--------------------------------------------->

<div class="modal fade" id="modalsource" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content" style="height: 250px;  border:black 1px solid;  width: 90%;">
      <div class="modal-header" style="background-color: #005C97;">
        <h5 class="modal-title" style="color:white;" ><b>Add Source</b></h5>
        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div><br>
      <div class="col-md-12">
      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
     	<div class="row">
                   
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Source Short Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="ShortName" type="text" name="ShortName" required="required" maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Source Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="SourceName" type="text" name="SourceName" required="required" maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                		</div>
                		<div class="col-md-12" align="center" style="margin-top: 2.4rem">
	 						     <input type="button" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="addsource()" > 
                    		</div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!---------------------------------------------------------SOURCE Modal Ends--------------------------------------------->

<!--------------------------------------------------------Non-Project Modal start--------------------------------------------->

<div class="modal fade" id="modalNonProject" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content" style="height: 250px; border:black 1px solid; ">
      <div class="modal-header" style="background-color: #005C97;">
        <h5 class="modal-title" style="color:white;"><b>Add Non-Project</b></h5>
        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div><br>
      <div class="col-md-12">
                		<div class="row">
                   
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Non-Project Short Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="NonShortName" type="text"  name="ShortName" required="required" maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Non-Project Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="NonProjectName" type="text" name="NonProjectName" required="required"  maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                		</div>
                		<div class="col-md-12" align="center" style="margin-top: 2.4rem">
	 						     <input type="button" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="addNonProject()" > 
                    		</div>
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!---------------------------------------------------------Non-Project Modal Ends--------------------------------------------->


<!--------------------------------------------------------Other-Project Modal start--------------------------------------------->

<div class="modal fade" id="modalotherproject" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content" style="height: 250px; border: black 1px solid; width: 100%;">
      <div class="modal-header" style="background-color: #005C97;">
        <h5 class="modal-title" style="color:white;" ><b>Add Other-Project</b></h5>
        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div><br>
      <div class="col-md-12">
      <form action="#" >
      <div class="row">
                		
                		    <div class="col-md-3">
                        		<div class="form-group">
                            		<label >Lab Code <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="LabCode" type="text" name="LabCode" required="required"  maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                            
                            <div class="col-md-3">
                        		<div class="form-group">
                            		<label >Project Code <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="ProjectCode" type="text"  name="ProjectCode" required="required" maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                           
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label >Project Short Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="OtherShortName" type="text"  name="ShortName" required="required" maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label >Project Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="OtherProjectName" type="text" name="OtherProjectName" required="required"  maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                		</div>
                		<div class="col-md-12" align="center" style="margin-top: 2.4rem">
	 						     <input type="button" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="addOtherProject()" > 
                    		</div>
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
      </form>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!---------------------------------------------------------Other-Project Modal Ends--------------------------------------------->
	
</div>
</div>
</div>

<script type="text/javascript">

window.onload = function() {
    // Get all select elements with the class 'readonly-dropdown'
    var dropdowns = document.querySelectorAll('.readonly-dropdown');
    
    dropdowns.forEach(function(selectElement) {
        // Check if the dropdown needs to be readonly (modify this condition as per your logic)
        var isReadonly = "<%= dakData.getDakCreateId() %>" !== "null"; // Modify for different dropdowns if needed

        if (isReadonly) {
            selectElement.style.pointerEvents = "none"; // Prevent selection change
            selectElement.style.backgroundColor = "#e9ecef"; // Make it look disabled
            selectElement.onfocus = function() { this.blur(); }; // Prevent focus
        }
    });
};

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
</script>  
<script type="text/javascript">
$('#docdate').daterangepicker({
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
$('#refdate').daterangepicker({
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

$('#duedate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" : $('#editDueDate').val(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#Receiptdate').daterangepicker({
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
function changeProject(){
	var hiddenElement = document.getElementById("projectDirectorSelected");

	if($('#RelaventId').val()=='N'){
		$('#proname1').html('Project Type');
		$('#prodiv').prop('hidden',true);
	    $('#ProId').prop('disabled',true); 
		$('#prodiv1').prop('hidden',false);
		$('#prodiv2').prop('hidden',true);
		$('#ProId1').prop('disabled',false);
		hiddenElement.style.display = "none";
	}else if($('#RelaventId').val()=='P'){
		$('#proname').html('Project Type');
		$('#prodiv1').prop('hidden',true);
		$('#prodiv').prop('hidden',false);
		$('#prodiv2').prop('hidden',true);
		$('#ProId1').prop('disabled',true);
		$('#ProId1').selectpicker('refresh');
		$('#ProId').prop('disabled',false);
		$('#ProId').selectpicker('refresh');
	    hiddenElement.style.display = "block";
	    projectDirectorAutoSelect();//call function projectDirectorAutoSelect onchange of project type to get First projects PrjDirector
	}else if($('#RelaventId').val()=='O'){
		$('#proname2').html('Project Type');
		$('#prodiv1').prop('hidden',true);
		$('#prodiv').prop('hidden',true);
		$('#ProId').prop('disabled',true); 
		$('#prodiv2').prop('hidden',false);
		$('#ProId1').prop('disabled',true);
		hiddenElement.style.display = "none";
	}
}
</script>

<script>
//call function projectDirectorAutoSelect onchange of projects to get PrjDirector

function projectDirectorAutoSelect() {
	
	
    var ProjectIdSel = document.getElementById("ProId").value;

    $('#projectDirEmpIdVal').empty();
    $('#projectDirEmpName').empty();
    
    $.ajax({
        type: "GET",
        url: "getProjectDetails.htm",
        data: {
            projectId: ProjectIdSel
        },
        datatype: 'json',
        success: function (result) {
            if (result != null && result != "") {
                var resultData = JSON.parse(result);

                if (resultData.length > 0) {
                    var data = resultData[0]; // Assuming you only get one row
                    $('#projectDirEmpIdVal').val(data[0]);
                    $('#projectDirEmpName').val(data[1]);
                    // Check if ProjectDirectorEmpId is not null
                   
                }
            }
        }
    });
} 

// so i will  use ProjectDirectorEmpId if its not null




</script>


<script>
var sourceid="<%=dakData.getSourceId()%>";
var value="<%=dakData.getDakId()%>";
/* $( document ).ready(function() {

	if($('#RelaventId').val()==='N'){
		$('#proname1').html('Non-Project');
		$('#prodiv').prop('hidden',true);
		$('#ProId').prop('disabled',true);
		$('#prodiv1').prop('hidden',false);
		$('#prodiv2').prop('hidden',true);
		$('#ProId1').prop('disabled',false);
	}else if($('#RelaventId').val()==='P'){
		$('#proname').html('Project');
		$('#prodiv1').prop('hidden',true);
		$('#ProId').prop('disabled',false);
		$('#prodiv').prop('hidden',false);
		$('#prodiv2').prop('hidden',true);
		$('#ProId1').prop('disabled',true);
	}else if($('#RelaventId').val()==='O'){
		$('#proname2').html('Project');
		$('#prodiv1').prop('hidden',true);
		$('#prodiv').prop('hidden',true);
		$('#ProId').prop('disabled',true);
		$('#prodiv2').prop('hidden',false);
		$('#ProId1').prop('disabled',true);
	}	

    $.ajax({
			
			type : "GET",
			url : "getSelectDakEditList.htm",
			data : {
				
				dakId: value
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals1= Object.keys(result).map(function(e){
		return result[e]
		})

			for(var c=0;c<consultVals1.length;c++)
	 			{
	 				
	 				if(consultVals1[c][1]=='P'  &&  $('#RelaventId').val()=='P'){
	 					
	 					$('#ProId option[value="'+consultVals1[c][0]+'"]').prop('selected', true);
	 					
	 				}else if(consultVals1[c][1]=='P'  &&  $('#RelaventId').val()=='N'){
	 					
	 					$('#ProId1 option[value="'+consultVals1[c][0]+'"]').prop('selected', true);
	 					
	 				}
	 				
	 				else if(consultVals1[c][1]=='E'){
	 					
	 					$('#CwId option[value="'+consultVals1[c][0]+'"]').prop('selected', true);
	 					
	 				}
	 			}
	 	        $('.selectpicker').selectpicker('refresh');	
	
			
			}
		});

    
}); */
</script>

<script>
$(document).ready(function(){
	 var num=<%=counts%>;
	 var letterno=<%=letterno%>;
	 if(num!=null){
		 uploadDoc(num,letterno,'M')
	 }
})


document.addEventListener("DOMContentLoaded", function() {
    const fieldValue = "<%= dakData.getDakCreateId() != null ? dakData.getDakCreateId() : "" %>"; 
    if(fieldValue!= null && fieldValue != "") {
    setTimeout(() => {
        let element = document.querySelector('[data-id="RelaventId"]');
        let element1 = document.querySelector('[data-id="ProId"]');
        let element2 = document.querySelector('[data-id="ProId1"]');
        let element3 = document.querySelector('[data-id="ProId2"]');
        let element4 = document.querySelector('[data-id="ClosingAuthority"]');
        if (element) {
            element.style.backgroundColor = "lightblue";
            element1.style.backgroundColor = "lightblue";
            element2.style.backgroundColor = "lightblue";
            element3.style.backgroundColor = "lightblue";
            element4.style.backgroundColor = "lightblue";
        } else {
        }
    }, 100); 
    }
});


function submitattach1(){
	// Check if the file input is empty
    var fileInput = document.getElementById("dakdocument");
    if (!fileInput.files || fileInput.files.length === 0) {
        alert("Please attach a document to submit.");
        return false; // Prevent form submission
    }

    var res = confirm('Your Replacing the old Document! Are You Sure To Submit?');
    if (res) {
        // Programmatically trigger the form submission
        $('#attachform1')[0].submit();
    } else {
        event.preventDefault();
    }
	}
	
	
function submitattach2(){
	  var fileInput = document.getElementById("dakdocument2");
	    if (!fileInput.files || fileInput.files.length === 0) {
	        alert("Please attach a document to submit.");
	        return false; // Prevent form submission
	    }

	    var res = confirm('Are You Sure To Submit?');
	    if (res) {
	        // Programmatically trigger the form submission
	        $('#attachform2')[0].submit();
	    } else {
	        event.preventDefault();
	    }
	
	}
	
	function uploadDoc(value,letterno,type){
		
		
		$('#tab-1').prop('checked',true);
		
		$('#dakidvalue').val(value);
		$('#letterno').val(letterno);
		$('#dakidvalue2').val(value);
		$('#letterno2').val(letterno);
		$('#dakattachmentid').val(value);
		$('#dakattachmentid1').val(value);
		$('#type').val(type);
		$('#type2').val(type);
		$('#exampleModalCenter').modal('toggle');
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
			otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >';
			otherHTMLStr +=	'		<button type="submit" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" formaction="DownloadAttach.htm" data-toggle="tooltip" data-placement="top" title="Download" ><img alt="attach" src="view/images/download1.png"></button>'; 
/* 				otherHTMLStr +=	'		<button type="submit" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" formaction="DownloadAttach.htm" data-toggle="tooltip" data-placement="top" title="Preview" ><img alt="attach" src="view/images/eye.png"></button>'; 
*/				 /* otherHTMLStr +=	'		<button type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'"  data-toggle="tooltip" data-placement="top" title="Delete"  onclick="deleteForm('+other[2]+')" ><img alt="attach" src="view/images/delete.png"></button>';   */
			otherHTMLStr +=	'</td></tr> ';
			
			var DakAttachmentId=other[2];
			document.getElementById('dakattachmentid').value= DakAttachmentId;
		}
		
		if(consultVals.length>0){
			$('.downloadtable').css('display','block');
		}
		if(type=='M'){
			$('#other-list-table').html('');
		$('#other-list-table').html(otherHTMLStr);
		}else{
			$('#other-list-table2').html(otherHTMLStr);
		}
		$('[data-toggle="tooltip"]').tooltip()
			}
		});
	}
	
	
	function tabChange(type){
		var dakCreateId='<%=dakData.getDakCreateId()%>';
		var value;
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
		 if (result !== null && result !== '' && result !=='null') {
		var result = JSON.parse(result);
		var consultVals= Object.keys(result).map(function(e){
		return result[e]
		})
		console.log("hghfg g hgh"+consultVals);
		var otherHTMLStr = '';
		for(var c=0;c<consultVals.length;c++)
		{
			var other = consultVals[c];
		
			otherHTMLStr +=	'<tr> ';
			otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >'+ (c+1) +'.</span> </td> ';
			otherHTMLStr +=	'	<td  style="text-align: left;" ><span class="sno" id="sno" >'+ other[3] +'.</span> </td> ';
			otherHTMLStr +=	'	<td  style="text-align: center;" ><span class="sno" id="sno" >';
			otherHTMLStr +=	'		<button style="align:center; width:60%;" type="submit" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" formaction="DownloadAttach.htm" data-toggle="tooltip" data-placement="top" title="Download" ><img alt="attach" src="view/images/download1.png"></button>'; 
/* 				otherHTMLStr +=	'		<button type="submit" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'" formaction="DownloadAttach.htm" data-toggle="tooltip" data-placement="top" title="Preview" ><img alt="attach" src="view/images/eye.png"></button>'; 
*/
			if(type='S' && dakCreateId==null){
            otherHTMLStr +=	'<button style="width:60%;" type="button" class="btn btn-sm icon-btn " name="downloadbtn" value="'+other[2]+'"  data-toggle="tooltip" data-placement="top" title="Delete"  onclick="deleteForm('+other[2]+')" ><img alt="attach" src="view/images/delete.png"></button>'; 
			}
			otherHTMLStr +=	'</td></tr> ';

			var DakAttachmentId=other[2];
			document.getElementById('dakattachmentid1').value= DakAttachmentId;
			
		}
		
		if(consultVals.length>0){
			$('.downloadtable').css('display','block');
		}
		if(type=='M'){
		$('#other-list-table').html('');
		$('#other-list-table').html(otherHTMLStr);
		}else{
			$('#other-list-table2').html('');
			$('#other-list-table2').html(otherHTMLStr);
		}
		$('[data-toggle="tooltip"]').tooltip()
			
			
		}
		 
		}
	});

	}
	
	 function deleteForm(value){
		 $('#dakattachmentid2').val(value);
		 
		 var result = confirm ("Are You sure to Delete ?"); 
		 if(result){
			 $('#deleteform').submit();
		 }
		 
	 }
</script>

<script>
$(document).ready(function(){
	 var select= document.getElementById("Action").value.trim();
	    var splitValues = select.split("#"); 
	    console.log(splitValues);
	    if(splitValues[1]=='ACTION'){
	    	$('.ActionDueDate').show();
	    	$('.ActionTime').show();
	    }else{
	    	$('.ActionDueDate').hide();
	    	$('.ActionTime').hide();
	    }});
function changeFunc() {
    var select= document.getElementById("Action").value.trim();
    var splitValues = select.split("#"); 
    console.log(splitValues);
    if(splitValues[1]=='ACTION'){
    	$('.ActionDueDate').show();
    	$('.ActionTime').show();
    }else{
    	$('.ActionDueDate').hide();
    	$('.ActionTime').hide();
    }};
</script>
<script type="text/javascript">
$(function() {
	   $('#DueTime').daterangepicker({
	            timePicker : true,
	            singleDatePicker:true,
	            timePicker24Hour : true,
	            timePickerIncrement : 1,
	            timePickerSeconds : false,
	            locale : {
	                format : 'HH:mm'
	            }
	        }).on('show.daterangepicker', function(ev, picker) {
	            picker.container.find(".calendar-table").hide();
	   });
	})
</script>
<script>

var PrevSelAllEmps=[]; ///empty array to store all previously selected(marked) employees
var PrevSelGMEmps=[];//empty array to store only previously selected group marking employees
var PrevSelGMEmpsInactive = []; //empty array to store only previously selected group marking employees but later deleted
var PrevSelIMEmps=[];//empty array to store only previously selected individual marking employees

$(document).ready(function(){	
	AllEmpsAlreadyMarked(<%=DakIdSelFrEdit%>);
    PrevInactiveGMMarkedEmpIds(<%=DakIdSelFrEdit%>);
	PrevGMMarkedEmpIds(<%=DakIdSelFrEdit%>);
});	


//////////////////////////////////////////////////////////GROUP MARKING ONCHANGE JAVASCRIPT/////////////////////////////////////
$(document).ready(function(){	
	$("#Groupname").trigger("change");
});
$("#Groupname").change(function(){//if it is changed or onload triggered change(by above function)
	
	   var selGroupdIds = [];
	  $("select[name='groupname[]'] option:selected").each(function() { 
		  selGroupdIds.push($(this).val()); // by using selGroupdIds[] the current selected and prev sel empids will be fetched using getDakmemberGroupEmpList.htm
	  });
	  $('#GroupEmp').empty();
	  
	  if (selGroupdIds.length === 0) {
	        // Clear data and perform necessary actions when no options are selected
	        $('#GroupEmp').empty();
	        $('#EmpIdGroup').val('');
	        return; // Exit the function
	    }
	
   $.ajax({
	   type : "GET",
	   url : "getDakmemberGroupEmpList.htm",
	   datatype : 'json',
	   data : {
			 Group: selGroupdIds
		},
	   success : function(result) {
		   if (result !== null && result !== '' && result !=='null') {
		   
			  var result = JSON.parse(result);
			  
	
			  var consultVals= Object.keys(result).map(function(e){
			  return result[e];
			   });
			  
			   var prevSelAllEmpIds = []; 
			   prevSelAllEmpIds = PrevSelAllEmps;
			   ///all previous selected empids in group and individual marking(checkout ajax getDistributedDakMeberslist.htm)
			   
			
			   var prevInactiveGMEmpIds = []; 
               prevInactiveGMEmpIds = PrevSelGMEmpsInactive;//previously selected EmpIds of group marking but deleted later
         
		
			   var otherHTMLStr = '';
			   var id='Employees';
			   var count=1;
			   var EmpId=[];
			   
			   for (var c = 0; c < consultVals.length; c++) {
				 
				   if( (!prevInactiveGMEmpIds.includes(consultVals[c][0]))){//making sure only active GMEmpIds shows not all empids of the groupid 
				       var Temp = id + (c+1);
			           otherHTMLStr += '<span style="margin-left:2%" id="name_'+ Temp +'">'+count+'. '+' '+consultVals[c][1]+' , '+' '+ ' '+consultVals[c][2]+'</span><br>';
			           count++;
			       }
			    
				   
				   //The above code i.e otherHTMLStr is for display and below code EmpId.push(str); is for controller inserted empids
			        
			       if ( (!prevSelAllEmpIds.includes(consultVals[c][0])) &&  (!prevInactiveGMEmpIds.includes(consultVals[c][0])) ) {  //means if current marked Empid and previously marked empids are same than dont push for insertion//consultVals[c][0] is a empids got by passing groupids which is both present and previously selected by user
		        	       var str=consultVals[c][0]+'/'+consultVals[c][3];
			               EmpId.push(str); //Not sending to parameter EmpIdGroup if currently selected emps includes
				  
				   }
			   }//for loop close
			
			   var id= $('#EmpIdGroup').val(EmpId);//this is where selected Group datas will be pushed to textbox
			   $('#GroupEmp').html(otherHTMLStr);
			
			}
	   }//success close
	   
   });//ajax close
});//change funcion close
</script>


<script type="text/javascript">
//////////////////////////////////////////////////////////INDIVIDUAL MARKING ONCHANGE JAVASCRIPT/////////////////////////////////////


$(document).ready(function() {
	$("#individual").trigger("change");

   
});


$("#individual").change(function(){//if it is changed or onload triggered change(checkout above function)
	  var value = [];
	  $("select[name='individual[]'] option:selected").each(function() { // Fix the selector here
		  value.push($(this).val());
	   });
	  
   
	   $.ajax({
             type: "GET",
             url: "getSelectEmpList.htm",
             data: {
                 empId: value
             },
             datatype: 'json',
            success: function(result) {
            	
            	
                   var result = JSON.parse(result);
                   var consultVals = Object.keys(result).map(function(e) {
                   return result[e];
                   });
                   
                   var selectedEmployees = [];
                   selectedEmployees = PrevSelAllEmps;
         	      $("#empidSelect option:selected").each(function () {
         	        selectedEmployees.push($(this).val().split(",")[0]);//currently selected employees will be pushed by this code
         	       
         	      });
                 
                   $('#empidSelect').empty();
                   
                   for (var c = 0; c < consultVals.length; c++) {
        	           var optionValue = consultVals[c][0] + '/' + consultVals[c][3];
                       var optionText = consultVals[c][1] + ', ' + consultVals[c][2];
                       var option = $("<option></option>").attr("value", optionValue).text(optionText);
        
                        if (selectedEmployees.includes(consultVals[c][0])) { //if selected Employees and priviously inserted employees are same then dont push those
    	                 
                    	    option.prop('selected', true);
    	                    option.prop('disabled', true);
    	                }
                        
                  <%--  <%for(Object[] type : DakMarkingData){ %>
                       var id = <%=type[1]%>
  	                  if(consultVals[c][0] == id){
  	                	   option.prop("selected", true);
  	                	
                        }
  		          <%}%>   --%>
		           $('#empidSelect').append(option);
            
               }//consultValsForLoop closed
        
        addEmpToSelect();
        $('.selectpicker').selectpicker('refresh');
      },
      error: function() {
        // Handle the error response here
      }
    
	   });//ajax close
  });//change function close
  

</script>
<script>
function AllEmpsAlreadyMarked(DakId){  //Is Active is checked
	 var data=DakId;
	 $.ajax({
		  type: "GET",
		  url: "getDistributedDakMeberslist.htm",
		  data : {
				 DakId: data
			},
			 datatype : 'json',
			success: function(result) {
				if (result != null) {
				      result = JSON.parse(result);
				      var Data = Object.keys(result).map(function(e) {
				        return result[e];
				      });
				      
				      for (var c = 0; c < Data.length; c++) {
							PrevSelAllEmps.push(Data[c][1]);
						}      
				      
				      console.log('allEmps',PrevSelAllEmps);
			}
        }//success close
		});
}

function PrevInactiveGMMarkedEmpIds(DakId){//Is Active is checked
	 var DAKID=DakId;
	 $.ajax({
		  type: "GET",
		  url: "getMarkedInactiveGroupMembersEmps.htm",
		  data : {
			  dakId: DAKID
			},
			 datatype : 'json',
			success: function(result) {
				console.log(result);
				console.log(result);
				if (result != null) {
					
					   
					   result = JSON.parse(result);
					      var Data = Object.keys(result).map(function(e) {
					        return result[e];
					      });
	                   
					      for (var c = 0; c < Data.length; c++) {
	                	   PrevSelGMEmpsInactive.push(Data[c][2]);
						}    
					      console.log('InactiveEmps',PrevSelGMEmpsInactive);
				}
				
			}//success close
	 });
}


function PrevGMMarkedEmpIds(DakId){//Is Active is checked
	 var DAKID=DakId;
	 $.ajax({
		  type: "GET",
		  url: "getMarkedGroupMembersEmps.htm",
		  data : {
			  dakId: DAKID
			},
			 datatype : 'json',
			success: function(result) {
				console.log(result);
				console.log(result);
				if (result != null) {
					
					   var result = JSON.parse(result);
					   
	                   var consultVals = Object.keys(result).map(function(e) {
	                   return result[e];
	                   });
	                   
	                   for (var c = 0; c < consultVals.length; c++) {
				        	PrevSelGMEmps.push(consultVals[c][3]);
						}    
					
				}
				
			}//success close
	 });
}





</script>
<script>
////////////////////////////////////////ONCHANGE OF INDIVIDUAL MARKING TRIGGERED FUNCTION///////////////////////////

function addEmpToSelect(){
         var options = $('#empidSelect option:selected');
         var selected = [];
         var otherHTML = '';
	     var id='empsSelectedIndividual';
	     var count=1;
    
	     $(options).each(function(){
	        otherHTML += '<span style="margin-left:2%" id="id">'+count+'.  '+' '+$(this).text()+'</span><br>';
	        count++;
	       selected.push($(this).val());
        });
        $('#EmpIdIndividual').val(selected);
        $('#IndEmp').html(otherHTML);
}
</script>
<script>
$(document).ready(function(){	
	
	$("#sourceid").trigger("change");
	$("#pass").hide();
	$("#fail").hide();
	$("#passNonProject").hide();
	$("#failNonProject").hide();
	$("#passOtherProject").hide();
	$("#failOtherProject").hide();
	
});
$("#sourceid").change(function(){
	var SourceId=$("#sourceid").val();
	var SourcetypeId=$("#SourcetypeId").val();
   $.ajax({
			
			type : "GET",
			url : "getSelectSourceTypeList.htm",
			data : {
				
				SourceId: SourceId
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
          $('#SourceType').empty();
			
			for(var c=0;c<consultVals.length;c++)
			{
				 $('#SourceType')
		         var option = $("<option></option>") 
		                    .attr("value", consultVals[c][0])
		                    .text(consultVals[c][3]+'- '+consultVals[c][2]); 
				 if(consultVals[c][0] == SourcetypeId){
					 option.prop("selected", true);
			          }
				 $('#SourceType').append(option);
			}
			var addnew = "addnew";
		    var $newOption = $("<option></option>")
			  .attr("value", addnew)
			  .text("Add New")
			  .css({
			    "background-color": "blue",
			    "color": "white",
			    // Add more styles as needed
			  });

			$('#SourceType').append($newOption);
			 $('#SourceType').selectpicker('refresh');
			}
});
});
</script>
<script>
$(document).ready(function(){	
	$("#RelaventId").trigger("change");
});
$("#RelaventId").change(function(){
	var ProjectId=$("#getProjectId").val();
	var projecttype=$('#getProjecttype').val();
	console.log('ProjectType:'+projecttype);
   $.ajax({
			
			type : "GET",
			url : "getSelectNonProjectList.htm",
			data : {
				
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
          $('#ProId1').empty(); //Non Project
			
			for(var c=0;c<consultVals.length;c++)
			{
				
                var option = $("<option></option>").attr("value", consultVals[c][0]).text(consultVals[c][1]);
				 if(projecttype==='N' && consultVals[c][0]==ProjectId){
					 option.prop("selected", true);
			          }
				 $('#ProId1').append(option);
			}
			
			var addnew = "addnonproject";
			var $newOption = $("<option></option>")
			  .attr("value", addnew)
			  .text("Add New")
			  .css({
			    "background-color": "blue",
			    "color": "white",
			    // Add more styles as needed
			  });

			$('#ProId1').append($newOption);
			
			 $('#ProId1').selectpicker('refresh');
			}
});
});
</script>

<script>
$(document).ready(function(){	
	$("#RelaventId").trigger("change");
});
$("#RelaventId").change(function(){
	var ProjectId=$('#getProjectId').val();
	var projecttype=$('#getProjecttype').val();
	console.log('ProjectType:'+projecttype);
   $.ajax({
			
			type : "GET",
			url : "getSelectOtehrProjectList.htm",
			data : {
				
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
          $('#ProId2').empty();
			
			for(var c=0;c<consultVals.length;c++)
			{
				$('#ProId2')
		         var option = $("<option></option>") 
		                    .attr("value", consultVals[c][0])
		                    .text(consultVals[c][1]); 
				 if(projecttype==='O' && consultVals[c][0]==ProjectId){
					 console.log('others#####');
					 option.prop("selected", true);
			}
				 $('#ProId2').append(option);
			}
			var addnew = "addotherproject";
			var $newOption = $("<option></option>")
			  .attr("value", addnew)
			  .text("Add New")
			  .css({
			    "background-color": "blue",
			    "color": "white",
			    // Add more styles as needed
			  });

			$('#ProId2').append($newOption);
			
			 $('#ProId2').selectpicker('refresh');
			}
});
});
</script>
<script type="text/javascript">

$('#SourceType').change(function(){
	var SourceType=document.getElementById("SourceType").value;
	  if(SourceType=='addnew'){ 
	  $('#modalsource').modal('show');
}
	  else{
		  $('#modalsource').modal('hide');
	  }
	});  
$('#ProId1').change(function(){
	var ProId1=document.getElementById("ProId1").value;
	  if(ProId1=='addnonproject'){ 
	  $('#modalNonProject').modal('show');
	  $("#ProId1").prop("selectedIndex", 0);
	  }
	  else{
		  $('#modalNonProject').modal('hide');
	  }
	});  
$('#ProId2').change(function(){
	var ProId2=document.getElementById("ProId2").value;
	  if(ProId2=='addotherproject'){ 
	  $('#modalotherproject').modal('show');
	  $("#ProId2").prop("selectedIndex", 0);
}
	  else{
		  $('#modalotherproject').modal('hide');
	  }
	});  



		function addsource()
		{
		  var SourceType= $("#sourceid").val();
		  var ShortName=$("#ShortName").val();
		  var SourceName=$("#SourceName").val();
		  if(SourceType==null || SourceType=='' || typeof(SourceType)=='undefined' || SourceType=="Select Source Type")
		  {
			  alert("Select Source Type..!");
			  $("#SourceType").focus();
			  return false;
		  }
		  else if(ShortName==null || ShortName==='' || ShortName==="" || typeof(ShortName)=='undefined')
		  {
			  alert("Enter Source Short Name..!");
			  $("#ShortName").focus();
			  return false;
		  }
		  else if(SourceName==null || SourceName==='' || SourceName==="" || typeof(SourceName)=='undefined')
		  {
			  alert("Enter Source Name..!");
			  $("#SourceName").focus();
			  return false;
		  }
		  else
			  {
 				var x=confirm("Are You Sure To Add ?");
			  
			  if(x)
				  {
				  $.ajax({
					  type : "GET",
						url : "dakSourceAddSubmit.htm",
						data : {
							
							SourceType: SourceType,
							ShortName:ShortName,
							SourceName:SourceName,
							
						},
						datatype : 'json',
						success : function(result) {
						var result = JSON.parse(result);
						if(result==1){
							$('#modalsource').modal('hide');
							$("#sourceid").trigger("change");
							$("#pass").addClass("alert alert-success");
							 $("#pass").show();
							 setTimeout(function() {
							        $("#pass").hide();
							      }, 2000);
							 $("#ShortName").val("");
							 $("#SourceName").val(""); 
						}else{
							$('#modalsource').modal('hide');
							$("#sourceid").trigger("change");
							$("#fail").addClass("alert alert-danger");
							 $("#fail").show();
							 setTimeout(function() {
							        $("#fail").hide();
							      }, 2000);
							 $("#ShortName").val("");
							 $("#SourceName").val("");
						}
						}
					});
				  }
			  else
				  {
				  return false;
				  }
			
			  }
		}

		 
		 function addNonProject()
			{
			  var ShortName=$("#NonShortName").val();
			  var NonProjectName=$("#NonProjectName").val();
			 
			  if(ShortName==null || ShortName==='' || ShortName==="" || typeof(ShortName)=='undefined')
			  {
				  alert("Enter Non-Project Short Name..!");
				  $("#NonShortName").focus();
				  return false;
			  }
			  else if(NonProjectName==null || NonProjectName==='' || NonProjectName==="" || typeof(NonProjectName)=='undefined')
			  {
				  alert("Enter Non-Project Name..!");
				  $("#NonProjectName").focus();
				  return false;
			  }
			  else
				  {
				  var x=confirm("Are You Sure To Add ?");
				  if(x)
				  {
				  $.ajax({
					  type : "GET",
						url : "dakNonProjectAddSubmit.htm",
						data : {
							
							ShortName: ShortName,
							NonProjectName:NonProjectName
						},
						datatype : 'json',
						success : function(result) {
						var result = JSON.parse(result);
						if(result==1){
							$('#modalNonProject').modal('hide');
							$("#RelaventId").trigger("change");
							$("#passNonProject").addClass("alert alert-success");
							 $("#passNonProject").show();
							 setTimeout(function() {
							        $("#passNonProject").hide();
							      }, 2000);
							 $("#NonShortName").val("");
							 $("#NonProjectName").val(""); 
						}else{
							$('#modalNonProject').modal('hide');
							$("#RelaventId").trigger("change");
							$("#failNonProject").addClass("alert alert-danger");
							 $("#failNonProject").show();
							 setTimeout(function() {
							        $("#failNonProject").hide();
							      }, 2000);
							 $("#NonShortName").val("");	
							 $("#NonProjectName").val("");
						}
						}
					});
				  }
			  else
				  {
				  return false;
				  }
				  }
			}

		 
		 
		 function addOtherProject()
			{
			  var ShortName=$("#OtherShortName").val();   
			  var OtherProjectName=$("#OtherProjectName").val();   
			  var ProjectCode=$("#ProjectCode").val();
			  var LabCode=$("#LabCode").val();
			  
			 if(LabCode==null || LabCode==='' || LabCode==="" || typeof(LabCode)=='undefined')
			  {
				  alert("EnterLab Code..!");
				  $("#LabCode").focus();
				  return false;
			  }
			 else if(ProjectCode==null || ProjectCode==='' || ProjectCode==="" || typeof(ProjectCode)=='undefined')
			  {
				  alert("Enter Project Code..!");
				  $("#ProjectCode").focus();
				  return false;
			  }
			  else if(ShortName==null || ShortName==='' || ShortName==="" || typeof(ShortName)=='undefined')
			  {
				  alert("Enter Other Project Short Name..!");
				  $("#OtherShortName").focus();
				  return false;
			  }
			  else if(OtherProjectName==null || OtherProjectName==='' || OtherProjectName==="" || typeof(OtherProjectName)=='undefined')
			  {
				  alert("Enter Other-Project Name..!");
				  $("#OtherProjectName").focus();
				  return false;
			  }
			  else
			  {
				  var x=confirm("Are You Sure To Add ?");
				  if(x)
				  {
				  $.ajax({
					  type : "GET",
						url : "dakOtherProjectAddSubmit.htm",
						data : {
							
							ShortName: ShortName,
							OtherProjectName:OtherProjectName,
							ProjectCode:ProjectCode,
							LabCode:LabCode
							
						},
						datatype : 'json',
						success : function(result) {
						var result = JSON.parse(result);
						if(result==1){
							$('#modalotherproject').modal('hide');
							$("#RelaventId").trigger("change");
							$("#passOtherProject").addClass("alert alert-success");
							 $("#passOtherProject").show();
							 setTimeout(function() {
							        $("#passOtherProject").hide();
							      }, 2000);
							 $("#OtherShortName").val("");
							 $("#OtherProjectName").val("");
							 $("#ProjectCode").val("");
							 $("#LabCode").val("");
						}else{
							$('#modalotherproject').modal('hide');
							$("#RelaventId").trigger("change");
							$("#failOtherProject").addClass("alert alert-danger");
							 $("#failOtherProject").show();
							 setTimeout(function() {
							        $("#failOtherProject").hide();
							      }, 2000);
							 $("#OtherShortName").val("");	
							 $("#OtherProjectName").val("");
							 $("#ProjectCode").val("");
							 $("#LabCode").val("");
						}
						}
					});
				  }
			  else
				  {
				  return false;
				  }
				  }
			}

		 
</script>
</body>
</html>