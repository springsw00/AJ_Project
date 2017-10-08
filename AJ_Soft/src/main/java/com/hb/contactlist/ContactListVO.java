package com.hb.contactlist;

import com.hb.interfaces.VO;

public class ContactListVO implements VO {
	private int contactList_No;
	private String id, name, cellPhone, phone, departmentID, companyName, email, contact_group, etc;

	public int getContactList_No() {
		return contactList_No;
	}

	public void setContactList_No(int contactList_No) {
		this.contactList_No = contactList_No;
	}


	public String getContact_group() {
		return contact_group;
	}

	public void setContact_group(String contact_group) {
		this.contact_group = contact_group;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDepartmentID() {
		return departmentID;
	}

	public void setDepartmentID(String departmentID) {
		this.departmentID = departmentID;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "ContactListVO [contactList_No=" + contactList_No + ", id=" + id + ", name=" + name + ", cellPhone="
				+ cellPhone + ", phone=" + phone + ", departmentID=" + departmentID + ", companyName=" + companyName
				+ ", email=" + email + ", contact_group=" + contact_group + ", etc=" + etc + "]";
	}

}
