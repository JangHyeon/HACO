package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.AccountDAO;
import kr.co.haco.DAO.CourceDAO;
import kr.co.haco.DAO.SubjectDAO;
import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.educationCenter;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CourseServiceImpl implements CourseService {

	@Autowired
	SqlSession sqlSession;
	
	
	@Override
	public List<kr.co.haco.VO.getCourseList> getCourseList() {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(CourceDAO.class).getCourseList();
	}

	@Override
	public List<kr.co.haco.VO.getCourseList> getCourseList2(
			String open_course_id) {
		// TODO Auto-generated method stub
			return sqlSession.getMapper(CourceDAO.class).getCourseList2(open_course_id);
	}
	
	@Override
	public List<CenterClassroom> getClassroom(int center_id) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(CourceDAO.class).getClassroom(center_id);
	}

	@Override
	public List<educationCenter> getCenter() {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(CourceDAO.class).getCenter();
	}

	
	@Override
	public int insertCourse(OpenCourse course) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(CourceDAO.class).insertCourse(course);
	}

	@Override
	public int deleteCourse(String open_course_id) {
		// TODO Auto-generated method stub

		return sqlSession.getMapper(CourceDAO.class).deleteCourse(open_course_id);
	}

	@Override
	public int updateCourse(OpenCourse course) {
		return sqlSession.getMapper(CourceDAO.class).updateCourse(course);
	
	}

	
}