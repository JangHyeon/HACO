package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.HomepageDAO;
import kr.co.haco.Util.MultipartUploader;
import kr.co.haco.VO.Notice;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class HomepageServiceImpl implements HomepageService {

	@Autowired
	SqlSession sqlSession;
	

	@Override
	public int getNoticeListCount(Notice notice) {
		return sqlSession.getMapper(HomepageDAO.class).getNoticeListCount(notice);
	}
	
	@Override
	public List<Notice> getNoticeList(Notice notice) {
		return sqlSession.getMapper(HomepageDAO.class).getNoticeList(notice);
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
		
		// The uploaded image url returned to ckeditor
		return "<script type='text/javascript'>"+
				"window.parent.CKEDITOR.tools.callFunction("+ callback + ", '" + fileUrl + "','"+msg+"'" + ");"+
				"</script> ";
	}

	@Override
	public int insertNotice(Notice notice) {
		return sqlSession.getMapper(HomepageDAO.class).insertNotice(notice);
	}

	
}
