package kr.co.haco.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.EmployeeService;
import kr.co.haco.Service.EvaluationRegisterService;
import kr.co.haco.Service.EvaluationRegisterformService;
import kr.co.haco.Service.MemberService;
import kr.co.haco.Util.ImageJ;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EmployeeList;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.MemberOfAcademy;

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
	
	@Autowired
	EvaluationRegisterformService evaluationRegisterformService;
	
	//////직원 관리//////////////////
	//직원추가
	@RequestMapping(value = "employeeRegister", method = RequestMethod.GET)
	public String employeeManagement(Model model){
		model.addAttribute("roleList",accountService.getRoleList());
		return "management.employeeRegister";
	}
	@RequestMapping(value = "employeeRegister", method = RequestMethod.POST)
	public String employeeManagementAdd(Employee employee){		
		employeeService.addEmployee(employee);
		return "management.index";
	}
	
	

	//직원정보 사진 업로드
	@RequestMapping(value="photoUpload", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> photoUpload(MultipartHttpServletRequest req){
		
		System.out.println("photoUpload");
		
	    InputStream in = null;
	    OutputStream out = null;
	 
	    MultipartFile multipartFile = req.getFile("file");
	    
	    String usrUploadDir = "resources/upload/employeePhoto"; //저장 폴더명
		//업로드 파일명
	    String originalFileName = multipartFile.getOriginalFilename();
	    //저장 파일명
	    String targetFileName = UUID.randomUUID().toString().replace("-", "") + "." +
	            originalFileName.substring(originalFileName.lastIndexOf(".") + 1, originalFileName.length()).toLowerCase();
	    //저장 경로
	    String targetPath = req.getSession().getServletContext().getRealPath("/")+File.separator + usrUploadDir;
	    
	    File targetPathDir = new File(targetPath);
	    if(!targetPathDir.exists()) targetPathDir.mkdir();
	     
	    String savedFilePath = targetPathDir + File.separator + targetFileName;
	     
	    try {
	        in = multipartFile.getInputStream();
	        out = new FileOutputStream(savedFilePath);
	         
	        int readBytes = 0;
	        byte[] buff = new byte[8192];
	         
	        while((readBytes=in.read(buff,0,8192))!=-1){
	            out.write(buff,0,readBytes);
	        }           
	    } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
	        if(in!=null)
				try {
					in.close();
			        if(out!=null) out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    }
	    
	    String result = ImageJ.photoCropAndResize(savedFilePath,177, 236);
	    System.out.println("result-"+result);
	    
	    
	    
	    HashMap<String, String> map = new HashMap<String, String>();
	    map.put("originalFileName", originalFileName);
	    map.put("renameFileName", targetFileName);
	     
	    return map;
	}

	
	
	//대쉬보드
	@RequestMapping(value = "index", method = RequestMethod.GET)
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
	
	// 평가 등록 리스트
	@RequestMapping(value="evaluationRegister" , method=RequestMethod.GET)
	public String evaluationRegister(Model model){
		model.addAttribute("er",evaluationRegisterService.getevaluationRegist());
		return "management.evaluationRegister";
		
	}
	
	//평가 등록
	@RequestMapping(value="evaluationRegisterform" , method=RequestMethod.GET)
	public String evaluationRegisterform(Model model , String course_name/*, int type_code , String question*/){
		
		// 윗부분 과정명, 과목명 , 강사명 , 수강기간 뿌려주기
		// System.out.println(course_name);
		model.addAttribute("erf",evaluationRegisterformService.getEvaluationRegisterform(course_name));
		// System.out.println(evaluationRegisterformService.getEvaluationRegisterform(course_name));
		
		// 객관식 질문 등록하기 
		/*System.out.println(type_code);
		System.out.println(question);*/
		/*model.addAttribute("insertque",evaluationRegisterformService.getinsertquestion(type_code, question));
		model.addAttribute("lastid",evaluationRegisterformService.getlastid());	
			*/
			
			return "management.evaluationRegisterform";
		
	}
	
	//강의평가
	@RequestMapping(value = "lectureEvaluation", method = RequestMethod.GET)
	public String lectureEvaluation() {		
		return "management.lectureEvaluation";
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
			@RequestParam(value="center_id", defaultValue="0")int center_id,
			@RequestParam(value="open_course_id", defaultValue="0")int open_course_id) {		
		List<MemberOfAcademy> memberList = memberService.getMemberOfAcademyList(center_id,open_course_id);
		List<EducationCenter> eduCenterList = employeeService.getEduCenterList();
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("eduCenterList", eduCenterList);
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
	public String employee(Model model,@RequestParam(value="now_center_id",defaultValue="0") int now_center_id , HttpServletRequest request) {	
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
