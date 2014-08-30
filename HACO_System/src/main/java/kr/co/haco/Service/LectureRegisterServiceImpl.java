package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.co.haco.DAO.AttendanceDAO;
import kr.co.haco.DAO.OpenCourseDAO;
import kr.co.haco.VO.LectureRegisterList;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Student;
import kr.co.haco.VO.Subject;

@Component
public class LectureRegisterServiceImpl implements LectureRegisterService{
	
	@Autowired
	SqlSession sqlSession;
	
	public List<OpenCourse> getopencourselist(HashMap map) {
		return sqlSession.getMapper(OpenCourseDAO.class).getopencourselist(map);
	}
	
/*	public Subject getsubject(HashMap map) {
		return sqlSession.getMapper(OpenCourseDAO.class).getsubject(map);
	}
*/
	public Subject getCNT(HashMap map) {
		return sqlSession.getMapper(OpenCourseDAO.class).getCNT(map);
	}
	public List<LectureRegisterList> getlecturestats(HashMap map) {
		return sqlSession.getMapper(OpenCourseDAO.class).getlecturestats(map);
	}
	public List<LectureRegisterList> getlecturecomplete(HashMap map) {
		return sqlSession.getMapper(OpenCourseDAO.class).getlecturecomplete(map);
	}
	public int insertlecture(HashMap map) {
		return sqlSession.getMapper(OpenCourseDAO.class).insertlecture(map);
	}
	public int updatestudent(HashMap map) {
		return sqlSession.getMapper(OpenCourseDAO.class).updatestudent(map);
	}
	public int cancelstudent(HashMap map) {
		return sqlSession.getMapper(OpenCourseDAO.class).cancelstudent(map);
	}
	public int completestudent(HashMap map) {
		return sqlSession.getMapper(OpenCourseDAO.class).completestudent(map);
	}
}
