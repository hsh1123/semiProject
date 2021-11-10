package dto;
public class TodayWeatherDTO {
	private int Seq;
	private String UserID;
	// private String UserName;
	private String Title;
	private String Content; //210625 추가, comment->content
	private String FileName;
	private String newFileName;	// 210625 10:42 추가 - weather.sql 추가
	private String LastUpdate;
	private int LikeCount;
	private String LocationCode; // 210625 14:51 수정 - weather.sql 추가
	private int Del;
	
	public TodayWeatherDTO() {
		
	}
	
	/**
	 * @param seq : 글번호
	 * @param userID : 회원 아이디
	 * @param name : 회원 닉네임
	 * @param title : 제목
	 * @param Content: 한줄코멘트
	 * @param FileName : 파일명
	 * @param newFileName : 변환파일명
	 * @param LocationCode : 각 구 코드
	 * @param lastUpdate : 등록/수정일
	 * @param likeCount : 좋아요 카운트
	 */
	
	// 전체 usingfield 세팅
	public TodayWeatherDTO(int seq, String userID, /*String userName,*/ String title, String content, String fileName,
			String newFileName, String lastUpdate, int likeCount, String locationCode, int del) {
		super(); // 있어야 하는 것 맞나요??
		this.Seq = seq;
		this.UserID = userID;
		//this.UserName = userName;
		this.Title = title;
		this.Content = content;
		this.FileName = fileName;
		this.newFileName = newFileName;
		this.LastUpdate = lastUpdate;
		this.LikeCount = likeCount;
		this.LocationCode = locationCode;		
		this.Del = del;
	}
	// 외부입력변수 usingfield 세팅 - seq, lastupdate 두 가지만 제외함
	public TodayWeatherDTO(String userID, /*String userName,*/ String title, String content, String fileName,
			String newFileName, int likeCount, String locationCode) {
		super(); // 있어야 하는 것 맞나요??
		this.UserID = userID;
		//this.UserName = userName;
		this.Title = title;
		this.Content = content;
		this.FileName = fileName;
		this.newFileName = newFileName;
		this.LikeCount = likeCount;
		this.LocationCode = locationCode;
		
	}
	
	public TodayWeatherDTO(String userID,/* String userName,*/ String title, String content, String fileName,
			String newFileName, String locationCode) {
		super(); // 있어야 하는 것 맞나요??
		this.UserID = userID;
		//this.UserName = userName;
		this.Title = title;
		this.Content = content;
		this.FileName = fileName;
		this.newFileName = newFileName;
		this.LocationCode = locationCode;
	}
	// getter & setter
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

	/*
	 * public String getUserName() { return UserName; } public void
	 * setUserName(String userName) { UserName = userName; }
	 */
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
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}
	public String getLastUpdate() {
		return LastUpdate;
	}
	public void setLastUpdate(String lastUpdate) {
		LastUpdate = lastUpdate;
	}
	public int getLikeCount() {
		return LikeCount;
	}
	public void setLikeCount(int likeCount) {
		LikeCount = likeCount;
	}
	public String getLocationCode() {
		return LocationCode;
	}
	public void setLocationCode(String locationCode) {
		LocationCode = locationCode;
	}
	public int getDel() {
		return Del;
	}
	public void setDel(int del) {
		Del = del;
	}

	@Override
	public String toString() {
		return "TodayWeatherDTO [Seq=" + Seq + ", UserID=" + UserID + ", Title=" + Title + ", Content=" + Content
				+ ", FileName=" + FileName + ", newFileName=" + newFileName + ", LocationCode=" + LocationCode
				+ ", LastUpdate=" + LastUpdate + ", LikeCount=" + LikeCount + ", Del=" + Del + "]";
	}

	
}