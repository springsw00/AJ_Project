package com.hb.employee;

import com.hb.interfaces.VO;

public class EmployeeVO implements VO {
	private String id, password, name, email, address, cellPhone, position, phone, profile, departmentID, hired_date;
	private int birth;

	public String getHired_date() {
		return hired_date;
	}

	public void setHired_date(String hired_date) {
		this.hired_date = hired_date;
	}

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getDepartmentID() {
		return departmentID;
	}

	public void setDepartmentID(String departmentID) {
		this.departmentID = departmentID;
	}

	public int getBirth() {
		return birth;
	}

	public void setBirth(int birth) {
		this.birth = birth;
	}

	@Override
	public String toString() {
		return "EmployeeVO [id=" + id + ", password=" + password + ", name=" + name + ", email=" + email + ", address="
				+ address + ", \ncellPhone=" + cellPhone + ", position=" + position + ", phone=" + phone + ", profile="
				+ profile + ", departmentID=" + departmentID + ", birth=" + birth + "]";
	}

}
