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
<title>DAK Seek Response List</title>
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
				<h5 style="font-weight: 700 !important">DAK Seek Response List </h5>
			</div>
			
			<div class="col-md-9 " >
				<nav aria-label="breadcrumb">
				  <ol class="breadcrumb ">
				    <li class="breadcrumb-item ml-auto"><a href="MainDashBoard.htm"><i class="fa fa-home"></i> Home</a></li>
				    <li class="breadcrumb-item  " aria-current="page"><a href="DakDashBoard.htm"><i class="fa fa-envelope" ></i> DAK</a></li>
				    <li class="breadcrumb-item active">DAK Seek Response List </li>
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
		String frmDt=(String)request.getAttribute("frmDt");
		String toDt=(String)request.getAttribute("toDt");
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		List<Object[]> DakSeekResponseListToMe=(List<Object[]>)request.getAttribute("DakSeekResponseListToMe");
		List<Object[]> DakSeekResponseByMeList=(List<Object[]>)request.getAttribute("DakSeekResponseByMeList");
		String redirectedvalue=(String)request.getAttribute("redirectedvalueForward");
		long EmpId =(Long)session.getAttribute("EmpId"); 
		List<Object[]> GetAssignEmpList=(List<Object[]>)request.getAttribute("GetAssignEmpList");
		
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
 <form action="DakSeekResponseList.htm" method="POST" id="myform"> 
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <div class="float-container" style="float:right;">
        <div class="col-12" style="width: 100%;" >
          <div class="row" >
              <label for="fromdate" style="text-align:  center;font-size: 16px;width:40px; ">From	</label>&nbsp;&nbsp;
              <input type="text" style="width:113px; margin-top: -10px; " class="form-control input-sm mydate" readonly="readonly" value="" id="fromdate" name="FromDate" required="required"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label for="todate" style="text-align: center;font-size: 16px;width:20px; ">To</label>&nbsp;&nbsp;
              <input type="text" style="width:113px;  margin-top: -10px;" class="form-control input-sm mydate" readonly="readonly" value="" id="todate" name="ToDate" required="required"> 
             <input type="hidden" id="seekredirectedvalue" name="redirectedvalue" value="<%if(redirectedvalue!=null){%><%=redirectedvalue %><%}%>"> 
              
          </div>
        </div>
      </div>
      </form>
</div>
<div class="card-body">
					<ul class="nav nav-pills mb-3" id="Seekpills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  <li class="nav-item" style="width: 50%;"  >
		    <div class="nav-link active" style="text-align: center;" id="seekpills-OPD-tab" data-toggle="pill" data-target="#seekpills-OPD" role="tab" aria-controls="pills-OPD" aria-selected="true">
			   <span>Response Sought From Me  
				   <span class="badge badge-danger badge-counter count-badge">
				   		<%if(DakSeekResponseListToMe.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DakSeekResponseListToMe.size() %>
						<%} %>				   			
				  </span>  
				</span> 
		    </div>
		  </li>
		  <li class="nav-item"  style="width: 50%;">
		    <div class="nav-link" style="text-align: center;" id="seekpills-IPD-tab" data-toggle="pill" data-target="#seekpills-IPD" role="tab" aria-controls="pills-IPD" aria-selected="false">
		    	 <span>Response Seek By Me     
				   <span class="badge badge-danger badge-counter count-badge">
				   		<%if(DakSeekResponseByMeList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=DakSeekResponseByMeList.size() %>
						<%} %>				   			
				   </span>  
				</span> 
		    
		    
		    </div>
		  </li>
		</ul>
			

	<div class="tab-content" id="seekpills-tabContent">
			<div class=" tab-pane  show active" id="seekpills-OPD" role="tabpanel" aria-labelledby="seekpills-OPD-tab" >
				 
					<div class="table-responsive">
					<form action="#" method="post">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="viewfrom" value="DakSeekResponseList">
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
							if(DakSeekResponseListToMe!=null){
							for(Object[] obj:DakSeekResponseListToMe){ 
							
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
										&& !obj[19].toString().equalsIgnoreCase("FP")			   ){	
										 StatusCountReply  = "Replied["+obj[18]+"/"+obj[16]+"]";
									 }
							
							
							
							%>
								<tr  data-row-id=row-<%=count %> id=buttonbackground<%=obj[7]%>>
									<td style="text-align: center;width:10px;"><%=count %></td>
									<td style="text-align: left;width:80px;">
									<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[7] %>','DakSeekResponseList')">
                                    <% if (obj[0] != null) { %>
                                    <%= obj[0].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
									</td>
									<td style="text-align: center;width:10px;"><%if(obj[10]!=null){ %><%=obj[10].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:70px;"><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>-<%} %></td>
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
 										 formaction="DakReceivedView.htm" formtarget="blank"
									  data-toggle="tooltip" formmethod="post" data-placement="top" title="Preview"> 
															<img alt="mark" src="view/images/preview3.png">
 										  </button>
 										  
 										  <%if(obj[9]!=null && obj[9].toString().equalsIgnoreCase("N")){ %>
 										  <button type="button" class="btn btn-sm icon-btn"  onclick="return SeekResponsereplyModal('<%=obj[7]%>','<%=obj[8]%>','<%=obj[0]%>','<%=obj[1] %>',<%=obj[8] %>,<%=pageNumber%>,<%=count%>)" 
 										  data-toggle="tooltip" data-placement="top" title="Reply">
															<img alt="Reply" src="view/images/replyy.png">
 											</button>
 										<%}else if(obj[9]!=null && obj[9].toString().equalsIgnoreCase("Y")){ %>	
 										Replied
 										<%} %>
 										    <!--------------DAK Marker SeekResponse Button Start -----------------------------------------------> 									   
 									   	<%if( !obj[19].toString().equalsIgnoreCase("RP") && !obj[19].toString().equalsIgnoreCase("FP") && !obj[19].toString().equalsIgnoreCase("RM") && !obj[19].toString().equalsIgnoreCase("AP") && !obj[19].toString().equalsIgnoreCase("DC")){ %>
 								         <button type="button" class="btn btn-sm icon-btn" onclick="SeekResponse(<%=obj[7]%>,<%=obj[8] %>,'<%=obj[0] %>','<%=obj[1] %>','DakSeekResponseList')"
 										  data-toggle="tooltip" data-placement="top" title="SeekResponse">
 											<img alt="SeekResponse" src="view/images/SeekResponse.png">
										 </button>
										
 										<%} %> 
                                       <!--------------DAK Marker SeekResponse Button End ----------------------------------------------->
									</td>
								</tr>
								<%count++;}} %>
							</tbody>
						</table>
						</form>
					</div>
					
					</div>
				
						<!----------------------------------------------------   Div SeekResponse Assigned By Me    ----------------------------------------------------------->

	<div class="card tab-pane " id="seekpills-IPD" role="tabpanel" aria-labelledby="seekpills-IPD-tab" >	
       <div class="card-body"> 
					<div class="table-responsive">
					<form action="#" method="post">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="hidden" name="viewfrom" value="DakSeekResponseList">
						<table class="table table-bordered table-hover table-striped table-condensed " id="myTablesecond">
							<thead>
								<tr >
									<th style="text-align: center;">SN</th>
									<th style="text-align: center;">DAK Id</th>
									<th style="text-align: center;">Head</th>
									<th style="text-align: center;">Source</th>
									<th style="text-align: center;">Ref No & Date</th>
									<th style="text-align: center;">Assigned To</th>
									<th style="text-align: center;">DAK Status</th>
									<th style="text-align: center;">Action</th>
								</tr>
							</thead>
							<tbody>
							<%
							int count1=1;
							if(DakSeekResponseByMeList!=null){
							for(Object[] obj:DakSeekResponseByMeList){ 
								 String StatusCountAck = null;
									String StatusCountReply = null;
									 
									if(obj[14]!=null  && obj[13]!=null && Long.parseLong(obj[13].toString())==0
										&& obj[12]!=null && Long.parseLong(obj[12].toString())>0
										&& !obj[14].toString().equalsIgnoreCase("DC") && !obj[14].toString().equalsIgnoreCase("AP")
										&& !obj[14].toString().equalsIgnoreCase("RP") && !obj[14].toString().equalsIgnoreCase("RM")
										&& !obj[14].toString().equalsIgnoreCase("FP")	   ){	
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
								<tr id=buttonbackground<%=obj[0]%>>
									<td style="text-align: center;width:10px;"><%=count1 %></td>
									<td style="text-align: left;width:80px;">
									<a class="font" href="javascript:void()" 
	 					          	style="color:#007bff;" onclick="TrackingStatusPageRedirect('<%=obj[0] %>','DakSeekResponseList')">
                                    <% if (obj[1] != null) { %>
                                    <%= obj[1].toString() %>
                                      <% } else { %>
                                           -
                                     <% } %>
                                     </a>
									</td>
									<td style="text-align: center;width:10px;"><%if(obj[4]!=null){ %><%=obj[4].toString() %><%}else{ %>-<%} %></td>
									<td class="wrap"  style="text-align: left;width:70px;"><%if(obj[3]!=null){ %><%=obj[3].toString() %><%}else{ %>-<%} %></td>
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
									<td>
									<button type="submit" class="btn btn-sm icon-btn" name="DakId"  id=<%="DakId"+obj[0]%> value="<%=obj[0] %>" 
									
									 formaction="DakReceivedView.htm" formtarget="blank" formmethod="post"
									 
									  data-toggle="tooltip" data-placement="top" title="Preview"> 
															<img alt="mark" src="view/images/preview3.png">
 										  </button>
 										  
									</td>
								</tr>
								<%count1++;}} %>
							</tbody>
						</table>
</form>
					</div>
					</div>
					</div>
					
	</div>
</div>
	<!----------------------------------------------------   Reply  Modal start    ----------------------------------------------------------->

  <div class="modal fade my-modal" id="SeekexampleModalReply" tabindex="-1" role="dialog" aria-labelledby="exampleModalReplyTitle" aria-hidden="true" >
 	  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document"  style="min-width: 50% !important; min-height: 50vh !important; display: flex; align-items: stretch;" >
 	    <div class="modal-content" >
 	      <div class="modal-header" style="background-color: #114A86;max-height:55px;">
 	      <div class="center-div" align="center"><h5 class="modal-title" id="SeekResponseexampleModalLongTitle"><b><span style="color: white;">DAK SeekResponse Reply</span></b>
 	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	        &nbsp;<span style="color:white;">DAK Id:</span> <span style="color: white;" id="DakSeekResponseReplyDakNo"></span>, &nbsp;&nbsp;<span style="color:white;">Source:</span> <span style="color: white;" id="DakSeekResponseReplySource"></span>&nbsp;
 	      </h5></div>
  	        <button type="button" class="close" style="color: white;" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body" >
  	      	<form action="#" name="SeekResponseattachformReply" id="SeekResponseattachformReply" enctype="multipart/form-data" method="post">
  	      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      		<div class="col-md-12" align="left" style="width: 100%;">
  	      		<label style="font-weight: bold; font-size: 16px;">Reply :<span class="mandatory" style="color: red;font-weight: normal;">*</span></label>
  	      		<div class="col-md-11">
  	      				<textarea class="form-control replyTextArea"    name="SeekResponsereplyRemarks" style="min-width: 110% !important;min-height: 30vh;"  id="SeekResponseReplyRemarks" required="required"  maxlength="500" > </textarea>
  	      			</div>
  	      			<br>
  	      			<label style="font-weight: bold; font-size: 16px;">Document :</label>
  	      			<div class="col-md-10 ">
  	      			<table>
			  	      	<tr><td></td>
			  	      		<td align="right"><button type="button" class="tr_clone_addbtn btn btn-sm" data-toggle="tooltip" data-placement="top" title="Add More Documents"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></td>
			  	      		</tr>
			  	      		<tr class="tr_clone">
			  	      			<td><input class="form-control" type="file" name="dak_SeekResponse_reply_document"  id="dakSeekResponsedocumentreply"  accept="*/*" ></td>
			  	      				<td><button type="button" class="tr_clone_sub btn btn-sm "  data-toggle="tooltip" data-placement="top" title="Remove this Document"> <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button></td>
			  	      			</tr>			  	      				
			  	     </table>
  	      			</div>
  	      			<br>
  	      		  <div class="col-md-12"  align="center">
  	      		  <br>
  	      		  <input type="hidden" name="dakIdOfSeekResponseReply"  id="dakIdOfSeekResponseReply" value="" >
  	      		  <input type="hidden" name="DakAssignId" id="DakSeekResponseAssignerId" value="">
  	      		  <input type="hidden" name="DakNo" id="SeekResponseDakNo" value="">
  	      		  <input type="hidden" name="SeekResponseId" id="SeekResponseId" value="">
  	      		  <input type="hidden" name="FromDate"  value="<%=frmDt%>">
  	      		  <input type="hidden" name="ToDate"  value="<%=toDt%>">
  	      		  
  	      		   <input type="hidden" name="SeekResponseReplyPageNo" id="SeekResponseReplyPageNo" value="">
  	      		  <input type="hidden" name="SeekResponseReplyRowNo" id="SeekResponseReplyRowNo" value="">
  	      		  
  	      		    
  	      			<input type="button" formaction="DAKSeekResponseReply.htm"  class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return dakSeekResponseReplyValidation()" > 
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
  	      			<input type="hidden" name="fromDateFetch" value=<%=frmDt %>>
					<input type="hidden" name="toDateFetch" value=<%=toDt %>>
					
					<input type="hidden" name="PageValBySeekRepsonse" id="PageRedirBySeekRepsonse" value="">
  	      			<input type="hidden" name="RowValBySeekRepsonse" id="RowRedirBySeekRepsonse" value="">
  	      			<input type="hidden" name="seekFrom" value="S">
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
  
  
  
  <!-- -------------------------------------------------------------------------------------------------SeekResponse Modal End  ---------------------------------------------------------------------------->
</div>
</body>
<script type="text/javascript">

$(window).on('load',function(){
	$('.spinner').fadeOut(1000);
	$('.loadingCard').fadeIn(1000);
});

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
</script>
<script>
  // Check if the CountForMsgRedirect string is not null
  var countForMsgMarkerRedirect = '<%= redirectedvalue %>';
  if (countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='SeekResponseToMe') {
    // Get the button element by ID
   var button = document.querySelector('[id="seekpills-OPD-tab"]');

    // Scroll to the button element to that view
 /*    button.scrollIntoView(); */
    // Programmatically trigger a click event on the button
    if (button) {
      // Programmatically trigger a click event on the button
      
      button.click();
      
    }
  }else if(countForMsgMarkerRedirect != 'null' && countForMsgMarkerRedirect==='SeekResponseByMe'){
	  var button = document.querySelector('[id="seekpills-IPD-tab"]');

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
  $("#seekpills-OPD-tab").click(function() {
	$("#seekredirectedvalue").val('');
    $("#seekredirectedvalue").val('SeekResponseToMe');
  });

  $("#seekpills-IPD-tab").click(function() {
    $("#seekredirectedvalue").val('');
    $("#seekredirectedvalue").val('SeekResponseByMe');
  });
</script>
<script type="text/javascript">
function dakSeekResponseReplyValidation() {
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
         var form = document.getElementById("SeekResponseattachformReply");
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


</script> 

<script type="text/javascript">
function SeekResponsereplyModal(DakId,AssignId,dakno,source,SeekerResponseId) {
	 $('#SeekexampleModalReply').modal('show');
	$('#dakIdOfSeekResponseReply').val(DakId);
	$('#DakSeekResponseAssignerId').val(AssignId);
	$('#SeekResponseDakNo').val(dakno);
	$("#SeekResponseId").val(SeekerResponseId);
	$('#DakSeekResponseReplyDakNo').html(dakno);
	$('#DakSeekResponseReplySource').html(source);
	$('#SeekResponseReplyPageNo').val(SeekResponseReplyPageNo);
	$('#SeekResponseReplyRowNo').val(SeekResponseReplyRowNo);
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
	        
	        </script>
</html>