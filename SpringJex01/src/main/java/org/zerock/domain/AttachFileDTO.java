package org.zerock.domain;

import lombok.Data;

//브라우저로 전송해야하는 데이터를 객체화하기 위한 클래스
@Data
public class AttachFileDTO {
	
	private String fileName; //파일명 
	private String uploadPath; //업로드 경로
	private String uuid; //uuid값
	private boolean image; //이미지여부
	
}
