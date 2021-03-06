package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.DAO.AttendanceDAO;
import kr.co.haco.VO.AttendanceMember;
import kr.co.haco.VO.AttendanceOpenCourse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AttendanceServiceImpl implements AttendanceService{

	@Autowired
	SqlSession sqlSession;
	
	public List<AttendanceOpenCourse> getattenlist(HashMap<String, Object> map) {
		return sqlSession.getMapper(AttendanceDAO.class).getattenlist(map);
	}

	public List<AttendanceMember> getstudentlist(HashMap<String, Object> map) {
		return sqlSession.getMapper(AttendanceDAO.class).getstudentlist(map);
	}
	public int insertatt(HashMap<String, Object> att) {
		return sqlSession.getMapper(AttendanceDAO.class).insertatt(att);
	}
}
