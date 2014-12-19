<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.inspur.cams.comm.soo.util.SooUtil" %>
<html>
<%
	StringBuilder builder = new StringBuilder();
	//builder.append("http://10.60.0.16/marry/loginMarry.do?method=login&action=login&username=");
	//builder.append(SooUtil.getSooUserName("mary"));
	//builder.append("&password=");
	//builder.append(SooUtil.getSooPassword("mary"));
	//builder.append("http://lljiuzhu.mca.gov.cn/web/UserAction.do");	
	String path = builder.toString();
%>
<body>
	<form name="logonInfoForm" action="http://lljiuzhu.mca.gov.cn/web/UserAction.do" method="post">
		<input type="hidden" id="method" name="method" value="login"/>
		<input type="hidden" id="name" name="name" value="370000admin"/>
		<input type="hidden" id="pw" name="pw" value="250012"/>
	</form>
</body>
</html>
<script language="javascript">
	document.logonInfoForm.target='_self';
	document.logonInfoForm.submit();
</script>