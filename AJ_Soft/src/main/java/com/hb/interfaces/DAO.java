package com.hb.interfaces;

import java.util.List;
import java.util.Map;


public interface DAO {
	
	

	
	// 모든데이터 가져오기
	public List<VO> getList();
	
	// 페이징 처리 리스트
	public List<VO> getList(Map<String, Integer> map);

	// 데이터 하나 꺼내오기
	public VO getOneItem(int idx);

	// 데이터 삽입
	public int insert(VO vo);

	// 데이터 수정
	public int modify(VO vo);

	// 데이터 삭제
	public int delete(VO vo);

}
