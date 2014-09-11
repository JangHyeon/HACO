package kr.co.haco.Service;

import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;


public interface ManagementService {
	public Map<String, String> photoUpload(MultipartHttpServletRequest req);
	
	public Map<String, Object> getIndexInfo();
}
