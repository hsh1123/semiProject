<%@page import="dao.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));

QnADAO dao = QnADAO.getInstance();
boolean check = dao.qnaDelete(seq);
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
	alert("삭제되었습니다.");
	location.href="Main.jsp?content=qnalist&choice=title&search=&pageNumber=0";
</script>
<%
}else{
%>
<script type="text/javascript">
	alert("삭제가 실패되었습니다.");
	location.href="Main.jsp?content=qnadetail";
</script>
<%
}
%>

</body>
</html>