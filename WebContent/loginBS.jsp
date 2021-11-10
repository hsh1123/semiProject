<html><head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

    <title>SB Admin 2 - Login</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
   <%
   String isLogout = request.getParameter("isLogout");
   
   if (isLogout != null && isLogout.equals("0")) {

      session.removeAttribute("login");
      session.invalidate();
  
 

   }
	   
      request.setCharacterEncoding("utf-8");
       String id = request.getParameter("id");
       System.out.println("불러온 id 값 : "+id);
   %>
</head>

<body class="bg-gradient-primary sidebar-toggled">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center" style="margin-top: 100px">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <img src="img/logo.png" style="height: 330px; width: 350px; margin-left: 65px; margin-top: 40px;">
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">로 그 인</h1>
                                    </div>
                                    <form class="user">
                                       <%if(id != null){ %>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" id="id" value="<%=id %>" placeholder="아이디를 입력하세요">
                                        </div>
                                        <%}else{ %>
                                        <div class="form-group">
                                           <input type="text" class="form-control form-control-user" id="id"  placeholder="아이디를 입력하세요">
                                        </div>
                                        
                                        <%} %>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" id="pwd" placeholder="비밀번호를 입력하세요">
                                        </div>
                                    <!--     <div class="form-group">
                                                 <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="check">
                                                
                                               </div>
                                        </div> -->
                                        <div class="form-group">
                                        <input type="checkbox" id="check"> Remember
                                        </div>
                                        
                                        <a href="#" id="login" class="btn btn-primary btn-user btn-block">
                                            로그인
                                        </a>
                                        <a href="Main.jsp" class="btn btn-info btn-user btn-block">
                                            메인으로 가기
                                        </a>
                                        <hr>
                                        <!-- 하단 넣을 때~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --><%//TODO:아이디찾기/비밀번호 찾기 넣기 %>
                                    </form>
                                    <div class="text-center">
                                        <a class="small" href="findId.jsp">아이디 찾기</a>
                                        |
                                        <a class="small" href="findPw.jsp">비밀번호 찾기</a>
                                    </div>
                                    <hr>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
 <script type="text/javascript">

   $(document).ready(function(){
      $("#login").click(function() {
         let id = $('#id').val();
         let pwd = $('#pwd').val();
         location.href="loginAf.jsp?id="+id+"&pwd="+pwd;
      }); 
   });
   
   let user = $.cookie("user"); //쿠키 유저 값을 변수 유저에 담는다.
   if(user != null){ // 변수값에 값이 있으면
      $("#id").val(user); // class =id 의 값에 유저값을 세팅해준다. 
      $("#check").prop("checked", true); // checkbox의 checking
   }

   $("#check").click(function () {
      if( $("#check").is(":checked") ){ // check가 checking되어 있으면
         if( $("#id").val().trim() == "" ){ // id에 값이 없으면
            alert("id값이 없습니다. id값을 넣어주세요!"); //경고창
            $("#check").prop("checked", false); // class= check에 checking을 해제한다
         }else{
            $.cookie("user", $("#id").val().trim(), { expires:7, path:'/' }); //7일동안 모든 경로의 값?을 저장한다.
         }
      }
      else{
         $.removeCookie("user", { path:'/' }); //user data 삭제
      }
   });
   
</script> 
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>



</body></html>