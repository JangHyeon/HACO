package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

public interface EmployeeService{
	
	//직원 등록
	@Transactional
	@PreAuthorize("hasAnyRole('MASTER','CENTER')")
	public HashMap<String, Integer> addEmployee(Employee employee);
	
	//직원 목록 조회
	//public List<EmployeeList> getEmplList(int job_code, int now_center_id);
	public void getEmplList(int job_code, int now_center_id,Model model,int pageNum, int pageSize);
	
	//센터 목록 조회
	public List<EducationCenter> getEduCenterList();
	
	//직원 상세정보 조회
	public Employee getEmp(int account_id);
	
	//직원 상세정보 수정
	public int updateEmp(Employee emp);
}