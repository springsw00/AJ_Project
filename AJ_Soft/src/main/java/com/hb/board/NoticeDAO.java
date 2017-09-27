package com.hb.board;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.transaction.PlatformTransactionManager;

import com.hb.interfaces.DAO;
import com.hb.interfaces.VO;

public class NoticeDAO implements DAO {

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
		System.out.println(template.toString());
	}

	// 전체 게시물의 수
	public int getTotalCount() {
		return template.selectOne("totalcount");
	}

	@Override
	public List<VO> getList() {
		return null;
	}

	@Override
	public List<VO> getList(Map<String, Object> map) {
		return template.selectList("board.list", map);
	}

	@Override
	public VO getOneItem(int idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(VO vo) {
		return template.insert("board.insertNotice", vo);
	}

	@Override
	public int modify(VO vo) {
		return template.update("board.updateNotice",vo);
	}

	@Override
	public int delete(VO vo) {
		// TODO Auto-generated method stub
		return 0;
	}
	public VO getOneList(int notice_no){
		return template.selectOne("board.selectOne", notice_no);
	}

}
