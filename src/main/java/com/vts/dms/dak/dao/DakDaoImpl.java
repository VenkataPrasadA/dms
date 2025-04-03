package com.vts.dms.dak.dao;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.vts.dms.dak.dto.DakAttachmentDto;
import com.vts.dms.dak.model.AssignReplyAttachment;
import com.vts.dms.dak.model.DakAcknowledged;
import com.vts.dms.dak.model.DakAssign;
import com.vts.dms.dak.model.DakAssignReply;
import com.vts.dms.dak.model.DakAssignReplyAttachRev;
import com.vts.dms.dak.model.DakAssignReplyRev;
import com.vts.dms.dak.model.DakAttachment;
import com.vts.dms.dak.model.DakCreate;
import com.vts.dms.dak.model.DakCreateAttach;
import com.vts.dms.dak.model.DakCreateDestination;
import com.vts.dms.dak.model.DakCreateLink;
import com.vts.dms.dak.model.DakLink;
import com.vts.dms.dak.model.DakMailAttach;
import com.vts.dms.dak.model.DakMailSentAttach;
import com.vts.dms.dak.model.DakMain;
import com.vts.dms.dak.model.DakMarked;
import com.vts.dms.dak.model.DakMarking;
import com.vts.dms.dak.model.DakMember;
import com.vts.dms.dak.model.DakMemberType;
import com.vts.dms.dak.model.DakNotification;
import com.vts.dms.dak.model.DakPnCReply;
import com.vts.dms.dak.model.DakPnCReplyAttach;
import com.vts.dms.dak.model.DakProData;
import com.vts.dms.dak.model.DakRemind;
import com.vts.dms.dak.model.DakReply;
import com.vts.dms.dak.model.DakReplyAttach;
import com.vts.dms.dak.model.DakSeekResponse;
import com.vts.dms.dak.model.DakTransaction;
import com.vts.dms.dak.model.SeekResponseReplyAttachment;
import com.vts.dms.master.model.NonProjectMaster;
import com.vts.dms.master.model.OtherProjectMaster;
import com.vts.dms.master.model.Source;
import com.vts.dms.model.Notification;

@Transactional
@Repository
public class DakDaoImpl implements DakDao {

	private static final Logger logger = LogManager.getLogger(DakDaoImpl.class);
	private static final String SOURCELIST = "select sourceid,sourcename from dak_source";
	private static final String DAKDELIVERYLIST = "select deliverytypeid,deliverytype from dak_delivery_type";
	private static final String PRIORITYLIST = "select priorityid,priorityname from dak_priority";
	private static final String LETTERTYPELIST = "select lettertypeid,lettertype from dak_letter_type";
	private static final String RELEVANTLIST = "select projectid,projectcode,ProjectShortName from project_master where isactive='1' AND LabCode=:lab";
    private static final String DAKPENDINGDISTRIBUTIONLIST = "CALL Dms_DakPendingDistributionList(:DivisionCode,:LabCode,:UserName)";
	private static final String EMPIDCOUNTOFCOMPARISON = "SELECT COUNT(EmpId) FROM dak_marking WHERE DakId=:dakid AND EmpId=:prjDirEmpId";
	private static final String DELETEPREVPRJDIREMPID = "DELETE FROM dak_marking WHERE DakId=:dakid AND EmpId=:prjdirempid ";
	private static final String DAKDATA = "FROM DakMain WHERE DakId=:dakId";
	private static final String DAKATTACHMENTDATA = "SELECT dakid, filepath,dakattachmentid,filename  FROM dak_attachment WHERE DakId=:dakid and ismain=:type";
	private static final String DAKATTACHMENTDETAILS = "SELECT filepath, filename , dakid from dak_attachment WHERE DakAttachmentid=:dakattachmentid";
	private static final String DELETEATTACHMENT = "DELETE FROM dak_attachment WHERE dakattachmentid=:dakattachmentid";
	private static final String DELETESUBATTACHMENT = "DELETE FROM dak_attachment WHERE dakid=:DakId AND ismain=:Type";
	private static final String DAKMEMBERS = "SELECT a.dakmembertypeid,a.dakmembertype FROM dak_member_type a WHERE a.MemberTypeGrouping='N'";
	private static final String EMPLOYEELIST = "select a.empid,a.empname,b.divisioncode from employee a,division_master b where a.divisionid=b.divisionid and a.isactive='1' ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
    private static final String ACKNOWEDGED = "CALL Dak_Ack_Notify(:empId,:dakId)";
	private static final String MARKEDLIST = "SELECT distributiontypeid,distributiontype FROM dak_distribution where dakid=:dakId ORDER BY distributiontype";
	private static final String DAKFORWARDED = "Update dak set dakstatus=:status ,modifieddate=sysdate(),modifiedby=:userName where dakid=:dakId";
	private static final String DAKCOUNT = "SELECT COUNT(*) FROM dak WHERE Refdate BETWEEN  :startDate AND :endDate";
	private static final String DAKCOUNTFORDAKNOGENERATION = "SELECT COUNT(*) FROM dak WHERE DATE(CreatedDate) = CURDATE();";
	private static final String MARKNOTIFY = "CALL Dak_Mark_Notify(:empId,:dakId)";
	private static final String DAKLINKLIST = "SELECT dakid, dakno, subject FROM dak ORDER BY dakid DESC ";
	private static final String NONPROJECTLIST = "SELECT nonprojectid, nonprojectname FROM dak_non_project WHERE isactive='1' ORDER BY nonprojectid DESC";
	private static final String ACTIONLIST = "SELECT actionid,actionrequired  FROM dak_action WHERE isactive='1' ";
	private static final String CWLIST = "SELECT a.empid,a.empname,b.designation   FROM employee a, employee_desig b, login c WHERE c.formroleid='4'  AND  a.empid=c.empid AND  a.desigId=b.desigid AND  a.isactive='1' ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String DIVLIST = "select divisionid, divisioncode from division_master where isactive='1'";
	private static final String DELETEMARKED = "delete from dak_distribution where dakid=:dakId";
	private static final String DELETEMARKEDEMPLOYEE = "UPDATE dak_marking SET IsActive=0 WHERE DakMarkingId=:dakmarkingid AND DakId=:dakid AND DakMemberTypeId=:dakmembertypeid AND EmpId=:empid ";
	private static final String EDITDAK = "SELECT projectid AS id, 'P' AS idtype FROM dak_pro WHERE dakid=:dakid  UNION SELECT empid AS id, 'E' AS idtype FROM dak_assign WHERE dakid=:dakid";
	private static final String DELETEPRO = "delete from dak_pro where dakid=:dakId";
	private static final String DELETEASSIGN = "delete from dak_assign where dakid=:dakId";
	private static final String DAKREPLYATTACHDATA = "SELECT a.replyid, a.filepath,a.replyattachmentid,a.filename,b.remarks  FROM dak_reply_attachment a, dak_reply b WHERE a.ReplyId=b.dakreplyid and b.dakid=:dakid and a.empid=:empid and a.ismain=:type";
	private static final String REPLYATTACHMENTDETAILS = "SELECT filepath, filename from dak_reply_attachment WHERE replyAttachmentid=:replyattachmentid";
	private static final String DELETEREPLYATTACHMENT = "DELETE FROM dak_reply_attachment WHERE replyattachmentid=:replyattachmentid";
	private static final String UPDATEREPLY = "update dak_reply set remarks=:remarks, modifieddate=sysdate(),modifiedby=:userName where dakreplyid=:replyid";
	private static final String REPLYATTACHMENT = "SELECT filepath, filename,replyAttachmentid from dak_reply_attachment WHERE replyid=:replyid and ismain=:type";
	private static final String DAKRECEIVEDVIEWLIST = "SELECT a.createdBy, a.dakid,b.lettertype,c.priorityname,d.sourceshortname,a.Refno,a.dakstatus,a.Refdate,e.statusdesc,a.dakno,g.ActionRequired, a.KeyWord1,a.KeyWord2,a.KeyWord3,a.KeyWord4,a.Subject,a.ProjectType,a.Remarks,a.ActionDueDate,a.ActionTime,a.ClosingAuthority,a.DirectorApproval,(SELECT COUNT(m.FileName) FROM dak_attachment m WHERE m.DakId = a.DakId AND a.DakId=:dakId),a.ClosingCommt,(SELECT COUNT(r.DakLinkId) FROM dak_daklink r WHERE r.DakId = a.DakId AND a.DakId=:dakId),a.ActionId,a.ClosedBy FROM dak a,dak_letter_type b, dak_priority c,dak_source_details d,dak_status e,dak_action g WHERE a.lettertypeid=b.lettertypeid AND a.priorityid=c.priorityid AND a.SourceDetailId=d.SourceDetailId AND a.dakstatus=e.dakstatus  AND g.ActionId=a.ActionId AND a.DakId=:dakId";
	private static final String DISTRIBUTEDDAKMEMBERS = "SELECT m.DakMarkingId,m.DakMemberTypeId,m.EmpId,m.MarkerAction,m.Remarkup,(SELECT e.Email FROM employee e WHERE e.EmpId=m.EmpId)AS 'EmpMail',(SELECT e.EmpName FROM employee e WHERE e.EmpId=m.EmpId)AS 'EmpName',(SELECT h.Designation FROM employee g,employee_desig h WHERE g.EmpId=m.EmpId AND g.DesigId=h.DesigId) AS 'EmpDesig',(SELECT e.DronaEmail FROM employee e WHERE e.EmpId=m.EmpId)AS 'DronaEmpMail',a.DakNo  FROM dak_marking m,dak a WHERE m.DakId=:dakid AND a.DakId=m.DakId AND m.IsActive='1' ";
	private static final String DAKRECEIVEDLIST = "CALL Dms_DakReceivedList(:fromDate,:toDate,:statusvalue,:empId,:username)";
	private static final String DAKPENDINGREPLYLIST = "CALL Dms_DakPendingReplyList(:fromDate,:toDate,:statusvalue,:empId,:username,:lettertypeid,:priorityid,:sourcedetailid,:sourceId,:projectType,:projectId,:dakMemberTypeId,:employeeId)";
	private static final String DAKMARKERSDETAILSLIST = "CALL Dms_DakMarkersDetailsList(:dakid)";
	private static final String DAKDETAILEDLIST = "CALL Dms_DakDetailedList(:fromDate,:toDate,:statusvalue,:lettertypeid,:priorityid,:sourcedetailid,:sourceId,:projectType,:projectId,:dakMemberTypeId,:empId,:DivisionCode,:LabCode,:UserName)";
	private static final String DELETEMARKING = "delete from dak_marking where dakId=:dakId";
	private static final String DAKDISTRIBUTEDATA = "SELECT a.EmpId,a.EmpName,c.Designation,b.DakMemberTypeId,b.DakMarkingId,(SELECT CASE WHEN EXISTS (SELECT 1 FROM dak_attachment t  WHERE t.DakId =d.DakId)THEN (SELECT COUNT(t.DakAttachmentId) FROM dak_attachment t WHERE t.DakId =d.DakId)ELSE 0 END) AS 'DakAttachCount',(SELECT CASE WHEN d.ProjectType='P' THEN (SELECT p.ProjectDirector FROM  project_master p WHERE p.ProjectId=d.ProjectId)ELSE 0 END) AS 'PrjDirEmpId' FROM employee a,dak_marking b,employee_desig c,dak d WHERE a.EmpId=b.EmpId AND a.DesigId=c.DesigId AND b.DakAckStatus='N' AND b.DakId=d.DakId AND d.DakId=:dakId AND b.IsActive='1' ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
    private static final String DAKDISTRIBUTE = "Update dak set dakstatus='DD',DistributedDate=:date where dakid=:dakId";
	private static final String GETSOURCEDETAILS = "SELECT SourceDetailId,SourceId,SourceName,SourceShortName,ApiUrl,DivisionCode,LabCode FROM dak_source_details where SourceId=:sourceId order By SourceDetailId DESC";
	private static final String DAKLINKDATA = "SELECT DakId,LinkDakId FROM dak_daklink WHERE DakId=:dakId";
	private static final String DELETEDAKLINK = "delete from dak_daklink where dakid=:dakId";
	private static final String DAKACK = "Update dak_marking set DakAckStatus='Y',DakAckDate=:AckDate WHERE EmpId=:empId AND DakId=:dakIdSel";
	private static final String REVOKEMEMBER = "UPDATE dak_members a SET a.IsActive='0',a.ModifiedBy=:UserName,a.ModifiedDate=NOW() WHERE a.DakMembersId=:dakMembersId";
	private static final String DAKDISTRIBUTEDLIST = "CALL Dms_DakDistributedList(:EmpId,:fromdate,:todate)";
	private static final String UPDATEDAKSTATUS = "UPDATE dak set dakstatus='DA' WHERE dakid=:dakIdSel";
	private static final String OTHERPROJECTLIST = "SELECT ProjectOtherId, ProjectName,LabCode FROM dak_others_project WHERE isactive='1'";
	private static final String GETASSIGNEMPLIST = "SELECT a.EmpId,a.EmpName FROM employee a,project_employee b WHERE a.EmpId=b.EmpId AND b.ProjectId=:projectid AND a.LabCode=:lab AND a.EmpId<>:EmpId AND b.IsActive='1' ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String GETLABCODE = "SELECT labcode FROM employee WHERE empid=:empId";
	private static final String GETUSERNAME = "SELECT a.Empname,b.Designation FROM employee a,employee_desig b WHERE a.desigid=b.desigid AND a.empid=:empId";
	private static final String DAKDISTRIBUTEASSIGNDATA = "SELECT a.EmpId AS 'MarkedEmployeeId', a.EmpName,(SELECT c.Designation FROM employee_desig c WHERE a.DesigId = c.DesigId) AS 'Designation',(SELECT CASE WHEN b.DakAssignStatus = 'Y' THEN (SELECT COUNT(e.EmpId)FROM dak_assign e WHERE e.DakId = d.DakId AND e.IsActive = '1' AND e.DakMarkingId = b.DakMarkingId)ELSE 0 END) AS AssignedEmpCount,b.MarkerAction,(SELECT CASE WHEN EXISTS (SELECT r.SeekEmpId FROM dak_seekresponse r WHERE r.DakId = d.dakid AND r.SeekAssignerId=b.DakMarkingId)THEN (SELECT COUNT(r.SeekEmpId) FROM dak_seekresponse r  WHERE d.dakid = r.dakid AND r.SeekAssignerId=b.DakMarkingId) ELSE 0 END ) AS countofSeekEmpId,(SELECT CASE WHEN EXISTS (SELECT r.RemindBy FROM dak_remind r WHERE r.DakId = d.dakid AND b.EmpId=r.RemindBy)THEN (SELECT COUNT(r.RemindBy) FROM dak_remind r  WHERE d.dakid = r.dakid AND b.EmpId=r.RemindBy) ELSE 0 END ) AS countofRemindByEmpId ,(SELECT CASE WHEN EXISTS (SELECT r.RemindTo FROM dak_remind r WHERE r.DakId = d.dakid AND b.EmpId=r.RemindTo)THEN (SELECT COUNT(r.RemindTo) FROM dak_remind r  WHERE d.dakid = r.dakid AND b.EmpId=r.RemindTo) ELSE 0 END ) AS countofRemindToEmpId,(SELECT CASE WHEN EXISTS (SELECT r.DakId FROM dak_remind r WHERE r.DakId = d.dakid AND b.DakId=r.DakId)THEN (SELECT COUNT(r.DakId) FROM dak_remind r  WHERE d.dakid = r.dakid AND b.DakId=r.DakId) ELSE 0 END ) AS countofDakId,(SELECT CASE WHEN EXISTS (SELECT r.Comment FROM dak_remind r WHERE r.DakId = d.dakid AND b.EmpId=r.RemindTo)THEN (SELECT COUNT(r.Comment) FROM dak_remind r  WHERE d.dakid = r.dakid AND b.EmpId=r.RemindTo AND r.CommentType='R') ELSE 0 END ) AS countofreply,(SELECT b.DakAckStatus WHERE b.DakId=d.DakId) AS DakAckStatus,(SELECT COUNT(r.DakId) FROM dak_reply r WHERE r.EmpId=b.EmpId AND r.DakId=d.DakId) AS DakReplyCount FROM employee a, dak_marking b, dak d WHERE a.EmpId = b.EmpId AND b.DakId = d.DakId AND d.DakId =:dakId  AND b.IsActive = 1 ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
	private static final String FACILITATORSLIST = "SELECT a.DakAssignId,a.EmpId,a.Remarks,a.ReplyStatus,e.EmpName,(SELECT c.Designation FROM  employee_desig c WHERE e.DesigId=c.DesigId ) AS 'Designation',(SELECT CASE WHEN EXISTS (SELECT r.SeekEmpId FROM dak_seekresponse r WHERE r.DakId = a.dakid AND r.SeekAssignerId=a.DakAssignId)THEN (SELECT COUNT(r.SeekEmpId) FROM dak_seekresponse r  WHERE a.dakid = r.dakid AND r.SeekAssignerId=a.DakAssignId) ELSE 0 END ) AS countofSeekEmpId,(SELECT CASE WHEN EXISTS (SELECT r.RemindTo FROM dak_remind r WHERE r.DakId = a.dakid AND a.EmpId=r.RemindTo)THEN (SELECT COUNT(r.RemindTo) FROM dak_remind r  WHERE a.dakid = r.dakid AND a.EmpId=r.RemindTo) ELSE 0 END ) AS countofRemindToEmpId FROM dak_assign a,dak_marking b,employee e WHERE a.DakId=:dakId AND a.DakId=b.DakId AND b.EmpId=:markerEmpId AND b.DakMarkingId=a.DakMarkingId AND a.EmpId=e.EmpId";
	private static final String DAKREPLYATTACHMENTDATA = "SELECT ReplyId, FilePath,ReplyAttachmentId,FileName  FROM dak_reply_attachment WHERE ReplyId=:replyid";
	private static final String UPDATEDAKASSIGNSTATUS = "UPDATE dak_marking set DakAssignStatus='Y' WHERE DakMarkingId=:DakMarkingIdsel";
	private static final String GETDAKASSIGNEDLIST = "CALL Dms_DakAssignedListToMe(:empId,:fromDate,:toDate,:SelEmpId)";
	private static final String GETREPLYMODALDETAILS = "CALL Dms_DakReplyModalList(:dakid,:empid,:username,:dakadmin)";
	private static final String GETREPLYATTACHMODALDETAILS = "SELECT ReplyAttachmentId,ReplyId,EmpId,FilePath,FileName,CreatedBy,CreatedDate FROM dak_reply_attachment WHERE ReplyId=:dakreplyid";
	private static final String DAKREPLYATTACHMENTDETAILS = "SELECT FilePath, FileName , ReplyId  FROM dak_reply_attachment WHERE ReplyAttachmentId=:replyattachmentid";
	private static final String PARTICULARDAKREPLYATTACHDATA = "SELECT FilePath,FileName,ReplyAttachmentId,ReplyId,EmpId,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate FROM dak_reply_attachment WHERE ReplyAttachmentId=:dakReplyAttachId AND ReplyId=:dakReplyId";
	private static final String GETREPLYVIEWMOREDETAILS ="SELECT a.DakReplyId,a.Remarks,(SELECT COUNT(d.ReplyAttachmentId) FROM dak_reply_attachment d WHERE d.ReplyId=a.DakReplyId) AS 'dakReplyAttachCount' FROM  dak_reply a WHERE a.DakReplyId=:dakreplyid ";
   //private static final String GETNONOTHERPROJECTLIST = "SELECT EmpId,EmpName FROM employee WHERE LabCode=:lab AND EmpId<>:EmpId AND DivisionId=:divid AND IsActive='1' ORDER BY SrNo";
	private static final String GETSEEKRESPONSEEMPLIST = "SELECT e.EmpId, e.EmpName,COALESCE((SELECT g.Designation FROM employee_desig g WHERE g.DesigId = e.DesigId),'--') AS 'Designation'FROM employee e WHERE e.LabCode=:lab AND e.EmpId<>:empid AND e.IsActive='1' ORDER BY CASE WHEN e.Srno = 0 THEN 1 ELSE 0 END, e.Srno ASC";
	private static final String GETEMPLISTFORASSIGNING = "CALL Dms_DakAssignEmployeeList(:dakid,:lab,:EmpId)";
	private static final String DELETEREPLYATTACHMENTDATA = "DELETE FROM dak_reply_attachment WHERE ReplyAttachmentId=:dakreplyattachmentid";
	private static final String UPDATEDAKREPLY ="UPDATE dak_reply SET Remarks=:reply,ModifiedBy=:modifiedBy,ModifiedDate=:modifiedDate WHERE DakReplyId=:dakReplyId AND DakId=:dakId";
	private static final String GETCSWREPLYMODALDETAILS = "CALL Dms_DakCSWReplyModalList(:dakid,:empid,:username,:dakadmin)";
	private static final String GETSPECIFICMARKERSCSWREPLYDETAILS = "SELECT r.DakId,r.DakAssignId,r.DakAssignReplyId, r.EmpId AS 'AssignReplyEmpId',(SELECT e.EmpName FROM employee e WHERE e.EmpId=r.EmpId) AS 'FacilitatorName',(SELECT d.Designation FROM employee e,employee_desig d  WHERE e.EmpId=r.EmpId AND e.DesigId=d.DesigId) AS 'FacilitatorDesig',r.Reply,(SELECT CASE WHEN EXISTS (SELECT 1 FROM dak_assign_reply_attachment a WHERE a.DakAssignReplyId = r.DakAssignReplyId)THEN (SELECT COUNT(a.DakAssignReplyAttachmentId) FROM dak_assign_reply_attachment a WHERE a.DakAssignReplyId = r.DakAssignReplyId) ELSE 0 END ) AS 'DakAssignReplyAttachCount',(SELECT g.EmpName FROM employee g WHERE g.EmpId=m.EmpId) AS'MarkedEmpName',(SELECT h.Designation FROM employee g,employee_desig h WHERE g.EmpId=m.EmpId AND g.DesigId=h.DesigId) AS'MarkedEmpDesig',a.DakStatus,r.CreatedDate FROM dak_assign_reply r,dak_marking m, dak_assign n,dak a  WHERE r.DakId =:dakid   AND r.DakId=a.DakId  AND n.DakAssignId=r.DakAssignId  AND n.DakMarkingId=:dakmarkingid AND n.DakMarkingId=m.DakMarkingId";
	private static final String GETREPLYCSWATTACHMODALDETAILS = "SELECT DakAssignReplyAttachmentId,DakAssignReplyId,EmpId,FilePath,FileName,CreatedBy,CreatedDate,DakId FROM dak_assign_reply_attachment WHERE DakAssignReplyId=:dakassignreplyid";
	private static final String PARTICULARCSWREPLYDETAILS = "SELECT r.DakAssignReplyId,r.DakAssignId,r.EmpId,r.Reply,r.CreatedBy,r.CreatedDate,r.DakId,(SELECT COUNT(a.DakAssignReplyAttachmentId) FROM dak_assign_reply_attachment a WHERE a.DakAssignReplyId = r.DakAssignReplyId) AS 'DakAssignReplyAttachCount' FROM dak_assign_reply r WHERE DakAssignReplyId=:dakassignreplyid";
    private static final String DAKREPLYCSWATTACHMENTDETAILS = "SELECT FilePath, FileName FROM dak_assign_reply_attachment WHERE DakAssignReplyAttachmentId=:replycswattachmentid";
	private static final String DAKDIRECTORLIST = "CALL Dms_DakDirectorList(:fromDate,:toDate,:statusvalue)";
	private static final String DIRPENDINGAPPROVALS = "CALL Dms_DakDirPendingApprovalList(:lettertypeid,:priorityid,:sourcedetailid,:sourceId,:projectType,:projectId,:dakMemberTypeId,:employeeId)";
	private static final String DAKEMPDETAILSLIST = "CALL Dms_DakEmpDetailsList(:fromDate,:toDate)";
    private static final String INDIVIDUALREPLYDETAILS = "SELECT r.DakReplyId,r.EmpId,r.Remarks,r.ReplyStatus,r.CreatedBy, r.CreatedDate,e.EmpName,(SELECT d.Designation FROM employee_desig d WHERE e.DesigId=d.DesigId),r.DakId,a.DakStatus FROM dak_reply r,employee e,dak a WHERE r.DakId=a.DakId AND r.EmpId = e.EmpId    AND r.DakReplyId =:dakReplyId AND r.EmpId=:empId AND r.DakId=:dakId";
	private static final String UPDATEDAKMARKING = "UPDATE dak_marking SET MsgType=:msgtype WHERE DakMarkingId=:dakmarkingid AND DakId=:dakid AND EmpId=:empid";
	private static final String DAKASSIGNREPLYATTACHMENTDATA="SELECT FilePath,DakAssignReplyAttachmentId,FileName FROM dak_assign_reply_attachment WHERE DakAssignReplyId=:dakAssignId";
    private static final String UPDATEASSIGNREPLYSTATUS="UPDATE dak_assign set ReplyStatus='Y' WHERE DakAssignId=:dakAssignId";
	private static final String EMPIDCOUNTOFDAKMARKING="SELECT COUNT(EmpId)  FROM dak_marking WHERE dakId=:dakIdSel AND IsActive='1'";
    private static final String DAKACKCOUNTOFDAKMARKING="SELECT COUNT(DakAckStatus) FROM dak_marking WHERE dakId=:dakIdSel AND DakAckStatus='Y' AND IsActive='1'";
    private static final String DAKREPLYCOUNTOFDAKREPLY="SELECT COUNT(EmpId)  FROM dak_reply WHERE dakId=:dakIdSel AND ReplyStatus='R' ";
    private static final String UPDATEDAKSTATUSTODR = "UPDATE dak SET DakStatus='DR' WHERE DakId=:dakid";
    private static final String DAKPNCDOLIST="CALL Dms_DakPnCDOList(:fromDate,:toDate,:statusvalue,:lettertypeid,:priorityid,:sourcedetailid,:sourceId,:projectType,:projectId,:dakMemberTypeId,:empId,:actionId)";
    private static final String DAKPNCLIST="CALL Dms_DakPnCList(:empId,:loginType, :fromDate,:toDate,:statusValue)";
    private static final String DAKPENDINGPNCREPLYLIST="CALL Dms_DakPnCPendingReplyList(:empId,:loginType,:fromDate,:toDate,:statusValue)";
    private static final String GETREPLYDETAILSOFDAKREPLY = "SELECT r.DakReplyId,r.EmpId, r.Remarks,r.ReplyStatus,r.CreatedBy, r.CreatedDate, e.EmpName,d.Designation,r.DakId,(SELECT COUNT(a.ReplyAttachmentId) FROM dak_reply_attachment a WHERE a.ReplyId = r.DakReplyId) AS DakReplyAttachCount,(SELECT  CASE WHEN b.loginTypeDms IN ('E','L')  OR b.Username =:dakadmin THEN 'ReplyForward' ELSE 'NA' END) AS ReplyAction,(SELECT COUNT(s.DakAssignId) FROM dak_assign_reply s,dak_assign t,dak_marking g  WHERE s.DakId = a.dakid AND s.DakAssignId=t.DakAssignId AND g.DakMarkingId=t.DakMarkingId AND g.EmpId=r.EmpId ) AS CountOfDakAssignReplyId,(SELECT m.DakMarkingId FROM dak_marking m WHERE m.DakId=a.DakId AND m.EmpId=r.EmpId LIMIT 1)AS DakMarkingId FROM dak_reply r, login b , employee e, employee_desig d,dak a  WHERE  a.DakId =:dakid AND  r.DakId =a.dakId AND r.EmpId=e.EmpId  AND e.DesigId=d.DesigId AND b.Username=:username AND b.EmpId =:empid  ORDER BY r.DakReplyId;";
    private static final String GETREPLYATTACHSLIST = "SELECT ReplyAttachmentId,ReplyId,EmpId,FilePath,FileName,CreatedBy,CreatedDate FROM dak_reply_attachment";
    private static final String PNCDAKREPLYATTACHMENTDATA = "SELECT DakPnCReplyId, FilePath,PnCReplyAttachId,FileName  FROM dak_pnc_reply_attachment WHERE DakPnCReplyId=:pncreplyid";
    private static final String UPDATEPANDCDAKSTATUS="UPDATE dak set DakStatus='RP' WHERE DakId=:dakid";
    private static final String MARKERREPLIEDDATAFORAPPROVE = "SELECT r.DakReplyId,r.DakId,r.EmpId,r.Remarks,r.ReplyStatus,r.CreatedBy,r.CreatedDate,a.DakNo,(SELECT COUNT(c.ReplyAttachmentId) FROM  dak_reply_attachment c WHERE c.ReplyId=r.DakReplyId ) AS 'AttachCount',a.RefNo,a.Refdate,(SELECT d.sourceshortname FROM dak_source_details d WHERE a.sourcedetailid=d.sourcedetailid) AS 'sourceShortName',a.ActionDueDate,(SELECT g.EmpName FROM employee g WHERE g.EmpId=r.EmpId) AS'MarkedEmpName',(SELECT h.Designation FROM employee g,employee_desig h WHERE g.EmpId=r.EmpId AND g.DesigId=h.DesigId) AS'MarkedEmpDesig' FROM  dak_reply  r , dak a WHERE r.DakId=:dakid AND r.DakId=a.DakId AND r.EmpId=:dakaprvforwaderid";
    private static final String PNCREPLYDATA="SELECT r.DakPnCReplyId,r.DakId,r.EmpId,r.PnCReply,r.PnCReplyStatus,r.CreatedBy,r.CreatedDate,a.DakNo,(SELECT COUNT(c.PnCReplyAttachId) FROM  dak_pnc_reply_attachment c WHERE c.DakPnCReplyId=r.DakPnCReplyId ) AS 'AttachCount',a.RefNo,a.Refdate,(SELECT d.sourceshortname FROM dak_source_details d WHERE a.sourcedetailid=d.sourcedetailid) AS 'sourceShortName',a.ActionDueDate,e.EmpName,d.Designation,r.ReturnedCommt FROM  dak_pnc_reply  r , dak a,employee e,employee_desig d WHERE r.DakId=:dakid AND r.DakId=a.DakId AND e.EmpId=r.empId AND e.DesigId=d.DesigId";
    private static final String PNCREPLYATTACHDATA = "SELECT a.PnCReplyAttachId,a.DakPnCReplyId,a.EmpId,a.FilePath,a.FileName,a.CreatedBy,a.CreatedDate FROM dak_pnc_reply_attachment a WHERE a.DakPnCReplyId=:dakpncreplyid ";
    private static final String DAKPNCREPLYDOWNLOAD = "SELECT FilePath, FileName , DakPnCReplyId  FROM dak_pnc_reply_attachment WHERE PnCReplyAttachId=:pncreplyattachid";
    private static final String UPDATESTATUSFRAPPROVAL = "UPDATE dak SET DakStatus=:status ,ApprovedBy=:approvedby ,ApprovedDateTime=:approveddate  WHERE DakId=:dakid";
    private static final String UPDATESTATUSFRAPPROVALWITHCOMMT = "UPDATE dak SET DakStatus=:status ,ApprovedBy=:approvedby ,ApprovedCommt=:approvedcommt,ApprovedDateTime=:approveddate  WHERE DakId=:dakid";
    private static final String UPDATESTATUSFRDAKPNCFORWARD = "UPDATE dak SET DakStatus=:status,ForwardBy=:forwardby ,ForwardDate=:forwarddate WHERE DakId=:dakid";
    private static final String UPDATESTATUSFRDAKRETURN = "UPDATE dak_pnc_reply SET PnCReplyStatus=:pncreplystatus,ReturnedCommt=:returnedcomment WHERE DakId=:dakid";
    private static final String UPDATEDIRAPPROVALACTION = "UPDATE dak SET DirectorApproval=:dirapprovalval WHERE DakId=:dakid ";
    private static final String UPDATEDIRAPVFWDERIDANDSTATUS = "UPDATE  dak SET DirApvForwarderId=:dirApvForwarderId,DakStatus=:dakstatus  WHERE DakId=:dakid ";
    private static final String PNCREPLYDATALIST = "SELECT r.DakPnCReplyId,r.DakId,r.EmpId,r.PnCReply,r.PnCReplyStatus,r.CreatedBy,r.CreatedDate,a.DakNo,a.DakStatus,a.ApprovedCommt,r.ReturnedCommt FROM  dak_pnc_reply  r , dak a WHERE r.DakPnCReplyId=:pncReplyId AND r.DakId=:dakid AND r.DakId=a.DakId";
	private static final String PARTICULARDAKPNCREPLYATTACHDATA = "SELECT FilePath,FileName,PnCReplyAttachId,DakPnCReplyId,EmpId,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate FROM dak_pnc_reply_attachment WHERE PnCReplyAttachId=:DakPnCReplyAttachId AND DakPnCReplyId=:DakPnCReplyId";
	private static final String DELETEPNCREPLYATTACHMENT = "DELETE FROM dak_pnc_reply_attachment WHERE PnCReplyAttachId=:PnCReplyAttachId AND DakPnCReplyId=:DakPnCReplyId";
	private static final String UPDATEPNCREPLY = "UPDATE dak_pnc_reply SET EmpId=:empid ,PnCReply=:pnCReplyData ,PnCReplyStatus=:pnCReplyStatus ,ModifiedBy=:modifiedBy ,ModifiedDate=:modifiedDate WHERE DakPnCReplyId=:pnCReplyId AND DakId=:dakid";
	private static final String UPDATESTATUSFRDAKCLOSE = "UPDATE dak SET DakStatus=:status ,ClosedBy=:closedBy ,ClosedDateTime=:closedDateTime,ClosedDate=:closedDate,ClosingCommt=:closingCommt WHERE DakId=:dakid";
    private static final String DAKCLOSEDLIST = "CALL Dms_DakClosedList(:frmDt, :toDt, :statusvalue ,:logintype , :username , :empid,:lettertypeid,:priorityid,:sourcedetailid,:sourceId,:projectType,:projectId,:dakMemberTypeId,:employeeId,:DivisionCode,:LabCode)";
    private static final String DAKDETAILSFORPNCDO = "SELECT  a.dakid,a.Refno,a.dakstatus,a.Refdate,a.dakno,a.ActionDueDate,a.SourceId,ClosedDate,a.subject ,a.ProjectType, a.ProjectId,(SELECT CASE WHEN EXISTS (SELECT r.DakReplyId FROM dak_reply r WHERE r.DakId = a.dakid)THEN (SELECT COUNT(r.DakReplyId) FROM dak_reply r  WHERE a.dakid = r.dakid)ELSE 0 END ) AS replyCountOverall,    (SELECT CASE WHEN EXISTS (SELECT r.DakAssignId FROM dak_assign_reply r WHERE r.DakId = a.dakid )THEN (SELECT COUNT(r.DakAssignReplyId) FROM dak_assign_reply r  WHERE a.dakid = r.dakid) ELSE 0 END ) AS replyCWCountOverall,a.DirectorApproval,a.ClosingAuthority  FROM dak a WHERE a.dakId=:dakid";
    private static final String REVOKEMARKING="UPDATE dak_marking SET IsActive='0' WHERE DakMarkingId=:markingId";
    private static final String DAKMEMBERGROUP="SELECT a.DakMemberTypeId,a.DakMemberType FROM dak_member_type a WHERE a.MemberTypeGrouping='Y'";
    private static final String ASSIGNREPLYDATA="SELECT r.Reply,b.EmpName,c.Designation,r.DakAssignReplyId,r.EmpId,(SELECT CASE WHEN EXISTS (SELECT 1 FROM dak_assign_reply_attachment a WHERE a.DakAssignReplyId = r.DakAssignReplyId) THEN (SELECT COUNT(a.DakAssignReplyAttachmentId) FROM dak_assign_reply_attachment a WHERE a.DakAssignReplyId = r.DakAssignReplyId) ELSE 0  END  ) AS DakReplyAttachCount,r.ReplyStatus,r.CreatedDate  FROM dak_assign_reply r,employee b,employee_desig c WHERE  b.DesigId=c.DesigId AND r.EmpId=b.EmpId AND r.EmpId=:empId AND r.DakId=:dakIdSel";
    private static final String GETASSIGNREPLYATTACHMODALDETAILS="SELECT DakAssignReplyAttachmentId,DakAssignReplyId,EmpId,FilePath,FileName,CreatedBy,CreatedDate FROM dak_assign_reply_attachment WHERE DakAssignReplyId=:dakAsssignReplyId";
    private static final String GETASSIGNREPLYVIEWMOREDETAILS ="SELECT a.DakAssignReplyId,a.Reply FROM  dak_assign_reply a WHERE a.DakAssignReplyId=:dakAsssignReplyId";
    private static final String UPDATEDAKASSIGNREPLY="UPDATE dak_assign_reply SET Reply=:reply,ModifiedBy=:modifiedBy,ModifiedDate=:modifiedDate WHERE DakAssignReplyId=:DakAssignReplyId AND DakId=:DakId AND DakAssignId=:DakAssignId AND EmpId=:DakEmpId";
    private static final String PARTICULARDAKASSIGNREPLYATTACHDATA="SELECT FilePath,FileName,DakAssignReplyAttachmentId,DakAssignReplyId,EmpId,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,DakId FROM dak_assign_reply_attachment WHERE DakAssignReplyAttachmentId=:dakAssignReplyAttachId AND DakAssignReplyId=:dakAssignReplyId";
    private static final String DELETEASSIGNREPLYATTACHMENTDATA="DELETE FROM dak_assign_reply_attachment WHERE DakAssignReplyAttachmentId=:dakAssignReplyAttachId";
    private static final String DAKMARKINGDATA = "SELECT a.DakMemberTypeId,a.EmpId ,e.empname FROM dak_marking a,dak b, employee e WHERE a.DakId=b.DakId AND e.empid=a.EmpId AND b.DakId=:dakId AND a.IsActive=1";
    private static final String DAKMARKEDGROUPMEMBERS="SELECT a.DakMemberTypeId,a.DakMemberType,b.EmpId FROM dak_member_type a,dak_marking b WHERE a.DakMemberTypeId=b.DakMemberTypeId AND b.DakId=:dakId AND a.MemberTypeGrouping='Y' AND b.IsActive=1";
    private static final String DAKMARKEDGROUPMEMBERSINACTIVE="SELECT a.DakMemberTypeId,a.DakMemberType,b.EmpId FROM dak_member_type a,dak_marking b WHERE a.DakMemberTypeId=b.DakMemberTypeId AND b.DakId=:dakId AND a.MemberTypeGrouping='Y' AND b.IsActive=0";
    private static final String INDMARKEDEMPLIST="";
    private static final String CSWREPLYFORWARDRETURN="UPDATE dak_assign_reply SET ReplyStatus='F',ReturnRemarks=:ReturnRemarks WHERE DakAssignReplyId=:dakAssignReplyIdFrReturn";
    private static final String COUNTREVISIONNO="SELECT MAX(a.revisionno) FROM dak_assign_reply_rev  a WHERE a.DakAssignReplyId=:dakAssignReplyId";
    private static final String GETACTIONREQUIREDFOREDIT="SELECT a.ActionId,a.ActionRequired,b.ActionDueDate,b.ActionTime,b.ClosingAuthority,b.Remarks FROM dak_action a ,dak b WHERE a.ActionId=b.ActionId AND b.DakId=:actionRequiredDakId";
    private static final String PROJECTDETAILSLIST="SELECT p.ProjectDirector,e.EmpName FROM project_master p,employee e WHERE p.ProjectId=:projectid AND p.ProjectDirector = e.EmpId";
    private static final String EDITACTIONREQUIRED="UPDATE dak SET ActionId=:actionRequiredEdit,ActionDueDate=NULL,ActionTime=NULL,ReplyOpen='N',ClosingAuthority=:ClosingAuthority,Remarks=:EditRemarks WHERE DakId=:actionRequiredEditDakId";
    private static final String EDITACTIONREQUIREDDUEDATE="UPDATE dak SET ActionId=:actionRequiredEdit,ActionDueDate=:dueDate,ActionTime=:actionTime,ReplyOpen='Y',ClosingAuthority=:ClosingAuthority,Remarks=:EditRemarks WHERE DakId=:actionRequiredEditDakId";
    private static final String UPDATEDAKMARKINGACTION="UPDATE dak_marking SET ActionId=:actionId,Replyopen='Y',ActionDueDate=:dueDate WHERE DakId=:actionRequiredEditDakId";
    private static final String UPDATEDAKMARKINGRECORDS="UPDATE dak_marking SET ActionId=:actionId,Replyopen='N',ActionDueDate=NULL WHERE DakId=:actionRequiredEditDakId";
    private static final String REUPDATEREMARKUPSTATUS="UPDATE dak_marking set Remarkup='N' WHERE Remarkup='Y' AND  DakId=:dakId";
    private static final String DAKREDISTRIBUTEDATA="SELECT a.EmpId,a.EmpName,c.Designation,b.DakMemberTypeId,b.DakMarkingId,(SELECT CASE WHEN EXISTS (SELECT 1 FROM dak_attachment t  WHERE t.DakId =d.DakId)THEN (SELECT COUNT(t.DakAttachmentId) FROM dak_attachment t WHERE t.DakId =d.DakId)ELSE 0 END) AS 'DakAttachCount',(SELECT CASE WHEN d.ProjectType=\\\"P\\\" THEN (SELECT p.ProjectDirector FROM  project_master p WHERE p.ProjectId=d.ProjectId)ELSE 0 END) AS 'PrjDirEmpId'    FROM employee a,dak_marking b,employee_desig c,dak d WHERE a.EmpId=b.EmpId AND a.DesigId=c.DesigId AND b.DakAckStatus='N' AND b.Remarkup='Y' AND b.DakId=d.DakId AND d.DakId=:dakId AND b.IsActive='1' ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
    private static final String GETASSIGNID="SELECT DakAssignId,Remarks FROM dak_assign WHERE DakId=:dakId AND dakmarkingId=:dakMarkingId";
    private static final String UPDATEMARKERACTIONINFO="UPDATE dak_marking SET MarkerAction=:MarkerAction WHERE DakId=:DakId AND EmpId=:EmpId AND DakMarkingId=:MarkedId";
    private static final String GETOLDASSIGNEMPLIST="SELECT a.EmpId,a.DakMarkingId,e.EmpName,c.Designation,(SELECT COUNT(*) FROM dak_assign_reply r WHERE r.DakId=:dakId AND r.EmpId=a.EmpId) AS 'replycount',a.Remarks FROM dak_assign a,employee e,employee_desig c WHERE e.EmpId=a.EmpId AND e.DesigId=c.DesigId AND a.DakId=:dakId AND a.IsActive='1'";
    private static final String UPDATEMARKERACTION="UPDATE dak_marking SET MarkerAction=:actionValue WHERE DakId=:dakId AND EmpId=:empId AND DakMarkingId=:dakMarkingId";
    private static final String DAKASSIGNEDBYMELIST="CALL Dms_DakAssignedByMeList(:empId,:fromDate,:toDate,:SelEmpId)";
    private static final String ALLDAKLINKLIST=" SELECT b.LinkDakId,(SELECT z.DakNo FROM dak z WHERE z.DakId=b.LinkDakId) FROM dak_daklink  b WHERE b.DakId=:dakId";
	private static final String DAKREMARKNREDISTRIBUTELIST="CALL Dms_DakRemarknRedistributeList(:fromDate,:toDate,:statusValue)";
    private static final String DAKASSIGNRESPONSELISTTOME="CALL Dms_DakSeekResponseListToMe(:empId,:fromDate,:toDate)";
    private static final String DAKSEEKRESPONSEBYMELIST="CALL Dms_DakSeekResponseByMeList(:empId,:fromDate,:toDate)";
    private static final String UPDATESEEKRESPONSEREPLY="UPDATE dak_seekresponse SET Reply=:reply,ReplyStatus=:replyStatus,RepliedBy=:RepliedBy,RepliedDate=:RepliedDate WHERE SeekResponseId=:seekResponseId";
    private static final String DAKSEEKRESPONSEATTACHMENTDATA="SELECT FilePath,SeekResponseAttachmentId,FileName FROM dak_seekresponse_attachment WHERE SeekResponseId=:seekResponseId";
    private static final String GETSEEKRESPONSEREPLYMODALDETAILS="CALL Dms_DakSeekResponseReplyModalList(:dakId,:empId,:username,:dakadmin)";
    private static final String GETSEEKRESPONSEREPLYATTACHMODALDETAILS="SELECT SeekResponseAttachmentId,SeekResponseId,EmpId,FilePath,FileName,CreatedBy,CreatedDate FROM dak_seekresponse_attachment WHERE SeekResponseId=:dakReplyId";
    private static final String GETSEEKRESPONSEREPLYVIEWMOREDETAILS="SELECT a.SeekResponseId,a.Reply FROM  dak_seekresponse a WHERE a.SeekResponseId=:dakreplyid";
    private static final String PARTICULARDAKSEEKRESPONSEREPLYATTACHDATA="SELECT FilePath,FileName,SeekResponseAttachmentId,SeekResponseId,EmpId,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate,DakId FROM dak_seekresponse_attachment WHERE SeekResponseAttachmentId=:dakReplyAttachId AND SeekResponseId=:dakReplyId";
    private static final String DELETESEEKRESPONSEREPLYATTACHMENT="DELETE FROM dak_seekresponse_attachment WHERE SeekResponseAttachmentId=:dakReplyAttachId";
    private static final String UPDATESEEKRESPONSEUPDATE="UPDATE dak_seekresponse SET Reply=:reply,ModifiedBy=:modifiedBy,ModifiedDate=:modifiedDate WHERE SeekResponseId=:seekResponseId";
    private static final String DAKSEEKRESPONSEATTACHMENTDETAILS="SELECT filepath, filename , dakid FROM dak_seekresponse_attachment WHERE SeekResponseAttachmentId=:dakattachmentid";
    private static final String OLDSEEKRESPONSEEMPID="SELECT SeekEmpId,SeekResponseId FROM dak_seekresponse WHERE DakId=:dakId";
    private static final String GETPREVMARKEDEMPS="SELECT EmpId,DakMarkingId FROM dak_marking WHERE DakId=:dakId";
    private static final String ADDTOFAVOURITES="UPDATE dak_marking SET Favourites=1 WHERE DakMarkingId=:dakMarkingId";
    private static final String REMOVEFROMFAVOURITES="UPDATE dak_marking SET Favourites=0 WHERE DakMarkingId=:dakMarkingId";
    private static final String DAKREPLIEDTOMELIST="CALL Dms_DakRepliedToMeList(:fromDate,:toDate,:username)";
    private static final String DAKREPLIEDBYMELIST="CALL Dms_DakRepliedByMeList(:fromDate,:toDate,:empId,:lettertypeid,:priorityid,:sourcedetailid,:sourceId,:projectType,:projectId,:dakMemberTypeId,:employeeId)";
//    private static final String GETEMPLISTFORSEEKRESPONSE="SELECT e.EmpId, e.EmpName,COALESCE((SELECT g.Designation FROM employee_desig g WHERE g.DesigId = e.DesigId),'--') AS 'Designation'FROM employee e WHERE e.LabCode=:lab AND e.EmpId<>:empId AND e.IsActive='1' AND e.EmpId NOT IN (SELECT m.EmpId  FROM dak_marking m WHERE m.DakId = :dakId)  AND e.EmpId NOT IN (SELECT f.EmpId  FROM dak_Assign f WHERE f.DakId = :dakId) ORDER BY e.SrNo;";
   
    private static final String GETEMPLISTFORSEEKRESPONSE="SELECT e.EmpId, e.EmpName,COALESCE((SELECT g.Designation FROM employee_desig g WHERE g.DesigId = e.DesigId),'--') AS 'Designation'FROM employee e WHERE e.LabCode=:lab AND e.EmpId<>:empId AND e.IsActive='1' ORDER BY CASE WHEN e.Srno = 0 THEN 1 ELSE 0 END, e.Srno ASC";

    private static final String GETCLOSEDBYNAME="SELECT a.EmpName,b.Designation FROM employee a,employee_desig b,login c WHERE a.EmpId=c.EmpId AND a.DesigId=b.DesigId AND c.UserName=:closedBy";
    private static final String EMPLOYEELISTDROPDOWN="SELECT a.EmpId,a.EmpName,b.Designation FROM employee a,employee_desig b WHERE a.DesigId=b.DesigId AND a.Labcode=:lab AND a.IsActive='1' ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";
    private static final String MARKEDEMPCOUNTS="CALL Dms_DakMarkedEmpCounts(:emp,:fromDate,:toDate,:username)";
    private static final String ASSIGNEDEMPCOUNTS="CALL Dms_DakAssignedEmpCounts(:emp,:fromDate,:toDate,:username)";
    private static final String DAKRECEIVEDVIEWRECEIVEDLIST="CALL Dms_DakReceivedViewList(:empId,:dakId)";
    private static final String ASSIGNDATA="SELECT ReplyStatus,DakAssignId FROM dak_assign WHERE DakId=:dakId AND EmpId=:empId";
    private static final String SEEKRESPONSEDATA="SELECT ReplyStatus,SeekResponseId FROM dak_seekresponse WHERE DakId=:dakId AND SeekEmpId=:empId";
    private static final String MARKERDATA=" SELECT DakMarkingId,DakAckStatus,DakAssignStatus,MsgType,MarkerAction FROM dak_marking WHERE DakId=:dakId AND EmpId=:empId";
    private static final String GETDAKATTACHID="SELECT DakAttachmentId FROM dak_attachment WHERE DakId=:dakId AND IsMain=:type";
    private static final String SEEKRESPONSEEMPDETAIL="SELECT a.SeekResponseId,a.SeekEmpId,a.Reply,a.ReplyStatus,e.EmpName,(SELECT c.Designation FROM  employee_desig c WHERE e.DesigId=c.DesigId ) AS 'Designation' FROM dak_seekresponse a,dak_marking b,employee e WHERE a.DakId=:dakId AND a.DakId=b.DakId AND b.EmpId=:markerEmpId AND b.DakMarkingId=a.SeekAssignerId AND a.SeekEmpId=e.EmpId";
    private static final String FACILITATORSEEKRESPONSEEMPDETAIL="SELECT a.SeekResponseId,a.SeekEmpId,a.Reply,a.ReplyStatus,e.EmpName,(SELECT c.Designation FROM  employee_desig c WHERE e.DesigId=c.DesigId ) AS 'Designation' FROM dak_seekresponse a,dak_assign b,employee e WHERE a.DakId=:dakId AND a.DakId=b.DakId AND b.EmpId=:assignEmpId AND b.DakAssignId=a.SeekAssignerId AND a.SeekEmpId=e.EmpId";
    private static final String GETREMINDEMPLOYEELIST="SELECT a.EmpId, a.EmpName, b.Designation, c.DakMarkingId, a.Srno,'DakReceivedList.htm' AS 'url' FROM employee a JOIN employee_desig b ON a.DesigId = b.DesigId JOIN dak_marking c ON c.EmpId = a.EmpId JOIN dak d ON c.DakId = d.DakId WHERE d.DakId =:dakId AND c.EmpId NOT IN (SELECT r.EmpId FROM dak_reply r WHERE r.DakId = c.DakId) AND c.IsActive = 1 UNION SELECT a.EmpId, a.EmpName, b.Designation, c.DakAssignId, a.Srno,'DakAssignedList.htm' AS 'url' FROM employee a JOIN employee_desig b ON a.DesigId = b.DesigId JOIN dak_assign c ON c.EmpId = a.EmpId JOIN dak d ON c.DakId = d.DakId WHERE d.DakId =:dakId AND c.EmpId NOT IN (SELECT r.EmpId FROM dak_assign_reply r WHERE r.DakId = c.DakId) AND c.IsActive = 1 ORDER BY CASE WHEN Srno = 0 THEN 1 ELSE 0 END, Srno ASC";
    private static final String GETREMINDTODETAILSLIST="SELECT(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e,employee_desig d WHERE a.RemindTo=e.EmpId AND e.DesigId=d.DesigId ) AS 'RemindTo',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e,employee_desig d WHERE a.RemindBy=e.EmpId AND e.DesigId=d.DesigId ) AS 'RemindBy',a.DakId,a.comment,a.CreatedDate,a.CommentType FROM dak_remind a  WHERE a.DakId=:dakId AND a.RemindBy=:empId ORDER BY a.CreatedDate";
    private static final String GETPERTICULARREMINDTODETAILSLIST="SELECT (SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e,employee_desig d WHERE a.RemindBy=e.EmpId AND e.DesigId=d.DesigId ) AS 'RemindByName',a.DakId,a.comment,a.CreatedDate,a.RemindBy,(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e,employee_desig d WHERE a.Remindto=e.EmpId AND e.DesigId=d.DesigId ) AS 'RemindtoName',a.CommentType FROM dak_remind a  WHERE a.DakId=:dakId AND a.RemindTo=:empId";
    private static final String UPDATEDAKREMIND="UPDATE dak_remind SET reply=:reply,replydate=:replyDate WHERE DakId=:dakId AND RemindTo=:empId";
    private static final String ENOTEASSIGNREPLYDATA="SELECT a.DakId,a.DakNo,a.RefDate,a.RefNo,d.EmpId,c.Reply,b.DakMarkingId,c.DakAssignReplyId,b.DakAssignId,a.Subject FROM dak a,dak_assign b,dak_assign_reply c,dak_marking d WHERE a.DakId=c.DakId AND b.DakAssignId=c.DakAssignId AND b.DakMarkingId=d.DakMarkingId AND a.DakId=:dakId AND c.EmpId=:EmpId";
    private static final String DAKENOTEREPLYATTACHMENTDATA="SELECT DakId, filepath,DakAssignReplyAttachmentId,filename  FROM dak_assign_reply_attachment WHERE DakId=:dakId ";
    private static final String GETDIVISIONID="SELECT DivisionId FROM employee WHERE EmpId=:empId";
    private static final String INITIATEDBYEMPLOYEELIST="SELECT a.EmpId,a.EmpName,b.Designation,a.EmpNo FROM employee a,employee_desig b WHERE a.labcode=:lab AND a.IsActive=1 AND a.DesigId=b.DesigId AND a.DivisionId=:divisionId ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC ";
    private static final String ENOTEMARKERREPLYDATA="SELECT a.DakId,a.DakNo,a.RefDate,a.RefNo,c.EmpId,c.Remarks,a.ActionId,c.DakReplyId,a.DakStatus,a.Subject FROM dak a,dak_reply c WHERE a.DakId=c.DakId AND a.DakId=:dakId AND c.EmpId=:empId";
    private static final String DAKMARKERENOTEREPLYATTACHMENTDATA="SELECT ReplyId, filepath,ReplyAttachmentId,filename  FROM dak_reply_attachment WHERE ReplyId=:dakReplyId";
    private static final String MAILSENTDETAILS="SELECT a.UserName,a.Password FROM mail_configuration a WHERE a.TypeOfHost=:TypeOfHost";
    private static final String DRONAMAILRECEIVEDDETAILS="SELECT EmpId,EmpName,DronaEMail FROM employee WHERE IsActive=1 AND DronaEmail IS NOT NULL AND EmpId!=:empId";
    private static final String LABMAILRECEIVEDDETAILS="SELECT EmpId,EmpName,EMail FROM employee WHERE IsActive=1 AND Email IS NOT NULL AND EmpId!=:empId";
    private static final String GETEMPNAME="SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE e.EmpId=:empId AND  e.DesigId=d.DesigId";
    private static final String GETDRONAMAILDETAILS="SELECT a.Host,a.Port,a.Username,a.Password FROM mail_configuration a WHERE a.TypeOfHost=:typeOfHost";
    private static final String ATTACHMENTSFILEPATH="SELECT FilePath,FileName FROM dak_reply_attachment WHERE ReplyId=:dakReplyAddResult";
    
    
    
    @PersistenceContext
	EntityManager manager;

	@Autowired
	DakRepo dakRepo;
	
	@Autowired
	DakAssignRepo dakAssignRepo;

	@Override
	public List<Object[]> SourceList() throws Exception {
		logger.info(new Date() + "Inside DAO SourceList");
		try {
			Query query = manager.createNativeQuery(SOURCELIST);
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>) query.getResultList();
			return resultList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl SourceList", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> DakDeliveryList() throws Exception {
		logger.info(new Date() + "Inside DAO DakDeliveryList");
		try {
			Query query = manager.createNativeQuery(DAKDELIVERYLIST);
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>) query.getResultList();
			return resultList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakDeliveryList", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> getLetterTypeList() throws Exception {
		logger.info(new Date() + "Inside DAO getLetterTypeList");
		try {
			Query query = manager.createNativeQuery(LETTERTYPELIST);
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>) query.getResultList();
			return resultList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getLetterTypeList", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> getPriorityList() throws Exception {
		logger.info(new Date() + "Inside DAO getPriorityList");
		try {
			Query query = manager.createNativeQuery(PRIORITYLIST);
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>) query.getResultList();
			return resultList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getPriorityList", e);
			return null;
		}
		
	}


	@Override
	public List<Object[]> getRelaventList(String lab) throws Exception {
		logger.info(new Date() + "Inside DAO getRelaventList");
		try {
			Query query = manager.createNativeQuery(RELEVANTLIST);
			query.setParameter("lab", lab);
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>) query.getResultList();
			return resultList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getRelaventList", e);
			return null;
		}
		
	}

	@Override
	public long insertDak(DakMain dak) throws Exception {
		logger.info(new Date() + "Inside DAO insertDak");
		try {
			manager.persist(dak);
			manager.flush();
			return dak.getDakId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl insertDak", e);
			return 0;
		}
		
	}

	@Override
	public List<Object[]> DakPendingDistributionList(String DivisionCode,String LabCode,String UserName) throws Exception {
		logger.info(new Date() + "Inside DAO DakPendingDistributionList");
		try {
			 Query query = manager.createNativeQuery(DAKPENDINGDISTRIBUTIONLIST);
			 query.setParameter("DivisionCode", DivisionCode);
			 query.setParameter("LabCode", LabCode);
			 query.setParameter("UserName", UserName);
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>) query.getResultList();
			return resultList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPendingDistributionList", e);
			return null;
		}
		
	}

	@Override
	public long DakAttachmentFile(DakAttachment model) throws Exception {
		logger.info(new Date() + "Inside DAO DakAttachmentFile");
		try {
			manager.persist(model);
			manager.flush();
			return model.getDakAttachmentId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakAttachmentFile", e);
			return 0;
		}
		
	}

	@Override
	public DakMain dakData(long dakId) throws Exception {
		logger.info(new Date() + " Inside dakData ");
		try {
			Query query = manager.createQuery(DAKDATA);
			query.setParameter("dakId", dakId);
			DakMain dakData = (DakMain) query.getSingleResult();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl dakData", e);
			return null;
		}
		
	}

	@Override
	public long saveDak(DakMain dak) throws Exception {
		logger.info(new Date() + "Inside DAO saveDak");
		try {
			dakRepo.save(dak);
			return dak.getDakId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl saveDak", e);
			return 0;
		}
		
	}


	
	@Override
	public List<Object[]> GetAttachmentDetails(long dakid, String type) throws Exception {
		logger.info(new Date() + "Inside GetAttachmentDetails");
		try {
			Query query = manager.createNativeQuery(DAKATTACHMENTDATA);
			query.setParameter("dakid", dakid);
			query.setParameter("type", type);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetAttachmentDetails", e);
			return null;
		}
		

	}

	@Override
	public Object[] DakAttachmentData(String dakattachmentid) throws Exception {
		logger.info(new Date() + "Inside DakAttachmentData");
		try {
			Query query = manager.createNativeQuery(DAKATTACHMENTDETAILS);
			query.setParameter("dakattachmentid", dakattachmentid);
			Object[] dakData = (Object[]) query.getSingleResult();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakAttachmentData", e);
			return null;
		}
		

	}

	@Override
	public int DeleteAttachment(String dakattachmentid) throws Exception {
		logger.info(new Date() + "Inside DeleteAttachment");
		try {
			Query query = manager.createNativeQuery(DELETEATTACHMENT);
			query.setParameter("dakattachmentid", dakattachmentid);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DeleteAttachment", e);
			return 0;
		}
		

	}

	@Override
	public List<Object[]> getDakMembers() throws Exception {

		logger.info(new Date() + "Inside getDakMembers");
		try {
			Query query = manager.createNativeQuery(DAKMEMBERS);
			List<Object[]> FeedbackList = (List<Object[]>) query.getResultList();
			return FeedbackList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakMembers", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> EmployeeList() throws Exception {
		logger.info(new Date() + "Inside EmployeeList");
		try {
			Query query = manager.createNativeQuery(EMPLOYEELIST);
			List<Object[]> EmployeeList = (List<Object[]>) query.getResultList();
			return EmployeeList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl EmployeeList", e);
			return null;
		}
		
	}

	@Override
	public long insertMarkedDak(DakMarked dakMark) throws Exception {
		logger.info(new Date() + "Inside DAO insertMarkedDak");
		try {
			manager.persist(dakMark);
			manager.flush();
			return dakMark.getDakDistributionId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl insertMarkedDak", e);
			return 0;
		}
		
	}

	@Override
	public List<Object[]> DakClosedList(String fromDate,String toDate,String StatusValue,String LoginType,String Username,long EmpId, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String employeeId,String DivisionCode,String LabCode) throws Exception {
		logger.info(new Date() + "Inside DakClosedList");
		try {
			Query query = manager.createNativeQuery(DAKCLOSEDLIST);
			query.setParameter("frmDt", fromDate);
			query.setParameter("toDt", toDate);
			query.setParameter("statusvalue", StatusValue);
			query.setParameter("logintype", LoginType);
			query.setParameter("username", Username);
			query.setParameter("empid", EmpId);
			query.setParameter("lettertypeid", lettertypeid);
			query.setParameter("priorityid", priorityid);
			query.setParameter("sourcedetailid", sourcedetailid);
			query.setParameter("sourceId", sourceId);
			query.setParameter("projectType", projectType);
			query.setParameter("projectId", projectId);
			query.setParameter("dakMemberTypeId", dakMemberTypeId);
			query.setParameter("employeeId", employeeId);
			query.setParameter("DivisionCode", DivisionCode);
			query.setParameter("LabCode", LabCode);
			System.out.println("CALL DakClosedList("+fromDate+","+toDate+","+StatusValue+","+EmpId+","+Username+","+LoginType+","+EmpId+","+DivisionCode+","+LabCode+");");
			
			List<Object[]> dakClosedList = (List<Object[]>) query.getResultList();
			return dakClosedList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakClosedList", e);
			return null;
		}
		
	}

	@Override
	public long getDakAcknowledged(DakAcknowledged acknow) throws Exception {
		logger.info(new Date() + "Inside DAO getDakAcknowledged");
		try {
			manager.persist(acknow);
			manager.flush();
			return acknow.getAcknowledgedId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakAcknowledged", e);
			return 0;
		}
		
	}

	@Override
	public Long NotificationInsert(Notification notif) throws Exception {
		logger.info(new Date() + "Inside DAO NotificationInsert");
		try {
			manager.persist(notif);
			manager.flush();
			return notif.getNotificationId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl NotificationInsert", e);
			return (long) 0;
		}
		
	}

	@Override
	public List<Object[]> DakAckNotifyList(long empId, String dakId) throws Exception {
		logger.info(new Date() + "Inside DakAckNotifyList");
		try {
			Query query = manager.createNativeQuery(ACKNOWEDGED);
			query.setParameter("empId", empId);
			query.setParameter("dakId", dakId);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakAckNotifyList", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> DakMarkedList(String dakId) throws Exception {
		logger.info(new Date() + "Inside DakMarkedList");
		try {
			Query query = manager.createNativeQuery(MARKEDLIST);
			query.setParameter("dakId", dakId);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakMarkedList", e);
			return null;
		}
		
	}

	@Override
	public long getDakForwarded(String DakId, long Empid, String userName, String status) throws Exception {
		logger.info(new Date() + "Inside getDakForwarded");
		try {
			Query query = manager.createNativeQuery(DAKFORWARDED);
			query.setParameter("dakId", DakId);
			query.setParameter("userName", userName);
			query.setParameter("status", status);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakForwarded", e);
			return 0;
		}
		
	}

	@Override
	public long DakCount(String fromDate, String endDate) throws Exception {
		logger.info(new Date() + "Inside DakCount");
		try {
			Query query = manager.createNativeQuery(DAKCOUNT);
			query.setParameter("startDate", fromDate);
			query.setParameter("endDate", endDate);
			BigInteger dakData = (BigInteger) query.getSingleResult();
			return dakData.longValue();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakCount", e);
			return 0;
		}
		
	}
	
	@Override
	public long DakCountFrDakNoCreation() throws Exception {
		logger.info(new Date() + "Inside DakIdCountFrDakNoCreation");
		try {
			Query query = manager.createNativeQuery(DAKCOUNTFORDAKNOGENERATION);
			BigInteger dakData = (BigInteger) query.getSingleResult();
			return dakData.longValue();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakCountFrDakNoCreation", e);
			return 0;
		}
	}

	@Override
	public List<Object[]> DakMarkNotifyList(long empId, String dakId) throws Exception {
		logger.info(new Date() + "Inside DakMarkNotifyList");
		try {
			Query query = manager.createNativeQuery(MARKNOTIFY);
			query.setParameter("empId", empId);
			query.setParameter("dakId", dakId);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakMarkNotifyList", e);
			return null;
		}
		
	}

	@Override
	public long getDakTransInsert(DakTransaction trans) throws Exception {
		logger.info(new Date() + "Inside getDakTransInsert");
		try {
			manager.persist(trans);
			manager.flush();
			return trans.getDakTransactionId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakTransInsert", e);
			return 0;
		}
	}

	@Override
	public List<Object[]> DakLinkList() throws Exception {
		logger.info(new Date() + "Inside DakLinkList");
		try {
			Query query = manager.createNativeQuery(DAKLINKLIST);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakLinkList", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> NonProjectList() throws Exception {
		logger.info(new Date() + "Inside NonProjectList");
		try {
			Query query = manager.createNativeQuery(NONPROJECTLIST);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl NonProjectList", e);
			return null;
		}
		
	}

	@Override
	public long getDakProInsert(DakProData pro) throws Exception {
		logger.info(new Date() + "Inside getDakProInsert");
		try {
			manager.persist(pro);
			manager.flush();
			return pro.getDakProjectId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakProInsert", e);
			return 0;
		}
		
	}

	@Override
	public List<DakMemberType> getAllMemberType() throws Exception {
		logger.info(new Date() + " Inside getAllMemberType ");
		try {
			Query query = manager.createQuery("from DakMemberType");
			List<DakMemberType> dakData = (List<DakMemberType>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getAllMemberType", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> getAllMemberList(int i, String member, String lab) throws Exception {
		logger.info(new Date() + " Inside getAllMemberList ");
		try {
			Query query = manager.createNativeQuery(
					"SELECT e.EmpId,e.empName,d.Designation,e.SrNo FROM employee e,employee_desig d WHERE e.EmpId NOT IN(SELECT a.EmpId FROM dak_members a,employee b WHERE  a.DakmemberTypeId=:DakMemberTypeId AND a.EmpId=b.EmpId AND a.IsActive=1) AND e.DesigId=d.DesigId AND e.LabCode=:lab AND e.isactive='1' ORDER BY e.SrNo");
			query.setParameter("DakMemberTypeId", i);
			query.setParameter("lab", lab);
			return (List<Object[]>) query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getAllMemberList", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> getAllMemberList2(int i) throws Exception {
		logger.info(new Date() + " Inside getAllMemberList2 ");
		try {
			Query query = manager.createNativeQuery(
					"SELECT e.EmpId,e.empName,d.Designation,c.dakmembertype,m.DakMembersId FROM employee e,employee_desig d ,dak_members m,dak_member_type c WHERE m.dakmembertypeid=c.dakmembertypeid and e.EmpId=m.EmpId AND e.DesigId=d.DesigId AND m.DakmemberTypeId=:DakMemberType AND m.IsActive=1");
			query.setParameter("DakMemberType", i);
			return (List<Object[]>) query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getAllMemberList2", e);
			return null;
		}
		
	}

	@Override
	public long addDakMember(DakMember member1) throws Exception {
		logger.info(new Date() + "Inside addDakMember");
		try {
			manager.persist(member1);
			manager.flush();
			return member1.getDakMembersId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl addDakMember", e);
			return 0;
		}
		
	}

	@Override
	public List<Object[]> getActionList() throws Exception {
		logger.info(new Date() + "Inside getActionList");
		try {
			Query query = manager.createNativeQuery(ACTIONLIST);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getActionList", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> getCwList() throws Exception {
		logger.info(new Date() + "Inside getCwList");
		try {
			Query query = manager.createNativeQuery(CWLIST);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getCwList", e);
			return null;
		}
		
	}

	@Override
	public long getDakAssignInsert(DakAssign cw) throws Exception {
		logger.info(new Date() + "Inside getDakAssignInsert");
		try {
			manager.persist(cw);
			manager.flush();
			return cw.getDakAssignId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakAssignInsert", e);
			return 0;
		}
		
	}
	
	@Override
	public List<Object[]> getIndiMarkedEmpIdsFrmDakId(long DakId) throws Exception{
		logger.info(new Date() + "Inside getIndiMarkedEmpIdsFrmDakId");
		try {
			Query query = manager.createNativeQuery(INDMARKEDEMPLIST);
			query.setParameter("dakid", DakId);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			
			return dakData;
		} catch (Exception e) {
			return null;
		}
	}
	
	
	@Override
	public List<Object[]> getDivisionList() throws Exception {
		logger.info(new Date() + "Inside getDivisionList");
		try {
			Query query = manager.createNativeQuery(DIVLIST);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDivisionList", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> getSelectEmpList(String[] empid, String lab) throws Exception {
		logger.info(new Date() + "Inside getSelectEmpList");
		try {
		String ind = "0";
		String SerialNo = "SELECT a.empid, a.empname, b.designation, '0' AS dakmembertypeid, a.SrNo FROM employee a, employee_desig b "
				+ "WHERE a.desigid = b.desigid AND a.labcode='" + lab + "' AND a.IsActive = '1'  "
				+ "AND a.empid NOT IN (SELECT a.empid FROM employee a, employee_desig b, dak_members c "
				+ "WHERE a.desigid = b.desigid AND a.IsActive = '1' AND c.IsActive = '1' AND a.empid = c.empid AND c.dakmembertypeid IN (";

		for (int i = 0; i < empid.length; i++) {
			if (i > 0) {
				SerialNo += ",'" + empid[i] + "'";
			} else {
				SerialNo += "'" + empid[i] + "'";
			}
			if (empid[i].equals("0")) {
				ind = "1";
			}
		}

		SerialNo += ")) AND 1 = " + ind + " " + "UNION "
				+ "SELECT a.empid, a.empname, b.designation, c.dakmembertypeid,a.SrNo FROM employee a,employee_desig b, "
				+ "(SELECT DISTINCT empid, dakmembertypeid,IsActive  FROM dak_members WHERE dakmembertypeid IN (";

		for (int i = 0; i < empid.length; i++) {
			if (i > 0) {
				SerialNo += ",'" + empid[i] + "'";
			} else {
				SerialNo += "'" + empid[i] + "'";
			}
			if (empid[i].equals("0")) {
				ind = "1";
			}
		}

		SerialNo += ")) c   WHERE a.empid = c.empid AND a.desigid = b.desigid AND a.labcode='" + lab
				+ "' AND a.IsActive='1' AND c.IsActive='1' GROUP BY a.empid ORDER BY SrNo";
		Query query = manager.createNativeQuery(SerialNo);
		List<Object[]> dakData = (List<Object[]>) query.getResultList();
		return dakData;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getSelectEmpList", e);
			return null;
		}
	}

	@Override
	public int getDeletedMarked(String dakid) throws Exception {
		logger.info(new Date() + "Inside getDeletedMarked");
		try {
			Query query = manager.createNativeQuery(DELETEMARKED);
			query.setParameter("dakId", dakid);
			int result = query.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDeletedMarked", e);
			return 0;
		}
		
	}

	@Override
	public int getDeletedPro(long dakid) throws Exception {
		logger.info(new Date() + "Inside getDeletedPro");
		try {
			Query query = manager.createNativeQuery(DELETEPRO);
			query.setParameter("dakId", dakid);
			int result = query.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDeletedPro", e);
			return 0;
		}
		
	}

	@Override
	public int getDeletedAssign(long dakid) throws Exception {
		logger.info(new Date() + "Inside getDeletedAssign");
		try {
			Query query = manager.createNativeQuery(DELETEASSIGN);
			query.setParameter("dakId", dakid);
			int result = query.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDeletedAssign", e);
			return 0;
		}
		
	}

	@Override
	public List<Object[]> getSelectDakEditList(String dakid) throws Exception {
		logger.info(new Date() + "Inside getSelectDakEditList");
		try {
			Query query = manager.createNativeQuery(EDITDAK);
			query.setParameter("dakid", dakid);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getSelectDakEditList", e);
			return null;
		}
		
	}

	@Override
	public long getDakReplyInsert(DakReply model) throws Exception {
		logger.info(new Date() + "Inside DAO getDakReplyInsert");
		try {
			manager.persist(model);
			manager.flush();
			return model.getDakReplyId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakReplyInsert", e);
			return 0;
		}
		
	}



	@Override
	public List<Object[]> getReplyAttachDetails(long dakid, long empId, String type) throws Exception {
		logger.info(new Date() + "Inside getReplyAttachDetails");
		try {
			Query query = manager.createNativeQuery(DAKREPLYATTACHDATA);
			query.setParameter("dakid", dakid);
			query.setParameter("empid", empId);
			query.setParameter("type", type);
			List<Object[]> dakData = (List<Object[]>) query.getResultList();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getReplyAttachDetails", e);
			return null;
	}
	}

	@Override
	public Object[] DakReplyAttachmentData(String replyattachmentid) throws Exception {
		logger.info(new Date() + "Inside DakReplyAttachmentData");
		try {
			Query query = manager.createNativeQuery(REPLYATTACHMENTDETAILS);
			query.setParameter("replyattachmentid", replyattachmentid);
			Object[] dakData = (Object[]) query.getSingleResult();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakReplyAttachmentData", e);
			return null;
		}
		

	}

	@Override
	public int DeleteReplyAttachment(String DakReplyAttachmentId) throws Exception {
		logger.info(new Date() + "Inside DeleteReplyAttachment");
		try {
			Query query = manager.createNativeQuery(DELETEREPLYATTACHMENT);
			query.setParameter("replyattachmentid", DakReplyAttachmentId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DeleteReplyAttachment", e);
			return 0;
		}
	}

	@Override
	public int UpdateReply(DakAttachmentDto dakdto) throws Exception {
		logger.info(new Date() + "Inside UpdateReply");
		try {
			Query query = manager.createNativeQuery(UPDATEREPLY);
			query.setParameter("replyid", dakdto.getReplyid());
			query.setParameter("userName", dakdto.getCreatedBy());
			query.setParameter("remarks", dakdto.getRemarks());
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl UpdateReply", e);
			return 0;
		}
		

	}

	@Override
	public Object[] ReplyAttachmentData(String ReplyId, String type) throws Exception {
		logger.info(new Date() + "Inside ReplyAttachmentData");
		try {
			Query query = manager.createNativeQuery(REPLYATTACHMENT);
			query.setParameter("replyid", ReplyId);
			query.setParameter("type", type);
			Object[] dakData = (Object[]) query.getSingleResult();
			return dakData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl ReplyAttachmentData", e);
			return null;
		}
	}



	@Override
	public long insertDakAttach(DakMailAttach attach) throws Exception {
		logger.info(new Date() + "Inside DAO insertDakAttach");
		try {
			manager.persist(attach);
			manager.flush();
			return attach.getDakMailAttachId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl insertDakAttach", e);
			return 0;
		}
		
	}

	@Override
	public long insertDakSentAttach(DakMailSentAttach attach) throws Exception {
		logger.info(new Date() + "Inside DAO insertDakSentAttach");
		try {
			manager.persist(attach);
			manager.flush();
			return attach.getDakMailSentAttachId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl insertDakSentAttach", e);
			return 0;
		}
		
	}

	@Override
	public long getDakMarkingInsert(DakMarking marking) throws Exception {
		logger.info(new Date() + "Inside DAO getDakMarkingInsert");
		try {
			manager.persist(marking);
			manager.flush();
			return marking.getDakMarkingId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakMarkingInsert", e);
			return 0;
		}
		
	}
	
	@Override
	public long GetCountPrjDirEmpIdInPrev(long PrjDirEmpId,long DakId)throws Exception{
		logger.info(new Date() + "Inside DAO GetCountPrjDirEmpIdInPrev");
		try {
			Query query = manager.createNativeQuery(EMPIDCOUNTOFCOMPARISON);
			query.setParameter("prjDirEmpId", PrjDirEmpId);
			query.setParameter("dakid", DakId);
			BigInteger result = (BigInteger) query.getSingleResult();
		    return result.longValue();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetCountPrjDirEmpIdInPrev", e);
			return 0;
		}
		
    }
	
	@Override
	public long DeletePrevPrjDirEmpId(long PrjDirEmpId,long DakId)throws Exception{
		logger.info(new Date() + "Inside DAO DeletePrevPrjDirEmpId");
		try {
			Query query = manager.createNativeQuery(DELETEPREVPRJDIREMPID);
			query.setParameter("prjdirempid", PrjDirEmpId);
			query.setParameter("dakid", DakId);
			return query.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DeletePrevPrjDirEmpId", e);
			return 0;
		}
	}
	
	@Override
    public long DeleteSelMarkedEmployee(long DakId, long EmpId,long DakMemberTypeId,long DakMarkingId)throws Exception{
		logger.info(new Date() + "Inside DAO DeleteSelMarkedEmployee");
		try {
	
			Query query = manager.createNativeQuery(DELETEMARKEDEMPLOYEE);
			query.setParameter("dakid", DakId);
			query.setParameter("empid", EmpId);
			query.setParameter("dakmembertypeid", DakMemberTypeId);
			query.setParameter("dakmarkingid", DakMarkingId);
			return query.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DeleteSelMarkedEmployee", e);
			return 0;
		}
		
    }

	@Override
	public List<Object[]> dakReceivedList(String fromDate ,String toDate,String statusValue,long EmpId,String Username) throws Exception {
		logger.info(new Date() + "Inside dakReceivedList");
		try {
			Query query = manager.createNativeQuery(DAKRECEIVEDLIST);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			query.setParameter("empId", EmpId);
			query.setParameter("statusvalue", statusValue);
			query.setParameter("username", Username);
			
			List<Object[]> dakReceivedList = (List<Object[]>) query.getResultList();
			return dakReceivedList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl dakReceivedList", e);
			return null;
		}

	}

	@Override
	public List<Object[]> dakPendingReplyList(String fromDate ,String toDate,String StatusValue,long EmpId,String Username, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String employeeId) throws Exception {
		logger.info(new Date() + "Inside dakPendingReplyList");
		try {
			Query query = manager.createNativeQuery(DAKPENDINGREPLYLIST);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			query.setParameter("statusvalue", StatusValue);
			query.setParameter("empId", EmpId);
			query.setParameter("username", Username);
			query.setParameter("lettertypeid", lettertypeid);
			query.setParameter("priorityid", priorityid);
			query.setParameter("sourcedetailid", sourcedetailid);
			query.setParameter("sourceId", sourceId);
			query.setParameter("projectType", projectType);
			query.setParameter("projectId", projectId);
			query.setParameter("dakMemberTypeId", dakMemberTypeId);
			query.setParameter("employeeId", employeeId);
			System.out.println("CALL Dms_DakPendingReplyList("+fromDate+","+toDate+","+StatusValue+","+EmpId+","+Username+","+lettertypeid+","+priorityid+","+sourcedetailid+","+sourceId+","+projectType+","+projectId+","+dakMemberTypeId+","+employeeId+");");
			
			List<Object[]> dakPendingReplyList = (List<Object[]>) query.getResultList();
			return dakPendingReplyList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl dakPendingReplyList", e);
			return null;
		}

	}

	@Override
	public Object[] dakReceivedView(long empId, long dakId) throws Exception {
		logger.info(new Date() + "Inside dakReceivedView");
		try {
			Query query = manager.createNativeQuery(DAKRECEIVEDVIEWLIST);
			query.setParameter("dakId", dakId);
			Object[] dakReceivedView = (Object[]) query.getSingleResult();
			return dakReceivedView;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl dakReceivedView", e);
			return null;
		}
		
	}
	@Override
    public List<Object[]> GetDistributedDakMembers(long dakId) throws Exception{
    	logger.info(new Date() + "Inside GetDistributedDakMembers");
		try {
			Query query = manager.createNativeQuery(DISTRIBUTEDDAKMEMBERS);
			query.setParameter("dakid", dakId);
			List <Object[]> DistributedDakMembers =  (List<Object[]>) query.getResultList();
			return DistributedDakMembers;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetDistributedDakMembers", e);
			return null;
		}
    }
	
	@Override
	public int getDeletedMarking(Long dakId) throws Exception {
		logger.info(new Date() + "Inside getDeletedMarking");
		try {
			Query query = manager.createNativeQuery(DELETEMARKING);
			query.setParameter("dakId", dakId);
			int result = query.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDeletedMarking", e);
			return 0;
		}
		
	}

	@Override
	public int getDeletedAttachment(Long DakAttachmentId) throws Exception {
		logger.info(new Date() + "Inside getDeletedAttachment");
		try {
			Query query = manager.createNativeQuery(DELETEATTACHMENT);
			query.setParameter("dakattachmentid", DakAttachmentId);
			int result = query.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDeletedAttachment", e);
			return 0;
		}
		
	}

	@Override
	public int getSubDeletedAttachment(Long DakId, String Type) throws Exception {
		logger.info(new Date() + "Inside getSubDeletedAttachment");
		try {
			Query query = manager.createNativeQuery(DELETESUBATTACHMENT);
			query.setParameter("DakId", DakId);
			query.setParameter("Type", Type);
			int result = query.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getSubDeletedAttachment", e);
			return 0;
		}
		
	}

	@Override
	public DakMain getDakIdDetails(Long dakId) throws Exception {
		logger.info(new Date() + "Inside getDakIdDetails");
		try {
			DakMain dakdata = manager.find(DakMain.class, dakId);
			return dakdata;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakIdDetails", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> getDistributedEmps(String dakId) throws Exception {
		logger.info(new Date() + "Inside getDistributedEmps");
		try {
			Query query = manager.createNativeQuery(DAKDISTRIBUTEDATA);
			query.setParameter("dakId", dakId);
			List<Object[]> getDistributedEmps = (List<Object[]>) query.getResultList();
			return getDistributedEmps;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDistributedEmps", e);
			return null;
		}
		
	}
	//It can return multiple rows
	@Override
	public List<Object[]> getDistributedAssignedEmps(String dakId) throws Exception {
		logger.info(new Date() + "Inside getDistributedAssignedEmps");
		try {
			Query query = manager.createNativeQuery(DAKDISTRIBUTEASSIGNDATA);
			query.setParameter("dakId", dakId);
			List<Object[]> getDistributedEmps = (List<Object[]>) query.getResultList();
			return getDistributedEmps;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDistributedAssignedEmps", e);
			return null;
		}
		
	}
	
	@Override
	public List<Object[]> getFacilitatorsList(long MarkedEmpId,long dakId) throws Exception{
		logger.info(new Date() + "Inside getFacilitatorsList");
		try {
			Query query = manager.createNativeQuery(FACILITATORSLIST);
			query.setParameter("markerEmpId", MarkedEmpId);
			query.setParameter("dakId", dakId);
			List<Object[]> getFacilitatorsList = (List<Object[]>) query.getResultList();
			return getFacilitatorsList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getFacilitatorsList", e);
			return null;
		}
	}

	
	private static final String GETPRIORITYOFDAK = "SELECT p.PriorityName FROM dak_priority p, dak a WHERE p.PriorityId = a.PriorityId AND a.DakId=:dakid";

	@Override
	public String getPriorityOfParticularDak(long dakId) throws Exception {
		logger.info(new Date() + "Inside getPriorityOfParticularDak");
		try {
			Query query = manager.createNativeQuery(GETPRIORITYOFDAK);
			query.setParameter("dakid", dakId);
			String priorityName = (String) query.getSingleResult();
		    return priorityName;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getPriorityOfParticularDak", e);
			return null;
		}
	}

	@Override
	public long DakDistribute(String dakId, String date) throws Exception {
		logger.info(new Date() + "Inside DakDistribute");
		try {
			Query query = manager.createNativeQuery(DAKDISTRIBUTE);
			query.setParameter("dakId", dakId);
			query.setParameter("date", date);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakDistribute", e);
			return 0;
		}
		
	}

	@Override
	public List<Object[]> getSelectSourceTypeList(String sourceId) throws Exception {
		logger.info(new Date() + "Inside getSelectSourceTypeList");
		try {
			Query query = manager.createNativeQuery(GETSOURCEDETAILS);
			query.setParameter("sourceId", sourceId);
			List<Object[]> getSelectSourceTypeList = (List<Object[]>) query.getResultList();
			return getSelectSourceTypeList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getSelectSourceTypeList", e);
			return null;
		}
		
	}

	@Override
	public long getDakLinkDetails(DakLink link) throws Exception {
		logger.info(new Date() + "Inside getDakLinkDetails");
		try {
			manager.persist(link);
			manager.flush();
			return link.getDakLinkId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakLinkDetails", e);
			return 0;
		}
		
	}

	@Override
	public List<Object[]> dakLinkData(long dakId) throws Exception {
		logger.info(new Date() + "Inside dakLinkData");
		try {
			Query query = manager.createNativeQuery(DAKLINKDATA);
			query.setParameter("dakId", dakId);
			List<Object[]> dakLinkData = (List<Object[]>) query.getResultList();
			return dakLinkData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl dakLinkData", e);
			return null;
		}
		
	}

	@Override
	public int DeletedDakLink(Long dakId) throws Exception {
		logger.info(new Date() + "Inside DeletedDakLink");
		try {
			Query query = manager.createNativeQuery(DELETEDAKLINK);
			query.setParameter("dakId", dakId);
			int result = query.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DeletedDakLink", e);
			return 0;
		}
		
	}

	@Override
	public long DakAck(long empId, long dakIdSel,String AckDate) throws Exception {
		logger.info(new Date() + "Inside DakAck");
		try {
			Query query = manager.createNativeQuery(DAKACK);
			query.setParameter("empId", empId);
			query.setParameter("dakIdSel", dakIdSel);
			query.setParameter("AckDate", AckDate);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakAck", e);
			return 0;
		}
		
	}

	@Override
	public int RevokeMember(String dakMembersId, String UserName) throws Exception {
		logger.info(new Date() + "Inside RevokeMember");
		try {
			Query query = manager.createNativeQuery(REVOKEMEMBER);
			query.setParameter("dakMembersId", dakMembersId);
			query.setParameter("UserName", UserName);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl RevokeMember", e);
			return 0;
		}
		
	}
	
	@Override
	public List<Object[]> DakDistributedList(long EmpId, String fromdate, String todate) throws Exception {
		logger.info(new Date() + "Inside DakDistributedList");
		try {
			Query query = manager.createNativeQuery(DAKDISTRIBUTEDLIST);
			query.setParameter("fromdate", fromdate);
			query.setParameter("todate", todate);
			query.setParameter("EmpId", EmpId);
			List<Object[]> DakDistributedList = (List<Object[]>) query.getResultList();
			return DakDistributedList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakDistributedList", e);
			return null;
		}
		
	}

	@Override
	public long UpdateDakStatus(long dakIdSel) throws Exception {
		logger.info(new Date() + "Inside UpdateDakStatus");
		try {
			Query query = manager.createNativeQuery(UPDATEDAKSTATUS);
			query.setParameter("dakIdSel", dakIdSel);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl UpdateDakStatus", e);
			return 0;
		}
		
	}

	@Override
	public List<Object[]> OtherProjectList() throws Exception {
		logger.info(new Date() + "Inside OtherProjectList");
		try {
			Query query = manager.createNativeQuery(OTHERPROJECTLIST);
			List<Object[]> OtherProjectList = (List<Object[]>) query.getResultList();
			return OtherProjectList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl OtherProjectList", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> getassignemplist(String projectid, String lab, long EmpId) throws Exception {
		logger.info(new Date() + "Inside getassignemplist");
		try {
			Query query = manager.createNativeQuery(GETASSIGNEMPLIST);
			query.setParameter("projectid", projectid);
			query.setParameter("lab", lab);
			query.setParameter("EmpId", EmpId);
			List<Object[]> getassignemplist = (List<Object[]>) query.getResultList();
			return getassignemplist;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getassignemplist", e);
			return null;
		}
		
	}
	
	@Override
	public List<Object[]> getseekResponseEmplist(String lab ,long EmpId,long divid) throws Exception{
		logger.info(new Date() + "Inside getseekResponseEmplist");
		try {
			
			Query query = manager.createNativeQuery(GETSEEKRESPONSEEMPLIST);
			query.setParameter("lab", lab);
			query.setParameter("empid", EmpId);
			//query.setParameter("divid", divid);
			List<Object[]> seekResponseEmplist = (List<Object[]>) query.getResultList();
			return seekResponseEmplist;
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getseekResponseEmplist", e);
			return null;
		}
	}

	@Override
	public Object getlabcode(long empId) throws Exception {
		logger.info(new Date() + "Inside getlabcode");
		try {
			Query query = manager.createNativeQuery(GETLABCODE);
			query.setParameter("empId", empId);
			Object labcode = query.getSingleResult();
			return labcode;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getlabcode", e);
			return null;
		}
		
	}

	@Override
	public Object[] getUsername(long empId) throws Exception {
		logger.info(new Date() + "Inside getUsername");
		try {
			Query query = manager.createNativeQuery(GETUSERNAME);
			query.setParameter("empId", empId);
			Object[] UserName = (Object[]) query.getSingleResult();
			return UserName;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getUsername", e);
			return null;
		}
		
	}

	@Override
	public long DakAssignInsert(DakAssign assign) throws Exception {
		logger.info(new Date() + "Inside DAO DakAssignInsert");
		try {
			manager.persist(assign);
			manager.flush();
			return assign.getDakAssignId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakAssignInsert", e);
			return 0;
		}
		
	}

	@Override
	public long DakReplyInsert(DakReply replyModal) throws Exception {
		logger.info(new Date() + "Inside DAO DakReplyInsert");
		try {
			manager.persist(replyModal);
			manager.flush();
			return replyModal.getDakReplyId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakReplyInsert", e);
			return 0;
		}
		
	}
	
	@Override
	public DakMain GetDakDetails(long dakId) throws Exception {
		logger.info(new Date() + "Inside DaoImpl GetDakDetails()");
		try {
			return manager.find(DakMain.class, dakId);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetDakDetails", e);
			return null;
		}
	}

	@Override
	public List<Object[]> GetPrevReplyAttachmentDetails(long replyid) throws Exception {
		logger.info(new Date() + "Inside GetPrevReplyAttachmentDetails");
		try {
			Query query = manager.createNativeQuery(DAKREPLYATTACHMENTDATA);
			query.setParameter("replyid", replyid);
			List<Object[]> dakReplyCountData = (List<Object[]>) query.getResultList();
			return dakReplyCountData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetPrevReplyAttachmentDetails", e);
			return null;
		}
		
	}

	@Override
	public long DakReplyAttachmentAdd(DakReplyAttach ReplyAttachModel) throws Exception {
		logger.info(new Date() + "Inside DAO DakReplyAttachmentAdd");
		try {
			manager.persist(ReplyAttachModel);
			manager.flush();
			return ReplyAttachModel.getReplyAttachmentId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakReplyAttachmentAdd", e);
			return 0;
		}
		
	}
	
	@Override
	public List<Object[]>  getEmpListForAssigning (long DakId,String lab, long EmpId)throws Exception{
		logger.info(new Date() + "Inside DaoImpl getEmpListForAssigning()");
		try {
			Query query = manager.createNativeQuery(GETEMPLISTFORASSIGNING);
			query.setParameter("dakid", DakId);
			query.setParameter("lab", lab);
			query.setParameter("EmpId", EmpId);
            List<Object[]> EmpListForAssigning  = (List<Object[]>) query.getResultList();
			return EmpListForAssigning ;

			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getEmpListForAssigning", e);
			return null;
		}
	}

	@Override
	public List<Object[]>  GetDakReplyDetails(long dakReplyId) throws Exception {
		logger.info(new Date() + "Inside DaoImpl GetDakReplyDetails()");
		try {
			
			Query query = manager.createNativeQuery(GETREPLYVIEWMOREDETAILS);
			query.setParameter("dakreplyid", dakReplyId);
            List<Object[]> ReplyViewMoreDetails = (List<Object[]>) query.getResultList();
			return ReplyViewMoreDetails;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetDakReplyDetails", e);
			return null;
		}
	}
	
	@Override
	public DakReply GetDakReplyEditDetails(long dakReplyId)throws Exception{
		logger.info(new Date() + "Inside DaoImpl GetDakReplyEditDetails()");
		try {	
			
			return manager.find(DakReply.class, dakReplyId);
			
			
	    } catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetDakReplyEditDetails", e);
		return null;
	}
	}
	
	@Override
	public List<Object[]> ReplyDakAttachmentData (long DakReplyAttachId, long DakReplyId) throws Exception {
		logger.info(new Date() + "Inside ReplyDakAttachmentData");
		try {
			Query query = manager.createNativeQuery(PARTICULARDAKREPLYATTACHDATA);
			query.setParameter("dakReplyAttachId", DakReplyAttachId);
			query.setParameter("dakReplyId", DakReplyId);
			 List<Object[]> ReplyDakAttachmentData = (List<Object[]>) query.getResultList();
				return ReplyDakAttachmentData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl ReplyDakAttachmentData", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> GetReplyModalDetails(long DakId, long EmpId, String Username, String DakAdmin)
			throws Exception {
		logger.info(new Date() + "Inside GetReplyModalDetails");
		try {
			Query query = manager.createNativeQuery(GETREPLYMODALDETAILS);
			query.setParameter("dakid", DakId);
			query.setParameter("empid", EmpId);
			query.setParameter("username", Username);
			query.setParameter("dakadmin", DakAdmin);
			System.out.println("CALL Dms_DakReplyModalList('" + DakId + "', '" + EmpId + "', '" + Username + "', '"
					+ DakAdmin + "')");
			List<Object[]> ReplyModalDetails = (List<Object[]>) query.getResultList();
			return ReplyModalDetails;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetReplyModalDetails", e);
			return null;
		}
	}
	
	@Override
	public List<Object[]> GetReplyAttachmentList(long DakReplyId) throws Exception {
		logger.info(new Date() + "Inside GetReplyAttachmentList");
		try {
			Query query = manager.createNativeQuery(GETREPLYATTACHMODALDETAILS);
			query.setParameter("dakreplyid", DakReplyId);
			List<Object[]> ReplyAttachModalList = (List<Object[]>) query.getResultList();
			return ReplyAttachModalList;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetReplyAttachmentList", e);
			return null;
		}
	}

	@Override
	public Object[] DakReplyAttachData(String ReplyAttachmentId) throws Exception {
		logger.info(new Date() + "Inside DakReplyAttachData");
		try {
			Query query = manager.createNativeQuery(DAKREPLYATTACHMENTDETAILS);
			query.setParameter("replyattachmentid", ReplyAttachmentId);
			Object[] dakData = (Object[]) query.getSingleResult();
			return dakData;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakReplyAttachData", e);
			return null;
		}

	}
	
	@Override
	public long  DeleteReplyAttachment(long DakReplyAttachmentId)  throws Exception {
		logger.info(new Date() + "Inside DeleteReplyAttachment");
		try {
			Query query = manager.createNativeQuery(DELETEREPLYATTACHMENTDATA);
			query.setParameter("dakreplyattachmentid", DakReplyAttachmentId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DeleteReplyAttachment", e);
			return 0;
		}
		

	}
	
	public long DakReplyEditData(DakReply replyModal)throws Exception{
		logger.info(new Date() + "Inside DAO DakReplyEditData");
		try {
			Query query = manager.createNativeQuery(UPDATEDAKREPLY);
			query.setParameter("dakReplyId", replyModal.getDakReplyId());
			query.setParameter("dakId", replyModal.getDakId());
			query.setParameter("reply", replyModal.getRemarks());
			query.setParameter("modifiedBy", replyModal.getModifiedBy());
			query.setParameter("modifiedDate", replyModal.getModifiedDate());
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakReplyEditData", e);
			return 0;
		}
		
	}
	
	@Override
	public List<Object[]> GetCSWReplyModalDetails(long DakId, long EmpId, String Username, String DakAdmin)
			throws Exception {
		logger.info(new Date() + "Inside GetCSWReplyModalDetails");
		try {
			Query query = manager.createNativeQuery(GETCSWREPLYMODALDETAILS);
			query.setParameter("dakid", DakId);
			query.setParameter("empid", EmpId);
			query.setParameter("username", Username);
			query.setParameter("dakadmin", DakAdmin);
			System.out.println("CALL Dms_DakCSWReplyModalList('" + DakId + "', '" + EmpId + "', '" + Username + "', '"
					+ DakAdmin + "')");
			List<Object[]> CSWReplyModalDetails = (List<Object[]>) query.getResultList();
			return CSWReplyModalDetails;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetCSWReplyModalDetails", e);
			return null;
		}
	}
	
	public List<Object[]>  GetSpecificMarkersCSWReplyDetails(long DakId,long DakMarkingId)throws Exception{
		logger.info(new Date() + "Inside GetSpecificMarkersCSWReplyDetails");
		try {
			Query query = manager.createNativeQuery(GETSPECIFICMARKERSCSWREPLYDETAILS);
			query.setParameter("dakid", DakId);
			query.setParameter("dakmarkingid", DakMarkingId);
			List<Object[]> CSWReplyDetails = (List<Object[]>) query.getResultList();
			return CSWReplyDetails;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetSpecificMarkersCSWReplyDetails", e);
			return null;
		}
	}
	
	@Override
	public List<Object[]> GetReplyCSWAttachmentList(long DakAssignReplyId) throws Exception {
		logger.info(new Date() + "Inside GetReplyCSWAttachmentList");
		try {
			Query query = manager.createNativeQuery(GETREPLYCSWATTACHMODALDETAILS);
			query.setParameter("dakassignreplyid", DakAssignReplyId);
			List<Object[]> ReplyCSWAttachModalList = (List<Object[]>) query.getResultList();
			return ReplyCSWAttachModalList;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetReplyCSWAttachmentList", e);
			return null;
		}
	}

	@Override
	public List<Object[]>  GetParticularCSWReplyDetails(long DakAssignReplyId) throws Exception{
		logger.info(new Date() + "Inside GetParticularCSWReplyDetails");
		try {
			Query query = manager.createNativeQuery(PARTICULARCSWREPLYDETAILS);
			query.setParameter("dakassignreplyid", DakAssignReplyId);
			List<Object[]> ParticularCSWReplyDetails = (List<Object[]>) query.getResultList();
			return ParticularCSWReplyDetails;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetParticularCSWReplyDetails", e);
			return null;
		}
	}
	
	
	
	@Override
	public Object[] DakReplyCSWAttachData(String DakAssignReplyAttachmentId) throws Exception {
		logger.info(new Date() + "Inside DakReplyCSWAttachData");
		try {
			Query query = manager.createNativeQuery(DAKREPLYCSWATTACHMENTDETAILS);
			query.setParameter("replycswattachmentid", Long.parseLong(DakAssignReplyAttachmentId));
			Object[] dakData = (Object[]) query.getSingleResult();
			return dakData;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakReplyCSWAttachData", e);
			return null;
		}

	}
	
	@Override
	public List<Object[]>  GetDakMarkersDetailsList (long DakId)  throws Exception {
		logger.info(new Date() + "Inside GetDakMarkersDetailsList");
		try {
			Query query = manager.createNativeQuery(DAKMARKERSDETAILSLIST);
			query.setParameter("dakid", DakId);
			List<Object[]> DakMarkersDetailsList = (List<Object[]>) query.getResultList();
			return DakMarkersDetailsList;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetDakMarkersDetailsList", e);
			return null;
		}
	}
	
	
	@Override
	public List<Object[]> DakDetailedList(String fromdate, String todate,String StatusValue, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String empId,String DivisionCode,String LabCode,String UserName) throws Exception {
		logger.info(new Date() + "Inside DakDetailedList");
		try {
			Query query = manager.createNativeQuery(DAKDETAILEDLIST);
			query.setParameter("fromDate", fromdate);
			query.setParameter("toDate", todate);
			query.setParameter("statusvalue", StatusValue);
			query.setParameter("lettertypeid", lettertypeid);
			query.setParameter("priorityid", priorityid);
			query.setParameter("sourcedetailid", sourcedetailid);
			query.setParameter("sourceId", sourceId);
			query.setParameter("projectType", projectType);
			query.setParameter("projectId", projectId);
			query.setParameter("dakMemberTypeId", dakMemberTypeId);
			query.setParameter("empId", empId);
			query.setParameter("DivisionCode", DivisionCode);
			query.setParameter("LabCode", LabCode);
			query.setParameter("UserName", UserName);
			List<Object[]> DakDetailedList = (List<Object[]>) query.getResultList();
			return DakDetailedList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakDetailedList", e);
			return null;
		}
		
	}


	@Override
	public List<Object[]> DakDirectorList(String fromdate, String todate,String StatusValue) throws Exception {

		logger.info(new Date() + "Inside DakDirectorList");
		try {
			Query query = manager.createNativeQuery(DAKDIRECTORLIST);
			query.setParameter("fromDate", fromdate);
			query.setParameter("toDate", todate);
			query.setParameter("statusvalue", StatusValue);
			List<Object[]> dakDirectorList = (List<Object[]>) query.getResultList();
			return dakDirectorList;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakDirectorList", e);
			return null;
		}
	}
	
	@Override
	public List<Object[]> DirPendingApprovalList(String lettertypeid,String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String employeeId) throws Exception {

		logger.info(new Date() + "Inside DirPendingApprovalList");
		try {
			Query query = manager.createNativeQuery(DIRPENDINGAPPROVALS);
			query.setParameter("lettertypeid", lettertypeid);
			query.setParameter("priorityid", priorityid);
			query.setParameter("sourcedetailid", sourcedetailid);
			query.setParameter("sourceId", sourceId);
			query.setParameter("projectType", projectType);
			query.setParameter("projectId", projectId);
			query.setParameter("dakMemberTypeId", dakMemberTypeId);
			query.setParameter("employeeId", employeeId);
			List<Object[]> DirPendingApprovalList = (List<Object[]>) query.getResultList();
			return DirPendingApprovalList;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DirPendingApprovalList", e);
			return null;
		}
	}

	@Override
	public List<Object[]> DakEmpDetailsList(String fromdate, String todate) throws Exception {

		logger.info(new Date() + "Inside DakEmpDetailsList");
		try {
			Query query = manager.createNativeQuery(DAKEMPDETAILSLIST);
			query.setParameter("fromDate", fromdate);
			query.setParameter("toDate", todate);
			List<Object[]> dakEmpDetailsList = (List<Object[]>) query.getResultList();
			return dakEmpDetailsList;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakEmpDetailsList", e);
			return null;
		}
	}
	
	@Override
	public DakMarking getGetMarkedPersDetails(long DakMarkingId) throws Exception {
		logger.info(new Date() + "Inside DAO getGetMarkedPersDetails");
		DakMarking MarkedDetails = null;
		try {
			MarkedDetails = manager.find(DakMarking.class, DakMarkingId);
			return MarkedDetails;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getGetMarkedPersDetails", e);
			return null;
		}
	}
	

	@Override
	public long UpdateDakDirAction(DakMarking dakMark)throws Exception{
		logger.info(new Date() + "Inside DAO UpdateDakDirAction");
		try {
			Query query = manager.createNativeQuery(UPDATEDAKMARKING);
			query.setParameter("dakid", dakMark.getDakId());
			query.setParameter("dakmarkingid", dakMark.getDakMarkingId());
			query.setParameter("empid", dakMark.getEmpId());
			query.setParameter("msgtype", dakMark.getMsgType());
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl UpdateDakDirAction", e);
			return 0;
		}
	}
	
	@Override
	public List<Object[]> GetIndividualReplyDetails(long DakReplyId,long EmpId, long DakId)throws Exception{
		logger.info(new Date() + "Inside GetIndividualReplyDetails");
		try {
			Query query = manager.createNativeQuery(INDIVIDUALREPLYDETAILS);
			query.setParameter("dakReplyId", DakReplyId);
			query.setParameter("empId", EmpId);
			query.setParameter("dakId", DakId);
			List<Object[]> IndividualRelyDetails = (List<Object[]>) query.getResultList();
			return IndividualRelyDetails;
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetIndividualReplyDetails", e);
			return null;
		}
		
	}
	
	@Override
	public long dakAssignstatus(long DakMarkingIdsel) throws Exception {
		logger.info(new Date() + "Inside dakAssignstatus");
		try {
			Query query = manager.createNativeQuery(UPDATEDAKASSIGNSTATUS);
			query.setParameter("DakMarkingIdsel", DakMarkingIdsel);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl dakAssignstatus", e);
			return 0;
		}
		
	}

	
	@Override
	public List<Object[]> getDakAssignedList(long empId,String fromDate,String toDate,long SelEmpId) throws Exception {
		logger.info(new Date() + "Inside getDakAssignedList");
		try {
			Query query = manager.createNativeQuery(GETDAKASSIGNEDLIST);
			query.setParameter("empId", empId);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			query.setParameter("SelEmpId", SelEmpId);
			List<Object[]> getDakAssignedList = (List<Object[]>) query.getResultList();
			return getDakAssignedList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakAssignedList", e);
			return null;
		}
		
	}

	@Override
	public Object[] getDaknoviewlist(long dakid) throws Exception {
		logger.info(new Date() + "Inside getDaknoviewlist");
		try {
			Query query = manager.createNativeQuery(DAKRECEIVEDVIEWLIST);
			query.setParameter("dakid", dakid);
			Object[] getDaknoviewlist = (Object[]) query.getSingleResult();
			return getDaknoviewlist;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDaknoviewlist", e);
			return null;
		}
		
	}

	@Override
	public List<Object[]> GetPrevAssignReplyAttachmentDetails(Long dakAssignId) throws Exception {
		logger.info(new Date() + "Inside GetPrevAssignReplyAttachmentDetails");
		try {
			Query query = manager.createNativeQuery(DAKASSIGNREPLYATTACHMENTDATA);
			query.setParameter("dakAssignId", dakAssignId);
			List<Object[]> dakAsssignReplyCountData = (List<Object[]>) query.getResultList();
			return dakAsssignReplyCountData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetPrevAssignReplyAttachmentDetails", e);
			return null;
		}
		
	}

	@Override
	public long AssignReplyInsert(DakAssignReply model) throws Exception {
		logger.info(new Date() + "Inside DAO AssignReplyInsert");
		try {
			manager.persist(model);
			manager.flush();
			return model.getDakAssignReplyId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl AssignReplyInsert", e);
			return 0;
		}
		
	}

	@Override
	public long updateAssignStatus(long dakAssignId) throws Exception {
		logger.info(new Date() + "Inside updateAssignStatus");
		try {
			Query query = manager.createNativeQuery(UPDATEASSIGNREPLYSTATUS);
			query.setParameter("dakAssignId", dakAssignId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl updateAssignStatus", e);
			return 0;
		}
	}


	@Override
	public long DakNotificationInsert(DakNotification notification) throws Exception {
		logger.info(new Date() + "Inside DAO DakNotificationInsert");
		try {
			manager.persist(notification);
			manager.flush();
			return notification.getNotificationId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakNotificationInsert", e);
			return (long) 0;
		}
	}

	@Override
	public long InsertSourceDetails(Source source) throws Exception {
		logger.info(new Date() + "Inside DAO InsertSourceDetails");
		try {
		manager.persist(source);
		manager.flush();
		return source.getSourceDetailId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl InsertSourceDetails", e);
			return (long) 0;
		}
	}

	@Override
	public long InsertNonProjectDetails(NonProjectMaster nonProject) throws Exception {
		logger.info(new Date() + "Inside DAO InsertNonProjectDetails");
		try {
		manager.persist(nonProject);
		manager.flush();
		return nonProject.getNonProjectId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl InsertNonProjectDetails", e);
			return (long) 0;
		}
	}

	@Override
	public long InsertOtherProjectDetails(OtherProjectMaster otherProject) throws Exception {
		try {
			manager.persist(otherProject);
			manager.flush();
			return otherProject.getProjectOtherId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl InsertOtherProjectDetails", e);
			return (long) 0;
		}
	}

	@Override
	public long AssignReplyAttachment(AssignReplyAttachment attachment) throws Exception {
		try {
			manager.persist(attachment);
			manager.flush();
			return attachment.getDakAssignReplyAttachmentId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl InsertOtherProjectDetails", e);
			return (long) 0;
		}
	}


	@Override
	public long EmpIdCountOfDM(long dakIdSel) throws Exception {
		logger.info(new Date() + "Inside EmpIdCountOfDM");
		try {
			Query query = manager.createNativeQuery(EMPIDCOUNTOFDAKMARKING);
			query.setParameter("dakIdSel", dakIdSel);
			BigInteger EmpIdCount = (BigInteger) query.getSingleResult();
			return EmpIdCount.longValue();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl EmpIdCountOfDM", e);
			return 0;
		}
	}

	@Override
	public long DakAckCountOfDM(long dakIdSel) throws Exception {
		logger.info(new Date() + "Inside DakAckCountOfDM");
		try {
			Query query = manager.createNativeQuery(DAKACKCOUNTOFDAKMARKING);
			query.setParameter("dakIdSel", dakIdSel);
			BigInteger dakData = (BigInteger) query.getSingleResult();
			return dakData.longValue();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakAckCountOfDM", e);
			return 0;
		}
	}

	@Override
	public long DakReplyCountInDR(long dakIdSel) throws Exception {
		logger.info(new Date() + "Inside DakReplyCountInDR");
		try {
			Query query = manager.createNativeQuery(DAKREPLYCOUNTOFDAKREPLY);
			query.setParameter("dakIdSel", dakIdSel);
			BigInteger dakData = (BigInteger) query.getSingleResult();
			return dakData.longValue();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakReplyCountInDR", e);
			return 0;
		}
	}
	
	@Override
	public long UpdateDakStatusToDR(long dakId)throws Exception{
		logger.info(new Date() + "Inside UpdateDakStatusToDR");
		try {
			Query query = manager.createNativeQuery(UPDATEDAKSTATUSTODR);
			query.setParameter("dakid", dakId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl UpdateDakStatusToDR", e);
			return 0;
		}
	}
	
	@Override
	public List<Object[]> DakPnCDoList(String fromDate, String toDate,String StatusValue, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String empId, String actionId) throws Exception {
		logger.info(new Date() + "Inside DakPnCDoList");
		try {
			Query query=manager.createNativeQuery(DAKPNCDOLIST);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			query.setParameter("statusvalue", StatusValue);
			query.setParameter("lettertypeid", lettertypeid);
			query.setParameter("priorityid", priorityid);
			query.setParameter("sourcedetailid", sourcedetailid);
			query.setParameter("sourceId", sourceId);
			query.setParameter("projectType", projectType);
			query.setParameter("projectId", projectId);
			query.setParameter("dakMemberTypeId", dakMemberTypeId);
			query.setParameter("empId", empId);
			query.setParameter("actionId", actionId);
			List<Object[]> DakRtmdoList=(List<Object[]>)query.getResultList();
			return DakRtmdoList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPnCDoList", e);
			return null;
		}
		
		
	}
	
	@Override
	public List<Object[]> DakPnCList(long EmpId,String LoginType, String fromDate, String toDate,String StatusValue) throws Exception {
		logger.info(new Date() + "Inside DakPnCList");
		try {
			Query query=manager.createNativeQuery(DAKPNCLIST);
			query.setParameter("empId", EmpId);
			query.setParameter("loginType", LoginType);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			query.setParameter("statusValue", StatusValue);
			System.out.println("CALL Dms_DakPnCList("+EmpId+","+LoginType+","+fromDate+","+toDate+","+StatusValue+")");
			List<Object[]> DakRtmdoList=(List<Object[]>)query.getResultList();
			return DakRtmdoList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPnCList", e);
			return null;
		}
	}
	
	
	@Override
	public List<Object[]> DakPnCPendingReplyList(long EmpId,String LoginType, String fromDate, String toDate,String StatusValue) throws Exception {
		logger.info(new Date() + "Inside DakPnCPendingReplyList");
		try {
			Query query = manager.createNativeQuery(DAKPENDINGPNCREPLYLIST);
			query.setParameter("empId", EmpId);
			query.setParameter("loginType", LoginType);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			query.setParameter("statusValue", StatusValue);
			System.out.println("CALL Dms_DakPnCPendingReplyList("+EmpId+","+LoginType+","+fromDate+","+toDate+","+StatusValue+")");
			List<Object[]> DakPnCDoPendingReplyList = (List<Object[]>) query.getResultList();
			return DakPnCDoPendingReplyList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPnCPendingReplyList", e);
			return null;
		}
	}

	
	@Override
	public List<Object[]>  DakDetailForPNCDO(long DakId) throws Exception {
		logger.info(new Date() + "Inside DakDetailForPNCDO");
		try {
			Query query=manager.createNativeQuery(DAKDETAILSFORPNCDO);
			query.setParameter("dakid", DakId);
			List<Object[]> DakDetailForPNCDO=(List<Object[]>)query.getResultList();
			return DakDetailForPNCDO;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakDetailForPNCDO", e);
			return null;
		}
		
	}

	

	@Override
	public List<Object[]> GetReplyDetailsFrmDakReply(long DakId, long EmpId, String Username, String DakAdmin)
			throws Exception {
		logger.info(new Date() + "Inside GetReplyDetailsFrmDakReply");
		try {
			Query query = manager.createNativeQuery(GETREPLYDETAILSOFDAKREPLY);
			query.setParameter("dakid", DakId);
			query.setParameter("empid", EmpId);
			query.setParameter("username", Username);
			query.setParameter("dakadmin", DakAdmin);
			System.out.println("CALL Dms_DakReplyModalList('" + DakId + "', '" + EmpId + "', '" + Username + "', '"
					+ DakAdmin + "')");
			List<Object[]> ReplyModalDetails = (List<Object[]>) query.getResultList();
			return ReplyModalDetails;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetReplyDetailsFrmDakReply", e);
			return null;
		}
	}
	
	@Override
	public List<Object[]> GetReplyAttachsFrmDakReplyAttach() throws Exception {
		logger.info(new Date() + "Inside GetReplyAttachsFrmDakReplyAttach");
		try {
			Query query = manager.createNativeQuery(GETREPLYATTACHSLIST);
			List<Object[]> ReplyAttachList = (List<Object[]>) query.getResultList();
			return ReplyAttachList;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetReplyAttachsFrmDakReplyAttach", e);
			return null;
		}
	}
	
	@Override
	public long  DirApprovalActionUpdate(String DirApprovalVal,long DakId)  throws Exception{
		logger.info(new Date() + "Inside DirApprovalActionUpdate");
		try {
			Query query = manager.createNativeQuery(UPDATEDIRAPPROVALACTION);
			query.setParameter("dirapprovalval", DirApprovalVal);
			query.setParameter("dakid", DakId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DirApprovalActionUpdate", e);
			return 0;
		}
	}
	
	@Override
	public long  UpdateDirAprvForwarderIdAndDakStatus(long EmpId,long DakId,String DakStatus)  throws Exception{
		logger.info(new Date() + "Inside UpdateDirAprvForwarderIdAndDakStatus");
		try {
			Query query = manager.createNativeQuery(UPDATEDIRAPVFWDERIDANDSTATUS);
			query.setParameter("dirApvForwarderId", EmpId);
			query.setParameter("dakid", DakId);
			query.setParameter("dakstatus", DakStatus);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl UpdateDirAprvForwarderIdAndDakStatus", e);
			return 0;
		}
	}

	@Override
	public long DakPnCReplyInsert(DakPnCReply pncModel)  throws Exception {
		logger.info(new Date() + "Inside DAO DakPnCReplyInsert");
		try {
			manager.persist(pncModel);
			manager.flush();
			return pncModel.getDakPnCReplyId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPnCReplyInsert", e);
			return 0;
		}
		
	}
	

	@Override
	public List<Object[]> GetPrevPnCReplyAttachmentDetails(long pncreplyid) throws Exception {
		logger.info(new Date() + "Inside GetPrevPnCReplyAttachmentDetails");
		try {
			Query query = manager.createNativeQuery(PNCDAKREPLYATTACHMENTDATA);
			query.setParameter("pncreplyid", pncreplyid);
			List<Object[]> PnCReplyAttachCountData = (List<Object[]>) query.getResultList();
			return PnCReplyAttachCountData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetPrevPnCReplyAttachmentDetails", e);
			return null;
		}
		
	}


	@Override
	public long DakPnCAttachmentAdd(DakPnCReplyAttach attachModel) throws Exception {
		logger.info(new Date() + "Inside DAO DakPnCAttachmentAdd");
		try {
			manager.persist(attachModel);
			manager.flush();
			return attachModel.getPnCReplyAttachId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPnCAttachmentAdd", e);
			return 0;
		}
		
	}
	
	@Override
    public long  DakPnCUpdateStatus(long DakId)throws Exception{
		logger.info(new Date() + "Inside DAO DakPnCUpdateStatus");
		try {
			Query query = manager.createNativeQuery(UPDATEPANDCDAKSTATUS);
			query.setParameter("dakid", DakId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPnCUpdateStatus", e);
			return 0;
		}
    }
	@Override
	  public List<Object[]>  GetMarkerReplySentForApprovalData(long DakId,long DirApvForwarderId)throws Exception{
		  logger.info(new Date() + "Inside GetMarkerReplySentForApprovalData");
			try {
				Query query = manager.createNativeQuery(MARKERREPLIEDDATAFORAPPROVE);
				query.setParameter("dakid", DakId);
				query.setParameter("dakaprvforwaderid", DirApvForwarderId);
				List<Object[]> Data = (List<Object[]>) query.getResultList();
				return Data;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl GetMarkerReplySentForApprovalData", e);
				return null;
			}
			
		}
	
	@Override
	public List<Object[]>  GetPnCReplyDetails(long DakId) throws Exception {
		logger.info(new Date() + "Inside GetPnCReplyDetails");
		try {
			Query query = manager.createNativeQuery(PNCREPLYDATA);
			query.setParameter("dakid", DakId);
			List<Object[]> Data = (List<Object[]>) query.getResultList();
			return Data;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetPnCReplyDetails", e);
			return null;
		}
		
	}
	
	@Override
	public List<Object[]>  GetPnCAttachReplyDetails(long DakPnCReplyId) throws Exception {
		logger.info(new Date() + "Inside GetPnCAttachReplyDetails");
		try {
			Query query = manager.createNativeQuery(PNCREPLYATTACHDATA);
			query.setParameter("dakpncreplyid", DakPnCReplyId);
			List<Object[]> Data = (List<Object[]>) query.getResultList();
			return Data;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetPnCAttachReplyDetails", e);
			return null;
		}
		
	}
	

	@Override
	public Object[] DakPnCReplyAttachData(String PnCReplyAttachId) throws Exception {
		logger.info(new Date() + "Inside DakPnCReplyAttachData");
		try {
			Query query = manager.createNativeQuery(DAKPNCREPLYDOWNLOAD);
			query.setParameter("pncreplyattachid", PnCReplyAttachId);
			Object[] attachData = (Object[]) query.getSingleResult();
			return attachData;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPnCReplyAttachData", e);
			return null;
		}

	}
	@Override
	public long DakApprovalUpdate(long DakId,String ApprovedBy,String ApprovedDate)throws Exception{
		logger.info(new Date() + "Inside DAO DakApprovalUpdate");
		try {
			Query query = manager.createNativeQuery(UPDATESTATUSFRAPPROVAL);
			query.setParameter("dakid", DakId);
			query.setParameter("approvedby", ApprovedBy);
			query.setParameter("approveddate", ApprovedDate);
			query.setParameter("status", "AP");
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakApprovalUpdate", e);
			return 0;
		}
	}
	
	@Override
	public long DakApprovalWithCommtUpdate(long DakId,String ApprovalCommt,String ApprovedBy,String ApprovedDate)throws Exception{
		logger.info(new Date() + "Inside DAO DakApprovalWithCommtUpdate");
		try {
			Query query = manager.createNativeQuery(UPDATESTATUSFRAPPROVALWITHCOMMT);
			query.setParameter("dakid", DakId);
			query.setParameter("approvedby", ApprovedBy);
			query.setParameter("approvedcommt", ApprovalCommt);
			query.setParameter("approveddate", ApprovedDate);
			query.setParameter("status", "AP");
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakApprovalWithCommtUpdate", e);
			return 0;
		}
	}

	@Override
	public long DakReturnUpdate(long DakId,String ReturnComment)throws Exception{
		logger.info(new Date() + "Inside DAO DakReturnUpdate");
		try {
			Query query = manager.createNativeQuery(UPDATESTATUSFRDAKRETURN);
			query.setParameter("pncreplystatus", "D");
			query.setParameter("dakid", DakId);
			query.setParameter("returnedcomment", ReturnComment);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakReturnUpdate", e);
			return 0;
		}
	}
	
	
	@Override
	public long DakPNCForwardUpdate(long DakId,String ForwardBy, String ForwardDate)throws Exception{
		logger.info(new Date() + "Inside DAO DakPNCForwardUpdate");
		try {
			Query query = manager.createNativeQuery(UPDATESTATUSFRDAKPNCFORWARD);
			query.setParameter("dakid", DakId);
			query.setParameter("status", "FP");
			query.setParameter("forwardby", ForwardBy);
			query.setParameter("forwarddate", ForwardDate);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPNCForwardUpdate", e);
			return 0;
		}
	}


	@Override
	public List<Object[]>  GetPnCReplyDataDetails(long DakPnCReplyId,long DakId) throws Exception {
		logger.info(new Date() + "Inside GetPnCReplyDataDetails");
		try {
			Query query = manager.createNativeQuery(PNCREPLYDATALIST);
			query.setParameter("pncReplyId", DakPnCReplyId);
			query.setParameter("dakid", DakId);
			List<Object[]> Data = (List<Object[]>) query.getResultList();
			return Data;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetPnCReplyDataDetails", e);
			return null;
		}
		
	}
	
	@Override
	public List<Object[]>  ReplyDakPnCAttachmentData (long DakPnCReplyAttachId, long DakPnCReplyId)throws Exception {
		logger.info(new Date() + "Inside ReplyDakPnCAttachmentData");
		try {
			Query query = manager.createNativeQuery(PARTICULARDAKPNCREPLYATTACHDATA);
			query.setParameter("DakPnCReplyAttachId", DakPnCReplyAttachId);
			query.setParameter("DakPnCReplyId", DakPnCReplyId);
			 List<Object[]> Data = (List<Object[]>) query.getResultList();
				return Data;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl ReplyDakPnCAttachmentData", e);
			return null;
		}
		
	}
	

	@Override
	public long DeletePnCReplyAttachment(long PnCReplyAttachId,long DakPnCReplyId) throws Exception{
		logger.info(new Date() + "Inside DeletePnCReplyAttachment");
		try {
			Query query = manager.createNativeQuery(DELETEPNCREPLYATTACHMENT);
			query.setParameter("PnCReplyAttachId", PnCReplyAttachId);
			query.setParameter("DakPnCReplyId", DakPnCReplyId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DeletePnCReplyAttachment", e);
			return 0;
		}
		
	}
	
	@Override
	public DakPnCReply GetPnCDetails(long DakPnCReplyId) throws Exception{
		logger.info(new Date() + "Inside DaoImpl GetPnCDetails()");
		try {	
			return manager.find(DakPnCReply.class, DakPnCReplyId);
	    } catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetPnCDetails", e);
		return null;
	}
	}
	
	@Override
	public long   DakPnCReplyUpdate(DakPnCReply pncModel)   throws Exception{
		try {
			Query query = manager.createNativeQuery(UPDATEPNCREPLY);
			query.setParameter("empid", pncModel.getEmpId());
			query.setParameter("pnCReplyData", pncModel.getPnCReply());
			query.setParameter("pnCReplyStatus", pncModel.getPnCReplyStatus());
			query.setParameter("modifiedBy", pncModel.getModifiedBy());
			query.setParameter("modifiedDate", pncModel.getModifiedDate());
			query.setParameter("pnCReplyId", pncModel.getDakPnCReplyId());
			query.setParameter("dakid", pncModel.getDakId());
			
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakPnCReplyUpdate", e);
			return 0;
		}
	}
	@Override
	public long DakCloseUpdate(long DakId,String closedBy,String closedDateTime,String closedDate,String closingCommt)throws Exception{
		logger.info(new Date() + "Inside DAO DakCloseUpdate");
		try {
			Query query = manager.createNativeQuery(UPDATESTATUSFRDAKCLOSE);
			query.setParameter("dakid", DakId);
			query.setParameter("closedBy", closedBy);
			query.setParameter("closedDateTime", closedDateTime);
			query.setParameter("closedDate", closedDate);
			query.setParameter("closingCommt", closingCommt);
			query.setParameter("status", "DC");
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakCloseUpdate", e);
			return 0;
		}
	}
	

	@Override
	public long RevokeMarking(String markingId) throws Exception {
		logger.info(new Date() + "Inside RevokeMarking");
		try {
			Query query = manager.createNativeQuery(REVOKEMARKING);
			query.setParameter("markingId", markingId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl RevokeMarking", e);
			return 0;
		}
	}

	@Override
	public List<Object[]> DakMemberGroup() throws Exception {
		logger.info(new Date() + "Inside DakMemberGroup");
		try {
			Query query=manager.createNativeQuery(DAKMEMBERGROUP);
			List<Object[]> DakMemberGroup=(List<Object[]>)query.getResultList();
			return DakMemberGroup;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakMemberGroup", e);
			return null;
		}
	}

	@Override
	public List<Object[]> getDakmemberGroupEmpList(String[] groupid,String labcode) throws Exception {
		logger.info(new Date() + "Inside getDakmemberGroupEmpList");
		try {
			 String employee = "SELECT DISTINCT a.EmpId,a.EmpName,c.Designation,d.dakmembertypeid,a.srno FROM employee a,dak_members b,employee_desig c,dak_member_type d WHERE a.EmpId=b.EmpId AND a.DesigId=c.DesigId AND a.labcode='"+labcode+"' AND b.DakMemberTypeId=d.DakMemberTypeId AND a.IsActive='1' AND b.IsActive='1' AND b.DakMemberTypeId IN(";

			 for (int i = 0; i < groupid.length; i++) {
					if (i > 0) {
						employee += ",'" + groupid[i] + "'";
					} else {
						employee += "'" + groupid[i] + "'";
					}
			 }
		        employee += ") ORDER BY a.srno ";
			Query query=manager.createNativeQuery(employee);
			List<Object[]> getDakmemberGroupEmpList=(List<Object[]>)query.getResultList();
			return getDakmemberGroupEmpList;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl getDakmemberGroupEmpList", e);
			return null;
		}
	}

	@Override
	public List<Object[]> AssignReplyRemarks(long empId, long dakIdSel) throws Exception {
		logger.info(new Date() + "Inside AssignReplyRemarks");
		try {
			Query query = manager.createNativeQuery(ASSIGNREPLYDATA);
			query.setParameter("empId", empId);
			query.setParameter("dakIdSel", dakIdSel);
			List<Object[]> AssignReplyRemarks=(List<Object[]>)query.getResultList();
			return AssignReplyRemarks;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl AssignReplyRemarks", e);
			return null;
		}
	}

	@Override
	public List<Object[]> GetAssignReplyAttachmentList(long dakAsssignReplyId) throws Exception {
		logger.info(new Date() + "Inside GetAssignReplyAttachmentList");
		try {
			Query query = manager.createNativeQuery(GETASSIGNREPLYATTACHMODALDETAILS);
			query.setParameter("dakAsssignReplyId", dakAsssignReplyId);
			List<Object[]> GetAssignReplyAttachmentList = (List<Object[]>) query.getResultList();
			return GetAssignReplyAttachmentList;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetAssignReplyAttachmentList", e);
			return null;
		}
	}

	@Override
	public List<Object[]> GetDakAssignReplyDetails(long dakAsssignReplyId) throws Exception {
		logger.info(new Date() + "Inside DaoImpl GetDakAssignReplyDetails()");
		try {
			
			Query query = manager.createNativeQuery(GETASSIGNREPLYVIEWMOREDETAILS);
			query.setParameter("dakAsssignReplyId", dakAsssignReplyId);
            List<Object[]> GetDakAssignReplyDetails = (List<Object[]>) query.getResultList();
			return GetDakAssignReplyDetails;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetDakAssignReplyDetails", e);
			return null;
		}
	}

	@Override
	public DakAssignReply GetDakAssignReplyEditDetails(long dakAssignReplyId) throws Exception {
		logger.info(new Date() + "Inside DaoImpl GetDakAssignReplyEditDetails()");
		try {	
			return manager.find(DakAssignReply.class, dakAssignReplyId);
	    } catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetDakAssignReplyEditDetails", e);
		return null;
	}
	}

	@Override
	public long AssignReplyEdit(DakAssignReply model) throws Exception {
		logger.info(new Date() + "Inside DAO DakReplyEditData");
		try {
			Query query = manager.createNativeQuery(UPDATEDAKASSIGNREPLY);
			query.setParameter("DakAssignReplyId", model.getDakAssignReplyId());
			query.setParameter("DakId", model.getDakId());
			query.setParameter("DakAssignId", model.getDakAssignId());
			query.setParameter("DakEmpId", model.getEmpId());
			query.setParameter("reply", model.getReply());
			query.setParameter("modifiedBy", model.getModifiedBy());
			query.setParameter("modifiedDate", model.getModifiedDate());
			long value=query.executeUpdate();
			return value;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakReplyEditData", e);
			return 0;
		}
	}

	@Override
	public List<Object[]> AssignReplyDakAttachmentData(long dakAssignReplyAttachId, long dakAssignReplyId) throws Exception {
		logger.info(new Date() + "Inside AssignReplyDakAttachmentData");
		try {
			Query query = manager.createNativeQuery(PARTICULARDAKASSIGNREPLYATTACHDATA);
			query.setParameter("dakAssignReplyAttachId", dakAssignReplyAttachId);
			query.setParameter("dakAssignReplyId", dakAssignReplyId);
			 List<Object[]> AssignReplyDakAttachmentData = (List<Object[]>) query.getResultList();
				return AssignReplyDakAttachmentData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl AssignReplyDakAttachmentData", e);
			return null;
		}
	}

	@Override
	public int DeleteAssignReplyAttachment(String dakAssignReplyAttachId) throws Exception {
		logger.info(new Date() + "Inside DeleteAssignReplyAttachment");
		try {
			Query query = manager.createNativeQuery(DELETEASSIGNREPLYATTACHMENTDATA);
			query.setParameter("dakAssignReplyAttachId", dakAssignReplyAttachId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DeleteAssignReplyAttachment", e);
			return 0;
		}
	}
	
	

	@Override
	public List<Object[]> DakMarkingData(long dakId) throws Exception {
		logger.info(new Date() + "Inside DakMarkingData");
		try {
			Query query = manager.createNativeQuery(DAKMARKINGDATA);
			query.setParameter("dakId", dakId);
			List<Object[]> DakMarkingData = (List<Object[]>) query.getResultList();
			return DakMarkingData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakMarkingData", e);
			return null;
		}
		
	}

	

	@Override
	public List<Object[]> DakMarkedMemberGroup(String dakId) throws Exception {
		logger.info(new Date() + "Inside DakMarkedMemberGroup");
		try {
			Query query = manager.createNativeQuery(DAKMARKEDGROUPMEMBERS);
			query.setParameter("dakId", dakId);
			 List<Object[]> DakMarkedMemberGroup = (List<Object[]>) query.getResultList();
				return DakMarkedMemberGroup;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DakMarkedMemberGroup", e);
			return null;
		}
	}




@Override
public List<Object[]> DakInactiveMarkedMemberGroup(String dakId) throws Exception {
	logger.info(new Date() + "Inside DakInactiveMarkedMemberGroup");
	try {
		Query query = manager.createNativeQuery(DAKMARKEDGROUPMEMBERSINACTIVE);
		query.setParameter("dakId", dakId);
		 List<Object[]> DakMarkedInactiveMemberGroup = (List<Object[]>) query.getResultList();
			return DakMarkedInactiveMemberGroup;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakInactiveMarkedMemberGroup", e);
		return null;
	}
}

@Override
public long CSWReplyForwardReturn(long dakAssignReplyIdFrReturn,String ReturnRemarks) throws Exception {
	logger.info(new Date() + "Inside CSWReplyForwardReturn");
	try {
		Query query = manager.createNativeQuery(CSWREPLYFORWARDRETURN);
		query.setParameter("dakAssignReplyIdFrReturn", dakAssignReplyIdFrReturn);
		query.setParameter("ReturnRemarks", ReturnRemarks);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl CSWReplyForwardReturn", e);
		return 0;
	}
}

@Override
public long insertDakAssignReplyRev(DakAssignReplyRev replyRev) throws Exception {
	logger.info(new Date() + "Inside DAO insertDakAssignReplyRev");
	try {
		manager.persist(replyRev);
		manager.flush();
		return replyRev.getDakAssignReplyRevId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl insertDakAssignReplyRev", e);
		return 0;
	}
}

@Override

public long insertDakAssignReplyAttachRev(DakAssignReplyAttachRev attachRev) throws Exception {
	logger.info(new Date() + "Inside DAO insertDakAssignReplyAttachRev");
	try {
		manager.persist(attachRev);
		manager.flush();
		return attachRev.getDakAssignReplyAttachRevId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl insertDakAssignReplyAttachRev", e);
		return 0;
	}
}
@Override	
		
public List<Object[]> ProjectDetailedList(String projectId) throws Exception {
	logger.info(new Date() + "Inside ProjectDetailedList");
	try {
		Query query = manager.createNativeQuery(PROJECTDETAILSLIST);
		query.setParameter("projectid", projectId);
		 List<Object[]> ProjectDetailedList = (List<Object[]>) query.getResultList();
			return ProjectDetailedList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl ProjectDetailedList", e);
		return null;
	}
}

@Override
public long CountRevisionNo(Long dakAssignReplyId) throws Exception {
	logger.info(new Date() + "Inside CountRevisionNo");
	try {
		Query query = manager.createNativeQuery(COUNTREVISIONNO);
		query.setParameter("dakAssignReplyId", dakAssignReplyId);
         List<Object> resultList = query.getResultList();
        
        if (resultList != null && !resultList.isEmpty()) {
            // Assuming the query returns a single value
            Object resultValue = resultList.get(0);
            if (resultValue instanceof Number) {
                return ((Number) resultValue).longValue();
            }
        }
        
        return 0;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl CountRevisionNo", e);
		return 0;
	}
}

@Override
public List<Object[]> getDakActionRequiredEdit(long actionRequiredDakId) throws Exception {
	logger.info(new Date() + "Inside getDakActionRequiredEdit");
	try {
		Query query = manager.createNativeQuery(GETACTIONREQUIREDFOREDIT);
		query.setParameter("actionRequiredDakId", actionRequiredDakId);
		 List<Object[]> getDakActionRequiredEdit = (List<Object[]>) query.getResultList();
			return getDakActionRequiredEdit;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getDakActionRequiredEdit", e);
		return null;
	}
}


@Override
public long CSWReplyForwardReturn(long dakAssignReplyIdFrReturn) throws Exception {
	logger.info(new Date() + "Inside CSWReplyForwardReturn");
	try {
		Query query = manager.createNativeQuery(CSWREPLYFORWARDRETURN);
		query.setParameter("dakAssignReplyIdFrReturn", dakAssignReplyIdFrReturn);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl CSWReplyForwardReturn", e);
		return 0;
	}
}

@Override
public long EditActionRequired(long actionRequiredEditDakId, long actionRequiredEdit,String ClosingAuthority,String EditRemarks) throws Exception {
	logger.info(new Date() + "Inside EditActionRequired");
	try {
		Query query = manager.createNativeQuery(EDITACTIONREQUIRED);
		query.setParameter("actionRequiredEditDakId", actionRequiredEditDakId);
		query.setParameter("actionRequiredEdit", actionRequiredEdit);
		query.setParameter("ClosingAuthority", ClosingAuthority);
		query.setParameter("EditRemarks", EditRemarks);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EditActionRequired", e);
		return 0;
	}
}

@Override
public DakAssign getDaAssignIdDetails(Long dakAssignId) throws Exception {
	logger.info(new Date() + "Inside getDaAssignIdDetails");
	try {
		DakAssign dakassigndata = manager.find(DakAssign.class, dakAssignId);
		return dakassigndata;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getDaAssignIdDetails", e);
		return null;
	}
}

@Override
public long UpdateAssign(DakAssign assign) throws Exception {
	logger.info(new Date() + "Inside DAO UpdateAssign");
	try {
		dakAssignRepo.save(assign);
		return assign.getDakAssignId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl UpdateAssign", e);
		return 0;
	}
}

@Override
public long EditActionRequired(long actionRequiredEditDakId, long actionRequiredEdit, String dueDate, String actionTime,String ClosingAuthority,String EditRemarks) throws Exception {
	logger.info(new Date() + "Inside EditActionRequired");
	try {
		Query query = manager.createNativeQuery(EDITACTIONREQUIREDDUEDATE);
		query.setParameter("actionRequiredEditDakId", actionRequiredEditDakId);
		query.setParameter("actionRequiredEdit", actionRequiredEdit);
		query.setParameter("dueDate", dueDate);
		query.setParameter("actionTime", actionTime);
		query.setParameter("ClosingAuthority", ClosingAuthority);
		query.setParameter("EditRemarks", EditRemarks);
		
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EditActionRequired", e);
		return 0;
	}
}

@Override
public long updatedakmarkingaction(long actionRequiredEditDakId, long actionId,String dueDate) throws Exception {
	logger.info(new Date() + "Inside updatedakmarkingaction");
	try {
		Query query = manager.createNativeQuery(UPDATEDAKMARKINGACTION);
		query.setParameter("actionRequiredEditDakId", actionRequiredEditDakId);
		query.setParameter("actionId", actionId);
		query.setParameter("dueDate", dueDate);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl updatedakmarkingaction", e);
		return 0;
	}
}

@Override
public long updatedakmarkingrecords(long actionRequiredEditDakId, long actionId) throws Exception {
	logger.info(new Date() + "Inside updatedakmarkingactionrecords");
	try {
		Query query = manager.createNativeQuery(UPDATEDAKMARKINGRECORDS);
		query.setParameter("actionRequiredEditDakId", actionRequiredEditDakId);
		query.setParameter("actionId", actionId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl updatedakmarkingactionrecords", e);
		return 0;
	}
	
	}

@Override
public long reupdateremarkstatus(String dakId) throws Exception {
	logger.info(new Date() + "Inside reupdateremarkstatus");
	try {
		Query query = manager.createNativeQuery(REUPDATEREMARKUPSTATUS);
		query.setParameter("dakId", dakId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl reupdateremarkstatus", e);
		return 0;
}
}

@Override
public List<Object[]> getReDistributedEmps(String dakId) throws Exception {
	logger.info(new Date() + "Inside getReDistributedEmps");
	try {
		Query query = manager.createNativeQuery(DAKREDISTRIBUTEDATA);
		query.setParameter("dakId", dakId);
		List<Object[]> getDistributedEmps = (List<Object[]>) query.getResultList();
		return getDistributedEmps;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getReDistributedEmps", e);
		return null;
	}
}

@Override
public Object[] GetAssignId(Long dakId, Long dakMarkingId) throws Exception {
	logger.info(new Date() + "Inside GetAssignId");
	try {
		Query query = manager.createNativeQuery(GETASSIGNID);
		query.setParameter("dakId", dakId);
		query.setParameter("dakMarkingId", dakMarkingId);
		Object[] assignid = (Object[]) query.getSingleResult();
		return assignid;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetAssignId", e);
		return null;
	}
	
}

@Override
public long updatemarkedactioninfo(long DakId, long EmpId, long MarkedId, String MarkerAction) throws Exception {
	logger.info(new Date() + "Inside updatemarkedactioninfo");
	try {
		Query query = manager.createNativeQuery(UPDATEMARKERACTIONINFO);
		query.setParameter("DakId", DakId);
		query.setParameter("EmpId", EmpId);
		query.setParameter("MarkedId", MarkedId);
		query.setParameter("MarkerAction", MarkerAction);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl updatemarkedactioninfo", e);
		return 0;
}
}

@Override
public List<Object[]> getOldassignemplist(long dakId) throws Exception {
	logger.info(new Date() + "Inside getOldassignemplist");
	try {
		Query query = manager.createNativeQuery(GETOLDASSIGNEMPLIST);
		query.setParameter("dakId", dakId);
		List<Object[]> getOldassignemplist = (List<Object[]>) query.getResultList();
		return getOldassignemplist;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getOldassignemplist", e);
		return null;
	}
}

@Override
public long UpdateMarkerAction(long dakId, long dakMarkingId, long empId, String actionValue) throws Exception {
	logger.info(new Date() + "Inside UpdateMarkerAction");
	try {
		Query query = manager.createNativeQuery(UPDATEMARKERACTION);
		query.setParameter("dakId", dakId);
		query.setParameter("dakMarkingId", dakMarkingId);
		query.setParameter("empId", empId);
		query.setParameter("actionValue", actionValue);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl UpdateMarkerAction", e);
		return 0;
}
}

@Override
public List<Object[]> DakAssignedByMeList(long empId, String fromDate, String toDate,long SelEmpId) throws Exception {
	logger.info(new Date() + "Inside DakAssignedByMeList");
	try {
		Query query = manager.createNativeQuery(DAKASSIGNEDBYMELIST);
		query.setParameter("empId", empId);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		query.setParameter("SelEmpId", SelEmpId);
		List<Object[]> DakAssignedByMeList = (List<Object[]>) query.getResultList();
		return DakAssignedByMeList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakAssignedByMeList", e);
		return null;
	}
}


@Override
public List<Object[]> getalldaklinkdata(long dakId) throws Exception {
	logger.info(new Date() + "Inside getalldaklinkdata");
	try {
		Query query = manager.createNativeQuery(ALLDAKLINKLIST);
		query.setParameter("dakId", dakId);
		List<Object[]> getalldaklinkdata = (List<Object[]>) query.getResultList();
		return getalldaklinkdata;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getalldaklinkdata", e);
		return null;
	}
}

@Override
public List<Object[]> DakRemarknRedistributeList(String fromDate, String toDate, String statusValue) throws Exception {
	logger.info(new Date() + "Inside DakRemarknRedistributeList");
	try {
		Query query = manager.createNativeQuery(DAKREMARKNREDISTRIBUTELIST);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		query.setParameter("statusValue", statusValue);
		List<Object[]> dakdetailedList = (List<Object[]>) query.getResultList();
		return dakdetailedList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakRemarknRedistributeList", e);
		return null;
	}
	
}

@Override
public long Dakseekresponseinsert(DakSeekResponse seekresponseinsert) throws Exception {
	logger.info(new Date() + "Inside DAO Dakseekresponseinsert");
	try {
		manager.persist(seekresponseinsert);
		manager.flush();
		return seekresponseinsert.getSeekResponseId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl Dakseekresponseinsert", e);
		return 0;
	}
}

@Override
public List<Object[]> getDakSeekResponseListToMe(long empId, String fromDate, String toDate) throws Exception {
	logger.info(new Date() + "Inside getDakSeekResponseListToMe");
	try {
		Query query = manager.createNativeQuery(DAKASSIGNRESPONSELISTTOME);
		query.setParameter("empId", empId);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		List<Object[]> getDakSeekResponseListToMe = (List<Object[]>) query.getResultList();
		return getDakSeekResponseListToMe;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getDakSeekResponseListToMe", e);
		return null;
	}
}

@Override
public List<Object[]> DakSeekResponseByMeList(long empId, String fromDate, String toDate) throws Exception {
	logger.info(new Date() + "Inside DakSeekResponseByMeList");
	try {
		Query query = manager.createNativeQuery(DAKSEEKRESPONSEBYMELIST);
		query.setParameter("empId", empId);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		List<Object[]> DakSeekResponseByMeList = (List<Object[]>) query.getResultList();
		return DakSeekResponseByMeList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakSeekResponseByMeList", e);
		return null;
	}
}

@Override
public long SeekResponseReplyInsert(String reply, String replyStatus,String RepliedBy,String RepliedDate, Long seekResponseId) throws Exception {
	logger.info(new Date() + "Inside SeekResponseReplyInsert");
	try {
		Query query = manager.createNativeQuery(UPDATESEEKRESPONSEREPLY);
		query.setParameter("reply", reply);
		query.setParameter("replyStatus", replyStatus);
		query.setParameter("RepliedBy", RepliedBy);
		query.setParameter("RepliedDate", RepliedDate);
		query.setParameter("seekResponseId", seekResponseId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl UpdateReply", e);
		return 0;
	}
}

@Override
public List<Object[]> GetPrevSeekResponseReplyAttachmentDetails(Long seekResponseId) throws Exception {
	logger.info(new Date() + "Inside GetPrevSeekResponseReplyAttachmentDetails");
	try {
		Query query = manager.createNativeQuery(DAKSEEKRESPONSEATTACHMENTDATA);
		query.setParameter("seekResponseId", seekResponseId);
		List<Object[]> GetPrevSeekResponseReplyAttachmentDetails = (List<Object[]>) query.getResultList();
		return GetPrevSeekResponseReplyAttachmentDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetPrevSeekResponseReplyAttachmentDetails", e);
		return null;
	}
}

@Override
public long SeekResponseReplyAttachment(SeekResponseReplyAttachment attachment) throws Exception {
	try {
		manager.persist(attachment);
		manager.flush();
		return attachment.getSeekResponseAttachmentId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl SeekResponseReplyAttachment", e);
		return (long) 0;
	}
}

@Override
public List<Object[]> GetSeekResponseRelyModalDetails(long dakId, long empId, String username, String createdBy) throws Exception {
	logger.info(new Date() + "Inside GetSeekResponseRelyModalDetails");
	try {
		Query query = manager.createNativeQuery(GETSEEKRESPONSEREPLYMODALDETAILS);
		query.setParameter("dakId", dakId);
		query.setParameter("empId", empId);
		query.setParameter("username", username);
		query.setParameter("dakadmin", createdBy);
		List<Object[]> SeekResponseReplyModalDetails = (List<Object[]>) query.getResultList();
		return SeekResponseReplyModalDetails;

	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetSeekResponseRelyModalDetails", e);
		return null;
	}
}

@Override
public List<Object[]> GetSeekResponseReplyAttachmentList(long dakReplyId) throws Exception {
	logger.info(new Date() + "Inside GetSeekResponseReplyAttachmentList");
	try {
		Query query = manager.createNativeQuery(GETSEEKRESPONSEREPLYATTACHMODALDETAILS);
		query.setParameter("dakReplyId", dakReplyId);
		List<Object[]> GetSeekResponseReplyAttachmentList = (List<Object[]>) query.getResultList();
		return GetSeekResponseReplyAttachmentList;

	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetSeekResponseReplyAttachmentList", e);
		return null;
	}
}

@Override
public List<Object[]> GetDakSeekResponseReplyDetails(long dakReplyId) throws Exception {
	logger.info(new Date() + "Inside DaoImpl GetDakSeekResponseReplyDetails()");
	try {
		
		Query query = manager.createNativeQuery(GETSEEKRESPONSEREPLYVIEWMOREDETAILS);
		query.setParameter("dakreplyid", dakReplyId);
        List<Object[]> GetDakSeekResponseReplyDetails = (List<Object[]>) query.getResultList();
		return GetDakSeekResponseReplyDetails;

	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetDakSeekResponseReplyDetails", e);
		return null;
	}
}

@Override
public DakSeekResponse GetDakSeekResponseReplyEditDetails(long dakReplyId) throws Exception {
	logger.info(new Date() + "Inside DaoImpl GetDakSeekResponseReplyEditDetails()");
	try {	
		return manager.find(DakSeekResponse.class, dakReplyId);
    } catch (Exception e) {
	e.printStackTrace();
	logger.error(new Date() + "Inside DaoImpl GetDakSeekResponseReplyEditDetails", e);
	return null;
}
}

@Override
public List<Object[]> SeekResponseReplyDakAttachmentData(long dakReplyAttachId, long dakReplyId) throws Exception {
	logger.info(new Date() + "Inside SeekResponseReplyDakAttachmentData");
	try {
		Query query = manager.createNativeQuery(PARTICULARDAKSEEKRESPONSEREPLYATTACHDATA);
		query.setParameter("dakReplyAttachId", dakReplyAttachId);
		query.setParameter("dakReplyId", dakReplyId);
		 List<Object[]> SeekResponseReplyDakAttachmentData = (List<Object[]>) query.getResultList();
			return SeekResponseReplyDakAttachmentData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl SeekResponseReplyDakAttachmentData", e);
		return null;
	}
}

@Override
public int DeleteSeekResponseReplyAttachment(String dakReplyAttachId) throws Exception {
	logger.info(new Date() + "Inside DeleteSeekResponseReplyAttachment");
	try {
		Query query = manager.createNativeQuery(DELETESEEKRESPONSEREPLYATTACHMENT);
		query.setParameter("dakReplyAttachId", dakReplyAttachId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DeleteSeekResponseReplyAttachment", e);
		return 0;
	}
	
}

@Override
public long SeekResponseReplyUpdate(String reply, String modifiedBy, String modifiedDate, Long seekResponseId) throws Exception {
	logger.info(new Date() + "Inside SeekResponseReplyUpdate");
	try {
		Query query = manager.createNativeQuery(UPDATESEEKRESPONSEUPDATE);
		query.setParameter("reply", reply);
		query.setParameter("modifiedBy", modifiedBy);
		query.setParameter("modifiedDate", modifiedDate);
		query.setParameter("seekResponseId", seekResponseId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl SeekResponseReplyUpdate", e);
		return 0;
	}
}

@Override
public Object[] DakSeekResponseAttachmentData(String dakattachmentid) throws Exception {
	logger.info(new Date() + "Inside DakSeekResponseAttachmentData");
	try {
		Query query = manager.createNativeQuery(DAKSEEKRESPONSEATTACHMENTDETAILS);
		query.setParameter("dakattachmentid", dakattachmentid);
		Object[] dakData = (Object[]) query.getSingleResult();
		return dakData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakSeekResponseAttachmentData", e);
		return null;
	}
}

@Override
public List<Object[]> getoldSeekResponseassignemplist(long dakId) throws Exception {
	logger.info(new Date() + "Inside getoldSeekResponseassignemplist");
	try {
		Query query = manager.createNativeQuery(OLDSEEKRESPONSEEMPID);
		query.setParameter("dakId", dakId);
		 List<Object[]> getoldSeekResponseassignemplist = (List<Object[]>) query.getResultList();
			return getoldSeekResponseassignemplist;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getoldSeekResponseassignemplist", e);
		return null;
	}
}

@Override
public List<Object[]> PrevMarkedEmployees(long dakId) throws Exception {
	logger.info(new Date() + "Inside PrevMarkedEmployees");
	try {
		Query query = manager.createNativeQuery(GETPREVMARKEDEMPS);
		query.setParameter("dakId", dakId);
		 List<Object[]> PrevMarkedEmployees = (List<Object[]>) query.getResultList();
			return PrevMarkedEmployees;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl PrevMarkedEmployees", e);
		return null;
	}
}

@Override
public long AddToFavourites(long dakMarkingId) throws Exception {
	logger.info(new Date() + "Inside AddToFavourites");
	try {
		Query query = manager.createNativeQuery(ADDTOFAVOURITES);
		query.setParameter("dakMarkingId", dakMarkingId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl AddToFavourites", e);
		return 0;
	}
}

@Override
public long RemoveFavourites(long dakMarkingId) throws Exception {
	logger.info(new Date() + "Inside RemoveFavourites");
	try {
		Query query = manager.createNativeQuery(REMOVEFROMFAVOURITES);
		query.setParameter("dakMarkingId", dakMarkingId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl RemoveFavourites", e);
		return 0;
	}
}

@Override
public List<Object[]> DakRepliedToMeList(String username, String fromDate, String toDate) throws Exception {
	logger.info(new Date() + "Inside DakRepliedToMeList");
	try {
		Query query = manager.createNativeQuery(DAKREPLIEDTOMELIST);
		query.setParameter("username", username);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		 List<Object[]> DakRepliedToMeList = (List<Object[]>) query.getResultList();
			return DakRepliedToMeList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakRepliedToMeList", e);
		return null;
	}
}

@Override
public List<Object[]> DakRepliedByMeList(long empId, String fromDate, String toDate, String lettertypeid, String priorityid, String sourcedetailid, String sourceId, String projectType, String projectId, String dakMemberTypeId, String employeeId) throws Exception {
	logger.info(new Date() + "Inside DakRepliedByMeList");
	try {
		Query query = manager.createNativeQuery(DAKREPLIEDBYMELIST);
		query.setParameter("empId", empId);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		query.setParameter("lettertypeid", lettertypeid);
		query.setParameter("priorityid", priorityid);
		query.setParameter("sourcedetailid", sourcedetailid);
		query.setParameter("sourceId", sourceId);
		query.setParameter("projectType", projectType);
		query.setParameter("projectId", projectId);
		query.setParameter("dakMemberTypeId", dakMemberTypeId);
		query.setParameter("employeeId", employeeId);
		 List<Object[]> DakRepliedByMeList = (List<Object[]>) query.getResultList();
			return DakRepliedByMeList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakRepliedByMeList", e);
		return null;
	}
}

@Override
public List<Object[]> getEmpListForSeekResponse(long dakId, String lab, long empId) throws Exception {
	logger.info(new Date() + "Inside DaoImpl getEmpListForSeekResponse()");
	try {
		Query query = manager.createNativeQuery(GETEMPLISTFORSEEKRESPONSE);
		//query.setParameter("dakId", dakId);
		query.setParameter("lab", lab);
		query.setParameter("empId",empId);
        List<Object[]> getEmpListForSeekResponse  = (List<Object[]>) query.getResultList();
		return getEmpListForSeekResponse ;

		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getEmpListForSeekResponse", e);
		return null;
	}
}


@Override
public Object[] getClosedByDetails(String closedBy) throws Exception {
	logger.info(new Date() + "Inside getClosedByDetails");
	try {
		Query query = manager.createNativeQuery(GETCLOSEDBYNAME);
		query.setParameter("closedBy", closedBy);
		Object[] getClosedByDetails = (Object[]) query.getSingleResult();
		return getClosedByDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getClosedByDetails", e);
		return null;
	}
}

@Override
public List<Object[]> EmpListDropDown(String lab) throws Exception {
	logger.info(new Date() + "Inside DaoImpl EmpListDropDown()");
	try {
		Query query = manager.createNativeQuery(EMPLOYEELISTDROPDOWN);
		query.setParameter("lab", lab);
        List<Object[]> EmpListDropDown  = (List<Object[]>) query.getResultList();
		return EmpListDropDown ;

		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EmpListDropDown", e);
		return null;
	}
}

@Override
public Object[] MarkedEmpCounts(String emp, String fromDate, String toDate, String username) throws Exception {
	logger.info(new Date() + "Inside MarkedEmpCounts");
	try {
		Query query = manager.createNativeQuery(MARKEDEMPCOUNTS);
		query.setParameter("emp", emp);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		query.setParameter("username", username);
		Object[] MarkedEmpCounts = (Object[]) query.getSingleResult();
		return MarkedEmpCounts;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl MarkedEmpCounts", e);
		return null;
	}
}

@Override
public Object[] AssignedEmpCounts(String emp, String fromDate, String toDate, String username) throws Exception {
	logger.info(new Date() + "Inside MarkedEmpCounts");
	try {
		Query query = manager.createNativeQuery(ASSIGNEDEMPCOUNTS);
		query.setParameter("emp", emp);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		query.setParameter("username", username);
		Object[] AssignedEmpCounts = (Object[]) query.getSingleResult();
		return AssignedEmpCounts;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl MarkedEmpCounts", e);
		return null;
	}
}


@Override
public Object[] dakReceivedViewrecived(long empId, long dakId) throws Exception {
	logger.info(new Date() + "Inside dakReceivedViewrecived");
	try {
		Query query = manager.createNativeQuery(DAKRECEIVEDVIEWRECEIVEDLIST);
		query.setParameter("empId", empId);
		query.setParameter("dakId", dakId);
		Object[] dakReceivedViewrecived = (Object[]) query.getSingleResult();
		return dakReceivedViewrecived;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl dakReceivedViewrecived", e);
		return null;
	}
}


@Override
public List<Object[]> AssignData(long dakId, long empId) throws Exception {
	logger.info(new Date() + "Inside DaoImpl AssignData()");
	try {
		Query query = manager.createNativeQuery(ASSIGNDATA);
		query.setParameter("dakId", dakId);
		query.setParameter("empId", empId);
        List<Object[]> AssignData  = (List<Object[]>) query.getResultList();
		return AssignData ;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl AssignData", e);
		return null;
	}
	}

@Override
public List<Object[]> SeekResponseData(long dakId, long empId) throws Exception {
	logger.info(new Date() + "Inside DaoImpl SeekResponseData()");
	try {
		Query query = manager.createNativeQuery(SEEKRESPONSEDATA);
		query.setParameter("dakId", dakId);
		query.setParameter("empId", empId);
        List<Object[]> SeekResponseData  = (List<Object[]>) query.getResultList();
		return SeekResponseData ;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl SeekResponseData", e);
		return null;
	}
}

@Override
public List<Object[]> MarkerData(long dakId, long empId) throws Exception {
	logger.info(new Date() + "Inside DaoImpl MarkerData()");
	try {
		Query query = manager.createNativeQuery(MARKERDATA);
		query.setParameter("dakId", dakId);
		query.setParameter("empId", empId);
        List<Object[]> MarkerData  = (List<Object[]>) query.getResultList();
		return MarkerData ;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl MarkerData", e);
		return null;
	}
}

@Override
public Object getDakAttachId(Long dakId, String type) throws Exception {
	logger.info(new Date() + "Inside getDakAttachId");
	try {
		Query query = manager.createNativeQuery(GETDAKATTACHID);
		query.setParameter("dakId", dakId);
		query.setParameter("type", type);
		Object labcode = query.getSingleResult();
		return labcode;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getDakAttachId", e);
		return null;
	}
}

@Override
public List<Object[]> getSeekResponseList(long markedEmpId, long dakId) throws Exception {
	logger.info(new Date() + "Inside getSeekResponseList");
	try {
		Query query = manager.createNativeQuery(SEEKRESPONSEEMPDETAIL);
		query.setParameter("markerEmpId", markedEmpId);
		query.setParameter("dakId", dakId);
		List<Object[]> getSeekResponseList = (List<Object[]>) query.getResultList();
		return getSeekResponseList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getSeekResponseList", e);
		return null;
	}
}

@Override
public List<Object[]> getFacilitatorSeekResponseList(long assignEmpId, long dakId) throws Exception {
	logger.info(new Date() + "Inside getFacilitatorSeekResponseList");
	try {
		Query query = manager.createNativeQuery(FACILITATORSEEKRESPONSEEMPDETAIL);
		query.setParameter("assignEmpId", assignEmpId);
		query.setParameter("dakId", dakId);
		List<Object[]> getFacilitatorSeekResponseList = (List<Object[]>) query.getResultList();
		return getFacilitatorSeekResponseList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getFacilitatorSeekResponseList", e);
		return null;
	}
}

@Override
public List<Object[]> getRemindEmployeeList(long dakId) throws Exception {
	logger.info(new Date() + "Inside getRemindEmployeeList");
	try {
		Query query = manager.createNativeQuery(GETREMINDEMPLOYEELIST);
		query.setParameter("dakId", dakId);
		List<Object[]> getRemindEmployeeList = (List<Object[]>) query.getResultList();
		return getRemindEmployeeList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getRemindEmployeeList", e);
		return null;
	}
}


@Override
public long InsertDakRemind(DakRemind modal) throws Exception {
	logger.info(new Date() + "Inside DAO InsertDakRemind");
	try {
		manager.persist(modal);
		manager.flush();
		return modal.getRemindId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl InsertDakRemind", e);
		return 0;
	}
}

@Override
public List<Object[]> getRemindToDetailsList(long dakId, long empId) throws Exception {
	logger.info(new Date() + "Inside getRemindToDetailsList");
	try {
		Query query = manager.createNativeQuery(GETREMINDTODETAILSLIST);
		query.setParameter("dakId", dakId);
		query.setParameter("empId", empId);
		List<Object[]> getRemindToDetailsList = (List<Object[]>) query.getResultList();
		return getRemindToDetailsList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getRemindToDetailsList", e);
		return null;
	}
}

@Override
public List<Object[]> getPerticularRemindToDetails(long dakId, long empId) throws Exception {
	logger.info(new Date() + "Inside getPerticularRemindToDetails");
	try {
		Query query = manager.createNativeQuery(GETPERTICULARREMINDTODETAILSLIST);
		query.setParameter("dakId", dakId);
		query.setParameter("empId", empId);
		List<Object[]> getPerticularRemindToDetails = (List<Object[]>) query.getResultList();
		return getPerticularRemindToDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getPerticularRemindToDetails", e);
		return null;
	}
}

@Override
public long UpdateDakRemind(String reply, long dakId, long empId, String replyDate) throws Exception {
	logger.info(new Date() + "Inside UpdateDakRemind");
	try {
		Query query = manager.createNativeQuery(UPDATEDAKREMIND);
		query.setParameter("reply", reply);
		query.setParameter("dakId", dakId);
		query.setParameter("empId", empId);
		query.setParameter("replyDate", replyDate);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl UpdateDakRemind", e);
		return 0;
	}
}

@Override
public Object[] EnoteAssignReplyData(long dakId,long EmpId) throws Exception {
	logger.info(new Date() + "Inside EnoteAssignReplyData");
	try {
		Query query = manager.createNativeQuery(ENOTEASSIGNREPLYDATA);
		query.setParameter("EmpId", EmpId);
		query.setParameter("dakId", dakId);
		Object[] EnoteAssignReplyData = (Object[]) query.getSingleResult();
		return EnoteAssignReplyData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnoteAssignReplyData", e);
		return null;
	}
}

@Override
public List<Object[]> EnoteAssignReplyAttachmentData(long dakId) throws Exception {
	logger.info(new Date() + "Inside EnoteAssignReplyAttachmentData");
	try {
		Query query = manager.createNativeQuery(DAKENOTEREPLYATTACHMENTDATA);
		query.setParameter("dakId", dakId);
		List<Object[]> EnoteAssignReplyAttachmentData = (List<Object[]>) query.getResultList();
		return EnoteAssignReplyAttachmentData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnoteAssignReplyAttachmentData", e);
		return null;
	}
}

@Override
public List<Object[]> InitiatedByEmployeeList(long divisionId, String lab) throws Exception {
	try {
		Query query=manager.createNativeQuery(INITIATEDBYEMPLOYEELIST);
		query.setParameter("divisionId", divisionId);
		query.setParameter("lab", lab);
		return (List<Object[]>)query.getResultList();
	} catch (Exception e) {
		e.printStackTrace();

		return null;
	}
}

@Override
public Object getDivisionId(long empId) throws Exception {
	try {
		Query query = manager.createNativeQuery(GETDIVISIONID);
		query.setParameter("empId", empId);
		Object divisionId = query.getSingleResult();
		return divisionId;
	} catch (Exception e) {
		e.printStackTrace();

		return null;
	}
}

@Override
public Object[] EnoteMarkerReplyData(long dakId, long empId) throws Exception {
	logger.info(new Date() + "Inside EnoteMarkerReplyData");
	try {
		Query query = manager.createNativeQuery(ENOTEMARKERREPLYDATA);
		query.setParameter("empId", empId);
		query.setParameter("dakId", dakId);
		Object[] EnoteMarkerReplyData = (Object[]) query.getSingleResult();
		return EnoteMarkerReplyData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnoteMarkerReplyData", e);
		return null;
	}
}

@Override
public List<Object[]> EnoteMarkerReplyAttachmentData(long dakReplyId) throws Exception {
	logger.info(new Date() + "Inside EnoteMarkerReplyAttachmentData");
	try {
		Query query = manager.createNativeQuery(DAKMARKERENOTEREPLYATTACHMENTDATA);
		query.setParameter("dakReplyId", dakReplyId);
		List<Object[]> EnoteMarkerReplyAttachmentData = (List<Object[]>) query.getResultList();
		return EnoteMarkerReplyAttachmentData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnoteMarkerReplyAttachmentData", e);
		return null;
	}
}

@Override
public Object[] MailSentDetails(String TypeOfHost) throws Exception {
	logger.info(new Date() + "Inside MailSentDetails");
	try {
		Query query = manager.createNativeQuery(MAILSENTDETAILS);
		query.setParameter("TypeOfHost", TypeOfHost);
		Object[] MailSentDetails = (Object[]) query.getSingleResult();
		return MailSentDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl MailSentDetails", e);
		return null;
	}
}

@Override
public List<Object[]> MailReceivedEmpDetails(long empId,String HostType) throws Exception {
	logger.info(new Date() + "Inside MailReceivedEmpDetails");
	try {
		List<Object[]> MailReceivedEmpDetails=null;
		if(HostType!=null && HostType.equalsIgnoreCase("D")) {
		Query query = manager.createNativeQuery(DRONAMAILRECEIVEDDETAILS);
		query.setParameter("empId", empId);
		MailReceivedEmpDetails = (List<Object[]>) query.getResultList();
		return MailReceivedEmpDetails;
		}else {
			Query query = manager.createNativeQuery(LABMAILRECEIVEDDETAILS);
			query.setParameter("empId", empId);
			MailReceivedEmpDetails = (List<Object[]>) query.getResultList();
			return MailReceivedEmpDetails;
		}
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl MailReceivedEmpDetails", e);
		return null;
	}
}

@Override
public Object getEmpName(long empId) throws Exception {
	try {
		Query query = manager.createNativeQuery(GETEMPNAME);
		query.setParameter("empId", empId);
		Object getEmpName = query.getSingleResult();
		return getEmpName;
	} catch (Exception e) {
		e.printStackTrace();

		return null;
	}
}

@Override
public Object[] getDronaMailDetails(String typeOfHost) throws Exception {
	logger.info(new Date() + "Inside getDronaMailDetails");
	try {
		Query query = manager.createNativeQuery(GETDRONAMAILDETAILS);
		query.setParameter("typeOfHost", typeOfHost);
		Object[] getDronaMailDetails = (Object[]) query.getSingleResult();
		return getDronaMailDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getDronaMailDetails", e);
		return null;
	}
}

@Override
public List<Object[]> AttachmentsFilePath(long dakReplyAddResult) throws Exception {
	logger.info(new Date() + "Inside AttachmentsFilePath");
	try {
		Query query = manager.createNativeQuery(ATTACHMENTSFILEPATH);
		query.setParameter("dakReplyAddResult", dakReplyAddResult);
		List<Object[]> AttachmentsFilePath = (List<Object[]>) query.getResultList();
		return AttachmentsFilePath;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl AttachmentsFilePath", e);
		return null;
	}
}

private static final String DAKCREATECOUNTFORDAKNOGENERATION="SELECT COUNT(*) FROM dak_c WHERE DATE(CreatedDate) = CURDATE();";
@Override
public long DakCreateCountFrDakNoCreation() throws Exception {
	logger.info(new Date() + "Inside DakCreateCountFrDakNoCreation");
	try {
		Query query = manager.createNativeQuery(DAKCREATECOUNTFORDAKNOGENERATION);
		BigInteger DakCreateCountFrDakNoCreation = (BigInteger) query.getSingleResult();
		return DakCreateCountFrDakNoCreation.longValue();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakCreateCountFrDakNoCreation", e);
		return 0;
	}
}


@Override
public long insertDakCreate(DakCreate dak) throws Exception {
	logger.info(new Date() + "Inside DAO insertDakCreate");
	try {
		manager.persist(dak);
		manager.flush();
		return dak.getDakCreateId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl insertDakCreate", e);
		return 0;
	}
}


private static final String DAKCREATEATTACHMENTDATA="SELECT DakCreateId, filepath,DakCreateAttachmentId,filename  FROM dak_c_attachment WHERE DakCreateId=:dakCreateId AND ismain=:type";
@Override
public List<Object[]> GetDakCreateAttachmentDetails(Long dakCreateId, String type) throws Exception {
	logger.info(new Date() + "Inside GetDakCreateAttachmentDetails");
	try {
		Query query = manager.createNativeQuery(DAKCREATEATTACHMENTDATA);
		query.setParameter("dakCreateId", dakCreateId);
		query.setParameter("type", type);
		List<Object[]> GetDakCreateAttachmentDetails = (List<Object[]>) query.getResultList();
		return GetDakCreateAttachmentDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetDakCreateAttachmentDetails", e);
		return null;
	}
}

@Override
public long DakCreateAttachmentFile(DakCreateAttach model) throws Exception {
	logger.info(new Date() + "Inside DAO DakCreateAttachmentFile");
	try {
		manager.persist(model);
		manager.flush();
		return model.getDakCreateAttachmentId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakCreateAttachmentFile", e);
		return 0;
	}
}

@Override
public long insertDakDestination(DakCreateDestination destination) throws Exception {
	logger.info(new Date() + "Inside DAO DakCreateAttachmentFile");
	try {
		manager.persist(destination);
		manager.flush();
		return destination.getDakCreateDestinationId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakCreateAttachmentFile", e);
		return 0;
	}
}


private static final String GETLABDAKDATA="SELECT a.DakNo,a.LabCode FROM dak a WHERE a.DakId=:result";
@Override
public Object[] labDakData(long result) throws Exception {
	logger.info(new Date() + "Inside labDakData");
	try {
		Query query = manager.createNativeQuery(GETLABDAKDATA);
		query.setParameter("result", result);
		Object[] labDakData = (Object[]) query.getSingleResult();
		return labDakData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl labDakData", e);
		return null;
	}
}


private static final String DAKCREATIONLIST="SELECT a.DakCreateId,a.DakNo,a.RefNo,a.RefDate,a.Subject,a.ActionDueDate,a.DakStatus,a.IsSave FROM dak_c a WHERE a.ReceiptDate BETWEEN :fromDate AND :toDate AND a.IsSave='N' ORDER BY a.DakCreateId DESC";
@Override
public List<Object[]> dakCreationList(String fromDate,String toDate) throws Exception {
	logger.info(new Date()+"Inside the dakCreationList()");
	try {
		Query query=manager.createNativeQuery(DAKCREATIONLIST);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		return (List<Object[]>)query.getResultList();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside the dakCreationList()",e);
		return null;
	}
}


private static final String DAKDESTINATIONDETAILSLIST="SELECT a.DakCreateId,a.DakNo,a.Subject,c.SourceShortName,c.ApiUrl,a.RefNo,b.Reply,b.ReplyStatus FROM dak_c a,dak_c_destination b,dak_source_details c WHERE c.SourceDetailId=b.DestinationTypeId AND a.DakCreateId=b.DakCreateId AND a.DakCreateId=:dakCreateId and b.IsActive='1'";
@Override
public List<Object[]> DakDestinationDetailsList(long dakCreateId) throws Exception {
	logger.info(new Date()+"Inside the DakDestinationDetailsList()");
	try {
		Query query=manager.createNativeQuery(DAKDESTINATIONDETAILSLIST);
		query.setParameter("dakCreateId", dakCreateId);
		return (List<Object[]>)query.getResultList();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside the DakDestinationDetailsList()",e);
		return null;
	}
}


@Override
public DakCreate findByDakCreateId(long dakCreateId) throws Exception {
	logger.info(new Date() + "Inside findByDakCreateId");
	try {
		DakCreate dakdata = manager.find(DakCreate.class, dakCreateId);
		return dakdata;
	} catch (Exception e) {
		
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl findByDakCreateId", e);
		return null;
	}
}


private static final String SELDESTINATIONTYPELIST="SELECT DestinationTypeId,DakCreateId FROM dak_c_destination WHERE DakCreateId=:dakCreateId AND IsActive='1'";
@Override
public List<Object[]> selDestinationTypeList(long dakCreateId) throws Exception {
	logger.info(new Date()+"Inside the selDestinationTypeList()");
	try {
		Query query=manager.createNativeQuery(SELDESTINATIONTYPELIST);
		query.setParameter("dakCreateId", dakCreateId);
		return (List<Object[]>)query.getResultList();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside the selDestinationTypeList()",e);
		return null;
	}
}


@Override
public long getDakCreateLinkDetails(DakCreateLink link) throws Exception {
	logger.info(new Date() + "Inside getDakCreateLinkDetails");
	try {
		manager.persist(link);
		manager.flush();
		return link.getDakCreateLinkId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getDakCreateLinkDetails", e);
		return 0;
	}
}


private static final String DAKCREATELINKLIST="SELECT a.DakCreateId,a.DakNo,a.subject FROM dak_c a ORDER BY a.DakCreateId DESC";
@Override
public List<Object[]> DakCreateLinkList() throws Exception {
	logger.info(new Date() + "Inside DakCreateLinkList");
	try {
		Query query = manager.createNativeQuery(DAKCREATELINKLIST);
		List<Object[]> DakCreateLinkList = (List<Object[]>) query.getResultList();
		return DakCreateLinkList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakCreateLinkList", e);
		return null;
	}
}

private static final String DAKCREATELINKDATA="SELECT DakCreateId,LinkDakCreateId FROM dak_c_daklink WHERE DakCreateId=:dakCreateId";
@Override
public List<Object[]> dakCreateLinkData(long dakCreateId) throws Exception {
	logger.info(new Date() + "Inside dakCreateLinkData");
	try {
		Query query = manager.createNativeQuery(DAKCREATELINKDATA);
		query.setParameter("dakCreateId", dakCreateId);
		List<Object[]> dakCreateLinkData = (List<Object[]>) query.getResultList();
		return dakCreateLinkData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl dakCreateLinkData", e);
		return null;
	}
}


private static final String DAKCREATEATTACHMENTDETAILS="SELECT filepath, filename , DakCreateId FROM dak_c_attachment WHERE DakCreateAttachmentId=:dakattachmentid";
@Override
public Object[] dakCreateattachmentdata(String dakattachmentid) throws Exception {
	logger.info(new Date() + "Inside dakCreateattachmentdata");
	try {
		Query query = manager.createNativeQuery(DAKCREATEATTACHMENTDETAILS);
		query.setParameter("dakattachmentid", dakattachmentid);
		Object[] dakData = (Object[]) query.getSingleResult();
		return dakData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl dakCreateattachmentdata", e);
		return null;
	}
}


private static final String DELETEDAKCREATEATTACHMENT="DELETE FROM dak_c_attachment WHERE DakCreateAttachmentId=:dakattachmentid";
@Override
public int DeleteDakCreateAttachment(String dakattachmentid) throws Exception {
	logger.info(new Date() + "Inside DeleteDakCreateAttachment");
	try {
		Query query = manager.createNativeQuery(DELETEDAKCREATEATTACHMENT);
		query.setParameter("dakattachmentid", dakattachmentid);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DeleteDakCreateAttachment", e);
		return 0;
	}
}


private static final String DELETEDAKCREATELINK="DELETE FROM dak_c_daklink WHERE DakCreateId=:dakCreateId";
@Override
public int DeletedDakCreateLink(Long dakCreateId) throws Exception {
	logger.info(new Date() + "Inside DeletedDakCreateLink");
	try {
		Query query = manager.createNativeQuery(DELETEDAKCREATELINK);
		query.setParameter("dakCreateId", dakCreateId);
		int result = query.executeUpdate();
		return result;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DeletedDakCreateLink", e);
		return 0;
	}
}

@Override
public long saveDakCreate(DakCreate dakdata) throws Exception {
	logger.info(new Date() + "Inside DAO saveDakCreate");
	try {
		manager.merge(dakdata);
		return dakdata.getDakCreateId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl saveDakCreate", e);
		return 0;
	}
}


private static final String UPDATEISACTIVESELDESTINATION="UPDATE dak_c_destination SET IsActive=:isActive WHERE DakCreateId=:result AND DestinationTypeId=:destinationTypeId";
@Override
public long updateIsActiveselDestination(long result, long destinationTypeId,int isActive) throws Exception {
	logger.info(new Date() + "Inside updateIsActiveselDestination");
	try {
		Query query = manager.createNativeQuery(UPDATEISACTIVESELDESTINATION);
		query.setParameter("result", result);
		query.setParameter("destinationTypeId", destinationTypeId);
		query.setParameter("isActive", isActive);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl updateIsActiveselDestination", e);
		return 0;
	}
}


private static final String DAKCREATIONPENDINGLIST="SELECT a.DakCreateId,a.DakNo,a.RefNo,a.RefDate,a.Subject,a.ActionDueDate,a.DakStatus,a.IsSave FROM dak_c a WHERE a.IsSave='Y' ORDER BY a.DakCreateId DESC";
@Override
public List<Object[]> dakCreationPendingList() throws Exception {
	logger.info(new Date()+"Inside the dakCreationList()");
	try {
		Query query=manager.createNativeQuery(DAKCREATIONPENDINGLIST);
		return (List<Object[]>)query.getResultList();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside the dakCreationList()",e);
		return null;
	}
}



private static final String DAKASSIGNUPDATE="UPDATE dak_assign SET IsActive=:IsActive,Remarks=:Remarks WHERE DakId=:dakIdAssignDelete AND EmpId=:empIdAssignDelete";
@Override
public long DakAssignUpdate(String empIdAssignDelete, String dakIdAssignDelete,int IsActive,String Remarks) throws Exception {
	logger.info(new Date() + "Inside DakAssignUpdate");
	try {
		Query query = manager.createNativeQuery(DAKASSIGNUPDATE);
		query.setParameter("empIdAssignDelete", empIdAssignDelete);
		query.setParameter("dakIdAssignDelete", dakIdAssignDelete);
		query.setParameter("IsActive", IsActive);
		query.setParameter("Remarks", Remarks);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakAssignUpdate", e);
		return 0;
	}
}


private static final String OLDASSIGNEMPCOUNT="SELECT COUNT(EmpId) FROM dak_assign WHERE DakId=:dakId AND EmpId=:EmpId";
@Override
public long oldAssignEmpCount(long EmpId, Long dakId) throws Exception {
	logger.info(new Date() + "Inside DAO oldAssignEmpCount");
	try {
		Query query = manager.createNativeQuery(OLDASSIGNEMPCOUNT);
		query.setParameter("EmpId", EmpId);
		query.setParameter("dakId", dakId);
		BigInteger result = (BigInteger) query.getSingleResult();
	    return result.longValue();
		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl oldAssignEmpCount", e);
		return 0;
	}
}


private static final String DAKLISTFORTRACK="SELECT a.DakCreateId,a.DestinationId,b.SourceName FROM dak_c a,dak_source b WHERE a.DestinationId=b.SourceId AND a.ReceiptDate BETWEEN :fromDate AND :toDate AND a.IsSave='N'";
@Override
public List<Object[]> dakListForTrack(String fromDate, String toDate) throws Exception {
	logger.info(new Date()+"Inside the dakListForTrack()");
	try {
		Query query=manager.createNativeQuery(DAKLISTFORTRACK);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		return (List<Object[]>)query.getResultList();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside the dakListForTrack()",e);
		return null;
	}
}



private static final String GETDAKDATAFORSHOW="SELECT a.DakId,a.DakNo,a.RefNo,a.RefDate,b.PriorityName,c.SourceShortName,c.SourceName,a.Subject,a.ReceiptDate,a.ActionId,a.ActionDueDate,a.ActionTime,d.DakStatus,d.StatusDesc,a.SourceLabCode FROM dak a,dak_priority b,dak_source_details c,dak_status d WHERE a.PriorityId=b.PriorityId AND a.SourceDetailId=c.SourceDetailId AND a.DakStatus=d.DakStatus AND a.DakCreateId=:dakCreateId AND a.SourceLabCode=:labCode";
@Override
public Object[] getDakDataforShow(Long dakCreateId,String labCode) throws Exception {
	logger.info(new Date() + "Inside getDakDataforShow");
	try {
		Query query = manager.createNativeQuery(GETDAKDATAFORSHOW);
		query.setParameter("dakCreateId", dakCreateId);
		query.setParameter("labCode", labCode);
		Object[] getDakDataforShow = (Object[]) query.getSingleResult();
		return getDakDataforShow;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getDakDataforShow", e);
		return null;
	}
}



private static final String UPDATELABREPLY="UPDATE dak_c_destination SET Reply=:reply,ReplyStatus='Y',ModifiedBy=:modifiedBy,ModifiedDate=:modifiedDate WHERE DakCreateId=:seldakCreateId AND DestinationTypeId=:seldestinationId";
@Override
public long updateLabReply(Long seldakCreateId, Long seldestinationId, String reply,String modifiedBy,String modifiedDate) throws Exception {
	logger.info(new Date() + "Inside updateLabReply");
	try {
		Query query = manager.createNativeQuery(UPDATELABREPLY);
		query.setParameter("seldakCreateId", seldakCreateId);
		query.setParameter("seldestinationId", seldestinationId);
		query.setParameter("reply", reply);
		query.setParameter("modifiedBy", modifiedBy);
		query.setParameter("modifiedDate", modifiedDate);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl updateLabReply", e);
		return 0;
	}
}



private static final String SOURCEDETAILDATA="SELECT a.SourceDetailId,a.SourceId,a.SourceShortName,a.SourceName FROM dak_source_details a WHERE a.SourceShortName=:labCode";
@Override
public Object[] SourceDetailData(String labCode) throws Exception {
	logger.info(new Date() + "Inside SourceDetailData");
	try {
		Query query = manager.createNativeQuery(SOURCEDETAILDATA);
		query.setParameter("labCode", labCode);
		Object[] SourceDetailData = (Object[]) query.getSingleResult();
		return SourceDetailData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl SourceDetailData", e);
		return null;
	}
}



private static final String SELECTEDNEWDAKEMPLOYEES="SELECT a.DakId,a.EmpId,a.DakMarkingId FROM dak_marking a,dak b WHERE a.DakId=b.DakId AND b.DakCreateId=:dakCreateId AND b.SourceLabCode=:labCode";
@Override
public List<Object[]> selectedNewDakEmployees(long dakCreateId,String labCode) throws Exception {
	logger.info(new Date()+"Inside the selectedNewDakEmployees()");
	try {
		Query query=manager.createNativeQuery(SELECTEDNEWDAKEMPLOYEES);
		query.setParameter("dakCreateId", dakCreateId);
		query.setParameter("labCode", labCode);
		return (List<Object[]>)query.getResultList();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside the selectedNewDakEmployees()",e);
		return null;
	}
}
}
