<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <%
    request.setCharacterEncoding("utf-8");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div align="center" style="background: #c8c9cc; padding: 200px"> <!-- #7d859c,#8d97b3,#434c65,#87a6ff,,,#bbbcc1,#c8c9cc -->
					<h2 style="color: white; font-size: 50px; margin-bottom: 50px "> What can i help you ?  </h2>
                    <!-- Sidebar Toggle (Topbar) -->


                    <!-- Topbar Search -->
                    <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" id="text" class="form-control bg-light border-0 small" placeholder="내용을 검색하세요"
                             aria-label="Search" aria-describedby="basic-addon2" style="width: 400px; height: 60px;">
                            <div class="input-group-append">
                                <button class="btn" id="btn" type="button" style="background-color: #4f73df;">
                                    <i class="fas fa-search fa-sm" style="color: white;"></i>
                                </button>
                            </div>
                        </div>
                    </form>

</div>
<div align="center">
	<h2 style="color: #66676c; font-family:Georgia; font-size: 50px; margin-bottom: 50px; margin-top: 50px;"> 자주 묻는 질문  </h2>
<button type="button" id="hong1" class="btn"  style=" margin-right: 25px; width: 185px; height: 85px; background-color: #4f73df; color: white; font-size: 20px">회원 가입 방법</button>
<button type="button" id="hong2" class="btn" style=" margin-right: 25px; width: 185px; height: 85px; background-color: #4f73df; color: white; font-size: 20px">게시물 등록 방법</button>
 <button type="button"  id="hong3" class="btn" style=" margin-right: 25px; width: 185px; height: 85px; background-color: #4f73df; color: white; font-size: 20px">등급제란?</button>
 <button type="button"  id="hong4" class="btn" style=" margin-right: 25px; width: 185px; height: 85px; background-color: #4f73df; color: white; font-size: 20px">회원탈퇴 방법</button>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#btn').click(function() {
			let searchM = $('#text').val().trim();
			location.href ="Main.jsp?content=qnalist&searchM="+searchM;
		});
		$('#hong1').click(function() {
			let searchM = "가입";
			location.href ="Main.jsp?content=qnalist&searchM="+searchM; 
		});
		$('#hong2').click(function() {
			let searchM = "게시물";
			location.href ="Main.jsp?content=qnalist&searchM="+searchM;
		});
		$('#hong3').click(function() {
			let searchM = "등급";
			location.href ="Main.jsp?content=qnalist&searchM="+searchM;
		});
		$('#hong4').click(function() {
			let searchM = "탈퇴";
			location.href ="Main.jsp?content=qnalist&searchM="+searchM;
		});
	});

</script>

 
</body>
</html>