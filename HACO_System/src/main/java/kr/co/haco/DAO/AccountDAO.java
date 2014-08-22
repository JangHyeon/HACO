package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.Account;
import kr.co.haco.VO.Authority;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.Roles;

public interface AccountDAO {
	public List<Roles> getRoleList();
	public Employee getEmployee(String account_id);
	
	public int getLastInsertId();
	
	public String checkId(String id);
	public int insertAccount(Account account);
	public int insertAuthority(Authority authority);
	public int insertMember(Member member);
	
	public Account getAccount(Account account);
	public int accountActivation(String activation_key);

	public Member getMember(Member member);
	
	public int updateAccount(Account account);
	public int updateMember(Member member);
	
	public int disableAccount(Account account);
}
