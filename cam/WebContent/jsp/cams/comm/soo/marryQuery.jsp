<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.inspur.cams.comm.soo.util.SooUtil" %>
<html>
<%
	StringBuilder builder = new StringBuilder();
	builder.append("http://10.60.0.18:8080/LoginShow/loginAction.jsp?name=");
	builder.append(SooUtil.getSooUserName("maryquery"));
	builder.append("&password=");
	builder.append(SooUtil.getSooPassword("maryquery"));
	String path = builder.toString();
%>
<body>
	<form name="logonInfoForm" action="" method="post">
	</form>
</body>
</html>
<script language="javascript">
	document.logonInfoForm.target='_blank';
	document.logonInfoForm.action='<%=path%>';
	document.logonInfoForm.submit();
</script>