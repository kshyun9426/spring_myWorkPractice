package org.zerock.domain;

import lombok.Data;

//�������� �����ؾ��ϴ� �����͸� ��üȭ�ϱ� ���� Ŭ����
@Data
public class AttachFileDTO {
	
	private String fileName; //���ϸ� 
	private String uploadPath; //���ε� ���
	private String uuid; //uuid��
	private boolean image; //�̹�������
	
}
