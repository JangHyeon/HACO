package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.Attendance;
import kr.co.haco.VO.AttendanceMember;
import kr.co.haco.VO.AttendanceOpenCourse;


public interface AttendanceService{
	
	public List<AttendanceMember> getstudentlist(HashMap<String, Object>  map);
	public int insertatt(HashMap<String, Object>  att);
	public List<AttendanceOpenCourse> getattenlist(HashMap<String, Object> map);
}