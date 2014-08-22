package kr.co.haco.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.HomepageService;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	@RequestMapping(value = {"/notice","/noticeSearch"}, method = RequestMethod.GET)
	public String notice(Model model, HttpServletRequest request, HttpSession session,
			@RequestParam(defaultValue="1") int pageNum, 
			@RequestParam(defaultValue="10") int pageSize, 
			@RequestParam(defaultValue="title") String searchType, 
			@RequestParam(defaultValue="") String searchKey) {
		

		model.addAttribute("searchType",searchType);
		model.addAttribute("searchKey",searchKey);
		
		String servletPath = request.getServletPath();
		if(servletPath.equals("/noticeSearch")){
			pageNum = 1;
		}
		
		Notice notice = new Notice();
		
		notice.setPageNum(pageNum);
		notice.setPageSize(pageSize);
		notice.setSearchType(searchType);
		notice.setSearchKey(searchKey);
		
		homepageService.getNoticeList(notice, session, model);
		
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
		
		return "redirect:notice";
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
		
	// 공지사항 읽기
	@RequestMapping(value = "/notice/{notice_id}")
	public String noticeView(@PathVariable int notice_id, Model model) {
		model.addAttribute("notice",homepageService.getNotice(notice_id));
		return "homepage.noticeView";
	}
	
	// 공지사항 수정
	@RequestMapping(value = "/noticeModify/{notice_id}",method = RequestMethod.GET)
	public String noticeModify(@PathVariable int notice_id, Model model) {
		model.addAttribute("notice",homepageService.getNotice(notice_id));
		return "homepage.noticeModify";
	}
	@RequestMapping(value = "/noticeModify/{notice_id}",method = RequestMethod.POST)
	public String noticeModifyProcess(@PathVariable int notice_id, Notice notice) {
		System.out.println(homepageService.updateNotice(notice));
		return "redirect:/notice/"+notice_id;
	}
	
	
	// 공지 사항 삭제
	@RequestMapping(value = "/noticeDelete/{notice_id}",method = RequestMethod.GET)
	public String noticeDelete(@PathVariable int notice_id, Model model) {
		//model.addAttribute("notice",homepageService.getNotice(notice_id));
		return "homepage.noticeView";
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