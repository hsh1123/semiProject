<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
MemberDTO mem = (MemberDTO)session.getAttribute("login");
if(mem == null){
%>  
	<script>
	alert("로그인 해 주십시오");
	location.href = "loginBS.jsp";
	</script>	
<%
}
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="qnaWriteAf.jsp" method="post">
		<div align="center">
			<table border="1">
				<col width="200"><col width="400">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" value="<%=mem.getUserID() %>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" placeholder="제목을 입력해주세요."></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
					<textarea rows="20" cols="50" name="content"></textarea>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
					<input type="text" name="email" value="<%=mem.getEmail() %>">
					</td>
				</tr>
			</table>
			<input type="submit" value="전송" style="margin-top: 10px; margin-left: 550px">
		
		</div>
	</form>

</body>
</html>