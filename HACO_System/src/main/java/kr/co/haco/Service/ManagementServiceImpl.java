package kr.co.haco.Service;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.haco.DAO.AccountDAO;
import kr.co.haco.DAO.HomepageDAO;
import kr.co.haco.Util.ImageJ;
import kr.co.haco.Util.MultipartUploader;
import kr.co.haco.VO.Notice;
import kr.co.haco.VO.UploadFile;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class ManagementServiceImpl implements ManagementService {

	@Autowired
	SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(ManagementServiceImpl.class);

	@Override
	public Map<String, String> photoUpload(MultipartHttpServletRequest req) {

		MultipartFile multipartFile = req.getFile("file");
		String usrUploadDir = "/resources/upload/employeePhoto"; // 저장 폴더명

		MultipartUploader mu = new MultipartUploader(req, usrUploadDir,
				multipartFile, true);

		String result = ImageJ.photoCropAndResize(mu.getFilePath(), 177, 236);
		logger.info("[photoUpload] - result:["+result+"] / 직원사진업로드");

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
	public Map<String, Object> getIndexInfo() {
		HashMap<String, Object> map = new HashMap<String,Object>();
		//상단 인원정보
		map.put("totalMemberNumber", sqlSession.getMapper(HomepageDAO.class).getTotalMemberNumber());
		map.put("totalStudentNumber", sqlSession.getMapper(HomepageDAO.class).getTotalStudentNumber());
		map.put("newStudentNumber", sqlSession.getMapper(HomepageDAO.class).getNewStudentNumber());
		map.put("newEmployeeNumber", sqlSession.getMapper(HomepageDAO.class).getNewEmployeeNumber());
		map.put("newNoticeNumber", sqlSession.getMapper(HomepageDAO.class).getNewNoticeNumber());
		map.put("newQnaNumber", sqlSession.getMapper(HomepageDAO.class).getNewQnaNumber());
		
		//답변을 기다리는 질문
		map.put("waitAnswerList", sqlSession.getMapper(HomepageDAO.class).getWaitAnswerList());
		map.put("pageSize", 10);
		map.put("pageNum", 1);
		map.put("searchType", "title");
		map.put("searchKey", "[noKeyword]");
		
		//우수강사
		if(sqlSession.getMapper(HomepageDAO.class).ExistBestTeacher()!=0){
			int bestTeacher_id = sqlSession.getMapper(HomepageDAO.class).getBestTeacher();
			map.put("bestTeacher", sqlSession.getMapper(AccountDAO.class).getEmployee(String.valueOf(bestTeacher_id)));
			
			//인센티브
			int incentive = sqlSession.getMapper(HomepageDAO.class).getBestIncentive(bestTeacher_id);
			
			NumberFormat nf = NumberFormat.getNumberInstance();
			map.put("bestIncentive",nf.format(incentive/100));
			map.put("bestIncentiveStack",nf.format(incentive/200*3));
		}
		
		
		//사용량 차트
		map.put("totalFileSize", sqlSession.getMapper(HomepageDAO.class).getTotalFileSize());
		map.put("totalImageSize", sqlSession.getMapper(HomepageDAO.class).getTotalImageSize());
		
		//지난 7개월간 수강생 차트
		map.put("past7mouthsList", sqlSession.getMapper(HomepageDAO.class).getPast7monthsList());
		
		List<Map<String, Object>> list = (List<Map<String, Object>>) sqlSession.getMapper(HomepageDAO.class).getPast7monthsList(); 
		
		ArrayList<String> label = new ArrayList<String>();
		ArrayList<Object> data = new ArrayList<Object>();
		for(Map<String, Object> m : list){
			label.add((String) m.get("mouth"));
			data.add(m.get("counts"));
		}
		JSONArray jsonLabel = new JSONArray(label);
		JSONArray jsonData = new JSONArray(data);
		
		map.put("jsonLabel", jsonLabel.toString().replace("\"", "'"));
		map.put("jsonData", jsonData.toString());
		
		//최신 직원 공지사항5개
		Notice notice = new Notice();
		notice.setState_code(77);
		notice.setCenter_id(1);
		notice.setPageSize(5);
		notice.setPageNum(1);
		map.put("newEmployeeNoticeList", sqlSession.getMapper(HomepageDAO.class).getEmployeeNoticeList(notice));
		
		//신규 직원 5명
		map.put("newEmployeeList", sqlSession.getMapper(HomepageDAO.class).getNewEmployeeList());
		
		return map;
	}
}
