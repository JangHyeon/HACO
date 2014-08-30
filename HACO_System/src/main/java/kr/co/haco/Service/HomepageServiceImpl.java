package kr.co.haco.Service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.haco.DAO.HomepageDAO;
import kr.co.haco.Util.DateUtil;
import kr.co.haco.Util.ImageJ;
import kr.co.haco.Util.MultipartUploader;
import kr.co.haco.Util.myStringUtils;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.Notice;
import kr.co.haco.VO.Qna;
import kr.co.haco.VO.UploadFile;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mysql.jdbc.StringUtils;

@Service
public class HomepageServiceImpl implements HomepageService {

	@Autowired
	SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(HomepageServiceImpl.class);
	
	@Override
	public Map<String, String> photoUpload(MultipartHttpServletRequest req){

	    MultipartFile multipartFile = req.getFile("file");
	    String usrUploadDir = "/resources/upload/employeePhoto"; //저장 폴더명

	    MultipartUploader mu = new MultipartUploader(req, usrUploadDir, multipartFile,true);
	    
	    String result = ImageJ.photoCropAndResize(mu.getFilePath(),177, 236);
	    System.out.println("result-"+result);
	    
		UploadFile uploadFile = new UploadFile();
		uploadFile.setBoard_name("/employeePhoto");
		uploadFile.setFile_type("images");
		uploadFile.setFilesize(mu.getFileSize());
		uploadFile.setOrign_file(mu.getOriginalFileName());
		uploadFile.setSave_file(mu.getFileName());
				
		sqlSession.getMapper(HomepageDAO.class).insertuploadFile(uploadFile);
	    
	    HashMap<String, String> map = new HashMap<String, String>();
	    map.put("originalFileName", multipartFile.getOriginalFilename());
	    map.put("renameFileName", mu.getFileName());
	    map.put("fileUrl", mu.getFileUrl());
		
		return map;
	}

	@Override
	public void getNoticeList(Notice notice, HttpSession session, Model model, String contextPath) {
		
		/*@RequestParam(defaultValue="1") int pageNum, 
		@RequestParam(defaultValue="10") int pageSize, 
		@RequestParam(defaultValue="title") String searchType, 
		@RequestParam(defaultValue="") String searchKey*/
		
		if(notice.getSearchKey()!=null && !notice.getSearchKey().equals(""))
			logger.info("[getNoticeList] - SearchType:["+notice.getSearchType()+"] SearchKey:["+notice.getSearchKey()+"] / 검색");
		
		//기본값 설정
		if(notice.getPageNum()==0) notice.setPageNum(1);
		if(notice.getPageSize()==0) notice.setPageSize(10);
		if(notice.getSearchType()==null || notice.getSearchType().equals("")) notice.setSearchType("title");
		if(notice.getSearchKey()==null || notice.getSearchKey().equals("")) notice.setSearchKey("");
		
		//비회원
		if(session.getAttribute("member")==null && session.getAttribute("employee")==null){
			notice.setCenter_id(1);
			notice.setState_code(1); //일반글 코드
		}else if(session.getAttribute("member")!=null){ 
			//회원
			Member member =(Member)session.getAttribute("member");
			
			//학생인경우 교육센터 정보 조회
			List<Integer> resultCenterId = sqlSession.getMapper(HomepageDAO.class).getLectureRegisterByMember(member.getAccount_id());
			if(resultCenterId.size()==0){
				notice.setCenter_id(1);
			}else{
				String center_list = resultCenterId.toString().substring(1, resultCenterId.toString().length()-1);
				notice.setCenter_list(center_list);
			}
			notice.setState_code(1); //일반글 코드
		}else if(session.getAttribute("employee")!=null){
			//직원(비밀공지)
			Employee employee = (Employee)session.getAttribute("employee");
			//근무센터 조회
			notice.setCenter_list(employee.getNow_center_id()+"");
			notice.setState_code(99); //비밀글 코드 0을 직원 공지로 사용
		}
		
		// 현 페이지 정보
		int pageNum = notice.getPageNum();
		int pageSize = notice.getPageSize();
		
		int start = pageNum * pageSize - (pageSize -1)-1;
		notice.setStartNum(start);
		
		//게시물 리스트 출력
		List<Notice> noticeList = sqlSession.getMapper(HomepageDAO.class).getNoticeList(notice);
		
		// 검색된 총 게시물 건수
		int noticeListCount = sqlSession.getMapper(HomepageDAO.class).getNoticeListCount(notice);
		
		model.addAttribute("noticeListCount", noticeListCount);
		
		// 페이징 처리		
		int visiblePageNum = 10;
		int pagecount = 0;
		int beginPage = 0;
		int endPage = 0;
		if (noticeListCount != 0) {// 게시물이 없는 경우
			pagecount = noticeListCount / pageSize;// 115건 = 11page
			if (noticeListCount % pageSize > 0) {// 115건 = 나머지 5 true
				pagecount++;// 11page++ = 12page
			}
			beginPage = (pageNum - 1) / visiblePageNum * visiblePageNum + 1;// 10단위 계산
			endPage = beginPage + (visiblePageNum - 1);
			if (endPage > pagecount) {
				endPage = pagecount;
			}
		}

		
		// view에 보낼 데이터
		model.addAttribute("pagecount", pagecount);
		model.addAttribute("beginpage", beginPage);
		model.addAttribute("endpage", endPage);

		model.addAttribute("pageNum",pageNum);
		model.addAttribute("pageSize",pageSize);

		model.addAttribute("searchType",notice.getSearchType());

		//검색어가 없는경우 재처리
		if(notice.getSearchKey().equals("")) notice.setSearchKey("[noKeyword]");
		model.addAttribute("searchKey",notice.getSearchKey());

		
		// 최신글, 공지사항, 긴 아이디 제목 처리,날짜 포맷 재설정
		Date now = new Date();//현재 시간
		int n = 24;			//n시간전으로 설정
		now.setTime(now.getTime()-1000*60*60*n);
		for (Notice DTO : noticeList) {
			

			// 제목 영문 기준 50자 길이로 처리
			String title = DTO.getTitle();
			title = myStringUtils.getFixString(title, 50);
			
			// 7자 초과 닉네임
			String name_kor = DTO.getName_kor();
			if (name_kor != null && name_kor.length() > 7) {
				name_kor = name_kor.substring(0, 7) + "..";
			}
			DTO.setName_kor(name_kor);
			

			//직원공지글
			if(DTO.getState_code()==0){
				title ="<span class='label label-info'><i class='fa fa-exclamation-circle'></i> 직원 공지 </span>"+ title;
			}
			
			// 최신글
			Timestamp writeDate = DTO.getRegister_date();
			if(writeDate.getTime()>now.getTime()){
				title+="&nbsp;<img alt='new' src='"+contextPath+"/images/new.gif'>";
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"HH:mm:ss"));
			}else{
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"yyyy.MM.dd"));
			}
			DTO.setTitle(title);
		}
		model.addAttribute("noticeList",noticeList);
		
		

		//상단 고정 공지
		notice.setState_code(2);
		notice.setSearchType(null);
		notice.setSearchKey(null);
		notice.setStartNum(0);
		notice.setPageNum(1);
		notice.setPageSize(5);
		List<Notice> topNoticeList = sqlSession.getMapper(HomepageDAO.class).getNoticeList(notice);
		
		// 최신글, 공지사항, 긴 아이디 제목 처리,날짜 포맷 재설정
		for (Notice DTO : topNoticeList) {
			// 최신글
			String title = DTO.getTitle();
			Timestamp writeDate = DTO.getRegister_date();
			if(writeDate.getTime()>now.getTime()){
				title+="&nbsp;<img alt='new' src='"+contextPath+"/images/new.gif'>";
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"HH:mm:ss"));
			}else{
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"yyyy.MM.dd"));
			}
			DTO.setTitle(title);
		}
		model.addAttribute("topNoticeList",topNoticeList);
	}
	
	@Override
	public String CkeditorUpload(MultipartHttpServletRequest request, String board, String command, String type) {
		String callback = request.getParameter ("CKEditorFuncNum");
		//업로드 성공시 alert창으로 띄울 메시지 "" 이면 안뜸
		String msg = "";

		MultipartUploader mu = null;
		
		String usrUploadDir = "/resources/upload/board/"+board;
		if(type.equals("Images")){
			usrUploadDir += "/images";
			mu = new MultipartUploader(request, usrUploadDir, request.getFile("upload"),true);
		}else if(type.equals("File")){
			usrUploadDir += "/file";
			mu = new MultipartUploader(request, usrUploadDir, request.getFile("upload"),false);
		}
		
		UploadFile uploadFile = new UploadFile();
		uploadFile.setBoard_name(board);
		uploadFile.setFile_type(type);
		uploadFile.setFilesize(mu.getFileSize());
		uploadFile.setOrign_file(mu.getOriginalFileName());
		uploadFile.setSave_file(mu.getFileName());
				
		sqlSession.getMapper(HomepageDAO.class).insertuploadFile(uploadFile);
		
		String fileUrl = mu.getFileUrl();
		
		logger.info("[CkeditorUpload] - Upload:["+fileUrl+"] / 업로드 성공");
		
		// The uploaded image url returned to ckeditor
		return "<script type='text/javascript'>"+
				"window.parent.CKEDITOR.tools.callFunction("+ callback + ", '" + fileUrl + "','"+msg+"'" + ");"+
				"</script> ";
	}

	@Override
	public int insertNotice(Notice notice) {
		//제목 HTML태그 삭제
		String title = notice.getTitle();
		notice.setTitle(title.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", ""));
		return sqlSession.getMapper(HomepageDAO.class).insertNotice(notice);
	}

	@Override
	public Notice getNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session, int notice_id){
		
		Notice notice = sqlSession.getMapper(HomepageDAO.class).getNotice(notice_id);
		
		if(notice==null) return null; 

		//비회원
		if(session.getAttribute("member")==null && session.getAttribute("employee")==null){
			if(notice.getCenter_id()!=1 || notice.getState_code()==0 || (notice.getCenter_id()!=1&&notice.getState_code()==2)){ 
				notice.setError("비회원이 겁도없이 접근");
				return notice;
			}
		}else if(session.getAttribute("member")!=null){
			//회원
			Member member =(Member)session.getAttribute("member");
			
			//학생인경우 교육센터 정보 조회
			List<Integer> resultCenterId = sqlSession.getMapper(HomepageDAO.class).getLectureRegisterByMember(member.getAccount_id());


			System.out.println("게시물센터-"+notice.getCenter_id());
			System.out.println("학생센터-"+resultCenterId);
			
			//본점 추가
			resultCenterId.add(1);

			boolean pass = false;
			for(Integer centerId : resultCenterId){
				if(centerId==notice.getCenter_id()){
					pass=true;
				}
			}
			if(!pass){
				notice.setError("다른센터 학생이 교묘하게 접근");
				return notice;
			}
			
		}else if(session.getAttribute("employee")!=null){
			//직원(비밀공지)
			Employee employee = (Employee)session.getAttribute("employee");
			
			//본점 직원이 아닌경우만
			if(employee.getNow_center_id()!=1){ 
				//근무센터 조회
				if(notice.getCenter_id()!=1 && (notice.getCenter_id() != employee.getNow_center_id())){ 
					notice.setError("다른센터 직원이 일안하고 접근");
					return notice;
				}
			}
		}
		
		// 저장된 쿠키 불러오기
	    Cookie cookies[] = request.getCookies();
	    Map<String,String> mapCookie = new HashMap<String,String>();
	    if(request.getCookies() != null){
	      for (int i = 0; i < cookies.length; i++) {
	        Cookie obj = cookies[i];
	        mapCookie.put(obj.getName(),obj.getValue());
	      }
	    }
	    
	    // 저장된 쿠키중에 read_count 만 불러오기
	    String cookie_read_count = (String) mapCookie.get("read_notice");
	    // 저장될 새로운 쿠키값 생성
	    String new_cookie_read_count = notice_id+"|";
	    if(cookie_read_count==null) cookie_read_count="";
	    // 저장된 쿠키에 새로운 쿠키값이 존재하는 지 검사
	    if ( StringUtils.indexOfIgnoreCase(cookie_read_count, new_cookie_read_count) == -1 ) {
	         // 없을 경우 쿠키 생성
	         Cookie cookie = new Cookie("read_notice", cookie_read_count + new_cookie_read_count);
	         cookie.setMaxAge(60*5); // 초단위
	         response.addCookie(cookie);
	         // 조회수 업데이트
	         sqlSession.getMapper(HomepageDAO.class).countNotice(notice_id);
	         notice.setHit(notice.getHit()+1);
	    }
		return notice;
	}
	
	@Override
	public Notice getNotice(int notice_id){
		return sqlSession.getMapper(HomepageDAO.class).getNotice(notice_id);
	}

	@Override
	public int updateNotice(Notice notice) {
		//제목 HTML태그 삭제
		String title = notice.getTitle();
		notice.setTitle(title.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", ""));
		
		return sqlSession.getMapper(HomepageDAO.class).updateNotice(notice);
	}

	@Override
	public int deleteNotice(int notice_id) {
		return sqlSession.getMapper(HomepageDAO.class).deleteNotice(notice_id);
	}


	@Override
	public int insertQuestion(Qna question) {
		//제목 HTML태그 삭제
		String title = question.getTitle();
		question.setTitle(title.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", ""));
		return sqlSession.getMapper(HomepageDAO.class).insertQna(question);
	}

	@Override
	public void getQnaList(Qna qna, HttpSession session, Model model, String contextPath) {
		
		if(qna.getSearchKey()!=null && !qna.getSearchKey().equals(""))
			logger.info("[getQnaList] - SearchType:["+qna.getSearchType()+"] SearchKey:["+qna.getSearchKey()+"] / 검색");
		
		//기본값 설정
		if(qna.getPageNum()==0) qna.setPageNum(1);
		if(qna.getPageSize()==0) qna.setPageSize(10);
		if(qna.getSearchType()==null || qna.getSearchType().equals("")) qna.setSearchType("title");
		if(qna.getSearchKey()==null || qna.getSearchKey().equals("")) qna.setSearchKey("");
		
			
		// 현 페이지 정보
		int pageNum = qna.getPageNum();
		int pageSize = qna.getPageSize();
		
		int start = pageNum * pageSize - (pageSize -1)-1;
		qna.setStartNum(start);
		
		//게시물 리스트 출력
		List<Qna> qnaList = sqlSession.getMapper(HomepageDAO.class).getQnaList(qna);
		
		// 검색된 총 게시물 건수
		int qnaListCount = sqlSession.getMapper(HomepageDAO.class).getQnaListCount(qna);
		
		model.addAttribute("qnaListCount", qnaListCount);
		
		// 페이징 처리		
		int visiblePageNum = 10;
		int pagecount = 0;
		int beginPage = 0;
		int endPage = 0;
		if (qnaListCount != 0) {// 게시물이 없는 경우
			pagecount = qnaListCount / pageSize;// 115건 = 11page
			if (qnaListCount % pageSize > 0) {// 115건 = 나머지 5 true
				pagecount++;// 11page++ = 12page
			}
			beginPage = (pageNum - 1) / visiblePageNum * visiblePageNum + 1;// 10단위 계산
			endPage = beginPage + (visiblePageNum - 1);
			if (endPage > pagecount) {
				endPage = pagecount;
			}
		}

		
		// view에 보낼 데이터
		model.addAttribute("pagecount", pagecount);
		model.addAttribute("beginpage", beginPage);
		model.addAttribute("endpage", endPage);

		model.addAttribute("pageNum",pageNum);
		model.addAttribute("pageSize",pageSize);

		model.addAttribute("searchType",qna.getSearchType());

		//검색어가 없는경우 재처리
		if(qna.getSearchKey().equals("")) qna.setSearchKey("[noKeyword]");
		model.addAttribute("searchKey",qna.getSearchKey());

		
		// 최신글, 공지사항, 긴 아이디 제목 처리,날짜 포맷 재설정
		Date now = new Date();//현재 시간
		int n = 24;			//n시간전으로 설정
		now.setTime(now.getTime()-1000*60*60*n);
		for (Qna DTO : qnaList) {
			

			// 제목 영문 기준 50자 길이로 처리
			String title = DTO.getTitle();
			title = myStringUtils.getFixString(title, 50);
			
			// 7자 초과 닉네임
			String name_kor = DTO.getName_kor();
			if (name_kor != null && name_kor.length() > 7) {
				name_kor = name_kor.substring(0, 7) + "..";
			}
			DTO.setName_kor(name_kor);


			// 비밀글
			if(DTO.getState_code()==0){
				title ="<i class='fa fa-lock'></i>"+ title;
			}

			// 답글
			if(DTO.getDivide_code()=='A'){
				title ="<img alt='new' src='"+contextPath+"/images/re.gif'>&nbsp;"+ title;
			}
			
			
			// 구분코드 변환
			DTO.setDivide_code_toString(String.valueOf(DTO.getDivide_code()));
			
			// 최신글
			Timestamp writeDate = DTO.getRegister_date();
			if(writeDate.getTime()>now.getTime()){
				title+="&nbsp;<img alt='new' src='"+contextPath+"/images/new.gif'>";
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"HH:mm:ss"));
			}else{
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"yyyy.MM.dd"));
			}
			DTO.setTitle(title);
		}
		model.addAttribute("qnaList",qnaList);
		
		/*

		//상단 고정 자주 묻는 질문
		qna.setState_code(1);
		qna.setSearchType(null);
		qna.setSearchKey(null);
		qna.setStartNum(0);
		qna.setPageNum(1);
		//10개만 노출
		qna.setPageSize(10);
		//조회수 기준
		qna.setHit(10);
		
		List<Qna> topQnaList = sqlSession.getMapper(HomepageDAO.class).getQnaList(qna);
		
		// 최신글, 공지사항, 긴 아이디 제목 처리,날짜 포맷 재설정
		for (Qna DTO : topQnaList) {
			// 최신글
			String title = DTO.getTitle();
			Timestamp writeDate = DTO.getRegister_date();
			if(writeDate.getTime()>now.getTime()){
				title+="&nbsp;<img alt='new' src='"+contextPath+"/images/new.gif'>";
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"HH:mm:ss"));
			}else{
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"yyyy.MM.dd"));
			}
			DTO.setTitle(title);
		}
		model.addAttribute("topQnaList",topQnaList);*/
	}

	@Override
	public Qna getQna(HttpServletRequest request, HttpServletResponse response,HttpSession session,int qna_id) {
		
		Qna qna = sqlSession.getMapper(HomepageDAO.class).getQna(qna_id);
		
		if(qna==null) return null; 
		
		qna.setDivide_code_toString(String.valueOf(qna.getDivide_code()));
		
		// 비공개 답변 글그룹의 원본글 찾기
		if(qna.getState_code()==0 && qna.getDivide_code()=='A'){
			Qna oriQuestion = sqlSession.getMapper(HomepageDAO.class).getQna(qna.getGroup_no());
			
			//비회원
			if(session.getAttribute("member")==null && session.getAttribute("employee")==null){
				qna.setError("비회원이 겁도없이 접근");
				return qna;
			}else if(session.getAttribute("member")!=null){
				//회원
				Member member =(Member)session.getAttribute("member");
				if(member.getAccount_id()!=oriQuestion.getAccount_id()){
					qna.setError("작성자가 아닌데 교묘하게 접근");
					return qna;
				}
			}
		}
		
		if(qna.getState_code()==0 && qna.getDivide_code()=='Q'){
			//비회원
			if(session.getAttribute("member")==null && session.getAttribute("employee")==null){
				qna.setError("비회원이 겁도없이 접근");
				return qna;
			}else if(session.getAttribute("member")!=null){
				//회원
				Member member =(Member)session.getAttribute("member");
				if(member.getAccount_id()!=qna.getAccount_id()){
					qna.setError("작성자가 아닌데 교묘하게 접근");
					return qna;
				}
			}
		}
		
		// 저장된 쿠키 불러오기
	    Cookie cookies[] = request.getCookies();
	    Map<String,String> mapCookie = new HashMap<String,String>();
	    if(request.getCookies() != null){
	      for (int i = 0; i < cookies.length; i++) {
	        Cookie obj = cookies[i];
	        mapCookie.put(obj.getName(),obj.getValue());
	      }
	    }
	    
	    // 저장된 쿠키중에 read_count 만 불러오기
	    String cookie_read_count = (String) mapCookie.get("read_qna");
	    // 저장될 새로운 쿠키값 생성
	    String new_cookie_read_count = qna_id+"|";
	    if(cookie_read_count==null) cookie_read_count="";
	    // 저장된 쿠키에 새로운 쿠키값이 존재하는 지 검사
	    if ( StringUtils.indexOfIgnoreCase(cookie_read_count, new_cookie_read_count) == -1 ) {
	         // 없을 경우 쿠키 생성
	         Cookie cookie = new Cookie("read_qna", cookie_read_count + new_cookie_read_count);
	         cookie.setMaxAge(60*5); // 초단위
	         response.addCookie(cookie);
	         // 조회수 업데이트
	         sqlSession.getMapper(HomepageDAO.class).countQna(qna_id);
	         qna.setHit(qna.getHit()+1);
	    }
		return qna;
	}

	@Override
	public Qna getQna(int qna_id) {
		Qna qna = sqlSession.getMapper(HomepageDAO.class).getQna(qna_id);
		qna.setDivide_code_toString(String.valueOf(qna.getDivide_code()));
		return qna;
	}

	@Override
	public int updateQna(Qna qna) {
		//제목 HTML태그 삭제
		String title = qna.getTitle();
		qna.setTitle(title.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", ""));
		
		return sqlSession.getMapper(HomepageDAO.class).updateQna(qna);
	}

	@Override
	public int deleteQna(int qna_id) {
		return sqlSession.getMapper(HomepageDAO.class).deleteQna(qna_id);
	}

	@Override
	public int insertAnswer(Qna answer) {
		//제목 HTML태그 삭제
		String title = answer.getTitle();
		answer.setTitle(title.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", ""));
		return sqlSession.getMapper(HomepageDAO.class).insertQna(answer);
	}

	@Override
	public Map<String,Number> getUploadFileSumFilesize() {
		HashMap<String,Number> map = new HashMap<String, Number>();
		map.put("totalFileSize", sqlSession.getMapper(HomepageDAO.class).getTotalFileSize());
		map.put("totalImageSize", sqlSession.getMapper(HomepageDAO.class).getTotalImageSize());
		return map;
	}
	
}
