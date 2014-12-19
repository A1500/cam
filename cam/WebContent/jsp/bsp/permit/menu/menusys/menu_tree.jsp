<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
<title><%=res.get("MENU_TREE_MANAGER")%></title>
<script type="text/javascript" >
var menuSysTypeId = '<%=request.getParameter("menuTypeId")%>';
var menuTypeName = '<%=request.getParameter("menuTypeName")%>';
menuTypeName = decodeURI(menuTypeName);
var isSys = '<%=request.getParameter("isSys")%>';//是否系统预置
var isSysDefault = '<%=request.getParameter("isSysDefault")%>';
/**
*定义根节点
*/
var rootdata = {
	id:'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	menuId:menuSysTypeId,
	menuName:'主菜单',
	menuStruId:'rootId',
	parentMenuId:menuSysTypeId,
	recordType:'menuRecord' //这个是必须滴，指定那个record
};
</script>
<script type="text/javascript" src="js/menu_tree.js"></script>
</head>
<body>
<next:ViewPort>
  <next:BorderLayout>
	 <next:Left split="true" cmargins="5 0 0 0" margins="5 5 0 0">
	   <next:Panel title='<%=res.get("MENU_TREE") %>' width="20%" collapsible="true" autoScroll="true">
   			<next:Tree name="menutree" id="menutree" width="100%"  autoHeight="true" lines="true" border="false" autoScroll="true" >
				<next:TreeDataSet dataset="menudataset" root="rootdata">
					<next:TreeLoader cmd="org.loushang.bsp.permit.menu.cmd.MenuStruQueryCmd" trigger="loadMenu">
						<next:treeRecord name="menuRecord" idField="menuStruId" >
							<model:field name="menuStruId" type="string"/>
							<model:field name="menuId" type="string"/>
							<model:field name="menuName" type="string"/>
							<model:field name="menuPath" type="string"/>
							<model:field name="pathName" type="string"/>
							<model:field name="parentMenuId" type="string"/>
							<model:field name="isLeaf" type="string"/>
							<model:field name="seq" type="string"/>
							<model:field name="menuTypeId" type="string"/>
							<model:field name="requestAction" type="string"/>
							<model:field name="target" type="string"/>
							<model:field name="moduleCode" type="string"/>
							<model:field name="functionCode" type="string"/>
							<model:field name="appCode" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="PARENT_MENU_ID@=" value="getParentMenuId"/>
						<next:TreeBaseparam name="MENU_TYPE_ID@=" value="getMenuTypeId"/>
						<next:TreeBaseparam name="MENU_PATH@like" value="getMenuPath"/>
						<next:TreeBaseparam name="sort" value="'SEQ'"/>
						<next:TreeBaseparam name="dir" value="'ASC'"/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="menuRecord">
					<next:TreeNodeAttribute name="text" mapping="menuName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
					<next:RightmouseMenu menuId="noSys" trigger="noSysShow">
						<next:MenuItem text='<%=res.get("MENU_ADD")%>' handler="addMenu"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU_SELECT")%>' handler="selectFromMenu"></next:MenuItem>
						<next:MenuItem text='<%=res.get("BUT.REMOVE")%>' handler="deleteMenu"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU_MOVE_TO")%>' handler="moveToMenu"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU_UP")%>' handler="moveUPMenu"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU_DOWN")%>' handler="moveDownMenu"></next:MenuItem>
						<next:MenuItem text='导入' handler="importInfo"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>
					</next:RightmouseMenu>
					<next:RightmouseMenu trigger="handler"  menuId="menuId2">
							<next:MenuItem text='<%=res.get("BUT.REMOVE")%>' handler="deleteMenu"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU_MOVE_TO")%>' handler="moveToMenu"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU_UP")%>' handler="moveUPMenu"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU_DOWN")%>' handler="moveDownMenu"></next:MenuItem>
						<next:MenuItem text='导入' handler="importInfo"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>
					</next:RightmouseMenu>
						<next:RightmouseMenu trigger="isRootMenu"  menuId="menuId4">
						<next:MenuItem text='<%=res.get("MENU_ADD")%>' handler="addMenu"></next:MenuItem>
						<next:MenuItem text='<%=res.get("MENU_SELECT")%>' handler="selectFromMenu"></next:MenuItem>
						<next:MenuItem text='导入' handler="importInfo"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>
				</next:RightmouseMenu>
					<next:RightmouseMenu trigger="sysShow"  menuId="menuId3">	
						<next:MenuItem text='导入' handler="importInfo"></next:MenuItem>
						<next:MenuItem text='导出' handler="exportInfo"></next:MenuItem>	
					</next:RightmouseMenu>
					<next:Listeners>
						<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
					</next:Listeners>
				</next:TreeNodemodel>
			</next:Tree>
	   </next:Panel>
	 </next:Left>
	 <next:Center split="true" margins="5 0 0 0" margins="5 5 0 0">
		<next:Panel autoScroll="true" height="100%" width="100%">
	 	<next:Panel id="center" height="100%"  hidden="ture" width="100%" autoScroll="false" collapsible="true" bodyStyle="overflow-y:auto;overflow-x:hidden">
	 	
	 	<next:TopBar>
		<next:ToolBarItem  symbol="->"  />
		<next:ToolBarItem iconCls="undo"  text='返回' handler="cancel_click"/>
	   </next:TopBar>	
	 	
	 	<next:Html>
	 			<iframe id="nodeFrame" name="nodeFrame" frameborder="no" border="0" marginwidth="0"
								marginheight="0" allowtransparency="yes"
								width="100%" style="overflow:auto" height="100%">
				</iframe>
	 		</next:Html>
	 	</next:Panel>
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
	 </next:Panel>
	 </next:Center>
  </next:BorderLayout>
</next:ViewPort>
</body>
</html>