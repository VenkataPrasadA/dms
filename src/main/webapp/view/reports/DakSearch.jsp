<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,java.text.SimpleDateFormat,com.vts.dms.dak.model.DakAttachment"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<title>DAK Search</title>

<style>
div.dropdown-menu.open
    {
        max-height: 410px !important;
        overflow: hidden;
    }
    ul.dropdown-menu.inner
    {
        max-height: 410px !important;
        /* overflow-y: auto; */
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
#Sample{
display:block;
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
.table .font {
	font-size: 13px;
	font-weight: 700 !important;
	
}

.table a:hover,a:focus {
   text-decoration: underline !important; 
}


.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 30px;
	height: 20px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 100px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 30px;
	height: 20px;
	box-sizing: border-box;
	margin: 0 0 0 0;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 4px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 12px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

 .searchtbl {
    border-collapse: separate;
    border-spacing: 0;
  }
  .searchtbl th,
  .searchtbl td {
    border-right: 1px solid #dee2e6;
  }

 .searchModalButton{
   background-color: Transparent;
   font-weight: 400;
   font-size:15px;
   font-weight:bold;
   line-height: 1.5;
   color: #1C6DD0;;
   text-decoration: underline;
   border: none;
   cursor:pointer;    
   outline: none !important;


} 	

#searchTheadRow{
 /*   background-color:  rgba(65, 51, 173, 1); */
   /* color:#fff; */
  color:#353935; 
   
   background: 
    radial-gradient(
      farthest-side at top left,
      rgba(65, 51, 173, 1), 
      transparent
    ),
    radial-gradient(
      farthest-side at top right,
      rgba(65, 51, 173, 1), 
      transparent
    ),
    radial-gradient(
      farthest-corner at bottom right,
      rgba(255, 255, 255, 1), 
      transparent 400px
    ); 
}



.input-group .form-search {
  flex: 1;
  margin-right: 10px;
}

.input-group .btn-group {
  display: flex;
}

.input-group
{
    position: relative;
    display: flex;
  align-items: center;
}

.search-btn{
  width: 45px; /* Adjust the width as per your needs */
}

.search-btn{
  background-color: #1C6DD0;;
}

.btn-group.searchicon button i::before {
  content: "\f002";
  transition: content 0.3s ease-in-out;
}

.btn-group.searchicon button:hover i::before {
  content: "\f101";
}


.form-search
{
    display: block;
    padding: 0.375rem 0.75rem;
    width: 100%;
    background-color: transparent;
    color: #495057;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: 0.25rem;
    box-sizing: border-box;
    background-clip: padding-box;
    outline: none;
    border: 1px solid #1C6DD0;;
    
    
}
.placeholder
{
     position: absolute;
    top: 10px;
    left: 8px;
    font-size: 14px;
    padding: 0px 5px;
    color: #666;
    transition: 0.3s;
    pointer-events: none;
}


/* .form-search:focus + .placeholder {
  top: -22px;
  color: #4133ad;
  background-color: transparent;
  border-radius: 0.25rem;
}
 .form-search.has-value + .placeholder {
  top: -22px;
  color: #4133ad;
  background-color: transparent;
  border-radius: 0.25rem;
}
 
 .form-search.has-no-value + .placeholder {
  top: 0;
  color: initial;
  background-color: initial;
  border-radius: initial;
} */


.searchScroll{
min-height: 400px!important;



}

.search-dropdown{
background-image: url("view/images/panoramic.jpg");
background-repeat: no-repeat;
background-position: center;
background-size: cover;
background-attachment: fixed;
opacity: 1.0;
}

.search{
padding:10px;
 background: transparent!important;
}

.search_modules{
padding:10px;
}

.search_Result_page{

   /*  position: relative;
    background-color:transparent!important;
    min-height:250px;
    min-width:100%;
    display: flex;
    background-color: #fff;
    background-clip: border-box;
    border: 1px solid grey;
    border-radius: 0.25rem; */
}

  .searchdiv {
  display: none;
}

@keyframes zoom-in-zoom-out {
  0% {
    transform: scale(1, 1);
  }
  50% {
    transform: scale(1.1, 1.1);
  }
 
}

.zoom-in-zoom-out {
  background: transparent;
  animation: zoom-in-zoom-out 2s ease-out infinite;
}



.table.searchtbl {
  background-color: rgba(0,0,0,.05)!important;
 
}
 
 .previewTable td {
  font-size: 16px !important;
}

.previewTable th {
  color: #114A86;
  font:size:16px;
}

.modal-title {
  display: flex;
   color: #114A86;
  justify-content: center;
  align-items: center;
  text-align: center;
  color: #000;
  text-shadow: 0 1px 0 #fff;
}

</style>



</head>
<body>

			
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Search</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="ReportsDashBoard.htm"><i class="fa fa-file" ></i> Reports</a></li>
				    <li class="breadcrumb-item active">DAK Search </li>
				  </ol>
				</nav>
			</div>			
		</div>
		</div>
		
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="left">
		<div class="alert alert-danger" role="alert">
	    	<%=ses1 %>
	    </div>
    </div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
        	<%=ses %>
        </div>
    </div>
    <%} %>
    
    <%  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
    String searchType=(String)request.getAttribute("searchType");
    String searchValue=(String)request.getAttribute("searchValue");
    String searchAction = (String)request.getAttribute("searchAction");
  
	List<Object[]> SearchDetailsList = (List<Object[]>) request.getAttribute("SearchDetailsList"); 
	
%>

<!-- <div class="card-body">  -->
<div class="container text-center" style="margin-top:-1.65rem;"><!-- ***********search container starts*************  -->
 	 	<form action="#" method="post">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
<div style="margin-left: 4rem;" class="row search"><!-- //row 1 starts// -->
 <input type="hidden" id="search-action" value="<%=searchAction%> " />
 
    <div class="search_modules">
    <div class="input-group">
      <input type="text" class="form-search" id="DakNoValue" placeholder="Enter DAK Id" name="DakNoVal" oninput="changedakno()" onfocus="showmodal()" value="<%if("DakIdSearch".equalsIgnoreCase(searchAction) &&  searchValue!=null){ %><%=searchValue %><%} %>"  maxlength="52"  autocomplete="off">
    <!--   <label class="placeholder" for="dakIdVal">Enter DAK Id</label> -->
      <div class="btn-group searchicon">
       
      </div>
    </div>
</div>    

<div class="search_modules">
    <div class="input-group">
       <input type="text" class="form-search" id="RefNoValue"  placeholder="Enter Ref No"   name="RefNoVal" oninput="changerefno()" onfocus="showmodal()" value="<%if( "RefNoSearch".equalsIgnoreCase(searchAction) &&  searchValue!=null){ %><%=searchValue %><%} %>"  maxlength="52"  autocomplete="off">
    <!--   <label class="placeholder" for="RefNoVal">Enter Ref No</label> -->
      <div class="btn-group searchicon">
       
      </div>
    </div>
</div>   
 
  
 
 
  <div class="search_modules">
    <div class="input-group">
      <input type="text" class="form-search" id="SubjectValue"   placeholder="Enter Subject" name="SubjectVal" oninput="changesubject()" onfocus="showmodal()"  value="<%if( "SubjectSearch".equalsIgnoreCase(searchAction) &&  searchValue!=null){ %><%=searchValue %><%} %>"  maxlength="52"  autocomplete="off">
    <!--   <label class="placeholder" for="SubjectVal">Enter Subject</label> -->
      <div class="btn-group searchicon">
      
      </div>
    </div>
</div>    


   <div class="search_modules">
    <div class="input-group">
     <input type="text" class="form-search" id="KeywordsValue"  placeholder="Enter Keyword" name="KeywordsVal" oninput="changekeyword()" onfocus="showmodal()"  value="<%if( "KeywordsSearch".equalsIgnoreCase(searchAction) &&  searchValue!=null){ %><%=searchValue %><%} %>"  maxlength="52"  autocomplete="off">
  <!--     <label class="placeholder" for="KeywordsVal">Enter Keyword</label> -->
      <div class="btn-group searchicon">
       
      </div>
    </div>
</div>    
 
 </div>
 </form>
 </div>
 
  
	<!-- <div class="card" style="width: 90%;  display: none; margin:auto; " id="searchmodal"> -->
		<div class="card-body" id="searchmodal"  style="display: none;">
			<h3 style="text-align: center;" >Search Results</h3>
			<form id="myForm" action="#">
				<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
				<input type="hidden" name="viewfrom" value="DakSearch">
				<table id="myTable1"
					class="table table-bordered table-hover table-striped table-condensed " >
					<thead>
						<tr>
							<th class="text-nowrap">SN</th>
							<th class="text-nowrap">DAK Id</th>
							<th class="text-nowrap">Head</th>
							<th class="text-nowrap">Source</th>
							<th class="text-nowrap">Ref No & Date</th>
							<th class="text-nowrap">Action Due</th>
							<th class="text-nowrap">Subject</th>
							<th class="text-nowrap">Status</th>
							<th class="text-nowrap">Action</th>
						</tr>
					</thead>
					<tbody id="dakidtargets"></tbody>
				</table>
			</form>
			<h3 id="loading"
				style="text-align: center; margin-top: 20%; display: none">Please Wait ...</h3>
		</div>
<!-- 	</div> -->
</body>
<script>
  var inputs = document.querySelectorAll('.form-search');
  var focusedInput = null;
  // Add event listeners to all input fields
  inputs.forEach(function(input) {
    input.addEventListener('click', function() {
      // Check if a previous input field was clicked and if it has a value
      if (focusedInput && focusedInput !== input && focusedInput.value !== '') {
        focusedInput.value = ''; // Clear the value if a previous input field has a value
     // Hide the <div>
        var searchResultPage = document.getElementsByClassName("search_Result_page")[0];
        searchResultPage.style.display = "none";
      }
      focusedInput = input; // Update the currently focused input field
    });
  });
</script>

<script>
var searchButtons = document.getElementsByClassName("search-btn");
for (var i = 0; i < searchButtons.length; i++) {
	searchButtons[i].addEventListener("click", function(event) {
	    var searchInputs = document.getElementsByClassName("form-search");
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
    }
    else
    {
    	 // Trigger the CSS style for .form-search:focus + .placeholder
        searchInputs[j].focus();

        // Checking the visibility status of search_Result_page
        var isSearchResultPageVisible = window.getComputedStyle(searchResultPage).display !== "none";

        if (isSearchResultPageVisible) {
        	    
                 // adding additional code here when search_Result_page is visible to maintain .form-search:focus + .placeholder css no matter where i click
        	      document.addEventListener("click", function(e) {
                  var clickedElement = e.target;
                  // Check if the clicked element is a search input or its placeholder
                   var isSearchInput = clickedElement.classList.contains("form-search") || clickedElement.classList.contains("placeholder");
                   if (!isSearchInput) {
                   // Remove focus from all search inputs
                   for (var k = 0; k < searchInputs.length; k++) {
                     searchInputs[k].blur();
                   }
                   // Refocus on the appropriate search input
                   searchInputs[j].focus();
                 }
               });
        }
    }
  });//search button click function close
}
</script>
<script>
  $(document).ready(function() {
	  var $action = $("#search-action").val().trim(); // Trim whitespace
      var searchResultPage = document.getElementsByClassName("search_Result_page")[0];
  });
</script>

<script type="text/javascript">
function changedakno() {
	$('#searchmodal').css('display', 'block');
	var dakno=document.getElementById('DakNoValue').value.length;
	if(dakno>=3){
	$('#loading').css('display', 'block');
			
	$('#dakidtargets').empty();
	$.ajax({
		type : "GET",
		url : "dakidtargets.htm",
		data : {
			DakNoVal : document.getElementById('DakNoValue').value
		},
		datatype : 'json',
		success : function(result) {
			var result = JSON.parse(result);
			$('#dakidtargets').empty();
			var count=0;
			for (var i = 0; i < result.length; i++) {
			    var dateString = result[i][4];
			    var date = new Date(dateString);
			    var day = date.getDate();
			    var month = date.getMonth() + 1;
			    var year = date.getFullYear();
			    var formattedDate = day.toString().padStart(2, '0') + '-' + month.toString().padStart(2, '0') + '-' + year;

			    var dateString1 = result[i][5];
			    var date1 = new Date(dateString1);
			    var day1 = date1.getDate();
			    var month1 = date1.getMonth() + 1;
			    var year1 = date1.getFullYear();
			    var formattedDate1 = day1.toString().padStart(2, '0') + '-' + month1.toString().padStart(2, '0') + '-' + year1;

			    count++;
			    var amountPrintOutDiv = document.createElement("tr");
			    amountPrintOutDiv.innerHTML = 
			        "<td style='width:10px;'>" + count + "</td>" +
			        "<td style='text-align: left;width:10px;'>" + result[i][1] + "</td>" +
			        "<td style='text-align: center;width:80px;'>" + result[i][8] + "</td>" +
			        "<td style='text-align: center;width:10px;'>" + result[i][2] + "</td>" +
			        "<td style='text-align: left;width:50px;'>" + result[i][3] + "<br>" + formattedDate + "</td>" +
			        "<td style='text-align: center;width:50px;'>" + formattedDate1 + "</td>" +
			        "<td style='text-align: left;width:200px;'>" + result[i][6] + "</td>" +
			        "<td style='text-align: center; width:80px;'>" + result[i][7] + "</td>" +
			        "<td style='text-align: center; width:80px;' ><button type='submit' class='btn btn-sm icon-btn' name='DakId' value='"+result[i][0]+"'"+
					"formaction='DakReceivedView.htm' formmethod='post' formtarget='_blank' > "+"<img alt='mark' src='view/images/preview3.png'>"+"</td>";

			    $('#dakidtargets').append(amountPrintOutDiv);
			}

			
			$('#loading').css('display', 'none');
		}
	});
	}
}
/* $(document).on('click', '.btn.icon-btn', function () {
    var dakId = $(this).data('dakid');
    var form = $('<form>', {
        'action': 'DakReceivedView.htm',
        'method': 'GET',
        'target': '_blank'
    }).append($('<input>', {
        'type': 'hidden',
        'name': 'DakId',
        'value': dakId
    }));
    
    form.appendTo('body').submit();
}); */
function changerefno() {
	$('#searchmodal').css('display', 'block');
	var RefNo=document.getElementById('RefNoValue').value.length;
	if(RefNo>=3){
	$('#loading').css('display', 'block');
			
	$('#dakidtargets').empty();
	$.ajax({
		type : "GET",
		url : "GetDakDetailsRefNo.htm",
		data : {
			RefNoValue : document.getElementById("RefNoValue").value
		},
		datatype : 'json',
		success : function(result) {
			var result = JSON.parse(result);
			var count=0;
			$('#dakidtargets').empty();
			//var iter = result.length>10?10:result.length;
			for (var i = 0;  i < result.length; i++) {
				var dateString = result[i][4];
				var date = new Date(dateString);
				var day = date.getDate();
				var month = date.getMonth() + 1; // Adding 1 to make it 1-indexed
				var year = date.getFullYear();
				var formattedDate = day.toString().padStart(2, '0') + '-' + month.toString().padStart(2, '0') + '-' + year;
				
				var dateString1 = result[i][5];
				var date1 = new Date(dateString);
				var day1 = date.getDate();
				var month1 = date.getMonth() + 1; // Adding 1 to make it 1-indexed
				var year1 = date.getFullYear();
				var formattedDate1 = day1.toString().padStart(2, '0') + '-' + month1.toString().padStart(2, '0') + '-' + year1;
				
				count++;
				var amountPrintOutDiv = document.createElement("tr");
				amountPrintOutDiv.innerHTML = "<td style='width:10px;'>"+count+"</td>"+
				"<td style='text-align: left;width:10px;' >"+result[i][1]+"</td>"+
				"<td style='text-align: center;width:80px;' >"+result[i][8]+"</td>"+
				"<td style='text-align: center;width:10px;' >"+result[i][2]+"</td>"+
				"<td style='text-align: left;width:50px;' >"+result[i][3] +"<br> "+formattedDate+"</td>"+
				"<td style='text-align: center;width:50px;' >"+formattedDate1+"</td>"+
				"<td style='text-align: left;width:200px;'>"+result[i][6]+"</td>"+
				"<td style='text-align: center; width:80px;'>"+result[i][7]+"</td>"+
				"<td style='text-align: center; width:80px;' ><button type='submit' class='btn btn-sm icon-btn' name='DakId' value='"+result[i][0]+"'"+
				"formaction='DakReceivedView.htm' formmethod='post' formtarget='_blank' > "+"<img alt='mark' src='view/images/preview3.png'>"+"</td>";
				
				$('#dakidtargets').append(amountPrintOutDiv);
			}
			
			$('#loading').css('display', 'none');
		}
	});
	}
}


function changesubject() {
	$('#searchmodal').css('display', 'block');
	var subject=document.getElementById('SubjectValue').value.length;
	if(subject>=3){
	$('#loading').css('display', 'block');
			
	$('#dakidtargets').empty();
	$.ajax({
		type : "GET",
		url : "GetDakDetailsSubject.htm",
		data : {
			Subject : document.getElementById('SubjectValue').value
		},
		datatype : 'json',
		success : function(result) {
			var result = JSON.parse(result);
			$('#dakidtargets').empty();
			var count=0;
			//var iter = result.length>10?10:result.length;
			for (var i = 0;  i < result.length; i++) {
				var dateString = result[i][4];
				var date = new Date(dateString);
				var day = date.getDate();
				var month = date.getMonth() + 1; // Adding 1 to make it 1-indexed
				var year = date.getFullYear();
				var formattedDate = day.toString().padStart(2, '0') + '-' + month.toString().padStart(2, '0') + '-' + year;
				
				var dateString1 = result[i][5];
				var date1 = new Date(dateString);
				var day1 = date.getDate();
				var month1 = date.getMonth() + 1; // Adding 1 to make it 1-indexed
				var year1 = date.getFullYear();
				var formattedDate1 = day1.toString().padStart(2, '0') + '-' + month1.toString().padStart(2, '0') + '-' + year1;
				
				count++;
				var amountPrintOutDiv = document.createElement("tr");
				amountPrintOutDiv.innerHTML = "<td style='width:10px;'>"+count+"</td>"+
				"<td style='text-align: left;width:10px;' >"+result[i][1]+"</td>"+
				"<td style='text-align: center;width:80px;' >"+result[i][8]+"</td>"+
				"<td style='text-align: center;width:10px;' >"+result[i][2]+"</td>"+
				"<td style='text-align: left;width:50px;' >"+result[i][3] +"<br> "+formattedDate+"</td>"+
				"<td style='text-align: center;width:50px;' >"+formattedDate1+"</td>"+
				"<td style='text-align: left;width:200px;' >"+result[i][6]+"</td>"+
				"<td style='text-align: center; width:80px;'>"+result[i][7]+"</td>"+
				"<td style='text-align: center; width:80px;' ><button type='submit' class='btn btn-sm icon-btn' name='DakId' value='"+result[i][0]+"'"+
				"formaction='DakReceivedView.htm' formmethod='post' formtarget='_blank' > "+"<img alt='mark' src='view/images/preview3.png'>"+"</td>";
				
				$('#dakidtargets').append(amountPrintOutDiv);
			}
			
			$('#loading').css('display', 'none');
		}
	});
	}
}

function changekeyword() {
	$('#searchmodal').css('display', 'block');
	var keyword=document.getElementById('KeywordsValue').value.length;
	if(keyword>=3){
	$('#loading').css('display', 'block');
			
	$('#dakidtargets').empty();
	$.ajax({
		type : "GET",
		url : "GetDakDetailsKey.htm",
		data : {
			Keyword : document.getElementById('KeywordsValue').value
		},
		datatype : 'json',
		success : function(result) {
			var data = JSON.parse(result);
			 var printOutDiv = $("#dakidtargets");
		        printOutDiv.empty(); // Clear existing rows
	
			//var iter = result.length>10?10:result.length;
			for (var i = 0;  i < data.length; i++) {
				var dateString = data[i][4];
				var date = new Date(dateString);
				var day = date.getDate();
				var month = date.getMonth() + 1; // Adding 1 to make it 1-indexed
				var year = date.getFullYear();
				var formattedDate = day.toString().padStart(2, '0') + '-' + month.toString().padStart(2, '0') + '-' + year;
				
				var dateString1 = data[i][5];
				var date1 = new Date(dateString);
				var day1 = date.getDate();
				var month1 = date.getMonth() + 1; // Adding 1 to make it 1-indexed
				var year1 = date.getFullYear();
				var formattedDate1 = day1.toString().padStart(2, '0') + '-' + month1.toString().padStart(2, '0') + '-' + year1;
				var row = "<tr>" +
                "<td style='width:10px;'>" + (i + 1) + "</td>" +
                "<td style='text-align: left;width:10px;'>" + data[i][1] + "</td>" +
                "<td style='text-align: center;width:80px;'>" + data[i][8] + "</td>" +
                "<td style='text-align: center;width:10px;'>" + data[i][2] + "</td>" +
                "<td style='text-align: left;width:50px;'>" + data[i][3] + "<br> " + formattedDate + "</td>" +
                "<td style='text-align: center;width:50px;'>" + formattedDate1 + "</td>" +
                "<td style='text-align: left;width:200px;'>" + data[i][6] + "</td>" +
                "<td style='text-align: center; width:80px;'>" + data[i][7] + "</td>" +
                "<td style='text-align: center; width:80px;'>" +
                "<button type='submit' class='btn btn-sm icon-btn' name='DakId' value='"+data[i][0]+"'"+
                "formaction='DakReceivedView.htm' formmethod='post' formtarget='_blank'>" +
                "<img alt='mark' src='view/images/preview3.png'>" +
                "</button>" +
                "</td>" +
                "</tr>";
                printOutDiv.append(row);
			}
			$('#loading').css('display', 'none');
			
		}
	});
	}
	
}
function showmodal() {
	$('#searchmodal').css('display', 'block');
}
</script>
</html>