package com.vts.dms.report.service;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.dms.DateTimeFormatUtil;
import com.vts.dms.report.dao.ReportDao;

@Service
public class ReportServiceImpl implements ReportService{
	 private static final Logger logger=LogManager.getLogger(ReportServiceImpl.class);
	    DateTimeFormatUtil dtf=new DateTimeFormatUtil();
	    @Autowired 
		private ReportDao dao;
	    
	    @Override
		public List<Object[]> DakStatusList(String Username,String LoginType,long EmpId,String fromDate,String toDate) throws Exception {
			return dao.DakStatusList(Username,LoginType,EmpId,fromDate,toDate);
		}
		
		   @Override
			public List<Object[]> DakTrackingList(String DakId) throws Exception {
				return dao.DakTrackingList(DakId);
			}
			
			 @Override
				public List<Object[]> DakTrackingPrintList(String DakId) throws Exception {
					return dao.DakTrackingPrintList(DakId);
				}
			
	 @Override
		public List<Object[]> GetCreatedByDetails(String InitiatedBy) throws Exception {
				return dao.GetCreatedByDetails(InitiatedBy);
		}
		
	 @Override
		public List<Object[]> GeAcknowledgedMembersList(String DakId) throws Exception {
		return dao.GeAcknowledgedMembersList(DakId);
	}	
		
		 @Override
			public List<Object[]>  GetDakNoSearchDetailsList(String DakId,long EmpId,String Username,String LoginType) throws Exception {
			return dao. GetDakNoSearchDetailsList(DakId,EmpId,Username,LoginType);
		}	
	
	@Override		
			public List<Object[]>  GetRefNoSearchDetailsList(String RefNo,long EmpId,String Username,String LoginType) throws Exception{
				return dao. GetRefNoSearchDetailsList(RefNo,EmpId,Username,LoginType);
			}	
			
	@Override			
			public List<Object[]>  GetSubjectSearchDetailsList(String Subject,long EmpId,String Username,String LoginType) throws Exception{
				return dao. GetSubjectSearchDetailsList(Subject,EmpId,Username,LoginType);
			}	
			
     @Override			
			public List<Object[]>   GetKeywordsSearchDetailsList(String Keyword,long EmpId,String Username,String LoginType) throws Exception{
				return dao. GetKeywordsSearchDetailsList(Keyword,EmpId,Username,LoginType);
			}

	@Override
	public List<Object[]> GetRepliedMembersList(String dakId) throws Exception {
		return dao.GetRepliedMembersList(dakId);
	}

	@Override
	public List<Object[]> GetSelectedTypeDropDown(String filterType) throws Exception {
		
		List<Object[]> List=null;
		if(filterType.equalsIgnoreCase("Source"))
		{
			List=dao.GetSourceDropDown();
		}
		else if(filterType.equalsIgnoreCase("Project"))
		{
			List=dao.GetProjectDropDown();
		}
		else if(filterType.equalsIgnoreCase("NonProject"))
		{
			List=dao.GetNonProjectDropDown();
		}
		else if(filterType.equalsIgnoreCase("OtherProject"))
		{
			List=dao.GetOtherProjectDropDown();
		}
		return List;
	}

	@Override
	public List<Object[]> GetDakFilteredList(String filterType, String selectedDetailsId, String fromDate, String toDate,String LoginType,long EmpId,String Username) throws Exception {
		return dao.GetDakFilteredList(filterType,selectedDetailsId,fromDate,toDate,LoginType,EmpId,Username);
	}

	@Override
	public List<Object[]> DakGroupingListDropDown() throws Exception {
		return dao.DakGroupingListDropDown();
	}

	@Override
	public List<Object[]> DakGroupingList(long dakMemberTypeId,long EmpId,String fromDate,String toDate) throws Exception {
		return dao.DakGroupingList(dakMemberTypeId,EmpId,fromDate,toDate);
	}

	@Override
	public List<Object[]> intialDakGroupingList(String fromDate,String toDate) throws Exception {
		return dao.intialDakGroupingList(fromDate,toDate);
	}

	@Override
	public List<Object[]> GroupEmpList(long DakMemberTypeId) throws Exception {
		return dao.GroupEmpList(DakMemberTypeId);
	}

	@Override
	public Object getlabcode(long empId) throws Exception {
		return dao.getlabcode(empId);
	}

	@Override
	public List<Object[]> StartEmployeeList(String lab) throws Exception {
		return dao.StartEmployeeList(lab);
	}

	@Override
	public List<Object[]> SelMemberTypeDakGroupingList(String selDakMemberTypeId, String fromDate, String toDate)throws Exception {
		return dao.SelMemberTypeDakGroupingList(selDakMemberTypeId,fromDate,toDate);
	}

	@Override
	public List<Object[]> SelMemberTypeEmployeeList(String selDakMemberTypeId, String lab) throws Exception {
		return dao.SelMemberTypeEmployeeList(selDakMemberTypeId,lab);
	}

	@Override
	public List<Object[]> SelEmployeeTypeDakGroupingList(String selEmpId, String fromDate, String toDate)throws Exception {
		return dao.SelEmployeeTypeDakGroupingList(selEmpId,fromDate,toDate);
	}

	@Override
	public List<Object[]> SelEmployeeMemberTypeDakGroupingList(String selDakMemberTypeId, String selEmpId,String fromDate, String toDate) throws Exception {
		return dao.SelEmployeeMemberTypeDakGroupingList(selDakMemberTypeId,selEmpId,fromDate,toDate);
	}

	@Override
	public List<Object[]> SelProjectTypeList(String lab) throws Exception {
		return dao.SelProjectTypeList(lab);
	}

	@Override
	public List<Object[]> AllProjectWiseList(String fromDate, String toDate) throws Exception {
		return dao.AllProjectWiseList(fromDate,toDate);
	}

	@Override
	public List<Object[]> SelectedProjectWiseList(String projectTypeId, String fromDate, String toDate)throws Exception {
		return dao.SelectedProjectWiseList(projectTypeId,fromDate,toDate);
	}

	@Override
	public List<Object[]> SmsReportList(String fromDate, String toDate) throws Exception {
		return dao.SmsReportList(fromDate,toDate);
	}
	
	@Override
	public List<Object[]> dakPendingReportList() throws Exception {
		return dao.dakPendingReportList();
	}
	
	@Override
	public List<Object[]> holidayDateList() throws Exception {
		return dao.holidayDateList();
	}
	
	@Override
	public List<Object[]> GetAcknowledgeMembersList(String selDakId) throws Exception {
		return dao.GetAcknowledgeMembersList(selDakId);
	}
	
	@Override
	public List<Object[]> GetReplyMembersList(String replydakId) throws Exception {
		return dao.GetReplyMembersList(replydakId);
	}
	
	@Override
	public List<Object[]> GetAssignedMembersList(String dakId) throws Exception {
		return dao.GetAssignedMembersList(dakId);
	}
	
	@Override
	public List<Object[]> GetSeekRepsonseMembersList(String dakId) throws Exception {
		return dao.GetSeekRepsonseMembersList(dakId);
	}
			
}
