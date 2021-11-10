package dto;

import java.io.Serializable;

public class CommentsDTO implements Serializable{
/*
 CREATE TABLE COMMENTS(
  COMMENT_NUMBER NUMBER PRIMARY KEY,
  USERID VARCHAR2(15) NOT NULL,
  COMMENT_CONTENT VARCHAR2(200) NOT NULL,
  COMMENT_DATE DATE NOT NULL,
  SEQ NUMBER(8) NOT NULL,
  COMMENTDEL NUMBER(1) NOT NULL,
 
CONSTRAINT COMMENT_FK FOREIGN KEY(SEQ)
REFERENCES FREEBOARD(SEQ) ON DELETE CASCADE)
 
--댓글 시퀀스 생성
CREATE SEQUENCE  COMMENTS_SEQ
 START WITH 1
INCREMENT BY 1;

 */
	
	private int commentNum;
	private String UserID;
	private String commentContent;
	private String commentDate;
	private int Seq;
	private int commentdel;
	
	
	public CommentsDTO(int commentNum, String userID, String commentContent, String commentDate, int seq,
			int commentdel) {
		super();
		this.commentNum = commentNum;
		UserID = userID;
		this.commentContent = commentContent;
		this.commentDate = commentDate;
		Seq = seq;
		this.commentdel = commentdel;
	}

	//외부영향 생성자 
	public CommentsDTO(String userID, String commentContent) {
		super();
		UserID = userID;
		this.commentContent = commentContent;
	}
	
	public CommentsDTO() {
		
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}

	public String getUserID() {
		return UserID;
	}

	public void setUserID(String userID) {
		UserID = userID;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public String getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}

	public int getSeq() {
		return Seq;
	}

	public void setSeq(int seq) {
		Seq = seq;
	}
	
	public int getCommentdel() {
		return commentdel;
	}

	public void setCommentdel(int commentdel) {
		this.commentdel = commentdel;
	}

	@Override
	public String toString() {
		return "CommentsDTO [commentNum=" + commentNum + ", UserID=" + UserID + ", commentContent=" + commentContent
				+ ", commentDate=" + commentDate + ", Seq=" + Seq + ", commentdel=" + commentdel + "]";
	}


	
	
	
}
