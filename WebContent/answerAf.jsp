<%@page import="dto.QnADTO"%>
<%@page import="dao.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>    
<%
int seq = Integer.parseInt( request.getParameter("seq") );

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");
String email = request.getParameter("email");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
QnADAO dao = QnADAO.getInstance();

boolean check = dao.qnaAnswer(seq, new QnADTO(id, title, content,email));
if(check){
%>
	<script type="text/javascript">
	alert('답글입력 성공!');
	location.href = "Main.jsp?content=qnalist&choice=title&search=&pageNumber=0";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert('답글입력 실패');
	location.href = "Main.jsp?content=qnalist&choice=title&search=&pageNumber=0";
	</script>
<%
}
%>

</body>
</html>