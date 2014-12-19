<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>当前业务动态</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
</script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsMain.js"></script>
</head>
<body>
<next:Panel id="organFundsPanel" width="100%" height="100%">
	<next:Html>
		<iframe id="fundsMain" name="fundsMain" frameborder="no"
			border="0" marginwidth="0" marginheight="0" scrolling="no"
			allowtransparency="yes" width="100%" height="100%"> </iframe>
	</next:Html>
</next:Panel>
</body>
</html>