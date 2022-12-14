use madang;

--연습문제 01 (01)--
--select bookname from book where bookid=1;

--연습문제 01 (02)--
--select bookname from book where price>20000;

--연습문제 01 (03)--
--select sum(saleprice) from orders,customer where orders.custid=customer.custid and customer.name like "박지성";

--연습문제 01 (04)--
--select count(orderid) from orders,customer where orders.custid=customer.custid and customer.name like "박지성";

--연습문제 01 (05)--
-- select count(publisher) 
-- from orders,customer,book 
-- where orders.custid=customer.custid and orders.bookid=book.bookid and customer.name like "박지성";

--연습문제 01 (06)--
-- select bookname, price, price-saleprice
-- from book,orders,customer 
-- where book.bookid=orders.bookid and customer.custid=orders.custid and customer.name  like "박지성" ;

--연습문제 01 (07)--
-- select bookname from book 
-- where bookname not in(
-- select bookname from book, customer ,orders 
-- where book.bookid=orders.bookid and customer.custid=orders.custid 
-- and customer.name  like "박지성" );

--연습문제 02 (01)--
--select count(*) from book;
--연습문제 02 (02)--
--select count(distinct publisher) from book ;
--연습문제 02 (03)--
--select name,address from customer;
--연습문제 02 (04)--
--select orderid from orders where orderdate between  "2014-07-04" and "2014-07-07";
--연습문제 02 (05)--
--select orderid from orders where orderdate not between  "2014-07-04" and "2014-07-07";
--연습문제 02 (06)--
--select name,address from customer where name like "김%";
--연습문제 02 (07)--
--select name,address from customer where name like "김%아";
--연습문제 02 (08)--
-- select distinct name from customer, orders 
-- where customer.custid=orders.custid 
-- and customer.custid in (select custid from orders);
--연습문제 02 (09)--
--select sum(saleprice),avg(saleprice) from orders;
--연습문제 02 (10)--
--select name,sum(saleprice) from customer, orders where customer.custid=orders.custid group by customer.name;

--연습문제 02 (11)--
-- select name,bookname from customer, orders ,book 
-- where customer.custid=orders.custid and orders.bookid= book.bookid;
--연습문제 02 (12)--
-- select orderid from orders,book 
-- where book.bookid=orders.bookid and 
-- price-saleprice=(select max(price-saleprice) from book, orders where book.bookid=orders.bookid);
--연습문제 02 (13)--

-- select c1.name from customer c1
--  where (select avg(saleprice) from orders)
--  <
--  (select avg(saleprice) from orders , customer c2 where orders.custid=c2.custid and c2.custid= c1.custid );

-- select c1.name from customer c1
-- where 
-- (select avg(saleprice) from orders)
-- < 
-- (select avg(saleprice) from orders,customer c2
-- where orders.custid=c2.custid
-- and c1.custid=c2.custid);

-- select distinct name 
-- from customer,book,orders
-- where orders.custid=customer.custid
-- and book.bookid= orders.bookid
-- and publisher in (select publisher 
--                 from book,orders,customer
--                 where orders.custid=customer.custid
--                 and book.bookid= orders.bookid
--                 and customer.name like "박지성");


-- select name ,count(distinct publisher)
-- from customer,book,orders
-- where orders.custid=customer.custid
-- and book.bookid= orders.bookid
-- group by name
-- having count(distinct publisher)>2;




--and (select count(distinct name))/(select count(distinct name) from customer) >0.3;



--연습문제 03 (01)--

-- select distinct name from customer,Orders,book  
-- where Customer.custid=Orders.custid and Orders.bookid=book.bookid
-- and publisher in( select publisher from customer,book, orders 
-- where Orders.bookid=book.bookid and Customer.custid=Orders.custid and customer.name like "박지성");

--연습문제 03 (02)--

-- select name ,count(distinct publisher) from customer,orders,book 
--  where customer.custid=orders.custid and Orders.bookid=book.bookid
--  group by customer.name ;
-- having count(distinct publisher)>2;
--연습문제 03 (03)--

-- select b1.bookname from book b1
-- where(select count(distinct name) from orders, customer, book b2 
-- where orders.custid=customer.custid and b2.bookid=orders.bookid and b1.bookname=b2.bookname ) /
-- (select count(distinct name) from customer)
-- >0.3;


--use movie;
--2021 시험1번
--select mov_year from movie where mov_title like "American Beauty";

--2021 시험2번
--select mov_title from movie where
--movie.mov_id not in (select mov_id from rating)

--2022 시험 3번
-- select rev_name from reviewer,rating
--  where reviewer.rev_id=rating.rev_id and rev_stars>7.0 and rev_name IS NOT NULL;

--2021 시험 4번
-- select mov_title,mov_year,mov_time,mov_dt_rel,mov_rel_country
-- from Movie where mov_rel_country not like ('UK');

--2021 시험 5번
-- select rev_name, mov_title from rating, reviewer,movie
-- where rating.rev_id=reviewer.rev_id
-- and movie.mov_id=rating.mov_id and rev_name is not null;

--2021 시험 6번 

-- select dir_fname,dir_lname from director, movie_direction,movie,movie_cast
-- where director.dir_id=movie_direction.dir_id 
-- and movie_direction.mov_id= movie.mov_id 
-- and movie.mov_id= movie_cast.mov_id
-- and mov_title like "Eyes Wide Shut"
-- and movie_cast.role is not null;

--2021 시험 7번 --group byE ㅈㄴ어렵
-- select mov_title, max(rev_stars) from movie, rating, movie_direction
-- where  movie.mov_id= rating.mov_id 
-- and movie_direction.mov_id=movie.mov_id
-- and rev_stars is not null
-- group by movie_direction.dir_id;

--2021 시험 8번 --
-- select mov_title from movie,reviewer, rating
-- where movie.mov_id=rating.mov_id 
-- and rating.rev_id=reviewer.rev_id
-- and movie.mov_id  in (select mov_id from rating)
-- and rev_name not like "Paul Monks";

--2021 시험 9번 --ㅈㄴ어렵

-- select mov_title, rev_stars ,A.rate  from movie, rating, 
-- (select avg(rev_stars) as rate  from movie, rating
-- where movie.mov_id=rating.mov_id 
-- and mov_year<1980) A  <--이부분으로 추가할수 있다
-- where movie.mov_id=rating.mov_id 
-- and rating.rev_stars<
-- A.rate;



--2021 시험 10번--
-- select A.rate-B.rate as avg_diff from 
-- (select avg(rev_stars) as rate  from movie, rating
-- where movie.mov_id=rating.mov_id 
-- and mov_year<1980) A ,(select avg(rev_stars) as rate  from movie, rating
-- where movie.mov_id=rating.mov_id 
-- and mov_year>1980) B;

--2021 시험 11번--
-- select A.avg_stars,A.mov_title  from
-- (select mov_title,avg(rev_stars) as avg_stars from rating, movie 
-- where rating.mov_id=movie.mov_id
-- group by mov_title) A 
-- where A.avg_stars=(select min(B.min_stars) from 
-- (select mov_title,avg(rev_stars) as min_stars from rating, movie 
-- where rating.mov_id=movie.mov_id
-- group by mov_title) B
-- );


--2021 시험 12번--



-- 1
-- select mov_rel_country from Movie where mov_title like "American Beauty";
-- 2
-- select mov_title from movie
-- where movie.mov_id not in(select mov_id from rating)
-- 3
-- select reviewer.rev_name  from reviewer,rating
--  where reviewer.rev_id = rating.rev_id
--  and rev_stars>7.0 and rev_name is not null;
--4
-- select  mov_title, mov_year, mov_time, mov_dt_rel, mov_rel_country from movie
-- where mov_rel_country not like "UK";
--5
-- select rev_name, mov_title from reviewer, rating, movie
-- where reviewer.rev_id=rating.rev_id
-- and movie.mov_id= rating.mov_id
-- and rev_name is not null;
--6
-- select dir_fname, dir_lname , mov_title from director,movie_direction,movie,movie_cast
-- where director.dir_id=movie_direction.dir_id
-- and movie.mov_id=movie_direction.mov_id
-- and movie.mov_id=movie_cast.mov_id
-- and mov_title like "Eyes Wide Shut"
-- and movie_cast.act_id is not null;
--7 다시!
-- select mov_title,rev_stars ,dir_id 
-- from movie, rating, movie_direction A
-- where  movie.mov_id= rating.mov_id 
-- and movie.mov_id=A.mov_id
-- and rev_stars=
--                 (select max(rev_stars) 
--                 from movie_direction B, movie, rating
--                 where  movie.mov_id= rating.mov_id 
--                 and movie.mov_id=B.mov_id
--                 and A.dir_id =B.dir_id);
--8
-- select mov_title 
-- from movie, rating,reviewer
-- where movie.mov_id=rating.mov_id
-- and reviewer.rev_id=rating.rev_id
-- and rev_name not like "Paul Monks";
-- select mov_title 
-- from movie,rating,reviewer
-- where movie.mov_id=rating.mov_id
-- and reviewer.rev_id=rating.rev_id
-- and rev_name not like 'paul monks'; 
--9 다시!
-- select mov_title,rev_stars,A.avg_stars 
-- from movie, rating,
--     (select avg(rev_stars) as avg_stars from rating,movie
--     where rating.mov_id= movie.mov_id
--     and mov_year <1980) A
-- where movie.mov_id=rating.mov_id
-- and A.avg_stars> rating.rev_stars;

-- select mov_title, rev_stars 
-- from rating, movie,
-- (select avg(rev_stars) as avg_stars from rating, movie 
-- where rating.mov_id= movie.mov_id
-- and mov_year<1980) A  
-- where rating.mov_id= movie.mov_id
-- and rating.rev_stars>A.avg_stars;


-- select avg(rev_stars) from rating, movie 
-- where rating.mov_id= movie.mov_id
-- and mov_year<1980;


--10
-- select A.avg_stars-B.avg_stars
-- from

-- (select avg(rev_stars) as avg_stars 
-- from rating,movie
-- where rating.mov_id= movie.mov_id
-- and mov_year <1980)A,
-- (select avg(rev_stars) as avg_stars 
-- from rating,movie
-- where rating.mov_id= movie.mov_id
-- and mov_year >1980) B

--11
-- select A.avg_stars,A.mov_title  
-- from
--     (select mov_title,avg(rev_stars) as avg_stars from rating, movie 
--      where rating.mov_id=movie.mov_id
--      group by mov_title) A
--      where A.avg_stars=(select min(B.min_stars)
--                         from 
--                         (select mov_title,avg(rev_stars) as min_stars from rating, movie 
--                          where rating.mov_id=movie.mov_id
--                          group by mov_title) B);
                        
--12

-- select A.gen_id 
-- from
--     (select count(gen_id) as num,gen_id
--     from movie_genres, movie
--     where movie_genres.mov_id=movie.mov_id
--     group by gen_id) A
-- where A.num=(select max(A.num) 
--                 from (select count(gen_id) as num
--                 from movie_genres, movie
--                 where movie_genres.mov_id=movie.mov_id
--                 group by gen_id) A) ; 



-- select mov_title, gen_title 
-- from movie_genres,movie,genres
-- where movie.mov_id=movie_genres.mov_id
-- and movie_genres.gen_id=genres.gen_id
-- and movie_genres.gen_id in (select A.gen_id
--                             from
--                                 (select count(gen_id) as num,gen_id
--                                 from movie_genres, movie
--                                 where movie_genres.mov_id=movie.mov_id
--                                 group by gen_id) A
--                                 where A.num=(select max(B.num) from
--                                                 (select count(gen_id) as num
--                                                 from movie_genres, movie
--                                                 where movie_genres.mov_id=movie.mov_id
--                                                 group by gen_id) B ));

--1
-- select mov_year from movie
-- where mov_title like "American Beauty"
--2
-- select mov_title from movie
-- where mov_id not in(select mov_id from rating);
--3
-- select distinct rev_name 
-- from reviewer,rating
-- where reviewer.rev_id= rating.rev_id
-- and rev_stars>7.0
-- and rev_name is not null; 

--select reviewer.rev_name  from reviewer,rating
--  where reviewer.rev_id = rating.rev_id
--  and rev_stars>7.0 and rev_name is not null;
--4
-- select  mov_title, mov_year, mov_time ,mov_dt_rel,mov_rel_country
-- from movie 
-- where mov_rel_country not like("uk");
--5
-- select rev_name, mov_title 
-- from movie, rating, reviewer
-- where movie.mov_id=rating.mov_id
-- and reviewer.rev_id=rating.rev_id
-- and rev_name is not null;
--6
-- select dir_fname, dir_lname ,mov_title 
-- from movie, director,movie_direction,movie_cast
-- where director.dir_id=movie_direction.dir_id
-- and movie_direction.mov_id= movie.mov_id
-- and movie_cast.mov_id=movie.mov_id
-- and mov_title like "Eyes Wide Shut"
-- and act_id is not null;

--
-- select mov_title,rev_stars 
-- from movie, rating
-- where movie.mov_id=rating.mov_id


-- from movie, rating, movie_direction A
-- where  movie.mov_id= rating.mov_id 
-- and movie.mov_id=A.mov_id
-- and rev_stars=
--                 (select max(rev_stars) 
--                 from movie_direction B, movie, rating
--                 where  movie.mov_id= rating.mov_id 
--                 and movie.mov_id=B.mov_id
--                 and A.dir_id =B.dir_id);
select mov_title 
from movie,rating,reviewer
where movie.mov_id=rating.mov_id
and reviewer.rev_id=rating.rev_id
and rev_name not like 'paul monks'; 