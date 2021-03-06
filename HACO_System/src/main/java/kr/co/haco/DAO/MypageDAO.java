package kr.co.haco.DAO;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.Attenlist;
import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.EvaluationRegisterForm;
import kr.co.haco.VO.MyLectureHistory;


public interface MypageDAO {
	//수강내역
	public List<MyLectureHistory> getMyLecture(int account_id);	
	//강의평가 - 설문내용 불러오기 : 질문, 보기		
	public List<EvaluationRegister> getEvaluationQuestion(int open_course_id);
	public List<EvaluationRegister> getEvaluationExample(int open_course_id);
	
	//강의평가 - 기본정보 불러오기
	public EvaluationRegisterForm getEvaluationRegisterform(int open_course_id);
	//강의평가 하기
	 //is_survey='Y'처리 - 설문 완료 flag처리
	public int setIsSurvey(int account_id, int open_course_id);
	 //주관식 답변
	public int uploadEvalAnswer(EvalQuestionAnswer evalQuestAnswer);
	 //객관식 답변
	public int uploadEvalExam(EvalExampleResult evalExampleResult);
	public List<Attenlist> getattenlist(HashMap map);
}
