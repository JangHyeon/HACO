package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EmployeeList;

public interface EmployeeDAO {
	public int getAccountId();
	public void addAccount(int account_id);	
	public void addEmployee(Employee employee);
	public List<EmployeeList> getEmpList(int job_code,int now_center_id);
	public List<EducationCenter>getEduCenterList();
}
