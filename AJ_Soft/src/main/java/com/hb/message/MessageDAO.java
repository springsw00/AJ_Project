package com.hb.message;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.transaction.PlatformTransactionManager;

import com.hb.interfaces.DAO;
import com.hb.interfaces.VO;

public class MessageDAO implements DAO {
	
	private SqlSessionTemplate template;
	PlatformTransactionManager transactionManager;

	public PlatformTransactionManager getTransactionManager() {
		return transactionManager;
	}

	public void setTransactionManager(PlatformTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}

	public SqlSessionTemplate getTemplate() {
		return template;
	}

	public void setTemplate(SqlSessionTemplate template) {
		this.template = template;
	}

	@Override
	public List<? extends VO> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<? extends VO> getList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 
	 * @param id
	 * @return 내가 받은 메세지 리스트
	 */
	public List<? extends VO> getReceiveList(String id) {
		// TODO Auto-generated method stub
		return template.selectList("getMyMsg", id);
	}
	/**
	 * 
	 * @param id
	 * @return 내가 보낸 메세지 리스트
	 */
	public List<? extends VO> getSendList(String id) {
		// TODO Auto-generated method stub
		return template.selectList("getSendMsg", id);
	}

	@Override
	public VO getOneItem(int idx) {
		// TODO Auto-generated method stub
		return template.selectOne("getOneMsg", idx);
	}

	@Override
	public int insert(VO vo) {
		// TODO Auto-generated method stub
		return template.insert("sendMsg", vo);
	}

	@Override
	public int modify(VO vo) {
		// TODO Auto-generated method stub
		return template.update("readChk",vo);
	}

	@Override
	public int delete(VO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

}
