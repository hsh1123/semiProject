<%@page import="dao.BookMarkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bookmarkDel.jsp</title>
</head>
<body>

<%
int seq = Integer.parseInt( request.getParameter("seq") );
System.out.println("seq:" + seq);

BookMarkDAO dao = BookMarkDAO.getInstance();
boolean isS = dao.BookMarkDel(seq);
if(isS){
	%>
	<script type="text/javascript">
	alert("삭제하였습니다");
	location.href = 'bookmark.jsp';
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("삭제되지 않았습니다");
	location.href = 'bookmark.jsp';
	</script>	
	<%
}
%>

</body>
</html>