package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//BoardService를 구현하는 비즈니스로직은 간단하게 로그만 출력하도록 구현
@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	//스프링 4.3 이상에서는 단일 파라미터를 받는 생성자의 경우에는 필요한 파라미터를 자동으로 주입할 수 있다.
	//@Setter(onMethod_={@Autowired}) //@AllArgsConstructor 애노테이션이 없을 경우 설정
	private BoardMapper boardMapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("BoardServiceImpl of registering boardVO.... : " + board);
		boardMapper.insertSelectKey(board);
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

	@Override
	public boolean remove(Long bno) {
		log.info("BoardServiceImpl of remove()...........: " + bno);
		return boardMapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("BoardServiceImpl of getlist()....... : ");
//		return boardMapper.getList();
		return boardMapper.getListWithPaging(cri);
	}

	
	
}
