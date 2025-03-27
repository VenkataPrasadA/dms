<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>SOURCE MASTER</title>




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
			<div class="col-md-3 heading-breadcrumb">
			<%if(Action.equalsIgnoreCase("add")){ %>
				<h5 style="font-weight: 700 !important">SOURCE MASTER ADD</h5>
			<%}else{ %>
			    <h5 style="font-weight: 700 !important">SOURCE MASTER EDIT</h5>
			<%} %>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="MasterDashBoard.htm"><i class="fa fa-book" aria-hidden="true"></i> Master</a> </li>
				    <li class="breadcrumb-item"><a href="Source.htm"><i class="fa fa-list-alt" aria-hidden="true"></i> Source Master List</a></li>
				    <%if(Action.equalsIgnoreCase("add")){ %>
				    <li class="breadcrumb-item active">Source Master Add</li>
				    <%}else{ %>
				    <li class="breadcrumb-item active">Source Master Edit</li>
				    <%} %>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	



	<%
	Object[] ParticularSourceDetails=(Object[])request.getAttribute("ParticularSourceDetails");
	List<Object[]> SourceDropDownList=(List<Object[]>)request.getAttribute("SourceDropDownList");
	if(ParticularSourceDetails!=null && ParticularSourceDetails[2]!=null){%>
    <input type="hidden" id="shtname" value="<%=ParticularSourceDetails[2]%>">
    <%} %>
  <div class="container-fluid datatables">
	<div class="row" style="margin-top: 0px; margin-bottom: 5px;">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
        		<div class="card-body">
        		
        	     	<form id="myfrm" action="SourceAddEditSubmit.htm" method="POST">
                		<div class="row">
                   
                        	<div class="col-sm-4" align="left">
	                        	<div class="form-group">
	                            		<label >Source Type <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
	                              		<select id="SourceType" name="SourceType" class="form-control">
	                              		<option value="">Select Source Type</option>
	                              		<%if(SourceDropDownList!=null && SourceDropDownList.size()>0){ 
	                              		for(Object[] obj:SourceDropDownList){%>
	                              		<option value="<%=obj[0] %>" <%if(ParticularSourceDetails!=null && ParticularSourceDetails[1]!=null){if(ParticularSourceDetails[1].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%}} %>><%=obj[1].toString() %></option>
	                              		<%}} %>
	                              		</select>
	                       		</div>
                           	</div>
                           
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label >Source Short Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="ShortName" type="text" <%if(ParticularSourceDetails!=null && ParticularSourceDetails[2]!=null){ %> value="<%=ParticularSourceDetails[2].toString() %>" <%} %> name="ShortName" required="required" maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label >Source Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="SourceName" type="text" name="SourceName" required="required" <%if(ParticularSourceDetails!=null && ParticularSourceDetails[3]!=null){ %> value="<%=ParticularSourceDetails[3].toString() %>" <%} %> maxlength="255" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                		</div>
                		<div class="row">
                   
                        	<div class="col-sm-4" align="left">
	                        	<div class="form-group">
	                            		<label >Source Address <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
	                              		<input  class="form-control" id="SourceAddress" type="text" name="SourceAddress" required="required" <%if(ParticularSourceDetails!=null && ParticularSourceDetails[4]!=null){ %> value="<%=ParticularSourceDetails[4].toString() %>" <%} %> maxlength="100" style="font-size: 15px;width:100%;">
	                       		</div>
                           	</div>
                           
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label >Source City <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="SourceCity" type="text" <%if(ParticularSourceDetails!=null && ParticularSourceDetails[5]!=null){ %> value="<%=ParticularSourceDetails[5].toString() %>" <%} %> name="SourceCity" required="required" maxlength="100" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label >Source PinCode <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="SourcePinCode" type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' name="SourcePinCode" required="required" <%if(ParticularSourceDetails!=null && ParticularSourceDetails[6]!=null){ %> value="<%=ParticularSourceDetails[6].toString() %>" <%} %> maxlength="6" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-sm-4" align="left">
	                        	<div class="form-group">
	                            		<label >IsDMS <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
	                              		<select id="IsDMS" name="IsDMS" class="form-control">
	                              		<option value="">Select IsDMS</option>
	                              		
	                              		<option value="Y" <%if(ParticularSourceDetails!=null && ParticularSourceDetails[7]!=null){if(ParticularSourceDetails[7].toString().equalsIgnoreCase("Y")){ %> selected="selected" <%}} %>>Yes</option>
	                              		<option value="N" <%if(ParticularSourceDetails!=null && ParticularSourceDetails[7]!=null){if(ParticularSourceDetails[7].toString().equalsIgnoreCase("N")){ %> selected="selected" <%}} %> >No</option>
	                              	  
	                              		</select>
	                       		</div>
                           	</div>
                           	
                           	<div class="col-md-4">
                        		<div class="form-group">
                            		<label >API URL <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="APIURL" type="text" <%if(ParticularSourceDetails!=null && ParticularSourceDetails[8]!=null){ %> value="<%=ParticularSourceDetails[8].toString() %>" <%} %> name="APIURL" required="required" maxlength="100" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                		</div>
                		<div align="center">
                        		<%if(Action.equalsIgnoreCase("add")){ %>
	 						     <input type="submit" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="return SubmitForm('Add')" > 
						        <%}else{ %>
						        <input type="hidden" name="SourceId" value="<%=ParticularSourceDetails[0]%>">
						         <input type="submit" class="btn btn-primary btn-sm submit" value="Edit" name="sub" onclick="return SubmitForm('Edit')" > 
						        <%} %>
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

</body>

<script>
$("#ShortName").keyup(function(){  
	var shtname=$("#shtname").val();
	var ShortName=$("#ShortName").val();
	var ActionJs=$("#ActionJs").val();
	var type="Source";
	
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
		  var SourceType=$("#SourceType").val();
		  var ShortName=$("#ShortName").val();
		  var SourceName=$("#SourceName").val();
		  var IsDMS=$("#IsDMS").val();
           var APIURL=$("#APIURL").val();
          var SourcePinCode=$("#SourcePinCode").val();
            var SourceCity=$("#SourceCity").val();
            var SourceAddress=$("#SourceAddress").val();
           
		  if(SourceType==null || SourceType=='' || typeof(SourceType)=='undefined' || SourceType=="Select Source Type")
		  {
			  alert("Select Source Type..!");
			  $("#SourceType").focus();
			  return false;
		  }
		  else if(ShortName==null || ShortName==='' || ShortName==="" || typeof(ShortName)=='undefined')
		  {
			  alert("Enter Source Short Name..!");
			  $("#ShortName").focus();
			  return false;
		  }
		  else if(SourceName==null || SourceName==='' || SourceName==="" || typeof(SourceName)=='undefined')
		  {
			  alert("Enter Source Name..!");
			  $("#SourceName").focus();
			  return false;
		  }
		  else if(IsDMS==null || IsDMS==='' || IsDMS==="" || typeof(IsDMS)=='undefined')
		  {
			  alert("Select IsDMS..!");
			  $("#IsDMS").focus();
			  return false;
		  }
		  else if(APIURL==null || APIURL==='' || APIURL==="" || typeof(APIURL)=='undefined')
		  {
			  alert("Enter API URL..!");
			  $("#APIURL").focus();
			  return false;
		  }
		  else if(SourcePinCode==null || SourcePinCode==='' || SourcePinCode==="" || typeof(SourcePinCode)=='undefined')
		  {
			  alert("Enter Source PinCode..!");
			  $("#SourcePinCode").focus();
			  return false;
		  }
		  else if(SourceCity==null || SourceCity==='' || SourceCity==="" || typeof(SourceCity)=='undefined')
		  {
			  alert("Enter Source City..!");
			  $("#SourceCity").focus();
			  return false;
		  }
		  else if(SourceAddress==null || SourceAddress==='' || SourceAddress==="" || typeof(SourceAddress)=='undefined')
		  {
			  alert("Enter Source Address..!");
			  $("#SourceAddress").focus();
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

</html>