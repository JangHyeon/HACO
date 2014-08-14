package kr.co.haco.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Util.ImageJ;
import kr.co.haco.VO.Account;
import kr.co.haco.VO.Member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class AccountController {

	@Autowired
	AccountService accountService;

	// 로그인
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}

	// 직원 로그인 처리
	@RequestMapping(value = "employeeLogin", method = RequestMethod.GET)
	public String employeeLogin(HttpSession session, Principal principal) {
		session.setAttribute("employee",
				accountService.getEmployee(principal.getName()));
		return "redirect:/management/index";
	}

	// 원생 로그인 처리
	@RequestMapping(value = "studentLogin", method = RequestMethod.GET)
	public String studentLogin(HttpSession session, Principal principal) {

		return "redirect:/";
	}

	// 홈페이지 회원가입 약관동의 페이지
	@RequestMapping(value = "joinIntro", method = RequestMethod.GET)
	public String joinIntro(HttpSession session, Principal principal) {

		return "homepage.joinIntro";
	}

	// 홈페이지 회원가입페이지
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String join(HttpSession session, Principal principal) {

		return "homepage.join";
	}

	// 홈페이지 회원가입처리
	@RequestMapping(value = "joinProcess", method = RequestMethod.POST)
	public String joinProcess(Member member, Account account) {
			
		try{
		accountService.joinMember(account, member);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
			
		return "homepage.index";
	}

	// 아이디 중복 체크
	// *******map타입 리턴 말고 String 타입으로 리턴하는 방법 알고싶다
	@RequestMapping(value = "checkId", method = RequestMethod.POST)
	@ResponseBody
	public String checkId(String id) {
		return accountService.checkId(id);
	}

}
