<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.live.engine.util.*"%>
<%
	try{
		JMSUtil.exit();
		out.write("已停止JMS");
	}
	catch(Exception e){
		out.write("停止JMS失败");
		e.printStackTrace();
	}
	
	
%>