package kr.co.Foundation.Service;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;

import kr.co.Foundation.VO.Employee;

public interface UserService {
	
	public int insert(Employee employee);
	
	public void insertAuthority(String email, String authority);
	
	public Employee login(Employee employee);
	
	@PreAuthorize("#user.email == principal.username or hasRole('ROLE_ADMIN')")
	public int modify(Employee employee);
	
	@PreAuthorize("#user.email == principal.username or hasRole('ROLE_ADMIN')")
	public void changePasswd(Employee employee);
	
	@PreAuthorize("#user.email == principal.username or hasRole('ROLE_ADMIN')")
	public void bye(Employee employee);
	
	//모든 회원정보를 가져온다.
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public List<Employee> getAllUsers();
	
	//이메일로 회원를 찾는다.
	@PreAuthorize("#email == principal.username or hasRole('ROLE_ADMIN')")
	public Employee getUserByEmail(String email);
	
	//키워드 검색으로 회원을 찾는다.
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public List<Employee> getUsersByKeyword(String keyword);
}
