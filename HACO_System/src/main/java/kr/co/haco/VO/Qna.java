package kr.co.haco.VO;

import java.sql.Timestamp;


public class Qna{
	private String error;
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}

	
	
	private int startNum;
	
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	
	private int group_no;
	private int insert_group_no;
	
	
	public int getGroup_no() {
		return this.group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	

	public int getInsert_group_no() {
		return insert_group_no;
	}
	public void setInsert_group_no(int insert_group_no) {
		this.insert_group_no = insert_group_no;
	}
	
	

	private char divide_code;
	private String divide_code_toString;

	public String getDivide_code_toString() {
		return divide_code_toString;
	}
	public void setDivide_code_toString(String divide_code_toString) {
		this.divide_code_toString = divide_code_toString;
	}
	

	public char getDivide_code() {
		return divide_code;
	}
	public void setDivide_code(char divide_code) {
		this.divide_code = divide_code;
	}
	
	

	private int pageNum;
	private int pageSize;
	private String searchType;
	private String searchKey;
	

	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	

	private String name;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	

	private String name_kor;
	private String name_eng;
	
	private int qna_id;

	public int getQna_id() {
		return qna_id;
	}
	public void setQna_id(int qna_id) {
		this.qna_id = qna_id;
	}
	
	private int account_id;
	private Timestamp register_date;
	private String register_date_string;
	
	public String getRegister_date_string() {
		return register_date_string;
	}
	public void setRegister_date_string(String register_date_string) {
		this.register_date_string = register_date_string;
	}

	private String title;
	private int state_code;
	private String content;
	private int hit;
	
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public Timestamp getRegister_date() {
		return register_date;
	}
	public void setRegister_date(Timestamp register_date) {
		this.register_date = register_date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getState_code() {
		return state_code;
	}
	public void setState_code(int state_code) {
		this.state_code = state_code;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}

	
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
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
}
