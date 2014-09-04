package kr.co.haco.VO;

import java.sql.Date;
import java.sql.Time;

public class Subject {
   private int subject_id;
   private String subject_name;
   private int capacity;
   private String subject_explanation;
   private String instructional_objectives;
   private String subject_point;
   private String lecture_target;
   private int lecture_totalday;
   private int lecture_totaltime;
   private int tuition_fee;
   private String lecture_content;
   private Date create_date;
   private Date update_date;
   private int center_id;
   //private String lecture_time;  -> lecture_time_start/lecture_time_start으로변경
   private Time  lecture_time_start;
   private Time  lecture_time_end;
   private String course_name;
   private String name_kor;
   private Date course_start_date;
   private Date course_end_date;
   private String course_id;
   private String location;
   private int CNT;
   private String name;
   private String open_course_id;
   private int account_id;
   
   private String lecture_totalday_String;
   private String  capacity_String;
   private String  tuition_fee_String;
   
   
   public String getLecture_totalday_String() {
	return lecture_totalday_String;
}

public void setLecture_totalday_String(String lecture_totalday_String) {
	this.lecture_totalday_String = lecture_totalday_String;
}

public String getCapacity_String() {
	return capacity_String;
}

public void setCapacity_String(String capacity_String) {
	this.capacity_String = capacity_String;
}

public String getTuition_fee_String() {
	return tuition_fee_String;
}

public void setTuition_fee_String(String tuition_fee_String) {
	this.tuition_fee_String = tuition_fee_String;
}

public Subject(){}
   
   public Subject(int subject_id, String subject_name, int capacity,
         String subject_explanation, String instructional_objectives,
         String subject_point, String lecture_target, int lecture_totalday,
           int tuition_fee, String lecture_content,
          int center_id,Time lecture_time_start, Time lecture_time_end,int lecture_totaltime) {
      super();
      this.subject_id= subject_id;
      this.subject_name = subject_name;
      this.capacity = capacity;
      this.subject_explanation = subject_explanation;
      this.instructional_objectives = instructional_objectives;
      this.subject_point = subject_point;
      this.lecture_target = lecture_target;
      this.lecture_totalday = lecture_totalday;
      this.tuition_fee = tuition_fee;
      this.lecture_content = lecture_content;
      this.center_id = center_id;
      this.lecture_time_start = lecture_time_start;
      this.lecture_time_end = lecture_time_end;
      this.lecture_totaltime = lecture_totaltime;
      
   }
   public Subject(int subject_id, String subject_name, int capacity,
         String subject_explanation, String instructional_objectives,
         String subject_point, String lecture_target, int lecture_totalday,
           int tuition_fee, String lecture_content,
          Time lecture_time_start, Time lecture_time_end,int lecture_totaltime) {
      super();
      this.subject_id= subject_id;
      this.subject_name = subject_name;
      this.capacity = capacity;
      this.subject_explanation = subject_explanation;
      this.instructional_objectives = instructional_objectives;
      this.subject_point = subject_point;
      this.lecture_target = lecture_target;
      this.lecture_totalday = lecture_totalday;
      this.tuition_fee = tuition_fee;
      this.lecture_content = lecture_content;
      this.lecture_time_start = lecture_time_start;
      this.lecture_time_end = lecture_time_end;
      this.lecture_totaltime = lecture_totaltime;
      
   }


   public int getSubject_id() {
      return subject_id;
   }
   
   public void setSubject_id(int subject_id) {
      this.subject_id = subject_id;
   }
   public String getSubject_name() {
      return subject_name;
   }
   public void setSubject_name(String subject_name) {
      this.subject_name = subject_name;
   }
   public int getCapacity() {
      return capacity;
   }
   public void setCapacity(int capacity) {
      this.capacity = capacity;
   }
   public String getSubject_explanation() {
      return subject_explanation;
   }
   public void setSubject_explanation(String subject_explanation) {
      this.subject_explanation = subject_explanation;
   }
   public String getInstructional_objectives() {
      return instructional_objectives;
   }
   public void setInstructional_objectives(String instructional_objectives) {
      this.instructional_objectives = instructional_objectives;
   }
   public String getSubject_point() {
      return subject_point;
   }
   public void setSubject_point(String subject_point) {
      this.subject_point = subject_point;
   }
   public String getLecture_target() {
      return lecture_target;
   }
   public void setLecture_target(String lecture_target) {
      this.lecture_target = lecture_target;
   }
   public int getLecture_totalday() {
      return lecture_totalday;
   }
   public void setLecture_totalday(int lecture_totalday) {
      this.lecture_totalday = lecture_totalday;
   }
   public int getLecture_totaltime() {
      return lecture_totaltime;
   }
   public void setLecture_totaltime(int lecture_totaltime) {
      this.lecture_totaltime = lecture_totaltime;
   }
   public int getTuition_fee() {
      return tuition_fee;
   }
   public void setTuition_fee(int tuition_fee) {
      this.tuition_fee = tuition_fee;
   }
   public String getLecture_content() {
      return lecture_content;
   }
   public void setLecture_content(String lecture_content) {
      this.lecture_content = lecture_content;
   }
   public Date getCreate_date() {
      return create_date;
   }
   public void setCreate_date(Date create_date) {
      this.create_date = create_date;
   }
   public Date getUpdate_date() {
      return update_date;
   }
   public void setUpdate_date(Date update_date) {
      this.update_date = update_date;
   }
   public int getCenter_id() {
      return center_id;
   }
   public void setCenter_id(int center_id) {
      this.center_id = center_id;
   }
   public Time getLecture_time_start() {
      return lecture_time_start;
   }
   public void setLecture_time_start(Time lecture_time_start) {
      this.lecture_time_start = lecture_time_start;
   }
   public Time getLecture_time_end() {
      return lecture_time_end;
   }
   public void setLecture_time_end(Time lecture_time_end) {
      this.lecture_time_end = lecture_time_end;
   }

   public String getCourse_name() {
      return course_name;
   }

   public void setCourse_name(String course_name) {
      this.course_name = course_name;
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

   public String getCourse_id() {
      return course_id;
   }

   public void setCourse_id(String course_id) {
      this.course_id = course_id;
   }

   public String getLocation() {
      return location;
   }

   public void setLocation(String location) {
      this.location = location;
   }

   public int getCNT() {
      return CNT;
   }

   public void setCNT(int cNT) {
      CNT = cNT;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   public String getOpen_course_id() {
      return open_course_id;
   }

   public void setOpen_course_id(String open_course_id) {
      this.open_course_id = open_course_id;
   }

   public int getAccount_id() {
      return account_id;
   }

   public void setAccount_id(int account_id) {
      this.account_id = account_id;
   }
   
   
   
   
   
   
   
   
}