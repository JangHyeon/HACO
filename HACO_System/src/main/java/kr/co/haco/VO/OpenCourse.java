package kr.co.haco.VO;

import java.util.Date;

public class OpenCourse {
	
	
	public OpenCourse(){};
	
	public OpenCourse(int account_id, int subject_id, String course_name,
			Date course_start_date, Date course_end_date, int center_id,
			int center_classroom_id) {
		super();
		this.account_id = account_id;
		this.subject_id = subject_id;
		this.course_name = course_name;
		this.course_start_date = course_start_date;
		this.course_end_date = course_end_date;
		this.center_id = center_id;
		this.center_classroom_id = center_classroom_id;
	}
	    public OpenCourse(int open_course_id, int account_id, int subject_id,
			String course_name, 
			int center_id, int center_classroom_id) {
		super();
		this.open_course_id = open_course_id;
		this.account_id = account_id;
		this.subject_id = subject_id;
		this.course_name = course_name;
		this.center_id = center_id;
		this.center_classroom_id = center_classroom_id;
	}

	@Override
	public String toString() {
		return "OpenCourse [open_course_id=" + open_course_id + ", account_id="
				+ account_id + ", subject_id=" + subject_id + ", course_name="
				+ course_name + ", course_start_date=" + course_start_date
				+ ", course_end_date=" + course_end_date + ", center_id="
				+ center_id + ", center_classroom_id=" + center_classroom_id
				+ "]";
	}





	private String seldate;
	private String name_kor;
	public String getSeldate() {
		return seldate;
	}

	public void setSeldate(String seldate) {
		this.seldate = seldate;
	}

	public String getName_kor() {
		return name_kor;
	}

	public void setName_kor(String name_kor) {
		this.name_kor = name_kor;
	}

	public String getSubject_name() {
		return subject_name;
	}

	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getCNT() {
		return CNT;
	}

	public void setCNT(int cNT) {
		CNT = cNT;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public int getClassroom() {
		return classroom;
	}

	public void setClassroom(int classroom) {
		this.classroom = classroom;
	}

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

	public int getAttendance_date() {
		return attendance_date;
	}

	public void setAttendance_date(int attendance_date) {
		this.attendance_date = attendance_date;
	}





	private String subject_name;
	private String location;
	private int CNT;
	private int capacity;
	private int classroom;
	private int lecture_register_id;
	private int attendance_code;
	private int attendance_date;



	private int open_course_id;
	private int account_id;
	private int subject_id;
	private String course_name;
	private Date course_start_date;
	private Date course_end_date;
	private int center_id;
	private int center_classroom_id;
	
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
	public int getSubject_id() {
		return subject_id;
	}
	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
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
	public int getCenter_id() {
		return center_id;
	}
	public void setCenter_id(int center_id) {
		this.center_id = center_id;
	}
	public int getCenter_classroom_id() {
		return center_classroom_id;
	}
	public void setCenter_classroom_id(int center_classroom_id) {
		this.center_classroom_id = center_classroom_id;
	}
	
	
}