<%@page import="org.loushang.live.engine.util.SenderUtil"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	SenderUtil.getExtendSenders();
	String jsonStr = SenderUtil.getJsonStr();
	out.append("<script type=\"text/javascript\">");
	out.append("var DeliveryMode=" + jsonStr);
	out.append("</script>");
%>

