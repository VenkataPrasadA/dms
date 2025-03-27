package com.vts.dms.login;

import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vts.dms.DateTimeFormatUtil;
import com.vts.dms.model.AuditStamping;
import com.vts.dms.service.DmsService;





@Service
public class LoginDetailsServiceImpl implements UserDetailsService 
{
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
    private LoginRepository loginRepository;
	
	@Autowired
	private DmsService service;
	
	@Override
	@Transactional(readOnly = false)
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException 
	{
		Login login = loginRepository.findByUsername(username);
        if(login != null && login.getIsActive()==1 && login.getPfms().equalsIgnoreCase("Y")) {
        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
        for (Role role : login.getRoles()){
            grantedAuthorities.add(new SimpleGrantedAuthority(role.getRoleName()));
        }
        String IpAddress="Not Available";
     		try{
     		
     		 IpAddress = request.getRemoteAddr();
     		 
     		if("0:0:0:0:0:0:0:1".equalsIgnoreCase(IpAddress))
     		{     			
     			InetAddress ip = InetAddress.getLocalHost();
     			IpAddress= ip.getHostAddress();
     		}
     		
     		}
     		catch(Exception e)
     		{
     		IpAddress="Not Available";	
     		e.printStackTrace();	
     		}
     		try{
     	        AuditStamping stamping=new AuditStamping();
     	        stamping.setLoginId(login.getLoginId());
     	        stamping.setLoginDate(new java.sql.Date(new Date().getTime()));
     	        stamping.setUsername(login.getUsername());
     	        stamping.setIpAddress(IpAddress);
     	        stamping.setLoginDateTime(sdf1.format(new Date()));
     	        service.LoginStampingInsert(stamping);
     	     		}catch (Exception e) {
     					e.printStackTrace();
     				}
        
        return new org.springframework.security.core.userdetails.User(login.getUsername(), login.getPassword(), grantedAuthorities);
    }
        else {
        	   throw new UsernameNotFoundException("username not found");
        }
    }
	

	
	
}
