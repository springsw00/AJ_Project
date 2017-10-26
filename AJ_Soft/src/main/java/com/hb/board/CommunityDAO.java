package com.hb.board;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

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
		int res = 0;
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			res += template.insert("board.groupNameInsert", map);
			res += template.insert("board.gN_IDInsert", map);
			
			transactionManager.commit(status);
		} catch (Exception e) {
			System.out.println(e);
			transactionManager.rollback(status);
		}finally {
			
		}
		return res;
	}
	
	public int insertGMember(Map<String, Object> map) {
		return template.insert("board.insertGMember", map);
	}

	public int deleteGMember(Map<String, Object> map) {
		int res = 0;
		res += template.delete("board.deleteGMember", map);
		res += template.delete("board.noGroupMember", map);
		return res;
	}
	
	public int replyInsert(Map<String, Object> map) {
		return template.insert("board.reply_insert", map);
	}
	
	public List<? extends VO> replyList(Map<String, Object> map) {
		System.out.println("DAO에서 map:"+map);
		return template.selectList("board.reply_list", map);
	}
	
	public int deleteReply(int reply_No) {
		return template.delete("board.deleteReply", reply_No);
	}
	
}

