package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Roles;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

public interface EmployeeService{
	
	@Transactional
	@PreAuthorize("hasRole('MASTER')")
	public void addEmployee(Employee employee);
}