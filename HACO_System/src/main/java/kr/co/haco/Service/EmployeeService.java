package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EmployeeList;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

public interface EmployeeService{
	
	@Transactional
	@PreAuthorize("hasRole('MASTER')")
	public void addEmployee(Employee employee);
	
	public List<EmployeeList> getEmplList(int job_code, int now_center_id);
	public List<EducationCenter> getEduCenterList();
}