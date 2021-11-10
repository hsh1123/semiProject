<%@page import="dto.MemberDTO"%>
<%@page import="dto.QnADTO"%>
<%@page import="dao.QnADAO"%>
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
	<div align="center">
		<table border="1">
		<colgroup>
			<col style="width: 100px">
			<col style="width: 400px">
		</colgroup>
			<tr>
				<th>아이디</th>
				<td><input type="text" value="<%=dto.getUserID() %>" readonly="readonly" style="width: 400px; text-align: center;"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input  type="text" value="<%=dto.getTitle() %>" readonly="readonly" style="width: 400px; text-align: center;"></td>	
			</tr>	
			<tr>
				<th>내용</th>
				<td><textarea cols="60" rows="15" readonly="readonly"><%=dto.getContent() %></textarea></td>	
			</tr>
			<tr>
				<th>이메일</th>
				<td><%=dto.getEmail() %></td>
			</tr>
		</table>
	
	<input type="button" value="목록" onclick="Main.jsp?content=qnalist&choice=title&search='" style="margin-top: 10px">
	
	<%
	if(mem.getUserID().equals(dto.getUserID())){
	%>
	<input type="button" value="수정" onclick="location.href='Main.jsp?content=qnaUpdate&seq=<%=dto.getSeq()%>'">
	<input type="button" value="삭제" onclick="location.href='Main.jsp?content=qnaDelete&seq=<%=dto.getSeq()%>'">
	<%
	}
	%>
	<%
	if(mem.getUserID().equals("admin")){
	%>
	<input type="button" onclick="location.href='Main.jsp?content=qnaAnswer&seq=<%=dto.getSeq() %>'" value="답글">
	<input type="button" onclick="location.href='Main.jsp?content=qnaDelete&seq=<%=dto.getSeq()%>'" value="삭제">
	
	<%
	}
	%>
	</div>
</body>
</html>