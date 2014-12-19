<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/L5-all.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/live/L5-live.css"/>
<%@page import="org.loushang.live.engine.timer.TimerUtil"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.live.engine.timer.TimerOperator"%>
<%@page import="org.loushang.live.engine.util.PropertyUtil"%>
<%@page import="org.loushang.live.engine.util.StringUtil"%>
<%@page import="org.loushang.live.engine.timer.AbstractTimerTask"%>
<html>
<head>
<title> 定时器监控 </title>
</head>
<body>
<%
	Map timerOperators = TimerUtil.getTasks();
	String action = request.getParameter("action");
	String timerKey = request.getParameter("key");
	if("stop".equals(action)){
		if(null!=timerKey && !"".equals(timerKey)){
			AbstractTimerTask at = (AbstractTimerTask)timerOperators.get(timerKey);
			try{
				TimerUtil.stop(timerKey);
			}catch(Exception e){
				out.append("<p style=\"color:red\">定时器" + timerKey + "启动失败<p><br/>");
				out.append("<p>"+e.getMessage()+"<p>");
			}
		}
	}else if("start".equals(action)){
		AbstractTimerTask at = (AbstractTimerTask)timerOperators.get(timerKey);
		try{
			//动态取参数
			String timerStr = PropertyUtil.getInstance().get(timerKey);
			if (timerStr != null) {
				List ts = StringUtil.split(timerStr , ",");
				if (ts.size()==3 && ts.get(0) != null && ts.get(1) != null && ts.get(2) != null){
					at.fre = Integer.valueOf(ts.get(1).toString()).intValue();
					at.delay = Integer.valueOf(ts.get(2).toString()).intValue();
				}
				TimerUtil.start(timerKey);
			}
		}catch(Exception e){
			out.append("<p style=\"color:red\">定时器" + timerKey + "停止失败<p>");
			out.append("<p>"+e.getMessage()+"<p>");
		}
	}
%>
<form class="L5form" action="stat.jsp" method="get">
<table>
<tr class="FieldLabel" height="10px">
<td>序号</td>
<td width="100px">定时器</td>
<td width="100px">启动延时</td>
<td width="100px">运行频率</td>
<td width="200px">状态</td>
<td width="200px">操作</td>
</tr>
<tr>
	<%
		Iterator ats = timerOperators.keySet().iterator();
		int i = 1;
		while (ats.hasNext()){
			String key = ats.next().toString();	
			AbstractTimerTask at = (AbstractTimerTask)timerOperators.get(key);
			String stamp = String.valueOf(new Date().getTime());
	%>
			<td><%=i%></td>
			<td><%=key%></td>
			<td><%=at.fre%>ms</td>
			<td><%=at.delay%>ms</td>
			<td><%=at.isstart ? "started" : "stoped"%></td>
	<%
			if(at.isstart){
				
	%>
			<td style="text-align:center">
				<input type="hidden" name="action" value="stop">
				<input type="hidden" name="key" value="<%=key%>">
				<input type="hidden" name="stamp" value="<%=stamp%>">
				<button class="stop" type="submit"></button>
			</td>
	<%		
			}else{
	%>
			<td style="text-align:center">
				<input type="hidden" name="action" value="start">
				<input type="hidden" name="key" value="<%=key%>">
				<input type="hidden" name="stamp" value="<%=stamp%>">
				<button class="start" type="submit"></button>
			</td>
	<%
			}
		}
	%>
</tr>
</table>
</form>
</body>
<script type="text/javascript">
</script>
</html>