package kr.co.haco.Controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.HomepageService;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Notice;
import kr.co.haco.VO.Qna;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "management/")
public class ManagementBoardController {

	@Autowired
	HomepageService homepageService;

	// ///게시판////////////////////
	// 공지
	@RequestMapping(value = "notice", method = RequestMethod.GET)
	public String notice() {
		return "management.notice";
	}

	// 질문과 답변
	@RequestMapping(value = "qna", method = RequestMethod.GET)
	public String qna() {
		return "management.qna";
	}

	// 모임방
	@RequestMapping(value = "community", method = RequestMethod.GET)
	public String community() {
		return "management.community";
	}
	
	// 공지사항 작성 페이지
	@RequestMapping(value = "noticeWrite", method = RequestMethod.GET)
	public String noticeWrite(HttpServletRequest request) {
		return "management.noticeWrite";
	}
	
	// 공지사항 작성
	@RequestMapping(value = "noticeWrite", method = RequestMethod.POST)
	public String noticeWriteProcess(Notice notice, HttpSession session) {
		Employee emp = (Employee)session.getAttribute("employee");
		notice.setAccount_id(emp.getAccount_id());
		notice.setCenter_id(emp.getNow_center_id());
		
		homepageService.insertNotice(notice);
		
		return "redirect:/management/notice";
	}

	// 공지사항(페이지 정보가 없는경우)
	@RequestMapping(value = "notice", method = RequestMethod.GET, params = "!pageNum")
	public String noticeDefault(Model model, HttpServletRequest request,
			HttpSession session, Notice notice) {
		homepageService.getNoticeList(notice, session, model, request.getContextPath());
		return "management.notice";
	}

	// 공지사항 리스트
	@RequestMapping(value = "notice/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
	public String notice(Model model, HttpServletRequest request,
			HttpSession session, @PathVariable String searchType,
			@PathVariable String searchKey, @PathVariable int pageSize,
			@PathVariable int pageNum) {

		Notice notice = new Notice();
		notice.setSearchType(searchType);
		notice.setPageSize(pageSize);
		notice.setPageNum(pageNum);
		notice.setSearchKey(searchKey);

		// 인코딩 설정을 했는데도 인코딩이 꺠질시에는 일일이 바이트 처리 ( server.xml 설정 변경으로 사용안함 )
		/*
		 * try { notice.setSearchKey(new
		 * String(searchKey.getBytes("8859_1"),"UTF-8")); } catch
		 * (UnsupportedEncodingException e) { e.printStackTrace(); }
		 */

		if (searchKey.equals("[noKeyword]")) {
			notice.setSearchKey("");
		}

		homepageService.getNoticeList(notice, session, model,
				request.getContextPath());
		return "management.notice";
	}

	// 공지사항 읽기
	@RequestMapping(value = "noticeView/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/noticeId/{notice_id}", method = RequestMethod.GET)
	public String noticeView(Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			RedirectAttributes redirectAttributes, @PathVariable int pageSize,
			@PathVariable int pageNum, @PathVariable int notice_id,
			@PathVariable String searchType, @PathVariable String searchKey) {

		Notice notice = homepageService.getNotice(request, response, session, notice_id);

		if (notice == null) {
			return "redirect:/error/PageNotFound"; // 없는 페이지
		} else if (notice.getError() != null) {
			redirectAttributes.addFlashAttribute("errorMsg", notice.getError());
			return "redirect:/error";
		}

		notice.setSearchKey(searchKey);
		notice.setSearchType(searchType);
		notice.setPageNum(pageNum);
		notice.setPageSize(pageSize);

		model.addAttribute("notice", notice);
		return "management.noticeView";
	}

	// 공지사항 수정 페이지
	@RequestMapping(value = "noticeModify/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/noticeId/{notice_id}", method = RequestMethod.GET)
	public String noticeModify(Model model, @PathVariable int pageSize,
			@PathVariable int pageNum, @PathVariable int notice_id,
			@PathVariable String searchType, @PathVariable String searchKey) {

		Notice notice = homepageService.getNotice(notice_id);
		notice.setSearchKey(searchKey);
		notice.setSearchType(searchType);
		notice.setPageNum(pageNum);
		notice.setPageSize(pageSize);

		model.addAttribute("notice", notice);

		return "management.noticeModify";
	}

	// 공지사항 수정
	@RequestMapping(value = "noticeModifyProcess", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	public String noticeModifyProcess(Notice notice) {
		homepageService.updateNotice(notice);

		//Redirect시 UTF-8 > ISO8859로 인코딩 변환해야함
		try {
			notice.setSearchKey(new String(notice.getSearchKey().getBytes("UTF-8"),"8859_1"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/management/noticeView/pageSize/" + notice.getPageSize()
				+ "/pageNum/" + notice.getPageNum() + "/searchType/"
				+ notice.getSearchType() + "/searchKey/"
				+ notice.getSearchKey() + "/noticeId/" + notice.getNotice_id();
	}

	// 공지 사항 삭제
	@RequestMapping(value = "noticeDelete/{notice_id}", method = RequestMethod.GET)
	public String noticeDelete(@PathVariable int notice_id, Model model) {
		homepageService.deleteNotice(notice_id);
		return "redirect:/management/notice";
	}

	
	
	// 질문과 답변(페이지 정보가 없는경우)
	@RequestMapping(value = "qna", method = RequestMethod.GET, params = "!pageNum")
	public String qnaDefault(Model model, HttpServletRequest request, Qna qna) {
		homepageService.getQnaList(qna, model, request.getContextPath());
		return "management.qna";
	}

	// 질문과 답변
	@RequestMapping(value = "qna/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
	public String qna(Model model, HttpServletRequest request, @PathVariable String searchType,
			@PathVariable String searchKey, @PathVariable int pageSize,
			@PathVariable int pageNum) {
		Qna qna = new Qna();
		qna.setSearchType(searchType);
		qna.setPageSize(pageSize);
		qna.setPageNum(pageNum);
		qna.setSearchKey(searchKey);

		if (searchKey.equals("[noKeyword]")) {
			qna.setSearchKey("");
		}

		homepageService.getQnaList(qna, model, request.getContextPath());
		return "management.qna";
	}

	// 질문과 답변 읽기
	@RequestMapping(value = "qnaView/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/qnaId/{qna_id}", method = RequestMethod.GET)
	public String qnaView(Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			RedirectAttributes redirectAttributes, @PathVariable int pageSize,
			@PathVariable int pageNum, @PathVariable int qna_id,
			@PathVariable String searchType, @PathVariable String searchKey) {

		Qna qna = homepageService.getQna(request, response, session, qna_id);

		if (qna == null) {
			return "redirect:/error/PageNotFound"; // 없는 페이지
		} else if (qna.getError() != null) {
			redirectAttributes.addFlashAttribute("errorMsg", qna.getError());
			return "redirect:/error";
		}

		qna.setGroup_no(qna.getQna_id());
		homepageService.getQnaList(qna, model, request.getContextPath());
		
		qna.setSearchKey(searchKey);
		qna.setSearchType(searchType);
		qna.setPageNum(pageNum);
		qna.setPageSize(pageSize);

		model.addAttribute("qna", qna);
		return "management.qnaView";
	}

	// 질문과 답변 수정 페이지
	@RequestMapping(value = "qnaModify/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/qnaId/{qna_id}", method = RequestMethod.GET)
	public String qnaModify(Model model, @PathVariable int pageSize,
			@PathVariable int pageNum, @PathVariable int qna_id,
			@PathVariable String searchType, @PathVariable String searchKey) {

		Qna qna = homepageService.getQna(qna_id);
		qna.setSearchKey(searchKey);
		qna.setSearchType(searchType);
		qna.setPageNum(pageNum);
		qna.setPageSize(pageSize);

		model.addAttribute("qna", qna);

		return "management.answerModify";
	}

	// 질문과 답변 수정
	@RequestMapping(value = "qnaModifyProcess", method = RequestMethod.POST)
	public String qnaModifyProcess(Qna qna) {
		homepageService.updateQna(qna);
		try {
			qna.setSearchKey(new String(qna.getSearchKey().getBytes("UTF-8"),"8859_1"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/management/qnaView/pageSize/" + qna.getPageSize() + "/pageNum/"
				+ qna.getPageNum() + "/searchType/" + qna.getSearchType()
				+ "/searchKey/" + qna.getSearchKey() + "/qnaId/"
				+ qna.getQna_id();
	}

	// 질문과 답변 삭제
	@RequestMapping(value = "qnaDelete/{qna_id}", method = RequestMethod.GET)
	public String qnaDelete(@PathVariable int qna_id, Model model) {
		homepageService.deleteQna(qna_id);
		return "redirect:/management/qna";
	}

	// 답변 작성 페이지
	@RequestMapping(value = "answerWrite/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}/qnaId/{qna_id}", method = RequestMethod.GET)
	public String answerWrite(Model model, @PathVariable int pageSize,
			@PathVariable int pageNum, @PathVariable int qna_id,
			@PathVariable String searchType, @PathVariable String searchKey) {

		Qna qna = homepageService.getQna(qna_id);
		qna.setSearchKey(searchKey);
		qna.setSearchType(searchType);
		qna.setPageNum(pageNum);
		qna.setPageSize(pageSize);
		qna.setGroup_no(qna_id);

		qna.setTitle(qna.getTitle() + " - 답변");
		qna.setContent(qna.getContent() + "<hr/><br/>&nbsp;");

		model.addAttribute("qna", qna);

		return "management.answerWrite";
	}

	// 답변 작성
	@RequestMapping(value = "answerWrite", method = RequestMethod.POST)
	public String answerWriteProcess(Qna answer, HttpSession session)
			throws NullPointerException {
		Employee employee = (Employee) session.getAttribute("employee");
		answer.setAccount_id(employee.getAccount_id());
		answer.setDivide_code('A');
		homepageService.insertAnswer(answer);

		return "redirect:/management/qna";
	}
}
