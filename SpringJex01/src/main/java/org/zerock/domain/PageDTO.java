package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;//(pageNum, amount)
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * cri.getAmount();
		this.startPage = endPage - (cri.getAmount() - 1);
		
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount())); //진짜 마지막 페이지번호
		if(realEnd < this.endPage)
			this.endPage = realEnd;
		
		this.prev = startPage > 1;
		this.next = this.endPage < realEnd;
	}
}


















