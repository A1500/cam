<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String processServiceWsdl = (String) request
			.getAttribute("processServiceWsdl");
	out.println(processServiceWsdl);
%>