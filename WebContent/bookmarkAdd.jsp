<%@page import="dto.BookMarkDTO"%>
<%@page import="dao.BookMarkDAO"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="dao.MemberDAO"%>
<%@page import="dto.MemberDTO"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="java.util.List"%>
    
<%

String UserID = request.getParameter("id");
String locationCode = request.getParameter("locationCode");//


System.out.println( UserID+ " " + locationCode + " ");
%>

<%
WeatherLocationDAO wdao = WeatherLocationDAO.getInstance();
List<WeatherLocationDTO> list = wdao.getStateList();
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div align ="center">

<%
BookMarkDAO dao = BookMarkDAO.getInstance();

BookMarkDTO dto = new BookMarkDTO(UserID, locationCode);
boolean isS = dao.BookMarkAdd(UserID, locationCode);
if(isS){
%>
 <script type = "text/javascript">
 alert("성공적으로 추가되었습니다");
 location.href ="Main.jsp?content=bookmark";
 </script>
<%
}else {
	%>
<script type = "text/javascript">
alert("다시 추가해주세요");
location.href ="Main.jsp?content=bookmark";
 </script>	
<%
}
%>	

</div>
</body>
</html>