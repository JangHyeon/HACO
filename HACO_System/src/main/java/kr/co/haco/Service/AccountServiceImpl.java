package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.AccountDAO;
import kr.co.haco.VO.Account;
import kr.co.haco.VO.Authority;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.Roles;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccountServiceImpl implements AccountService {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<Roles> getRoleList() {
		return sqlSession.getMapper(AccountDAO.class).getRoleList();
	}

	@Override
	public Employee getEmployee(String account_id) {
		return sqlSession.getMapper(AccountDAO.class).getEmployee(account_id);
	}

	@Override
	public String checkId(String id) {
		String result;
		if (sqlSession.getMapper(AccountDAO.class).checkId(id) == null) {
			result = "ok";
		} else {
			result = "error";
		}
		return result;
	}

	@Override
	public int joinMember(Account account, Member member) {
		sqlSession.getMapper(AccountDAO.class).insertAccount(account);
		member.setAccount_id(sqlSession.getMapper(AccountDAO.class).getLastInsertId());
		sqlSession.getMapper(AccountDAO.class).insertAuthority(new Authority(member.getAccount_id(),"GUEST"));
		int result = sqlSession.getMapper(AccountDAO.class).insertMember(member);
		return result;
	}
}
