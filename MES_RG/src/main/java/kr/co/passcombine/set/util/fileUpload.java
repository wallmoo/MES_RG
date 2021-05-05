package kr.co.passcombine.set.util;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.swing.ImageIcon;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class fileUpload {
	
	 public static Map<String, Object> saveFile(MultipartFile multipartFile, String basePath,
			 MultipartHttpServletRequest request) {
			String paths = basePath;
			basePath = request.getRealPath("/upload");
		 	HashMap<String,Object> resultMap = new HashMap<String,Object>();
			 // input form's parameter name
	        String fileName = "";
	        // original file name
	        String originalFileName = multipartFile.getOriginalFilename();
	        // file content type
	        String contentType = multipartFile.getContentType();
	        // file size
	        long fileSize = multipartFile.getSize();

	        System.out.println("fileSize: " + fileSize);
	        System.out.println("originalFileName: " + originalFileName);

	        InputStream inputStream = null;
	        OutputStream outputStream = null;

	        try {
	            if( fileSize > 0 ) { // 파일이 존재한다면
	                // 인풋 스트림을 얻는다.
	                inputStream = multipartFile.getInputStream();
	                File oldfile = new File(basePath, originalFileName);
	                if ( oldfile.exists()){
	                    for(int k=0; true; k++){
	                        //파일명 중복을 피하기 위한 일련 번호를 생성하여
	                        //파일명으로 조합
	                        oldfile = new File(basePath,"("+k+")"+originalFileName);
	                        //조합된 파일명이 존재하지 않는다면, 일련번호가
	                        //붙은 파일명 다시 생성
	                        if(!oldfile.exists()){ //존재하지 않는 경우
	                            fileName = "("+k+")"+originalFileName;
	                            break;
	                        }
	                    }
	                }else{
	                    fileName = originalFileName;
	                }

	                //make server full path to save
	                String serverFullPath = basePath + "\\" + fileName;

	                System.out.println("fileName: " + fileName);
	                System.out.println("serverFullPath: " + serverFullPath);

	                outputStream = new FileOutputStream( serverFullPath );

	                // 버퍼를 만든다.
	                int readBytes = 0;
	                byte[] buffer = new byte[8192];

	                while((readBytes = inputStream.read(buffer, 0, 8192)) != -1 ) {
	                    outputStream.write( buffer, 0, readBytes );
	                }

	                outputStream.close();
	                inputStream.close();

	                String CMM_FLE_ATT_EXT =fileName.substring(fileName.lastIndexOf(".")+1);
	              //파일정보 MAP에담기
	                resultMap.put("CMM_FLE_SYS_PATH",request.getRealPath(""));
			        resultMap.put("CMM_FLE_ATT_PATH",paths);
			        resultMap.put("CMM_FLE_ORG_NM",originalFileName);
			        resultMap.put("CMM_FLE_SYS_NM",fileName);
			        resultMap.put("CMM_FLE_ATT_SIZE",fileSize);
			        resultMap.put("CMM_FLE_ATT_EXT",CMM_FLE_ATT_EXT);
			        resultMap.put("CMM_FLE_USE_YN",'Y');
			        resultMap.put("CMM_FLE_DEL_YN",'N');
	            }
		        
	  	      

	        } catch(Exception e) {
	            e.printStackTrace();  
	        }finally{

	        }

	        

	        
	        return resultMap;

	    }
	public static void delFile(MultipartHttpServletRequest request, Map<String, Object> result) {
		String paths = request.getRealPath((String)result.get("CMM_FLE_ATT_PATH"))+"\\"+(String)result.get("CMM_FLE_SYS_NM");
		File file = new File(paths);
		if(file.exists()) {
			if(file.delete()) {
				System.out.println("파일삭제 성공");
			}else {
				System.out.println("파일삭제실패");
			}
		}
	}
	public static void delFile(HttpServletRequest request, Map<String, Object> result) {
		String paths = request.getRealPath((String)result.get("CMM_FLE_ATT_PATH"))+"\\"+(String)result.get("CMM_FLE_SYS_NM");
		File file = new File(paths);
		if(file.exists()) {
			if(file.delete()) {
				System.out.println("파일삭제 성공");
			}else {
				System.out.println("파일삭제실패");
			}
		}
	}
	 
}
