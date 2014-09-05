package kr.co.haco.Service;

import java.sql.Time;
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
		public int insertSubject(Subject subject, String start, String end) {
		
		

		subject.setCapacity(Integer.parseInt(subject.getLecture_totalday_String().replace(",", "")));
		subject.setLecture_totalday(Integer.parseInt(subject.getLecture_totalday_String().replace(",", "")));
		subject.setTuition_fee(Integer.parseInt(subject.getTuition_fee_String().replace(",", "")));
		 
		
		 Time start1 =  Time.valueOf(start + ":00");
         Time end1 =  Time.valueOf(end + ":00");
         long a = (end1.getTime() - start1.getTime()) / 1000;
         int time3 = (int) (subject.getLecture_totalday() * a);
         Subject subject2 = new Subject(subject.getSubject_id(),
               subject.getSubject_name(), subject.getCapacity(),
               subject.getSubject_explanation(),
               subject.getInstructional_objectives(),
               subject.getSubject_point(), subject.getLecture_target(),
               subject.getLecture_totalday(), subject.getTuition_fee(),
               subject.getLecture_content(), subject.getCenter_id(), start1,
               end1, time3 / 3600);
		return sqlSession.getMapper(SubjectDAO.class).insertSubject(subject2);
	}
	
	
	@Override
	public int updateSubject(Subject subject, String start, String end) {
		
		

		subject.setCapacity(Integer.parseInt(subject.getCapacity_String().replace(",", "")));
		subject.setLecture_totalday(Integer.parseInt(subject.getLecture_totalday_String().replace(",", "")));
		subject.setTuition_fee(Integer.parseInt(subject.getTuition_fee_String().replace(",", "")));
		
		
		     Time start1 = null;
	         Time end1 = null;
	         if (start.length() < 7) {
	            start1 = Time.valueOf(start + ":00");
	         } else {
	            start1 = Time.valueOf(start);
	         }
	         if (end.length() < 7) {
	            end1 = Time.valueOf(end + ":00");
	         } else {
	            end1 = Time.valueOf(end);
	         }
	         long a = (end1.getTime() - start1.getTime()) / 1000;
	         int b = (int) (subject.getLecture_totalday() * a);
	         Subject subject2 = new Subject(subject.getSubject_id(),
	               subject.getSubject_name(), subject.getCapacity(),
	               subject.getSubject_explanation(),
	               subject.getInstructional_objectives(),
	               subject.getSubject_point(), subject.getLecture_target(),
	               subject.getLecture_totalday(), subject.getTuition_fee(),
	               subject.getLecture_content(), start1, end1, b / 3600);	
		return sqlSession.getMapper(SubjectDAO.class).updateSubject(subject2);
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
		if(subject2.getPageSize()==0) subject2.setPageSize(8);
		if(subject2.getSearchType()==null || subject2.getSearchType().equals("")) subject2.setSearchType("subject");
		if(subject2.getSearchKey()==null || subject2.getSearchKey().equals("")) subject2.setSearchKey("");		
	    // 현 페이지 정보
		int pageNum = subject2.getPageNum();
		int pageSize = subject2.getPageSize();	
		int start = pageNum * pageSize - (pageSize -1)-1;
		subject2.setStartNum(start);
		List<Subject2> SubjectList = sqlSession.getMapper(SubjectDAO.class).getSubjectList(subject2);
		int SubjectListCount = sqlSession.getMapper(SubjectDAO.class).getSubjectListCount(subject2);
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
	
	@Override
	public void getSubjectList(String searchType, int pageSize, int pageNum,
			String searchKey, Model model, String contextPath) {
	        Subject2 subject2 = new Subject2();
	        subject2.setPageNum(pageNum);
	        subject2.setPageSize(pageSize);
	        subject2.setSearchKey(searchKey);
	        subject2.setSearchType(searchType);
	        if (searchKey.equals("[noKeyword]")) {
	        	subject2.setSearchKey("");
	         }
	        if(pageNum==0) subject2.setPageNum(1);
			if(pageSize==0) subject2.setPageSize(8);
			if(searchType==null || searchType.equals("")) subject2.setSearchType("subject");
			if(searchKey==null || searchKey.equals("")) subject2.setSearchKey("");		
		 
			// 현 페이지 정보
			int NowpageNum = subject2.getPageNum();
			int NowpageSize = subject2.getPageSize();	
			int start = NowpageNum * NowpageSize - (NowpageSize -1)-1;
			subject2.setStartNum(start);
			List<Subject2> SubjectList = sqlSession.getMapper(SubjectDAO.class).getSubjectList(subject2);
			int SubjectListCount = sqlSession.getMapper(SubjectDAO.class).getSubjectListCount(subject2);
			model.addAttribute("SubjectListCount", SubjectListCount);

			// 페이징 처리 하단!
			int visiblePageNum = 10;
			int pagecount = 0;
			int beginPage = 0;
			int endPage = 0;
			if (SubjectListCount != 0) {// 게시물이 없는 경우
				pagecount = SubjectListCount / NowpageSize;// 115건 = 11page
				if (SubjectListCount % NowpageSize > 0) {// 115건 = 나머지 5 true
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
			model.addAttribute("searchType",subject2.getSearchType());		
			//검색어가 없는경우 재처리
			if(subject2.getSearchKey().equals("")) subject2.setSearchKey("[noKeyword]");
			model.addAttribute("searchKey",subject2.getSearchKey());
			model.addAttribute("SubjectList",SubjectList);	
		
	}

}
