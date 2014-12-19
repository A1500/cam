<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<script type="text/javascript" src="js/menu_listform_forselect.js"></script>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
var menuTypeId = '<%=request.getParameter("menuTypeId")%>';//菜单类型id
var menuId = '<%=request.getParameter("menuId")%>';//当前菜单节点的menuid
var menuStruId = '<%=request.getParameter("menuStruId")%>';//菜单结构Id
var opFlag = '<%=request.getParameter("opFlag")%>';//操作标志
/**
*定义根节点
*/
var rootdata = {
	id:'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	menuId:'rootId',
	menuName:'主菜单',
	menuStruId:'rootId',
	recordType:'menuRecord' //这个是必须滴，指定那个record
};
</script>
</head>
<body>
<div style="display: none"><xml id="datasetDiv"> <datasets>
<dataset id="menuTypeDataSet" proxy="cmd" autoLoad="true"
	sortField="ORGAN_TYPE"> <record> <field name="value"
	mapping="menuTypeId" type="string" /> <field name="text"
	mapping="menuTypeName" type="string" /> </record> <command>org.loushang.bsp.permit.menu.cmd.MenuTypeQueryCmd</command>
</dataset> </datasets> </xml></div>

<!--<next:GridPanel id="menusystypeGrid" name="menusystypeGrid" width="100%" height="100" stripeRows="true" dataset="menuTypeDataSet" title='<%=res.get("PUB_MENU_TYPE.SYSMENUTYPE")%>'>
	<next:Columns onRowSelect="RowSelect">
		<next:RowNumberColumn width="30"/>
		<next:Column id="id" header='<%=res.get("PUB_MENU_TYPE.MENUTYPEID")%>' field="menuTypeId" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="typename" header='<%=res.get("PUB_MENU_TYPE.MENUTYPENAME")%>' field="menuTypeName" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="isSysDefault" header='<%=res.get("PUB_MENU_TYPE.ISSYS")%>' field="isSysDefault" width="200" dataset="useStatus">
		</next:Column>
	</next:Columns>
</next:GridPanel>
-->


<next:ViewPort>
<next:Panel>
<next:Html>
<form id="myform" onsubmit="return false;" class="L5form">
	<table  border="0" width="100%">
		<tr>
			<td style="background-color:#d4e1f1;font:normal 12px tahoma, arial, helvetica, sans-serif;width:15%" ><%=res.get("SELECT_MENU_TYPE") %></td>
			<td class="FieldInput">
				<select id ="smenuTypeId" field="menuTypeName" onchange="changeSelect(this)" noPlease="true"><option dataset="menuTypeDataSet" ></option></select>
			</td>
		</tr>
	</table>
</form>
</next:Html>
</next:Panel>
<next:Panel width="100%"  height ="100%" collapsible="true" autoScroll="false" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">

	<next:TopBar>

		<next:ToolBarItem symbol='<%=res.get("MENU_TREE") %>' ></next:ToolBarItem>
		<next:ToolBarItem  symbol="->"  />
		<next:ToolBarItem iconCls="save"  text='<%=res.get("BUT.SAVE")%>' handler="save_click"/>
	</next:TopBar>
	<next:Tree name="menutreeForSelect" id="menutreeForSelect"
		height="410" lines="true" autoScroll="true">
		<next:TreeDataSet dataset="menudataset" root="rootdata">
			<next:TreeLoader
				cmd="org.loushang.bsp.permit.menu.cmd.MenuStruQueryCmd"
				trigger="loadMenu">
				<next:treeRecord name="menuRecord" idField="menuStruId">
					<model:field name="menuStruId" type="string" />
					<model:field name="menuId" type="string" />
					<model:field name="menuName" type="string" />
					<model:field name="pathName" type="string" />
					<model:field name="menuPath" type="string" />
					<model:field name="isLeaf" type="string" />
				</next:treeRecord>
				<next:TreeBaseparam name="PARENT_MENU_ID@=" value="getParentMenuId" />
				<next:TreeBaseparam name="MENU_TYPE_ID@=" value="getMenuTypeId" />
				<next:TreeBaseparam name="MENU_PATH@like" value="getMenuPath" />
				<next:TreeBaseparam name="sort" value="'SEQ'" />
				<next:TreeBaseparam name="dir" value="'ASC'" />
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="menuRecord">
			<next:TreeNodeAttribute name="text" mapping="menuName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getShowType"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="leaf" handler="getIsLeaf"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
	</next:Tree>
</next:Panel>
</next:ViewPort>
</body>
</html>
