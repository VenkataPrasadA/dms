<%@page import="java.time.LocalDate"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<spring:url value="/webresources/css/ProjectGraph.css" var="ProjectGraphonecss" />
<link href="${ProjectGraphonecss}" rel="stylesheet" /> 

<spring:url value="/webresources/css/ProjectGrapchtwo.css" var="ProjectGraphTwocss" />
<link href="${ProjectGraphTwocss}" rel="stylesheet" /> 

<spring:url value="/webresources/js/chart.js" var="jquerymomentjs" />
<script src="${jquerymomentjs}"></script>

<spring:url value="/webresources/js/ProjectGraph.js" var="ProjectGraphjs" />
<script src="${ProjectGraphjs}"></script>

<title>DMS</title>
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">
body {
 background:white; !important;
}

#pleasewait {
  background: rgba(0, 0, 0, 0.6); /* Semi-transparent background overlay */
}
/*

*/
.shadow {
  box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15) !important;
}

.border-left-primary {
  border-left: 0.25rem solid #4e73df !important;
}

.border-left-success {
  border-left: 0.25rem solid #1cc88a !important;
}
labeled
.h-100 {
  height: 100% !important;
}

.text-gray-300 {
  color: #dddfeb !important;
}

.border-left-info {
  border-left: 0.25rem solid #36b9cc !important;
}

.border-left-warning {
  border-left: 0.25rem solid #f6c23e !important;
}

 
 @media (max-width: 600px) {
	    .highcharts-figure,
	    .highcharts-data-table table {
	        width: 100%;
	    }
	
	}
 
#container, #container3, #container4, #container-speed {
    height: 300px;
    min-width: 310px;
    max-width: 800px;
    
    }
#ProjectGraph{
 width: 100%;
  height: 50vh;
  margin: 0;
  padding: 0;
    }
      .charts {
            display: flex;
            justify-content: space-between;
        }

        .chart {
            width: 500px;
            height: 200px;
            border: 1px solid #ccc;
            display: flex;
            flex-direction: row;
            justify-content: flex-start; /* Change this line to flex-end */
            margin: 20px 10px;
        }

        .bar {
            width: 30px;
            margin: 0 35px 20px 20px;
        }

        .label {
            text-align: center;
        }

        .labeleddata {
            margin: 0 auto;
            width: 700px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        label {
            /*    position: relative;
               padding-left: 20px; */
            /* Add some space to the left of the label for the indicator */
        }

        label::before {
            content: '';
            display: inline-block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin-right: 5px;
            /* Add some space between the indicator and the label text */
        }

        /* Define the colors for each indicator */
        .initiated::before {
            background-color: rgb(0, 123, 255);
        }

        .distributed::before {
            background-color: rgb(100, 181, 246);
        }

        .replied::before {
            background-color: rgb(25, 118, 210);
        }

        .pnc-do::before {
            background-color: rgb(239, 108, 0);
        }

        .approved::before {
            background-color: rgb(255, 213, 79);
        }

        .closed::before {
            background-color: rgb(69, 90, 100);
        }	
        .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn){
        width: 300px !important;
        }
     .custom-select {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  width: 200px;
  padding: 0px !important;
  
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
   
   .btn1{
	border-top-left-radius: 5px !important;
	border-bottom-left-radius: 5px !important;
}

.btn2{
	
    border-left: 1px solid black;
}

.btn3{
	border-left: 1px solid black;
}     
.anychart-credits-logo{
display: none !important;
}
.anychart-credits-text {
display: none;
}

.spinner {
    position: fixed;
    top: 40%;
    left: 32%;
    margin-left: -50px; /* half width of the spinner gif */
    margin-top: -50px; /* half height of the spinner gif */
    text-align:center;
    z-index:1234;
    overflow: auto;
    width: 1000px; /* width of the spinner gif */
    height: 1020px; /*hight of the spinner gif +2px to fix IE8 issue */
    background: transparent;
}

.order-card {
    color: #fff;
}

.bg-c-blue {
    background: linear-gradient(45deg,#4099ff,#73b4ff);
}

.bg-c-green {
    background: linear-gradient(45deg, #ff8c00, #ffcc00);;
}

.bg-c-yellow {
    background: linear-gradient(45deg, #A389F4, #C4B5FD);
}

.bg-c-pink {
    background:linear-gradient(45deg,#2ed8b6,#59e0c5);
}

.bg-c-purple{
    background: lightgreen;
}

.bg-c-red{
background: linear-gradient(45deg, #1f9964, #187d52);
}

.bg-c-lime {
    background: linear-gradient(45deg, #8bc34a,#cddc39);
}

.bg-c-cyan {
   background: linear-gradient(45deg, #87ede0, #a8f4e9);
}

.card {
    border-radius: 5px;
    -webkit-box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
    box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
    border: none;
    margin-bottom: 30px;
    -webkit-transition: all 0.3s ease-in-out;
    transition: all 0.3s ease-in-out;
}

.card .card-block {
    padding: 25px;
}

.order-card i {
    font-size: 26px;
}

.f-left {
    float: left;
}

.f-right {
    float: right;
}
.container {
max-width: 1650px!important;
}

.counter-box {
	display: block;
	background: #f6f6f6;
	padding: 40px 20px 37px;
	text-align: center
}

.counter-box p {
	margin: 5px 0 0;
	padding: 0;
	color: #909090;
	font-size: 18px;
	font-weight: 500
}

.counter-box i {
	font-size: 60px;
	margin: 0 0 15px;
	color: #d2d2d2
}

.counter { 
	display: block;
	font-size: 32px;
	font-weight: 700;
	color: #666;
	line-height: 28px
}

.counter-box.colored {
      background: rgb(2, 136, 209);
}

.counter-box.colored p,
.counter-box.colored i,
.counter-box.colored .counter {
	color: #fff
}

.modalcontainer {
      position: fixed;
      bottom: 45%;
      right: 20px;
      width: 400px;
      max-width: 80%;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      z-index: 1000;
      font-family: Arial, sans-serif;
     display: none;
    }
 .modal-container {
      position: fixed;
      bottom: 20px;
      right: 20px;
      width: 350px;
      max-width: 80%;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      display: none;
      z-index: 1000;
      font-family: Arial, sans-serif;
     
    }
 .modalheader {
    display: flex;
    align-items: center;
    justify-content: end;
    padding:8px;
      background-color: #FFC436;
      color: #fff;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
    }
.modalcontent {
    
      padding: 10px 10px 10px 10px;
    }
.modalfooter {
      padding: 10px;
      text-align: right;
      border-bottom-left-radius: 8px;
      border-bottom-right-radius: 8px;
    }
.modal-close {
      cursor: pointer;
      color: red;
    }

 /* Style for the button */
    .open-modal-button {
      position: fixed;
      bottom: 10px;
      right: 10px;
      background-color: #007bff;
      color: #fff;
      padding: 5px;
      border: none;
      border-radius: 5px;
      font-weight:bold;
      cursor: pointer;
      z-index: 1001; /* Make sure the button is above the modal */
    }
</style>

</head>
<body>
<%
List<Object[]> loginTypeList=(List<Object[]>)request.getAttribute("loginTypeList");
List<Object[]> sourceList = (List<Object[]>) request.getAttribute("SourceList");
List<Object[]> AllSourceTypeList=(List<Object[]>)request.getAttribute("AllSourceTypeList");
List<Object[]> ProjectTypeList=(List<Object[]>)request.getAttribute("ProjectTypeList");

List<Object[]> DakGroupingListDropDown=(List<Object[]>)request.getAttribute("DakGroupingListDropDown");

List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");

List<Object[]> dakDeliveryList = (List<Object[]>) request.getAttribute("DakDeliveryList");
List<Object[]> priorityList = (List<Object[]>) request.getAttribute("priorityList");
Object[] ProjectCardsCount=(Object[])request.getAttribute("ProjectCardsCount");

List<Object[]> todayschedulelist=(List<Object[]>)request.getAttribute("todayschedulelist");

ObjectMapper objectMapper = new ObjectMapper();
String jsonArray = objectMapper.writeValueAsString(todayschedulelist);

Object[] GroupCardsCount=(Object[])request.getAttribute("GroupCardsCount");

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd");
String LoginAs=(String)session.getAttribute("LoginAs");
Object[] TotalCountData = (Object[])request.getAttribute("CountData");
String frmDt=(String)request.getAttribute("frmDt");
String toDt=(String)request.getAttribute("toDt"); 


Object[] PopUpCount=(Object[])request.getAttribute("PopUpCount");

System.out.println("PopUpCount:"+PopUpCount[0].toString());
Date frominpuDate=inputDateFormat.parse(frmDt);
Date toinputDate=inputDateFormat.parse(toDt);

String FromDate=sdf.format(frominpuDate);
String  toDate=sdf.format(toinputDate);

System.out.println("FromDate:"+FromDate);
System.out.println("toDate:"+toDate);

String Date=(String)request.getAttribute("Date");
String Project=(String)request.getAttribute("Project");
String Source=(String)request.getAttribute("Source");
String SelSourceType=(String)request.getAttribute("SelSourceType");
String selProjectTypeId=(String)request.getAttribute("selProjectTypeId");

String Emp=(String)request.getAttribute("Emp");
String MemberTypeId=(String)request.getAttribute("MemberTypeId");

String redirectedvalue=(String)request.getAttribute("redirectedvalueForward");

String DeliveryTypeId=(String)request.getAttribute("DeliveryTypeId");
String PriorityId=(String)request.getAttribute("PriorityId");

int TotalMissedDak=(int)request.getAttribute("TotalMissedDak");
int MissedDistributed=(int)request.getAttribute("MissedDistributed");
int MissedReplied=(int)request.getAttribute("MissedReplied");
int MissedRepliedByPnCDo=(int)request.getAttribute("MissedRepliedByPnCDo");
int MissedApproved=(int)request.getAttribute("MissedApproved");
int MissedClosed=(int)request.getAttribute("MissedClosed");

int TotalNearDak=(int)request.getAttribute("TotalNearDak");
int NearDistributed=(int)request.getAttribute("NearDistributed");
int NearReplied=(int)request.getAttribute("NearReplied");
int NearRepliedByPnCDo=(int)request.getAttribute("NearRepliedByPnCDo");
int NearApproved=(int)request.getAttribute("NearApproved");
int NearClosed=(int)request.getAttribute("NearClosed");

String Username =(String)session.getAttribute("Username"); 
String LoginType =(String)session.getAttribute("LoginTypeDms"); 

String EmpName =(String)session.getAttribute("EmpName"); 
String EmpDesig =(String)session.getAttribute("EmpDesig"); 

	String LoginTypeCode=null;
	
if(LoginAs!=null){
	LoginTypeCode=LoginAs;
}else{
	LoginTypeCode=LoginType;
}

Map<String, List<Object[]>> multiValueMap = (Map<String, List<Object[]>>) request.getAttribute("multiValueMap");

Map<String, List<Object[]>> multiGroupValueMap = (Map<String, List<Object[]>>) request.getAttribute("multiGroupValueMap");
LocalDate currentDate = LocalDate.now();
LocalDate toDateSevenDaysAhead = currentDate.plusDays(7);
String toDateParameter = sdf.format(java.sql.Date.valueOf(toDateSevenDaysAhead));
%>

	<div class="card-header page-top">
		<div class="row" >
			<div class="col-md-9 heading-breadcrumb">
				<h5 style="font-weight: 700 !important; ">DASHBOARD</h5>
			</div>
			<div class="col-md-3 " >
			 <!-- ----------- COMMON TOGGLE BUTTONS(ACTION,PROJECT,OVERALL) STARTS --------------------------- --> 	
		   <div style="float: right;padding:5px;<%if( LoginType.equalsIgnoreCase("U")) { %>  display:none   <%}%> ">
		  	 <div class="btn-group "> 
		        <button class="btn btn1" id="OverallButton">Overall</button>
		        <button class="btn btn2" id="ProjectButton">Project</button>
		        <button class="btn btn3" id="GroupButton">Group</button>
		      </div>
		  </div>	
			</div>			
		</div>
</div>     
<%-- <iframe src="http://vts11:8051/?jsessionid=<%= session.getId() %>" width="100%" height="100%" frameborder="0"></iframe> --%>

     <%-- <div id="error-page">
         <div class="content">
            <h3 align="center" style="color: #363795;" data-text="Connecting to DashBoard">
              Coming  Soon	
            </h3>
             <div align="center" class="col-md-4"style=" margin-top: 50px; margin-left: 33%;"> 
		
		<div class="product-banner-container" align="center" style="margin-top:150px">
									<img class="img-fluid img-responsive" width="60%;" src="view/images/loading.png" style="">
								</div></div>
         </div>
      </div>--%>
      
      <div class="card dashboard-card"  > 

		 <div class="card" id="loadingCard"  >
		 <form action="MainDashBoard.htm" method="POST" id="myform"> 
		<div class="card-header" style="height: 3rem; background-color: rgb(68, 119, 206); color: white;">
     
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <%System.out.println("RedirectionValue"+redirectedvalue);%>
    <input type="hidden" id="redirectedvalue" name="redirectedvalue" value="<%if(redirectedvalue!=null){%><%=redirectedvalue %><%}%>">
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
          
          <label style="display: inline-block; margin: 0rem 0.4rem; align-items: center;">
          <input type="radio"  name="Date" value="Yesterday" <% if(Date!=null && Date.equalsIgnoreCase("Yesterday")) { %> checked="checked" <% }else{%>checked="checked"<%} %> onclick="submitForm(this.value)">
          <label style="font-weight: bold; font-size: 1rem; font-family: Arial, sans-serif; padding-right: 0.5rem;">Yesterday</label>
          </label>
          <label style="display: inline-block; margin: 0rem 0.4rem; align-items: center;">
          <input type="radio" name="Date" value="Today" <% if(Date!=null && Date.equalsIgnoreCase("Today")) { %> checked="checked" <% } %> onclick="submitForm(this.value)">
          <label style="font-weight: bold; font-size: 1rem; font-family: Arial, sans-serif; padding-right: 0.5rem;">Today</label>
          </label>
          <label style="display: inline-block; margin: 0rem 0.4rem; align-items: center;">
          <input type="radio" name="Date" value="week" <% if(Date!=null && Date.equalsIgnoreCase("week")) { %> checked="checked" <% } %> onclick="submitForm(this.value)">
          <label style="font-weight: bold; font-size: 1rem; font-family: Arial, sans-serif; padding-right: 0.5rem;">1 Week Ago</label>
          </label>
          <label style="display: inline-block; margin: 0rem 0.4rem; align-items: center;">
          <input type="radio" name="Date" value="month" <% if(Date!=null && Date.equalsIgnoreCase("month")) { %> checked="checked" <% } %> onclick="submitForm(this.value)">
          <label style="font-weight: bold; font-size: 1rem; font-family: Arial, sans-serif; padding-right: 0.5rem;">1 Month Ago</label>
          </label>
          <label style="display: inline-block; margin: 0rem 0.4rem; align-items: center;">
          <input type="radio" name="Date" value="threeMonth" <% if(Date!=null && Date.equalsIgnoreCase("threeMonth")) { %> checked="checked" <% } %> onclick="submitForm(this.value)">
          <label style="font-weight: bold; font-size: 1rem; font-family: Arial, sans-serif; padding-right: 0.5rem;">3 Months Ago</label>
          </label>
          <label style="display: inline-block; margin: 0rem 0.4rem; align-items: center;">
          <input type="radio" name="Date" value="sixMonth" <% if(Date!=null && Date.equalsIgnoreCase("sixMonth")) { %> checked="checked" <% } %> onclick="submitForm(this.value)">
          <label style="font-weight: bold; font-size: 1rem; font-family: Arial, sans-serif; padding-right: 0.5rem;">6 Months Ago</label>
          </label>
          <label style="display: inline-block; margin: 0rem 0.4rem; align-items: center;">
          <input type="radio" name="Date" value="year" <% if(Date!=null && Date.equalsIgnoreCase("year")) { %> checked="checked" <% } %> onclick="submitForm(this.value)">
          <label style="font-weight: bold; font-size: 1rem; font-family: Arial, sans-serif; padding-right: 0.5rem;">1 Year Ago</label>
          </label>
          </div>
        </div>
      </div>
      
</div>
       <div class="row Filtersfirst" style="background-color: rgb(255, 173, 188); display: none;">
       <div class="float-container">
        <div class="col-12" style="width: 100%; padding: 10px;" >
        <label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>DAK Type</b></label>
			<select class="selectpicker custom-select" id="DeliveryTypeId" required="required" data-live-search="true" name="DeliveryTypeId"  >
				<option value="All" <% if ( DeliveryTypeId!=null && "All".equalsIgnoreCase(DeliveryTypeId)) { %>selected="selected"<% } %>>All</option>
				<%if (dakDeliveryList != null && dakDeliveryList.size() > 0) {
					for (Object[] obj : dakDeliveryList) {%>
					<option value=<%=obj[0]%> <% if (DeliveryTypeId!=null && DeliveryTypeId.equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1]%></option>
						<%}}%>
			      </select>
			  <label class="control-label " style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>DAK Priority</b></label>
				<select class="selectpicker custom-select" id="PriorityId" required="required" data-live-search="true" name="PriorityId" >
				<option value="All" <% if ( PriorityId!=null && "All".equalsIgnoreCase(PriorityId)) { %>selected="selected"<% } %>>All</option>
				<%if (priorityList != null && priorityList.size() > 0) {
					for (Object[] obj : priorityList) {%>
					<option value=<%=obj[0]%> <% if (PriorityId!=null && PriorityId.equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1]%></option>
						<%}}%>
			</select>
             <label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Source </b></label>
				<select class="selectpicker custom-select" id="sourceid" required="required" data-live-search="true" name="SourecId" >
				<option value="All" <% if ( Source!=null && "All".equalsIgnoreCase(Source)) { %>selected="selected"<% } %>>All</option>
				<%if (sourceList != null && sourceList.size() > 0) {
				for (Object[] obj : sourceList) {%>
				<option value=<%=obj[0]%> <% if (Source!=null && Source.equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1]%></option>
				<%}}%>
			</select>
			
			<label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Source Type</b></label>
				<select class="selectpicker custom-select" id="sourceTypeid" required="required" data-live-search="true" name="SourecTypeId" style="width: 50%;">
				<option value="All" <% if ( SelSourceType!=null && "All".equalsIgnoreCase(SelSourceType)) { %>selected="selected"<% } %>>All</option>
				<%if (AllSourceTypeList != null && AllSourceTypeList.size() > 0) {
				for (Object[] obj : AllSourceTypeList) {%>
				<option value=<%=obj[0]%> <% if (SelSourceType!=null && SelSourceType.equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()%>-<%=obj[2].toString() %></option>
				<%}}%>
			</select>
			
			</div>
			</div>
			</div>
			<div class="row FiltersSecond"  style="background-color:rgb(158 201 255); display: none;">
          <div class="float-container" >
           <div class="col-12" style="width: 100%; padding: 10px;margin-left: 18px; " >
           <label class="control-label " style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Project</b></label>
			<select class="selectpicker custom-select" id="RelaventId" required="required" data-live-search="true" name="ProjectType"  >
				<option value="All" <% if ( Project!=null && "All".equalsIgnoreCase(Project)) { %>selected="selected"<% } %>>All</option>
				<option value="N" <% if ( Project!=null && "N".equalsIgnoreCase(Project)) { %>selected="selected"<% } %>>Non-Project</option>
				<option value="P" <% if ( Project!=null && "P".equalsIgnoreCase(Project)) { %>selected="selected"<% } %>>Project</option>
				<option value="O" <% if ( Project!=null && "O".equalsIgnoreCase(Project)) { %>selected="selected"<% } %>>Project (Others)</option>
			</select>
			
			<label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Project Type</b></label>
				<select class="selectpicker custom-select" id="ProjectTypeid" required="required" data-live-search="true" name="ProjectTypeId" style="width: 100%;">
				<option value="All" <% if ( selProjectTypeId!=null && "All".equalsIgnoreCase(selProjectTypeId)) { %>selected="selected"<% } %>>All</option>
				<%if (ProjectTypeList != null && ProjectTypeList.size() > 0) {
				for (Object[] obj : ProjectTypeList) {%>
				<option value=<%=obj[0]%> <% if (selProjectTypeId!=null && selProjectTypeId.equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()%></option>
				<%}}%>
			</select>
			<%if(LoginType.equalsIgnoreCase("A") || LoginType.equalsIgnoreCase("L") || LoginType.equalsIgnoreCase("E") || LoginType.equalsIgnoreCase("Z")) {%>
			<label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Grouping </b></label>
				<select class="selectpicker custom-select" id="DakMemberTypeId" required="required" data-live-search="true" name="DakMemberTypeId" >
				<option value="All" <% if ( MemberTypeId!=null && "All".equalsIgnoreCase(MemberTypeId)) { %>selected="selected"<% } %>>All</option>
				<%if (DakGroupingListDropDown != null && DakGroupingListDropDown.size() > 0) {
				for (Object[] obj : DakGroupingListDropDown) {%>
				<option value=<%=obj[0]%> <% if (MemberTypeId!=null && MemberTypeId.equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1]%></option>
				<%}}%>
			</select>
			
			<label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Employee</b></label>
				<select class="selectpicker custom-select" id="Employee" required="required" data-live-search="true" name="Employee" style="width: 50%;">
				<option value="All" <% if ( Emp!=null && "All".equalsIgnoreCase(Emp)) { %>selected="selected"<% } %>>All</option>
				<%if (EmployeeList != null && EmployeeList.size() > 0) {
				for (Object[] obj : EmployeeList) {%>
				<option value=<%=obj[0]%> <% if (Emp!=null && Emp.equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()%>-<%=obj[2].toString() %></option>
				<%}}%>
			</select>
			<%} %>
			</div>
			</div>
       </div>
       </form>
       <hr style="background-color: green;">
       
       
       
       <div class="card-body " style="padding-top: 6px;max-height:43rem;"> 
       <div class="container">
        <div class="row" id="TotalDashBoard" style="display: none; ">
        <%if(LoginType.equalsIgnoreCase("A") || LoginType.equalsIgnoreCase("Z") || LoginType.equalsIgnoreCase("E") || LoginType.equalsIgnoreCase("L")){ %>
         <div class="col-md-2 col-xl-2" >
            <a id="DakDetailedList" href="DakList.htm" data-toggle="tooltip" data-placement="top" title="Click Here To Go DakList">
        <div class="card bg-c-blue order-card" >
                <div class="card-block">
                <h5 class="m-b-15"  style="color:black;"><b>Total DAK</b></h5>
                    <h2 class="text-right"><i class="fa fa-database float-right size" style="font-size: 40px; color: white;"></i></h2>
                   <p><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;">A : <%=TotalCountData[2] %>&nbsp;&nbsp;&nbsp;&nbsp;     R : <%=TotalCountData[1] %></span></b></p>
                </div>
            </div>
             </a>
            </div>
              <%} %>
              
          <%if(LoginType.equalsIgnoreCase("A") || LoginType.equalsIgnoreCase("L") || LoginType.equalsIgnoreCase("E") || LoginType.equalsIgnoreCase("U")) {%>
<div class="col-md-2 col-xl-2">
 <a  id="DakPendingReplyList" href="DakPendingReplyList.htm" data-toggle="tooltip" data-placement="top" title="Click Here To Go Dak Pending Reply List">
    <div class="card bg-c-green order-card" >
	<div class="card-block">
			<h5 class="m-b-15"  style="color:black;"><b>Pending Reply</b></h5>
		    <h2 class="text-right"><i class="fa fa-clock-o float-right size" style="font-size: 40px; color: white;"></i></h2>
	    <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"><%if(TotalCountData[4]!=null){%><%=TotalCountData[4] %><%}else{%> <%} %></span></b></p>
	</div>
</div>
</a>
</div>

  <div class="col-md-2 col-xl-2">
   <a id="DakRepliedList"  href="DakRepliedList.htm" data-toggle="tooltip" data-placement="top" title="Click Here To Go Dak Replied List">
<div class="card bg-c-pink order-card" >
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK Replied</b></h5>
        <h2 class="text-right"><i class="fa fa-reply float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"><%if(TotalCountData[5]!=null){%><%=TotalCountData[5] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</a>
</div>
<%} %>
 <%if(LoginType.equalsIgnoreCase("L") || LoginType.equalsIgnoreCase("E")) {%>
<div class="col-md-2 col-xl-2">
   <a id="DakPNCDOList"  href="DakPNCDOList.htm" data-toggle="tooltip" data-placement="top" title="Click Here To Go Dak P & C DO List">
<div class="card bg-c-purple order-card" >
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK P & C DO</b></h5>
        <h2 class="text-right"><i class="fa fa-user-tie float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"> <%if(TotalCountData[6]!=null){%><%=TotalCountData[6] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</a>
</div>
<%} %>

 <%if(LoginType.equalsIgnoreCase("Z")) {%>
 <div class="col-md-2 col-xl-2">
 <a id="DakDirectorList" href="DakDirectorList.htm" data-toggle="tooltip" data-placement="top" title="Click Here To Go Dak Director List">
<div class="card bg-c-yellow order-card" >
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK Director</b></h5>
        <h2 class="text-right"><i class="fa fa-user-shield float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"> <%if(TotalCountData[7]!=null){%><%=TotalCountData[7] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</a>
</div>
<%} %>

<%if(LoginType.equalsIgnoreCase("A") || LoginType.equalsIgnoreCase("L") || LoginType.equalsIgnoreCase("E") || LoginType.equalsIgnoreCase("U") || LoginType.equalsIgnoreCase("Z")) {%>
<div class="col-md-2 col-xl-2">
<a id="DakClosedList" href="DakClosedList.htm" data-toggle="tooltip" data-placement="top" title="Click  Here To Go Dak Closed List">
<div class="card bg-c-red order-card">
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK Closed</b></h5>
        <h2 class="text-right"><i class="fa-solid fa-door-closed float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"><%if(TotalCountData[8]!=null){%><%=TotalCountData[8] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</a>
</div>
<%} %>
             </div>
             </div>
             
             
              <div class="container">
       <div class="row" id="ProjectDashboard" style="display: none;">
         <div class="col-md-2 col-xl-2">
        <div class="card bg-c-blue order-card" >
                <div class="card-block">
                <h5 class="m-b-15"  style="color:black;"><b>Total DAK</b></h5>
                    <h2 class="text-right"><i class="fa fa-database float-right size" style="font-size: 40px; color: white;"></i></h2>
                   <p><b><span class="f-left" style="color:black; font-size: 18px; font-weight: 800;" >A : <%=ProjectCardsCount[2] %>&nbsp;&nbsp;&nbsp;&nbsp;     R : <%=ProjectCardsCount[3] %></span></b></p>
                </div>
            </div>
            </div>
              
             <div class="col-md-2 col-xl-2">
          			  <div class="card bg-c-green order-card" >
   						 <div class="card-block">
     				<h5 class="m-b-15"  style="color:black;"><b>DAK Pending Reply</b></h5>
     			   <h2 class="text-right"><i class="fa fa-clock-o float-right size" style="font-size: 40px; color: white;"></i></h2>
    			    <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"><%if(ProjectCardsCount[4]!=null){%><%=ProjectCardsCount[4] %><%}else{%> <%} %></span></b></p>
   				 </div>
			</div>
</div>

  <div class="col-md-2 col-xl-2">
<div class="card bg-c-pink order-card" >
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK Replied</b></h5>
        <h2 class="text-right"><i class="fa fa-reply float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"><%if(ProjectCardsCount[5]!=null){%><%=ProjectCardsCount[5] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</div>

<div class="col-md-2 col-xl-2">
<div class="card bg-c-purple order-card" >
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK P & C </b></h5>
        <h2 class="text-right"><i class="fa fa-user-tie float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"> <%if(ProjectCardsCount[6]!=null){%><%=ProjectCardsCount[6] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</div>

 <div class="col-md-2 col-xl-2">
<div class="card bg-c-yellow order-card" >
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK Director</b></h5>
        <h2 class="text-right"><i class="fa fa-user-shield float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"> <%if(ProjectCardsCount[7]!=null){%><%=ProjectCardsCount[7] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</div>

<div class="col-md-2 col-xl-2">
<div class="card bg-c-red order-card">
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK Closed</b></h5>
        <h2 class="text-right"><i class="fa-solid fa-door-closed float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"><%if(ProjectCardsCount[8]!=null){%><%=ProjectCardsCount[8] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</div>
             </div>
            </div>
            
              <div class="container">
        <div class="row" id="GroupDashboard" style="display: none;">
         <div class="col-md-2 col-xl-2">
        <div class="card bg-c-blue order-card" >
                <div class="card-block">
                <h5 class="m-b-15"  style="color:black;"><b>Total DAK</b></h5>
                    <h2 class="text-right"><i class="fa fa-database float-right size" style="font-size: 40px; color: white;"></i></h2>
                   <p><b><span class="f-left" style="color:black; font-size: 18px; font-weight: 800;" >A : <%=GroupCardsCount[2] %>&nbsp;&nbsp;&nbsp;&nbsp;     R : <%=GroupCardsCount[1] %></span></b></p>
                </div>
            </div>
            </div>
              
             <div class="col-md-2 col-xl-2">
          			  <div class="card bg-c-green order-card" >
   						 <div class="card-block">
     				<h5 class="m-b-15"  style="color:black;"><b>DAK Pending Reply</b></h5>
     			   <h2 class="text-right"><i class="fa fa-clock-o float-right size" style="font-size: 40px; color: white;"></i></h2>
    			    <p class="m-b-0" ><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"><%if(GroupCardsCount[4]!=null){%><%=GroupCardsCount[4] %><%}else{%> <%} %></span></b></p>
   				 </div>
			</div>
</div>

  <div class="col-md-2 col-xl-2">
<div class="card bg-c-pink order-card" >
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK Replied</b></h5>
        <h2 class="text-right"><i class="fa fa-reply float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"><%if(GroupCardsCount[5]!=null){%><%=GroupCardsCount[5] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</div>

<div class="col-md-2 col-xl-2">
<div class="card bg-c-purple order-card" >
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK P & C </b></h5>
        <h2 class="text-right"><i class="fa fa-user-tie float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"> <%if(GroupCardsCount[6]!=null){%><%=GroupCardsCount[6] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</div>

 <div class="col-md-2 col-xl-2">
<div class="card bg-c-yellow order-card" >
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK Director</b></h5>
        <h2 class="text-right"><i class="fa fa-user-shield float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"> <%if(GroupCardsCount[7]!=null){%><%=GroupCardsCount[7] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</div>

<div class="col-md-2 col-xl-2">
<div class="card bg-c-red order-card">
    <div class="card-block">
     <h5 class="m-b-15"  style="color:black;"><b>DAK Closed</b></h5>
        <h2 class="text-right"><i class="fa-solid fa-door-closed float-right size" style="font-size: 40px; color: white;"></i></h2>
        <p class="m-b-0"><b><span class="f-left"  style="color:black; font-size: 18px; font-weight: 800;"><%if(GroupCardsCount[8]!=null){%><%=GroupCardsCount[8] %><%}else{%> <%} %></span></b></p>
    </div>
</div>
</div>
             </div>
             </div>
            <div class="row labeleddata" style="display: none;" align="center">
         <!-- <label class="initiated" style="font-size: 15px;">Initiated</label> -->
         <label class="distributed" style="font-size: 15px;">Distributed</label>&nbsp;&nbsp;
         <label class="replied" style="font-size: 15px;">Replied</label>&nbsp;&nbsp;
         <label class="pnc-do" style="font-size: 15px;">Replied By P&C</label>&nbsp;&nbsp;
         <label class="approved" style="font-size: 15px;">Approved</label>&nbsp;&nbsp;
         <label class="closed" style="font-size: 15px;">Closed</label>
        </div><br>
          <div class="row overall" align="left" style="height: 34vh;  ">
          <div class="col-md-4" id="myChart"></div>
          <div class="col-md-4" id="mySecondChart"></div>
<!-- <canvas id="myChart" style="width:100%;max-width:550px; margin-left: 50px; height:40vh; padding: 10px; border: 1px solid #000; border-radius:10px; background-color: rgb(239, 239, 239);"></canvas> -->
<!-- <canvas id="mySecondChart" style="width:100%;max-width:550px; padding: 5px; height:40vh; border: 1px solid #000; border-radius:10px; background-color: rgb(239, 239, 239);"></canvas> -->
			<div class="col-md-4" id="myThirdChart">
		<span style="color: black; font-size: 25px; margin-top: 10px; margin-left: 100px;">DAK SLA NEXT THREE DAYS</span><br><br>
		  <div id="nearDistributedChart" style="width: 100%; height: 150px;"></div>
 		</div>
	</div>
<!-- <canvas id="myThirdChart" style="width:100%;max-width:500px;  padding: 5px; border: 1px solid #000; border-radius:10px; background-color: rgb(239, 239, 239);"></canvas> -->
</div>
<!-- <div id="container"></div> -->
<div class="ProjectGraph" id="ProjectGraph" style="display: none; height: 500px; border:1px solid #000; border-radius: 4px; ">

</div>
<div class="GroupGraph" id="GroupGraph" style="display: none; height: 500px; border: 1px solid #000; border-radius: 4px;">

</div>
<button class="open-modal-button" id="modalbtn" onclick="openModal()"><i class="fa fa-arrow-left" aria-hidden="true"></i></button>
	  <!-- Modal Container -->
  <div id="myModal" class="modal-container" >
    <div class="modalheader" style="justify-content: start;color:red; ">
    	<p style="margin-top:0.3rem; margin-bottom:0.4rem; font-weight: bold;"><b> Today's Date : &nbsp;</b><%=sdf.format(inputDateFormat.parse( LocalDate.now().toString()))%></p>
     <!--  <span class="modal-close"  onclick="closeModal()">&times;</span> -->
    </div>
    <div class="modalcontent" >
      <a href="DakReceivedList.htm?FromDate=<%= sdf.format(inputDateFormat.parse( LocalDate.now().toString())) %>&ToDate=<%= sdf.format(inputDateFormat.parse( LocalDate.now().toString())) %>" style="font-weight: 700;float:left; color:black; "><span style="text-decoration: underline">DAK Received Today</span>:
      <span style="border:1px solid trasparent;padding:2px;border-radius: 3px;background: green;color:white; margin-left: 10px; width: 30px; text-align: center;height: 25px;"><%if(PopUpCount!=null && PopUpCount[0]!=null) {%><%=PopUpCount[0].toString() %><%}else{ %>-<%} %></span><br><br></a>
      <a href="DakPendingReplyList.htm?FromDate=<%= sdf.format(inputDateFormat.parse( LocalDate.now().toString())) %>&ToDate=<%= sdf.format(inputDateFormat.parse( LocalDate.now().toString())) %>" style="font-weight: 700;float:left; color:black; "><span style="text-decoration: underline;">DAK Pending Today </span>:
      <span style="border:1px solid trasparent;padding:2px;border-radius: 5px;background: green;color:white;  margin-left: 18px; width: 30px; text-align: center; height: 25px;"><%if(PopUpCount!=null && PopUpCount[1]!=null) {%><%=PopUpCount[1].toString() %><%}else{ %>-<%} %></span><br><br></a>
      <a href="DakPendingReplyList.htm?FromDate=<%= sdf.format(inputDateFormat.parse( LocalDate.now().toString())) %>&ToDate=<%= toDateParameter %>" style="font-weight: 700;float:left; color:black; "><span style="text-decoration: underline">DAK Pending In Next Week </span>:
      <span style="border:1px solid trasparent;padding:2px;border-radius: 5px;background: green;color:white; width: 30px; text-align: center; height: 25px;"><%if(PopUpCount!=null && PopUpCount[2]!=null) {%><%=PopUpCount[2].toString() %><%}else{ %>-<%} %></span></a>
    </div>
    <div class="modalfooter">
      <button class="btn" aria-label="Close" style="padding: 0px !important; width:15%; font-weight: 800; margin-top: 100px; color: red;" onclick="closeModal()">
     Close
     </button>
    </div>
  </div>

  <div id="ModalDetails" class="modalcontainer">
    <div class="modalheader">
      <span class="modal-close"  onclick="closeModals()">&times;</span>
    </div>
    <div class="modalcontent"  id="modalcontents">
    </div>
  </div>
         </div>
         </div>
		
         </div>
        
		<!-- Loading  Modal -->
	
<div id="spinner" class="spinner" style="display:none;">
                <img id="img-spinner" style="width: 300px;height: 300px;" src="view/images/load.gif" alt="Loading"/>
                </div>
		<!-- Loading  Modal End-->
		
	</body>
	<script>
	$(document).ready(function(){
		var myAnchor = document.getElementById("DakDetailedList");
		if(myAnchor!=null){
		myAnchor.addEventListener("click", function(event) {
		    // Prevent the default action of the anchor tag
		    event.preventDefault();

		    // Get the values of the variables
		    var DeliveryTypeId = $('#DeliveryTypeId').val();
		    var PriorityId = $('#PriorityId').val();
		    var sourceid = $('#sourceid').val();
		    var sourceTypeid = $('#sourceTypeid').val();
		    var RelaventId = $('#RelaventId').val();
		    var ProjectTypeid = $('#ProjectTypeid').val();
		    var DakMemberTypeId = $('#DakMemberTypeId').val();
		    var Employee = $('#Employee').val();
	 		
		    // Construct the URL with the values
		    var url = "DakList.htm?" +
		              "FromDate=" + encodeURIComponent('<%=FromDate%>') +
		              "&ToDate=" + encodeURIComponent('<%=toDate%>') +
		              "&lettertypeid=" + encodeURIComponent(DeliveryTypeId) +
		              "&priorityid=" + encodeURIComponent(PriorityId) +
		              "&SourceId=" + encodeURIComponent(sourceid) +
		              "&sourcedetailid=" + encodeURIComponent(sourceTypeid) +
		              "&ProjectType=" + encodeURIComponent(RelaventId) +
		              "&ProjectId=" + encodeURIComponent(ProjectTypeid) ;
		              if (DakMemberTypeId !== null && typeof DakMemberTypeId !== "undefined") {
		            	    url += "&DakMemberTypeId=" + encodeURIComponent(DakMemberTypeId);
		            	} else {
		            	    url += "&DakMemberTypeId=All";
		            	}

		            	// Check if Employee is null or undefined
		            	if (Employee !== null && typeof Employee !== "undefined") {
		            	    url += "&EmpId=" + encodeURIComponent(Employee);
		            	} else {
		            	    url += "&EmpId=All";
		            	}

		    // Set the updated URL to the href attribute of the anchor
		    this.href = url;
		    
		    $('#spinner').show();
            $('#loadingCard').hide();
            
		    // Navigate to the constructed URL
		    window.location.href = url;
		});
		}
		
		var myAnchor1 = document.getElementById("DakPendingReplyList");
		if(myAnchor1!=null){
		myAnchor1.addEventListener("click", function(event) {
		    // Prevent the default action of the anchor tag
		    event.preventDefault();

		    // Get the values of the variables
		    var DeliveryTypeId = $('#DeliveryTypeId').val();
		    var PriorityId = $('#PriorityId').val();
		    var sourceid = $('#sourceid').val();
		    var sourceTypeid = $('#sourceTypeid').val();
		    var RelaventId = $('#RelaventId').val();
		    var ProjectTypeid = $('#ProjectTypeid').val();
		    var DakMemberTypeId = $('#DakMemberTypeId').val();
		    var Employee = $('#Employee').val();
		    
	 		
		    // Construct the URL with the values
		    var url = "DakPendingReplyList.htm?" +
		              "FromDate=" + encodeURIComponent('<%=FromDate%>') +
		              "&ToDate=" + encodeURIComponent('<%=toDate%>') +
		              "&lettertypeid=" + encodeURIComponent(DeliveryTypeId) +
		              "&priorityid=" + encodeURIComponent(PriorityId) +
		              "&SourceId=" + encodeURIComponent(sourceid) +
		              "&sourcedetailid=" + encodeURIComponent(sourceTypeid) +
		              "&ProjectType=" + encodeURIComponent(RelaventId) +
		              "&ProjectId=" + encodeURIComponent(ProjectTypeid) ;
		    
		              if (DakMemberTypeId !== null && typeof DakMemberTypeId !== "undefined") {
		            	    url += "&DakMemberTypeId=" + encodeURIComponent(DakMemberTypeId);
		            	} else {
		            	    url += "&DakMemberTypeId=All";
		            	}

		            	// Check if Employee is null or undefined
		            	if (Employee !== null && typeof Employee !== "undefined") {
		            	    url += "&EmpId=" + encodeURIComponent(Employee);
		            	} else {
		            	    url += "&EmpId=All";
		            	}

		    // Set the updated URL to the href attribute of the anchor
		    this.href = url;
		    
		    $('#spinner').show();
            $('#loadingCard').hide();
            
		    // Navigate to the constructed URL
		    window.location.href = url;
		});
		}
		
		var myAnchor2 = document.getElementById("DakRepliedList");
		if(myAnchor2!=null){
		myAnchor2.addEventListener("click", function(event) {
		    // Prevent the default action of the anchor tag
		    event.preventDefault();

		    // Get the values of the variables
		    var DeliveryTypeId = $('#DeliveryTypeId').val();
		    var PriorityId = $('#PriorityId').val();
		    var sourceid = $('#sourceid').val();
		    var sourceTypeid = $('#sourceTypeid').val();
		    var RelaventId = $('#RelaventId').val();
		    var ProjectTypeid = $('#ProjectTypeid').val();
		    var DakMemberTypeId = $('#DakMemberTypeId').val();
		    var Employee = $('#Employee').val();
		    var Redirectval='RepliedByMe';
		    
		    // Construct the URL with the values
		    var url = "DakRepliedList.htm?" +
		              "FromDate=" + encodeURIComponent('<%=FromDate%>') +
		              "&ToDate=" + encodeURIComponent('<%=toDate%>') +
		              "&lettertypeid=" + encodeURIComponent(DeliveryTypeId) +
		              "&priorityid=" + encodeURIComponent(PriorityId) +
		              "&SourceId=" + encodeURIComponent(sourceid) +
		              "&sourcedetailid=" + encodeURIComponent(sourceTypeid) +
		              "&ProjectType=" + encodeURIComponent(RelaventId) +
		              "&ProjectId=" + encodeURIComponent(ProjectTypeid) +
		              "&redirectedvalue=" + encodeURIComponent(Redirectval);
		    
		              if (DakMemberTypeId !== null && typeof DakMemberTypeId !== "undefined") {
		            	    url += "&DakMemberTypeId=" + encodeURIComponent(DakMemberTypeId);
		            	} else {
		            	    url += "&DakMemberTypeId=All";
		            	}

		            	// Check if Employee is null or undefined
		            	if (Employee !== null && typeof Employee !== "undefined") {
		            	    url += "&EmpId=" + encodeURIComponent(Employee);
		            	} else {
		            	    url += "&EmpId=All";
		            	}
		              

		    // Set the updated URL to the href attribute of the anchor
		    this.href = url;
		    
		    $('#spinner').show();
            $('#loadingCard').hide();
            
		    // Navigate to the constructed URL
		    window.location.href = url;
		});
		}
		
		var myAnchor3 = document.getElementById("DakPNCDOList");
		if(myAnchor3!=null){
		myAnchor3.addEventListener("click", function(event) {
		    // Prevent the default action of the anchor tag
		    event.preventDefault();

		    // Get the values of the variables
		    var DeliveryTypeId = $('#DeliveryTypeId').val();
		    var PriorityId = $('#PriorityId').val();
		    var sourceid = $('#sourceid').val();
		    var sourceTypeid = $('#sourceTypeid').val();
		    var RelaventId = $('#RelaventId').val();
		    var ProjectTypeid = $('#ProjectTypeid').val();
		    var DakMemberTypeId = $('#DakMemberTypeId').val();
		    var Employee = $('#Employee').val();
		    var ActionId=2;
		    
		    // Construct the URL with the values
		    var url = "DakPNCDOList.htm?" +
		              "fromDateFetch=" + encodeURIComponent('<%=FromDate%>') +
		              "&toDateFetch=" + encodeURIComponent('<%=toDate%>') +
		              "&lettertypeid=" + encodeURIComponent(DeliveryTypeId) +
		              "&priorityid=" + encodeURIComponent(PriorityId) +
		              "&SourceId=" + encodeURIComponent(sourceid) +
		              "&sourcedetailid=" + encodeURIComponent(sourceTypeid) +
		              "&ProjectType=" + encodeURIComponent(RelaventId) +
		              "&ProjectId=" + encodeURIComponent(ProjectTypeid) +
		              "&ActionId=" + encodeURIComponent(ActionId);
		    
		              if (DakMemberTypeId !== null && typeof DakMemberTypeId !== "undefined") {
		            	    url += "&DakMemberTypeId=" + encodeURIComponent(DakMemberTypeId);
		            	} else {
		            	    url += "&DakMemberTypeId=All";
		            	}

		            	// Check if Employee is null or undefined
		            	if (Employee !== null && typeof Employee !== "undefined") {
		            	    url += "&EmpId=" + encodeURIComponent(Employee);
		            	} else {
		            	    url += "&EmpId=All";
		            	}
		              

		    // Set the updated URL to the href attribute of the anchor
		    this.href = url;
		    
		    $('#spinner').show();
            $('#loadingCard').hide();
            
		    // Navigate to the constructed URL
		    window.location.href = url;
		});
		}
		
		var myAnchor4 = document.getElementById("DakDirectorList");
		if(myAnchor4!=null){
		myAnchor4.addEventListener("click", function(event) {
		    // Prevent the default action of the anchor tag
		    event.preventDefault();

		    // Get the values of the variables
		    var DeliveryTypeId = $('#DeliveryTypeId').val();
		    var PriorityId = $('#PriorityId').val();
		    var sourceid = $('#sourceid').val();
		    var sourceTypeid = $('#sourceTypeid').val();
		    var RelaventId = $('#RelaventId').val();
		    var ProjectTypeid = $('#ProjectTypeid').val();
		    var DakMemberTypeId = $('#DakMemberTypeId').val();
		    var Employee = $('#Employee').val();
		    
		    // Construct the URL with the values
		    var url = "DakDirectorList.htm?" +
		              "&lettertypeid=" + encodeURIComponent(DeliveryTypeId) +
		              "&priorityid=" + encodeURIComponent(PriorityId) +
		              "&SourceId=" + encodeURIComponent(sourceid) +
		              "&sourcedetailid=" + encodeURIComponent(sourceTypeid) +
		              "&ProjectType=" + encodeURIComponent(RelaventId) +
		              "&ProjectId=" + encodeURIComponent(ProjectTypeid) ;
		    
		              if (DakMemberTypeId !== null && typeof DakMemberTypeId !== "undefined") {
		            	    url += "&DakMemberTypeId=" + encodeURIComponent(DakMemberTypeId);
		            	} else {
		            	    url += "&DakMemberTypeId=All";
		            	}

		            	// Check if Employee is null or undefined
		            	if (Employee !== null && typeof Employee !== "undefined") {
		            	    url += "&EmpId=" + encodeURIComponent(Employee);
		            	} else {
		            	    url += "&EmpId=All";
		            	}
		              

		    // Set the updated URL to the href attribute of the anchor
		    this.href = url;
		    
		    $('#spinner').show();
            $('#loadingCard').hide();
            
		    // Navigate to the constructed URL
		    window.location.href = url;
		});
		}
		
		var myAnchor5 = document.getElementById("DakClosedList");
		if(myAnchor5!=null){
		myAnchor5.addEventListener("click", function(event) {
		    // Prevent the default action of the anchor tag
		    event.preventDefault();

		    // Get the values of the variables
		    var DeliveryTypeId = $('#DeliveryTypeId').val();
		    var PriorityId = $('#PriorityId').val();
		    var sourceid = $('#sourceid').val();
		    var sourceTypeid = $('#sourceTypeid').val();
		    var RelaventId = $('#RelaventId').val();
		    var ProjectTypeid = $('#ProjectTypeid').val();
		    var DakMemberTypeId = $('#DakMemberTypeId').val();
		    var Employee = $('#Employee').val();
		    
		    // Construct the URL with the values
		    var url = "DakClosedList.htm?" +
		              "FromDate=" + encodeURIComponent('<%=FromDate%>') +
		              "&ToDate=" + encodeURIComponent('<%=toDate%>') +
		              "&lettertypeid=" + encodeURIComponent(DeliveryTypeId) +
		              "&priorityid=" + encodeURIComponent(PriorityId) +
		              "&SourceId=" + encodeURIComponent(sourceid) +
		              "&sourcedetailid=" + encodeURIComponent(sourceTypeid) +
		              "&ProjectType=" + encodeURIComponent(RelaventId) +
		              "&ProjectId=" + encodeURIComponent(ProjectTypeid) ;
		    
		              if (DakMemberTypeId !== null && typeof DakMemberTypeId !== "undefined") {
		            	    url += "&DakMemberTypeId=" + encodeURIComponent(DakMemberTypeId);
		            	} else {
		            	    url += "&DakMemberTypeId=All";
		            	}

		            	// Check if Employee is null or undefined
		            	if (Employee !== null && typeof Employee !== "undefined") {
		            	    url += "&EmpId=" + encodeURIComponent(Employee);
		            	} else {
		            	    url += "&EmpId=All";
		            	}
		              

		    // Set the updated URL to the href attribute of the anchor
		    this.href = url;
		    
		    $('#spinner').show();
            $('#loadingCard').hide();
            
		    // Navigate to the constructed URL
		    window.location.href = url;
		});
		}
	});
  // Check if the CountForMsgRedirect string is not null
  var countForMsgMarkerRedirect = '<%= redirectedvalue %>';
  if (countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='MainDashBoard') {
    // Get the button element by ID
   var button = document.getElementById('OverallButton');
   if (button) {
	   applyStylesbtn1();
		    }
  }else if(countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='ProjectDashBoard'){
	  var button = document.getElementById('ProjectButton');

	    if (button) {
	    	applyStylesbtn2();
	    }
  }else if(countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='GroupDashBoard'){
	  var button = document.getElementById('GroupButton');

	    if (button) {
	      applyStylesbtn3();
     }
	    
  }
  
  
  $('.btn1').click(function(){
	  applyStylesbtn1();
	}) 

	$('.btn2').click(function(){
		applyStylesbtn2();
	})

	$('.btn3').click(function(){
		applyStylesbtn3();
	})
	
	
	
	
	function applyStylesbtn1() {
       $('.btn1').css('background-color','green');
       $('.btn1').css('color','white');
       $('.btn2').css('background-color','white');
       $('.btn2').css('color','black');
       $('.btn3').css('background-color','white');
       $('.btn3').css('color','black');
       $('.Filtersfirst').css('display','block');
       $('.FiltersSecond').css('display','block');
       $('.labeleddata').css('display','block');
       $('.overall').css('display','');
       $('.ProjectGraph').css('display','none');
       $('#TotalDashBoard').css('display','');
       $('#ProjectDashboard').css('display','none');
       $('#GroupDashboard').css('display','none');
       $('#GroupGraph').css('display','none');
  }
  
  
	function applyStylesbtn2() {
		
		$('.btn2').css('background-color','green');
		$('.btn2').css('color','white');
		$('.btn1').css('background-color','white');
		$('.btn1').css('color','black');
		$('.btn3').css('background-color','white');
		$('.btn3').css('color','black');
		$('.Filtersfirst').css('display','none');
		$('.FiltersSecond').css('display','none');
		$('.labeleddata').css('display','none');
		$('.overall').css('display','none');
		$('.ProjectGraph').css('display','block');
		$('#TotalDashBoard').css('display','none');
		$('#ProjectDashboard').css('display','');
		 $('#GroupDashboard').css('display','none');
		 $('#GroupGraph').css('display','none');
	}
	
	function applyStylesbtn3() {
		$('.btn3').css('background-color','green');
		$('.btn3').css('color','white');
		$('.btn1').css('background-color','white');
		$('.btn1').css('color','black');
		$('.btn2').css('background-color','white');
		$('.btn2').css('color','black');
		$('.Filtersfirst').css('display','none');
		$('.FiltersSecond').css('display','none');
		$('.labeleddata').css('display','none');
		$('.overall').css('display','none');
		$('.ProjectGraph').css('display','none');
		$('#TotalDashBoard').css('display','none');
		$('#ProjectDashboard').css('display','none');
		 $('#GroupDashboard').css('display','');
		 $('#GroupGraph').css('display','block');
	}
	
	

	<%-- function openModalDetails(a,b){
		var jsObjectList
		console.log(b + "--"+ typeof b)
		if(a==="M" && b>0){
			jsObjectList = JSON.parse('<%= jsonArray %>');
		}
		console.log(jsObjectList)
		var html="";
		for(var i=0;i<jsObjectList.length;i++){
			html=html+'<p style="font-weight: 600;">'+"Project:"+jsObjectList[i][8]+"; Meeting:"+jsObjectList[i][7]+"; Time:"+jsObjectList[i][4]+';</p>'
		}
		document.getElementById('modalcontents').innerHTML=html;
		if(jsObjectList.length>0){
			$('#ModalDetails').show();
			   $( document ).ready(function() {
		    	   setTimeout(() => { 
		    		   closeModals()
				}, 3000);
		    	});
		}
	} --%>
	function closeModals(){
		$('#ModalDetails').hide();
	}

	// Functions to open and close the modal
	function openModal() {
	/*   document.getElementById('myModal').style.display = 'block';
	  document.getElementById('modalbtn').style.display = 'none'; */
		$('#myModal').show();
	 	$('#modalbtn').hide();
	    setTimeout(() => { 
			   closeModal()
		}, 10000);
	}

	function closeModal() {
	/*   document.getElementById('myModal').style.display = 'none';
	 */  $('#myModal').hide();
	 	$('#modalbtn').show();
	 /*  document.getElementById('modalbtn').style.display = 'block'; */
	}

	// Close the modal if the user clicks outside of it
	window.onclick = function(event) {
	  var modal = document.getElementById('myModal');
	  if (event.target === modal) {
	    modal.style.display = 'none';
	  }
	}

	//clicked the modal 
	    document.addEventListener('DOMContentLoaded', function() {
	    	openModal();
	      });
	      
	    $( document ).ready(function() {
	    	   setTimeout(() => { 
	    		   closeModal()
			}, 10000);
	    	});
</script>
	<script>
  // Get references to the elements
  // Add click event handlers to the tab links
  $("#OverallButton").click(function() {
	$("#redirectedvalue").val('');
    $("#redirectedvalue").val('MainDashBoard');
  });

  $("#ProjectButton").click(function() {
    $("#redirectedvalue").val('');
    $("#redirectedvalue").val('ProjectDashBoard');
  });
  
  $("#GroupButton").click(function() {
	$("#redirectedvalue").val('');
	$("#redirectedvalue").val('GroupDashBoard');
 });
</script>
	<script>
    function submitForm(selectedValue) {
      
        // Submit the formlabeled
        
        var confirmation = true; // Set your condition for confirmation here

            if (confirmation) {
                var form = document.getElementById("myform");
                if (form) {
                    var dakDistributeSubmitBtn = document.getElementById("DakDistriBtn");
                        form.submit();
                        $('#spinner').show();
                        $('#loadingCard').hide();
                    }
            } else {
            	$('#spinner').hide();
                return false;
            }
    }
    $(document).ready(function(){
        $('#sourceid').change(function(){
            $("#sourceTypeid").prop("disabled", true);
            var confirmation = true; // Set your condition for confirmation here

            if (confirmation) {
                var form = document.getElementById("myform");
                if (form) {
                    var dakDistributeSubmitBtn = document.getElementById("DakDistriBtn");
                        form.submit();
                        $('#spinner').show();
                        $('#loadingCard').hide();
                    }
            } else {
            	$('#spinner').hide();
                return false;
            }
    });

 	  $('#RelaventId').change(function(){
 		 $("#ProjectTypeid").prop("disabled", true);
 		 var confirmation = true; // Set your condition for confirmation here

         if (confirmation) {
             var form = document.getElementById("myform");
             if (form) {
                     form.submit();
                     $('#spinner').show();
                     $('#loadingCard').hide();
                 }
         } else {
        	 $('#spinner').hide();
             return false;
         }
	    });
 	 $('#sourceTypeid').change(function(){
 		 var confirmation = true; // Set your condition for confirmation here

         if (confirmation) {
             var form = document.getElementById("myform");
             if (form) {
                     form.submit();
                     $('#spinner').show();
                     $('#loadingCard').hide();
                 }
         } else {
        	 $('#spinner').hide();
             return false;
         }
	    });
 	 $('#ProjectTypeid').change(function(){
 		 var confirmation = true; // Set your condition for confirmation here

         if (confirmation) {
             var form = document.getElementById("myform");
             if (form) {
                     form.submit();
                     $('#spinner').show();
                     $('#loadingCard').hide();
                 }
         } else {
        	 $('#spinner').hide();
             return false;
         }
	    });
 	 
 	$('#DakMemberTypeId').change(function(){
 		 $("#Employee").prop("disabled", true);
 		 var confirmation = true; // Set your condition for confirmation here

         if (confirmation) {
             var form = document.getElementById("myform");
             if (form) {
                     form.submit();
                     $('#spinner').show();
                     $('#loadingCard').hide();
                 }
         } else {
        	 $('#spinner').hide();
             return false;
         }
	    });
	 $('#Employee').change(function(){
		 var confirmation = true; // Set your condition for confirmation here

         if (confirmation) {
             var form = document.getElementById("myform");
             if (form) {
                     form.submit();
                     $('#spinner').show();
                     $('#loadingCard').hide();
                 }
         } else {
        	 $('#spinner').hide();
             return false;
         }
	    });
	 
	 $('#DeliveryTypeId').change(function(){
		 var confirmation = true; // Set your condition for confirmation here

         if (confirmation) {
             var form = document.getElementById("myform");
             if (form) {
                     form.submit();
                     $('#spinner').show();
                     $('#loadingCard').hide();
                 }
         } else {
        	 $('#spinner').hide();
             return false;
         }
	    });
	 $('#PriorityId').change(function(){
		 var confirmation = true; // Set your condition for confirmation here

         if (confirmation) {
             var form = document.getElementById("myform");
             if (form) {
                     form.submit();
                     $('#spinner').show();
                     $('#loadingCard').hide();
                 }
         } else {
        	 $('#spinner').hide();
             return false;
         }
	    });
 	});
</script>
	<%-- <script>
     window.location.hash = "no-back-button";

    window.location.hash = "Again-No-back-button"; 

    window.onhashchange = function(){
        window.location.hash = "no-back-button";
    } 
    
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
    	
    var currentDate = new Date();
    var maxDate = currentDate.toISOString().split('T')[0];
    console.log(maxDate);

    	$('#todate').daterangepicker({
    		"singleDatePicker" : true,
    		"linkedCalendars" : false,
    		"showCustomRangeLabel" : true,
    		"startDate" : new Date('<%=toDt%>'), 
    		"maxDate" : new Date(maxDate),  
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
</script>  --%>

<script>
<%-- var xValues = ["<%=TotalCountData[3]%>", "<%=TotalCountData[5]%>", "<%=TotalCountData[10]%> ", "<%=TotalCountData[9]%>" ,"<%=TotalCountData[8]%>"];
var yValues = [<%=TotalCountData[3]%>, <%=TotalCountData[5]%>, <%=TotalCountData[10]%>, <%=TotalCountData[9]%>,<%=TotalCountData[8]%>];
var barColors = ["rgb(185, 28, 214)","rgb(0, 0, 255)","rgb(161, 118, 39)","rgb(34, 139, 34)","rgb(249, 99, 2)"];

new Chart(document.getElementById("myChart"), {
    type: "bar",
    data: {
        labels: xValues,
        datasets: [{
            backgroundColor: barColors,
            data: yValues
        }]
    },
    options: {
        legend: { display: false },
        title: {
            display: true,
            text: "DAK COUNTS",
            fontColor: '#4477CE',
            fontSize: 20,
            fontStyle: 'bold',
            padding: 20
        },
        scales: {
            xAxes: [{
                ticks: {
                    fontColor: "black", // Customize the font color for the x-axis labels
                    style: {
                        fontWeight: "1000" // Set the font weight for the x-axis labels
                    }
                },
                categoryPercentage: 0.4 // Adjust the value to compress the x-axis labels
            }],
            yAxes: [{
                ticks: {
                    fontColor: "black", // Customize the font color for the y-axis labels
                    style: {
                        fontWeight: "1000" // Set the font weight for the y-axis labels
                    }
                }
            }]
        }
    }
}); --%>

anychart.onDocumentReady(function () {
	  // create 3D pie chart with dynamic data
	 var chart = anychart.pie3d([
        {x: "Distributed", value: <%=TotalCountData[3]%>},
        {x: "Replied", value: <%=TotalCountData[5]%>},
        {x: "Replied By P&C", value: <%=TotalCountData[10]%>},
        {x: "Approved", value: <%=TotalCountData[9]%>},
        {x: "Closed", value: <%=TotalCountData[8]%>}
    ]);

	 chart
     .title('DAK COUNTS')
     .radius('60%');
	  chart.container('myChart');  
	  chart.draw();
	});



anychart.onDocumentReady(function () {
	  // create 3D pie chart with dynamic data
	var chart = anychart.pie3d([
    {x: "Distributed", value: <%=MissedDistributed%>},
    {x: "Replied", value: <%=MissedReplied%>},
    {x: "Replied By P&C", value: <%=MissedRepliedByPnCDo%>},
    {x: "Approved", value: <%=MissedApproved%>},
    {x: "Closed", value: <%=MissedClosed%>}
	]);


	  // set chart title with text and styles
	  chart
     .title('DAK SLA MISSED')
     // set chart radius
     .radius('60%');

	  // set the palette (colors for the slices)
	 /*  chart.palette([
	    "rgb(185, 28, 214)",
	    "rgb(0, 0, 255)",
	    "rgb(161, 118, 39)",
	    "rgb(34, 139, 34)",
	    "rgb(249, 99, 2)"
	  ]); */

	  // set container id for the chart
	  chart.container('mySecondChart');  // This matches the container for your second chart

	  // draw the chart
	  chart.draw();
	});


anychart.onDocumentReady(function () {
	  // create data for the doughnut chart
	  var data = [
	    {x: "SLA Next Three Days", value: <%=NearDistributed%>},  // Your main count
	    {x: "Remaining", value: 100 - <%=NearDistributed%>}  // Placeholder to make a complete circle
	  ];

	  // create a pie chart and set the data
	  var chart = anychart.pie(data);

	  // set the inner radius to create a doughnut chart
	  chart.innerRadius("50%");

	  // customize the appearance of the chart
	  chart.labels(false);  // Disable labels for cleaner look

	  // set the chart title
	  chart.title(false);  // Disable title

	  // set the container id
	  chart.container("nearDistributedChart");

	  // initiate drawing the chart
	  chart.draw();
	});


var xValues = ["<%=NearDistributed%>", "<%=NearReplied%>", "<%=NearRepliedByPnCDo%>", "<%=NearApproved%>" ,"<%=NearClosed%>"];
var yValues = [<%=NearDistributed%>, <%=NearReplied%>, <%=NearRepliedByPnCDo%>, <%=NearApproved%>,<%=NearClosed%>];
var barColors = ["rgb(185, 28, 214)","rgb(0, 0, 255)","rgb(161, 118, 39)","rgb(34, 139, 34)","rgb(249, 99, 2)"];

new Chart(document.getElementById("myThirdChart"), {
    type: "bar",
    data: {
        labels: xValues,
        datasets: [{
            backgroundColor: barColors,
            data: yValues
        }]
    },
    options: {
        legend: { display: false },
        title: {
            display: true,
            text: "DAK SLA NEXT THREE DAYS",
            fontColor: '#4477CE',
            fontSize: 20,
            fontStyle: 'bold',
            padding: 20
        },
        scales: {
            xAxes: [{
                ticks: {
                    fontColor: "black", // Customize the font color for the x-axis labels
                    style: {
                        fontWeight: "900" // Set the font weight for the x-axis labels (adjust the value as needed)
                    }
                },
                categoryPercentage: 0.4 // Adjust the value to compress the x-axis labels
            }],
            yAxes: [{
                ticks: {
                    fontColor: "black", // Customize the font color for the y-axis labels
                    style: {
                        fontWeight: "900" // Set the font weight for the y-axis labels (adjust the value as needed)
                    }
                }
            }]
        }
    }
});



<%-- var xValues = ["Initiated", "Distributed", "Replied", "P&C DO", "Approved" ,"Closed"];
var yValues = [<%=TotalCountData[0]%>, <%=TotalCountData[3]%>, <%=TotalCountData[5]%>, <%=TotalCountData[6]%>, <%=TotalCountData[7]%>,<%=TotalCountData[8]%>];
var barColors = ["rgb(0, 123, 255)", "rgb(185, 28, 214)","rgb(0, 0, 255)","rgb(161, 118, 39)","rgb(34, 139, 34)","rgb(249, 99, 2)"];
var totalCountData = "<%=TotalCountData[0]%>"; 

new Chart("mySecondChart", {
  type: "bar",
  data: {
    labels: xValues,
    datasets: [{
      backgroundColor: barColors,
      data: yValues
    }]
  },
  options: {
    legend: {display: false},
    title: {
      display: true,
      text: "DAK SLA MISSED (" + totalCountData + ")"
    }
  }
});

var xValues = ["Initiated", "Distributed", "Replied", "P&C DO", "Approved" ,"Closed"];
var yValues = [<%=TotalCountData[0]%>, <%=TotalCountData[3]%>, <%=TotalCountData[5]%>, <%=TotalCountData[6]%>, <%=TotalCountData[7]%>,<%=TotalCountData[8]%>];
var barColors = ["rgb(0, 123, 255)", "rgb(185, 28, 214)","rgb(0, 0, 255)","rgb(161, 118, 39)","rgb(34, 139, 34)","rgb(249, 99, 2)"];
var totalCountData = "<%=TotalCountData[0]%>"; 

new Chart("myThirdChart", {
  type: "bar",
  data: {
    labels: xValues,
    datasets: [{
      backgroundColor: barColors,
      data: yValues
    }]
  },
  options: {
    legend: {display: false},
    title: {
      display: true,
      text: "DAK SLA NEAR (" + totalCountData + ")"
    }
  }
}); --%>

var xValues = ["Initiated", "Distributed", "Replied", "P&C DO", "Approved" ,"Closed"];
var yValues = [<%=TotalCountData[0]%>, <%=TotalCountData[3]%>, <%=TotalCountData[5]%>, <%=TotalCountData[6]%>, <%=TotalCountData[7]%>,<%=TotalCountData[8]%>];
var barColors = ["rgb(0, 123, 255)","rgb(185, 28, 214)", "rgb(0, 0, 255)","rgb(161, 118, 39)","rgb(34, 139, 34)","rgb(249, 99, 2)"];

new Chart("mysecondChart", {
  type: "pie",
  data: {
    labels: xValues,
    datasets: [{
      backgroundColor: barColors,
      data: yValues
    }]
  },
  options: {
    title: {
      display: true,
      text: "DAK COUNTS",
      fontColor: '#4477CE', // Set the color of the title text
      fontSize: 20, // Set the font size of the title text
      fontStyle: 'bold', // Set the font style of the title text
      padding: 20
    }
  }
});

 anychart.onDocumentReady(function () {
    // create a dataset

    var dataArray = [];
    <%
    for (Map.Entry<String, List<Object[]>> entry : multiValueMap.entrySet()) {
        String key = entry.getKey();
        List<Object[]> valueList = entry.getValue();
        for (Object[] objArray : valueList) {
        	    Object value1 = objArray[0];
        	    Object value2 = objArray[1];
        	    Object value3 = objArray[2];
        	    Object value4 = objArray[3];
                Object value5 = objArray[4]; // Accessing the element at index 4
                Object value6 = objArray[5];
                Object value7 = objArray[6];
                Object value8 = objArray[7];
                Object value9 = objArray[8];
                Object value10 = objArray[9];
                Object value11 = objArray[10];
                Object value12 = objArray[11];
                Object value13 = objArray[12];// Accessing the element at index 5
                %>
                var dataRow = [<%= value1 %>, <%= value2 %>, <%= value3 %>, <%= value4 %>, <%= value5%>, <%= value6 %>,<%=value7%>,<%=value8%>,<%=value9%>,<%=value10%>,<%=value11%>,<%=value12%>,'<%=value13%>'];
                dataArray.push(dataRow);
                <%
        }
    }
    %>


    var dataSet = anychart.data.set(dataArray);

    // map the data for the first series
    var firstSeriesData = dataSet.mapAs({ x: 12, value: 1 });

    // map the data for the second series
    var secondSeriesData = dataSet.mapAs({ x: 12, value: 5 });

    // map the data for the third series
    var thirdSeriesData = dataSet.mapAs({ x: 12, value: 9 });

    // map the data for the fourth series
    var FourthSeriesData = dataSet.mapAs({ x: 12, value: 10 });

    // map the data for the fifth series
    var FifthSeriesData = dataSet.mapAs({ x: 12, value: 8 });

    // create a column chart instance
    var chart = anychart.bar();
    // stack values on y scale.
    chart.yScale().stackMode('value');

    // a function to configure label, padding, and color settings for all series
    var setupSeries = function (series, name, color, hoveredColor) {
        series.name(name).stroke('2 #fff 1').fill(color);
        series.hovered().stroke('1 #fff 1').fill(hoveredColor);
    };

    // store series
    var series;

    // create the first series with the mapped data
    series = chart.bar(firstSeriesData);
    setupSeries(series, 'Distributed', 'rgb(100, 181, 246)');

    // create the second series with the mapped data
    series = chart.bar(secondSeriesData);
    setupSeries(series, 'Replied', 'rgb(25, 118, 210)');

    // create the third series with the mapped data
    series = chart.bar(thirdSeriesData);
    setupSeries(series, 'Replied By P&C', 'rgb(239, 108, 0)');

    // create the fourth series with the mapped data
    series = chart.bar(FourthSeriesData);
    setupSeries(series, 'Approved', 'rgb(255, 213, 79)');

    // create the fifth series with the mapped data
    series = chart.bar(FifthSeriesData);
    setupSeries(series, 'Closed', 'rgb(69, 90, 100)');

    // turn on the legend
    chart.legend().enabled(true).fontSize(16).padding([10, 0, 0, 0]);

    // set the union tooltip
    chart.tooltip().displayMode('union');

    // customize the toolttip
    chart.tooltip().titleFormat(function() {
        return this.x + ' - ' + this.points[0].getStat('categoryYSum');
    });

    chart.xAxis().labels().fontWeight('900').fontColor('black');

    // Customize the Y axis labels with font weight
    chart.yAxis().labels().fontWeight('900').fontColor('black');


    // set the chart title and adjust it
    chart.title('PROJECT-WISE DAK COUNT');
    chart.title().fontSize(20).fontColor('#4477CE').padding([5, 0, 0, 0]);
    
    // define zoom settings
    chart.xZoom().setToPointsCount(7);

    // enable and configure the scroller
    chart.xScroller(true);
    chart.xScroller().orientation("right");
    chart.xScroller().thumbs(false);
    

    // prevent the range changing
    chart.xScroller().allowRangeChange(false); 
    // set the container id for the chart
    chart.container('ProjectGraph');
    
    // initiate chart drawing
    chart.draw();
}); 
 
 
 
 anychart.onDocumentReady(function () {
	    // create a dataset

	    var dataArray = [];
	    <%
	    for (Map.Entry<String, List<Object[]>> entry : multiGroupValueMap.entrySet()) {
	        String key = entry.getKey();
	        List<Object[]> valueList = entry.getValue();
	        for (Object[] objArray : valueList) {
	        	    Object value1 = objArray[0];
	        	    Object value2 = objArray[1];
	        	    Object value3 = objArray[2];
	        	    Object value4 = objArray[3];
	                Object value5 = objArray[4]; // Accessing the element at index 4
	                Object value6 = objArray[5];
	                Object value7 = objArray[6];
	                Object value8 = objArray[7];
	                Object value9 = objArray[8];
	                Object value10 = objArray[9];
	                Object value11 = objArray[10];// Accessing the element at index 5
	                %>
	                var dataRow = [<%= value1 %>, <%= value2 %>, <%= value3 %>, <%= value4 %>, <%= value5%>, <%= value6 %>,<%=value7%>,<%=value8%>,<%=value9%>,<%=value10%>,'<%=value11%>'];
	                dataArray.push(dataRow);
	                <%
	        }
	    }
	    %>


	    var dataSet = anychart.data.set(dataArray);

	    // map the data for the first series
	    var firstSeriesData = dataSet.mapAs({ x: 10, value: 1 });

	    // map the data for the second series
	    var secondSeriesData = dataSet.mapAs({ x: 10, value: 5 });

	    // map the data for the third series
	    var thirdSeriesData = dataSet.mapAs({ x: 10, value: 6 });

	    // map the data for the fourth series
	    var FourthSeriesData = dataSet.mapAs({ x: 10, value: 7 });

	    // map the data for the fifth series
	    var FifthSeriesData = dataSet.mapAs({ x: 10, value: 8 });

	    // create a column chart instance
	    var chart = anychart.bar();
	    // stack values on y scale.
	    chart.yScale().stackMode('value');

	    // a function to configure label, padding, and color settings for all series
	    var setupSeries = function (series, name, color, hoveredColor) {
	        series.name(name).stroke('2 #fff 1').fill(color);
	        series.hovered().stroke('1 #fff 1').fill(hoveredColor);
	    };

	    // store series
	    var series;

	    // create the first series with the mapped data
	    series = chart.bar(firstSeriesData);
	    setupSeries(series, 'Distributed', 'rgb(100, 181, 246)');

	    // create the second series with the mapped data
	    series = chart.bar(secondSeriesData);
	    setupSeries(series, 'Replied', 'rgb(25, 118, 210)');

	    // create the third series with the mapped data
	    series = chart.bar(thirdSeriesData);
	    setupSeries(series, 'Replied By P&C', 'rgb(239, 108, 0)');

	    // create the fourth series with the mapped data
	    series = chart.bar(FourthSeriesData);
	    setupSeries(series, 'Approved', 'rgb(255, 213, 79)');

	    // create the fifth series with the mapped data
	    series = chart.bar(FifthSeriesData);
	    setupSeries(series, 'Closed', 'rgb(69, 90, 100)');

	    // turn on the legend
	    chart.legend().enabled(true).fontSize(16).padding([10, 0, 0, 0]);

	    // set the union tooltip
	    chart.tooltip().displayMode('union');

	    // customize the toolttip
	    chart.tooltip().titleFormat(function() {
	        return this.x + ' - ' + this.points[0].getStat('categoryYSum');
	    });

	    chart.xAxis().labels().fontWeight('900').fontColor('black');
	    
	    // Customize the Y axis labels with font weight
	    chart.yAxis().labels().fontWeight('900').fontColor('black');

	    // set the chart title and adjust it	
	    chart.title('GROUP-WISE DAK COUNT');
	    chart.title().fontSize(20).fontColor('#4477CE').padding([5, 0, 0, 0]);
	    
	    // define zoom settings
	    chart.xZoom().setToPointsCount(10);

	    // enable and configure the scroller
	    chart.xScroller(true);
	    chart.xScroller().orientation("right");
	    chart.xScroller().thumbs(false);

	    // prevent the range changing
	    chart.xScroller().allowRangeChange(false); 

	    // set the container id for the chart
	    chart.container('GroupGraph');

	    // initiate chart drawing
	    chart.draw();
	}); 
 

</script>
</html>