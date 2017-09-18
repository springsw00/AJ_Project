package com.hb.interfaces;

import java.util.List;
import java.util.Map;


public interface DAO {
	
	

	
	// ��絥���� ��������
	public List<VO> getList();
	
	// ����¡ ó�� ����Ʈ
	public List<VO> getList(Map<String, Integer> map);

	// ������ �ϳ� ��������
	public VO getOneItem(int idx);

	// ������ ����
	public int insert(VO vo);

	// ������ ����
	public int modify(VO vo);

	// ������ ����
	public int delete(VO vo);

}
