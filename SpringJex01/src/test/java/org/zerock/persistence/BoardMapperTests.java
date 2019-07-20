package org.zerock.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;
import org.zerock.domain.BoardVO;
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
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setContent("테스트6");
		board.setTitle("테스트제목6");
		board.setWriter("user06");
		
		boardMapper.insert(board);
		log.info(board);
		
	}
}




















