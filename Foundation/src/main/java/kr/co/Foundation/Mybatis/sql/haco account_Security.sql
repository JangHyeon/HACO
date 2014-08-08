insert into account(id,password) values('admin','admin');
insert into account(id,password) values('kjhkju','kjhkju');
insert into account(id,password) values('ㄷ','lkjlki');
update account set state_code=1;
delete from account;

insert into authority values('1','master');
insert into authority values('1','manager');
insert into authority values('2','manager');


insert into roles(role_name,role_desc) value('master','본점장');

commit;

show tables;

select * from account;
select * from roles;
select * from authority;

drop table authority;
drop table account;
drop table roles;


﻿show tables;

drop table code_account
select * from code_account;



-- 계정상태
CREATE TABLE `HACO`.`code_state` (
 `state_code` INT         NOT NULL COMMENT '상태코드', -- 상태코드
 `state_name` VARCHAR(20) NOT NULL COMMENT '상태명', -- 상태명
 CONSTRAINT `PK_code_account` PRIMARY KEY (`state_code`) -- 상태코드
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '계정상태';

insert into code_account value(0,'비활성(대기,비밀)');
insert into code_account value(1,'활성(허가)');
insert into code_account value(2,'공지');
insert into code_account value(4,'삭제(취소)');

SELECT id AS USER_ID  ,  
    	                                 password AS PASSWORD ,  
    	                                 1 enabled 
    	                          FROM account WHERE id='kjhkju'
-- 계정
CREATE TABLE `HACO`.`account` (
 `account_id` INT         NOT NULL AUTO_INCREMENT COMMENT '계정ID', -- 계정ID
 `state_code` INT         NOT NULL COMMENT '상태코드', -- 상태코드
 `id`         VARCHAR(20) NOT NULL COMMENT '아이디', -- 아이디
 `password`   VARCHAR(50) NOT NULL COMMENT '비밀번호', -- 비밀번호
 CONSTRAINT `PK_account` PRIMARY KEY (`account_id`), -- 계정 기본키
 CONSTRAINT `UK_account_id` UNIQUE (`id`), -- id 유일값
 CONSTRAINT `FK_account_state_code` FOREIGN KEY (`state_code`) REFERENCES `code_account` (`state_code`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '계정';


--  권한
CREATE TABLE `HACO`.`roles` (
 `role_name`   VARCHAR(20) NOT NULL COMMENT '권한명', -- 권한명
 `role_desc`   VARCHAR(50) NOT NULL COMMENT '권한설명', -- 권한설명
 `create_date` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일자', -- 생성일자
 CONSTRAINT `PK_roles` PRIMARY KEY (`role_name`)--  권한 기본키
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT ' 권한';

insert into roles(role_name,role_desc) value('ROLE_GUEST','손님');
insert into roles(role_name,role_desc) value('ROLE_STUDENT','학원생');
insert into roles(role_name,role_desc) value('ROLE_TEACHER','강사');
insert into roles(role_name,role_desc) value('manager','관리직원');
insert into roles(role_name,role_desc) value('ROLE_CENTER','센터장');
insert into roles(role_name,role_desc) value('master','본점장');

delete from authority;
delete from roles;

-- 계정권한
CREATE TABLE `HACO`.`authority` (
 `account_id` INT NOT NULL COMMENT '계정ID', -- 계정ID
 `role_name`  VARCHAR(20) NOT NULL COMMENT '권한ID', -- 권한ID
 CONSTRAINT `FK_authority_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) on update CASCADE,
 CONSTRAINT `FK_authority_role_name` FOREIGN KEY (`role_name`) REFERENCES `roles` (`role_name`) on update CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '계정권한';

