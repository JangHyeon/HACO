package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.EvaluationRegisterForm;

public interface EvaluationRegisterformDAO {
	
	// 윗부분 과정명, 과목명 , 강사명 , 수강기간 뿌려주기
	public List<EvaluationRegisterForm> getEvaluationRegisterform(String course_name);
	
	// 객관식 질문 등록하기 
	/*public List<EvaluationRegisterForm> insertquestion(int type_code , String question);
	public int getlastid(); */
}
