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
	private String phone_cell;
	private int phone_emergency;
	private String email;
	private int salary;
	private String bank;
	private String bank_account;
	private String account_owner;
	private Date join_date;
	private String join_center;
	private int center_id;	
	private int resident_registration_num1;
	private int resident_registration_num2;
	private String photo;
	
	//getter,setter
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
		return phone_home;
	}
	public void setPhone_home(String phone_home) {
		this.phone_home = phone_home;
	}
	public String getPhone_cell() {
		return phone_cell;
	}
	public void setPhone_cell(String phone_cell) {
		this.phone_cell = phone_cell;
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
	public String getJoin_center() {
		return join_center;
	}
	public void setJoin_center(String join_center) {
		this.join_center = join_center;
	}
	public int getCenter_id() {
		return center_id;
	}
	public void setCenter_id(int center_id) {
		this.center_id = center_id;
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
	
	
	
	
}
