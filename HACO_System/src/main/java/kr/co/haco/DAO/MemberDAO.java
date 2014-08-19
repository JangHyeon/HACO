package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.Member;
import kr.co.haco.VO.MemberOfAcademy;
import kr.co.haco.VO.OpenCourse;

public interface MemberDAO {
	//사이트 회원 조회
	public List<Member> getMemberOfSite();
	//수강 중인 회원 목록
	public List<MemberOfAcademy> getMember(int center_id,int open_course_id);
	//개설과정 목록
	public List<OpenCourse> getCourseList(OpenCourse openCourse);
	
}
