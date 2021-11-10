
<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String email = request.getParameter("email");

System.out.println("이름 : "+name+" , 이메일 : "+email);

MemberDAO dao = MemberDAO.getInstance();
String id = dao.findId(name,email);
System.out.println("아이디 : " + id);
%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 <%
if(id!=null||id.equals("")){
%>
<script type="text/javascript">
   alert("귀하의 아이디는 <%=id%>  입니다.");
   location.href="loginBS.jsp?id=<%=id%>";
</script>
<%
}else{
%>
<script type="text/javascript">
   alert("이름 및 이메일을 정확히 입력해주세요");
   location.href="findId.jsp";
</script>

<%
}
%> 
</body>
</html>