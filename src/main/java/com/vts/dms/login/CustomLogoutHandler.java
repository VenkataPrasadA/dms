package com.vts.dms.login;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import com.vts.dms.service.DmsService;




public class CustomLogoutHandler  implements LogoutHandler  {


	@Autowired
	DmsService mainservice;
	
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		 HttpSession ses=request.getSession();
		 try {
       	  String LogId = ((Long) ses.getAttribute("LoginId")).toString();
       	  mainservice.LoginStampingUpdate(LogId, "L");
       	}
       	catch (Exception e) {
				e.printStackTrace();
			}	
	}
	
	
}
