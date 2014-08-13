package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Roles;
import kr.co.haco.VO.Subject;

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
	
	
	
	//과목등록: 리스트..
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public List<Subject> getSubjectList();

	
	
	//과목등록: 수정..
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public List<Subject> getSubjectList2(String subject_id);
	
	//과목등록: 추가..
	@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
	public int insertSubject(Subject subject);
	
	
	
	
	
	
	
}