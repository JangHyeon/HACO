package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Notice;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.Subject2;

public interface SubjectDAO {
	
	public List<Subject> getsubjectList();
	public List<Subject> getSubjectList2(String subject_id);
	public int insertSubject(Subject subject);
	public int updateSubject(Subject subject);
	public int deleteSubject(String subject_id);
	public List<Employee> getName(String name);
	

	public int getSubjectListCount(Subject2 subject2);
	public List<Subject2> getSubjectList(Subject2 subject2);
	
	
	
}
