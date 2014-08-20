package kr.co.haco.VO;

import java.sql.Date;

public class OpenCourse {
	int open_course_id;
	int account_id;
	int subject_id;
	String course_name;
	Date course_start_date;
	Date course_end_date;
	int center_id;
	int center_classroom_id;
	String seldate;
	
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
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
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
	public int getCenter_id() {
		return center_id;
	}
	public void setCenter_id(int center_id) {
		this.center_id = center_id;
	}
	public int getCenter_classroom_id() {
		return center_classroom_id;
	}
	public void setCenter_classroom_id(int center_classroom_id) {
		this.center_classroom_id = center_classroom_id;
	}
	public String getSeldate() {
		return seldate;
	}
	public void setSeldate(String seldate) {
		this.seldate = seldate;
	}
	
}
