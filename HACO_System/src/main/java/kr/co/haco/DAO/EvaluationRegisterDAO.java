package kr.co.haco.DAO;

import java.util.List;
import java.util.Map;

import kr.co.haco.VO.EvalExample;
import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestion;
import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.EvaluationRegisterForm;

public interface EvaluationRegisterDAO {
   //개설과정 목록 총 갯수
   public int getEvaluationRegistListCount(Map isResultMap);
   //개설과정 목록
   public List<EvaluationRegisterForm> getEvaluationRegistList(Map isResultMap);
   //평가 등록 폼- 기본정보(과정명, 과목명 , 강사명 , 수강기간)
   public EvaluationRegisterForm getEvaluationRegisterform(int open_course_id);
      
   //평가 등록
   public int getQuestionId();
   public int addEvaluation(EvaluationRegister evalRegister);
   //public int addQuestion(Map<String,Object> questionMap);
   public int addQuestion(EvalQuestion evalRegister);
   public int addQuestionExample(EvalExample evalRegister);   
      
   //강의평가 - 설문내용 불러오기 : 질문, 보기      
   public List<EvaluationRegister> getEvaluationQuestion(int open_course_id);
   public List<EvaluationRegister> getEvaluationExample(int open_course_id);
   
   //평가 결과 -일단은 객관식만
   public List<EvalExampleResult> getEvalExamResult(int open_course_id);
   //평가 결과 -일단은 주관식만
   public List<EvalQuestionAnswer> getEvalEssayResult(int open_course_id);
}