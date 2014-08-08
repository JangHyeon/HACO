package kr.co.Foundation.DAO;

import java.util.List;

import kr.co.Foundation.VO.Employee;
import kr.co.Foundation.VO.Roles;

public interface AccountDAO {
	public List<Roles> getRoleList();
	public Employee getEmployee(String account_id);
}
