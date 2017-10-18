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

	@Override
	public VO getOneItem(int idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(VO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int modify(VO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(VO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

}
