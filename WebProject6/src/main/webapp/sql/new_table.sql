create table member(
id varchar2(10) primary key,
password varchar2(20) not null,
name varchar2(10),
userimg varchar2(30));

select constraint_name, constraint_type from user_constraints;

create table board(
userid varchar2(10) references member(id),
title varchar2(30),
artist varchar2(30),
album varchar2(30),
albumart varchar2(20),
genre varchar2(15),
lyric varchar2(500)
);