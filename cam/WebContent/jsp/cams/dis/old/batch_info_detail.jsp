
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>补录批次信息明细</title>
<next:ScriptManager />
<script type="text/javascript" src="batch_info_detail.js"></script>
<script>
			var batchId='<%=request.getParameter("batchId")%>';
		</script>
</head>
<body>
<model:datasets>
	<!--批次-->
	<model:dataset id="batchds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatch">
			<model:field type="string" name="areaName" />
		</model:record>
	</model:dataset>
	<!--批次明细-->
	<model:dataset id="batchDetailds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<!--救助类型-->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>
	<!--填报状态-->
	<model:dataset id="fillstateDs" enumName="DIS.BATCHDETAIL_FILL_STATE"
		autoLoad="true" global="true">
	</model:dataset>
	<!--发放单位-->
	<model:dataset id="grantTypeDataset" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!--发放方式-->
	<model:dataset id="allocationTypeDataset"
		enumName="DIS.INFO_ALLOCATION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!--冬春救灾本年度批次-->
	<model:dataset id="dcReliefBatchDs" enumName="DIS.DC_RELIEF_BATCH"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel title="批次信息">
	<next:Html>
		<form id="editForm" dataset="batchds" onsubmit="return false"
			class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" width="20%">年度</td>
				<td class="FieldInput"><label field="year" /></td>
				<td class="FieldLabel">任务名称</td>
				<td class="FieldInput"><label field="batchName"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">救助类型</td>
				<td class="FieldInput">
					<label field="reliefType" dataset="ReliefTypeDataset" /></td>
				<td class="FieldLabel"><label id="dcLabel"
					style="display: none;">本年度批次</label></td>
				<td class="FieldInput">
					<label field="dcReliefBatch" dataset="dcReliefBatchDs" style="display: none;"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">发放方式</td>
				<td class="FieldInput">
					<label field="allocationType" dataset="allocationTypeDataset" /> </td>
				<td class="FieldLabel">发放单位</td>
				<td class="FieldInput">
					<label field="grantType" dataset="grantTypeDataset" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">创建人</td>
				<td class="FieldInput"><label field="createPerson" /></td>
				<td class="FieldLabel">创建单位</td>
				<td class="FieldInput"><label field="createOrgan" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">需填报单位</td>
				<td class="FieldInput" colspan="3"><label field="areaName"/></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="disreliefinfoGrid"
	stripeRows="true" clickToSelectedForChkSM="true" height="100%"
	dataset="batchDetailds" title="已下发批次信息">
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column header="所需填报单位" field="requiredOrganName" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="救助类型" field="reliefType"
			dataset="ReliefTypeDataset" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="填报状态" field="fillState" dataset="fillstateDs"
			width="120">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="batchDetailds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
