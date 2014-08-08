package kr.co.Foundation.Handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;


public class LoginSuccessHandler implements AuthenticationSuccessHandler
{
	private static final Logger logger = LoggerFactory.getLogger(LoginSuccessHandler.class);
	
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth) throws IOException, ServletException
    {
    	
    	String url = request.getContextPath() + "/sample/management/index.jsp";
    	//권한이 없으면 해당 메서드가 작동안되고 실패핸들러작동
    	/*logger.info(auth.getName());*/
    	logger.info(auth.getAuthorities().toString());
    	/*logger.info(auth.getDetails().toString());*/
    	/*logger.info(auth.getPrincipal().toString());*/
    	for(GrantedAuthority a : auth.getAuthorities()){
    		/*logger.info(a.getAuthority());*/
    		if(a.getAuthority().equals("master")){
    			url = request.getContextPath() + "/sample/management/general.jsp";
    			break;
    		}else if(a.getAuthority().equals("manager")){
    			url = request.getContextPath() + "/sample/management/panels.jsp";
  
    		}
    	}
    	response.sendRedirect(url);
    }
}