package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.haco.DAO.EmployeeDAO;
import kr.co.haco.VO.Authority;
import kr.co.haco.VO.EducationCenter;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.EmployeeList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;


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
	public void getEmplList(int job_code,int now_center_id,Model model,int pageNum, int pageSize) {
		// TODO Auto-generated method stub
		EmployeeDAO employeeDAO = sqlSession.getMapper(EmployeeDAO.class);	
		
		//for페이징
	      int startNum = pageNum * pageSize - (pageSize -1)-1;      
	      System.out.println("startNum:"+startNum);
	      
	      //DAO에 보낼 parameter
	      Map<String, Integer> paraMap = new HashMap<String, Integer>();            
	      paraMap.put("startNum", startNum);
	      paraMap.put("pageSize", pageSize);      
	      paraMap.put("job_code", job_code); 
	      paraMap.put("now_center_id", now_center_id); 
	      
	      //DAO로부터 데이터 select수행      
	      List<EmployeeList> emplist = employeeDAO.getEmpList(paraMap);
	      if(emplist == null || emplist.size()==0){
				System.out.println("EmployeeServiceImpl : emplist가 null입니다.");
			}
	      model.addAttribute("emplist", emplist);      
	      
	      // 검색된 총 게시물 건수      
	      int employeeCount = employeeDAO.getEmployeeCount(paraMap);
	      
	      // 페이징 처리      
	      int visiblePageNum = 10;
	      int pagecount = 0;
	      int beginPage = 0;
	      int endPage = 0;
	      if (employeeCount != 0) {// 게시물이 없는 경우
	         pagecount = employeeCount / pageSize;// 115건 = 11page
	         if (employeeCount % pageSize > 0) {// 115건 = 나머지 5 true
	            pagecount++;// 11page++ = 12page
	         }
	         beginPage = (pageNum - 1) / visiblePageNum * visiblePageNum + 1;// 10단위 계산
	         endPage = beginPage + (visiblePageNum - 1);
	         if (endPage > pagecount) {
	            endPage = pagecount;
	         }
	      }
	      
	      // view에 보낼 데이터
	      model.addAttribute("pagecount", pagecount);
	      model.addAttribute("beginpage", beginPage);
	      model.addAttribute("endpage", endPage);
	
	      model.addAttribute("pageNum",pageNum);
	      model.addAttribute("pageSize",pageSize);
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
