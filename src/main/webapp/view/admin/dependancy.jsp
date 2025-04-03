<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!--JQUERY JS  -->
<script src="./webjars/jquery/3.6.0/jquery.min.js"></script>

<!--BootStrap Bundle JS  -->
<script src="./webjars/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>

<!--BootStrap JS  -->
<script src="./webjars/bootstrap/4.0.0/js/*.js"></script>

<!--BootStrap CSS  -->
<link rel="stylesheet" href="./webjars/bootstrap/4.0.0/css/bootstrap.min.css" />

<link rel="stylesheet" href="./webjars/font-awesome/4.7.0/css/font-awesome.min.css" />



<spring:url value="/resources/css/jquery-confirm.min.css" var="jqueryconfirmcss" />
<link href="${jqueryconfirmcss}" rel="stylesheet" />
<spring:url value="/resources/js/jquery-confirm.min.js" var="jqueryconfirmjs" />
<script src="${jqueryconfirmjs}"></script>
<spring:url value="/resources/dataTables.bootstrap4.min.css" var="DataTableCss" />
     <spring:url value="/resources/jquery.dataTables.min.js" var="DataTableJjs" />    
     <spring:url value="/resources/dataTables.bootstrap4.min.js" var="DataTablejs" />    
 <spring:url value="/resources/bootstrap-select.min.css" var="select2Css" />
     <spring:url value="/resources/bootstrap-select.min.js" var="select2js" />
     <!--DATE PICKER -->
     <spring:url value="/resources/bootstrap-datepicker.min.css" var="DatepickerCss" />
     <spring:url value="/resources/bootstrap-datepicker.min.js" var="Datepickerjs" />
   
     <spring:url value="/resources/daterangepicker.min.js" var="daterangepickerjs" />  
    <spring:url value="/resources/daterangepicker.min.css" var="daterangepickerCss" />     
     <spring:url value="/resources/moment.min.js" var="momentjs" />  
         <spring:url value="/resources/bootbox.all.min.js" var="bootboxjs" /> 
         
         <spring:url value="/resources/bootstrap-toggle.min.css" var="ToggleCss" />
         <link href="${ToggleCss}" rel="stylesheet" />
     <spring:url value="/resources/bootstrap-toggle.min.js" var="Togglejs" />
   <link href="${DatepickerCss}" rel="stylesheet" />
          <script src="${Togglejs}"></script> 
         
         
     <!-- Add font.css dependancy -->
<%-- <spring:url value="/resources/css/font.css" var="FontCss" /> --%>

      <%-- <spring:url value="/resources/normalize.css" var="normalizeCss" /> --%>
      <link href="${DatepickerCss}" rel="stylesheet" />
          <script src="${Datepickerjs}"></script> 
            <script src="${momentjs}"></script> 
                   <script src="${daterangepickerjs}"></script> 
          <link href="${daterangepickerCss}" rel="stylesheet" />
      <link href="${DataTableCss}" rel="stylesheet" />
          <script src="${DataTableJjs}"></script>
          <script src="${DataTablejs}"></script>
           <link href="${select2Css}" rel="stylesheet" />
          <script src="${select2js}"></script>
           <script src="${bootboxjs}"></script>
        <%--   <link href="${FontCss}" rel="stylesheet" /> --%>
             <%--   <link href="${normalizeCss}" rel="stylesheet" /> --%>


  <spring:url value="/resources/js/jquery.canvasjs.min.js" var="fbegraph" />
<script src="${fbegraph}"></script>
<spring:url value="/resources/js/highcharts.js" var="highcharts" />
<script src="${highcharts}"></script>
<spring:url value="/resources/js/exporting.js" var="exporting" />
<script src="${exporting}"></script>
<spring:url value="/resources/js/export-data.js" var="export" />
<script src="${export}"></script>

</head>

</html>