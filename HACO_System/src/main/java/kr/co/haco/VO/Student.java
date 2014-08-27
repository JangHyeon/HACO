package kr.co.haco.VO;

import java.sql.Date;
import java.sql.Time;

public class Student {
	private int account_id;
	private int open_course_id;
	private String course_name;
	private String name_kor;
	private Date course_start_date;
	private Date course_end_date;
	private String subject_name;
	private Time lecture_time_start;
	private Time lecture_time_end;
	private int tuition_fee;
	private int capacity;
	private int location;
	private String lecture_content;
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
	public String getName_kor() {
		return name_kor;
	}
	public void setName_kor(String name_kor) {
		this.name_kor = name_kor;
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
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public Time getLecture_time_start() {
		return lecture_time_start;
	}
	public void setLecture_time_start(Time lecture_time_start) {
		this.lecture_time_start = lecture_time_start;
	}
	public Time getLecture_time_end() {
		return lecture_time_end;
	}
	public void setLecture_time_end(Time lecture_time_end) {
		this.lecture_time_end = lecture_time_end;
	}
	public int getTuition_fee() {
		return tuition_fee;
	}
	public void setTuition_fee(int tuition_fee) {
		this.tuition_fee = tuition_fee;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public int getLocation() {
		return location;
	}
	public void setLocation(int location) {
		this.location = location;
	}
	public String getLecture_content() {
		return lecture_content;
	}
	public void setLecture_content(String lecture_content) {
		this.lecture_content = lecture_content;
	}
	
}
