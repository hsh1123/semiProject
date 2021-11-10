<%@page import="dao.MemberDAO"%>
<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String id = request.getParameter("id");
	String isLogout = request.getParameter("isLogout");

		boolean check = false;
		
		if (isLogout != null && isLogout.equals("0")) {

			session.removeAttribute("login");
			session.invalidate();

		} else {

			if (id != null) {
				MemberDAO dao = MemberDAO.getInstance();
				check = dao.getId(id);
			}
		}
	%>


	<div align="center">
<form action="loginAf.jsp" method="post">
<%
if(check!=true){
%>
<table>
	<tr>
		<td>
			ID : <input type="text" id="id" name="id" placeholder="id" size="7" >
		</td>
		<td>
			PW : <input type="password" id="pwd" name="pwd" placeholder="password" size="7">
		</td>
		<th>
			<input	type="submit" value="로그인" >
		</th>
		<th>
			<button type="button" onclick="func()">회원가입</button>
		</th>
	</tr>
</table>
<%
}else{
%>
<div align="right">
<font font-size: 15px"><%=id %>님 반갑습니다.</font>
<input type="button" name="logout" onclick="func3()" value="로그아웃" style="margin-left: 5px" >
</div>
<div align="center">
	<button type="button" onclick="func4()">
		Q&A main
	</button>
</div>
<%
}
%>
</form>
</div>

<script type="text/javascript">
function func() {
	location.href="Main.jsp?content=regi";
}
function func1() {
	location.href="Main.jsp?content=qnalist";
}
function func3() {
	alert("로그아웃 되었습니다.");
	location.href='login.jsp';
}
function func4() {
	location.href="Main.jsp?content=qnaMain";
}


</script>


</body>
</html>