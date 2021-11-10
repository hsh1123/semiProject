
CREATE TABLE WEATHERLOCATION(
   SEQ NUMBER(8) PRIMARY KEY,
   CITY VARCHAR2(50) NOT NULL,
   STATE VARCHAR2(50) NOT NULL
);

CREATE SEQUENCE SEQ_WEATHERLOCATION
START WITH 1
INCREMENT BY 1;



CREATE TABLE GRADE(
   SEQ NUMBER(8) PRIMARY KEY,
   GRADENAME VARCHAR2(50) NOT NULL,
   STARTPOINT NUMBER(8) NOT NULL,
   ENDPOINT NUMBER(8) NOT NULL
);


CREATE SEQUENCE SEQ_GRADE
START WITH 1
INCREMENT BY 1;


CREATE TABLE MEMBERPOINT(
   SEQ NUMBER(8) PRIMARY KEY,
   USERID VARCHAR2(50) NOT NULL,
   POINT NUMBER(8) NOT NULL
);





CREATE SEQUENCE SEQ_MEMBERPOINT
START WITH 1
INCREMENT BY 1;



CREATE TABLE WEATHERMEMBER(
   SEQ NUMBER(8) PRIMARY KEY,
   USERID VARCHAR2(50) UNIQUE NOT NULL,
   USERPW VARCHAR2(50) NOT NULL,
   USERNAME VARCHAR2(50) NOT NULL,
   EMAIL VARCHAR2(100) UNIQUE,
   GRADENAME VARCHAR2(50) NOT NULL,
   DEL NUMBER(8) NOT NULL
   
);


CREATE SEQUENCE SEQ_WEATHERMEMBER
START WITH 1
INCREMENT BY 1;

ALTER TABLE MEMBERPOINT
ADD CONSTRAINT FK_USER_ID FOREIGN KEY(USERID)
REFERENCES WEATHERMEMBER(USERID);


CREATE TABLE BOOKMARK(
   SEQ NUMBER(8) PRIMARY KEY,
   USERID VARCHAR2(50) NOT NULL,
   USERNAME VARCHAR2(50) NOT NULL,
   CITY VARCHAR2(50) NOT NULL,
   STATE VARCHAR2(50) NOT NULL
   
);


CREATE SEQUENCE SEQ_BOOKMARK
START WITH 1
INCREMENT BY 1;

ALTER TABLE BOOKMARK
ADD CONSTRAINT FK_BOOKMARK_USER_ID FOREIGN KEY(USERID)
REFERENCES WEATHERMEMBER(USERID);


CREATE TABLE QNA(
   SEQ NUMBER(8) PRIMARY KEY,
   USERID VARCHAR2(50) NOT NULL,
   TITLE VARCHAR2(300) NOT NULL,
   CONTENT VARCHAR2(3000) NOT NULL,
   FILENAME VARCHAR2(100) NOT NULL,
   EMAIL VARCHAR2(100) NOT NULL
   
);

CREATE SEQUENCE SEQ_QNA
START WITH 1
INCREMENT BY 1;

ALTER TABLE QNA
ADD CONSTRAINT FK_QNA_USER_ID FOREIGN KEY(USERID)
REFERENCES WEATHERMEMBER(USERID);



CREATE TABLE TODAYWEATHER(
   SEQ NUMBER(8) PRIMARY KEY,
   USERID VARCHAR2(50) NOT NULL,
   USERNAME VARCHAR2(50) NOT NULL,
   TITLE VARCHAR2(300) NOT NULL,
   FILENAME VARCHAR2(900) NOT NULL,
   CITY VARCHAR2(50) NOT NULL,
   STATE VARCHAR2(50) NOT NULL,
   LASTUPDATE DATE NOT NULL,
   LIKECOUNT NUMBER(8) NOT NULL
   
);

CREATE SEQUENCE SEQ_TODAYWEATHER
START WITH 1
INCREMENT BY 1;

ALTER TABLE TODAYWEATHER
ADD CONSTRAINT FK_TODAYWEATHER_USER_ID FOREIGN KEY(USERID)
REFERENCES WEATHERMEMBER(USERID);



CREATE TABLE FREEBOARD(
   SEQ NUMBER(8) PRIMARY KEY,
   USERID VARCHAR2(50) NOT NULL,
   REF NUMBER(8) NOT NULL,
   STEP NUMBER(8) NOT NULL,
   DEPTH NUMBER(8) NOT NULL,
   TITLE VARCHAR2(200) NOT NULL,
   CONTENT VARCHAR2(4000) NOT NULL,
   CITY VARCHAR2(50) NOT NULL,
   STATE VARCHAR2(50) NOT NULL,
   LASTUPDATE DATE NOT NULL,
   READCOUNT NUMBER(8) NOT NULL,
   DEL NUMBER(1) NOT NULL,
   CATEGORYCODE VARCHAR2(50) NOT NULL
   
);

CREATE SEQUENCE SEQ_FREEBOARD
START WITH 1
INCREMENT BY 1;

ALTER TABLE FREEBOARD
ADD CONSTRAINT FK_FREEBOARD_USERID FOREIGN KEY(USERID)
REFERENCES WEATHERMEMBER(USERID);


select * from freeboard

09380102

select * from WEATHERLOCATION