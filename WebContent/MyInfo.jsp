<%@page import="dto.MemberDTO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="dto.WeatherLocationDTO"%>
<%@page import="dao.WeatherLocationDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
WeatherLocationDAO dao = WeatherLocationDAO.getInstance();
List<WeatherLocationDTO> list = dao.getStateList();

String id = request.getParameter("id");
MemberDTO dto = (MemberDTO) session.getAttribute("login");

if (dto == null) {
%>
<script>
			alert("로그인 바랍니다.");
			location.href = "login.jsp";
		</script>
<%

%>
<%
}
%>
<!DOCTYPE html>
<html>
<style>
.input_td{
margin-bottom: 10px;
margin-left: 10px;
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>

	<div class="card shadow ml-3 mr-3 " style="width:400px;">
	<form action="MyInfoAf.jsp" method="post" id="form1" class="mt-3 ml-3">

		<table>
			<tr>
				<th>아이디</th>
				<td><input type="text" id="_id" name="id" size="20" class="input_td"
					value="<%=dto.getUserID()%>" readOnly></td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td><input type="text" name="pwd" id="pwd" size="20" class="input_td"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" id="name" size="20" class="input_td"
					value="<%=dto.getUserName()%>"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<div class="dropdown">
						<select name="locationCode" id="locationCode" style="width: 202px " class="input_td">
							<%
							for (int i = 0; i < list.size(); i++) {
								WeatherLocationDTO wdto = list.get(i);
							%>
							<option value="<%=wdto.getLocationCode()%>"
								<%=wdto.getLocationCode().equals(dto.getLocationCode()) ? "selected" : ""%>>
								<%=wdto.getState()%></option>
							<%
							}
							%>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" id="email" size="20"  class="input_td"
					value="<%=dto.getEmailID()%>" style="margin-bottom:0px !important;"><br>
					<p id="emailcheck" style="font-size: 8px"></p> <select
					name="emailDetail"  class="input_td" style="width: 202px " >
						<option value="">선택</option>
						<option value="@gmail.com"
							<%="@gmail.com".equals(dto.getEmailDetail()) ? "selected" : ""%>>gmail.com</option>
						<option value="@naver.com"
							<%="@naver.com".equals(dto.getEmailDetail()) ? "selected" : ""%>>naver.com</option>
						<option value="@hanmail.net"
							<%="@hanmail.net".equals(dto.getEmailDetail()) ? "selected" : ""%>>hanmail.net</option>
						<option value="@nate.com"
							<%="@nate.com".equals(dto.getEmailDetail()) ? "selected" : ""%>>nate.com</option>
						<option value="@bitcamp.com"
							<%="@bitcamp.com".equals(dto.getEmailDetail()) ? "selected" : ""%>>bitcamp.com</option>
				</select>
		 		<a href="#" class="btn btn-danger btn-circle btn-sm" id="emailbtn">
                                        <i class="fas fa-check"></i>
                                    </a>
				</tr>
		</table>

	</form>

	<div class="mt-3 mb-3 ml-3">
	
				<a href="#" id="btnDelete" class="btn btn-danger btn-icon-split">
					<span class="icon text-white-50"> <i class="fas fa-trash"></i>
				</span> <span class="text">탈퇴</span>
				</a>
	 <a href="#" id="btnEdit"  class="btn btn-primary btn-icon-split">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-flag"></i>
                                        </span>
                                        <span class="text">회원정보 수정</span>
                                    </a> 
	<!-- 	<input type="submit" value="회원정보 수정" id="btnEdit" class="btn btn-primary btn-icon-split"
			onclick="checkEdit();"> -->
	</div>

</div>
</body>

<script type="text/javascript">
let idCheck = false;
let emailCheck= false;
let memEmail = "<%=dto.getEmail()%>";
	$(document).ready(
			function() {

				$("#emailbtn").click(
						function() {

							if ($('#email').val().length == 0) {
								alert('email을 입력하세요');
								$('#email').focus();
								return false;
							}

							if ($("select[name=emailDetail]").val() == "") {
								alert('email을 선택해주세요.');
								$('#email').focus();
								return false;
							}

							if (memEmail == ($("#email").val() + $("select[name=emailDetail]").val())) {

								$("#emailcheck").css("color",
										"#0000ff");
								$("#emailcheck").text(
										"본인의 이메일 주소입니다.");
								$("#emailbtn").removeClass("btn-danger");
								$("#emailbtn").addClass("btn-success");
								emailCheck = true;
							} else {

								$.ajax({
									url : "emailcheck.jsp",
									type : "post",
									data : {
										"email" : $("#email").val(),
										"emailDetail" : $(
												"select[name=emailDetail]")
												.val(),
									},
									success : function(data) {

										if (data.trim() == "YES") {

											$("#emailcheck").css("color",
													"#0000ff");
											$("#emailcheck").text(
													"사용할 수 있는 이메일입니다");
											$("#emailbtn").removeClass("btn-danger");
											$("#emailbtn").addClass("btn-success");
											emailCheck = true;

										} else {
											$("#emailcheck").css("color",
													"#ff0000");
											$("#emailcheck").text(
													"사용할 수 없는 이메일입니다");
											$("#emailcheck").val("");
											$("#emailbtn").removeClass("btn-success");
											$("#emailbtn").addClass("btn-danger");
											emailCheck = false;

										}
									},
									error : function() {
										alert('error');
									}
								});
							}
						});

				$("#btnEdit").click(function() {
					if ($('#pwd').val().length == 0) {
						alert('패스워드를 입력하세요');
						$('#pwd').focus();
						return false;
					}

					if ($('#name').val().length == 0) {
						alert('이름을 입력하세요');
						$('#name').focus();
						return false;
					}

					if ($('#email').val().length == 0) {
						alert('email을 입력하세요');
						$('#email').focus();
						return false;
					}

					if (!emailCheck) {
						alert('Email 확인을 해주세요');
						$('#_id').focus();
						return false;
					}

					$("#form1").submit();
				});

				$("#btnDelete").click(function() {					
					
					if($('#_id').val() == ""){
						alert("삭제할 회원을 선택해주세요.");
						return false;
					}
					
					
					// 추가 예정
					$.ajax({
						url : "admin/UserLIstdel.jsp",
						type : "post",
						data : {
							"userID" : $('#_id').val()
							
						},
						success : function(data) {
								alert('탈퇴되었습니다.');

								location.href='loginBS.jsp?isLogout=0';
								
							
						},
						error : function(jqXHR, exception) {
							console.log(jqXHR);
							console.log(exception);
						}
					});
				});
					
				
			});

	
</script>
</html>
