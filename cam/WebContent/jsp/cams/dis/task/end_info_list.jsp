
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>完成任务信息</title>
<next:ScriptManager />
<script type="text/javascript" src="end_info_list.js"></script>
<script language="javascript">
			var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
			var reliefType = '<%=request.getParameter("reliefType")%>';
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefTaskQueryCommand"
		global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo"></model:record>
	</model:dataset>
	<!-- 获取批次汇总信息 -->
	<model:dataset id="amountds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand"
		method="queryBatchGatherDate" global="true">
	</model:dataset>
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="workflowStateDs"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel title="分析汇总" width="100%">
	<next:Html>
		<form id="editForm" dataset="amountds" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="1" width="100%">

			<tr>
				<td class="FieldLabel">救助家庭数量</td>
				<td class="FieldInput" colspan="3"><label
					field="FAMILY_AMOUNT" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">总核准救助粮食（公斤）</td>
				<td class="FieldInput" style="width: 200"><label
					field="FOOD_AMOUNT" /></td>

				<td class="FieldLabel">人均核准救助粮食（公斤）</td>
				<td class="FieldInput" style="width: 200"><label
					field="FOOD_AVERAGE" /></td>
			</tr>
			<tr>

				<td class="FieldLabel">总核准救助衣被（件）</td>
				<td class="FieldInput"><label field="CLOTHES_AMOUNT" /></td>
				<td class="FieldLabel">人均核准救助衣被（件）</td>
				<td class="FieldInput"><label field="CLOTHES_AVERAGE" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">总核准重建间数（间）</td>
				<td class="FieldInput"><label field="REBUILED_HOUSE_AMOUNT" /></td>

				<td class="FieldLabel">人均核准重建间数（间）</td>
				<td class="FieldInput"><label field="REBUILED_HOUSE_AVERAGE" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">总核准修缮间数（间）</td>
				<td class="FieldInput"><label field="REPAIRED_HOUSE_AMOUNT" /></td>

				<td class="FieldLabel">人均核准修缮间数（间）</td>
				<td class="FieldInput"><label field="REPAIRED_HOUSE_AVERAGE" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">总核准救助资金（元）</td>
				<td class="FieldInput"><label field="MONRY_AMOUNT" /></td>

				<td class="FieldLabel">人均核准救助资金（元）</td>
				<td class="FieldInput"><label field="MONRY_AVERAGE" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

<next:GridPanel id="yjGridPanel" name="disreliefinfoGrid" width="100%"
	stripeRows="true" clickToSelectedForChkSM="true" height="100%"
	dataset="ds" title="应急生活救助信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>

		<next:Column header="所在村" field="ACCEPT_AREA_NAME" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="note" header="核准救助人口数量" field="APPROVAL_FAMILY_NUM" align="right"
			width="200">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="organName" header="核准救助粮食（公斤）" field="APPROVAL_FOOD" align="right"
			width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="note" header="核准救助衣被（件）" field="APPROVAL_CLOTHES" align="right"
			width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="审批状态" field="WORKFLOW_STATUS"
			dataset="workflowStateDs" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>


<next:GridPanel id="swGridPanel" name="disreliefinfoGrid" width="100%"
	hidden="true" stripeRows="true" clickToSelectedForChkSM="true"
	height="100%" dataset="ds" title="因灾死亡人员家庭抚慰金发放信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>

		<next:Column header="所属行政区划" field="TOWN_CODE_NAME" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="户主姓名" field="NAME" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="身份证号码" field="ID_CARD" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>


		<next:Column header="核准救助资金（元）" field="APPROVAL_MONRY" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="核准救助粮食（公斤）" field="APPROVAL_FOOD" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="核准救助衣被（件）" field="APPROVAL_CLOTHES" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="审批状态" field="WORKFLOW_STATUS"
			dataset="workflowStateDs" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>



<next:GridPanel id="cjGridPanel" name="disreliefinfoGrid" width="100%"
	hidden="true" stripeRows="true" clickToSelectedForChkSM="true"
	height="100%" dataset="ds" title="灾区民房恢复重建补助信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>

		<next:Column header="所属行政区划" field="TOWN_CODE_NAME" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="户主姓名" field="NAME" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="身份证号码" field="ID_CARD" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>


		<next:Column header="核准重建间数（间）" field="APPROVAL_REBUILED_HOUSE" align="right"
			width="150">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="核准修缮间数（间）" field="APPROVAL_REPAIRED_HOUSE" align="right"
			width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="核准补助资金（元）" field="APPROVAL_MONRY" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="审批状态" field="WORKFLOW_STATUS"
			dataset="workflowStateDs" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>


<next:GridPanel id="gdGridPanel" name="disreliefinfoGrid" width="100%"
	hidden="true" stripeRows="true" clickToSelectedForChkSM="true"
	height="100%" dataset="ds" title="过渡性生活救助信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>

		<next:Column header="所在村" field="ACCEPT_AREA_NAME" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>


		<next:Column header="核准救助户数" field="APPROVAL_FAMILY_NUM" width="200" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="核准救助粮食（公斤）" field="APPROVAL_FOOD" width="200" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="核准救助衣被（件）" field="APPROVAL_CLOTHES" width="200" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="审批状态" field="WORKFLOW_STATUS"
			dataset="workflowStateDs" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>


<next:GridPanel id="dcGridPanel" name="disreliefinfoGrid" width="100%"
	hidden="true" stripeRows="true" clickToSelectedForChkSM="true"
	height="100%" dataset="ds" title="冬春生活救助信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>

		<next:Column header="所属行政区划" field="TOWN_CODE_NAME" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="户主姓名" field="NAME" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="身份证号码" field="ID_CARD" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>


		<next:Column header="核准救助资金（元）" field="APPROVAL_MONRY" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="核准救助粮食（公斤）" field="APPROVAL_FOOD" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="核准救助衣被（件）" field="APPROVAL_CLOTHES" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="审批状态" field="WORKFLOW_STATUS"
			dataset="workflowStateDs" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>

</body>
</html>
