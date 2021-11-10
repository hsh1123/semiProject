<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="dto.FreeBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.FreeBoardDAO"%>
<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDTO mem = (MemberDTO)session.getAttribute("login");


Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 ");

FreeBoardDAO dao = FreeBoardDAO.getInstance();
List<FreeBoardDTO> list = dao.getFreeBoardList(mem.getUserID(),"","");


String locationCode= request.getParameter("locationCode");
//System.out.println("write_locationCode: " + locationCode);

WeatherLocationDAO Wdao = WeatherLocationDAO.getInstance();

WeatherLocationDTO dto = Wdao.getState(locationCode);
//System.out.println("dto매개변수 : " +dto);

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeboardWrite</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
.tbline tr{
	height: 50px;
}
</style>


</head>
<body>
<!-- 
	 * @param seq : 글번호
	 * @param userID ㅣ 회원 아이디
	 * @param title : 글 제목
	 * @param content : 글 내용
	 * @param lastUpdate : 등록/수정일
	 * @param readCount : 조회수
	 * @param del : 삭제 
	 * @param categoryCode : 카테고리
-->

<div align="center">

<form action="freeboardWriteAf.jsp" method="post">
<input type="hidden" name="locationCode" value="<%=locationCode%>">

<table border="0" class="tbline">
<!-- <col width="80px"><col width="100px"><col width="100px"><col width="200px"> -->


<tr>
	<!-- 숨김처리, 투명효과 -->
	<td><input type="hidden" name="UserId" value="<%= mem.getUserID() %>" readonly="readonly"></td> 
	<td><input type="hidden" name="lastupdate" value="<%=sf.format(nowTime) %>" readonly="readonly" size="27px"></td>
</tr>

<tr>	
	<td colspan="2"><h3>글쓰기</h3></td>
</tr>

<tr>	<!-- 존나 편법임 -->
	<td colspan="2"><h3></h3></td>
</tr>

<tr>	
	<th>지역</th>
		<td><%=dto.getState() %></td>
</tr>

<tr>
	<th width="100px">카테고리</th>
	<td><select name="categorycode" style="width: 80px">
		<option>일상</option>
		<option>취미</option>
		<option>유머</option>
		<option>정보</option>
	</select></td>
</tr>

<tr>
	<th>제목</th>
	<td colspan="3">
		<input type="text" class="Title" name="Title" placeholder="제목을 입력하세요" maxlength="50" style="width: 570px; height: 40px"><br>
	</td>
</tr>


<tr>
	<th>내용</th>
	<td colspan="5">
		<textarea rows="30" cols="90" class="Content" name="Content" placeholder="내용을 입력하세요" style="height: 400px; width: 570px"></textarea>
	</td>
</tr>

<tr>
	<td colspan="6" align="center" style="width: 550px" >
	<button type="submit" id="writeBtn" class="btn btn-secondary" style="margin-left:95px">글쓰기</button>
	</td>
</tr>

</table>
</form>
</div>


<!-- input text 유효성 검사  -->
<script type="text/javascript">
$(document).ready(function() {
	$("#writeBtn").click(function() {
		if($(".Title").val().length == 0){
			alert('제목을 입력하세요');
			$(".Title").focusin();
			return false;
		}
		
		if($(".Content").val().length == 0){
			alert('내용을 입력하세요');
			$(".Content").focusin();
			return false;
		}
		
	});
});

</script>



</body>
</html>









