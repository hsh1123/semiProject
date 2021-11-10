<%@page import="dto.CommentsDTO"%>
<%@page import="dao.CommentsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CommentAdd</title>
</head>
<body>

<%
String userId = request.getParameter("commentID");
String commentContent = request.getParameter("commentContent");
String commentDate = request.getParameter("commentDate");
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
//int commentNum = Integer.parseInt(request.getParameter("commentNum"));

//System.out.println("commentAdd: " + userId +" "+ commentContent +" "+ commentDate + " " + seq + " " );

%>

<%
CommentsDAO dao = CommentsDAO.getInstance();
boolean isS = dao.addComment(seq, new CommentsDTO(userId, commentContent));
if(isS){
%>
	<script type="text/javascript">
	alert('댓글등록완료');
	location.href = "Main.jsp?content=freeboardDetail&seq=" + <%=seq%>;
	</script>

<%
}else{
%>
	<script type="text/javascript">
	alert('댓글등록실패');
	location.href = history.back();
	</script>
<%
}
%>

</body>
</html>