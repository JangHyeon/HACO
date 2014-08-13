package kr.co.haco.Controller;

import java.security.Principal;

import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Controller
public class AccountController {
	
	@Autowired
	AccountService accountService;

	//로그인
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	//직원 로그인 처리
	@RequestMapping(value = "employeeLogin", method = RequestMethod.GET)
	public String employeeLogin(HttpSession session, Principal principal) {		
		session.setAttribute("employee", accountService.getEmployee(principal.getName()));
		return "redirect:/management/index";
	}
	
	//원생 로그인 처리
	@RequestMapping(value = "studentLogin", method = RequestMethod.GET)
	public String studentLogin(HttpSession session, Principal principal) {		
		//session.setAttribute("employee", accountService.getEmployee(principal.getName()));
		return "redirect:/index";
	}
}
