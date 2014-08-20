package kr.co.haco.VO;

public class EvaluationRegister {	
	private int open_course_id;
	private int state_code;
	private int queston_id;
	private int type_code;
	private String question;
	private int example_id;
	private String example_content;
	
	
	public int getOpen_course_id() {
		return open_course_id;
	}
	public void setOpen_course_id(int open_course_id) {
		this.open_course_id = open_course_id;
	}
	public int getState_code() {
		return state_code;
	}
	public void setState_code(int state_code) {
		this.state_code = state_code;
	}
	public int getQueston_id() {
		return queston_id;
	}
	public void setQueston_id(int queston_id) {
		this.queston_id = queston_id;
	}
	public int getType_code() {
		return type_code;
	}
	public void setType_code(int type_code) {
		this.type_code = type_code;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public int getExample_id() {
		return example_id;
	}
	public void setExample_id(int example_id) {
		this.example_id = example_id;
	}
	public String getExample_content() {
		return example_content;
	}
	public void setExample_content(String example_content) {
		this.example_content = example_content;
	}
}
