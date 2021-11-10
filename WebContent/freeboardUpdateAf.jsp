<%@page import="dto.FreeBoardDTO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));
String title = request.getParameter("Title");
String content = request.getParameter("Content");
String location = request.getParameter("locationcode");
String category = request.getParameter("categorycode");

//System.out.println("title:" + title + " " + "content:" + content + " " 
//					+"location:" + location + " " + "category:" + category );

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
FreeBoardDAO dao = FreeBoardDAO.getInstance();
boolean isS = dao.updateFreeBoard(seq, new FreeBoardDTO(null, title, content, location, category));
if(isS){
%>
	<script type="text/javascript">
	alert('수정이 완료되었습니다.');
	location.href = "Main.jsp?content=freeboardMain";
	</script>

<%
}else{
%>
	<script type="text/javascript">
	alert('수정이 실패하였습니다.');
	location.href = "Main.jsp?content=freeboardMain";
	</script>
<%
}
%>




</body>
</html>