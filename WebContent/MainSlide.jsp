<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
.carousel slide{
 position:relative;
}


</style>

<!-- 부트스트랩 사용을 위한 5개 추가 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<title>Insert title here</title>
</head>
<body>



  <div class="container">

	<!-- 이미지 부분을 div 로 묶어줌 -->
    <div class="carousel slide" data-ride="carousel">		<!-- carousel 캐러셀 -->
      <div class="carousel-inner">
        <!-- First slide -->
        <div class="carousel-item active"><!-- 사이즈가 여기 설정되어있나??? -->
          <img class="d-block w-100" alt="First slide" src="MainSlideImage/216595.jpg">
        </div>
        <!-- Second slide -->
        <div class="carousel-item">
          <img class="d-block w-100" alt="Second slide" src="MainSlideImage/212121.jpg">
        </div>
        <!-- Third slide -->
        <div class="carousel-item">
          <img class="d-block w-100" alt="Third slide" src="MainSlideImage/232323.jpg">
        </div>
      </div>
    </div>
    
    <div> <!-- 텍스트 부분을 div로 묶어줌, 텍스트 css앱솔루트해줘야함 기다려주세요! -->
    	<h2 class="text-center">메인화면에 띄울 슬라이드 테스트중입니다.</h2>
  	</div>
  </div><br><br><hr>

</body>
</html>