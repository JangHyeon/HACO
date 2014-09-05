-- 테이블 갯수 총 23개;
-- 코드성 테이블;
CREATE TABLE `code_attendance` (
  `attendance_code` int(3) NOT NULL COMMENT '출결코드',
  `attendance_state_name` varchar(10) NOT NULL COMMENT '1 지각\r\n	2 조퇴\r\n	3 결석',
  PRIMARY KEY (`attendance_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='출결 코드';

CREATE TABLE `code_job` (
  `job_code` int(3) NOT NULL COMMENT '1 강사\r\n	2 직원\r\n	3 센터장',
  `job_name` varchar(20) NOT NULL COMMENT '직무명',
  PRIMARY KEY (`job_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='직무코드';

CREATE TABLE `code_lecture_register` (
  `lecture_register_code` int(3) NOT NULL COMMENT '수강신청상태코드',
  `lecture_register_name` varchar(10) NOT NULL COMMENT '1 신청	2 허가	3 납부완료',
  PRIMARY KEY (`lecture_register_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='수강신청 코드';

CREATE TABLE `code_state` (
  `state_code` int(11) NOT NULL COMMENT '상태코드',
  `state_name` varchar(20) NOT NULL COMMENT '상태명',
  PRIMARY KEY (`state_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='계정상태';


CREATE TABLE `education_center` (
  `center_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '교육센터ID',
  `location` varchar(10) NOT NULL COMMENT '지점명',
  `state` int(11) DEFAULT '1' COMMENT '1 공개글 0 삭제글',
  PRIMARY KEY (`center_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='교육센터';

-- 계정;
CREATE TABLE `roles` (
  `role_name` varchar(20) NOT NULL COMMENT '권한명',
  `role_desc` varchar(50) NOT NULL COMMENT '권한설명',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  PRIMARY KEY (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT=' 권한';

CREATE TABLE `account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '계정ID',
  `state_code` int(11) DEFAULT '0',
  `id` varchar(20) DEFAULT NULL,
  `password` varchar(50) NOT NULL COMMENT '비밀번호',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activation_key` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `UIX_account_id` (`id`),
  KEY `FK_account_state_code` (`state_code`),
  CONSTRAINT `FK_account_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='계정';


CREATE TABLE `employee` (
  `account_id` int(11) NOT NULL COMMENT '계정ID',
  `job_code` int(3) DEFAULT NULL COMMENT '직무코드',
  `name_kor` varchar(10) NOT NULL COMMENT '한글성명',
  `name_eng` varchar(20) NOT NULL COMMENT '영문성명',
  `gender` char(1) NOT NULL COMMENT '성별',
  `address_registered` varchar(100) DEFAULT NULL,
  `address_real` varchar(100) DEFAULT NULL,
  `phone_home` varchar(13) DEFAULT NULL,
  `phone_cell` varchar(13) NOT NULL,
  `phone_emergency` varchar(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL COMMENT '급여',
  `bank` varchar(50) DEFAULT NULL COMMENT '은행명',
  `bank_account` varchar(20) DEFAULT NULL COMMENT '계좌번호',
  `account_owner` varchar(10) DEFAULT NULL COMMENT '예금주명',
  `join_date` date NOT NULL COMMENT '입사일자',
  `join_center_id` int(11) NOT NULL,
  `photo` varchar(50) DEFAULT NULL,
  `resident_registration_num1` int(11) NOT NULL COMMENT '주민등록번호앞',
  `now_center_id` int(11) NOT NULL,
  `resident_registration_num2` int(11) NOT NULL COMMENT '주민등록번호뒤',
  PRIMARY KEY (`account_id`),
  KEY `FK_employee_job_code` (`job_code`),
  KEY `FK_employee_join_center_id` (`join_center_id`),
  KEY `FK_employee_now_center_id` (`now_center_id`),
  CONSTRAINT `FK_account_TO_employee` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `FK_employee_job_code` FOREIGN KEY (`job_code`) REFERENCES `code_job` (`job_code`) ON UPDATE CASCADE,
  CONSTRAINT `FK_employee_join_center_id` FOREIGN KEY (`join_center_id`) REFERENCES `education_center` (`center_id`),
  CONSTRAINT `FK_employee_now_center_id` FOREIGN KEY (`now_center_id`) REFERENCES `education_center` (`center_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='직원';

CREATE TABLE `member` (
  `account_id` int(11) NOT NULL COMMENT '계정ID',
  `name` varchar(10) NOT NULL COMMENT '성명',
  `zipcode` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL COMMENT '기본주소',
  `address_detail` varchar(100) DEFAULT NULL COMMENT '상세주소',
  `email` varchar(50) NOT NULL COMMENT '이메일',
  `phone` varchar(13) NOT NULL,
  `company` varchar(50) DEFAULT NULL COMMENT '근무_회사명',
  `position` varchar(50) DEFAULT NULL COMMENT '직위',
  `job_duty` varchar(50) DEFAULT NULL COMMENT '직무',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '가입일자',
  PRIMARY KEY (`account_id`),
  CONSTRAINT `FK_member_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원';

CREATE TABLE `authority` (
  `account_id` int(11) NOT NULL COMMENT '계정ID',
  `role_name` varchar(20) NOT NULL COMMENT '권한명',
  KEY `FK_authority_account_id` (`account_id`),
  KEY `FK_authority_role_name` (`role_name`),
  CONSTRAINT `FK_authority_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_authority_role_name` FOREIGN KEY (`role_name`) REFERENCES `roles` (`role_name`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='계정권한';

-- 과목, 과정;
CREATE TABLE `center_classroom` (
  `center_classroom_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '교육센터별강의실ID',
  `center_id` int(11) DEFAULT NULL COMMENT '교육센터ID',
  `classroom` int(11) DEFAULT NULL COMMENT '강의실',
  PRIMARY KEY (`center_classroom_id`),
  KEY `FK_center_classroom_center_id` (`center_id`),
  CONSTRAINT `FK_center_classroom_center_id` FOREIGN KEY (`center_id`) REFERENCES `education_center` (`center_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='개설과정';

CREATE TABLE `subject` (
  `subject_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '과목ID',
  `subject_name` varchar(20) NOT NULL COMMENT '과목명',
  `capacity` int(11) NOT NULL COMMENT '정원',
  `subject_explanation` varchar(2000) DEFAULT NULL COMMENT '과목설명',
  `instructional_objectives` varchar(2000) DEFAULT NULL COMMENT '학습목표',
  `subject_point` varchar(2000) DEFAULT NULL COMMENT '과목의특장점',
  `lecture_target` varchar(50) DEFAULT NULL COMMENT '수강대상',
  `lecture_totalday` int(3) DEFAULT NULL COMMENT '총강의일수',
  `lecture_totaltime` int(20) DEFAULT NULL,
  `tuition_fee` int(11) DEFAULT NULL COMMENT '수강료',
  `lecture_content` varchar(2000) DEFAULT NULL COMMENT '강의내용',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  `center_id` int(11) NOT NULL COMMENT '교육센터ID',
  `lecture_time_start` time DEFAULT NULL,
  `lecture_time_end` time DEFAULT NULL,
  `state` int(11) DEFAULT '1' COMMENT '1 공개글 0 삭제글',
  PRIMARY KEY (`subject_id`),
  KEY `FK_common_subject_center_id` (`center_id`),
  CONSTRAINT `FK_common_subject_center_id` FOREIGN KEY (`center_id`) REFERENCES `education_center` (`center_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='과목';

CREATE TABLE `open_course` (
  `open_course_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '개설과정ID',
  `account_id` int(11) NOT NULL COMMENT '강사ID',
  `subject_id` int(11) DEFAULT NULL COMMENT '과목ID',
  `course_name` varchar(50) NOT NULL COMMENT '과정명',
  `course_start_date` date NOT NULL COMMENT '과정시작일자',
  `course_end_date` date NOT NULL COMMENT '과정종료일자',
  `center_id` int(11) DEFAULT NULL COMMENT '교육센터ID',
  `center_classroom_id` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT '1' COMMENT '1 공개글 0 삭제글',
  PRIMARY KEY (`open_course_id`),
  KEY `FK_open_course_account_id` (`account_id`),
  KEY `FK_open_course_subject_id` (`subject_id`),
  KEY `FK_open_course_center_id` (`center_id`),
  KEY `FK_open_course_center_classroom_id` (`center_classroom_id`),
  CONSTRAINT `FK_open_course_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_open_course_center_classroom_id` FOREIGN KEY (`center_classroom_id`) REFERENCES `center_classroom` (`center_classroom_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_open_course_center_id` FOREIGN KEY (`center_id`) REFERENCES `education_center` (`center_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_open_course_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='개설과정';

-- 수강신청 ;
CREATE TABLE `lecture_register` (
  `lecture_register_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '수강신청ID',
  `open_course_id` int(11) NOT NULL COMMENT '개설과정ID',
  `account_id` int(11) NOT NULL COMMENT '계정ID',
  `lecture_register_code` int(3) NOT NULL COMMENT '수강신청상태코드',
  `lecture_register_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수강신청날짜',
  `is_survey` char(1) NOT NULL DEFAULT 'N' COMMENT 'N 설문안함	Y 설문완료',
  PRIMARY KEY (`lecture_register_id`),
  UNIQUE KEY `lecture_regist_unique` (`open_course_id`,`account_id`),
  KEY `FK_lecture_register_account_id` (`account_id`),
  KEY `FK_lecture_register_lecture_register_code` (`lecture_register_code`),
  CONSTRAINT `FK_lecture_register_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_lecture_register_lecture_register_code` FOREIGN KEY (`lecture_register_code`) REFERENCES `code_lecture_register` (`lecture_register_code`) ON UPDATE CASCADE,
  CONSTRAINT `FK_lecture_register_open_course_id` FOREIGN KEY (`open_course_id`) REFERENCES `open_course` (`open_course_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='수강신청';

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '출석ID',
  `lecture_register_id` int(11) NOT NULL COMMENT '수강신청ID',
  `attendance_code` int(3) NOT NULL COMMENT '출결코드',
  `attendance_date` varchar(10) NOT NULL,
  `center_id` int(11) NOT NULL COMMENT '교육센터ID',
  `open_course_id` int(11) NOT NULL COMMENT '개설과정ID',
  PRIMARY KEY (`attendance_id`),
  UNIQUE KEY `u_index_attendance` (`lecture_register_id`,`attendance_date`),
  KEY `attendance` (`attendance_code`),
  KEY `center` (`center_id`),
  KEY `opencourse` (`open_course_id`),
  CONSTRAINT `attendance` FOREIGN KEY (`attendance_code`) REFERENCES `code_attendance` (`attendance_code`),
  CONSTRAINT `center` FOREIGN KEY (`center_id`) REFERENCES `education_center` (`center_id`),
  CONSTRAINT `lecture` FOREIGN KEY (`lecture_register_id`) REFERENCES `lecture_register` (`lecture_register_id`),
  CONSTRAINT `opencourse` FOREIGN KEY (`open_course_id`) REFERENCES `open_course` (`open_course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='출석정보';

-- 게시판 ;
CREATE TABLE `notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '공지사항ID',
  `account_id` int(11) NOT NULL COMMENT '계정ID',
  `center_id` int(11) NOT NULL COMMENT '교육센터ID',
  `register_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '게시일자',
  `title` varchar(50) NOT NULL COMMENT '제목',
  `state_code` int(3) NOT NULL DEFAULT '1' COMMENT '1 공개글 0 비밀글 9 삭제',
  `content` varchar(20000) NOT NULL COMMENT '내용',
  `hit` int(11) NOT NULL DEFAULT '0' COMMENT '조회수',
  PRIMARY KEY (`notice_id`),
  KEY `FK_notice_account_id` (`account_id`),
  KEY `FK_notice_center_id` (`center_id`),
  KEY `FK_notice_state_code` (`state_code`),
  CONSTRAINT `FK_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_notice_center_id` FOREIGN KEY (`center_id`) REFERENCES `education_center` (`center_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_notice_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='공지사항';

CREATE TABLE `qna` (
  `qna_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '질문과답변ID',
  `account_id` int(11) NOT NULL COMMENT '계정ID',
  `title` varchar(100) NOT NULL COMMENT '제목',
  `register_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '게시일자',
  `content` varchar(2000) NOT NULL COMMENT '게시내용',
  `group_no` int(11) NOT NULL COMMENT '그룹번호',
  `hit` int(11) NOT NULL DEFAULT '0' COMMENT '조회수',
  `state_code` int(11) NOT NULL DEFAULT '1' COMMENT '상태코드',
  `divide_code` char(1) NOT NULL COMMENT '구분코드 질문Q 답A',
  PRIMARY KEY (`qna_id`),
  KEY `FK_qna_account_id` (`account_id`),
  KEY `FK_qna_state_code` (`state_code`),
  CONSTRAINT `FK_qna_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_qna_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='질문과답변';

CREATE TABLE `upload_file` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '첨부파일ID',
  `file_type` varchar(50) NOT NULL COMMENT '파일 타입 image/file...',
  `board_name` varchar(50) NOT NULL COMMENT '게시판명',
  `orign_file` varchar(100) NOT NULL COMMENT '원본파일명',
  `save_file` varchar(110) NOT NULL COMMENT '저장파일명',
  `filesize` mediumtext NOT NULL COMMENT '용량',
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='첨부파일';

-- 강의 평가;
CREATE TABLE `lecture_evaluation` (
  `open_course_id` int(11) NOT NULL COMMENT '개설과정ID',
  `state_code` int(11) NOT NULL COMMENT '0 not open	1 open	2 close',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`open_course_id`),
  KEY `FK_attendance_state_code` (`state_code`),
  CONSTRAINT `FK_attendance_open_course_id` FOREIGN KEY (`open_course_id`) REFERENCES `open_course` (`open_course_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_attendance_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='강의평가';

CREATE TABLE `eval_question` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '평가문항ID',
  `open_course_id` int(11) NOT NULL COMMENT '개설과정ID',
  `type_code` varchar(100) NOT NULL,
  `question` varchar(200) NOT NULL COMMENT '평가문항',
  PRIMARY KEY (`question_id`),
  KEY `FK_eval_question_open_course_id` (`open_course_id`),
  CONSTRAINT `FK_eval_question_open_course_id` FOREIGN KEY (`open_course_id`) REFERENCES `open_course` (`open_course_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='평가문항';

CREATE TABLE `eval_question_example` (
  `example_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '평가문항보기ID',
  `question_id` int(11) NOT NULL COMMENT '평가문항ID',
  `example_content` varchar(200) NOT NULL COMMENT '보기내용',
  PRIMARY KEY (`example_id`),
  KEY `FK_eval_question_example_question_id` (`question_id`),
  CONSTRAINT `FK_eval_question_example_question_id` FOREIGN KEY (`question_id`) REFERENCES `eval_question` (`question_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='객관식 평가문항 보기';

CREATE TABLE `eval_example_result` (
  `eval_result_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '평가문항결과ID',
  `open_course_id` int(11) NOT NULL COMMENT '개설과정ID',
  `question_id` int(11) NOT NULL COMMENT '평가문항ID',
  `example_id` int(11) NOT NULL COMMENT '평가문항보기ID',
  `account_id` int(11) NOT NULL COMMENT '계정ID',
  PRIMARY KEY (`eval_result_id`),
  KEY `FK_eval_rs_open_course_id` (`open_course_id`),
  KEY `FK_eval_rs_question_id` (`question_id`),
  KEY `FK_eval_rs_example_id` (`example_id`),
  KEY `FK_eval_rs_account_id` (`account_id`),
  CONSTRAINT `FK_eval_rs_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_eval_rs_example_id` FOREIGN KEY (`example_id`) REFERENCES `eval_question_example` (`example_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_eval_rs_open_course_id` FOREIGN KEY (`open_course_id`) REFERENCES `open_course` (`open_course_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_eval_rs_question_id` FOREIGN KEY (`question_id`) REFERENCES `eval_question` (`question_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='객관식 평가문항 결과';



CREATE TABLE `eval_question_answer` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '주관식평가문항답변ID',
  `question_id` int(11) NOT NULL COMMENT '평가문항ID',
  `answer` varchar(2000) NOT NULL COMMENT '주관식평가문항답변',
  `answer_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일자',
  `account_id` int(11) NOT NULL COMMENT '계정ID',
  PRIMARY KEY (`answer_id`),
  UNIQUE KEY `quest_answer_unique` (`question_id`,`account_id`),
  KEY `FK_eval_question_answer_account_id` (`account_id`),
  CONSTRAINT `FK_eval_question_answer_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_eval_question_answer_question_id` FOREIGN KEY (`question_id`) REFERENCES `eval_question` (`question_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='주관식평가문합답변';

