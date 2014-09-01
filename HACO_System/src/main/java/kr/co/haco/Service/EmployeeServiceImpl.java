package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;

import kr.co.haco.DAO.EmployeeDAO;
import kr.co.haco.VO.Authority;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EmployeeList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


/*
 <!-- 컨트롤러/컴포넌트 스캔 -->
<context:component-scan base-package="kr.co.haco.Controller  
									kr.co.haco.Service" />
위처럼 패키지 단위의 스캔을 사용할 때는 @Component 어노테이션을 class위에 선언해주어야 bean이 생성된다.
*/
@Component
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	SqlSession sqlSession;
	
	//직원 등록
	@Override	
	public HashMap<String, Integer> addEmployee(Employee employee) {		
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		int result=0;
		//1.account테이블에 추가
		result += employeeDAO.addAccount();
		//2. 1번에서 추가된 account_id 조회
		int account_id = employeeDAO.getAccountId();
		//3. account의 id컬럼에 account_id값 넣어주기 
		result += employeeDAO.setUserId(account_id);
		//4. 계정권한 등록
		String role_name="";
		if(employee.getJob_code()==1){ //강사
			role_name="TEACHER";
		}else if(employee.getJob_code()==2){ //관리직원
			role_name="MANAGER";  
		}else if(employee.getJob_code()==3){ //센터장
			role_name="CENTER";
		}
		Authority authority = new Authority(account_id,role_name);
		result += employeeDAO.setAuthority(authority);
		//5. employee테이블에 추가
		employee.setAccount_id(account_id);
		result += employeeDAO.addEmployee(employee);		
		
		//return값 생성
		HashMap<String, Integer> resultMap = new HashMap<String, Integer>();
		resultMap.put("result", result);
		resultMap.put("account_id", account_id);
		return resultMap;
	}
	
	//직원 목록 조회
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

	//센터 목록 조회
	@Override
	public List<EducationCenter> getEduCenterList() {
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		List<EducationCenter> eduCenterList = null;
		eduCenterList = employeeDAO.getEduCenterList();
		
		return eduCenterList;
	}
	
	//직원 상세정보 조회
	@Override
	public Employee getEmp(int account_id) {
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		String user_id = employeeDAO.getUserId(account_id);		
		Employee emp = employeeDAO.getEmp(account_id);
		emp.setUser_id(user_id);
		
		return emp;
	}
	
	//직원 상세정보 수정
	@Override
	public int updateEmp(Employee emp) {
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);
		int result = 0;		
		result += employeeDAO.updateEmp(emp);
		
		return result;
	}
	
}
