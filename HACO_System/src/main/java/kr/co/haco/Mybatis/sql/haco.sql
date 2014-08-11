select * from account
select * from roles
commit
show tables

select * from authority




-- 계정상태
CREATE TABLE `HACO`.`code_state` (
 `state_code` INT         NOT NULL COMMENT '상태코드', -- 상태코드
 `state_name` VARCHAR(20) NOT NULL COMMENT '상태명', -- 상태명
 CONSTRAINT `PK_code_state` PRIMARY KEY (`state_code`) -- 상태코드
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '계정상태';

insert into code_state value(0,'비활성(대기,비밀)');
insert into code_state value(1,'활성(허가)');
insert into code_state value(2,'공지');
insert into code_state value(9,'삭제(취소)');

-- 계정
CREATE TABLE `HACO`.`account` (
 `account_id` INT         NOT NULL AUTO_INCREMENT COMMENT '계정ID', -- 계정ID
 `state_code` INT         NOT NULL DEFAULT 0 COMMENT '상태코드', -- 상태코드
 `id`         VARCHAR(20) NOT NULL COMMENT '아이디', -- 아이디
 `password`   VARCHAR(50) NOT NULL COMMENT '비밀번호', -- 비밀번호
 CONSTRAINT `PK_account` PRIMARY KEY (`account_id`), -- 계정 기본키
 CONSTRAINT `UIX_account_id` UNIQUE (`id`), -- id 유일값
 CONSTRAINT `FK_account_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '계정';



insert into account(id,password) values('admin','admin');
insert into account(id,password) values('kjhkju','kjhkju');
insert into account(id,password) values('lkjlki','lkjlki');
insert into account(id,password) values('kglim','1004');
insert into account(id,password) values('hs','hs');
insert into account(id,password) values('issue','ekfrl');
insert into account(id,password) values('center','1004');
insert into account(id,password) values('manager','1004');
insert into account(id,password) values('teacher','1004');
insert into account(id,password) values('student','1004');
insert into account(id,password) values('guest','1004');
update account set state_code=1;



--  권한
CREATE TABLE roles (
	role_name   VARCHAR(20) NOT NULL COMMENT '권한명', -- 권한명
	role_desc   VARCHAR(50) NOT NULL COMMENT '권한설명', -- 권한설명
	create_date TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자', -- 생성일자
    CONSTRAINT `PK_roles` PRIMARY KEY (`role_name`) -- 권한명
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ' 권한';


insert into roles(role_name,role_desc) value('GUEST','손님');
insert into roles(role_name,role_desc) value('STUDENT','학원생');
insert into roles(role_name,role_desc) value('TEACHER','강사');
insert into roles(role_name,role_desc) value('MANAGER','관리직원');
insert into roles(role_name,role_desc) value('CENTER','센터장');
insert into roles(role_name,role_desc) value('MASTER','본점장');


-- 계정권한
CREATE TABLE authority (
	account_id INT         NOT NULL COMMENT '계정ID', --
    . 계정ID
	role_name  VARCHAR(20) NOT NULL COMMENT '권한명', -- 권한명
    CONSTRAINT `FK_authority_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
 	CONSTRAINT `FK_authority_role_name` FOREIGN KEY (`role_name`) REFERENCES `roles` (`role_name`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '계정권한';



insert into authority values('1','MASTER');
insert into authority values('1','CENTER');
insert into authority values('1','MANAGER');
insert into authority values('1','TEACHER');
insert into authority values('1','STUDENT');
insert into authority values('1','GUEST');

insert into authority values('2','MASTER');
insert into authority values('3','MASTER');
insert into authority values('4','MASTER');
insert into authority values('5','MASTER');

insert into authority values('6','CENTER');
insert into authority values('7','TEACHER');
insert into authority values('8','STUDENT');
insert into authority values('9','CENTER');
insert into authority values('10','MANAGER');
insert into authority values('11','GUEST');



-- 회원
CREATE TABLE member (
	account_id     INT          NOT NULL COMMENT '계정ID', -- 계정ID
	name           VARCHAR(10)  NOT NULL COMMENT '성명', -- 성명
	zipcode        INT(6)       NULL     COMMENT '우편번호', -- 우편번호
	address        VARCHAR(100) NULL     COMMENT '기본주소', -- 기본주소
	address_detail VARCHAR(100) NULL     COMMENT '상세주소', -- 상세주소
	email          VARCHAR(50)  NOT NULL COMMENT '이메일', -- 이메일
	phone          INT(11)      NOT NULL COMMENT '휴대폰번호', -- 휴대폰번호
	company        VARCHAR(50)  NULL     COMMENT '근무_회사명', -- 근무_회사명
	position       VARCHAR(50)  NULL     COMMENT '직위', -- 직위
	job_duty       VARCHAR(50)  NULL     COMMENT '직무', -- 직무
	create_date    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '가입일자', -- 가입일자
    CONSTRAINT `PK_member` PRIMARY KEY(`account_id`), -- 계정 ID
    CONSTRAINT `FK_member_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '회원';



-- 직무코드
CREATE TABLE code_job (
	job_code INT(3)      NOT NULL COMMENT '1 강사
	2 직원
	3 센터장', -- 직무코드
	job_name VARCHAR(20) NOT NULL COMMENT '직무명', -- 직무명
    CONSTRAINT `PK_code_job` PRIMARY KEY(`job_code`) -- 직무코드
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '직무코드';

insert into code_job values('1','강사');
insert into code_job values('2','관리직원');
insert into code_job values('3','센터장');
insert into code_job values('4','본점장');

commit

-- 직원
CREATE TABLE employee (
	account_id                 INT          NOT NULL COMMENT '계정ID', -- 계정ID
	job_code                   INT(3)       NULL     COMMENT '직무코드', -- 직무코드
	name_kor                   VARCHAR(10)  NOT NULL COMMENT '한글성명', -- 한글성명
	name_eng                   VARCHAR(20)  NOT NULL COMMENT '영문성명', -- 영문성명
	gender                     CHAR(1)      NOT NULL COMMENT '성별', -- 성별
	address_registered         VARCHAR(100) NOT NULL COMMENT '주민등록지주소', -- 주민등록지주소
	address_real               VARCHAR(100) NOT NULL COMMENT '거주지주소', -- 거주지주소
	phone_home                 INT(11)      NULL     COMMENT '집전화번호', -- 집전화번호
	phone_cell                 INT(11)      NOT NULL COMMENT '휴대폰번호', -- 휴대폰번호
	phone_emergency            INT(11)      NULL     COMMENT '비상연락전화번호', -- 비상연락전화번호
	email                      VARCHAR(50)  NOT NULL COMMENT '이메일', -- 이메일
	salary                     INT          NULL     COMMENT '급여', -- 급여
	bank                       VARCHAR(50)  NULL     COMMENT '은행명', -- 은행명
	bank_account               VARCHAR(20)  NULL     COMMENT '계좌번호', -- 계좌번호
	account_owner              VARCHAR(10)  NULL     COMMENT '예금주명', -- 예금주명
	join_date                  DATE         NOT NULL COMMENT '입사일자', -- 입사일자
	join_center                VARCHAR(20)  NOT NULL COMMENT '채용센터', -- 채용센터
	photo                      VARCHAR(20)  NOT NULL COMMENT '증명사진', -- 증명사진
	resident_registration_num1 INT(13)      NOT NULL COMMENT '주민등록번호앞', -- 주민등록번호앞
	resident_registration_num2 INT(13)      NOT NULL COMMENT '주민등록번호뒤', -- 주민등록번호뒤
	center_id                  INT          NULL     COMMENT '현교육센터ID', -- 현교육센터ID
    CONSTRAINT `PK_employee` PRIMARY KEY(`account_id`), -- 계정 ID
    CONSTRAINT `FK_employee_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '직원';

ALTER TABLE employee modify photo VARCHAR(20) NULL COMMENT '증명사진';
ALTER TABLE employee ADD CONSTRAINT `FK_employee_job_code` FOREIGN KEY (`job_code`) REFERENCES `code_job` (`job_code`) on update CASCADE;
ALTER TABLE employee ADD COLUMN `FK_employee_job_code` FOREIGN KEY (`job_code`) REFERENCES `code_job` (`job_code`) on update CASCADE;


desc employee;


-- 교육센터
CREATE TABLE education_center (
	center_id INT         NOT NULL AUTO_INCREMENT COMMENT '교육센터ID', -- 교육센터ID
	location  VARCHAR(10) NOT NULL COMMENT '지점명', -- 지점명
    CONSTRAINT `PK_education_center` PRIMARY KEY(`center_id`)-- 교육센터ID
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '교육센터';


insert into education_center(location) values('여의도');
insert into education_center(location) values('LA');
insert into education_center(location) values('약수');
insert into education_center(location) values('판교');
insert into education_center(location) values('가산');
insert into education_center(location) values('서울대입구');
insert into education_center(location) values('수원');
insert into education_center(location) values('제주도');
insert into education_center(location) values('안드로메다');


-- 공지사항
CREATE TABLE notice (
	notice_id     INT          NOT NULL AUTO_INCREMENT COMMENT '공지사항ID', -- 공지사항ID
	account_id    INT          NOT NULL COMMENT '계정ID', -- 계정ID
	center_id     INT          NOT NULL COMMENT '교육센터ID', -- 교육센터ID
	register_date TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '게시일자', -- 게시일자
	title         VARCHAR(20)  NOT NULL COMMENT '제목', -- 제목
	state_code    INT(3)       NOT NULL DEFAULT 1 COMMENT '1 공개글 0 비밀글 9 삭제', -- 상태코드
	content       VARCHAR(500) NOT NULL COMMENT '내용', -- 내용
	hit           INT          NOT NULL DEFAULT 0 COMMENT '조회수', -- 조회수
    CONSTRAINT `PK_notice` PRIMARY KEY(`notice_id`), -- 공지사항ID
    CONSTRAINT `FK_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
    CONSTRAINT `FK_notice_center_id` FOREIGN KEY (`center_id`) REFERENCES `education_center` (`center_id`) on update CASCADE,
    CONSTRAINT `FK_notice_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '공지사항';



-- 근무이력
CREATE TABLE work_history (
	work_history_id INT       NOT NULL AUTO_INCREMENT COMMENT '근무이력ID', -- 근무이력ID
	account_id      INT       NOT NULL COMMENT '계정ID', -- 계정ID
	center_id       INT       NOT NULL COMMENT '교육센터ID', -- 교육센터ID
	work_start_date TIMESTAMP NOT NULL COMMENT '근무시작일자', -- 근무시작일자
	work_end_date   TIMESTAMP NOT NULL COMMENT '근무종료일자', -- 근무종료일자
	job_code        INT(3)    NULL     COMMENT '직무코드', -- 직무코드
    CONSTRAINT `PK_work_history` PRIMARY KEY(`work_history_id`), -- 근무이력ID
    CONSTRAINT `FK_work_history_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
    CONSTRAINT `FK_work_history_center_id` FOREIGN KEY (`center_id`) REFERENCES `education_center` (`center_id`) on update CASCADE,
    CONSTRAINT `FK_work_history_job_code` FOREIGN KEY (`job_code`) REFERENCES `code_job` (`job_code`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '근무이력';



-- 질문과답변
CREATE TABLE qna (
	qna_id        INT           NOT NULL AUTO_INCREMENT COMMENT '질문과답변ID', -- 질문과답변ID
	account_id    INT           NOT NULL COMMENT '계정ID', -- 계정ID
	title         VARCHAR(100)  NOT NULL COMMENT '제목', -- 제목
	register_date TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '게시일자', -- 게시일자
	content       VARCHAR(2000) NOT NULL COMMENT '게시내용', -- 게시내용
	group_no      INT           NOT NULL COMMENT '그룹번호', -- 그룹번호
	hit           INT           NOT NULL DEFAULT 0 COMMENT '조회수', -- 조회수
	state_code    INT        NOT NULL DEFAULT 1 COMMENT '상태코드', -- 상태코드
	divide_code   char(1)       NOT NULL COMMENT '구분코드 질문Q 답A', -- 구분코드
    CONSTRAINT `PK_qna` PRIMARY KEY(`qna_id`), -- 질문과답변ID
    CONSTRAINT `FK_qna_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
    CONSTRAINT `FK_qna_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '질문과답변';


-- 모임방 개설신청 코드
CREATE TABLE code_community (
	state_code INT(3)      NOT NULL COMMENT '개설신청 코드', -- 개설신청 코드
	state_name VARCHAR(20) NOT NULL COMMENT '1 신청
	2 허가
	3 불허가
	9 삭제', -- 개설신청 코드명
    CONSTRAINT `PK_code_community` PRIMARY KEY(`state_code`)-- 개설신청 코드
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '모임방 개설신청 코드';

insert into code_community values('1','신청');
insert into code_community values('2','허가');
insert into code_community values('3','불허가');
insert into code_community values('9','삭제');

-- 모임방
CREATE TABLE community (
	community_id      INT          NOT NULL AUTO_INCREMENT COMMENT '모임방ID', -- 모임방ID
	community_name    VARCHAR(100) NOT NULL COMMENT '모임방명', -- 모임방명
	state_code        INT(3)       NOT NULL COMMENT '개설신청 코드', -- 개설신청 코드
	create_account_id INT          NOT NULL COMMENT '개설자', -- 개설자
	num_of_member     INT          NOT NULL COMMENT '인원', -- 인원
	purpose           VARCHAR(200) NOT NULL COMMENT '목적', -- 목적
	create_date       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '개설일시', -- 개설일시
	close_date        TIMESTAMP    NULL     COMMENT '폐쇄일시', -- 폐쇄일시
	close_account_id  INT          NULL     COMMENT '폐쇄자', -- 폐쇄자
    CONSTRAINT `PK_community` PRIMARY KEY(`community_id`), -- 모임방ID
    CONSTRAINT `FK_community_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_community` (`state_code`) on update CASCADE,
    CONSTRAINT `FK_community_create_account_id` FOREIGN KEY (`create_account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
    CONSTRAINT `FK_community_close_account_id` FOREIGN KEY (`close_account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '모임방';




-- 모임방 회원
CREATE TABLE community_account (
	account_id   INT       NOT NULL COMMENT '계정ID', -- 계정ID
	community_id INT       NOT NULL COMMENT '모임방ID', -- 모임방ID
	state_code   INT(3)    NOT NULL COMMENT '상태코드', -- 상태코드
	create_date  TIMESTAMP NOT NULL COMMENT '신청일시', -- 신청일시
    CONSTRAINT `FK_community_account_account_id` FOREIGN KEY(`account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
    CONSTRAINT `FK_community_account_community_id` FOREIGN KEY(`community_id`) REFERENCES `community` (`community_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '모임방 회원';





-- 모임방카테고리
CREATE TABLE community_category (
	category_id       INT         NOT NULL AUTO_INCREMENT COMMENT '카테고리ID', -- 카테고리ID
	community_id      INT         NOT NULL COMMENT '모임방ID', -- 모임방ID
	category_name     VARCHAR(50) NOT NULL COMMENT '카테고리명', -- 카테고리명
	state_code        INT(3)      NOT NULL DEFAULT 1 COMMENT '1 미삭제
	0 삭제', -- 상태코드
	create_date       TIMESTAMP   NOT NULL DEFAULT NOW() COMMENT '생성일시', -- 생성일시
	sort              INT         NOT NULL COMMENT '정렬', -- 정렬
	create_account_id INT         NOT NULL COMMENT '생성자ID', -- 생성자ID
    CONSTRAINT `PK_community_category` PRIMARY KEY (`category_id`), -- 카테고리ID
	CONSTRAINT `FK_community_category_community_id` FOREIGN KEY (`community_id`) REFERENCES `community` (`community_id`) on update CASCADE,
    CONSTRAINT `FK_community_category_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) on update CASCADE,
    CONSTRAINT `FK_community_category_create_account_id` FOREIGN KEY (`create_account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '모임방카테고리';



-- 상세카테고리
CREATE TABLE community_subcategory (
	subcategory_id    INT         NOT NULL AUTO_INCREMENT COMMENT '상세카테고리ID', -- 상세카테고리ID
	category_id       INT         NOT NULL COMMENT '카테고리ID', -- 카테고리ID
	subcategory_name  VARCHAR(50) NOT NULL COMMENT '상세카테고리명', -- 상세카테고리명
	state_code        INT(3)      NOT NULL COMMENT '상태코드', -- 상태코드
	create_date       TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시', -- 생성일시
	sort              INT         NOT NULL COMMENT '정렬', -- 정렬
	create_account_id INT         NOT NULL COMMENT '생성자 계정ID', -- 생성자 계정ID
    CONSTRAINT `PK_community_subcategory` PRIMARY KEY (`subcategory_id`), -- 상세카테고리ID
	CONSTRAINT `FK_community_subcategory_category_id` FOREIGN KEY (`category_id`) REFERENCES `community_category` (`category_id`) on update CASCADE,
    CONSTRAINT `FK_community_subcategory_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) on update CASCADE,
    CONSTRAINT `FK_community_subcategory_create_account_id` FOREIGN KEY (`create_account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '상세카테고리';



-- 모임방게시물
CREATE TABLE community_board (
	board_id       INT           NOT NULL AUTO_INCREMENT COMMENT '게시물ID', -- 게시물ID
	subcategory_id INT           NOT NULL COMMENT '상세카테고리ID', -- 상세카테고리ID
	account_id     INT           NOT NULL COMMENT '계정ID', -- 계정ID
	title          VARCHAR(100)  NOT NULL COMMENT '제목', -- 제목
	content        VARCHAR(2000) NOT NULL COMMENT '내용', -- 내용
	write_date     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일시', -- 작성일시
	state_code     INT(3)        NOT NULL COMMENT '상태코드', -- 상태코드
	group_id       INT           NOT NULL COMMENT '그룹ID', -- 그룹ID
	hit            INT           NOT NULL DEFAULT 0 COMMENT '조회수', -- 조회수
    CONSTRAINT `PK_community_board` PRIMARY KEY (`board_id`), -- 게시물ID
    CONSTRAINT `FK_community_board_subcategory_id` FOREIGN KEY (`subcategory_id`) REFERENCES `community_subcategory` (`subcategory_id`) on update CASCADE,
    CONSTRAINT `FK_community_board_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_state` (`state_code`) on update CASCADE,
    CONSTRAINT `FK_community_board_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '모임방게시물';


-- 첨부파일
CREATE TABLE community_file (
	file_id    INT          NOT NULL AUTO_INCREMENT COMMENT '첨부파일ID', -- 첨부파일ID
	board_id   INT          NOT NULL COMMENT '게시물ID', -- 게시물ID
	orign_file VARCHAR(100) NOT NULL COMMENT '원본파일명', -- 원본파일명
	save_file  VARCHAR(110) NOT NULL COMMENT '저장파일명', -- 저장파일명
	filesize   INT          NOT NULL COMMENT '용량', -- 용량
    CONSTRAINT `PK_community_file` PRIMARY KEY (`file_id`), -- 첨부파일ID
    CONSTRAINT `FK_community_file_board_id` FOREIGN KEY (`board_id`) REFERENCES `community_board` (`board_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '첨부파일';



-- 댓글
CREATE TABLE community_comment (
	comment_id INT           NOT NULL AUTO_INCREMENT COMMENT '댓글ID', -- 댓글ID
	account_id INT           NOT NULL COMMENT '계정ID', -- 계정ID
	board_id   INT           NOT NULL COMMENT '게시물ID', -- 게시물ID
	content    VARCHAR(2000) NOT NULL COMMENT '댓글내용', -- 댓글내용
	write_date TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '댓글작성일시', -- 댓글작성일시
	state_code INT(3)        NOT NULL DEFAULT 1 COMMENT '상태코드', -- 상태코드
    CONSTRAINT `PK_community_comment` PRIMARY KEY (`comment_id`), -- 댓글ID
	CONSTRAINT `FK_community_comment_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
	CONSTRAINT `FK_community_comment_board_id` FOREIGN KEY (`board_id`) REFERENCES `community_board` (`board_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '댓글';


-- 프로필
CREATE TABLE teacher_profile (
	account_id      INT           NOT NULL COMMENT '계정ID', -- 계정ID
	profile_photo   VARCHAR(20)   NULL     COMMENT '프로필사진', -- 프로필사진
	profile_content VARCHAR(1000) NULL     COMMENT '소개글', -- 소개글
	introduction    VARCHAR(500)  NULL     COMMENT '담당과목', -- 담당과목
    CONSTRAINT `PK_teacher_profile` PRIMARY KEY (`account_id`), -- 계정ID
    CONSTRAINT `FK_teacher_profile_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '프로필';



-- 보유자격증
CREATE TABLE teacher_certificate (
	certificate_id INT         NOT NULL AUTO_INCREMENT COMMENT '자격증ID', -- 자격증ID
	account_id     INT         NOT NULL COMMENT '계정ID', -- 계정ID
	certificate    VARCHAR(20) NOT NULL COMMENT '자격증명', -- 자격증명
    CONSTRAINT `PK_teacher_certificate` PRIMARY KEY (`certificate_id`), -- 자격증ID
    CONSTRAINT `FK_teacher_certificate_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '보유자격증';


-- 경력사항
CREATE TABLE teacher_career (
	career_id   INT         NOT NULL AUTO_INCREMENT COMMENT '경력사항ID', -- 경력사항ID
	career_code INT(3)      NOT NULL COMMENT '1 경력
	2 강의', -- 구분코드
	account_id  INT         NOT NULL COMMENT '계정ID', -- 계정ID
	career_desc VARCHAR(500) NOT NULL COMMENT '경력사항', -- 경력사항
    CONSTRAINT `PK_teacher_career` PRIMARY KEY (`career_id`), -- 경력사항ID
    CONSTRAINT `FK_teacher_career_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '경력사항';



-- 과목
CREATE TABLE subject (
	subject_id               INT           NOT NULL AUTO_INCREMENT COMMENT '과목ID', -- 과목ID
	subject_name             VARCHAR(20)   NOT NULL COMMENT '과목명', -- 과목명
	capacity                 INT           NOT NULL COMMENT '정원', -- 정원
	subject_explanation      VARCHAR(500)  NULL     COMMENT '과목설명', -- 과목설명
	instructional_objectives VARCHAR(100)  NULL     COMMENT '학습목표', -- 학습목표
	subject_point            VARCHAR(200)  NULL     COMMENT '과목의특장점', -- 과목의특장점
	lecture_target           VARCHAR(50)   NULL     COMMENT '수강대상', -- 수강대상
	lecture_totalday         INT(3)        NULL     COMMENT '총강의일수', -- 총강의일수
	lecture_totaltime        INT           NULL     COMMENT '총강의시간', -- 총강의시간
	lecture_time             VARCHAR(10)   NULL     COMMENT '강의시간', -- 강의시간
	tuition_fee              INT           NULL     COMMENT '수강료', -- 수강료
	lecture_content          VARCHAR(1000) NULL     COMMENT '강의내용', -- 강의내용
	create_date              TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자', -- 생성일자
	update_date              TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자', -- 수정일자
	center_id                INT           NOT NULL COMMENT '교육센터ID', -- 교육센터ID
    CONSTRAINT `PK_common_subject` PRIMARY KEY (`subject_id`), -- 과목ID
    CONSTRAINT `FK_common_subject_center_id` FOREIGN KEY (`center_id`) REFERENCES `education_center` (`center_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '과목';


-- 개설과정
CREATE TABLE open_course (
	open_course_id    INT         NOT NULL AUTO_INCREMENT COMMENT '개설과정ID', -- 개설과정ID
	account_id        INT         NOT NULL COMMENT '강사ID', -- 강사의계정ID
	subject_id        INT         NULL     COMMENT '과목ID', -- 과목ID
	course_name       VARCHAR(50) NOT NULL COMMENT '과정명', -- 과정명
	classroom         INT         NULL     COMMENT '강의실', -- 강의실
	course_start_date DATE        NOT NULL COMMENT '과정시작일자', -- 과정시작일자
	course_end_date   DATE        NOT NULL COMMENT '과정종료일자', -- 과정종료일자
	center_id         INT         NULL     COMMENT '교육센터ID', -- 교육센터ID
    CONSTRAINT `PK_open_course` PRIMARY KEY (`open_course_id`), -- 개설과정ID
    CONSTRAINT `FK_open_course_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
    CONSTRAINT `FK_open_course_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) on update CASCADE,
    CONSTRAINT `FK_open_course_center_id` FOREIGN KEY (`center_id`) REFERENCES `education_center` (`center_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '개설과정';



-- 수강신청 코드
CREATE TABLE code_lecture_register (
	lecture_register_code INT(3)      NOT NULL COMMENT '수강신청상태코드', -- 수강신청상태코드
	lecture_register_name VARCHAR(10) NOT NULL COMMENT '1 신청	2 허가	3 취소	4 납부완료', -- 수강신청상태명
    CONSTRAINT `PK_code_lecture_register` PRIMARY KEY (`lecture_register_code`) -- 수강신청상태코드
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '수강신청 코드';

insert into code_lecture_register value('1','신청');
insert into code_lecture_register value('2','허가');
insert into code_lecture_register value('3','취소');
insert into code_lecture_register value('4','납부완료');



-- 수강신청
CREATE TABLE lecture_register (
	lecture_register_id   INT       NOT NULL AUTO_INCREMENT COMMENT '수강신청ID', -- 수강신청ID
	open_course_id        INT       NOT NULL COMMENT '개설과정ID', -- 개설과정ID
	account_id            INT       NOT NULL COMMENT '계정ID', -- 계정ID
	lecture_register_code INT(3)    NOT NULL COMMENT '수강신청상태코드', -- 수강신청상태코드
	lecture_register_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수강신청날짜', -- 수강신청날짜
	is_survey             CHAR(1)   NOT NULL DEFAULT 'N' COMMENT 'N 설문안함	Y 설문완료', -- 설문여부
    CONSTRAINT `PK_lecture_register` PRIMARY KEY (`lecture_register_id`), -- 수강신청ID
    CONSTRAINT `FK_lecture_register_open_course_id` FOREIGN KEY (`open_course_id`) REFERENCES `open_course` (`open_course_id`) on update CASCADE,
	CONSTRAINT `FK_lecture_register_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
	CONSTRAINT `FK_lecture_register_lecture_register_code` FOREIGN KEY (`lecture_register_code`) REFERENCES `code_lecture_register` (`lecture_register_code`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '수강신청';



-- 수료증발급기록
CREATE TABLE certificate_issue (
	certificate_issue_id INT       NOT NULL AUTO_INCREMENT COMMENT '수료증발급ID', -- 수료증발급ID
	lecture_register_id  INT       NOT NULL COMMENT '수강신청ID', -- 수강신청ID
	issue_date           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '발급일시', -- 발급일시
    CONSTRAINT `PK_certificate_issue` PRIMARY KEY (`certificate_issue_id`), -- 수강신청ID
	CONSTRAINT `FK_certificate_issue_lecture_register_id` FOREIGN KEY (`lecture_register_id`) REFERENCES `lecture_register` (`lecture_register_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '수료증발급기록';



-- 출결 코드
CREATE TABLE code_attendance (
	attendance_code       INT(3)      NOT NULL COMMENT '출결코드', -- 출결코드
	attendance_state_name VARCHAR(10) NOT NULL COMMENT '1 지각
	2 조퇴
	3 결석', -- 출결상태명
    CONSTRAINT `PK_code_attendance` PRIMARY KEY (`attendance_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '출결 코드';

insert into code_attendance values(1,'지각');
insert into code_attendance values(2,'조퇴');
insert into code_attendance values(3,'결석');



-- 출석정보
CREATE TABLE attendance (
	attendance_id       int         NOT NULL AUTO_INCREMENT COMMENT '출석ID', -- 출석ID
	lecture_register_id INT         NOT NULL COMMENT '수강신청ID', -- 수강신청ID
	attendance_code     INT(3)      NOT NULL COMMENT '출결코드', -- 출결코드
	attendance_date     TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '날짜', -- 날짜
	location            VARCHAR(50) NOT NULL COMMENT '과정명', -- 과정명
	course_name         VARCHAR(10) NOT NULL COMMENT '지점명', -- 지점명
    CONSTRAINT `PK_attendance` PRIMARY KEY(`attendance_id`), -- 출석ID
	CONSTRAINT `FK_attendance_issue_lecture_register_id` FOREIGN KEY (`lecture_register_id`) REFERENCES `lecture_register` (`lecture_register_id`) on update CASCADE,
    CONSTRAINT `FK_attendance_code_attendance` FOREIGN KEY (`attendance_code`) REFERENCES `code_attendance` (`attendance_code`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '출석정보';


-- 강의평가
CREATE TABLE lecture_evaluation (
	open_course_id INT    NOT NULL COMMENT '개설과정ID', -- 개설과정ID
	state_code     INT	  NOT NULL COMMENT '0 not open	1 open	2 close', -- 상태코드
    CONSTRAINT `PK_attendance` PRIMARY KEY(`open_course_id`), -- 개설과정ID
    CONSTRAINT `FK_attendance_open_course_id` FOREIGN KEY(`open_course_id`) REFERENCES `open_course` (`open_course_id`) on update CASCADE,
    CONSTRAINT `FK_attendance_state_code` FOREIGN KEY(`state_code`) REFERENCES `code_state` (`state_code`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '강의평가';


-- 평가문항
CREATE TABLE eval_question (
	question_id    INT          NOT NULL AUTO_INCREMENT COMMENT '평가문항ID', -- 평가문항ID
	open_course_id INT          NOT NULL COMMENT '개설과정ID', -- 개설과정ID
	type_code      INT(3)       NOT NULL COMMENT '1 객관식	2 주관식', -- 문항유형코드
	question       VARCHAR(200) NOT NULL COMMENT '평가문항', -- 평가문항
    CONSTRAINT `PK_eval_question` PRIMARY KEY(`question_id`), -- 평가문항ID
    CONSTRAINT `FK_eval_question_open_course_id` FOREIGN KEY(`open_course_id`) REFERENCES `open_course` (`open_course_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '평가문항';


select role_name, role_desc, create_date from roles
desc roles

-- 객관식 평가문항 보기
CREATE TABLE eval_question_example (
	example_id      INT          NOT NULL AUTO_INCREMENT COMMENT '평가문항보기ID', -- 평가문항보기ID
	question_id     INT          NOT NULL COMMENT '평가문항ID', -- 평가문항ID
	example_content VARCHAR(200) NOT NULL COMMENT '보기내용', -- 보기내용
    CONSTRAINT `PK_eval_question_example` PRIMARY KEY(`example_id`), -- 평가문항보기ID
    CONSTRAINT `FK_eval_question_example_question_id` FOREIGN KEY(`question_id`) REFERENCES `eval_question` (`question_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '객관식 평가문항 보기';



-- 객관식 평가문항 결과
CREATE TABLE eval_example_result (
	eval_result_id INT NOT NULL AUTO_INCREMENT COMMENT '평가문항결과ID',
	open_course_id INT NOT NULL COMMENT '개설과정ID', -- 개설과정ID
	question_id    INT NOT NULL COMMENT '평가문항ID', -- 평가문항ID
	example_id     INT NOT NULL COMMENT '평가문항보기ID', -- 평가문항보기ID
	account_id     INT NOT NULL COMMENT '계정ID',-- 계정ID
    CONSTRAINT `PK_eval_rs` PRIMARY KEY(`eval_result_id`), -- 평가문항결과ID
    CONSTRAINT `FK_eval_rs_open_course_id` FOREIGN KEY(`open_course_id`) REFERENCES `open_course` (`open_course_id`) on update CASCADE,
    CONSTRAINT `FK_eval_rs_question_id` FOREIGN KEY(`question_id`) REFERENCES `eval_question` (`question_id`) on update CASCADE,
    CONSTRAINT `FK_eval_rs_example_id` FOREIGN KEY(`example_id`) REFERENCES `eval_question_example` (`example_id`) on update CASCADE,
    CONSTRAINT `FK_eval_rs_account_id` FOREIGN KEY(`account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '객관식 평가문항 결과';



-- 주관식평가문합답변
CREATE TABLE eval_question_answer (
	answer_id   INT           NOT NULL AUTO_INCREMENT COMMENT '주관식평가문항답변ID', -- 주관식평가문항답변ID
	question_id INT           NOT NULL COMMENT '평가문항ID', -- 평가문항ID
	answer      VARCHAR(2000) NOT NULL COMMENT '주관식평가문항답변', -- 주관식평가문항답변
	answer_date TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일자', -- 작성일자
	account_id  INT           NOT NULL COMMENT '계정ID', -- 계정ID
    CONSTRAINT `PK_eval_question_answer` PRIMARY KEY(`answer_id`), -- 주관식평가문항답변ID
    CONSTRAINT `FK_eval_question_answer_question_id` FOREIGN KEY(`question_id`) REFERENCES `eval_question` (`question_id`) on update CASCADE,
    CONSTRAINT `FK_eval_question_answer_account_id` FOREIGN KEY(`account_id`) REFERENCES `account` (`account_id`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '주관식평가문합답변';




직원입력.
insert into employee VALUES('4','2','박효상','HyoSang Park','M','서울특별시 중구 신당동 418-1 2층','서울특별시 중구 신당동 418-1 2층','0222355228','01056440854','01056440854',
'ahfotnseo1@naver.com','10000000','기업','01056440854','박효상','2014-8-8','판교',null,871002,'3',1006717);
insert into employee VALUES('5','2','기호동','HoDong Ki','M','서울특별시 관악구 행운동 1666-10 그레이스 601호','서울특별시 관악구 행운동 1666-10 그레이스 601호',null,'01065016149','01065016149',
'isuue_a@naver.com','9000000','하나','40691044594607','기호동','2014-8-8','가산',null,'880110','1','1001111'
)
과목입력.
insert into subject(subject_name,capacity,subject_explanation,instructional_objectives,subject_point,
lecture_target,lecture_totalday,lecture_totaltime,lecture_time,tuition_fee,lecture_content,center_id)
 VALUES('Software Architecture Master 과정','25','과목설명부분','학습목표부분','과목의특장점부분',
'수강대상부분','5','35','10:00~18:00','175000','강의내용부분','1')

insert into subject(subject_name,capacity,subject_explanation,instructional_objectives,subject_point,
lecture_target,lecture_totalday,lecture_totaltime,lecture_time,tuition_fee,lecture_content,center_id)
 VALUES(' 차세대 엔터프라이즈 시스템구축을 위한 아키텍처 수립','40','과목설명부분','학습목표부분','과목의특장점부분',
'수강대상부분','4','16','18:30-22:30','80000','강의내용부분','1')

insert into subject(subject_name,capacity,subject_explanation,instructional_objectives,subject_point,
lecture_target,lecture_totalday,lecture_totaltime,lecture_time,tuition_fee,lecture_content,center_id)
 VALUES('IT 기술 트랜드 - 2010','40','과목설명부분','학습목표부분','과목의특장점부분',
'수강대상부분','5','20','18:30-22:30','100000','강의내용부분','1')

insert into subject(subject_name,capacity,subject_explanation,instructional_objectives,subject_point,
lecture_target,lecture_totalday,lecture_totaltime,lecture_time,tuition_fee,lecture_content,center_id)
 VALUES('UML 2.x 기초 다지기','40','과목설명부분','학습목표부분','과목의특장점부분',
'수강대상부분','10','40','18:30-22:30','400000','강의내용부분','3')

insert into subject(subject_name,capacity,subject_explanation,instructional_objectives,subject_point,
lecture_target,lecture_totalday,lecture_totaltime,lecture_time,tuition_fee,lecture_content,center_id)
 VALUES('객체 모델링','40','과목설명부분','학습목표부분','과목의특장점부분',
'수강대상부분','10','40','18:30-22:30','400000','강의내용부분','3')



개설과정
insert into open_course VALUES('1','4','2','과정명내용(75기)','5강의실','2015-01-01','2015-01-06',3)

