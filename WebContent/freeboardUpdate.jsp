<%@page import="java.util.List"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="dto.FreeBoardDTO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
 int seq = Integer.parseInt(request.getParameter("seq"));

WeatherLocationDAO Wdao = WeatherLocationDAO.getInstance();
List<WeatherLocationDTO> Wlist = Wdao.getStateList();

 %>   
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeboardUpdate.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
.tbline tr{
	height: 50px;
}

.Title{
	
}
</style>

</head>
<body>

<%
Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");

FreeBoardDAO dao = FreeBoardDAO.getInstance();
FreeBoardDTO dto = dao.getFreeBoardDetail(seq);
%>


<div align="center">
<form action="freeboardUpdateAf.jsp" method="post">
<input type="hidden" name="seq" value="<%=seq%>">

<table border="0" class="tbline">
<!-- <col width="80px"><col width="100px"><col width="100px"><col width="200px"> -->

<tr>
	
	
	<th width="100px">지역</th>
		<td>
	<select name="locationcode" style="width: 80px">
   		<%
   		for(int i = 0; i< Wlist.size(); i++){
   			 WeatherLocationDTO rdto = Wlist.get(i);
   			 
   			System.out.println("같은가?"+dto.getLocationCode().equals(rdto.getLocationCode()));
  			 System.out.println(rdto.getLocationCode());
   			 System.out.println(dto.getLocationCode());
   			 
   			 boolean equalCheck = dto.getLocationCode().equals(rdto.getLocationCode());
   			 
   			 System.out.println(equalCheck);
   		%>
			<option value="<%=rdto.getLocationCode() %>" <%= dto.getLocationCode().equals(rdto.getLocationCode()) ? "selected" : "" %>><%=rdto.getState() %></li>
    
    	<%
   		}
    	%>
	</select>
	</td>


	
	<!-- 정보숨김처리 -->
	<td><input type="hidden" name="UserId" value="<%= dto.getUserID() %>" readonly="readonly"></td>  <!-- 로그인value값 추후변경하기 --> 
	<td><input type="hidden" name="lastupdate" value="<%=sf.format(nowTime) %>" readonly="readonly" size="27px"></td>
	
</tr>

<tr>
	<th style="width: 80px">카테고리</th>
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
	 <!-- text창 부분이 가운데로 오도록 할 필요 있음 -->
		<input type="text" class="Title" name="Title" value="<%=dto.getTitle() %>" maxlength="50" style="width:800px; height: 40px;" ><br><br>
	
	</td>

</tr>

<tr>
	<th>내용</th>
	<td colspan="5">
		<textarea rows="20" cols="70" class="Content" name="Content" style="width:800px;"><%=dto.getContent() %></textarea>
	</td>
</tr>

<tr>
	<td colspan="6" align="center" style="width: 550px">
	<button type="button" onclick="history.back()" class="btn btn-secondary">취소</button>
	<button type="submit" id="writeBtn" class="btn btn-secondary">수정하기</button>
	
	</td>

</tr>


</table>

</form>

</div>


</body>
</html>