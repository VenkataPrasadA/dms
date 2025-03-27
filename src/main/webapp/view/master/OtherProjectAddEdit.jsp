<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>NON-PROJECT MASTER</title>




<style>
.table thead tr th {
	background-color: aliceblue;
	width: 30%;
	
}

.table thead tr td {
	background-color: #f9fae1;
	text-align: left;
}

label{
font-size: 15px;
}

table{
	box-shadow: 0 4px 6px -2px gray;
}
</style>


</head>
<body >

<%String Action=(String)request.getAttribute("Action"); %>
<input type="hidden" value="<%=Action%>" id="ActionJs">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-4 heading-breadcrumb">
			<%if(Action.equalsIgnoreCase("add")){ %>
				<h5 style="font-weight: 700 !important">OTHER-PROJECT MASTER ADD</h5>
			<%}else{ %>
			    <h5 style="font-weight: 700 !important">OTHER-PROJECT MASTER EDIT</h5>
			<%} %>
			</div>
			<div class="col-md-8" >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="OtherProject.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Other-Project Master List</a></li>
				    <%if(Action.equalsIgnoreCase("add")){ %>
				    <li class="breadcrumb-item active">Non-Project Master Add</li>
				    <%}else{ %>
				    <li class="breadcrumb-item active">Non-Project Master Edit</li>
				    <%} %>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	



	<%
	Object[] OtherProjectDetails=(Object[])request.getAttribute("ParticularOtherProjectDetails");
	if(OtherProjectDetails!=null && OtherProjectDetails[2]!=null)
	{%>
       <input type="hidden" id="shtname" value="<%=OtherProjectDetails[2]%>">
       <%} %>

  <div class="container-fluid datatables">
	<div class="row" style="margin-top: 0px; margin-bottom: 5px;">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
        		<div class="card-body">
        		
        	     	<form id="myfrm" action="OtherProjectAddEditSubmit.htm" method="POST">
                		<div class="row">
                		
                		    <div class="col-md-2">
                        		<div class="form-group">
                            		<label >Lab Code <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="LabCode" type="text" name="LabCode" required="required" <%if(OtherProjectDetails!=null){ if(OtherProjectDetails[4]!=null){ %> value="<%=OtherProjectDetails[4].toString() %>" <%}else{ %> value="" <%} }%> maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                            
                            <div class="col-md-2">
                        		<div class="form-group">
                            		<label >Project Code <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="ProjectCode" type="text" <%if(OtherProjectDetails!=null){ if(OtherProjectDetails[1]!=null){%> value="<%=OtherProjectDetails[1].toString() %>" <%}else{ %> value="" <%}} %> name="ProjectCode" required="required" maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                           
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label >Project Short Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="ShortName" type="text" <%if(OtherProjectDetails!=null){ if(OtherProjectDetails[2]!=null){%> value="<%=OtherProjectDetails[1].toString() %>" <%}else{ %> value="" <%}} %> name="ShortName" required="required" maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-5">
                        		<div class="form-group">
                            		<label >Project Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="OtherProjectName" type="text" name="OtherProjectName" required="required" <%if(OtherProjectDetails!=null){ if(OtherProjectDetails[3]!=null){ %> value="<%=OtherProjectDetails[3].toString() %>" <%}else{ %> value="" <%} }%> maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		
                    		<div class="col-md-1" style="margin-top: 2.4rem">
                        		<%if(Action.equalsIgnoreCase("add")){ %>
	 						     <input type="submit" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="return SubmitForm('Add')" > 
						        <%}else{ %>
						        <input type="hidden" name="OtherProjectId" value="<%=OtherProjectDetails[0]%>">
						         <input type="submit" class="btn btn-primary btn-sm submit" value="Edit" name="sub" onclick="return SubmitForm('Edit')" > 
						        <%} %>
                    		</div>
                		</div>
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 				</form>
     		</div>    
        
			<div class="card-footer form-footer">
       
        	</div>
        	
        	</div>
		</div>
	</div>
</div>
	  
	<script>
$("#ShortName").keyup(function(){  
	var shtname=$("#shtname").val();
	var ShortName=$("#ShortName").val();
	var ActionJs=$("#ActionJs").val();
	var type="OtherProject";
	
			$.get('ShortNameUniqueCheck.htm', {
				ShortName : ShortName,
				    type  : type
			}, function(responseJson) {
				var values = JSON.parse(responseJson);
				if(ActionJs=="add")
					{
						if(values>0)
						{
						alert(ShortName+" - Short Name Already Exist..!");
						$("#ShortName").val('');
						return false;
						}
					}else
						{
							if(shtname!=ShortName)
							{
								if(values>0)
									{
										alert(ShortName+" - Short Name Already Exist..!");
										$("#ShortName").val('');
										return false;
									}
							}
							else
								{
									if(values>1)
									{
										alert(ShortName+" - Short Name Already Exist..!");
										$("#ShortName").val('');
										return false;
								    }
								}
						}
				
				
			});
	});
</script>
	  
<script type="text/javascript">

		function SubmitForm(action)
		{
		  var ShortName=$("#ShortName").val();   
		  var OtherProjectName=$("#OtherProjectName").val();   
		  var ProjectCode=$("#ProjectCode").val();
		  var LabCode=$("#LabCode").val();
		  
		 if(LabCode==null || LabCode==='' || LabCode==="" || typeof(LabCode)=='undefined')
		  {
			  alert("EnterLab Code..!");
			  $("#LabCode").focus();
			  return false;
		  }
		 else if(ProjectCode==null || ProjectCode==='' || ProjectCode==="" || typeof(ProjectCode)=='undefined')
		  {
			  alert("Enter Project Code..!");
			  $("#ProjectCode").focus();
			  return false;
		  }
		  else if(ShortName==null || ShortName==='' || ShortName==="" || typeof(ShortName)=='undefined')
		  {
			  alert("Enter Other Project Short Name..!");
			  $("#ShortName").focus();
			  return false;
		  }
		  else if(OtherProjectName==null || OtherProjectName==='' || OtherProjectName==="" || typeof(OtherProjectName)=='undefined')
		  {
			  alert("Enter Other-Project Name..!");
			  $("#OtherProjectName").focus();
			  return false;
		  }
		  else
			  {
			  if(action=='Add')
				  {
				  var x=confirm("Are You Sure To Add ?");
				  }
			  else
				  {
				  var x=confirm("Are You Sure To Update ?");
				  }
			  
			  if(x)
				  {
				  document.getElementById("myfrm").submit();
				  return true;
				  }
			  else
				  {
				  return false;
				  }
			  }
		}


</script>
</body>
</html>