<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.inspur.cams.comm.soo.util.SooUtil" %>
<html>
<%
	StringBuilder builder = new StringBuilder();
	builder.append("http://10.60.0.39:6888/collect/j_security_check?j_username=");
	builder.append(SooUtil.getSooUserName("collectwh"));
	builder.append("&j_password=");
	builder.append(SooUtil.md5(SooUtil.getSooPassword("collectwh")));
	String path = builder.toString();
%>
<body>
	<form name="logonInfoForm" action="" method="post" target='_blank'>
		
	</form>
</body>
</html>
<script language="javascript">
	document.logonInfoForm.target='_blank';
	document.logonInfoForm.action='<%=path%>';
	//document.logonInfoForm.action="saaslogin.jsp";
	document.logonInfoForm.submit();
</script>