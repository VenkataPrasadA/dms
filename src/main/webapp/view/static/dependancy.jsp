<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!-- ----------  jquery  ---------- -->
<script src="./webjars/jquery/3.4.0/jquery.min.js"></script>

<!--BootStrap Bundle JS  -->
<script src="./webjars/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>

<!--BootStrap CSS  -->
<link rel="stylesheet" href="./webjars/bootstrap/4.0.0/css/bootstrap.min.css" />

<!-- Font Awesome 4.7 -->
<link rel="stylesheet" href="./webjars/font-awesome/4.7.0/css/font-awesome.min.css" /> 

<!-- Font Awesome 6.0 -->
<spring:url value="/webresources/fontawesome/css/all.css" var="fontawesome" />     
<link href="${fontawesome}" rel="stylesheet" />

<!-- MomentJs -->
<spring:url value="/webresources/js/moment.min.js" var="jquerymomentjs" />
<script src="${jquerymomentjs}"></script>

<!-- Master.js -->
<spring:url value="/webresources/js/master.js" var="masterjs" />
<script src="${masterjs}"></script>

<%-- <!--Modal Drag.js  -->
<spring:url value="/webresources/js/jquery-ui.js" var="modaldragjs" />
<script src="${modaldragjs}"></script>

<!--Modal Drag.js  -->
<spring:url value="/webresources/js/jquery-ui.min.js" var="modaldragminjs" />
<script src="${modaldragminjs}"></script> --%>

<!-- Select2 -->
<spring:url value="/webresources/bootstrap-select.min.css" var="select2Css" />
<link href="${select2Css}" rel="stylesheet" />

<spring:url value="/webresources/bootstrap-select.min.js" var="select2js" />
<script src="${select2js}"></script>

<!-- DataTables -->
<spring:url value="/webresources/dataTables.bootstrap4.min.css" var="DataTableCss" />
<link href="${DataTableCss}" rel="stylesheet" />

<spring:url value="/webresources/jquery.dataTables.min.js" var="DataTableJjs" />
<script src="${DataTableJjs}"></script> 

<spring:url value="/webresources/dataTables.bootstrap4.min.js" var="DataTablejs" />
<script src="${DataTablejs}"></script>

<!-- Date Range Picker -->
<spring:url value="/webresources/daterangepicker.min.js" var="daterangepickerjs" /> 
<script src="${daterangepickerjs}"></script>  

<spring:url value="/webresources/daterangepicker.min.css" var="daterangepickerCss" />   
<link href="${daterangepickerCss}" rel="stylesheet" />


<!-- Excess -->

<%-- <spring:url value="/webresources/css/jquery-confirm.min.css" var="jqueryconfirmcss" />
<link href="${jqueryconfirmcss}" rel="stylesheet" />

<spring:url value="/webresources/js/jquery-confirm.min.js" var="jqueryconfirmjs" />
<script src="${jqueryconfirmjs}"></script>


<spring:url value="/webresources/bootstrap-datepicker.min.css" var="DatepickerCss" />
<link href="${DatepickerCss}" rel="stylesheet" />

<spring:url value="/webresources/bootstrap-datepicker.min.js" var="Datepickerjs" />
<script src="${Datepickerjs}"></script> 
 
<spring:url value="/webresources/moment.min.js" var="momentjs" />  
<script src="${momentjs}"></script> 
         
<spring:url value="/webresources/bootbox.all.min.js" var="bootboxjs" /> 
<script src="${bootboxjs}"></script>
         
<spring:url value="/webresources/bootstrap-toggle.min.css" var="ToggleCss" />
<link href="${ToggleCss}" rel="stylesheet" />
     
<spring:url value="/webresources/bootstrap-toggle.min.js" var="Togglejs" /> --%>






</head>
</html>