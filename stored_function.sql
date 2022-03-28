set global log_bin_trust_function_creators = 1;

DELIMITER $$
create function sumFunc(number1 int, number2 int)
	returns int
begin
	return number1 + number2;
end $$
DELIMITER ;

select sumFunc(4, 5) as '합계';

drop function if exists calcYearFunc;
DELIMITER $$
create function calcYearFunc(dYear int)
	returns int
begin
	declare runYear int;
    set runYear = YEAR(CURDATE()) - dYear;
    return runYear;
end $$
DELIMITER ;

select calcYearFunc(2010) as '활동 기간';

select calcYearFunc(2007) into @debut2007;
select calcYearFunc(2015) into @debut2015;

select @debut2007 - @debut2015;

select mem_id, mem_name, calcYearFunc(year(debut_date)) as '활동 햇수' from market_db.member;

show create function calcYearFunc;
