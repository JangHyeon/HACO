package kr.co.haco.Service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import kr.co.haco.DAO.EmployeeDAO;
import kr.co.haco.VO.Employee;


@Component
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	SqlSession sqlSession;
	
	@Override	
	public void addEmployee(Employee employee) {
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		int account_id= employeeDAO.getAccountId();
		employeeDAO.addAccount(account_id);
		employee.setAccount_id(account_id);		
		employeeDAO.addEmployee(employee);
	}
	
}
