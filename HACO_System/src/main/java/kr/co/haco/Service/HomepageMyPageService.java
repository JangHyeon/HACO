package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.haco.VO.Attenlist;
import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestionAnswer;
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
		//주관식일 때
	public int uploadEvalAnswerResult(EvalQuestionAnswer evalQuestionAnswer);
		//객관식일 때
	public int uploadEvalExamResult(EvalExampleResult evalExampleResult);
	public List<Attenlist> getattenlist(HashMap map);
}
