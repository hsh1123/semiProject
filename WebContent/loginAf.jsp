<%@page import="dao.MemberDAO"%>
<%@page import="java.lang.reflect.Member"%>
<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberDAO dao = MemberDAO.getInstance();

MemberDTO dto = dao.login(new MemberDTO(id,pwd,null,null,0,null,0));
%>    
        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
if(dto != null && !dto.getUserID().equals("")){
	session.setAttribute("login", dto);
%>
	<script type="text/javascript">
	alert("<%=dto.getUserName()%>님 반갑습니다..로그인에 성공하셨습니다.");
	location.href="Main.jsp";  
	</script>

<%
}else{
%>
	<script type="text/javascript">
	alert("로그인에 실패하셨습니다, 정보를 다시 확인해주세요");
	location.href="loginBS.jsp";  
	</script>
<%
}
%>




</body>
</html>