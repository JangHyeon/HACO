package kr.co.haco.VO;

public class EvalExampleResult {
	private int open_course_id;
	private int question_id;
	private int example_id;
	private int account_id;
	private String example_content;
	private int counts;
	private String question;
	
	public int getOpen_course_id() {
		return open_course_id;
	}
	public void setOpen_course_id(int open_course_id) {
		this.open_course_id = open_course_id;
	}
	public int getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}
	public int getExample_id() {
		return example_id;
	}
	public void setExample_id(int example_id) {
		this.example_id = example_id;
	}
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public String getExample_content() {
		return example_content;
	}
	public void setExample_content(String example_content) {
		this.example_content = example_content;
	}
	public int getCounts() {
		return counts;
	}
	public void setCounts(int counts) {
		this.counts = counts;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	
	
}
