<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市民主决策情况填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="decisionDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcDecisionReportQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcDecisionReport">
		</model:record>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R13'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="decisionDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报日期：</td>
			<td class="FieldInput" style="width:36%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>民主决策情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">居民会议次数：</td>
			<td class="FieldInput" style="width:36%"><label field="meetingShouldNum" renderer="cRender" /></td>
			<td class="FieldLabel" style="width:16%">居民会议参加人数：</td>
			<td class="FieldInput" style="width:30%"><label field="meetingRealNum" renderer="rRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">居民代表会议次数：</td>
			<td class="FieldInput"><label field="meetingAgreeNum"/ renderer="cRender" ></td>
			<td class="FieldLabel">居民代表会议参加人数：</td>
			<td class="FieldInput"><label field="meetingUnagreeNum" renderer="rRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:30%;text-align:center;" colspan="4"><font color="red">*</font>填报内容为当前情况<font color="red">*</font></td>
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
	var ds=L5.DatasetMgr.lookup("decisionDataSet");
	ds.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function cRender(val){
	if(val!=""){
		return val+" 次";
	}
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
</script>