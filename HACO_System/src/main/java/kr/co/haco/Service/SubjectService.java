package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.Subject2;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;

public interface SubjectService {
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public void getSubjectList(Subject2 subject2, Model model, String contextPath);
	
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public void getSubjectList(String searchType, int pageSize, int pageNum,
			String searchKey, Model model, String contextPath);
	
	
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public List<Subject> getsubjectList();

	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public List<Subject> getSubjectList2(String subject_id);

	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public int insertSubject(Subject subject  ,String start , String end);

	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public int updateSubject(Subject subject, String start , String end);
	
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public int deleteSubject(String subject_id);

	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public List<Employee> getName(String name);
	
	
}
