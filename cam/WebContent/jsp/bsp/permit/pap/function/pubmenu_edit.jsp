
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
	<head>
		<title><%=res.get("PUB_MODULES.TITLE")%></title>
		<next:ScriptManager/>
		<script>
			var method='<%=request.getParameter("method")%>';
			var moduleCode='<%=request.getParameter("moduleCode")%>';
			var modulePrexx = moduleCode.substring(0,moduleCode.indexOf('000'));
		</script>
		<script type="text/javascript" src="pubmenu_edit.js"></script>
	</head>
<body>
<model:datasets>
<!--	菜单项	-->
	<model:dataset id="menuItemDataSet" cmd="com.inspur.cams.comm.menuconfig.cmd.CustomMenuItemQueryCmd" 
	 	method="queryMenuItem" global="true" pageSize="-1">
		<model:record fromBean="org.loushang.bsp.permit.menu.data.MenuItem">
		</model:record>
	</model:dataset>
<!--	菜单关系-不含个性化菜单	-->
	<model:dataset id="menuStruDataSet" cmd="com.inspur.cams.comm.menuconfig.cmd.CustomMenuItemQueryCmd" 
	 	method="queryMenuStru" global="true" pageSize="-1">
		<model:record fromBean="org.loushang.bsp.permit.menu.data.MenuItem">
		</model:record>
	</model:dataset>
<!--	菜单类型	-->
	<model:dataset id="menuTypeDataSet"  pageSize="65535"
		cmd="org.loushang.bsp.permit.menu.cmd.MenuTypeQueryCmd" global="true" >
		<model:record fromBean="org.loushang.bsp.permit.menu.data.MenuType">
	 		<model:field name="value" mapping="menuTypeId" type="string" />
			<model:field name="text" mapping="menuTypeName" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort><next:AnchorLayout>
<next:Panel  title='菜单主键校正'  border="false" anchor="100% 99%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text='校正' handler="save"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" onsubmit="return false" class="L5form">
		<table   width="100%" >
	   		<tr>
				<td class="FieldLabel" style="width:15%" >默认主键前缀</td>
				<td class="FieldInput"><input type="text" id="moduleCodePrexx" /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >需要校正菜单项个数</td>
				<td class="FieldInput"><label id="maxNumItem"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >需要校正菜单关系个数</td>
				<td class="FieldInput"><label id="maxNumStru"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >同步个性化菜单</td>
				<td class="FieldInput"><select id="menuConfig" name="同步个性化菜单" style="width: 200px">
											<option dataset=menuTypeDataSet></option>
										</select></td>
			</tr>
			<tr>
				<td colspan="2" class="FieldInput" align="left">
				<font color="red">
					<p>本页面功能：</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;因菜单项和菜单关系使用最大号表，难以移植，故使用此功能校正主键。</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;校正方式：原最大号前加所属子系统标识。</p>
					<p>&nbsp;&nbsp;&nbsp;&nbsp;校正力度：所选子系统下的所有菜单项、所选子系统下的所有菜单关系（包含个性化菜单）。</p>
				</font></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout> </next:ViewPort>
</body>
</html>
