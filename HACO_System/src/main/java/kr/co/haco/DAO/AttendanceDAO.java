package kr.co.haco.DAO;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.AttendanceMember;
import kr.co.haco.VO.AttendanceOpenCourse;

public interface AttendanceDAO {

	public List<AttendanceMember> getstudentlist(HashMap<String, Object> map);
	public int insertatt(HashMap<String, Object> att);
	public List<AttendanceOpenCourse> getattenlist(HashMap<String, Object> map);
}
