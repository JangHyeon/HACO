package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.Subject;

import org.springframework.security.access.prepost.PreAuthorize;

public interface SubjectService {
	///////////////////////////과목 부분///////////////////////////
	// 과목:목록..
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public List<Subject> getSubjectList();

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
}
