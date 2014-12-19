<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>殡葬版本编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisVersion.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var organType='<%=request.getParameter("organType")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisVersionDataSet" cmd="com.inspur.cams.fis.base.cmd.FisVersionQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisVersion"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fisVersionDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>殡葬版本</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">版本号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="版本号" id="versionNum" field="versionNum" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位类型：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位类型" id="organType" field="organType" maxlength="50" style="width:90%" readonly="readonly"/>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">最小版本号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="最小版本号" id="minVersion" field="minVersion" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>