package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.educationCenter;
import kr.co.haco.VO.getCourseList;

public interface CourceDAO {

	public List<getCourseList>  getCourseList();
	public List<getCourseList> getCourseList2(String open_course_id);
	public List<CenterClassroom> getClassroom(int center_id);
	public List<educationCenter> getCenter();
	public int insertCourse(OpenCourse course);
	public int deleteCourse(String open_course_id);
	public int updateCourse(OpenCourse course);
}
