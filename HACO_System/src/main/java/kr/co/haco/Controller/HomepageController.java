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
public class HomepageController {
	@Autowired
	AccountService accountService;

	// 메인페이지
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		
		return "homepage.index";
	}
	
	
	// 학원소개
	@RequestMapping(value = "/introduction", method = RequestMethod.GET)
	public String academy(Model model) {
		
		return "homepage.introduction";
	}
	
	// 학원장 인사말
	@RequestMapping(value = "/introductionGreeting", method = RequestMethod.GET)
	public String introductionGreeting(Model model) {
		
		return "homepage.introductionGreeting";
	}	
	
	// 찾아오시는길
	@RequestMapping(value = "/contectUs", method = RequestMethod.GET)
	public String contectUs(Model model) {
		
		return "homepage.contectUs";
	}	
	
	
	
	
	
	
	// 커뮤니티
	@RequestMapping(value = "/community", method = RequestMethod.GET)
	public String community(Model model) {
		
		return "homepage.community";
	}
}