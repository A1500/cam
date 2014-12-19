<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.live.engine.util.*"%>
<%
	try{
		JMSUtil.start();
		out.write("已启动JMS");
	}
	catch(Exception e){
		out.write("启动JMS失败");
		e.printStackTrace();
	}
	
%>
