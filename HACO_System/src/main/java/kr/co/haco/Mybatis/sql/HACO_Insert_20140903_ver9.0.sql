-- 코드성 데이터;

insert into education_center(location) values('여의도');
insert into education_center(location) values('LA');
insert into education_center(location) values('약수');
insert into education_center(location) values('판교');
insert into education_center(location) values('가산');
insert into education_center(location) values('서울대입구');
insert into education_center(location) values('수원');
insert into education_center(location) values('제주도');
insert into education_center(location) values('안드로메다');

insert into code_lecture_register value('1','신청');
insert into code_lecture_register value('2','허가');
insert into code_lecture_register value('3','취소');
insert into code_lecture_register value('4','납부완료');

insert into code_attendance values(1,'지각');
insert into code_attendance values(2,'조퇴');
insert into code_attendance values(3,'결석');

insert into code_state value(0,'비활성(대기,비밀)');
insert into code_state value(1,'활성(허가)');
insert into code_state value(2,'공지');
insert into code_state value(9,'삭제(취소)');

insert into roles(role_name,role_desc) value('GUEST','손님');
insert into roles(role_name,role_desc) value('STUDENT','학원생');
insert into roles(role_name,role_desc) value('TEACHER','강사');
insert into roles(role_name,role_desc) value('MANAGER','관리직원');
insert into roles(role_name,role_desc) value('CENTER','센터장');
insert into roles(role_name,role_desc) value('MASTER','본점장');

-- 기본 Admin 계정;
insert into account(state_code,id,password) values(1,'admin','1004');
insert into account(state_code,id,password) values(1,'hs','hs');
insert into account(state_code,id,password) values(1,'kjhkju','kjhkju');
insert into account(state_code,id,password) values(1,'je','1004');
insert into account(state_code,id,password) values(1,'hd','1004');


insert into employee(account_id,name_kor,name_eng,gender,join_date,join_center_id,resident_registration_num1,resident_registration_num2,now_center_id,phone_cell)
values(1,'운영자','Admin','M',now(),1,121212,212121,1,'010-111-1111');
insert into employee(account_id,name_kor,name_eng,gender,join_date,join_center_id,resident_registration_num1,resident_registration_num2,now_center_id,phone_cell)
values(2,'박효상','Admin','M',now(),1,121212,212121,1,'010-111-1111');
insert into employee(account_id,name_kor,name_eng,gender,join_date,join_center_id,resident_registration_num1,resident_registration_num2,now_center_id,phone_cell)
values(3,'김장현','Admin','M',now(),1,121212,212121,1,'010-111-1111');
insert into employee(account_id,name_kor,name_eng,gender,join_date,join_center_id,resident_registration_num1,resident_registration_num2,now_center_id,phone_cell)
values(4,'정은누나','Admin','M',now(),1,121212,212121,1,'010-111-1111');
insert into employee(account_id,name_kor,name_eng,gender,join_date,join_center_id,resident_registration_num1,resident_registration_num2,now_center_id,phone_cell)
values(5,'호동','Admin','M',now(),1,121212,212121,1,'010-111-1111');

insert into authority values('1','MASTER');
insert into authority values('2','MASTER');
insert into authority values('3','MASTER');
insert into authority values('4','MASTER');
insert into authority values('5','MASTER');

insert into center_classroom(center_id,classroom) VALUES('1','101');
insert into center_classroom(center_id,classroom) VALUES('1','102');
insert into center_classroom(center_id,classroom) VALUES('1','103');
insert into center_classroom(center_id,classroom) VALUES('1','104');
insert into center_classroom(center_id,classroom) VALUES('1','105');


insert into center_classroom(center_id,classroom) VALUES('2','201');
insert into center_classroom(center_id,classroom) VALUES('2','202');
insert into center_classroom(center_id,classroom) VALUES('2','203');
insert into center_classroom(center_id,classroom) VALUES('2','204');
insert into center_classroom(center_id,classroom) VALUES('2','205');


insert into center_classroom(center_id,classroom) VALUES('3','205');
insert into center_classroom(center_id,classroom) VALUES('3','206');
insert into center_classroom(center_id,classroom) VALUES('3','207');
insert into center_classroom(center_id,classroom) VALUES('3','208');
insert into center_classroom(center_id,classroom) VALUES('3','209');


insert into center_classroom(center_id,classroom) VALUES('4','101');
insert into center_classroom(center_id,classroom) VALUES('4','102');

insert into center_classroom(center_id,classroom) VALUES('5','111');
insert into center_classroom(center_id,classroom) VALUES('5','112');

insert into center_classroom(center_id,classroom) VALUES('6','201');
insert into center_classroom(center_id,classroom) VALUES('6','202');

insert into center_classroom(center_id,classroom) VALUES('7','401');
insert into center_classroom(center_id,classroom) VALUES('7','402');

insert into center_classroom(center_id,classroom) VALUES('8','501');
insert into center_classroom(center_id,classroom) VALUES('8','502');

insert into center_classroom(center_id,classroom) VALUES('9','801');
insert into center_classroom(center_id,classroom) VALUES('9','802');


INSERT INTO code_job VALUES(1,'강사');
INSERT INTO code_job VALUES(2,'관리직원');
INSERT INTO code_job VALUES(3,'센터장');
INSERT INTO code_job VALUES(4,'본점장');


-- 기본 설정값
insert into upload_file(file_type,board_name,orign_file,save_file,filesize) values('images','/employeePhoto','sampleImages.jpg','sampleImage.jpg',300000000);
insert into upload_file(file_type,board_name,orign_file,save_file,filesize) values('File','/board/notice','sampleFile.zip','sampleFile.zip',600000000);



