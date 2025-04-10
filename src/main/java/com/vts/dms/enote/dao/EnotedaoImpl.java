package com.vts.dms.enote.dao;

import java.util.Date;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.dms.enote.model.DakEnoteReply;
import com.vts.dms.enote.model.DakEnoteReplyAttach;
import com.vts.dms.enote.model.DakLetterDoc;
import com.vts.dms.enote.model.Enote;
import com.vts.dms.enote.model.EnoteAttachment;
import com.vts.dms.enote.model.EnoteFlow;
import com.vts.dms.enote.model.EnoteRosoModel;
import com.vts.dms.enote.model.EnoteTransaction;


@Transactional
@Repository
public class EnotedaoImpl implements Enotedao{

	private static final Logger logger=LogManager.getLogger(EnotedaoImpl.class);
	
	private static final String ENOTECOUNTFORIDGENERATION="SELECT COUNT(*) FROM dak_enote WHERE DATE(CreatedDate) = CURDATE()";
	private static final String ENOTEATTACHMENTDATA="SELECT EnoteId, filepath,Enoteattachmentid,filename  FROM dak_enote_attach WHERE EnoteId=:enoteId";
	private static final String ENOTEPREVIEWDETAILS="SELECT a.EnoteId,a.NoteId, a.NoteNo,a.RefNo, a.RefDate,a.subject,a.comment,a.Recommend1, a.Recommend2,a.Recommend3,a.Recommend4,a.Recommend5,a.ApprovingOfficer,b.EnoteStatus,a.Enotetype,a.InitiatedBy,a.ExternalOfficer,a.Rec1_Role,a.Rec2_Role,a.Rec3_Role,a.Rec4_Role,a.Rec5_Role,a.External_Role,a.Approving_Role,a.LabCode,a.EnoteStatusCodeNext,a.EnoteStatusCode,a.CreatedBy,(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname), ', '), ''), d.Designation)  FROM employee e, employee_desig d  WHERE a.InitiatedBy = e.EmpId AND e.DesigId = d.DesigId AND e.IsActive = 1) AS 'IntiatedBy',(CASE  WHEN a.InitiatedBy = c.InitiatingEmpId THEN c.EnoteRoSoId END) AS 'EnoteRoSoId',a.IsDraft FROM  dak_enote a JOIN  dak_enote_status b ON a.EnoteStatusCode = b.EnoteStatusCode LEFT JOIN dak_enote_roso c ON a.InitiatedBy = c.InitiatingEmpId WHERE  a.EnoteId =:result";
	private static final String GETLABCODE = "SELECT labcode FROM employee WHERE empid=:empId";
	private static final String INITIATEDBYEMPLOYEELIST="SELECT a.EmpId,a.EmpName,b.Designation,a.EmpNo FROM employee a,employee_desig b WHERE a.labcode=:lab AND a.IsActive=1 AND a.DesigId=b.DesigId AND a.DivisionId=:divid ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC ";
	private static final String RECOMMENDINGOFFICERLIST="SELECT a.EmpId,a.EmpName,b.Designation,a.EmpNo FROM employee a,employee_desig b WHERE a.labcode=:lab AND a.IsActive=1 AND a.DesigId=b.DesigId ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC ";
	private static final String ENOTELIST="SELECT a.EnoteId,a.NoteId,a.NoteNo,a.RefNo,a.RefDate,a.SUBJECT,d.EnoteStatus,d.EnoteStatusColor,d.EnoteStatusCode,a.DakId,a.DakReplyId,a.DakNo,a.Reply,a.IsDak,a.LetterNo FROM dak_enote  a,dak_enote_status d  WHERE a.EnoteStatusCode=d.EnoteStatusCode AND (CASE WHEN a.InitiatedBy=:EmpId THEN 1=1 ELSE a.CreatedBy=:Username END) AND RefDate BETWEEN :fromDate AND :toDate ORDER BY EnoteId DESC";
	private static final String UPDATEENOTESTATUS="UPDATE dak_enote SET EnoteStatus='F' WHERE EnoteId=:eNoteId";
	private static final String ATTACHMENTCOUNT="SELECT COUNT(m.FileName) FROM dak_enote_attach m,dak_enote b WHERE m.EnoteId = b.EnoteId AND b.EnoteId=:enoteId";
	private static final String ENOTEATTACHMENTDETAILS="SELECT filepath, filename , EnoteId from dak_enote_attach WHERE EnoteAttachmentId=:eNoteAttachId";
	private static final String PARTICULARENOTEATTACHDATA="SELECT FilePath,FileName,EnoteAttachmentId,EnoteId,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate FROM dak_enote_attach WHERE EnoteAttachmentId=:enoteAttachId AND EnoteId=:enoteId";
	private static final String DELETEENOTEATTACHMENT="DELETE FROM dak_enote_attach WHERE EnoteAttachmentId=:enoteAttachId";
	private static final String RECOMMENDINGDETAILS="SELECT(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend1=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND e.LabCode=:lab) AS 'Recommend1',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend2=e.EmpId AND  e.DesigId=d.DesigId AND e.IsActive=1 AND e.LabCode=:lab) AS 'Recommend2',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend3=e.EmpId AND  e.DesigId=d.DesigId AND e.IsActive=1 AND e.LabCode=:lab) AS 'Recommend3',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend4=e.EmpId AND  e.DesigId=d.DesigId AND e.IsActive=1 AND e.LabCode=:lab) AS 'Recommend4',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend5=e.EmpId AND  e.DesigId=d.DesigId AND e.IsActive=1 AND e.LabCode=:lab) AS 'Recommend5',(CASE WHEN a.LabCode='@EXP' THEN (SELECT CONCAT(IFNULL(CONCAT(TRIM(e.expertname), ', '), ''), d.Designation) FROM expert e,employee_desig d WHERE a.ExternalOfficer=e.ExpertId AND e.desigId=d.desigid ) ELSE (SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.ExternalOfficer=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND a.LabCode=e.LabCode) END) AS 'External',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.ApprovingOfficer=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND e.LabCode=:lab) AS 'ApprovingOfficer',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.InitiatedBy=e.EmpId AND  e.DesigId=d.DesigId AND e.IsActive=1 AND e.LabCode=:lab) AS 'IntiatedBy',a.Rec1_Role,a.Rec2_Role,a.Rec3_Role,a.Rec4_Role,a.Rec5_Role,a.External_Role,a.Approving_Role FROM dak_enote a WHERE a.EnoteId=:enoteId";
	private static final String ENOTEPENDINGLIST="CALL Dms_DakEnote_PendingList(:EmpId)";
	private static final String ENOTEAPPROVALLIST="SELECT a.EnoteId,a.NoteId,a.NoteNo,a.RefNo,a.RefDate,a.Subject,a.Comment,a.InitiatedBy,c.ActionDate,d.EnoteStatus,d.EnoteStatusColor,d.EnoteStatusCode,a.DakId,a.DakReplyId,a.DakNo,a.Reply,a.IsDak FROM dak_enote a,employee b,dak_enote_trans c,dak_enote_status d WHERE a.InitiatedBy=b.EmpId AND a.EnoteStatusCode=d.EnoteStatusCode AND a.EnoteId=c.EnoteId AND c.EnoteStatusCode IN ('RC1','RC2','RC3','RC4','RC5','EXT','APR') AND c.ActionBy=:EmpId AND DATE(a.CreatedDate) BETWEEN :fromDate AND :toDate ORDER BY a.EnoteId DESC ";
	private static final String ENOTETRANSACTIONLIST="SELECT tra.EnoteTransId,emp.EmpId,emp.EmpName,des.Designation,tra.ActionDate,tra.Remarks,sta.EnoteStatus,sta.EnoteStatusColor FROM dak_enote_trans tra,dak_enote_status sta,employee emp,employee_desig des,dak_enote e WHERE e.EnoteId = tra.EnoteId AND tra.EnoteStatusCode = sta.EnoteStatusCode AND tra.ActionBy=emp.EmpId AND emp.DesigId = des.DesigId AND e.EnoteId=:enoteTrackId ORDER BY tra.ActionDate";
	private static final String ENOTEPRINTDATA="SELECT a.EnoteId,a.NoteId,a.NoteNo,a.RefNo,a.RefDate,a.subject,a.comment,a.Recommend1,a.Recommend2,a.Recommend3,a.Recommend4,a.Recommend5,a.ApprovingOfficer,b.EnoteStatus,a.DakId,a.DakReplyId,a.DakNo,a.Reply,a.IsDak,a.EnoteFrom FROM dak_enote a,dak_enote_status b WHERE a.EnoteStatusCode=b.EnoteStatusCode AND EnoteId=:enotePrintId";
	private static final String ENOTEPRINTDETAILS="SELECT MAX(tra.EnoteTransId) AS EnoteTransId,(SELECT empId FROM dak_enote_trans t, employee e WHERE e.empid = t.Actionby AND t.EnoteStatusCode = sta.EnoteStatusCode  AND t.EnoteId = par.EnoteId ORDER BY t.EnoteTransId DESC LIMIT 1) AS empid,(SELECT empname FROM dak_enote_trans t, employee e WHERE e.empid = t.Actionby AND t.EnoteStatusCode = sta.EnoteStatusCode AND t.EnoteId = par.EnoteId ORDER BY t.EnoteTransId DESC LIMIT 1) AS empname,(SELECT designation FROM dak_enote_trans t, employee e, employee_desig des WHERE e.empid = t.Actionby AND e.desigid = des.desigid AND t.EnoteStatusCode = sta.EnoteStatusCode AND t.EnoteId = par.EnoteId ORDER BY t.EnoteTransId DESC LIMIT 1) AS designation,MAX(tra.ActionDate) AS ActionDate,(SELECT t.Remarks FROM dak_enote_trans t, employee e WHERE e.empid = t.Actionby AND t.EnoteStatusCode = sta.EnoteStatusCode AND t.EnoteId = par.EnoteId ORDER BY t.EnoteTransId DESC LIMIT 1) AS Remarks,MAX(sta.EnoteStatus) AS EnoteStatus,MAX(sta.EnoteStatusColor) AS EnoteStatusColor,sta.EnoteStatusCode,MAX(tra.Role) AS ROLE,MAX(par.InitiatedBy) AS InitiatedBy FROM  dak_enote_trans tra INNER JOIN dak_enote_status sta ON tra.EnoteStatusCode = sta.EnoteStatusCode INNER JOIN employee emp ON tra.Actionby = emp.EmpId INNER JOIN dak_enote par ON par.EnoteId = tra.EnoteId WHERE sta.EnoteStatusCode IN ('FWD', 'RFD', 'RC1', 'RC2', 'RC3', 'RC4', 'RC5', 'EXT', 'APR') AND par.EnoteId =:enoteId GROUP BY tra.EnoteStatusCode ORDER BY  ActionDate ASC";
	private static final String ENOTEROSOLIST="CALL Dms_DakEnoteRoSoList(:lab)";
	private static final String EMPLOYEELISTFORENOTEROSO="SELECT e.EmpId,e.EmpName,e.EmpNo,d.Designation FROM employee e,employee_desig d WHERE e.DesigId=d.DesigId AND e.IsActive='1' AND e.LabCode=:lab ORDER BY CASE WHEN e.Srno = 0 THEN 1 ELSE 0 END, e.Srno ASC";
	private static final String INITIATEDEMPLIST="SELECT e.EmpId,e.EmpName,e.EmpNo,d.Designation FROM employee e,employee_desig d WHERE e.DesigId=d.DesigId AND e.IsActive='1' AND e.EmpId NOT IN (SELECT c.InitiatingEmpId FROM dak_enote_roso c WHERE e.EmpId=c.InitiatingEmpId) AND e.LabCode=:lab ORDER BY CASE WHEN e.Srno = 0 THEN 1 ELSE 0 END, e.Srno ASC";
	private static final String ENOTEROSODETAILS="CALL Dms_DakEnoteRoSoDetails(:enoteRoSoId,:lab)";
	private static final String ENOTEROSOROLEDETAILS="SELECT a.InitiatingEmpId,a.RO1,a.RO1_Role,a.RO2,a.RO2_Role,a.RO3,a.RO3_Role,a.RO4,a.RO4_Role,a.RO5,a.RO5_Role,a.ExternalOfficer,a.ExternalOfficer_Role,a.ApprovingOfficer,a.Approving_Role,a.External_LabCode FROM dak_enote_roso a,dak_enote b WHERE a.InitiatingEmpId=b.InitiatedBy AND b.EnoteId=:enoteId";
	private static final String LABLIST="SELECT LabId, ClusterId, LabCode FROM cluster_lab WHERE LabCode NOT IN (:lab)";
	private static final String EXPERTEMPLOYEELIST="SELECT e.expertid,CONCAT(IFNULL(CONCAT(e.title,' '),''),e.expertname) AS 'expertname' ,e.expertno,'Expert' AS designation FROM expert e WHERE e.isactive=1";
	private static final String GETEXTERNALLABCODEDATA="SELECT ExternalOfficer,ExternalOfficer_Role,External_LabCode FROM dak_enote_roso WHERE EnoteRoSoId=:enoteRoSoId";
	private static final String EXTERNALNAMEDATA="SELECT (CASE WHEN a.LabCode='@EXP' THEN (SELECT CONCAT(IFNULL(CONCAT(TRIM(e.expertname), ', '), ''), d.Designation) AS 'Employee' FROM expert e,employee_desig d WHERE a.ExternalOfficer=e.ExpertId AND e.desigId=d.desigid AND e.IsActive=1 AND a.LabCode='@EXP') ELSE (SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname), ', '), ''), d.Designation) AS 'Employee' FROM employee e,employee_desig d WHERE a.ExternalOfficer=e.EmpId AND e.desigId=d.desigid AND e.IsActive=1 AND e.LabCode=a.LabCode) END) AS 'External',a.External_Role FROM dak_enote a WHERE a.EnoteId=:enoteId";
	private static final String ALLRETURNREMARKS="SELECT(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.ActionBy=e.EmpId AND  e.DesigId=d.DesigId) AS 'Recommend',a.EnoteStatusCode,a.Remarks,a.ActionBy,a.Role FROM dak_enote_trans a WHERE a.EnoteId=:eNoteId AND a.Remarks NOT IN('') AND a.EnoteStatusCode IN ('RC1','RC2','RC3','RC4','RC5','EXT','APR','RR1','RR2','RR3','RR4','RR5','ERT','RAP')";
	private static final String EXTERNALLIST="SELECT a.EnoteId,a.NoteId,a.NoteNo,a.RefNo,a.RefDate,a.Subject,a.Comment,a.InitiatedBy,c.EnoteStatus,c.EnoteStatusColor FROM dak_enote a,employee b,dak_enote_status c WHERE a.InitiatedBy=b.EmpId AND a.EnoteStatusCode=c.EnoteStatusCode AND a.EnoteStatusCode IN('RC1','RC2','RC3','RC4','RC5') AND a.EnoteStatusCodeNext IN('EXT') AND :empid IN (a.InitiatedBy,(SELECT l.EmpId FROM login l,employee emp WHERE a.CreatedBy=l.UserName AND l.EmpId=emp.EmpId LIMIT 1)) ORDER BY a.EnoteId DESC";
	private static final String EXTERNALAPPROVALLIST="SELECT a.EnoteId,a.NoteId,a.NoteNo,a.RefNo,a.RefDate,a.Subject,a.Comment,a.InitiatedBy,c.ActionDate,d.EnoteStatus,d.EnoteStatusColor,d.EnoteStatusCode FROM dak_enote a,employee b,dak_enote_trans c,dak_enote_status d WHERE a.InitiatedBy=b.EmpId AND a.EnoteStatusCode=d.EnoteStatusCode AND a.EnoteId=c.EnoteId AND c.EnoteStatusCode IN ('EXT') AND c.ActionBy=:EmpId AND DATE(a.CreatedDate) BETWEEN :fromDate AND :toDate ORDER BY a.EnoteId DESC";
	private static final String ENOTESKIPAPPROVALPENDINGLIST="SELECT a.EnoteId,a.NoteId,a.NoteNo,a.RefNo,a.RefDate,a.SUBJECT,d.EnoteStatus,d.EnoteStatusColor,d.EnoteStatusCode,a.DakId,a.DakReplyId,a.DakNo,a.Reply,a.IsDak FROM dak_enote  a,dak_enote_status d WHERE a.EnoteStatusCode=d.EnoteStatusCode AND (CASE WHEN a.InitiatedBy=:EmpId THEN 1=1 ELSE (SELECT 1 FROM login WHERE username =:Username AND logintypeDms ='A') END) AND a.EnoteStatusCode IN ('FWD','RFD','RC1','RC2','RC3','RC4','RC5') AND RefDate BETWEEN :fromDate AND :toDate ORDER BY EnoteId DESC";
	private static final String ENOTEPRINTVIEWDETAILS="SELECT tra.EnoteTransId,(SELECT e.empId FROM  employee e  WHERE tra.Actionby = e.empid   AND tra.EnoteStatusCode =  sta.EnoteStatusCode AND tra.EnoteId=par.EnoteId ORDER BY tra.EnoteTransId DESC LIMIT 1) AS 'empId',(SELECT e.empname FROM  employee e  WHERE  tra.Actionby=e.empid AND tra.EnoteStatusCode =  sta.EnoteStatusCode AND tra.EnoteId=par.EnoteId ORDER BY tra.EnoteTransId DESC LIMIT 1) AS 'empname',(SELECT designation FROM  employee e,employee_desig des WHERE e.empid = tra.Actionby AND e.desigid=des.desigid AND tra.EnoteStatusCode =  sta.EnoteStatusCode AND tra.EnoteId=par.EnoteId ORDER BY tra.EnoteTransId DESC LIMIT 1) AS 'Designation',tra.ActionDate AS ActionDate,tra.Remarks,sta.EnoteStatus,sta.EnoteStatusColor,sta.EnoteStatusCode,tra.Role,par.InitiatedBy,tra.ActionBy FROM dak_enote_trans tra,dak_enote_status sta,dak_enote par WHERE par.EnoteId=tra.EnoteId AND tra.EnoteStatusCode =sta.EnoteStatusCode AND par.EnoteId=:enoteId ORDER BY ActionDate ASC";
	private static final String GETDIVISIONID="SELECT DivisionId FROM employee WHERE EmpId=:EmpId";
	private static final String GETCHANGERECOMMENDINGOFFICER="SELECT e.EmpId,e.EmpName,d.Designation,e.EmpNo FROM employee e,employee_desig d WHERE e.DesigId=d.DesigId AND e.IsActive=1 ORDER BY CASE WHEN e.Srno = 0 THEN 1 ELSE 0 END, e.Srno ASC";
	private static final String DAKRECOMMENDINGDETAILS="SELECT(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend1=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND a.LabCode=e.LabCode) AS 'Recommend1',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend2=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND a.LabCode=e.LabCode) AS 'Recommend2',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend3=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND a.LabCode=e.LabCode) AS 'Recommend3',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend4=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND a.LabCode=e.LabCode) AS 'Recommend4',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Recommend5=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND a.LabCode=e.LabCode) AS 'Recommend5',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.ApprovingOfficer=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND a.LabCode=e.LabCode) AS 'SanctionOfficer',(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.InitiatedBy=e.EmpId AND  e.DesigId=d.DesigId AND e.IsActive=1 AND a.LabCode=e.LabCode) AS 'IntiatedBy',a.Rec1_Role,a.Rec2_Role,a.Rec3_Role,a.Rec4_Role,a.Rec5_Role,a.Approving_Role FROM dak_enote a WHERE a.EnoteId=:dakeNoteReplyId";
	private static final String DAKREPLYATTACHMENTCOUNT="SELECT COUNT(m.FileName) FROM dak_assign_reply_attachment m,dak_assign_reply b WHERE m.DakAssignReplyId = b.DakAssignReplyId AND b.DakAssignReplyId=:dakeNoteReplyId";
	private static final String GETDAKENOTEATTACHMENTDATA="SELECT DakEnoteReplyId, filepath,DakEnoteAttachmentId,filename  FROM dak_enote_reply_attach WHERE DakEnoteReplyId=:dakEnoteReplyId";
	private static final String DAKENOTEPREVIEWDETAILS="SELECT a.EnoteId,a.NoteId,a.NoteNo,a.RefNo,a.RefDate,a.Recommend1,a.Recommend2,a.Recommend3,a.Recommend4,a.Recommend5,a.ApprovingOfficer,b.EnoteStatus,a.InitiatedBy,a.Rec1_Role,a.Rec2_Role,a.Rec3_Role,a.Rec4_Role,a.Rec5_Role,a.Approving_Role,a.LabCode,a.EnoteStatusCodeNext,a.EnoteStatusCode,a.CreatedBy,(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.InitiatedBy=e.EmpId AND e.DesigId=d.DesigId AND e.IsActive=1 AND a.LabCode=e.LabCode) AS 'IntiatedBy',a.DakId,a.DakNo,a.DakReplyId,a.Reply,a.Subject,a.EnoteFrom  ,(CASE  WHEN a.InitiatedBy = c.InitiatingEmpId THEN c.EnoteRoSoId END) AS 'EnoteRoSoId',a.IsDraft FROM  dak_enote a JOIN  dak_enote_status b ON a.EnoteStatusCode = b.EnoteStatusCode LEFT JOIN dak_enote_roso c ON a.InitiatedBy = c.InitiatingEmpId WHERE  a.EnoteId =:dakeNoteReplyId";
	//private static final String DAKENOTELIST="SELECT a.DakEnoteReplyId,a.NoteNo,a.DakId,a.DakNo,a.RefNo,a.RefDate,a.Reply,d.EnoteStatus,d.EnoteStatusColor,d.EnoteStatusCode,a.DakReplyId FROM dak_enote_reply a,dak_enote_status d WHERE a.EnoteStatusCode=d.EnoteStatusCode AND (CASE WHEN a.InitiatedBy=:empId THEN 1=1 ELSE a.CreatedBy=:username END) AND RefDate BETWEEN :fromDate AND :toDate ORDER BY DakEnoteReplyId DESC";
	private static final String DAKENOTEATTACHMENTDETAILS="SELECT filepath, filename , DakAssignReplyId FROM dak_assign_reply_attachment WHERE DakAssignReplyAttachmentId=:eNoteAttachId";
	private static final String DAKREPLYPARTICULARENOTEATTACHDATA="SELECT FilePath,FileName,DakAssignReplyAttachmentId,DakAssignReplyId,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate FROM dak_assign_reply_attachment WHERE DakAssignReplyAttachmentId=:attachmentId AND DakId=:dakEnoteReplyId";
	private static final String DAKDELETEENOTEATTACHMENT="DELETE FROM dak_assign_reply_attachment WHERE DakAssignReplyAttachmentId=:enoteAttachId";
	private static final String GETENOTEASSIGNREPLYATTACHMENTDATA="SELECT DakAssignReplyId, filepath,DakAssignReplyAttachmentId,filename  FROM dak_assign_reply_attachment WHERE DakAssignReplyId=:dakAssignReplyId";
	//private static final String DAKENOTEPENDINGLIST="CALL Dms_Dak_EnoteReply_PendingList(:empId)";
	//private static final String DAKENOTEAPPROVALLIST="SELECT a.DakEnoteReplyId,a.NoteNo,a.DakId,a.DakNo,a.RefNo,a.RefDate,a.Reply,a.InitiatedBy,c.ActionDate,d.EnoteStatus,d.EnoteStatusColor,d.EnoteStatusCode FROM dak_enote_reply a,employee b,dak_enote_reply_trans c,dak_enote_status d WHERE a.InitiatedBy=b.EmpId AND a.EnoteStatusCode=d.EnoteStatusCode AND a.DakEnoteReplyId=c.DakEnoteReplyId AND c.EnoteStatusCode IN ('RC1','RC2','RC3','RC4','RC5','APR') AND c.ActionBy=:empId AND DATE(a.CreatedDate) BETWEEN :fromDate AND :toDate GROUP BY a.DakEnoteReplyId ORDER BY a.DakEnoteReplyId DESC ";
	//private static final String DAKENOTEPRINTVIEWDETAILS="SELECT tra.EnoteReplyTransId,(SELECT empid FROM dak_enote_reply_trans t , employee e  WHERE e.empid = t.Actionby AND t.EnoteStatusCode =  sta.EnoteStatusCode AND t.DakEnoteReplyId=par.DakEnoteReplyId ORDER BY t.EnoteReplyTransId DESC LIMIT 1) AS 'empid',(SELECT empname FROM dak_enote_reply_trans t , employee e  WHERE e.empid = t.Actionby AND t.EnoteStatusCode =  sta.EnoteStatusCode AND t.DakEnoteReplyId=par.DakEnoteReplyId ORDER BY t.EnoteReplyTransId DESC LIMIT 1) AS 'empname',(SELECT designation FROM dak_enote_reply_trans t , employee e,employee_desig des WHERE e.empid = t.Actionby AND e.desigid=des.desigid AND t.EnoteStatusCode =  sta.EnoteStatusCode AND t.DakEnoteReplyId=par.DakEnoteReplyId ORDER BY t.EnoteReplyTransId DESC LIMIT 1) AS 'Designation', tra.ActionDate AS ActionDate,tra.Remarks,sta.EnoteStatus,sta.EnoteStatusColor,sta.EnoteStatusCode,tra.Role,par.InitiatedBy FROM dak_enote_reply_trans tra,dak_enote_status sta,employee emp,dak_enote_reply par WHERE par.DakEnoteReplyId=tra.DakEnoteReplyId AND tra.EnoteStatusCode =sta.EnoteStatusCode AND tra.Actionby=emp.EmpId AND par.DakEnoteReplyId=:dakEnotePrintId ORDER BY ActionDate ASC";
	//private static final String DAKENOTEPRINTDATA="SELECT a.DakEnoteReplyId,a.DakNo,a.NoteNo,a.RefNo,a.RefDate,a.Reply,a.Recommend1,a.Recommend2,a.Recommend3,a.Recommend4,a.Recommend5,a.SanctionOfficer,b.EnoteStatus FROM dak_enote_reply a,dak_enote_status b WHERE a.EnoteStatusCode=b.EnoteStatusCode AND DakEnoteReplyId=:enotePrintId";
	//private static final String DAKENOTETRANSACTIONLIST="SELECT tra.EnoteReplyTransId,emp.EmpId,emp.EmpName,des.Designation,tra.ActionDate,tra.Remarks,sta.EnoteStatus,sta.EnoteStatusColor FROM dak_enote_reply_trans tra,dak_enote_status sta,employee emp,employee_desig des,dak_enote_reply e WHERE e.DakEnoteReplyId = tra.DakEnoteReplyId AND tra.EnoteStatusCode = sta.EnoteStatusCode AND tra.ActionBy=emp.EmpId AND emp.DesigId = des.DesigId AND e.DakEnoteReplyId=:enoteTrackId ORDER BY tra.ActionDate";
	//private static final String DAKENOTEPRINTDETAILS="SELECT tra.EnoteReplyTransId,(SELECT empid FROM dak_enote_reply_trans t , employee e  WHERE e.empid = t.Actionby AND t.EnoteStatusCode =  sta.EnoteStatusCode AND t.DakEnoteReplyId=par.DakEnoteReplyId ORDER BY t.EnoteReplyTransId DESC LIMIT 1) AS 'empno',(SELECT empname FROM dak_enote_reply_trans t , employee e  WHERE e.empid = t.Actionby AND t.EnoteStatusCode =  sta.EnoteStatusCode AND t.DakEnoteReplyId=par.DakEnoteReplyId ORDER BY t.EnoteReplyTransId DESC LIMIT 1) AS 'empname',(SELECT designation FROM dak_enote_reply_trans t , employee e,employee_desig des WHERE e.empid = t.Actionby AND e.desigid=des.desigid AND t.EnoteStatusCode =  sta.EnoteStatusCode AND t.DakEnoteReplyId=par.DakEnoteReplyId ORDER BY t.EnoteReplyTransId DESC LIMIT 1) AS 'Designation',MAX(tra.ActionDate) AS ActionDate,(SELECT t.Remarks FROM dak_enote_reply_trans t , employee e  WHERE e.empid = t.Actionby AND t.EnoteStatusCode =  sta.EnoteStatusCode AND t.DakEnoteReplyId=par.DakEnoteReplyId ORDER BY t.EnoteReplyTransId DESC LIMIT 1) AS 'Remarks',sta.EnoteStatus,sta.EnoteStatusColor,sta.EnoteStatusCode,tra.Role,par.InitiatedBy FROM dak_enote_reply_trans tra,dak_enote_status sta,employee emp,dak_enote_reply par WHERE par.DakEnoteReplyId=tra.DakEnoteReplyId AND tra.EnoteStatusCode =sta.EnoteStatusCode AND sta.EnoteStatusCode IN ('FWD','RFD','RC1','RC2','RC3','RC4','RC5','EXT','APR') AND tra.Actionby=emp.EmpId AND par.DakEnoteReplyId=:dakEnotePrintId GROUP BY tra.EnoteStatusCode ORDER BY ActionDate ASC";
	private static final String DAKENOTEREPLYALLRETURNREMARKS="SELECT(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.ActionBy=e.EmpId AND  e.DesigId=d.DesigId) AS 'Recommend',a.EnoteStatusCode,a.Remarks,a.ActionBy,a.Role FROM dak_enote_trans a WHERE a.EnoteId=:dakEnoteReplyId AND  a.EnoteStatusCode IN ('RC1','RC2','RC3','RC4','RC5','APR','RR1','RR2','RR3','RR4','RR5','RAP')";
	private static final String DAKMARKINGENOTEATTACHMENTDETAILS="SELECT filepath, filename , ReplyId FROM dak_reply_attachment WHERE ReplyAttachmentId=:eNoteAttachId";
	private static final String DAKMARKERREPLYPARTICULARENOTEATTACHDATA="SELECT FilePath,FileName,ReplyAttachmentId,ReplyId,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate FROM dak_reply_attachment WHERE ReplyAttachmentId=:attachmentId AND ReplyId=:dakEnoteReplyId";
	private static final String DAKMARKERDELETEENOTEATTACHMENT="DELETE FROM dak_reply_attachment WHERE ReplyAttachmentId=:enoteAttachId";
	private static final String DAKMARKERREPLYATTACHMENTCOUNT="SELECT COUNT(m.FileName) FROM dak_reply_attachment m,dak_reply b WHERE m.ReplyId = b.DakReplyId AND b.DakReplyId=:dakeNoteReplyId";
	
	@PersistenceContext
	EntityManager manager;

	@Override
	public long EnoteCountForGeneration() throws Exception {
		logger.info(new Date() + "Inside EnoteIdForCount");
		try {
			Query query = manager.createNativeQuery(ENOTECOUNTFORIDGENERATION);
			Long Enote = (Long) query.getSingleResult();
			return Enote.longValue();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl EnoteIdForCount", e);
			return 0;
		}
	}
	
	@Override
	public long insertEnote(Enote enote) throws Exception {
		logger.info(new Date() + "Inside DAO insertEnote");
		try {
			manager.persist(enote);
			manager.flush();
			return enote.getEnoteId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl insertEnote", e);
			return 0;
		}
	}
	
	@Override
	public List<Object[]> GetAttachmentDetails(Long enoteId) throws Exception {
		logger.info(new Date() + "Inside GetAttachmentDetails");
		try {
			Query query = manager.createNativeQuery(ENOTEATTACHMENTDATA);
			query.setParameter("enoteId", enoteId);
			List<Object[]> GetAttachmentDetails = (List<Object[]>) query.getResultList();
			return GetAttachmentDetails;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl GetAttachmentDetails", e);
			return null;
		}
	}

	@Override
	public long EnoteAttachmentFile(EnoteAttachment model) throws Exception {
		logger.info(new Date() + "Inside DAO EnoteAttachmentFile");
		try {
			manager.persist(model);
			manager.flush();
			return model.getEnoteAttachmentId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl EnoteAttachmentFile", e);
			return 0;
		}
	}
	
	@Override
	public Object[] EnotePreview(long result) throws Exception {
		logger.info(new Date() + "Inside EnotePreview");
		try {
			Query query = manager.createNativeQuery(ENOTEPREVIEWDETAILS);
			query.setParameter("result", result);
			Object[] EnotePreview = (Object[]) query.getSingleResult();
			return EnotePreview;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl EnotePreview", e);
			return null;
		}
	}
	
	
	@Override
	public Object getlabcode(long empId) throws Exception {

		try {
			Query query = manager.createNativeQuery(GETLABCODE);
			query.setParameter("empId", empId);
			Object labcode = query.getSingleResult();
			return labcode;
		} catch (Exception e) {
			e.printStackTrace();
	
			return null;
		}
		
	}
	
	
	
	@Override
	public List<Object[]> InitiatedByEmployeeList(long divid, String lab) throws Exception {

		try {
			Query query=manager.createNativeQuery(INITIATEDBYEMPLOYEELIST);
			query.setParameter("divid", divid);
			query.setParameter("lab", lab);
			return (List<Object[]>)query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
	
			return null;
		}
	}
	
	@Override
	public List<Object[]> RecommendingOfficerList(String lab) throws Exception {
		try {
			Query query=manager.createNativeQuery(RECOMMENDINGOFFICERLIST);
			query.setParameter("lab", lab);
			return (List<Object[]>)query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
	
			return null;
		}
	}
	
	@Override
	public long InsertForwardRecommendOfficers(EnoteFlow enoteflow) throws Exception {
		logger.info(new Date() + "Inside DAO InsertForwardRecommendOfficers");
		try {
			manager.persist(enoteflow);
			manager.flush();
			return enoteflow.getRecommendId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl InsertForwardRecommendOfficers", e);
			return 0;
		}
	}
	
	@Override
	public List<Object[]> EnoteList(String fromDate, String toDate,String Username,long EmpId) throws Exception {
	logger.info(new Date()+ "inside EnoteList"); 
		try {
			Query query=manager.createNativeQuery(ENOTELIST);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			query.setParameter("Username", Username);
			query.setParameter("EmpId", EmpId);
			return (List<Object[]>)query.getResultList();
		} catch (Exception e) {
		e.printStackTrace();
		logger.info(new Date()+"inside Enotelist");
		return null;
	}
	}
	
	@Override
	public long UpdateEnoteStatus(String eNoteId) throws Exception {
		logger.info(new Date() + "Inside DAO UpdateEnoteStatus");
		try {
			Query query=manager.createNativeQuery(UPDATEENOTESTATUS);
			query.setParameter("eNoteId", eNoteId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl UpdateEnoteStatus", e);
			return 0;
		}
	}
	
	
	@Override
	public Enote getEnoteById(long enoteId) throws Exception{
		return manager.find(Enote.class, enoteId);
	}

	@Override
	public long updateEnote(Enote enote) throws Exception {
		try {
			manager.merge(enote);
			manager.flush();
			return enote.getEnoteId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public long addEnoteTransaction(EnoteTransaction trans) throws Exception {
		try {
			manager.persist(trans);
			manager.flush();
			return trans.getEnoteId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public long AttachmentCount(long enoteId) throws Exception {
		logger.info(new Date() + "Inside DAO AttachmentCount");
		try {
			Query query=manager.createNativeQuery(ATTACHMENTCOUNT);
			query.setParameter("enoteId", enoteId);
			return ((Number) query.getSingleResult()).longValue();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl AttachmentCount", e);
			return 0;
		}
	}

	@Override
	public Object[] EnoteAttachmentData(String eNoteAttachId) throws Exception {
		logger.info(new Date() + "Inside EnoteAttachmentData");
		try {
			Query query = manager.createNativeQuery(ENOTEATTACHMENTDETAILS);
			query.setParameter("eNoteAttachId", eNoteAttachId);
			Object[] enotedata = (Object[]) query.getSingleResult();
			return enotedata;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl EnoteAttachmentData", e);
			return null;
		}
	}
	
	@Override
	public List<Object[]> EnoteAttachmentData(long enoteAttachId, long enoteId) throws Exception {
		logger.info(new Date() + "Inside EnoteAttachmentData");
		try {
			Query query = manager.createNativeQuery(PARTICULARENOTEATTACHDATA);
			query.setParameter("enoteAttachId", enoteAttachId);
			query.setParameter("enoteId", enoteId);
			 List<Object[]> EnoteAttachmentData = (List<Object[]>) query.getResultList();
				return EnoteAttachmentData;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl EnoteAttachmentData", e);
			return null;
		}
	}
	
@Override
	public int DeleteEnoteAttachment(String enoteAttachId) throws Exception {
	logger.info(new Date() + "Inside DeleteEnoteAttachment");
	try {
		Query query = manager.createNativeQuery(DELETEENOTEATTACHMENT);
		query.setParameter("enoteAttachId", enoteAttachId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DeleteEnoteAttachment", e);
		return 0;
	}
	
	}

@Override
public Object[] RecommendingDetails(long enoteId,String lab) throws Exception {
	logger.info(new Date() + "Inside RecommendingDetails");
	try {
		Query query = manager.createNativeQuery(RECOMMENDINGDETAILS);
		query.setParameter("enoteId", enoteId);
		query.setParameter("lab", lab);
		Object[] RecommendingDetails = (Object[]) query.getSingleResult();
		return RecommendingDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl RecommendingDetails", e);
		return null;
	}
}

@Override
public List<Object[]> eNotePendingList(long EmpId) throws Exception {
	logger.info(new Date() + "Inside eNotePendingList");
	try {
		Query query = manager.createNativeQuery(ENOTEPENDINGLIST);
		query.setParameter("EmpId", EmpId);
		 List<Object[]> eNotePendingList = (List<Object[]>) query.getResultList();
			return eNotePendingList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl eNotePendingList", e);
		return null;
	}
}

@Override
public List<Object[]> eNoteApprovalList(long EmpId,String fromDate,String toDate) throws Exception {
	logger.info(new Date() + "Inside eNoteApprovalList");
	try {
		Query query = manager.createNativeQuery(ENOTEAPPROVALLIST);
		query.setParameter("EmpId", EmpId);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		 List<Object[]> eNoteApprovalList = (List<Object[]>) query.getResultList();
			return eNoteApprovalList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl eNoteApprovalList", e);
		return null;
	}
}


@Override
public List<Object[]> EnoteTransactionList(String enoteTrackId) throws Exception {
	logger.info(new Date() + "Inside EnoteTransactionList");
	try {
		Query query = manager.createNativeQuery(ENOTETRANSACTIONLIST);
		query.setParameter("enoteTrackId", enoteTrackId);
		 List<Object[]> EnoteTransactionList = (List<Object[]>) query.getResultList();
			return EnoteTransactionList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnoteTransactionList", e);
		return null;
	}
}

@Override
public Object[] EnotePrint(String enotePrintId) throws Exception {
	logger.info(new Date() + "Inside EnotePrint");
	try {
		Query query = manager.createNativeQuery(ENOTEPRINTDATA);
		query.setParameter("enotePrintId", enotePrintId);
		Object[] EnotePrint = (Object[]) query.getSingleResult();
		return EnotePrint;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnotePrint", e);
		return null;
	}
}

@Override
public List<Object[]> EnotePrintDetails(long enoteId) throws Exception {
	logger.info(new Date() + "Inside EnotePrintDetails");
	try {
		Query query = manager.createNativeQuery(ENOTEPRINTDETAILS);
		query.setParameter("enoteId", enoteId);
		 List<Object[]> EnotePrintDetails = (List<Object[]>) query.getResultList();
			return EnotePrintDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnotePrintDetails", e);
		return null;
	}
}

@Override
public List<Object[]> EnoteRoSoList(String lab) throws Exception {
	logger.info(new Date() + "Inside EnoteRoSoList");
	try {
		Query query = manager.createNativeQuery(ENOTEROSOLIST);
		query.setParameter("lab", lab);
		 List<Object[]> EnoteRoSoList = (List<Object[]>) query.getResultList();
			return EnoteRoSoList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnoteRoSoList", e);
		return null;
	}
}

@Override
public List<Object[]> EmployeeListForEnoteRoSo(String lab) throws Exception {
	logger.info(new Date() + "Inside EmployeeListForEnoteRoSo");
	try {
		Query query = manager.createNativeQuery(EMPLOYEELISTFORENOTEROSO);
		query.setParameter("lab", lab);
		 List<Object[]> EmployeeListForEnoteRoSo = (List<Object[]>) query.getResultList();
			return EmployeeListForEnoteRoSo;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EmployeeListForEnoteRoSo", e);
		return null;
	}
}
@Override
public long InsertEnoteRoso(EnoteRosoModel enote) throws Exception {
	logger.info(new Date() + "Inside DAO insertEnote");
	try {
		manager.persist(enote);
		manager.flush();
		return enote.getEnoteRoSoId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl insertEnote", e);
		return 0;
	}
}

@Override
public List<Object[]> InitiatedEmpList(String lab) throws Exception {
	logger.info(new Date() + "Inside InitiatedEmpList");
	try {
		Query query = manager.createNativeQuery(INITIATEDEMPLIST);
		query.setParameter("lab", lab);
		 List<Object[]> InitiatedEmpList = (List<Object[]>) query.getResultList();
			return InitiatedEmpList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl InitiatedEmpList", e);
		return null;
	}
}


@Override
public EnoteRosoModel getEnoteRoSoDataById(long enoteRoSoId) throws Exception {
	logger.info(new Date() + "Inside getEnoteRoSoDataById");
	try {
		return manager.find(EnoteRosoModel.class, enoteRoSoId);
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getEnoteRoSoDataById", e);
		return null;
	}
}

@Override
public long updateDakEnoteRoSo(EnoteRosoModel model) throws Exception {
	logger.info(new Date() + "Inside updateDakEnoteRoSo");
	try {
		manager.merge(model);
		manager.flush();
		return model.getEnoteRoSoId();
	}catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl updateDakEnoteRoSo", e);
		return 0;
	}
}

@Override
public Object[] EnoteRoSoDetails(long enoteRoSoId,String lab) throws Exception {
	logger.info(new Date() + "Inside EnoteRoSoDetails");
	try {
		Query query = manager.createNativeQuery(ENOTEROSODETAILS);
		query.setParameter("enoteRoSoId", enoteRoSoId);
		query.setParameter("lab", lab);
		Object[] EnoteRoSoDetails = (Object[]) query.getSingleResult();
		return EnoteRoSoDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnoteRoSoDetails", e);
		return null;
	}
}

@Override
public Object[] EnoteRoSoRoledetails(long enoteId) throws Exception {
	logger.info(new Date() + "Inside EnoteRoSoRoledetails");
	try {
		Query query = manager.createNativeQuery(ENOTEROSOROLEDETAILS);
		query.setParameter("enoteId", enoteId);
		Object[] EnoteRoSoRoledetails = (Object[]) query.getSingleResult();
		return EnoteRoSoRoledetails;
	} catch (Exception e) {
		//e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnoteRoSoRoledetails", e);
		return null;
	}
}


@Override
public List<Object[]> LabList(String lab) throws Exception {
	logger.info(new Date() + "Inside the DaoImpl LabList");
	try {
		Query query=manager.createNativeQuery(LABLIST);
		query.setParameter("lab", lab);
		List<Object[]> lablist=(List<Object[]>)query.getResultList();
		return lablist;
		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl LabList", e);
		return null;
	}
}

@Override
public List<Object[]> ExpertEmployeeList() throws Exception {
	logger.info(new Date() + "Inside the DaoImpl ExpertEmployeeList");
	try {
		Query query=manager.createNativeQuery(EXPERTEMPLOYEELIST);
		List<Object[]> ExpertEmployeeList=(List<Object[]>)query.getResultList();
		return ExpertEmployeeList;
		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl ExpertEmployeeList", e);
		return null;
	}
}
@Override
public Object[] getExternalLabCode(long enoteRoSoId) throws Exception {
	logger.info(new Date() + "Inside getExternalLabCode");
	try {
		Query query = manager.createNativeQuery(GETEXTERNALLABCODEDATA);
		query.setParameter("enoteRoSoId", enoteRoSoId);
		Object[] getExternalLabCode = (Object[]) query.getSingleResult();
		return getExternalLabCode;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl getExternalLabCode", e);
		return null;
	}
}

@Override
public long eNoteRevokeEdit(Enote enote) throws Exception {
	try {
		manager.merge(enote);
		manager.flush();
		return enote.getEnoteId();
	}catch (Exception e) {
		logger.error(new Date()  + "Inside Daoimpl eNoteRevokeEdit " + e);
		e.printStackTrace();
		return 0;
	}
}

@Override
public Object[] ExternalNameData(long enoteId) throws Exception {
	logger.info(new Date() + "Inside ExternalNameData");
	try {
		Query query = manager.createNativeQuery(EXTERNALNAMEDATA);
		query.setParameter("enoteId", enoteId);
		Object[] ExternalNameData = (Object[]) query.getSingleResult();
		return ExternalNameData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl ExternalNameData", e);
		return null;
	}
}

@Override
public List<Object[]> ReturnRemarks(String eNoteId) throws Exception {
	logger.info(new Date() + "Inside the DaoImpl ReturnRemarks");
	try {
		Query query=manager.createNativeQuery(ALLRETURNREMARKS);
		query.setParameter("eNoteId", eNoteId);
		List<Object[]> ReturnRemarks=(List<Object[]>)query.getResultList();
		return ReturnRemarks;
		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl ReturnRemarks", e);
		return null;
	}
}

@Override
public List<Object[]> ExternalList(long EmpId) throws Exception {
	logger.info(new Date() + "Inside the DaoImpl ExternalList");
	try {
		Query query=manager.createNativeQuery(EXTERNALLIST);
		query.setParameter("empid", EmpId);
		List<Object[]> ExternalList=(List<Object[]>)query.getResultList();
		return ExternalList;
		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl ExternalList", e);
		return null;
	}
}

@Override
public List<Object[]> ExternalApprovalList(long EmpId, String fromDate, String toDate) throws Exception {
	logger.info(new Date() + "Inside the DaoImpl ExternalApprovalList");
	try {
		Query query=manager.createNativeQuery(EXTERNALAPPROVALLIST);
		query.setParameter("EmpId", EmpId);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		List<Object[]> ExternalApprovalList=(List<Object[]>)query.getResultList();
		return ExternalApprovalList;
		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl ExternalApprovalList", e);
		return null;
	}
}

@Override
public List<Object[]> eNoteSkipApprovalPendingList(String fromDate, String toDate,String Username,long EmpId) throws Exception {
	logger.info(new Date() + "Inside eNoteSkipApprovalPendingList");
	try {
		Query query = manager.createNativeQuery(ENOTESKIPAPPROVALPENDINGLIST);
		
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		query.setParameter("Username", Username);
		query.setParameter("EmpId", EmpId);
		 List<Object[]> eNoteSkipApprovalPendingList = (List<Object[]>) query.getResultList();
			return eNoteSkipApprovalPendingList;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl eNoteSkipApprovalPendingList", e);
		return null;
	}
}

@Override
public List<Object[]> EnotePrintViewDetails(long enoteId) throws Exception {
	logger.info(new Date() + "Inside EnotePrintViewDetails");
	try {
		Query query = manager.createNativeQuery(ENOTEPRINTVIEWDETAILS);
		query.setParameter("enoteId", enoteId);
		 List<Object[]> EnotePrintViewDetails = (List<Object[]>) query.getResultList();
			return EnotePrintViewDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl EnotePrintViewDetails", e);
		return null;
	}
}

@Override
public Object getDivisionId(long EmpId) throws Exception {
	try {
		Query query = manager.createNativeQuery(GETDIVISIONID);
		query.setParameter("EmpId", EmpId);
		Object divisionId = query.getSingleResult();
		return divisionId;
	} catch (Exception e) {
		e.printStackTrace();

		return null;
	}
}

@Override
public List<Object[]> GetChangeRecommendingOfficer(String divId) throws Exception {
	logger.info(new Date()+"Inisde the GetChangeRecommendingOfficer dao");
	try {
		Query query=manager.createNativeQuery(GETCHANGERECOMMENDINGOFFICER);
		//query.setParameter("divId", divId);
		return (List<Object[]>)query.getResultList();
	} catch (Exception e) {
		e.printStackTrace();
		return null;
	}
}

@Override
public long ChangeRecommendOfficer(long enoteId, long RecommendingOfficer, String statusCodeNext,String RecommendRole,String ChangeApprovalRemarks) throws Exception {
	logger.info(new Date() + "Inside ChangeRecommendOfficer");
	try {
		Query query=null;
		if(statusCodeNext.equalsIgnoreCase("RC1")) {
		    query = manager.createNativeQuery("UPDATE dak_enote SET Recommend1=:RecommendingOfficer,Rec1_Role=:RecommendRole WHERE EnoteId=:enoteId");
		}else if(statusCodeNext.equalsIgnoreCase("RC2")){
			query = manager.createNativeQuery("UPDATE dak_enote SET Recommend2=:RecommendingOfficer,Rec2_Role=:RecommendRole WHERE EnoteId=:enoteId");
		}else if(statusCodeNext.equalsIgnoreCase("RC3")){
			query = manager.createNativeQuery("UPDATE dak_enote SET Recommend3=:RecommendingOfficer,Rec3_Role=:RecommendRole WHERE EnoteId=:enoteId");
		}else if(statusCodeNext.equalsIgnoreCase("RC4")){
			query = manager.createNativeQuery("UPDATE dak_enote SET Recommend4=:RecommendingOfficer,Rec4_Role=:RecommendRole WHERE EnoteId=:enoteId");
		}else if(statusCodeNext.equalsIgnoreCase("RC5")){
			query = manager.createNativeQuery("UPDATE dak_enote SET Recommend5=:RecommendingOfficer,Rec5_Role=:RecommendRole WHERE EnoteId=:enoteId");
		}else if(statusCodeNext.equalsIgnoreCase("APR")){
			query = manager.createNativeQuery("UPDATE dak_enote SET ApprovingOfficer=:RecommendingOfficer,Approving_Role=:RecommendRole WHERE EnoteId=:enoteId");
		}
		query.setParameter("enoteId", enoteId);
		query.setParameter("RecommendingOfficer", RecommendingOfficer);
		query.setParameter("RecommendRole", RecommendRole);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl ChangeRecommendOfficer", e);
		return 0;
	}
}

@Override
public Object[] DakRecommendingDetails(long dakeNoteReplyId) throws Exception {
	logger.info(new Date() + "Inside DakRecommendingDetails");
	try {
		Query query = manager.createNativeQuery(DAKRECOMMENDINGDETAILS);
		query.setParameter("dakeNoteReplyId", dakeNoteReplyId);
		Object[] DakRecommendingDetails = (Object[]) query.getSingleResult();
		return DakRecommendingDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakRecommendingDetails", e);
		return null;
	}
}

@Override
public long DakReplyAttachmentCount(long dakeNoteReplyId) throws Exception {
	logger.info(new Date() + "Inside DAO DakReplyAttachmentCount");
	try {
		Query query=manager.createNativeQuery(DAKREPLYATTACHMENTCOUNT);
		query.setParameter("dakeNoteReplyId", dakeNoteReplyId);
		return ((Number) query.getSingleResult()).longValue();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakReplyAttachmentCount", e);
		return 0;
	}
}

@Override
public long DakReplyinsertEnote(DakEnoteReply enote) throws Exception {
	logger.info(new Date() + "Inside DAO DakReplyinsertEnote");
	try {
		manager.persist(enote);
		manager.flush();
		return enote.getDakEnoteReplyId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakReplyinsertEnote", e);
		return 0;
	}
}

@Override
public List<Object[]> GetDakEnoteAttachmentDetails(Long dakEnoteReplyId) throws Exception {
	logger.info(new Date() + "Inside GetDakEnoteAttachmentDetails");
	try {
		Query query = manager.createNativeQuery(GETDAKENOTEATTACHMENTDATA);
		query.setParameter("dakEnoteReplyId", dakEnoteReplyId);
		List<Object[]> GetDakEnoteAttachmentDetails = (List<Object[]>) query.getResultList();
		return GetDakEnoteAttachmentDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetDakEnoteAttachmentDetails", e);
		return null;
	}
}

@Override
public long DakReplyEnoteAttachmentFile(DakEnoteReplyAttach model) throws Exception {
	logger.info(new Date() + "Inside DAO DakReplyEnoteAttachmentFile");
	try {
		manager.persist(model);
		manager.flush();
		return model.getDakEnoteAttachmentId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakReplyEnoteAttachmentFile", e);
		return 0;
	}
}


@Override
public Object[] DakEnotePreview(long dakeNoteReplyId) throws Exception {
	logger.info(new Date() + "Inside DakEnotePreview");
	try {
		Query query = manager.createNativeQuery(DAKENOTEPREVIEWDETAILS);
		query.setParameter("dakeNoteReplyId", dakeNoteReplyId);
		Object[] DakEnotePreview = (Object[]) query.getSingleResult();
		return DakEnotePreview;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakEnotePreview", e);
		return null;
	}
}

@Override
public long DakupdateEnote(DakEnoteReply enote) throws Exception {
	try {
		manager.merge(enote);
		manager.flush();
		return enote.getDakEnoteReplyId();
	}catch (Exception e) {
		e.printStackTrace();
		return 0;
	}
}

@Override
public Object[] DakEnoteAttachmentData(String eNoteAttachId) throws Exception {
	logger.info(new Date() + "Inside DakEnoteAttachmentData");
	try {
		Query query = manager.createNativeQuery(DAKENOTEATTACHMENTDETAILS);
		query.setParameter("eNoteAttachId", eNoteAttachId);
		Object[] DakEnoteAttachmentData = (Object[]) query.getSingleResult();
		return DakEnoteAttachmentData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakEnoteAttachmentData", e);
		return null;
	}
}

@Override
public List<Object[]> DakEnoteAttachmentData(long attachmentId, long dakEnoteReplyId) throws Exception {
	logger.info(new Date() + "Inside DakEnoteAttachmentData");
	try {
		Query query = manager.createNativeQuery(DAKREPLYPARTICULARENOTEATTACHDATA);
		query.setParameter("attachmentId", attachmentId);
		query.setParameter("dakEnoteReplyId", dakEnoteReplyId);
		List<Object[]> DakEnoteAttachmentData = (List<Object[]>) query.getResultList();
		return DakEnoteAttachmentData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakEnoteAttachmentData", e);
		return null;
	}
}

@Override
public int DeleteDakEnoteAttachment(String enoteAttachId) throws Exception {
	logger.info(new Date() + "Inside DeleteDakEnoteAttachment");
	try {
		Query query = manager.createNativeQuery(DAKDELETEENOTEATTACHMENT);
		query.setParameter("enoteAttachId", enoteAttachId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DeleteDakEnoteAttachment", e);
		return 0;
	}
}

@Override
public List<Object[]> GetEnoteAssignReplyAttachmentDetails(long dakAssignReplyId) throws Exception {
	logger.info(new Date() + "Inside GetEnoteAssignReplyAttachmentDetails");
	try {
		Query query = manager.createNativeQuery(GETENOTEASSIGNREPLYATTACHMENTDATA);
		query.setParameter("dakAssignReplyId", dakAssignReplyId);
		List<Object[]> GetEnoteAssignReplyAttachmentDetails = (List<Object[]>) query.getResultList();
		return GetEnoteAssignReplyAttachmentDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetEnoteAssignReplyAttachmentDetails", e);
		return null;
	}
}

@Override
public DakEnoteReply getEnoteReplyEditData(long dakEnoteReplyId) throws Exception {
	return manager.find(DakEnoteReply.class, dakEnoteReplyId);
}

@Override
public long updateEnoteReply(Enote enote) throws Exception {
	try {
		manager.merge(enote);
		manager.flush();
		return enote.getEnoteId();
	}catch (Exception e) {
		e.printStackTrace();
		return 0;
	}
}

@Override
public List<Object[]> DakENoteReplyReturnRemarks(String dakEnoteReplyId) throws Exception {
	logger.info(new Date() + "Inside the DaoImpl DakENoteReplyReturnRemarks");
	try {
		Query query=manager.createNativeQuery(DAKENOTEREPLYALLRETURNREMARKS);
		query.setParameter("dakEnoteReplyId", dakEnoteReplyId);
		List<Object[]> DakENoteReplyReturnRemarks=(List<Object[]>)query.getResultList();
		return DakENoteReplyReturnRemarks;
		
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakENoteReplyReturnRemarks", e);
		return null;
	}
}

@Override
public Object[] DakMarkingEnoteAttachmentData(String eNoteAttachId) throws Exception {
	logger.info(new Date() + "Inside DakMarkingEnoteAttachmentData");
	try {
		Query query = manager.createNativeQuery(DAKMARKINGENOTEATTACHMENTDETAILS);
		query.setParameter("eNoteAttachId", eNoteAttachId);
		Object[] DakMarkingEnoteAttachmentData = (Object[]) query.getSingleResult();
		return DakMarkingEnoteAttachmentData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakMarkingEnoteAttachmentData", e);
		return null;
	}
}

@Override
public List<Object[]> DakEnoteMarkerAttachmentData(long attachmentId, long dakEnoteReplyId) throws Exception {
	logger.info(new Date() + "Inside DakEnoteMarkerAttachmentData");
	try {
		Query query = manager.createNativeQuery(DAKMARKERREPLYPARTICULARENOTEATTACHDATA);
		query.setParameter("attachmentId", attachmentId);
		query.setParameter("dakEnoteReplyId", dakEnoteReplyId);
		List<Object[]> DakEnoteMarkerAttachmentData = (List<Object[]>) query.getResultList();
		return DakEnoteMarkerAttachmentData;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakEnoteMarkerAttachmentData", e);
		return null;
	}
}

@Override
public int DeleteMarkerDakEnoteAttachment(String enoteAttachId) throws Exception {
	logger.info(new Date() + "Inside DeleteMarkerDakEnoteAttachment");
	try {
		Query query = manager.createNativeQuery(DAKMARKERDELETEENOTEATTACHMENT);
		query.setParameter("enoteAttachId", enoteAttachId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DeleteMarkerDakEnoteAttachment", e);
		return 0;
	}
}

@Override
public long DakMarkerReplyAttachmentCount(long dakeNoteReplyId) throws Exception {
	logger.info(new Date() + "Inside DAO DakMarkerReplyAttachmentCount");
	try {
		Query query=manager.createNativeQuery(DAKMARKERREPLYATTACHMENTCOUNT);
		query.setParameter("dakeNoteReplyId", dakeNoteReplyId);
		return ((Number) query.getSingleResult()).longValue();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl DakMarkerReplyAttachmentCount", e);
		return 0;
	}
}

private static final String ENOTEPENDINGAPPROVLADATA="SELECT a.NoteId,a.NoteNo,e.MobileNo,e.Email,e.DronaEmail FROM dak_enote a, employee e WHERE EnoteStatusCode NOT IN ('APR') AND EnoteStatusCodeNext='APR' AND a.ApprovingOfficer=e.EmpId AND a.ApprovingOfficer=:ApprovingOfficer AND a.EnoteId=:enoteId";
@Override
public Object[] EnotePendingApprovalList(long ApprovingOfficer, Long enoteId) throws Exception {
	logger.info(new Date()+ "inside EnotePendingApprovalList()");
	try {
		Query query=manager.createNativeQuery(ENOTEPENDINGAPPROVLADATA);
		query.setParameter("ApprovingOfficer", ApprovingOfficer);
		query.setParameter("enoteId", enoteId);
		return (Object[])query.getSingleResult();
	} catch (Exception e) {
		e.printStackTrace();
		logger.info(new Date()+ "inside EnotePendingApprovalList()");
		return null;
	}
}

private static final String ENOTEDOCUMENTDATA="SELECT CONCAT(IFNULL(CONCAT(TRIM(e1.empname), ', '), ''), d1.Designation) AS 'DirectorName',CONCAT(IFNULL(CONCAT(TRIM(e2.empname), ', '), ''), d2.Designation) AS 'InitiatedByName' FROM employee e1 JOIN lab_master lm ON e1.empid = lm.LabAuthorityId JOIN employee_desig d1 ON e1.DesigId = d1.DesigId JOIN employee e2 ON e2.EmpId =:initiatedBy JOIN employee_desig d2 ON e2.DesigId = d2.DesigId WHERE lm.labcode =:labCode AND  e1.isactive = '1'";
@Override
public Object[] EnoteDocumentData(String labCode, long initiatedBy) throws Exception {
	logger.info(new Date()+"Inside EnoteDocumentData()");
	try {
		Query query=manager.createNativeQuery(ENOTEDOCUMENTDATA);
		query.setParameter("labCode", labCode);
		query.setParameter("initiatedBy", initiatedBy);
		return (Object[])query.getSingleResult();
	} catch (Exception e) {
		e.printStackTrace();
		logger.info(new Date()+"Inside the EnoteDocumentData");
		return null;
	}
}


private static final String TEMPLATELIST="SELECT TemplateId,TemplateName,TemplateFilePath FROM dak_template WHERE IsActive='1'";
@Override
public List<Object[]> TemplateList() throws Exception {
	logger.info(new Date()+"Inside TemplateList()");
	try {
		Query query =manager.createNativeQuery(TEMPLATELIST);
		return (List<Object[]>)query.getResultList();
	} catch (Exception e) {
		e.printStackTrace();
		logger.info(new Date()+"Inside TemplateList()");
		return null;
	}
}


@Override
public long updateRosoId(String[] eNoteRosoDeleteId) throws Exception {
	logger.info(new Date() + "Inside updateRosoId");
	try {
		String RecommendingOfficer=eNoteRosoDeleteId[0].trim();
		String eNoteRosoId=eNoteRosoDeleteId[1].trim();
		System.out.println("RecommendingOfficeroutside:"+RecommendingOfficer);
		System.out.println("eNoteRosoIdoutside:"+eNoteRosoId);
		Query query=null;
		if(RecommendingOfficer.equalsIgnoreCase("R1")) {
		    query = manager.createNativeQuery("UPDATE dak_enote_roso SET RO1=NULL,RO1_Role=NULL WHERE EnoteRoSoId=:eNoteRosoId");
		}else if(RecommendingOfficer.equalsIgnoreCase("R2")){
			query = manager.createNativeQuery("UPDATE dak_enote_roso SET RO2=NULL,RO2_Role=NULL WHERE EnoteRoSoId=:eNoteRosoId");
		}else if(RecommendingOfficer.equalsIgnoreCase("R3")){
			query = manager.createNativeQuery("UPDATE dak_enote_roso SET RO3=NULL,RO3_Role=NULL WHERE EnoteRoSoId=:eNoteRosoId");
		}else if(RecommendingOfficer.equalsIgnoreCase("R4")){
			query = manager.createNativeQuery("UPDATE dak_enote_roso SET RO4=NULL,RO4_Role=NULL WHERE EnoteRoSoId=:eNoteRosoId");
		}else if(RecommendingOfficer.equalsIgnoreCase("R5")){
			query = manager.createNativeQuery("UPDATE dak_enote_roso SET RO5=NULL,RO5_Role=NULL WHERE EnoteRoSoId=:eNoteRosoId");
		}else if(RecommendingOfficer.equalsIgnoreCase("E")){
			System.out.println("RecommendingOfficerinside:"+RecommendingOfficer);
			System.out.println("eNoteRosoIdinside:"+eNoteRosoId);
			query = manager.createNativeQuery("UPDATE dak_enote_roso SET ExternalOfficer=NULL,ExternalOfficer_Role=NULL,External_LabCode=NULL WHERE EnoteRoSoId=:eNoteRosoId");
		}else if(RecommendingOfficer.equalsIgnoreCase("A")){
			query = manager.createNativeQuery("UPDATE dak_enote_roso SET ApprovingOfficer=NULL,Approving_Role=NULL WHERE EnoteRoSoId=:eNoteRosoId");
		}
		query.setParameter("eNoteRosoId", eNoteRosoId);
		return query.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl updateRosoId", e);
		return 0;
	}
}

private static final String WORDDOCUMENTDATA="SELECT a.RefNo,a.LetterDate,a.Subject,a.DraftContent,a.LetterHead,(SELECT CONCAT(IFNULL(CONCAT(TRIM(e.empname),', '),''), d.Designation) FROM employee e ,employee_desig d WHERE a.Signatory=e.EmpId AND  e.DesigId=d.DesigId) AS 'Signatory',b.SourceName,b.SourceAddress,b.SourceCity,b.SourcePin FROM dak_enote a,dak_source_details b WHERE a.DestinationTypeId=b.SourceDetailId AND a.EnoteId=:enoteId";
@Override
public Object[] WordDocumentData(long enoteId) throws Exception {
	logger.info(new Date()+"Inside the WordDocumentData()");
	try {
		Query query=manager.createNativeQuery(WORDDOCUMENTDATA);
		query.setParameter("enoteId", enoteId);
		return (Object[])query.getSingleResult();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside the WordDocumentData()",e);
		return null;
	}
}


private static final String LETTERDOCUMENTDATA="SELECT EnoteId, filepath,LetterDocId,filename FROM dak_letter_doc WHERE EnoteId=:enoteId";
@Override
public List<Object[]> GetLetterDocDetails(long enoteId) throws Exception {
	logger.info(new Date() + "Inside GetLetterDocDetails");
	try {
		Query query = manager.createNativeQuery(LETTERDOCUMENTDATA);
		query.setParameter("enoteId", enoteId);
		List<Object[]> GetLetterDocDetails = (List<Object[]>) query.getResultList();
		return GetLetterDocDetails;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl GetLetterDocDetails", e);
		return null;
	}
}

@Override
public long DakLetterDocFile(DakLetterDoc doc) throws Exception {
	logger.info(new Date()+"Inside the DakLetterDocFile");
	try {
		manager.persist(doc);
		manager.flush();
		return doc.getLetterDocId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside the DakLetterDocFile()",e);
		return 0;
	}
}


private static final String SELLETTERDOCUMENTDATA="SELECT filepath,filename ,EnoteId,LetterDocId FROM dak_letter_doc WHERE EnoteId=:letterDocumentid ORDER BY CreatedDate DESC LIMIT 1";
@Override
public Object[] letterDocumentData(String letterDocumentid) throws Exception {
	logger.info(new Date()+"Inside the letterDocumentData()");
	try {
		Query query=manager.createNativeQuery(SELLETTERDOCUMENTDATA);
		query.setParameter("letterDocumentid", letterDocumentid);
		return (Object[])query.getSingleResult();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside the letterDocumentData()",e);
		return null;
	}
}

private static final String LETTERATTACHMENTSFILEPATH="SELECT FilePath,FileName FROM dak_letter_doc WHERE LetterDocId=:result";
@Override
public List<Object[]> LetterAttachmentsFilePath(long result) throws Exception {
	logger.info(new Date() + "Inside LetterAttachmentsFilePath");
	try {
		Query query = manager.createNativeQuery(LETTERATTACHMENTSFILEPATH);
		query.setParameter("result", result);
		List<Object[]> LetterAttachmentsFilePath = (List<Object[]>) query.getResultList();
		return LetterAttachmentsFilePath;
	} catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() + "Inside DaoImpl LetterAttachmentsFilePath", e);
		return null;
	}
}
}
