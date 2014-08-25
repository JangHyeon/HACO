package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.SubjectDAO;
import kr.co.haco.VO.Subject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SubjectServiceImpl implements SubjectService {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<Subject> getSubjectList() {
		return sqlSession.getMapper(SubjectDAO.class).getSubjectList();
	}
	@Override
	public List<Subject> getSubjectList2(String subject_id) {
		return sqlSession.getMapper(SubjectDAO.class).getSubjectList2(
				subject_id);
	}
	@Override
	public int insertSubject(Subject subject) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SubjectDAO.class).insertSubject(subject);
	}
	@Override
	public int updateSubject(Subject subject) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SubjectDAO.class).updateSubject(subject);
	}
	@Override
	public int deleteSubject(String subject_id) {
		// TODO Auto-generated method stub
		return sqlSession.getMapper(SubjectDAO.class).deleteSubject(subject_id);
	}

}
