package kr.co.haco.Service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.haco.VO.Notice;
import kr.co.haco.VO.Qna;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;


public interface ManagementService {
	public Map<String, String> photoUpload(MultipartHttpServletRequest req);
	
	public Map<String, Object> getIndexInfo();
}
