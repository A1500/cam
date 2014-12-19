<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
	<head>
		<title>流程定义修改</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
	<body>
		<div align="center">
			<font color="red">如果您没有看见设计界面说明您目前的浏览器设置阻止了将要弹出的设计界面！<br>
			解决方法为：将当前网站<b>设置为信任网站</b>或<b>允许弹出当前网站弹出框</b>！</font>
		</div>
		<script>
			var url=document.URL.replace("forupdatebpmn.jsp","fullscreenupdatebpmn.jsp");
			var ret=showModalDialog(url,window,"scroll:no;status:no;location:no;dialogWidth:"+screen.width+"px;dialogHeight:"+screen.height+"px")
			var url =  'jsp/workflow/modeling/bpmn/querybpmnprocessdef.jsp?isHighLevel='+<%=request.getParameter("isHighLevel")%>;
			var text = 'BPMN流程定义查询';
			L5.forward(url, text);
		</script>
	</body>
</html>

