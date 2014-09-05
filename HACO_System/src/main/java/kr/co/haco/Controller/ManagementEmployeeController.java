package kr.co.haco.Controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.haco.DAO.EmployeeDAO;
import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.EmployeeService;
import kr.co.haco.Service.MemberService;
import kr.co.haco.Service.ManagementService;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.OpenCourse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "management/")
public class ManagementEmployeeController {
	@Autowired
	SqlSession sqlSession;
	@Autowired
	MemberService memberService;
	@Autowired
	AccountService accountService;
	@Autowired
	EmployeeService employeeService;
	@Autowired
	ManagementService managementService; 

	// ////직원 관리//////////////////
	// 직원추가
	@RequestMapping(value = "employeeRegister", method = RequestMethod.GET)
	public String employeeManagement(Model model) {
		List<EducationCenter> eduList = employeeService.getEduCenterList();
		model.addAttribute("eduCenterList", eduList);
		return "management.employeeRegister";
	}
	

	// 직원정보 사진 업로드
	@RequestMapping(value = "photoUpload", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> photoUpload(MultipartHttpServletRequest req) {
		return managementService.photoUpload(req);
	}

	@RequestMapping(value = "employeeRegister", method = RequestMethod.POST)
	public String employeeManagementAdd(Employee employee,
			RedirectAttributes redirectAttributes) {
		HashMap<String, Integer> resultMap = employeeService
				.addEmployee(employee);
		int result = resultMap.get("result");
		int account_id = resultMap.get("account_id");

		redirectAttributes.addAttribute("result", result);
		redirectAttributes.addAttribute("user_id", account_id);
		return "redirect:index";
	}

	// /직원///////
	/*
	 * //직원 목록 - 페이징 없는 것
	 * 
	 * @RequestMapping(value = {"center", "manager", "teacher"}, method =
	 * RequestMethod.GET) //@RequestParam :파라미터로 now_center_id를 보내지 않을 때 기본값을
	 * 0으로 셋팅해준다. public String employeeList(Model model,
	 * 
	 * @RequestParam(value="now_center_id",defaultValue="0") int now_center_id ,
	 * HttpServletRequest request) { int job_code = 0;
	 * 
	 * String myuri = request.getRequestURI();
	 * System.out.println("myurl:"+myuri); String uri =
	 * myuri.substring(myuri.lastIndexOf("/")+1);
	 * System.out.println("uri:"+uri); if(uri.equals("center")){ job_code = 3;
	 * }else if(uri.equals("manager")){ job_code = 2; }else
	 * if(uri.equals("teacher")){ job_code = 1; }
	 * 
	 * List<EmployeeList> emplist =
	 * employeeService.getEmplList(job_code,now_center_id);
	 * List<EducationCenter> eduCenterList = employeeService.getEduCenterList();
	 * 
	 * model.addAttribute("uri", uri); model.addAttribute("eduCenterList",
	 * eduCenterList); model.addAttribute("job_code", job_code);
	 * model.addAttribute("emplist",emplist); return "management.employee"; }
	 */
	// 직원 목록 - 페이징 있는 것
	@RequestMapping(value = { "center", "manager", "teacher" }, method = RequestMethod.GET)
	// @RequestParam :파라미터로 now_center_id를 보내지 않을 때 기본값을 0으로 셋팅해준다.
	public String employeeListPaging(
			Model model,
			@RequestParam(value = "now_center_id", defaultValue = "0") int now_center_id,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
			HttpServletRequest request) {
		int job_code = 0;

		String myuri = request.getRequestURI();
		System.out.println("myurl:" + myuri);
		String uri = myuri.substring(myuri.lastIndexOf("/") + 1);
		System.out.println("uri:" + uri);
		if (uri.equals("center")) {
			job_code = 3;
		} else if (uri.equals("manager")) {
			job_code = 2;
		} else if (uri.equals("teacher")) {
			job_code = 1;
		}

		employeeService.getEmplList(job_code, now_center_id, model, pageNum,
				pageSize);
		List<EducationCenter> eduCenterList = employeeService
				.getEduCenterList();

		model.addAttribute("uri", uri);
		model.addAttribute("eduCenterList", eduCenterList);
		model.addAttribute("job_code", job_code);

		return "management.employee";
	}

	// 직원 상세정보 조회
	@RequestMapping(value = { "employeeDetail" }, method = RequestMethod.GET, params = "!account_id")
	public String employeeDetail(Model model, Principal principal) {
		int account_id = Integer.parseInt(principal.getName());
		Employee emp = employeeService.getEmp(account_id);
		model.addAttribute("emp", emp);
		return "management.employeeDetail";
	}

	// 직원 상세정보 조회
	@RequestMapping(value = { "employeeDetail/{account_id}" }, method = RequestMethod.GET)
	public String employeeDetail(Model model, Principal principal,
			@PathVariable int account_id) {
		Employee emp = employeeService.getEmp(account_id);
		model.addAttribute("emp", emp);
		return "management.employeeDetail";
	}

	// 직원 정보 수정
	@RequestMapping(value = { "employeeUpdate" }, method = RequestMethod.GET)
	public String employeeUpdate(Model model, Principal principal,
			@RequestParam(value = "result", defaultValue = "0") int result) {
		int account_id = Integer.parseInt(principal.getName());

		Employee emp = employeeService.getEmp(account_id);
		model.addAttribute("emp", emp);
		model.addAttribute("result", result);
		return "management.employeeUpdate";
	}

	// 직원 정보 수정 로직
	@RequestMapping(value = { "employeeUpdate" }, method = RequestMethod.POST)
	public String employeeUpdatePro(Model model, Employee emp,
			Principal principal, HttpSession session,
			RedirectAttributes redirectAttributes) {
		System.out.println("ManagementController- employeeUpdate");
		int account_id = Integer.parseInt(principal.getName());
		emp.setAccount_id(account_id);

		int result = 0;

		System.out.println("user_id:" + emp.getUser_id());
		// id를 변경할 경우
		if (emp.getUser_id() != null) {
			EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
			result += employeeDAO.setUserIdWithId(emp.getAccount_id(),
					emp.getUser_id());

			if (result > 0) {
				result += employeeService.updateEmp(emp);
			}
		} else { // id를 변경하지 않은 경우
			result += employeeService.updateEmp(emp);
		}

		session.setAttribute("employee",
				accountService.getEmployee(principal.getName()));

		System.out.println("photo:" + emp.getPhoto());
		System.out.println("account_id:" + emp.getAccount_id());
		System.out.println("employeeUpdate result:" + result);

		redirectAttributes.addAttribute("result", result);
		return "redirect:employeeUpdate";
	}

	// /////원생////////////////
	// 사이트 회원 - 페이징 처리 없는 것
	@RequestMapping(value = "memberOfSiteList", method = RequestMethod.GET)
	// , params="!pageSize"
	public String getSiteMember(Model model) {
		memberService.getMemberOfSiteList(model, 10, 1);
		return "management.memberOfSiteList";
	}

	// 사이트 회원 - 페이징 처리
	@RequestMapping(value = "memberOfSiteList/{pageSize}/{pageNum}", method = RequestMethod.GET)
	public String getSiteMemberPaging(Model model, @PathVariable int pageSize,
			@PathVariable int pageNum) {
		memberService.getMemberOfSiteList(model, pageSize, pageNum);
		return "management.memberOfSiteList";
	}

	// 원생목록 - 페이징 처리 없음
	@RequestMapping(value = "memberOfAcademyList", method = RequestMethod.GET)
	public String studentList(
			Model model,
			@RequestParam(value = "c_id", required = false, defaultValue = "0") int c_id,
			@RequestParam(value = "open_course_id", required = false, defaultValue = "0") int open_course_id) {

		System.out.println("center_id:" + c_id);
		System.out.println("open_course_id:" + open_course_id);

		memberService
				.getMemberOfAcademyList(c_id, open_course_id, model, 1, 10);
		List<EducationCenter> eduCenterList = employeeService
				.getEduCenterList();

		model.addAttribute("eduCenterList", eduCenterList);

		if (open_course_id != 0) {
			System.out.println("open_course_id 값이 0이 아닐 때 들어오나");
			// 센터목록에 셋팅
			model.addAttribute("center_name", eduCenterList.get(c_id - 1)
					.getLocation());
			List<OpenCourse> courseList = memberService.getCourseList(c_id);
			model.addAttribute("courseList", courseList);
			// 강좌목록에 셋팅
			String course_name = "";
			for (int i = 0; i < courseList.size(); i++) {
				if (courseList.get(i).getOpen_course_id() == open_course_id) {
					course_name = courseList.get(i).getCourse_name();
				}
			}
			model.addAttribute("course_name", course_name);
		}

		return "management.memberOfAcademyList";
	}

	// 원생목록 - 페이징 처리
	@RequestMapping(value = "memberOfAcademyList/{pageSize}/{pageNum}", method = RequestMethod.GET)
	public String studentListPageing(
			Model model,
			@PathVariable int pageSize,
			@PathVariable int pageNum,
			@RequestParam(value = "c_id", required = false, defaultValue = "0") int c_id,
			@RequestParam(value = "open_course_id", required = false, defaultValue = "0") int open_course_id) {

		System.out.println("center_id:" + c_id);
		System.out.println("open_course_id:" + open_course_id);

		memberService.getMemberOfAcademyList(c_id, open_course_id, model,
				pageNum, pageSize);
		List<EducationCenter> eduCenterList = employeeService
				.getEduCenterList();

		model.addAttribute("eduCenterList", eduCenterList);

		if (open_course_id != 0) {
			System.out.println("open_course_id 값이 0이 아닐 때 들어오나");
			// 센터목록에 셋팅
			model.addAttribute("center_name", eduCenterList.get(c_id - 1)
					.getLocation());
			List<OpenCourse> courseList = memberService.getCourseList(c_id);
			model.addAttribute("courseList", courseList);
			// 강좌목록에 셋팅
			String course_name = "";
			for (int i = 0; i < courseList.size(); i++) {
				if (courseList.get(i).getOpen_course_id() == open_course_id) {
					course_name = courseList.get(i).getCourse_name();
				}
			}
			model.addAttribute("course_name", course_name);
		}
		return "management.memberOfAcademyList";
	}

	// 센터별 강좌 리스트 가져오기
	@RequestMapping(value = "getOpenCourseList")
	@ResponseBody
	public List<OpenCourse> getCourseList(int center_id) {
		System.out.println("ManagementController - getCourseList");
		System.out.println("center_id:" + center_id);
		List<OpenCourse> openCourseList = memberService
				.getCourseList(center_id);
		return openCourseList;
	}

	// 퇴교목록
	@RequestMapping(value = "memberOfLeaveList", method = RequestMethod.GET)
	public String responsive_table() {
		return "management.memberOfLeaveList";
	}
}
