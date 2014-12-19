<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>工作计划</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcWorkPlanEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var workId='<%=request.getParameter("workId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcWorkInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcWorkInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcWorkInfo"/>
	</model:dataset>
	<model:dataset id="workPlanDataSet" enumName="CDC.WORK_PLAN_TYPE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcWorkInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>工作内容</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">名称：</td>
			<td class="FieldInput" colspan="3"><input type="text" id="name" field="name" maxlength="100" style="width:50%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">单位：</td>
			<td class="FieldInput" colspan="3"><input type="text" id="organ" field="organ" maxlength="100" style="width:50%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">年度：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="yearly" field="yearly" maxlength="4" style="width:50%"/></td>
			<td class="FieldLabel" style="width:16%">文档分类：</td>
			<td class="FieldInput" style="width:30%"><select id="kind" field="kind" style="width:50%"><option dataset="workPlanDataSet"/></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">上报人：</td>
			<td class="FieldInput"><input type="text" id="reportPeople" field="reportPeople" maxlength="100" style="width:50%"/></td>
			<td class="FieldLabel">上报日期：</td>
			<td class="FieldInput"><input type="text" name='"上报日期"' field="reportDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width:50%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">附件：</td>
			<td class="FieldInput" colspan="3"><input id="idFile" name="file" type="file" style="width:89%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">内容：</td>
			<td class="FieldInput" colspan="3"><textarea field="content" rows="10" style="width:90%"><textarea/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>