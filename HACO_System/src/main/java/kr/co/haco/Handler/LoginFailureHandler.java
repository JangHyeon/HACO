package kr.co.haco.Handler;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;


public class LoginFailureHandler implements AuthenticationFailureHandler {
	public void onAuthenticationFailure(HttpServletRequest request,
			HttpServletResponse response, AuthenticationException auth)
			throws IOException, ServletException {

		System.out.println("//login-fail");
		System.out.println("//"+auth.getMessage());
		
		request.getSession().setAttribute("SPRING_SECURITY_LAST_EXCEPTION", auth.getMessage());
				
		response.sendRedirect(request.getContextPath() + "/login?error=fail");
	}
}