use mysql;
update user set password = password('1004') where user = 'root';
flush privileges;

show databases;
create DATABASE haco;
use haco;

create user 'haco'@'%' identified by '1004';

grant all privileges on haco.* to 'haco'@'%' identified by '1004';
grant all privileges on haco.* to 'haco'@'localhost' identified by '1004';
flush privileges;
