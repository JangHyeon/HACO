package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.Account;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.Roles;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

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
	
	public String checkId(String id);
	
	@Transactional
	public int joinMember(Account account, Member member) throws DataIntegrityViolationException ; 
}