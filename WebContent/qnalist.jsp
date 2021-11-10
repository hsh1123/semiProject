
<%@page import="dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="dto.QnADTO"%>
<%@page import="dao.QnADAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%
MemberDTO mem = (MemberDTO)session.getAttribute("login");
//if(mem == null){ //최종수정-접근권한
%>
	<!-- <script>
	alert("로그인 해 주십시오");
	location.href = "loginBS.jsp";
	</script>	 -->
<%
//}
%> 
<%
request.setCharacterEncoding("utf-8");
QnADAO dao = QnADAO.getInstance();


String searchM = request.getParameter("searchM");
String choice = request.getParameter("choice");
String search = request.getParameter("search");
System.out.println(choice);
System.out.println(search);
if(choice == null){
	choice = "";
}
if(search == null){
	search = "";
}

%>

<!-- 페이지 총 글의 수 찾기 -->
<%
int len = dao.getAllPage(choice, search,searchM);
System.out.println("total :"+len);

int qnaNum = len / 10;
if((len%10)>0){
	qnaNum = qnaNum +1;
}
%>
<%

String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
	pageNumber = Integer.parseInt(sPageNumber);
}


List<QnADTO> list = dao.getQnAList(choice,search,pageNumber,searchM);
%>


    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div align="center">
		<table border="1">
			<col width="100"><col width="500"><col width="150"><col width="200">
			<tr>
				<th>번호</th><th>제목</th><th>작성자</th><th>날짜</th>
			</tr>
 			<%
			if(list==null || list.size()==0 ){
			%>
			<tr>
				<td colspan="4" align="center">작성된 글이 없습니다</td>
			</tr>
			<%
			}else{
				for(int i=0; i<list.size(); i++){
					QnADTO dto = list.get(i);
				%>
				<tr>
					<th><%=i+1 %></th><td><a href="Main.jsp?content=qnadetail&seq=<%=dto.getSeq()%>"><%=dto.getTitle() %></a></td>
					<td style="text-align: center;"><%=dto.getUserID() %></td>
					<td style="text-align: center;"><%=dto.getRdate().substring(0,10) %></td>
				</tr>
				
				<%	
			}
				}
				%>
		</table>
		
 <%
for(int i = 0;i < qnaNum; i++){ //TODO:page
	if(pageNumber == i){	// 현재페이지		[1] 2 [3]
%>
		<span style="font-size: 15pt; color: skyblue; font-weight: bold;">
			<%=i + 1 %>
		</span>&nbsp;
		<%		
	}else{					// 그밖에 페이지
		%>
		<a href="#none" title="<%=i+1 %>페이지" onclick="func4(<%=i %>)"
			style="font-size: 15pt;color: #000;font-weight: bold;text-decoration: none;">
			[<%=i + 1 %>]
		</a>&nbsp;
		<%
	}
}
%> 
		<div>
		<select id="choice">
			<option value="title" >제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
		</select>
		<input type="text" id="search" value="<%=search %>" size="20">
		<input type="button" id="clk" value="검색" onclick="func3()">
		</div>
		
		<input type="button" value="문의 작성" onclick="func1()" style="margin-top: 10px; margin-left: 30px">
		<input type="button" value="목록" onclick="func3()">
	</div>



<script type="text/javascript">


function func1() {
	location.href="Main.jsp?content=qnaWrite"
}
function func2() {
	location.href="Main.jsp?content=qnalist"
}
function func3() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	location.href="Main.jsp?content=qnalist&choice="+choice+"&search="+search;
	
}
function func4(pageNum) {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById("search").value;
	
	location.href = "Main.jsp?content=qnalist&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

</script>



</body>
</html>