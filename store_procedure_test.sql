use market_db;
drop procedure if exists user_proc1;

DELIMITER $$
create procedure user_proc1(in username varchar(10))
begin
	select * from market_db.member where mem_name = username;
end $$

DELIMITER ; 

call user_proc1('에이핑크');
call user_proc1('블랙핑크');
    
drop procedure if exists user_proc2;
DELIMITER $$
create procedure user_proc2(in usernumber int, in userheight int)
	begin
		select * from market_db.member
			where mem_number > usernumber and height > userheight;
	end $$
DELIMITER ;

call user_proc2(6, 105);

create table noTable(
	id int auto_increment primary key,
    txt char(10)
);

drop procedure if exists user_proc3;
DELIMITER $$
create procedure user_proc3(
	in txtValue char(10),
    out outValue int)
    
    begin
		insert into noTable values(null, txtValue);
        select max(id) into outValue from noTable;
	end $$
    
DELIMITER ;

call user_proc3('테스트1', @txtValue);
select concat('입력된 ID값 : ', @txtValue);
