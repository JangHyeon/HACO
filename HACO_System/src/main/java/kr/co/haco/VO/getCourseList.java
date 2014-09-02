package kr.co.haco.VO;

import java.util.Date;

public class getCourseList {
   private int open_course_id;
   private String name_kor;
   private Date course_start_date;
   private Date course_end_date;
   private int classroom;
   private String subject_name;
   private String location;
   private String course_name;
   private int account_id;
   private int subject_id;
   private int center_id;
   private int startNum;
   private int pageNum;
   private int pageSize;
   private String searchType;
   private String searchKey;
   private int  center_classroom_id;
    
   public int getCenter_classroom_id() {
      return center_classroom_id;
   }

   public void setCenter_classroom_id(int center_classroom_id) {
      this.center_classroom_id = center_classroom_id;
   }

   public int getCenter_id() {
      return center_id;
   }

   public void setCenter_id(int center_id) {
      this.center_id = center_id;
   }

   public int getStartNum() {
      return startNum;
   }

   public void setStartNum(int startNum) {
      this.startNum = startNum;
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

   public String getSearchKey() {
      return searchKey;
   }

   public void setSearchKey(String searchKey) {
      this.searchKey = searchKey;
   }

   public int getSubject_id() {
      return subject_id;
   }

   public void setSubject_id(int subject_id) {
      this.subject_id = subject_id;
   }

   public int getAccount_id() {
      return account_id;
   }

   public void setAccount_id(int account_id) {
      this.account_id = account_id;
   }

   public String getCourse_name() {
      return course_name;
   }

   public void setCourse_name(String course_name) {
      this.course_name = course_name;
   }

   public int getOpen_course_id() {
      return open_course_id;
   }
   
   public void setOpen_course_id(int open_course_id) {
      this.open_course_id = open_course_id;
   }
   public String getName_kor() {
      return name_kor;
   }
   public void setName_kor(String name_kor) {
      this.name_kor = name_kor;
   }
   public Date getCourse_start_date() {
      return course_start_date;
   }
   public void setCourse_start_date(Date course_start_date) {
      this.course_start_date = course_start_date;
   }
   public Date getCourse_end_date() {
      return course_end_date;
   }
   public void setCourse_end_date(Date course_end_date) {
      this.course_end_date = course_end_date;
   }
   public int getClassroom() {
      return classroom;
   }
   public void setClassroom(int classroom) {
      this.classroom = classroom;
   }
   public String getSubject_name() {
      return subject_name;
   }
   public void setSubject_name(String subject_name) {
      this.subject_name = subject_name;
   }
   public String getLocation() {
      return location;
   }
   public void setLocation(String location) {
      this.location = location;
   }

}