#LIDB_4 데이터베이스 제거
DROP DATABASE IF EXISTS LIDB_4;

#LIDB_4 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS LIDB_4;

#SQL 명령어를 실행할 기본 DB를 LIDB_4로 지정
USE LIDB_4;

SET foreign_key_checks = 0;

#필요한 테이블 생성



#구역 테이블을 생성하시오
create table sector
	(
		sector_id varchar(10) NOT NULL PRIMARY KEY ,
        sector_name varchar(10) NOT NULL,
        lib_id  varchar(10) NOT NULL,
        FOREIGN KEY(lib_id) REFERENCES librarian(lib_id) ON UPDATE CASCADE ON DELETE CASCADE#ok
    );

#관리자 테이블을 생성하시오
create table librarian
	(	lib_id varchar(10) NOT NULL PRIMARY KEY,
		lib_name varchar(10) NOT NULL,
        sector_id varchar(10) NOT NULL,
		FOREIGN KEY(sector_id) REFERENCES sector(sector_id) ON UPDATE CASCADE ON DELETE CASCADE#ok
    );

#무인대출반납기 테이블을 생성하시오    
create table selfs_machine
	(
		machine_id varchar(10)  NOT NULL PRIMARY KEY,
        machine_location varchar(20) NOT NULL,
        dlv_id varchar(10) NOT NULL,
        FOREIGN KEY(dlv_id) REFERENCES delivery(dlv_id) ON UPDATE CASCADE ON DELETE CASCADE#ok
    );
  
#학생 테이블을 생성하시오
CREATE TABLE student
	( std_id varchar(10) NOT NULL PRIMARY KEY,
		std_name varchar(10) NOT NULL,
        machine_id varchar(10) NOT NULL,
        std_phone varchar(15) NOT NULL,
        FOREIGN KEY(machine_id) REFERENCES selfs_machine(machine_id) ON UPDATE CASCADE ON DELETE CASCADE #ok
    );

#대출반납 테이블을 생성하시오 
create table checkout_return
	( 
		std_id varchar(10) NOT NULL  ,
        checkout_id varchar(10) NOT NULL,
        book_id int NOT NULL  ,
		constraint checkout_return primary key(std_id,checkout_id,book_id)
    );

#대출시스템 테이블을 생성하시오  
CREATE TABLE checkout_sys
	(	
		book_id int NOT NULL,
        checkout_id varchar(10) NOT NULL PRIMARY KEY,
        std_id varchar(10) NOT NULL,
        date_keep date NULL,
        date_ch date NULL,
        date_prereturn date NULL,
        date_return date NULL,
        machine_id varchar(10) NOT NULL,
        price_overdue int NULL DEFAULT 100,
        times_extension int NULL,
		return_0 int NULL,
         FOREIGN KEY(machine_id) REFERENCES selfs_machine(machine_id) ON UPDATE CASCADE ON DELETE CASCADE,#ok
         constraint checkout_id CHECK(times_extension>=3)
    );


#도서 테이블을 생성하시오
create table book
	(
		book_id int NOT NULL PRIMARY KEY,
        title varchar(80) NOT NULL ,
        author varchar(20) NOT NULL,
        sector_id varchar(10) NOT NULL,
         FOREIGN KEY(sector_id) REFERENCES sector(sector_id) ON UPDATE CASCADE ON DELETE CASCADE#ok
        
    );
#운송직원  테이블을 생성하시오
create table delivery
(
	dlv_id varchar(10) NOT NULL PRIMARY KEY,
    dlv_name varchar(10) NOT NULL
    
);
#예약 테이블 생성하시오
create table reservation
	(
		reserv_id varchar(10) NOT NULL PRIMARY KEY,
        book_id int NOT NULL,
        title varchar(80),
        date_return date NULL,
        checkout_id varchar(10) NOT NULL,
        std_id varchar(10) NOT NULL
		
       

    );
ALTER TABLE reservation
ALTER COLUMN title SET DEFAULT '기본 제목';
INSERT INTO librarian (lib_id, lib_name, sector_id)
VALUES ('L1', '정영환', 'S1'),
('L2', '최경미', 'S2'),
('L3', '최동환', 'S3'),
('L4', '이다호', 'S4');

INSERT INTO delivery (dlv_id, dlv_name)
VALUES ('D1', '김세훈'),
('D2', '조승환'),
('D3', '김덕기'),
('D4', '안명지');

INSERT INTO student (std_id, std_name, machine_id, std_phone)
VALUES ('B935620', '박유찬', 'M2', '01032411211'),
       ('B911423', '김철수', 'M8', '01032312341'),
       ('B946271', '강민애', 'M4', '01057411987'),
       ('B918231', '오지환', 'M5', '01032897341'),
       ('B712423', '이현서', 'M3', '01057268218'),
       ('B862331', '윤소연', 'M1', '01038932341'),
       ('B763523', '정현재', 'M7', '01058268732'),
       ('B911354', '김윤민', 'M8', '01012365735');

INSERT INTO checkout_return (book_id, checkout_id, std_id)
VALUES ('15', 'CK1', 'B935620'),
 ('16', 'CK2', 'B911423'),
 ('59', 'CK3', 'B911423'),
 ('92', 'CK4', 'B935620'),
 ('99','CK5','B946271');

INSERT INTO book (book_id, title, author, sector_id)
VALUES (1, '소년이 온다: 한강 장편소설', '한강', 'S1'),
       (2, '나미야 잡화점의 기적 :히가시노 게이고 장편소설','히가시노 게이고', 'S1'),
       (3, '바깥은 여름 :김애란 소설', '김애란', 'S1'),
       (4, '여행의 이유 :김영하 산문', '김영하', 'S1'),
       (5, '미드나잇 라이브러리', '매트 헤이그', 'S1'),
       (6, '달러구트 꿈 백화점 :주문하신 꿈은 매진입니다 : 이미예 장편소설', '이미예', 'S1'),
       (7, '완전한 행복 :정유정 장편소설', '정유정', 'S1'),
       (8, '파친코 :이민진 장편소설 .1', '이민진', 'S1'),
       (9, '대도시의 사랑법 :박상영 연작소설', '박상영', 'S1'),
       (10, '방구석 미술관 :가볍고 편하게 시작하는 유쾌한 교양 미술', '조원재', 'S3'),
       (11, 'H마트에서 울다', '미셸 자우너', 'S1'),
       (12, '가재가 노래하는 곳 :델리아 오언스 장편소설', '델리아 오언스', 'S1'),
       (13, '구의 증명 :최진영 소설', '최진영', 'S1'),
       (14, '돌이킬 수 없는 약속 :야쿠마루 가쿠 장편소설', '야쿠마루 가쿠', 'S1'),
       (15, '이기적 유전자', '리처드 도킨스', 'S4'),
       (16, '지구 끝의 온실 :김초엽 장편소설', '김초엽', 'S1'),
       (17, '햇빛은 찬란하고 인생은 귀하니까요 :밀라논나 이야기: ciao, amici', '장명숙', 'S3'),
       (18, '홍학의 자리 :정해연 장편소설', '정해연', 'S1'),
       (19, '나의 하루는 4시 30분에 시작된다 :하루를 두 배로 사는 단 하나의 습관', '김유진', 'S3'),
       (20, '부자 아빠 가난한 아빠 :부자들이 들려주는 `돈`과 `투자`의 비밀 : 20주년 특별 기념판', '로버트 기요사키', 'S2'),
       (21, '불편한 편의점', '김호연', 'S1'),
       (22, '소크라테스 익스프레스 :철학이 우리 인생에 스며드는 순간', '에릭 와이너', 'S3'),
       (23, '파친코 :이민진 장편소설 .2', '이민진', 'S1'),
       (24, '(인생을 바꾸는 자기 혁명) 몰입 :`생각하고 집중하고 몰입하라 =Think Hard', '황농문', 'S3'),
       (25, '밝은 밤 :최은영 장편소설', '최은영', 'S1'),
       (26, '역행자 :돈?시간?운명으로부터 완전한 자유를 얻는 7단계 인생 공략집', '자청', 'S3'),
       (27, '친밀한 이방인 :정한아 장편소설', '정한아', 'S1'),
       (28, '하얼빈 :김훈 장편소설', '김훈', 'S1'),
       (29, '(서울 자가에 대기업 다니는) 김 부장 이야기 .1 ,김 부장 편', '송희구', 'S2'),
       (30, '나는 소망한다 내게 금지된 것을 :양귀자 장편소설','양귀자', 'S1'),
       (31, '내가 틀릴 수도 있습니다 :숲속의 현자가 전하는 마지막 인생수업', '비욘 나티코 린데블라드', 'S3'),
       (32, '달콩이네 떡집', '김리리', 'S1'),
       (33, '사피엔스 :유인원에서 사이보그까지, 인간 역사의 대담하고 위대한 질문', '유발 하라리', 'S3'),
       (34, '총, 균, 쇠 :무기, 병균, 금속은 인류의 운명을 어떻게 바꿨는가', '재레드 다이아몬드', 'S3'),
       (35, '테라피스트 :B.A. 패리스 장편소설', 'B.A. 패리스', 'S1'),
       (36, '파친코 :이민진 장편소설 .2', '이민진', 'S1'),
       (37, '프로젝트 헤일메리', '앤디 위어', 'S1'),
       (38, '(서울 자가에 대기업 다니는) 김 부장 이야기 .2 ,정 대리?권 사원 편', '송희구', 'S2'),
       (39, '그릿 :IQ, 재능, 환경을 뛰어넘는 열정적 끈기의 힘', '앤절라 더크워스', 'S3'),
       (40, '나는 부동산과 맞벌이한다 :배우자 대신 꼬박꼬박 월급을 가져오는 시스템 만들기', '너바나', 'S2'),
       (41, '달러구트 꿈 백화점 :이미예 장편소설 .2 ,단골손님을 찾습니다', '이미예', 'S1'),
       (42, '레슨 인 케미스트리 :보니 가머스 장편소설 .1', '보니 가머스', 'S1'),
       (43, '망원동 브라더스 :김호연 장편소설', '김호연', 'S1'),
       (44, '브라질에 비가 내리면 스타벅스 주식을 사라 :경제의 큰 흐름에서 기회를 잡는 매크로 투자 가이드', '피터 나바로', 'S2'),
       (45, '세상의 마지막 기차역 =The last train station in the world', '무라세 다케시', 'S1'),
       (46, '스토너 :존 윌리엄스 장편소설', '존 윌리엄스', 'S1'),
       (47, '신경 끄기의 기술 :인생에서 가장 중요한 것만 남기는 힘', '마크 맨슨', 'S3'),
       (48, '요즘 사는 맛 :먹고 사는 일에 누구보다 진심인 작가들의 일상 속 음식 이야기', '김겨울', 'S3'),
       (49, '우리가 빛의 속도로 갈 수 없다면 :김초엽 소설집', '김초엽', 'S1'),
       (50, '이웃집 백만장자 변하지 않는 부의 법칙 :흔들리지 않는 부는 어떻게 축적되는가', '토머스 스탠리', 'S2'),
       (51, '작별인사 :김영하 장편소설', '김영하', 'S1'),
       (52, '재수사 :장강명 장편소설 .1', '장강명', 'S1'),
       (53, '저주토끼 :정보라 소설집 =Cursed bunny', '정보라', 'S1'),
       (54, '죽고 싶지만 떡볶이는 먹고 싶어 :백세희 에세이', '백세희', 'S3'),
       (55, '채식주의자 :한강 연작소설', '한강', 'S1'),
       (56, '(50대 사건으로 보는) 돈의 역사 =The history of Money', '홍춘욱', 'S2'),
       (57, '(고양이 해결사) 깜냥 :홍민정 동화 .4 ,눈썰매장을 씽씽 달려라!', '홍민정', 'S1'),
       (58, '(보도 섀퍼의) 돈', '보도 섀퍼', 'S2'),
       (59, '(보도 섀퍼의) 이기는 습관 :불가능을 뛰어넘어 최후의 승자가 된 사람들', '보도 섀퍼', 'S2'),
       (60, '(서울 자가에 대기업 다니는) 김 부장 이야기 .3 ,송 과장 편', '송희구', 'S2'),
       (61, '(세상에서 가장 쉬운) 본질육아 :삶의 근본을 보여주는 부모, 삶을 스스로 개척하는 아이', '지나영', 'S3'),
       (62, '1차원이 되고 싶어 :박상영 장편소설', '박상영', 'S1'),
       (63, '가면산장 살인사건', '히가시노 게이고', 'S1'),
       (64, '개인주의자 선언 :판사 문유석의 일상유감', '문유석', 'S3'),
       (65, '고래 :천명관 장편소설', '천명관', 'S1'),
       (66, '긴긴밤', '루리', 'S1'),
       (67, '나의 문화유산답사기 :내 고향 서울 이야기 .11 ,서울편 3 : 사대문 안동네', '유홍준', 'S3'),
       (68, '당신은 결국 무엇이든 해내는 사람 :김상현 에세이', '김상현', 'S3'),
       (69, '모든 것은 기본에서 시작한다 :실력도 기술도 사람 됨됨이도, 기본을 지키는 손웅정의 삶의 철학', '손웅정', 'S3'),
       (70, '모순 :양귀자 소설', '양귀자', 'S1'),
       (71, '미라클모닝 :당신의 하루를 바꾸는 기적 아침 6분이면 충분하다', '할 엘로드', 'S3'),
       (72, '방금 떠나온 세계 :김초엽 소설집', '김초엽', 'S1'),
       (73, '생각에 관한 생각 :우리의 행동을 지배하는 생각의 반란', '대니얼 카너먼', 'S2'),
       (74, '수상한 목욕탕', '마쓰오 유미', 'S1'),
       (75, '순례주택 :유은실 소설', '유은실', 'S1'),
       (76, '시선으로부터, :정세랑 장편소설', '정세랑', 'S1'),
       (77, '아무튼, 술', '김혼비', 'S3'),
       (78, '어서 오세요, 휴남동 서점입니다 :황보름 장편소설', '황보름', 'S1'),
       (79, '엑시트 :당신의 인생을 바꿔 줄 부자의 문이 열린다! =Exit', '송희창', 'S2'),
       (80, '우리는 모두 죽는다는 것을 기억하라 :삶의 다른 방식을 찾고 있는 당신에게', '웨인 다이어', 'S3'),
       (81, '종이달 :가쿠다 미쓰요 장편소설', '가쿠다 미쓰요', 'S1'),
       (82, '최재천의 공부 :어떻게 배우며 살 것인가', '최재천', 'S3'),
       (83, '팩트풀니스 :우리가 세상을 오해하는 10가지 이유와 세상이 생각보다 괜찮은 이유', '한스 로슬링', 'S4'),
       (84, '허상의 어릿광대', '히가시노 게이고', 'S1'),
       (85, '(나를 숨 쉬게 하는) 보통의 언어들', '김이나', 'S3'),
       (86, '(쉽게 따라 만드는) 파이썬 주식 자동매매 시스템 =Python auto trading system', '박준성', 'S4'),
       (87, '(이미 늦었다고 생각하는 당신을 위한) 김미경의 마흔 수업', '김미경', 'S3'),
       (88, '공정하다는 착각 :능력주의는 모두에게 같은 기회를 제공하는가', '마이클 샌델', 'S2'),
       (89, '김경일의 지혜로운 인간생활 :님을 위한 행복한 인간관계 지침서', '김경일', 'S3'),
       (90, '나의 투자는 새벽 4시에 시작된다 :3년만에 300억으로 돌아온 유목민의 투자 인사이트', '유목민', 'S2'),
       (91, '내가 알고 있는 걸 당신도 알게 된다면 :전 세계가 주목한 코넬대학교의 인류 유산 프로젝트', '칼 필레머', 'S3'),
       (92, '내게 무해한 사람 :최은영 소설', '최은영', 'S1'),
       (93, '뉴욕 정신과 의사의 사람 도서관 :낙인과 혐오를 넘어 이해와 공존으로', '나종호', 'S4'),
       (94, '다이어트 사이언스 :지방세포 잠금해제 스타일스 다이어트 : 비만의 알고리즘, 간헐적 단식과 저탄수 식단의 과학 =Diet science 2022', '최겸', 'S4'),
       (95, '단순한 열정 :아니 에르노 소설', '아니 에르노', 'S1'),
       (96, '당신이 옳다 :정혜신 적정심리학', '정혜신', 'S4'),
       (97, '돈으로 살 수 없는 것들 :무엇이 가치를 결정하는가', '마이클 샌델', 'S2'),
       (98, '마음의 법칙 :사람의 마음을 사로잡는 51가지 심리학', '폴커', 'S4'),
       (99, '마케팅이다', '세스 고딘', 'S2'),
       (100, '마흔에 읽는 니체 :지금 이 순간을 살기 위한 철학 수업: Nietzsche', '장재형', 'S3');

INSERT INTO selfs_machine (machine_id, machine_location, dlv_id)
VALUES ('M1', '합정역', 'D1'),
('M2', '홍대입구역', 'D1'),
('M3', '신촌역', 'D2'),
('M4', '이대역', 'D2'),
('M5', '아현역', 'D3'),
('M6', '충정로역', 'D3'),
('M7', '시청역', 'D4'),
('M8', '을지로입구역', 'D4');


INSERT INTO checkout_sys (book_id, checkout_id, std_id, date_keep, date_ch, date_prereturn, date_return, machine_id, price_overdue, times_extension, return_0)
VALUES   ('6', 'CK0', 'B911354', '2023-04-18', '2023-04-21', '2023-05-12', NULL, 'M8', NULL, NULL, 0),
('15', 'CK1', 'B935620', '2023-05-10', '2023-05-12', '2023-05-31', NULL, 'M3', NULL, NULL, 0), 
 ('16', 'CK2', 'B911423', '2023-05-07', '2023-05-10', '2023-05-28', NULL, 'M8', NULL, NULL, 0),
 ('59', 'CK3', 'B911423', '2023-05-11', '2023-05-14', '2023-06-01', NULL, 'M8', NULL, NULL, 0),
 ('92', 'CK4', 'B935620', '2023-05-11', '2023-05-14', '2023-06-01', NULL, 'M3', NULL, NULL, 0),
 ('99','CK5','B946271','2023-05-13','2023-05-14','2023-06-3',NULL,'M4',NULL,NULL,0);


INSERT INTO reservation (reserv_id, book_id, checkout_id,std_id)
VALUES ('R1', '15','CK1','B911423'),
('R2', '16', 'CK2','B946271'),
('R3', '59', 'CK3','B946271');
 
 
INSERT INTO sector (sector_id, sector_name, lib_id)
VALUES ('S1','문학','L1'),
('S2','경제경영','L2'),
('S3','인문일반','L3'),
('S4','과학일반','L4');

#HW2-3: 대출 시 대출 도서 개수 확인 + 연체된 경우 대출 불가 함수

#HW2-3: reserve에 데이터 삽입 시 각 학생 예약 개수 확인 후 3개 넘으면 데이터 추가 x
 
#HW2-3: checkout_sys 들어오면 자동으로 checkout_return 테이블에도 insert

#HW2-3: checkout_sys 입력 시 date_keep + 3일 


DROP PROCEDURE IF EXISTS check_num_checkout;
#HW 2-3 1.
DELIMITER //
CREATE PROCEDURE check_num_checkout(
	IN book_id1 INT,
    IN checkout_id1 VARCHAR(10),
    IN std_id1 VARCHAR(10),
    IN date_keep1 date ,
    IN date_ch1 date ,
    IN date_prereturn1 date,
    IN date_return1 date  ,
    IN machine_id1 varchar(10),
    IN price_overdue1 int,
    IN times_extension1 int,
    IN return_01 int
)
BEGIN
	DECLARE Count INT;
    DECLARE Overdue date;
    DECLARE NoOverdue date;
    select COUNT(std_id) INTO Count FROM checkout_sys where std_id1= checkout_sys.std_id; 
     select min(date_prereturn) INTO Overdue from checkout_sys where std_id1= checkout_sys.std_id;
     
	IF(Count<3) THEN # 같은학생의 대출수가 3보다 작아야 하며, 
		IF(Count=0) THEN # 일단 대출 SYS에 대출 내역이 없으면 
			insert into checkout_sys(book_id, checkout_id, std_id, date_keep, date_ch, date_prereturn, date_return, machine_id, price_overdue, times_extension, return_0)
			VALUES(book_id1, checkout_id1, std_id1, date_keep1, date_ch1, date_prereturn1, date_return1, machine_id1, price_overdue1, times_extension1, return_01);
		ELSEIF(Count=1) THEN
			select date_prereturn INTO NoOverdue from checkout_sys where std_id1= checkout_sys.std_id;
			IF (NoOverdue is NULL)THEN
				insert into checkout_sys(book_id, checkout_id, std_id, date_keep, date_ch, date_prereturn, date_return, machine_id, price_overdue, times_extension, return_0)
				VALUES(book_id1, checkout_id1, std_id1, date_keep1, date_ch1, date_prereturn1, date_return1, machine_id1, price_overdue1, times_extension1, return_01);
			ELSE 
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = '대출 불가합니다1';
			END IF;
		ELSE
			IF(Overdue>date_keep1) THEN#대출 내역이 있으면 반납 예정일이 가장 얼마 안남은것보다 현재 날짜가 크거나 , 반납 예정일이 없으면  INSERT
				insert into checkout_sys(book_id, checkout_id, std_id, date_keep, date_ch, date_prereturn, date_return, machine_id, price_overdue, times_extension, return_0)
				VALUES(book_id1, checkout_id1, std_id1, date_keep1, date_ch1, date_prereturn1, date_return1, machine_id1, price_overdue1, times_extension1, return_01);
            ELSE# 2023-06-01이 앞선다면 대출불가.
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = '대출 불가합니다1';
            END IF;
        END IF;
    ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = '대출 불가합니다';
	END IF;
END //

call check_num_checkout('30', 'CK8' ,'B918231', '2023-06-01', NULL, NULL, NULL, 'M5', NULL, NULL, 0);
call check_num_checkout('45', 'CK9', 'B712423', '2023-06-01', NULL, NULL, NULL, 'M3', NULL, NULL, 0);
call check_num_checkout('46', 'CK10', 'B712423', '2023-06-01', NULL, NULL, NULL, 'M3', NULL, NULL, 0);
call check_num_checkout('78', 'CK11', 'B862331', '2023-06-01', NULL, NULL, NULL, 'M1', NULL, NULL, 0);  # 4번다 대출가능

SELECT COUNT(*) AS number_of_books_checked_out
FROM checkout_sys
WHERE std_id = 'B935620' AND date_return IS NULL
PRINT 'Debugging message';
CALL check_num_checkout('101', 'CK13', 'B935620', '2023-06-01', NULL, NULL, NULL, 'M2', NULL, NULL, 0);
CALL check_num_checkout('102', 'CK14', 'B935620', '2023-06-01', NULL, NULL, NULL, 'M2', NULL, NULL, 0); #연체로 인하여 "대출 불가"

CALL check_num_checkout('101', 'CK13', 'B935620', '2023-05-30', NULL , NULL, NULL, 'M2', NULL, NULL,0);
CALL check_num_checkout('102', 'CK14', 'B935620', '2023-05-30 ', NULL , NULL, NULL, 'M2', NULL, NULL,0); #B8935620의 대출수가 3권이 넘어 "대출 불가합니다" 표시 확인.

#HW 2-3 2.
DELIMITER //
CREATE TRIGGER ReturnInsert
AFTER INSERT ON checkout_sys for each row
begin
	insert into checkout_return(book_id, checkout_id, std_id)
		values(NEW.book_id, NEW.checkout_id, NEW.std_id);
end;
//
DELIMITER ;

INSERT INTO checkout_sys (std_id, checkout_id, book_id, date_keep, date_ch, date_prereturn, date_return, machine_id,
price_overdue, times_extension, return_0)
VALUES ('B763523', 'CK12', '64', '2023-06-01', NULL, NULL, NULL, 'M7', NULL, NULL, 0);
SELECT * FROM checkout_return WHERE checkout_id = 'CK12'; #삽입확인