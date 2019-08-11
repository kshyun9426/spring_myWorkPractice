package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
	
	private int replyCnt; //각 게시글의 댓글 총갯수
	private List<ReplyVO> list; //댓글 리스트
	
}
