<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
	String lablogo=(String)request.getAttribute("lablogo");
%>
<table style="width: 100%;">
	<tr>
		<td style="width: 39%;font-size: 14px;line-height: 17px;">
			<span style="color: blue;">इलेक्ट्रॉनिक्स तथा रेडार विकास स्थापना</span> <br>
			<span>भारत सरकार - रक्षा मंत्रालय </span> <br>
			<span>रक्षा अनुसंधान तथा विकास संगठन</span> <br>
			<span>सी. वी. रामन नगर</span> <br>
			<span>बेंगलूर - <span style="font-size: 13px;">560093</span>, भारत</span> <br><br><br><br>
			 
			
		</td>
		<td style="width: 20%;text-align: center">
			<div style="font-size: 40px;font-style: italic;">
				<img style="width: 100px; height: 100px;margin-left: -50px;" <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuraton"<%}else{ %> alt="File Not Found" <%} %>>
			</div><br>
			<span style="font-size: 11px;color: red;margin-left: -50px;display: block;">आई एस ओ 9001-2015 प्रमाणित</span> <br>
			<span style="font-size: 15px;color: red;margin-left: -50px;margin-top:-10px; display: block;">ISO 9001:2015 Certified</span>
		</td>
		<td style="width: 41%;margin-left: 10px;line-height: 15px;">
		<br> <br>  
			<span style="font-weight: bold;color: blue;">Electronics & Radar Development Establishment</span> <br>
			<span style="font-size: 13px;font-weight: 500 !important;">Govt of India, Ministry of Defence</span> <br>
			<span style="font-size: 13px;">Defence Research & Development Organisation</span> <br>
			<span style="font-size: 13px;">P.B. No: 9324, C V Raman Nagar</span> <br>
			<span style="font-size: 13px;">Bengaluru - 560 093. India</span> <br>
			<span style="font-size: 13px;">Fax <span style="margin-left: 25px;">:</span> 080-2524 2916</span> <br>
			<span style="font-size: 13px;">Phone <span style="margin-left: 12px;">:</span> 080-2524 3873</span> <br>
			<span style="font-size: 13px;">E-Mail <span style="margin-left: 8px;">:</span> director.lrde@gov.in</span><br><br><br>
		</td>
	</tr>
</table>
</body>
</html>