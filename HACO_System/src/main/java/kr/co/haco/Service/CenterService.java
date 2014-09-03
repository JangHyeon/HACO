package kr.co.haco.Service;

import java.util.List;





import kr.co.haco.VO.Center;
import kr.co.haco.VO.CenterClassroom;
import kr.co.haco.VO.Subject;



public interface CenterService {

	public List<Center> getcenterList();
	public List<CenterClassroom> getclassroomList(String center_id);
	public int insertCenter(String location);
	public int deleteCenter(String center_id);
}
