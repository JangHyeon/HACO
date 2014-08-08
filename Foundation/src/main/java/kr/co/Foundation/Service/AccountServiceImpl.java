package kr.co.Foundation.Service;

import java.util.List;

import kr.co.Foundation.DAO.AccountDAO;
import kr.co.Foundation.VO.Employee;
import kr.co.Foundation.VO.Roles;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccountServiceImpl implements AccountService{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Roles> getRoleList(){
		return sqlSession.getMapper(AccountDAO.class).getRoleList();
	}

	@Override
	public Employee getEmployee(String account_id) {
		return sqlSession.getMapper(AccountDAO.class).getEmployee(account_id);
	}
}
