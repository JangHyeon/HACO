package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.Notice;

public interface HomepageDAO {
	public int getNoticeListCount(Notice notice);
	public List<Notice> getNoticeList(Notice notice);
	
	public int insertNotice(Notice notice);
}
