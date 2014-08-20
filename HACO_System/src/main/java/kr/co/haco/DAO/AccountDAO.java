package kr.co.haco.DAO;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.LectureRegister;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Roles;

public interface AccountDAO {
	public List<Roles> getRoleList();
	public Employee getEmployee(String account_id);
	public OpenCourse getOpencourse(OpenCourse oc);
	public List<OpenCourse> getattenlist(HashMap map);
	public LectureRegister getregister(LectureRegister lecture_register_id);
	public List<Member> getstdentlist(HashMap map);
	public EducationCenter getcenter(EducationCenter location);
	public Employee getemployee(Employee name_kor);
	public CenterClassroom getclassroom(CenterClassroom classroom);
}
