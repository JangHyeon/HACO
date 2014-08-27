package kr.co.haco.Service;

import java.util.List;

import javax.servlet.http.HttpSession;

import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Notice;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.Subject2;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;

public interface SubjectService {
	///////////////////////////과목 부분///////////////////////////
	
	public void getSubjectList(Subject2 subject2, Model model, String contextPath);
	
	// 과목:목록..
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public List<Subject> getsubjectList();

	// 과목:상세..
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public List<Subject> getSubjectList2(String subject_id);

	// 과목:추가..
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public int insertSubject(Subject subject);

	// 과목:수정..
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public int updateSubject(Subject subject);

	// 과목:삭제..
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public int deleteSubject(String subject_id);
	////////////////////////////////////////////////////////////////////
	
	// 강사명검색.
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public List<Employee> getName(String name);
	////////////////////////////////////////////////////////////////////
	
}
