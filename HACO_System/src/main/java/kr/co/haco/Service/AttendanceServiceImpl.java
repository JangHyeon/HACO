package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.DAO.AccountDAO;
import kr.co.haco.DAO.AttendanceDAO;
import kr.co.haco.VO.Attendance;
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
public class AttendanceServiceImpl implements AttendanceService{

	@Autowired
	SqlSession sqlSession;
	
	public List<OpenCourse> getattenlist(HashMap map) {
		return sqlSession.getMapper(AttendanceDAO.class).getattenlist(map);
	}

	public List<Member> getstdentlist(HashMap map) {
		return sqlSession.getMapper(AttendanceDAO.class).getstdentlist(map);
	}
	public List<Attendance> insertatt(HashMap map) {
		return sqlSession.getMapper(AttendanceDAO.class).insertatt(map);
	}
}
