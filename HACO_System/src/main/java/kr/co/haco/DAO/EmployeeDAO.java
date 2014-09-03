package kr.co.haco.DAO;

import java.util.List;
import java.util.Map;

import kr.co.haco.VO.Authority;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EmployeeList;

public interface EmployeeDAO {
	//직원 등록
	public int getAccountId();
	public int addAccount();	
	public int setUserId(int account_id);
	public int setAuthority(Authority authority);
	public int addEmployee(Employee employee);
	
	//직원 목록 조회
	public int getEmployeeCount(Map paraMap);
	public List<EmployeeList> getEmpList(Map paraMap);
	public List<EducationCenter>getEduCenterList();
	
	//직원 상세정보 조회
	public String getUserId(int account_id);
	public Employee getEmp(int acccount_id);
	
	//직원 상세정보 수정
	public int setUserIdWithId(int acccount_id,String user_id);
	public int updateEmp(Employee emp);
}
