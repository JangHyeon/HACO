package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.Subject;

public interface SubjectDAO {
	public List<Subject> getSubjectList();
	public List<Subject> getSubjectList2(String subject_id);
	public int insertSubject(Subject subject);
	public int updateSubject(Subject subject);
	public int deleteSubject(String subject_id);
}
