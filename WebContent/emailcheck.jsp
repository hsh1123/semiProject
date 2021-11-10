<%@page import="dao.MemberDAO"%>
<%@page import ="dto.MemberDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String Email = request.getParameter("email");
	String emailDetail = request.getParameter("emailDetail");

	Email += emailDetail;
    System.out.println("Email:" + Email);


    MemberDAO dao = MemberDAO.getInstance();
    boolean b = dao.getEmailCheck(Email);
    System.out.println("b:" + b);

    if(b == true){
    	out.println("NO");	// 사용할 수 없음
    }else{
    	out.println("YES");	// 사용할 수 있음
    }
    %>