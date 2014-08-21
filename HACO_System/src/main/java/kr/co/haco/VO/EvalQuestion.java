package kr.co.haco.VO;

public class EvalQuestion {	
	private int open_course_id;
	private String type_code;
	private String question;
	
	public int getOpen_course_id() {
		return open_course_id;
	}
	public void setOpen_course_id(int open_course_id) {
		this.open_course_id = open_course_id;
	}
	public String getType_code() {
		return type_code;
	}
	public void setType_code(String type_code) {
		this.type_code = type_code;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	
	@Override
	public String toString() {
		String string = "open_course_id:"+open_course_id+" type_code:"+type_code+" question:"+question;
		return string;
	}
	

}
