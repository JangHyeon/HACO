package kr.co.haco.VO;

import java.sql.Date;

public class LectureRegister {
	int lecture_register_id;
	int open_course_id;
	int account_id;
	int lecture_register_code;
	Date lecture_register_date;
	String is_survey;
	
	public int getLecture_register_id() {
		return lecture_register_id;
	}
	public void setLecture_register_id(int lecture_register_id) {
		this.lecture_register_id = lecture_register_id;
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
	public Date getLecture_register_date() {
		return lecture_register_date;
	}
	public void setLecture_register_date(Date lecture_register_date) {
		this.lecture_register_date = lecture_register_date;
	}
	public String getIs_survey() {
		return is_survey;
	}
	public void setIs_survey(String is_survey) {
		this.is_survey = is_survey;
	}
	
}
