package kr.co.haco.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.haco.Service.HomepageService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileController {

	@Autowired
	HomepageService homepageService;
	
	// 첨부파일
	/*
	스프링에서 @ResponseBody로 문자열을 반환 시 디폴트로 ISO-8859-1를 사용한다.
	이를 변경하기 위해 @RequestMapping의 produces 속성을 다음과 같이 설정할 수 있다.
	Response 사용시 returnString 값이 script라면 text/html를 사용하고 단순 text라면 text/plain을 사용한다.
	*/
	@RequestMapping(value = "/ckUpload/board/{board}/command/{command}/type/{type}", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String ckUpload(MultipartHttpServletRequest request,
			@PathVariable String board,
			@PathVariable String command,
			@PathVariable String type) {
		return homepageService.CkeditorUpload(request,board,command,type);
	}
	
	// 다운로드
	@RequestMapping(value = "/upload/board/{boardName}/file/{fileName:.+}")
	public String download(
            @PathVariable String boardName,
            @PathVariable String fileName,
            HttpServletResponse response,
            HttpServletRequest request){
		
		try{
	
			//다운로드 기본 설정 (브라우져가 read 하지 않고 ... 다운 )
			//요청 - 응답 간에 헤더정보에 설정을 강제 다운로드
			String userAgent = request.getHeader("User-Agent");
			
			if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1) {   // MS IE 브라우저에서 한글 인코딩
			   response.setHeader("Content-Disposition", "attachment; filename="
			   + java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ ") + ";");
			} else {                                                                     // 모질라나 오페라 브라우저에서 한글 인코딩​
				response.setHeader("Content-Disposition",
				"attachment; filename=" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1").replaceAll("\\+", "\\ ") + ";");
			}
			//파일명 전송 
			//파일 내용전송
			String fullpath = request.getSession().getServletContext().getRealPath("/resources/upload/board/" + boardName + "/file/" + fileName).replace("/", File.separator);
			FileInputStream fin = new FileInputStream(fullpath);
			//출력 도구 얻기 :response.getOutputStream()
			ServletOutputStream sout = response.getOutputStream();
			byte[] buf = new byte[1024]; //전체를 다읽지 않고 1204byte씩 읽어서
			int size = 0;
			while((size=fin.read(buf,0,buf.length)) != -1) //buffer 에 1024byte 담고
			{                                              //마지막 남아있는 byte 담고  그다음 없으면 탈출
				sout.write(buf, 0, size); //1kbyte씩 출력 
			}
			fin.close();
			sout.close();
		
		}catch(IOException e){
			System.out.println(e.getMessage());
			return "redirect:/error/FileNotFound";
		}
		return null;
	}
}
