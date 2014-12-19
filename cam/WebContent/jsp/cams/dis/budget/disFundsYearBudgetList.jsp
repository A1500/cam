<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>救灾资金年度预算表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request, "camsCheck.js")%>'></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="disFundsYearBudgetList.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="disFundsYearBudgetDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsYearBudgetQueryCmd"
		pageSize="10" global="true" isGroup="true" groupField="disYear" sortField="FILL_TIME DESC,ID">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisFundsYearBudget" />
	</model:dataset>
	<!-- 预算类型 -->
	<model:dataset id="disBudgetType" enumName="DIS.BUDGET_TYPE"
		global="true" autoLoad="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">填报单位:</td>
				<td class="FieldInput"><input type="text"
					id="requiredOrganName" class="TextEditor" title="所属行政区划"
					style="width: 200" /> <input type="hidden" id="requiredOrganCode"
					class="TextEditor" title="所属行政区划" /> <img
					src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
					style="cursor: hand" onclick="forOrganSelect()" /></td>
				<td class="FieldLabel" nowrap>年度：</td>
				<td class="FieldInput"><input type="text" id="cx_disYear"
					class="TextEditor" title="年度" maxlength="4" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>预算类型：</td>
				<td class="FieldInput"><select id="cx_budgetType"
					class="TextEditor" title="预算类型">
					<option dataset="disBudgetType" />
				</select></td>
				<td class="FieldButton" colspan="2">
					<button onclick="query()">查询</button>
						&nbsp;&nbsp;
					<button onclick="resetQuery()">重置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="budgetGrid" dataset="disFundsYearBudgetDs"
	width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem text="资金预算管理"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40"></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column hidden="true" id="id" field="id" header="ID" width="30%"
			sortable="false" align="center" />
			
		<next:Column id="disYear" field="disYear" header="年度" width="60"
			sortable="true" align="center" />
		<next:Column id="budgetType" field="budgetType" header="预算类型"
			width="120" sortable="false" dataset="disBudgetType" align="center" />
			
		<next:Column id="budgetMoney" field="budgetMoney" header="预算金额(元)"
			width="120" sortable="false" align="right" renderer="formatNum"/>
		<next:Column hidden="true" id="fillOrganCode" field="fillOrganCode"
			header="填报单位代码" width="30%" sortable="false" align="center" />
			
		<next:Column id="fillOrganName" field="fillOrganName" header="填报单位名称"
			width="200" sortable="false" align="center" />
			
		<next:Column id="fillTime" field="fillTime" header="填报时间" width="200"
			sortable="true" align="center" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="disFundsYearBudgetDs" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>

<!--预算-->
<next:Window id="budgetWin" width="400" height="350" collapsible="false"
	closable="close" resizable="true" modal="true" title="救灾资金年度预算维护">
	<next:TopBar>
		<next:ToolBarItem symbol="->" />
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="return" text="取消" handler="cancel" />
	</next:TopBar>
	<next:Panel id="dFYBE" name="dFYBE" width="100%" autoHeight="100%">
		<next:Html>
			<form id="editForm" dataset="disFundsYearBudgetDs"
				onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width: 15%" nowrap>年度:</td>
					<td class="FieldInput" style="width: 35%"><input type="text"
						id="disYear" name="disYear" field="disYear" title="年度"
						maxlength="4" /> <font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%" nowrap>预算类型:</td>
					<td class="FieldInput" style="width: 35%"><select
						id="budgetType" name="budgetType" field="budgetType" title="预算类型">
						<option dataset="disBudgetType"></option>
					</select> <font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%" nowrap>预算金额:</td>
					<td class="FieldInput" style="width: 35%" colspan="3"><input
						type="text" id="budgetMoney" name="budgetMoney"
						field="budgetMoney" title="预算金额" maxlength="16"
						onchange="checkAssMon(this.id)" />元 <font color="red">*</font></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>