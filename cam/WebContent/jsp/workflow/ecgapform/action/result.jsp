<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="java.net.URLDecoder"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<html>
<head>
<title>Insert title here</title>
<style type="text/css">
body{
	background-color:#D1DFF0;
}
.resultContent{
	background-color:#D1DFF0;
	width:100%;
	height:30px;
	border: solid #99bbe8 1px;
}
</style>
</head>
<%
	String message=request.getParameter("message");
	message=URLDecoder.decode(message,"utf-8");
%>
<body>
<next:ScriptManager></next:ScriptManager>
<div class="resultContent" style="text-align: center">	
	<font color="red" ><span id="messageShow"><%=message %></span></font>
</div>
</body>
</html>

