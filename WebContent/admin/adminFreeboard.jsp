<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dao.WeatherLocationDAO"%>

<%@page import="java.util.List"%>
<%@page import="dao.FreeBoardDAO"%>
<%@page import="db.DBConnection"%>
<%@page import="dto.FreeBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 검색(search)룰 눌렀을때 다시 갱신할 페이지( 자바스크립트에서 넘어온 데이터를 자바로 받아줘야함)
//검색했을때만 파라미터를 받아와야함! 하지만 bbslist를 클릭했을때도 들어올수있기때문에 조건설정을 해줘야함(아니면 처음페이지 로드 시 널포인트익셉션)
String choice= request.getParameter("choice");
String search= request.getParameter("search");
if(choice == null ){
	choice="";
}
if(search ==null){
	search="";
}



%>
<%

FreeBoardDAO dao = FreeBoardDAO.getInstance();

//현재 페이지번호 불러오기
String sPageNumber = request.getParameter("pageNumber");
int pageNumber=0;

//파라미터(pageNumber)로 넘어온 값이 있으면 세팅 없으면 x
if(sPageNumber != null && !sPageNumber.equals("")){
	pageNumber = Integer.parseInt(sPageNumber);
}

List<FreeBoardDTO> list = dao.adminGetFreeBoardList( choice, search,pageNumber);
System.out.println(list.size());
int len = dao.freeboardAllPagesAdmin(choice, search);



System.out.println(len);

//페이지수 불러오기
int MemberListPage = len / 10; //숫자는 내가 몇페이지씩 보여주고싶은지를 정하는것이다 총 글수/10 
if((len %10) > 0){ //남아있는 글이 있을때
	MemberListPage = MemberListPage + 1;  //페이지 하나를 더 만들어줘야함
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function() { //문서를 다 읽어들인 다음에 실행해야해서 제이쿼리 ready추가
	//search가 빈값인경우에 검색작업이 필요없으니까!
	let search = "<%=search %>"; 
		//자바값불러옴
	let choice = "<%=choice %>";

	if(search == "" && choice == "") return; //search가 비었을때 리턴
		
	let obj = document.getElementById("choice"); 
	obj.value = choice;
	obj.setAttribute("selected", "selected");
})




</script>
</head>
<body>
	<div class="card shadow ml-3 mr-3">
		<table border="1" class="table table-bordered" id="dataTable"
			width="100%">
			<col width="50">
			<col width="150">
			<col width="250">
			<col width="300">
			<col width="80">
			<col width="100">
			<col width="50">

			<tr>
				<td><input type="checkbox" id="chkAll"></td>
				<td>USER ID</td>
				<td>TITLE</td>
				<td>CONTENT</td>
				<td>CATEGORY</td>
				<td>LOCATION</td>
				<td>DEL</td>

			</tr>
			<% for (int i = 0; i < list.size(); i++) {
					FreeBoardDTO dto = list.get(i);
					WeatherLocationDAO wdao = WeatherLocationDAO.getInstance();
					WeatherLocationDTO wdto = wdao.getState(dto.getLocationCode());
						%><tr>
				<td><input type="checkbox" id="<%= dto.getSeq()%>"
					class="chk_content"></td>
				<td><%= dto.getUserID() %></td>
				<td><%= dto.getTitle()%></td>
				<td><%= (dto.getContent().length() > 20) ? (dto.getContent().substring(0,20)+"...") : dto.getContent()%></td>
				<td><%= dto.getCategoryCode()%></td>
				<td><%=wdto.getState() %></td>
				<td><%=dto.getDel()==0?"NO":"YES" %></td>
			</tr>
<% 
}
%>

		</table>
		
		<div align="center" class="ml-3">
			<ul class="pagination" align="center">
			<%
        
        System.out.println(MemberListPage);
for(int i = 0; i<MemberListPage;i++){
	
	if(pageNumber == i){ //현재 페이지  [1] 2 [3]
		%>
			<li class="paginate_button page-item active">
			<a href="#" aria-controls="dataTable" data-dt-idx="<%=i %>" tabindex="0" class="page-link">
				<%=i + 1 %>
				</a>
				</li>
			<% 
	}else{           //그밖에 페이지
		%>
			<li class="paginate_button page-item">
			<a href="javascript:goPage(<%=i %>)" aria-controls="dataTable" data-dt-idx="<%=i %>" tabindex="0" class="page-link">
				<%=i+1 %>
				</a>
				</li>
			<%
	}
}
%></ul>
		</div>

		<div align="center">
			<div style="width: 100px; float: left;" class="ml-3 mb-3">
				<a href="#" id="btnDelete" class="btn btn-danger btn-icon-split">
					<span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">삭제</span>
				</a>
			</div>

			<select id="choice">
				<option value="USERID">userId</option>
				<option value="TITLE">Title</option>
				<option value="CATEGORYCODE">CATEGORY</option>
			</select> <input type="text" id="search" value="<%=search  %>">

			<button type="button" onclick="searchBtn()">검색</button>

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

	
$("#btnDelete").click(function() {
	 let strCheck = "";
	$(".chk_content").each(function() {
		if( $(this).prop('checked') )	{			
			strCheck += $(this).attr('id') + ",";
		}
	});
	
	if(strCheck == ""){
		alert("삭제할 회원을 선택해주세요.");
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
				alert('회원게시글을 삭제하였습니다.');

				location.reload();
				
			
		},
		error : function(jqXHR, exception) {
			console.log(jqXHR);
			console.log(exception);
		}
	});
});
	
});

function searchBtn() {
	//alert("searchBtn");
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	
	if(search.trim() == ''){
		alert("검색어를 입력해주십시오");
		return;		//검색한 결과를 유지하기위해서..?
	}
	
	location.href="Main.jsp?content=admin/adminFreeboard&choice="+choice+"&search="+search; //검색했을 때 검색한 결과만 가지고페이지 갱신해야함

}

function goPage( pageNum ) {
	
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	//검색한 화면 페이징 시에는 검색된 결과의 페이징을 해야되기때문에 search오ㅑㅏ choice를 파라미터로 받아야함
	
	let url = "Main.jsp?content=admin/adminFreeboard&pageNumber=" + pageNum;
	
	if(choice != ""){
		url += "&choice=" + choice;
	}
	
	if(search != ""){
		url += "&search=" + search;
	}
	
	//location.href = "Main.jsp?content=admin/UserlList&choice=" + choice + "&search=" + search +
	//					"&pageNumber=" + pageNum;
	
	location.href= url;
}
</script>


</html>
