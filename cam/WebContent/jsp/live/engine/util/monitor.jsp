<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.live.engine.util.*"%>
<%@ page import="org.loushang.live.engine.timer.*"%>
<%@ page import="org.loushang.live.engine.util.monitor.*"%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/skins/css/live/L5-live.css" />
<%
	MonitorServiceImpl mi = new MonitorServiceImpl();
	MonitorBean monitorInfo = mi.getMonitorInfoBean();
%>
<table class="FieldLabel" border="1" bordercolor="black">
	<tr>
		<th>属性</th>
		<th>值</th>
	</tr>
	<tr>
		<td>定时器是否开启</td>
		<td><%=TimerOperator.isstart%></td>
	</tr>
	<tr>
		<td>转出过程是否正在进行</td>
		<td><%="未知"%></td>
	</tr>
	<tr>
		<td>JMS默认工厂</td>
		<td><%=JMSUtil.factory%></td>
	</tr>
	<tr>
		<td>JMS默认连接</td>
		<td><%=JMSUtil.connection%></td>
	</tr>
	<tr>
		<td>cpu占有率</td>
		<td><%=monitorInfo.getCpuRatio()%></td>
	</tr>
	<tr>
		<td>可使用内存</td>
		<td><%=monitorInfo.getTotalMemory()%></td>
	</tr>
	<tr>
		<td>剩余内存</td>
		<td><%=monitorInfo.getFreeMemory()%></td>
	</tr>
	<tr>
		<td>最大可使用内存</td>
		<td><%=monitorInfo.getMaxMemory()%></td>
	</tr>
	<tr>
		<td>操作系统</td>
		<td><%=monitorInfo.getOsName()%></td>
	</tr>
	<tr>
		<td>总的物理内存</td>
		<td><%=monitorInfo.getTotalMemorySize()%></td>
	</tr>
	<tr>
		<td>剩余的物理内存</td>
		<td><%=monitorInfo.getFreeMemory()%></td>
	</tr>
	<tr>
		<td>已使用的物理内存</td>
		<td><%=monitorInfo.getUsedMemory()%></td>
	</tr>
	<tr>
		<td>线程总数</td>
		<td><%=monitorInfo.getTotalThread()%></td>
	</tr>
</table>

