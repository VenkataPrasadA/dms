package com.vts.dms.dak.dto;

import java.util.ArrayList;
import java.util.List;

public class SmsDto {
	private String MobileNo;
	private List<Object[]> dakAndSourceAndDueDateList;
	
	public SmsDto(String MobileNo) {
        this.MobileNo = MobileNo;
        this.dakAndSourceAndDueDateList = new ArrayList<>();
    }
	
	 public String getMobileNo() {
	        return MobileNo;
	    }

	 public List<Object[]> getDakAndSourceAndDueDateList() {
	        return dakAndSourceAndDueDateList;
	    }

	    public void addDakAndSourceAndDueDate(String dakNo, String source, String actionDueDate) {
	    	dakAndSourceAndDueDateList.add(new Object[]{dakNo, source, actionDueDate});
	    }
}
