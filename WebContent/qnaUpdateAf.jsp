<%@page import="dao.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int seq = Integer.parseInt(request.getParameter("seq"));
String title = request.getParameter("title");
String content = request.getParameter("content");

QnADAO dao = QnADAO.getInstance();
boolean check = dao.qnaUpdate(title,content,seq);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
if(check){
%>
	<script type="text/javascript">
		alert("수정이 완료되었습니다.");
		location.href="Main.jsp?content=qnalist"
	</script>

<%
}else{
%>
	<script type="text/javascript">
		alert("수정 실패");
		location.href="Main.jsp?content=qnaUpdate"
	</script>

<%
}
%>
</body>
</html>