<%@page import="com.vts.dms.dak.model.DakMailSentAttach"%>
<%@page import="com.vts.dms.dak.model.DakMailSent"%>
<%@page import="jakarta.mail.internet.MimeMultipart"%>
<%@page import="jakarta.mail.BodyPart"%>
<%@page import="jakarta.mail.internet.ContentType"%>
<%@page import="jakarta.mail.MessagingException"%>
<%@page import="com.vts.dms.dak.dto.MailDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>Sent Mail</title>

<style>
div.dropdown-menu.open
    {
        max-height: 410px !important;
        overflow: hidden;
    }
    ul.dropdown-menu.inner
    {
        max-height: 410px !important;
        overflow-y: auto;
    }
  
.bootstrap-select   .filter-option {

    width: 530px !important;
    height: 230px !important;
    white-space: pre-wrap;
  
}
.bootstrap-select  .dropdown-toggle{
 width: 330px !important;
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
.spinner {
    position: fixed;
    top: 40%;
    left: 25%;
    margin-left: -50px; /* half width of the spinner gif */
    margin-top: -50px; /* half height of the spinner gif */
    text-align:center;
    z-index:1234;
    overflow: auto;
    width: 1000px; /* width of the spinner gif */
    height: 1020px; /*hight of the spinner gif +2px to fix IE8 issue */
}
.modal-dialog {
    max-width:750px;
    margin: 2rem auto;
    font: black;
}
</style>

</head>
<body>

			
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">INTRANET SENT MAIL LIST</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">Intranet Sent Mail  List </li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");

	if(ses1!=null){
	%><center>
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></center>
                    <%} %>
                    
<%  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<DakMailSent> mailAll= (List<DakMailSent>) request.getAttribute("SentList");
String dt=(String)request.getAttribute("dt");
%>
		<div id="spinner" class="spinner" style="display:none;">
                <img id="img-spinner" style="width: 400px;height: 300px;" src="view/images/spinner.gif" alt="Loading"/>
                </div>

	<div class="row datatables" id="main">
   		
   		<div class="col-md-12">
   			<form action="SentIntList.htm" method="POST" id="preview" style="background-color:#0e6fb6;  border-radius: 4px;">
			    <div class="row" >			    
				    <div class="col-md-10" > 
				    </div>
				    <div class="col-md-1">
					 	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					    <input class="form-control  form-control"  type="text" id="fromdate" value="<%=dt %>" style="font-size: 10px"  onchange="this.form.submit()" name="dt">
                            </div>
				    <div class="col-md-1">
					   <button class="btn btn-sm btn-info btnspin" formaction="MailIntSent.htm" type="submit" ><i class="fa fa-refresh" aria-hidden="true"></i></button>
					    
				    </div>
				</div>
    		</form>
   		</div>
				<div class="col-md-12">
				 <div class="card shadow-nohover" >

				<div class="card-body"> 
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover table-striped table-condensed " id="myTable">
							<thead>
								<tr >
									<th style="text-align: left;">SN</th>
									<th style="text-align: left;">Sent Date</th>
									<th style="text-align: left;">From</th>
									<th style="text-align: left;">Receipt</th>
									<th style="text-align: left;">Subject</th>
									<th style="text-align: left;">Attachment</th>
									<th style="text-align: left;">Marked</th>
								</tr>
							</thead>
							<tbody>
								<%
								    int count=1;
									for (DakMailSent dto :mailAll) {
								%>
								<tr>

									<td style="text-align: center;width: 3%;">
					                    <%=count %>
                                    </td>
                                    <td style="text-align: center;width: 10%;">
					                    <%=sdf.format(dto.getSentDate()) %>
                                    </td>
                                    <td style="text-align: center;width: 13%;">

					                    <%=dto.getAddressFrom() %>
					                    
					                    
                                    </td>
                                    <td style="text-align: center;width: 16%;">
					                    <%=dto.getAddressRecieptant() %>
					                  
                                    </td>
                                    <td style="text-align: center;">
					                   
                             
									  <button type="button" class="btn btn-sm icon-btn btn-link btnspin" onclick="getContent(<%=dto.getMessageId() %>)"  data-toggle="tooltip" data-placement="top" title="Download" >  <%=dto.getSubject() %></button>


                                    </td>

                                    <td style="text-align: center;width: 18%;">
                                    
                                      <%if(dto.getDakMailSentAttach().size()>0){
                                      for(DakMailSentAttach atach:dto.getDakMailSentAttach()){ %>   
									  <form action="DownloadMailAttach.htm" method="POST"  class="form-in" >   
									  <input type="hidden" name="fileName" value="<%=atach.getAttachPath() %>" />
									                               
									  <button style="font-size: 11px;" type="submit" class="btn btn-sm icon-btn " name="downloadbtn" value="I_<%=dto.getMessageId() %>_"  data-toggle="tooltip" data-placement="top" title="Download" ><img alt="attach" src="view/images/download1.png"> <%=atach.getAttachPath() %></button>
                                         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                         </form>
                                      
                                      
                                      <br>
                                      <%} }else{%>
                                         Empty
                                      <%} %>
                                    </td>
                                    <td style="text-align: center;width: 3%;">
					                    <%=dto.getIsMarked()%>
                                    </td>
								</tr>
								<%
								count++;	}
								%>
							</tbody>
						</table>

					</div>

				</div>

			</div>
		</div>
	</div>
	<div class="modal fade my-modal" id="exampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true">
 	  <div class="modal-dialog modal-dialog-centered" role="document">
 	    <div class="modal-content">
 	      <div class="modal-header">
 	        <h5 class="modal-title" id="exampleModalLongTitle">Content</h5>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <div id="contentModal">
  	      </div>
 
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
<script type="text/javascript">
$('#fromdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	 "maxDate" :new Date(),   
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

function getContent(value){	
	 $('body').css("filter", "blur(0.5px)");
     $('body').css("pointer-events", "none");
    $('#main').hide();
    $('#spinner').show();
$.ajax({
			type : "GET",
			url : "getMailSentContent.htm",
			data : {
				
				messageid: value
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			
		    $('#contentModal').html(result);
		    $('body').css("filter", "blur(0.0px)");
		    $('body').css("pointer-events", "auto");
	        $('#main').show();
	        $('#spinner').hide();
		    $('#exampleModalReply').modal('toggle');
			}
		});

}

$(document).ready(function(){
    $('.btnspin').click(function() {
        $('body').css("filter", "blur(0.5px)");
         $('body').css("pointer-events", "none");
        $('#main').hide();
        $('#spinner').show();
       
    });

});


</script>
</body>



</html>