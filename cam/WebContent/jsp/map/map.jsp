<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.comm.util.DateUtil"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<next:ScriptManager />
<%
	String date8 = DateUtil.getDay8(); //日期20140313
	String userId = GetBspInfo.getBspInfo().getUserId();
	String ud = new BASE64Encoder().encode((date8 + userId).getBytes());
%>
<script type="text/javascript">
	try {
		window.top.shang();
	}catch(e){
	}
	window.location.href="http://10.60.5.74:8088/admGIS/index.html?ud="+'<%=ud%>'; 
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>电子地图</title>
</head>
<body>
</body>
</html>
