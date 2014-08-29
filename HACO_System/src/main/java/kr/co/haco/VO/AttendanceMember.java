package kr.co.haco.VO;

public class AttendanceMember {
	private String name;
	private String phone;
	private int account_id;
	private int lecture_register_id;
	private int center_id;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public int getLecture_register_id() {
		return lecture_register_id;
	}
	public void setLecture_register_id(int lecture_register_id) {
		this.lecture_register_id = lecture_register_id;
	}
	public int getCenter_id() {
		return center_id;
	}
	public void setCenter_id(int center_id) {
		this.center_id = center_id;
	}
	
}
