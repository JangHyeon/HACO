package kr.co.haco.Controller;

import java.io.IOException;
import java.security.Principal;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.CourseService;
import kr.co.haco.Service.EmployeeService;
import kr.co.haco.Service.EvaluationRegisterService;
import kr.co.haco.Service.MemberService;
import kr.co.haco.Service.SubjectService;
import kr.co.haco.Util.ImageJ;
import kr.co.haco.Util.MultipartUploader;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EmployeeList;
import kr.co.haco.VO.EvalExampleResult;
import kr.co.haco.VO.EvaluationRegister;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.MemberOfAcademy;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Controller
@RequestMapping(value = "management/")
public class ManagementController {

	@Autowired
	AccountService accountService;
	@Autowired
	EmployeeService employeeService; 
	@Autowired
	MemberService memberService;
	
	@Autowired
	EvaluationRegisterService evaluationRegisterService; 	


	@Autowired
	SubjectService subjectService;


	@Autowired
	CourseService courseService;
	// ////직원 관리//////////////////
	// 직원추가
	@RequestMapping(value = "employeeRegister", method = RequestMethod.GET)
	public String employeeManagement(Model model){
		List<EducationCenter> eduList = employeeService.getEduCenterList();
		model.addAttribute("eduCenterList", eduList);
		return "management.employeeRegister";
	}
	@RequestMapping(value = "employeeRegister", method = RequestMethod.POST)
	public String employeeManagementAdd(Employee employee){		
		
		System.out.println("employ.photo:"+employee.getPhoto());
		//System.out.println("employee.getJoin_center_id():"+employee.getJoin_center_id());
		employeeService.addEmployee(employee);
		return "management.index";
	}
	
	


	//직원정보 사진 업로드
	@RequestMapping(value = "photoUpload", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> photoUpload(MultipartHttpServletRequest req){
		
	    MultipartFile multipartFile = req.getFile("file");
	    String usrUploadDir = "/resources/upload/employeePhoto"; //저장 폴더명

	    MultipartUploader mu = new MultipartUploader(req, usrUploadDir, multipartFile,false);
	    
	    String result = ImageJ.photoCropAndResize(mu.getFilePath(),177, 236);
	    System.out.println("result-"+result);
	    
	    HashMap<String, String> map = new HashMap<String, String>();
	    map.put("originalFileName", multipartFile.getOriginalFilename());
	    map.put("renameFileName", mu.getFileName());
	    map.put("fileUrl", mu.getFileUrl());
	     
	    return map;
	}
	
	
	//대쉬보드
	@RequestMapping(value = {"index",""}, method = RequestMethod.GET)
	public String index() {
		System.out.println("index");
		return "management.index";
	}
	
	
	
	/////////////////////////////과정//////////////////////////////////////////////////////////

	// 과정-과목등록-SubjectList(Basic)
	@RequestMapping(value = "subjectRegister", method = RequestMethod.GET)
	public String subjectRegister(Model model,HttpServletRequest request, Subject2 subject2 ) {
		System.out.println("************************************************");
		System.out.println("subjectRegister//MainList//Basic");
		subjectService.getSubjectList(subject2, model, request.getContextPath());
		System.out.println("Move : management.subjectRegister");
		return "management.subjectRegister";
	}
	
	// 과정-과목등록-SubjectList(PageChange)
	@RequestMapping(value = "/subjectRegister/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
	public String subjectRegister2(Model model, HttpServletRequest request, HttpSession session,
						@PathVariable String searchType,@PathVariable String searchKey,@PathVariable int pageSize,@PathVariable int pageNum) {
		System.out.println("************************************************");
		System.out.println("subjectRegister//MainList//PageChange");
		Subject2 subject2 = new Subject2();
		subject2.setSearchType(searchType);
		subject2.setPageSize(pageSize);
		subject2.setPageNum(pageNum);
		subject2.setSearchKey(searchKey);
		if(searchKey.equals("[noKeyword]")){
			subject2.setSearchKey("");
		}
		subjectService.getSubjectList(subject2, model, request.getContextPath());
		System.out.println("Move : management.subjectRegister(PageChange)");
		return "management.subjectRegister";
	}
	
	
	// 과정-과목등록-SubjectInsert-Form
	@RequestMapping(value = "subjectInsert", method = RequestMethod.GET)
	public String insertForm(Model model) {
		System.out.println("************************************************");
		System.out.println("subjectInsert//InsertForm");
		System.out.println("Move : management.subjectInsert");
		model.addAttribute("Center", courseService.getCenter());
		return "management.subjectInsert";
	}

	//시간처리
	public Time getTimestamp(String str) {
		return Time.valueOf(str);
	}

	// 과정-과목등록-SubjectInsert-OK
	@RequestMapping(value = "insertOk", method = RequestMethod.GET)
	public String insertOk(Subject subject, String start, String end)
			throws ParseException {
		System.out.println("************************************************");
		System.out.println("subjectInsert//InsertForm//insertOk");
		Time start1 = getTimestamp(start + ":00");
		Time end1 = getTimestamp(end + ":00");
		long a = (end1.getTime() - start1.getTime()) / 1000;
		int time1 = (int) (a / 3600);
		int time2 = (int) (a % 3600 / 60);
		int time3 = (int) (subject.getLecture_totalday() * a);
		Subject subject2 = new Subject(subject.getSubject_id() ,subject.getSubject_name(),
				subject.getCapacity(), subject.getSubject_explanation(),
				subject.getInstructional_objectives(),
				subject.getSubject_point(), subject.getLecture_target(),
				subject.getLecture_totalday(), subject.getTuition_fee(),
				subject.getLecture_content(), subject.getCenter_id(), start1,
				end1, time3 / 3600);
		subjectService.insertSubject(subject2);
		System.out.println("Move : management.subjectRegister");
		//res.sendRedirect("subjectRegister"); 구방식이래..재길..
		return "redirect:subjectRegister";

	}

	// 과정-과목수정-updateForm-Form
	@RequestMapping(value = "subjectUpdate", method = RequestMethod.GET)
	public String subjectUpdate(HttpServletRequest request, Model model) {
		System.out.println("************************************************");
		System.out.println("subjectUpdate//UpdateForm");
		System.out.println(request.getParameter("id"));
		model.addAttribute("Center", courseService.getCenter());
		model.addAttribute("roleList",subjectService.getSubjectList2(request.getParameter("id")));
		System.out.println("move:management.subjectUpdate");
		return "management.subjectUpdate";
	}

	// 과정-과목수정-updateForm-Form-OK
	@RequestMapping(value = "UpdateOk", method = RequestMethod.GET)
	public String UpdateOk(Model model, Subject subject, String start,
			String end, HttpServletResponse res) throws IOException {
		System.out.println("************************************************");
		System.out.println("subjectUpdate//UpdateForm//UpdateOk");
		Time start1 = getTimestamp(start + ":00");
		Time end1 = getTimestamp(end + ":00");
		long a = (end1.getTime() - start1.getTime()) / 1000;
		int time1 = (int) (a / 3600);
		int time2 = (int) (a % 3600 / 60);
		int b = (int) (subject.getLecture_totalday() * a);
		Subject subject2 = new Subject(subject.getSubject_id(), subject.getSubject_name(),
				subject.getCapacity(), subject.getSubject_explanation(),
				subject.getInstructional_objectives(),
				subject.getSubject_point(), subject.getLecture_target(),
				subject.getLecture_totalday(), subject.getTuition_fee(),
				subject.getLecture_content(), subject.getCenter_id(), start1,
				end1, b / 3600);
		System.out.println("move:management.subjectRegister");
		return "redirect:subjectRegister";
	}

	// 과정-과목삭제-OK
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
	/////////////////////////////과정//////////////////////////////////////////////////////////


		
	
	
	
	// 과정-과정등록-CourseList(Basic)
	@RequestMapping(value = "courseRegister", method = RequestMethod.GET)
	public String courseRegister(Model model ,HttpServletRequest request, getCourseList courseList ) {
	
		
		System.out.println("************************************************");
		System.out.println("courseRegister//Basic");
		System.out.println("move:management.courseRegister//att:roleList");
		courseService.getCourseList(courseList, model,  request.getContextPath());
		return "management.courseRegister";
	}

	// 과정-과목등록-SubjectList(PageChange)
		@RequestMapping(value = "/courseRegister/pageSize/{pageSize}/pageNum/{pageNum}/searchType/{searchType}/searchKey/{searchKey}")
		public String courseRegister2(Model model, HttpServletRequest request, HttpSession session,
							@PathVariable String searchType,@PathVariable String searchKey,@PathVariable int pageSize,@PathVariable int pageNum) {
			System.out.println("************************************************");
			System.out.println("subjectRegister//MainList//PageChange");
			getCourseList courseList = new getCourseList();
			courseList.setSearchType(searchType);
			courseList.setPageSize(pageSize);
			courseList.setPageNum(pageNum);
			courseList.setSearchKey(searchKey);		
			if(searchKey.equals("[noKeyword]")){
				courseList.setSearchKey("");
			}
			courseService.getCourseList(courseList, model, request.getContextPath());
			System.out.println("Move : management.subjectRegister(PageChange)");
			return "management.courseRegister";   
		}
		
	

		
		
		
		
		
	
	
	
	
	@RequestMapping(value = "courseInsert", method = RequestMethod.GET)
	public String courseInsert(Model model) {
		// 리스트.
		System.out.println("************************************************");
		System.out.println("courseInsert//InsertForm");
		System.out.println("move:management.courseInsert");
		model.addAttribute("Center", courseService.getCenter());
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
		mapJson.put("t",courseService.getClassroom(Integer.parseInt(json_data)));
		System.out.println(mapJson);

		/*
		 * ObjectMapper om = new ObjectMapper(); // 어노테이션 방식을 수동으로 적용시키는방법
		 * om.writeValue(rs.getWriter(), mapJson);
		 */
		return mapJson;
	}

	@RequestMapping(value = "courseInsertOk", method = RequestMethod.GET)
	public String courseInsertOk(String name, int center_id,
			int center_classroom_id, String course_name,int subject_id, String course_start_date,
			String course_end_date, Model model) throws ParseException {
		// 리스트.
		System.out.println("************************************************");
		System.out.println("courseInsertOk//InsertForm");
		System.out.println(name);
		Employee e = accountService.getEmployeeID(name);

		// 개설과정ID 자동 increment
		System.out.println(e.getAccount_id()); // 강사ID
		System.out.println(subject_id);// 과목ID
		System.out.println(course_name); //과정명	
		System.out.println(java.sql.Date.valueOf(course_start_date));
		System.out.println(java.sql.Date.valueOf(course_end_date));
		System.out.println(center_id); // 센터ID
		System.out.println(center_classroom_id);// 강의실

		OpenCourse course = new OpenCourse(e.getAccount_id(), subject_id,
				course_name, java.sql.Date.valueOf(course_start_date),
				java.sql.Date.valueOf(course_end_date), center_id,
				center_classroom_id);
		System.out.println(courseService.insertCourse(course));
		
		return "management.courseRegister";
	}


	@RequestMapping(value = "courseDeleteOk", method = RequestMethod.GET)
	public void courseDeleteOk(Model model, HttpServletRequest request,
			HttpServletResponse res) throws IOException {
		System.out.println("************************************************");
		System.out.println("courseDeleteOk//");
		courseService.deleteCourse(request.getParameter("id"));
		res.sendRedirect("courseRegister");
	}
	
	// 과정수정 updateForm..
		@RequestMapping(value = "courseUpdate", method = RequestMethod.GET)
		public String courseUpdate(HttpServletRequest request, Model model) {

			System.out.println("************************************************");
			System.out.println("courseUpdate//");
			System.out.println("move:management.subjectUpdate//Update");
			System.out.println(request.getParameter("id"));
			model.addAttribute("Center", courseService.getCenter());
			model.addAttribute("Subject", subjectService.getsubjectList());
			model.addAttribute("roleList", courseService.getCourseList2(request.getParameter("id")));
			
		  return "management.courseUpdate"; 
		}
		// 과목수정 UpdateOk..
		@RequestMapping(value = "courseUpdateOk", method = RequestMethod.GET)
		public void courseUpdateOk(Model model, String start, String center_id,String center_classroom_id,
				getCourseList getList	,String end, HttpServletResponse res) throws IOException {
			System.out.println("************************************************");
			System.out.println("courseUpdateOk//");

			/*getCourseList getList2 = new getCourseList
					(getList.getOpen_course_id(), getList.getCourse_name(), java.sql.Date.valueOf(start) , java.sql.Date.valueOf(end), 
							getList.getClassroom(), getList.getName_kor(), getList.getLocation(), getList.getSubject_name());
			
			*/
			
			System.out.println("accountID:"+getList.getAccount_id());
			OpenCourse course = new OpenCourse(getList.getOpen_course_id(),getList.getAccount_id(), getList.getSubject_id(),
					getList.getCourse_name(), java.sql.Date.valueOf(start),
					java.sql.Date.valueOf(end), Integer.parseInt(center_id),
					Integer.parseInt(center_classroom_id));
			
			System.out.println(course.toString());
			
			System.out.println("되나요?:"+courseService.updateCourse(course));
			res.sendRedirect("subjectRegister");
		}
	
	//교육센터
	@RequestMapping(value = "educationCenter", method = RequestMethod.GET)
	public String educationCenter() {		
		return "management.educationCenter";
	}

	
	//수강신청
	@RequestMapping(value = "lectureRegister", method = RequestMethod.GET)
	public String lectureRegister() {		
		return "management.lectureRegister";
	}
	
	//평가 등록, 평가 결과 리스트
	@RequestMapping(value = {"evaluationRegisterList", "evaluationResultList"}, method=RequestMethod.GET)
	public String evaluationRegister(Model model,HttpServletRequest request){
		//평가등록 리스트: isResult=0, 평가결과 리스트:isResult=1 구분 
		int isResult=0;
		String myuri = request.getRequestURI();
			System.out.println("myurl:"+myuri);				
		String uri = myuri.substring(myuri.lastIndexOf("/")+1);
			System.out.println("uri:"+uri);
		if(uri.equals("evaluationResultList")){
			isResult =1;
		}
		model.addAttribute("uri", uri);
		model.addAttribute("evalRegList",evaluationRegisterService.getEvaluationRegistList(isResult));
		return "management.evaluationRegisterList";		
	}	
	
	//평가 등록 폼
	@RequestMapping(value="evaluationRegisterform" , method=RequestMethod.GET)
	public String evaluationRegisterform(Model model ,int open_course_id){
		model.addAttribute("evalForm",evaluationRegisterService.getEvaluationRegisterform(open_course_id));		
		return "management.evaluationRegisterform";	
	}
	//평가 등록
	@RequestMapping(value="evaluationRegisterform" , method=RequestMethod.POST)
	public String evaluationRegistertoDb(Model model ,EvaluationRegister evalRegister){
		int result = evaluationRegisterService.addEvalution(evalRegister);
		model.addAttribute("result", result);
		if(result>0){
			System.out.println("평가 등록 성공");
		}else{
			System.out.println("평가 등록 실패");
		}
		return "management.evaluationRegisterUpdate";	
	}
	
	//강의평가 결과 페이지
	@RequestMapping(value = "evaluationResult", method = RequestMethod.GET)
	public String lectureEvaluation(Model model, int open_course_id) {
		return "management.evaluationResult";
	}
	//강의 평가 결과 - 차트
	@RequestMapping("getEvalChart")
	@ResponseBody
	public ArrayList<ArrayList<HashMap<String, Object>>> getLecEvalChart(Model model,int open_course_id) throws ClassNotFoundException, SQLException{
		System.out.println("ManageMentController - getLecEvalChart -open_course_id="+open_course_id);
		List<EvalExampleResult> examResult = evaluationRegisterService.getEvalResult(open_course_id);		
		ArrayList<ArrayList<HashMap<String, Object>>> sendEvalResultofList = new ArrayList<ArrayList<HashMap<String,Object>>>();
		ArrayList<HashMap<String, Object>> sendEvalResult = null;
		
		for(int i=0; i<examResult.size();i++){
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("question", examResult.get(i).getQuestion());
			map.put("question_id", examResult.get(i).getQuestion_id());
			map.put("example_id", examResult.get(i).getExample_id());
			map.put("example_content", examResult.get(i).getExample_content());
			map.put("counts", examResult.get(i).getCounts());
			if(i==0){
				sendEvalResult = new ArrayList<HashMap<String,Object>>();			
				sendEvalResult.add(map);
			}else{
				if(examResult.get(i-1).getQuestion_id()==examResult.get(i-1).getQuestion_id()){				
					sendEvalResult.add(map);
				}else{
					sendEvalResultofList.add(sendEvalResult);
					sendEvalResult = null;
					sendEvalResult = new ArrayList<HashMap<String,Object>>();					
					sendEvalResult.add(map);
				}
			}
		}
		
		return sendEvalResultofList;
	}
	
	
	/////게시판////////////////////
	//공지
	@RequestMapping(value = "notice", method = RequestMethod.GET)
	public String notice() {		
		return "management.notice";
	}

	//질문과 답변
	@RequestMapping(value = "qna", method = RequestMethod.GET)
	public String qna() {		
		return "management.qna";
	}
	
	//모임방
	@RequestMapping(value = "community", method = RequestMethod.GET)
	public String community() {		
		return "management.community";
	}

	
	

	///////원생////////////////
	//사이트 회원
	@RequestMapping(value = "memberOfSiteList", method = RequestMethod.GET)
	public String getSiteMember(Model model) {		
		List<Member> memberList = memberService.getMemberOfSiteList();
		
		model.addAttribute("memberList", memberList);
		return "management.memberOfSiteList";
	}
	//원생목록
	@RequestMapping(value = "memberOfAcademyList", method = RequestMethod.GET)
	public String basic_table(Model model,
			@RequestParam(value="c_id",required=false, defaultValue="0")int c_id,
			@RequestParam(value="open_course_id",required=false, defaultValue="0")int open_course_id) {
		
		System.out.println("center_id:"+c_id);
		System.out.println("open_course_id:"+open_course_id);
/*		MemberOfAcademy moa = new MemberOfAcademy();
		moa.setCenter_id(center_id);
		moa.setOpen_course_id(open_course_id);
		System.out.println("moa.getAccount_id():"+moa.getAccount_id());
		System.out.println("moa.getOpen_course_id():"+moa.getOpen_course_id());*/
		
		List<MemberOfAcademy> memberList = memberService.getMemberOfAcademyList(c_id,open_course_id);
		List<EducationCenter> eduCenterList = employeeService.getEduCenterList();		
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("eduCenterList", eduCenterList);
		
		if(c_id != 0){
			List<OpenCourse> courseList = memberService.getCourseList(c_id);
			model.addAttribute("courseList", courseList);
		}	
		
		return "management.memberOfAcademyList";
	}
	//퇴교목록
	@RequestMapping(value = "memberOfLeaveList", method = RequestMethod.GET)
	public String responsive_table() {		
		return "management.memberOfLeaveList";
	}
	
	

	///직원///////
	//직원 목록 
	@RequestMapping(value = {"center", "manager", "teacher"}, method = RequestMethod.GET)
	//@RequestParam :파라미터로 now_center_id를 보내지 않을 때 기본값을 0으로 셋팅해준다.
	public String employee(Model model,
			@RequestParam(value="now_center_id",defaultValue="0") int now_center_id , 
			HttpServletRequest request) {	
		int job_code = 0;
		
		String myuri = request.getRequestURI();
			System.out.println("myurl:"+myuri);				
		String uri = myuri.substring(myuri.lastIndexOf("/")+1);
			System.out.println("uri:"+uri);
		if(uri.equals("center")){
			job_code = 3;
		}else if(uri.equals("manager")){
			job_code = 2;
		}else if(uri.equals("teacher")){
			job_code = 1;
		}	
		
		List<EmployeeList> emplist =  employeeService.getEmplList(job_code,now_center_id);
		List<EducationCenter> eduCenterList = employeeService.getEduCenterList();
		
		model.addAttribute("uri", uri);
		model.addAttribute("eduCenterList", eduCenterList);
		model.addAttribute("job_code", job_code);
		model.addAttribute("emplist",emplist);
		return "management.employee";
	}	
	//직원 상세정보 조회
	@RequestMapping(value = {"employeeDetail"}, method = RequestMethod.GET)
	public String employeeDetail(Model model, int account_id) {	
		Employee emp = employeeService.getEmp(account_id);
		model.addAttribute("emp", emp);
		return "management.employeeDetail";	
	}
	//직원 정보 수정
	@RequestMapping(value = {"employeeUpdate"}, method = RequestMethod.GET)
	public String employeeUpdate(Model model,Principal principal) {		
		int account_id = Integer.parseInt(principal.getName());
		
		Employee emp = employeeService.getEmp(account_id);
		model.addAttribute("emp", emp);
		return "management.employeeUpdate";
	}
	//직원 정보 수정 로직
	@RequestMapping(value = {"employeeUpdate"}, method = RequestMethod.POST)
	public String employeeUpdatePro(Model model,Employee emp) {
		int result = employeeService.updateEmp(emp);
		
		System.out.println("employeeUpdate result:"+result);		
		model.addAttribute("result", result);
		model.addAttribute("emp", emp);
		return "management.employeeUpdate";
	}
	
	
	
	
	
	/////test//////////
	@RequestMapping(value = "test", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> key(String json_data, Model model,
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
