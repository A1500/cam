<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村社区建设规划情况</title>
<next:ScriptManager/>
<script type="text/javascript">
var fileId='<%=request.getParameter("fileId")%>';
function gRender(val){
	if(val!="")
	return val+" 个";
}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="planDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPlanInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPlanInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R18'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="planDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区建设规划情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">规划社区数量：</td>
			<td class="FieldInput" style="width:30%"><label id="planNum" field="planNum" maxlength="30" style="width:90%" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:16%">规划建设完成社区数量：</td>
			<td class="FieldInput" style="width:30%"><label id="completeNum" field="completeNum" maxlength="30" style="width:90%" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">本年度建设完成社区数量：</td>
			<td class="FieldInput" style="width:30%"><label id="yearCompleteNum" field="yearCompleteNum" maxlength="30" style="width:90%" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:16%">附件</td>
			<td class="FieldInput" style="width:30%"><a id="fj"  href="<%=SkinUtils.getRootUrl(request) %>download?table=com_file&column=file_content&filename=file_name&pk=file_id&file_id='<%=request.getParameter("fileId") %>'"><font size=2 field ="fileName"></font></a></td>
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
	var ds=L5.DatasetMgr.lookup("planDataSet");
	ds.setParameter("PLAN_ID@=",'<%=request.getParameter("recordId")%>');
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