use market_db;
drop procedure if exists cursor_proc;
DELIMITER $$
create procedure cursor_proc()
begin
	declare memNumber int;
    declare cnt int default 0;
    declare totNumber int default 0;
    declare endofRow boolean default false;
    
    declare memberCursor cursor for
		select mem_number from market_db.member;
        
	declare continue handler 
    for not found set endofRow = true;
    
    open memberCursor;
    
    cursor_loop : LOOP
		FETCH memberCursor into memNumber;
        
	if endofRow = true then
		leave cursor_loop;
	end if;
    
    set cnt = cnt + 1;
    set totNumber = totNumber + memNumber;
    end loop cursor_loop;
    
    select (totNumber/cnt) as '회원 수의 평균 : ';
    
    close memberCursor;
end $$
DELIMITER ;

call cursor_proc();
	
        
    