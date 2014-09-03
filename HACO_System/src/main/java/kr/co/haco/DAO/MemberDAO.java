package kr.co.haco.DAO;

import java.util.List;
import java.util.Map;

import kr.co.haco.VO.Member;
import kr.co.haco.VO.MemberOfAcademy;
import kr.co.haco.VO.OpenCourse;

public interface MemberDAO {
   //사이트 회원 총 수
   public int getMemberOfSiteCount();
   //사이트 회원 조회
   public List<Member> getMemberOfSite(Map isResultMap);
   
   //수강 중인 회원 총 수
   public int getMemberCount(Map isResultMap);
   //수강 중인 회원 목록
   public List<MemberOfAcademy> getMember(Map isResultMap);
   //개설과정 목록
   public List<OpenCourse> getCourseList(OpenCourse openCourse);
   
}