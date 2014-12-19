<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.jcm.util.PrimaryKeyCreateUtil"%>
<% String str = PrimaryKeyCreateUtil.createPrimaryKey(); %>

<html>
<head>
<title>字典管理信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script>
	var uuid = '<%=str %>';
</script>
<script type="text/javascript" src="jcmDic.js">
</script>
</head>
<body>
<model:datasets>
	<!-- 字典管理信息 -->
	<model:dataset id="jcmDicDataSet" cmd="com.inspur.cams.jcm.cmd.JcmDicQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmDic">
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:EditGridPanel id="grid" dataset="jcmDicDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="inserts"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="dels"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="id" header="ID" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="dicType" header="字典类型" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="dicEn" header="字典英文编码" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="dicCn" header="字典中文编码" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="dicNote" header="字典说明" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="dicStatus" header="字典状态" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="dicCode" header="字典编码" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmDicDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</body>
</html>