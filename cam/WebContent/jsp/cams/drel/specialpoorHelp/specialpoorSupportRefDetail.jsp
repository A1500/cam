<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>帮扶关系表明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="specialpoorSupportRef.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="specialpoorSupportRefDataSet"
		cmd="com.inspur.cams.drel.special.cmd.SpecialpoorSupportRefQueryCmd"
		pageSize="200">
		<model:record
			fromBean="com.inspur.cams.drel.special.data.SpecialpoorSupportRef" />
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="specialpoorSupportRefDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>帮扶关系表</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">编码：</td>
			<td class="FieldInput" style="width:36%"><label field="recordId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">帮扶单位代码：</td>
			<td class="FieldInput" style="width:36%"><label field="supportUnitCode"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">帮包村代码：</td>
			<td class="FieldInput" style="width:36%"><label field="helpVillageCode"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>