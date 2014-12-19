<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员简历信息(多条记录)明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleResume.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var resumeId='<%=request.getParameter("resumeId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleResumeDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleResumeQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleResume"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmPeopleResumeDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员简历信息(多条记录)</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">人员主键：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">j简历主键：</td>
			<td class="FieldInput" style="width:36%"><label field="resumeId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">时间段：</td>
			<td class="FieldInput" style="width:36%"><label field="timeInfo"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位：</td>
			<td class="FieldInput" style="width:36%"><label field="unit"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">任职情况：</td>
			<td class="FieldInput" style="width:36%"><label field="duitInfo"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>