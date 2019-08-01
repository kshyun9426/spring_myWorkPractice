package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum; //페이지 번호
	private int amount; //한 페이지당 몇개의 데이터
	
	public Criteria() {
		this(1, 10); //기본으로 첫페이지와 페이지당 10개의 데이터로 설정
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
