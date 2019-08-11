package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_= {@Autowired})
	private ReplyMapper replyMapper;
	
	@Override
	public int register(ReplyVO vo) {
		log.info("ReplyServiceImple of register()...");
		return replyMapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("ReplyServiceImple of get(Long bno)...");
		return replyMapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("ReplyServiceImple of modify(ReplyVO vo)...");
		return replyMapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		log.info("ReplyServiceImple of remove(Long rno)...");
		return replyMapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("ReplyServiceImple of getList(Criteria cri, Long bno)...");
		return replyMapper.getListWithPaging(cri, bno);
	}
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		int replyCount = replyMapper.getCountByBno(bno);
		List<ReplyVO> replyList = replyMapper.getListWithPaging(cri, bno);
		return new ReplyPageDTO(replyCount, replyList);
	}
}














