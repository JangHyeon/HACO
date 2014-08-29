package kr.co.haco.VO;

import java.sql.Date;

public class Attenlist {
	private String name;
	private Date attendance_date;
	private String attendance_state_name;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getAttendance_date() {
		return attendance_date;
	}
	public void setAttendance_date(Date attendance_date) {
		this.attendance_date = attendance_date;
	}
	public String getAttendance_state_name() {
		return attendance_state_name;
	}
	public void setAttendance_state_name(String attendance_state_name) {
		this.attendance_state_name = attendance_state_name;
	}
	
	
}
