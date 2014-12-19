<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="<%=SkinUtils.getRootUrl(request) %>skins/ecgapform/css/pub.css"/>
	<link rel="stylesheet" type="text/css" href="<%=SkinUtils.getRootUrl(request) %>skins/ecgapform/css/form.css"/>
	<script language="javascript" src="<%=SkinUtils.getRootUrl(request) %>skins/ecgapform/js/fc.js" ></script>
	<script language="javascript" src="<%=SkinUtils.getRootUrl(request) %>skins/ecgapform/js/pubfunction.js" ></script>
	<script language="javascript" src="<%=SkinUtils.getRootUrl(request) %>skins/ecgapform/js/calendar/script/Popup.js" ></script>
	<next:ScriptManager></next:ScriptManager>
</head>
<%String formId=request.getParameter("formId");
	String title="表单ID："+formId;%>

<body onload='initpages();initdynas() '>
	<next:Panel width="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="<%=title%>"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
		</next:TopBar>
		<next:Html>
		</next:Html>
	</next:Panel>
			<table border="0" width="100%" align="center" height="100%">
				<tr>
					<td ><div id="content" ></div></td>
				</tr>
			</table>
</body>
<script>
	var command = new L5.Command("org.loushang.workflow.ecgapform.formdef.cmd.FormDefCmd");
	command.setParameter("formId", "<%=formId%>");
	command.execute("getHtml");
	var html=command.getReturn("html");
	var content=document.getElementById("content");
	content.innerHTML=html;	
	function back(){
		L5.forward("jsp/workflow/ecgapform/form_query.jsp","");
	}
</script>
</html>