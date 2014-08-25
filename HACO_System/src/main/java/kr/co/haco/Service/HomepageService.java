package kr.co.haco.Service;

import javax.servlet.http.HttpSession;

import kr.co.haco.VO.Notice;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;


public interface HomepageService {
	public void getNoticeList(Notice notice, HttpSession session, Model model);
	
	public String noticeUpload(MultipartHttpServletRequest request);
	public int insertNotice(Notice notice);
	
	public Notice getNotice(int notice_id);
	public int updateNotice(Notice notice);
}
