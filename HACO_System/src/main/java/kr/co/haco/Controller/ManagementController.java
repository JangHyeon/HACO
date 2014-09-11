package kr.co.haco.Controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AttendanceService;
import kr.co.haco.Service.CourseService;
import kr.co.haco.Service.EvaluationRegisterService;
import kr.co.haco.Service.LectureRegisterService;
import kr.co.haco.Service.ManagementService;
import kr.co.haco.Service.SubjectService;
import kr.co.haco.VO.AttendanceMember;
import kr.co.haco.VO.AttendanceOpenCourse;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvalQuestionAnswer;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.LectureRegisterList;
import kr.co.haco.VO.OpenCourse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "management/")
public class ManagementController {

   @Autowired
   ManagementService managementService;
   
   @Autowired
   AttendanceService attendanceService;
   @Autowired
   LectureRegisterService lectureregisterService;
   @Autowired
   EvaluationRegisterService evaluationRegisterService;
   @Autowired
   SubjectService subjectService;
   @Autowired
   CourseService courseService;

   // 대쉬보드
   @RequestMapping(value = { "index", "" }, method = RequestMethod.GET)
   public String index(Model model, HttpServletRequest request) {

      // Top Info Area
      Map<String, Object> topInfo = managementService.getIndexInfo();
      for (String i : topInfo.keySet()) {
         model.addAttribute(i, topInfo.get(i));
      }

      // 최대 저장공간
      long MaxStorage = 1024 * 1024 * 5; // 5GB
      model.addAttribute("maxStorage", MaxStorage);

      // 오늘 날짜
      Date date = new Date();
      model.addAttribute("now", date);

      return "management.index";
   }

   @RequestMapping(value = "attendance", method = RequestMethod.GET)
   public String attendancelist() {
      return "management.attendance";
   }

   // ///////////////////////////과정//////////////////////////////////////////////////////////
   // 출석
   @RequestMapping(value = "attendancelist", method = RequestMethod.GET)
   public String attendancelist(HttpSession session, HttpServletRequest req) {
      Employee eply = (Employee) session.getAttribute("employee");
      String seldate = req.getParameter("attendancesub");
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("center_id", eply.getNow_center_id());
      map.put("seldate", seldate);
      List<AttendanceOpenCourse> getattenlist = attendanceService.getattenlist(map);
      OpenCourse attendance_date = new OpenCourse();
      attendance_date.setSeldate(req.getParameter("attendancesub"));
      req.setAttribute("attendance_date", attendance_date);
      req.setAttribute("getattenlist", getattenlist);
      return "management.attendancelist";
   }

   // 출석
   @RequestMapping(value = "studentlist", method = RequestMethod.GET)
   public String stdentlist(HttpSession session, HttpServletRequest req) {
      AttendanceOpenCourse date = new AttendanceOpenCourse();
      String attendance_date = req.getParameter("attendance_date");
      String center_id = req.getParameter("center_id");
      String open_course_id = req.getParameter("open_course_id");

      HashMap<String, Object> map = new HashMap<String, Object>();
      date.setSeldate(attendance_date);

      map.put("center_id", center_id);
      map.put("open_course_id", open_course_id);
      map.put("attendance_date", attendance_date);

      req.setAttribute("date", date);

      req.setAttribute("open_course_id", open_course_id);
      String[] account_id = req.getParameterValues("account_id");
      if (account_id != null) {
         String[] attendance_code = req.getParameterValues("attendance_code");
         String[] lecture_register_id = req.getParameterValues("lecture_register_id");
         System.out.println("attendance_code : " + attendance_code);
         System.out.println("attendance_date : " + attendance_date);
         System.out.println("center_id : " + center_id);
         System.out.println("open_course_id :" + open_course_id);
         System.out.println("attendance_code : " + attendance_code);
         System.out.println(account_id.length);
         for (int i = 0; i < account_id.length; i++) {

            System.out.println("lecture_register_id : "
                  + lecture_register_id[i]);
            map.put("center_id", Integer.parseInt(center_id));
            map.put("attendance_code", Integer.parseInt(attendance_code[i]));
            map.put("lecture_register_id",Integer.parseInt(lecture_register_id[i]));
            map.put("open_course_id", Integer.parseInt(open_course_id));

            attendanceService.insertatt(map);
         }
      }
      List<AttendanceMember> getstudentlist = attendanceService.getstudentlist(map);
      req.setAttribute("getstudentlist", getstudentlist);
      return "management.studentlist";
   }

   // 교육센터
   @RequestMapping(value = "educationCenter", method = RequestMethod.GET)
   public String educationCenter() {
      return "management.educationCenter";
   }

   // 수강신청
   @RequestMapping(value = "lectureRegister", method = RequestMethod.GET)
   public String lectureRegister(HttpSession session, HttpServletRequest req) {
      Employee eply = (Employee) session.getAttribute("employee");

      String classification = req.getParameter("classification") == null ? "" : req.getParameter("classification");
      String open_course_id = req.getParameter("open_course_id") == null ? "" : req.getParameter("open_course_id");
      String account_id = req.getParameter("account_id") == null ? "" : req.getParameter("account_id");
      System.out.println(classification);
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("open_course_id", open_course_id);
      map.put("account_id", account_id);

      if (classification.equals("grant")) {
         lectureregisterService.updatestudent(map);
      } else if (classification.equals("cancel")) {
         lectureregisterService.cancelstudent(map);
      } else if (classification.equals("complete")) {
         lectureregisterService.completestudent(map);
      }

      Calendar c = Calendar.getInstance();
      String month = "" + (c.get(Calendar.MONTH) + 1);
      if (month.length() == 1) {
         month = "0" + month;
      }
      ;
      String today = c.get(Calendar.YEAR) + "-" + month + "-"
            + (c.get(Calendar.DATE));

      map.put("center_id", eply.getNow_center_id());
      map.put("today", today);

      List<LectureRegisterList> getlecturestats = lectureregisterService
            .getlecturestats(map);
      req.setAttribute("getlecturestats", getlecturestats);
      return "management.lectureRegister";
   }

   // 수강신청완료page
   @RequestMapping(value = "lectureRegisterComplete", method = RequestMethod.GET)
   public String lectureRegisterComplete(HttpSession session,HttpServletRequest req) {
      Employee eply = (Employee) session.getAttribute("employee");
      Calendar c = Calendar.getInstance();
      String month = "" + (c.get(Calendar.MONTH) + 1);
      if (month.length() == 1) {
         month = "0" + month;
      }
      ;
      String today = c.get(Calendar.YEAR) + "-" + month + "-" + (c.get(Calendar.DATE));
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("center_id", eply.getNow_center_id());
      map.put("today", today);
      List<LectureRegisterList> getlecturecomplete = lectureregisterService.getlecturecomplete(map);
      req.setAttribute("getlecturecomplete", getlecturecomplete);
      return "management.lectureRegisterComplete";
   }

   // 평가 등록, 평가 결과 리스트 - 페이지가 없는 경우
   @RequestMapping(value = { "evaluationRegisterList", "evaluationResultList" }, method = RequestMethod.GET)
   public String evaluationRegister(Model model, HttpServletRequest request) {
      // 평가등록 리스트: isResult=0, 평가결과 리스트:isResult=1 구분
      int isResult = 0;
      String myuri = request.getRequestURI();
      System.out.println("myurl:" + myuri);
      String uri = myuri.substring(myuri.lastIndexOf("/") + 1);
      System.out.println("uri:" + uri);
      if (uri.equals("evaluationResultList")) {
         isResult = 1;
      }

      evaluationRegisterService.getEvaluationRegistList(isResult, 10, 1, model);
      model.addAttribute("uri", uri);
      return "management.evaluationRegisterList";
   }

   // 평가 등록, 평가 결과 리스트 - 페이지가 있는 경우
   @RequestMapping(value = {
         "evaluationRegisterList/pageSize/{pageSize}/pageNum/{pageNum}",
         "evaluationResultList/pageSize/{pageSize}/pageNum/{pageNum}" }, method = RequestMethod.GET)
   public String notice(Model model, HttpServletRequest request, HttpSession session, @PathVariable int pageSize,
         @PathVariable int pageNum) {

      // 평가등록 리스트: isResult=0, 평가결과 리스트:isResult=1 구분
      int isResult = 0;
      String myuri = request.getRequestURI();
      System.out.println("myurl:" + myuri);
      String uri = myuri.substring(17, myuri.indexOf("/", 17));
      System.out.println("uri:" + uri);
      if (uri.equals("evaluationResultList")) {
         isResult = 1;
      }

      evaluationRegisterService.getEvaluationRegistList(isResult, pageSize, pageNum, model);
      model.addAttribute("uri", uri);
      return "management.evaluationRegisterList";
   }

   // 평가 등록 폼
   @RequestMapping(value = "evaluationRegisterform", method = RequestMethod.GET)
   public String evaluationRegisterform(Model model, int open_course_id) {
      model.addAttribute("evalForm", evaluationRegisterService.getEvaluationRegisterform(open_course_id));
      return "management.evaluationRegisterform";
   }

   // 평가 등록
   @RequestMapping(value = "evaluationRegisterform", method = RequestMethod.POST)
   public String evaluationRegistertoDb(Model model, EvaluationRegister evalRegister) {
      int result = evaluationRegisterService.addEvalution(evalRegister);
      model.addAttribute("result", result);
      if (result > 0) {
         System.out.println("평가 등록 성공");
      } else {
         System.out.println("평가 등록 실패");
      }
      model.addAttribute("open_course_id", evalRegister.getOpen_course_id());
      return "redirect:evaluationRegisterDetail";
   }

   // 평가 항목 조회
   @RequestMapping(value = "evaluationRegisterDetail", method = RequestMethod.GET)
   public String evaluationRegistertDetail(Model model, int open_course_id) {
      System.out.println("open_course_id:" + open_course_id);
      // 강좌 기본 정보
      model.addAttribute("evalForm", evaluationRegisterService.getEvaluationRegisterform(open_course_id));
      // 질문,보기 리스트
      Map<String, List<EvaluationRegister>> evaluation = evaluationRegisterService.getEvaluation(open_course_id);

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
      return "management.evaluationRegisterDetail";
   }

   // 강의평가 결과 페이지
   @RequestMapping(value = "evaluationResult", method = RequestMethod.GET)
   public String lectureEvaluation(Model model, int open_course_id) {
      // 주관식 결과
      System.out.println("Controller : evaluationResult");
      List<EvalQuestionAnswer> essayResult = evaluationRegisterService.getEvalEssayResult(open_course_id);

      ArrayList<String> question = new ArrayList<String>();

      ArrayList<ArrayList<String>> answerList = new ArrayList<ArrayList<String>>();
      ArrayList<String> answer = null;
      for (int i = 0; i < essayResult.size(); i++) {
         if (i == 0) {
            answer = new ArrayList<String>();
            question.add(essayResult.get(i).getQuestion());
            answer.add(essayResult.get(i).getAnswer());
         } else {
            if (essayResult.get(i - 1).getQuestion_id() == essayResult.get(i).getQuestion_id()) { // 같은 질문이면
               answer.add(essayResult.get(i).getAnswer());
            } else { // 다른 질문이면
               answerList.add(answer);
               answer = null;
               answer = new ArrayList<String>();
               question.add(essayResult.get(i).getQuestion());
               answer.add(essayResult.get(i).getAnswer());
            }
            /*if (i == essayResult.size() - 1) {
               answerList.add(answer);
            }*/
         }
         if (i == essayResult.size() - 1) {
            answerList.add(answer);
         }
      }
      /*//출력
      for(int i=0;i<question.size();i++){
         System.out.println("question 출력");
         System.out.println(question.get(i));
      }
      for(int i=0;i<answerList.size();i++){
         System.out.println("answerList 출력");
         ArrayList<String> a = answerList.get(i);
         System.out.println("answerList 안의 내용 출력");
         for(int j=0; j<a.size();j++){
            System.out.println(a.get(j));
         }
      }*/
      
      model.addAttribute("question", question);
      model.addAttribute("answerList", answerList);
      return "management.evaluationResult";
   }

   // 강의 평가 결과 - 차트
   @RequestMapping("getEvalChart")
   @ResponseBody
   public ArrayList<ArrayList<HashMap<String, Object>>> getLecEvalChart(
         Model model, int open_course_id) throws ClassNotFoundException,SQLException {
      System.out.println("ManageMentController - getLecEvalChart -open_course_id=" + open_course_id);
      // 객관식 결과
      List<EvalExampleResult> examResult = evaluationRegisterService.getEvalExamResult(open_course_id);
      System.out.println("examResult.size():" + examResult.size());

      ArrayList<ArrayList<HashMap<String, Object>>> sendEvalResultListofList = new ArrayList<ArrayList<HashMap<String, Object>>>();
      ArrayList<HashMap<String, Object>> evalResultList = null;

      for (int i = 0; i < examResult.size(); i++) {
         HashMap<String, Object> map = new HashMap<String, Object>();
         map.put("question", examResult.get(i).getQuestion());
         map.put("question_id", examResult.get(i).getQuestion_id());
         map.put("example_id", examResult.get(i).getExample_id());
         map.put("example_content", examResult.get(i).getExample_content());
         map.put("counts", examResult.get(i).getCounts());
         if (i == 0) {
            evalResultList = new ArrayList<HashMap<String, Object>>();
            evalResultList.add(map);
         } else {
            if (examResult.get(i - 1).getQuestion_id() == examResult.get(i).getQuestion_id()) {
               evalResultList.add(map);

            } else {
               sendEvalResultListofList.add(evalResultList);

               evalResultList = null;
               evalResultList = new ArrayList<HashMap<String, Object>>();
               evalResultList.add(map);
            }
            /*if (i == examResult.size() - 1) {
               sendEvalResultListofList.add(evalResultList);
            }*/
         }
         if (i == examResult.size() - 1) {
            sendEvalResultListofList.add(evalResultList);
         }
      }
      System.out.println("sendEvalResultofList.size:" + sendEvalResultListofList.size());

      return sendEvalResultListofList;
   }

   /*
    * //수강신청허가
    * 
    * @RequestMapping(value = "updatest", method = RequestMethod.GET) public
    * String updatest(HttpServletRequest req) { String open_course_id =
    * req.getParameter("open_course_id"); String account_id =
    * req.getParameter("account_id"); HashMap map = new HashMap();
    * map.put("open_course_id", open_course_id); map.put("account_id",
    * account_id); int updatestudent =
    * lectureregisterService.updatestudent(map);
    * req.setAttribute("updatestudent", updatestudent); String res =
    * "redirect:/management/lectureRegister"; return res; } //수강신청취소
    * 
    * @RequestMapping(value = "cancelst", method = RequestMethod.GET) public
    * String canslest(HttpServletRequest req) { String open_course_id =
    * req.getParameter("open_course_id"); String account_id =
    * req.getParameter("account_id"); HashMap map = new HashMap();
    * map.put("open_course_id", open_course_id); map.put("account_id",
    * account_id); int cancelstudent =
    * lectureregisterService.cancelstudent(map);
    * req.setAttribute("canslestudent", cancelstudent); String res =
    * "redirect:/management/lectureRegister"; return res; } //수강신청완료
    * 
    * @RequestMapping(value = "completest", method = RequestMethod.GET) public
    * String deletest(HttpServletRequest req) { String open_course_id =
    * req.getParameter("open_course_id"); String account_id =
    * req.getParameter("account_id"); HashMap map = new HashMap();
    * map.put("open_course_id", open_course_id); map.put("account_id",
    * account_id); int completestudent =
    * lectureregisterService.completestudent(map);
    * req.setAttribute("completestudent", completestudent); String res =
    * "redirect:/management/lectureRegister"; return res; }
    */
   
}