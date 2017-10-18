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
	public List<? extends VO> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<? extends VO> getList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return template.selectList("selectListUseDate", map);
	}
	
	/**
	 * 해당 날짜에 해당 부서의 모든 사원 근태확인
	 * map에 들어갈 key - departmentid, date
	 */
	public List<? extends VO> getARListDept(Map<String, String> map) {
		// TODO Auto-generated method stub
		return template.selectList("selectListDeptAR", map);
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
	
	public int delete(String id) {
		return template.delete("deleteAR",id);
	}
	
	public VO getOneItem(VO vo) {
		return template.selectOne("checkTodayRecord", vo);
	}
	
	public int CheckDeptSuper(String id){
		
		return template.selectOne("CheckDeptSuper",id);
	}
	
	public List<? extends VO> getEmpListUseDept(String deptID){
		return template.selectList("SelectListUseDept", deptID);
	}

}
