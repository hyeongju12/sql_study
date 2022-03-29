use market_db;
create table if not exists trigger_table (id int, txt varchar(10));
insert into trigger_table values(1, '레드벨벳');
insert into trigger_table values(2, '잇지');
insert into trigger_table values(3, '블랙핑크');

drop trigger if exists myTrigger;
DELIMITER $$
create trigger myTrigger
	after delete
    on trigger_table
    for each row
begin
	set @msg = '가수 그룹이 삭제됨' ; 
end $$
DELIMITER ;

insert into trigger_table values(4, '오키도키');
select @msg;

delete from trigger_table where id=4;
select @msg;

create table singer(select mem_id, mem_name, mem_number, addr from market_db.member);

create table backup_singer(
	mem_id char(8) not null,
    mem_name varchar(10) not null,
    mem_number int not null,
    addr char(2) not null,
    modType char(2),
    modDate date,
    modUser varchar(30)
);

drop trigger if exists singer_updateTrg;
DELIMITER $$
create trigger singer_updateTrg
	after update
    on market_db.singer
    for each row
begin
	insert into backup_singer values(
		OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr, '수정', curdate(), current_user()
	);
end $$

DELIMITER ; 

drop trigger if exists singer_deleteTrg;
DELIMITER $$
create trigger singer_deleteTrg
	after delete
    on market_db.singer
    for each row
begin
	insert into backup_singer values(
		OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr, '삭제', curdate(), current_user()
    );
end $$

DELIMITER ;
		
update singer set addr = '영국' where mem_id = 'BLK';
delete from singer where mem_id = 'BLK';

select * from market_db.backup_singer;