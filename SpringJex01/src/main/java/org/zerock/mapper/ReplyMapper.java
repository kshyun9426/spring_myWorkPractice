package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO reply);
	
	//mybatis에 매개변수를 2개이상 사용하기 위해선 @Param어노테이션을 사용함
	public List<ReplyVO> getListWithPaging(@Param("cri")Criteria cri, @Param("bno")Long bno);
	
	public int getCountByBno(Long bno);
}
