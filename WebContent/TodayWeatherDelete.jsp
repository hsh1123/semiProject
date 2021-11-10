<%@page import="dto.MemberDTO"%>
<%@page import="dao.TodayWeatherDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
Object ologin = session.getAttribute("login");
MemberDTO mem = null;
mem = (MemberDTO)ologin;
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String sseq = request.getParameter("seq");
int Seq = Integer.parseInt(sseq.trim());

System.out.println("Seq:" + Seq);

TodayWeatherDAO dao = TodayWeatherDAO.getInstance();
boolean isS = dao.deleteTodayWeather(Seq);

if(isS){
	%>
	<script type="text/javascript">
	alert("삭제하였습니다");
	location.href = 'Main.jsp?content=TodayWeatherList';
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("삭제되지 않았습니다");
	location.href = 'Main.jsp?content=TodayWeatherList';
	</script>	
	<%
}
%>

</body>
</html>