<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
        // DB 접속 Data를 산출
        String UserID = request.getParameter("id");
        System.out.println("id:" + UserID);

        // Dao 호출
        MemberDAO dao = MemberDAO.getInstance();
        boolean b = dao.getId(UserID);
        if(b == true){
        	out.println("NO");	// 사용할 수 없음
        }else{
        	out.println("YES");	// 사용할 수 있음
        }
        %>

