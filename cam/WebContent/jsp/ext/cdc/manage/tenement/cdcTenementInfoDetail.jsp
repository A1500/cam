<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市社区服务明细</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="tenementInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcTenementInfoQueryCmd" method="query" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcTenementInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R23'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="99%">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="tenementInfoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:36%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:36%"><label field="reportDate" dataset="reportWorkDataSet" /><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
<form id="form1" method="post" dataset="tenementInfoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>物业信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">物业服务企业个数:</td>
			<td class="FieldInput" style="width:36%"><label field="tenementNum" renderer="gRender"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:16%">业主委员会个数:</td>
			<td class="FieldInput" style="width:36%"><label field="proprietorCommitteeNum" renderer="gRender"/><font color="red">*</font></td>
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
	var ds=L5.DatasetMgr.lookup("tenementInfoDataSet");
	ds.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	reportWorkDataSet.on("load",function(){
		ds.load();
	});
}
function returnBack(){
	history.go(-1);
}
function gRender(val){
	if(val!="")
	return val+" 个";
}
</script>