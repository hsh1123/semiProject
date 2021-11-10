<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
   String userID = request.getParameter("userID");

System.out.println(userID);

	MemberDAO dao  = MemberDAO.getInstance();
	boolean result = dao.deleteMember(userID);
	
		
		out.println(result);
	
    %>
