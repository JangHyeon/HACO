package kr.co.haco.VO;

import java.sql.Timestamp;



public class Member{
	private int account_id;
	private String name;
	private String zipcode;
	private String address;
	private String address_detail;
	private String email;
	private String phone;
	private String phoneNum1;
	private String phoneNum2;
	private String phoneNum3;
	
	private String company;
	private String position;
	private String job_duty;
	private Timestamp create_date;
	
	
	public Member() {}
	
	public Member(int account_id) {
		this.account_id = account_id;
	}
	public Member(String name, String email){
		this.name = name;
		this.email = email;
	}
	
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress_detail() {
		return address_detail;
	}
	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	
	public String getPhone() {
		this.phone = getPhoneNum1()+"-"+getPhoneNum2()+"-"+getPhoneNum3();
		return this.phone;
	}
	public void setPhone(String phone) {
		String[] phonenum = phone.split("-");
		this.phoneNum1 = phonenum[0];
		this.phoneNum2 = phonenum[1];
		this.phoneNum3 = phonenum[2];
	}
	

	public String getPhoneNum1() {
		return phoneNum1;
	}
	public void setPhoneNum1(String phoneNum1) {
		this.phoneNum1 = phoneNum1;
	}
	public String getPhoneNum2() {
		return phoneNum2;
	}
	public void setPhoneNum2(String phoneNum2) {
		this.phoneNum2 = phoneNum2;
	}
	public String getPhoneNum3() {
		return phoneNum3;
	}
	public void setPhoneNum3(String phoneNum3) {
		this.phoneNum3 = phoneNum3;
	}
	
	
	
	public String getCompany() {
		return company;
	}
	public void setCompany(String pompany) {
		this.company = pompany;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getJob_duty() {
		return job_duty;
	}
	public void setJob_duty(String job_duty) {
		this.job_duty = job_duty;
	}
	public Timestamp getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}
	
	
}
