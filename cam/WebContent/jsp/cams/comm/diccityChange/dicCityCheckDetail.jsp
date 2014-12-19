<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>行政区划变更列表</title>
<next:ScriptManager></next:ScriptManager>
<%
	String method = request.getParameter("method");
%>
<script type="text/javascript">
	 var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	 var batchId='<%=request.getParameter("batchId")%>';
	 var changeId = '<%=IdHelp.getUUID32()%>';
	 var method = '<%=method%>';
</script>
<script type="text/javascript" src="dicCityCheckDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicCityChangeDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeQueryCmd" sortField="serialNum" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChange">
			<model:field name="serialNum" type="string" rule="require|length{3}" />
		</model:record>
	</model:dataset>
	<!-- 区划撤销时详细明细 -->
	<model:dataset id="dicCityDetailDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityDataTransQueryCmd" sortField="preChangeCode" pageSize="250">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityDataTrans"/>
	</model:dataset>
	<!-- 变更类型 -->
	<model:dataset id="changeTypeDataset" enumName="COMM.CHANGE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 处理结果 -->
	<model:dataset id="changeResultDataset" enumName="COMM.CHANGE.RESULT" autoLoad="true" global="true"></model:dataset>
	<!-- 调整类别 -->
	<model:dataset id="adjustTypeDataset" enumName="COMM.ADJUST.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 撤销时迁移类型 -->
	<model:dataset id="transTypeDataset" enumName="COMM.TRANS.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">变更前区划代码：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "pre_code" /></td>
					<td class="FieldLabel" style="width:10%">变更前区划名称：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "pre_name" /></td>
					<td class="FieldLabel" style="width:10%">变更类别：</td>
					<td class="FieldInput" style="width:12%"><select  id = "change_type" ><option dataset="changeTypeDataset"></option></select></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">变更后区划代码：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "change_code" /></td>
					<td class="FieldLabel" style="width:10%">变更后区划名称：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "change_name" /></td>
					<td class="FieldButton" style="width:20%" colspan="2"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel height="60%" id="grid"  dataset="dicCityChangeDataSet" autoScroll="true"  width="100%" titleCollapse="true" collapsible="true"  stripeRows="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert" id="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update" id="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del" id="del"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="校验" handler="check" id="check"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="changeId" header="变更业务ID" width="10%" sortable="false" hidden="true"/>
		<next:Column field="serialNum" header="序号" width="5%" >
			<next:TextField  />
		</next:Column>
		<next:Column field="changeType" header="变更类型" width="10%" sortable="false" dataset="changeTypeDataset"/>
		<next:Column field="preChangeCode" header="变更前区划代码" width="10%" sortable="false"/>
		<next:Column field="preChangeName" header="变更前区划名称" width="15%" sortable="false"/>
		<next:Column field="postChangeCode" header="变更后区划代码" width="10%" sortable="false"/>
		<next:Column field="postChangeName" header="变更后区划名称" width="15%" sortable="false"/>
		<next:Column field="postUpsCode" header="变更后上级区划代码" width="15%" sortable="false"/>
		<next:Column field="postUpsName" header="变更后上级区划名称" width="15%" sortable="false"/>
		<next:Column field="changeResult" header="处理结果" width="10%" sortable="false" hidden="true" dataset="changeResultDataset"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dicCityChangeDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:GridPanel  id="detailGrid" title="行政区划撤销时民政事业数据合并"  dataset="dicCityDetailDataSet"  width="100%" titleCollapse="true" collapsible="true"  stripeRows="true" height="100%">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:Column field="transId" header="数据迁移ID" width="10%" sortable="false" hidden="true"/>
		<next:Column field="changeId" header="变更业务ID" width="10%" sortable="false" hidden="true"/>
		<next:Column field="transType" header="迁移类型" width="10%" sortable="false" dataset="transTypeDataset"/>
		<next:Column field="preChangeCode" header="迁移前区划代码" width="15%" sortable="false" ></next:Column>
		<next:Column field="preChangeName" header="迁移前区划名称" width="15%" sortable="false" ></next:Column>
		<next:Column field="postUpsCode" header="迁移后上级区划代码" width="15%" sortable="false"></next:Column>
		<next:Column field="postUpsName" header="迁移后上级区划名称" width="15%" sortable="false"></next:Column>
		<next:Column field="postChangeCode" header="迁移后区划代码" width="15%" sortable="false"></next:Column>
		<next:Column field="postChangeName" header="迁移后区划名称" width="15%" sortable="false"></next:Column>
	</next:Columns>
</next:GridPanel>
</body>
</html>