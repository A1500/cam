<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>工作计划</title>
<next:ScriptManager/>
<script type="text/javascript">
var fileId='<%=request.getParameter("fileId")%>';
</script>
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
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcWorkInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>工作内容</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">名称：</td>
			<td class="FieldInput" colspan="3"><label field="name"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">单位：</td>
			<td class="FieldInput" colspan="3"><label field="organ"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">年度：</td>
			<td class="FieldInput" style="width:36%"><label field="yearly"/></td>
			<td class="FieldLabel" style="width:16%">文档分类：</td>
			<td class="FieldInput" style="width:30%"><label field="kind" dataset="workPlanDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">上报人：</td>
			<td class="FieldInput"><label field="reportPeople"/></td>
			<td class="FieldLabel">上报日期：</td>
			<td class="FieldInput"><label field="reportDate"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">附件：</td>
			<td class="FieldInput" colspan="3"><a id="fj"  href="<%=SkinUtils.getRootUrl(request) %>download?table=com_file&column=file_content&filename=file_name&pk=file_id&file_id='<%=request.getParameter("fileId") %>'"><font size=2>下载</font></a></td>
		</tr>
		<tr>
			<td class="FieldLabel">内容：</td>
			<td class="FieldInput" colspan="3"><textarea field="content" rows="10" style="width:90%" readonly="true"><textarea/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
	var ds=L5.DatasetMgr.lookup("cdcWorkInfoDataSet");
	ds.setParameter("WORK_ID@=",'<%=request.getParameter("workId")%>');
	ds.load();
	ds.on("load",function(){
		if(ds.get("fileId")==''){
		document.getElementById("fj").style.display="none";
		}
	});
}
function returnBack(){
	history.go(-1);
}
</script>