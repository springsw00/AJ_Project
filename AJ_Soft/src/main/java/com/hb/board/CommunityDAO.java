package com.hb.board;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.transaction.PlatformTransactionManager;

import com.hb.interfaces.DAO;
import com.hb.interfaces.VO;

public class CommunityDAO implements DAO {
	
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
		//System.out.println(template.toString());
	}

	// 전체 게시물의 수
	public int getCommuTotalCount(int groupID) {
		return template.selectOne("board.commuTotalcount",groupID);
	}
	
	@Override
	public List<? extends VO> getList() {
		return null;
	}

	@Override
	public List<? extends VO> getList(Map<String, Object> map) {
		return template.selectList("board.listCommuMap", map);
	}

	@Override
	public VO getOneItem(int idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(VO vo) {
		return template.insert("board.insertCommu", vo);
	}

	@Override
	public int modify(VO vo) {
		return template.update("board.updateCommu", vo);
	} 
  
	@Override
	public int delete(VO vo) {
		return template.delete("board.deleteCommu", vo);
	}
	
	public List<? extends VO> getCommunityMenu(String empID) {
		return template.selectList("board.selectCommuMenu", empID);
	}

	public VO listOne(int community_no) {
		return template.selectOne("board.CommuSelectOne", community_no);
	}
	
	public String getGroupName(int groupID){
		return template.selectOne("board.selectGroupName", groupID);
	}
	
	public int empInsert(VO vo) {
		return template.insert("board.empInsert", vo);
	}

	public List<? extends VO> getAllGroup() {
		return template.selectList("board.selectAllGroup");
	}
	
	public List<?> getGroupID(String empID) {
		return template.selectList("board.select_listGroupID", empID);
	}
	
	public int groupNameInsert(Map<String, Object> map) {
		return template.insert("board.groupNameInsert", map);
	}
}
