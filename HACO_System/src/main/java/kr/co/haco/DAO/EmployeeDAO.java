package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EmployeeList;

public interface EmployeeDAO {
	//직원 등록
	public int getAccountId();
	public void addAccount();	
	public void setUserId(int account_id);
	public void addEmployee(Employee employee);
	
	//직원 목록 조회
	public List<EmployeeList> getEmpList(int job_code,int now_center_id);
	public List<EducationCenter>getEduCenterList();
	
	//직원 상세정보 조회
	public Employee getEmp(int acccount_id);
	
	//직원 상세정보 수정
	public int updateEmp(Employee emp);
}
