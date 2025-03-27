<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.dms.DateTimeFormatUtil"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>eNote Print</title>
</head>  
<%
Object[] EnotePrint=(Object[])request.getAttribute("EnotePrint");
%>
<style type="text/css">
.break {
	page-break-after: always;
}


@page {
size: 790px 1050px;
margin-top: 49px;
margin-left: 72px;
margin-right: 39px;
margin-buttom: 49px;

@bottom-right {
	counter-increment: page;
			counter-reset: page 2;
	content: "Page "counter(page) " of "counter(pages);
	margin-bottom: 30px;
	margin-right: 10px;
}

	@top-right {
		content: "";
		margin-top: 30px;
		margin-right: 10px;
	}

	@top-left {
		margin-top: 30px;
		margin-left: 10px;
	
	}

	@top-center {
		margin-top: 30px;
		content: "";

	}

	@bottom-center {
		margin-bottom: 30px;
		font-size: 12px;
		content: "This is computer generated statement no signature required";
	}
}

p {
	text-align: justify;
	text-justify: inter-word;
}

body
{
	font-size:14px !important;
}

div
{
	width: 650px !important;
}
table{
	align: left;
	width: 650px !important;
	max-width: 650px !important;
	margin-top: 10px; 
	margin-bottom: 10px;
	margin-left:10px;
	border-collapse:collapse;
	
}
th,td
{
	text-align: left;
	border: 1px solid black;
	padding: 4px;
	word-break: break-word;
	overflow-wrap: anywhere;
	
	 -ms-word-break: break-all;
     word-break: break-all;

     /* Non standard for WebKit */
     word-break: break-word;

-webkit-hyphens: auto;
   -moz-hyphens: auto;
        hyphens: auto;
	
}
.center{

	text-align: center;
}

.right
{
	text-align: right;
}
input{
border-width: 0 0 1px 0;
width:80%;
}
input:focus {
  outline: none;
}

.text-blue
{
	color: blue;
	font-weight:500px;
	font-size: 15px;
}

</style>
<body>
<%
List<Object[]> EnotePrintDetails = (List<Object[]>)request.getAttribute("EnotePrintDetails");
List<Object[]> AttachmentData = (List<Object[]>)request.getAttribute("AttachmentData");
String empNo = (String)session.getAttribute("EmpNo");

SimpleDateFormat rdf= new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdtf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat rdtf= new SimpleDateFormat("dd-MM-yyyy hh:mm a");

Object[] ExternalNameData=(Object[])request.getAttribute("ExternalNameData");
String currentDateString = EnotePrint[4].toString();
LocalDate currentDate = LocalDate.parse(currentDateString); // Assuming DakEnotePrint[4] is a String in the format "yyyy-MM-dd"
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
String formattedDate = currentDate.format(formatter);
String path=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()+"/";
%>
<div class="center">
         
	<div style="width: 100%;border: 0;text-align: center;"><h3> <b style="font-size:18px;text-decoration:underline">Note&nbsp;:&nbsp;<%if(EnotePrint!=null && EnotePrint[2]!=null){%><%=EnotePrint[2].toString()%><%}else{%>-<%}%></b></h3></div>
	<br>
	<div style="width: 100%;border: 0;text-align: center;"> <span style="float: left;"><b style="font-size:18px; margin-left: 14px;">Ref No&nbsp; : &nbsp;<span style="color: blue; font-size: 16px;"><%if(EnotePrint!=null && EnotePrint[3]!=null){%><%=EnotePrint[3].toString()%><%}else{%>-<%}%></span></b></span><span style="float: right;"><b style="font-size:16px;">Date : &nbsp;<%=formattedDate%></b></span> </div>
	<br><br><br>
	<%if(EnotePrint[18]!=null && EnotePrint[18].toString().equalsIgnoreCase("N")) {%>
	<table style="border-collapse: collapse;">
	<tr>
	<td style="border: none; width: 20%; vertical-align: top;"><span style="font-size: 14px; color: blue;"><b style="margin-left:20px; color:black; ">Subject :</b></span></td>
	<td style="border: none; vertical-align: top;"><span style="font-size: 14px; color: blue;"><%if(EnotePrint!=null && EnotePrint[5]!=null){%><%=EnotePrint[5].toString()%><%}else{%>-<%}%></span></td>
	</tr>
	<tr>
	<!-- <td style="border: none; width: 20%; vertical-align: top;"><span style=" font-size: 14px; color: blue;"><b style="margin-left:20px; color: black;">Comment :</b></span></td> -->
	<td colspan="2" style="border: none; vertical-align: top;"><span style="font-size: 14px; color: blue; margin-left: 20px;"><%if(EnotePrint!=null && EnotePrint[6]!=null){%><%=EnotePrint[6].toString().replaceAll("\n", "<br>")%><%}else{%>-<%}%></span> </td>
	</tr>
	</table>
    <%}else{ %>
    <table style="border-collapse: collapse;">
	<tr>
	<td style="border: none; width: 20%;"><span style="font-size: 14px; color: blue;"><b style="margin-left:20px; color:black; ">Subject :</b></span></td>
	<td style="border: none;"><span style="font-size: 14px; color: blue;"><%if(EnotePrint!=null && EnotePrint[5]!=null){%><%=EnotePrint[5].toString()%><%}else{%>-<%}%></span></td>
	</tr>
	<tr>
	<!-- <td style="border: none; width: 20%;"><span style=" font-size: 14px; color: blue;"><b style="margin-left:20px; color: black;">Reply :</b></span></td> -->
	<td colspan="2" style="border: none; vertical-align: top;"><span style="font-size: 14px; color: blue; margin-left: 20px;"><%if(EnotePrint!=null && EnotePrint[17]!=null){%><%=EnotePrint[17].toString().replaceAll("\n", "<br>")%><%}else{%>-<%}%></span></td>
	</tr>
	</table>
    <%} %>
     <br><br><br><br><br>    
 <% if(EnotePrintDetails!=null && EnotePrintDetails.size()>0){
   for(Object[] ad :EnotePrintDetails) {
     if(ad[8].toString().equalsIgnoreCase("FWD")){%>
	<div align="right" style="">&nbsp;<span class="text-blue" style="font-size :16px;"><b><%=ad[2].toString().trim() %>, &nbsp; <%=ad[3].toString() %></b></span> </div>
	  <div align="right" style="font-size :12px;">[Forwarded On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	  <br>
<%}}}%>
<br><br><br><br>
       <% 
       if(EnotePrintDetails!=null && EnotePrintDetails.size()>0){
       for(Object[] ad :EnotePrintDetails) {
		if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RFD")){%>
		<div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
		<div align="left" style="margin-left:12px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Reforwarded On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	    <br><br><br>
		<%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RC1")){%>
		<div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
		<div align="left" style="margin-left:12px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;"> <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Recommended On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	    <br><br><br>
	   <%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RR1")){%>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	   <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim()%>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Returned On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	     <br><br><br>
	   <%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RC2")){ %>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	    <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Recommended On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	      <br><br><br>
	   <%}else if (ad[8]!=null && ad[8].toString().equalsIgnoreCase("RR2")){ %>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	    <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Returned On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	      <br><br><br>
	   <%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RC3")) {%>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	    <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Recommended On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	      <br><br><br><br>
	   <%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RR3")){ %>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	    <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Returned On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	      <br><br><br><br>
	   <%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RC4")) {%>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	    <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Recommended On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	      <br><br><br>
	   <%}else if (ad[8]!=null && ad[8].toString().equalsIgnoreCase("RR4")){%>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	    <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Returned On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	    <br><br><br>
	   <%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RC5")){ %>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	    <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Recommended On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
	      <br><br><br>
	   <%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RR5")){ %>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	    <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[Returned On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
		 <br><br><br><br>
	   <%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("EXT")){ %>
	   <div align="left" style="margin-left: 15px !important; font-size: 12px;"><p><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></p></div>
	    <div align="left" style="margin-left:15px !important;">&nbsp;<span class="text-blue" style="font-size :16px;"><%if(ExternalNameData[1]!=null){ %><%=ExternalNameData[1].toString() %><%} %></span> <span class="text-blue" style="font-size :14px;"><b><%if(ExternalNameData[0]!=null){%><%=ExternalNameData[0].toString() %><%} %></b></span> </div><br>
	    <div align="left" style="margin-left:15px !important;font-size :12px;">[External Recommended On :&nbsp;<span class="text-blue" style="font-size :12px;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %> </span>]</div>
		 <br><br><br><br>
		 
	   <%--  <br><div align="center" style="text-align:center;"> 
         <span style="font-weight: 600; font-size: 16px; color: green;">External Recommended</span><br>
         <span style="font-weight: 400; font-size: 12px; color: green;"><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></span><br>
         <span style="font-weight: 500; font-size: 14px; color: green;"><span class="text-blue"style="font-size :14px; color: green;" ><%if(ExternalNameData[1]!=null){ %><%=ExternalNameData[1].toString() %><%} %></span> <span class="text-blue" style="font-size :14px; color: green;">  <b><%if(ExternalNameData[0]!=null){%><%=ExternalNameData[0].toString() %><%} %></b></span></span><br>
		 <span style="font-weight: 400; font-size: 12px; color: green;">[Approved On :&nbsp;<span class="text-blue" style="font-size:12px; color: green;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) %></span>]</span>
         </div>
		 <br><br><br> --%>
		<%}	else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("APR")){%>
		<br><br>
         <div align="center" style="text-align:center;"> 
         <span style="font-weight: 600; font-size: 16px; color: green;">APPROVED</span><br>
         <span style="font-weight: 400; font-size: 12px; color: green;"><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></span><br><br>
         <span style="font-weight: 500; font-size: 14px; color: green;"><span class="text-blue" style="font-size :14px; color: green;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span></span><br><br>
		 <span style="font-weight: 400; font-size: 12px; color: green;">[Approved On :&nbsp;<span class="text-blue" style="font-size:12px; color: green;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %></span>]</span>
         </div>
		 <%}else if(ad[8]!=null && ad[8].toString().equalsIgnoreCase("RAP")){%>
		<br><br><br>
		<div align="center" style="text-align:center;"> 
        <span style="font-weight: 600; font-size: 16px; color: red;">RETURNED BY APPROVER</span><br>
        <span style="font-weight: 400; font-size: 12px; color: red;"><%if(ad[5]!=null){ %><%=ad[5].toString() %><%} %></span><br>
        <span style="font-weight: 500; font-size: 14px; color: red;"><span class="text-blue" style="color: red;" ><%if(!ad[1].toString().equalsIgnoreCase(ad[10].toString())){%><%if(ad[9]!=null){ %><%=ad[9].toString() %>-<%}} %></span> <span class="text-blue" style="font-size :14px; color: red;">  <b><%=ad[2].toString().trim() %>, &nbsp;<%=ad[3].toString() %></b></span></span><br><br>
		<span style="font-weight: 400; font-size: 12px; color: red;">[Returned On :&nbsp;<span class="text-blue" style="font-size:12px; color: red;"><%=DateTimeFormatUtil.SqlToRegularDate(ad[4].toString().substring(0, 10)) +" "+ad[4].toString().substring(11,19) %></span>]</span>
		</div> <br><br><br>
	<%}}}%>
	<br><br><br>
	<%if (AttachmentData != null && !AttachmentData.isEmpty()) { %>
	<div class="enoteDocuments" style="width: 100%;">
    <div class="row col-md-12">
        <div class="col-md-3" id="eNoteDocumentLabel" style="float: left !important;  text-align:left; margin-left: 10px;">
            <label><b>Documents :</b></label>
        </div>
        <div class="col-md-9 downloadDakMainReplyAttachTable" id="eNoteDocs" style="position: relative; float: left!important;  width: 100%;">
            <% 
                for (Object[] other : AttachmentData) {
                    String fileName = (String) other[3]; 
            %>
            <div align="left" style="margin-left: 100px; margin-top: -15px;">
           <%if(EnotePrint!=null && EnotePrint[18]!=null && EnotePrint[18].toString().equalsIgnoreCase("N")){ %>
            <a href="<%=path%>EnoteAttachmentDownload.htm?eNoteAttachId=<%=other[2] %>" title="Download">
			       <%=fileName %>
		     </a>
		     <%} %>
		     <%if(EnotePrint!=null && EnotePrint[18]!=null && EnotePrint[18].toString().equalsIgnoreCase("Y")){
		    	 if(EnotePrint!=null && EnotePrint[19]!=null && EnotePrint[19].toString().equalsIgnoreCase("M")){
		      %>
		    
            <a href="<%=path%>DakEnoteMarkerAttachmentDownload.htm?eNoteAttachId=<%=other[2] %>" title="Download">
			       <%=fileName %>
		     </a>
		     <%}else if(EnotePrint!=null && EnotePrint[19]!=null && EnotePrint[19].toString().equalsIgnoreCase("C")){ %>
            <a href="<%=path%>DakEnoteCaseWorkerAttachmentDownload.htm?eNoteAttachId=<%=other[2] %>" title="Download">
			       <%=fileName %>
		     </a>
		     <%}} %>
		     <br><br>
            </div><br>
            <%}}%>
        </div>
    </div>
</div>
</div>
</body>
</html>