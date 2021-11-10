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
      request.setCharacterEncoding("utf-8");
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
                            <img src="img/logo.png" style="height: 330px; width: 350px; margin-left: 65px; margin-top: 70px;">
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">비 밀 번 호  찾 기</h1>
                                    </div>
                                    <form class="user">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" id="id" placeholder="아이디를 입력하세요">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" id="name" placeholder="이름을 입력하세요">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" id="email" placeholder="이메일을 입력하세요">
                                        </div>
                                    <!--     <div class="form-group">
                                                 <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="check">
                                                
                                               </div>
                                        </div> -->                                        
                                        <a href="#" id="btn" class="btn btn-primary btn-user btn-block" style="margin-top: 50px">
                                            찾 기
                                        </a>
                                        <hr style="margin-top: 30px">
                                        <!-- 하단 넣을 때~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --><%//TODO:아이디찾기/비밀번호 찾기 넣기 %>
                                    </form>
                                    <div class="text-center">
                                        <a class="small" href="Main.jsp?content=regi">회 원 가 입</a>
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
      $('#btn').click(function() {
         let id = $('#id').val().trim();
         let name = $('#name').val().trim();
         let email = $('#email').val().trim();
         
         location.href="findPwAf.jsp?id="+id+"&name="+name+"&email="+email;
      });
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