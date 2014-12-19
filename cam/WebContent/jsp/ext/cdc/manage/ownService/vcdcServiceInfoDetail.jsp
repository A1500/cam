<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区服务情况</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="infoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceModeQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceMode"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R18'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="infoDataSet" onsubmit="return false" class="L5form">
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
<legend>社区服务情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="2">公共服务</td>
			<td class="FieldLabel" style="width:18%">公共服务内容：</td>
			<td class="FieldInput" style="width:36%"><label id="publicContent" field="publicContent"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:16%" >公共服务人数：</td>
			<td class="FieldInput" style="width:30%"><label id="publicPeopleNum" field="publicPeopleNum" renderer="pRender"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="2">志愿服务</td>
			<td class="FieldLabel" style="width:18%">志愿服务内容：</td>
			<td class="FieldInput" style="width:36%"><label id="voluntContent" field="voluntContent"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >志愿服务人数：</td>
			<td class="FieldInput" style="width:36%"><label id="voluntPeopleNum" field="voluntPeopleNum" renderer="pRender"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="3">商业服务</td>
			<td class="FieldLabel" style="width:18%">商业服务名称：</td>
			<td class="FieldInput" style="width:36%"><label id="commerceName" field="commerceName"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >商业服务内容：</td>
			<td class="FieldInput" style="width:36%"><label id="commerceContent" field="commerceContent"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >商业服务地址：</td>
			<td class="FieldInput" style="width:36%"><label id="commerceAddress" field="commerceAddress"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="3">服务方式</td>
			<td class="FieldLabel" style="width:18%">是否提供全程代办代理服务：</td>
			<td class="FieldInput" style="width:36%"><label id="ifService" field="ifService"  dataset ="YorN" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >社区电话服务热线：</td>
			<td class="FieldInput" style="width:36%"><label id="servicePhone" field="servicePhone"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >社区网络服务平台：</td>
			<td class="FieldInput" style="width:36%"><label id="serviceWeb" field="serviceWeb"  /></td>
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
	var ds=L5.DatasetMgr.lookup("infoDataSet");
	ds.setParameter("MODE_ID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}

function pRender(val){
	if(val!="")
	return val+" 人";
}
</script>