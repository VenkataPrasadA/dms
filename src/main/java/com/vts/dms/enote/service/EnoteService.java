package com.vts.dms.enote.service;

import java.util.List;

import com.vts.dms.enote.dto.DakLetterDocDto;
import com.vts.dms.enote.dto.EnoteDto;
import com.vts.dms.enote.dto.EnoteReplyDto;
import com.vts.dms.enote.dto.EnoteRosoDto;
import com.vts.dms.enote.dto.EnoteflowDto;
import com.vts.dms.enote.model.DakEnoteReply;
import com.vts.dms.enote.model.Enote;
import com.vts.dms.enote.model.EnoteRosoModel;

public interface EnoteService {

	public long InsertEnote(EnoteDto dto,String LabCode) throws Exception;

	public Object[] EnotePreview(long result) throws Exception;

	public Object getlabcode(long empId) throws Exception;

	public List<Object[]> InitiatedByEmployeeList(long divid, String lab) throws Exception;

	public List<Object[]> RecommendingOfficerList(String lab) throws Exception;

	public long ForwardtoRecommendOfficers(EnoteflowDto dto, String[] employeeIds) throws Exception;

	public List<Object[]> EnoteList(String fromDate, String toDate,String Username,long EmpId) throws Exception;

	public long UpdateEnoteStatus(String eNoteId) throws Exception;

	public long forwardeNote(EnoteDto dto, long EmpId,String Action,String remarks,String RedirectName)  throws Exception;

	public Enote EnoteEditData(long EnoteId) throws Exception;

	public long AttachmentCount(long EnoteId) throws Exception;

	public List<Object[]> GetAttachmentDetails(long EnoteId) throws Exception;

	public Object[] EnoteAttachmentData(String eNoteAttachId) throws Exception;

	public List<Object[]> EnoteAttachmentData(long EnoteAttachId, long enoteId) throws Exception;

	public int DeleteEnoteAttachment(String enoteAttachId) throws Exception;

	public long UpdateEnote(EnoteDto dto) throws Exception;

	public Object[] RecommendingDetails(long EnoteId,String lab) throws Exception;

	public List<Object[]> eNotePendingList(long EmpId) throws Exception;

	public List<Object[]> eNoteApprovalList(long EmpId,String fromDate,String toDate) throws Exception;

	public List<Object[]> EnoteTransactionList(String enoteTrackId) throws Exception;

	public Object[] EnotePrint(String enotePrintId) throws Exception;

	public List<Object[]> EnotePrintDetails(long EnoteId) throws Exception;

	public List<Object[]> EnoteRoSoList(String lab) throws Exception;

	public List<Object[]> EmployeeListForEnoteRoSo(String lab) throws Exception;

	public long InsertEnoteRoso(EnoteRosoModel enote) throws Exception;

	public List<Object[]> InitiatedEmpList(String lab) throws Exception;

	public EnoteRosoModel EnoteRoSoEditData(long EnoteRoSoId) throws Exception;

	public long UpdateEnoteRoso(EnoteRosoDto enote) throws Exception;

	public Object[] EnoteRoSoDetails(long EnoteRoSoId,String lab) throws Exception;

	public Object[] EnoteRoSoRoledetails(long EnoteId) throws Exception;

	public List<Object[]> LabList(String lab) throws Exception;

	public List<Object[]> ExpertEmployeeList() throws Exception;

	public Object[] getExternalLabCode(long EnoteRoSoId) throws Exception;

	public long EnoteInitiaterRevoke(String enoteRevokeId, String username, long EmpId) throws Exception;

	public Object[] ExternalNameData(long EnoteId) throws Exception;

	public List<Object[]> ReturnRemarks(String eNoteId) throws Exception;

	public List<Object[]> ExternalList(long EmpId) throws Exception;

	public List<Object[]> ExternalApprovalList(long EmpId, String fromDate, String toDate) throws Exception;

	public List<Object[]> eNoteSkipApprovalPendingList(String fromDate, String toDate,String Username,long EmpId) throws Exception;

	public List<Object[]> EnotePrintViewDetails(long EnoteId) throws Exception;

	public Object getDivisionId(long EmpId) throws Exception;

	public List<Object[]> GetChangeRecommendingOfficer(String divId) throws Exception;

	public long ChangeRecommendOfficer(long EnoteId, long RecommendingOfficer, String statusCodeNext,String RecommendRole,String ChangeApprovalRemarks,String ChangeStatusCode,long EmpId) throws Exception;

	public Object[] DakRecommendingDetails(long DakeNoteReplyId) throws Exception;

	public long DakReplyAttachmentCount(long DakeNoteReplyId) throws Exception;

	public long InsertDakReplyEnote(EnoteDto dto,String DakAssignReplyId,long EmpId,String EnoteFrom,String LabCode) throws Exception;

	public Object[] DakEnotePreview(long DakeNoteReplyId) throws Exception;

	public Object[] DakEnoteAttachmentData(String eNoteAttachId) throws Exception;

	public List<Object[]> DakEnoteAttachmentData(long AttachmentId, long DakEnoteReplyId) throws Exception;

	public int DeleteDakEnoteAttachment(String enoteAttachId) throws Exception;

	public List<Object[]> GetEnoteAssignReplyAttachmentDetails(long DakAssignReplyId) throws Exception;

	public DakEnoteReply EnoteReplyEditData(long DakEnoteReplyId) throws Exception;

	public long UpdateEnoteReply(EnoteDto dto,long EmpId) throws Exception;

	public List<Object[]> DakENoteReplyReturnRemarks(String DakEnoteReplyId) throws Exception;

	public Object[] DakMarkingEnoteAttachmentData(String eNoteAttachId) throws Exception;

	public List<Object[]> DakEnoteMarkerAttachmentData(long AttachmentId, long DakEnoteReplyId) throws Exception;

	public int DeleteMarkerDakEnoteAttachment(String enoteAttachId) throws Exception;

	public long DakMarkerReplyAttachmentCount(long DakeNoteReplyId) throws Exception;

	public Object[] EnoteDocumentData(String labCode, long InitiatedBy) throws Exception;

	public List<Object[]> TemplateList() throws Exception;

	public long updateRosoId(String[] eNoteRosoDeleteId) throws Exception;

	public Object[] WordDocumentData(long EnoteId) throws Exception;
	
	public Object[] letterDocumentData(String letterDocumentid) throws Exception;

	public long EnoteDocumentUpload(DakLetterDocDto dto) throws Exception;

}
