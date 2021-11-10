package dto;

public class ForeCastWeatherDTO {

	private int seq;
	private String locationCode;
	private String accessDate;
	private String accessHour;
	private String accessMin;
	private String rain;
	private String humidity;
	private String temperature;
	
	
	public ForeCastWeatherDTO() {
		
	}


	public ForeCastWeatherDTO(int seq, String locationCode, String accessDate, String accessHour, String accessMin,
			String rain, String humidity, String temperature) {
		super();
		this.seq = seq;
		this.locationCode = locationCode;
		this.accessDate = accessDate;
		this.accessHour = accessHour;
		this.accessMin = accessMin;
		this.rain = rain;
		this.humidity = humidity;
		this.temperature = temperature;
	}


	public ForeCastWeatherDTO(String locationCode, String accessDate, String accessHour, String accessMin, String rain,
			String humidity, String temperature) {
		super();
		this.locationCode = locationCode;
		this.accessDate = accessDate;
		this.accessHour = accessHour;
		this.accessMin = accessMin;
		this.rain = rain;
		this.humidity = humidity;
		this.temperature = temperature;
	}


	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public String getLocationCode() {
		return locationCode;
	}


	public void setLocationCode(String locationCode) {
		this.locationCode = locationCode;
	}


	public String getAccessDate() {
		return accessDate;
	}


	public void setAccessDate(String accessDate) {
		this.accessDate = accessDate;
	}


	public String getAccessHour() {
		return accessHour;
	}


	public void setAccessHour(String accessHour) {
		this.accessHour = accessHour;
	}


	public String getAccessMin() {
		return accessMin;
	}


	public void setAccessMin(String accessMin) {
		this.accessMin = accessMin;
	}


	public String getRain() {
		return rain;
	}


	public void setRain(String rain) {
		this.rain = rain;
	}


	public String getHumidity() {
		return humidity;
	}


	public void setHumidity(String humidity) {
		this.humidity = humidity;
	}


	public String getTemperature() {
		return temperature;
	}


	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}


	@Override
	public String toString() {
		return "ForeCastWeatherDTO [seq=" + seq + ", locationCode=" + locationCode + ", accessDate=" + accessDate
				+ ", accessHour=" + accessHour + ", accessMin=" + accessMin + ", rain=" + rain + ", humidity="
				+ humidity + ", temperature=" + temperature + "]";
	}
	
}
