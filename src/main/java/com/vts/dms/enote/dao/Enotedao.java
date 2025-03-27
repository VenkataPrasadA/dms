package com.vts.dms.enote.dao;

import java.util.List;

import com.vts.dms.enote.model.DakEnoteReply;
import com.vts.dms.enote.model.DakEnoteReplyAttach;
import com.vts.dms.enote.model.DakLetterDoc;
import com.vts.dms.enote.model.Enote;
import com.vts.dms.enote.model.EnoteAttachment;
import com.vts.dms.enote.model.EnoteFlow;
import com.vts.dms.enote.model.EnoteReplyTransaction;
import com.vts.dms.enote.model.EnoteRosoModel;
import com.vts.dms.enote.model.EnoteTransaction;

public interface Enotedao {

	public long EnoteCountForGeneration() throws Exception;

	public long insertEnote(Enote enote) throws Exception;

	public List<Object[]> GetAttachmentDetails(Long enoteId) throws Exception;

	public long EnoteAttachmentFile(EnoteAttachment model) throws Exception;

	public Object[] EnotePreview(long result) throws Exception;
	
	public Object getlabcode(long empId) throws Exception;

	public List<Object[]> InitiatedByEmployeeList(long divid, String lab) throws Exception;

	public List<Object[]> RecommendingOfficerList(String lab) throws Exception;

	public long InsertForwardRecommendOfficers(EnoteFlow enoteflow) throws Exception;

	public List<Object[]> EnoteList(String fromDate, String toDate,String Username,long EmpId) throws Exception;

	public long UpdateEnoteStatus(String eNoteId) throws Exception;


	public Enote getEnoteById(long enoteId) throws Exception;
	
	public long updateEnote(Enote enote) throws Exception;

	public long addEnoteTransaction(EnoteTransaction trans) throws Exception;

	public long AttachmentCount(long enoteId) throws Exception;

	public Object[] EnoteAttachmentData(String eNoteAttachId) throws Exception;

	public List<Object[]> EnoteAttachmentData(long enoteAttachId, long enoteId) throws Exception;

	public int DeleteEnoteAttachment(String enoteAttachId) throws Exception;

	public Object[] RecommendingDetails(long enoteId,String lab) throws Exception;

	public List<Object[]> eNotePendingList(long EmpId) throws Exception;

	public List<Object[]> eNoteApprovalList(long EmpId,String fromDate,String toDate) throws Exception;

	public List<Object[]> EnoteTransactionList(String enoteTrackId) throws Exception;

	public Object[] EnotePrint(String enotePrintId) throws Exception;

	public List<Object[]> EnotePrintDetails(long enoteId) throws Exception;

	public List<Object[]> EnoteRoSoList(String lab) throws Exception;

	public List<Object[]> EmployeeListForEnoteRoSo(String lab) throws Exception;

	public long InsertEnoteRoso(EnoteRosoModel enote) throws Exception;

	public List<Object[]> InitiatedEmpList(String lab) throws Exception;

	public EnoteRosoModel getEnoteRoSoDataById(long enoteRoSoId) throws Exception;

	public long updateDakEnoteRoSo(EnoteRosoModel model) throws Exception;

	public Object[] EnoteRoSoDetails(long enoteRoSoId,String lab) throws Exception;

	public Object[] EnoteRoSoRoledetails(long enoteId) throws Exception;

	public List<Object[]> LabList(String lab) throws Exception;

	public List<Object[]> ExpertEmployeeList() throws Exception;

	public Object[] getExternalLabCode(long enoteRoSoId) throws Exception;

	public long eNoteRevokeEdit(Enote enote) throws Exception;

	public Object[] ExternalNameData(long enoteId) throws Exception;

	public List<Object[]> ReturnRemarks(String eNoteId) throws Exception;

	public List<Object[]> ExternalList(long EmpId) throws Exception;

	public List<Object[]> ExternalApprovalList(long EmpId, String fromDate, String toDate) throws Exception;

	public List<Object[]> eNoteSkipApprovalPendingList(String fromDate, String toDate,String Username,long EmpId) throws Exception;

	public List<Object[]> EnotePrintViewDetails(long enoteId) throws Exception;

	public Object getDivisionId(long EmpId) throws Exception;

	public List<Object[]> GetChangeRecommendingOfficer(String divId) throws Exception;

	public long ChangeRecommendOfficer(long enoteId, long RecommendingOfficer, String statusCodeNext,String RecommendRole,String ChangeApprovalRemarks) throws Exception;

	public Object[] DakRecommendingDetails(long dakeNoteReplyId) throws Exception;

	public long DakReplyAttachmentCount(long dakeNoteReplyId) throws Exception;

	public long DakReplyinsertEnote(DakEnoteReply enote) throws Exception;

	public List<Object[]> GetDakEnoteAttachmentDetails(Long dakEnoteReplyId) throws Exception;

	public long DakReplyEnoteAttachmentFile(DakEnoteReplyAttach model) throws Exception;

	public Object[] DakEnotePreview(long dakeNoteReplyId) throws Exception;

	public long DakupdateEnote(DakEnoteReply enote) throws Exception;

	public Object[] DakEnoteAttachmentData(String eNoteAttachId) throws Exception;

	public List<Object[]> DakEnoteAttachmentData(long attachmentId, long dakEnoteReplyId) throws Exception;

	public int DeleteDakEnoteAttachment(String enoteAttachId) throws Exception;

	public List<Object[]> GetEnoteAssignReplyAttachmentDetails(long dakAssignReplyId) throws Exception;

	public DakEnoteReply getEnoteReplyEditData(long dakEnoteReplyId) throws Exception;

	public long updateEnoteReply(Enote enote) throws Exception;

	public List<Object[]> DakENoteReplyReturnRemarks(String dakEnoteReplyId) throws Exception;

	public Object[] DakMarkingEnoteAttachmentData(String eNoteAttachId) throws Exception;

	public List<Object[]> DakEnoteMarkerAttachmentData(long attachmentId, long dakEnoteReplyId) throws Exception;

	public int DeleteMarkerDakEnoteAttachment(String enoteAttachId) throws Exception;

	public long DakMarkerReplyAttachmentCount(long dakeNoteReplyId) throws Exception;

	public Object[] EnotePendingApprovalList(long ApprovingOfficer, Long enoteId) throws Exception;

	public Object[] EnoteDocumentData(String labCode, long initiatedBy) throws Exception;

	public List<Object[]> TemplateList() throws Exception;

	public long updateRosoId(String[] eNoteRosoDeleteId) throws Exception;

	public Object[] WordDocumentData(long enoteId) throws Exception;

	public List<Object[]> GetLetterDocDetails(long enoteId) throws Exception;

	public long DakLetterDocFile(DakLetterDoc doc) throws Exception;

	public Object[] letterDocumentData(String letterDocumentid) throws Exception;

	public List<Object[]> LetterAttachmentsFilePath(long result) throws Exception;

}
