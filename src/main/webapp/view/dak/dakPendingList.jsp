<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,java.text.SimpleDateFormat,com.vts.dms.dak.model.DakAttachment"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Pending Distribution List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
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
/*  .bootstrap-select   .filter-option {

    width: 530px !important;
    height: 230px !important;
    white-space: pre-wrap;

}  */ 
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

.HighlightHighPrior{
    background: rgb(223 42 42 / 50%)!important;
}

/* -------TAB SWITCHING CSS START ----- */
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
    top: 40px; 
  
  padding: 20px;
  border-radius: 0 0 8px 8px;
  background: white;
  
  transition: 
    opacity 0.8s ease,
    transform 0.8s ease   ;
    opacity: 0;
    transform: scale(0.1);
    transform-origin: top left;
  
}

.tabby-content img {
  float: left;
  margin-right: 20px;
  border-radius: 8px;
}

.tabby-tab [type=radio] { display: none; }
[type=radio]:checked ~ label {
  background: #5488BF ;
  z-index: 2;
}

[type=radio]:checked ~ label ~ .tabby-content {
  z-index: 1;
    opacity: 1;
    transform: scale(1);
}

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

@keyframes glow {
    0% {
        box-shadow: 0 0 5px 5px rgba(255, 255, 153, 0.8); /* Initial shadow - Light yellow */
    }
    50% {
        box-shadow: 0 0 20px 10px rgba(255, 255, 153, 0.8); /* Expanded shadow - Light yellow */
    }
    100% {
        box-shadow: 0 0 5px 5px rgba(255, 255, 153, 0.8); /* Return to initial shadow - Light yellow */
    }
}

</style>
</head>
<body>
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">

				<h5 style="font-weight: 700 !important;font-size: 1.01rem!important;">DAK Pending Distribution List </h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active" >DAK Pending Distribution List</li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>

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
		<div class="alert alert-success" role="alert" >
        	<%=ses %>
        </div>
    </div>
    <%} %>
                    
<%   SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	 SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
	 String frmDt=(String)request.getAttribute("frmDt");
	 String toDt=(String)request.getAttribute("toDt");
	
	 List<Object[]> DakList = (List<Object[]>) request.getAttribute("DakList");
	 List<DakAttachment> List =(List<DakAttachment>) request.getAttribute("AttachmentData");
	 String letterno=(String)request.getParameter("letterno");
	 List<Object[]> EmpList = (List<Object[]>) request.getAttribute("EmpList");
	 String counts=(String)request.getParameter("count");
	 String DakStatus = null;
	 String DakMarkingStatus = null;
	 
	//Redir
			String PageNo=(String)request.getAttribute("PageNumber");
			String Row=(String)request.getAttribute("RowNumber");
			System.out.println("PageNo :"+PageNo+" Row :"+Row);
%>

<div class="card" style="width: 99%">

				<div class="card-body"> 
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th style="text-align: center;">Head</th>
									<th style="text-align: center;">Source</th>
									<th style="text-align: center;">Ref No & Date</th>
									<th style="text-align: center; width: 10%;">Action Due</th>
									<th style="text-align: center;">Subject</th>
									<th style="text-align: center;width:60px;">Status</th>
									<th style="text-align: center; width: 15%;">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								    int count=1;
									for (Object[] obj : DakList) {
										
								%>
							
								<tr data-row-id=row-<%=count %> <%if(obj[16]!=null && Long.parseLong(obj[16].toString())==3){ %> class="HighlightHighPrior"<%}%>>
									<td style="text-align: center;width:10px;"><%=count%></td>
									<td style="text-align: left;width:80px;"><%=obj[8]%></td>
 									<td style="text-align: center;width:10px;"><%if(obj[15]!=null){ %><%=obj[15].toString() %><%}else{ %>-<%} %></td>
							     	<td class="wrap"  style="text-align: center;width:50px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
								    <td class="wrap"  style="text-align: left;width:130px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%=sdf.format(obj[6])%></td>
								    <td><%if(obj[13]!=null){ %><%=sdf.format(obj[13]) %><%}else{ %><%="NA" %><%} %></td>
									<td class="wrap"  style="text-align: left;width:180px;"><%if(obj[14]!=null){ %><%=obj[14].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap" style="text-align: center;"><%if(obj[7]!=null){ %><%=obj[7].toString() %><%}else{ %>-<%} %></td>
									<td style="text-align: center;">
										<%if(obj[5]!=null && obj[11]!=null){
												DakStatus = obj[5].toString();
												DakMarkingStatus = obj[11].toString();
										%>
										  <%
								 
											 int itemsPerPage = 10;
                              				 // Calculating the page number based on the count and itemsPerPage
											int pageNumber = (count - 1) / itemsPerPage + 1;

											%>
										<form action="DakEdit.htm" method="POST" name="myfrm" id="myfrm" >
										<input type="hidden" name=RedirPageNo<%=obj[0]%> value="<%=pageNumber%>">
										 <input type="hidden" name=RedirRow<%=obj[0]%> value="<%=count%>">
										<input type="hidden" name="ActionCode" id="ActionCode" value="<%=obj[9].toString()%>">
 										   <%if( "DI".equalsIgnoreCase(DakStatus) ){ %>
 										  <button type="submit" class="btn btn-sm icon-btn" data-toggle="tooltip" data-placement="top" title="Edit">
 											<img alt="edit" src="view/images/writing.png">
 										  </button>
 										  <%} %>
 										  
 										  
 										  <%if("N".equalsIgnoreCase(DakMarkingStatus)){ %>
                                              <button type="button" onclick="DakMarking(<%= obj[0] %>,<%= obj[12] %>,'<%= obj[13] %>','<%= obj[9].toString().trim() %>','DakPendingList','<%=obj[8] %>','<%=obj[3] %>','<%=frmDt %>','<%=toDt %>')" class="btn btn-sm icon-btn" data-toggle="tooltip" title="Mark Up">
 											<img alt="mark" src="view/images/file-sharing.png">
 										  </button>
 										  <%} %>
 										  
 										 
 										  <button type="button" class="btn btn-sm icon-btn" data-toggle="tooltip" Onclick="uploadDoc(<%=obj[0] %>,'M','<%=obj[8].toString() %>','DakPendingList','<%=frmDt%>','<%=toDt%>','<%=obj[3].toString() %>',<%=pageNumber %>,<%=count %>,<%=obj[17] %>)" data-placement="top" title="Attach" data-target="#exampleModalCenter">
 											<img alt="attach" src="view/images/attach.png">
 										  </button>
 										  
 										 <%if( "DI".equalsIgnoreCase(DakStatus) &&  "Y".equalsIgnoreCase(DakMarkingStatus) && obj[15]!=null && !obj[15].toString().equalsIgnoreCase("NA")){ %> 
 										 <button type="button" data-toggle="tooltip" class="btn btn-sm icon-btn" onclick="DakDistribute(<%=obj[0] %>,'DakPendingList','<%=obj[8] %>','<%=obj[3] %>','<%=frmDt %>','<%=toDt %>','<%= obj[9].toString().trim() %>',<%=pageNumber %>,<%=count %>)" data-placement="top" title="Distribute">
 											<img alt="mark"  src="view/images/d1.jpg">
 										  </button>
 										  
 										  <%}%>
 										  
 										  <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
			                              <input type="hidden" name="DakId"	value="<%=obj[0] %>" /> 
			                              <input type="hidden" name="DakNo"	value="<%=obj[8] %>" />
			                              <input type="hidden" name="fromDateFetch"	value="<%=frmDt%>" /> 
			                              <input type="hidden" name="toDateFetch"	value="<%=toDt%>" />
			                              <input type="hidden" name="ActionForm" vaLue="DakPendingList"> 
		
 		                                </form>
 		                                <%} %>
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
	

	
	<!-- Modal -->
<div id="myModallist"  style="margin-left: 10%; margin-top: 50px; width: 80%; border: 1px solid black;"  class="modal">
  <!-- Modal content -->
   <div  class="modal-header" style="background-color: white; border: 1px solid black;">
        <h5 class="modal-title" style="margin-left: 93%; color: red;" ></h5>
        <button type="button" style="color:red;" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
  <div class="modal-content">
    <div id="modalbodylist" ></div>
  </div>
   <div class="modal-footer"></div>
</div>
	
<!-- Button to trigger the modal -->
<button type="button" id="openModalBtn" style="display: none;">Open Modal</button>

<!-- Modal -->
<div class="modal fade" id="myModallargefilelist" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
<form action="#">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <span style="color: red;">File is too Large to Open & Please download the document !..</span><br><br>
        <button type="submit" class="btn btn-sm icon-btn" name="downloadbtn" id="largedocumentId" value="'+result[1]+'" formaction="OpenAttachForDownload.htm"  formtarget="blank" style="width:25%; margin-left: 70%; padding-right: 5px;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>
	

 <script type="text/javascript">
$("#myTable1").DataTable({	
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	



</script> 
<script type="text/javascript">

$('#fromdate').daterangepicker({
	"singleDatePicker" : true,	
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 "startDate" : new Date('<%=frmDt%>'), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
	
var currentDate = new Date();
var maxDate = currentDate.toISOString().split('T')[0];
console.log(maxDate);

	$('#todate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"startDate" : new Date('<%=toDt%>'), 
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	$(document).ready(function(){
		   $('#fromdate, #todate').change(function(){
		       $('#myform').submit();
		    });
		});
</script>
		<script>
	        // Get PageNo and Row from JSP attributes
	        var pageNoNavigate = <%=PageNo%>;
	        var rowToHighlight  = <%=Row%>;
	        console.log('PageNo'+pageNoNavigate+'Row'+rowToHighlight);
	        
	        if(pageNoNavigate!=null && rowToHighlight!=null){
	        document.addEventListener("DOMContentLoaded", function () {
	        	  // Navigate to the specified page
	            navigateToPage(pageNoNavigate);
	        	
	            // Highlight the specified row
	            highlightRow(rowToHighlight);

	        });
	        
	        }
	        
	        
	        function highlightRow(count) {
	        	var rowElement = document.querySelector('[data-row-id="row-' + count + '"]');
	          	console.log("afsdadasd"+count);
	        	if (rowElement) {
	          
		              	console.log("afsdadasd");
		                rowElement.scrollIntoView();
	            	
		                // Apply the glow animation directly to the element's style
	                	console.log("sdfsxdcf"+count);
	                         rowElement.style.animation = "glow 2s infinite"; // Adjust the duration as needed (in seconds)

	                // Set a timeout to remove the animation after a certain duration (e.g., 6 seconds)
	                 /*   setTimeout(function () {
	                  rowElement.style.animation = "none";
	                     }, 5000); */ // Adjust the duration as needed (in milliseconds)
	            }
	        }

	        function navigateToPage(page) {
	        	  // Assuming you have initialized your DataTable with the id 'myTable1'
	            var table = $("#myTable1").DataTable();

	            // Use DataTables API to go to the specified page
	            table.page(page - 1).draw('page');
   }
	        
	        </script>

</body>
</html>