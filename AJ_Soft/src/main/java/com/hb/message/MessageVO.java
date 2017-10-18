package com.hb.message;

import com.hb.interfaces.VO;

public class MessageVO implements VO{
	String message_no, senderID, receiveID, content, msgDate, readChk;

	public String getMessage_no() {
		return message_no;
	}

	public void setMessage_no(String message_no) {
		this.message_no = message_no;
	}

	public String getSenderID() {
		return senderID;
	}

	public void setSenderID(String senderID) {
		this.senderID = senderID;
	}

	public String getReceiveID() {
		return receiveID;
	}

	public void setReceiveID(String receiveID) {
		this.receiveID = receiveID;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMsgDate() {
		return msgDate;
	}

	public void setMsgDate(String msgDate) {
		this.msgDate = msgDate;
	}

	public String getReadChk() {
		return readChk;
	}

	public void setReadChk(String readChk) {
		this.readChk = readChk;
	}
	
}
