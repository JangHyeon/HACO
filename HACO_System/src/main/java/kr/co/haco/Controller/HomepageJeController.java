package kr.co.haco.Controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.haco.Service.HomepageMyPageService;
import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.MyLectureHistory;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomepageJeController {
	@Autowired
	HomepageMyPageService homepageMyPageService;

	//마이 페이지
	
	//수강 내역
	@RequestMapping(value = "/myLectureHistory", method = RequestMethod.GET)
	public String myLecture(Model model,Principal principal) {		
		int account_id = Integer.parseInt(principal.getName());
		System.out.println("account_id:"+account_id);
		List<MyLectureHistory> myLectureList = homepageMyPageService.getMyLecture(account_id);
		model.addAttribute("myLectureList", myLectureList);
		return "homepage.myLectureHistory";
	}
	//강의평가 하기 - 평가 내용 가져오기
	@RequestMapping(value = "/myLectureEvaluation", method = RequestMethod.GET)
	public String myLectureEval(Model model,Principal principal,int open_course_id) {		
		int account_id = Integer.parseInt(principal.getName());
		//System.out.println("account_id:"+account_id);
		Map evaluation =homepageMyPageService.getEvaluation(open_course_id);
		
		List<EvaluationRegister> questionList = (List<EvaluationRegister>) evaluation.get("questionList");
		List<EvaluationRegister> examList = (List<EvaluationRegister>) evaluation.get("examList");
		
		//보기를 질문별로 List에 담기
		List<List<EvaluationRegister>> examListofList = new ArrayList<List<EvaluationRegister>>();
		List<EvaluationRegister> exam = null;
		for(int i=0; i<examList.size();i++){
			if(i==0){
				exam = new ArrayList<EvaluationRegister>();
				exam.add(examList.get(i));
			}else{
				if(examList.get(i-1).getQuestion_id()==examList.get(i).getQuestion_id()){ //같은 문제의 보기일 때
					exam.add(examList.get(i));					
				}else{
					examListofList.add(exam);
					exam = null;
					exam = new ArrayList<EvaluationRegister>();
					exam.add(examList.get(i));
				}
			}
			
			if(i==examList.size()-1){
				examListofList.add(exam);
			}			
			
		}
		
		
		model.addAttribute("questionList", questionList);
		System.out.println("questionList.size():"+questionList.size());
		model.addAttribute("examListofList", examListofList);
		System.out.println("examListofList.size()"+examListofList.size());
		/*for(int i=0;i<examListofList.size();i++){
			System.out.println("examListofList.get("+i+").size:"+examListofList.get(i).size());
		}*/
		return "homepage.myLectureEvaluation";
	}
	//설문 하기
	@RequestMapping(value = "/myLectureEvaluation", method = RequestMethod.POST)	
	@ResponseBody
	public int doEvaluation(Model model,String answerList, Principal principal) throws JSONException{
		System.out.println("Controller-myLectureEvaluation");		
		int result =0;
		int account_id = Integer.parseInt(principal.getName());
		
		JSONArray answerJsonArray = new JSONArray(answerList);
		for(int i=0; i<answerJsonArray.length(); i++){
			JSONObject answerJson = answerJsonArray.getJSONObject(i);
			int question_id=Integer.parseInt((String)answerJson.get("question_id"));
			String answer = (String)answerJson.get("answer");
			System.out.println("question_id:"+question_id);
			System.out.println("answer:"+answer);
			
			EvalQuestionAnswer evalQuestionAnswer = new EvalQuestionAnswer();
			evalQuestionAnswer.setAccount_id(account_id);
			evalQuestionAnswer.setQuestion_id(question_id);
			evalQuestionAnswer.setAnswer(answer);
			
			result += homepageMyPageService.uploadEvalResult(evalQuestionAnswer);			
		}
		System.out.println("result:"+result);		
		
		return result;
	}

	

}