<%@page import="dao.TodayWeatherDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String sseq = request.getParameter("Seq");
int Seq = Integer.parseInt(sseq.trim());

String Title = request.getParameter("Title");
String Content = request.getParameter("Content");

TodayWeatherDAO dao = TodayWeatherDAO.getInstance();
boolean isS = dao.updateTodayWeather(Seq, Title, Content);

if(isS == true){
	%>
	<script type="text/javascript">
	alert("글 수정 성공");
	location.href="Main.jsp?content=TodayWeatherList";
	</script>	
	<%
}else{	
	%>
	<script type="text/javascript">
	alert("글 수정 실패");
	location.href="Main.jsp?content=TodayWeatherList";
	</script>
	<%
}	
%>

</body>
</html>