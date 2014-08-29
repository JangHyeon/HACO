package kr.co.haco.VO;

public class Teacher {
	private String name_kor;
	private int account_id;
	private String profile_photo;
	private String profile_content;
	private String introduction;
	public Teacher(){}
	public String getName_kor() {
		return name_kor;
	}
	public void setName_kor(String name_kor) {
		this.name_kor = name_kor;
	}
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public String getProfile_photo() {
		return profile_photo;
	}
	public void setProfile_photo(String profile_photo) {
		this.profile_photo = profile_photo;
	}
	public String getProfile_content() {
		return profile_content;
	}
	public void setProfile_content(String profile_content) {
		this.profile_content = profile_content;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	
	
}
