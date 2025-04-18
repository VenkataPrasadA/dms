<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<title>DMS</title>
	<link rel="shortcut icon" type="image/png" href="view/images/drdologo.png">
	

	<jsp:include page="dependancy.jsp"></jsp:include>

	
	<spring:url value="/webresources/css/rfpHeader.css" var="headerCss" />
<link href="${headerCss}" rel="stylesheet" />

 <spring:url value="/webresources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" /> 

<spring:url value="/webresources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />
  
 <spring:url value="/webresources/css/fontanimation.css" var="fontAnimation" />
<link href="${fontAnimation}" rel="stylesheet" />  
	
<style>
     
.dropdown-toggle::after {
    display:none;
}


    
nav ul li{ 
	padding-right: 30;
}
    
.customClassForDropDown {
       height: 200px;
       overflow-y: auto;
    }
 
.btn-circle.btn-xl {
    width: 40px;
    height: 40px;
    padding: 10px 16px;
    border-radius: 35px;
    font-size: 24px;
    line-height: 1.33;
}
	
/*  Tharun Styles*/
	
.dropdown-header {
    background-color: #4e73df;
    border: 1px solid #4e73df;
    padding-top: .75rem;
    padding-bottom: .75rem;
    color: #fff;
}

.dropdown-header {
    font-weight: 800;
    font-size: 0.95rem;
    color: #fff;
    font-family:'Quicksand', sans-serif;	
}

.dropdown-list {
    padding: 0;
    border: none;
    overflow: hidden;
    width: 20rem!important;
}

.dropdown-item {
    white-space: normal;
    padding-top: .5rem;
    padding-bottom: .5rem;
    border-left: 1px solid #e3e6f0;
    border-right: 1px solid #e3e6f0;
    border-bottom: 1px solid #e3e6f0;
    line-height: 1.3rem;
    font-family:'Lato', sans-serif;
    font-size: 0.85rem;	
    font-weight: 400;
}
	
.text-gray-500 {
    color: black !important;
}
	
.small, small {
    font-size: 70%;
    font-weight: 400;
    background-color: #f7f7f7;
}
	
.badge-counter {
    position: absolute;
    transform: scale(.8);
    transform-origin: top right;
   	margin-left: -1.75rem;
    margin-top: -.25rem;
    background: red;
   	font-family:'Lato', sans-serif;  
}
	


.logout .dropdown-item{

		border-left: 0px !important;
		border-right: 0px !important;
		border-bottom: 0px !important;
}
.bg-light{
background-color: #005C97 !important;
}

      </style>
</head>
<body>

	<div class="wrapper">

	    <%
		    String Username =(String)session.getAttribute("Username"); 
		    String LoginType =(String)session.getAttribute("LoginTypeDms"); 
		    String LoginAs=(String)session.getAttribute("LoginAs");
		    String LabCode=(String)session.getAttribute("LabCode");
		    
		    String EmpName =(String)session.getAttribute("EmpName"); 
		    String EmpDesig =(String)session.getAttribute("EmpDesig"); 
		    
		   	String LoginTypeCode=null;
		   	
		    if(LoginAs!=null){
		    	LoginTypeCode=LoginAs;
		    }else{
		    	LoginTypeCode=LoginType;
		    }
		    
		    String LoginTypeName=null;
		   
			if(LoginTypeCode.equalsIgnoreCase("A")){
	    		LoginTypeName="ADMIN";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("D")){
	    		LoginTypeName="DH";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("G")){
	    		LoginTypeName="GH";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("T")){
	    		LoginTypeName="GHDH";
	    	}
	      	if(LoginTypeCode.equalsIgnoreCase("O")){
	    		LoginTypeName="STORES";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("B")){
	    		LoginTypeName="B&A";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("S")){
	    		LoginTypeName="SPC";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("C")){
	    		LoginTypeName="CFA";
	    	}
	      	if(LoginTypeCode.equalsIgnoreCase("M")){
	    		LoginTypeName="MMD";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("R")){
	    		LoginTypeName="DIR SECT";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("I")){
	    		LoginTypeName="IMMS";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("U")){
	    		LoginTypeName="USER";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("P")){
	    		LoginTypeName="PROJECT DIRECTOR";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("Z")){
	    		LoginTypeName="DIR";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("Y")){
	    		LoginTypeName="ASSC DIR";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("Q")){
	    		LoginTypeName="2-IC";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("E")){
	    		if(LabCode!=null && LabCode.equalsIgnoreCase("ADE")){
	    			LoginTypeName="PPA";
	    		}else{
	    			LoginTypeName="P&C DO";
	    		}
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("H")){
	    		LoginTypeName="HQ";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("L")){
	    		LoginTypeName="LAB PM";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("F")){
	    		LoginTypeName="DOPD";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("J")){
	    		LoginTypeName="GHPD";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("X")){
	    		LoginTypeName="DG";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("W")){
	    		LoginTypeName="SUPER-ADMIN";
	    	}
    
	    	if(LoginTypeCode.equalsIgnoreCase("K")){
	    		LoginTypeName="SECY";
	    	}
	    	if(LoginTypeCode.equalsIgnoreCase("V")){
	    		LoginTypeName="DAK ADMIN";
	    	}
	    	
	    	if(LoginTypeCode.equalsIgnoreCase("N")){
	    		LoginTypeName="SPC MEMBER";
	    	}
	    	%>
    

    
    
        <!-- Sidebar  -->
        <nav id="sidebar">
            
			<div class="sidebar-header" align="center">
                <a href="MainDashBoard.htm"><p><img alt="logo" src="view/images/dms1.png" style="width:auto;height:2rem"><br>DMS</p></a>
            </div>
            
            <ul class="list-unstyled components" id="module" style="margin-top: 25px;">
            
                
            </ul>

           
        </nav>

        <!-- Page Content  -->
        <div id="content" >
        
        
        	<nav class="navbar navbar-expand-lg navbar-light " style="background-color: #363795;">

			  <button type="button" id="sidebarCollapse" style="border-color: white;margin-left: -0.3rem; background-color:#363795; "	class="btn btn-sm " >
                        <i class="fa fa-align-left" ></i>
              </button> 
			   <span style="color: white; margin-left: 20px; font-weight: bold; font-style: normal;">DMS -  <%=EmpName.trim()+",  "+ EmpDesig%> </span>
			  <div class="collapse navbar-collapse" id="navbarSupportedContent" style="background-color: #363795;">
			    <ul class="navbar-nav mr-auto">
			     
			    </ul>
			  
			  <!-- Button trigger modal start -->
						

						<!-- Modal -->
							<div class="modal fade bd-example-modal-xl" id="smartsearch"
								tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
								aria-hidden="true">

								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<div class="container">
												<div class="row">
													<div class="col-lg">
														<input autofocus autocomplete="off"
															placeholder="Enter Module Name To Navigate"
															required="required" oninput="findModule()" id="projectids"
															class="form-control" type="text">
													</div>
												</div>
											</div>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body" id="targets"></div>
									</div>
								</div>
							</div>
							<button type="button" class="btn btn-light"  style="    margin-right: 50px ;"
									onclick="opensmartsearch()">
									<b>Smart Search </b>&#x1F50D;
								</button>
								
								
								
					<!--------------------------------------------- Button trigger modal end ------------------------------------------------------->
					<% if( LoginType.equalsIgnoreCase("A") ||  LoginType.equalsIgnoreCase("Z") ||  LoginType.equalsIgnoreCase("E")){%>
							<div class=" btn btn-light">
							<a href="DakNoSearchDetails.htm">
								Dak Search
								</a>
							</div>
						
					<%} %>
<!--------------------------------------------- Button trigger modal end ------------------------------------------------------->

	         <%-- <% if( LoginType.equalsIgnoreCase("A") ||  LoginType.equalsIgnoreCase("Z") ||  LoginType.equalsIgnoreCase("E")){%>
			    <form action="DakNoSearchDetails.htm" class="form-inline my-2 my-lg-0" autocomplete="off">
			          <div class=" search rounded rounded-pill shadow-sm ">
			            <div class="input-group">
			            <input type="search" placeholder="Search DAK Id" name="DakNoVal" 
			            aria-describedby="button-addon1" class="form-control border-0 formSearch ">
			             <div class="input-group-append">
			                <button id="button-addon1" type="submit" style="background-color:lightblue;height: 36px;" class="btn btn-link text-primary searchBtn"><i class="fa fa-search" style="background-color:lightblue"></i></button>
			              </div>
			            </div>
			          </div>
			    </form>
			    <%} %> --%>
			    
			    <div class="btn-group " >
					<a class="nav-link dropdown-toggle onclickbell" href="#"
			 					id="alertsDropdown" role="button" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false">	
								<!-- <i	class="fa fa-bell fa-fw " aria-hidden="true" style="color:#115293"></i> -->
								<img alt="logo" src="view/images/alarm.png" style="">
								<i	class="fa fa-caret-down whiteiconcolor" aria-hidden="true"	style="padding-left:5px;"></i><span
								class="badge badge-danger badge-counter" id="NotificationCount" >0</span>
		             </a>
	 				<div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in custombell" aria-labelledby="alertsDropdown" >
	                	<h6 class="dropdown-header">Notifications</h6>
	                		<div id="Notification"></div>
	                		<a class="dropdown-item text-center small text-gray-500 showall"  href="NotificationListView.htm">Show All Alerts</a>
	            	</div>
				</div>
				<div class="btn-group">
					<button type="button"  class="btn btn-link btn-sm dropdown-toggle btn-responsive" style="text-decoration: none !important; color: white;"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    	<img alt="logo" src="view/images/myacc.png" style="">
					   		<span style="font-family: 'Quicksand', sans-serif;font-weight: 700">&nbsp;<%=Username   %>&nbsp;(<%=LoginTypeName %>)</span><i class="fa fa-caret-down whiteiconcolor" aria-hidden="true"style="padding-left:5px;"></i>
					</button>
					  
					<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in logout" aria-labelledby="userDropdown" style="width: 170%;">
						<a class="dropdown-item" href="#">
						<img src="view/images/admin.png"/>&nbsp;&nbsp;
						 &nbsp;&nbsp;Hi <%=EmpName+" , "+EmpDesig%> 	&nbsp;&nbsp;&nbsp;!!  </a>
					    
					    <div class="dropdown-divider"></div>
					                
					    <a class="dropdown-item" href="PasswordChange.htm">
					    <img src="view/images/key.png"/>
												&nbsp;&nbsp; 
					                  Change Password
					    </a>
					
					    <div class="dropdown-divider"></div>
					        
					    <a class="dropdown-item" href="DmsInstruction.htm" target="_blank">    
					     <img src="view/images/handbook.png"/>
												&nbsp;&nbsp; 
					     Dms Manual     </a>
					     
					     <div class="dropdown-divider"></div>
					        
					    <a class="dropdown-item" href="DmsWorkFlow.htm" target="_blank">    
					     <img src="view/images/workflow.png"/>
												&nbsp;&nbsp; 
					     Dms WorkFlow     </a>
					        
					        <div class="dropdown-divider"></div>
					                
					    <a class="dropdown-item" href="FeedBack.htm">
					    
					     <img src="view/images/feedback.png"/>
												&nbsp;&nbsp; 
					                  Feedback
					    </a>
					    
					        <div class="dropdown-divider"></div>
					                
					    <a class="dropdown-item" href="DmsPpt.htm" target="_blank">
					    
					     <img src="view/images/work.png"/>
												&nbsp;&nbsp; 
					                  About Dms
					    </a>
					    
					     <div class="dropdown-divider"></div>
					                
					    <a class="dropdown-item" href="DmsSms.htm" target="_blank">
					    
					     <img src="view/images/sms.png"/>
												&nbsp;&nbsp; 
					                  About SMS
					    </a>
					    
					    <div class="dropdown-divider"></div>
					                
					    <form id="logoutForm" method="POST" action="${pageContext.request.contextPath}/logout">
					           			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					               		 	<button class="dropdown-item " href="#"  data-target="#logoutModal">
					                  			 <img src="view/images/logout.png"/>
												&nbsp;&nbsp; 
					                  					&nbsp;&nbsp;Logout
					                		</button>
					    </form>
					</div>
				</div> 
			    
			  </div>
			</nav>
        
<script type="text/javascript">

var searchButtons = document.getElementsByClassName("searchBtn");

for (var i = 0; i < searchButtons.length; i++) {
	 
	searchButtons[i].addEventListener("click", function(event) {
	
	    var searchInputs = document.getElementsByClassName("formSearch");
	    var isAnyFilled = false;

	    for (var j = 0; j < searchInputs.length; j++) {
	      if (searchInputs[j].value.trim() !== "") {
	        isAnyFilled = true;
	        break;
	      }
	    }


    if (!isAnyFilled) {
      event.preventDefault(); // Prevent form submission
      alert("Please fill in the search input field.");
     
      
    }else{
    	
    
        
        // Trigger the CSS style for .form-search:focus + .placeholder
        searchInputs[j].focus();

        // Checking the visibility status of search_Result_page
        var isSearchResultPageVisible = window.getComputedStyle(searchResultPage).display !== "none";
    }
    
	  });//search button click function close
}
</script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
            });
        });
        window.setTimeout(function() {
            $(".alert").fadeTo(500, 0).slideUp(500, function(){
                $(this).remove(); 
            });
        }, 4000);
        
        
        $(document).ready(function(){
      	  $("#myTable").DataTable({
      	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
      	 "pagingType": "simple",
      	  order : false
      	
      });
        });
        
     
   /*   $(document).bind("contextmenu",function(e) {
       	 e.preventDefault();
       	});
       document.onkeydown = function(e) {
       	if(event.keyCode == 123) {
       	return false;
       	}
       	if(e.ctrlKey && e.shiftKey && e.keyCode == 'I'.charCodeAt(0)){
       	return false;
       	}
       	if(e.ctrlKey && e.shiftKey && e.keyCode == 'J'.charCodeAt(0)){
       	return false;
       	}
       	if(e.ctrlKey && e.keyCode == 'U'.charCodeAt(0)){
       	return false;
       	}
       	
       	}
       function preventBack(){window.history.forward();}
       setTimeout("preventBack()", 0);
       window.onunload=function(){null};   */
          
        
    </script>
    
    <script>
    $(document)
    
    			.ready
    			
    						(function () {

						        // ANIMATEDLY DISPLAY THE NOTIFICATION COUNTER.
						        $('#noti_Counter')
						            .css({ opacity: 0 })
						            .text('7')  // ADD DYNAMIC VALUE (YOU CAN EXTRACT DATA FROM DATABASE OR XML).
						            .css({ top: '-10px' })
						            .animate({ top: '-2px', opacity: 1 }, 500);
						
						        $('#noti_Button')
						        				
						        					.click(function () {
						
													            // TOGGLE (SHOW OR HIDE) NOTIFICATION WINDOW.
													            $('#notifications')
													            
													            
													            					.fadeToggle(
													            									'fast',
													            									'linear', 
													            									function () {
													            										
																								                if ($(
																								                				'#notifications').is(
																								                											':hidden')) {	
																								                	
																								                    $(
																								                    		'#noti_Button')
																								                    		.css(
																								                    				'background-color', '#2E467C');
																								                }
																								                
																								                // CHANGE BACKGROUND COLOR OF THE BUTTON.
																								                else 
																								                	$(
																								                			'#noti_Button')
																								                			.css(
																								                					'background-color', '#FFF');
																								            });
													
													            $('#noti_Counter').fadeOut('slow');     // HIDE THE COUNTER.
													
													            return false;
													        });
													
						        // HIDE NOTIFICATIONS WHEN CLICKED ANYWHERE ON THE PAGE.
						        $(document)
						        		.click(
						        				function () {
													            $(
													            		'#notifications')
													            		.hide();
													
													            // CHECK IF NOTIFICATION COUNTER IS HIDDEN.
													            if ($('#noti_Counter').is(
													            							':hidden')) {
													                // CHANGE BACKGROUND COLOR OF THE BUTTON.
													                $('#noti_Button').css(
													                					'background-color', 
													                					'#2E467C');
													            	}
							        		});

        $('#notifications').click(function () {
            return false;       // DO NOTHING WHEN CONTAINER IS CLICKED.
        });
    }); 
</script>
    
    



<script type="text/javascript">

$(document).ready(function(){
	
	$.ajax({
		type : "GET",
		url : "HeaderModuleList.htm",
		
		datatype : 'json',
		success : function(result) {
			
			var result = JSON.parse(result);
			var values = Object.keys(result).map(function(e) {
				  return result[e]
				});
			var module = "";
			for (i = 0; i < values.length; i++) {
			
				module+="<li ><a href='"+values[i][3]+"' ><i class='"+values[i][2]+"'></i>"+values[i][1]+"</a> </li>";
				
			
			}
			$('#module').html(module); 
		}
	});
	

	  $.ajax({
		type : "GET",
		url : "NotificationList.htm",
		
		datatype : 'json',
		success : function(result) {
			
			var result = JSON.parse(result);
			var values = Object.keys(result).map(function(e) {
				  return result[e]
				});
			var module = "";
			for (i = 0; i < values.length; i++) {
			
				module += "<a class='dropdown-item d-flex align-items-center' id='" + values[i][5] + "' onclick='return test(" + values[i][5] + ", \"" + values[i][4] + "\")' href='" + values[i][4] + "' style='font-family: \"Quicksand\", sans-serif;'> <div> <i class='fa fa-arrow-right' aria-hidden='true' style='color:green'></i></div> <div style='margin-left:20px'>" + values[i][3] + "</div> </a>";
				if(i>4){
					break;
				}
				console.log("values[i][5]:"+values[i][5]);
			}
          if(values.length==0){
				
				var info="No Notifications to display !";
				var empty="";
				 empty+="<a class='dropdown-item d-flex align-items-center' href=# style=' font-family:'Quicksand', sans-serif; '> <div> <i class='fa fa-comment-o' aria-hidden='true' style='color:green;font-weight:800'></i></div> <div style='margin-left:20px'>" +info+" </div> </a>";

				$('#Notification').html(empty); 
				$('.showall').hide();
				$('#NotificationCount').addClass('badge-success');
			}
			
			if(values.length>0){
 			
				$('#Notification').html(module);
				$('.showall').show();
				
			
			}
			
			
			
			$('#NotificationCount').html(values.length); 
		}
	});   
	
	
	
	$.ajax({
		type : "GET",
		url : "EmpNameHeader.htm",
	
		datatype : 'json',
		success : function(result) {
			
			var result = JSON.parse(result);
			var values = Object.keys(result).map(function(e) {
				  return result[e]
				});
			
			
			$('#EmpNameheader').html(values[0]);
			$('#EmpRoleheader').html(values[1]); 
		}
	});
	

	
	$.ajax({
		type : "GET",
		url : "DivisionNameHeader.htm",
		
		datatype : 'json',
		success : function(result) {
			
			var result = JSON.parse(result);
			var values = Object.keys(result).map(function(e) {
				  return result[e]
				});
			
			
			$('#Divisionheader').html(values); 
		}
	});
	
});


function test(NotificationId,NotificationUrl){
	
	var notificationid=NotificationId;
	var notificationurl=NotificationUrl;
	console.log("NotificationId:"+notificationid);
	console.log("NotificationUrl:"+notificationurl);
	
	
	$.ajax({
		type : "GET",
		url : "NotificationUpdate.htm",
		data : {
				notificationid : notificationid,
				notificationurl : notificationurl
				
			},
		datatype : 'json',
		success : function(result) {
			
		}
	});
	
	
}
 
 
 
</script>

<!-- sometime later, probably inside your on load event callback -->
<script>
    $("#myModal").on("show", function() {    // wire up the OK button to dismiss the modal when shown
        $("#myModal a.btn").on("click", function(e) {
            $("#myModal").modal('hide');     // dismiss the dialog
        });
    });
        
    $("#myModal").on("hide", function() {    // remove the event listeners when the dialog is dismissed
        $("#myModal a.btn").off("click");
    });
            
    $("#myModal").on("hidden", function() {  // remove the actual elements from the DOM when fully hidden
        $("#myModal").remove();
    });
            
    $("#myModal").modal({                    // wire up the actual modal functionality and show the dialog
        "backdrop"  : "static",
        "keyboard"  : true,
        "show"      : true                     // ensure the modal is shown immediately
    });
    
    
    
</script>

</body>

<script type="text/javascript">
	$(document).ready(function() {
		$('.datatablex').DataTable();
	});
	
	
	function findModule() {

		$.ajax({
			type : "GET",
			url : "SmartSearch.htm",
			data : {
				search : document.getElementById('projectids').value
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				console.log(result);

				var printOutDiv = document
						.getElementById("targets");
				while (printOutDiv.firstChild) {
					printOutDiv.removeChild(printOutDiv.lastChild);
				}
				console.log(result.length);
				for (let i = 0; i < result.length; i++) {
					var amountPrintOutDiv = document
							.createElement("div");
					amountPrintOutDiv.innerHTML = "<a href='"
							+ result[i][3] + "' id='"
							+ result[i][0]
							+ "+id' onclick=searchForRole("
							+ result[i][0] + ") >" + result[i][2]
							+ "</a>";
					printOutDiv.appendChild(amountPrintOutDiv);
				}
			}
		});
	}

	function searchForRole(formname) {
		console.log("clicked!!!!!!!!");
		var currentloc = "";
		currentloc += String(window.location.href);
		currentloc = currentloc.split("").reverse().join("")
		currentloc = currentloc.substring(0, currentloc
				.indexOf("/"));
		$
				.ajax({
					type : "GET",
					url : "searchForRole.htm",
					data : {
						search : formname
					},
					datatype : 'json',
					success : function(result) {
						var count = JSON.parse(result);
						console.log(typeof(count));
						if (count>0)
							return true;
						else {
							window
									.alert("\"Sorry\", You don't have access to this module.\nPlease contact Administrator");
							window.location.href = currentloc
									.split("").reverse().join("");
						}
					}
				});
	}


	function opensmartsearch() {
		$('#smartsearch').modal('show')
	}
	
	$('#smartsearch').on('shown.bs.modal', function() {
		  $(this).find('[autofocus]').focus();
		});
</script>
</html>