package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.Member;
import kr.co.haco.VO.MemberOfAcademy;
import kr.co.haco.VO.OpenCourse;

public interface MemberService {
	//사이트 회원 목록
	public List<Member> getMemberOfSiteList();
	//수강 중인 회원 목록
	public List<MemberOfAcademy> getMemberOfAcademyList(int center_id, int open_course_id);
	//개설과정 목록
	public List<OpenCourse> getCourseList(int center_id);

	
}
