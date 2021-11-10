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
 MemberDTO mem = (MemberDTO)session.getAttribute("login");
 System.out.println("mem*****************************");
 System.out.println(mem);
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

BookMarkDAO bmkdao = BookMarkDAO.getInstance();
List<BookMarkDTO> bmklist = bmkdao.getBookMarkList(mem.getUserID());   

System.out.println(bmklist);

	%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div style="height:550px;">
<h2> 즐겨찾기</h2>

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

<input type ="submit" value="추가">
</form>


<table border="1" class="table table-bordered" id="dataTable" style="width:70%">
<tr>
	<th width="100">지역</th>
	<th width="200">강수량</th>
	<th width="200">온도</th>
	<th width="200">습도</th>
</tr>
<%
if(bmklist==null || bmklist.size()==0) {
	%>
		<tr>
			<td colspan="2">추가된 북마크가 없습니다</td>
		</tr>
	<% 
} else {
	for(int i=0; i< bmklist.size(); i++) {
		BookMarkDTO bmkdto = bmklist.get(i);
	%>
		<tr>
			<td><%=bmkdto.getState() %></td>
			<td><%=bmkdto.getRain() %></td>
			<td><%=bmkdto.getTemperature() %></td>
			<td><%=bmkdto.getHumidity() %></td>
				
		</tr>
	<% 
	}
}	
%>


</table>
</div>
</body>

<script type="text/javascript">

$("#bmkDelete").click(function() {
	 let strCheck = "";
	$(".chkBmk_content").each(function() {
		if( $(this).prop('checked') )	{			
			strCheck += $(this).attr('id') + ",";
		}
	});
	
	strCheck = strCheck.substr(0,strCheck.length-1);
	
	
	$.ajax({
		url : "bookMarkDel.jsp",
		type : "post",
		data : {
			"arrSeq" : strCheck
			
		},
		success : function(data) {
				alert('북마크가 삭제되었습니다');
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
