package kr.co.haco.VO;

import java.sql.Date;

public class Subject {
	int subject_id;
	String subject_name;
	int capacity;
	String subject_explanation;
	String instructional_objectives;
	String subject_point;
	String lecture_target;
	int lecture_totalday;
	int lecture_totaltime;
	String lecture_time;
	int tuition_fee;
	String lecture_content;
	Date create_date;
	Date update_date;
	int center_id;
	
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getSubject_explanation() {
		return subject_explanation;
	}
	public void setSubject_explanation(String subject_explanation) {
		this.subject_explanation = subject_explanation;
	}
	public String getInstructional_objectives() {
		return instructional_objectives;
	}
	public void setInstructional_objectives(String instructional_objectives) {
		this.instructional_objectives = instructional_objectives;
	}
	public String getSubject_point() {
		return subject_point;
	}
	public void setSubject_point(String subject_point) {
		this.subject_point = subject_point;
	}
	public String getLecture_target() {
		return lecture_target;
	}
	public void setLecture_target(String lecture_target) {
		this.lecture_target = lecture_target;
	}
	public int getLecture_totalday() {
		return lecture_totalday;
	}
	public void setLecture_totalday(int lecture_totalday) {
		this.lecture_totalday = lecture_totalday;
	}
	public int getLecture_totaltime() {
		return lecture_totaltime;
	}
	public void setLecture_totaltime(int lecture_totaltime) {
		this.lecture_totaltime = lecture_totaltime;
	}
	public String getLecture_time() {
		return lecture_time;
	}
	public void setLecture_time(String lecture_time) {
		this.lecture_time = lecture_time;
	}
	public int getTuition_fee() {
		return tuition_fee;
	}
	public void setTuition_fee(int tuition_fee) {
		this.tuition_fee = tuition_fee;
	}
	public String getLecture_content() {
		return lecture_content;
	}
	public void setLecture_content(String lecture_content) {
		this.lecture_content = lecture_content;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	public int getCenter_id() {
		return center_id;
	}
	public void setCenter_id(int center_id) {
		this.center_id = center_id;
	}
	
}
