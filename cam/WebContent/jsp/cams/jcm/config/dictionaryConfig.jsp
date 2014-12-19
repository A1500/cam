<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>字典详细信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="dictionaryConfig.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 字典详细信息 -->
	<model:dataset id="dicJcmDetailsDataSet" cmd="com.inspur.cams.jcm.cmd.DicJcmDetailsQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.DicJcmDetails">
			<model:field name="code" type="string" rule="require|length{2}" />
			<model:field name="name" type="string" rule="require" />
			<model:field name="dicType" type="string" rule="require" />
		</model:record>
	</model:dataset>
	
	<!-- 字典表的引用 字典类型 -->
	<model:dataset id="dicJcmManageDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_JCM_MANAGE"></model:param>        <!-- 需要查询的表 -->
			<model:param name="value" value="DIC_TYPE"></model:param>     <!-- 查询的内容 -->
			<model:param name="text" value="DIC_NAME"></model:param>    <!-- 输出查询的结果 -->
		</model:params>
	</model:dataset>
	<!-- 枚举  是、否 -->
	<model:dataset id="YESORNO" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:EditGridPanel id="grid" dataset="dicJcmDetailsDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="inserts"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="dels"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="dicType" header="字典类型" width="160" sortable="false">
			<next:ComboBox dataset="dicJcmManageDataSet" triggerAction="all"  valueField="value" displayField="text"></next:ComboBox>
		</next:Column>
		<next:Column field="code" header="代码值" width="160" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="name" header="名称" width="160" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="flag" header="是否有效" width="160" sortable="false">
			<next:ComboBox dataset="YESORNO" triggerAction="all"  valueField="value" displayField="text"></next:ComboBox>
		</next:Column>
		<next:Column field="orderNum" header="排序字段" width="160" sortable="false" hidden="true">
			<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dicJcmDetailsDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</body>
</html>