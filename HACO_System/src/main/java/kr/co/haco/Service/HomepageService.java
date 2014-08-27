package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.Notice;

import org.springframework.web.multipart.MultipartHttpServletRequest;


public interface HomepageService {
	public int getNoticeListCount(Notice notice);
	public List<Notice> getNoticeList(Notice notice);
	public String noticeUpload(MultipartHttpServletRequest request);
	public int insertNotice(Notice notice);
}
