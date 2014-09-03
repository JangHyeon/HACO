package kr.co.haco.VO;

import java.sql.Timestamp;



public class MemberOfAcademy{
	private int center_id;
	private String location;
	private String course_name;
	
	private int open_course_id;
	private int account_id;
	private int lecture_register_code;
	private Timestamp lecture_register_date;
	private String is_survey;
	private String name;
	private String address;
	private String email;
	private String phone;
	private String job_duty;	
	
		
	public int getCenter_id() {
		return center_id;
	}
	public void setCenter_id(int center_id) {
		this.center_id = center_id;
	}	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public int getOpen_course_id() {
		return open_course_id;
	}
	public void setOpen_course_id(int open_course_id) {
		this.open_course_id = open_course_id;
	}
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public int getLecture_register_code() {
		return lecture_register_code;
	}
	public void setLecture_register_code(int lecture_register_code) {
		this.lecture_register_code = lecture_register_code;
	}
	public Timestamp getLecture_register_date() {
		return lecture_register_date;
	}
	public void setLecture_register_date(Timestamp lecture_register_date) {
		this.lecture_register_date = lecture_register_date;
	}
	public String getIs_survey() {
		return is_survey;
	}
	public void setIs_survey(String is_survey) {
		this.is_survey = is_survey;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getJob_duty() {
		return job_duty;
	}
	public void setJob_duty(String job_duty) {
		this.job_duty = job_duty;
	}	
	
}
