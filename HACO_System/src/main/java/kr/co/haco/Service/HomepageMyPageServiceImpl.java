package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.haco.DAO.MypageDAO;
import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestionAnswer;
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
	
	//강의평가 하기	
	@Override
	public int uploadEval(int account_id, int open_course_id,Map<String, Object> answerAndExam) {
		System.out.println("HomepageMyPageServiceImpl :uploadEval");
		MypageDAO mypageDAO = sqlsession.getMapper(MypageDAO.class); 
		int result=0;
		System.out.println("account_id:"+account_id);
		System.out.println("open_course_id:"+open_course_id);
		result += mypageDAO.setIsSurvey(account_id, open_course_id);
		System.out.println("setIsSurvey result:"+result);
		for(int i=0; i<answerAndExam.size(); i++){
			 for(String s : answerAndExam.keySet()){
				 System.out.println(i+":"+s);
				 if(answerAndExam.get(s).equals("EvalQuestionAnswer")) { //주관식 일때					 
					 result += mypageDAO.uploadEvalAnswer((EvalQuestionAnswer)answerAndExam.get(i));
					 System.out.println("EvalQuestionAnswer result:"+result);
					 
					 EvalQuestionAnswer e = (EvalQuestionAnswer)answerAndExam.get(i);
					 System.out.println("getAccount_id:"+e.getAccount_id());
					 System.out.println("getAnswer:"+e.getAnswer());
					 System.out.println("getOpen_course_id:"+e.getOpen_course_id());
					 System.out.println("getQuestion:"+e.getQuestion());
					 System.out.println("getQuestion_id:"+e.getQuestion_id());
					 System.out.println("EvalQuestionAnswer result:"+result);
			     }else{ //객관식 일때
			    	 result += mypageDAO.uploadEvalExam((EvalExampleResult)answerAndExam.get(i));
			    	 System.out.println("EvalExampleResult result:"+result);
			    	 
			    	 EvalExampleResult e = (EvalExampleResult)answerAndExam.get(i);			    	 
			    	 System.out.println("getAccount_id:"+e.getAccount_id());					 
					 System.out.println("getOpen_course_id:"+e.getOpen_course_id());
					 System.out.println("getQuestion:"+e.getQuestion());
					 System.out.println("getQuestion_id:"+e.getQuestion_id());					 
			     }
			 }
		}
		
		return result;
	}
	
	
}
