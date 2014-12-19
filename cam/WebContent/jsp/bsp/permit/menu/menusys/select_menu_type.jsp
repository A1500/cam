<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager ></next:ScriptManager>
<html>
<head>
<title>选择菜单类型</title>
<script type="text/javascript" src="js/select_menu_type.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="menuTypeDs" cmd="org.loushang.bsp.permit.menu.cmd.MenuTypeQueryCmd" global="true">
		<model:record fromBean="org.loushang.bsp.permit.menu.data.MenuType">
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel  width="100%"  border="false" autoScroll="false">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
</next:TopBar>
<next:GridPanel id="menuTypeGridPanel" dataset="menuTypeDs" width="100%" height="100%"  title="选择菜单类型">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>	
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="menuTypeName" id="menuTypeName" header="菜单类型名称" width="100%">
			<next:TextField />
		</next:Column>
	</next:Columns>
</next:GridPanel>
 </next:Panel>
</body>
</html>