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
			dataset="menuTypeDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="->" />
				<next:ToolBarItem iconCls="add" text='<%=res.get("BUT.ADD")%>'
					handler="add_click" />
				<next:ToolBarItem iconCls="remove" text='<%=res.get("BUT.REMOVE")%>'
					handler="remove_click" />
				<next:ToolBarItem iconCls="save" text='<%=res.get("BUT.SAVE")%>'
					handler="save_click" />
				<next:ToolBarItem iconCls="undo" text='<%=res.get("BUT.UNDO")%>'
					handler="undo_click" />
				<next:ToolBarItem iconCls="edit" text='<%=res.get("UTIL.MANAGER")%>'
					handler="manage_menu" />
				<next:ToolBarItem text='导出' iconCls="export" handler="exportMenu"/>
				<next:ToolBarItem text='导入' iconCls="import" handler="importMenu"/>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="typename"
					header='<%=res.get("PUB_MENU_TYPE.MENUTYPENAME")%>'
					field="menuTypeName" width="200">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="isSysDefault"
					header='<%=res.get("PUB_MENU_TYPE.DEFULTMENU")%>'
					field="isSysDefault" width="200" dataset="useStatus" >
					<next:ComboBox dataset="useStatus" displayField="text" valueField="value" triggerAction="all">
					</next:ComboBox>
				</next:Column>
				<next:Column id="isSys" header='<%=res.get("PUB_MENU_TYPE.ISSYS")%>'
					field="isSys" width="200" dataset="useStatus" >
					<next:ComboBox dataset="useStatus" displayField="text" triggerAction="all" editable="false">
					</next:ComboBox>
		    </next:Column>
			</next:Columns>
		</next:EditGridPanel>
		<next:Panel id="dao" title=""  height="100%" width="100%" border="false" >
			 <next:Html>
				<div id="loadmask" style="display: none;" class="loading" >
					 <img src="<%=request.getContextPath()%>/skins/images/default/extanim32.gif"
					                        width="32" height="32" style="margin-right: 8px;" />正在处理...</div>
					 <iframe id="frame1" frameborder="no"  marginwidth="0" marginheight="0" allowtransparency="yes" 
						 style="overflow: auto" height="100%" width="100%" 
								src="../../../demo/blank.jsp"></iframe>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>