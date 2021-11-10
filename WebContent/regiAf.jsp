<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<%
String UserID = request.getParameter("id");
String UserPW = request.getParameter("pwd");
String UserName = request.getParameter("name");
String locationCode = request.getParameter("locationCode");
String email = request.getParameter("email");
String emailDetail = request.getParameter("emailDetail");

System.out.println("emailDetail :" + emailDetail);

email += emailDetail;
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
out.println(UserID + " " + UserPW + " " + UserName + " " + locationCode + " " + email + " " );

MemberDAO dao = MemberDAO.getInstance();

MemberDTO dto = new MemberDTO(UserID, UserPW, UserName, email,1, locationCode,0);
boolean isS = dao.addMember(dto);
if(isS){
%>
	<script type="text/javascript">
	alert("성공적으로 가입되었습니다");
	location.href = "loginBS.jsp";
	// 메인페이지로 돌아가도록
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("다시 기입해 주십시오");
	location.href = "Main.jsp?content=regi";
	</script>
	<%
}
%>


</body>
</html>



