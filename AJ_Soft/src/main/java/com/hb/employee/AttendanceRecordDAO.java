package com.hb.employee;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.transaction.PlatformTransactionManager;

import com.hb.interfaces.DAO;
import com.hb.interfaces.VO;

public class AttendanceRecordDAO implements DAO {
	
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
	public List<VO> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<VO> getList(Map<String, Integer> map) {
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
		return template.insert("insertAR", vo);
	}

	@Override
	public int modify(VO vo) {
		// TODO Auto-generated method stub
		return template.update("updateAR", vo);
	}

	@Override
	public int delete(VO vo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public VO getOneItem(VO vo) {
		return template.selectOne("checkTodayRecord", vo);
	}

}
