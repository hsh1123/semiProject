<%@page import="dto.MemberDTO"%>
<%@page import="dao.TodayWeatherDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    

   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
// 추천관련 로그인 세션 설정
Object objLogin = session.getAttribute("login");
MemberDTO memm = (MemberDTO)objLogin;

// 1. dao소환
TodayWeatherDAO dao = TodayWeatherDAO.getInstance();

// 2. seq값 처리
String sseq = request.getParameter("seq");
int Seq = Integer.parseInt(sseq.trim());

// 3. 함수 처리

boolean isS = dao.LikeCountUp(Seq);

if(isS){ 
	// 문제 1. 추천 후 방금 추천했던 그 페이지 위치로 돌아가게 해야한다.
	%>
	<script type="text/javascript">
	alert("추천성공");
	location.href = 'Main.jsp?content=TodayWeatherList';
	</script>
	<% 
}else{ 
	%>
	<script type="text/javascript">
	alert("추천 실패, 다시 추천해주세요");
	location.href = 'Main.jsp?content=TodayWeatherList';
	</script>	
	<%
}
%>

</body>
</html>