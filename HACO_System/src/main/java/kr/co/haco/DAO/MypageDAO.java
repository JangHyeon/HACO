package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.MyLectureHistory;

public interface MypageDAO {
	//수강내역
	public List<MyLectureHistory> getMyLecture(int account_id);	
	//강의평가 - 설문내용 불러오기 : 질문, 보기		
	public List<EvaluationRegister> getEvaluationQuestion(int open_course_id);
	public List<EvaluationRegister> getEvaluationExample(int open_course_id);
	//강의평가 하기
	 //주관식 답변
	public int uploadEvalAnswer(EvalQuestionAnswer evalQuestAnswer);
	 //객관식 답변
	public int uploadEvalExam(EvalExampleResult evalExampleResult);
}
