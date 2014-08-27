package kr.co.haco.VO;

public class Chart {

	private int    count;
	private String color;
	private String height;
	private String label;
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	@Override
	public String toString() {
		
		return count +" // "+ color +" // "+ height  +" // "+ label;
	}

	
}
