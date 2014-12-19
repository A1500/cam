<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.inspur.cams.comm.soo.util.SooUtil" %>
<html>
<%
	StringBuilder builder = new StringBuilder();
	builder.append("http://10.60.0.39:6888/collect/j_security_check?j_username=");
	builder.append(SooUtil.getSooUserName("collect"));
	builder.append("&j_password=");
	builder.append(SooUtil.md5(SooUtil.getSooUserName("collect")));
	String path = builder.toString();
%>
<head></head>
<body>
	<form name="logonInfoForm" action="<%=path%>" method="post">
	</form>
</body>
</html>
<script language="javascript">
	document.logonInfoForm.target='_blank';
	document.logonInfoForm.action='<%=path%>';
	document.logonInfoForm.submit();
</script>