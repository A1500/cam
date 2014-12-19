<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>工作简报</title>
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
	<model:dataset id="workBreifDataSet" enumName="CDC.WORK_BREIF_TYPE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcWorkInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>工作简报</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">主题：</td>
			<td class="FieldInput" ><label field="name"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="reportDate"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">上传附件：</td>
			<td class="FieldInput" ><a id="fj"  href="<%=SkinUtils.getRootUrl(request) %>download?table=com_file&column=file_content&filename=file_name&pk=file_id&file_id='<%=request.getParameter("fileId") %>'"><font size=2>下载</font></a></td>
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