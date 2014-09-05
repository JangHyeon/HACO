package kr.co.haco.Service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.haco.VO.Notice;
import kr.co.haco.VO.Qna;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;


public interface HomepageService {
	public void getNoticeList(Notice notice, HttpSession session, Model model, String contextPath);
	public String CkeditorUpload(MultipartHttpServletRequest request, String board, String command, String type);
	public int insertNotice(Notice notice);
	
	@Transactional
	public Notice getNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session,int notice_id);
	public Notice getNotice(int notice_id);
	public int updateNotice(Notice notice);
	public int deleteNotice(int notice_id);
	
	public int insertQuestion(Qna question);
	public void getQnaList(Qna qna, Model model, String contextPath);
	@Transactional
	public Qna getQna(HttpServletRequest request, HttpServletResponse response,HttpSession session, int qna_id);
	public Qna getQna(int qna_id);
	public int updateQna(Qna qna);
	public int deleteQna(int qna_id);
	public int insertAnswer(Qna answer);
}
