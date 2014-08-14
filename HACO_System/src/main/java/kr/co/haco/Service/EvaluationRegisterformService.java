package kr.co.haco.Service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import kr.co.haco.VO.EvaluationRegisterForm;


public interface EvaluationRegisterformService {

	// 윗부분 과정명, 과목명 , 강사명 , 수강기간 뿌려주기
	public List<EvaluationRegisterForm> getEvaluationRegisterform(String course_name);
	
	// 객관식 질문 등록하기
	/*public List<EvaluationRegisterForm> getinsertquestion(int type_code , String question);
	public int getlastid(); 
	*/
}
