<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ADMIN DASHBOARD</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/webresources/css/dashboard.css" var="dashboardCss" />
<link href="${dashboardCss}" rel="stylesheet" />
<style>

</style>
</head>
<body>

<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">ADMIN </h5>
			</div>
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item active " aria-current="page"> Admin </li>
				  </ol>
				</nav>
			</div>			
		</div>
</div>	
		  
<%List<Object[]> DashBoardFormUrlList=(List<Object[]>)request.getAttribute("DashBoardFormUrlList"); %>

<%-- <div class="row" >
	<div class="col-md-12">
	
		<div class="container" >

			<%if(DashBoardFormUrlList!=null&&DashBoardFormUrlList.size()>0){ %>
			<div class="row" >
	
				<%int count=1;
				for(Object[] obj:DashBoardFormUrlList){ %>

				<div class="col-md-3" >
					<%if(count%2==0){ %>
						
						<a class="btn shadow-nohover  btn-primary-1 btn-block btn-sm" href="<%=obj[1] %>" style="text-align: left">
							<span class="fa-stack" style="width:3em !important">
				    			<span class="fa fa-square-o fa-stack-2x"></span>
				   					<strong class="fa-stack-1x" style="font-size: 14px"><%=count %></strong>
							</span>
							<i ><%=obj[0] %></i>
						</a>
							
						<%}else{ %>
							
						<a class="btn shadow-nohover btn-primary-2 btn-block btn-sm" href="<%=obj[1] %>" style="text-align: left">
							<span class="fa-stack" style="width:3em !important">
				    			<span class="fa fa-square-o fa-stack-2x"></span>
				   					<strong class="fa-stack-1x" style="font-size: 14px"> <%=count %></strong>
								</span>
								<i ><%=obj[0] %></i>
						</a>
							
						<%} %>
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

	</div>
	</div>
</div> --%>


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