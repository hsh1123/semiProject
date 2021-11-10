<%@page import="dto.MemberDTO"%>
<%@page import="dto.TodayWeatherDTO"%>
<%@page import="dao.TodayWeatherDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.tbline tr{
	height: 60px;
}

</style>


</head>
<body>

<%
String sseq = request.getParameter("seq");
int Seq = Integer.parseInt(sseq.trim());

System.out.println("Seq:" + Seq);

TodayWeatherDAO dao = TodayWeatherDAO.getInstance();
TodayWeatherDTO bbs = dao.getTodayWeather(Seq);

%>

<%
Object ologin = session.getAttribute("login");
MemberDTO mem = null;
mem = (MemberDTO)ologin;
%>

<div align="center">

<form action="TodayWeatherUpdateAf.jsp" method="post">
<input type="hidden" name="Seq" value="<%=Seq %>">
			
<table border="0" class="tbline">
<col width="200"><col width="500"> 

<tr>	
	<td colspan="2">
		<h2>글수정</h2>
		<input type="hidden" name="UserID" value="<%=mem.getUserID()%>"><br>
	 </td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="Title" size="50px" value="<%=bbs.getTitle() %>"><br>
	</td>
</tr>
<tr>
	<th>한줄 코멘트</th>
	<td>
		<input type="text" name="Content" size="50px" value="<%=bbs.getContent() %>"><br>
	</td>
</tr>
<tr align = "center">
	<td colspan="2">
		<button type="submit" class="btn btn-secondary">작성완료</button>
		<button type="button" class="btn btn-secondary" onclick="back()">취소</button>
	</td>
</tr>

</table>

</form>

</div>

<script type="text/javascript">
function back() {
	location.href="Main.jsp?content=TodayWeatherList";
}

</script>

</body>
</html>