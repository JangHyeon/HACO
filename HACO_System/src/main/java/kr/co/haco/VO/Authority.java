package kr.co.haco.VO;


public class Authority{
	private int account_id;
	private String role_name;
	
	public Authority(){}
	
	public Authority(int account_id, String role_name){
		this.account_id = account_id;
		this.role_name = role_name;
	}
	
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}	
}
