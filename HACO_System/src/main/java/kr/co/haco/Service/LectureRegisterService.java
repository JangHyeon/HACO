package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.VO.LectureRegisterList;
import kr.co.haco.VO.OpenCourse;
import kr.co.haco.VO.Student;
import kr.co.haco.VO.Subject;

public interface LectureRegisterService {
	public List<OpenCourse> getopencourselist(HashMap map);
	/*public Subject getsubject(HashMap map);*/
	public Subject getCNT(HashMap map);
	public List<LectureRegisterList> getlecturestats(HashMap map);
	public List<LectureRegisterList> getlecturecomplete(HashMap map);
	public int insertlecture(HashMap map);
	public int updatestudent(HashMap map);
	public int cancelstudent(HashMap map);
	public int completestudent(HashMap map);
}
