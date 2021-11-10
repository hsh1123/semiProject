
<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String name = request.getParameter("name");
String email = request.getParameter("email");

System.out.println("이름 : "+name+" , 이메일 : "+email+"id"+id);

MemberDAO dao = MemberDAO.getInstance();
String pw = dao.findPw(id, email, name);
System.out.println("비밀번호 : " + pw);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <%
if(pw!=null || pw.equals("")){
%>
<script type="text/javascript">
   alert("귀하의 비밀번호는 <%=pw%> 입니다.");
   location.href="loginBS.jsp";
</script>
<%
}else{
%>
<script type="text/javascript">
   alert("가입된 정보가 없습니다. 회원가입을 해주세요");
   location.href="findId.jsp";
</script>

<%
 }
%>  

</body>
</html>