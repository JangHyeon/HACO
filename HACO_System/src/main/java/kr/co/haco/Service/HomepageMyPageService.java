package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.haco.VO.Attenlist;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.MyLectureHistory;

import org.springframework.transaction.annotation.Transactional;

public interface HomepageMyPageService {
   //수강 내역
   public List<MyLectureHistory> getMyLecture(int account_id);
   
   
   //강의평가 - 설문내용 불러오기
   @Transactional
   public Map<String,List<EvaluationRegister>> getEvaluation(int open_course_id);
   
      
   //강의평가 하기   
   @Transactional
   public int uploadEval(int account_id, int open_course_id,Map<String,Object> answerAndExam);
   
   public List<Attenlist> getattenlist(HashMap map);
}