package com.hb.board;

import com.hb.interfaces.VO;

public class NoticeVO implements VO {
	private int poll_No, importanceLevel;
	private String title, content, writeDate;

	public int getPoll_No() {
		return poll_No;
	}

	public void setPoll_No(int poll_No) {
		this.poll_No = poll_No;
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
