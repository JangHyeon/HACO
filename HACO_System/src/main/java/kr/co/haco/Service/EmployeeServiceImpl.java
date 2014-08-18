package kr.co.haco.Service;

import java.util.List;

import kr.co.haco.DAO.EmployeeDAO;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EmployeeList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	SqlSession sqlSession;
	
	@Override	
	public void addEmployee(Employee employee) {		
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		
		//1.account테이블에 추가
		employeeDAO.addAccount();
		//2. 1번에서 추가된 account_id 조회
		int account_id = employeeDAO.getAccountId();
		//3. account의 id컬럼에 account_id값 업데이트 하기 
		employeeDAO.setUserId(account_id);
		//4. employee테이블에 추가
		employee.setAccount_id(account_id);
		employeeDAO.addEmployee(employee);		
	}
	
	@Override
	public List<EmployeeList> getEmplList(int job_code,int now_center_id) {
		// TODO Auto-generated method stub
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		List<EmployeeList> emplist = null;
		emplist = employeeDAO.getEmpList(job_code,now_center_id);
		
		if(emplist == null || emplist.size()==0){
			System.out.println("EmployeeServiceImpl : emplist가 null입니다.");
		}
		
		return emplist;
	}

	@Override
	public List<EducationCenter> getEduCenterList() {
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		List<EducationCenter> eduCenterList = null;
		eduCenterList = employeeDAO.getEduCenterList();
		//System.out.println("첫번째center_id:"+eduCenterList.get(0).getCenter_id());
		return eduCenterList;
	}

	@Override
	public Employee getEmp(int account_id) {
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		Employee emp = employeeDAO.getEmp(account_id);
		
		return emp;
	}
	
}
