<%@page import="dto.MemberDTO"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="java.util.List"%>
<%@page import="dao.TodayWeatherDAO"%>
<%@page import="dto.TodayWeatherDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
// 지역코드 대신 구 표시를 위한 소환
WeatherLocationDAO Ldao = WeatherLocationDAO.getInstance();
List<WeatherLocationDTO> Llist = Ldao.getStateList();
//WeatherLocationDTO rdto = Ldao.getState(locationCode);
%>
   
<%
// 1-1. 멤버DTO로 수정삭제 제한 걸기
Object objLogin = session.getAttribute("login");
MemberDTO memm = null;
memm = (MemberDTO)objLogin;

// 1-2. 세션 유지시간 설정 - 이렇게하는 것 맞나요??
// session.setAttribute( "User_ID", memm.getUserID() );
session.setMaxInactiveInterval(60*60) ; // 세션 유지시간 1시간




// 2-1. DAO 실행
TodayWeatherDAO dao = TodayWeatherDAO.getInstance();

// 2-2. LikeCountUP
/* int Seq = Integer.parseInt( request.getParameter("seq") );
dao.LikeCountUp(Seq); */

// 2-3. DTO에서 정보를 불러오기 위한 Seq 값 정렬 -> 이거 ....필요없나요???
// int seq = Integer.parseInt( request.getParameter("seq") );
// TodayWeatherDTO dto = dao.getTodayWeather(seq);
// System.out.println(dto.toString());



// 3-1. 페이지 번호
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
	pageNumber = Integer.parseInt(sPageNumber);
}

// 3-2. 글의 총수
int len = dao.getAllTodayWeather(/*select한 지역코드로 검색가능하게 할 것*/);
System.out.println("총 글의 수:" + len);

// 3-3. 페이지 수
int TodayWeatherPage = len / 15;		// 26 / 15 -> 2page
if((len % 15) > 0){
	TodayWeatherPage = TodayWeatherPage + 1;
}




// 4-1. 게시글 목록 불러오기
List<TodayWeatherDTO> getList = dao.getTodayWeatherPagingList(pageNumber/*, select한 지역코드*/);
for(TodayWeatherDTO dto : getList){
	System.out.println(dto.toString());
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body{ 
 /* width: 100%; */
 margin-bottom: 50px;
}
.tb{
 width: 90%;
}
.cardall { 
 position: static;
 width: 80%;
 margin-top: 50px;
 margin-left: 10%;
}
.card{
 width: 250px;
 height: 470px;
 margin:5px;
 padding: 15px;
}
.card-img-top{
 width: 100vw;
 height: 150px;
}
.btn{
 font-size: 8px;
}
.pagenum{ /* 얘를 카드들 하단 정 중앙에 안움직이게 띄우고 싶다.... */
 position: fixed;
 align: center;
 bottom:0;
 width:100%;
}
</style>
 <!-- 부트스트랩 사용을 위한 5개 추가 -->
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 




 
 <title>사진게시판_목록</title>
<!--
	전체 적용 사이즈 간격을 1000 으로 해놓고 각 게시물의 가로 사이즈를 300으로 잡으면 알아서 다음줄로 넘어간다.
	그리고 만약 게시물이 15개가 되면 다음페이지로 넘어가게 한다.
 -->
</head>

<body>
<div class="cardall">

 
<table class="tb">
<tr>
	<td width="33%" align="left">
		<% /* 회원만 글쓰기 버튼을 활성화, 비회원은 로그인 버튼으로 대체 */
		if(objLogin != null){
			%>
			<button type="button" class="btn btn-secondary" onclick="goWrite()">사진업로드</button>
		<%
		}else{
			%>
			<button type="button" class="btn btn-secondary" onclick="goLogin()">로그인</button> * 회원만 글쓰기 권한이 있습니다 *
			<%
		} 
		%>	
	</td>
	<td width="33%" align="center">
		<% // 게시판 페이지 표시
		for(int i = 0;i < TodayWeatherPage; i++){
			if(pageNumber == i){	// 현재페이지 [1] 2 [3]
		%>
			<span style="font-size: 15pt; color: #0000FF; font-weight: bold;">
				<%=i + 1 %>
			</span>&nbsp;
			<%		
			}else{					// 그밖에 페이지
				%>
				<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
					style="font-size: 15pt;color: #000;font-weight: bold;text-decoration: none;">
					[<%=i + 1 %>]
				</a>&nbsp;
					<%
			}			
		}
		%>
	</td>
	<td width="33%" align="right">
		<%-- <select name="LocationCode">
			<%for(int i= 0; i<Llist.size();i++){ 
				WeatherLocationDTO Ldto = Llist.get(i);
			%>
				<option value="<%=Ldto.getLocationCode() %>"> <%=Ldto.getState() %></option>
			<%
			}
			%>				
		</select>
		<button type="button" class="btn btn-secondary" onclick="">지역검색</button><!-- 이동을 어떻게하지...? --> --%>
	</td>
</tr>
</table> 

<br><br><br>
	<div class="cardList">
	
	<% // 게시글이 0개인 경우 처리
	if(getList.size() ==0 || getList == null) {
		%>	
		<div align="center">작성된 게시글이 없습니다.</div>
	<%
	}else{ //게시글이 존재할 경우 처리
		for(int i = 0;i < getList.size(); i++){
			TodayWeatherDTO dto = getList.get(i); // 게시글 소환
			WeatherLocationDTO Ldto = Llist.get(i); // 구 소환
	//		if(dto.getDel() == 0){ // 미삭제된 게시글을 불러오기
			%>						
				<div class="card" style="max-width: 300px; float:left;">
			 
				    <!--  이미지 : card-img-top -->
				    <img class="card-img-top" src="upload/<%=dto.getNewFileName()%>" alt="..."><br>
				    
				    <!-- 버튼위치 -->	
				    <%
				    if(objLogin != null){
						%>
						<div>			    
				    		<a href="#" class="btn btn-secondary" id="like"	onclick="LikeCountUp(<%=dto.getSeq() %>)">
				    		♡ + <%=dto.getLikeCount() %>
				    		</a>
				    	</div>	
						<%
					}else{
						%>
						<div> 			    
				    		<a href="#" class="btn btn-secondary" id="like"	onclick="nonLikeCountUp()">
				    		♡ + <%=dto.getLikeCount() %>
				    		</a>
				    	</div>	
						<%
					} 
					%>	
				    
				    	   	
				   	       		   
				    <!-- 본문:card-body -->
				    <div class="card-body"> 
				     				    	
					  	<!-- 제목 :card-title -->
				    	<h5 class="card-title"><b><%=dto.getTitle() %></b></h5>		
				      	
				     	<!-- 한줄코멘트 :card-text -->
				     	<p class="card-text"><%=dto.getContent() %></p>
				     
				      	<div class="userInfo"> <!-- 계정정보 -->
						    올린이: <%=dto.getUserID() %><br>
						    지역: <%=Ldto.getState() %><br>
						    게시일: <%=dto.getLastUpdate() %><!-- 수정 시 옆에 (수정됨) 이 뜨게 할 예정-->
				    	</div>
				    	
				    	<% 
						if(objLogin != null && dto.getUserID().equals(memm.getUserID())){
						 	%>
					      	<div class="btns" align="right">
						      <a class="btn" href="#" class="btn btn-secondary" onclick="TWUpdate(<%=dto.getSeq() %>)">수정</a>
						      <a class="btn" href="#" class="btn btn-secondary" onclick="TWDelete(<%=dto.getSeq() %>)">삭제</a>
					   		</div>
					    	<% 
						} 
						%>
				  	</div>
				</div>
				<%
		//		}
			}
	}
	%>	
	</div>
</div>	

<div align="center" class="pagenum">	
		
</div>


	
	
	
<script type="text/javascript">

function goWrite() {
	location.href = "Main.jsp?content=TodayWeatherWrite";
}
function goLogin() {
	location.href = "loginBS.jsp";
}
function TWUpdate( seq ) {
	location.href = "Main.jsp?content=TodayWeatherUpdate&seq=" + seq;
}
function TWDelete( seq ) {
	location.href = "Main.jsp?content=TodayWeatherDelete&seq=" + seq;
}
function LikeCountUp( seq ) {
	location.href = "TodayWeatherLikeCountUp.jsp?seq=" + seq;
}
function nonLikeCountUp() {
	alert("비회원은 추천하실 수 없습니다.");
}

/* $(function(){
	  $('#like').click(function(){
		  like.attr("disabled", "true");
	  });
}); */

function goPage( pageNum ) {
	// let choice = document.getElementById('choice').value;
	// let search = document.getElementById("search").value;
	
	location.href = "Main.jsp?content=TodayWeatherList&pageNumber=" + pageNum;
}
</script>


</body>
</html>