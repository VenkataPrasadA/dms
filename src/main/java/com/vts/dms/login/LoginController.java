package com.vts.dms.login;

import java.util.Date;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

//import io.jsonwebtoken.Claims;
//import io.jsonwebtoken.ExpiredJwtException;
//import io.jsonwebtoken.Jws;
//import io.jsonwebtoken.Jwts;
//import io.jsonwebtoken.MalformedJwtException;
//import io.jsonwebtoken.SignatureException;
//import io.jsonwebtoken.UnsupportedJwtException;


@Controller
public class LoginController 
{

	private static final Logger logger=LogManager.getLogger(LoginController.class);
	@Autowired
	LoginRepository Repository;
    
	@Autowired
    private Environment env;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	 public String login(@RequestHeader(name = "User-Agent") String userAgent,
			 						Model model, @RequestParam(value = "error", required=false) String error,
			 						@RequestParam(value = "logout", required=false) String logout, 
			 						@RequestParam(value = "session", required=false) String session,
			 						HttpServletRequest req,HttpSession ses,HttpServletResponse response) 
	 {	 String browser = req.getHeader("user-agent");
		String[] br = browser.split("\\)");
		String version = "";
		userAgent = br[br.length - 1];
		
		if (userAgent.contains("Chrome")) {
			browser = "Chrome";
			version = userAgent.substring(userAgent.indexOf("Chrome/") + 7);
		} else if (userAgent.contains("Firefox")) {
			browser = "Firefox";
			version = userAgent.substring(userAgent.indexOf("Firefox/") + 8);
		} else if (userAgent.contains("MSIE")) {
			browser = "Internet Explorer";
			version = userAgent.substring(userAgent.indexOf("MSIE") + 5);
		} else if (userAgent.contains("Trident")) {
			browser = "Internet Explorer";
			version = userAgent.substring(userAgent.indexOf("rv:") + 3);
		} else if (userAgent.contains("Edge")) {
			browser = "Edge";
			version = userAgent.substring(userAgent.indexOf("Edge/") + 5);
		} else if (userAgent.contains("Safari")) {
			browser = "Safari";
			version = userAgent.substring(userAgent.indexOf("Version/") + 8);
		}
       
        if(version!="")
        {
        	if (Integer.parseInt(version.substring(0, version.indexOf('.'))) < 110) {
    			System.out.println(Integer.parseInt(version.substring(0, version.indexOf('.'))));
    			req.setAttribute("browser", browser);
    			req.setAttribute("version", "yes");
    			req.setAttribute("versionint", Integer.parseInt(version.substring(0, version.indexOf('.'))));
    		} else {
    			System.out.println(Integer.parseInt(version.substring(0, version.indexOf('.'))));
    			req.setAttribute("browser", browser);
    			req.setAttribute("version", "no");
    			req.setAttribute("versionint", Integer.parseInt(version.substring(0, version.indexOf('.'))));
    		}
        }
		
		logger.info(new Date() +"Inside login ");
	
		if (error != null && error.equalsIgnoreCase("1")) 
		{
	        model.addAttribute("error", "Your username or password is invalid.");
	    }
		
	    if (logout != null && logout.equalsIgnoreCase("1")) 
	    {
	        model.addAttribute("message", "You have been logged out successfully.");
	    }
	    
	    if (logout != null && logout.equalsIgnoreCase("1")) 
	    {
	        model.addAttribute("message", "You have been logged out successfully.");
	    }
	    
	    String success= req.getParameter("success");
		if (success == null) {
			Map md = model.asMap();
			success = (String) md.get("success");
		}
	    if(success!=null) {
	    	 model.addAttribute("success", success);
	    }
	    req.setAttribute("ContactNo", env.getProperty("ContactNo"));
	    
	    // License Expiration Validation 
 		boolean expstatus = true;
// 		try {
// 			Jws<Claims> claims = Jwts.parser().setSigningKey("vts-123").parseClaimsJws(env.getProperty("license"));
// 			expstatus = true;
// 		} catch (SignatureException | MalformedJwtException | UnsupportedJwtException | IllegalArgumentException ex) {
// 			expstatus = false;
// 		} catch (ExpiredJwtException ex) {
// 			expstatus = false;
// 		}
 		req.setAttribute("expstatus", expstatus);
 		
	    return "static/login";
	    
	 }
	 
	 

    @RequestMapping(value = {"/sessionExpired","/invalidSession"}, method = RequestMethod.GET)
    public String sessionExpired(Model model,HttpServletRequest req,HttpSession ses) {
    	logger.info(new Date() +"Inside sessionExpired ");
        return "SessionExp";
    }
    
//    @RequestMapping(value = {"/accessdenied"}, method = RequestMethod.GET)
//    public String accessdenied(Model model,HttpServletRequest req,HttpSession ses) {
//    	
//        return "accessdenied";
//    }
    
    @RequestMapping(value = {"/accessdenied"}, method = RequestMethod.GET)
    public String accessdenied(Model model,HttpServletRequest req,HttpSession ses) {
        return "static/accessdeniederror";
    }


}
