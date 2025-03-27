package com.vts.dms.header.dao;

import java.util.List;

public interface HeaderDao {

	public List<Object[]> FormModuleList(String formroleid)throws Exception;
	public List<Object[]> loginTypeList()throws Exception;
	public List<Object[]> DashboardDemandCount()throws Exception;
	public List<Object[]> NotificationList(String Empid)throws Exception;
	public int NotificationUpdate(String NotificationId,String EmpId)throws Exception;
	public List<Object[]> NotificationAllList(String Empid)throws Exception;
	public List<Object[]> EmployeeDetailes(String LoginId)throws Exception;
	public String DivisionName(String DivisionId)throws Exception;
	public List<Object[]> getFormNameByName(String valueOf)throws Exception;
	public Boolean getRoleAccess(String logintype, String formModuleId)throws Exception;
}
