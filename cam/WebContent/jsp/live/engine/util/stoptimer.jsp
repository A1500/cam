<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.live.engine.util.*"%>
<%@ page import="org.loushang.live.engine.timer.*"%>
<%@ page import="org.loushang.live.engine.util.monitor.*"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/live/L5-live.css"/>
<%
	String timer = request.getParameter("timer");
	try{
		if(timer!=null){
			TimerUtil.stop(timer);
		}
		else{
			TimerUtil.stopAll();
		}
		out.append("停止成功");
	}
	catch(Exception e){
		out.append("停止失败");
		e.printStackTrace();
	}
%>