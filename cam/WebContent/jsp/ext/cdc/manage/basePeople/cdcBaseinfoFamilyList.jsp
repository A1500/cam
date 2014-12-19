<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>家庭 信息列表</title>
<next:ScriptManager></next:ScriptManager>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<script type="text/javascript" src="cdcBaseinfoFamilyList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcBaseinfoPeopleDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcBaseinfoPeopleQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcBaseinfoPeople"/>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<!-- 政治面貌 -->
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<!-- 文化程度 -->
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">户主姓名：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "query_name" /></td>
					<td class="FieldLabel" style="width:10%">家庭住址：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "query_address" /></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="cdcBaseinfoPeopleDataSet" width="100%" stripeRows="true" height="99.9%" autoExpandColumn="address">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="添加家庭" handler="addFamily"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改家庭信息" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="家庭明细" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除家庭" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="户主姓名" width="90" sortable="false"/>
		<next:Column field="idCard" header="身份证件号码" width="150" sortable="false"/>
		<next:Column field="sex" header="性别" width="60" dataset ="sexDataSet" sortable="false"/>
		<next:Column field="birthday" header="出生日期" width="90" sortable="false"/>
		<next:Column field="nation" header="民族" width="80" dataset ="NationDataset" sortable="false"/>
		<next:Column field="eduCode" header="文化程度" width="90" dataset ="educationDataSet" sortable="false"/>
		<next:Column field="politicalCode" header="政治面貌" width="90" dataset ="politicalDataSet" sortable="false"/>
		<next:Column field="tel" header="联系电话" width="100" sortable="false"/>
		<next:Column id="address" field="address" header="住址" width="150" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="cdcBaseinfoPeopleDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>