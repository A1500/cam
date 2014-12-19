
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>

<title>待办任务信息</title>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="db_info_list.js"></script>
<script language="javascript">
			var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
			var reliefType = '<%=request.getParameter("reliefType")%>';
			var batchState = '<%=request.getParameter("batchState")%>';
			var organType = '<%=BspUtil.getOrganType()%>';
			var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
			var day = '<%= DateUtil.getDay()%>';
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
			<tr id="jtTr">
				<td class="FieldLabel">救助家庭数量</td>
				<td class="FieldInput" colspan="3"><label
					field="FAMILY_AMOUNT" /></td>
			</tr>
			<tr id="lsTr">
				<td class="FieldLabel">总核准救助粮食（公斤）</td>
				<td class="FieldInput" style="width: 200"><label id="FOOD_AMOUNT"
					field="FOOD_AMOUNT" /></td>

				<td class="FieldLabel">人均核准救助粮食（公斤）</td>
				<td class="FieldInput" style="width: 200"><label id="FOOD_AVERAGE"
					field="FOOD_AVERAGE" /></td>
			</tr>
			<tr id="ybTr">
				<td class="FieldLabel">总核准救助衣被（件）</td>
				<td class="FieldInput"><label field="CLOTHES_AMOUNT" id="CLOTHES_AMOUNT" /></td>
				<td class="FieldLabel">人均核准救助衣被（件）</td>
				<td class="FieldInput"><label field="CLOTHES_AVERAGE" id="CLOTHES_AVERAGE" /></td>
			</tr>
			<tr id="cjTr">
				<td class="FieldLabel">总核准重建间数（间）</td>
				<td class="FieldInput"><label field="REBUILED_HOUSE_AMOUNT" id="REBUILED_HOUSE_AMOUNT"/></td>

				<td class="FieldLabel">人均核准重建间数（间）</td>
				<td class="FieldInput"><label field="REBUILED_HOUSE_AVERAGE" id="REBUILED_HOUSE_AVERAGE"/></td>
			</tr>
			<tr id="xsTr">
				<td class="FieldLabel">总核准修缮间数（间）</td>
				<td class="FieldInput"><label field="REPAIRED_HOUSE_AMOUNT" id="REPAIRED_HOUSE_AMOUNT"/></td>

				<td class="FieldLabel">人均核准修缮间数（间）</td>
				<td class="FieldInput"><label field="REPAIRED_HOUSE_AVERAGE" id="REPAIRED_HOUSE_AVERAGE"/></td>
			</tr>
			<tr id="zjTr">
				<td class="FieldLabel">总核准救助资金（元）</td>
				<td class="FieldInput"><label field="MONRY_AMOUNT" id="MONRY_AMOUNT"/></td>

				<td class="FieldLabel">人均核准救助资金（元）</td>
				<td class="FieldInput"><label field="MONRY_AVERAGE" id="MONRY_AVERAGE"/></td>
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
		<next:ToolBarItem id="xgYJ" text="修改" iconCls="edit" handler="edit"
			hidden="true" />
		<next:ToolBarItem id="blYJ" text="办理" iconCls="send" handler="deal" />
		<next:ToolBarItem id="ffYJ" text="发放" iconCls="send" handler="grant"
			hidden="true" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column header="所在村" field="ACCEPT_AREA_NAME" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>


		<next:Column header="核准救助人口数量" field="APPROVAL_FAMILY_NUM" width="200" align="right">
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


<next:GridPanel id="swGridPanel" name="disreliefinfoGrid" width="100%"
	hidden="true" stripeRows="true" clickToSelectedForChkSM="true"
	height="100%" dataset="ds" title="因灾死亡人员家庭抚慰金发放信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail" />
		<next:ToolBarItem id="xgSW" text="修改" iconCls="edit" handler="edit"
			hidden="true" />
		<next:ToolBarItem id="blSW" text="办理" iconCls="send" handler="deal" />
		<next:ToolBarItem id="ffSW" text="发放" iconCls="send" handler="grant"
			hidden="true" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

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
		<next:ToolBarItem id="xgCJ" text="修改" iconCls="edit" handler="edit"
			hidden="true" />
		<next:ToolBarItem id="blCJ" text="办理" iconCls="send" handler="deal" />
		<next:ToolBarItem id="ffCJ" text="发放" iconCls="send" handler="grant"
			hidden="true" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column header="所属行政区划" field="TOWN_CODE_NAME" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="户主姓名" field="NAME" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="身份证号码" field="ID_CARD" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>


		<next:Column header="核准重建间数（间）" field="APPROVAL_REBUILED_HOUSE"
			width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="核准修缮间数（间）" field="APPROVAL_REPAIRED_HOUSE"
			width="150" align="right">
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
		<next:ToolBarItem id="xgGD" text="修改" iconCls="edit" handler="edit"
			hidden="true" />
		<next:ToolBarItem id="blGD" text="办理" iconCls="send" handler="deal" />
		<next:ToolBarItem id="ffGD" text="发放" iconCls="send" handler="grant"
			hidden="true" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

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
		<next:ToolBarItem id="xgDC" text="修改" iconCls="edit" handler="edit"
			hidden="true" />
		<next:ToolBarItem id="blDC" text="办理" iconCls="send" handler="deal" />
		<next:ToolBarItem id="ffDC" text="发放" iconCls="send" handler="grant"
			hidden="true" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

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
<next:Window id="sendinfo" title="操作" resizable="false" width="520"
	height="135" closeAction="hide" modal="true">
	<next:Panel>
		<next:Html>
			<form id="form1" onsubmit="return false" class="L5form">
			<table border="0" width="99%">
				<tr>
					<td class="FieldLabel">操作类别：</td>
					<td class="FieldInput" colspan="3"><select id="changeState"
						title="操作类别">
					</select><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">审批人：</td>
					<td class="FieldInput"><input type="text"
						id="auditPeopleName" /></td>
					<td class="FieldLabel">审批时间：</td>
					<td class="FieldInput"><input type="text" format="Y-m-d"
						style="width: 100px;" maxlength="10" id="auditDate" /><img
						src="../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this)"></td>
				</tr>
			</table>
			</form>
		</next:Html>
		<next:Buttons>
			<next:ToolButton text="确定" handler="send()"></next:ToolButton>
			<next:ToolButton text="关闭" handler="close()"></next:ToolButton>
		</next:Buttons>
	</next:Panel>
</next:Window>
<next:Window id="grantinfo" title="发放" resizable="false" width="520"
	height="100" closeAction="hide" modal="true">
	<next:Panel>
		<next:Html>
			<form id="form2" onsubmit="return false" class="L5form">
			<table border="0" width="99%">
				<tr>
					<td class="FieldLabel">发放人：</td>
					<td class="FieldInput"><input type="text"
						id="grantPeopleName" /></td>
					<td class="FieldLabel">发放时间：</td>
					<td class="FieldInput"><input type="text" format="Y-m-d"
						style="width: 100px;" maxlength="10" id="grantTime" /><img
						src="../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this)"></td>
				</tr>
			</table>
			</form>
		</next:Html>
		<next:Buttons>
			<next:ToolButton text="确定" handler="suregrant()"></next:ToolButton>
			<next:ToolButton text="关闭" handler="grantclose()"></next:ToolButton>
		</next:Buttons>
	</next:Panel>
</next:Window>
</body>
</html>
