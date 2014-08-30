package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.Attendance;
import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.LectureRegister;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Roles;

import org.springframework.security.access.prepost.PreAuthorize;

public interface AttendanceService{
	
	public List<OpenCourse> getattenlist(HashMap map);
	public List<Member> getstdentlist(HashMap map);
	public List<Attendance> insertatt(HashMap map);
}