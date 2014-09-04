package kr.co.haco.DAO;

import java.util.List;

import kr.co.haco.VO.Center;
import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.getCourseList;

public interface CenterDAO {
	public List<Center> getcenterList();
	public List<CenterClassroom> getclassroomList(String center_id);
	public List<getCourseList> getopencoursesList(String center_classroom_id);
	public int insertCenter(String location);
	public int deleteCenter(String center_id);
	public int insertRoom(String center_id,String classroom);
	public int deleteRoom(String center_classroom_id);
}
