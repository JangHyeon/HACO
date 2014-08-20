package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.LectureRegister;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Roles;

import org.springframework.security.access.prepost.PreAuthorize;

public interface AccountService{
	//서비스 인터페이스에서 세부 권한 설정	
	/*
	  권한이 맞지 않으면
	  security.xml 에서 설정한 access-denied-page로 이동
	  
	<security:http access-decision-manager-ref="accessDecisionManager"
			access-denied-page="/login?error=denied"
			use-expressions="true">*/
	
	@PreAuthorize("hasRole('MASTER')")
	public List<Roles> getRoleList();
	
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public Employee getEmployee(String account_id);
	public List<OpenCourse> getattenlist(HashMap map);
	public List<Member> getstdentlist(HashMap map);
	public LectureRegister getregister(LectureRegister lecture_register_id);
	public EducationCenter getcenter(EducationCenter location);
	public CenterClassroom getclassroom(CenterClassroom classroom);
	public Employee getemployee(Employee name_kor);
	
}