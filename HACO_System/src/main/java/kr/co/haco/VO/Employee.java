package kr.co.haco.VO;

import java.sql.Date;

public class Employee{
	private int account_id;
	private int job_code;
	private String name_kor;
	private String name_eng;
	private String gender;
	private String address_registered;
	private String address_real;
	private String phone_home;
	private String phone_home1;
	private String phone_home2;
	private String phone_home3;
	private String phone_cell;
	private String phone_cell1;
	private String phone_cell2;
	private String phone_cell3;
	private int phone_emergency;
	private String email;
	private int salary;
	private String bank;
	private String bank_account;
	private String account_owner;
	private Date join_date;
	private int join_center_id;
	private int now_center_id;	
	private int resident_registration_num1;
	private int resident_registration_num2;
	private String photo;
	private String location;
	//추가
	private String user_id;
	
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public int getJob_code() {
		return job_code;
	}
	public void setJob_code(int job_code) {
		this.job_code = job_code;
	}
	public String getName_kor() {
		return name_kor;
	}
	public void setName_kor(String name_kor) {
		this.name_kor = name_kor;
	}
	public String getName_eng() {
		return name_eng;
	}
	public void setName_eng(String name_eng) {
		this.name_eng = name_eng;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAddress_registered() {
		return address_registered;
	}
	public void setAddress_registered(String address_registered) {
		this.address_registered = address_registered;
	}
	public String getAddress_real() {
		return address_real;
	}
	public void setAddress_real(String address_real) {
		this.address_real = address_real;
	}
	
	public String getPhone_home() {
		return phone_home1+"-"+phone_home2+"-"+phone_home3;
	}
	public void setPhone_home(String phone_home) {		
		String[] p = phone_home.split("-");
		phone_home1 = p[0];
		phone_home2 = p[1];
		phone_home3 = p[2];
	}
	public String getPhone_home1() {
		return phone_home1;
	}
	public void setPhone_home1(String phone_home1) {
		this.phone_home1 = phone_home1;
	}
	public String getPhone_home2() {
		return phone_home2;
	}
	public void setPhone_home2(String phone_home2) {
		this.phone_home2 = phone_home2;
	}
	public String getPhone_home3() {
		return phone_home3;
	}
	public void setPhone_home3(String phone_home3) {
		this.phone_home3 = phone_home3;
	}
	
	
	public String getPhone_cell() {
		return phone_cell1+"-"+phone_cell2+"-"+phone_cell3;
	}
	public void setPhone_cell(String phone_cell) {		
		String[] p = phone_cell.split("-");
		phone_cell1 = p[0];
		phone_cell2 = p[1];
		phone_cell3 = p[2];
	}
	public String getPhone_cell1() {
		return phone_cell1;
	}
	public void setPhone_cell1(String phone_cell1) {
		this.phone_cell1 = phone_cell1;
	}
	public String getPhone_cell2() {
		return phone_cell2;
	}
	public void setPhone_cell2(String phone_cell2) {
		this.phone_cell2 = phone_cell2;
	}
	public String getPhone_cell3() {
		return phone_cell3;
	}
	public void setPhone_cell3(String phone_cell3) {
		this.phone_cell3 = phone_cell3;
	}

	public int getPhone_emergency() {
		return phone_emergency;
	}
	public void setPhone_emergency(int phone_emergency) {
		this.phone_emergency = phone_emergency;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getBank_account() {
		return bank_account;
	}
	public void setBank_account(String bank_account) {
		this.bank_account = bank_account;
	}
	public String getAccount_owner() {
		return account_owner;
	}
	public void setAccount_owner(String account_owner) {
		this.account_owner = account_owner;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public int getJoin_center_id() {
		return join_center_id;
	}
	public void setJoin_center_id(int join_center_id) {
		this.join_center_id = join_center_id;
	}
	public int getNow_center_id() {
		return now_center_id;
	}
	public void setNow_center_id(int now_center_id) {
		this.now_center_id = now_center_id;
	}
	public int getResident_registration_num1() {
		return resident_registration_num1;
	}
	public void setResident_registration_num1(int resident_registration_num1) {
		this.resident_registration_num1 = resident_registration_num1;
	}
	public int getResident_registration_num2() {
		return resident_registration_num2;
	}
	public void setResident_registration_num2(int resident_registration_num2) {
		this.resident_registration_num2 = resident_registration_num2;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id.toLowerCase();
	}	
	
}
