<%@page import="java.util.List"%>
<%@page import="dto.QnADTO"%>
<%@page import="dao.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));
QnADAO dao = QnADAO.getInstance();
QnADTO dto = dao.getQna(seq);

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>답글 달기</h2>
<form action="answerAf.jsp?seq=<%=dto.getSeq() %>" method="post">
<div align="center">
	<table border="1">
	<col width="200"><col width="500">
	<tr>
		<th>아이디</th>
		<td><input type="text" name="id" value="<%=dto.getUserID() %>" readonly="readonly"  ></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" value="  ▶답글: <%=dto.getTitle() %>" size="50px" readonly="readonly"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="20" cols="52px" name="content"></textarea></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><input type="text" name="email" value="<%=dto.getEmail()%>" readonly="readonly"></td>
	</tr>
	</table>
	<input type="submit" value="답글 작성" style="margin-top: 10px">
</div>
</form>


<h2>질문 게시글</h2>
	
	<div align="center">
	<table border="1">
	<col width="200"><col width="500">
	<tr>
		<th>아이디</th>
		<td><input type="text" value="<%=dto.getUserID() %>" readonly="readonly"  ></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" value="<%=dto.getTitle() %>" size="50px" readonly="readonly"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="20" cols="52px" readonly="readonly"><%=dto.getContent() %></textarea></td>
	</tr>
	</table>
	

	


</body>
</html>