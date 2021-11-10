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
boolean isS = dao.updateMember(dto);
if(isS){
%>
	<script type="text/javascript">
	alert("변경된 정보로 다시 로그인해주세요.");
	location.href = "loginBS.jsp?isLogout=0"; /* // 메인페이지로 돌아가도록 */
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("회원정보 수정이 실패하였습니다.");
	location.href = "Main.jsp?content=mycontent";
	</script>
	<%
}
%>


</body>
</html>



