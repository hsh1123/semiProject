<%@page import="dto.MemberDTO"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="dto.FreeBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDTO mem = (MemberDTO)session.getAttribute("login");

String userType = "";
String userID = "";
if(mem==null){
	userType = "Guest";
	userID = userType;
	
}else{
	
	System.out.println("mem: " + mem);
	
	if(mem.getUserID().equals("admin")){
		
		userType="Admin";
	}   	
	
	userID=mem.getUserID();
	   	
}

%>

<%
String choice = request.getParameter("choice");
String search = request.getParameter("search");


if(choice == null){
	choice = "";
}
if(search == null){
	search = "";
}
%>

<%
String locationCode = request.getParameter("locationCode");
if(locationCode == null){
	if(mem != null){
		locationCode = mem.getLocationCode();   // 로그인한 회원 로케이션코드값 초기화 
		//System.out.println("로케이션초기화한값:" + locationCode);
	} else {
		locationCode = "09680590";
	}
}
//TODO:page

//페이지 번호
String spageNumber = request.getParameter("pageNumber");  
int pageNumber = 0;

if(spageNumber != null && !spageNumber.equals("")){
	pageNumber = Integer.parseInt(spageNumber);
}
System.out.println("spageNumber:" + spageNumber);

//날씨 locationcode 가져오기 


WeatherLocationDAO Wdao = WeatherLocationDAO.getInstance();
List<WeatherLocationDTO> Wlist = Wdao.getStateList();  // 리스트를 다 가지고와버리기 때문에 지정해준것이 없다. weatherlocation에 대한것을 다 가지고온다 . 
WeatherLocationDTO dto = Wdao.getState(locationCode);
//System.out.println(dto.toString()); 

//System.out.println(dto.getState());   // 강남구 
//System.out.println(dto);   -- 강남구 나옴. 

//System.out.println(locationCode);
	
FreeBoardDAO dao = FreeBoardDAO.getInstance();
List<FreeBoardDTO> list = dao.freeboardPaging(choice, search, pageNumber, locationCode);   // 프리보드에서 지역을 갖고오는 것. 


//총 글 갯수 구하기 
int write = dao.freeboardAllPages(choice, search, locationCode);
System.out.println("총글갯수:" + write);


//페이지 수  (1페이지당 글 10개)
int pages = write/10 ;     
if ((write % 10) > 0){
	pages += 1; 
}

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeboardMain.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
.bottomSearch{
	position: fixed;
	bottom: 100px;
	width:60%;
}
.tbline tr{
	height: 60px;
	border-bottom: 1px solid;
}

.tbline{
	border-top: 1px solid;
	border-bottom: 1px solid;
}

.titletd{
	padding-left: 20px;
}



</style>

</head>
<body>

 <!-- 왼쪽메뉴 -->
 <div class="leftmenu" align="left" style="overflow-y:scroll; width:15%; height:80%; padding:5px; float:left">
 <table>
 <col width="200px">
<tr>
	<td>
   		 <ul class="statelist">	
   		<%
   		for(int i = 0; i< Wlist.size(); i++){
   			 WeatherLocationDTO rdto = Wlist.get(i);
   		%>
			<li><a href="Main.jsp?content=freeboardMain&locationCode=<%=rdto.getLocationCode() %>"><%=rdto.getState() %></a></li>
    
    	<%
   		}
    	%>
    	</ul>
    </td>
  
</tr>  
</table>

 </div> 
 

	


 
 <!-- 오른쪽바탕 큰테이블 -->

 <table style="width:80%; height:600px; float:left; margin-left:10px;">
<%--  <tr>
 	<td><h1> <%= dto.getState() %></h1> <td>
 </tr> --%>
 <tr>
 	<td>
 	
 	 	<!-- 하단 검색 하는 부분  -->
	 	<div  align="center" style="margin-bottom:10px;margin-left:20px;"> <!-- class="bottomSearch" -->
			<b style="font-size:40px;float:left;margin-top:-5px;"><%= dto.getState() %> </b> 
	 	 	<select id="choice" style="height: 36px;margin-top:10px;">		
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="writer">작성자</option>
			</select>
	
		<input type="text" id="search" value="<%=search%>" style="height: 36px">    
	
		<button type="button" class="btn btn-secondary" onclick="searchBtn()">검색</button>
		</div>
	 	<!-- 메인 글 테이블 시작-->
	 	<table border="0" class="tbline" id="dataTable" style="width: 100%;margin-left: 20px"> <!-- class="table table-bordered" --> 
	 	<col width="30"><col width="70"><col width="60"><col width="300"><col width="100"><col width="100">
	 	
	 	<tr align="center">
	 		<th>NO</th><th>카테고리</th><th>지역</th><th>제목</th><th>작성자</th><th>작성일</th>
	 	</tr>
	 	
 	<%
	 if(list == null || list.size() == 0){
	 %>
	 	<tr>
	 		<td colspan="6">작성된 글이 없습니다</td>	
	 	</tr>
	 <%
	 }else{
	 	for(int i=0; i<list.size(); i++){
	 	FreeBoardDTO bbs = list.get(i);
	 %>
			<%
			if(bbs.getDel() == 0){
			%>
	 <tr>
		<td align="center"><b><%=i + 1 %></b></td>
		
			<td align="center"><%=bbs.getCategoryCode() %></td>
			<td align="center"><%=dto.getState() %></td>
			<td class="titletd">
			<a href="#none" onclick="detailMove('<%=bbs.getSeq()%>','<%=dto.getLocationCode()%>')"><%=bbs.getTitle() %></a>
			</td>
			<td align="center"><%=bbs.getUserID() %></td>
			<td align="center"><%=bbs.getLastUpdate().substring(0,16) %></td>
	</tr>
	 	<%
	 	}}
	 }
	 	%> 
	 	
	 	</table> <!-- 자유게시판 테이블 끝 --> 
	 	<%if(!userID.equals("Guest")){ //TODO: 글쓰기버튼%>
	 	<br>
 		<button type="button" onclick="writeButton('<%=dto.getLocationCode()%>')" class="btn btn-secondary">글쓰기</button>
 		
 	 	<br><br>
		<%
	 	}
		%>
 	 		
 	 	<% //TODO:page %>
 	 	<!-- 글 페이지 수 나타내기  -->
 	 	
 	 	<div align="center">
 	 	<%
 	 	for(int i=0; i<pages; i++){
 	 		if(pageNumber == i){		//현재페이지가 i 일때 
 	 	%>
 	 		<span style="font-size: 12pt; color: #148CFF; font-weight: bold;"><%=i+1 %></span>&nbsp;   <!-- 현재페이지 누르면글자 파란색 -->
 	 	<%
 	 	}else{
 	 	%>
 	 		<a href="#none" title="<%=i+1%>페이지" onclick="goPage(<%=i%>)" 
 	 				style="font-size: 12px; color: #000000; font-weight:bold; text-decoration: none;">[<%=i+1 %>]</a>&nbsp;
 	 	<%
 	 		}
 	 	}
 	 	%>
 	 	</div>
		<br>

 	</td>
 </tr>

 </table> <!-- 메인 큰테이블 끝 --> 



<script type="text/javascript">


function writeButton( locationCode ){				// 글쓰기 버튼눌렀을때.
	//alert("locationcode: " + locationCode);
	
	let id = '<%=userID %>';
	
	if(id == '' || id == null){ 
	   alert("로그인이 필요합니다");
	   location.href = "loginBS.jsp?isLogout=0";
 
	}else{
		 location.href = "Main.jsp?content=freeboardWrite&locationCode=" + '<%=locationCode%>'; 
	}
}


<% //TODO :page %>
function goPage( pageNum ){
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	location.href = "Main.jsp?content=freeboardMain&choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}

function searchBtn(){
	//alert('검색버튼');
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	if(search.trim() == ""){
		alert('검색어를 입력하세요!'); 
		return;
	}
	location.href = "Main.jsp?content=freeboardMain&choice=" + choice + "&search=" + search ;
}

function detailMove( seq, locationCode ){
	//alert("디테일로넘어가기:" + detailMove);
	let id = '<%=userID %>';
	
	if(id == '' || id == null || id == "Guest"){ 
	   alert("로그인이 필요합니다");
	   location.href = "loginBS.jsp";
 
	}else{
		location.href = "Main.jsp?content=freeboardDetail&seq=" + seq + "&locationCode=" + locationCode;
	}
}

</script>

</body>
</html>



