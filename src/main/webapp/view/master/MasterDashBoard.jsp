<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MASTER DASHBOARD</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<link href="${dashboardCss}" rel="stylesheet" />
<style type="text/css">


</style>

</head>
<body>
<div id="wrapper">
			<div id=" sub-container">
<div class="row">
<div class="col-md-12">

<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">MASTER </h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item active " aria-current="page"> Master </li>
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
<div class="alert alert-danger" role="alert" align="center">
<%=ses1 %>
 </div></div>
<%}if(ses!=null){ %>
<div align="center">
<div class="alert alert-success" role="alert" align="center">
<%=ses %>
</div></div>
<%} %>

<%List<Object[]> DashBoardFormUrlList=(List<Object[]>)request.getAttribute("DashBoardFormUrlList"); %>
	<div class="datatables">
	  <section id="minimal-statistics">
	 
	 	<%if(DashBoardFormUrlList!=null&&DashBoardFormUrlList.size()>0){ %>
	 
	    <div class="row">
	    
	    	<%int count=1;
				for(Object[] obj:DashBoardFormUrlList){ %>
	    
	      <div class="col-xl-3 col-sm-6 col-12">

	        <a class="card card-shadow" href="<%=obj[1] %>">
	          <div class="card-content" data-toggle="tooltip" data-placement="top" title="<%=obj[3].toString() %>">
	            <div class="card-body">
	              <div class="media d-flex">
	                <div class="media-body text-left">
	                  <h6 class="primary" style="font-weight:700"><%=obj[0] %></h6>
	                </div>
	                <div class="align-self-center">
	                  <i class="<%=obj[2] %> float-right size"></i>
	                </div>
	              </div>
	             	<div class="progress mt-1 mb-0" style="height: 7px;">
	                <div class="progress-bar progress" role="progressbar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
	              </div> 
	            </div>
	          </div>
	        </a>
	        
	      </div>
	      
	      	<%count++;
				} %>
	      
	      
	    </div>
	    
	    <%}else{ %>

		<div class="row" >
			<div class="col-md-5"></div>
			<div class="col-md-2 badge badge-warning">No Module Found</div>
		</div>
		
		<%} %>
	    
	  </section>
	  
	</div>

</body>
</html>