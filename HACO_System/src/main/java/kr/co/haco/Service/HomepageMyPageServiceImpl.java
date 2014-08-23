package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.haco.DAO.MypageDAO;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.MyLectureHistory;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class HomepageMyPageServiceImpl implements HomepageMyPageService {
	@Autowired
	SqlSession sqlsession;
	
	//수강내역
	@Override
	public List<MyLectureHistory> getMyLecture(int account_id) {
		System.out.println("HomepageMyPageServiceImpl_getMyLecture:수강내역");
		MypageDAO mypageDAO = sqlsession.getMapper(MypageDAO.class);
		List<MyLectureHistory> myLectureList =  mypageDAO.getMyLecture(account_id);
		return myLectureList;
	}
	
	//강의평가 - 설문내용 불러오기
	@Override
	public Map<String,List<EvaluationRegister>> getEvaluation(int open_course_id) {
		MypageDAO mypageDAO = sqlsession.getMapper(MypageDAO.class);		
		List<EvaluationRegister> questionList = mypageDAO.getEvaluationQuestion(open_course_id);
		List<EvaluationRegister> examList = mypageDAO.getEvaluationExample(open_course_id);
		Map<String,List<EvaluationRegister>> evaluation = new HashMap<String,List<EvaluationRegister>>();
		evaluation.put("questionList", questionList);
		evaluation.put("examList", examList);		
		return evaluation;
	}
	
}
