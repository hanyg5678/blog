 create table reply_memo(
rnum number not null,
content varchar(500) not null,
regdate date not null,
id varchar(10) not null,
memono number(7) not null,
primary key(rnum),
foreign key(memono)  references memo(memono)
 
)
 
--create(��۵��)
select * from MEMBER;
select * from reply_memo;
select * from memo;
 
select nvl(max(rnum),0)+1 from reply;
 
insert into reply_memo(rnum, content, regdate, id, memono)
values((select nvl(max(rnum),0)+1 from reply_memo),
'�ǰ��Դϴ�.',sysdate,'user1',304
)
 
 
--read(��� ����)
select * from reply
 
--update(��� ����)
update reply
set content = '���ο� �ǰ��� �ø��ϴ�.'
where rnum = 1
 
--delete(��� ����)
delete from REPLY
where rnum = 1
 
 
--list(���)
select rnum, content, to_char(regdate,'yyyy-mm-dd') regdate, id, bbsno, r
FROM(
select rnum, content, regdate, id, bbsno, rownum r
FROM(
select rnum, content, regdate, id, bbsno
from REPLY
order by rnum DESC
    )
)WHERE r >= 1 and r <= 5
 
 
--total(���)
select count(*) from reply