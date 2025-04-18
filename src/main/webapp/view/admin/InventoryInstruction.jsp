<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inventory Instruction</title>
<style type="text/css">

/* reset */
html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,dl,dt,dd,ol,nav ul,nav li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,embed,figure,figcaption,footer,header,hgroup,menu,nav,output,ruby,section,summary,time,mark,audio,video{margin:0;padding:0;border:0;font-size:100%;font:inherit;vertical-align:baseline;}
article, aside, details, figcaption, figure,footer, header, hgroup, menu, nav, section {display: block;}
ol,ul{list-style:none;margin:0px;padding:0px;}
blockquote,q{quotes:none;}
blockquote:before,blockquote:after,q:before,q:after{content:'';content:none;}
table{border-collapse:collapse;border-spacing:0;}
/* start editing from here */
a{text-decoration:none;}
.txt-rt{text-align:right;}/* text align right */
.txt-lt{text-align:left;}/* text align left */
.txt-center{text-align:center;}/* text align center */
.float-rt{float:right;}/* float right */
.float-lt{float:left;}/* float left */
.clear{clear:both;}/* clear float */
.pos-relative{position:relative;}/* Position Relative */
.pos-absolute{position:absolute;}/* Position Absolute */
.vertical-base{	vertical-align:baseline;}/* vertical align baseline */
.vertical-top{	vertical-align:top;}/* vertical align top */
.underline{	padding-bottom:5px;	border-bottom: 1px solid #eee; margin:0 0 20px 0;}/* Add 5px bottom padding and a underline */
nav.vertical ul li{	display:block;}/* vertical menu */
nav.horizontal ul li{	display: inline-block;}/* horizontal menu */
img{max-width:100%;}
/*end reset*
 */
body{
	background: url(view/images/Error/bg1.png);
	font-family: "Century Gothic",Arial, Helvetica, sans-serif;
	}
.content p{
	margin: 18px 0px 45px 0px;
}
.content p{
	font-family: "Century Gothic";
	font-size:2em;
	color:#666;
	text-align:center;
}
.content p span,.logo h1 a{
	color:#e54040;
}
.content{
	text-align:center;
	padding:115px 0px 0px 0px;
}
.content a{
	color:#fff;
	font-family: "Century Gothic";
	background: #666666; /* Old browsers */
	background: -moz-linear-gradient(top,  #666666 0%, #666666 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#666666), color-stop(100%,#666666)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #666666 0%,#666666 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #666666 0%,#666666 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #666666 0%,#666666 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #666666 0%,#666666 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#666666', endColorstr='#666666',GradientType=0 ); /* IE6-9 */
	padding: 15px 20px;
	border-radius: 1em;
}
.content a:hover{
	color:#e54040;
}
.logo{
	text-align:center;
	-webkit-box-shadow: 0 8px 6px -6px rgb(97, 97, 97);
	-moz-box-shadow: 0 8px 6px -6px  rgb(97, 97, 97);
	box-shadow: 0 8px 6px -6px  rgb(97, 97, 97);
}
.logo h1{
	font-size:2em;
	font-family: "Century Gothic";
	background: #666666; /* Old browsers */
	background: -moz-linear-gradient(top,  #666666 0%, #666666 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#666666), color-stop(100%,#666666)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #666666 0%,#666666 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #666666 0%,#666666 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #666666 0%,#666666 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #666666 0%,#666666 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#666666', endColorstr='#666666',GradientType=0 ); /* IE6-9 */	
	padding: 10px 10px 18px 10px;
}
.logo h1 a{
	font-size:1em;
}
.copy-right{
	padding-top:20px;
}
.copy-right p{
	font-size:0.9em;
}
.copy-right p a{
	background:none;
	color:#e54040;
	padding:0px 0px 5px 0px;
	font-size:0.9em;
}
.copy-right p a:hover{
	color:#666;
}
/*------responive-design--------*/
@media screen and (max-width: 1366px)	{
	.content {
		padding: 58px 0px 0px 0px;
	}
}
@media screen and (max-width:1280px)	{
	.content {
		padding: 58px 0px 0px 0px;
	}
}
@media screen and (max-width:1024px)	{
	.content {
		padding: 58px 0px 0px 0px;
	}
	.content p {
		font-size: 1.5em;
	}
	.copy-right p{
		font-size:0.9em;
	}
}
@media screen and (max-width:640px)	{
	.content {
		padding: 58px 0px 0px 0px;
	}
	.content p {
		font-size: 1.3em;
	}
	.copy-right p{
		font-size:0.9em;
	}
}
@media screen and (max-width:460px)	{
	.content {
		padding:20px 0px 0px 0px;
		margin:0px 12px;
	}
	.content p {
		font-size:0.9em;
	}
	.copy-right p{
		font-size:0.8em;
	}
}
@media screen and (max-width:320px)	{
	.content {
		padding:30px 0px 0px 0px;
		margin:0px 12px;
	}
	.content a {
		padding:10px 15px;
		font-size:0.8em;
	}
	.content p {
		margin: 18px 0px 22px 0px;
	}
}

</style>
</head>
<body>
  <!--start-wrap---> 
  <div class="wrap"> 
   <!--start-header----> 
   <div class="header"> 
    <div class="logo"> 
     <h1><a href="#">Ohh</a></h1> 
    </div> 
   </div> 
   <!--End-header----> 
   <!--start-content------> 
   <div class="content"> 
    <img src="view/images/Error/error-img.png" title="error" /> 
    <p><span><label>O</label>hh.....</span>You Requested the page that is Coming Soon.</p> 
    <a href="<%=request.getContextPath()%>">Back To Home</a> 
    <div class="copy-right"> 
     <p>&copy; <script type="text/javascript">
  document.write(new Date().getFullYear());
</script> Ohh. All Rights Reserved | Design by </p> 
    </div> 
   </div> 
   <!--End-Cotent------> 
  </div> 
</body>
</html>