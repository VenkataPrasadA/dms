<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>DAK CSW Transition History</title>

<style>
.control-label {
	font-weight: bold !important;
}

.table thead th {
	vertical-align: middle !important;
}

.header {
	position: sticky;
	top: 0;
	background-color: #346691;
}
.modal-dialog-jump {
  animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
.table button {
	font-size: 12px;
}

label {
	font-size: 15px !important;
}

td {
	text-align: center;
	vertical-align: middle;
}
</style>
<!-- --------------  tree   ------------------- -->
<style>
ul, #myUL {
	list-style-type: none;
}

#myUL {
	margin: 0;
	padding: 0;
}

.caret {
	cursor: pointer;
	-webkit-user-select: none; /* Safari 3.1+ */
	-moz-user-select: none; /* Firefox 2+ */
	-ms-user-select: none; /* IE 10+ */
	user-select: none;
}

.caret::before {
	content: "  \25B7";
	color: black;
	display: inline-block;
	margin-right: 6px;
}

.caret-down::before {
	content: "\25B6  ";
	-ms-transform: rotate(90deg); /* IE 9 */
	-webkit-transform: rotate(90deg); /* Safari */ '
	transform: rotate(90deg);
}

.caret-last {
	cursor: pointer;
	-webkit-user-select: none; /* Safari 3.1+ */
	-moz-user-select: none; /* Firefox 2+ */
	-ms-user-select: none; /* IE 10+ */
	user-select: none;
}

.caret-last::before {
	content: "\25B7";
	color: black;
	display: inline-block;
	margin-right: 6px;
}

.nested {
	display: none;
}

.active {
	display: block;
}
</style>

<!-- ---------------- tree ----------------- -->
<!-- -------------- model  tree   ------------------- -->
<style>
.caret-1 {
	cursor: pointer;
	-webkit-user-select: none; /* Safari 3.1+ */
	-moz-user-select: none; /* Firefox 2+ */
	-ms-user-select: none; /* IE 10+ */
	user-select: none;
}

.caret-last-1 {
	cursor: pointer;
	-webkit-user-select: none; /* Safari 3.1+ */
	-moz-user-select: none; /* Firefox 2+ */
	-ms-user-select: none; /* IE 10+ */
	user-select: none;
}

.caret-last-1::before {
	content: "\25B7";
	color: black;
	display: inline-block;
	margin-right: 6px;
}

.level2 {
	cursor: pointer;
	-webkit-user-select: none; /* Safari 3.1+ */
	-moz-user-select: none; /* Firefox 2+ */
	-ms-user-select: none; /* IE 10+ */
	user-select: none;
}

.level2::before {
	content: "\25B7";
	color: black;
	display: inline-block;
	margin-right: 6px;
}

.caret-1::before {
	content: "  \25B7";
	color: black;
	display: inline-block;
	margin-right: 6px;
}

.caret-down-1::before {
	content: "\25B6  ";
	-ms-transform: rotate(90deg); /* IE 9 */
	-webkit-transform: rotate(90deg); /* Safari */ '
	transform: rotate(90deg);
}

.nested-1 {
	display: none;
}

.active-1 {
	display: block;
}
</style>

<!-- ---------------- model tree ----------------- -->

</head>
<body>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK CSW TRANSITION LIST</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK CSW Transition List </li>
				  </ol>
				</nav>
			</div>			
		</div>
		</div>
		<%

List<Object[]> ProjectList=(List<Object[]>) request.getAttribute("ProjectList");
String ProjectId = (String) request.getAttribute("ProjectId");

String MainSystemValue = (String) request.getAttribute("MainSystemValue");
String s1 = (String) request.getAttribute("s1");
String s2 = (String) request.getAttribute("s2");
String s3 = (String) request.getAttribute("s3");
String s4 = (String) request.getAttribute("s4");
String sublevel = (String) request.getAttribute("sublevel");
String doclev1 = (String) request.getAttribute("doclev1");
String doclev2 = (String) request.getAttribute("doclev2");
String doclev3 = (String) request.getAttribute("doclev3");
String GlobalFileSize=(String) request.getAttribute("GlobalFileSize");
String projectname="";
List<Object[]> filerepmasterlistall=(List<Object[]>) request.getAttribute("filerepmasterlistall");

%>




	<%
String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	<div align="center">

		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</div>
	<%} %>

		<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="min-height: 34rem;">
					<form method="post" action="" id="myform">
						<div class="card-header">
							<div class="row">
								<div class="col-md-6">
									<h4 class="control-label">Document</h4>
								</div>
							</div>
						</div>
					</form>




					<div class="card-body">
						<div class="row">
							<div class="col-md-12 border">
								<div
									style="font-size: 17px; padding-top: 10px !important; padding-bottom: 25px !important;"
									align="center">
									<span id="tablehead"
										style="display: inline; color: black; font-style: italic;"></span>
								</div>
								<div style="overflow-y: auto; width: 100%; max-height: 35rem;">
									<div class="table-responsive ">
										<table class="table table-bordered " style="width: 100%;"
											id="MyTable1">
											<thead>
												<tr>
													<th style="width: 4%; text-align: center;">SN</th>
													<th style="width: 10%; text-align: center;">DocId</th>
													<th style="width: 60%; text-align: center;">Name</th>
													<th style="width: 15%; text-align: center;">UpdateOn</th>
													<th style="width: 5%; text-align: center;">Ver</th>
													<th><i class="fa fa-download" aria-hidden="true"></th>
													<th><i class="fa fa-history" aria-hidden="true"></th>
												</tr>
											</thead>
											<tbody id="flisttbody">

											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){	
	 doclist(0, this);
});

function doclist(lev,ele)
{	
	var $proid=$('#ProjectId').val();
	var $slevel='0';	
	var $proname=$('#projectname').val();
	
	
	elements = document.getElementsByClassName('caret');
	    for (var i1 = 0; i1 < elements.length; i1++) {
	    	$(elements[i1]).css("color", "black");
	    	$(elements[i1]).css("font-weight", "");
	    }
	    elements = document.getElementsByClassName('caret-last');
	    for (var i1 = 0; i1 < elements.length; i1++) {
	    	$(elements[i1]).css("color", "black");
	    	$(elements[i1]).css("font-weight", "");
	    }
	$(ele).css("color", "green");
	$(ele).css("font-weight", "700");
	
	if(lev==0)
	{
		//setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$proname,'modelhead');
		//setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$proname,'tablehead');
		
		var tempx = '<tbody id="flisttbody"></tbody>';
		$('#flisttbody').replaceWith(tempx);					
		$("#MyTable1").DataTable({
			 "destroy": true,							 
			 "lengthMenu": [5,10,25, 50, 75, 100 ],
			 "pagingType": "simple",
			 "pageLength": 5,
			 "language": {
			 "emptyTable": "Files not Found"
			    }
		}); 
		return 0;
	}
	
		 $.ajax({
			
				type : "GET",
				url : "AllFilesList.htm",
				data : {
					subid		:	$slevel  ,
					projectid	:	$proid ,
					mainsystem 	:	mid ,
				},
				datatype: 'json',
				success : function(result){
					
					var result= JSON.parse(result);
					var values= Object.keys(result).map(function(e){
						
						return result[e]
						
					})
				 	var x = '<tbody id="flisttbody">';
					
					for (i = 0; i < values.length; i++) {
						
						var sn=i+1;
					
						x += '<tr><td>'+sn+'</td><td>'+values[i][9]+'</td><td>'+values[i][12]+'</td><td>'+values[i][11]+'</td><td>'+values[i][8]+'.'+values[i][6]+'</td>';
						if(Number(values[i][4])>0){
							x +='<td><button type="button" class="btn" onclick="FileDownload(\''+values[i][4]+'\');"><i class="fa fa-download" aria-hidden="true"></i></button></td>'
						}else{
							x +='<td>-</td>'
						}
						
						if(Number(values[i][8])>0 || Number(values[i][6])>0 ){
							x +='<td><button type="button" class="btn"  onclick="DocHistoryList('+values[i][7]+');"><i class="fa fa-history" aria-hidden="true"></i></button></td></tr>';
						}else{
							x +='<td>-</td></tr>'
						}

					}
					x=x+'</tbody>';
					
					 
					$('#flisttbody').replaceWith(x);					
					$("#MyTable1").DataTable({
						 "destroy": true,							 
						 "lengthMenu": [5,10,25, 50, 75, 100 ],
						 "pagingType": "simple",
						 "pageLength": 5,
						 "language": {
						      "emptyTable": "Files not Found"
						    }
					}); 
					 
					 
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert("Internal Error Occured !!");
		            alert("Status: " + textStatus);
		            alert("Error: " + errorThrown); 
		        }  
				
				
			}) 
}
</script>
	<!-- ----------------------------------------- hislist table -------------------------------------------------------------------  -->

</html>