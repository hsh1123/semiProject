package dto;

public class GradeDTO {
	
	private int gradeCode;
	private String gradeName;
	public GradeDTO(int gradeCode, String gradeName) {
		super();
		this.gradeCode = gradeCode;
		this.gradeName = gradeName;
	}
	public int getGradeCode() {
		return gradeCode;
	}
	public void setGradeCode(int gradeCode) {
		this.gradeCode = gradeCode;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	@Override
	public String toString() {
		return "GradeDTO [gradeCode=" + gradeCode + ", gradeName=" + gradeName + "]";
	}
	
	

}
