package kr.co.haco.Service;

import java.util.ArrayList;
import java.util.List;

import kr.co.haco.DAO.EvaluationRegisterDAO;
import kr.co.haco.VO.EvalExample;
import kr.co.haco.VO.EvalQuestion;
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

	
	/*@Override
	public int addEvalution(EvaluationRegister evalRegister) {		
		EvaluationRegisterDAO evalRegisterDAO = sqlsession.getMapper(EvaluationRegisterDAO.class);
		
		System.out.println("EvaluationRegisterImpl - addEvalution");
		System.out.println("evalRegister.getOpen_course_id():"+evalRegister.getOpen_course_id());		
		System.out.println("getType_code:"+evalRegister.getType_code());
		System.out.println("getQuestion:"+evalRegister.getQuestion());	
		
		System.out.println("getExample_content:"+evalRegister.getExample_content());
		
		//split
		String type_code = evalRegister.getType_code();
		String question = evalRegister.getQuestion();
		String question_example = evalRegister.getExample_content();	
		String[] type_codes = type_code.split(",");
		String[] questions = question.split(",");
		String[] examples = question_example.split(",");

		
		//List<EvaluationRegister> eval_question_List = new ArrayList<EvaluationRegister>();
		List<EvalQuestion> eval_question_List = new ArrayList<EvalQuestion>();
		for(int i=0; i<questions.length; i++){
			EvalQuestion evalQuestion = new EvalQuestion();
			evalQuestion.setOpen_course_id(evalRegister.getOpen_course_id());
			evalQuestion.setType_code(type_codes[i]);
			evalQuestion.setQuestion(questions[i]);
			
			System.out.println("evalQuestion.toString():"+evalQuestion.toString());			
			
			eval_question_List.add(evalQuestion);
		}
		System.out.println("eval_question_List size:"+eval_question_List.size());
		//Map에 List를 담아서 DTO로 보낸다.
		Map<String, Object> questionMap = new HashMap<String, Object>();
		questionMap.put ("paramList",eval_question_List);
		
		
		int result=0;
		result += evalRegisterDAO.addEvaluation(evalRegister);
		result += evalRegisterDAO.addQuestion(questionMap);
		//result += evalRegisterDAO.addQuestionExample(evalRegister);
		return result;
	}	
	*/
	
	@Override
	public int addEvalution(EvaluationRegister evalRegister) {
		EvaluationRegisterDAO evalRegisterDAO = sqlsession.getMapper(EvaluationRegisterDAO.class);
		System.out.println("EvaluationRegisterImpl - addEvalution");
		System.out.println("evalRegister.getOpen_course_id():"+evalRegister.getOpen_course_id());		
		System.out.println("getType_code:"+evalRegister.getType_code());
		System.out.println("getQuestion:"+evalRegister.getQuestion());	
		
		System.out.println("getExample_content:"+evalRegister.getExample_content());
		
		//split
		String type_code = evalRegister.getType_code();
		String question = evalRegister.getQuestion();
		String question_example = evalRegister.getExample_content();	
		String[] type_codes = type_code.split(",");
		String[] questions = question.split(",");
		String[] examples = question_example.split(",");
		
		//프린트
		System.out.println("examples.length:"+examples.length);
		for(int i=0; i<examples.length; i++){
			System.out.println("examples["+i+"]:"+examples[i]);
		}		
		
		//보기 List
		List<ArrayList<EvalExample>> exampleArrayListofList = new ArrayList<ArrayList<EvalExample>>();
		ArrayList<EvalExample> question_example_List = new ArrayList<EvalExample>();
		int idx_listoflist=0;
		for(int i=1; i<examples.length;i++){		
			if(examples[i].equals("|") ||examples[i]==examples[examples.length-1] ){				
				exampleArrayListofList.add(question_example_List);
				System.out.println("exampleArrayListofList.get("+idx_listoflist+").size():"+exampleArrayListofList.get(idx_listoflist).size());
				idx_listoflist++;
				System.out.println("question_example_List.size() clear전:"+question_example_List.size());
				//question_example_List.clear();
				//System.out.println("question_example_List.size() clear후:"+question_example_List.size());
			}else{				
				EvalExample evalExample = new EvalExample();
				evalExample.setExample_content(examples[i]);
				question_example_List.add(evalExample);
			}
		}
		System.out.println("exampleArrayListofList.size():"+exampleArrayListofList.size());
		
		//질문 List
		List<EvalQuestion> eval_question_List = new ArrayList<EvalQuestion>();		
		for(int i=0; i<questions.length; i++){
			EvalQuestion evalQuestion = new EvalQuestion();
			evalQuestion.setOpen_course_id(evalRegister.getOpen_course_id());
			evalQuestion.setType_code(type_codes[i]);
			evalQuestion.setQuestion(questions[i]);
			eval_question_List.add(evalQuestion);
			//System.out.println("evalQuestion.toString_question():"+evalQuestion.toString());			
		}
		System.out.println("eval_question_List size:"+eval_question_List.size());
	
		
		int result=0;
		
		//강의 평가 DB등록
		//1. lecture_evaluation테이블 insert
		result += evalRegisterDAO.addEvaluation(evalRegister);
		int j=0;
		for(int i=0; i<eval_question_List.size();i++){
			//2. eval_question 테이블 insert
			result += evalRegisterDAO.addQuestion(eval_question_List.get(i));
			
			//3. 객관식 일때 보기eval_question_example 테이블 insert			
			if (eval_question_List.get(i).getType_code().equals("1")) {
				System.out.println("if문 안의 j:" + j);
				int questionId = evalRegisterDAO.getQuestionId();
				System.out.println("exampleArrayListofList.get("+j+").size():"+exampleArrayListofList.get(j).size());
				for (int x = 0; x < exampleArrayListofList.get(j).size(); x++) {
					exampleArrayListofList.get(j).get(x).setQuestion_id(questionId);
							
					System.out.println("for문 안쪽의 questionId:"+questionId);
					result += evalRegisterDAO.addQuestionExample(exampleArrayListofList.get(j).get(x));
				}
				j++;
				
			}//if
		}//for

		return result;	
	}
	
}
