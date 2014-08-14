package kr.co.haco.VO;

import java.util.Date;

public class Open_Course {
	
	private String course_name;
	private int classroom;
	private Date course_start_date;
	private Date course_end_date;
	
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public int getClassroom() {
		return classroom;
	}
	public void setClassroom(int classroom) {
		this.classroom = classroom;
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
	
	
	
	
}
