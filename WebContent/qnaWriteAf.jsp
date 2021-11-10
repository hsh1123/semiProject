<%@page import="dto.QnADTO"%>
<%@page import="dao.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");
String email = request.getParameter("email");

QnADAO dao = QnADAO.getInstance();
boolean check = dao.qnaWrite(new QnADTO(id,title,content,email));

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
	alert('글쓰기 성공');
	let title = '<%= title %>';
	location.href = "Main.jsp?content=qnalist&choice=title&search=";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert('다시 작성해 주십시오');
	location.href = "Main.jsp?content=qnaWrite";
	</script>
<%
}
%>



</body>
</html>