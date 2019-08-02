package org.zerock.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class})
@Log4j
public class BoardMapperTests {
	
	@Autowired
	private BoardMapper boardMapper;
	
//	@Test
//	public void testGetList() {
//		boardMapper.getList().forEach(vo->log.info(vo));
//	}
	
//	@Test
//	public void testInsert() {
//		BoardVO board = new BoardVO();
//		board.setContent("테스트6");
//		board.setTitle("테스트제목6");
//		board.setWriter("user06");
//		
//		boardMapper.insert(board);
//		log.info(board);
//		
//	}
	
//	@Test
//	public void testInsertSelectKey() {
//		BoardVO board = new BoardVO();
//		board.setContent("새로 작성하는 내용 select Key");
//		board.setTitle("새록 작성하는 제목 select Key");
//		board.setWriter("user07");
//		
//		boardMapper.insertSelectKey(board);
//		log.info(board);
//	}
	
//	@Test
//	public void testRead() {
//		log.info(boardMapper.read(7L));
//	}
	
//	@Test
//	public void testDelete() {
//		log.info("Deleted count: " + boardMapper.delete(3L));	
//	}
	
//	@Test
//	public void testUpdate() {
//		BoardVO board = new BoardVO();
//		board.setBno(1L);
//		board.setContent("수정된 내용1");
//		board.setTitle("수정된 제목1");
//		board.setWriter("updated user1");
//		
//		log.info(boardMapper.update(board));
//	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<BoardVO> list = boardMapper.getListWithPaging(cri);
		
		list.forEach(board->log.info(board));
	}
	
}




















