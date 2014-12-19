<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市民主管理情况填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="manageReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcManageReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcManageReport"/>
	</model:dataset>
	<model:dataset id="manageDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcManageInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcManageInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R14'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="manageReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:36%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="reportDate" dataset="reportWorkDataSet"/><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
<form id="form1" method="post" dataset="manageDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldsets">
<legend>民主管理情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">是否建立居民自治章程：</td>
			<td class="FieldInput" style="width:18%"><label field ="ifRule" dataset = "YorN"/> </td>
			<td class="FieldLabel" style="width:16%">是否建立居民公约：</td>
			<td class="FieldInput" colspan="3"><label field ="ifPact" dataset = "YorN"/> </td>
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
	var manageReportDataSet=L5.DatasetMgr.lookup("manageReportDataSet");
	var manageDataSet=L5.DatasetMgr.lookup("manageDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	manageReportDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	manageReportDataSet.load();
	manageDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	manageDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
</script>