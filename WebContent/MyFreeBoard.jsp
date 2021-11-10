<%@page import="dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.FreeBoardDAO"%>
<%@page import="db.DBConnection"%>
<%@page import="dto.FreeBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
DBConnection.initConnection();

MemberDTO mem = (MemberDTO)session.getAttribute("login");
List<FreeBoardDTO> list = null;
if(mem != null){

FreeBoardDAO dao = FreeBoardDAO.getInstance();
list = dao.getFreeBoardList(mem.getUserID());
}
int del = 0;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
	<div>
		<table border="1" class="table table-bordered" id="dataTable" width="100%">
			<col width="50">
			<col width="100">
			<col width="700">
			<col width="80">

			<tr>
				<td><input type="checkbox" id="chkAll"></td>
				<td>SEQ</td>
				<td>TITLE</td>
				<td>삭제</td>

			</tr>
			<% for (int i = 0; i < list.size(); i++) {
				FreeBoardDTO dto = list.get(i);
				
						%><tr>
				<td><input type="checkbox" id="<%= dto.getSeq() %>" class="chk_content"></td>
				<td><%= dto.getSeq() %></td>
				<% if(dto.getDel()==0){%>
				<td><a href="Main.jsp?content=freeboardDetail&seq=<%= dto.getSeq() %>">
				<%= dto.getTitle()%>
				</a></td>
				<td>N</td>
				<%
							}else{ %>

				<td><%=dto.getTitle() %></td>
				<td>Y</td>
				<% 
								} %>
				<% } %>
			</tr>

		</table>
		<a href="#" id="btnDelete" class="btn btn-danger btn-icon-split">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-trash"></i>
                                        </span>
                                        <span class="text">내가 쓴 글 삭제</span>
                                    </a>
	
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

	
$("#btnDelete").click(function() {
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
		url : "MyFreeBoardDel.jsp",
		type : "post",
		data : {
			"arrSeq" : strCheck
			
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
