package dto;

public class WeatherLocationDTO {
	
	private String City;
	private String State;
	private String LocationCode;
	
	/**
	 * @param seq : index
	 * @param city : 시
	 * @param state : 구
	 */
	public WeatherLocationDTO(String locationCode, String city, String state) {
		
		this.City = city;
		this.State = state;
		this.LocationCode = locationCode;
	}
	
	public WeatherLocationDTO() {
		
	}

	public String getCity() {
		return City;
	}

	public void setCity(String city) {
		City = city;
	}

	public String getState() {
		return State;
	}

	public void setState(String state) {
		State = state;
	}

	public String getLocationCode() {
		return LocationCode;
	}

	public void setLocationCode(String locationCode) {
		LocationCode = locationCode;
	}

	@Override
	public String toString() {
		return "WeatherLocationDTO [City=" + City + ", State=" + State + ", LocationCode=" + LocationCode + "]";
	}

	
	
}
