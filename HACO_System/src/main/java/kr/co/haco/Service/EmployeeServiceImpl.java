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
		System.out.println(employee.getPhoto());
		
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		int account_id= employeeDAO.getAccountId();
		System.out.println("account_id:"+account_id);
		employeeDAO.addAccount(account_id);
		System.out.println("employeeDAO.addAccount(account_id)처리 완료");
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
		}else{
			System.out.println("EmployeeServiceImpl : emplist.size() :"+emplist.size());			
		}
		return emplist;
	}

	@Override
	public List<EducationCenter> getEduCenterList() {
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		List<EducationCenter> eduCenterList = null;
		eduCenterList = employeeDAO.getEduCenterList();
		System.out.println("첫번째center_id:"+eduCenterList.get(0).getCenter_id());
		return eduCenterList;
	}

	
}
