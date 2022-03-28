drop procedure if exists user_proc4;

DELIMITER $$

create procedure user_proc4(
	in memName char(10)
	)
    begin
		declare debutYear int;
        select year(debut_date) into debutYear from member
			where mem_name = memName;
		if (debutYear < 2015) then 
			select '고참 가수네요.' as '메시지';
		elseif (debutYear >= 2015) then
			select '신인 가수네요.' as '메시지';
		end if;
	end $$

DELIMITER ;

call user_proc4('오마이걸');

DELIMITER $$
create procedure user_proc5()

begin
	declare hap int;
    declare num int;
    set hap = 0;
    set num = 1;
    
    while (num<=100) do
		set hap = hap + num;
        set num = num + 1;
	end while;
    select hap as '1~100 합계';
end $$
DELIMITER ;

call user_proc5();

drop procedure if exists user_proc6;
DELIMITER $$
create procedure user_proc6(
	in tableName char(30)
)

begin
	set @setQuery = concat('select * from ', tableName);
    prepare myQuery from @setQuery;
    execute myQuery;
    deallocate prepare myQuery;
end $$
DELIMITER ;

call user_proc6('market_db.member');