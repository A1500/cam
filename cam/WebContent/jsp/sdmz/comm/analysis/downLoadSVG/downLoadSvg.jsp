<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>文件下载</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="downLoadSvg.js"></script>
	</head>
<body>
<next:ViewPort>
<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:TopBar>
		<next:ToolBarItem text="请点击下载并安装决策分析功能浏览器支持插件" iconCls="send" handler="downLoad" ></next:ToolBarItem>
	</next:TopBar>
</next:Panel>
</next:ViewPort>
</body>
</html>