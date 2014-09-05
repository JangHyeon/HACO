package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.haco.DAO.MypageDAO;
import kr.co.haco.VO.Attenlist;
import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.EvaluationRegisterForm;
import kr.co.haco.VO.MyLectureHistory;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;



@Component
public class HomepageMyPageServiceImpl implements HomepageMyPageService {
   @Autowired
   SqlSession sqlsession;
   
   //수강내역
   @Override
   public List<MyLectureHistory> getMyLecture(int account_id) {
      System.out.println("HomepageMyPageServiceImpl_getMyLecture:수강내역");
      MypageDAO mypageDAO = sqlsession.getMapper(MypageDAO.class);
      List<MyLectureHistory> myLectureList =  mypageDAO.getMyLecture(account_id);
      return myLectureList;
   }
   
   //강의평가 - 기본정보 불러오기
   @Override
   public EvaluationRegisterForm getEvaluationRegisterform(int open_course_id) {
      return sqlsession.getMapper(MypageDAO.class).getEvaluationRegisterform(open_course_id);      
   }
   
   //강의평가 - 설문내용 불러오기
   @Override
   public Map<String,List<EvaluationRegister>> getEvaluation(int open_course_id) {
      MypageDAO mypageDAO = sqlsession.getMapper(MypageDAO.class);      
      List<EvaluationRegister> questionList = mypageDAO.getEvaluationQuestion(open_course_id);
      List<EvaluationRegister> examList = mypageDAO.getEvaluationExample(open_course_id);
      Map<String,List<EvaluationRegister>> evaluation = new HashMap<String,List<EvaluationRegister>>();
      evaluation.put("questionList", questionList);
      evaluation.put("examList", examList);      
      return evaluation;
   }
   public List<Attenlist> getattenlist(HashMap<String,Integer> map){
      return sqlsession.getMapper(MypageDAO.class).getattenlist(map);
   }
   //강의평가 하기   
   @Override
   public int uploadEval(int account_id, int open_course_id,Map<String, Object> answerAndExam) {
      System.out.println("HomepageMyPageServiceImpl :uploadEval");
      MypageDAO mypageDAO = sqlsession.getMapper(MypageDAO.class); 
      int result=0;
      
      result += mypageDAO.setIsSurvey(account_id, open_course_id);
      System.out.println("setIsSurvey result:"+result);
      
      System.out.println("answerAndExam.size():"+answerAndExam.size());
      for(int i=0; i<answerAndExam.size(); i++){         
         if(answerAndExam.get("EvalExampleResult") != null){ //객관식일 때
            System.out.println("EvalExampleResult null아님 -객관식");
            EvalExampleResult evalexample = (EvalExampleResult)answerAndExam.get("EvalExampleResult");            
            result += mypageDAO.uploadEvalExam(evalexample);
             System.out.println("EvalExampleResult result:"+result);
         }else{ //주관식일 때
            System.out.println("EvalQuestionAnswer null임-주관식");
            result += mypageDAO.uploadEvalAnswer((EvalQuestionAnswer)answerAndExam.get("EvalQuestionAnswer"));
            System.out.println("EvalQuestionAnswer result:"+result);
         }   
      }
      
      return result;
   }
   
   
}