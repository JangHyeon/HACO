package kr.co.haco.VO;

import java.sql.Date;

public class MyLectureHistory {
	private int account_id;
	private int open_course_id;
	private String course_name;
	private int center_id;
	private String location;
	private Date course_start_date;
	private Date course_end_date;
	private String now_study;
	private String is_survey;
	
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public int getOpen_course_id() {
		return open_course_id;
	}
	public void setOpen_course_id(int open_course_id) {
		this.open_course_id = open_course_id;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
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
	public Date getCourse_start_date() {
		return course_start_date;
	}
	public void setCourse_start_date(Date course_start_date) {
		this.course_start_date = course_start_date;
	}
	public Date getCourse_end_date() {
		return course_end_date;
	}
	public void setCourse_end_date(Date course_end_date) {
		this.course_end_date = course_end_date;
	}
	public String getNow_study() {
		return now_study;
	}
	public void setNow_study(String now_study) {
		this.now_study = now_study;
	}
	public String getIs_survey() {
		return is_survey;
	}
	public void setIs_survey(String is_survey) {
		this.is_survey = is_survey;
	}	
	
}
