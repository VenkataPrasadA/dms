package com.vts.dms.cfg;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDecisionVoter;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.vote.AuthenticatedVoter;
import org.springframework.security.access.vote.RoleVoter;
import org.springframework.security.access.vote.UnanimousBased;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.expression.WebExpressionVoter;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;

import com.vts.dms.login.CustomLogoutHandler;
import com.vts.dms.login.LoginSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

	@Autowired
	private UserDetailsService userDetailsService;

	@Autowired
    private LoginSuccessHandler successHandler;
	
	@Override
	@Bean
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

        registry.addResourceHandler("/webjars/**").addResourceLocations("/webjars/").resourceChain(false);
        registry.setOrder(1);
	}
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordencoder());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
	    http
	        .authorizeRequests()
	            .antMatchers("/").hasAnyRole("USER", "ADMIN")
	            .antMatchers("/webresources/**").permitAll()
	            .antMatchers("/view/**").permitAll()
	            .antMatchers("/webjars/**").permitAll()
	            .antMatchers("/DakCreationforLabSubmit.htm/**").permitAll()
	            .antMatchers("/getDakData/**").permitAll()
	            .antMatchers("/labDakTrackingData/**").permitAll()
	            .antMatchers("/ReplyForMainLab/**").permitAll()
	            .antMatchers("/ClosedByFullName.htm/**").permitAll()
	            .antMatchers("/ApprovedByFullName.htm/**").permitAll()
	            .antMatchers("/RepliedByPAndCFullName.htm/**").permitAll()
	            .antMatchers("/GetReplyMemberName.htm/**").permitAll()
	            .antMatchers("/GetRepliedMemberName.htm/**").permitAll()
	            .antMatchers("/GetInitiatedByFullName.htm/**").permitAll()
	            .antMatchers("/GetAcknowledgedMembers.htm/**").permitAll()
	            .antMatchers("/GetAcknowledgeMembers.htm/**").permitAll()
	            .anyRequest().authenticated().accessDecisionManager(adm())
	        .and()
	            .formLogin().loginPage("/login").defaultSuccessUrl("/welcome", true).failureUrl("/login?error=1")
	            .permitAll().usernameParameter("username").passwordParameter("password").successHandler(successHandler)
	        .and()
	            .logout().invalidateHttpSession(true).deleteCookies("JSESSIONID")
	            .logoutSuccessUrl("/login?logout=1").addLogoutHandler(logoutSuccessHandler())
	        .and()
	        	.exceptionHandling().accessDeniedPage("/accessdenied")
	        .and()
	            .csrf().ignoringAntMatchers("/DakCreationforLabSubmit.htm")
	        .and()
	            .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
	            .invalidSessionUrl("/login?session=1");
	}

	
	

	public PasswordEncoder passwordencoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public LogoutHandler logoutSuccessHandler() {
		return new CustomLogoutHandler();
	}

	@Bean
	public AccessDecisionManager adm() {
		List<AccessDecisionVoter<? extends Object>> DecisionVoter = Arrays.asList(new RoleVoter(),
				new AuthenticatedVoter(), new WebExpressionVoter(), new RealTimeLockVoter());

		return new UnanimousBased(DecisionVoter);
	}

	class RealTimeLockVoter implements AccessDecisionVoter<Object> {

		@Override
		public boolean supports(ConfigAttribute attribute) {
			// TODO Auto-generated method stub
			return true;
		}

		@Override
		public boolean supports(Class<?> clazz) {
			// TODO Auto-generated method stub
			return true;
		}

		@Override
		public int vote(Authentication authentication, Object object, Collection<ConfigAttribute> attributes) {

			// System.out.println(authentication.getName());
			/*
			 * if(url.equalsIgnoreCase("DemandInitiationList.htm")) { return ACCESS_GRANTED;
			 * } }
			 */

			return ACCESS_GRANTED;
		}

	}

}
