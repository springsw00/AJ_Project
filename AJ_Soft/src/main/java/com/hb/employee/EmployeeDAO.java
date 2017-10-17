package com.hb.employee;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hb.interfaces.DAO;
import com.hb.interfaces.VO;

public class EmployeeDAO implements DAO {
	
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
	public List<VO> getList(Map<String, Object> map) {
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
		int res = 0;
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			res += template.insert("employee.insertEmployee", vo);
			res += template.insert("board.empInsert", vo);
			
			transactionManager.commit(status);
		} catch (Exception e) {
			System.out.println(e);
			transactionManager.rollback(status);
		}finally {
			
		}
		return res;
	}
 
	@Override
	public int modify(VO vo) {
		return template.update("employee.updateEmployee", vo);
	}
	@Override
	public int delete(VO vo) {
		return template.delete("employee.deleteEmployee", vo);
	}
	
	public VO loginCheck(VO vo) {
		return template.selectOne("employee.loginCheck", vo);
		
	}
	public int idCheck_ajax(String id) {
		int res = template.selectOne("employee.insert_idCheck", id);
		return res;
	}
	public VO getOneList(String id) {
		return template.selectOne("employee.selectEmployee", id);
	}
	
	public List<HashMap<String, String>> getList(String deptID){
		return template.selectList("employee.selectForContact", deptID);
	}
	
	
}
