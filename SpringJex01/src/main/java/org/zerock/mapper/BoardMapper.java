package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardMapper {
	
	//회원들 Get
	public List<BoardVO> getList(); 
	
	//회원 정보 insert
	public void insert(BoardVO board);
	
	//회원 정보 insert(pk값을 가져와서 삽입작업함)
	public void insertSelectKey(BoardVO board);
	
	//회원 읽어오기
	public BoardVO read(Long bno);
	
	//회원 정보 삭제
	public int delete(Long bno);
	
	//회원 수정
	public int update(BoardVO board);
	
}
