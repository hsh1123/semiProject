<%@page import="dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));
//System.out.println("seq :" + seq );

FreeBoardDAO dao = FreeBoardDAO.getInstance();
boolean isS = dao.deleteFreeBoard(seq);
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeboard Delete.jsp</title>
</head>
<body>

<%
if(isS){
%>
	<script type="text/javascript">
	alert('삭제가 완료되었습니다');
	location.href = "Main.jsp?content=freeboardMain";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert('삭제실패');
	location.href = "Main.jsp?content=freeboardMain";
	</script>
<%
}
%>


</body>
</html>