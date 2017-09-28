package com.hb.calendar;

import com.hb.interfaces.VO;

public class CalendarVO implements VO {
	private String id, title, content, location = "", startDate, endDate, target="", category, color;
	private int calendar_No;
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public int getCalendar_No() {
		return calendar_No;
	}
	public void setCalendar_No(int calendar_No) {
		this.calendar_No = calendar_No;
	}
	@Override
	public String toString() {
		return "CalendarVO [id=" + id + ", title=" + title + ", content=" + content + ", location=" + location
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", target=" + target + ", category=" + category
				+ ", color=" + color + ", calendar_No=" + calendar_No + "]";
	}
	
	
	
	
}
