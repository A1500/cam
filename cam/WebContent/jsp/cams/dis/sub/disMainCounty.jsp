<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>县级</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
</script>
<script type="text/javascript" src="disMainCounty.js"></script>
</head>
<body>
<model:datasets>
	<!--未使用资金-->
	<model:dataset id="allocationDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>

	<!--拨付资金-->
	<model:dataset id="disFundsBatchDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsBatchQueryCmd"
		sortField="ALLOCATION_TIME DESC,FILL_TIME DESC,BATCH_ID">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsBatch"></model:record>
	</model:dataset>
	<!--拨付物资-->
	<model:dataset id="disDetailBatchDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailBatchQueryCmd"
		sortField="RECEIVE_TIME DESC,FILL_TIME DESC,BATCH_ID">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisDetailBatch"></model:record>
	</model:dataset>

	<!--审批-->
	<model:dataset id="batchDetailds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCommand"
		method="queryBatchDetail" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<!--发放-->
	<model:dataset id="batchDetailDoleds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCommand"
		method="queryBatchDetail" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>

	<!--发放单位-->
	<model:dataset id="grantTypeDataset" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!--发放方式-->
	<model:dataset id="allocationTypeDataset"
		enumName="DIS.INFO_ALLOCATION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!--灾害类型-->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>
	<!--填报状态-->
	<model:dataset id="fillstateDs" enumName="DIS.BATCHDETAIL_FILL_STATE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 资金来源类型 -->
	<model:dataset id="disSourceTypeDs" enumName="DIS.SOURCE_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 资金类型 -->
	<model:dataset id="disAllocationTypeDs" enumName="DIS.ALLOCATION_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="disAllocationPurposeDs"
		enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel height="100%" autoScroll="true">
	<next:Panel height="208" width="99%">
		<next:ColumnLayout>
			<next:Panel id="panel" title="资金使用情况总表（单位：万元）" columnWidth=".4"
				height="100%">
				<next:Html>
					<form method="post" onsubmit="return false" class="L5form">
					<table border="0" width="100%">
						<tr>
							<td class="FieldLabel" width="150">结余资金:</td>
							<td class="FieldInput"><label />100</td>
						</tr>
						<tr>
							<td class="FieldLabel" width="150">其中，上级下拨投入:</td>
							<td class="FieldInput"><label />40</td>
						</tr>
						<tr>
							<td class="FieldLabel" width="150">其中，市财政投入:</td>
							<td class="FieldInput"><label />60</td>
						</tr>
						<tr>
							<td class="FieldLabel" width="150">拨付资金:</td>
							<td class="FieldInput"><label />40</td>
						</tr>
						<tr>
							<td class="FieldLabel" width="150">其中，已拨付资金:</td>
							<td class="FieldInput"><label />30</td>
						</tr>
						<tr>
							<td class="FieldLabel" width="150">其中，计划拨付资金:</td>
							<td class="FieldInput"><label />10</td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel id="otherPanel" columnWidth=".6" height="100%">
				<next:GridPanel id="grid" dataset="disFundsBatchDs" width="100%"
					height="205" title="资金拨付记录列表">
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:Column id="disYear" header="年度" field="disYear"
							align="center" width="60">
							<next:TextField />
						</next:Column>
						<next:Column id="allocationTime" header="拨款日期"
							field="allocationTime" align="center" width="80">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationNum" header="拨款文号"
							field="upAllocationNum" align="center" width="120">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationType" header="拨款类型"
							field="upAllocationType" align="center" width="70"
							dataset="disAllocationTypeDs">
							<next:TextField />
						</next:Column>
						<next:Column id="amount" header="拨款金额(万元)" field="amount"
							align="right" width="110" renderer="formatMoneyForDis">
							<next:TextField />
						</next:Column>
						<next:Column id="inConfirm" header="是否确认" field="inConfirm"
							align="center" width="70" renderer="inConfirmRenderer">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationPurpose" header="资金用途"
							field="upAllocationPurpose" align="left"
							renderer="upAllocationPurposeRenderer" width="80">
							<next:TextField />
						</next:Column>
						<next:Column id="note" header="备注" field="note" align="left">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="disFundsBatchDs" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:ColumnLayout>
	</next:Panel>
	<next:Panel height="200" width="99%">
		<next:ColumnLayout>
			<next:Panel id="panel2" title="物资情况表" columnWidth=".4" height="100%">
				<next:GridPanel id="grid5" dataset="allocationDs" width="100%"
					height="175">
					<next:Columns>
						<next:Column header='物资类型' field="meterialType" width="130">
							<next:TextField />
						</next:Column>
						<next:Column header="物资单位" field="meterialUnit" align="center"
							width="80">
							<next:TextField />
						</next:Column>
						<next:Column header="物资数量" field="meterialNum" align="right"
							renderer="formatMoneyForDis" width="120">
							<next:TextField />
						</next:Column>
						<next:Column header="物资金额合计(万元)" field="meterialAccount"
							align="right" renderer="formatMoneyForDis" width="120">
							<next:TextField />
						</next:Column>
						<next:Column header="备注" field="note" align="left" width="280">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="allocationDs" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel id="otherPanel2" columnWidth=".6" height="100%">
				<next:GridPanel id="grid" dataset="disDetailBatchDs" width="100%"
					height="198" title="物资拨付记录列表">
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:Column id="batchId" header="批次ID" field="batchId"
							align="center" hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="disYear" header="年度" field="disYear"
							align="center" width="60">
							<next:TextField />
						</next:Column>
						<next:Column id="receiveTime" header="拨付日期" field="receiveTime"
							align="center" width="80">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationNum" header="拨付文号"
							field="upAllocationNum" align="center" width="120">
							<next:TextField />
						</next:Column>
						<next:Column id="inConfirm" header="是否确认" field="inConfirm"
							align="center" width="70" renderer="inConfirmRenderer">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationPurpose" header="物资用途"
							field="upAllocationPurpose" align="left"
							renderer="upAllocationPurposeRenderer" width="130">
							<next:TextField />
						</next:Column>
						<next:Column id="note" header="备注" field="note" align="left">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="disDetailBatchDs" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:ColumnLayout>
	</next:Panel>
	<next:Panel height="300" width="99%">
		<next:ColumnLayout>
			<next:Panel id="panel3" title="救助审批列表" columnWidth=".4" height="300">
				<next:GridPanel id="grid" dataset="batchDetailds" height="275">
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:Column header="年度" field="YEAR" width="50">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="批次名称" field="BATCH_NAME" width="170">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="救助类型" field="RELIEF_TYPE"
							dataset="ReliefTypeDataset" width="125">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="填报状态" field="FILL_STATE" width="100"
							renderer="fillStateRenderer">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="发放单位" field="GRANT_TYPE"
							dataset="grantTypeDataset" width="80">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="发放方式" field="ALLOCATION_TYPE"
							dataset="allocationTypeDataset" width="80">
							<next:TextField allowBlank="false" />
						</next:Column>

						<next:Column header="填报单位" field="REQUIRED_ORGAN_NAME" width="170">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="填报人" field="FILL_PEOPLE" width="135">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="填报时间" field="FILL_TIME" width="150">
							<next:TextField allowBlank="false" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="batchDetailds" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel id="otherPanel3" columnWidth=".6" height="300">
				<next:GridPanel id="grid" dataset="batchDetailDoleds" width="100%"
					height="300" title="救助发放列表">
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:Column header="年度" field="YEAR" width="50">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="批次名称" field="BATCH_NAME" width="200">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="救助类型" field="RELIEF_TYPE"
							dataset="ReliefTypeDataset" width="135">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="填报状态" field="FILL_STATE"
							renderer="fillStateRenderer2" width="80">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="发放单位" field="GRANT_TYPE" width="80"
							dataset="grantTypeDataset">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="发放方式" field="ALLOCATION_TYPE" width="80"
							dataset="allocationTypeDataset">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="填报单位" field="REQUIRED_ORGAN_NAME" width="160">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="填报人" field="FILL_PEOPLE" width="135">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="填报时间" field="FILL_TIME" width="150">
							<next:TextField allowBlank="false" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="batchDetailDoleds" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:ColumnLayout>
	</next:Panel>
</next:Panel>
</body>
</html>