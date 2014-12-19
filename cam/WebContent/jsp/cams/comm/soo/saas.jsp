<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<html>
<body>
	<form name="logonInfoForm" action="http://10.60.0.39:6888/saas/j_security_check" method="post" target='_blank'>
		
	</form>
</body>
</html>
<script language="javascript">
	document.logonInfoForm.target='_blank';
	document.logonInfoForm.action="saaslogin.jsp";
	document.logonInfoForm.submit();
</script>