<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<c:set var="contPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="dependancy.jsp"></jsp:include>
<title>DMS-LogIn</title>

<style type="text/css">

.loginpage #header {
 	/* background: rgba(6,103,200,1)  50% 0 no-repeat; */
 	background: rgb(0, 36, 121) ;
 }
 
article, aside, details, figcaption, figure, footer, header, hgroup, nav, section {
	display: block;
	box-sizing: border-box;
}
/*===========Usefull CSS===========*/
.clear {
	clear: both;
	display: block;
}
.clearfix {
 *zoom: 1;
}
.clearfix:before, .clearfix:after {
	display: table;
	line-height: 0;
	content: "";
}
.clearfix:after {
	clear: both;
}
.row:before, .row:after {
	display: table;
	line-height: 0;
	content: "";
}
.row:after {
	clear: both;
}
/* Global
----------------------------------*/
body {
	font-family: 'Open Sans', sans-serif;
	font-weight: 400;
	color: rgb(0, 36, 121);
	font-size: 15px;
	line-height: 18px;
	overflow-x: hidden;
	overflow-y: hidden;
}
body.home .header-wrapper {
	/* background: url("../view/bg3.jpg") 50% 0 no-repeat; */
 	background: rgb(0, 36, 121)  50% 0 no-repeat;
 }
body.inner .header-wrapper {
	background: rgb(0, 36, 121)  50% 0 no-repeat;
}
a {
	color: #0c99d5;
	outline: none;
	border: none;
}
a:focus {
	outline: none;
	border: none;
}
/* Guideline Frame
----------------------------------*/
.wrapper {
	position: relative;
	margin: 0 15px;
	padding: 0;
}
.wrapper:before, .wrapper:after {
	display: table;
	line-height: 0;
	content: "";
}
.wrapper:after {
	clear: both;
}
.container:before, .container:after {
	display: table;
	line-height: 0;
	content: "";
}
.container:after {
	clear: both;
}
.container {
	position: relative;
	margin: 0 auto;
	display: block;

}
.widget-guide {
	position: relative;
	margin: 0 auto;
	display: block;
	max-width: 1180px;
	/*max-width: 1170px;*/
	width: 100%;
}
.widget-guide:before, .widget-guide:after {
	display: table;
	line-height: 0;
	content: "";
}
.widget-guide:after {
	clear: both;
}

.btmhead {
	background: none;
	/*height: 135px;*/
	margin: 15px 0 0px;
}
.btmhead:before, .btmhead:after {
	display: table;
	line-height: 0;
	content: "";
}
.btmhead:after {
	clear: both;
}

.header-right {
	float: left;
	width: 111px;
	height: 30px;
	display: block;
	outline: none;
}
.float-element {
	float: left;
	clear: both;
	display: block;
	margin: 23px 0 18px;
	width: 100%;
	text-align: right;
}

.header-right .float-element a:focus {
	outline: none;
}

.header-right .float-element a:focus {
	outline: none;
}
.drdologo{

	width:82%;
	margin-right: -56%;
	margin-top: -16%;
	/* box-shadow: 2px 2px 8px rgb(0 0 0 / 70%);
    border-radius: 50%; */
}

/*Logo*/

.logo {
	background:  no-repeat 10px 0;
	float: left;
	font-size: 214%;
	line-height: 93%;
	font-weight: 700;
	min-height: 100px;
	padding: 21px 0 0 86px;
	color: rgba(255,255,255,1);
	text-transform: uppercase;
	font-family: 'Montserrat', sans-serif;
}
.logo a {
	color: rgba(255,255,255,1);
	display: block;
	text-align: left;
	font-style: normal;
	font-weight: 700;
	font-size: 74%;
}
.logo a:focus,
.logo a:hover {
	color: rgba(124,199,252,1);
	outline: none;
}
.logo a span {
	display: block;
	font-style: normal;
	font-weight: 800;
	font-size: 135%;
	margin-top: 5%;
	font-family: Montserrat,'sans-seriff' !important;
}

.login-container{
		background-color: transparent;
	}
	
	

/* ********************************************************** Login CSS ***********************************************************************/

	.header-container{
		background-color: transparent;
	}
	
	.drdo-writing{
		font-size: 1.5rem;
		font-weight: bolder;
		color: #02b0de;
  		font-family:'Montserrat', sans-serif;
	}

	.login-container{
		background-color: transparent;
	}
	
	.quote{
		font-weight: 500 !important;
		color: #3ea5d0!important;
		font-size: 16px;
		font-family:  Monospace;
	}
	
	.login-form-wrapper{
		border-radius: 8px;
	}
	
	.form-group {
    margin-bottom: 1.9rem !important;
	}
	
	/* .btn-primary {
    color: #fff;
    background: #3ea5d0 linear-gradient(180deg,#5bb3d7,#3ea5d0) repeat-x;
    border-color: #3ea5d0;
	} */
	
	 
	 .fa {
  		top: 17px;
 		 right: 1rem;
	}

	.form-group a i {
  		font-family: FontAwesome;
  		margin: 0 auto;
 	 	font-size: 5rem;
  		font-style: normal;
	}


	@media screen and (max-width:900px){
		
		.login-form-wrapper{
			margin-left: -132px;
		}
		.welcome{
			margin-left: -125px;
		}
		body{
			background-repeat: repeat !important;
		}
		.footer-writing{
			margin-left: 0px !important;
		}
	}
	
	@media screen and (max-width:1000px){
	
		.login-form-wrapper{
			margin-left: -132px;
		}
		.welcome{
			margin-left: -125px;
		}
	}
	
	@media screen and (max-width:1100px){
	

		.quote2{
			font-size: 20px !important;	
		}
		.nav-link{
			font-size: 12px !important;
		}	
	}



.loginpage #header {
 	/* background: rgba(6,103,200,1)  50% 0 no-repeat; */
 	background:  rgb(0, 36, 121); ;
 }

/* Media Query for Marquee */

@media screen and (max-width: 1350px) and (min-width:100px)  {
    .arrowdiv img {
        display:none;
    }	
}
@media screen and (max-width: 1350px) and (min-width: 100px){
    .whatsnew {
       display:none !important;
       
    }	
    .dot{
    	display: inline-block !important;
    	
    }
    .rectangle{
    	display:none;
    }
    
    .marquee span{
    padding: 0px !important ;
    }
    
    .hm-compliant-manual{
    	height:45px;
    }
}

@media screen and (max-width: 1370px) and (min-width:100px) {
    
  /*   .img-fluid{
 		max-width: 65% !important;   
    } */
    
    .login-form-wrapper{
    	padding-top: 0px !important;
    	padding-bottom: 24px !important;
    }
    
    .support-row{
    	padding: 16px 0px !important;
    }
  
  	.welcome{
  		display: none!important;
  	}
  	
  
}


@media screen and (min-width:1370px){
	
	.img-fluid{
		max-width: 100% !important;
		margin-left:-23%;
	}
}

/* Hover Shadow */


.grid img{
	width:50%;
	margin-top:10%;
	margin-left:20%;
}

.raise:hover,
.raise:focus {
  box-shadow: 0 0.5em 0.5em -0.4em var(--hover);
  transform: translateY(-0.25em);
  
}



.img_container {
  display: flex;
  width: 100%;
  box-sizing: border-box;
  height: 25vh;
  
}

.box {
  flex: 1;
  overflow: hidden;
  transition: .5s;
  line-height: 0;
}

.box > img {
  width: 200%;
  height: calc(100% - 10vh);
  object-fit: cover; 
  transition: .5s;
}

.box > span {
  font-size: 3.8vh;
  display: block;
  text-align: center;
  height: 10vh;
  line-height: 2.6;
}

.box:hover { flex: 1 1 4%; }
.box:hover > img {
  width: 40%;
  height: 40%;
}
 
 /* Carousel Slides */
 
 .slide1{
 	width:40% !important;
 	margin-left: 33%;
 }
 
 .slide3{
 	width:80% !important;
 	margin-left: 10%;
 }
 
  .slide4{
 	width:70% !important;
 	margin-left: 15%;
 	
 }
 
 .flex-pauseplay a {
  display: block;
  width: 35px;
  height: 35px;
  line-height:35px;
  position: absolute;
  text-align:center;
  bottom: 5px;
  left: 10px;
  opacity: 0.8;
  z-index: 10;
  overflow: hidden;
  cursor: pointer;
  color: #000;
  border-radius:3px;
}
.flex-pauseplay a:before {
  font-family: "FontAwesome";
  font-size: 20px;
  display: inline-block;
  content: '\f04c';
}
.flex-pauseplay a:hover {
  opacity: 1;
}
.flex-pauseplay a.flex-play:before {
  content: '\f04b ';
}
.flex-nav-next{
	display: hidden;
}


.marquee {
  height: 30px;
  width: 96%;
  overflow: hidden;
  position: relative;
  color:white;
  font-family: 'Lato', sans-serif;
}

.marquee div {
  display: block;
  width: 200%;
  height: 30px;
  position: absolute;
  overflow: hidden;
  animation: marquee 10s linear infinite;
}

.marquee span {
  float: left;
  width: 50%;
  padding:10px;
}

@keyframes marquee {
  0% { left: 0; }
  100% { left: -100%; }
}


.rectangle {
  height: 40px;
  width: 100px;
  background-color:  rgb(0, 36, 121);;
  color:rgba(6,103,200,1);
  padding-top:10px;
  padding-right:15px;
  font-family: 'Montserrat', sans-serif;
  font-weight: 800;
}

.arrow {
  border: solid black;
  border-width: 0 3px 3px 0;
  display: inline-block;
  padding: 3px;
}

.right {
  transform: rotate(-45deg);
  -webkit-transform: rotate(-45deg);
}	
.arrowlogo{
	width:69%;
}
.whatsnew{
	padding-left: 19%;
    padding-top: 8%;
    font-family: 'Montserrat', sans-serif;
    font-weight: 800;
    font-size: 18px;
    color: orange;
  
}
.arrowdiv{
	margin-left: -20px;
}


/* Buttons nav */

.nav-link {	
	color:white;
	font-family: 'Montserrat',sans-serif;
	font-weight: 600;
}

.justify-content-end{
	margin-right: 7%;
}

.nav-tabs{
	border-bottom: 0px solid white !important;
}
	
	.support-row {
	clear: both;
	overflow: hidden;
	display: block;
	padding: 35px 0;
	margin: 0;
	/* background: rgba(6,127,208,1); */
	background: #08293c ;
	font-family: 'Open Sans';
	/* color: rgba(255,255,255,1); */
}

#footer {
	background-color: rgba(86,86,86,1);
	clear: both;
	overflow: hidden;
	padding-bottom:3px;
	margin: 0;
}

.nav-link:hover{
	color: black !important;
}

.copyright-content{
	text-align: center;
    color: white;
    padding: 23px 0px 0px 0px;
}

.copyright-content p{
	font-size: 12px !important;
}

@media screen and (min-height:850px){
	.img-fluid{
		max-width: 135% !important;
		margin-left: -20%;
	}
	.login-main-container{
		margin-top: 8rem !important;
	}
}

@media screen and (min-height:950px){
	.img-fluid{
		max-width: 145% !important;
		margin-left: -20%;
	}
	.product-banner-container{
		margin-top: 5rem !important;
	}
	
	.login-main-container{
		margin-top: 10rem !important;
	}
}

 body{
 background-image: url("view/images/bg3.jpg");
 background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  background-attachment: fixed;
 opacity: 1.0;
}
/* body{
background:none;
} */
.marquee-container {
            width: 100%; /* Set the width as needed */
            overflow: hidden; /* Hide any overflowing content */
}
</style>

</head>

<body style="background-color: rgb(0, 36, 121);">
<%String version= (String)request.getAttribute("version");
String ContactNo=(String)request.getAttribute("ContactNo");
%>
<%if(version!=null && version.equalsIgnoreCase("yes")){ %>
 <!-- Button trigger modal -->
<button type="button"  class="btn btn-primary" style="display:none;" data-toggle="modal" data-target="#staticBackdrop" id = "versionerror">
</button>
<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered  modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title " style="color: red;"  id="staticBackdropLabel">Version Mismatch</h5>
      </div>
      <div class="modal-body center" >
      <p class="center" style="font-weight: 700;" id="version"></p>
       
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-primary" data-dismiss="modal">Still want to continue</button>
      </div>
    </div>
  </div>
</div>
 <%} %>
<section class="loginpage" style="background-color: #08293c;">
  
	<header id="header" class="clearfix" style="margin-left: 15%; background-color:#08293c;">
 
	
  		<div class="btmhead clearfix" style="background-color:#08293c !important;">
    		<div class="widget-guide clearfix" style="background-color: #08293c !important;">
      			<div class="header-right clearfix" style="background-color: #08293c !important;">
        			<div class="float-element" style="background-color: #08293c !important; ">
        				<a class="" href="" target="_blank">
        					<img style="margin-top: -27px;" class ="drdologo " src="view/images/drdologo.png" alt=""></a>
        			</div>
      			</div>
     			<div class="logo" 	>
     				<font class="c"  style="margin-top: 5% !important;font-size: 85% !important;  ">DAK MANAGEMENT SYSTEM (DMS)</font>
     			</div>
    		</div>

  		</div>
  		
  		
  				<!-- <ul class="nav nav-tabs justify-content-end ">
					  <li class="nav-item"  onclick="$('#footer').show();">
						 <a class="nav-link active" data-toggle="tab" href="#tab-1" role="tab" ><i class="fa fa-home" aria-hidden="true"></i>&nbsp;Home</a>
					  </li> 

				</ul> -->
				
  		
	</header>
 </section> <br>
	<div class="container-fluid" style="">
		<div class="row">
		 <div align="center" class="col-md-4"style=" margin-top: 50px;"> 
		
		<div class="product-banner-container" align="center" style="margin-top:45px">
									<img class="img-fluid img-responsive" width="100%;" src="view/images/mail.png" style="">
								</div></div> 
								<div class="col-md-1">
								</div>
		<!-- <div class="col-md-2">
		<div class="col-md-12 float-right align-middle" style="margin-top: 5rem;  ">
					<div class="card" style="padding: 20px;box-shadow: -2px 2px 2px black; background-color: white; background: transparent; height:53vh; width: 170%;">
					  <div class="modal-header" style="max-height:55px;">
					  <h5>SMS Abbreviation</h5>
					  </div>
					  <div><br>
					  <span style="font-size: 1rem; line-height: 2rem;">
					  DAK SMS will be sent every morning at 7:30 AM.
					  </span></div><br>
					  <div >
					  <h5>P : Total Dak Pending </h5>
					  </div><br>
					  <div >
					  <h5>U : Total Dak Urgent </h5>
					  </div><br>
					  <div >
					  <h5>T : ToDay Dak Pending </h5>
					  </div><br>
					  <div >
					  <h5>D : Total Dak Delay </h5>
					  </div><br>
					</div>
					</div>
		</div> -->
			<div class="col-md-6 " >
			<div class="col-md-6 float-right align-middle" style="margin-top: 5rem;  ">
					<div class="card" style="padding: 20px;box-shadow: -2px 2px 2px black; background-color: white; background: transparent; height: 53vh; ">
						<div align="center" >
							<h2 class="heading-section " style="color: #08293c;" ><img alt="DMS" src="view/images/dms.png">DMS</h2>
						</div>
						<br>
						<div align="center" >	
							<form action="${contPath}/login" autocomplete="off" method="post" >
							
								<div class="form-group">
									<input type="text" class="form-control"  name="username" placeholder="Username" style="background: transparent;" required="required">
								</div>
								<br>
								<div class="form-group">
									<input type="password" class="form-control" name="password" style="background: transparent;" placeholder="Password" required="required">
								</div>
								<br>
								<span style="font-family: 'Lato', sans-serif;font-size: 15px;color:red;margin-bottom: 10px;" id="success-alert">${error}</span>
													<span style="font-family: 'Lato', sans-serif;font-size: 15px;color:green;margin-bottom: 10px;" id="success-alert">${message}</span>
								<div class="form-group ">
									<button type="submit" class="form-control btn btn-primary submit  " onmouseover ="this.style.backgroundColor = '#134d61' " onmouseout ="this.style.backgroundColor = '#08293c' "  style="border-radius: 20px; background-color: #08293c; colo border-color:#980F5A " ><b>Login</b></button>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								</div>						
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>	
		<div class="credentials-info-container" style="margin-top: 50px;margin-bottom: -6px">
	    	<%
	        	boolean expstatus = (boolean)request.getAttribute("expstatus");
	       		if(!expstatus) {%>
					<marquee  class="news-scroll" behavior="scroll" direction="left" scrollamount="7" onmouseover="this.stop();" onmouseout="this.start();" style="color: red;font-weight: bold;">Your License has been Expired..!</marquee>
			<%} %>
			<!-- <marquee  class="news-scroll" behavior="scroll" direction="left" scrollamount="7" onmouseover="this.stop();" onmouseout="this.start();" style="color: red;font-weight: bold;">Please ensure the Work Register details for January 2025 are filled in by 10 February 2025. Kindly disregard if it has already been completed.</marquee> -->
		</div>		
	</div><br>
 <div id="footer">
	<footer class="footer"  >
	    <section id="fontSize" class="clearfix" style="font-size: 100%;">
		  <section id="page" class="body-wrapper clearfix" style="">
		    <div class="support-row clearfix" id="swapper-border" style="">
		    <div class="marquee-container" onmouseover="stopMarquee()" onmouseout="startMarquee()">
        <marquee behavior="scroll" direction="left" scrollamount="10" id="marquee">
            <p style="font-size: 22px; color: white;">SMS Abbreviation  :  DAK SMS will be sent every morning at 7:30 AM  ,  P : Total Dak Pending,  U : Total Dak Urgent,  T : ToDay Dak Pending  and  D : Total Dak Delay </p>
        </marquee>
    </div>
		      	<div class="widget-guide clearfix">
		        </div>
		    </div> 
		    	
		  </section> 
		</section>
		<div class="widget-guide clearfix"  style="height:4rem !important; ">
       		<div class="footr-rt" >
            	<div class="copyright-content" > 
            	 <span style="float: left !important; font-size: 15px;">For Any Queries Please Contact : <%=ContactNo %></span>
            		<p ><b style="font-size: 15px;">Site best viewed at 1360 x 768 resolution in I.E 11+, Mozilla 70+, Google Chrome 79+</b>	</p> 
            	</div>
    		</div>
  		</div>
	</footer>
	</div> 

</body>
<script>
var vers="<%=version%>";
if(vers!=null && vers==='yes'){
document.getElementById("versionerror").click();
const paragraphElement = document.getElementById("version");
const originalText = paragraphElement.textContent; // Store original text for backup

// Choose the new word:
const replacementWord = "<%= request.getAttribute("browser")%>";

paragraphElement.innerHTML="<b>Your current Browser version is not supported.<br><br>Please ensure optimal viewing by using Internet Explorer (I.E) or Microsoft Edge 110+,<br> Mozilla 110+, or Google Chrome 110+.</b><br><br><b>Site Best viewed at a resolution of 1360 x 768.</b><br><br><b style=\"color: green;\">Thank You!</b>"
console.log("browser name: "+replacementWord);
console.log(replacementWord+" version: "+"<%= request.getAttribute("versionint") %>");
}
</script>
 <script>
    $(document).ready(function() {
        setInterval(function() {
            var docHeight = $(window).height();
            var footerHeight = $('#footer').height();
            var footerTop = $('#footer').position().top + footerHeight;
            var marginTop = (docHeight - footerTop + 10);

            $('.scrollpolicy').css('max-height', docHeight-155+ 'px' )
            
            if (footerTop < docHeight)
                $('#footer').css('margin-top', marginTop + 'px'); // padding of 30 on footer
            else
                $('#footer').css('margin-top', '0px');
            // console.log("docheight: " + docHeight + "\n" + "footerheight: " + footerHeight + "\n" + "footertop: " + footerTop + "\n" + "new docheight: " + $(window).height() + "\n" + "margintop: " + marginTop);
        }, 250);
    }); 
</script>

<script>
        var marquee = document.getElementById('marquee');

        function stopMarquee() {
            marquee.stop();
        }

        function startMarquee() {
            marquee.start();
        }
    </script>
</html>