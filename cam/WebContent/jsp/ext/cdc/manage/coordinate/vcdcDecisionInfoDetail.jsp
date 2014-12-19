<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区建设领导协调机制</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="coordinateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcCoordinateInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcCoordinateInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R17'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorNDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="coordinateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报时间：</td>
			<td class="FieldInput" style="width:36%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>领导协调机制</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">是否成立领导协调机制：</td>
			<td class="FieldInput" style="width:36%"><label id = "ifFound" field="ifFound" dataset ="YorNDataSet"/></td>
			<td class="FieldLabel" style="width:18%"></td>
			<td class="FieldInput" style="width:36%"></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">名称：</td>
			<td class="FieldInput" style="width:36%"><label id="name" field="name" maxlength="30" /></td>
			<td class="FieldLabel" style="width:16%">职责：</td>
			<td class="FieldInput" style="width:30%"><label id="duty" field="duty" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">牵头部门：</td>
			<td class="FieldInput" style="width:36%"><label id="department" field="department" maxlength="30" /></td>
			<td class="FieldLabel" style="width:16%">联系人姓名：</td>
			<td class="FieldInput" style="width:30%"><label id="linkPeople" field="linkPeople" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">联系人电话：</td>
			<td class="FieldInput" style="width:36%"><label id="phone" field="phone" maxlength="30" /></td>
			<td class="FieldLabel" style="width:16%">联系人职责：</td>
			<td class="FieldInput" style="width:30%"><label id="position" field="position" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">是否纳入财政预算：</td>
			<td class="FieldInput" style="width:36%"><label id = "ifBudget" field="ifBudget" dataset ="YorNDataSet"/></td>
			<td class="FieldLabel" style="width:16%">财政标准：</td>
			<td class="FieldInput" style="width:30%"><label id="criterion" field="criterion" maxlength="30" /></td>
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
	var ds=L5.DatasetMgr.lookup("coordinateDataSet");
	ds.setParameter("COORDINATE_ID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
</script>