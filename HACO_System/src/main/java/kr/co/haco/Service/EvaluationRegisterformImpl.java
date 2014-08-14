package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.EvaluationRegisterDAO;
import kr.co.haco.DAO.EvaluationRegisterformDAO;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.EvaluationRegisterForm;
import kr.co.haco.VO.Open_Course;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EvaluationRegisterformImpl implements EvaluationRegisterformService {
	
	@Autowired
	SqlSession sqlsession;

	@Override
	public List<EvaluationRegisterForm> getEvaluationRegisterform(String course_name) {
		
		return sqlsession.getMapper(EvaluationRegisterformDAO.class).getEvaluationRegisterform(course_name);
	}

	/*@Override
	public List<EvaluationRegisterForm> getinsertquestion(int type_code,
			String question) {
		
		return sqlsession.getMapper(EvaluationRegisterformDAO.class).insertquestion(type_code, question);
	}

	@Override
	public int getlastid() {
		
		return sqlsession.getMapper(EvaluationRegisterformDAO.class).getlastid();
	}
*/
	

	
	

	
	
	
}
