package kr.co.haco.Controller;

import java.io.IOException;
import java.sql.Time;
import java.text.ParseException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.AttendanceService;
import kr.co.haco.Service.CenterService;
import kr.co.haco.Service.CourseService;
import kr.co.haco.Service.EmployeeService;
import kr.co.haco.Service.EvaluationRegisterService;
import kr.co.haco.Service.HomepageService;
import kr.co.haco.Service.LectureRegisterService;
import kr.co.haco.Service.MemberService;
import kr.co.haco.Service.SubjectService;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.Subject2;
import kr.co.haco.VO.getCourseList;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "management/")
public class ManagementControllerHS {
   @Autowired
   AccountService accountService;
   @Autowired
   AttendanceService attendanceService;
   @Autowired
   EmployeeService employeeService;
   @Autowired
   MemberService memberService;
   @Autowired
   LectureRegisterService lectureregisterService;
   @Autowired
   EvaluationRegisterService evaluationRegisterService;
   @Autowired
   SubjectService subjectService;
   @Autowired
   HomepageService homepageService;
   @Autowired
   CourseService courseService;
   @Autowired
   CenterService centerService;
   

   // 과정-과목등록-SubjectList(Basic)
   @RequestMapping(value = "subjectRegister", method = RequestMethod.GET)
   public String subjectRegister(Model model, HttpServletRequest request,
         Subject2 subjectRegister) {
      System.out.println("************************************************");
      System.out.println("SubjectRegister//SubjectList//Basic");
      subjectService.getSubjectList(subjectRegister, model, request.getContextPath());
      System.out.println("PageMove : management.SubjectRegister");
      return "management.subjectRegister";
   }
   
   // 과정-과목등록-SubjectList(PageChange)
   @RequestMapping(value = "/subjectRegister/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
   public String subjectRegister2(Model model, HttpServletRequest request,
         HttpSession session, @PathVariable String searchType,
         @PathVariable String searchKey, @PathVariable int pageSize,
         @PathVariable int pageNum) {
      System.out.println("************************************************");
      System.out.println("SubjectRegister//SubjectList//PageChange");
      Subject2 subjectRegister = new Subject2();
      subjectRegister.setSearchType(searchType);
      subjectRegister.setPageSize(pageSize);
      subjectRegister.setPageNum(pageNum);
      subjectRegister.setSearchKey(searchKey);
      if (searchKey.equals("[noKeyword]")) {
         subjectRegister.setSearchKey("");
      }
      subjectService.getSubjectList(subjectRegister, model, request.getContextPath());
      System.out.println("PageMove : management.SubjectRegister(PageChange)");
      return "management.subjectRegister";
   }
   
   // 과정-과목등록-SubjectInsert-Form
      @RequestMapping(value = "subjectInsert", method = RequestMethod.GET)
      public String insertForm(Model model, HttpSession session) {
         Employee eply = (Employee) session.getAttribute("employee");
         System.out.println("************************************************");
         System.out.println("SubjectInsert//InsertForm");
         System.out.println("Move : management.SubjectInsert");
         model.addAttribute("Center", courseService.getCenter());
         model.addAttribute("getAccountId",subjectService.getSubjectList2(Integer.toString(eply.getAccount_id())));
         return "management.subjectInsert";
      }   

      // 시간처리
      public Time getTimestamp(String str) {
         return Time.valueOf(str);
      }

      // 과정-과목등록-SubjectInsert-OK
      @RequestMapping(value = "insertOk", method = RequestMethod.GET)
      public String insertOk(Subject subject, String start, String end)
            throws ParseException {
         System.out.println("************************************************");
         System.out.println("subjectInsert//InsertForm//insertOk");
         System.out.println("getSubject_id::" + subject.getSubject_id());
         System.out.println("getSubject_name::" + subject.getSubject_name());
         Time start1 = getTimestamp(start + ":00");
         Time end1 = getTimestamp(end + ":00");
         System.out.println(start1 + "//" + end1);
         long a = (end1.getTime() - start1.getTime()) / 1000;
         int time3 = (int) (subject.getLecture_totalday() * a);
         Subject subject2 = new Subject(subject.getSubject_id(),
               subject.getSubject_name(), subject.getCapacity(),
               subject.getSubject_explanation(),
               subject.getInstructional_objectives(),
               subject.getSubject_point(), subject.getLecture_target(),
               subject.getLecture_totalday(), subject.getTuition_fee(),
               subject.getLecture_content(), subject.getCenter_id(), start1,
               end1, time3 / 3600);
         subjectService.insertSubject(subject2);
         System.out.println("Move : management.subjectRegister");
         // res.sendRedirect("subjectRegister"); 구방식이래..재길..
         return "redirect:subjectRegister";

      }

      // 과정-과목수정-updateForm-Form
      @RequestMapping(value = "subjectUpdate", method = RequestMethod.GET)
      public String subjectUpdate(HttpServletRequest request, Model model) {
         System.out.println("************************************************");
         System.out.println("subjectUpdate//UpdateForm");
         System.out.println(request.getParameter("id"));
         model.addAttribute("Center", courseService.getCenter());
         model.addAttribute("roleList",
               subjectService.getSubjectList2(request.getParameter("id")));
         System.out.println("move:management.subjectUpdate");
         return "management.subjectUpdate";
      }

      // 과정-과목수정-updateForm-Form-OK
      @RequestMapping(value = "UpdateOk", method = RequestMethod.GET)
      public String UpdateOk(Model model, Subject subject, String start,
            String end, HttpServletResponse res) throws IOException {
         System.out.println("************************************************");
         System.out.println("subjectUpdate//UpdateForm//UpdateOk");
         Time start1 = null;
         Time end1 = null;
         if (start.length() < 7) {
            start1 = getTimestamp(start + ":00");
         } else {
            start1 = getTimestamp(start);
         }
         if (end.length() < 7) {
            end1 = getTimestamp(end + ":00");
         } else {
            end1 = getTimestamp(end);
         }
         long a = (end1.getTime() - start1.getTime()) / 1000;
         int b = (int) (subject.getLecture_totalday() * a);
         Subject subject2 = new Subject(subject.getSubject_id(),
               subject.getSubject_name(), subject.getCapacity(),
               subject.getSubject_explanation(),
               subject.getInstructional_objectives(),
               subject.getSubject_point(), subject.getLecture_target(),
               subject.getLecture_totalday(), subject.getTuition_fee(),
               subject.getLecture_content(), start1, end1, b / 3600);

         subjectService.updateSubject(subject2);
         System.out.println("move:management.subjectRegister");
         return "redirect:subjectRegister";
      }

      // 과정-과목삭제-OK-예외처리추가.
      @RequestMapping(value = "DeleteOk", method = RequestMethod.POST)
      @ResponseBody
      public String DeleteOk(String json_data, Model model, HttpServletResponse rs)
            throws JsonGenerationException, JsonMappingException, IOException {
         System.out.println("************************************************");
         String state;
         if (courseService.CKsubjectid(Integer.parseInt(json_data)) == 0) {
            state = "notnull";
         } else {
            state = "null";
         }
         ;
         System.out.println("state" + json_data + "//" + state);
         return state;
      }

      @RequestMapping(value = "DeleteOk", method = RequestMethod.GET)
      public String DeleteOk(Model model, HttpServletRequest request,
            HttpServletResponse res) throws IOException {
         System.out.println("************************************************");
         System.out.println("id value : " + request.getParameter("id"));
         System.out.println(subjectService.deleteSubject(request
               .getParameter("id")));
         System.out.println("subjectDelete//DeleteOk");
         return "redirect:subjectRegister";
      }

      // ///////////////////////////과정//////////////////////////////////////////////////////////

      // 과정-과정등록-CourseList(Basic)
      @RequestMapping(value = "courseRegister", method = RequestMethod.GET)
      public String courseRegister(Model model, HttpServletRequest request,
            getCourseList courseList) {

         System.out.println("************************************************");
         System.out.println("courseRegister//Basic");
         System.out.println("move:management.courseRegister//att:roleList");
         courseService
               .getCourseList(courseList, model, request.getContextPath());
         return "management.courseRegister";
      }

      // 과정-과목등록-CourseList(PageChange)
      @RequestMapping(value = "/courseRegister/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
      public String courseRegister2(Model model, HttpServletRequest request,
            HttpSession session, @PathVariable String searchType,
            @PathVariable String searchKey, @PathVariable int pageSize,
            @PathVariable int pageNum) {
         System.out.println("************************************************");
         System.out.println("subjectRegister//MainList//PageChange");
         getCourseList courseList = new getCourseList();
         courseList.setSearchType(searchType);
         courseList.setPageSize(pageSize);
         courseList.setPageNum(pageNum);
         courseList.setSearchKey(searchKey);
         if (searchKey.equals("[noKeyword]")) {
            courseList.setSearchKey("");
         }
         courseService
               .getCourseList(courseList, model, request.getContextPath());
         System.out.println("Move : management.subjectRegister(PageChange)");
         return "management.courseRegister";
      }

      @RequestMapping(value = "courseInsert", method = RequestMethod.GET)
      public String courseInsert(Model model) {
         // 리스트.
         System.out.println("************************************************");
         System.out.println("courseInsert//InsertForm");
         System.out.println("move:management.courseInsert");
         model.addAttribute("Center", centerService.getcenterList());
         System.out.println("test");
         model.addAttribute("Subject", subjectService.getsubjectList());
         return "management.courseInsert";
      }

      @RequestMapping(value = "courseInsert", method = RequestMethod.POST)
      @ResponseBody
      public HashMap<String, Object> courseInsert(String json_data, Model model,
            HttpServletResponse rs) throws JsonGenerationException,
            JsonMappingException, IOException {
         System.out.println("************************************************");
         System.out
               .println("tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
         System.out.println(json_data);

         HashMap<String, Object> mapJson = new HashMap<String, Object>();
         mapJson.put("t",
               courseService.getClassroom(Integer.parseInt(json_data)));
         System.out.println(mapJson);

         /*
          * ObjectMapper om = new ObjectMapper(); // 어노테이션 방식을 수동으로 적용시키는방법
          * om.writeValue(rs.getWriter(), mapJson);
          */
         return mapJson;
      }

      @RequestMapping(value = "courseInsertOk", method = RequestMethod.GET)
      public String courseInsertOk(String name2, int center_id,
            int center_classroom_id, String course_name, int subject_id,
            String course_start_date, String course_end_date, Model model)
            throws ParseException {
         // 리스트.

         System.out.println("************************************************");
         System.out.println("courseInsertOk//InsertForm");
         System.out.println(name2);
         System.out.println(subject_id);// 과목ID
         System.out.println(course_name); // 과정명
         System.out.println(java.sql.Date.valueOf(course_start_date));
         System.out.println(java.sql.Date.valueOf(course_end_date));
         System.out.println(center_id); // 센터ID
         System.out.println(center_classroom_id);// 강의실

         OpenCourse course = new OpenCourse(Integer.parseInt(name2), subject_id,
               course_name, java.sql.Date.valueOf(course_start_date),
               java.sql.Date.valueOf(course_end_date), center_id,
               center_classroom_id);
         System.out.println(courseService.insertCourse(course));

         return "redirect:courseRegister";

      }

      @RequestMapping(value = "courseDeleteOk", method = RequestMethod.GET)
      public void courseDeleteOk(Model model, HttpServletRequest request,
            HttpServletResponse res) throws IOException {
         System.out.println("************************************************");
         System.out.println("courseDeleteOk//");
         courseService.deleteCourse(request.getParameter("id"));
         res.sendRedirect("courseRegister");
      }
      
      
      @RequestMapping(value = "courseDeleteOk", method = RequestMethod.POST)
      @ResponseBody
      public String courseDeleteOk(String json_data, Model model,
            HttpServletResponse rs) throws JsonGenerationException,
            JsonMappingException, IOException {
         System.out.println("************************************************");
         String state;
         if (courseService.CKsubjectid(Integer.parseInt(json_data)) == 0) {
            state = "notnull";
         } else {
            state = "null";
         }
         ;
         System.out.println("state" + json_data + "//" + state);
         return state;
      }

      // 과정수정 updateForm..
      @RequestMapping(value = "courseUpdate", method = RequestMethod.GET)
      public String courseUpdate(HttpServletRequest request, Model model) {

         System.out.println("************************************************");
         System.out.println("courseUpdate//");
         System.out.println("move:management.courseUpdate//Update");
         System.out.println(request.getParameter("id"));
         model.addAttribute("Center", courseService.getCenter());
         model.addAttribute("Subject", subjectService.getsubjectList());
         model.addAttribute("roleList",
               courseService.getCourseList2(request.getParameter("id")));

         return "management.courseUpdate";
      }

      // 과목수정 UpdateOk..
      @RequestMapping(value = "courseUpdateOk", method = RequestMethod.GET)
      public void courseUpdateOk(Model model, String start, String center_id,
            String center_classroom_id, getCourseList getList, String end,
            HttpServletResponse res) throws IOException {
         System.out
               .println("**************eeeeeeeeeeeeeee**********************************");
         System.out.println("courseUpdateOk//");

         /*
          * getCourseList getList2 = new getCourseList
          * (getList.getOpen_course_id(), getList.getCourse_name(),
          * java.sql.Date.valueOf(start) , java.sql.Date.valueOf(end),
          * getList.getClassroom(), getList.getName_kor(), getList.getLocation(),
          * getList.getSubject_name());
          */

         System.out.println("accountID:" + getList.getAccount_id());
         OpenCourse course = new OpenCourse(getList.getOpen_course_id(),
               getList.getAccount_id(), getList.getSubject_id(),
               getList.getCourse_name(), Integer.parseInt(center_id),
               Integer.parseInt(center_classroom_id));

         System.out.println(course.toString());

         System.out.println("되나요?:" + courseService.updateCourse(course));
         res.sendRedirect("courseRegister");
      }

      // 과정-교육센터등록-CenterList(Basic)
      @RequestMapping(value = "centerRegister", method = RequestMethod.GET)
      public String centerRegister(Model model) {
         System.out.println("************************************************");
         System.out.println("centerRegister//Basic");
         System.out.println("move:management.centerRegister//att:roleList");

         model.addAttribute("Center", centerService.getcenterList());
         return "management.centerRegister";
      }

      // 과정-교육센터등록-CenterList(Basic)
      @RequestMapping(value = "classroomList", method = RequestMethod.GET)
      public String classroomList(Model model, HttpServletRequest req) {
         System.out.println("************************************************");
         System.out.println("classroomList//Basic");
         System.out.println("center_id::" + req.getParameter("id"));
         model.addAttribute("Classroom",
               centerService.getclassroomList(req.getParameter("id")));
         return "management.classroomList";
      }

      @RequestMapping(value = "centerInsert", method = RequestMethod.GET)
      public String centerInsert(Model model, HttpServletRequest req) {
         System.out.println("************************************************");
         System.out.println("centerInsert//Basic");
         return "management.centerInsert";
      }

      @RequestMapping(value = "centerinsertOk   ", method = RequestMethod.GET)
      public String centerinsertOk(Model model, String location)
            throws ParseException {
         // 리스트.

         System.out.println("************************************************");
         System.out.println("centerinsertOk//InsertForm");

         System.out.println(centerService.insertCenter(location));

         return "redirect:centerRegister";

      }

      @RequestMapping(value = "centerdeleteOk", method = RequestMethod.GET)
      public String centerdeleteOk(Model model, String id) throws ParseException {
         // 리스트.

         System.out.println("************************************************");
         System.out.println("centerdeleteOk//InsertForm");
         centerService.deleteCenter(id);
         return "redirect:centerRegister";

      }
      
      @RequestMapping(value = "centerdeleteOk", method = RequestMethod.POST)
      @ResponseBody
      public String centerdeleteOk(String json_data, Model model, HttpServletResponse rs)
            throws JsonGenerationException, JsonMappingException, IOException {
         System.out.println("************************************************");
         String state;
         if (courseService.CKcenterid(Integer.parseInt(json_data)) == 0) {
            state = "notnull";
         } else {
            state = "null";
         }
         ;
         System.out.println("state" + json_data + "//" + state);
         return state;
      }
  	
  	
  	
  	
  	// ///자동완성//////////
  	   @RequestMapping(value = "test", method = RequestMethod.POST)
  	   @ResponseBody
  	   public HashMap<String, Object> key(String json_data, Model model,
  	         HttpServletResponse rs) throws JsonGenerationException,
  	         JsonMappingException, IOException {
  	      System.out.println("************************************************");
  	      System.out.println("json_data_value: " + json_data);

  	      subjectService.getName(json_data);

  	      HashMap<String, Object> mapJson = new HashMap<String, Object>();
  	      mapJson.put("auto", subjectService.getName(json_data));
  	      System.out.println("mapJson_value: " + mapJson);
  	      return mapJson;
  	   }
  	   
  	   
  	   
  	   
  	   
  	
  /////자동완성->프로필검색//////////
  	@RequestMapping(value = "test2", method = RequestMethod.POST)
  	@ResponseBody
  	public HashMap<String, Object> search(String json_data, Model model,
  			HttpServletResponse rs) throws JsonGenerationException,
  			JsonMappingException, IOException {
  		
  		System.out.println("************************************************");
  		System.out.println("json_data_value: "+json_data);
  		subjectService.getName(json_data);
  		HashMap<String, Object> mapJson = new HashMap<String, Object>();
  		mapJson.put("t",subjectService.getName(json_data));
  		System.out.println("mapJson_value: "+mapJson);
  		return mapJson;
  	}
}