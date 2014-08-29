package kr.co.haco.DAO;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.LectureRegisterList;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.OpenCourseList;
import kr.co.haco.VO.Subject;
import kr.co.haco.VO.Teacher;

public interface OpenCourseDAO {
	public List<OpenCourseList> getopencourselist(HashMap<String,Object> map);
	public Subject getCNT(HashMap<String,Object> map);
	public LectureRegisterList lecturemember(HashMap map);
	public List<LectureRegisterList> getlecturestats(HashMap<String,Object> map);
	public List<LectureRegisterList> getlecturecomplete(HashMap<String,Object> map);
	public int insertlecture(HashMap map);
	public int updatestudent(HashMap<String,Object> map);
	public int cancelstudent(HashMap<String,Object> map);
	public int completestudent(HashMap<String,Object> map);
}
