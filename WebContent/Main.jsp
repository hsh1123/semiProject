<%@page import="dao.GradeDAO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="en">
<%

	
	MemberDTO mem = (MemberDTO)session.getAttribute("login");
	String userType = "";
	String userID = "";
	String gradeImage = "Guest";
	
    if(mem==null){
    	userType = "Guest";
    	userID = userType;
    
    	
    }else{
    	
    	System.out.println(mem);
    	
    	if(mem.getUserID().equals("admin")){
    		
    		userType="Admin";
    	}   	
    	
    	GradeDAO gdao = GradeDAO.getInstance();
    	
    	int gradeCode = gdao.getGradeCode(mem.getUserID()); //mem.getGradeCode();
    	gradeImage = "grade"+gradeCode;
    	userID=mem.getUserID();
    	   	
    }


%>


<%
  
 
	request.setCharacterEncoding("utf-8");//이 작업을 해줘야 한글이 깨지지않고 잘 받아진다.
	String content = request.getParameter("content");
	if(content == null){
		content = "forecast";
		//content 초기화
	}
 %>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title></title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="Main.jsp">
				<div class="sidebar-brand-icon rotate-n-15"
					style="transform: rotate(0deg)" !important>
					<!--  <i class="fas fa-laugh-wink"></i>  -->
					<img
						src="https://image.flaticon.com/icons/png/512/1196/1196517.png"
						height="40px" width="40px">
				</div>
				<div class="sidebar-brand-text mx-3"">날SEE</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item"></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">PUBLIC</div>
			<!-- 로고 -->
	<%-- 		<li class="nav-item <%=content.equals("logo") ? "active" : "" %>">
				<a class="nav-link collapsed" href="Main.jsp?content=logo"> <i
					class="fas fa-fw fa-folder"></i> <span>Team FIVE</span>
			</a>
			</li>
 --%>
			<!-- 실시간날씨 -->
			<li class="nav-item <%=content.equals("forecast") ? "active" : "" %>">
				<a class="nav-link collapsed" href="Main.jsp?content=forecast">
					<i class="fas fa-fw fa-folder"></i> <span>실시간 날씨</span>
			</a>

			</li>

			<!-- 오늘의 날씨 -->
			<li
				class="nav-item <%=content.equals("TodayWeatherList") ? "active" : "" %>">
				<a class="nav-link collapsed"
				href="Main.jsp?content=TodayWeatherList"> <i
					class="fas fa-fw fa-folder"></i> <span>오늘의 날씨</span>
			</a>

			</li>
			<!-- 자유게시판 -->
			<li
				class="nav-item  <%=content.equals("freeboardMain") ? "active" : "" %>">
				<a class="nav-link collapsed" href="Main.jsp?content=freeboardMain">
					<!-- freeboardMain.jsp" > --> <i class="fas fa-fw fa-folder"></i> <span>자유게시판</span>
			</a>

			</li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">PREMIUM</div>

			<!-- 북마크 -->
			<li
				class="nav-item  <%=content.equals("bookmark") ? "active" : "" %>">
				<a class="nav-link" href="Main.jsp?content=bookmark"> <i
					class="fas fa-fw fa-folder"></i> <span>북마크</span>
			</a>

			</li>

			<!-- Q&a-->
			<li class="nav-item <%=content.equals("qnaMain") ? "active" : "" %>">
				<a class="nav-link" href="Main.jsp?content=qnaMain"> <i
					class="fas fa-fw fa-folder"></i> <span>Q&A</span></a>
			</li>


			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->


			<% if(userType.equals("Admin")){ %>
			<!-- Sidebar Message -->
			<!-- Heading -->
			<div class="sidebar-heading">ADMIN</div>

			<!-- 회원리스트 -->
			<li
				class="nav-item <%=content.equals("admin/UserlList") ? "active" : "" %>">
				<a class="nav-link" href="Main.jsp?content=admin/UserlList"> <i
					class="fas fa-fw fa-cog"></i> <span>회원리스트</span>
			</a>

			</li>

			<!-- 자유게시판관리-->
			<li
				class="nav-item <%=content.equals("admin/adminFreeboard") ? "active" : "" %>">
				<a class="nav-link" href="Main.jsp?content=admin/adminFreeboard">
					<i class="fas fa-fw fa-cog"></i> <span>자유게시판</span>
			</a>
			</li>
			<!-- 오늘의게시판관리 -->
			<li
				class="nav-item <%=content.equals("admin/adminToday") ? "active" : "" %>">
				<a class="nav-link" href="Main.jsp?content=admin/adminToday"> <i
					class="fas fa-fw fa-cog"></i> <span>오늘의날씨</span></a>
			</li>
			<!-- qna게시판관리 -->
			<li
				class="nav-item <%=content.equals("admin/adminQna") ? "active" : "" %>">
				<a class="nav-link" href="Main.jsp?content=admin/adminQna"> <i
					class="fas fa-fw fa-cog"></i> <span>QNA</span></a>
			</li>
			<%
			}
			%>

			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div><!-- 메뉴 줄이기 -->
		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">


					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto" style="margin-left: 0px !important;">


						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small"> <%=userID %>님
									반갑습니다.
							</span> <img class="img-profile rounded-circle" style="height: 2rem"
								src="img/<%=gradeImage%>.PNG">


						</a> <!-- Dropdown - User Information -->


							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<% if(!userType.equals("Guest")) {%>
								<a class="dropdown-item" href="Main.jsp?content=mycontent">
									<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 내가 쓴
									글 보기
								</a> <a class="dropdown-item" href="Main.jsp?content=MyInfo"> <i
									class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> 회원정보 수정
								</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									Logout
								</a>
								<% }else{ %>
								<a class="dropdown-item" href="Main.jsp?content=regi"> <i
									class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> 회원 가입
								</a>
								<% } %>
							</div></li>

					</ul>
					<!-- hong start1 -->
					<% //TODO:성호1 %>

					<div style="margin-left: 500px" id="div">
						<%
   String id = request.getParameter("id");
   String isLogout = request.getParameter("isLogout");

      boolean check = false;
      
      if (isLogout != null && isLogout.equals("0")) {

         session.removeAttribute("login");
         session.invalidate();
     
    

      } else {

         if (id != null) {
            MemberDAO dao = MemberDAO.getInstance();
            check = dao.getId(id);
         }
      }
   %>

						<!--    <div align="center"> -->

						<%
if(mem == null || mem.getUserID().equals("")){
%>

						<table>
							<tr>
								<td>ID : <input type="text" id="id" name="id"
									placeholder="id" size="7" style="margin-right: 5px">
								</td>
								<td>PW : <input type="password" id="pwd" name="pwd"
									placeholder="password" size="7" style="margin-right: 5px">
								</td>
								<th><a href="#" id="login"
									class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"
									style="margin-right: 7px; font-size: 5px;"> 로그인</a></th>
								<!--  <th>
         <a href="#" id="join"class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" style="font-size: 5px;"  > 회원가입</a>
      </th> -->
							</tr>
						</table>
						<%
}
%>
						<!--</div> -->

					</div>
					<!-- hong end1 -->
				</nav>
				<!-- End of Topbar -->

				<div class="tab-pane fade show in active" id="forecast">

					<jsp:include page='<%=content + ".jsp" %>' flush="false" />
				</div>
				<!--이 부분이 각 게시판 소스(BODY부터)가 들어갈 부분입니다. -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Team 5 of Bitcamp 2021</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">로그아웃을 누르면 로그인페이지로 돌아갑니다.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="javascript:logout();">Logout</a>
				</div>
			</div>
		</div>
	</div>
	<script>
	
	function logout() {
		
		location.href='loginBS.jsp?isLogout=0'; 
		
	}
	</script>
	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="js/demo/chart-area-demo.js"></script>
	<script src="js/demo/chart-pie-demo.js"></script>

</body>

<script type="text/javascript">



   $(document).ready(function(){
      
      
      
      
      $("#login").click(function() {
         let id = $('#id').val();
         let pwd = $('#pwd').val();
         location.href="loginAf.jsp?id="+id+"&pwd="+pwd;
      }); 
      
      $("#join").click(function() {
         
         location.href="Main.jsp?content=regi";
      });
   });
</script>
</html>