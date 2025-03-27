<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>MEMBER TYPE MASTER</title>




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
				<h5 style="font-weight: 700 !important">MEMBER TYPE MASTER ADD</h5>
			<%}else{ %>
			    <h5 style="font-weight: 700 !important">MEMBER TYPE MASTER EDIT</h5>
			<%} %>
			</div>
			<div class="col-md-8" >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="MemberType.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Member Type Master List</a></li>
				    <%if(Action.equalsIgnoreCase("add")){ %>
				    <li class="breadcrumb-item active">Member Type Master Add</li>
				    <%}else{ %>
				    <li class="breadcrumb-item active">Member Type Master Edit</li>
				    <%} %>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	



	<%
	Object[] MemberTypeDetails=(Object[])request.getAttribute("ParticularMemberTypeDetails");
	%>

  <div class="container-fluid datatables">
	<div class="row" style="margin-top: 0px; margin-bottom: 5px;">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
        		<div class="card-body">
        		
        	     	<form id="myfrm" action="MemberTypeAddEditSubmit.htm" method="POST">
                		<div class="row">
                            
                            <div class="col-md-5">
                        		<div class="form-group">
                            		<label >Member Type <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="MemberType" type="text" <%if(MemberTypeDetails!=null){ if(MemberTypeDetails[1]!=null){%> value="<%=MemberTypeDetails[1].toString() %>" <%}else{ %> value="" <%}} %> name="MemberType" required="required" maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		 <div class="col-md-2">
                        		<div class="form-group">
                            		<label >Grouping <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                        		     <select id="Grouping" name="Grouping" class="form-control">
	                              		<option value="Y" <%if(MemberTypeDetails!=null){ if(MemberTypeDetails[2]!=null && (MemberTypeDetails[2].toString()).equalsIgnoreCase("Y")){%> selected="selected" <%}} %>>Yes</option>
	                              		<option value="N" <%if(MemberTypeDetails!=null){ if(MemberTypeDetails[2]!=null && (MemberTypeDetails[2].toString()).equalsIgnoreCase("N")){%> selected="selected" <%}} %>>No</option>
	                              		</select>
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-1" style="margin-top: 2.4rem">
                        		<%if(Action.equalsIgnoreCase("add")){ %>
	 						     <input type="submit" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="return SubmitForm('Add')" > 
						        <%}else{ %>
						        <input type="hidden" name="MemberTypeId" value="<%=MemberTypeDetails[0]%>">
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
	  
	  
<script type="text/javascript">

		function SubmitForm(action)
		{
		  var MemberType=$("#MemberType").val();    
		  
		 if(MemberType==null || MemberType==='' || MemberType==="" || typeof(MemberType)=='undefined')
		  {
			  alert("Enter Member Type..!");
			  $("#MemberType").focus();
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