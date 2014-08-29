package kr.co.haco.Controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.HomepageMyPageService;
import kr.co.haco.VO.Attenlist;
import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.MyLectureHistory;
import kr.co.haco.VO.OpenCourseList;

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
	public String myLecture(Model model,Principal principal,HttpServletRequest req,HttpSession session) {		
		int account_id = Integer.parseInt(principal.getName());
		List<MyLectureHistory> myLectureList = homepageMyPageService.getMyLecture(account_id);
		model.addAttribute("myLectureList", myLectureList);
		return "homepage.myLectureHistory";
	}
	//출석정보
		@RequestMapping(value = "/attenlist", method = RequestMethod.GET)
		public String attenlist(HttpServletRequest req,Principal principal,int open_course_id) {
			
			int account_id = Integer.parseInt(principal.getName());
			HashMap map = new HashMap();
			map.put("account_id", account_id);
			map.put("open_course_id", open_course_id);
			System.out.println("account_id : " + account_id);
			List<Attenlist> getattenlist = homepageMyPageService.getattenlist(map);
			req.setAttribute("getattenlist", getattenlist);
			return "homepage.myattenlist";
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
		model.addAttribute("examListofList", examListofList);
		
		System.out.println("questionList.size():"+questionList.size());
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
		System.out.println("Controller : myLectureEvaluation");		
		//System.out.println("answerList:"+answerList);
		int result =0;
		int account_id = Integer.parseInt(principal.getName());		
		
		/*answerList Sample : 총4문제
		[{"question_id":"155","type_code":"2","answer":"ㅋㅋㅋ"},
		{"question_id":"156","type_code":"1","example_id":"2"},
		{"question_id":"157","type_code":"2","answer":"ㅎㅎㅎ"},
		{"question_id":"158","type_code":"1","example_id":"3"}] 
		
		=>공통 데이터 때문에 아래와 같이 변경
		
		{
		"sub1":{"course_id":"26"},
		"sub2":{"answerData":
		        [
			 {"question_id":"162","type_code":"1","example_id":"154"},
			 {"question_id":"163","type_code":"1","example_id":"161"},
			 {"question_id":"164","type_code":"1","example_id":"163"}
		        ]
		      }
		} 
		*/
		
		JSONObject receiveJson = new JSONObject(answerList);
		JSONObject commonSub = receiveJson.getJSONObject("sub1");
		int open_course_id = Integer.parseInt((String)commonSub.get("course_id"));
		System.out.println("open_course_id:"+open_course_id);
				
		JSONObject answerSub = receiveJson.getJSONObject("sub2");		
		JSONArray answerJsonArray = answerSub.getJSONArray("answerData");		
		//System.out.println("a:"+answerJsonArray.getJSONObject(0).get("question_id"));
		
		
		//문제 하나씩 처리하는 for문
		for(int i=0; i<answerJsonArray.length(); i++){
			JSONObject answerJson = answerJsonArray.getJSONObject(i);
			
			int question_id=Integer.parseInt((String)answerJson.get("question_id"));
			System.out.println("question_id:"+question_id);
			String type_code = (String)answerJson.get("type_code");
			System.out.println("type_code:"+type_code);
			String answer="";
			int example_id=0;						
			
			if(type_code.equals("1")){           //객관식일 때
				example_id = Integer.parseInt((String)answerJson.get("example_id"));
				
				EvalExampleResult evalExampleResult = new EvalExampleResult();
				evalExampleResult.setAccount_id(account_id);
				evalExampleResult.setExample_id(example_id);
				evalExampleResult.setOpen_course_id(open_course_id); //Test data
				evalExampleResult.setQuestion_id(question_id);
				Map<String, Object> answerAndExam = new HashMap<String, Object>();
				answerAndExam.put("EvalExampleResult", evalExampleResult);				
				
				result += homepageMyPageService.uploadEval(account_id,open_course_id,answerAndExam);
			}else if(type_code.equals("2")){     //주관식일 때
				answer = (String)answerJson.get("answer");
				EvalQuestionAnswer evalQuestionAnswer = new EvalQuestionAnswer();
				evalQuestionAnswer.setAccount_id(account_id);
				evalQuestionAnswer.setQuestion_id(question_id);
				evalQuestionAnswer.setAnswer(answer);
				Map<String, Object> answerAndExam = new HashMap<String, Object>();
				answerAndExam.put("EvalQuestionAnswer", evalQuestionAnswer);
				
				result += homepageMyPageService.uploadEval(account_id,open_course_id,answerAndExam);
			}			
		}
		System.out.println("result:"+result);		
		
		return result;
	}

	

}
