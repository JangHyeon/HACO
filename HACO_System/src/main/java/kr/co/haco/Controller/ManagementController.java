package kr.co.haco.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.UUID;

import kr.co.haco.Service.AccountService;
import kr.co.haco.Util.ImageJ;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping(value="management/")
public class ManagementController {
	
	
	
	
	
	@Autowired
	AccountService accountService;
	
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
		
		System.out.println("photoUpload");
		
	    InputStream in = null;
	    OutputStream out = null;
	 
	    MultipartFile multipartFile = req.getFile("files[]");
	    
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
