package com.hb.interfaces;

import java.util.List;
import java.util.Map;


public interface DAO {
	
	

	
	// ��絥���� ��������
	public List<? extends VO> getList();
	
	// ����¡ ó�� ����Ʈ
	public List<? extends VO> getList(Map<String, Object> map);

	// ������ �ϳ� ��������
	public VO getOneItem(int idx);

	// ������ ����
	public int insert(VO vo);

	// ������ ����
	public int modify(VO vo);

	// ������ ����
	public int delete(VO vo);

}
