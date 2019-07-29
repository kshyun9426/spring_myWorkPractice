package org.zerock.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class})
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_= {@Autowired})
	private BoardService boardService;
	
//	@Test
//	public void testExists() {
//		log.info(boardService);
//		assertNotNull(boardService);
//	}
	
//	@Test
//	public void testRegister() {
//		BoardVO board = new BoardVO();
//		board.setTitle("새로 작성하는 글");
//		board.setContent("새로 작성하는 내용");
//		board.setWriter("newbie");
//		
//		boardService.register(board);
//		
//		log.info("생성된 게시물의 번호: " + board.getBno());
//		
//	}
	
//	@Test
//	public void testGetList() {
//		boardService.getList().forEach(vo->log.info(vo));
//	}
	
//	@Test
//	public void testGet() {
//		log.info(boardService.get(8L));
//	}
	
//	@Test
//	public void testUpdate() {
//		BoardVO boardVO = boardService.get(2L);
//		
//		if(boardVO == null) {
//			return;
//		}
//		
//		boardVO.setTitle("제목 수정됨1");
//		log.info("MODIFY RESULT: " + boardService.modify(boardVO));
//	}
	
//	@Test
//	public void testDelete() {
//		log.info("REMOVE RESULT: " + boardService.remove(1L));
//	}
	
	
}


























