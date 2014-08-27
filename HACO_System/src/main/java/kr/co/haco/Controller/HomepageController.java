package kr.co.haco.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Time;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.AttendanceService;
import kr.co.haco.Service.HomepageService;
import kr.co.haco.Service.LectureRegisterService;
import kr.co.haco.Util.MultipartUploader;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.Notice;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.StudentVO;
import kr.co.haco.VO.Subject;

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
	
	@Autowired
	LectureRegisterService lectureRegisterService;
	
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
	//수강신청page
	@RequestMapping(value = "/lectureregister", method = RequestMethod.GET)
	public String lectureregister(HttpServletRequest req) {
		Calendar c = Calendar.getInstance();
		String month = ""+(c.get(Calendar.MONTH)+1);
		if(month.length()==1) {month= "0" +month;};
		String today = c.get(Calendar.YEAR) +"-" + month +"-"+(c.get(Calendar.DATE)+1);
		System.out.println(c.get(Calendar.YEAR));
		HashMap map = new HashMap();
		System.out.println(today);
		map.put("today", today);
		List<OpenCourse> getopencourselist = lectureRegisterService.getopencourselist(map);
		req.setAttribute("getopencourselist", getopencourselist);
		return "homepage.lectureregister";
	}
	//과정설명
	@RequestMapping(value = "/lecture", method = RequestMethod.GET)
	public String lecture(HttpSession session,HttpServletRequest req) {
		Member member = (Member) session.getAttribute("member");
		String opid = req.getParameter("opid");
		HashMap map = new HashMap();
		map.put("course_id", opid);
		map.put("account_id", member.getAccount_id());
		Subject getCNT = lectureRegisterService.getCNT(map);
		System.out.println("!!!!!!!!!!"+getCNT);
		req.setAttribute("getCNT", getCNT);
		
		return "homepage.lecture";
	}
	//수강신청완료 page
		@RequestMapping(value = "/lecturesuccess", method = RequestMethod.GET)
		public String lecturesuccess(HttpSession session,HttpServletRequest req) {
			
			Member member = (Member) session.getAttribute("member");
			int op = Integer.parseInt(req.getParameter("opid"));
			
			Subject sbj = new Subject();
			
			sbj.setCourse_name(req.getParameter("course_name"));
			sbj.setName_kor(req.getParameter("name_kor"));
			sbj.setCourse_start_date(java.sql.Date.valueOf(req.getParameter("course_start_date")));
			sbj.setCourse_end_date(java.sql.Date.valueOf(req.getParameter("course_end_date")));
			sbj.setLecture_time_start(Time.valueOf(req.getParameter("lecture_time_start")));
			sbj.setLecture_time_end(Time.valueOf(req.getParameter("lecture_time_end")));
			sbj.setTuition_fee(Integer.parseInt(req.getParameter("tuition_fee")));
			sbj.setLocation(req.getParameter("location"));
			sbj.setCNT(Integer.parseInt(req.getParameter("CNT")));
			sbj.setCapacity(Integer.parseInt(req.getParameter("capacity")));
			sbj.setLecture_content(req.getParameter("lecture_content"));
			sbj.setName(req.getParameter("name"));
			sbj.setAccount_id(Integer.parseInt(req.getParameter("account_id")));
			if(sbj.getCapacity() <= sbj.getCNT())
			{ 
				return "homepage.lecturefailed";
			}
			System.out.println(member.getAccount_id());
			System.out.println(sbj.getAccount_id());
			if(member.getAccount_id() == sbj.getAccount_id()){
				return "homepage.lecturefailed2";
			}
			req.setAttribute("sbj", sbj);
			HashMap map = new HashMap();
			System.out.println();
			map.put("account_id", member.getAccount_id());
			map.put("open_course_id",op);
			
			int insertlecture = lectureRegisterService.insertlecture(map);

			req.setAttribute("insertlecture", insertlecture);
			
			return "homepage.lecturesuccess";
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