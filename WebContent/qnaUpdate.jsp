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
<form action="qnaUpdateAf.jsp?seq=<%=dto.getSeq() %>" method="post">
		<div align="center">
			<table border="1">
				<col width="200"><col width="400">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" value="<%=dto.getUserID() %>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" value="[수정]<%=dto.getTitle()%>"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
					<textarea rows="20" cols="50" name="content"><%=dto.getContent() %></textarea>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
					<input type="text" name="email" value="<%=dto.getEmail() %>">
					</td>
				</tr>
			</table>
			<input type="submit" value="수정 완료" style="margin-top: 10px; margin-left: 550px">
		
		</div>
	</form>
</body>
</html>