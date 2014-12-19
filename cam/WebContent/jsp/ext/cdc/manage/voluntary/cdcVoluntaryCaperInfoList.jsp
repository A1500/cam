<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>志愿者参加活动信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="cdcVoluntaryCaperInfoList.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<body>
<model:datasets>
	<model:dataset id="cdcCaperInfoDataSet"
		cmd="com.inspur.cams.cdc.base.cmd.CdcCaperInfoQueryCmd" pageSize="10" sortField="START_TIME DESC,CREATE_TIME DESC,CAPER_ID">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcCaperInfo" />
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel"><label>地点:</label></td>
				<td class="FieldInput"><input type="text" id="qAddress" /></td>
				<td class="FieldLabel"><label>活动内容:</label></td>
				<td class="FieldInput"><input type="text" id="qContent" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>主办单位/组织者姓名:</label></td>
				<td class="FieldInput"><input type="text" id="qEntrepreneur" /></td>
				<td class="FieldButton" colspan="2">
					<button onclick="query()">查询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="cdcCaperInfoDataSet" width="100%"
	stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert" id="btnAdd"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update" id="btnEdit"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del" id="btnDel"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="caperId" header="活动编号" hidden="true" />
		<next:Column field="startTime" header="开始时间" width="110" sortable="false"
			align="center" />
		<next:Column field="endTime" header="结束时间" width="110" sortable="false"
			align="center" />
		<next:Column field="address" header="地点" width="140" sortable="false" />
		<next:Column field="content" header="活动内容" width="180"
			sortable="false" />
		<next:Column field="entrepreneur" header="主办单位/组织者姓名" width="130"
			sortable="false" />
		<next:Column field="caperNums" header="参加人数" width="80"
			sortable="false" align="right" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="cdcCaperInfoDataSet" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>