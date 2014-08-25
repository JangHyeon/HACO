package kr.co.haco.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Time;
import java.text.ParseException;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.CourseService;
import kr.co.haco.Service.SubjectService;
import kr.co.haco.Util.ImageJ;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.getCourseList;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Controller
@RequestMapping(value = "management/")
public class ManagementController {

	@Autowired
	AccountService accountService;

	@Autowired
	SubjectService subjectService;


	@Autowired
	CourseService courseService;
	// ////직원 관리//////////////////
	// 직원추가
	@RequestMapping(value = "employeeRegister", method = RequestMethod.GET)
	public String employeeManagement(Model model) {
		model.addAttribute("roleList", accountService.getRoleList());
		return "management.employeeRegister";
	}

	// 직원정보 사진 업로드
	@RequestMapping(value = "photoUploadn ", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> photoUpload(MultipartHttpServletRequest req) {

		System.out.println("photoUpload");

		InputStream in = null;
		OutputStream out = null;

		MultipartFile multipartFile = req.getFile("files[]");

		String usrUploadDir = "resources/upload/employeePhoto"; // 저장 폴더명
		// 업로드 파일명
		String originalFileName = multipartFile.getOriginalFilename();
		// 저장 파일명
		String targetFileName = UUID.randomUUID().toString().replace("-", "")
				+ "."
				+ originalFileName.substring(
						originalFileName.lastIndexOf(".") + 1,
						originalFileName.length()).toLowerCase();
		// 저장 경로
		String targetPath = req.getSession().getServletContext()
				.getRealPath("/")
				+ File.separator + usrUploadDir;

		File targetPathDir = new File(targetPath);
		if (!targetPathDir.exists())
			targetPathDir.mkdir();

		String savedFilePath = targetPathDir + File.separator + targetFileName;

		try {
			in = multipartFile.getInputStream();
			out = new FileOutputStream(savedFilePath);

			int readBytes = 0;
			byte[] buff = new byte[8192];

			while ((readBytes = in.read(buff, 0, 8192)) != -1) {
				out.write(buff, 0, readBytes);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (in != null)
				try {
					in.close();
					if (out != null)
						out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}

		String result = ImageJ.photoCropAndResize(savedFilePath, 177, 236);
		System.out.println("result-" + result);

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("originalFileName", originalFileName);
		map.put("renameFileName", targetFileName);

		return map;
	}

	// 대쉬보드
	@RequestMapping(value = "index", method = RequestMethod.GET)
	public String index() {
		System.out.println("index");
		return "management.index";
	}

	// 출석
	@RequestMapping(value = "attendance", method = RequestMethod.GET)
	public String attendance() {
		return "management.attendance";
	} 

	// //////과정//////////////////////////////////////////////////////////

	// 과목 Main..
	@RequestMapping(value = "subjectRegister", method = RequestMethod.GET)
	public String subjectRegister(Model model) {
		System.out.println("************************************************");
		System.out.println("subjectRegister//Basic");
		model.addAttribute("roleList", subjectService.getSubjectList());
		System.out.println("move:management.subjectRegister//att:roleList");
		return "management.subjectRegister";
	}

	// 과목등록 insertForm..
	@RequestMapping(value = "subjectInsert", method = RequestMethod.GET)
	public String insertForm(Model model) {
		// 리스트.
		System.out.println("************************************************");
		System.out.println("subjectInsert//InsertForm1");
		System.out.println("move:management.subjectInsert");
		model.addAttribute("Center", courseService.getCenter());
	
		return "management.subjectInsert";

	}

	public Time getTimestamp(String str) {
		return Time.valueOf(str);
	}

	// 과목등록 insertOk..
	@RequestMapping(value = "insertOk", method = RequestMethod.GET)
	public String insertOk(Subject subject, String start, String end)
			throws ParseException {
		System.out.println("************************************************");
		System.out.println("insertOk//");

		Time start1 = getTimestamp(start + ":00");
		System.out.println(start1);
		Time end1 = getTimestamp(end + ":00");
		long a = (end1.getTime() - start1.getTime()) / 1000;
		int time1 = (int) (a / 3600);
		int time2 = (int) (a % 3600 / 60);

		int b = (int) (subject.getLecture_totalday() * a);

		/*
		 * SimpleDateFormat sdfCurrent = new SimpleDateFormat
		 * ("yyyy-mm-dd hh:mm:ss"); Timestamp currentTime = new
		 * Timestamp((start1-start2)/1000); System.out.println(currentTime);
		 * String today = sdfCurrent.format(currentTime);
		 * System.out.println("today==="+today);
		 */

		Subject subject2 = new Subject(subject.getSubject_id() ,subject.getSubject_name(),
				subject.getCapacity(), subject.getSubject_explanation(),
				subject.getInstructional_objectives(),
				subject.getSubject_point(), subject.getLecture_target(),
				subject.getLecture_totalday(), subject.getTuition_fee(),
				subject.getLecture_content(), subject.getCenter_id(), start1,
				end1, b / 3600);

		subjectService.insertSubject(subject2);

		return "management.subjectInsert";

	}

	// 과목수정 updateForm..
	@RequestMapping(value = "subjectUpdate", method = RequestMethod.GET)
	public String subjectUpdate(HttpServletRequest request, Model model) {

		System.out.println("************************************************");
		System.out.println("subjectUpdate//");
		System.out.println("move:management.subjectUpdate//Update");
		System.out.println(request.getParameter("id"));
		model.addAttribute("Center", courseService.getCenter());
		model.addAttribute("roleList",
				subjectService.getSubjectList2(request.getParameter("id")));
		return "management.subjectUpdate";
	}

	// 과목수정 UpdateOk..
	@RequestMapping(value = "UpdateOk", method = RequestMethod.GET)
	public void UpdateOk(Model model, Subject subject, String start,
			String end, HttpServletResponse res) throws IOException {
		System.out.println("************************************************");
		System.out.println("UpdateOk//");
		System.out.println("move:management.subjectRegister");
		System.out.println(subject.toString());
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
		System.out.println(subjectService.updateSubject(subject2));
		res.sendRedirect("subjectRegister");
	}

	// 과목삭제 DeleteOk..
	@RequestMapping(value = "DeleteOk", method = RequestMethod.GET)
	public void DeleteOk(Model model, HttpServletRequest request,
			HttpServletResponse res) throws IOException {
		System.out.println("************************************************");
		System.out.println("DeleteOk//");
		System.out.println("move:management.subjectRegister");
		System.out.println("idvalue2 : " + request.getParameter("id"));
		System.out.println(subjectService.deleteSubject(request
				.getParameter("id")));
		res.sendRedirect("subjectRegister?id=aa");
	}

	// 과정 Main..
	@RequestMapping(value = "courseRegister", method = RequestMethod.GET)
	public String courseRegister(Model model) {
		System.out.println("************************************************");
		System.out.println("courseRegister//Basic");
		System.out.println("move:management.courseRegister//att:roleList");
		model.addAttribute("roleList", courseService.getCourseList());
		model.addAttribute("Center", courseService.getCenter());
		/*
		 * System.out.println(accountService.getClassroom(4));
		 * System.out.println(accountService.getCourseList());
		 */
		return "management.courseRegister";
	}

	@RequestMapping(value = "courseInsert", method = RequestMethod.GET)
	public String courseInsert(Model model) {
		// 리스트.
		System.out.println("************************************************");
		System.out.println("courseInsert//InsertForm");
		System.out.println("move:management.courseInsert");
		model.addAttribute("Center", courseService.getCenter());
		model.addAttribute("Subject", subjectService.getSubjectList());
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
		model.addAttribute("roleList", courseService.getCourseList());
		
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
			model.addAttribute("Subject", subjectService.getSubjectList());
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
	

	// /////////////////////////////////////////////////////////////////////////
	// 교육센터
	@RequestMapping(value = "educationCenter", method = RequestMethod.GET)
	public String educationCenter() {
		return "management.educationCenter";
	}

	// 수강신청
	@RequestMapping(value = "lectureRegister", method = RequestMethod.GET)
	public String lectureRegister() {
		return "management.lectureRegister";
	}

	// 강의평가
	@RequestMapping(value = "lectureEvaluation", method = RequestMethod.GET)
	public String lectureEvaluation() {
		return "management.lectureEvaluation";
	}

	// ///게시판////////////////////
	// 공지
	@RequestMapping(value = "notice", method = RequestMethod.GET)
	public String notice() {
		return "management.notice";
	}

	// 질문과 답변
	@RequestMapping(value = "qna", method = RequestMethod.GET)
	public String qna() {
		return "management.qna";
	}

	// 모임방
	@RequestMapping(value = "community", method = RequestMethod.GET)
	public String community() {
		return "management.community";
	}

	// /////원생////////////////
	// 신규원생
	@RequestMapping(value = "newMemberList", method = RequestMethod.GET)
	public String panels() {
		return "management.newMemberList";
	}

	// 원생목록
	@RequestMapping(value = "memberList", method = RequestMethod.GET)
	public String basic_table() {
		return "management.memberList";
	}

	// 퇴교목록
	@RequestMapping(value = "leaveMemberList", method = RequestMethod.GET)
	public String responsive_table() {
		return "management.leaveMemberList";
	}

	// /직원///////
	// 센터장
	@RequestMapping(value = "center", method = RequestMethod.GET)
	public String morris() {
		return "management.center";
	}

	// 관리직원
	@RequestMapping(value = "manager", method = RequestMethod.GET)
	public String gallery() {
		return "management.manager";
	}

	// 강사
	@RequestMapping(value = "teacher", method = RequestMethod.GET)
	public String todo_list() {
		return "management.teacher";
	}
}
