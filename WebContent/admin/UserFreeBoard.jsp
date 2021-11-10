<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
   String arrSeq = request.getParameter("arrSeq");

	MemberDAO dao  = MemberDAO.getInstance();
	boolean result = dao.deleteFreeBoard(arrSeq);
	
		
		out.println(result);
	
    %>
