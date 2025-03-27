package com.vts.dms.header.dao;

import java.math.BigInteger;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;
@Transactional
@Repository
public class HeaderDaoImpl implements HeaderDao {
	
	private static final Logger logger=LogManager.getLogger(HeaderDaoImpl.class);

	private static final String FROMMODULELIST = "SELECT DISTINCT a.formmoduleid , a.formmodulename , a.moduleicon , a.moduleurl , a.serialno FROM dak_form_module a, dak_form_detail b, dak_form_role_access c WHERE a.isactive='1' AND a.formmoduleid=b.formmoduleid AND b.formdetailid=c.formdetailid AND c.formroleid=:formroleid order by a.serialno";
	private static final String LOGINTYPELIST = "select logintype,logindesc from login_type ";
	private static final String NOTIFICATIONLIST="select empid,notificationby,notificationdate,notificationmessage,notificationurl,notificationid from dak_notification where isactive='1' and empid=:empid ORDER BY notificationdate";
	private static final String NOTIFICATIONUPDATE="UPDATE dak_notification SET isactive='0' WHERE isactive='1' AND empid=:EmpId AND notificationurl=:notificationurl";
	private static final String NOTIFICATIONLISTALL ="SELECT empid,notificationby,notificationdate,notificationmessage,notificationurl FROM dak_notification WHERE  empid=:empid ORDER BY notificationdate";
	private static final String EMPDETAILES="SELECT b.empname, c.formrolename FROM login a,employee b,form_role c WHERE a.empid=b.empid AND a.formroleid=c.formroleid AND a.loginid=:loginid";
	private static final String DIVISIONNAME="select divisioncode from division_master where divisionid=:divisionid";
	
	@PersistenceContext
	EntityManager manager;

	@Override
	public List<Object[]> FormModuleList(String formroleid) throws Exception {
		Query query = manager.createNativeQuery(FROMMODULELIST);
		query.setParameter("formroleid", formroleid);
		List<Object[]> FormModuleList= query.getResultList();
		return FormModuleList;
	}

	@Override
	public List<Object[]> loginTypeList() throws Exception {
		Query query = manager.createNativeQuery(LOGINTYPELIST);
		List<Object[]> loginTypeList= query.getResultList();
		return loginTypeList;
	}

	@Override
	public List<Object[]> DashboardDemandCount() throws Exception {
		Query query=manager.createNativeQuery("CALL DashboardDemandCount()");
		List<Object[]> DashboardDemandCount=(List<Object[]>)query.getResultList();	
		return DashboardDemandCount;
	}

	@Override
	public List<Object[]> NotificationList(String Empid) throws Exception {
		Query query = manager.createNativeQuery(NOTIFICATIONLIST);
		query.setParameter("empid", Empid);
		List<Object[]> NotificationList= query.getResultList();
		return NotificationList;
	}

	@Override
	public int NotificationUpdate(String notificationurl,String EmpId) throws Exception {
		try {
		    Query query = manager.createNativeQuery(NOTIFICATIONUPDATE);
			query.setParameter("notificationurl", notificationurl);
			query.setParameter("EmpId", EmpId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside DAOImpl NotificationUpdate() "+ e);
			return 0;
		}
	}

	@Override
	public List<Object[]> NotificationAllList(String Empid) throws Exception {
		Query query = manager.createNativeQuery(NOTIFICATIONLISTALL);
		query.setParameter("empid", Empid);
		List<Object[]> NotificationList= query.getResultList();
		return NotificationList;
	}

	@Override
	public List<Object[]> EmployeeDetailes(String LoginId) throws Exception {
		Query query = manager.createNativeQuery(EMPDETAILES);
		query.setParameter("loginid", LoginId);
		List<Object[]> EmployeeDetailes= query.getResultList();
		return EmployeeDetailes;
	}

	@Override
	public String DivisionName(String DivisionId) throws Exception {
		Query query = manager.createNativeQuery(DIVISIONNAME);
		query.setParameter("divisionid", DivisionId);
		String DivisionName= (String) query.getSingleResult();
		return DivisionName;
	}

	@Override
	public List<Object[]> getFormNameByName(String search) throws Exception {
		Query query = manager.createNativeQuery("SELECT * FROM dak_form_detail WHERE REPLACE(formname,' ','') LIKE :search OR formname LIKE :search AND IsActive=1");
		query.setParameter("search", "%"+search+"%");
		return (List<Object[]>)query.getResultList();
	}

	@Override
	public Boolean getRoleAccess(String logintype, String formModuleId) throws Exception {
		System.out.println("logintype:"+logintype);
		System.out.println("formModuleId:"+formModuleId);
		Query query = manager.createNativeQuery("SELECT COUNT(FormRoleAccessId) FROM dak_form_role_access a,login b,dak_form_detail c WHERE a.FormRoleId=b.FormRoleId AND a.FormDetailId=c.FormDetailId AND b.LoginTypeDms=:logintype AND a.FormDetailId =:formModuleId AND c.Isactive=1");
		query.setParameter("logintype",logintype);
		query.setParameter("formModuleId", formModuleId);
		List<BigInteger> result = query.getResultList();
		if (result.get(0).intValue()==0)return false;
		else return true;
	}


}
