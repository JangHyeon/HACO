package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.DAO.AccountDAO;
import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.LectureRegister;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.OpenCourse;
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

	public List<OpenCourse> getattenlist(HashMap map) {
		return sqlSession.getMapper(AccountDAO.class).getattenlist(map);
	}

	@Override
	public Employee getEmployee(String account_id) {
		return sqlSession.getMapper(AccountDAO.class).getEmployee(account_id);
	}

	public List<Member> getstdentlist(HashMap map) {
		return sqlSession.getMapper(AccountDAO.class).getstdentlist(map);
	}
	
	public EducationCenter getcenter(EducationCenter location){
		return sqlSession.getMapper(AccountDAO.class).getcenter(location);
	}
	
	public CenterClassroom getclassroom(CenterClassroom classroom){
		return sqlSession.getMapper(AccountDAO.class).getclassroom(classroom);
	}
	
	public Employee getemployee(Employee name_kor){
		return sqlSession.getMapper(AccountDAO.class).getemployee(name_kor);
	}

	@Override
	public LectureRegister getregister(LectureRegister lecture_register_id) {
		return sqlSession.getMapper(AccountDAO.class).getregister(lecture_register_id);
	}

}
