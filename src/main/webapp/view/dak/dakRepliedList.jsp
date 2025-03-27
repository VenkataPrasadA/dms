<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List" %>
<%@page import="java.time.LocalTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.dms.FormatConverter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DAK Replied List</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<jsp:include page="../static/commonModals.jsp"></jsp:include>
<style type="text/css">
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
</style>
</head>
<body>
<div class="page-wrapper">
<div class="card-header page-top">
		<div class="row">
			<div class="col-md-3 heading-breadcrumb">
				<h5 style="font-weight: 700 !important">DAK Replied List</h5>
			</div>
			
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Replied List </li>
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
		List<Object[]> DakRepliedToMeList=(List<Object[]>)request.getAttribute("DakRepliedToMeList");
		List<Object[]> DakRepliedByMeList=(List<Object[]>)request.getAttribute("DakRepliedByMeList");
		
		String redirectedvalue=(String)request.getAttribute("redirectedvalueForward");
		
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
 <form action="DakRepliedList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
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
			   <span>Replied To Me  
				   <span class="badge badge-danger badge-counter count-badge">
				   		<%if(DakRepliedToMeList!=null && DakRepliedToMeList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DakRepliedToMeList.size() %>
						<%} %>				   			
				  </span>  
				</span> 
			  
			  
		    </div>
		  </li>
		  <li class="nav-item"  style="width: 50%;">
		    <div class="nav-link" style="text-align: center;" id="pills-IPD-tab" data-toggle="pill" data-target="#pills-IPD" role="tab" aria-controls="pills-IPD" aria-selected="false">
		    	 <span>Replied By Me     
				   <span class="badge badge-danger badge-counter count-badge">
				   		<%if(DakRepliedByMeList!=null && DakRepliedByMeList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DakRepliedByMeList.size()%>
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
				  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				 <input type="hidden" name="viewfrom" value="DakRepliedList">
						<table class="table table-bordered table-hover table-striped table-condensed " id="myTablesecond">
						
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th style="text-align: center;">Head</th>
									<th style="text-align: center;">Source</th>
									<th style="text-align: center;">Ref No & Date</th> 
									<th style="text-align: center;">Action Due</th>
									<th style="text-align: center;">Subject</th>
									<th style="text-align: center;">DAK Status</th>	
									<th style="text-align: center;">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
							int count1=1;
							 String DakStat = null;
							if(DakRepliedToMeList!=null && DakRepliedToMeList.size()>0){
							for(Object[] obj:DakRepliedToMeList){ 
								 if (obj[5] != null){
                           		  DakStat = obj[5].toString();
                           		  
                           			//obj[27] - CountOfAllMarkers//obj[28] - CountOfActionMarkers//obj[29] - CountOfMarkersAck//obj[30] - CountOfMarkersReply
                               	    String CountAck = null;
                               		String CountReply = null;

                                       if (!DakStat.equalsIgnoreCase("DC") && !DakStat.equalsIgnoreCase("AP")
                                           && !DakStat.equalsIgnoreCase("RP") && !DakStat.equalsIgnoreCase("RM")
                                           && !DakStat.equalsIgnoreCase("FP")) {
                                      //Ack Count
                                           if (obj[18] != null && Long.parseLong(obj[18].toString()) > 0) {
                                               CountAck = "Acknowledged<br>[" + obj[18] + "/" + obj[16] + "]";
                                           }
                                      
                                       }    
							
							%>
								<tr  data-row-id=row-<%=count1 %>  id=buttonbackground<%=obj[0]%>>
									<td style="text-align: center;width:10px;"><%=count1 %></td>
									<td style="text-align: left;width:80px;">
									<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakAssignedList')">
                                    <% if (obj[8] != null) { %>
                                    <%= obj[8].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
									</td>
									<td style="text-align: center;width:10px;"><%if(obj[15]!=null){ %><%=obj[15].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:70px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:150px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:100px;"><%if(obj[10]!=null){%><%=sdf.format(obj[10])%><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:180px;"><%if(obj[12]!=null){ %><%=obj[12].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:80px;">
									<%if(obj[7]!=null) {%><%if(CountAck!=null) {%> <%=CountAck%><%}%><%}%>
									</td>
									<td class="wrap"  style="text-align: center;width:150px;">
									<%
								 
								 int itemsPerPage = 10;
                               // Calculating the page number based on the count and itemsPerPage
								int pageNumber = (count1 - 1) / itemsPerPage + 1;

							%>
							 <input type="hidden"  name=RedirPageNo<%=obj[0]%>  id=PageNoValFetch<%=obj[0]%> value="<%=pageNumber%>">
							 <input type="hidden"  name=RedirRow<%=obj[0]%>     id=RowValFetch<%=obj[0]%>    value="<%=count1%>">
							 <input type="hidden" name="repliedReply" value="DakRepliedToMe">
 										<button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]%> value="<%=obj[0] %>" 
 										 formaction="DakReceivedView.htm" formmethod="post" formtarget="_blank"
									  data-toggle="tooltip" data-placement="top" title="Preview"> 
 											<img alt="mark" src="view/images/preview3.png">
 										  </button>
 										    <button type="button" class="btn btn-sm icon-btn"  onclick="return replyModalOfMarker('<%=obj[0] %>','<%=EmpId%>','<%=obj[19] %>','<%=obj[8] %>','<%=obj[3] %>','<%=obj[20] %>')" 
 												data-toggle="tooltip" data-placement="top" title="Reply">
 												<img alt="Reply" src="view/images/replyy.png">
											</button> 
									</td>
								</tr>
								<%}count1++;}} %>
							</tbody>
						</table>
</form>
					</div>
					
					
					</div>
				
						<!----------------------------------------------------   Div Replied By Me    ----------------------------------------------------------->

	<div class="card tab-pane " id="pills-IPD" role="tabpanel" aria-labelledby="pills-IPD-tab" >	
       <div class="card-body"> 
       
       <div class="table-responsive">
       <form action="#" method="post">
        <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
       <input type="hidden" name="viewfrom" value="DakRepliedList">
						<table class="table table-bordered table-hover table-striped table-condensed " id="myTable1">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th style="text-align: center;">Head</th>
									<th style="text-align: center;">Source</th>
									<th style="text-align: center;">Ref No & Date</th>
									<th style="text-align: center;">Subject</th>
									<th style="text-align: center;">DAK Status</th>
									<th style="text-align: center;">Action</th>
								</tr>
							
							</thead>
							<tbody>
							<%
							int count=1;
							if(DakRepliedByMeList!=null && DakRepliedByMeList.size()>0){
							for(Object[] obj:DakRepliedByMeList){ 
								 if (obj[5] != null){
	                           		  DakStat = obj[5].toString();
	                           		  
	                           			//obj[27] - CountOfAllMarkers//obj[28] - CountOfActionMarkers//obj[29] - CountOfMarkersAck//obj[30] - CountOfMarkersReply
	                               	    String CountAck = null;
	                               		String CountReply = null;

	                                       if (!DakStat.equalsIgnoreCase("DC") && !DakStat.equalsIgnoreCase("AP")
	                                           && !DakStat.equalsIgnoreCase("RP") && !DakStat.equalsIgnoreCase("RM")
	                                           && !DakStat.equalsIgnoreCase("FP")) {
	                                      //Ack Count
	                                           if (obj[25] != null && Long.parseLong(obj[25].toString()) == 0 && obj[24] != null && Long.parseLong(obj[24].toString()) > 0) {
	                                               CountAck = "Acknowledged<br>[" + obj[24] + "/" + obj[22] + "]";
	                                           }
	                                      //Reply Count
	                                           if (obj[24] != null && Long.parseLong(obj[24].toString()) > 0 && obj[23] != null && Long.parseLong(obj[23].toString()) > 0
	                                               && obj[25] != null && Long.parseLong(obj[25].toString()) > 0) {
	                                               CountReply = "Replied<br>[" + obj[25] + "/" + obj[23] + "]";
	                                           }
	                                       }    
							%>
								<tr  data-row-id=row-<%=count %> id=buttonbackground<%=obj[0]%>>
									<td style="text-align: center;width:10px;"><%=count %></td>
									<td style="text-align: left;width:50px;">
									<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakAssignedList')">
                                    <% if (obj[8] != null) { %>
                                    <%= obj[8].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
									</td>
									<td style="text-align: center;width:10px;"><%if(obj[16]!=null){ %><%=obj[16].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:30px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:50px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %><br><%if(obj[6]!=null){%><%=sdf.format(obj[6])%><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:180px;"><%if(obj[12]!=null){ %><%=obj[12].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: center;width:100px;">
									<%if(obj[7]!=null) {%><%if(CountAck!=null) {%> <%=CountAck%><%}else if(CountReply!=null) {%><%=CountReply%><%}else{%><%=obj[7].toString() %><%}%><%} %>
									</td>
									<td class="wrap"  style="text-align: center;width:80px;">
								<%
										 int itemsPerPage = 10;
                              			 // Calculating the page number based on the count and itemsPerPage
											int pageNumber = (count - 1) / itemsPerPage + 1;

										%>
							   		 <input type="hidden" name=RedirPageNo<%=obj[0]%>  id=PageNoValFetch<%=obj[0]%> value="<%=pageNumber%>">
									 <input type="hidden" name=RedirRow<%=obj[0]%>    id=RowValFetch<%=obj[0]%> value="<%=count%>">
									 <button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]%> value="<%=obj[0] %>"  
									 formaction="DakReceivedView.htm" formtarget="_blank"
									      data-toggle="tooltip" formmethod="post" data-placement="top" title="Preview"> 
 										 <img alt="mark" src="view/images/preview3.png">
								       </button>
								        <%if(obj[21]!=null && obj[21].toString().equalsIgnoreCase("Y") && !obj[5].toString().equalsIgnoreCase("RM") && !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("FP") && !obj[5].toString().equalsIgnoreCase("AP") && !obj[5].toString().equalsIgnoreCase("DC") ){ %>
 								         <button type="button" class="btn btn-sm icon-btn" onclick="return Assign(<%=obj[0]%>,<%=obj[19] %>,'<%=obj[8] %>','<%=obj[3] %>','DakRepliedList')"
 										  data-toggle="tooltip" data-placement="top" title="Assign">
 											<img alt="Assign" src="view/images/Assign.png">
										 </button>
										
 										<%} %>
 										
 											<%if(obj[21]!=null && obj[21].toString().equalsIgnoreCase("Y") && !obj[5].toString().equalsIgnoreCase("RP") && !obj[5].toString().equalsIgnoreCase("FP") && !obj[5].toString().equalsIgnoreCase("RM") && !obj[5].toString().equalsIgnoreCase("AP") && !obj[5].toString().equalsIgnoreCase("DC")){ %>
 								         <button type="button" class="btn btn-sm icon-btn" onclick="SeekResponse(<%=obj[0]%>,<%=obj[19] %>,'<%=obj[8] %>','<%=obj[3] %>','DakRepliedList')"
 										  data-toggle="tooltip" data-placement="top" title="SeekResponse">
 											<img alt="SeekResponse" src="view/images/SeekResponse.png">
										 </button>
										
 										<%} %> 
									</td>
								</tr>
								<%}count++;}} %>
							</tbody>
						</table>
					</form>
					</div>
					
					</div>
					</div>
					
	</div>
	</div>
					<!-- ------------------------------------------------------------------------------------------Assign Modal Start ------------------------------------------------------------------------------------------>
					

   <div class="modal fade my-modal" id="exampleModalAssign"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" >
 	    <div class="modal-content" style="height: 400px;">
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color: white;">DAK Assign</span></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color: white;">DAK Id:</span> &nbsp;&nbsp;<span style="color: white;" id="DakNo"></span> &nbsp;&nbsp;&nbsp;<span style="color:white;">Source :</span> <span style="color: white;" id="Sourcetype"></span></h5> </div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" ><br>
  	      	<form action="DakAssign.htm" method="post" id="AssignForm">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="row">
  	      		<div class="col-md-3">Facilitator</div>
  	      		<div class="col-md-9">
  	      			<select class="form-control selectpicker cswempidSelect"  id="DakCaseWorker" multiple="multiple" data-live-search="true"  required="required"  name="DakCaseWorker">
  	      								
  	      				</select>
  	      			</div><br><br><br>
  	      			<div class="col-md-3">Remarks</div>
  	      		<div class="col-md-9">
  	      				<textarea class="form-control" style="height: 100px;;"   name="remarks"  id="remarks" required="required"  maxlength="255" > </textarea>
  	      			</div>
  	      			<input type="hidden" name="DakMarkingId" id="DakMarkingdakId" value="">
  	      			<input type="hidden" name="DakMarkingIdsel" id="DakMarkingIdsel" value="">
  	      			<input type="hidden" name="RedirectValue" id="RedirectValue" value="">
  	      			<input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
					<input type="hidden" id="PageRedirByAssign"  name="PageRedireData" value="">
					<input type="hidden" id="RowRedirByAssign" name="RowRedireData" value="">
					<input type="hidden" name="redirectedvalue" value="<%if(redirectedvalue!=null){%><%=redirectedvalue %><%}%>">
  	      		  <div class="col-md-12"  align="center">
  	      		  <br><br>
  	      			<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return DakAssignSubmit()"> 
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
 
 
  <!-- ------------------------------------------------------------------------------------------SeekResponse Modal Start ------------------------------------------------------------------------------------------>
					

   <div class="modal fade my-modal" id="exampleModalSeekResponse"  tabindex="-1" role="dialog" aria-labelledby="exampleModalAssignTitle" aria-hidden="true" >
 	  <div class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump" role="document" >
 	    <div class="modal-content" style="height: 400px;">
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color: white;">DAK SeekResponse</span></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="color: white;">DAK Id:</span> &nbsp;&nbsp;<span style="color: white;" id="SeekDakNo"></span> &nbsp;&nbsp;&nbsp;<span style="color:white;">Source :</span> <span style="color: white;" id="SeekSourcetype"></span></h5> </div>
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
  	      				<%-- <%
											if (GetAssignEmpList != null && GetAssignEmpList.size() > 0) {
												for (Object[] obj : GetAssignEmpList) {
											%>
											<option value="<%=obj[0]%>"><%=obj[1]+", "+obj[2]%></option>
											<%}}%> --%>
  	      				</select>
  	      			</div>
  	      			<input type="hidden" name="DakMarkingId" id="SeekResponseDakMarkingdakId" value="">
  	      			<input type="hidden" name="DakMarkingIdsel" id="SeekResponseDakMarkingIdsel" value="">
  	      			<input type="hidden" name="SeekResponseRedirectVal" id="SeekResponseRedirectVal" value=""> 
  	      			<input type="hidden" name="redirectedvalue" value="<%if(redirectedvalue!=null){%><%=redirectedvalue %><%}%>">
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
	<!----------------------------------------------------   Reply  Modal Start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="exampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 95% !important; min-height: 70vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="exampleModalLongTitle"><b><span style="color:white;">DAK Reply</span></b>
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><span style="color: white;">DAK Id:</span></b> &nbsp;&nbsp;<span style="color: white;" id="RecievedListDakNo">
		         </span> &nbsp;&nbsp;&nbsp;<b><span style="color: white;">Source :</span></b> &nbsp;&nbsp; <span style="color: white;" id="RecievedListSourceNo"></span></h5></div>
  	        <button type="button" class="close" data-dismiss="modal" style="color: white;" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
  	      	<form action="#" name="attachformReply" id="attachformReply" enctype="multipart/form-data" method="post" >
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	         
  	      
  	      		   <div class="col-md-12" align="left" style="margin-left: 0px;width:100%;">
  	      	
  	      		<label style="font-weight:bold;font-size:16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<!-- <div class="col-md-2">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></div> -->
  	      		     <div class="col-md-9">
  	      				<textarea class="form-control replyTextArea"  name="replyRemarks" style="min-width: 135% !important;min-height: 30vh;"  id="reply" required="required"  maxlength="1000"  oninput="checkCharacterLimit()"> </textarea>
  	      			</div>
  	      			<br>
  	      				<label style="font-weight:bold;font-size:16px;">Document :</label>
  	      		
  	      		<div class="row">
  	      		    <!-- new file add start -->
  	      			<div class="col-md-5 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_clone">
			  	      			<td><input class="form-control" type="file" name="dak_reply_document"  id="dakdocumentreply" accept="*/*"></td>
			  	      				<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      			</div>
  	      			<!-- new file add end -->
  	      			
  	      			<!--copy files attached & delete those copy Start-->
  	      			<div class="col-md-5 " style="float:left;margin-top:-42px;">
  	      				<br>
  	      	       <table class="ReplyCopyAttachtable" style="border:none;" >
					
					<tbody id="ReplyCopyAttachDataFill">
					
					
					</tbody>
					</table>
  	      			</div>
  	      			<!--copy files attached & delete those copy End-->
  	      		</div>
  	     
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  <input type="hidden" name="dakIdValFrReply"  id="dakIdOfReply" value="" >
  	      		    <input type="hidden" name="EmpIdValFrValue" id="empIdOfReply" value="">
  	      		    <input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
										<!-- codee -->
					<input type="hidden" name="PageRedirectData" id="PageRedirByReply" value="">
  	      		    <input type="hidden" name="RowRedirectData" id="RowRedirByReply" value="">
  	      		    
  	      		     <input type="hidden"  name="RedirectValFrmPending" value="RedirToDakRepliedList">
  	      		    
					<input type="hidden" id="AttachsFromDakAssigner" name="AttachmentsFileNames" value="">

				
	
					
  	      		    
  	      			<input type="button" formaction="DAKReply.htm"  class="btn btn-primary btn-sm submit" id="sub" value="Submit" name="sub"  onclick="return dakReplyValidation()" > 
  	      		  </div>
  	      		</div>
  	      		<br>
  	
  	      	</form>
  	      	
  	      
      <!-- -----------DAK MultipleCaseworkerReply Of Specific MarkerDiv Within another Modal START --------------------------- --> 	
	
	
	 <!-- -----------DAK MultipleCaseworkerReply Of Specific MarkerDiv Within another Modal START --------------------------- --> 	
		 <div class="group" id=CSWReplyOfParticularMarker style="display:none;">	
		 	<form action="#" method="post" autocomplete="off" id="CSWOfParticularMarkerPreviewForm" >
		 	   	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 	<div class="modal-body" align="center" style="margin-top:-4px;">
				<div class="col-md-12" id="MarkerReplyModalCaseworkerPreview">
				<h5>Facilitator's Reply Details <span style="color:blue;" class="MarkerNameAndDesigDisplay"></span></h5>
				<div class="MarkerCaseworkersDakReplyData"  style="margin-left: 0px;width:100%;">  
				<!-- all the datas inside this is filled using javascript -->
				</div>
				</div>
					</div>		
					</form>
			
		 </div>
		 </div>
  	      	</div>
  	      	</div>
  	      	</div>
</div>
    	
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
 		
 	</script>

<script>
  // Check if the CountForMsgRedirect string is not null
  var countForMsgMarkerRedirect = '<%= redirectedvalue %>';
  if (countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='RepliedToMe') {
    // Get the button element by ID
   var button = document.querySelector('[id="pills-OPD-tab"]');

    // Scroll to the button element to that view
 /*    button.scrollIntoView(); */
    // Programmatically trigger a click event on the button
    if (button) {
      // Programmatically trigger a click event on the button
      
      button.click();
      
    }
  }else if(countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='RepliedByMe'){
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
    $("#redirectedvalue").val('RepliedToMe');
  });

  $("#pills-IPD-tab").click(function() {
    $("#redirectedvalue").val('');
    $("#redirectedvalue").val('RepliedByMe');
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
		   $('#todate').change(function(){
		       $('#myform').submit();
		    });
		});

	
	function checkCharacterLimit() {
	    var textarea = document.getElementById("reply");
	    var maxlength = textarea.getAttribute("maxlength");
	    var textLength = textarea.value.length;

	    if (textLength > maxlength) {
	        textarea.value = textarea.value.substring(0, maxlength); // Truncate the text to the maxlength
	        alert("You have reached the maximum character limit.");
	    }
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
	        url: "getEmpListForSeekResponse.htm",
	        data: {
	            dakid: DakId
	        },
	        dataType: 'json',
	        success: function(result) {
	            if (result != null) {
	            	 $('#DakSeekResponseEmployee').empty();
	                for (var i = 0; i < result.length; i++) {
	                    var data = result[i];
	                    var optionValue = data[0];
	                    var optionText = data[1] + ", " + data[2]; // Removed the %>; and fixed the concatenation
	                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                    $('#DakSeekResponseEmployee').append(option); // Moved this inside the loop
	                }
	                $('#DakSeekResponseEmployee').selectpicker('refresh');
	                $.ajax({
	                    type: "GET",
	                    url: "getoldSeekResponseassignemplist.htm", // Replace with the actual URL
	                    data: {
	                    	DakId: DakId
	                    },
	                    dataType: 'json',
	                    success: function(result) {
	                    	var consultVals = Object.values(result);
	                        if (consultVals != null) {
	                            // Iterate through the selectedOptions and set the selected and disabled properties
	                            for (var c = 0; c < consultVals.length; c++) {
	                                var selectedOptionValue = consultVals[c][0];
	                                $('#DakSeekResponseEmployee option[value="' + selectedOptionValue + '"]').prop('selected', true);
	                                $('#DakSeekResponseEmployee option[value="' + selectedOptionValue + '"]').prop('disabled', true);
	                            }
	                            // Refresh the selectpicker after making changes
	                            $('#DakSeekResponseEmployee').selectpicker('refresh');
	                        }
	                    }
	                });
	            }
	        }

	    });
	    
	}
	function Assign(DakId, dakmarkingid, dakno, Source,RedirVal) {
	    $('#exampleModalAssign').modal('show');
	    $('#DakNo').html(dakno);
	    $('#Sourcetype').html(Source);
	    $('#DakMarkingdakId').val(DakId);
	    $('#DakMarkingIdsel').val(dakmarkingid);
	    $('#RedirectValue').val(RedirVal);
	    $('#DakCaseWorker').empty();

	  //code to redirect to page
		var redirectPageId   = "PageNoValFetch"+DakId;
		var redirectRowId =  "RowValFetch"+DakId;
		var pageElement = document.getElementById(redirectPageId);
		var rowElement = document.getElementById(redirectRowId);
	    var pageValue = pageElement ? pageElement.value : null;
		var rowValue = rowElement ? rowElement.value : null;
		$('#PageRedirByAssign').val(pageValue);
		$('#RowRedirByAssign').val(rowValue);
		//code ends
		
	    $.ajax({
	        type: "GET",
	        url: "getEmpListForAssigning.htm",
	        data: {
	            dakid: DakId
	        },
	        dataType: 'json',
	        success: function(result) {
	            if (result != null) {
	            	 $('#DakCaseWorker').empty();
	                for (var i = 0; i < result.length; i++) {
	                    var data = result[i];
	                    var optionValue = data[0];
	                    var optionText = data[1] + ", " + data[2]; // Removed the %>; and fixed the concatenation
	                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                    $('#DakCaseWorker').append(option); // Moved this inside the loop
	                }
	                $('#DakCaseWorker').selectpicker('refresh');
	                $.ajax({
	                    type: "GET",
	                    url: "getoldassignemplist.htm", // Replace with the actual URL
	                    data: {
	                    	DakId: DakId
	                    },
	                    dataType: 'json',
	                    success: function(result) {
	                    	var consultVals = Object.values(result);
	                        if (consultVals != null) {
	                            // Iterate through the selectedOptions and set the selected and disabled properties
	                            for (var c = 0; c < consultVals.length; c++) {
	                                var selectedOptionValue = consultVals[c][0];
	                                $('#DakCaseWorker option[value="' + selectedOptionValue + '"]').prop('selected', true);
	                                $('#DakCaseWorker option[value="' + selectedOptionValue + '"]').prop('disabled', true);
	                            }
	                            // Refresh the selectpicker after making changes
	                            $('#DakCaseWorker').selectpicker('refresh');
	                        }
	                    }
	                });
	            }
	        }

	    });
	}
	
	function DakAssignSubmit() {
		var Caseworker=$('#DakCaseWorker').val();
		var shouldSubmit = true;
		var form=document.getElementById('AssignForm');
		if(Caseworker==null || Caseworker=='' || typeof(Caseworker)=='undefined'){
			 alert("Select CaseWorker..!");
		  $("#DakCaseWorker").focus();
		  shouldSubmit= false;
		}else{
			if(confirm('Are you Sure To Submit ?')){
				  form.submit();/*submit the form */
					}
		}
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

 function replyModalOfMarker(DakIdValue,loggedInEmpId,DakAssignReplyIdCount,dakno,source,DakMarkingId) {

	$('#exampleModalReply').modal('show');
	$('#dakIdOfReply').val(DakIdValue);
	$('#empIdOfReply').val(loggedInEmpId);
	$('#RecievedListDakNo').html(dakno);
	$('#RecievedListSourceNo').html(source);
	$('.replyTextArea').val('');
	$('#ReplyCopyAttachDataFill').empty();

	        	
	  //code to redirect to page
	  var redirectPageId   = "PageNoValFetch"+DakIdValue;
	  var redirectRowId =  "RowValFetch"+DakIdValue;
	  var pageElement = document.getElementById(redirectPageId);
	  var rowElement = document.getElementById(redirectRowId);
	  var pageValue = pageElement ? pageElement.value : null;
	  var rowValue = rowElement ? rowElement.value : null;
	  $('#PageRedirByReply').val(pageValue);
	  $('#RowRedirByReply').val(rowValue);
	  //code ends
	        	

	        	
	      	if(DakAssignReplyIdCount>0 ){
	      		CSWReplyOfParticularMarkerPreview(DakMarkingId,DakIdValue,loggedInEmpId);
	      		console.log("DakAssignReplyIdCount is greater than zero callefd");
	     	}else{
	      		$('#CSWReplyOfParticularMarker').hide();
	      	}
	      }
	      
	  function CSWReplyOfParticularMarkerPreview(DakMarkingId,DakId,loggedInEmpId){
	   console.log("DakAssignReplyIdCount reached");
	      	
	   // Clear previous data
	      $('.MarkerReplyModalCaseworkerPreview').empty();
	      $('.MarkerNameAndDesigDisplay').empty();
	      $('.MarkerCaseworkersDakReplyData').empty();
	       $.ajax({
	           type: "GET",
	            url: "GetAllCSWReplyByMarkingIdDetails.htm",
	           data: {
	             	dakMarkingId: DakMarkingId,
	                 dakId: DakId
	            },
	            dataType: 'json',
	            success: function(result) {
	            console.log("Response:", result);
	         try {
	            if (result != null) {
	               $('#CSWReplyOfParticularMarker').show();
	               var MarkerNameAndDesig;
	               for (var i = 0; i < result.length; i++) {
	         			   var data = result[i];
	         							    
	         					   var repliedCSWPersonName = data[4];
	        								$('#replierName').val(repliedCSWPersonName);
	        							    var repliedCSWPersonDesig = data[5];
	        							    var repliedData = data[6];
	        							    var dakAssignReplyId= data[2];
	        							    var replyEmpId=data[3];
	        							    var loggedInEmpId = <%= EmpId %>;
	        							    var MarkerPersName = data[8];
	        							    var MarkerPersDesig = data[9];
	        							    var dakStatus = data[10];
	        							    MarkerNameAndDesig = " (Marked By - " + MarkerPersName + "," + MarkerPersDesig + ")";
	        							    var dynamicCSWReplyDiv = $("<div>", { class: "DAKCSWReplysBasedOnReplyId", style: "min-width:100px;min-height:100px;" });
	        							    dynamicCSWReplyDiv.after("<br>");
	        							    var h4 = $("<h4>", {
	        							    	  class: "CSWRepliedPersonName",
	        							    	  id: "model-person-header",
	        							    	  html: (i + 1) + "." + repliedCSWPersonName + "," + repliedCSWPersonDesig + ""
	        							    	});
	        							    dynamicCSWReplyDiv.append(h4);//appended h4
	        							    
	        							 
	        							    var facilitatorReplyCopyButton = $("<button>", {
	        							        type: "button",
	        							        class: "btn replyCopyBtn",
	        							        id: "AssignReply" + data[2],
	        							        "data-button-type": "copyAndUncopyBtn",
	        							        "data-row-id": data[2],
	        							        "data-toggle": "tooltip",
	        							        "data-placement": "top",
	        							        style: "float:right!important",
	        							        title: "Reply Copy"
	        							       /*  onclick: "copyFacilitatorReplyToMarker('" + data[2] + "','" + data[1] + "')" */
	        							    });

	        							    var copyImage = $("<img>", { alt: "edit", src: "view/images/replyCopy.png" });
	        							    facilitatorReplyCopyButton.append(copyImage);
	        							    $(dynamicCSWReplyDiv).append(facilitatorReplyCopyButton);
	        							 
	           							dynamicCSWReplyDiv.append($("<div>", { class: "clearfix" })); // Add a clearfix div to clear the so innerdiv comes below h4
	                                      
	                                      
	        							    var innerCSWReplyDiv = $("<div>", { class: "row replyRow" });
	        							    
	        							    var formgroup1 = $("<div>", { class: "form-group group1" });
	        								
	        							  /*   var replyLabel = $("<label>", { class: "form-control" }).css({ fontweight: "800", fontSize: "16px", color: "#07689f;",display: "inline-block",marginbottom: "0.5rem"}).text("Reply :"); */
	        					
	        							    var replyCSWText = repliedData.length < 140 ? repliedData : repliedData.substring(0, 140);
	        							    var replyCSWDiv = $("<div>", { class: "col-md-12 replyCSW-div", contenteditable: "false" }).text(replyCSWText);
	        							    
	        							    if (repliedData.length > 140) {
	        							        var button = $("<button>", {
	        							            type: "button",
	        							            class: "viewmore-click",
	        							            name: "sub",
	        							            value: "Modify",
	        							            onclick: "replyCSWViewMoreModal('" + dakAssignReplyId + "')"
	        							        }).text("...(View More)");

	        							        var b = $("<b>").append($("<span>", { style: "color:#1176ab;font-size: 14px;" }).text("......"));

	        							        replyCSWDiv.append(button, b);
	        							    }

	        							
	        					          formgroup1.append(replyCSWDiv);   
	        					          innerCSWReplyDiv.append(formgroup1);
	        					          dynamicCSWReplyDiv.append(innerCSWReplyDiv);

	        					            // Check if row[7] count i.e DakReplyAttachCount is more than 0
	        						          if (data[7] > 0) {
	        						        	  // Call a function and pass row[2] i.e DakAssignReplyId
	        						              DakCSWReplyAttachPreview(data[2], dynamicCSWReplyDiv); //reusing the DakCSWReplyAttachPreview from common modals.jsp however oneverclick whole diuv will be emptied
	        						            }
	        					            
	        						    $(".MarkerCaseworkersDakReplyData").append(dynamicCSWReplyDiv);
	        						         
	        						      // Add line break after the textarea and DakReplyDivEnd
	        				                  
	                                    $(".MarkerCaseworkersDakReplyData").append("<br>");
	         							    
	                	            	 }//for loop close
	            	             	    $('.MarkerNameAndDesigDisplay').append(MarkerNameAndDesig);
	                	   
	                	            
	                	            }//if condition close
	                	        
	                     } catch (error) {
	                         console.error("Error parsing JSON:", error);
	                     }
	                 },
	                 error: function(xhr, status, error) {
	                     console.error("AJAX request error:", status, error);
	                 }
	                 
	            });
	        }	        
	        
	        </script>
<script>
// object named appendedText to store the reply text associated with each DakAssignReplyId//This object allows us to keep track of the text appended for each button click.
var appendedText = {};


$(document).ready(function () {
	  // Event delegation for dynamically generated buttons
	  $(document).on("click", "button[data-button-type='copyAndUncopyBtn']", function (event) {
	    event.preventDefault();

	
    // Get the data-row-id of the clicked button
    var dakAssignReplyId =  $(this).data("row-id"); // this is the unique Id which will identify particular DakAssignReplyId
    
    
         console.log($( "#AssignReply"+dakAssignReplyId ).hasClass( "btn replyCopyBtn" ).toString());
  if($( "#AssignReply"+dakAssignReplyId ).hasClass( "btn replyCopyBtn" ).toString()=='true'){
        	
    	$( "#AssignReply"+dakAssignReplyId ).removeClass( "btn replyCopyBtn" ).addClass( "btn replyUnCopyBtn" );

        // Change the image source using your code
        $( "#AssignReply"+dakAssignReplyId ).find('img').attr('src', 'view/images/replyUnCopy.png');
        
        // Change the title
        $( "#AssignReply"+dakAssignReplyId ).attr('title', 'Reply Uncopy');
   
        copyFacilitatorReplyToMarker(dakAssignReplyId);
    	
   }else if($( "#AssignReply"+dakAssignReplyId ).hasClass( "btn replyUnCopyBtn" ).toString()=='true'){
    	
    	$( "#AssignReply"+dakAssignReplyId ).removeClass( "btn replyUnCopyBtn" ).addClass( "btn replyCopyBtn" );
    	
    	// Change the image source using your code
        $( "#AssignReply"+dakAssignReplyId ).find('img').attr('src', 'view/images/replyCopy.png');
        
        // Change the title
        $( "#AssignReply"+dakAssignReplyId ).attr('title', 'Reply Copy');
        
        //all attachment(tr) with this id will be removed
        $('[id^="CopyAttachRow' + dakAssignReplyId + '"]').remove(); 
        
        
  
        //retrieve the previously appended text from the appendedText object based on the DakAssignReplyId
        var appended = appendedText[dakAssignReplyId];
        if (appended) {
          var currentText = $('.replyTextArea').val();
          // Replace the current text with the text without the appended portion
          //removes only the text appended during the corresponding "Copy" action, leaving the rest of the text area intact.
          var newText = currentText.replace(appended, '');
          $('.replyTextArea').val(newText);
          // Remove the appended text from the storage
          delete appendedText[dakAssignReplyId];
        }
    	 
        }
  });
});

function copyFacilitatorReplyToMarker(DakAssignReplyId){
	console.log(DakAssignReplyId);
	 $.ajax({
	        type: "GET",
	        url: "GetParticularCSWReplyDetails.htm",
	        data: {
	        	dakAssignReplyId: DakAssignReplyId
	        },
	        dataType: 'json',
	        success: function(result) {
	        	 if (result != null) {
 	            	 for (var i = 0; i < result.length; i++) {
						    var data = result[i];
						    
						   var FacilitatorReply = data[3];
						    $('.replyTextArea').val(function (i, val) {
						          appendedText[DakAssignReplyId] = FacilitatorReply;
						          return val + FacilitatorReply;
						        });
						  /*   $('.replyTextArea').append(FacilitatorReply); */
						   
						   //DakCSWReplyAttachPreview
						   // Check if data[7] count i.e DakReplyAttachCount is more than 0
					          console.log(data[7]);
						   if (data[7] > 0) {
					        	  // Call a function and pass row[2] i.e DakAssignReplyId
					              copyFacilitatorAttachToMarker(data[0]); 
					            }
				         
 	            	 }
	        	 }
	        },
	         error: function(xhr, status, error) {
	             console.error("AJAX request error:", status, error);
	         }
	 });
}

function ReplyCopyAttachDelete(DakAssignReplyAttachmentId) {
	console.log(DakAssignReplyAttachmentId);
	if ($('.AssignAttachRow' + DakAssignReplyAttachmentId).length > 0) {
	$('.AssignAttachRow' + DakAssignReplyAttachmentId).remove();
	} else {
	    console.log('Element not found');
	}
	}



	function copyFacilitatorAttachToMarker(DakAssignReplyId){
		 $.ajax({
			    type: "GET",
			    url: "GetCSWReplyAttachModalList.htm",
			    data: {
			      dakassignreplyid: DakAssignReplyId
			    },
			    datatype: 'json',
			    success: function(result) {
			      if (result != null) {
			        var resultData = JSON.parse(result);

			        if (resultData.length > 0) {
			      
			          var ReplyAttachTbody = '';
			          for (var z = 0; z < resultData.length; z++) {
			            var row = resultData[z];
			            DakAssignReplyAttachId = row[0];
			            ReplyAttachTbody += '<tr class="AssignAttachRow'+row[0]+'" id="CopyAttachRow'+DakAssignReplyId+'"  data-custom-name="AssignerAttachInsert" data-custom-value="'+row[4]+'"> ';
			            ReplyAttachTbody +=	' <td> <button type="button" onclick="ReplyCopyAttachDelete(' + row[0] + ')" id="ReplyCopyAttachDelete' + row[0] + '" class="btn btn-sm icon-btn" data-toggle="tooltip" data-placement="top" title="Delete" ><img alt="attach" src="view/images/delete.png"></button></td>';
	                    ReplyAttachTbody += '  <td style="text-align: left;">';
			            ReplyAttachTbody += '  <form action="#" id="CWReplyFormCopy">';
			            ReplyAttachTbody += '  <input type="hidden" id="CWReplyIframe" name="cswdownloadbtn">';
			            ReplyAttachTbody += '  <button type="button" class="btn btn-sm replyCSWAttachWithin-btn"   value="'+row[0]+'"  onclick="IframepdfCaseWorkerReply('+row[0]+')" name="dakReplyCSWDownloadBtn"  data-toggle="tooltip" data-placement="top" title="Download"   >' + row[4] + '</button>';
			            ReplyAttachTbody += '  </form>';
			            ReplyAttachTbody += '  </td>';
			      
			            ReplyAttachTbody += '</tr> ';
			          }
			          $('#ReplyCopyAttachDataFill').append(ReplyAttachTbody);
			        }
			      }
			    },
			    error: function(xhr, textStatus, errorThrown) {
			      // Handle error
			    }
			  });
		
		
	  }
	
	//Initialize an empty array to store the uniqueDakAssignReplyAttach IDs
	 var DakAssignReplyAttachFiles = [];
	 
	 
	function dakReplyValidation() {
		  $('#AttachsFromDakAssigner').val('');
		   var isValidated = false;
		   var replyRemark = document.getElementsByClassName("replyTextArea")[0].value;
		if(replyRemark.trim() == "") { 
	 	isValidated = false;
	 }else{
	 	isValidated = true;
	 }
	 
	 if (!isValidated) {
	     event.preventDefault(); // Prevent form submission
	     alert("Please fill in the reply input field.");
	   
	 
	   } else {
	       
		// Loop through all elements with data-custom-name="AssignerAttachInsert"
		   $('tr[data-custom-name="AssignerAttachInsert"]').each(function() {
			   // Get the data-custom-value attribute value and add it to the array
	           var AttachedFileNames = $(this).data('custom-value');
	           DakAssignReplyAttachFiles.push(AttachedFileNames);
		   });

		   // Set the value of the hidden input field as a comma-separated string
	       $('#AttachsFromDakAssigner').val(DakAssignReplyAttachFiles.join(','));

		   // Retrieve the form and submit it
	       var confirmation = confirm("Are you sure you want to reply?");
	       if (confirmation) {
	      var form = document.getElementById("attachformReply");
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
	}//function close
	   
</script>

</html>