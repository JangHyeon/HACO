package kr.co.Foundation.Service;

import java.util.List;

import kr.co.Foundation.VO.Employee;
import kr.co.Foundation.VO.Roles;

import org.springframework.security.access.prepost.PreAuthorize;

public interface AccountService {
	@PreAuthorize("hasRole('MASTER')")
	public List<Roles> getRoleList();
	
	@PreAuthorize("hasRole('MASTER')")
	public Employee getEmployee(String account_id);
}