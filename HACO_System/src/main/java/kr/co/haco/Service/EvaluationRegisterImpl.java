package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.EvaluationRegisterDAO;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.Open_Course;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EvaluationRegisterImpl implements EvaluationRegisterService {
	
	@Autowired
	SqlSession sqlsession;

	@Override
	public List<EvaluationRegister> getevaluationRegist() {
		
		return sqlsession.getMapper(EvaluationRegisterDAO.class).getevaluationRegist();
	}

	
	

	
	
	
}
