<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.live.engine.util.*"%>
<%@ page import="org.loushang.live.engine.timer.*"%>
<%@ page import="org.loushang.live.engine.util.monitor.*"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/live/L5-live.css"/>
<%
	try{
		TimerUtil.start();
		out.append("启动成功");
	}
	catch(Exception e){
		out.append("启动失败");
		e.printStackTrace();
	}
%>
