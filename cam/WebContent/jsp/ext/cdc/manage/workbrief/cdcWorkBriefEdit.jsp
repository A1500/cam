<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>工作简报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcWorkBriefEdit.js"></script>
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
	<model:dataset id="workBreifDataSet" enumName="CDC.WORK_BREIF_TYPE" autoLoad="true" global="true"/>
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
<legend>工作简报</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">主题：</td>
			<td class="FieldInput"><input type="text" id="name" field="name" maxlength="100" style="width:40%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput"  style="width:30%"><input type="text" name='"上报日期"' field="reportDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">上传附件：</td>
				<td class="FieldInput" ><input id="idFile" name="file" type="file" style="width:30%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>