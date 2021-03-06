package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.getCourseList;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;

public interface CourseService {
	
public void getCourseList(getCourseList getCourseList, Model model, String contextPath);

public void getCourseList(String searchType, int pageSize, int pageNum,
		String searchKey, Model model, String contextPath);
     
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

public int CKsubjectid(int subject_id);
public int CKopencouseid(int open_course_id);
public int CKcenterid(int center_id);
public int CKcenterid2(int center_id);
public int CKroomid(int center_classroom_id);
public List<Employee> getname(int center_id);

}