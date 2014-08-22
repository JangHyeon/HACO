package kr.co.haco.Service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import kr.co.haco.DAO.HomepageDAO;
import kr.co.haco.Util.MultipartUploader;
import kr.co.haco.Util.StringUtils;
import kr.co.haco.Util.DateUtil;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.Notice;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class HomepageServiceImpl implements HomepageService {

	@Autowired
	SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(HomepageServiceImpl.class);


	@Override
	public void getNoticeList(Notice notice, HttpSession session, Model model) {
		
		//비회원
		if(session.getAttribute("member")==null && session.getAttribute("employee")==null){
			notice.setCenter_id(1);
		}else if(session.getAttribute("member")!=null){ //회원
			Member member =(Member)session.getAttribute("member");
			
			//학생
			List<Integer> resultCenterId = sqlSession.getMapper(HomepageDAO.class).getLectureRegisterByMember(member.getAccount_id());
			String center_list = resultCenterId.toString().substring(1, resultCenterId.toString().length()-1);

			notice.setCenter_list(center_list);
		}else if(session.getAttribute("employee")!=null){//직원(비밀공지)
			Employee employee = (Employee)session.getAttribute("employee");
			
			notice.setCenter_list(employee.getNow_center_id()+"");
			notice.setState_code(99); //비밀글 코드 0이지만 int형 기본갑이 0이라 99값을 신호로 보냄
		}
		

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

		model.addAttribute("pagecount", pagecount);
		model.addAttribute("beginpage", beginPage);
		model.addAttribute("endpage", endPage);

		model.addAttribute("pageNum",pageNum);
		model.addAttribute("pageSize",pageSize);


		Date now = new Date();//현재 시간
		int n = 24;			//n시간전으로 설정
		now.setTime(now.getTime()-1000*60*60*n);
		for (Notice DTO : noticeList) {
			

			// 제목 영문 기준 50자 길이로 처리
			String title = DTO.getTitle();
			title = StringUtils.getFixString(title, 50);
			
			// 7자 초과 닉네임
			String name_kor = DTO.getName_kor();
			if (name_kor != null && name_kor.length() > 7) {
				name_kor = name_kor.substring(0, 7) + "..";
			}
			DTO.setName_kor(name_kor);
			

			//직원공지글
			if(DTO.getState_code()==0){
				title+="&nbsp;<span class='label label-info'>직원 공지</span>";			}
			
			// 최신글
			Timestamp writeDate = DTO.getRegister_date();
			if(writeDate.getTime()>now.getTime()){
				title+="&nbsp;<img alt='new' src='images/new.gif'>";
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
		notice.setCenter_list(null);
		notice.setStartNum(0);
		notice.setPageNum(1);
		notice.setPageSize(5);
		List<Notice> topNoticeList = sqlSession.getMapper(HomepageDAO.class).getNoticeList(notice);
		for (Notice DTO : topNoticeList) {
			// 최신글
			String title = DTO.getTitle();
			Timestamp writeDate = DTO.getRegister_date();
			if(writeDate.getTime()>now.getTime()){
				title+="&nbsp;<img alt='new' src='images/new.gif'>";
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"HH:mm:ss"));
			}else{
				DTO.setRegister_date_string(DateUtil.formatDateTimeToString(DTO.getRegister_date(),"yyyy.MM.dd"));
			}
			DTO.setTitle(title);
		}
		model.addAttribute("topNoticeList",topNoticeList);
	}
	
	
	
	@Override
	public String noticeUpload(MultipartHttpServletRequest request) {
		String callback = request.getParameter ("CKEditorFuncNum");
		//업로드 성공시 alert창으로 띄울 메시지 "" 이면 안뜸
		String msg = "";

		MultipartUploader mu = null;
		
		String usrUploadDir = "/resources/upload/board/notice";
		if(request.getParameter("type").equals("Images")){
			usrUploadDir += "/images";
			mu = new MultipartUploader(request, usrUploadDir, request.getFile("upload"),true);
		}else if(request.getParameter("type").equals("File")){
			usrUploadDir += "/file";
			mu = new MultipartUploader(request, usrUploadDir, request.getFile("upload"),false);
		}
		
		
		String fileUrl = mu.getFileUrl();
		
		logger.info("[Notice] - Upload:["+fileUrl+"] / 업로드 성공");
		
		// The uploaded image url returned to ckeditor
		return "<script type='text/javascript'>"+
				"window.parent.CKEDITOR.tools.callFunction("+ callback + ", '" + fileUrl + "','"+msg+"'" + ");"+
				"</script> ";
	}

	@Override
	public int insertNotice(Notice notice) {
		return sqlSession.getMapper(HomepageDAO.class).insertNotice(notice);
	}

	@Override
	public Notice getNotice(int notice_id){
		return sqlSession.getMapper(HomepageDAO.class).getNotice(notice_id);
	}

	@Override
	public int updateNotice(Notice notice) {
		return sqlSession.getMapper(HomepageDAO.class).updateNotice(notice);
	}
}
