package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.AccountDAO;
import kr.co.haco.DAO.CourceDAO;
import kr.co.haco.DAO.SubjectDAO;
import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.Subject2;
import kr.co.haco.VO.educationCenter;
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

	
	@Override
	public void getCourseList(getCourseList getCourseList, Model model, String contextPath){
		
		//기본값 설정
		if(getCourseList.getPageNum()==0) getCourseList.setPageNum(1);
		if(getCourseList.getPageSize()==0) getCourseList.setPageSize(10);
		if(getCourseList.getSearchType()==null || getCourseList.getSearchType().equals("")) getCourseList.setSearchType("teacher");
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
		System.out.println("CourseList: "+CourseList);
		// 검색된 총 게시물 건수
		int CourseListCount = sqlSession.getMapper(CourceDAO.class).getCourseListCount(getCourseList);
		System.out.println("CourseListCount: "+CourseListCount);
		
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
}