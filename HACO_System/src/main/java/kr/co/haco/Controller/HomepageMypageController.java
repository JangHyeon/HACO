package kr.co.haco.Controller;

import java.security.Principal;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.HomepageMyPageService;
import kr.co.haco.Service.LectureRegisterService;
import kr.co.haco.VO.Account;
import kr.co.haco.VO.Attenlist;
import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.LectureRegisterList;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.MyLectureHistory;
import kr.co.haco.VO.OpenCourseList;
import kr.co.haco.VO.Subject;

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
public class HomepageMypageController {

	@Autowired
	AccountService accountService;
	
	@Autowired
	HomepageMyPageService homepageMyPageService;
	
	@Autowired
	LectureRegisterService lectureRegisterService;
	
	//수강신청page
	@RequestMapping(value = "/lectureregister", method = RequestMethod.GET)
	public String lectureregister(HttpServletRequest req) {
		Calendar c = Calendar.getInstance();
		String month = ""+(c.get(Calendar.MONTH)+1);
		if(month.length()==1) {month= "0" +month;};
		String today = c.get(Calendar.YEAR) +"-" + month +"-"+(c.get(Calendar.DATE));
		System.out.println(c.get(Calendar.YEAR));
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println(today);
		map.put("today", today);
		String proid = req.getParameter("proid");
		map.put("proid", proid);
		map.put("limit", 0);
		List<OpenCourseList> getopencourselist = lectureRegisterService.getopencourselist(map);
		req.setAttribute("getopencourselist", getopencourselist);
		
		return "homepage.lectureregister";
	}
	//과정설명
	@RequestMapping(value = "/lecture", method = RequestMethod.GET)
	public String lecture(HttpSession session,HttpServletRequest req) {
		Member member = (Member) session.getAttribute("member");
		String opid = req.getParameter("opid");
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("course_id", opid);
		if(member!=null){
			int account_id = member.getAccount_id();
			System.out.println("account_id : " + account_id);
			map.put("account_id", account_id);
			map.put("open_course_id", opid);
			LectureRegisterList lecturemember = lectureRegisterService.lecturemember(map);
			Account a = accountService.getAccountToAccount_id((account_id+""));
			req.setAttribute("lecturemember", lecturemember);
			req.setAttribute("a", a);
			map.put("member_check", 1); // 회원일때
		}else {
			map.put("member_check", 0); // 비회원일때
		}
		req.setAttribute("member", member);
		Subject getCNT = lectureRegisterService.getCNT(map);
		req.setAttribute("getCNT", getCNT);
		return "homepage.lecture";
	}
		
   
   //수강신청완료 page
   @RequestMapping(value = "/lecturesuccess", method = RequestMethod.GET)
   public String lecturesuccess(HttpSession session,HttpServletRequest req) {
      
      int account_id = Integer.parseInt(req.getParameter("account_id"));
      int op = Integer.parseInt(req.getParameter("opid"));
      
      Subject sbj = new Subject();
      
      sbj.setCourse_name(req.getParameter("course_name"));
      sbj.setName_kor(req.getParameter("name_kor"));
      sbj.setCourse_start_date(java.sql.Date.valueOf(req.getParameter("course_start_date")));
      sbj.setCourse_end_date(java.sql.Date.valueOf(req.getParameter("course_end_date")));
      sbj.setLecture_time_start(Time.valueOf(req.getParameter("lecture_time_start")));
      sbj.setLecture_time_end(Time.valueOf(req.getParameter("lecture_time_end")));
      sbj.setTuition_fee(Integer.parseInt(req.getParameter("tuition_fee")));
      sbj.setLocation(req.getParameter("location"));
      sbj.setCNT(Integer.parseInt(req.getParameter("CNT")));
      sbj.setCapacity(Integer.parseInt(req.getParameter("capacity")));
      sbj.setLecture_content(req.getParameter("lecture_content"));
      sbj.setName(req.getParameter("name"));
      sbj.setAccount_id(Integer.parseInt(req.getParameter("account_id")));
      /*if(sbj.getCapacity() <= sbj.getCNT())
      { 
         return "homepage.lecturefailed";
      }*/
      System.out.println(req.getParameter("account_id"));
      System.out.println(sbj.getAccount_id());
      /*if(member.getAccount_id() == sbj.getAccount_id()){
         return "homepage.lecturefailed2";
      }*/
      req.setAttribute("sbj", sbj);
      HashMap<String,Integer> map = new HashMap<String,Integer>();
      System.out.println();
      map.put("account_id", account_id);
      map.put("open_course_id",op);
      
      lectureRegisterService.insertlecture(map);

      
      return "homepage.lecturesuccess";
   }
	
	
	// 수강 내역
	@RequestMapping(value = "/myLectureHistory", method = RequestMethod.GET)
	public String myLecture(Model model, Principal principal, HttpServletRequest req, HttpSession session) {
		int account_id = Integer.parseInt(principal.getName());
		List<MyLectureHistory> myLectureList = homepageMyPageService.getMyLecture(account_id);
		model.addAttribute("myLectureList", myLectureList);
		return "homepage.myLectureHistory";
	}

	// 출석정보
	@RequestMapping(value = "/attenlist", method = RequestMethod.GET)
	public String attenlist(HttpServletRequest req, Principal principal, int open_course_id) {
		int account_id = Integer.parseInt(principal.getName());
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("account_id", account_id);
		map.put("open_course_id", open_course_id);
		System.out.println("account_id : " + account_id);
		List<Attenlist> getattenlist = homepageMyPageService.getattenlist(map);
		req.setAttribute("getattenlist", getattenlist);
		return "homepage.myattenlist";
	}
	// 출석정보
	@RequestMapping(value="memberattendance", method=RequestMethod.GET)
	public String memberattendance(){
		return "homepage.memberattendance";
	}

	// 강의평가 하기 - 평가 내용 가져오기
	@RequestMapping(value = "/myLectureEvaluation", method = RequestMethod.GET)
	public String myLectureEval(Model model, Principal principal, int open_course_id) {
		Map evaluation = homepageMyPageService.getEvaluation(open_course_id);

		List<EvaluationRegister> questionList = (List<EvaluationRegister>) evaluation.get("questionList");
		List<EvaluationRegister> examList = (List<EvaluationRegister>) evaluation.get("examList");

		// 보기를 질문별로 List에 담기
		List<List<EvaluationRegister>> examListofList = new ArrayList<List<EvaluationRegister>>();
		List<EvaluationRegister> exam = null;
		for (int i = 0; i < examList.size(); i++) {
			if (i == 0) {
				exam = new ArrayList<EvaluationRegister>();
				exam.add(examList.get(i));
			} else {
				if (examList.get(i - 1).getQuestion_id() == examList.get(i).getQuestion_id()) { // 같은 문제의 보기일 때
					exam.add(examList.get(i));
				} else {
					examListofList.add(exam);
					exam = null;
					exam = new ArrayList<EvaluationRegister>();
					exam.add(examList.get(i));
				}
			}

			if (i == examList.size() - 1) {
				examListofList.add(exam);
			}

		}

		model.addAttribute("questionList", questionList);
		model.addAttribute("examListofList", examListofList);

		System.out.println("questionList.size():" + questionList.size());
		System.out.println("examListofList.size()" + examListofList.size());
		/*
		 * for(int i=0;i<examListofList.size();i++){
		 * System.out.println("examListofList.get("
		 * +i+").size:"+examListofList.get(i).size()); }
		 */
		return "homepage.myLectureEvaluation";
	}

	// 설문 하기
	@RequestMapping(value = "/myLectureEvaluation", method = RequestMethod.POST)
	@ResponseBody
	public int doEvaluation(Model model, String answerList, Principal principal) throws JSONException {
		System.out.println("Controller : myLectureEvaluation");
		// System.out.println("answerList:"+answerList);
		int result = 0;
		int account_id = Integer.parseInt(principal.getName());

		/*
		 * answerList Sample : 총4문제
		 * [{"question_id":"155","type_code":"2","answer":"ㅋㅋㅋ"},
		 * {"question_id":"156","type_code":"1","example_id":"2"},
		 * {"question_id":"157","type_code":"2","answer":"ㅎㅎㅎ"},
		 * {"question_id":"158","type_code":"1","example_id":"3"}]
		 * 
		 * =>공통 데이터 때문에 아래와 같이 변경
		 * 
		 * { "sub1":{"course_id":"26"}, "sub2":{"answerData": [
		 * {"question_id":"162","type_code":"1","example_id":"154"},
		 * {"question_id":"163","type_code":"1","example_id":"161"},
		 * {"question_id":"164","type_code":"1","example_id":"163"} ] } }
		 */

		JSONObject receiveJson = new JSONObject(answerList);
		JSONObject commonSub = receiveJson.getJSONObject("sub1");
		int open_course_id = Integer.parseInt((String) commonSub
				.get("course_id"));
		System.out.println("open_course_id:" + open_course_id);

		JSONObject answerSub = receiveJson.getJSONObject("sub2");
		JSONArray answerJsonArray = answerSub.getJSONArray("answerData");
		// System.out.println("a:"+answerJsonArray.getJSONObject(0).get("question_id"));

		// 문제 하나씩 처리하는 for문
		for (int i = 0; i < answerJsonArray.length(); i++) {
			JSONObject answerJson = answerJsonArray.getJSONObject(i);

			int question_id = Integer.parseInt((String) answerJson.get("question_id"));
			System.out.println("question_id:" + question_id);
			String type_code = (String) answerJson.get("type_code");
			System.out.println("type_code:" + type_code);
			String answer = "";
			int example_id = 0;

			if (type_code.equals("1")) { // 객관식일 때
				example_id = Integer.parseInt((String) answerJson.get("example_id"));

				EvalExampleResult evalExampleResult = new EvalExampleResult();
				evalExampleResult.setAccount_id(account_id);
				evalExampleResult.setExample_id(example_id);
				evalExampleResult.setOpen_course_id(open_course_id); // Test
																		// data
				evalExampleResult.setQuestion_id(question_id);
				Map<String, Object> answerAndExam = new HashMap<String, Object>();
				answerAndExam.put("EvalExampleResult", evalExampleResult);

				result += homepageMyPageService.uploadEval(account_id,
						open_course_id, answerAndExam);
			} else if (type_code.equals("2")) { // 주관식일 때
				answer = (String) answerJson.get("answer");
				EvalQuestionAnswer evalQuestionAnswer = new EvalQuestionAnswer();
				evalQuestionAnswer.setAccount_id(account_id);
				evalQuestionAnswer.setQuestion_id(question_id);
				evalQuestionAnswer.setAnswer(answer);
				Map<String, Object> answerAndExam = new HashMap<String, Object>();
				answerAndExam.put("EvalQuestionAnswer", evalQuestionAnswer);

				result += homepageMyPageService.uploadEval(account_id,
						open_course_id, answerAndExam);
			}
		}
		System.out.println("result:" + result);

		return result;
	}
}