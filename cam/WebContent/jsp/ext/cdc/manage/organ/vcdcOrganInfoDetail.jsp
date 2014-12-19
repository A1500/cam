<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区社会组织明细</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="organReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganReport"/>
	</model:dataset>
	<model:dataset id="organInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R10'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="organTypeDataSet" enumName="CDC.ORGAN_KIND" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="organReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报日期：</td>
			<td class="FieldInput" style="width:27%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:13%">上报日期：</td>
			<td class="FieldInput" style="width:42%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社会组织状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="4">社会组织状况</td>
			<td class="FieldLabel" style="width:13%">社会组织总数：</td>
			<td class="FieldInput" style="width:14%"><label field="organNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:13%">主管单位总数：</td>
			<td class="FieldInput" style="width:14%"><label field="morgNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:13%">行业协会类个数：</td>
			<td class="FieldInput" style="width:15%"><label field="kindOneNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">社会服务类个数：</td>
			<td class="FieldInput"><label field="kindTwoNum" renderer="gRender"/></td>
			<td class="FieldLabel">公益慈善类个数：</td>
			<td class="FieldInput"><label field="kindThreeNum" renderer="gRender"/></td>
			<td class="FieldLabel">其他类个数：</td>
			<td class="FieldInput"><label field="kindFourNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">成员总数：</td>
			<td class="FieldInput"><label field="memberNum" renderer="rRender"/></td>
			<td class="FieldLabel">办公场所数量：</td>
			<td class="FieldInput"><label field="officialNum" renderer="gRender"/></td>
			<td class="FieldLabel">办公场所总面积：</td>
			<td class="FieldInput"><label field="officialArea" renderer="aRender"/></td>
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
	var ds=L5.DatasetMgr.lookup("organReportDataSet");
	ds.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function rRender(val){
	if(val!="")
	return val+" 人";
}
function gRender(val){
	if(val!="")
	return val+" 个";
}
function aRender(val){
	if(val!="")
	return val+" 平方米";
}
</script>