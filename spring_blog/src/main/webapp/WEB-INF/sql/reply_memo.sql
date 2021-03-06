 create table reply_memo(
rnum number not null,
content varchar(500) not null,
regdate date not null,
id varchar(10) not null,
memono number(7) not null,
primary key(rnum),
foreign key(memono)  references memo(memono)
 
)
 
--create(댓글등록)
select * from MEMBER;
select * from reply_memo;
select * from memo;
 
select nvl(max(rnum),0)+1 from reply;
 
insert into reply_memo(rnum, content, regdate, id, memono)
values((select nvl(max(rnum),0)+1 from reply_memo),
'의견입니다.',sysdate,'user1',304
)
 
 
--read(댓글 내용)
select * from reply
 
--update(댓글 수정)
update reply
set content = '새로운 의견을 올립니다.'
where rnum = 1
 
--delete(댓글 삭제)
delete from REPLY
where rnum = 1
 
 
--list(목록)
select rnum, content, to_char(regdate,'yyyy-mm-dd') regdate, id, bbsno, r
FROM(
select rnum, content, regdate, id, bbsno, rownum r
FROM(
select rnum, content, regdate, id, bbsno
from REPLY
order by rnum DESC
    )
)WHERE r >= 1 and r <= 5
 
 
--total(목록)
select count(*) from reply