package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.EvaluationRegisterForm;

import org.springframework.transaction.annotation.Transactional;

public interface EvaluationRegisterService {
	//개설과정 목록
	public List<EvaluationRegisterForm> getEvaluationRegistList(int isResult);
	
	//평가 등록 폼- 기본정보(과정명, 과목명 , 강사명 , 수강기간)
	public EvaluationRegisterForm getEvaluationRegisterform(int open_course_id);
		
	@Transactional
	//평가 등록
	public int addEvalution(EvaluationRegister evalRegister);
	
	//평가 결과 보기 - 일단은 객관식만
	public List<EvalExampleResult> getEvalResult(int open_course_id);
	
}
