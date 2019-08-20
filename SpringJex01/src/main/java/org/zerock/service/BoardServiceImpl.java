package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//BoardService를 구현하는 비즈니스로직은 간단하게 로그만 출력하도록 구현
@Log4j
@Service
//@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	//스프링 4.3 이상에서는 단일 파라미터를 받는 생성자의 경우에는 필요한 파라미터를 자동으로 주입할 수 있다.
	@Setter(onMethod_={@Autowired}) //@AllArgsConstructor 애노테이션이 없을 경우 설정
	private BoardMapper boardMapper;
	
	@Setter(onMethod_= {@Autowired})
	private BoardAttachMapper boardAttachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("BoardServiceImpl of registering boardVO.... : " + board);
		boardMapper.insertSelectKey(board);
		
		//이미지가 없다면 return
		if(board.getAttachList() == null || board.getAttachList().size() == 0) {
			return;
		}
		board.getAttachList().forEach(vo->{
			vo.setBno(board.getBno());
			boardAttachMapper.insert(vo);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("BoardServiceImpl of get().....");
		return boardMapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("BoardServiceImpl of modify()...........: " + board);
		return boardMapper.update(board) == 1;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("BoardServiceImpl of remove()...........: " + bno);
		boardAttachMapper.deleteAll(bno);
		return boardMapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("BoardServiceImpl of getlist()....... : ");
//		return boardMapper.getList();
		return boardMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("BoardServiceImpl of getTotal()......");
		return boardMapper.getTotalCount(cri);
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(Long bno){
		log.info("BoardServiceImple of getAttachLIst()........");
		return boardAttachMapper.findByBno(bno);
	}
	
}


























