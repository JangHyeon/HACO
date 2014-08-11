package kr.co.haco.Handler;

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
    	System.out.println("=========login success===========");
    	request.getSession().removeAttribute("SPRING_SECURITY_LAST_EXCEPTION");

    	//권한이 없으면 해당 실패핸들러작동
    	logger.info("[Login] - account_id:["+auth.getName()+"] / 권한:"+auth.getAuthorities().toString());
    	//logger.info(auth.getDetails().toString());
    	//logger.info(auth.getPrincipal().toString());
    	
    	
    	//권한이 부족할시 이동할 URL
    	String url = request.getContextPath() + "/login?error=denied";

    	//권한 확인 후 해당 URL 지정
    	for(GrantedAuthority a : auth.getAuthorities()){
    		//logger.info(a.getAuthority());
    		if(a.getAuthority().equals("MASTER") || 
        			a.getAuthority().equals("CENTER") || 
        			a.getAuthority().equals("TEACHER") || 
        			a.getAuthority().equals("MANAGER")){
    			url = request.getContextPath() + "/employeeLogin"; //직원 로그인
    			break;
    		}else if(a.getAuthority().equals("STUDENT")){
    			url = request.getContextPath() + "/studentLogin"; //학생 로그인
    		}
    	}
    	response.sendRedirect(url);
    }
}