package dto;

import java.io.Serializable;

/*
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

CREATE TABLE FREEBOARD(
  SEQ NUMBER(8) PRIMARY KEY,
  USERID VARCHAR2(50) NOT NULL,
  TITLE VARCHAR2(200) NOT NULL,
  CONTENT VARCHAR2(4000) NOT NULL,
  LOCATIONCODE VARCHAR2(50) NOT NULL,
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

 */

public class FreeBoardDTO implements Serializable{
	
	private int Seq;
	private String UserID;
	private String Title;
	private String Content;
	private String LocationCode;
	private String LastUpdate;
	private int ReadCount;
	private int Del;
	private String CategoryCode;
	private String State;
	
	
	/**
	 * @param seq : 글번호
	 * @param userID ㅣ 회원 아이디
	 * @param title : 글 제목
	 * @param content : 글 내용
	 * @param locationcode : 지역코드
	 * @param lastUpdate : 등록/수정일
	 * @param readCount : 조회수
	 * @param del : 삭제 
	 * @param categoryCode : 카테고리
	 */
	public FreeBoardDTO(int seq, String userID, String title, String content, String locationcode,String state,
					String lastUpdate, int readCount, int del, String categoryCode) {
		
		this.Seq = seq;
		this.UserID = userID;
		this.Title = title;
		this.Content = content;
		this.LocationCode = locationcode;
		this.State = state;
		this.LastUpdate = lastUpdate;
		this.ReadCount = readCount;
		this.Del = del;
		this.CategoryCode = categoryCode;
	}

	//외부영향 생성자
public FreeBoardDTO(String userID, String title, String content, String locationcode, String categoryCode) {
		super();
		UserID = userID;
		Title = title;
		Content = content;
		LocationCode = locationcode;
		CategoryCode = categoryCode;
	}


		//외부영향 생성자
	public FreeBoardDTO(String userID, String title, String content, String locationcode,String state, String categoryCode) {
			super();
			UserID = userID;
			Title = title;
			Content = content;
			LocationCode = locationcode;
			CategoryCode = categoryCode;
			State = state;
		}



	public FreeBoardDTO()
	{
		
	}


	public int getSeq() {
		return Seq;
	}


	public void setSeq(int seq) {
		Seq = seq;
	}


	public String getUserID() {
		return UserID;
	}


	public void setUserID(String userID) {
		UserID = userID;
	}


	public String getTitle() {
		return Title;
	}


	public void setTitle(String title) {
		Title = title;
	}


	public String getContent() {
		return Content;
	}


	public void setContent(String content) {
		Content = content;
	}


	public String getLocationCode() {
		return LocationCode;
	}


	public void setLocationCode(String locationCode) {
		LocationCode = locationCode;
	}


	public String getState() {
		return State;
	}


	public void setState(String state) {
		State = state;
	}


	public String getLastUpdate() {
		return LastUpdate;
	}


	public void setLastUpdate(String lastUpdate) {
		LastUpdate = lastUpdate;
	}


	public int getReadCount() {
		return ReadCount;
	}


	public void setReadCount(int readCount) {
		ReadCount = readCount;
	}


	public int getDel() {
		return Del;
	}


	public void setDel(int del) {
		Del = del;
	}


	public String getCategoryCode() {
		return CategoryCode;
	}


	public void setCategoryCode(String categoryCode) {
		CategoryCode = categoryCode;
	}


	@Override
	public String toString() {
		return "FreeBoardDTO [Seq=" + Seq + ", UserID=" + UserID + ", Title=" + Title + ", Content=" + Content
				+ ", LocationCode=" + LocationCode + ", LastUpdate=" + LastUpdate + ", ReadCount=" + ReadCount
				+ ", Del=" + Del + ", CategoryCode=" + CategoryCode + "]";
	}

	
	

}
