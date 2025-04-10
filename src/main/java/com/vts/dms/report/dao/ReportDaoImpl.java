package com.vts.dms.report.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.dms.dak.dao.DakDaoImpl;

@Transactional
@Repository

public class ReportDaoImpl implements ReportDao{

	  
		@PersistenceContext
		EntityManager manager;
		
		private static final Logger logger=LogManager.getLogger(DakDaoImpl.class);
		
		private static final String DAKSTATUSLIST="CALL Dms_DakStatus(:UserName,:LoginType,:EmpId,:fromDate,:toDate)";
		private static final String DAKTRACKINGLIST="SELECT a.dakId, a.dakno,a.Refno,a.Refdate,a.dakstatus,a.createdBy,a.createdDate,a.distributedDate,a.ActionId,a.ActionDueDate,a.SourceId,(SELECT b.CreatedBy FROM dak_pnc_reply b WHERE b.DakId=a.dakid) AS 'P&C',(SELECT b.CreatedDate FROM dak_pnc_reply b WHERE b.DakId=a.dakid) AS 'P&C CreatedDate',ClosedBy,ClosedDateTime,ApprovedBy,ApprovedDateTime,(SELECT MIN(b.DakAckDate) FROM dak_marking b WHERE b.DakId=a.dakid) AS 'FirstAckDate',(SELECT MIN(b.CreatedDate) FROM dak_reply b WHERE b.DakId=a.dakid) AS 'FirstReplyDate',(SELECT s.SourceShortName FROM dak_source_details s WHERE s.SourceDetailId=a.SourceDetailId)AS 'sourceShortName',a.ClosingAuthority,a.DirectorApproval,a.ForwardBy,a.ForwardDate,(SELECT MIN(s.CreatedDate) FROM dak_assign s WHERE s.DakId=a.DakId) AS 'FirstAssignDate',(SELECT MIN(r.CreatedDate) FROM dak_seekresponse r WHERE r.DakId=a.DakId) AS 'FirstSeekResponseDate' FROM dak a WHERE a.DakId=:dakid";
	    private static final String DAKTRACKINGPRINTLIST="CALL Dms_DakTrackingPrint(:dakid)";
        private static final String INITITATEDBYDETAILS ="SELECT a.EmpId,b.EmpName,c.Designation FROM login a, employee b, employee_desig c WHERE a.UserName=:initiatedBy AND a.EmpId=b.EmpId AND b.desigId=c.desigId";
        private static final String ACKNOWLEDGEDMEMBERSLIST = "SELECT b.dakId,b.EmpId,DakAckStatus,c.empName,d.designation,b.DakAckDate FROM dak a,dak_marking b,employee c, employee_desig d WHERE a.dakId=:dakId AND a.dakId=b.dakId  AND b.DakAckStatus='Y' AND b.empId=c.empId AND c.desigId=d.desigId";
        //private static final String DAKNOSEARCHIST = "CALL Dms_DakIdSearch(:dakno,:Username,:LoginType,:EmpId)";
        private static final String DAKNOSEARCHIST = "SELECT a.DakId,a.DakNo,c.SourceShortName,a.RefNo,a.RefDate,a.ActionDueDate,a.Subject,d.StatusDesc,CASE WHEN a.ProjectType = 'P' THEN (SELECT p.Projectcode FROM project_master p WHERE a.ProjectId = p.ProjectId) WHEN a.ProjectType = 'N' THEN (SELECT n.NonShortName FROM dak_non_project n WHERE a.ProjectId = n.NonProjectId)  WHEN a.ProjectType = 'O' THEN (SELECT o.ProjectCode FROM dak_others_project o WHERE a.ProjectId = o.ProjectOtherId) ELSE 'NA' END AS 'Projectcode' FROM dak a,dak_source_details c, dak_status d WHERE a.DakNo LIKE :dakno AND a.DakStatus=d.DakStatus AND a.SourceDetailId=c.SourceDetailId";
        //private static final String REFNOSEARCHIST = "CALL Dms_DakRefNoSearch(:refno,:Username,:LoginType,:EmpId)";
        private static final String REFNOSEARCHIST = "SELECT a.DakId,a.DakNo,c.SourceShortName,a.RefNo,a.RefDate,a.ActionDueDate,a.Subject,d.StatusDesc,CASE WHEN a.ProjectType = 'P' THEN (SELECT p.Projectcode FROM project_master p WHERE a.ProjectId = p.ProjectId) WHEN a.ProjectType = 'N' THEN (SELECT n.NonShortName FROM dak_non_project n WHERE a.ProjectId = n.NonProjectId)  WHEN a.ProjectType = 'O' THEN (SELECT o.ProjectCode FROM dak_others_project o WHERE a.ProjectId = o.ProjectOtherId) ELSE 'NA' END AS 'Projectcode' FROM dak a,dak_source_details c, dak_status d WHERE a.RefNo LIKE :refno AND a.DakStatus=d.DakStatus AND a.SourceDetailId=c.SourceDetailId";
      //  private static final String SUBJECTSEARCHIST = "CALL Dms_DakSubjectSearch(:subject,:Username,:LoginType,:EmpId)";
        private static final String SUBJECTSEARCHIST = "SELECT a.DakId,a.DakNo,c.SourceShortName,a.RefNo,a.RefDate,a.ActionDueDate,a.Subject,d.StatusDesc,CASE WHEN a.ProjectType = 'P' THEN (SELECT p.Projectcode FROM project_master p WHERE a.ProjectId = p.ProjectId) WHEN a.ProjectType = 'N' THEN (SELECT n.NonShortName FROM dak_non_project n WHERE a.ProjectId = n.NonProjectId)  WHEN a.ProjectType = 'O' THEN (SELECT o.ProjectCode FROM dak_others_project o WHERE a.ProjectId = o.ProjectOtherId) ELSE 'NA' END AS 'Projectcode' FROM dak a,dak_source_details c, dak_status d WHERE a.Subject LIKE :subject AND a.DakStatus=d.DakStatus AND a.SourceDetailId=c.SourceDetailId";
       // private static final String KEYWORDSEARCHIST = "CALL Dms_DakKeywordSearch(:keyword,:Username,:LoginType,:EmpId) ";
        private static final String KEYWORDSEARCHIST = "SELECT a.DakId,a.DakNo,c.SourceShortName,a.RefNo,a.RefDate,a.ActionDueDate,a.Subject,d.StatusDesc,CASE WHEN a.ProjectType = 'P' THEN (SELECT p.Projectcode FROM project_master p WHERE a.ProjectId = p.ProjectId) WHEN a.ProjectType = 'N' THEN (SELECT n.NonShortName FROM dak_non_project n WHERE a.ProjectId = n.NonProjectId)  WHEN a.ProjectType = 'O' THEN (SELECT o.ProjectCode FROM dak_others_project o WHERE a.ProjectId = o.ProjectOtherId) ELSE 'NA' END AS 'Projectcode' FROM dak a,dak_source_details c, dak_status d WHERE (a.KeyWord1 LIKE :keyword OR a.KeyWord2 LIKE :keyword OR a.KeyWord3 LIKE :keyword OR a.KeyWord4 LIKE :keyword) AND a.DakStatus=d.DakStatus AND a.SourceDetailId=c.SourceDetailId";
        private static final String REPLIEDMEMBERSLIST = "SELECT b.dakId,b.EmpId,b.ReplyStatus,c.empName,d.designation,b.CreatedDate,b.DakReplyId,(SELECT m.DakMarkingId FROM dak_marking m WHERE m.DakId=:dakId AND m.EmpId=b.EmpId) AS DakMarkingId, (SELECT CASE WHEN EXISTS (SELECT r.DakAssignId FROM dak_assign_reply r,dak_assign t,dak_marking g  WHERE r.DakId =:dakId AND r.DakAssignId=t.DakAssignId AND g.DakMarkingId=t.DakMarkingId AND g.EmpId=b.EmpId  )THEN (SELECT COUNT(r.DakAssignId) FROM dak_assign_reply r,dak_assign t,dak_marking g  WHERE r.DakId =:dakId AND r.DakAssignId=t.DakAssignId AND g.DakMarkingId=t.DakMarkingId AND g.EmpId=b.EmpId ) ELSE 0 END ) AS CountOfDakAssignReplyId FROM dak_reply b,employee c, employee_desig d WHERE b.dakId=:dakId AND b.empId=c.empId AND c.desigId=d.desigId";
        private static final String GETSOURCEDROPDOWN = "SELECT a.SourceDetailId,CONCAT(a.SourceShortName,'-',a.SourceName) AS 'Name',a.SourceShortName,a.SourceName FROM dak_source_details a";
        private static final String GETPROJECTDROPDOWN = "SELECT a.ProjectId,CONCAT(a.ProjectCode,'-',a.ProjectShortName) AS 'Name',a.ProjectCode,a.ProjectShortName,a.ProjectName FROM project_master a";
        private static final String GETNONPROJECTDROPDOWN = "SELECT a.NonProjectId,a.NonProjectName,a.NonShortName FROM dak_non_project a";
        private static final String GETOTHERPROJECTDROPDOWN = "SELECT a.ProjectOtherId,a.ProjectName,a.ProjectCode,a.ProjectShortName FROM dak_others_project a";
        private static final String FILTEREDLIST = "CALL Dms_DakFilter(:filterType,:selectedDetailsId,:fromDate,:toDate,:LoginType,:EmpId,:Username)";
        private static final String DAKGROUPINGLISTDROPDOWN="SELECT a.DakMemberTypeId,a.DakMemberType FROM dak_member_type a WHERE a.MemberTypeGrouping='Y'";
        private static final String DAKGROUPINGLIST="SELECT a.DakId,a.DakNo,a.Refno,a.dakstatus,a.Refdate,c.StatusDesc,a.ActionDueDate,b.DakMemberTypeId,b.EmpId,d.SourceShortName,CASE WHEN a.ProjectType = 'P' THEN (SELECT p.Projectcode FROM project_master p WHERE a.ProjectId = p.ProjectId)  WHEN a.ProjectType = 'N' THEN (SELECT n.NonShortName FROM dak_non_project n WHERE a.ProjectId = n.NonProjectId) WHEN a.ProjectType = 'O' THEN (SELECT o.ProjectCode FROM dak_others_project o WHERE a.ProjectId = o.ProjectOtherId) ELSE 'NA' END AS 'ProjectType',a.Subject,b.MarkerAction,e.EmpName,f.Designation,CASE WHEN b.DakAckStatus = 'Y' AND NOT EXISTS (SELECT 1 FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') THEN 'Acknowledged' WHEN EXISTS (SELECT 1 FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') THEN 'Replied' ELSE 'Distributed' END AS 'Status',b.DakMarkingId,(SELECT r.DakReplyId FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') AS 'DakReplyId', (SELECT CASE WHEN EXISTS (SELECT s.DakAssignId FROM dak_assign_reply s,dak_assign t,dak_marking g  WHERE s.DakId = a.dakId AND s.DakAssignId=t.DakAssignId AND g.DakMarkingId=t.DakMarkingId AND g.EmpId=b.EmpId  )THEN (SELECT COUNT(s.DakAssignId) FROM dak_assign_reply s,dak_assign t,dak_marking g  WHERE s.DakId = a.dakid AND s.DakAssignId=t.DakAssignId AND g.DakMarkingId=t.DakMarkingId AND g.EmpId=b.EmpId )ELSE 0 END ) AS CountOfDakAssignReplyId FROM dak a,dak_marking b,dak_status c,dak_source_details d,employee e,employee_desig f WHERE a.DakId=b.DakId AND a.SourceDetailId=d.SourceDetailId AND a.DakStatus=c.DakStatus AND b.DakMemberTypeId=:dakMemberTypeId AND e.EmpId=b.EmpId AND f.DesigId=e.DesigId AND b.EmpId=:empId AND (a.ReceiptDate BETWEEN :fromDate AND :toDate) AND b.IsActive='1'";
        private static final String INTIALDAKGROUPINGLIST="SELECT a.DakId, a.DakNo,a.Refno,a.dakstatus,a.Refdate,c.StatusDesc,a.ActionDueDate,b.DakMemberTypeId,b.EmpId,d.SourceShortName,CASE WHEN a.ProjectType = 'P' THEN p.Projectcode  WHEN a.ProjectType = 'N' THEN n.NonShortName   WHEN a.ProjectType = 'O' THEN o.ProjectCode  ELSE 'NA' END AS ProjectType, a.Subject, b.MarkerAction,e.EmpName,f.Designation,CASE WHEN b.DakAckStatus = 'Y' AND r.ReplyStatus IS NULL THEN 'Acknowledged'  WHEN r.ReplyStatus = 'R' THEN 'Replied'  ELSE 'Distributed' END AS STATUS,b.DakMarkingId,r.DakReplyId, COALESCE(dr.CountOfDakAssignReplyId, 0) AS CountOfDakAssignReplyId FROM dak a INNER JOIN dak_marking b ON a.DakId = b.DakId INNER JOIN dak_status c ON a.DakStatus = c.DakStatus INNER JOIN dak_source_details d ON a.SourceDetailId = d.SourceDetailId INNER JOIN employee e ON e.EmpId = b.EmpId INNER JOIN employee_desig f ON f.DesigId = e.DesigId INNER JOIN dak_member_type g ON b.DakMemberTypeId = g.dakMemberTypeId LEFT JOIN project_master p ON a.ProjectId = p.ProjectId AND a.ProjectType = 'P' LEFT JOIN dak_non_project n ON a.ProjectId = n.NonProjectId AND a.ProjectType = 'N' LEFT JOIN dak_others_project o ON a.ProjectId = o.ProjectOtherId AND a.ProjectType = 'O' LEFT JOIN ( SELECT DakId,EmpId, MAX(CASE WHEN ReplyStatus = 'R' THEN 'Replied' END) AS ReplyStatus,COUNT(DakAssignId) AS CountOfDakAssignReplyId FROM dak_assign_reply GROUP BY DakId, EmpId) dr ON a.DakId = dr.DakId AND b.EmpId = dr.EmpId LEFT JOIN dak_reply r ON b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R' WHERE a.ReceiptDate BETWEEN :fromDate AND :toDate AND g.MemberTypeGrouping='Y' AND b.IsActive = '1' ORDER BY a.DakId DESC";
        private static final String GROUPEMPLIST="SELECT e.EmpId,e.EmpName,d.Designation,f.DakMembersId,m.DakMemberTypeId FROM employee e,employee_desig d ,dak_members f,dak_member_type m WHERE e.EmpId=f.EmpId AND e.DesigId=d.DesigId AND f.DakMemberTypeId=m.DakMemberTypeId AND m.DakMemberTypeId=:dakMemberTypeId";
        private static final String GETLABCODE = "SELECT labcode FROM employee WHERE empid=:empId";
        private static final String STARTEMPLOYEELIST="SELECT a.EmpId, a.EmpName, b.Designation FROM employee a JOIN employee_desig b ON a.DesigId = b.DesigId WHERE a.LabCode = :lab ORDER BY CASE WHEN a.Srno = 0 THEN 1 ELSE 0 END, a.Srno ASC";	
        private static final String SELMEMBERTYPEDAKGROUPINGLIST="SELECT a.DakId,a.DakNo,a.Refno,a.dakstatus,a.Refdate,c.StatusDesc,a.ActionDueDate, b.DakMemberTypeId,b.EmpId,d.SourceShortName, CASE WHEN a.ProjectType = 'P' THEN p.Projectcode WHEN a.ProjectType = 'N' THEN n.NonShortName WHEN a.ProjectType = 'O' THEN o.ProjectCode ELSE 'NA' END AS 'ProjectType',a.Subject,b.MarkerAction, e.EmpName, f.Designation, CASE  WHEN b.DakAckStatus = 'Y' AND NOT EXISTS (SELECT 1 FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') THEN 'Acknowledged' WHEN EXISTS (SELECT 1 FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') THEN 'Replied' ELSE 'Distributed' END AS 'Status', b.DakMarkingId,(SELECT r.DakReplyId FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') AS 'DakReplyId',(SELECT CASE  WHEN EXISTS ( SELECT 1  FROM dak_assign_reply s  JOIN dak_assign t ON s.DakAssignId = t.DakAssignId  JOIN dak_marking g ON g.DakMarkingId = t.DakMarkingId  WHERE s.DakId = a.dakId AND g.EmpId = b.EmpId)THEN (SELECT COUNT(s.DakAssignId) FROM dak_assign_reply s  JOIN dak_assign t ON s.DakAssignId = t.DakAssignId  JOIN dak_marking g ON g.DakMarkingId = t.DakMarkingId  WHERE s.DakId = a.dakid AND g.EmpId = b.EmpId) ELSE 0 END) AS CountOfDakAssignReplyId FROM dak a JOIN dak_marking b ON a.DakId = b.DakId JOIN dak_status c ON a.DakStatus = c.DakStatus JOIN dak_source_details d ON a.SourceDetailId = d.SourceDetailId JOIN employee e ON e.EmpId = b.EmpId JOIN employee_desig f ON f.DesigId = e.DesigId LEFT JOIN project_master p ON a.ProjectId = p.ProjectId AND a.ProjectType = 'P' LEFT JOIN dak_non_project n ON a.ProjectId = n.NonProjectId AND a.ProjectType = 'N' LEFT JOIN dak_others_project o ON a.ProjectId = o.ProjectOtherId AND a.ProjectType = 'O' WHERE b.DakMemberTypeId = :dakMemberTypeId AND (a.ReceiptDate BETWEEN :fromDate AND :toDate) AND b.IsActive = '1' ORDER BY a.DakId DESC";
        private static final String SELMEMBERTYPEEMPLOYEELIST="SELECT DISTINCT a.EmpId, a.EmpName, b.Designation FROM employee a JOIN employee_desig b ON a.DesigId = b.DesigId JOIN dak_members c ON a.EmpId = c.EmpId WHERE c.DakMemberTypeId = :selDakMemberTypeId AND a.LabCode = :lab ";
        private static final String SELEMPLOYEETYPEDAKGROUPINGLIST="SELECT a.DakId,a.DakNo,a.Refno,a.dakstatus,a.Refdate,c.StatusDesc, a.ActionDueDate, b.DakMemberTypeId, b.EmpId, d.SourceShortName,CASE  WHEN a.ProjectType = 'P' THEN p.Projectcode WHEN a.ProjectType = 'N' THEN n.NonShortName WHEN a.ProjectType = 'O' THEN o.ProjectCode ELSE 'NA' END AS 'ProjectType',a.Subject, b.MarkerAction, e.EmpName,f.Designation, CASE  WHEN b.DakAckStatus = 'Y' AND NOT EXISTS (SELECT 1 FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') THEN 'Acknowledged' WHEN EXISTS (SELECT 1 FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') THEN 'Replied' ELSE 'Distributed' END AS 'Status',b.DakMarkingId, (SELECT r.DakReplyId FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') AS 'DakReplyId',(SELECT CASE WHEN EXISTS ( SELECT 1  FROM dak_assign_reply s  JOIN dak_assign t ON s.DakAssignId = t.DakAssignId  JOIN dak_marking g ON g.DakMarkingId = t.DakMarkingId   WHERE s.DakId = a.dakId AND g.EmpId = b.EmpId)THEN (SELECT COUNT(s.DakAssignId) FROM dak_assign_reply s JOIN dak_assign t ON s.DakAssignId = t.DakAssignId JOIN dak_marking g ON g.DakMarkingId = t.DakMarkingId WHERE s.DakId = a.dakid AND g.EmpId = b.EmpId)ELSE 0 END) AS CountOfDakAssignReplyId FROM dak a JOIN dak_marking b ON a.DakId = b.DakId JOIN dak_status c ON a.DakStatus = c.DakStatus JOIN dak_source_details d ON a.SourceDetailId = d.SourceDetailId JOIN employee e ON e.EmpId = b.EmpId JOIN employee_desig f ON f.DesigId = e.DesigId JOIN dak_member_type g ON b.DakMemberTypeId=g.DakMemberTypeId LEFT JOIN project_master p ON a.ProjectId = p.ProjectId AND a.ProjectType = 'P' LEFT JOIN dak_non_project n ON a.ProjectId = n.NonProjectId AND a.ProjectType = 'N' LEFT JOIN dak_others_project o ON a.ProjectId = o.ProjectOtherId AND a.ProjectType = 'O' WHERE b.EmpId = :selEmpId AND g.MemberTypeGrouping='Y' AND (a.ReceiptDate BETWEEN :fromDate AND :toDate) AND b.IsActive = '1' ORDER BY a.DakId DESC";
        private static final String SELEMPLOYEEMEMBERTYPEDAKGROUPINGLIST="SELECT a.DakId,a.DakNo,a.Refno,a.dakstatus,a.Refdate,c.StatusDesc,a.ActionDueDate, b.DakMemberTypeId,b.EmpId,d.SourceShortName, CASE WHEN a.ProjectType = 'P' THEN p.Projectcode WHEN a.ProjectType = 'N' THEN n.NonShortName WHEN a.ProjectType = 'O' THEN o.ProjectCode ELSE 'NA' END AS 'ProjectType',a.Subject,b.MarkerAction, e.EmpName, f.Designation, CASE  WHEN b.DakAckStatus = 'Y' AND NOT EXISTS (SELECT 1 FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') THEN 'Acknowledged' WHEN EXISTS (SELECT 1 FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') THEN 'Replied' ELSE 'Distributed' END AS 'Status', b.DakMarkingId,(SELECT r.DakReplyId FROM dak_reply r WHERE b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R') AS 'DakReplyId',(SELECT CASE  WHEN EXISTS ( SELECT 1  FROM dak_assign_reply s  JOIN dak_assign t ON s.DakAssignId = t.DakAssignId  JOIN dak_marking g ON g.DakMarkingId = t.DakMarkingId  WHERE s.DakId = a.dakId AND g.EmpId = b.EmpId)THEN (SELECT COUNT(s.DakAssignId) FROM dak_assign_reply s  JOIN dak_assign t ON s.DakAssignId = t.DakAssignId  JOIN dak_marking g ON g.DakMarkingId = t.DakMarkingId  WHERE s.DakId = a.dakid AND g.EmpId = b.EmpId) ELSE 0 END) AS CountOfDakAssignReplyId FROM dak a JOIN dak_marking b ON a.DakId = b.DakId JOIN dak_status c ON a.DakStatus = c.DakStatus JOIN dak_source_details d ON a.SourceDetailId = d.SourceDetailId JOIN employee e ON e.EmpId = b.EmpId JOIN employee_desig f ON f.DesigId = e.DesigId LEFT JOIN project_master p ON a.ProjectId = p.ProjectId AND a.ProjectType = 'P' LEFT JOIN dak_non_project n ON a.ProjectId = n.NonProjectId AND a.ProjectType = 'N' LEFT JOIN dak_others_project o ON a.ProjectId = o.ProjectOtherId AND a.ProjectType = 'O' WHERE b.DakMemberTypeId = :selDakMemberTypeId AND b.EmpId = :selEmpId AND (a.ReceiptDate BETWEEN :fromDate AND :toDate) AND b.IsActive = '1' ORDER BY a.DakId DESC";
        private static final String SELPROJECTLIST = "SELECT projectid,projectcode,ProjectShortName from project_master where isactive='1' AND LabCode=:lab";
        private static final String ALLPROJECTWISELIST="SELECT a.DakId, a.DakNo,a.Refno,a.dakstatus,a.Refdate,c.StatusDesc,a.ActionDueDate,b.DakMemberTypeId,b.EmpId,d.SourceShortName,CASE WHEN a.ProjectType = 'P' THEN p.Projectcode ELSE 'NA' END AS ProjectType,a.Subject, b.MarkerAction,e.EmpName,f.Designation,CASE WHEN b.DakAckStatus = 'Y' AND r.ReplyStatus IS NULL THEN 'Acknowledged' WHEN r.ReplyStatus = 'R' THEN 'Replied'  ELSE 'Distributed' END AS STATUS,b.DakMarkingId,r.DakReplyId, COALESCE(dr.CountOfDakAssignReplyId, 0) AS CountOfDakAssignReplyId FROM dak a INNER JOIN dak_marking b ON a.DakId = b.DakId INNER JOIN dak_status c ON a.DakStatus = c.DakStatus INNER JOIN dak_source_details d ON a.SourceDetailId = d.SourceDetailId INNER JOIN employee e ON e.EmpId = b.EmpId INNER JOIN employee_desig f ON f.DesigId = e.DesigId LEFT JOIN project_master p ON a.ProjectId = p.ProjectId AND a.ProjectType = 'P' LEFT JOIN ( SELECT DakId,EmpId, MAX(CASE WHEN ReplyStatus = 'R' THEN 'Replied' END) AS ReplyStatus,COUNT(DakAssignId) AS CountOfDakAssignReplyId FROM dak_assign_reply GROUP BY DakId, EmpId) dr ON a.DakId = dr.DakId AND b.EmpId = dr.EmpId LEFT JOIN dak_reply r ON b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R' WHERE a.ReceiptDate BETWEEN :fromDate AND :toDate AND a.ProjectType='P' AND  b.IsActive = '1' ORDER BY a.DakId DESC";
        private static final String SELECTEDPROJECTWISELIST="SELECT a.DakId, a.DakNo,a.Refno,a.dakstatus,a.Refdate,c.StatusDesc,a.ActionDueDate,b.DakMemberTypeId,b.EmpId,d.SourceShortName,CASE WHEN a.ProjectType = 'P' THEN p.Projectcode ELSE 'NA' END AS ProjectType,a.Subject, b.MarkerAction,e.EmpName,f.Designation,CASE WHEN b.DakAckStatus = 'Y' AND r.ReplyStatus IS NULL THEN 'Acknowledged' WHEN r.ReplyStatus = 'R' THEN 'Replied'  ELSE 'Distributed' END AS STATUS,b.DakMarkingId,r.DakReplyId, COALESCE(dr.CountOfDakAssignReplyId, 0) AS CountOfDakAssignReplyId FROM dak a INNER JOIN dak_marking b ON a.DakId = b.DakId INNER JOIN dak_status c ON a.DakStatus = c.DakStatus INNER JOIN dak_source_details d ON a.SourceDetailId = d.SourceDetailId INNER JOIN employee e ON e.EmpId = b.EmpId INNER JOIN employee_desig f ON f.DesigId = e.DesigId LEFT JOIN project_master p ON a.ProjectId = p.ProjectId AND a.ProjectType = 'P' LEFT JOIN ( SELECT DakId,EmpId, MAX(CASE WHEN ReplyStatus = 'R' THEN 'Replied' END) AS ReplyStatus,COUNT(DakAssignId) AS CountOfDakAssignReplyId FROM dak_assign_reply GROUP BY DakId, EmpId) dr ON a.DakId = dr.DakId AND b.EmpId = dr.EmpId LEFT JOIN dak_reply r ON b.DakId = r.DakId AND b.EmpId = r.EmpId AND r.ReplyStatus = 'R' WHERE a.ReceiptDate BETWEEN :fromDate AND :toDate AND a.ProjectType='P' AND a.ProjectId=:projectTypeId AND  b.IsActive = '1' ORDER BY a.DakId DESC";
        private static final String SMSREPORTLIST="SELECT e.EmpName,d.Designation,a.DakPendingCount,a.DakUrgentCount,a.DakTodayPending,a.DakDelayCount,e.MobileNo,a.Message,DATE(a.SmsSentDate) FROM dak_sms_track_insights a,employee e,employee_desig d WHERE a.EmpId=e.EmpId AND e.DesigId=d.DesigId AND DATE(a.SmsSentDate) BETWEEN :fromDate AND :toDate";
        private static final String DAKPENDINGREPORTLIST="SELECT a.DakId,a.DakNo,a.RefNo,a.RefDate,a.ReceiptDate, a.Subject,a.ActionDueDate,b.SourceShortName,c.StatusDesc FROM dak a,dak_source_details b,dak_status c WHERE a.ActionId='2' AND a.ReceiptDate IS NOT NULL AND DATE(a.ReceiptDate)>='2023-12-01' AND  a.DakStatus  IN('DD','DA') AND a.DakId NOT IN (SELECT r.DakId FROM dak_reply r WHERE r.DakId=a.DakId) AND a.SourceDetailId=b.SourceDetailId AND a.DakStatus=c.DakStatus";
        
        @Override         
		public List<Object[]> DakStatusList(String Username,String LoginType,long EmpId,String fromDate,String toDate) throws Exception {
			logger.info(new Date() +"Inside DAO DakStatusList");
			Query query =manager.createNativeQuery(DAKSTATUSLIST);
			query.setParameter("UserName", Username);
			query.setParameter("LoginType", LoginType);
			query.setParameter("EmpId", EmpId);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			List<Object[]> resultList = new ArrayList<Object[]>();		
			resultList = (List<Object[]>)query.getResultList();				
			return resultList;
		}
		
		@Override
		public List<Object[]> DakTrackingList(String DakId) throws Exception {
			logger.info(new Date() +"Inside DAOImpl DakTrackingList");
			try {
			Query query =manager.createNativeQuery(DAKTRACKINGLIST);
			query.setParameter("dakid",DakId );
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>)query.getResultList();				
			return resultList;
			
			  }catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl DakTrackingList error "+e);
				e.printStackTrace();
				return null;
			}
		}
		
		@Override
		public List<Object[]> DakTrackingPrintList(String DakId) throws Exception {
			logger.info(new Date() +"Inside DAOImpl DakTrackingPrintList");
			try {
			Query query =manager.createNativeQuery(DAKTRACKINGPRINTLIST);
			query.setParameter("dakid",DakId );
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>)query.getResultList();				
			return resultList;
			  }catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl DakTrackingPrintList error "+e);
				e.printStackTrace();
				return null;
			}
		}
		
		
		@Override
		public List<Object[]> GetCreatedByDetails(String InitiatedBy) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetCreatedByDetails");
			try {
			Query query =manager.createNativeQuery(INITITATEDBYDETAILS);
			query.setParameter("initiatedBy",InitiatedBy );
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetCreatedByDetails() error"+e);
				e.printStackTrace();
				return null;
			}
		}
		
		
		@Override
		public List<Object[]> GeAcknowledgedMembersList(String DakId) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GeAcknowledgedMembersList");
			try {
			Query query =manager.createNativeQuery(ACKNOWLEDGEDMEMBERSLIST);
			query.setParameter("dakId",DakId );
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GeAcknowledgedMembersList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		
		@Override
		public List<Object[]> GetDakNoSearchDetailsList(String DakNo,long EmpId,String Username,String LoginType) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetDakNoSearchDetailsList");
			try {
			System.out.println("CALL Dms_DakIdSearch('"+DakNo+"','"+Username+"','"+LoginType+"','"+EmpId+"');");
			Query query =manager.createNativeQuery(DAKNOSEARCHIST);
			query.setParameter("dakno","%"+DakNo+"%");
			//query.setParameter("dakno",DakNo );
			//query.setParameter("LoginType",LoginType );
			//query.setParameter("Username",Username );
			//query.setParameter("EmpId",EmpId );
			  List<Object[]> resultList = new ArrayList<Object[]>();
		        resultList = (List<Object[]>) query.getResultList();
		         return resultList;
		      
			  }catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetDakNoSearchDetailsList error "+e);
				e.printStackTrace();
				return null;
			}
		}
		

		@Override
		public List<Object[]> GetRefNoSearchDetailsList(String RefNo,long EmpId,String Username,String LoginType) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetRefNoSearchDetailsList");
			try {
			Query query =manager.createNativeQuery(REFNOSEARCHIST);
			query.setParameter("refno","%"+RefNo+"%" );
			//query.setParameter("refno",RefNo );
			//query.setParameter("LoginType",LoginType );
			//query.setParameter("Username",Username );
			//query.setParameter("EmpId",EmpId );
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>)query.getResultList();				
			return resultList;
			
			  }catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetRefNoSearchDetailsList error "+e);
				e.printStackTrace();
				return null;
			}
		}
		
		@Override
		public List<Object[]> GetSubjectSearchDetailsList(String Subject,long EmpId,String Username,String LoginType) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetSubjectSearchDetailsList");
			try {
			Query query =manager.createNativeQuery(SUBJECTSEARCHIST);
			query.setParameter("subject","%"+Subject+"%" );
			//query.setParameter("subject",Subject );
			//query.setParameter("LoginType",LoginType );
			//query.setParameter("Username",Username );
			//query.setParameter("EmpId",EmpId );
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>)query.getResultList();				
			return resultList;
			
			  }catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetSubjectSearchDetailsList error "+e);
				e.printStackTrace();
				return null;
			}
		}
		
		@Override
		public List<Object[]> GetKeywordsSearchDetailsList(String Keyword,long EmpId,String Username,String LoginType) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetKeywordsSearchDetailsList");
			try {
			Query query =manager.createNativeQuery(KEYWORDSEARCHIST);
			query.setParameter("keyword","%"+Keyword+"%" );
			//query.setParameter("keyword",Keyword );
			//query.setParameter("LoginType",LoginType );
			//query.setParameter("Username",Username );
			//query.setParameter("EmpId",EmpId );
			List<Object[]> resultList = new ArrayList<Object[]>();
			resultList = (List<Object[]>)query.getResultList();				
			return resultList;
			
			  }catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetKeywordsSearchDetailsList error "+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> GetRepliedMembersList(String dakId) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetRepliedMembersList");
			try {
			Query query =manager.createNativeQuery(REPLIEDMEMBERSLIST);
			query.setParameter("dakId",dakId );
			List<Object[]> resultList =(List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetRepliedMembersList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> GetSourceDropDown() throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetSourceDropDown");
			try {
			Query query =manager.createNativeQuery(GETSOURCEDROPDOWN);
			List<Object[]> resultList =(List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetSourceDropDown() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> GetProjectDropDown() throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetProjectDropDown");
			try {
			Query query =manager.createNativeQuery(GETPROJECTDROPDOWN);
			List<Object[]> resultList =(List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetProjectDropDown() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> GetNonProjectDropDown() throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetNonProjectDropDown");
			try {
			Query query =manager.createNativeQuery(GETNONPROJECTDROPDOWN);
			List<Object[]> resultList =(List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetNonProjectDropDown() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> GetOtherProjectDropDown() throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetOtherProjectDropDown");
			try {
			Query query =manager.createNativeQuery(GETOTHERPROJECTDROPDOWN);
			List<Object[]> resultList =(List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetOtherProjectDropDown() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> GetDakFilteredList(String filterType, String selectedDetailsId, String fromDate,String toDate,String LoginType,long EmpId,String Username) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetDakFilteredList");
			try {
			System.out.println("CALL Dms_DakFilter('"+filterType+"','"+selectedDetailsId+"','"+fromDate+"','"+toDate+"','"+LoginType+"','"+EmpId+"','"+Username+"');");
			Query query =manager.createNativeQuery(FILTEREDLIST);   
			query.setParameter("filterType", filterType);
			query.setParameter("selectedDetailsId", selectedDetailsId);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			query.setParameter("LoginType", LoginType);
			query.setParameter("EmpId", EmpId);
			query.setParameter("Username", Username);
			List<Object[]> resultList =(List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetDakFilteredList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> DakGroupingListDropDown() throws Exception {
			logger.info(new Date() +"Inside DAOImpl DakGroupingListDropDown");
			try {
			Query query =manager.createNativeQuery(DAKGROUPINGLISTDROPDOWN);
			List<Object[]> DakGroupingListDropDown =(List<Object[]>)query.getResultList();				
			return DakGroupingListDropDown;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl DakGroupingListDropDown() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> DakGroupingList(long dakMemberTypeId, long empId,String fromDate,String toDate) throws Exception {
			logger.info(new Date() +"Inside DAOImpl DakGroupingList");
			try {
			Query query =manager.createNativeQuery(DAKGROUPINGLIST);
			query.setParameter("dakMemberTypeId", dakMemberTypeId);
			query.setParameter("empId", empId);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			List<Object[]> DakGroupingList =(List<Object[]>)query.getResultList();				
			return DakGroupingList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl DakGroupingList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> intialDakGroupingList(String fromDate,String toDate) throws Exception {
			logger.info(new Date() +"Inside DAOImpl intialDakGroupingList");
			try {
			Query query =manager.createNativeQuery(INTIALDAKGROUPINGLIST);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			List<Object[]> intialDakGroupingList =(List<Object[]>)query.getResultList();				
			return intialDakGroupingList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl intialDakGroupingList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> GroupEmpList(long dakMemberTypeId) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GroupEmpList");
			try {
			Query query =manager.createNativeQuery(GROUPEMPLIST);
			query.setParameter("dakMemberTypeId", dakMemberTypeId);
			List<Object[]> GroupEmpList =(List<Object[]>)query.getResultList();				
			return GroupEmpList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GroupEmpList() error"+e);
				e.printStackTrace();
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
		public List<Object[]> StartEmployeeList(String lab) throws Exception {
			logger.info(new Date() +"Inside DAOImpl StartEmployeeList");
			try {
			Query query =manager.createNativeQuery(STARTEMPLOYEELIST);
			query.setParameter("lab", lab);
			List<Object[]> StartEmployeeList =(List<Object[]>)query.getResultList();				
			return StartEmployeeList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl StartEmployeeList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> SelMemberTypeDakGroupingList(String selDakMemberTypeId, String fromDate, String toDate)throws Exception {
			logger.info(new Date() +"Inside DAOImpl SelMemberTypeDakGroupingList");
			try {
			Query query =manager.createNativeQuery(SELMEMBERTYPEDAKGROUPINGLIST);
			query.setParameter("dakMemberTypeId", selDakMemberTypeId);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			List<Object[]> SelMemberTypeDakGroupingList =(List<Object[]>)query.getResultList();				
			return SelMemberTypeDakGroupingList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl SelMemberTypeDakGroupingList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> SelMemberTypeEmployeeList(String selDakMemberTypeId, String lab) throws Exception {
			logger.info(new Date() +"Inside DAOImpl SelMemberTypeEmployeeList");
			try {
			Query query =manager.createNativeQuery(SELMEMBERTYPEEMPLOYEELIST);
			query.setParameter("selDakMemberTypeId", selDakMemberTypeId);
			query.setParameter("lab", lab);
			List<Object[]> StartEmployeeList =(List<Object[]>)query.getResultList();				
			return StartEmployeeList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl SelMemberTypeEmployeeList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> SelEmployeeTypeDakGroupingList(String selEmpId, String fromDate, String toDate)throws Exception {
			logger.info(new Date() +"Inside DAOImpl SelEmployeeTypeDakGroupingList");
			try {
			Query query =manager.createNativeQuery(SELEMPLOYEETYPEDAKGROUPINGLIST);
			query.setParameter("selEmpId", selEmpId);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			List<Object[]> SelEmployeeTypeDakGroupingList =(List<Object[]>)query.getResultList();				
			return SelEmployeeTypeDakGroupingList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl SelEmployeeTypeDakGroupingList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> SelEmployeeMemberTypeDakGroupingList(String selDakMemberTypeId, String selEmpId,String fromDate, String toDate) throws Exception {
			logger.info(new Date() +"Inside DAOImpl SelEmployeeMemberTypeDakGroupingList");
			try {
			Query query =manager.createNativeQuery(SELEMPLOYEEMEMBERTYPEDAKGROUPINGLIST);
			query.setParameter("selDakMemberTypeId", selDakMemberTypeId);
			query.setParameter("selEmpId", selEmpId);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			List<Object[]> SelEmployeeMemberTypeDakGroupingList =(List<Object[]>)query.getResultList();				
			return SelEmployeeMemberTypeDakGroupingList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl SelEmployeeMemberTypeDakGroupingList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> SelProjectTypeList(String lab) throws Exception {
			logger.info(new Date() + "Inside DAO SelProjectTypeList");
			try {
				Query query = manager.createNativeQuery(SELPROJECTLIST);
				query.setParameter("lab", lab);
				List<Object[]> resultList = new ArrayList<Object[]>();
				resultList = (List<Object[]>) query.getResultList();
				return resultList;
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() + "Inside DaoImpl SelProjectTypeList", e);
				return null;
			}
		}

		@Override
		public List<Object[]> AllProjectWiseList(String fromDate, String toDate) throws Exception {
			logger.info(new Date() +"Inside DAOImpl AllProjectWiseList");
			try {
			Query query =manager.createNativeQuery(ALLPROJECTWISELIST);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			List<Object[]> AllProjectWiseList =(List<Object[]>)query.getResultList();				
			return AllProjectWiseList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl AllProjectWiseList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> SelectedProjectWiseList(String projectTypeId, String fromDate, String toDate)throws Exception {
			logger.info(new Date() +"Inside DAOImpl SelectedProjectWiseList");
			try {
			Query query =manager.createNativeQuery(SELECTEDPROJECTWISELIST);
			query.setParameter("projectTypeId", projectTypeId);
			query.setParameter("fromDate", fromDate);
			query.setParameter("toDate", toDate);
			List<Object[]> SelectedProjectWiseList =(List<Object[]>)query.getResultList();				
			return SelectedProjectWiseList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl SelectedProjectWiseList() error"+e);
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public List<Object[]> SmsReportList(String fromDate, String toDate) throws Exception {
			logger.info(new Date() +"Inside the SmsReportList");
			try {
				Query query=manager.createNativeQuery(SMSREPORTLIST);
				query.setParameter("fromDate", fromDate);
				query.setParameter("toDate", toDate);
				List<Object[]> smsreportlist=(List<Object[]>)query.getResultList();
				return smsreportlist;
			} catch (Exception e) {
				logger.error(new Date()+"Inside the SmsReportList");
				e.printStackTrace();
				return null;
			}
			
		}
		
		@Override
		public List<Object[]> dakPendingReportList() throws Exception {
			logger.info(new Date() +"Inside the dakPendingReportList");
			try {
				Query query=manager.createNativeQuery(DAKPENDINGREPORTLIST);
				List<Object[]> dakPendingReportList=(List<Object[]>)query.getResultList();
				return dakPendingReportList;
			} catch (Exception e) {
				logger.error(new Date()+"Inside the dakPendingReportList");
				e.printStackTrace();
				return null;
			}
		}
		
		private static final String HANDINGOVERLIST="SELECT h.HolidayDate,h.HolidayName FROM pfms_holiday_master h WHERE h.HolidayType='G' AND h.IsActive='1'";
		@Override
		public List<Object[]> holidayDateList() throws Exception {
			try {
				Query query=manager.createNativeQuery(HANDINGOVERLIST);
				return (List<Object[]>)query.getResultList();
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
		
		
		private static final String GETACKNOWLEDGEMEMBERLIST="SELECT b.dakId,b.EmpId,DakAckStatus,c.empName,d.designation FROM dak a,dak_marking b,employee c, employee_desig d WHERE a.dakId=:selDakId AND a.dakId=b.dakId AND b.empId=c.empId AND c.desigId=d.desigId";
		@Override
		public List<Object[]> GetAcknowledgeMembersList(String selDakId) throws Exception {
			try {
				Query query=manager.createNativeQuery(GETACKNOWLEDGEMEMBERLIST);
				query.setParameter("selDakId", selDakId);
				return (List<Object[]>)query.getResultList();
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
		
		
		private static final String REPLYMEMBERSLIST="SELECT b.dakId,b.EmpId,c.empName,d.designation FROM dak_marking b,employee c, employee_desig d WHERE b.dakId=:replydakId AND b.empId=c.empId AND c.desigId=d.desigId";
		@Override
		public List<Object[]> GetReplyMembersList(String replydakId) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetRepliedMembersList");
			try {
			Query query =manager.createNativeQuery(REPLYMEMBERSLIST);
			query.setParameter("replydakId",replydakId );
			List<Object[]> resultList =(List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetRepliedMembersList() error"+e);
				e.printStackTrace();
				return null;
			}
		}
		
		private static final String GETASSIGNEDMEMBERSLIST="SELECT b.dakId,b.EmpId,c.empName,d.designation,b.CreatedDate FROM dak a,dak_assign b,employee c, employee_desig d WHERE a.dakId=:dakId AND a.dakId=b.dakId AND b.empId=c.empId AND c.desigId=d.desigId";
		@Override
		public List<Object[]> GetAssignedMembersList(String dakId) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GeAssignedMembersList");
			try {
			Query query =manager.createNativeQuery(GETASSIGNEDMEMBERSLIST);
			query.setParameter("dakId",dakId );
			List<Object[]> resultList =(List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GeAssignedMembersList() error"+e);
				e.printStackTrace();
				return null;
			}
		}
		
		
		
		private static final String GETSEEKRESPONSEMEMBERLIST="SELECT b.dakId,b.SeekEmpId,c.empName,d.designation,b.CreatedDate FROM dak a,dak_seekresponse b,employee c, employee_desig d WHERE a.dakId=:dakId AND a.dakId=b.dakId AND b.SeekEmpId=c.empId AND c.desigId=d.desigId";
		@Override
		public List<Object[]> GetSeekRepsonseMembersList(String dakId) throws Exception {
			logger.info(new Date() +"Inside DAOImpl GetSeekRepsonseMembersList");
			try {
			Query query =manager.createNativeQuery(GETSEEKRESPONSEMEMBERLIST);
			query.setParameter("dakId",dakId );
			List<Object[]> resultList =(List<Object[]>)query.getResultList();				
			return resultList;
			}catch (Exception e){
				  logger.error(new Date() + "Inside DAOImpl GetSeekRepsonseMembersList() error"+e);
				e.printStackTrace();
				return null;
			}
		}
		
}


