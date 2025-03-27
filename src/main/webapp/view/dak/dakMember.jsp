<%@page import="com.vts.dms.dak.model.DakMemberType"%>
<%@page import="java.util.List"%>
<%@ page language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>DAK Members</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style>
.table thead tr th{vertical-align:middle; text-align: center; font-size: 12px; white-space: nowrap;}
.table tbody tr td{vertical-align:middle; text-align: center; font-size: 12px; white-space: nowrap; }
.custom{
	margin: 0px 20px !important;
    border-radius: 7px !important;
}

</style>
<%
List<DakMemberType> dataList=(List<DakMemberType>)request.getAttribute("memberType");
List<Object[]> epmdata=(List<Object[]>)request.getAttribute("EmpList");
List<Object[]> memberData=(List<Object[]>)request.getAttribute("MemberList");
String type =(String)request.getAttribute("type");
String member =(String)request.getAttribute("member");
int type2=0;
if(type!=null){
	type2= Integer.parseInt(type);
}

%>
</head>
<body >
 <div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Members</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK  Members</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>

     


				<form action="dakMember.htm" method="post" id="FormSubmit">
					<div class="row">
				
						<div class="col-sm-2" style="margin-top: 4px;text-align: right;">
							<label class="control-label">Member Type:<span class="mandatory"
								style="color: red;">*</span>
							</label>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<select class=" form-control selectpicker"  data-live-search="true" id="optionajax"
									name="MemberType">
									<%if (dataList != null) {
										for (DakMemberType data : dataList) {%>
								     	<option value="<%=data.getDakMemberTypeId()%>" <%if(type2==data.getDakMemberTypeId()){ %> selected="selected" <%} %>><%=data.getDakMemberType()%></option>
									<% }} %>
								</select>
							</div>
						</div>
						 <div class="col-sm-2" style="margin-top: 4px;text-align: right;">
							<label class="control-label">Employee List:<span class="mandatory"
								style="color: red;">*</span>
							</label>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<select class=" form-control selectpicker"  data-live-search="true" id="EmployeeDropDown" required="required"
									name="Employee">
									<%if (epmdata != null) {
										for (Object[] data : epmdata) {%>
									<option value="<%=data[0]%>"><%=data[1]%>, <%=data[2] %></option>
									<% }} %>
								</select>
							</div>
						</div>
						
						<div class="col-sm-1">
							<button type="submit" class="btn btn-sm btn-primary" style="margin-bottom: 10px;margin-top: 3px;" formaction="addDakmember.htm" formnovalidate="formnovalidate" onclick="return SubmitAdd()">ADD </button>
						</div>
						
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				   
					</div>
					  </form>

	<%
	String ses = (String) request.getParameter("Status");
	String ses1 = (String) request.getParameter("StatusFail");
	if (ses1 != null) {
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert">
		<%=ses1%>
	</div>
	</div>
	<%
	}
	if (ses != null) {
	%>
	<div align="center">
	<div class="alert alert-success" role="alert">
		<%=ses%>
	</div>
	</div>
	<%
	}
	%>
	


	<div id="RevokeMessage" style="text-align: center;margin-left: auto;margin-right: auto;width: 60% !important;">
		                <div class="alert-success" role="alert" style="	text-align: center;width: 50%;margin-left: auto;margin-right: auto;">
	                     <span id="SetMemberName" style="font-weight: 700;color:red;"></span>&nbsp;<span style="font-weight: 600;"> Revoked Succesfully..!</span>
	                    </div></div>
		
          <div>	
                  <div class="row">
					<div id="clb" class="panel panel-default  col col-sm-11" style="margin-left: 50px">
						<div class="panel-body p-015">
						<div style="margin-top: 10px;">
								
						     <p id ="memberText"><b></b></p>
				
				              <table id="" class="table table-hover table-striped  table-condensed  table-bordered  " >
                              <thead> 
                                  <tr>            
                                   <th>Select</th>
                                   <th>MemberType</th>
                                   <th>Employee Name </th>
                                   <th>Designation</th>
                                  </tr>
                               </thead>
                               <tbody id="memberTable">
                               <%if(memberData!=null){for(Object[] data:memberData){ %>
                               <tr>
                               <td><input type="radio" name="EmpIdr" value="<%=data[0]%>"></td>
                               <td><%=data[3]%>
                               <input type="hidden" id="DakMembersId-<%=data[0]%>" value="<%=data[4]%>"></td>
                               <td><%=data[1]%>
                               <input type="hidden" id="MemberName-<%=data[0]%>" value="<%=data[1]%>"></td>
                               <td><%=data[2]%></td>
                               </tr>
                               
                               <%} }%>
                               </tbody>
                               </table>
                              	<div  class="row" style="justify-content: center;"><button class="btn btn-danger" id="RevokeBtn">Revoke</button></div>
						</div>
						</div>
					</div>
					
		
				</div>

</div>

<script src="${pageContext.request.contextPath}/vtsfolder/dist/js/app.min.js"></script> 
						
</body>
<script>
$('#optionajax').change(function(event) {
	
	var Employee=$("#EmployeeDropDown option:selected").text();
	if(typeof(Employee)=='undefined')
	{
		alert("Select Employee..!");
	}
	else
		{
		$("#FormSubmit").submit();
		}
});
</script>

<script>
function SubmitAdd()
{
	var EmployeeDropDown=$("#EmployeeDropDown").val();
	var emberType=$("#optionajax").val();
	if(EmployeeDropDown==null || EmployeeDropDown=='' || typeof(EmployeeDropDown)=='undefined')
	{
		alert("Select Member Type ..!");
		return false;
	}
	else if(emberType==null || emberType=='' || typeof(emberType)=='undefined')
	{
		alert("Select Employee List ..!");
		return false;
	}
	else
		{
		var x=confirm("Are You Sure To Add This Member..!");
		if(x)
			{
			document.getElementById("FormSubmit").submit();
			return true;
			}
		else
			{
			return false;
			}
		}
}


</script>

<script type="text/javascript">
	$(document).ready(function() {
		var project=$("#optionajax").val();
		$("#memberType").val(project);
		var project1=$("#memberType").val();
        $("#RevokeMessage").hide();
	});
	
</script>

<script type="text/javascript">
$("#optionajax").on('change', function(e){
	$("#RevokeMessage").hide();
	var project=$("#optionajax").val();
	$("#memberType").val(project);
	var project1=$("#memberType").val();
	
	var x='';
	$.ajax({
		
		type : "GET",
		url : "dakMemberAjax.htm",
		data : {
			project : project 
		},
		datatype : 'json',
		success : function(result) {
			var values = JSON.parse(result);
			for(i = 0; i < values.length; i++){
				 x=x+"<tr><td><input type="+"'radio'"+"name="+"'EmpIdr'"+"value="+values[i][0]+" "+"</td><td>"+values[i][1]+"</td><td>"+values[i][2]+"</td><td>"+values[i][3]+"</td></tr>"; 
				 
			}
		
			$("#memberTable").html(x);
		}
		});	
	
	var y='';
	$.ajax({
		
		type : "POST",
		url : "updateOption",
		data : {
			project : project 
		},
		datatype : 'json',
		success : function(result) {
			var valuess = JSON.parse(result);
			for(i = 0; i < valuess.length; i++){
				
				y=y+"<option value="+valuess[i][0]+">"+ valuess[i][1]+"("+valuess[i][2]+")" +"</option>";
			}
		  
			$(".selectdpicker").html(y);
		}
		});	
     
});
</script>

<script type="text/javascript">
$("#RevokeBtn").on('click', function(e){
	if (typeof $("input[name='EmpIdr']:checked").val() === "undefined") {
	    alert('Select Any One Of Radio Button..!');
	}else{
		var Member=$("input[name='EmpIdr']:checked").val();
		
		var TempId="DakMembersId-"+Member;     //Member Id
		var DakMembersId=$("#"+TempId).val();
		
		var TempId1="MemberName-"+Member;
		var MemberName=$("#"+TempId1).val();
		
		var project=$("#optionajax").val();
		
		var y=confirm("Are ou Sure To Revoke This Member..!");
		if(y)
			{
			var x='';
			$.get('revokeMember.htm', {
				project : project,
				DakMembersId  : DakMembersId
			}, function(responseJson) {
				var values = JSON.parse(responseJson);
				for(i = 0; i < values.length; i++){
					 x=x+"<tr><td><input type="+"'radio'"+"name="+"'EmpIdr'"+"value="+values[i][0]+" "+"</td><td>"+values[i][1]+"</td><td>"+values[i][2]+"</td><td>"+values[i][3]+"</td></tr>"; 
				}
				$("#memberTable").html(x);
				$("#SetMemberName").html(MemberName);
				$("#RevokeMessage").show();
			});
			}else
				{
				return false;
				}
	}
});
</script>

</html>