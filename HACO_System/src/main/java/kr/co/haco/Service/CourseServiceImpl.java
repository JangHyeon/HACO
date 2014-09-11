package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.CourceDAO;
import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.getCourseList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

@Component
public class CourseServiceImpl implements CourseService {

   @Autowired
   SqlSession sqlSession;


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
   public List<EducationCenter> getCenter() {
      // TODO Auto-generated method stub
      return sqlSession.getMapper(CourceDAO.class).getCenter();
   }
   @Override
   public List<EducationCenter> getCenter2(int center_id) {
      // TODO Auto-generated method stub
      return sqlSession.getMapper(CourceDAO.class).getCenter2(center_id);
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

   
   @Override
   public void getCourseList(getCourseList getCourseList, Model model, String contextPath){
      //기본값 설정
      if(getCourseList.getPageNum()==0) getCourseList.setPageNum(1);
      if(getCourseList.getPageSize()==0) getCourseList.setPageSize(10);
      if(getCourseList.getSearchType()==null || getCourseList.getSearchType().equals("")) getCourseList.setSearchType("center");
      if(getCourseList.getSearchKey()==null || getCourseList.getSearchKey().equals("")) getCourseList.setSearchKey("");
      System.out.println("getSearchType : "+getCourseList.getSearchType());
      System.out.println("getSearchKey : "+getCourseList.getSearchKey());      
      // 현 페이지 정보
      int pageNum = getCourseList.getPageNum();
      int pageSize = getCourseList.getPageSize();   
      int start = pageNum * pageSize - (pageSize -1)-1;
      getCourseList.setStartNum(start);
      //게시물 리스트 출력
      List<getCourseList> CourseList = sqlSession.getMapper(CourceDAO.class).getCourseList(getCourseList);
      // 검색된 총 게시물 건수
      int CourseListCount = sqlSession.getMapper(CourceDAO.class).getCourseListCount(getCourseList);
         model.addAttribute("CourseListCount", CourseListCount);
      // 페이징 처리 하단!
      int visiblePageNum = 10;
      int pagecount = 0;
      int beginPage = 0;
      int endPage = 0;
      if (CourseListCount != 0) {// 게시물이 없는 경우
         pagecount = CourseListCount / pageSize;// 115건 = 11page
         if (CourseListCount % pageSize > 0) {// 115건 = 나머지 5 true
            pagecount++;// 11page++ = 12page
         }
         beginPage = (pageNum - 1) / visiblePageNum * visiblePageNum + 1;// 10단위 계산
         endPage = beginPage + (visiblePageNum - 1);
         if (endPage > pagecount) {
            endPage = pagecount;
         }
      }
      // view에 보낼 데이터
      model.addAttribute("pagecount", pagecount);
      model.addAttribute("beginpage", beginPage);
      model.addAttribute("endpage", endPage);
      model.addAttribute("pageNum",pageNum);
      model.addAttribute("pageSize",pageSize);
      model.addAttribute("searchType",getCourseList.getSearchType());
      //검색어가 없는경우 재처리
      if(getCourseList.getSearchKey().equals("")) getCourseList.setSearchKey("[noKeyword]");
      model.addAttribute("searchKey",getCourseList.getSearchKey());
      model.addAttribute("CourseList",CourseList);   
   }

   @Override
   public void getCourseList(String searchType, int pageSize, int pageNum,
   		String searchKey, Model model, String contextPath) {
	 //기본값 설정
	   
	   getCourseList courseList = new getCourseList();
       courseList.setSearchType(searchType);
       courseList.setPageSize(pageSize);
       courseList.setPageNum(pageNum);
       courseList.setSearchKey(searchKey);
       if (searchKey.equals("[noKeyword]")) {
          courseList.setSearchKey("");
       }
       	if(pageNum==0) courseList.setPageNum(1);
	      if(pageSize==0) courseList.setPageSize(10);
	      if(searchType==null || courseList.getSearchType().equals("")) courseList.setSearchType("center");
	      if(searchKey==null || courseList.getSearchKey().equals("")) courseList.setSearchKey("");   
	      // 현 페이지 정보
	      int NowpageNum = courseList.getPageNum();
	      int NowpageSize = courseList.getPageSize();   
	      int start = NowpageNum * NowpageSize - (NowpageSize -1)-1;
	      courseList.setStartNum(start);
	      //게시물 리스트 출력
	      List<getCourseList> CourseList = sqlSession.getMapper(CourceDAO.class).getCourseList(courseList);
	      // 검색된 총 게시물 건수
	      int CourseListCount = sqlSession.getMapper(CourceDAO.class).getCourseListCount(courseList);
	         model.addAttribute("CourseListCount", CourseListCount);
	      // 페이징 처리 하단!
	      int visiblePageNum = 10;
	      int pagecount = 0;
	      int beginPage = 0;
	      int endPage = 0;
	      if (CourseListCount != 0) {// 게시물이 없는 경우
	         pagecount = CourseListCount / NowpageSize;// 115건 = 11page
	         if (CourseListCount % NowpageSize > 0) {// 115건 = 나머지 5 true
	            pagecount++;// 11page++ = 12page
	         }
	         beginPage = (NowpageNum - 1) / visiblePageNum * visiblePageNum + 1;// 10단위 계산
	         endPage = beginPage + (visiblePageNum - 1);
	         if (endPage > pagecount) {
	            endPage = pagecount;
	         }
	      }
	      // view에 보낼 데이터
	      model.addAttribute("pagecount", pagecount);
	      model.addAttribute("beginpage", beginPage);
	      model.addAttribute("endpage", endPage);
	      model.addAttribute("pageNum",NowpageNum);
	      model.addAttribute("pageSize",NowpageSize);
	      model.addAttribute("searchType",courseList.getSearchType());
	      //검색어가 없는경우 재처리
	      if(courseList.getSearchKey().equals("")) courseList.setSearchKey("[noKeyword]");
	      model.addAttribute("searchKey",courseList.getSearchKey());
	      model.addAttribute("CourseList",CourseList);   
	   }
   
   
   @Override
   public int CKsubjectid(int subject_id) {
      // TODO Auto-generated method stub
      return sqlSession.getMapper(CourceDAO.class).CKsubjectid(subject_id);
      
   }

   @Override
   public int CKopencouseid(int open_course_id) {
      // TODO Auto-generated method stub
      return sqlSession.getMapper(CourceDAO.class).CKopencouseid(open_course_id);
   }

   @Override
   public int CKcenterid(int center_id) {
      // TODO Auto-generated method stub
      return sqlSession.getMapper(CourceDAO.class).CKcenterid(center_id);
      
   }

@Override
public int CKroomid(int center_classroom_id) {
	// TODO Auto-generated method stub
	   return sqlSession.getMapper(CourceDAO.class).CKroomid(center_classroom_id);
}

@Override
public int CKcenterid2(int center_id) {
	  return sqlSession.getMapper(CourceDAO.class).CKcenterid2(center_id);
	     
}

@Override
public List<Employee> getname(int center_id) {
	  return sqlSession.getMapper(CourceDAO.class).getname(center_id);
}




   
}