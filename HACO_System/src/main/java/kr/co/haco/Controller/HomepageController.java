package kr.co.haco.Controller;

import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.HomepageService;
import kr.co.haco.Service.LectureRegisterService;
import kr.co.haco.VO.Notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomepageController {
	
	@Autowired
	HomepageService homepageService;
	
	@Autowired
	AccountService accountService;
	
	@Autowired
	LectureRegisterService lectureRegisterService;
	
	
	// 에러페이지
	@RequestMapping(value = "/error/{msg}")
	public String error(@PathVariable String msg, Model model) {
		model.addAttribute("errorMsg", msg);
		return "homepage.error";
	}
	@RequestMapping(value = "/error")
	public String errorGet(Model model) {
		return "homepage.error";
	}
	

	// 메인페이지
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request, HttpSession session, Notice notice) {
		notice.setPageSize(5);
		homepageService.getNoticeList(notice, session, model, request.getContextPath());
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		Calendar c = Calendar.getInstance();
		String month = ""+(c.get(Calendar.MONTH)+1);
		if(month.length()==1) {month= "0" +month;};
		String today = c.get(Calendar.YEAR) +"-" + month +"-"+(c.get(Calendar.DATE));
		map.put("today", today);
		map.put("limit", 5);
		model.addAttribute("lectureRegisterList", lectureRegisterService.getopencourselist(map));
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
}
