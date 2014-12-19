<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>殡仪馆上报信息</title>
<next:ScriptManager />
<script type="text/javascript">
	var method = "<%=request.getParameter("method")%>";
	var recordId = "<%=request.getParameter("recordId")%>";
	var ifFile = "<%=request.getParameter("ifFile")%>";
</script>
<script type="text/javascript" src="funeralOrganImportDetail_t.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
</head>
<body>

<model:datasets>
	<!-- 殡仪馆上报信息 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisImportDataQueryCmd" global="true"
		pageAble="false" method="getContentDetail">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisImportData"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%" title="明细">
		<next:Html>
			<form id="editForm" onsubmit="return false"
				class="L5form">
			<table border="1" width="100%" height="100%">
				<tr>
					<td class="FieldLabel"><span id="content" style="vertical-align: top;">测试</span></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>