<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String businessServiceWsdl = (String) request
			.getAttribute("businessServiceWsdl");
	out.println(businessServiceWsdl);
%>