package kr.co.haco.Controller;

import java.io.IOException;
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
public class ManagementSubjectController {
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
   

////////////////////////////과목//////////////////////////////////////
   
   
   
   // 과정-과목등록-SubjectList(Basic) *완료*
   @RequestMapping(value = "subjectRegister", method = RequestMethod.GET)
   public String subjectRegister(Model model, HttpServletRequest request,
         Subject2 subjectRegister) {
        subjectService.getSubjectList(subjectRegister, model, request.getContextPath());
        return "management.subjectRegister";
   }
   
   // 과정-과목등록-SubjectList(PageChange) *완료*
   @RequestMapping(value = "/subjectRegister/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
   public String subjectRegister2(Model model, HttpServletRequest request,
         HttpSession session, @PathVariable String searchType,
         @PathVariable String searchKey, @PathVariable int pageSize,
         @PathVariable int pageNum) {
	   subjectService.getSubjectList(searchType,pageSize,pageNum,searchKey, model, request.getContextPath());
	   return "management.subjectRegister";
   }
   
   // 과정-과목등록-SubjectInsert-Form  *완료*
      @RequestMapping(value = "subjectInsert", method = RequestMethod.GET)
      public String insertForm(Model model, HttpSession session)  {
         Employee eply = (Employee) session.getAttribute("employee");
         model.addAttribute("Center", courseService.getCenter());
	       /*  model.addAttribute("getAccountId",subjectService.getSubjectList2(Integer.toString(eply.getAccount_id())));
	      */  
         
         System.out.println(model.addAttribute("getAccountId", courseService.getCenter2(eply.getNow_center_id())));
         return "management.subjectInsert";
      }   

  
      // 과정-과목등록-SubjectInsert-OK  *완료*
      @RequestMapping(value = "insertOk", method = RequestMethod.POST)
      public String insertOk(Subject subject, String start, String end)
            throws ParseException {  
    	  
    	  
         subjectService.insertSubject(subject,start,end);
         return "redirect:subjectRegister";
      }

      // 과정-과목수정-updateForm-Form *완료*
      @RequestMapping(value = "subjectUpdate", method = RequestMethod.GET)
      public String subjectUpdate(HttpServletRequest request, Model model) {
       /*  model.addAttribute("Center", courseService.getCenter());*/
         model.addAttribute("roleList", subjectService.getSubjectList2(request.getParameter("id")));
         return "management.subjectUpdate";
      }

     // 과정-과목수정-updateForm-Form-OK *완료*
      @RequestMapping(value = "UpdateOk", method = RequestMethod.POST)
      public String UpdateOk(Model model, Subject subject, String start,
            String end, HttpServletResponse res) throws IOException { 
         subjectService.updateSubject(subject,start,end);
         return "redirect:subjectRegister";
      }
      // 과정-과목삭제-OK(상태확인)  *완료*
      @RequestMapping(value = "DeleteOk", method = RequestMethod.POST)
      @ResponseBody
      public String DeleteOk(String json_data, Model model, HttpServletResponse rs)
            throws JsonGenerationException, JsonMappingException, IOException {
         String state;
         if (courseService.CKsubjectid(Integer.parseInt(json_data)) == 0) {
            state = "notnull";
         } else {
            state = "null";
         } ;
         return state;
      }
      
      // 과정-과목삭제-OK *완료*
      @RequestMapping(value = "DeleteOk", method = RequestMethod.GET)
      public String DeleteOk(Model model, HttpServletRequest request,
            HttpServletResponse res) throws IOException {
         subjectService.deleteSubject(request.getParameter("id"));
         return "redirect:subjectRegister";
      }
      
////////////////////////////과정//////////////////////////////////////
     
      // 과정-과정등록-CourseList(Basic) *완료*
      @RequestMapping(value = "courseRegister", method = RequestMethod.GET)
      public String courseRegister(Model model, HttpServletRequest request,
            getCourseList courseList) {
         courseService.getCourseList(courseList, model, request.getContextPath());
         return "management.courseRegister";
      }
 
      // 과정-과정등록-CourseList(PageChange)  *완료*
      @RequestMapping(value = "/courseRegister/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
      public String courseRegister2(Model model, HttpServletRequest request,
            HttpSession session, @PathVariable String searchType,
            @PathVariable String searchKey, @PathVariable int pageSize,
            @PathVariable int pageNum) {
         courseService.getCourseList(searchType,pageSize,pageNum,searchKey, model, request.getContextPath());
         return "management.courseRegister";
      }

   // 과정-과정등록-CourseInsert-Form  *완료*
      @RequestMapping(value = "courseInsert", method = RequestMethod.GET)
      public String courseInsert(Model model) {
         // 리스트.
         model.addAttribute("Center", centerService.getcenterList());
         model.addAttribute("Subject", subjectService.getsubjectList());
         return "management.courseInsert";
      }

      // 과정-과정등록-CourseInsert-OK  *완료*
      @RequestMapping(value = "courseInsert", method = RequestMethod.POST)
      @ResponseBody
      public HashMap<String, Object> courseInsert(String json_data, Model model,
            HttpServletResponse rs) throws JsonGenerationException,
            JsonMappingException, IOException {
         HashMap<String, Object> mapJson = new HashMap<String, Object>();
         mapJson.put("t", courseService.getClassroom(Integer.parseInt(json_data)));
         return mapJson;
      }
      @RequestMapping(value = "courseInsert2", method = RequestMethod.POST)
      @ResponseBody
      public HashMap<String, Object> courseInsert2(String json_data, Model model,
            HttpServletResponse rs) throws JsonGenerationException,
            JsonMappingException, IOException {
         HashMap<String, Object> mapJson = new HashMap<String, Object>();
         mapJson.put("name", courseService.getname((Integer.parseInt(json_data))));
         return mapJson;
      }
      // 과정-과정등록-CourseInsert-Form *완료*
      @RequestMapping(value = "courseInsertOk", method = RequestMethod.GET)
      public String courseInsertOk(String name, int center_id,
            int center_classroom_id, String course_name, int subject_id,
            String course_start_date, String course_end_date, Model model)
            throws ParseException {
         OpenCourse course = new OpenCourse(Integer.parseInt(name), subject_id,
               course_name, java.sql.Date.valueOf(course_start_date),
               java.sql.Date.valueOf(course_end_date), center_id,
               center_classroom_id);
         courseService.insertCourse(course);
         return "redirect:courseRegister";

      }
      
      // 과정-과정삭제-OK *완료* 
      @RequestMapping(value = "courseDeleteOk", method = RequestMethod.GET)
      public void courseDeleteOk(Model model, HttpServletRequest request,
            HttpServletResponse res) throws IOException {
         courseService.deleteCourse(request.getParameter("id"));
         res.sendRedirect("courseRegister");
      }
      
      // 과정-과정삭제-OK(상태확인)  *완료*
      @RequestMapping(value = "courseDeleteOk", method = RequestMethod.POST)
      @ResponseBody
      public String courseDeleteOk(String json_data, Model model,
            HttpServletResponse rs) throws JsonGenerationException,
            JsonMappingException, IOException {
        String state;
         if (courseService.CKopencouseid(Integer.parseInt(json_data)) == 0) {
            state = "notnull";
         } else {
            state = "null";
         };
         return state;
      }
  
      // 과정-과정수정-updateForm-Form *완료*
      @RequestMapping(value = "courseUpdate", method = RequestMethod.GET)
      public String courseUpdate(HttpServletRequest request, Model model) {
         model.addAttribute("Center", courseService.getCenter());
         model.addAttribute("Subject", subjectService.getsubjectList());
         model.addAttribute("roleList",courseService.getCourseList2(request.getParameter("id")));
         return "management.courseUpdate";
      }

   // 과정-과정수정-updateForm-Form-OK *완료*
      @RequestMapping(value = "courseUpdateOk", method = RequestMethod.GET)
      public void courseUpdateOk(Model model, String start, String center_id,
            String center_classroom_id, getCourseList getList, String end,
            HttpServletResponse res) throws IOException {
         OpenCourse course = new OpenCourse(getList.getOpen_course_id(),
             getList.getAccount_id(), getList.getSubject_id(),
             getList.getCourse_name(), java.sql.Date.valueOf(start),
             java.sql.Date.valueOf(end),
             Integer.parseInt(center_id),
             Integer.parseInt(center_classroom_id));
       
         
         courseService.updateCourse(course);
         res.sendRedirect("courseRegister");
      }

      // 과정-교육센터등록-CenterList(Basic)
      @RequestMapping(value = "centerRegister", method = RequestMethod.GET)
      public String centerRegister(Model model) {
          model.addAttribute("Center", centerService.getcenterList());
         return "management.centerRegister";
      }

      // 과정-교육센터등록-CenterList(Basic)
      @RequestMapping(value = "classroomList", method = RequestMethod.GET)
      public String classroomList(Model model, HttpServletRequest req) {
          model.addAttribute("Classroom", centerService.getclassroomList(req.getParameter("id")));
          model.addAttribute("centerid", req.getParameter("id"));
         return "management.classroomList";
      }

      /*@RequestMapping(value = "centerInsert", method = RequestMethod.GET)
      public String centerInsert(Model model, HttpServletRequest req) {
         return "management.centerInsert";
      }*/

      @RequestMapping(value = "centerinsertOk", method = RequestMethod.GET)
      public String centerinsertOk(Model model, String location)
            throws ParseException {
         centerService.insertCenter(location);
         return "redirect:centerRegister";

      }

      @RequestMapping(value = "centerdeleteOk", method = RequestMethod.GET)
      public String centerdeleteOk(Model model, String id) throws ParseException {
          centerService.deleteCenter(id);
         return "redirect:centerRegister";

      }
      
      @RequestMapping(value = "centerdeleteOk", method = RequestMethod.POST)
      @ResponseBody
      public String centerdeleteOk(String json_data, Model model, HttpServletResponse rs)
            throws JsonGenerationException, JsonMappingException, IOException {
         String state;
         if (courseService.CKcenterid(Integer.parseInt(json_data)) == 0 && courseService.CKcenterid2(Integer.parseInt(json_data))==0) {
            state = "notnull";
         } else {
            state = "null";
         }
         ;
          return state;
      }
  	
      @RequestMapping(value = "roominsertOk", method = RequestMethod.GET)
      public String roominsertOk(Model model, HttpServletRequest req,String classroom)
            throws ParseException {
    	  centerService.insertRoom(req.getParameter("id"), classroom);  
    	  model.addAttribute("id", req.getParameter("id"));
          
         return "redirect:classroomList";

      }
      @RequestMapping(value = "roomdeleteOk", method = RequestMethod.GET)
      public String roomdeleteOk(Model model,HttpServletRequest req, String center_classroom_id) throws ParseException {
          System.out.println("idvalue::"+req.getParameter("id"));
    	 System.out.println(centerService.deleteRoom(req.getParameter("id"))); 
          model.addAttribute("id", req.getParameter("id2"));   
          return "redirect:classroomList";
      }
      @RequestMapping(value = "roomdeleteOk", method = RequestMethod.POST)
      @ResponseBody
      public String roomdeleteOk(String json_data, Model model, HttpServletResponse rs)
            throws JsonGenerationException, JsonMappingException, IOException {
         String state;
         if (courseService.CKroomid(Integer.parseInt(json_data)) == 0) {
            state = "notnull";
         } else {
            state = "null";
         }
         ;
          return state;
      }
  	// ///자동완성//////////
  	   @RequestMapping(value = "test", method = RequestMethod.POST)
  	   @ResponseBody
  	   public HashMap<String, Object> key(String json_data, Model model,
  	         HttpServletResponse rs) throws JsonGenerationException,
  	         JsonMappingException, IOException {
  	      subjectService.getName(json_data);
  	      HashMap<String, Object> mapJson = new HashMap<String, Object>();
  	      mapJson.put("auto", subjectService.getName(json_data));
  	     return mapJson;
  	   }
  	   

   /////자동완성->프로필검색//////////
  	@RequestMapping(value = "test2", method = RequestMethod.POST)
  	@ResponseBody
  	public HashMap<String, Object> search(String json_data, Model model,
  			HttpServletResponse rs) throws JsonGenerationException,
  			JsonMappingException, IOException {
  		
  		subjectService.getName(json_data);
  		HashMap<String, Object> mapJson = new HashMap<String, Object>();
  		mapJson.put("t",subjectService.getName(json_data));
  		return mapJson;
  	}
}