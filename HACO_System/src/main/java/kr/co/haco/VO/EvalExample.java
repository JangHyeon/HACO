package kr.co.haco.VO;

public class EvalExample {
	private int question_id;
	private String example_content;
	private int example_id;
	
	public int getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}
	public String getExample_content() {
		return example_content;
	}
	public void setExample_content(String example_content) {
		this.example_content = example_content;
	}
	
	public int getExample_id() {
		return example_id;
	}
	public void setExample_id(int example_id) {
		this.example_id = example_id;
	}
	
	@Override
	public String toString() {
		String string = " question_id:"+question_id+" example_content:"+example_content;
		return string;
	}	
	
}
