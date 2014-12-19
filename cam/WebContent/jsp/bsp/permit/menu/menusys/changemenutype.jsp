<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title><%=res.get("PUB_MENU_TYPE.TIELE")%></title>
<next:ScriptManager />
<script type="text/javascript" src="js/menutypemanager.js"></script>
<script language="javascript">
	var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
	var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
	var RES_SAVE='<%=res.get("MSG.SAVE")%>';
	var RES_DELETE='<%=res.get("ASK.DELETE")%>';
	var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
	var ASK_SELETE_DELETE = '<%=res.get("UTIL.SELECT_DELETE")%>';
	var ALERT_SELECT_ONE = '<%=res.get("ALETR_SELECT_ONE")%>';
	var MENU_TREE_MANAGER = '<%=res.get("MENU_TREE_MANAGER")%>';
	var alert_sys_default = '<%=res.get("ALERT_SYS_DEFULT")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="useStatus" enumName="BSP.IN_USE" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="menuTypeDataSet"  pageSize="65535"
		cmd="org.loushang.bsp.permit.menu.cmd.MenuTypeQueryCmd" global="true" >
		<model:record fromBean="org.loushang.bsp.permit.menu.data.MenuType"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>

		<next:EditGridPanel id="menusystypeGrid" name="menusystypeGrid"
			style="width:100%;" anchor="100% 100%"
			dataset="menuTypeDataSet"	>
			<next:TopBar>
				<next:ToolBarItem symbol="->" />
				<next:ToolBarItem iconCls="save" text='<%=res.get("BUT.CHANGE")%>'
					handler="app_menu" />
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column id="typename"
					header='<%=res.get("PUB_MENU_TYPE.MENUTYPENAME")%>'
					field="menuTypeName" width="200">
				</next:Column>
				<next:Column id="isSysDefault"
					header='<%=res.get("PUB_MENU_TYPE.DEFULTMENU")%>'
					field="isSysDefault" width="200" dataset="useStatus">
				</next:Column>
			</next:Columns>

		</next:EditGridPanel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>