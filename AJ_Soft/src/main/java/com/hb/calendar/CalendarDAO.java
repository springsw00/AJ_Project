package com.hb.calendar;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.transaction.PlatformTransactionManager;

import com.hb.interfaces.DAO;
import com.hb.interfaces.VO;

public class CalendarDAO implements DAO{
	
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
		return template.selectList("getCalendarData", map);
	}

	@Override
	public VO getOneItem(int idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(VO vo) {
		// TODO Auto-generated method stub
		int result = template.insert("addCalendar", vo);
		return result;
	}
	/*public int insert(VO vo, Map map) {
		// TODO Auto-generated method stub
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		int res =0 ;
		
		try {
			res = template.insert("addCalendar", vo);
			res += template.insert("addCalCategory", map);
			
			transactionManager.commit(status);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			transactionManager.rollback(status);
		}
		
		return res;
	}*/

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
