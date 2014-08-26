package kr.co.haco.Util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public class MultipartUploader {
	public String fileUrl = "";
	public String filePath = "";
	public String fileName = "";

	public String getFileUrl() {
		return fileUrl;
	}

	public String getFilePath() {
		return filePath;
	}

	public String getFileName() {
		return fileName;
	}

	public MultipartUploader(HttpServletRequest request, String usrUploadDir,
			MultipartFile multipartFile, boolean Rename) {
		
		// 저장 경로
				String targetPath = request.getSession().getServletContext().getRealPath("")
						+ usrUploadDir.replace("/", File.separator);

		// 저장 경로 폴더 생성
		File targetPathDir = new File(targetPath);
		if (!targetPathDir.exists())
			targetPathDir.mkdirs();
		
		
		// 업로드 파일명
		String originalFileName = multipartFile.getOriginalFilename();
		// 저장 파일명
		String targetFileName = originalFileName;
		if(Rename){
			targetFileName = UUID.randomUUID().toString().replace("-", "")
					+ "."
					+ originalFileName.substring(
							originalFileName.lastIndexOf(".") + 1,
							originalFileName.length()).toLowerCase();
		}
		
		
		String savedFilePath = targetPathDir + File.separator + targetFileName;
		
		//중복 파일명 처리
		File newfile = new File(savedFilePath);
		if(newfile.exists()){
			System.out.println("파일이 중복됨");
			targetFileName = System.currentTimeMillis()+"-"+targetFileName;
			savedFilePath = targetPathDir + File.separator + targetFileName;
		}
		System.out.println(savedFilePath);
		InputStream in = null;
		OutputStream out = null;

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

		// 사이트 루트 경로
		StringBuffer contextURL = request.getRequestURL();
		contextURL = contextURL.replace(contextURL.lastIndexOf("/"),
				contextURL.length(), "");

		// String fileUrl =
		// contextURL+StringUtils.replace(usrUploadDir+"/"+targetFileName, "//",
		// "/");

		//경로 숨김
		usrUploadDir = usrUploadDir.replaceAll("/resources", "");
		
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fileUrl", contextURL + usrUploadDir + "/" + targetFileName);
		map.put("filePath", savedFilePath);
		map.put("fileName", targetFileName);

		this.fileUrl = map.get("fileUrl");
		this.filePath = map.get("filePath");
		this.fileName = map.get("fileName");
	}

	/*public HashMap<String, String> uploadFile(HttpServletRequest request,
			String usrUploadDir, MultipartFile multipartFile) {

		// 업로드 파일명
		String originalFileName = multipartFile.getOriginalFilename();
		// 저장 파일명
		String targetFileName = UUID.randomUUID().toString().replace("-", "")
				+ "."
				+ originalFileName.substring(
						originalFileName.lastIndexOf(".") + 1,
						originalFileName.length()).toLowerCase();
		// 저장 경로
		String targetPath = request.getSession().getServletContext()
				.getRealPath("")
				+ usrUploadDir.replace("/", File.separator);

		// 저장 경로 폴더 생성
		File targetPathDir = new File(targetPath);
		if (!targetPathDir.exists())
			targetPathDir.mkdir();

		String savedFilePath = targetPathDir + File.separator + targetFileName;

		InputStream in = null;
		OutputStream out = null;

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

		// 사이트 루트 경로
		StringBuffer contextURL = request.getRequestURL();
		contextURL = contextURL.replace(contextURL.lastIndexOf("/"),
				contextURL.length(), "");

		// String fileUrl =
		// contextURL+StringUtils.replace(usrUploadDir+"/"+targetFileName, "//",
		// "/");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fileUrl", contextURL + usrUploadDir + "/" + targetFileName);
		map.put("filePath", savedFilePath);
		map.put("fileName", targetFileName);

		this.fileUrl = map.get("fileUrl");
		this.filePath = map.get("filePath");
		this.fileName = map.get("fileName");

		return map;
	}*/
}
