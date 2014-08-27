package kr.co.haco.DAO;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.LectureRegisterVO;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.StudentVO;
import kr.co.haco.VO.Subject;

public interface OpenCourseDAO {
	public List<OpenCourse> getopencourselist(HashMap map);
	/*public Subject getsubject(HashMap map);*/
	public Subject getCNT(HashMap map);
	public List<LectureRegisterVO> getlecturestats(HashMap map);
	public List<LectureRegisterVO> getlecturecomplete(HashMap map);
	public int insertlecture(HashMap map);
	public int updatestudent(HashMap map);
	public int cancelstudent(HashMap map);
	public int completestudent(HashMap map);
}
