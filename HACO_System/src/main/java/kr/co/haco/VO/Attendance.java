package kr.co.haco.VO;


public class Attendance {
	private int lecture_register_id;
	private int attendance_code;
	private String attendance_date;
	private int center_id;
	private int open_course_id;
	public int getLecture_register_id() {
		return lecture_register_id;
	}
	public void setLecture_register_id(int lecture_register_id) {
		this.lecture_register_id = lecture_register_id;
	}
	public int getAttendance_code() {
		return attendance_code;
	}
	public void setAttendance_code(int attendance_code) {
		this.attendance_code = attendance_code;
	}
	public String getAttendance_date() {
		return attendance_date;
	}
	public void setAttendance_date(String attendance_date) {
		this.attendance_date = attendance_date;
	}
	public int getCenter_id() {
		return center_id;
	}
	public void setCenter_id(int center_id) {
		this.center_id = center_id;
	}
	public int getOpen_course_id() {
		return open_course_id;
	}
	public void setOpen_course_id(int open_course_id) {
		this.open_course_id = open_course_id;
	}
	
}
