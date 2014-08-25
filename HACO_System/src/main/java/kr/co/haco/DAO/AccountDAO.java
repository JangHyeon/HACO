package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Roles;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.educationCenter;
import kr.co.haco.VO.getCourseList;

public interface AccountDAO {
	public List<Roles> getRoleList();
	public Employee getEmployee(String account_id);
	public Employee getEmployeeID(String name);

	
}
