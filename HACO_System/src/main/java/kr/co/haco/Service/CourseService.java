package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Subject2;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.getCourseList;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;

public interface CourseService {
///////////////////////////과정 부분///////////////////////////
public void getCourseList(getCourseList getCourseList, Model model, String contextPath);
		
/*// 과정:목록..
@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public List<getCourseList> getCourseList();*/
// 과정:상세보기..

@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public List<getCourseList> getCourseList2(String open_course_id);
// 과정:교육장검색..

@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public List<EducationCenter> getCenter();

@PreAuthorize("hasAnyRole('TEACHER','MANAGER','CENTER','MASTER')")
public List<EducationCenter> getCenter2(int center_id);

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
