package kr.co.haco.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.HomepageService;
import kr.co.haco.Util.MultipartUploader;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Notice;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class HomepageController {
	@Autowired
	HomepageService homepageService;

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
	
	
	

	

	// 공지사항
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public String notice(Notice notice, Model model, 
			@RequestParam(defaultValue="1")		String pageNum, 
			@RequestParam(defaultValue="10")	String pageSize, 
			@RequestParam(defaultValue="title")	String searchType, 
			@RequestParam(defaultValue="")		String searchKey) {
		
		notice.setPageNum(pageNum);
		notice.setPageSize(pageSize);
		notice.setSearchType(searchType);
		notice.setSearchKey(searchKey);

		System.out.println(pageNum);
		System.out.println(pageSize);
		System.out.println(searchKey);
		System.out.println(searchType);
		
		model.addAttribute("noticeList",homepageService.getNoticeList(notice));

		
		return "homepage.notice";
	}

	// 공지사항 작성 페이지
	@RequestMapping(value = "/noticeWrite", method = RequestMethod.GET)
	public String noticeWrite(HttpServletRequest request) {
		return "homepage.noticeWrite";
	}
	// 공지사항 작성
	@RequestMapping(value = "/noticeWrite", method = RequestMethod.POST)
	public String noticeWriteProcess(Notice notice, HttpSession session) {
		Employee emp = (Employee)session.getAttribute("employee");
		notice.setAccount_id(emp.getAccount_id());
		notice.setCenter_id(emp.getNow_center_id());
		
		homepageService.insertNotice(notice);
		
		return "redirect:noticeWrite";
	}
	
	
	
	
	// 공지사항 이미지 첨부
	/*
	스프링에서 @ResponseBody로 문자열을 반환 시 디폴트로 ISO-8859-1를 사용한다.
	이를 변경하기 위해 @RequestMapping의 produces 속성을 다음과 같이 설정할 수 있다.
	Response 사용시 returnString 값이 script라면 text/html를 사용하고 단순 text라면 text/plain을 사용한다.
	*/
	@RequestMapping(value = "/noticeUpload", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String noticeUpload(MultipartHttpServletRequest request) {
		return homepageService.noticeUpload(request);
	}
		
	
	
	
	// 질문과 답변
	@RequestMapping(value = "/qna", method = RequestMethod.GET)
	public String qna(Model model) {
		
		return "homepage.qna";
	}
	
	
	// 커뮤니티
	@RequestMapping(value = "/community", method = RequestMethod.GET)
	public String community(Model model) {
		
		return "homepage.community";
	}
}