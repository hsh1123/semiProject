package dto;

import java.io.Serializable;


public class BookMarkDTO implements Serializable {
	
	private int Seq;
	private String UserID;
	
	private String State;
	private String Rain;
	private String Humidity;

	private String Temperature;
	
	private String locationCode;
	
	public BookMarkDTO(String state, String rain, String humidity, String temperature) {
		
		this.State = state;
		this.Rain = rain;
		this.Humidity = humidity;
		this.Temperature = temperature;
	}

public BookMarkDTO(int seq,String state, String rain, String humidity, String temperature) {
		this.Seq = seq;
		this.State = state;
		this.Rain = rain;
		this.Humidity = humidity;
		this.Temperature = temperature;
	}



	/**
	 * @param seq : 글번호
	 * @param userID : 회원아이디
	 * @param userName : 회원닉네임
	 * @param locationCode 
	 */
	
	public BookMarkDTO() {
		
	}

	
	public BookMarkDTO(int seq,String userID,String locationCode)
	{
		this.Seq = seq;
		this.UserID = userID; // 외부
	
		this.locationCode = locationCode; // 외부
	}

	public BookMarkDTO(String userID, String locationCode) {
		this.UserID = userID;
		this.locationCode = locationCode;
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

	

	public String getLocationCode() {
		return locationCode;
	}

	public void setLocationCode(String locationCode) {
		this.locationCode = locationCode;
	}

	
	
	public String getState() {
		return State;
	}



	public void setState(String state) {
		State = state;
	}



	public String getRain() {
		return Rain;
	}



	public void setRain(String rain) {
		Rain = rain;
	}



	public String getHumidity() {
		return Humidity;
	}



	public void setHumidity(String humidity) {
		Humidity = humidity;
	}



	public String getTemperature() {
		return Temperature;
	}



	public void setTemperature(String temperature) {
		Temperature = temperature;
	}


	@Override
	public String toString() {
		return "BookMarkDTO [Seq=" + Seq + ", UserID=" + UserID +  ", locationCode="
				+ locationCode +" ]";
	}
	
	
	

}