package kr.co.haco.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Time;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.HomepageService;
import kr.co.haco.Service.LectureRegisterService;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.LectureRegisterList;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.Notice;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.OpenCourseList;
import kr.co.haco.VO.Qna;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.Teacher;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomepageController {
	
	@Autowired
	HomepageService homepageService;
	
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
		String today = c.get(Calendar.YEAR) +"-" + month +"-"+(c.get(Calendar.DATE));
		System.out.println(c.get(Calendar.YEAR));
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(today);
		map.put("today", today);
		String proid = req.getParameter("proid");
		map.put("proid", proid);
		List<OpenCourseList> getopencourselist = lectureRegisterService.getopencourselist(map);
		req.setAttribute("getopencourselist", getopencourselist);
		
		return "homepage.lectureregister";
	}
	//과정설명
	@RequestMapping(value = "/lecture", method = RequestMethod.GET)
	public String lecture(HttpSession session,HttpServletRequest req) {
		Member member = (Member) session.getAttribute("member");
		String opid = req.getParameter("opid");
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("course_id", opid);
		
		if(member!=null){
			System.out.println("member.getAccount_id() : " +member.getAccount_id());
			map.put("account_id", member.getAccount_id());
			map.put("open_course_id", opid);
			LectureRegisterList lecturemember = lectureRegisterService.lecturemember(map);
			req.setAttribute("lecturemember", lecturemember);
			map.put("member_check", 1); // 회원일때
		} else {
			map.put("member_check", 0); // 비회원일때
		}
		Subject getCNT = lectureRegisterService.getCNT(map);
		req.setAttribute("member", member);
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
		/*if(sbj.getCapacity() <= sbj.getCNT())
		{ 
			return "homepage.lecturefailed";
		}*/
		System.out.println(member.getAccount_id());
		System.out.println(sbj.getAccount_id());
		/*if(member.getAccount_id() == sbj.getAccount_id()){
			return "homepage.lecturefailed2";
		}*/
		req.setAttribute("sbj", sbj);
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		System.out.println();
		map.put("account_id", member.getAccount_id());
		map.put("open_course_id",op);
		
		lectureRegisterService.insertlecture(map);

		
		return "homepage.lecturesuccess";
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
		return homepageService.CkeditorUpload(request,"/board/notice");
	}
	
	// 공지사항(페이지 정보가 없는경우) 
	@RequestMapping(value = "/notice", method = RequestMethod.GET, params="!pageNum")
	public String noticeDefault(Model model, HttpServletRequest request, HttpSession session, Notice notice) {
		homepageService.getNoticeList(notice, session, model, request.getContextPath());
		return "homepage.notice";
	}
	
	// 공지사항 리스트
	@RequestMapping(value = "/notice/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
	public String notice(Model model, HttpServletRequest request, HttpSession session,
			@PathVariable String searchType,
			@PathVariable String searchKey,
			@PathVariable int pageSize,
			@PathVariable int pageNum) {

		Notice notice = new Notice();
		notice.setSearchType(searchType);
		notice.setPageSize(pageSize);
		notice.setPageNum(pageNum);
		notice.setSearchKey(searchKey);		
		
		
		//인코딩 설정을 했는데도 인코딩이 꺠질시에는 일일이 바이트 처리 ( server.xml 설정 변경으로 사용안함 )
		/*try {
			notice.setSearchKey(new String(searchKey.getBytes("8859_1"),"UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}*/
		
		if(searchKey.equals("[noKeyword]")){
			notice.setSearchKey("");
		}
		
		homepageService.getNoticeList(notice, session, model, request.getContextPath());
		return "homepage.notice";
	}
	
	// 공지사항 읽기
	@RequestMapping(value = "/noticeView/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/noticeId/{notice_id}", method = RequestMethod.GET)
	public String noticeView(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session,
			RedirectAttributes redirectAttributes,
			@PathVariable int pageSize,
			@PathVariable int pageNum,
			@PathVariable int notice_id,
			@PathVariable String searchType,
			@PathVariable String searchKey) {
 
		
		Notice notice = homepageService.getNotice(request,response,session,notice_id);
		
		if(notice==null){
			return "redirect:/error/PageNotFound"; //없는 페이지
		}else if(notice.getError()!=null){
			redirectAttributes.addFlashAttribute("errorMsg", notice.getError());
			return "redirect:/error";
		}
		
		notice.setSearchKey(searchKey);
		notice.setSearchType(searchType);
		notice.setPageNum(pageNum);
		notice.setPageSize(pageSize);
		
		model.addAttribute("notice",notice);
		return "homepage.noticeView";
	}
	
	// 공지사항 수정 페이지
	@RequestMapping(value = "/noticeModify/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/noticeId/{notice_id}", method = RequestMethod.GET)
	public String noticeModify(Model model,
			@PathVariable int pageSize,
			@PathVariable int pageNum,
			@PathVariable int notice_id,
			@PathVariable String searchType,
			@PathVariable String searchKey) {

		Notice notice = homepageService.getNotice(notice_id);
		notice.setSearchKey(searchKey);
		notice.setSearchType(searchType);
		notice.setPageNum(pageNum);
		notice.setPageSize(pageSize);
		
		model.addAttribute("notice",notice);
		
		return "homepage.noticeModify";
	}
	//공지사항 수정
	@RequestMapping(value = "/noticeModifyProcess",method = RequestMethod.POST)
	public String noticeModifyProcess(Notice notice) {
		homepageService.updateNotice(notice);
		return "redirect:/noticeView/pageSize/"+notice.getPageSize()+"/pageNum/"+notice.getPageNum()+"/searchType/"+notice.getSearchType()+"/searchKey/"+notice.getSearchKey()+"/noticeId/"+notice.getNotice_id();
	}
	
	// 공지 사항 삭제
	@RequestMapping(value = "/noticeDelete/{notice_id}",method = RequestMethod.GET)
	public String noticeDelete(@PathVariable int notice_id, Model model) {
		homepageService.deleteNotice(notice_id);
		return "redirect:/notice";
	}
	
	
	
	
	
	// 질문 작성 페이지
	@RequestMapping(value = "/questionWrite", method = RequestMethod.GET)
	public String qnaWrite(HttpServletRequest request) {
		return "homepage.questionWrite";
	}
	// 질문 작성
	@RequestMapping(value = "/questionWrite", method = RequestMethod.POST)
	public String qnaWriteProcess(Qna question, HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		question.setAccount_id(member.getAccount_id());
		question.setDivide_code('Q');
		homepageService.insertQuestion(question);
		
		return "redirect:qna";
	}
	
	// 질문과 답변 업로드
	@RequestMapping(value = "/qnaUpload", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String qnaUpload(MultipartHttpServletRequest request) {
		return homepageService.CkeditorUpload(request,"/board/qna");
	}
	

	// 질문과 답변(페이지 정보가 없는경우) 
	@RequestMapping(value = "/qna", method = RequestMethod.GET, params="!pageNum")
	public String qnaDefault(Model model, HttpServletRequest request, HttpSession session, Qna qna) {
		homepageService.getQnaList(qna, session, model, request.getContextPath());
		return "homepage.qna";
	}
	
	// 질문과 답변
	@RequestMapping(value = "/qna/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
	public String qna(Model model, HttpServletRequest request, HttpSession session,
			@PathVariable String searchType,
			@PathVariable String searchKey,
			@PathVariable int pageSize,
			@PathVariable int pageNum) {
		Qna qna = new Qna();
		qna.setSearchType(searchType);
		qna.setPageSize(pageSize);
		qna.setPageNum(pageNum);
		qna.setSearchKey(searchKey);		
		
		if(searchKey.equals("[noKeyword]")){
			qna.setSearchKey("");
		}
		
		homepageService.getQnaList(qna, session, model, request.getContextPath());
		return "homepage.qna";
	}
	

	// 질문과 답변 읽기
	@RequestMapping(value = "/qnaView/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/qnaId/{qna_id}", method = RequestMethod.GET)
	public String qnaView(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session,
			RedirectAttributes redirectAttributes,
			@PathVariable int pageSize,
			@PathVariable int pageNum,
			@PathVariable int qna_id,
			@PathVariable String searchType,
			@PathVariable String searchKey) {

		Qna qna = homepageService.getQna(request,response,session,qna_id);
		
		if(qna==null){
			return "redirect:/error/PageNotFound"; //없는 페이지
		}else if(qna.getError()!=null){
			return "redirect:/error/"+qna.getError();
		}
		
		
		qna.setSearchKey(searchKey);
		qna.setSearchType(searchType);
		qna.setPageNum(pageNum);
		qna.setPageSize(pageSize);
		
		model.addAttribute("qna",qna);
		return "homepage.qnaView";
	}
	
	// 질문과 답변 수정 페이지
	@RequestMapping(value = "/qnaModify/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/qnaId/{qna_id}", method = RequestMethod.GET)
	public String qnaModify(Model model,
			@PathVariable int pageSize,
			@PathVariable int pageNum,
			@PathVariable int qna_id,
			@PathVariable String searchType,
			@PathVariable String searchKey) {

		Qna qna = homepageService.getQna(qna_id);
		qna.setSearchKey(searchKey);
		qna.setSearchType(searchType);
		qna.setPageNum(pageNum);
		qna.setPageSize(pageSize);
		
		model.addAttribute("qna",qna);
		
		return "homepage.qnaModify";
	}
	// 질문과 답변 수정
	@RequestMapping(value = "/qnaModifyProcess",method = RequestMethod.POST)
	public String qnaModifyProcess(Qna qna) {
		homepageService.updateQna(qna);
		return "redirect:/qnaView/pageSize/"+qna.getPageSize()+"/pageNum/"+qna.getPageNum()+"/searchType/"+qna.getSearchType()+"/searchKey/"+qna.getSearchKey()+"/qnaId/"+qna.getQna_id();
	}
	
	// 질문과 답변 삭제
	@RequestMapping(value = "/qnaDelete/{qna_id}",method = RequestMethod.GET)
	public String qnaDelete(@PathVariable int qna_id, Model model) {
		homepageService.deleteQna(qna_id);
		return "redirect:/qna";
	}
	
	// 답변 작성 페이지
	@RequestMapping(value = "/answerWrite/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/qnaId/{qna_id}", method = RequestMethod.GET)
	public String answerWrite(Model model,
			@PathVariable int pageSize,
			@PathVariable int pageNum,
			@PathVariable int qna_id,
			@PathVariable String searchType,
			@PathVariable String searchKey) {

		Qna qna = homepageService.getQna(qna_id);
		qna.setSearchKey(searchKey);
		qna.setSearchType(searchType);
		qna.setPageNum(pageNum);
		qna.setPageSize(pageSize);
		qna.setGroup_no(qna_id);
		
		qna.setTitle(qna.getTitle()+" - 답변");
		qna.setContent(qna.getContent()+"</div><br/>&nbsp;<hr/><br/>&nbsp;");
		
		model.addAttribute("qna",qna);
		
		return "homepage.answerWrite";
	}
	// 답변 작성
	@RequestMapping(value = "/answerWrite", method = RequestMethod.POST)
	public String answerWriteProcess(Qna answer, HttpSession session) throws NullPointerException{
		Employee employee = (Employee)session.getAttribute("employee");
		answer.setAccount_id(employee.getAccount_id());
		answer.setDivide_code('A');
		homepageService.insertAnser(answer);
		
		return "redirect:/qna";
	}
	
	
	// 다운로드
	@RequestMapping(value = "/upload/board/{boardName}/file/{fileName:.+}")
	public String download(
            @PathVariable String boardName,
            @PathVariable String fileName,
            HttpServletResponse response,
            HttpServletRequest request){
		
		try{
	
			//다운로드 기본 설정 (브라우져가 read 하지 않고 ... 다운 )
			//요청 - 응답 간에 헤더정보에 설정을 강제 다운로드
			String userAgent = request.getHeader("User-Agent");
			
			if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1) {   // MS IE 브라우저에서 한글 인코딩
			   response.setHeader("Content-Disposition", "attachment; filename="
			   + java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ ") + ";");
			} else {                                                                     // 모질라나 오페라 브라우저에서 한글 인코딩​
				response.setHeader("Content-Disposition",
				"attachment; filename=" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1").replaceAll("\\+", "\\ ") + ";");
			}
			//파일명 전송 
			//파일 내용전송
			String fullpath = request.getSession().getServletContext().getRealPath("/resources/upload/board/" + boardName + "/file/" + fileName).replace("/", File.separator);
			FileInputStream fin = new FileInputStream(fullpath);
			//출력 도구 얻기 :response.getOutputStream()
			ServletOutputStream sout = response.getOutputStream();
			byte[] buf = new byte[1024]; //전체를 다읽지 않고 1204byte씩 읽어서
			int size = 0;
			while((size=fin.read(buf,0,buf.length)) != -1) //buffer 에 1024byte 담고
			{                                              //마지막 남아있는 byte 담고  그다음 없으면 탈출
				sout.write(buf, 0, size); //1kbyte씩 출력 
			}
			fin.close();
			sout.close();
		
		}catch(IOException e){
			System.out.println(e.getMessage());
			return "redirect:/error/FileNotFound";
		}
		return null;
	}
	
	
	// 커뮤니티
	@RequestMapping(value = "/community", method = RequestMethod.GET)
	public String community(Model model) {
		
		return "homepage.community";
	}
}