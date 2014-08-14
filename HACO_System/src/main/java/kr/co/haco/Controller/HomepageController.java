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

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		
		return "homepage.index";
	}
	
}
