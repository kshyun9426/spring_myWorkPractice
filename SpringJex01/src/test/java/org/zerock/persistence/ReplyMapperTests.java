package org.zerock.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {org.zerock.config.RootConfig.class})
@Log4j
public class ReplyMapperTests {
	
	private Long[] bnoArr = {35L, 36L, 37L, 38L, 39L};
	
	@Autowired
	private ReplyMapper replyMapper;
	
//	@Test
//	public void testMapperExists() {
//		log.info(replyMapper);
//	}
	
//	@Test
//	public void testInsertReply() {
//		IntStream.rangeClosed(1,10).forEach(i->{
//			ReplyVO reply = new ReplyVO();
//			
//			reply.setBno(bnoArr[i%5]);
//			reply.setReply("댓글 테스트" + i);
//			reply.setReplyer("replyer" + i);
//			
//			replyMapper.insert(reply);
//		});
//	}
	
//	@Test
//	public void testReadingReply() {
//		log.info(replyMapper.read(4L));
//	}
	
//	@Test
//	public void testDeletingReply() {
//		log.info(replyMapper.delete(4L));
//	}
	
//	@Test
//	public void testUpdatingReply() {
//		Long targetRno = 10L;
//		ReplyVO vo = replyMapper.read(targetRno);
//		vo.setReply("Updated Reply");
//		int count = replyMapper.update(vo);
//		log.info("Update Count: " + count);
//	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = replyMapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(vo->log.info(vo));
	}
}































