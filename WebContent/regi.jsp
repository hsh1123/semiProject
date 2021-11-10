<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	WeatherLocationDAO dao = WeatherLocationDAO.getInstance();
	List<WeatherLocationDTO> list = dao.getStateList();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.center {
	margin: auto;
	width: 60%;
	border: 3px solid #0000ff;
	padding: 10px;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>

	<h2 class="ml-3">JOIN US</h2>

	<div class="card shadow ml-3 mr-3 " style="width:700px;">

		<form action="regiAf.jsp" method="post" id="form1">

			<table class="table table-bordered">
				<tr>
					<th>아이디</th>
					<td><input type="text" id="_id" name="id" size="20"><br>
						<p id="idcheck" style="font-size: 8px"></p> <input type="button"
						id="btn" value="아이디확인" class="btn btn-dark"></td>
				</tr>
				<tr>
					<th>패스워드</th>
					<!-- <td><input type="text" name="pwd" id="pwd" size="20"></td> -->
					<td><input type="password" name="pwd" id="password1" class ="pw1" size="20"></td>
				</tr>
				 <tr>
					<th>패스워드 확인</th>
					<td>
					<input type="password" id = "password2" size="20" >
					<input type="button" onclick="test()" value="확인" class="btn btn-dark"> </td>
				</tr> 
				<tr>
					<th>이름</th>
					<td><input type="text" name="name"  id="name" size="20"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<div class="dropdown">
							<select name="locationCode"  id="locationCode">
								<%for(int i= 0; i<list.size();i++){ 
								WeatherLocationDTO dto = list.get(i);
							%>
								<option value="<%=dto.getLocationCode() %>">
									<%=dto.getState() %></option>
								<%} %>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" id="email"size="20"><br>
					<p id="emailcheck" style="font-size: 8px"></p> 
					<select name="emailDetail">
						<option value="">선택</option>
						<option value="@gmail.com">gmail.com</option>
						<option value="@naver.com">naver.com</option>
						<option value="@hanmail.net">hanmail.net</option>
						<option value="@nate.com">nate.com</option>
						<option value="@bitcamp.com">bitcamp.com</option>
					</select>
					<input type="button" id="emailbtn" value="이메일확인" class="btn btn-dark"></td>
				</tr>
			</table>

		</form>

	</div>
			<div style="float: left;" class="ml-3 mb-3"><!-- [CSS] class 추가 -->
				<a href="#" id="btnJoin" class="btn btn-primary btn-icon-split">
					<span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">회원가입</span>
				</a>
			</div>
	<div>
		<!-- <input type="submit" value="회원가입" id="btnJoin" onclick="checkJoin();"> -->
		<!-- <input type="button" value="회원가입" > -->
	</div>
</body>

<script type="text/javascript">

function test(){
	var p1 = document.getElementById('password1').value;
	var p2 = document.getElementById('password2').value;
	
	if(p1 == "" || p2 == ""){
		alert("비밀번호를 입력해주세요.");		
		return false;
	}
	
	if(p1 != p2){
		alert("비밀번호가 일치하지 않습니다");
		return false;
	}else {
		alert("비밀번호가 일치합니다")
		return true;
	}
}

let idCheck = false;
let emailCheck= false;
	$(document).ready(function() {

		$("#btn").click(function() {
			

			if($('#_id').val().length == 0){
				alert('ID를 입력하세요');
				$('#_id').focus();
				return false;
			}
			
			$.ajax({
				url : "idcheck.jsp",
				type : "post",
				data : {
					"id" : $("#_id").val()
				},
				success : function(data) {

					if (data.trim() == "YES") {
						$("#idcheck").css("color", "#0000ff");
						$("#idcheck").text("사용할 수 있는 아이디입니다");
						idCheck = true;

					} else {
						$("#idcheck").css("color", "#ff0000");
						$("#idcheck").text("사용할 수 없는 아이디입니다");
						$("#_id").val("");
						idCheck = false;
					}
				},
				error : function() {
					alert('error');
				}
			});
		});
		
		$("#emailbtn").click(function() {

			
			if($('#email').val().length == 0){
				alert('email을 입력하세요');
				$('#email').focus();
				return false;
			}

			if($("select[name=emailDetail]").val() == ""){
				alert('email을 선택해주세요.');
				$('#email').focus();
				return false;
			}
			
			
			
			$.ajax({
				url : "emailcheck.jsp",
				type : "post",
				data : {
					"email" : $("#email").val(),
					"emailDetail" : $("select[name=emailDetail]").val(),
				},
				success : function(data) {

					if (data.trim() == "YES") {
						
						$("#emailcheck").css("color", "#0000ff");
						$("#emailcheck").text("사용할 수 있는 이메일입니다");
						emailCheck = true;
							
					} else {
						$("#emailcheck").css("color", "#ff0000");
						$("#emailcheck").text("사용할 수 없는 이메일입니다");
						$("#emailcheck").val("");
						emailCheck = false;
						
					}
				},
				error : function() {
					alert('error');
				}
			});
		});
		
		$("#btnJoin").click(function(){


			if($('#_id').val().length == 0){
				alert('ID를 입력하세요');
				$('#_id').focus();
				return false;
			}

			if(!idCheck){
				alert('ID 확인을 해주세요');
				$('#_id').focus();
				return false;
			}
			
			if($('#password1').val().length == 0 || $('#password2').val().length == 0){
				alert('패스워드를 입력하세요');
				$('#pwd').focus();
				return false;
			}
			
			if($('#name').val().length == 0){
				alert('이름을 입력하세요');
				$('#name').focus();
				return false;
			}
			
			if($('#email').val().length == 0){
				alert('email을 입력하세요');
				$('#email').focus();
				return false;
			}

			if(!emailCheck){
				alert('Email 확인을 해주세요');
				$('#_id').focus();
				return false;
			}
			$("#form1").submit();
		});
		
		
	});

	
	

</script>
</html>
