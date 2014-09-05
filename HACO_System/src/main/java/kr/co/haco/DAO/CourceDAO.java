package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.getCourseList;

public interface CourceDAO {

   
   public List<getCourseList> getCourseList2(String open_course_id);
   public List<CenterClassroom> getClassroom(int center_id);
   public List<EducationCenter> getCenter();
   public List<EducationCenter> getCenter2(int center_id);
   public int insertCourse(OpenCourse course);
   public int deleteCourse(String open_course_id);
   public int updateCourse(OpenCourse course);
   
   public List<getCourseList>  getCourseList(getCourseList courseList);
   public int getCourseListCount(getCourseList courseList);
   public int CKsubjectid(int subject_id);
   public int CKopencouseid(int open_course_id);
   public int CKcenterid(int center_id);
   public int CKcenterid2(int center_id);
   public int CKroomid(int center_classroom_id);
   public List<Employee> getname(int center_id);
}