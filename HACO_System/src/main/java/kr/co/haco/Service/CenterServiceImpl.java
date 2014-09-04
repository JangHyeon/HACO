package kr.co.haco.Service;

import java.util.List;







import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.co.haco.DAO.CenterDAO;
import kr.co.haco.VO.Center;
import kr.co.haco.VO.CenterClassroom;



@Component
public class CenterServiceImpl implements CenterService{
	
	
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Center> getcenterList() {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(CenterDAO.class).getcenterList();
	}

	@Override
	public List<CenterClassroom> getclassroomList(String center_id) {
		// TODO Auto-generated method stub
				return sqlSession.getMapper(CenterDAO.class).getclassroomList(center_id);
	}

	@Override
	public int insertCenter(String location) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(CenterDAO.class).insertCenter(location);

	}

	@Override
	public int deleteCenter(String center_id) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(CenterDAO.class).deleteCenter(center_id);

	}

	@Override
	public int insertRoom(String center_id, String classroom) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(CenterDAO.class).insertRoom(center_id, classroom);

	}

	@Override
	public int deleteRoom(String center_classroom_id) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(CenterDAO.class).deleteRoom(center_classroom_id);

	}

}
