
<%@page import="dto.MemberDTO"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="db.DBConnection"%>
<%@page import="java.util.List"%>
<%@page import="dto.FreeBoardDTO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
MemberDTO mem = (MemberDTO)session.getAttribute("login");

System.out.println(mem);
if(mem == null){
%>
<script>
	alert("로그인 해 주십시오");
	location.href = "loginBS.jsp";
	</script>
<%                                                                                                                                
} else {

	WeatherLocationDAO dao = WeatherLocationDAO.getInstance();
	List<WeatherLocationDTO> list = dao.getStateList();
	
	String id = request.getParameter("id");

%>

<!DOCTYPE html>

<html>


<%
	request.setCharacterEncoding("utf-8");//이 작업을 해줘야 한글이 깨지지않고 잘 받아진다.
 %>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title></title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">
	<h1>MyPage</h1>
	<div style="margin: 10px;">

		<!--  	<ul class="nav nav-tabs">

			<li class="active"><a href="#todayweather" data-toggle="tab">오늘의
					날씨</a></li>
			<li><a href="#freeboard" data-toggle="tab">자유게시판</a></li>
			<li><a href="#location" data-toggle="tab">location설명</a></li>
			<li><a href="#myInfo" data-toggle="tab">내정보수정</a></li>

		</ul>  -->

		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				href="#freeboard" data-toggle="tab">자유게시판</a></li>
			<li class="nav-item"><a class="nav-link" aria-current="page"
				href="#todayweather" data-toggle="tab">오늘의 날씨</a></li>
			<!-- <li class="nav-item"><a class="nav-link" href="#location" data-toggle="tab">location설명</a></li>
						<li class="nav-item"><a class="nav-link" href="#myInfo"
							data-toggle="tab">내정보수정</a></li> -->
		</ul>

		<div class="tab-content">

			<div class="tab-pane fade show in active" id="freeboard">

				<jsp:include page='MyFreeBoard.jsp' flush="false" />

			</div>

			<div class="tab-pane fade" id="todayweather">
				<jsp:include page='MyTodayWeather.jsp' flush="false" />
			</div>

			<!-- <--로케이션테스트-->
			
			<%-- 			<div class="tab-pane fade" id="location">
			<form action="myLocationtest.jsp">	
				<select name="locationCode">
				<%for(int i= 0; i<list.size();i++){ 
					WeatherLocationDTO dto = list.get(i);
				
				%>
					<option value="<%=dto.getLocationCode() %>"> <%=dto.getState() %></option>
				
				<%} %>
		<!-- 		
				</select>
				<input type="submit" value="select  전달테스트">
				</form>

			</div> --> --%>
			<!-- 내정보수정	 -->
			<%-- 		<div class="tab-pane fade" id="myInfo">

				<jsp:include page='MyInfo.jsp' flush="false" />

			</div> --%>
		</div>
	</div>

</body>
</html>

<%

}

%>