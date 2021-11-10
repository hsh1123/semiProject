<%@page import="dao.CommentsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));
//System.out.println("deleteSEQ :" + seq );

String scommentNum = request.getParameter("commentNum").trim();
int commentNum = Integer.parseInt(scommentNum);


System.out.println("commentNum:" + commentNum);
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CommentDelete.jsp</title>
</head>
<body>

<%
CommentsDAO dao = CommentsDAO.getInstance();
boolean isS = dao.deleteComment(commentNum);
if(isS){
%>
	<script type="text/javascript">
	alert('해당 댓글이 삭제되었습니다');
	location.href = location.href = "Main.jsp?content=freeboardDetail&seq=" + <%=seq%>;
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert('삭제되지 않았습니다');
	location.href = location.href = "Main.jsp?content=freeboardDetail&seq=" + <%=seq%>;
	</script>
<%
}
%>

</body>
</html>