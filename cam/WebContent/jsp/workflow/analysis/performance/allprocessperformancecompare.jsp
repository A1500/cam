<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<html>
<head>
<title>流程统计分析</title>
<next:ScriptManager></next:ScriptManager>
<style type="text/css">
</style>
</head>
<body>
<%
	
	String chartCategory = "allProcessPerformanceCompare";
	
	StringBuffer sb = new StringBuffer();
	sb.append(request.getScheme());
	sb.append("://");
	sb.append(request.getServerName());
	sb.append(":");
	sb.append(request.getServerPort());
	sb.append(request.getContextPath());
	sb.append("/");
	String rootUrl = sb.toString();
	String flexUrl=rootUrl+"jsp/workflow/analysis/performance/WorkFlowChart.html";
%>
<next:Panel width="100%" height="100%">
	<next:Html>
		<form  name="frmList"  action="" class="L5form">					
			<input type="hidden" name="rootUrl" id="rootUrl" title="根路径"  value="<%=rootUrl%>"/>	
			<input type="hidden" name="chartCategory" id="chartCategory" title="图表类别"  value="<%=chartCategory%>"/>	
		</form>
		<iframe name="wfCharEditor" frameborder="1" marginheight="0" marginwidth="0" scrolling="no" width="100%" height="100%" src="<%=flexUrl%>"></iframe>
	</next:Html>
</next:Panel>
</body>
</html>
