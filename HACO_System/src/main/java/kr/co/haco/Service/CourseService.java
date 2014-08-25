package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.educationCenter;
import kr.co.haco.VO.getCourseList;

import org.springframework.security.access.prepost.PreAuthorize;

public interface CourseService {
///////////////////////////과정 부분///////////////////////////
	
// 과정:목록..
@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public List<getCourseList> getCourseList();
// 과정:상세보기..
@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public List<getCourseList> getCourseList2(String open_course_id);
// 과정:교육장검색..
@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public List<educationCenter> getCenter();

// 과정:강의실검색..
@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public List<CenterClassroom> getClassroom(int center_id);

// 과정:검색..
@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public int insertCourse(OpenCourse course);
// 과정:삭제..
@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public int deleteCourse(String open_course_id);
// 과정:수정..
@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public int updateCourse(OpenCourse course);
// 과정:삭제..

}
