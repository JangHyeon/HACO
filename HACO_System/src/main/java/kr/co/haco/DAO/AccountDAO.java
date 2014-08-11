package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Roles;

public interface AccountDAO {
	public List<Roles> getRoleList();
	public Employee getEmployee(String account_id);
}
