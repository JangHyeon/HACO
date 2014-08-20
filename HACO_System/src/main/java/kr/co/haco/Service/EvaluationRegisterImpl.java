package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.EvaluationRegisterDAO;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.EvaluationRegisterForm;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component
public class EvaluationRegisterImpl implements EvaluationRegisterService {
	
	@Autowired
	SqlSession sqlsession;

	@Override
	public List<EvaluationRegisterForm> getEvaluationRegist() {
		
		return sqlsession.getMapper(EvaluationRegisterDAO.class).getEvaluationRegist();
	}

	@Override
	public EvaluationRegisterForm getEvaluationRegisterform(int open_course_id) {
		return sqlsession.getMapper(EvaluationRegisterDAO.class).getEvaluationRegisterform(open_course_id);
	}

	
	@Override
	public int addEvalution(EvaluationRegister evalRegister) {		
		EvaluationRegisterDAO evalRegisterDAO = sqlsession.getMapper(EvaluationRegisterDAO.class);
		int result=0;
		result += evalRegisterDAO.addEvaluation(evalRegister);
		result += evalRegisterDAO.addQuestion(evalRegister);
		//result += evalRegisterDAO.addQuestionExample(evalRegister);
		return result;
	}



	
	
	

	
	
	
}
