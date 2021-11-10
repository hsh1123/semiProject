<%@page import="db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao.MemberDAO"%>
<%@page import="dto.MemberDTO"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.BookMarkDAO"%>
<%@page import="dto.BookMarkDTO"%>


<%
DBConnection.initConnection();
%>


<%
String UserID = request.getParameter("id");
String locationCode = request.getParameter("locationCode");//

System.out.println( UserID+ " " + locationCode + " ");
%>


<%
 MemberDTO mem = (MemberDTO)session.getAttribute("login");
 System.out.println("mem*****************************");
 //System.out.println(mem);
if(mem == null){
%>  
	<script>
	 alert("로그인 해 주십시오");
	location.href = "loginBS.jsp"; 
	</script>	
<%
}else{

	
WeatherLocationDAO wdao = WeatherLocationDAO.getInstance();
List<WeatherLocationDTO> wlist = wdao.getStateList();

BookMarkDAO dao = BookMarkDAO.getInstance();
List<BookMarkDTO> list = dao.getBookMarkList(mem.getUserID()); 
// 왜 멤버 아이디가 널이지??

System.out.println("list: " +list);

for(BookMarkDTO b : list){
	System.out.println("bookmark: " + b.toString());
} 


%>

<!DOCTYPE html>
<html>
<head>


    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <link href="css/sb-admin-2.min.css" rel="stylesheet"> 

<style>
#content{
height:100%}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.delbtn{
 margin-left: 100px;
}

</style>


<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div style="height:550px;">
<div align ="center">
<a href ="Main.jsp">
<h2> 즐겨찾기</h2>
</a>

<br>
<form action="bookmarkAdd.jsp">

<input type="hidden" name="id" value="<%=mem.getUserID()%>">
<select name="locationCode"  id="locationCode">
<%for(int i= 0; i< wlist.size(); i++){ 
	WeatherLocationDTO wdto = wlist.get(i);
	%>
	<option value="<%=wdto.getLocationCode() %>" >
	<%=wdto.getState() %></option>
	<%
}
%>
</select>

<input type ="submit" style="margin-left: 10px; height: 35px;"
						value="추가" class="btn btn-dark">
</form>
<br><br>


<div align = "center">
<table border="1" class="table table-bordered" id="dataTable" style="width:70%">
<tr align ="center">
	
	<th width ="30"><input type="checkbox" id="chkAll"></th>
	<th width="100" >지역</th>
	<th width="150" >강수량</th>
	<th width="150" >온도</th>
	<th width="150" >습도</th>
	

</tr>
<%
if(list==null || list.size()==0) {
	%>
		<tr>
			<td colspan="5" align ="center">추가된 북마크가 없습니다</td>
		</tr>
	<% 
} else {
	String beforeState = "";
	for(int i=0; i< list.size(); i++) {
		BookMarkDTO dto = list.get(i);
		if(beforeState != dto.getState()){
	%>
	
		<tr align ="center">
			<td><input type="checkbox" value="<%= dto.getSeq() %>" id="<%= dto.getSeq() %>" class="chk_content"></td>
			<td><%=dto.getState() %></td>
			<td><%=dto.getRain() %></td>
			<td><%=dto.getTemperature() %></td>
			<td><%=dto.getHumidity() %></td>
		
		</tr>
	
	<% }
	}
}	
%>


</table>
</div>



 	<a href="#" id="btnDelete1" class="btn btn-danger btn-icon-split">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-trash"></i>
                                        </span>
                                        <span class="text">삭제</span>
                                    </a>
<!-- 
<button type="button" id="btnDelete1"><span class="text">삭제</span></button> -->
          
                                 
</div>
</div>
</body>

<script type="text/javascript">

$(document).ready(function() {
	$("#chkAll").click(function() {
		if( $("#chkAll").prop("checked") ){
		$(".chk_content").prop("checked",true);
		}else{
			$(".chk_content").prop("checked",false);
		}
	});

	$(".chk_content").click(function() {
		if ($(this).prop("checked")) {
			let chkCount = 0;
			
			$(".chk_content").each(function() {
				if($(this).prop("checked")){
					chkCount++;					
				}
			});
			
			if(chkCount == $(".chk_content").length){
				$("#chkAll").prop("checked",true);
			}
			else {
				$("#chkAll").prop("checked",false);
			}
			
		}else {
			$("#chkAll").prop("checked",false);
		}
	});



	$("#btnDelete1").click(function() {	

		 let strCheck = "";
		$(".chk_content").each(function() {
			if( $(this).prop('checked') )	{			
				strCheck += $(this).attr('id') + ",";
			}
		});
		
		if(strCheck == ""){
			alert("삭제할 게시글을 선택해주세요.");
			return false;
		}
		
		strCheck = strCheck.substr(0,strCheck.length-1);
		
		// 추가 예정
		$.ajax({
			url : "bookmarkDel.jsp",
			type : "post",
			data : {
				"seq" : strCheck
				
			},
			success : function(data) {
					alert('삭제되었습니다.');
					location.reload();
					
				
			},
			error : function() {
				alert('error');
			}
		});
	});

});
</script>


</html>

<%
}
%> 
