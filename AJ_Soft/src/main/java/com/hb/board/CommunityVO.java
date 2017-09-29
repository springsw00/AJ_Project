package com.hb.board;

import com.hb.interfaces.VO;

public class CommunityVO implements VO {
	
	int community_no, groupID;
	String title, content, writer, writeDate, groupName, srartDate, memberID;
	
	public int getCommunity_no() {
		return community_no;
	}
	public void setCommunity_no(int community_no) {
		this.community_no = community_no;
	}
	public int getGroupID() {
		return groupID;
	}
	public void setGroupID(int groupID) {
		this.groupID = groupID;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getSrartDate() {
		return srartDate;
	}
	public void setSrartDate(String srartDate) {
		this.srartDate = srartDate;
	}
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	@Override
	public String toString() {
		return "CommunityVO [community_no=" + community_no + ", groupID=" + groupID + ", title=" + title + ", content="
				+ content + ", writer=" + writer + ", writeDate=" + writeDate + ", groupName=" + groupName
				+ ", srartDate=" + srartDate + ", memberID=" + memberID + "]";
	}

	
	

}
