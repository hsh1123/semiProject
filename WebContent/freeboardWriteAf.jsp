<%@page import="dao.GradeDAO"%>
<%@page import="dto.FreeBoardDTO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
request.setCharacterEncoding("utf-8");
%>    

<%
String UserId = request.getParameter("UserId");
String title = request.getParameter("Title");
String content = request.getParameter("Content");
String location = request.getParameter("locationCode");
String date = request.getParameter("lastupdate");
String category = request.getParameter("categorycode");

System.out.println("id:" + UserId + " " + "title:" + title + " " + "content:" + content + " " );
System.out.println("location:" + location + " " + "date:" + date + " " + "category:" + category);
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WriteAf.jsp</title>
</head>
<body>



<%
FreeBoardDAO dao = FreeBoardDAO.getInstance();
boolean isS = dao.addFreeBoard(new FreeBoardDTO(UserId, title, content, location, category ));

if(isS){
	GradeDAO gdao = GradeDAO.getInstance();
	gdao.updatePoint(UserId);
	gdao.setGradeCode(UserId);
%>
	<script type="text/javascript">
	 alert('글작성을 완료하였습니다');
	 location.href = "Main.jsp?content=freeboardMain&locationCode=" + '<%=location%>';
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert('글작성에 실패하였습니다. 다시 작성해 주세요.');
	location.href = "Main.jsp?content=freeboardWrite";
	</script>

<%
}
%>

</body>
</html>






