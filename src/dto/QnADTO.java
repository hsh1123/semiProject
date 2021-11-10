package dto;

import java.io.Serializable;

public class QnADTO implements Serializable{
	private int Seq;
	private String UserID;
	private String Title;
	private String Content;
	private String Email;
	private String Rdate;
	private int ref;	// 그룹번호
	private int step;	// 행번호
	private int del;		// 삭제
	private int readcount;	// 조회수
	
	public QnADTO(){}
	/**
	 * @param Seq : 순서번호
	 * @param userID : 회원아이디
	 * @param title : 제목
	 * @param content : 내용
	 * @param email : email
	 * @param Rdate : 날짜
	 */

	public QnADTO(int seq, String userID, String title, String content, String email, String rdate, int ref, int step,
			int del, int readcount) {
		super();
		Seq = seq;
		UserID = userID;
		Title = title;
		Content = content;
		Email = email;
		Rdate = rdate;
		this.ref = ref;
		this.step = step;
		this.del = del;
		this.readcount = readcount;
	}
	
	public QnADTO(String userID, String title, String content, String email) {
		super();
		UserID = userID;
		Title = title;
		Content = content;
		Email = email;
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
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getRdate() {
		return Rdate;
	}
	public void setRdate(String rdate) {
		Rdate = rdate;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	
	

	
	

}
