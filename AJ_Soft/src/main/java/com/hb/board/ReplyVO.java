package com.hb.board;

import com.hb.interfaces.VO;

public class ReplyVO implements VO {
	private int reply_No, board_Category, board_no;
	private String id, reply_date, content;
	
	
	public int getReply_No() {
		return reply_No;
	}
	public void setReply_No(int reply_No) {
		this.reply_No = reply_No;
	}
	public int getBoard_Category() {
		return board_Category;
	}
	public void setBoard_Category(int board_Category) {
		this.board_Category = board_Category;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReply_date() {
		return reply_date;
	}
	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
	
	
}
