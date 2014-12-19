<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员简历信息(多条记录)编辑</title>
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
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmPeopleResumeDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员简历信息(多条记录)</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">人员主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="人员主键" id="peopleId" field="peopleId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">j简历主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="j简历主键" id="resumeId" field="resumeId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">时间段：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="时间段" id="timeInfo" field="timeInfo" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位" id="unit" field="unit" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">任职情况：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="任职情况" id="duitInfo" field="duitInfo" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>