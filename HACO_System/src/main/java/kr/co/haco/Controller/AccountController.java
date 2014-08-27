package kr.co.haco.Controller;

import java.security.Principal;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;
import kr.co.haco.VO.Account;
import kr.co.haco.VO.Member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AccountController {

	@Autowired
	AccountService accountService;

	// 로그인
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	// 회원 로그아웃
	@RequestMapping(value = "memberLogout", method = RequestMethod.GET)
	public String memberLogout(HttpSession session){
		//Spring Security 로그아웃 하기
		//System.out.println(SecurityContextHolder.getContext().getAuthentication().getAuthorities());
		session.invalidate();
		SecurityContextHolder.getContext().setAuthentication(null); //권한설정 초기화
		return "redirect:/";
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
		session.setAttribute("member", accountService.getMemberToAccount_id(principal.getName()));
		return "redirect:/";
	}

	// 홈페이지 회원가입 약관동의 페이지
	@RequestMapping(value = "joinIntro", method = RequestMethod.GET)
	public String joinIntro() {
		return "homepage.joinIntro";
	}

	// 홈페이지 회원가입페이지
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String join() {
		return "homepage.join";
	}

	// 아이디 중복 체크
	@RequestMapping(value = "checkId", method = RequestMethod.POST)
	@ResponseBody
	public String checkId(String id) {
		return accountService.checkId(id);
	}


	// 홈페이지 회원가입처리
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String joinProcess(Member member, Account account, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		/*try{
			accountService.joinMember(account, member);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}*/
		StringBuffer contextURL = request.getRequestURL();
		contextURL = contextURL.replace(contextURL.lastIndexOf("join"), contextURL.length(), "");
		accountService.joinMember(account, member, contextURL);
		

		//RedirectAttributes = http://blog.naver.com/runthe/220017083494
		//redirectAttributes.addAttribute - get 방식 (String Type만 가능)
		//redirectAttributes.addFlashAttribute - post 방식 (Object 전부 가능)
		redirectAttributes.addFlashAttribute("email", member.getEmail());
		return "redirect:/joinActivation";
	}
	
	// 이메일 인증 안내 페이지
	@RequestMapping(value="joinActivation" ,method=RequestMethod.GET)
	public String joinActivation(){
		return "homepage.joinActivation";
	}
	
	
	// 이메일 인증처리
	@RequestMapping(value="accountActivation/{activation_key}", method=RequestMethod.GET)
	public String accountActivation(@PathVariable String activation_key, RedirectAttributes redirectAttributes){
		
		// 보류 :: 인증 처리 성공시 로그인 처리
		/*
		String result = accountService.accountActivation(activation_key);
		if(result.equals("success")){
			redirectAttributes.addFlashAttribute("result", result);
			return "redirect:/accountActivationResult";
		}
		 */
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("result", accountService.accountActivation(activation_key));
		data.put("member", accountService.getMemberToActivationKey(activation_key));
		
		redirectAttributes.addFlashAttribute("data", data);
		return "redirect:/accountActivationResult";
		
	}
	
	// 이메일 인증 결과
	@RequestMapping(value="accountActivationResult", method=RequestMethod.GET)
	public String accountActivationResult(){
		return "homepage.accountActivationResult";
	}
	
	// 마이페이지
	@RequestMapping(value="myPage", method=RequestMethod.GET)
	public String myPage(){
		return "homepage.myPage";
	}
	
	// 회원정보수정 페이지
	@RequestMapping(value="memberModify", method=RequestMethod.GET)
	public String modifyMember(Model model, Principal principal) {
		model.addAttribute("account", accountService.getAccountToAccount_id(principal.getName()));
		model.addAttribute("member", accountService.getMemberToAccount_id(principal.getName()));
		return "homepage.memberModify";
	}
	
	// 회원정보수정 처리
	@RequestMapping(value="memberModify", method=RequestMethod.POST)
	public String memberModifyProcess(Member member, Account account, Principal principal, HttpSession session, RedirectAttributes redirectAttributes) {
		account.setAccount_id(Integer.parseInt(principal.getName()));
		if(accountService.updateMember(account, member)){
			redirectAttributes.addFlashAttribute("result", true);
			session.setAttribute("member", member);
		}
		return "redirect:/memberModifyComplete";
	}
	
	// 회원정보수정 완료 페이지
	@RequestMapping(value="memberModifyComplete", method=RequestMethod.GET)
	public String memberModifyComplete(){
		return "homepage.memberModifyComplete";
	}
	
	// 회원 탈퇴 페이지
	@RequestMapping(value="memberDelete", method=RequestMethod.GET)
	public String memberDelete(){
		return "homepage.memberDelete";
	}
	
	// 회원 탈퇴 처리
	@RequestMapping(value="memberDelete", method=RequestMethod.POST)
	public String memberDeleteProcess(Account account, Principal principal, HttpSession session, RedirectAttributes redirectAttributes) {
		account.setAccount_id(Integer.parseInt(principal.getName()));
		if(accountService.deleteMember(account)){
			redirectAttributes.addFlashAttribute("member",session.getAttribute("member"));
			return "redirect:/memberDeleteComplete";
		}else{
			redirectAttributes.addFlashAttribute("result","notmatch");
			return "redirect:/memberDelete";
		}
	}
	
	// 회원 탈퇴 완료 페이지
	@RequestMapping(value="memberDeleteComplete", method=RequestMethod.GET)
	public String memberDeleteComplete(HttpSession session){
		//Spring Security 로그아웃 하기
		//System.out.println(SecurityContextHolder.getContext().getAuthentication().getAuthorities());
		session.invalidate();
		SecurityContextHolder.getContext().setAuthentication(null); //권한설정 초기화
		return "homepage.memberDeleteComplete";
	}
	
	// 아이디 찾기 ( 이메일 )
	@RequestMapping(value="forgetId", method=RequestMethod.POST)
	@ResponseBody
	public String forgetId(String name, String email){
		return accountService.findId(name, email);
	}	
	
	
	// 비밀번호 찾기 ( 이메일 )
	@RequestMapping(value="forgetPassword", method=RequestMethod.POST)
	@ResponseBody
	public String forgetPassword(String id, String email, HttpServletRequest request){
		StringBuffer contextURL = request.getRequestURL();
		contextURL = contextURL.replace(contextURL.lastIndexOf("forgetPassword"), contextURL.length(), "");
		return accountService.findPassword(id, email, contextURL);
	}
	// 출석정보
	@RequestMapping(value="memberattendance", method=RequestMethod.GET)
	public String memberattendance(){
		return "homepage.memberattendance";
	}
}