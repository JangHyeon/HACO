package kr.co.haco.Controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Service.AttendanceService;
import kr.co.haco.Service.LectureRegisterService;
import kr.co.haco.Util.ImageJ;
import kr.co.haco.VO.AttendanceVO;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.LectureRegisterVO;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.Util.MultipartUploader;

import org.apache.catalina.Session;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.SessionScope;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping(value="management/")
public class ManagementController {
	@Autowired
	AccountService accountService;
	
	@Autowired
	AttendanceService attendanceService;
	
	@Autowired
	LectureRegisterService lectureregisterService;
	//////직원 관리//////////////////
	//직원추가
	@RequestMapping(value = "employeeRegister", method = RequestMethod.GET)
	public String employeeManagement(Model model){
		model.addAttribute("roleList",accountService.getRoleList());
		return "management.employeeRegister";
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
	//출석
		@RequestMapping(value = "attendancelist", method = RequestMethod.GET)
		public String attendancelist(HttpSession session, HttpServletRequest req) {
			Employee eply = (Employee) session.getAttribute("employee");
			String seldate = req.getParameter("attendancesub");
			HashMap map = new HashMap();
			map.put("center_id", eply.getNow_center_id());
			map.put("seldate", seldate);
			List<OpenCourse> getattenlist = attendanceService.getattenlist(map);
			OpenCourse attendance_date = new OpenCourse();
			attendance_date.setSeldate(req.getParameter("attendancesub"));
			req.setAttribute("attendance_date", attendance_date);
			req.setAttribute("getattenlist", getattenlist);
			return "management.attendancelist";
		}
		//출석
		@RequestMapping(value = "studentlist", method = RequestMethod.GET)
		public String stdentlist(HttpSession session,HttpServletRequest req) {
			OpenCourse date = new OpenCourse();
			date.setSeldate(req.getParameter("attendance_date"));
			System.out.println("attendance_date : " +date);
			String center_id = req.getParameter("center_id");
			System.out.println("center_id : " + center_id);
			String open_course_id = req.getParameter("open_course_id");
			System.out.println("open_course_id :" + open_course_id);
			
			HashMap map = new HashMap();
			
			map.put("center_id", center_id);
			map.put("open_course_id", open_course_id);
			List<Member> getstdentlist = attendanceService.getstdentlist(map);
			req.setAttribute("date", date);
			req.setAttribute("getstdentlist", getstdentlist);
			req.setAttribute("open_course_id", open_course_id);
			String attendance_code = req.getParameter("attendance_code");
			System.out.println("attendance_code : " +attendance_code);
			if(attendance_code!=null){
				String attendance_date = req.getParameter("attendance_date");
				String lecture_register_id = req.getParameter("lecture_register_id");
				System.out.println("lecture_register_id : " + lecture_register_id);
				System.out.println("attendance_date : " +attendance_date);
				System.out.println("center_id : " + center_id);
				System.out.println("open_course_id :" + open_course_id);
				System.out.println("attendance_code : " +attendance_code);
				
				AttendanceVO VO = new AttendanceVO();
				VO.setCenter_id(Integer.parseInt(center_id));
				VO.setAttendance_code(Integer.parseInt(attendance_code));
				VO.setAttendance_date(attendance_date);
				VO.setLecture_register_id(Integer.parseInt(lecture_register_id));
				VO.setOpen_course_id(Integer.parseInt(open_course_id));
				List<AttendanceVO> list = new ArrayList<AttendanceVO>();
				list.add(VO);
				/*map.put("center_id",Integer.parseInt(center_id));
				map.put("attendance_code",Integer.parseInt(attendance_code));
				map.put("lecture_register_id",Integer.parseInt(lecture_register_id));
				map.put("open_course_id", Integer.parseInt(open_course_id));
				map.put("attendance_date",attendance_date);*/
				Map<String, Object> mm = new HashMap<String, Object>();
				mm.put("list", list);
				/*attendanceService.insertatt(map);*/
			}
			return "management.studentlist";
		}
		@Autowired private SqlSession mapper;
		 public void insetUser(Map<String, Object> map) {
		        List<AttendanceVO> list = (ArrayList<AttendanceVO>)map.get("list");
		        for(AttendanceVO dto : list) {
		            mapper.insert("attendanceService.insertatt", dto);
		        }
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
	public String lectureRegister(HttpSession session, HttpServletRequest req) {	
		Employee eply = (Employee) session.getAttribute("employee");

		String classification = req.getParameter("classification")==null?"":req.getParameter("classification");
		String open_course_id = req.getParameter("open_course_id")==null?"":req.getParameter("open_course_id");
		String account_id = req.getParameter("account_id")==null?"":req.getParameter("account_id");
		System.out.println(classification);
		HashMap map = new HashMap();
		map.put("open_course_id", open_course_id);
		map.put("account_id", account_id);
		
		if (classification.equals("grant")) {
			lectureregisterService.updatestudent(map);
		}else if (classification.equals("cancel")) {
			lectureregisterService.cancelstudent(map);
		}else if (classification.equals("complete")) {
			lectureregisterService.completestudent(map);
		}
		
		Calendar c = Calendar.getInstance();
		String month = ""+(c.get(Calendar.MONTH)+1);
		if(month.length()==1) {month= "0" +month;};
		String today = c.get(Calendar.YEAR) +"-" + month +"-"+(c.get(Calendar.DATE)+1);
		
		map.put("center_id", eply.getNow_center_id());
		map.put("today", today);
		
		List<LectureRegisterVO> getlecturestats = lectureregisterService.getlecturestats(map);
		req.setAttribute("getlecturestats", getlecturestats);
		return "management.lectureRegister";
	}
	//수강신청완료page
		@RequestMapping(value = "lectureRegisterComplete", method = RequestMethod.GET)
		public String lectureRegisterComplete(HttpSession session, HttpServletRequest req) {	
			Employee eply = (Employee) session.getAttribute("employee");
			Calendar c = Calendar.getInstance();
			String month = ""+(c.get(Calendar.MONTH)+1);
			if(month.length()==1) {month= "0" +month;};
			String today = c.get(Calendar.YEAR) +"-" + month +"-"+(c.get(Calendar.DATE)+1);
			HashMap map = new HashMap();
			map.put("center_id", eply.getNow_center_id());
			map.put("today", today);
			List<LectureRegisterVO> getlecturecomplete = lectureregisterService.getlecturecomplete(map);
			req.setAttribute("getlecturecomplete", getlecturecomplete);
			return "management.lectureRegisterComplete";
		}
	/*//수강신청허가
		@RequestMapping(value = "updatest", method = RequestMethod.GET)
		public String updatest(HttpServletRequest req) {
			String open_course_id = req.getParameter("open_course_id");
			String account_id = req.getParameter("account_id");
			HashMap map = new HashMap();
			map.put("open_course_id", open_course_id);
			map.put("account_id", account_id);
			int updatestudent = lectureregisterService.updatestudent(map);
			req.setAttribute("updatestudent", updatestudent);
			String res = "redirect:/management/lectureRegister";
			return res;
		}
	//수강신청취소
		@RequestMapping(value = "cancelst", method = RequestMethod.GET)
		public String canslest(HttpServletRequest req) {
			String open_course_id = req.getParameter("open_course_id");
			String account_id = req.getParameter("account_id");
			HashMap map = new HashMap();
			map.put("open_course_id", open_course_id);
			map.put("account_id", account_id);
			int cancelstudent = lectureregisterService.cancelstudent(map);
			req.setAttribute("canslestudent", cancelstudent);
			String res = "redirect:/management/lectureRegister";
			return res;
		}
	//수강신청완료
			@RequestMapping(value = "completest", method = RequestMethod.GET)
			public String deletest(HttpServletRequest req) {
				String open_course_id = req.getParameter("open_course_id");
				String account_id = req.getParameter("account_id");
				HashMap map = new HashMap();
				map.put("open_course_id", open_course_id);
				map.put("account_id", account_id);
				int completestudent = lectureregisterService.completestudent(map);
				req.setAttribute("completestudent", completestudent);
				String res = "redirect:/management/lectureRegister";
				return res;
			}*/
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
	//신규원생
	@RequestMapping(value = "newMemberList", method = RequestMethod.GET)
	public String panels() {		
		return "management.newMemberList";
	}
	//원생목록
	@RequestMapping(value = "memberList", method = RequestMethod.GET)
	public String basic_table() {		
		return "management.memberList";
	}
	//퇴교목록
	@RequestMapping(value = "leaveMemberList", method = RequestMethod.GET)
	public String responsive_table() {		
		return "management.leaveMemberList";
	}
	
	

	///직원///////
	//센터장
	@RequestMapping(value = "center", method = RequestMethod.GET)
	public String morris() {		
		return "management.center";
	}
	//관리직원
	@RequestMapping(value = "manager", method = RequestMethod.GET)
	public String gallery() {		
		return "management.manager";
	}
	//강사
	@RequestMapping(value = "teacher", method = RequestMethod.GET)
	public String todo_list() {		
		return "management.teacher";
	}
}
