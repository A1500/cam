<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>修改补录救灾任务</title>
<next:ScriptManager />
<script type="text/javascript" src="batch_info_edit.js"></script>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
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
			<model:field type="string" name="batchName" rule="require"/>
			<model:field type="string" name="areaName" rule="require"/>
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
	<!--救灾类型-->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true">
	</model:dataset>
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
	<model:dataset id="dcReliefBatchDs"
		enumName="DIS.DC_RELIEF_BATCH" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel title="救灾任务">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存救助任务" handler="update" />
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="batchds" onsubmit="return false" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel" width="17%">年度</td>
						<td class="FieldInput" width="33%"><input type="text" format="Y"
							style="width: 100px;" name="year" field="year" maxlength="4"
							id="year" title="年度"/> <font color="red">*</font></td>
						<td class="FieldLabel" width="17%">任务名称</td>
						<td class="FieldInput" width="33%"><input type="text" name="batchName"
							field="batchName" style="width: 230px" maxlength="50" title="任务名称"/> <font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">救助类型</td>
						<td class="FieldInput"><select name="reliefType"
							field="reliefType" style="width: 200px" title="救助类型"/>
							<option dataset="ReliefTypeDataset"></option>
						</select><font color="red">*</font></td>
						<td class="FieldLabel"><label id="dcLabel">本年度批次</label></td>
						<td class="FieldInput"><select id="dcSelect" name="dcReliefBatch"
							field="dcReliefBatch" title="本年度批次"/>
							<option dataset="dcReliefBatchDs"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">发放方式</td>
						<td class="FieldInput"><select name="allocationType"
							field="allocationType" title="发放方式"/>
							<option dataset="allocationTypeDataset"></option>
						</select> <font color="red">*</font></td>
						<td class="FieldLabel">发放单位</td>
						<td class="FieldInput"><select name="grantType"
							field="grantType" title="发放单位"/>
							<option dataset="grantTypeDataset"></option>
						</select><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">创建人</td>
						<td class="FieldInput"><label field="createPerson" /></td>
						<td class="FieldLabel">创建单位</td>
						<td class="FieldInput"><label field="createOrgan" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">需填报单位</td>
						<td class="FieldInput" colspan="3"><textarea rows="2"
							name="areaName" disabled="disabled" field="areaName"
							style="width: 90%" title="需填报单位"></textarea> <input type="hidden"
							id="areaCode" name="areaCode" field="areaCode" /></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>

<next:GridPanel id="editGridPanel" name="disreliefinfoGrid"
	stripeRows="true" clickToSelectedForChkSM="true" height="100%"
	dataset="batchDetailds" title="已下发救助任务">
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
