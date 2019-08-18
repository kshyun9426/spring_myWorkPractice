package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "C:\\uploadEx";
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("--------------------------------------");
			log.info("Upload name: " + multipartFile.getName());
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(IOException ex1) {
				ex1.getStackTrace();
			}catch(IllegalStateException ex2) {
				ex2.getStackTrace();
			}		
		}
		
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	@PostMapping(value="/uploadAjaxAction", produces= MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("update ajax post.............");
		
		List<AttachFileDTO> uploadFileList = new ArrayList<>();
		String uploadFolder = "C:\\uploadEx";
		String uploadFolderPath = getFolderName();
		
		//make folder---------------------(�� �������� �ʹ� ���� ������ ���� ���� �ذ��� ����)
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path: " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			//logging on server
			log.info("--------------------------------");
			log.info("upload File Name: " + multipartFile.getOriginalFilename());
			log.info("upload File Size: " + multipartFile.getSize());
			
			AttachFileDTO dto = new AttachFileDTO();
			String uploadFileName = multipartFile.getOriginalFilename();
			
			dto.setFileName(uploadFileName);
			
			//IE has file path, 파일명만 가져오기 위한 작업
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			//업로드 파일 이름의 중복방지를 위한 UUID생성과 파일이름과 결합
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName; //원래의 파일과 구분할 수 있게 _로 연결
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try { 
				multipartFile.transferTo(saveFile);
				
				dto.setUuid(uuid.toString());
				dto.setUploadPath(uploadFolderPath);
				
				//check image type file
				if(checkImageType(saveFile)) {
					//�̹��� �����̶�� ������ �̹���(s_�� �����ϴ�)�� �����ؼ� ����
					FileOutputStream thumbnailFile = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnailFile, 100, 100);
					dto.setImage(true);
					thumbnailFile.close();
				}
				uploadFileList.add(dto);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(uploadFileList, HttpStatus.OK);
	}
	
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			if(contentType.startsWith("image")) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	private String getFolderName() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date todayDate = new Date();
		
		String str = sdf.format(todayDate);
		
		return str.replace("-", File.separator);
	}
	
	
	@GetMapping(value="/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName: " + fileName);
		
		File file = new File("C:\\uploadEx\\" + fileName);
		
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//파일 다운로드요청 controller	
	@GetMapping(value="/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent")String userAgent, String fileName){
		
		log.info("download file: " + fileName);
		Resource resource = new FileSystemResource("C:\\uploadEx\\" + fileName);
		log.info("resource: " + resource);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			
			String downloadName = null;
			
			if(userAgent.contains("Trident") || userAgent.contains("MSIE")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");	//IE에서는 공백을 +로 처리하기 때문에 +를 공백으로 변경
			}else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				log.info("Edge name: " + downloadName);
			}else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}
			
			log.info("downloadName: " + downloadName);
			//attachment는 다운로드, inline은 웹페이지에 보여줌
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
//			headers.add("Content-Disposition", "inline; filename="+new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		//일반 파일이면 파일만 지우면됨 근데 이미지 파일이면 썸네일이미지와 일반이미지 두개를 삭제
		
		log.info("deleteFile: " + fileName);
		File file = null;
		
		try {
			//일반 파일인 경우 삭제, 이미지의 썸네일파일 삭제
			file = new File("C:\\uploadEx\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if(type.equals("image")) { //�̹����������� ����
				String originFileName = file.getAbsolutePath().replace("s_", "");
				log.info("deleted originImageName: " + originFileName);
				file = new File(originFileName);
				file.delete();
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<>("deleted", HttpStatus.OK);
	}
	
}
























