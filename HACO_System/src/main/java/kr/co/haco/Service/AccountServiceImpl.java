package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.AccountDAO;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Roles;

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
