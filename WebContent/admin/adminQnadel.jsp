<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
   
 String arrSeq = request.getParameter("arrSeq");
 System.out.println("arrSeq"+arrSeq);
	MemberDAO dao  = MemberDAO.getInstance();
	boolean result = dao.deleteQna(arrSeq);
	
	System.out.println(result);	
		out.println(result);
	
    %>
