<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title></title>
<!--导入Loushang5公用的js文件-->
		<next:ScriptManager/>
<!--导入业务开发的js文件-->
		<script type="text/javascript" src="open.js"></script>
	</head>
<body>
<next:Panel>	
	<next:Html>	
			<button onclick="userReg()">用户开通</button>
			<button onclick="sysReg()">系统开通</button>
	</next:Html>
</next:Panel>

</body>
</html>
