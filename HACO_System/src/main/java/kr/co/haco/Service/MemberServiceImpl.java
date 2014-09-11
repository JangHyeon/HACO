package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.haco.DAO.MemberDAO;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.MemberOfAcademy;
import kr.co.haco.VO.OpenCourse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

//자동으로 
@Component
public class MemberServiceImpl implements MemberService {

   @Autowired
   SqlSession sqlSession;
   
   //사이트 회원 목록
   @Override
   public void getMemberOfSiteList(Model model,int pageSize,int pageNum) {
      MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);      
      
      //for페이징
      int startNum = pageNum * pageSize - (pageSize -1)-1;      
      System.out.println("startNum:"+startNum);
      
      //DAO에 보낼 parameter
      Map<String, Integer> isResultMap = new HashMap<String, Integer>();            
      isResultMap.put("startNum", startNum);
      isResultMap.put("pageSize", pageSize);      
      
      //DAO로부터 데이터 select수행      
      List<Member> memberList = memberDAO.getMemberOfSite(isResultMap);
      model.addAttribute("memberList", memberList);      
      
      // 검색된 총 게시물 건수      
      int MemberOfSiteCount = memberDAO.getMemberOfSiteCount();
      
      // 페이징 처리      
      int visiblePageNum = 10;
      int pagecount = 0;
      int beginPage = 0;
      int endPage = 0;
      if (MemberOfSiteCount != 0) {// 게시물이 없는 경우
         pagecount = MemberOfSiteCount / pageSize;// 115건 = 11page
         if (MemberOfSiteCount % pageSize > 0) {// 115건 = 나머지 5 true
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
   }
   
   //수강중인 원생 목록
   @Override
   public void getMemberOfAcademyList(int center_id,int open_course_id,Model model,int pageNum, int pageSize) {
      MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);      
      
      //for페이징
      int startNum = pageNum * pageSize - (pageSize -1)-1;      
      System.out.println("startNum:"+startNum);
      
      //DAO에 보낼 parameter
      Map<String, Integer> isResultMap = new HashMap<String, Integer>();            
      isResultMap.put("startNum", startNum);
      isResultMap.put("pageSize", pageSize);   
      isResultMap.put("center_id",center_id);
      isResultMap.put("open_course_id",open_course_id);      
      
      //DAO로부터 데이터 select수행      
      List<MemberOfAcademy> memberList = memberDAO.getMember(isResultMap);   
      model.addAttribute("memberList", memberList);
      
      // 검색된 총 게시물 건수      
      int memberCount = memberDAO.getMemberCount(isResultMap);      
      
      // 페이징 처리      
      int visiblePageNum = 10;
      int pagecount = 0;
      int beginPage = 0;
      int endPage = 0;
      if (memberCount != 0) {// 게시물이 없는 경우
         pagecount = memberCount / pageSize;// 115건 = 11page
         if (memberCount % pageSize > 0) {// 115건 = 나머지 5 true
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
   }
   
   //개설과정 목록
   @Override
   public List<OpenCourse> getCourseList(int center_id) {
      MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
      OpenCourse oc = new OpenCourse();
      oc.setCenter_id(center_id);
      List<OpenCourse> courseList = memberDAO.getCourseList(oc);
      return courseList;
   }
   
   
}