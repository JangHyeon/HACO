package kr.co.haco.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import kr.co.haco.DAO.AccountDAO;
import kr.co.haco.Util.StringUtils;
import kr.co.haco.VO.Account;
import kr.co.haco.VO.Authority;
import kr.co.haco.VO.Employee;
import kr.co.haco.VO.Member;
import kr.co.haco.VO.Roles;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccountServiceImpl implements AccountService {

	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	private EmailSender emailSender;
	
	private static final Logger logger = LoggerFactory.getLogger(AccountServiceImpl.class);

	@Override
	public List<Roles> getRoleList() {
		return sqlSession.getMapper(AccountDAO.class).getRoleList();
	}

	@Override
	public Employee getEmployee(String account_id) {
		return sqlSession.getMapper(AccountDAO.class).getEmployee(account_id);
	}

	@Override
	public String checkId(String id) {
		String result;
		if (sqlSession.getMapper(AccountDAO.class).checkId(id) == null) {
			result = "ok";
		} else {
			result = "error";
		}
		return result;
	}

	@Override
	public void joinMember(Account account, Member member, StringBuffer contextURL) {
		account.setActivation_key(UUID.randomUUID().toString().replace("-",	""));								//인증코드 생성
		sqlSession.getMapper(AccountDAO.class).insertAccount(account);											//계정등록
		member.setAccount_id(sqlSession.getMapper(AccountDAO.class).getLastInsertId());							//방금 등록된계정 account_id값 추출
		sqlSession.getMapper(AccountDAO.class).insertAuthority(new Authority(member.getAccount_id(),"GUEST"));	//계정권한 등록
		if(sqlSession.getMapper(AccountDAO.class).insertMember(member)==1){										//회원정보 등록 및 인증 이메일발송
			logger.info("[joinMember] - insertMember:["+member.getAccount_id()+"] / 회원가입 성공");
			try {
				String from = "haco@haco.co.kr";
				String to = member.getEmail();
				String subject="HACO :: 이메일 인증 메일입니다.";
				
				String formatUrl = "emailTemplate.html";
				
				Map<String, Object> model = new HashMap<String, Object>();
				model.put("homepage", contextURL);															//사이트경로
				model.put("memberName", member.getName());													//회원이름
				model.put("activationUrl", contextURL+"accountActivation/"+account.getActivation_key());	//인증경로

				emailSender.SendEmail(from,to,subject,model,formatUrl);										//이메일 발송
				logger.info("[joinMember] - SendEmail:["+to+"]["+account.getActivation_key()+"] / 인증 이메일 발송");
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			
		};
	}


	@Override
	public String accountActivation(String activation_key) {
		Account account = sqlSession.getMapper(AccountDAO.class).getAccount(new Account(activation_key));
		if(account==null){
			logger.info("[accountActivation] - activation_key:["+activation_key+"] / 없는 활성키");
			return "errorKey";
		}else if(account.getState_code()==0){
			if(sqlSession.getMapper(AccountDAO.class).accountActivation(activation_key) == 1 ? true : false){
				logger.info("[accountActivation] - account_id:["+account.getAccount_id()+"] / 계정 활성화");
				return "success";
			}
			logger.info("[accountActivation] - account_id:["+account.getAccount_id()+"] / 계정 활성화 실패");
			return "false";
		}else{
			logger.info("[accountActivation] - account_id:["+account.getAccount_id()+"] / 이미 활성화된 계정");
			return "noChange";
		}
	}

	@Override
	public Member getMemberToActivationKey(String activation_key) {
		Account account = sqlSession.getMapper(AccountDAO.class).getAccount(new Account(activation_key));
		if(account!=null){
			logger.info("[getMemberToActivationKey] - account_id:["+account.getAccount_id()+"] activation_key:["+activation_key+"] / 회원 정보 출력");
			return sqlSession.getMapper(AccountDAO.class).getMember(new Member(account.getAccount_id()));
		}
		return null;
	}

	@Override
	public Member getMemberToAccount_id(String account_id) {
		logger.info("[getMemberToAccount_id] - account_id:["+account_id+"] / 회원 정보 출력");
		return sqlSession.getMapper(AccountDAO.class).getMember(new Member(Integer.parseInt(account_id)));
	}

	@Override
	public Account getAccountToAccount_id(String account_id) {
		Account account = new Account();
		account.setAccount_id(Integer.parseInt(account_id));
		logger.info("[getAccountToAccount_id] - account_id:["+account_id+"] / 계정 정보 출력");
		return sqlSession.getMapper(AccountDAO.class).getAccount(account);
	}

	@Override
	public boolean updateMember(Account account, Member member) {
		member.setAccount_id(account.getAccount_id());
		if(sqlSession.getMapper(AccountDAO.class).updateAccount(account)==1 
				&& sqlSession.getMapper(AccountDAO.class).updateMember(member)==1){ 
			logger.info("[updateMember] - account_id:["+account.getAccount_id()+"] / 회원 정보 수정");
			return true;
		}
		return false;
	}

	@Override
	public boolean deleteMember(Account account) {
		String password = account.getPassword();
		account = sqlSession.getMapper(AccountDAO.class).getAccount(account);
		account.setId("//del_"+account.getId());
		account.setPassword(password);
		if(sqlSession.getMapper(AccountDAO.class).disableAccount(account)==1){
			logger.info("[deleteMember] - account_id:["+account.getAccount_id()+"] / 회원 탈퇴 처리");
			return true;
		}
		return false;
	}

	@Override
	public String findId(String name, String email) {
		if((name!=null && !name.equals("")) || (email!=null && !email.equals(""))){
			Member member = new Member(name, email);
			member = sqlSession.getMapper(AccountDAO.class).getMember(member);
			if(member!=null){
				Account account = new Account();
				account.setAccount_id(member.getAccount_id());
				account = sqlSession.getMapper(AccountDAO.class).getAccount(account);
				logger.info("[findId] - account_id:["+member.getAccount_id()+"] / 아이디 찾기");
				
				//삭제 계정 예외 처리
				System.out.println(account.getId().substring(0, 6));
				if(account.getId().substring(0, 6).equals("//del_")){
					return "notFindID";
				}
				return account.getId();
			}
		}
		return "notFindID";
	}

	@Override
	public String findPassword(String id, String email, StringBuffer contextURL) {
		if((id!=null && !id.equals("")) || (email!=null && !email.equals(""))){
			Account account = new Account();
			account.setId(id);
			account = sqlSession.getMapper(AccountDAO.class).getAccount(account);
			
			if(account!=null){
				Member member = new Member();
				member.setEmail(email);
				member.setAccount_id(account.getAccount_id());
				member = sqlSession.getMapper(AccountDAO.class).getMember(member);
				
				if(member!=null){
					Account passAccount = new Account();
					passAccount.setAccount_id(account.getAccount_id());
					passAccount.setPassword(StringUtils.randomPassword(7));
					
					if(sqlSession.getMapper(AccountDAO.class).updateAccount(passAccount)==1){
						logger.info("[findPassword] - account_id:["+member.getAccount_id()+"] / 비밀번호 찾기");
						logger.info("[findPassword] - password:["+passAccount.getPassword()+"] / 임시비밀번호로 변경");
						try {
							String from = "haco@haco.co.kr";
							String to = member.getEmail();
							String subject="HACO :: 비밀번호 찾기 메일입니다.";
							
							String formatUrl = "emailTemplatePassword.html";
							
							Map<String, Object> model = new HashMap<String, Object>();
							model.put("homepage", contextURL);											//사이트경로
							model.put("memberName", member.getName());									//회원이름
							model.put("password", passAccount.getPassword());								//비밀번호
		
							emailSender.SendEmail(from,to,subject,model,formatUrl);										//이메일 발송
							logger.info("[findPassword] - SendEmail:["+to+"]["+account.getActivation_key()+"] / 비밀번호 찾기 이메일 발송");
						} catch (Exception e) {
							e.printStackTrace();
							System.out.println(e.getMessage());
						}
						return "Find";
					}
				}
			}
		}
		return "notFind";
	}
	
	
}
