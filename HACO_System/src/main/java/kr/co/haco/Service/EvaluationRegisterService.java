package kr.co.haco.Service;

import java.util.List;
import java.util.Map;

import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.EvaluationRegisterForm;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

public interface EvaluationRegisterService {
	//개설과정 목록
	//public List<EvaluationRegisterForm> getEvaluationRegistList(int isResult);
	public void getEvaluationRegistList(int isResult,int pageSize,int pageNum,Model model);
	
	//평가 등록 폼- 기본정보(과정명, 과목명 , 강사명 , 수강기간)
	public EvaluationRegisterForm getEvaluationRegisterform(int open_course_id);
		
	//평가 등록
	@Transactional	
	public int addEvalution(EvaluationRegister evalRegister);
	
	//강의평가 - 설문내용 불러오기
	@Transactional
	public Map<String,List<EvaluationRegister>> getEvaluation(int open_course_id);
	
	//평가 결과 보기 
	//객관식만
	public List<EvalExampleResult> getEvalExamResult(int open_course_id);
	//주관식만
	public List<EvalQuestionAnswer> getEvalEssayResult(int open_course_id);
}
