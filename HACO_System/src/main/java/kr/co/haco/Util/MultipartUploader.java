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
	private String fileUrl;
	private String filePath;
	private String fileName;
	private String originalFileName;
	private long fileSize;
	
	public String getFileUrl() {
		return fileUrl;
	}

	public String getFilePath() {
		return filePath;
	}

	public String getFileName() {
		return fileName;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public long getFileSize() {
		return fileSize;
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
		
		
		// 원본 파일명
		 originalFileName = multipartFile.getOriginalFilename();
		 
		// 저장 파일명
		String targetFileName = originalFileName;
		
		// 이름 재설정
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

		//리턴 파라메터 설정
		this.fileUrl = contextURL + usrUploadDir + "/" + targetFileName;
		this.filePath = savedFilePath;
		this.fileName = targetFileName;
		this.fileSize = multipartFile.getSize();
	}
}
