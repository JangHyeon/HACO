package kr.co.haco.VO;

import java.util.Date;

public class EvaluationRegister {
	/*private int open_course_id;*/
	private String location;
	private String course_name;
	private Date course_start_date;
	private Date course_end_date;
	
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
	/*public int getOpen_course_id() {
		return open_course_id;
	}
	public void setOpen_course_id(int open_course_id) {
		this.open_course_id = open_course_id;
	}*/
	
	
}
