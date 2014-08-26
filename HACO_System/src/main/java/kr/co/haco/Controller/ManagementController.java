package kr.co.haco.Controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.EmployeeService;
import kr.co.haco.Service.EvaluationRegisterService;
import kr.co.haco.Service.MemberService;
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

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping(value="management/")
public class ManagementController {
	
	@Autowired
	AccountService accountService;
	@Autowired
	EmployeeService employeeService; 
	@Autowired
	MemberService memberService;
	
	@Autowired
	EvaluationRegisterService evaluationRegisterService; 	

	
	//////직원 관리//////////////////
	//직원추가
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
	
	
	//출석
	@RequestMapping(value = "attendance", method = RequestMethod.GET)
	public String attendance() {
		return "management.attendance";
	}

	////////과정/////////////////
	//과목등록
	@RequestMapping(value = "subjectRegister", method = RequestMethod.GET)
	public String general() {		
		return "management.subjectRegister";
	}
	//과정등록
	@RequestMapping(value = "courseRegister", method = RequestMethod.GET)
	public String buttons() {		
		return "management.courseRegister";
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
	
	//강의평가 결과
	@RequestMapping(value = "evaluationResult", method = RequestMethod.GET)
	public String lectureEvaluation(Model model, int open_course_id) {		
		List<EvalExampleResult> resultList = evaluationRegisterService.getEvalResult(open_course_id);
		
		JSONArray jsonArray = new JSONArray(resultList);
		
		System.out.println("jsonArray:" + jsonArray);
		  
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", jsonArray);
		  
		JSONObject jsonObject = new JSONObject(map);		
		System.out.println("jsonObject:" + jsonObject);
		
		model.addAttribute("aa", jsonObject);
		return "management.evaluationResult.jsp";
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
	
}
