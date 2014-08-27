package kr.co.haco.DAO;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.AttendanceVO;
import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.LectureRegister;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.OpenCourse;

public interface AttendanceDAO {

	public List<OpenCourse> getattenlist(HashMap map);
	public List<Member> getstdentlist(HashMap map);
	public List<AttendanceVO> insertatt(HashMap map);
}
