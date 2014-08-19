package kr.co.haco.VO;

import java.sql.Date;



public class EvaluationRegisterForm {
	// 윗 부분 뿌리는 것들
	
	private String course_name;
	private String subject_name;
	private Date course_start_date;
	private Date course_end_date;
	private String name_kor;

	// 아래 부분 입력해야 하는 것들
	/*private int question_id;
	private int open_course_id;
	private int type_code;
	private String question;
	private String example_content;
	*/
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
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
	/*public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getExample_content() {
		return example_content;
	}
	public void setExample_content(String example_content) {
		this.example_content = example_content;
	}*/
	
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
	/*public int getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}
	public int getOpen_course_id() {
		return open_course_id;
	}
	public void setOpen_course_id(int open_course_id) {
		this.open_course_id = open_course_id;
	}
	public int getType_code() {
		return type_code;
	}
	public void setType_code(int type_code) {
		this.type_code = type_code;
	}*/
	
	
	
}
