package dto;

public class MemberDTO {

	private String UserID;
	private String UserPW;
	private String UserName;
	private String Email;
	private int GradeCode;
	private String GradeName;
	private String LocationCode;
	private int Del;
	
	/**
	 * @param userID : 회원 아이디
	 * @param userPW : 회원 비밀번호
	 * @param userName : 회원 닉네임
	 * @param email : 이메일
	 * @param gradeCode : 등급
	 * @param locationCode : 위치코드
	 * @param DeleteYN : 탈퇴여부
	 */
	
	public MemberDTO(String userID,String userPW, String userName, String email, String gradeName,int del) {
		
		this.UserID = userID;
		this.UserPW = userPW;
		this.UserName = userName;
		this.Email = email;
		this.GradeName = gradeName;
		this.Del = del;
	}
	
	public MemberDTO(String userID, String userPW, String userName, String email, int gradeCode, String gradeName,
			String locationCode, int del) {
		super();
		this.UserID = userID;
		this.UserPW = userPW;
		this.UserName = userName;
		this.Email = email;
		this.GradeCode = gradeCode;
		this.GradeName = gradeName;
		this.LocationCode = locationCode;
		this.Del = del;
	}

	public MemberDTO(String userID, String userPW, String userName, String email, int gradeCode, String locationCode,
			int del) {
		
		UserID = userID;
		UserPW = userPW;
		UserName = userName;
		Email = email;
		GradeCode = gradeCode;
		LocationCode = locationCode;
		Del = del;
	}
	public MemberDTO(String UserID, String UserPW,String name,String email,int gcode,String lcode)
	{
		this.UserID = UserID;
		this.UserPW = UserPW;
		this.UserName = name;
		this.Email = email;
		this.GradeCode = gcode;
		this.LocationCode = lcode;
		
	}
	public MemberDTO(String UserID, String UserPW,String name,String email,int gcode,int del)
	{
		this.UserID = UserID;
		this.UserPW = UserPW;
		this.UserName = name;
		this.Email = email;
		this.GradeCode = gcode;
		this.Del = del;
		
	}
	
	public MemberDTO() {
		
	}

	public MemberDTO(String id, String pw, String name, String email, int gcode, int del, String locationCode) {
		this.UserID = id;
		this.UserPW = pw;
		this.UserName = name;
		this.Email = email;
		this.GradeCode = gcode;
		this.Del = del;
		this.LocationCode = locationCode;
	}

	public String getUserID() {
		return UserID;
	}

	public void setUserID(String userID) {
		UserID = userID;
	}

	public String getUserPW() {
		return UserPW;
	}

	public void setUserPW(String userPW) {
		UserPW = userPW;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String userName) {
		UserName = userName;
	}

	public String getEmail() {
		return Email;
	}

	public void setEmail(String email) {
		Email = email;
	}

	public String getEmailID() {
		return Email.replace(getEmailDetail(),"");
	}


	public String getEmailDetail() {
		return Email.replace(UserID,"");
	}

	public String getLocationCode() {
		return LocationCode;
	}

	public void setLocationCode(String locationCode) {
		LocationCode = locationCode;
	}
	public int getGradeCode() {
		return GradeCode;
	}

	public void setGradeCode(int gradeCode) {
		GradeCode = gradeCode;
	}
	
	public int getDel() {
		return Del;
	}

	public void setDel(int del) {
		Del = del;
	}

	public String getGradeName() {
		return GradeName;
	}

	public void setGradeName(String gradeName) {
		GradeName = gradeName;
	}

	@Override
	public String toString() {
		return "MemberDTO [UserID=" + UserID + ", UserPW=" + UserPW + ", UserName=" + UserName + ", Email=" + Email
				+ ", GradeCode=" + GradeCode + ", GradeName=" + GradeName + ", LocationCode=" + LocationCode + ", Del="
				+ Del + "]";
	}

	
}