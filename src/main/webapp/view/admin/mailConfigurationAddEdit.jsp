<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>MAIL CONFIGURATION ADD EDIT</title>
<style>
.toggle-password {
      float: right;
      cursor: pointer;
      margin-top: -30px;
      font-size: 23px;
      position: relative; /* Add this line */
      z-index: 2;
    }

.disabled-password{
float: right;
      cursor: pointer;
      margin-top: -30px;
      font-size: 23px;
      position: relative; /* Add this line */
      z-index: 2;
      color:grey;
}

    .password-container {
      position: relative; /* Add this line */
    }

    .form-control {
      padding-right: 40px; /* Adjust as needed based on your icon size */
    }
</style>
</head>
<body>
<%
String Action =(String)request.getAttribute("action");
String mailConfigIdFrEdit =(String)request.getAttribute("mailConfigIdFrEdit");

//System.out.println("MailConfigAction :"+Action);
Object[] EditObject = (Object[]) request.getAttribute("mailConfigEditList");
String pass=(String)request.getAttribute("pass");
%>

<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important"><%if(Action.equalsIgnoreCase("Add")){%>MAIL CONFIGURATION ADD<%}else if(Action.equalsIgnoreCase("Edit")){ %>MAIL CONFIGURATION EDIT<%} %></h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
			<ol class="breadcrumb" >
				<li class="breadcrumb-item ml-auto"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item  " aria-current="page"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin </a></li>
				<li class="breadcrumb-item"><a href="MailConfigurationList.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Mail Configuration List</a></li>
				<li class="breadcrumb-item active"><%if(Action.equalsIgnoreCase("Add")){%>Mail Configuration Add<%}else if(Action.equalsIgnoreCase("Edit")){ %>Mail Configuration Edit<%} %></li>
			</ol>
		  </nav> 
		  </div>
		  </div>
</div>
<div  align="center"> 

<form id="MailConfigAddEditFrm" method="POST" autocomplete="off">
   <div class="col-sm-8"  style="top: 10px;" align="center">
      <div class="card"  style="background-color: aliceblue;">
          <div class="card-body">
 
      <div class="form-group">
         <div class="table-responsive">
                 <table class="table table-bordered table-hover table-striped table-condensed "  >
                  
                   <tr>
                   <th><label >USER NAME:<span class="mandatory" style="color: red;">*</span></label></th>
                   <td  colspan="4" >
                   <input  class="form-control form-control" placeholder="UserName" type="text"
                    name="UserNameData"  id="UserNameVal" required="required" maxlength="50" style="font-size: 15px;"
                    <%if( Action.equalsIgnoreCase("Edit") && EditObject!=null){%>value="<%=EditObject[1] %>"<%} %>
                     >
                   </td>
                   </tr> 
       
                   <tr>
                   <th><label >HOST TYPE:<span class="mandatory" style="color: red;">*</span></label></th>
                   <td >
                   <select class="form-control selectpicker" data-container="body" data-live-search="true" 
                    name="HostTypeData" id="HostTypeVal"  required="required" style="font-size: 5px;">
				       <option value="" disabled="disabled" selected="selected"
					  hidden="true">--Select--</option>
				      <option   <%if( Action.equalsIgnoreCase("Edit") && EditObject!=null && EditObject[3].toString().equalsIgnoreCase("L")){%>selected<%} %> value="L">Lab Email</option>
				      <option   <%if( Action.equalsIgnoreCase("Edit") && EditObject!=null && EditObject[3].toString().equalsIgnoreCase("D")){%>selected<%} %> value="D">Drona Email</option>
                 </select> 
                  </td>
                 </tr>
                 
                 
                   <tr>
                   <th><label >HOST :<span class="mandatory" style="color: red;">*</span></label></th>
                   <td >
                   <input  class="form-control form-control" placeholder="Host" type="text"
                    name="Host"  id="Host" required="required" maxlength="50" style="font-size: 15px;"
                    <%if( Action.equalsIgnoreCase("Edit") && EditObject!=null){%>value="<%=EditObject[2] %>"<%} %>
                     >
                  </td>
                 </tr>
                 
                 
                   <tr>
                   <th><label >PORT :<span class="mandatory" style="color: red;">*</span></label></th>
                   <td >
                   <input  class="form-control form-control" placeholder="Port" type="text"
                    name="Port"  id="Port" required="required" maxlength="50" style="font-size: 15px;"
                    <%if( Action.equalsIgnoreCase("Edit") && EditObject!=null){%>value="<%=EditObject[4] %>"<%} %>
                     >
                  </td>
                 </tr>
                 
                 <tr>
                   <th><label >ENTER PASSWORD:<span class="mandatory" style="color: red;">*</span></label></th>
                   <td  colspan="4" >
                   <div class="password-container">
                <input class="form-control" placeholder="Password" type="password"
                name="PasswordData" id="PasswordVal" required="required" maxlength="50" style="font-size: 15px;"
                <%if( Action.equalsIgnoreCase("Edit") && pass!=null){%>value="<%=pass %>" <%} %>>
               <%if( Action.equalsIgnoreCase("Add") && EditObject==null){%>
             <i class="toggle-password fa fa-fw fa-eye-slash"></i>
               <%}  %>
           </div>
                  
                   </td>
                   </tr> 
                   
                   <tr>
                   <th><label >CONFIRM PASSWORD:<span class="mandatory" style="color: red;">*</span></label></th>
                   <td  colspan="4" >
                   <div class="password-container">
                <input class="form-control" placeholder="Password" type="password"
                name="NewPasswordVal" id="NewPasswordVal" required="required" maxlength="50" style="font-size: 15px;"
                <%if( Action.equalsIgnoreCase("Edit") && pass!=null){%>value="<%=pass %>"  <%} %>>
               <%if( Action.equalsIgnoreCase("Add") && EditObject==null){%>
             <i class="toggle-password fa fa-fw fa-eye-slash"></i>
               <%}  %>
           </div>
                  
                   </td>
                   </tr> 
    
             <!--<tr>
                <th><label >MAIL TYPE:<span class="mandatory" style="color: red;">*</span></label></th>
                 <td >
                   <select class="form-control selectpicker"  data-container="body" data-live-search="true" 
                   name="MailTypeData" id="MailTypeVal"  required="required" style="font-size: 5px;">
				  <option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				  <option value="Gmail">Gmail</option>
				  <option value="Outlook">Outlook</option>
                 <option value="Yahoo">Yahoo</option>
	           </select> 
              </td>
             </tr>  -->
      <!--  <tr>
      <th><label >HOST:<span class="mandatory" style="color: red;">*</span></label></th>
      <td  colspan="4" >
       <input  class="form-control form-control" placeholder="Host" type="text" name="Host" required="required" maxlength="255" style="font-size: 15px;"  id="UserName" readonly="readonly">
      </td>
       </tr> 
       
       
         <tr>
      <th><label >PORT:<span class="mandatory" style="color: red;">*</span></label></th>
      <td  colspan="4" >
       <input  class="form-control form-control" placeholder="Port" type="text" name="Port" required="required" maxlength="255" style="font-size: 15px;"  id="UserName" readonly="readonly">
      </td>
       </tr>  -->
       
       </table>
  </div>
  </div>
  
    <div align="center"> 
    <div id="AddEditSubmit" >
	   
	   <% if(Action.equalsIgnoreCase("Add") &&  EditObject==null){ %> 
	     <button type="button"formaction="MailConfigurationAddSubmit.htm" class="btn btn-primary btn-sm submit" 
	     id="MailConfigAddSubmitBtn"  onclick="return MailConfigAddValidation()" >Submit</button>
	  <%} %>
	     
	       <% if(Action.equalsIgnoreCase("Edit") &&  EditObject!=null){ %> 
	       <input type="hidden" name="MailConfigIdFrEditSubmit" value="<%=mailConfigIdFrEdit%>">
	        <button type="button"formaction="MailConfigurationEditSubmit.htm" class="btn btn-primary btn-sm submit" 
	     id="MailConfigEditSubmitBtn"  onclick="return MailConfigEditValidation()" >Update</button>
	  <%} %>
	       
	   
	   
	     <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}"  />
	    </div></div>
	
  </div>
</div>
 </div>
 </form>
  </div>
   <script type="text/javascript">
  $(".toggle-password").click(function() {
    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $(this).parent().find("input");
    if (input.attr("type") == "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
});
  </script>
  
  <script>
  function resetPassword() {
    // Add your reset password logic here
    alert("Reset Password logic goes here!");
  }
</script>
  
 <script type="text/javascript">
  function MailConfigAddValidation(){
	    var Submit = true;
		var username=$('#UserNameVal').val();
		var Oldpassword=$('#PasswordVal').val();
		var Newpassword=$('#NewPasswordVal').val();
		var HostType= $("#HostTypeVal").val();
		var Host= $("#Host").val();
		var Port= $("#Port").val();
/* 		var MailType= $("#MailTypeVal").val(); */
		
    if(username==null || username==='' || username==="" || typeof(username)=='undefined'){
	 alert("Please Enter a Username ...!");
	 $("#UserNameVal").focus();
	 event.preventDefault();
	 Submit = false;
   }else if(HostType == null || HostType==='' || HostType==="" || typeof(HostType)=='undefined' ){	
	 alert("Please Select a Host Type ...!");
	 $("#HostTypeVal").focus();
	 event.preventDefault();
	 
	 Submit = false;
    }else if( Host== null || Host==='' || Host==="" || typeof(Host)=='undefined' ){	
	 alert("Please Enter a Host ...!");
	 $("#Host").focus();
	 event.preventDefault();	
	 Submit = false; 
    }else if( Port== null || Port==='' || Port==="" || typeof(Port)=='undefined' ){	
	 alert("Please Enter a Port ...!");
	 $("#Port").focus();
	 event.preventDefault();	
	 Submit = false; 
    }else if(Oldpassword==null || Oldpassword==='' || Oldpassword==="" || typeof(Oldpassword)=='undefined'){
   	 alert("Please Enter a Password ...!");
   	 $("#PasswordVal").focus();
   	 event.preventDefault();
   	 Submit = false;
    }else if( Newpassword== null || Newpassword==='' || Newpassword==="" || typeof(Newpassword)=='undefined' ){	
	 alert("Please Confirm the Password ...!");
	 $("#NewPasswordVal").focus();
	 event.preventDefault();	
	 Submit = false; 
    }else if(Oldpassword!=Newpassword){	
	 alert("Password Not Matching ...!");
	 event.preventDefault();	
	 Submit = false; 
	 
   }else{
	   var userConfirmation = confirm("Are you sure to add this mail configuration?");
	    
	    if (userConfirmation) {
	  
		  var addButton = document.getElementById('MailConfigAddSubmitBtn');
		  var formactionValue = addButton.getAttribute('formaction');

		  const form =document.getElementById('MailConfigAddEditFrm');
          form.action = formactionValue;
          form.submit();
          
		  return true;
		  
		  }else{
			  event.preventDefault();
			  return false;
			  }
	
    }  
	  
}
  
  function  MailConfigEditValidation() {
	    var Submit = true;
	    var username=$('#UserNameVal').val();
		var Oldpassword=$('#PasswordVal').val();
		var Newpassword=$('#NewPasswordVal').val();
		var HostType= $("#HostTypeVal").val();
		var Host= $("#Host").val();
		var Port= $("#Port").val();
/* 		var MailType= $("#MailTypeVal").val(); */
		
		if(username==null || username==='' || username==="" || typeof(username)=='undefined'){
			 alert("Please Enter a Username ...!");
			 $("#UserNameVal").focus();
			 event.preventDefault();
			 Submit = false;
		   }else if(HostType == null || HostType==='' || HostType==="" || typeof(HostType)=='undefined' ){	
			 alert("Please Select a Host Type ...!");
			 $("#HostTypeVal").focus();
			 event.preventDefault();
			 
			 Submit = false;
		    }else if( Host== null || Host==='' || Host==="" || typeof(Host)=='undefined' ){	
			 alert("Please Enter a Host ...!");
			 $("#Host").focus();
			 event.preventDefault();	
			 Submit = false; 
		    }else if( Port== null || Port==='' || Port==="" || typeof(Port)=='undefined' ){	
			 alert("Please Enter a Port ...!");
			 $("#Port").focus();
			 event.preventDefault();	
			 Submit = false; 
		    }else if(Oldpassword==null || Oldpassword==='' || Oldpassword==="" || typeof(Oldpassword)=='undefined'){
		   	 alert("Please Enter a Password ...!");
		   	 $("#PasswordVal").focus();
		   	 event.preventDefault();
		   	 Submit = false;
		    }else if( Newpassword== null || Newpassword==='' || Newpassword==="" || typeof(Newpassword)=='undefined' ){	
			 alert("Please Confirm the Password ...!");
			 $("#NewPasswordVal").focus();
			 event.preventDefault();	
			 Submit = false; 
		    }else if(Oldpassword!=Newpassword){	
			 alert("Password Not Matching ...!");
			 event.preventDefault();	
			 Submit = false; 
			   
		    }else{
				   var userConfirmation = confirm("Are you sure to update this mail configuration?");
				    
				    if (userConfirmation) {
				  
					  var addButton = document.getElementById('MailConfigEditSubmitBtn');
					  var formactionValue = addButton.getAttribute('formaction');
			
					  const form =document.getElementById('MailConfigAddEditFrm');
			          form.action = formactionValue;
			          form.submit();
			          
					  return true;
					  
					  }else{
						  event.preventDefault();
						  return false;
						  }
				
			    }  
	  
}
  
</script>

  
</body>
</html>