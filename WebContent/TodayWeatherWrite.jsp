<%@page import="java.util.List"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
MemberDTO mem= (MemberDTO)session.getAttribute("login");
if(mem == null){
%>
	<script>
	alert("login First");
	location.href="loginBS.jsp?isLogout=0";
	</script>
<%	
}
%>

<%
WeatherLocationDAO Ldao = WeatherLocationDAO.getInstance();
List<WeatherLocationDTO> Llist = Ldao.getStateList();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
body{
 /* font-size: 15px; */
 padding: 20px;
}
.tb td{
 height: 60px;
 font-size: 20px;
}
.tb th{
 text-align: right;
 padding-right:50px;
 font-size: 20px;
}
</style>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<title>weatherJSP_Project_TodayWeatherWrite_page</title>
</head>

<script type="text/javascript">
	$(function() {
		$("#droptest").click(function(e) { 
			debugger;		
		});
	});
</script>
<body>

<h2>사진 업로드</h2>

<form action="TodayWeatherUpload.jsp" method="post" enctype="multipart/form-data" id="form1">

<div align = "center">

<table class="tb" style="border-collapse:collapse">
<col width="200"><col width="800">

<tr>
	<th>아이디</th>
	<td>
		<%=mem.getUserID() %>
		<input type="hidden" name="UserID" value="<%=mem.getUserID()%>"><br>
	 </td>
</tr>
<tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="Title" size="50px"><br>
	</td>
</tr>
<tr>
	<th>한줄 코멘트</th>
	<td>
		<input type="text" name="Content" size="50px"><br>
	</td>
</tr>

<tr>
	<th>파일 업로드</th>
	<td><!-- 이 부분은 파일업로드 시 웹브라우저마다 나타나는 모양이나 배치가 다름  -->
		<label class="btn btn-secondary btn-file">
			파일업로드<input type="file" name="fileload" onchange="previewImage(this,'View_area')" style="display: none;">
    	</label>
    	<div id='View_area' style='position:relative; /*width: 100px; height: 100px;*/ color: black; border: 0px solid black; dispaly: inline; '></div>
	</td>
</tr>

<tr>
	<th>위치 설정</th>
	<td>	
	  
		<select name="LocationCode" ><!-- onchange="alert(this.options[this.selectedIndex].text)" -->
			<%for(int i= 0; i<Llist.size();i++){ 
				WeatherLocationDTO Ldto = Llist.get(i);
			%>
				<option value="<%=Ldto.getLocationCode() %>"> <%=Ldto.getState() %></option>
			<%
			}
			%>				
		</select>
		내가 선택한 위치: <p id="selectLocation"></p>
	  
	</td> 
</tr>

<tr align = "center">
	<td colspan="2">
		<button type="button" class="btn btn-secondary" onclick="checknotnull()">작성완료</button>
	</td>
</tr>


</table>
</div>
</form>

<script type="text/javascript">

// 필요한 사항
//  1. 제목 시 미입력시 페이지 그냥 놔두게 구현하기
//  2. 이미지 미첨부 시 강제로 파일 업로드 버튼 열리게 하기
// 		-> 완료하고나서야 페이지 성공 실패 넘어가게 하기

checknotnull = function(){	
	
/*	구문을 개같이 써서 코드가 꼬였었음
 if($('input[name=fileload]').val().length != 0 
			&& $('input[name=Title]').val().length != 0){
		$("#form1").submit();
	} else {
		if($('input[name=Title]').val().length == 0){
			alert('제목을 입력하세요.');
			$('input[name=Title]').focus(); // 이상태에서 파일업로드 실패 alert창 이후 게시판 리스트로 돌아감
			return false;
		}
		if($('input[name=fileload]').val().length == 0){
			alert('사진을 첨부해주세요.');
			$('input[name=fileload]').focus();
			return false; // 이상태에서 페이지 에러창이 뜬다.
		}		
	} */
	
	if($('input[name=Title]').val().length == 0){
		alert('제목을 입력하세요.');
		$('input[name=Title]').focus(); // 이상태에서 파일업로드 실패 alert창 이후 게시판 리스트로 돌아감
	}
	else if($('input[name=fileload]').val().length == 0){
		alert('사진을 첨부해주세요.');
		$('input[name=fileload]').focus();
	}
	else{
		$("#form1").submit();
	}	
}		
	


function previewImage(targetObj, View_area) {
	var preview = document.getElementById(View_area); //div id
	var ua = window.navigator.userAgent;

  //ie일때(IE8 이하에서만 작동)
	if (ua.indexOf("MSIE") > -1) {
		targetObj.select();
		try {
			var src = document.selection.createRange().text; // get file full path(IE9, IE10에서 사용 불가)
			var ie_preview_error = document.getElementById("ie_preview_error_" + View_area);


			if (ie_preview_error) {
				preview.removeChild(ie_preview_error); //error가 있으면 delete
			}

			var img = document.getElementById(View_area); //이미지가 뿌려질 곳

			//이미지 로딩, sizingMethod는 div에 맞춰서 사이즈를 자동조절 하는 역할
			img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+src+"', sizingMethod='scale')";
		} catch (e) {
			if (!document.getElementById("ie_preview_error_" + View_area)) {
				var info = document.createElement("<p>");
				info.id = "ie_preview_error_" + View_area;
				info.innerHTML = e.name;
				preview.insertBefore(info, null);
			}
		}
  //ie가 아닐때(크롬, 사파리, FF)
	} else {
		var files = targetObj.files;
		for ( var i = 0; i < files.length; i++) {
			var file = files[i];
			var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
			if (!file.type.match(imageType))
				continue;
			var prevImg = document.getElementById("prev_" + View_area); //이전에 미리보기가 있다면 삭제
			if (prevImg) {
				preview.removeChild(prevImg);
			}
			var img = document.createElement("img"); 
			img.id = "prev_" + View_area;
			img.classList.add("obj");
			img.file = file;
			img.style.width = '100px'; 
			img.style.height = '100px';
			preview.appendChild(img);
			if (window.FileReader) { // FireFox, Chrome, Opera 확인.
				var reader = new FileReader();
				reader.onloadend = (function(aImg) {
					return function(e) {
						aImg.src = e.target.result;
					};
				})(img);
				reader.readAsDataURL(file);
			} else { // safari is not supported FileReader
				//alert('not supported FileReader');
				if (!document.getElementById("sfr_preview_error_"
						+ View_area)) {
					var info = document.createElement("p");
					info.id = "sfr_preview_error_" + View_area;
					info.innerHTML = "not supported FileReader";
					preview.insertBefore(info, null);
				}
			}
		}
	}
}

</script>



</body>
</html>