package com.hb.board;

import com.hb.interfaces.VO;

public class NoticeVO implements VO {
	private int notice_no, importanceLevel;
	private String title, content, writeDate, writer;

	
	
	
	@Override
	public String toString() {
		return "NoticeVO [notice_no=" + notice_no + ", importanceLevel=" + importanceLevel + ", title=" + title
				+ ", content=" + content + ", writeDate=" + writeDate + ", writer=" + writer + "]";
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}


	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public int getImportanceLevel() {
		return importanceLevel;
	}

	public void setImportanceLevel(int importanceLevel) {
		this.importanceLevel = importanceLevel;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

}
