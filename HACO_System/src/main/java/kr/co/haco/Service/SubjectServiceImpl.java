package kr.co.haco.Service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import kr.co.haco.DAO.HomepageDAO;
import kr.co.haco.DAO.SubjectDAO;
import kr.co.haco.Util.DateUtil;
import kr.co.haco.Util.myStringUtils;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.Notice;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.Subject2;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

@Component
public class SubjectServiceImpl implements SubjectService {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<Subject> getsubjectList() {
		return sqlSession.getMapper(SubjectDAO.class).getsubjectList();
	}
	@Override
	public List<Subject> getSubjectList2(String subject_id) {
		return sqlSession.getMapper(SubjectDAO.class).getSubjectList2(
				subject_id);
	}
	@Override
	public int insertSubject(Subject subject) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SubjectDAO.class).insertSubject(subject);
	}
	@Override
	public int updateSubject(Subject subject) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SubjectDAO.class).updateSubject(subject);
	}
	@Override
	public int deleteSubject(String subject_id) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SubjectDAO.class).deleteSubject(subject_id);
	}
	
	
	
	@Override
	public List<Employee> getName(String name) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SubjectDAO.class).getName(name);
		}
	
	
	
	
	
	
	
	
	@Override
	public void getSubjectList(Subject2 subject2, Model model,
			String contextPath) {
		
		//기본값 설정
		if(subject2.getPageNum()==0) subject2.setPageNum(1);
		if(subject2.getPageSize()==0) subject2.setPageSize(5);
		if(subject2.getSearchType()==null || subject2.getSearchType().equals("")) subject2.setSearchType("title");
		if(subject2.getSearchKey()==null || subject2.getSearchKey().equals("")) subject2.setSearchKey("");
		
		
		// 현 페이지 정보
		int pageNum = subject2.getPageNum();
		int pageSize = subject2.getPageSize();	
		int start = pageNum * pageSize - (pageSize -1)-1;
		subject2.setStartNum(start);
		//게시물 리스트 출력
		List<Subject2> SubjectList = sqlSession.getMapper(SubjectDAO.class).getSubjectList(subject2);
		System.out.println("SubjectList: "+SubjectList);
		// 검색된 총 게시물 건수
		int SubjectListCount = sqlSession.getMapper(SubjectDAO.class).getSubjectListCount(subject2);
		System.out.println("SubjectListCount: "+SubjectListCount);
		
		model.addAttribute("SubjectListCount", SubjectListCount);

		// 페이징 처리 하단!
		int visiblePageNum = 10;
		int pagecount = 0;
		int beginPage = 0;
		int endPage = 0;
		if (SubjectListCount != 0) {// 게시물이 없는 경우
			pagecount = SubjectListCount / pageSize;// 115건 = 11page
			if (SubjectListCount % pageSize > 0) {// 115건 = 나머지 5 true
				pagecount++;// 11page++ = 12page
			}
			beginPage = (pageNum - 1) / visiblePageNum * visiblePageNum + 1;// 10단위 계산
			endPage = beginPage + (visiblePageNum - 1);
			if (endPage > pagecount) {
				endPage = pagecount;
			}
		}

		System.out.println("key : "+subject2.getSearchType());
		
		// view에 보낼 데이터
		model.addAttribute("pagecount", pagecount);
		model.addAttribute("beginpage", beginPage);
		model.addAttribute("endpage", endPage);

		model.addAttribute("pageNum",pageNum);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("searchType",subject2.getSearchType());
			
		//검색어가 없는경우 재처리
		if(subject2.getSearchKey().equals("")) subject2.setSearchKey("[noKeyword]");
		model.addAttribute("searchKey",subject2.getSearchKey());
		model.addAttribute("SubjectList",SubjectList);
		
		
	}
	
}
