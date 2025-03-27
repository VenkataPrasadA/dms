<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<%@page import="java.util.List" %>
<%@page import="java.time.LocalTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.dms.FormatConverter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Assigned List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style>

.seekResponseempidSelect{
width: 565px !important;
margin-top: -20px !important;
}

.form-group {
 flex: 1 0 auto;
 margin-bottom:0px;
}

.group1 {
  margin-left:0px;
  display: inline-block;
  max-width: 700px;
  padding-right:50px;
}

.group2 {
 display: inline-block;
   margin-left:0px;
  
}

#casemodel-card-header {
  display: flex;
   color: #114A86;
  justify-content: center;
  align-items: center;
  text-align: center;
  font-size: 1.24rem;
  font-weight: 700;
  color: #114A86;;
  text-shadow: 0 1px 0 #fff;
}

#AssignReply {
    /* Set the desired height for the scrollable area */
    height: 100%;
    /* Add a scroll to the content when it overflows */
    overflow-y: auto;
}
#AssignReply {
    /* Set the desired height for the scrollable area */
    height: 100%;
    /* Add a scroll to the content when it overflows */
    overflow-y: auto;
}

#model-person-header {

  font-size: 1.1rem;
  font-weight: 700;
  color: #8B0000;
  text-shadow: 0 1px 0 #fff;
  padding-top: 10px;
  float: left; 
  margin-left:32px;
}

.replyedit-click{
float: right; 
margin-left:10px;
margin-top:2px;
}

.replyforwardforedit-click{
float: right;
margin-left:10px;
margin-top:2px;
}

.viewmore-click{
    /* background-color: Transparent !important; */
    background-repeat: no-repeat;
    border: none;
    cursor: pointer;
    overflow: hidden;
    outline: none;
    text-align: left !important;
    color:#1176ab;
    font-size: 14px;
    background-color:white;
}
.viewmore-click:hover {
background-color: #f9fcff;
background-image: linear-gradient(147deg, #f9fcff 0%, #dee4ea 74%);

}

.replyAttachWithin-btn{
 color:#0089c7;
 background-color:white;
 font-size:14px;
}

.replyAttachWithin-btn:hover {
   color: royalblue;
  text-decoration: underline;
}

.replyRow {
 margin-bottom: 0; /* Remove the bottom margin of the .replyRow */
 margin-right:2px;
 margin-left:2px;
 
}

.replyremarks-div {
  color: black;
  user-select: all;
  outline: none;
  height: 51px;
/*   border: 1px solid grey; */
  text-align: left;
  padding-left: 10px;
  margin-left: 30px;
  width: 700px !important;
 float: left; 
 box-shadow: rgba(14, 30, 37, 0.32) 0px 0px 0px 3px;
border-radius:3px!important;
  
}

.replyremarks-div button,
.replyremarks-div span {
  user-select: none;
}
.replyModAttachTbl-div{
  float: left; 
}
.downloadReplyAttachTable {
  width: 350px;

}

.downloadReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}
.downloadReplyCSWAttachTable td {
    padding: 0.2rem;
    border:none;
}
.DAKReplysBasedOnReplyId{

box-shadow: rgba(152,152,152, 0.3)0px 2px 4px 0px, rgba(14, 30, 37, 0.32) 0px 2px 16px 0px;
border-radius:2px;
}
.count-badge {
    position: absolute;
    transform: scale(.8);
    transform-origin: top right;
    margin-left: 0rem;
    margin-top: -0.25rem;
    background: red;
    font-family: 'Lato', sans-serif;
 	padding: 0.25em 0.5em;
   	font-size: 13px;
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

.table a:hover,a:focus {
   text-decoration: underline !important; 
}

.downloadDakMainReplyAttachTable {
  width: 350px;

}

.downloadDakMainReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}

.downloadsubDakReplyAttachTable {
  width: 350px;

}

.downloadsubDakReplyAttachTable td {
    padding: 0.2rem;
    border:none;
}
 .nav-link:hover {
    cursor: pointer; /* Use the pointer cursor when hovering over .nav-link */
  }
  
  .HighlightHighPrior{
    background: rgb(223 42 42 / 50%)!important;
}
  
 .custom-selectEmp {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  width: 300px !important;
  padding: 0px !important;
  margin-top: -8px;
  
}

.custom-selectEmp select {
  /* Hide the default select dropdown arrow */
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  /* Add some padding to make room for the arrow */
  padding-right: 20px;
  width: 100%;
  height: 30px;
  /* Customize the look of the dropdown */
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: #fff;
 
}

/* Add a custom arrow */
.custom-selectEmp::after {
  content: '\25BC'; /* Unicode for downward-pointing triangle or arrow */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  /* Customize the arrow appearance */
  font-size: 10px;
  color: #666;
}  

@keyframes fav {
  60% {
    transform: scale(1.5);
  }
  90% {
    transform: scale(1);
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

.spinner {
    position: fixed;
    top: 40%;
    left: 32%;
    margin-left: -50px; /* half width of the spinner gif */
    margin-top: -50px; /* half height of the spinner gif */
    text-align:center;
    z-index:1234;
    overflow: auto;
    width: 1000px; /* width of the spinner gif */
    height: 1020px; /*hight of the spinner gif +2px to fix IE8 issue */
    background: transparent;
} 

.custom-selectEnote {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 300px !important;
  left: 30px;
}

.custom-selectEnote select {
  /* Hide the default select dropdown arrow */
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  /* Add some padding to make room for the arrow */
  padding-right: 20px;
  width: 100%;
  height: 10px;
  /* Customize the look of the dropdown */
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: #fff;
 
}

/* Add a custom arrow */
.custom-selectEnote::after {
  content: '\25BC'; /* Unicode for downward-pointing triangle or arrow */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  /* Customize the arrow appearance */
  font-size: 10px;
  color: #666;
}  
textarea {
           resize: none; /* Disable user resizing */
           overflow-y: hidden; /* Hide vertical scrollbar */
           min-height: 50px; /* Set a minimum height */
       }
       
.Signatory {
  position: relative;
  display: inline-block;
  /* Set a width for your dropdown */
  padding: 0px !important;
  width: 350px !important;

}

.Signatory select {
  /* Hide the default select dropdown arrow */
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  /* Add some padding to make room for the arrow */
  padding-right: 20px;
  width: 100%;
  height: 30px;
  /* Customize the look of the dropdown */
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: #fff;
 
}

/* Add a custom arrow */
.Signatory::after {
  content: '\25BC'; /* Unicode for downward-pointing triangle or arrow */
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  /* Customize the arrow appearance */
  font-size: 10px;
  color: #666;
}  
</style>
</head>
<body>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Assigned List </h5>
			</div>
			
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Assigned List </li>
				  </ol>
				</nav>
			</div>			
		</div>
		</div>
		<!-- Loading  Modal -->
	
<div id="spinner" class="spinner">
                <img id="img-spinner" style="width: 300px;height: 300px; margin-right: 150px;" src="view/images/load.gif" alt="Loading"/>
                </div>
		<!-- Loading  Modal End-->
		</div>
		<%
		long EmpId =(Long)session.getAttribute("EmpId"); 
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		List<Object[]> DakAssignedToMeList=(List<Object[]>)request.getAttribute("DakAssignedList");
		List<Object[]> DakAssignedByMeList=(List<Object[]>)request.getAttribute("DakAssignedByMeList");
		
		List<Object[]> GetAssignEmpList=(List<Object[]>)request.getAttribute("GetAssignEmpList");
		
		List<Object[]> InitiatedByEmployeeList=(List<Object[]>)request.getAttribute("InitiatedByEmployeeList");
		
		List<Object[]> sourceList=(List<Object[]>)request.getAttribute("SourceList");
		
		List<Object[]> EmpListDropDown=(List<Object[]>)request.getAttribute("EmpListDropDown");
		
		String SelEmpId=(String)request.getAttribute("SelEmpId");
		
		String redirectedvalue=(String)request.getAttribute("redirectedvalueForward");
		
		//Redir
		String PageNo=(String)request.getAttribute("pageNoRedirected");
		String Row=(String)request.getAttribute("rowRedirected");
		
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
		<div class="card loadingCard" style="width: 99%; display: none;">
		<div class="card-header" style="height: 3rem">
 <form action="DakAssignedList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
          	   <label class="control-label" style="display: inline-block; margin: 0rem 0.4rem; align-items: center; font-size: 15px;"><b>Employee</b></label>
				<select class="selectpicker custom-selectEmp" id="EmployeeId" required="required" data-live-search="true" name="EmployeeId" style="width: 50%;">
				<option value="All" <% if ( SelEmpId!=null && "All".equalsIgnoreCase(SelEmpId)) { %>selected="selected"<% } %>>All</option>
				<%if (EmpListDropDown != null && EmpListDropDown.size() > 0) {
				for (Object[] obj : EmpListDropDown) {%>
				<option value=<%=obj[0]%> <% if (SelEmpId!=null && SelEmpId.equalsIgnoreCase(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
				<%}}%>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label for="fromdate" style="text-align:  center;font-size: 16px;width:40px; ">From	</label>&nbsp;&nbsp;
              <input type="text" style="width:113px; margin-top: -10px; " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label for="todate" style="text-align: center;font-size: 16px;width:20px; ">To</label>&nbsp;&nbsp;
              <input type="text" style="width:113px;  margin-top: -10px;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
              <input type="hidden" id="redirectedvalue" name="redirectedvalue" value="<%if(redirectedvalue!=null){%><%=redirectedvalue %><%}%>">
              
          </div>
        </div>
      </div>
      </form>
</div>


			<div class="card-body">
					<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  <li class="nav-item" style="width: 50%;"  >
		    <div class="nav-link active" style="text-align: center;" id="pills-OPD-tab" data-toggle="pill" data-target="#pills-OPD" role="tab" aria-controls="pills-OPD" aria-selected="true">
			   <span>Assigned To Me  
				   <span class="badge badge-danger badge-counter count-badge">
				   		<%if(DakAssignedToMeList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DakAssignedToMeList.size() %>
						<%} %>				   			
				  </span>  
				</span> 
		    </div>
		  </li>
		  <li class="nav-item"  style="width: 50%;">
		    <div class="nav-link" style="text-align: center;" id="pills-IPD-tab" data-toggle="pill" data-target="#pills-IPD" role="tab" aria-controls="pills-IPD" aria-selected="false">
		    	 <span>Assigned By Me     
				   <span class="badge badge-danger badge-counter count-badge">
				   		<%if(DakAssignedByMeList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DakAssignedByMeList.size() %>
						<%} %>				   			
				   </span>  
				</span> 
		    
		    
		    </div>
		  </li>
		</ul>
			

	<div class="tab-content" id="pills-tabContent">
			<div class=" tab-pane  show active" id="pills-OPD" role="tabpanel" aria-labelledby="pills-OPD-tab" >
				 
					<div class="table-responsive">
					<form action="#" method="post">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="viewfrom" value="DakAssignedList">
						<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th style="text-align: center;">Head</th>
									<th style="text-align: center;">Source</th>
									<th style="text-align: center;">Ref No & Date</th>
									<th style="text-align: center;">Subject</th>
									<th style="text-align: center;">Assigned By</th>
									<th style="text-align: center;">DAK Status</th>	
									<th style="text-align: center;">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
							int count=1;
							if(DakAssignedToMeList!=null){
							for(Object[] obj:DakAssignedToMeList){ 
							
								 String StatusCountAck = null;
									String StatusCountReply = null;
									 
									if(obj[19]!=null  && obj[18]!=null && Long.parseLong(obj[18].toString())==0
										&& obj[17]!=null && Long.parseLong(obj[17].toString())>0
										&& !obj[19].toString().equalsIgnoreCase("DC") && !obj[19].toString().equalsIgnoreCase("AP")
										&& !obj[19].toString().equalsIgnoreCase("RP") && !obj[19].toString().equalsIgnoreCase("RM")
										&& !obj[19].toString().equalsIgnoreCase("FP") ){	
										StatusCountAck = "Acknowledged["+obj[17]+"/"+obj[15]+"]";
									   }
									
									 if(obj[19]!=null  && obj[17]!=null && Long.parseLong(obj[17].toString())>0
										&& obj[16]!=null && Long.parseLong(obj[16].toString()) > 0
									    && obj[18]!=null && Long.parseLong(obj[18].toString()) > 0
										&& !obj[19].toString().equalsIgnoreCase("DC") && !obj[19].toString().equalsIgnoreCase("AP")
										&& !obj[19].toString().equalsIgnoreCase("RP") && !obj[19].toString().equalsIgnoreCase("RM")
										&& !obj[19].toString().equalsIgnoreCase("FP")	 ){	
										 StatusCountReply  = "Replied["+obj[18]+"/"+obj[16]+"]";
									 }
							
							
							
							%>
								<tr data-row-id=row-<%=count %> id=buttonbackground<%=obj[7]%>>
									<td style="text-align: center;width:10px;"><%=count %></td>
									<td style="text-align: left;width:80px;">
									<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[7] %>','DakAssignedList')">
                                    <% if (obj[0] != null) { %>
                                    <%= obj[0].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
									</td>
									<td style="text-align: center;width:10px;"><%if(obj[10]!=null){ %><%=obj[10].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:70px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:150px;"><%if(obj[2]!=null){ %><%=obj[2].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:180px;"><%if(obj[5]!=null){ %><%=obj[5].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:180px;"><%if(obj[12]!=null && obj[13]!=null){ %><%=obj[12].toString()+','+' '+ obj[13].toString()%><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:80px;">
									<%if(obj[14]!=null) {%>
									
									<%if(StatusCountAck!=null) {%>
									   <%=StatusCountAck%>
									<%}else if(StatusCountReply!=null) {%>
									 <%=StatusCountReply%>
									<%}else{%>
									<%=obj[14].toString() %>
									<%}%>
									<%} %>
									
									</td>
									<td class="wrap"  style="text-align: center;width:150px;">
									<%	 
							     	    int itemsPerPage = 10;
                                        // Calculating the page number based on the count and itemsPerPage
							        	int pageNumber = (count - 1) / itemsPerPage + 1;
							        %>
								<input type="hidden" name=RedirPageNo<%=obj[7]%>  id=PageNoValFetch<%=obj[7]%> value="<%=pageNumber%>">
	 					     	<input type="hidden" name=RedirRow<%=obj[7]%>    id=RowValFetch<%=obj[7]%> value="<%=count%>">
	 					     	
	 					     	<button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[7]%> value="<%=obj[7] %>" 
 										 formaction="DakReceivedView.htm" formtarget="_blank" formmethod="post"
									  data-toggle="tooltip" data-placement="top" title="Preview"> 
 											
															<img alt="mark" src="view/images/preview3.png">
														
 										  </button>
									 <%if(!obj[19].toString().equalsIgnoreCase("RP") && !obj[19].toString().equalsIgnoreCase("FP") && !obj[19].toString().equalsIgnoreCase("RM") && !obj[19].toString().equalsIgnoreCase("AP") && !obj[19].toString().equalsIgnoreCase("DC") && obj[9]!=null && obj[9].toString().equalsIgnoreCase("N")){ %>
 										  <button type="button" class="btn btn-sm icon-btn"  onclick="return replyModal('<%=obj[7]%>','<%=obj[8]%>','<%=obj[0]%>','<%=obj[1] %>',<%=pageNumber%>,<%=count%>)" 
 										  data-toggle="tooltip" data-placement="top" title="Reply">
											<img alt="Reply" src="view/images/replyy.png">
 											</button>
 										<%}else if(obj[9]!=null && obj[9].toString().equalsIgnoreCase("Y")){ %>	
 										Replied
 										<%} %>
 										  
 										  <!--------------DAK Marker SeekResponse Button Start -----------------------------------------------> 									   
 									    	<%if( !obj[19].toString().equalsIgnoreCase("RP") && !obj[19].toString().equalsIgnoreCase("FP") && !obj[19].toString().equalsIgnoreCase("RM") && !obj[19].toString().equalsIgnoreCase("AP") && !obj[19].toString().equalsIgnoreCase("DC")){ %>
 								         <button type="button" class="btn btn-sm icon-btn" onclick="SeekResponse(<%=obj[7]%>,<%=obj[8] %>,'<%=obj[0] %>','<%=obj[1] %>','DakAssignedList')"
 										  data-toggle="tooltip" data-placement="top" title="SeekResponse">
 											<img alt="SeekResponse" src="view/images/SeekResponse.png">
										 </button>
										
 										<%} %> 
 										<%if(obj[20]!=null && Integer.parseInt(obj[20].toString())==0 && obj[18]!=null && Integer.parseInt(obj[18].toString())==0 && !obj[19].toString().equalsIgnoreCase("RP") && !obj[19].toString().equalsIgnoreCase("AP") && !obj[19].toString().equalsIgnoreCase("DC") && obj[22]!=null && Long.parseLong(obj[22].toString())==0){ %>
 										<input type="hidden" id="subjectid<%=obj[7] %>" value="<%=obj[5] %>">
 										<button type="button" class="btn btn-sm icon-btn" data-toggle="tooltip" data-placement="top" title="eNoteReply" onclick="return EnotereplyModal('<%=obj[7]%>','<%=obj[8]%>','<%=obj[0]%>','<%=obj[1] %>',<%=pageNumber%>,<%=count%>,'<%=obj[2] %>','<%=obj[6] %>')" >
 											<img alt="eNoteReply" src="view/images/enotereply.jpg">
										 </button>
 										<%} %>
<!--------------DAK Marker Assign Button End ----------------------------------------------->
									</td>
								</tr>
								<%count++;}} %>
							</tbody>
						</table>
</form>
					</div>
					
					</div>
				
						<!----------------------------------------------------   Div Assigned By Me    ----------------------------------------------------------->

	<div class="card tab-pane " id="pills-IPD" role="tabpanel" aria-labelledby="pills-IPD-tab" >	
       <div class="card-body"> 
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover table-striped table-condensed " id="myTablesecond">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th style="text-align: center;">Head</th>
									<th style="text-align: center;">Source</th>
									<th style="text-align: center;">Ref No & Date</th>
									<th style="text-align: center;">Assigned To</th>
									<th style="text-align: center;">DAK Status</th>
								</tr>
							</thead>
							<tbody>
							<%
							int count1=1;
							if(DakAssignedByMeList!=null){
							for(Object[] obj:DakAssignedByMeList){ 
								 String StatusCountAck = null;
									String StatusCountReply = null;
									 
									if(obj[14]!=null  && obj[13]!=null && Long.parseLong(obj[13].toString())==0
										&& obj[12]!=null && Long.parseLong(obj[12].toString())>0
										&& !obj[14].toString().equalsIgnoreCase("DC") && !obj[14].toString().equalsIgnoreCase("AP")
										&& !obj[14].toString().equalsIgnoreCase("RP") && !obj[14].toString().equalsIgnoreCase("RM")
										&& !obj[14].toString().equalsIgnoreCase("FP")	  ){	
										StatusCountAck = "Acknowledged["+obj[12]+"/"+obj[10]+"]";
									   }
									
									 if(obj[14]!=null  && obj[12]!=null && Long.parseLong(obj[12].toString())>0
										&& obj[11]!=null && Long.parseLong(obj[11].toString()) > 0
									    && obj[13]!=null && Long.parseLong(obj[13].toString()) > 0
										&& !obj[14].toString().equalsIgnoreCase("DC") && !obj[14].toString().equalsIgnoreCase("AP")
										&& !obj[14].toString().equalsIgnoreCase("RP") && !obj[14].toString().equalsIgnoreCase("RM")
										&& !obj[14].toString().equalsIgnoreCase("FP")  ){	
										 StatusCountReply  = "Replied["+obj[13]+"/"+obj[11]+"]";
									 }
							%>
								<tr>
									<td style="text-align: center;width:10px;"><%=count1 %></td>
									<td style="text-align: left;width:80px;">
									<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakAssignedList')">
                                    <% if (obj[1] != null) { %>
                                    <%= obj[1].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
									</td>
									<td style="text-align: center;width:10px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:70px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:150px;"><%if(obj[5]!=null){ %><%=obj[5].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:180px;"><%if(obj[2]!=null && obj[7]!=null){ %><%=obj[2].toString()+','+' '+ obj[7].toString()%><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:80px;">
									<%if(obj[9]!=null) {%>
									<%if(StatusCountAck!=null) {%>
									   <%=StatusCountAck%>
									<%}else if(StatusCountReply!=null) {%>
									 <%=StatusCountReply%>
									<%}else{%>
									<%=obj[9].toString() %>
									<%}%>
									<%} %>
									</td>
								</tr>
								<%count1++;}} %>
							</tbody>
						</table>
					</div>
					</div>
					</div>
	</div>
</div>

						<!----------------------------------------------------   Reply  Modal start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="exampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 50% !important; min-height: 50vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color: white;">DAK Assign Reply</span></b>
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;<span style="color:white;">DAK Id:</span> <span style="color: white;" id="DakAssignReplyDakNo"></span>, &nbsp;&nbsp;<span style="color:white;">Source:</span> <span style="color: white;" id="DakAssignReplySource"></span>&nbsp;
 	      </h5></div>
  	        <button type="button" class="close" style="color: white;" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="AssignattachformReply" id="AssignattachformReply" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control replyTextArea" name="AssignreplyRemarks" style="min-width: 110% !important;min-height: 30vh;"  id="reply" required="required"  maxlength="500" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :</label>
  	      			<div class="col-md-10 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_clone">
			  	      			<td><input class="form-control" type="file" name="dak_Assign_reply_document"  id="dakassigndocumentreply"  accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      			</div>
  	     
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  <input type="hidden" name="dakIdOfAssignReply"  id="dakIdOfAssignReply" value="" >
  	      		  <input type="hidden" name="DakAssignId" id="AssignId" value="">
  	      		  <input type="hidden" name="DakNo" id="DakNo" value="">
  	      		  <input type="hidden" name="FromDate"  value="<%=frmDt%>">
  	      		  <input type="hidden" name="ToDate"  value="<%=toDt%>">
  	      		  
  	      		  <input type="hidden" id="AssignReplyPageNo" name="AssignReplyPageNo"  value="">
  	      		  <input type="hidden" id="AssignReplyRowNo" name="AssignReplyRowNo"  value="">
  	      		  
  	      		    
  	      			<input type="button" formaction="DAKAssignReply.htm"  class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return dakReplyValidation()" > 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 
  <!----------------------------------------------------  Reply  Modal End    ----------------------------------------------------------->
  
  <!----------------------------------------------------   Enote Reply  Modal start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="exampleModalEnoteReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 100% !important; align-items: stretch;" >
 	    <div class="modal-content" >
 	     <div>
 	    <div class="modal-header" style="background-color: #114A86;">
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div><br>
  	      </div>
  	      <form action="DakEnoteReplyAddSubmit.htm" method="POST" id="myform1" data-action="DakEnoteReplyAddSubmit.htm" enctype="multipart/form-data">
 	       <div class="col-md-12 row" style="flex:none !important;">
	    <div class="col-md-6" style="display: inline-block;">
			<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #114A86; padding: 5px; height: 40px;">
			<div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color:white;">DAK eNote Assign Reply</span></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      <b><span style="color: white;">DAK Id:</span></b> &nbsp;&nbsp;<span style="color: white;" id="EnoteDakAssignReplyDakNo">
		         </span> &nbsp;&nbsp;&nbsp;<b><span style="color: white;">Source :</span></b> &nbsp;&nbsp; <span style="color: white;" id="EnoteDakAssignReplySource"></span></h5></div>
		</div>
		<div class="page card dashboard-card">
			<div class="card-body" align="center" >	
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="row">
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label" style="float: left;">Note No </label>
				<input type="text" class="form-control " id="NoteNo" value="" name="NoteNo" >
			</div>
			</div>
			
			        <div class="col-md-4">
			  <div class="form-group">
				<label class="control-label" style="float: left;">Ref Date </label>
				<input type="text" class="form-control" id="EnoteRefDate" value="" name="RefDate" >
				 </div>
				 </div> 
				 
				 <div class="col-md-4">
				<div class="form-group">
			<label class="control-label" style="float: left;">Dak Id</label>
			<input type="text" class="form-control" id="EnoteDakNo" value="" name="DakNo">
			</div>
			</div>
		</div>	
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Reply </label>
		<textarea style="border-bottom-color: gray;width: 100%" oninput="autoResize()"  maxlength="3000" placeholder="Maximum 3000 characters" id="EnoteReply" name="Reply"></textarea>
		</div>
		</div>
		</div>
		<div class="row" style="margin-top: 7px;">
				<div class="col-md-7">
  	      		 <label class="control-label" style=" display: inline-block; float:left; font-size: 15px;"><b>Initiated By</b></label>
			 <select class="selectpicker custom-selectEnote" id="InitiatedBy" required="required" data-live-search="true" name="InitiatedBy"  >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[0].toString()%> <% if (EmpId==Long.parseLong(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	 
				</div>
				</div>
  	     <input type="hidden" id="redirval" name="redirval" value="DakEnoteAdd">
  	     <input type="hidden" name="dakIdValFrReply"  id="EnotedakIdOfAssignReply" value="" >
  	      <input type="hidden" name="DakAssignId" id="EnoteAssignId" value="">
  	     <input type="hidden" name="EnoteFrom"  id="EnoteFrom" value="C" >
  	     <input type="hidden" name="EnoteRoSoEdit" value="EnoteRoSoAdd">
  	     </div>
  	     </div>
  	     </div>
  	      	<div class="col-md-6" style="display: inline-block;">
		<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;background-color: #114A86; padding: 5px; height:40px;">
			Draft
		</div>
		<div class="page card dashboard-card">
		<div class="card-body" align="center" >	
		<div class="row">
			<div class="col-md-4">
			<div class="form-group">
		<label class="control-label" style="float: left;">Letter Date <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control" id="DraftLetterDate" value="" name="LetterDate" >
		</div>
		</div>
		<div class="col-md-4">
			<div class="form-group">
				<label class="control-label" style="float: left;"> Destination <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
		<select class="form-control selectpicker custom-select" id="sourceid" required="required" data-live-search="true" name="DestinationId">
			<% if (sourceList != null && sourceList.size() > 0) {
		for (Object[] obj : sourceList) {
		%>
		<option value="<%=obj[0]%>"><%=obj[1]%></option>
		<%}}%>
					</select>
		     </div>
		 </div>
		 <input type="hidden" name="SourcetypeId" id="SourcetypeId" value="">
		<div class="col-md-4">
			<div class="form-group">
				<label class="control-label" style="float: left;"> Destination Type <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
				<select class="form-control selectpicker custom-select" id="SourceType" name="DestinationTypeId" data-live-search="true" required="required">
				</select>
			</div>
		</div>
		</div>
		
		<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		<label class="control-label" style="float: left;">Content </label>
		<textarea style="border-bottom-color: gray;width: 100%" oninput="autoResizeDraftContent()"  maxlength="3000" placeholder="Maximum 3000 characters" id="DraftContent" name="DraftContent"></textarea>
		</div>
		</div>
		</div>
		<div class="row" style="margin-top: 7px;">
		<div class="col-md-7" style="display: inline-block;">
  	      		 <label class="control-label" style="display: inline-block; float:left; font-size: 15px;"><b>Signatory</b></label>
			<select class="selectpicker Signatory" id="Signatory" required="required"  data-live-search="true" name="Signatory" >
			   <%if (InitiatedByEmployeeList != null && InitiatedByEmployeeList.size() > 0) {
					for (Object[] obj : InitiatedByEmployeeList) {%>
					<option value=<%=obj[0].toString()%> <% if (EmpId==Long.parseLong(obj[0].toString())) { %>selected="selected"<% } %>><%=obj[1].toString()+", "+obj[2].toString()%></option>
						<%}}%>
			      </select>	
		</div>
		<div class="col-md-5" style="display: inline-block;">
			<div class="form-group">
			<label class="control-label" style="display: inline-block; align-items: center; font-size: 15px; "><b>Letter Head</b></label>
			<input style="margin-left: 30px; width: 7%; opacity: inherit;" type="checkbox" id="checkboxone" checked="checked" name="LetterHead" class="checkbox" value="N">
			<label for="checkboxone">No</label>&nbsp;&nbsp;
			<input type="checkbox" style="width: 7%; opacity: inherit;" id="checkboxtwo" class="checkbox" name="LetterHead" value="Y">
			<label for="checkboxtwo">Yes</label>
			</div>
		</div>
		</div>
		</div>
		</div>
		</div>
  	      </div><br>
  	       <div class="col-md-12" style="flex: none !important;">
		   <div class="page card dashboard-card" style="width: 98.5%;">
			<div class="card-body">
			<div class="row">
			<div class="col-md-2" style="display: inline-block;">
			<div class="form-group">
				<label class="control-label" style="float: left;">Ref No <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
				<input type="text" class="form-control" id="EnoteRefNo" value="" name="RefNo" >
			</div> 
			</div>
			<div class="col-md-3">
			<div class="form-group">
			<label class="control-label" style="float: left;">Subject <span class="mandatory" style="color: red; font-weight: normal;">*</span></label>
			<input type="text" class="form-control" id="EnoteSubject" value="" name="Subject" maxlength="255">
			</div>
			</div>
			<div class="col-md-3">
   			<div>
   			<table>
			<tr ><td><label style="font-weight:bold;font-size:16px;">Document :</label></td>
			<td align="right"><button type="button" class="Enotetr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			</tr>
			<tr class="Enotetr_clone">
				<td><input class="form-control" type="file" name="dakReplyEnoteDocument"  id="EditdakEnoteDocument" accept="*/*" ></td>
					<td><button type="button" class="Enotetr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			 			</tr>	
			</table>
				</div>
				</div>
			</div>
			</div>
		</div>
		</div><br>
  	      <div align="center">
		 <input type="button" class="btn btn-primary btn-sm submit " id="Preview" value="Preview" name="sub"  onclick="return forward()">
		</div>
  	      </form>
  	    </div>
  	  </div>
	</div>
 
  <!---------------------------------------------------- Enote  Reply  Modal End    ----------------------------------------------------------->
  
	 <!-- -----------DAK Assign Reply Div Starts --------------------------- --> 	
		 <div class="Assigngroup" id="AssignreplyDetailsMod" style="display:none;" >	
		 <form action="#" method="post" autocomplete="off"  >
		 	   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	   	<div class="modal-body" align="center" style="margin-top:-4px;">
		 	<div class="DakAssignReply modal-dialog-jump" >  
				<!-- all the datas inside this is filled using javascript -->
				</div>
		 </div>
		 </form>
		 </div>
		  <!-- -----------DAK Assign Reply Div Ends --------------------------- --> 
		   <!----------------------------------------------------  Dak Individual Reply View Modal Start    ----------------------------------------------------------->
		<div class="modal fade my-modal" id="IndividualReply-detailedModal" tabindex="-1" role="dialog" aria-labelledby="IndividualReply-detailedModal" aria-hidden="true">
	 	   <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    <div class="modal-content" style="width: 100%;">
	 	      <div class="modal-header">
	 	        <h5 class="modal-title" style="margin-left: 150px;" id="exampleModalLong2Title"><b>Reply Preview</b> </h5>
	  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	  	          <span aria-hidden="true">&times;</span>
	  	        </button>
	  	      </div>
	  	      <div class="modal-body" align="center" >
	  	      <div class="IndividualReplyDetails" >  
	  	      	</div>

	  	      </div>
	  </div>	      
	 </div>
	  </div>
	  <!----------------------------------------------------  Dak Individual Reply View Modal End    ----------------------------------------------------------->
		  
		  <!----------------------------------------------------  Dak Reply View more Modal Start    ----------------------------------------------------------->
	<div class="modal fade my-modal" id="replyViewMore" tabindex="-1" role="dialog" aria-labelledby="exampleModalmarkTitle" aria-hidden="true">
	 	 <div class="modal-dialog modal-lg modal-dialog-jump" role="document"  style="min-width: 90% !important; min-height: 30vh !important; display: flex; align-items: stretch;" >
	 	    	<div class="modal-content" style="min-height: 90%!important;">
	 	     
	 	      <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="casemodel-card-header" style="color: #145374">Assign Reply Data&nbsp; <span id="replierName"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">×</span>
				        </button>
				    </div>
	 	  
	  	     <div class="modal-body" style="padding: 0.5rem !important; height: 50% !importatnt;">
	  	       <div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
	  	           <div class="row" id="replyDetailsDiv">
	  	      		</div>
	  	      	</div>	
	  	      </div>
	  	    
	  	    </div>
	  	  </div>
		</div>
		
		 <!----------------------------------------------------  Dak Reply View more Modal Start    ----------------------------------------------------------->


  <!----------------------------------------------------   DAK Assign Reply Return Edit start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="CSWreplyReturnCommonEditModal" tabindex="-1" role="dialog" aria-labelledby="replyCommonEditTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 95% !important; min-height: 70vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="ReturnexampleModalLongTitle"><b>DAK Assign Reply Return Edit</b></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReplyEditAndDel" id="ReturnattachformReplyEditAndDel" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Return Remarks :</label>
  	      		<div class="col-md-11">
  	      		<textarea class="form-control markedassignReplyReturnDataInEditModal"  name="MarkedassignReplyEditedVal" style="min-width: 110% !important;min-height: 5vh; background-color: white;" readonly="readonly"  id="MarkedReturnreplyEditRemarksData" required="required"  maxlength="255" > </textarea>
  	      		</div>
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control assignReplyReturnDataInEditModal"  name="assignReplyEditedVal" style="min-width: 110% !important;min-height: 30vh;"  id="ReturnreplyEditRemarksData" required="required"  maxlength="500" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :</label>
  	      	<!-- new file add start -->
  	      	<div class="row">
  	      	<div class="col-md-5 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_editreply_return_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_editreply_return">
			  	      			<td><input class="form-control" type="file" name="dak_replyEdit_document"  id="Returndakdocumenteditreply" accept="application/pdf, image/*, text/plain, .csv, .docx, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" ></td>
			  	      				<td><button type="button" class="tr_editreply_return_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      </div>
  	      	<!-- new file add end -->

  	      
  	       	<!-- old file delete,open or download start -->
  	      	<div class="col-md-5 " style="float:left">
  	      	<table class="ReplyEditAttachtable" style="border:none" >
					
					<tbody id="ReturnReplyAttachEditDataFill">
					
					
					</tbody>
				</table>
  	        </div>
  	        </div>
  	      	<!-- old file delete,open or download end -->
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  	<!-- for delete -->
  	      		 <input type="hidden" id="ReturnreplyAttachmentIdFrDelete" name="replyAttachmentIdVal" value="" />
  	      	     <input type="hidden" id="ReturnreplyIdFrAttachDelete" name="replyIdVal" value="" />
  	      		   <!-- for edit -->
  	      		  <input type="hidden" name="dakAssignReplyIdValue"  id="ReturndakAssignReplyIdEdit" value="" >
  	      		  <input type="hidden" name="dakIdFrEdit"  id="ReturndakIdOfAssignReplyEdit" value="" >
  	      		    <input type="hidden" name="empIdFrEdit" id="ReturnempIdOfAssignReplyEdit" value="">
  	      		    <input type="hidden" name="dakAssignIdFrEdit" id="ReturndakAssignIdReplyEdit" value="">
  	      		    
  	      		    <input type="hidden" name="PrevReply" id="PrevReply" value="">
  	      		    <input type="hidden" name="PrevFilePathandFileName" id="PrevFilePathandFileName" value="">
  	      		    
  	      			<input type="button" formaction="DAKAssignReplyReturnDataEdit.htm"  class="btn btn-primary btn-sm submit " id="ReturndakCommonReplyEditAction"   onclick="return dakAssignReplyReturnEditValidation()" value="Submit" > 
  	      	
  	      	
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
 <!----------------------------------------------------  Dak Assign Reply Return Edit End    -----------------------------------------------------------> 

	   
	   <!-- ------------------------------------------------------------------------------------------SeekResponse Modal Start ------------------------------------------------------------------------------------------>
					

   <div class="modal fade my-modal" id="exampleModalSeekResponse"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" >
 	    <div class="modal-content" style="height: 400px;">
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color: white;">DAK Seek Response</span></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color: white;">DAK Id:</span> &nbsp;&nbsp;<span style="color: white;" id="SeekDakNo"></span> &nbsp;&nbsp;&nbsp;<span style="color:white;">Source :</span> <span style="color: white;" id="SeekSourcetype"></span></h5> </div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" ><br>
  	      	<form action="DakSeekResponse.htm" method="post" id="SeekResponseForm">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="row">
  	      		<div class="col-md-3">Employee</div>
  	      		<div class="col-md-9">
  	      			<select class="form-control selectpicker seekResponseempidSelect"  id="DakSeekResponseEmployee" multiple="multiple" data-live-search="true"  required="required"  name="DakSeekCaseWorker">
  	      				
  	      				</select>
  	      			</div>
  	      			<input type="hidden" name="DakMarkingId" id="SeekResponseDakMarkingdakId" value="">
  	      			<input type="hidden" name="DakMarkingIdsel" id="SeekResponseDakMarkingIdsel" value="">
  	      			<input type="hidden" name="SeekResponseRedirectVal" id="SeekResponseRedirectVal" value="">
  	      			<input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
					<input type="hidden" name="PageValBySeekRepsonse" id="PageRedirBySeekRepsonse" value="">
  	      			<input type="hidden" name="RowValBySeekRepsonse" id="RowRedirBySeekRepsonse" value=""> 
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return DakSeekResponseSubmit()"> 
  	      		  </div>
  	      		</div>
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
  	      </div>
  	    </div>
  	  </div>
	</div>
  
  
  
  <!-- -------------------------------------------------------------------------------------------------Assign Modal End  ---------------------------------------------------------------------------->
  

		 <!-- Modal -->
<div id="myModal"  style="margin-left: 10%; margin-top: 50px; width: 80%;"  class="modal">
  <!-- Modal content -->
   <div  class="modal-header" style="background-color: white; border: 1px solid black;">
        <h5 class="modal-title" ></h5>
        <span style="margin-left: 85%; color: red; margin-top: 2px;"></span>
        <button type="button" style="color:red;" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
  <div class="modal-content">
    <div id="modalbodyAssign" style="border: 1px solid black;"></div>
  </div>
</div>
  
  
  <!-- Button to trigger the modal -->
<button type="button" id="openModalBtn" style="display: none;">Open Modal</button>

<!-- PDF Viewer Modal -->
<div class="modal fade" id="myModallarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
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
      <div class="modal-body" >
      <span style="color: red;">File is too Large to Open & Please download the document !..</span><br><br>
        <button type="submit" class="btn btn-sm icon-btn" name="downloadbtn" id="largedocument" value="'+result[1]+'" formaction="OpenAttachForDownload.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>


<!-- Case Worker PDF Viewer Modal -->
<div class="modal fade" id="myModalCSWlarge" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
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
      <div class="modal-body" >
      <span style="color: red;">File is too Large to Open & Please download the document !..</span><br><br>
        <button type="submit" class="btn btn-sm icon-btn" name="cswdownloadbtn" id="cswlargedocument"  formaction="ReplyCSWDownloadAttach.htm"  formtarget="blank" style="width:25%; margin-left: 70%;" data-toggle="tooltip" data-placement="top" title="Download">
          <img alt="attach" src="view/images/download1.png">
        </button>
      </div>
    </div>
  </div>
  </form>
</div>
 <!--------------------------------------------------------SOURCE Modal start--------------------------------------------->

<div class="modal fade" id="modalsource" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content" style="height: 350px;  border:black 1px solid;  width: 100%;">
      <div class="modal-header" style="background-color: #005C97;">
        <h5 class="modal-title" style="color:white;" ><b>Add Source</b></h5>
        <button type="button" class="close" data-dismiss="modal" style="color:white;" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div><br>
      <div class="col-md-12">
      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
     	<div class="row">
                   
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Source Short Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="ShortName" type="text" name="ShortName" required="required" maxlength="20" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                    		<div class="col-md-6">
                        		<div class="form-group">
                            		<label >Source Name <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
                              		<input  class="form-control" id="SourceName" type="text" name="SourceName" required="required" maxlength="100" style="font-size: 15px;width:100%;">
                        		</div>
                    		</div>
                    		
                		</div>
                		<div class="row">
						     <div class="col-md-4">
						          <div class="form-group">
						               <label >Source Address <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
										<input  class="form-control" id="SourceAddress" type="text" name="SourceAddress" required="required" maxlength="100" style="font-size: 15px;width:100%;">
						  		  </div>
							  </div>
						
							  <div class="col-md-4">
								  	<div class="form-group">
								      	<label >Source City <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
										 <input  class="form-control" id="SourceCity" type="text" name="SourceCity" required="required" maxlength="100" style="font-size: 15px;width:100%;">
								     </div>
							  </div>
							  <div class="col-md-4">
								  	<div class="form-group">
								      	<label >Source Pin <span class="mandatory" style="color: red; font-size: 125%">*</span> </label>
										 <input  class="form-control" id="SourcePin" type="text" name="SourcePin" required="required" maxlength="6" onkeypress='return event.charCode >= 48 && event.charCode <= 57'  style="font-size: 15px;width:100%;">
								     </div>
							  </div>
						  		
						 </div>
                		<div class="col-md-12" align="center" style="margin-top: 2.4rem">
	 						     <input type="button" class="btn btn-primary btn-sm submit" value="Add" name="sub" onclick="addsource()" > 
                    		</div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!---------------------------------------------------------SOURCE Modal Ends--------------------------------------------->
			</div>
	
<form action="DakTracking.htm" name="trackingform" id="dakStatusTrackingForm" method="POST" target="_blank" >
		
		<input type="hidden" name="dakId" id="dakIdFrTrackingDakStatus" />
		<input type="hidden" name="redirectValTracking" id="redirectionByTrackingPage" />
		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	</form>
	

</body>

	
<script>
$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
});
	function TrackingStatusPageRedirect(dakid,redirectVal){
		$('#dakIdFrTrackingDakStatus').val(dakid);
		$('#redirectionByTrackingPage').val(redirectVal);
		//Display the received content in new tab
           $('#dakStatusTrackingForm').submit();
	}

const checkboxone = document.getElementById('checkboxone');
const checkboxtwo = document.getElementById('checkboxtwo');

checkboxone.addEventListener('change', function() {
  if (this.checked) {
	  checkboxtwo.checked = false;
  }
});

checkboxtwo.addEventListener('change', function() {
  if (this.checked) {
	  checkboxone.checked = false;
  }
});
</script>

<script>
  // Check if the CountForMsgRedirect string is not null
  var countForMsgMarkerRedirect = "<%= redirectedvalue %>";
  if (countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='AssignedToMe') {
    // Get the button element by ID
   var button = document.querySelector('[id="pills-OPD-tab"]');

    // Scroll to the button element to that view
 /*    button.scrollIntoView(); */
    // Programmatically trigger a click event on the button
    if (button) {
      // Programmatically trigger a click event on the button
      
      button.click();
      
    }
  }else if(countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='AssignedByMe'){
	  var button = document.querySelector('[id="pills-IPD-tab"]');

	    // Scroll to the button element to that view
	 /*    button.scrollIntoView(); */
	    // Programmatically trigger a click event on the button
	    if (button) {
      // Programmatically trigger a click event on the button
       
      button.click();
     
    }
  }
</script>

<script>
  // Get references to the elements
  // Add click event handlers to the tab links
  $("#pills-OPD-tab").click(function() {
	$("#redirectedvalue").val('');
    $("#redirectedvalue").val('AssignedToMe');
  });

  $("#pills-IPD-tab").click(function() {
    $("#redirectedvalue").val('');
    $("#redirectedvalue").val('AssignedByMe');
  });
</script>
<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	

$("#myTableDisp").DataTable({
});

$("#myTable2").DataTable({
});
</script> 
<script type="text/javascript">
$("#myTablesecond").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
     ordering: true

});	

$("#myTableDisp").DataTable({
});

$("#myTable2").DataTable({
});

$(document).ready(function(){	
	$("#sourceid").trigger("change");
	$("#pass").hide();
	$("#fail").hide();
});
$("#sourceid").change(function(){
	var SourceId=$("#sourceid").val();
   $.ajax({
			
			type : "GET",
			url : "getSelectSourceTypeList.htm",
			data : {
				
				SourceId: SourceId
				
			},
			datatype : 'json',
			success : function(result) {
			var result = JSON.parse(result);
			var consultVals= Object.keys(result).map(function(e){
			return result[e]
			})
          $('#SourceType').empty();
			
			var addnew = "addnew";
		    var $newOption = $("<option></option>")
			  .attr("value", addnew)
			  .text("Add New")
			  .css({
			    "background-color": "blue",
			    "color": "white",
			    // Add more styles as needed
			  });

			$('#SourceType').append($newOption);
			for(var c=0;c<consultVals.length;c++)
			{
				
				 $('#SourceType')
		         .append($("<option></option>")
		                    .attr("value", consultVals[c][0])
		                    .text(consultVals[c][3]+'- '+consultVals[c][2])); 
			}
			 $('#SourceType').selectpicker('refresh');
			 $('#SourceType option:eq(1)').prop('selected', true);
			 $('#SourceType').selectpicker('refresh');
			}
});
});

function addsource()
{
  var SourceType= $("#sourceid").val();
  var ShortName=$("#ShortName").val();
  var SourceName=$("#SourceName").val();
  var SourceAddress=$("#SourceAddress").val();
  var SourceCity=$("#SourceCity").val();
  var SourcePin=$("#SourcePin").val();
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
  else if(SourceAddress==null || SourceAddress==='' || SourceAddress==="" || typeof(SourceAddress)=='undefined')
  {
	  alert("Enter Source Address..!");
	  $("#SourceAddress").focus();
	  return false;
  }
  else if(SourceCity==null || SourceCity==='' || SourceCity==="" || typeof(SourceCity)=='undefined')
  {
	  alert("Enter Source City..!");
	  $("#SourceCity").focus();
	  return false;
  }
  else if(SourcePin==null || SourcePin==='' || SourcePin==="" || typeof(SourcePin)=='undefined')
  {
	  alert("Enter Source Pin..!");
	  $("#SourcePin").focus();
	  return false;
  }
  else
	  {
			var x=confirm("Are You Sure To Add ?");
	  
	  if(x)
		  {
		  $.ajax({
			  type : "GET",
				url : "dakSourceAddSubmit.htm",
				data : {
					
					SourceType: SourceType,
					ShortName:ShortName,
					SourceName:SourceName,
					SourceAddress:SourceAddress,
					SourceCity:SourceCity,
					SourcePin:SourcePin
				},
				datatype : 'json',
				success : function(result) {
				var result = JSON.parse(result);
				if(result==1){
					$('#modalsource').modal('hide');
					$("#sourceid").trigger("change");
					$("#pass").addClass("alert alert-success");
					 $("#pass").show();
					 setTimeout(function() {
					        $("#pass").hide();
					      }, 2000);
					 $("#ShortName").val("");
					 $("#SourceName").val(""); 
				}else{
					$('#modalsource').modal('hide');
					$("#sourceid").trigger("change");
					$("#fail").addClass("alert alert-danger");
					 $("#fail").show();
					 setTimeout(function() {
					        $("#fail").hide();
					      }, 2000);
					 $("#ShortName").val("");
					 $("#SourceName").val("");
				}
				}
			});
		  }
	  else
		  {
		  return false;
		  }
	
	  }
}

$('#SourceType').change(function(){
	var SourceType=document.getElementById("SourceType").value;
	  if(SourceType=='addnew'){ 
	  $('#modalsource').modal('show');
	  $("#SourceType").prop("selectedIndex", 0);
}
	  else{
		  $('#modalsource').modal('hide');
	  }
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

$(document).ready(function(){
	   $('#fromdate').change(function(){
	       $('#myform').submit();
	    });
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
		   $('#todate,#EmployeeId').change(function(){
		       $('#myform').submit();
		    });
		});
</script>
<script type="text/javascript">
function replyModal(DakId,AssignId,dakno,source,AssignReplyPageNo,AssignReplyRowNo) {
	 $('#exampleModalReply').modal('show');
	$('#dakIdOfAssignReply').val(DakId);
	$('#AssignId').val(AssignId);
	$('#DakNo').val(dakno);
	$('#DakAssignReplyDakNo').html(dakno);
	$('#DakAssignReplySource').html(source);
	$('#AssignReplyPageNo').val(AssignReplyPageNo);
	$('#AssignReplyRowNo').val(AssignReplyRowNo);

}


function formatDate(dateString) {
    var dateParts = dateString.split("-");
    return dateParts[2] + "-" + dateParts[1] + "-" + dateParts[0];
}

function EnotereplyModal(DakId,AssignId,dakno,source,AssignReplyPageNo,AssignReplyRowNo,RefNo,RefDate) {
	 $('#exampleModalEnoteReply').modal('show');
	 var value=$('#subjectid'+DakId).val();
	$('#EnotedakIdOfAssignReply').val(DakId);
	$('#EnoteAssignId').val(AssignId);
	$('#EnoteDakNo').val(dakno);
	$('#EnoteRefNo').val(RefNo);
	$('#EnoteSubject').val(value);
	$('#EnoteDakAssignReplyDakNo').html(dakno);
	$('#EnoteDakAssignReplySource').html(source);
	$('#EnoteAssignReplyPageNo').val(AssignReplyPageNo);
	$('#EnoteAssignReplyRowNo').val(AssignReplyRowNo);
	var formattedDate = formatDate(RefDate);
    $('#EnoteRefDate').val(formattedDate);
	$('#EnoteRecievedListSourceNo').html(source);
	var selectedDate = moment(formattedDate, 'DD-MM-YYYY');
    $('#EnoteRefDate').data('daterangepicker').setStartDate(selectedDate);
    $('#EnoteRefDate').data('daterangepicker').setEndDate(selectedDate);

}

$('#EnoteRefDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
</script> 
<script type="text/javascript">

var count=1;
$("table").on('click','.tr_clone_addbtn' ,function() {
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.tr_clone_sub' ,function() {
	
var cl=$('.tr_clone').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.tr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});


var count=1;
$("table").on('click','.Enotetr_clone_addbtn' ,function() {
   var $tr = $('.Enotetr_clone').last('.Enotetr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.Enotetr_clone_sub' ,function() {
	
var cl=$('.Enotetr_clone').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.Enotetr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});
</script>

 <script type="text/javascript">

var count=1;
$("table").on('click','.tr_editreply_addbtn' ,function() {
   var $tr = $('.tr_editreply').last('.tr_editreply');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.tr_editreply_sub' ,function() {
	
var cl=$('.tr_editreply').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.tr_editreply');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});
</script>

 <script type="text/javascript">

var count=1;
$("table").on('click','.tr_editreply_return_addbtn' ,function() {
   var $tr = $('.tr_editreply_return').last('.tr_editreply_return');
   var $clone = $tr.clone();
   $tr.after($clone);
  count++;
  $clone.find("input").val("").end();
  

});

$("table").on('click','.tr_editreply_return_sub' ,function() {
	
var cl=$('.tr_editreply_return').length;
	
if(cl>1){
	
   var $tr = $(this).closest('.tr_editreply_return');
   var $clone = $tr.remove();
   $tr.after($clone);
}
   
});
</script>
<script type="text/javascript">
function dakReplyValidation() {
	   var isValidated = false;
	   var replyRemark = document.getElementsByClassName("replyTextArea")[0].value;
	if(replyRemark.trim() !== "") { 
    	isValidated = true;
    }else{
    	isValidated = false;
    }
    
    if (!isValidated) {
        event.preventDefault(); // Prevent form submission
        alert("Please fill in the remark input field.");
      
    
      } else {
          // Retrieve the form and submit it
          var confirmation = confirm("Are you sure you want to reply?");
          if (confirmation) {
         var form = document.getElementById("AssignattachformReply");
           if (form) {
        	   var submitButton = form.querySelector('input[type="button"]');
        	    var formAction = submitButton.getAttribute("formaction");
        	    if (formAction) {
        	        form.setAttribute("action", formAction);
        	        form.submit();
        	    }
           }
         }
      }//else close
      }

function dakEnoteReplyValidation() {
	   var isValidated = false;
	   var replyRemark = document.getElementsByClassName("EnotereplyTextArea")[0].value;
	if(replyRemark.trim() !== "") { 
    	isValidated = true;
    }else{
    	isValidated = false;
    }
    
    if (!isValidated) {
        event.preventDefault(); // Prevent form submission
        alert("Please fill in the remark input field.");
      
    
      } else {
          // Retrieve the form and submit it
          var confirmation = confirm("Are you sure you want to reply?");
          if (confirmation) {
         var form = document.getElementById("EnoteAssignattachformReply");
           if (form) {
        	   var submitButton = form.querySelector('input[type="button"]');
        	    var formAction = submitButton.getAttribute("formaction");
        	    if (formAction) {
        	        form.setAttribute("action", formAction);
        	        form.submit();
        	    }
           }
         }
      }//else close
      }
      
function SeekResponse(DakId,dakmarkingid,dakno,Source,RedirVal) {
    $('#exampleModalSeekResponse').modal('show');
    $('#SeekDakNo').html(dakno);
    $('#SeekSourcetype').html(Source);
    $('#SeekResponseDakMarkingdakId').val(DakId);
    $('#SeekResponseDakMarkingIdsel').val(dakmarkingid);
    $('#SeekResponseRedirectVal').val(RedirVal);
    
    
  //code to redirect to page
	var redirectPageId   = "PageNoValFetch"+DakId;
	var redirectRowId =  "RowValFetch"+DakId;
	var pageElement = document.getElementById(redirectPageId);
	var rowElement = document.getElementById(redirectRowId);
    var pageValue = pageElement ? pageElement.value : null;
	var rowValue = rowElement ? rowElement.value : null;
	$('#PageRedirBySeekRepsonse').val(pageValue);
	$('#RowRedirBySeekRepsonse').val(rowValue);
	//code ends
	
	
    $.ajax({
        type: "GET",
        url: "getoldSeekResponseassignemplist.htm",
        data: {
        	DakId: DakId
        },
        dataType: 'json',
        success: function(result) {
            var consultVals = Object.values(result); // Use Object.values() to get the values of the object
            if (result != null) {
            	 $('#DakSeekResponseEmployee').empty();
                 <%for(Object[] type : GetAssignEmpList){ %>
     		    var optionValue = <%=type[0]%>;
     		    var optionText = '<%=type[1] + ", " + type[2]%>';
     	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
                 for (var c = 0; c < consultVals.length; c++) {
             	 var OldEmpId =consultVals[c][0];
                  if(optionValue==OldEmpId){
                  option.prop('selected', true);
                  option.prop('disabled', true);
               }
           }
                 
                 $('#DakSeekResponseEmployee').append(option);
           <%}%>
                 // Refresh the selectpicker after appending options
                 $('#DakSeekResponseEmployee').selectpicker('refresh');
            }else{
            	 $('#DakSeekResponseEmployee').empty();
                 <%for(Object[] type : GetAssignEmpList){ %>
     		    var optionValue = <%=type[0]%>;
     		    var optionText = '<%=type[1] + ", " + type[2]%>';
     	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
                 $('#DakSeekResponseEmployee').append(option);
           <%}%>
                 // Refresh the selectpicker after appending options
                 $('#DakSeekResponseEmployee').selectpicker('refresh');
            }
           
        }
    }); 
}


function DakSeekResponseSubmit() {
	var Caseworker=$('#DakSeekResponseEmployee').val();
	var shouldSubmit = true;
	var form=document.getElementById('SeekResponseForm');
	if(Caseworker==null || Caseworker=='' || typeof(Caseworker)=='undefined'){
		 alert("Select Employee..!");
	  $("#DakSeekResponseEmployee").focus();
	  shouldSubmit= false;
	}else{
		if(confirm('Are you Sure To Submit ?')){
			  form.submit();/*submit the form */
				}
	}
}
</script> 
	 <script>
	  function returnreplyForwardForEdit(replyid){
			
		  $.ajax({
			    type: "GET",
			    url: "GetAssignReplyReturnEditDetails.htm",
			    data: {
			    	replyid: replyid
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			    	   var data = JSON.parse(result);
			           
			           // Extract the "Remarks" value
			    	   $('.markedassignReplyReturnDataInEditModal').val(data.ReturnRemarks);
			           $('.assignReplyReturnDataInEditModal').val(data.Reply);
			           $('#PrevReply').val(data.Reply);
					   $('#ReturndakAssignReplyIdEdit').val(data.DakAssignReplyId);
			           $('#ReturndakIdOfAssignReplyEdit').val(data.DakId);
			           $('#ReturnempIdOfAssignReplyEdit').val(data.EmpId);
			           $('#ReturndakAssignIdReplyEdit').val(data.DakAssignId);
			           
			           ReturnreplyAttachCommonEdit(replyid);
			       	
					}//if condition close
					
					
				}//successClose
		 });//ajaxClose  
		 $('#CSWreplyReturnCommonEditModal').appendTo('body').modal('show');
		 /*  $('#replyCommonEditModal').modal('show'); */
 } //functionClose 
	
	
	
	 function ReturnreplyAttachCommonEdit(replyid){
	 var PrevFilePathandFileName=[];
		 $.ajax({
			    type: "GET",
			    url: "GetAssignReplyReturnAttachModalList.htm",
			    data: {
			      dakreplyid: replyid
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			        var resultData = JSON.parse(result); 
			      
			        var ReplyAttachTbody = '';
			          for (var z = 0; z < resultData.length; z++) {
			            var row = resultData[z];

			            ReplyAttachTbody += '<tr> ';
			            ReplyAttachTbody += '  <td style="text-align: left;">';
			            ReplyAttachTbody += '  <form action="#" id="AssignIframeFormEditForm">';
			            ReplyAttachTbody += '  <input type="hidden" id="ReturnassignReplyIframeEdit" name="cswdownloadbtn">';
			            ReplyAttachTbody += '    <button type="button" class="btn btn-sm replyAttachWithin-btn"  value="' + row[0] + '" onclick="IframepdfCaseWorkerReply('+row[0]+',1)" name="dakReplyCSWDownloadBtn"   data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
			            ReplyAttachTbody += '  </form>';
			            ReplyAttachTbody += '  </td>';
			            ReplyAttachTbody += '  <td style="text-align: left;">';
			            ReplyAttachTbody +=	'		<button type="button" id="ReturnReplyEditAttachDelete" class="btn btn-sm icon-btn" name="dakEditReplyDeleteAttachId" formaction="AssignReplyAttachDelete.htm"  data-toggle="tooltip" data-placement="top" title="Delete" style="width:100%;"  onclick="ReturndeleteReplyEditAttach('+row[0]+','+row[1]+')" ><img alt="attach" src="view/images/delete.png"></button>';
			            ReplyAttachTbody += '  </td>';
			            ReplyAttachTbody += '</tr> ';
			            PrevFilePathandFileName.push(row[3]+'#'+row[4]);
			          }
			          
			          $('#PrevFilePathandFileName').val(PrevFilePathandFileName);
			          console.log(PrevFilePathandFileName);
			      	$('#ReturnReplyAttachEditDataFill').html(ReplyAttachTbody);
			        
			        
			      }          //if condition close
					
					
				}//successClose
		 });//ajaxClose    
	}//functionClose
	
	
	 function ReturndeleteReplyEditAttach(ReplyAttachmentId,ReplyId){
		 $('#ReturnreplyAttachmentIdFrDelete').val(ReplyAttachmentId);
		 $('#ReturnreplyIdFrAttachDelete').val(ReplyId);
		 
		 var result = confirm ("Are You sure to Delete ?"); 
		 if(result){
			var button = $('#ReturnReplyEditAttachDelete');
			var formAction = button.attr('formaction');
			 
			if (formAction) {
				  var form = button.closest('form');
				  form.attr('action', formAction);
				  form.submit();
				}else{
					console.log('form action not found');
				}
		} else {
		    return false; // or event.preventDefault();
		}
		 
	 }
	
	
	 function  dakAssignReplyReturnEditValidation(){
		 var isValidated = false;
		 var replyRemarkOfEdit = document.getElementsByClassName("assignReplyReturnDataInEditModal")[0].value;
		 if(replyRemarkOfEdit.trim() == "") { 
	    	isValidated = false;
	     }else{
	    	isValidated = true;
	     }
	    
	    if (!isValidated) {
	        event.preventDefault(); // Prevent form submission
	        alert("Please fill in the remark input field.");
	      } else {
	          // Retrieve the form and submit it
	          var confirmation = confirm("Are you sure you want to edit this reply?");
	         
	          if (confirmation) {
	        	  
	        	  var button = $('#ReturndakCommonReplyEditAction');
	   			var formAction = button.attr('formaction');
	   			 
	   			if (formAction) {
	   				  var form = button.closest('form');
	   				  form.attr('action', formAction);
	   				  form.submit();
	   				}else{
	   					console.log('form action not found');
	   				}
	          } else { return false; }
	          
	         
	      }//else close
	 } 
</script>

<!-------------------------------- Individual Reply Preview JavaScript Start(Using Commmon style and sharing reply attach js code ) -------------------------------------------->
<script> 
function IndividualReplyPrev(DakId,EmpId,DakReplyId){
	
    $('#IndividualReply-detailedModal').modal('show');

	$.ajax({
		 type : "GET",
			url : "GetIndividualReplyDetails.htm",
			data : {
				
				dakreplyid : DakReplyId,
				empid : EmpId,
				dakid : DakId
				
				
			},
			datatype : 'json',
			success : function(result) {
				
				if(result !=null){
					 var replyData = JSON.parse(result); // Parse the JSON data
					 
					  // Clear previous data
				        $(".IndividualReplyDetails").empty();
					 
					 for (var i = 0; i < replyData.length; i++) {
						    var row = replyData[i];
						    var repliedPersonName = row[1];
						    var repliedPersonDesig = row[2];
						    var repliedRemarks = row[0];
						    var replyid= row[3];
						    var replyEmpId=row[4];
						    var loggedInEmpId = <%= EmpId %>;
						    
						    
						    var dynamicReplyDiv = $("<div>", { class: "DAKReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
						    dynamicReplyDiv.after("<br>");
						    var h4 = $("<h4>", { class: "RepliedPersonName", id: "model-person-header", text: (i+1)+". "+repliedPersonName+","+repliedPersonDesig });
						    dynamicReplyDiv.append(h4);//appended h4
						   
						    var replyEditButton = $("<button>", {
						    	  type: "button",
						    	  class: "btn btn-sm icon-btn replyedit-click",
						    	  "data-toggle": "tooltip",
						    	  "data-placement": "top",
						    	  title: "Edit",
						    	  onclick: "replyCommonEdit('" + replyid + "')"
						    	});
						    
                           var editImage = $("<img>", { alt: "edit",src: "view/images/writing.png"});
                           replyEditButton.append(editImage);
                          
                           if(replyEmpId == loggedInEmpId){
							      dynamicReplyDiv.append(replyEditButton);// appended replyEditButton //Reply Edit is allowed only if looged in users empId and repliers empId is same
							  }
						    
						    
						    var replyForwardForEditBtn  = $("<button>", {
						    	  type: "button",
						    	  class: "btn btn-sm icon-btn replyforwardforedit-click",
						    	  "data-toggle": "tooltip",
						    	  "data-placement": "top",
						    	  title: "Reply Forward",
						    	  onclick: "replyForwardForEdit('" + replyid + "')"
						    	});
						    
                           var forwardForEditImage = $("<img>", { alt: "edit",src: "view/images/replyChange.png"});
                           replyForwardForEditBtn.append(forwardForEditImage);
                        
                        /*  if(action == 'ReplyForward'){
								 dynamicReplyDiv.append(replyForwardForEditBtn);//appended replyForwardForEditBtn //From Procedure if ReplyAction returns ReplyForward than this  button is allowed
							  } */
                         dynamicReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
                         
                         
						    var innerDiv = $("<div>", { class: "row replyRow" });
						    
						    var formgroup1 = $("<div>", { class: "form-group group1" });
							
						  /*   var replyLabel = $("<label>", { class: "form-control" }).css({ fontweight: "800", fontSize: "16px", color: "#07689f;",display: "inline-block",marginbottom: "0.5rem"}).text("Reply :"); */
				
						    var replyText = repliedRemarks.length < 140 ? repliedRemarks : repliedRemarks.substring(0, 140);
						    var replyDiv = $("<div>", { class: "col-md-12 replyCSW-div", contenteditable: "false" }).text(replyText);
						    
						    if (repliedRemarks.length > 140) {
						        var button = $("<button>", {
						            type: "button",
						            class: "viewmore-click",
						            name: "sub",
						            value: "Modify",
						            onclick: "replyViewMoreModal('" + replyid + "')"
						        }).text("...(View More)");

						        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));

						        replyDiv.append(button, b);
						    }

						
				          formgroup1.append(replyDiv);   
						  innerDiv.append(formgroup1);
                        dynamicReplyDiv.append(innerDiv);
						    
				            // Check if row[8] count i.e DakReplyAttachCount is more than 0
					          if (row[8] > 0) {
					        	  // Call a function and pass row[0] i.e DakReplyId
					              DakReplyAttachPreview(row[3], dynamicReplyDiv);
					            }
                           $(".IndividualReplyDetails").append(dynamicReplyDiv);
                           
                        // Add line break after the textarea and DakReplyDivEnd
             

                           $(".IndividualReplyDetails").append("<br>");
						    
						    
					 }//for loop close
				}//if condition close
				
				
			}
	 });
    
}
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
	                   /* setTimeout(function () {
	                  rowElement.style.animation = "none";
	                     }, 5000); // Adjust the duration as needed (in milliseconds) */
	            }
	        }

	        function navigateToPage(page) {
	        	  // Assuming you have initialized your DataTable with the id 'myTable1'
	            var table = $("#myTable1").DataTable();

	            // Use DataTables API to go to the specified page
	            table.page(page - 1).draw('page');
   }
function forward() {
	        	
		var shouldSubmit=true;
		var DakNo=$('#EnoteDakNo').val();
		var RefNo=$('#EnoteRefNo').val();
		var RefDate=$('#EnoteRefDate').val();
		var Reply=$('#EnoteReply').val();
		var Subject=$('#EnoteSubject').val();
		var NoteNo=$('#NoteNo').val();
		if(NoteNo==null || NoteNo==='' || NoteNo===" " || typeof(NoteNo)=='undefined'){
			alert("Please Enter the Note No...!")
			$('#NoteNo').focus();
			shouldSubmit=false;
		}else if(DakNo==null || DakNo==='' || DakNo===" " || typeof(DakNo)=='undefined'){
			alert("Please Enter the Dak No...!")
			$('#EnoteDakNo').focus();
			shouldSubmit=false;
		}else if(RefNo==null || RefNo==='' || RefNo===" " || typeof(RefNo)=='undefined'){
			alert("Please Enter the Ref No...!")
			$('#EnoteRefNo').focus();
			shouldSubmit=false;
		}else if(RefDate==null || RefDate==='' || RefDate===" " || typeof(RefDate)=='undefined'){
			alert("Please Select the Ref Date...!")
			$('#EnoteRefDate').focus();
			shouldSubmit=false;
		}else if(Subject==null || Subject==='' || Subject===" " || typeof(Subject)=='undefined'){
			alert("Please Enter the Subject...!")
			$('#EnoteSubject').focus();
			shouldSubmit=false;
		}else if(Reply==null || Reply==='' || Reply===" " || typeof(Reply)=='undefined'){
			alert("Please Enter the Reply...!")
			$('#EnoteReply').focus();
			shouldSubmit=false;
		}else{
			var formAction = $('#myform1').data('action');
			if(confirm('Are you Sure To Preview ?')){
				  $('#myform1').attr('action', formAction);
		          $('#myform1').submit(); /* submit the form */
			}
		}

}

function autoResize() {
    const textarea = document.getElementById('EnoteReply');
    textarea.style.height = 'auto'; // Reset height to auto to calculate the actual height
    textarea.style.height = textarea.scrollHeight + 'px'; // Set the height to the scroll height
} 

$('#DraftLetterDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

function autoResizeDraftContent() {
    const textarea = document.getElementById('DraftContent');
    textarea.style.height = 'auto'; // Reset height to auto to calculate the actual height
    textarea.style.height = textarea.scrollHeight + 'px'; // Set the height to the scroll height
}
</script> 
</html>