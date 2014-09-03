package kr.co.haco.DAO;

import java.util.List;
import java.util.Map;

import kr.co.haco.VO.Notice;
import kr.co.haco.VO.Qna;
import kr.co.haco.VO.UploadFile;

public interface HomepageDAO {
	//파일 업로드
	public int insertuploadFile(UploadFile uploadFile);
	
	//공지사항
	public int getNoticeListCount(Notice notice);
	public List<Notice> getNoticeList(Notice notice);
	public int insertNotice(Notice notice);
	public List<Integer> getLectureRegisterByMember(int account_id);
	public int countNotice(int notice_id);
	public Notice getNotice(int notice_id);
	public int updateNotice(Notice notice);
	public int deleteNotice(int notice_id);
	
	//질문과 답변
	public int insertQna(Qna qna);
	public int getQnaListCount(Qna qna);
	public List<Qna> getQnaList(Qna qna);
	public int countQna(int qna_id);
	public Qna getQna(int qna_id);
	public int updateQna(Qna qna);
	public int deleteQna(int qna_id);
	
	//메인페이지
	public long getTotalFileSize();
	public long getTotalImageSize();
	public int getTotalMemberNumber();
	public int getTotalStudentNumber();
	public int getNewStudentNumber();
	public int getNewEmployeeNumber();
	public int getNewNoticeNumber();
	public int getNewQnaNumber();
	public int getBestTeacher();
	public List<Qna> getWaitAnswerList();
	public int getBestIncentive(int account_id);
	public List<Map<String, Object>> getPast7monthsList();
	public List<Notice> getEmployeeNoticeList(Notice notice);
	
}
