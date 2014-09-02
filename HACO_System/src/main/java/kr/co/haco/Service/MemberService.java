package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.MemberOfAcademy;
import kr.co.haco.VO.OpenCourse;

import org.springframework.ui.Model;

public interface MemberService {
	//사이트 회원 목록
	public void getMemberOfSiteList(Model model,int pageSize,int pageNum);
	//수강 중인 회원 목록
	public void getMemberOfAcademyList(int c_id,int open_course_id,Model model,int pageNum, int pageSize);
	//개설과정 목록
	public List<OpenCourse> getCourseList(int center_id);

	
}
