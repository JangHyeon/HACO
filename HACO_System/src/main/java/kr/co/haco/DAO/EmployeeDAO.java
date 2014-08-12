package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Roles;

public interface EmployeeDAO {
	public int getAccountId();
	public void addAccount(int account_id);	
	public void addEmployee(Employee employee);
}
