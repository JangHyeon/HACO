package kr.co.haco.DAO;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.Attendance;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.OpenCourse;

public interface AttendanceDAO {

	public List<OpenCourse> getattenlist(HashMap map);
	public List<Member> getstdentlist(HashMap map);
	public List<Attendance> insertatt(HashMap map);
}
