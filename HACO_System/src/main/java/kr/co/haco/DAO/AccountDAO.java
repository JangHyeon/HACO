package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Roles;
import kr.co.haco.VO.Subject;

public interface AccountDAO {
	public List<Roles> getRoleList();
	public Employee getEmployee(String account_id);
	public List<Subject> getSubjectList();
	public List<Subject> getSubjectList(String subject_id);
	public int insertSubject(Subject subject);
}
