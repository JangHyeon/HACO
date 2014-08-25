package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.MyLectureHistory;

public interface HomepageMyPageService {
	//수강 내역
	public List<MyLectureHistory> getMyLecture(int account_id);
	
	
	//강의평가 - 설문내용 불러오기
	@Transactional
	public Map<String,List<EvaluationRegister>> getEvaluation(int open_course_id);
	
	//강의평가 하기
	public int uploadEvalResult(EvalQuestionAnswer evalQuestionAnswer);
}
