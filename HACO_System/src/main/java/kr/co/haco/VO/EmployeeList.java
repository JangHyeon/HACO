package kr.co.haco.VO;

import java.sql.Date;



public class EmployeeList{	
	private int now_center_id;
	private String now_center_name;
	private int account_id;
	private String name_kor;
	private String phone_cell;
	private String email;
	private Date join_date;
	private int join_center_id;
	private String join_center_name;

	
	public int getNow_center_id() {
		return now_center_id;
	}
	public void setNow_center_id(int now_center_id) {
		this.now_center_id = now_center_id;
	}
	public String getNow_center_name() {
		return now_center_name;
	}
	public void setNow_center_name(String now_center_name) {
		this.now_center_name = now_center_name;
	}
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public String getName_kor() {
		return name_kor;
	}
	public void setName_kor(String name_kor) {
		this.name_kor = name_kor;
	}
	public String getPhone_cell() {
		return phone_cell;
	}
	public void setPhone_cell(String phone_cell) {
		this.phone_cell = phone_cell;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public int getJoin_center_id() {
		return join_center_id;
	}
	public void setJoin_center_id(int join_center_id) {
		this.join_center_id = join_center_id;
	}
	public String getJoin_center_name() {
		return join_center_name;
	}
	public void setJoin_center_name(String join_center_name) {
		this.join_center_name = join_center_name;
	}

	
}
