package com.hb.contactlist;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.transaction.PlatformTransactionManager;

import com.hb.employee.EmpViewVO;
import com.hb.interfaces.DAO;
import com.hb.interfaces.VO;

public class ContactListDAO implements DAO{
	
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
		return template.selectList("contactlist.getAllList");
	}
	
	public List<ContactListVO> getList(String id){
		return template.selectList("getMyGroupList",id);
	}

	@Override
	public List<? extends VO> getList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return template.selectList("getMyList",map);
	}

	@Override
	public VO getOneItem(int idx) {
		// TODO Auto-generated method stub
		return template.selectOne("getOneContact", idx);
	}

	@Override
	public int insert(VO vo) {
		// TODO Auto-generated method stub
		return template.insert("contactlist.addContact", vo);
	}

	@Override
	public int modify(VO vo) {
		// TODO Auto-generated method stub
		return template.update("updateContact", vo);
	}

	@Override
	public int delete(VO vo) {
		// TODO Auto-generated method stub
		return 0;
	}
	public int delete(String id) {
		// TODO Auto-generated method stub
		return template.delete("deleteContact", id);
	}
	
	public List<EmpViewVO> getDepartmentList(){
		return template.selectList("contactlist.getDeptList");
	}
	

	
}
