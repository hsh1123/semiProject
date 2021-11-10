<%@page import="dao.CommentsDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="dto.CommentsDTO"%>

<%@page import="java.util.List"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dto.MemberDTO"%>
<%@page import="dto.FreeBoardDTO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//TODO: 로그인세션
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
//comment 날짜
Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");
%>
      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeboardDetail.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">


.tbline tr{
	border-bottom: 1px solid;
	height: 50px;
}

.tbline2{
	border-top: 1px solid;
	border-bottom: 1px solid;
	height: 50px;
}



</style>

</head>
<body>

<%
int seq = Integer.parseInt(request.getParameter("seq"));
String locationCode = request.getParameter("locationCode");
//System.out.println("detail:" + locationCode);

//System.out.println("seq: " + seq);
FreeBoardDAO dao = FreeBoardDAO.getInstance();
dao.readCount(seq);
FreeBoardDTO dto = dao.getFreeBoardDetail(seq);
//System.out.println(dto.toString());

//날씨 dao,dto가져오기
WeatherLocationDAO Wdao = WeatherLocationDAO.getInstance();
List<WeatherLocationDTO> Wlist = Wdao.getStateList();   
WeatherLocationDTO Wdto = Wdao.getState(locationCode);
if (userID == null || userID.equals("Guest")){
%>
	<script type="text/javascript">
	location.href = "loginBS.jsp";
	</script>
<%
}
%>	


<%
//commentDAO 가져오기 

CommentsDAO Cdao = CommentsDAO.getInstance();
List<CommentsDTO> Cdto = Cdao.getCommentsList(seq);
//System.out.println("comment전체목록: " + Cdto.toString());

%>
	


<br>

<div align="center">
<table border="0" class="tbline">
<tr>
	<th width="100px">지역</th>
		<td colspan="7"><%=dto.getState() %></td>
	
</tr>
<tr>
	<th width="100px">카테고리</th>
		<td colspan="7"><%=dto.getCategoryCode() %></td>
</tr>



<tr style="height: 40px">
	<th width="100px">제목</th>
		<td width="750px" colspan="4"><%=dto.getTitle() %></td>
		<td width="150px" align="right"> <%=dto.getUserID() %> | </td>
		<td width="150px" align="center"> <%=dto.getLastUpdate().substring(0,16)%> | </td>
		<td width="90px" align="left"> 조회수 <%=dto.getReadCount() %></td>
</tr>

<tr>
	<td colspan="8" style="width: 500px; height: 200px; padding:20px;"><%=dto.getContent() %></td>
</tr>

</table>
<br><br>

<div align="center">
<button type="button" onclick="history.back()" class="btn btn-secondary">뒤로</button>
<!-- "location.href='Main.jsp?content=freeboardMain'" -->
<%
//System.out.println("dto에서 오는 userID :" + dto.getUserID());
if(dto.getUserID().equals(userID) || userType.equals("Admin")){    
%>

<button type="button" onclick="updateFreeboard(<%=dto.getSeq()%>)" class="btn btn-secondary">수정</button>
<button type="button" onclick="deleteFreeboard(<%=dto.getSeq()%>)" class="btn btn-secondary">삭제</button>

<%
}
%>
</div>

<br><br><br>

<!-- 여기다 댓글 넣기 comment 시작부분   total 1240px -->


<p style="color: #CD1039;"><b>[ COMMENT ] </b></p>



<table border="0" class="tbline2" cellspacing="0">
<tr onmouseover="style.backgroundColor='#8CBDED'" onmouseout="style.backgroundColor='' ">

  <%
	 if(Cdto == null || Cdto.size() == 0){
	 %>
	 	<tr>
	 		<td colspan="4" align="center">작성된 댓글이 없습니다.</td>	
	 	</tr>
	 <%
	 }else{
	 	for(int i=0; i<Cdto.size(); i++){
	 	CommentsDTO reply = Cdto.get(i);
	 %>
	 <tr>
	
		
			<%
			if(reply.getCommentdel() == 0){
			%>
			<td>			
				<input type="hidden" name="seq" value="<%=reply.getCommentNum() %>">
			</td>
			<td width="190px" align="left" style="padding: 7px;"><%=reply.getUserID() %></td>
			<td width="700px" align="left"><%=reply.getCommentContent() %></td>
			<td width="250px" align="center"><%=reply.getCommentDate() %></td>
			<td width="100px" align="center">
  				<a href="CommentDelete.jsp?commentNum=<%=reply.getCommentNum()%>&seq=<%=reply.getSeq() %>" >[삭제]</a>
  			</td>
  			
			<%
			}else{
				%>
			<td colspan="6" align="center">
				<font color="red"> *******이 댓글은 작성자에 의해 삭제되었습니다*******</font>
			</td>
				<%
			}
			%>
	</tr>
	 	<%
	 	}
	 }
	 	%> 

 </table>	
</div>
<br>
<form name="comment" action="CommentAdd.jsp"> 	 
 	 <table border="0" align="center" cellspacing="0">
  	  
 	  <tr>

 	  	
 	  
 	  	<td width="150px" align="right" style="padding:30px;" >댓글작성</td>
 	  	
 	  	<td> <textarea rows="2" cols="5" name="commentContent" placeholder="댓글을 등록해 주세요" style="width: 940px"></textarea> </td>
 	  	
 	  	<td width="150px" align="center"> <button type="submit" id="commentBtn" name="commentBtn" onClick="btnPush()" class="btn btn-secondary">댓글작성</button> </td>
 	  
	 	<!-- 숨김값 -->
 	  	<td> <input type="hidden" name="commentID" value="<%=userID%>" readonly="readonly"> </td>
 	  	<td>
	 	  	<input type="hidden" name="seq" value="<%=seq%>">
	 	  	<input type="hidden" name="commentDate" value="<%=sf.format(nowTime)%>">
   	 	</td> 	  
 	  </tr>
   	 </table>
</form>






<script type="text/javascript">
function updateFreeboard(seq){
	
	location.href = "Main.jsp?content=freeboardUpdate&seq=" + seq;
}

function deleteFreeboard(seq){
	
	location.href = "Main.jsp?content=freeboardDelete&seq=" + seq;
}

</script>


</body>
</html>






