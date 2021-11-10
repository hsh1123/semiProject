
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="db.DBConnection"%>
<%@page import="java.util.List"%>
<%@page import="dto.FreeBoardDTO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String locationCode= request.getParameter("locationCode");

	WeatherLocationDAO dao = WeatherLocationDAO.getInstance();
	WeatherLocationDTO dto = dao.getState(locationCode);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


</head>

<body>

	<%=locationCode %><br>
	<%=dto.getState() %>
	


</body>
</html>