<%@page import="dao.ForeCastWeatherDAO"%>
<%@page import="dto.ForeCastWeatherDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.jsoup.Connection"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="org.jsoup.select.Elements"%>

<%  


 	String locationCode= request.getParameter("locationCode");
	String state = "";
	
	if(locationCode==null || locationCode.equals("")){
		locationCode = "09440730";
	}
		
	WeatherLocationDAO dao = WeatherLocationDAO.getInstance();
	List<WeatherLocationDTO> list = dao.getStateList();
	
	for(int i = 0;i< list.size() ; i++){
		if(list.get(i).getLocationCode().equals(locationCode))
		{
			state = list.get(i).getState();
			break;
		}
	}
	
	

%>
<!DOCTYPE html>
<html>
<head></head>
<style>
#content {
margin-top:-14px !important;
margin-left:-16px !important;
width:1450px !important;
}
.section_center {
margin-left:30px !important;

}
#container {
margin-top:-90px !important;
}
</style>
<body>


				<form>
					<select
						style="width: 40%; margin-left: 30px; float: left; height: 50px;"
						name="locationCode" class="form-select"
						aria-label="Default select example">

						<%for(int i= 0; i<list.size();i++){ 
					WeatherLocationDTO dto2 = list.get(i);
				
				%>
						<option value="<%=dto2.getLocationCode() %>"
							<%=dto2.getLocationCode().equals(locationCode)?"selected":""%>>
							<%=dto2.getState() %></option>

						<%} %>
					</select> <input type="submit" style="margin-left: 10px; height: 50px;"
						value="지역 선택" class="btn btn-dark">

			</form>
			<%!
public String setMin(String min){
     String minFirst = min.substring(0, 1);
     
     return minFirst+"0";
}
 


%>
			<%
	//String locationCode = dto.getLocationCode();
	String url = "https://weather.naver.com/today/";
	
	url = url + locationCode;
	

	// 문서 로드
	Connection.Response res = Jsoup.connect(url).method(Connection.Method.GET).execute();

	Document document  = res.parse();

	document.select("div#header").remove();
	document.select("div.cp_area").remove();
	document.select("div.section_right").remove();
	document.select("div.card_video").remove();
	document.select("div.card card_news").remove();
	document.select("div#news").remove();
	document.select("div#footer").remove();
	document.select("div.card_advertisement").remove();


	String html = document.html();

	html += "<br/><div style='color:darkgray;width:40%;margin-left:20%;float:left;'>©NAVER Corp.</div><br/>";
	out.println(html);
	// 데이터 값 뽑아서 DB INSERT
		 
    Document doc = Jsoup.connect(url).get();
	
	
	// 온도
    Elements posts = doc.body().getElementsByClass("current");

    Elements spans = doc.select("span");
    for(Element span : spans) {
        span.remove();
    }
    
    String temperature = "";
	for (Element result : posts.select("strong")) {
		temperature = result.childNode(0).toString();
	}
	
    Elements dls = doc.select("dl.summary_list");
    Element eleRain =dls.select(".desc").get(0);
    Element elehumidity =dls.select(".desc").get(1);
     
    
    String rain = eleRain.text();
    String humidity = elehumidity.text();
    //element.text()
    //out.println( rain + humidity);

    Date current = new Date();
    
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat sdf2 = new SimpleDateFormat("hh");
    SimpleDateFormat sdf3 = new SimpleDateFormat("mm");
        		
    String day = sdf1.format(current); //현재기준 날짜(일)구하기
    String hour = sdf2.format(current);//현재 기준 시 구하기
    String min = setMin(sdf3.format(current));
	System.out.println(day+""+hour+""+min);
	
	ForeCastWeatherDTO Fdto = new ForeCastWeatherDTO( locationCode,  day,  hour,  min,  rain,
			 humidity,  temperature);
	
	 ForeCastWeatherDAO Fdao = ForeCastWeatherDAO.getInstance();
	 boolean b = Fdao.addWeather(Fdto);
	
%>

<a class="dropdown-item" href="#" data-toggle="modal" id="alertModalCall"
									data-target="#alertModal" style="display:none;"> 
								</a>

    <div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"><%=state %> 실시간 날씨 </h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">실시간 날씨 데이터 수집되었습니다 !</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

		
</body>

<script>
$(document).ready(function() {
	$("#header").css("visibility","hidden");
	
	$("#alertModalCall").click();
});
</script>

</html>


