package com.vts.dms.login;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	
	@Autowired
	Environment env;
	
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,   HttpServletResponse response, Authentication authentication ) throws IOException  {
    	boolean status;
        
		try {
			Jws<Claims> claims = Jwts.parser().setSigningKey("vts-123").parseClaimsJws(env.getProperty("license"));
			status= true;
		} catch (SignatureException | MalformedJwtException | UnsupportedJwtException | IllegalArgumentException ex) {
			status= false;
		} catch (ExpiredJwtException ex) {
			status= false;
		}
    	 
    	 if(status) 
    		 response.sendRedirect(request.getContextPath()+"/welcome");	  
    	 else 
    		 response.sendRedirect(request.getContextPath()+"/accessdenied");	 
     
   }
    
    
    
    

}
