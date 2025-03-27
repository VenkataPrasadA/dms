package com.vts.dms.header.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.dms.header.dao.HeaderDao;
@Service
public class HeaderServiceImpl implements HeaderService {
	@Autowired
	HeaderDao dao;
	
	@Override
	public List<Object[]> FormModuleList(String formroleid)throws Exception {
		
		return dao.FormModuleList(formroleid);
	}
	@Override
	public List<Object[]> loginTypeList(String LoginType) throws Exception {
	List<Object[]>loginTypeList=dao.loginTypeList();
	List<Object[]>loginTypeListnew=new ArrayList<Object[]>();
	
	if(LoginType.equalsIgnoreCase("D")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("G")||obj[0].toString().equalsIgnoreCase("T")||obj[0].toString().equalsIgnoreCase("D")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	if(LoginType.equalsIgnoreCase("G")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("T")||obj[0].toString().equalsIgnoreCase("G")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	
	if(LoginType.equalsIgnoreCase("P")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("P")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	if(LoginType.equalsIgnoreCase("B")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("B")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}	
	
	
	if(LoginType.equalsIgnoreCase("O")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("O")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	
	
	if(LoginType.equalsIgnoreCase("S")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("G")||obj[0].toString().equalsIgnoreCase("T")||obj[0].toString().equalsIgnoreCase("S")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	

	if(LoginType.equalsIgnoreCase("C")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("G")||obj[0].toString().equalsIgnoreCase("T")||obj[0].toString().equalsIgnoreCase("C")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	
	
	if(LoginType.equalsIgnoreCase("M")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("M")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	if(LoginType.equalsIgnoreCase("R")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("R")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}	
	
	
	if(LoginType.equalsIgnoreCase("I")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("I")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	
	
	if(LoginType.equalsIgnoreCase("U")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("U")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	if(LoginType.equalsIgnoreCase("P")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("P")||obj[0].toString().equalsIgnoreCase("D")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	
	
	if(LoginType.equalsIgnoreCase("A")) {
	
				loginTypeListnew=loginTypeList;
		
	}
	
	return loginTypeListnew;
	}

	@Override
	public List<Object[]> DashboardDemandCount() throws Exception {
		
		return dao.DashboardDemandCount();
	}

	@Override
	public List<Object[]> NotificationList(String Empid) throws Exception {
	
		return dao.NotificationList(Empid);
	}

	@Override
	public int NotificationUpdate(String notificationurl,String EmpId) throws Exception {
		
		return dao.NotificationUpdate(notificationurl,EmpId);
	}

	@Override
	public List<Object[]> NotificationAllList(String Empid) throws Exception {
		
		return dao.NotificationAllList(Empid);
	}

	@Override
	public List<Object[]> EmployeeDetailes(String LoginId) throws Exception {
	
		return dao.EmployeeDetailes(LoginId);
	}

	@Override
	public String DivisionName(String DivisionId) throws Exception {
	
		return dao.DivisionName(DivisionId);
	}
	
	@Override
	public List<Object[]> getFormNameByName(String search) throws Exception {
		return dao.getFormNameByName(search);
	}
	@Override
	public Boolean getRoleAccess(String valueOf, String string) throws Exception {
		return dao.getRoleAccess(valueOf,string);
	}

}
