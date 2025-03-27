<%@page import="java.time.ZoneId"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
<%@page import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>  
<%@ page import="java.time.LocalDateTime, java.time.LocalDate,java.time.format.DateTimeFormatter" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>AUDIT PATCHES</title>
<style>
	.card-header{
		border-bottom: none !important;
		    padding: 0.5rem 1.25rem;
	}
	
	/* table style */
	label {
	font-weight: bold;
	font-size: 13px;
}

.table .font {
	font-family: 'Muli', sans-serif !important;
	font-style: normal;
	font-size: 13px;
	font-weight: 400 !important;
}



.table td {
	padding: 5px !important;
}

.resubmitted {
	color: green;
}

.fa {
	font-size: 1.20rem;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
}

.table-project-n {
	color: #005086;
}

#table thead tr th {
	padding: 0px 0px !important;
}

#table tbody tr td {
	padding: 2px 3px !important;
}

.glow-text {
            color: green;
            text-shadow: 0 0 10px green, 0 0 25px green, 0 0 25px green;
            text-align: center;
        }
.glow-text-red {
            color: red;
            text-shadow: 0 0 10px red, 0 0 25px red, 0 0 25px red;
            text-align: center;
        }
	
	
	/* Customizing the modal animation */
        .modal-dialog {
            transform: translateY(-50px); /* Start with modal above view */
            transition: transform 0.3s ease-out; /* Smooth transition */
        }

        .modal.show .modal-dialog {
            transform: translateY(0); /* Bring modal to center */
        }
</style>
</head>
<body>




<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">AUDIT PATCHES LIST</h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
			<ol class="breadcrumb" >
				<li class="breadcrumb-item ml-auto"><a href="welcome"><i class="fa fa-home"></i> Home</a></li>
				<li class="breadcrumb-item"><a href="AdminDashBoard.htm"><a href="AdminDashBoard.htm"><i class="fa fa-user" ></i> Admin</a></li>
				
				<li class="breadcrumb-item active">Audit Patches List</li>
			</ol>
				</nav>
			</div>			
		</div>
</div>

<%
List<Object[]> AuditPatchesList=(List<Object[]>)request.getAttribute("AuditPatchesList"); 
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat rdf=new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat rdf1 =new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
%>


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></div>
                    <%} %>

<div class="row datatables">
	<div class="col-md-12">
	
 		<div class="card shadow-nohover" >
			<div class="card-body"> 
			<form action="AuditPatchEdit.htm" method="post" style="display: inline">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-striped table-condensed" id="myTableData">
							    <thead style="text-align: center;">
							        <tr>
							            <th>Select</th>
							            <th>Version No</th>
							            <th style="width: 600px">Description</th>
							            <th>Patch Date</th>
							            <th>Updated Date</th>
							            <th>Attachment</th>
							        </tr>
							    </thead>
							    <tbody>
							        <% 
							            int count = 0;
							        	if(AuditPatchesList!=null && AuditPatchesList.size()>0){
							            for (Object[] obj : AuditPatchesList) { 
							                count++; 
							                String description = (String) obj[1];
							                boolean longDescription = description.length() > 90;
							                String shortDescription = description.substring(0, Math.min(description.length(), 90));
							        %>
							        <tr>
							            <td style="text-align: center; vertical-align: middle;">
							                <input type="radio" name="ProjectId" value="<%= obj[4].toString() %>" style="display: block; margin: auto;">
							            </td>
							            <td style="text-align: center;"><%= obj[0] %></td>
							            <td>
										    <span id="short-description-<%= count %>"><%= shortDescription %></span>
										    <% if (longDescription) { %>
										        <span id="dots-<%= count %>" style="display:inline;">...</span>
										        <span id="more-<%= count %>" style="display:none; margin: 0; padding: 0;"><%= description.substring(90) %></span>
										        <span class="btn btn-link" id="toggle-link-<%= count %>" style="margin: 0; padding: 0;" onclick="toggleDescription('<%= count %>')">Show More</span>
										    <% } %>
										    <span style="display: none;" class="full-description" data-description="<%= description %>"></span> <!-- Added this line -->
										</td>
							            <td style="text-align: center;"><%if(obj[5]!=null){%><%=sdf.format(obj[5])%><%}else{ %>-<%} %></td>
							            <%
							           		Date date = sdf1.parse(obj[2].toString());
							            	String updatedate=rdf1.format(date);
							            	LocalDate parsedLocalDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
							                LocalDate currentDate = LocalDate.now();
							                if (parsedLocalDate.isEqual(currentDate)) {
							            %>
							            <td class="glow-text"><%= updatedate %></td>
							            <% } else { %>
							            <td class="glow-text-red"><%= updatedate %></td>
							            <% } %>
							            <td style="text-align: center;">
							                <% if(obj[3] != null) { %>
							                    <a href="PatchesAttachDownload.htm?attachid=<%= obj[4] %>" target="_blank" title="Download">
							                        <i class="fa fa-download fa-2x" aria-hidden="true" style="width: 15px;"></i>
							                    </a>
							                <% } else { %>
							                    --
							                <% } %>
							            </td>
							        </tr>
							        <% }} %>
							    </tbody>
							</table>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                        <div align="center">
                        	<%if(AuditPatchesList.size()>0){ %>
                            <button type="button" class="btn btn-warning btn-custom" onclick="triggerEditModal()">Edit</button><%} %>
                        </div>
    			
</div>


</div>
</div>
</div>


  <!-- Modal Structure -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Patch</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" font-size: 25px">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editPatchForm" action="AuditPatchEditSubmit.htm" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <input type="hidden" id="auditIdEdit" name="auditId" />
                        <div class="form-group">
                            <label for="versionNoEdit">Version No:</label>
                            <input type="text" id="versionNoEdit" name="versionNo" class="form-control" maxlength="10" readonly="readonly">
                        </div>
                        <div class="form-group">
                            <label for="DescriptionEdit">Description:</label>
                            <textarea id="DescriptionEdit" name="Description" class="form-control" rows="4" maxlength="200" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="fileEdit">Attachment:</label>
                            <input type="file" id="fileEdit" name="file" class="form-control" accept=".sql,.txt" oninput="return validateFileEdit()">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-success">Submit</button>
                        </div>
                        <p style="margin-bottom: 5px; color: red">*Please attach .sql or .txt file only</p>
						<p style="margin-bottom: 5px; color: red">*Attachment size should be less than 100KB</p>

                    </form>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            // DataTable initialization
            $("#myTableData").DataTable({
                "lengthMenu": [5, 10, 25, 50, 75, 100],
                "pagingType": "simple",
                "pageLength": 5
            });
        });

        function toggleDescription(id) {
            var dots = document.getElementById("dots-" + id);
            var moreText = document.getElementById("more-" + id);
            var toggleLink = document.getElementById("toggle-link-" + id);

            if (dots.style.display === "inline") {
                dots.style.display = "none"; // Hide the dots
                moreText.style.display = "inline"; // Show the additional text
                toggleLink.innerHTML = "Show Less"; // Change the button text to "Show Less"
            } else {
                dots.style.display = "inline"; // Show the dots
                moreText.style.display = "none"; // Hide the additional text
                toggleLink.innerHTML = "Show More"; // Change the button text to "Show More"
            }
        }


        function triggerEditModal() {
            var selected = document.querySelector('input[name="ProjectId"]:checked');
            if (selected) {
                // Populate the modal with data
                var row = selected.closest("tr");
                document.getElementById("auditIdEdit").value = selected.value;
                document.getElementById("versionNoEdit").value = row.cells[1].innerText;

                // Get the full description from the hidden span
                var fullDescription = row.querySelector('.full-description').getAttribute('data-description');
                document.getElementById("DescriptionEdit").value = fullDescription;

                $('#editModal').modal('show');
            } else {
                alert("Please Select a Record ...!");
            }
        }


     // File validation for Edit modal
        function validateFileEdit() {
            var fileInput = document.getElementById('fileEdit');
            var filePath = fileInput.value;

            // Check the file extension
            var allowedExtensions = /(\.txt|\.sql)$/i;
            if (!allowedExtensions.exec(filePath)) {
                alert('Please upload a file with .sql or .txt extension.');
                fileInput.value = ''; // Reset file input
                return false;
            }

            // Check the file size (1 KB = 1024 bytes)
            var fileSize = fileInput.files[0].size;
            if (fileSize > 102400) {
                alert('File size must be less than 100 KB.');
                fileInput.value = ''; // Reset file input
                return false;
            }

            return true;
        }
    </script>







</body>
</html>