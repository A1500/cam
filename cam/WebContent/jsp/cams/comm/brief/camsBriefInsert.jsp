<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>简报快报录入</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="camsBriefInsert.js"></script>
<script type="text/javascript" src="checkComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var organArea='<%=request.getParameter("organArea")%>';
	var reportSeason='<%=request.getParameter("reportSeason")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="camsBriefCountDataSet" cmd="com.inspur.cams.comm.brief.cmd.CamsBriefCountQueryCmd" pageSize="200">
	<model:record fromBean="com.inspur.cams.comm.brief.data.CamsBriefCount"/>
	</model:dataset>
</model:datasets>
	<next:Panel>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />
			<next:ToolBarItem iconCls="return" text="返回" handler="returnBack" />
		</next:TopBar>
		<next:Html>
			<form id="briefEditForm" onsubmit="return false"  class="L5form">
			<table border="1" dataset="camsBriefCountDataSet" width="100%">
				<tbody id="resultsBody">
				<tr>
					<td class="FieldLabel" width="25%" align="center">指标名称:</td>
					<td class="FieldLabel" width="25%" align="center">代码:</td>
					<td class="FieldLabel" width="25%" align="center">单位:</td>
					<td class="FieldLabel" width="25%" align="center">数量:</td>
				</tr>
				<tr repeat="true">
					<td class="FieldInput" width="25%"><label  field="enterName"/></label></td>
					<td class="FieldInput" width="25%"><label  field="indexCode"/></label></td>
					<td class="FieldInput" width="25%"><label  field="unit"/></label></td>
					<td class="FieldInput" width="25%"><input type="text" id="count" name="count" field="count" /></td>
				</tr>
				</tbody>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</body>
</html>