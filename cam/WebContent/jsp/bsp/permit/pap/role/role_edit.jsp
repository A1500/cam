
<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<%@page import="org.loushang.bsp.util.BspConfig"%>
<%@page import="org.loushang.bsp.util.uuid.UUIDGenerator"%>
<html>
	<head>
	<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
		<title><%=res.get("PUB_ROLE.TITLE")%></title>
		<next:ScriptManager/>
		<script>
			var delwith = '<%=request.getParameter("delwith")%>';
			var RES_PROMPT='<%=res.get("MSG.PROMOT")%>';
			var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
			var RES_TITLE='<%=res.get("TITLE")%>';
			var RES_UNKOWN_CMD='<%=res.get("MSG.UNKOWN_CMD")%>';
			var RES_UNVALIDATED= '<%=res.get("RES_UNVALIDATED")%>';
			var RES_SAVE='<%=res.get("MSG.SAVE")%>';
			var idField='<%=request.getParameter("primeKey")%>';
				idField = decodeURIComponent(idField);
			var method='<%=request.getParameter("method")%>';
			var struId = '<%=request.getParameter("struId")%>';
			var organName = ('<%=request.getParameter("organName")%>');
				organName = decodeURIComponent( organName );
			var roleGroupId = '<%=request.getParameter("roleGroupId")%>';
				roleGroupId = decodeURIComponent( roleGroupId );
			var roleGroupName = '<%=request.getParameter("roleGroupName")%>';
				roleGroupName = decodeURIComponent( roleGroupName );
			var prePage = '<%=request.getParameter("prePage")%>';
			if (method=="INSERT"){
				<%UUIDGenerator uuid = new UUIDGenerator();%>
				var newId = "<%=uuid.getNextSeqId(30)%>";
			}
		</script>
		<%
		    String permit_ext_jsfile_path=BspConfig.getString("authorization_jsfile_path");
		    if(permit_ext_jsfile_path==null ||"".equals(permit_ext_jsfile_path))
		    	permit_ext_jsfile_path= "../../../demo/permitext/permit_ext.js";
		%>
		<script type="text/javascript" src="role_edit.js"></script>
		<script type="text/javascript" src="<%=permit_ext_jsfile_path%>"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="roleDataset" pageSize="-1" global="true" >
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role" >
			<model:field name="organName" type="string"/>
			<model:field name="roleGroupName" type="string"/>
			<model:field name="inheritedRoles" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="inheritedRoleDataset" pageSize="-1" cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand" method="getUserAbleRoles" autoLoad="true" >
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel id="totalPanel"  border="false" autoScroll="true"  width="100%" height="100%" >
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem iconCls="save" id="saveBtn"  text='<%=res.get("BUT.SAVE.ALL")%>' handler="save"/>
	<next:ToolBarItem iconCls="undo" id="undoBtn" text='<%=res.get("BUT.UNDO.ALL")%>' handler="undo"/>
	<next:ToolBarItem iconCls="undo" id="backBtn" text='<%=res.get("PUB_DATA_TYPE.BACK")%>' handler="backToRoles"/>
</next:TopBar>
<next:TabPanel id="tabPanels" border="false">
<next:Tabs>
<next:Panel  title='<%=res.get("ROLE.BASEINFO")%>'  border="false" height="300">
	<next:Html>
		<form id="editForm" onsubmit="return false" dataset="roleDataset" class="L5form">
		<table    width="100%" >
			<tr>
				<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_ROLE.ROLE_ID")%></td>
				<td class="FieldInput"><input type="text" id="roleId" name=<%=res.get("PUB_ROLE.ROLE_ID")%> field="roleId" style="width:260" maxlength="30"/><font
				color="red">*</font>不能包含汉字</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_ROLE.ROLE_NAME")%></td>
				<td class="FieldInput"><input type="text" id="roleName" name=<%=res.get("PUB_ROLE.ROLE_NAME")%> field="roleName" style="width:260" maxlength="20"/><font
				color="red">*</font></td>
			</tr>
	   		<tr id="struTr" style="display:none">
				<td  class="FieldLabel" ><%=res.get("PUB_ROLE.RELATION_ID")%></td>
				<td class="FieldInput"><input  type="text" name=<%=res.get("PUB_ROLE.RELATION_ID")%> field="organName"  style="width:260" disabled="disabled" />
				</td>
			</tr>
			<tr id="roleGroupTr" style="display:none">
				<td  class="FieldLabel" ><%=res.get("PUB_ROLE.ROLE_GROUP_ID")%></td>
				<td class="FieldInput"><input type="text" name=<%=res.get("PUB_ROLE.ROLE_GROUP_ID")%> field="roleGroupName" style="width:260" disabled="disabled" />
				</td>
			</tr>
			<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_ROLE.DESCRIPTION")%></td>
				<td class="FieldInput" rowspan="4"><textarea  id="discription" name=<%=res.get("PUB_ROLE.DESCRIPTION")%> field="discription" rows="3" cols="80" ></textarea></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
<next:Panel id="menu_permit" title='<%=res.get("ROLE.MENU_PERMIT")%>'  autoHeight="true" border="false" >
	<next:Html>
		<next:Tree name="menupermittree" id="menupermittree"  autoScroll="true" height="100%" lines="true" border="false" >
		<next:TreeDataSet dataset="menu_tree_dataset" root="menuRootData">
			<next:TreeLoader cmd="org.loushang.bsp.permit.pap.role.cmd.RolePermitTreeQuery" method="getMenuPermitTree" >
				<next:treeRecord name="menuTreeRecord" idField="treeMenuStruId" >
					<model:field name="treeMenuStruId" type="string"/>
					<model:field name="treeId" type="string"/>
					<model:field name="treeName" type="string"/>
					<model:field name="treeType" type="string"/>
					<model:field name="isLeafMenu" type="string"/>
					<model:field name="treeState" type="string"/>
					<model:field name="operation_flag" type="string" defaultValue="0"/>
				</next:treeRecord>
				<next:TreeBaseparam name="treeType" value="getTreeType"/>
				<next:TreeBaseparam name="treeId" value="getTreeId"/>
				<next:TreeBaseparam name="treeMenuStruId" value="getTreeMenuStruId"/>
				<next:TreeBaseparam name="isLeafMenu" value="getIsLeafMenu"/>
				<next:TreeBaseparam name="roleId" value="getRoleId"/>
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="menuTreeRecord">
			<next:TreeNodeAttribute name="text" mapping="treeName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getShowType"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="checked" handler="getChecked"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
		<next:Listeners>
			<next:Listener eventName="checkchange" handler="eachClick">
			</next:Listener>
		</next:Listeners>
	</next:Tree>
	</next:Html>
</next:Panel>

<next:Panel  id="function_permit" title='<%=res.get("ROLE.FUNCTION")%>'  autoHeight="true" border="false" >

	<next:Html>

		<next:Tree name="functiontree" id="functiontree" autoScroll="true" height="100%" lines="true" border="false" >

		<next:TreeDataSet dataset="function_tree_dataset" root="rootdata">
			<next:TreeLoader cmd="org.loushang.bsp.permit.pap.role.cmd.RolePermitTreeQuery" >
				<next:treeRecord name="treeRecord" idField="treeId" >
					<model:field name="treeId" type="string"/>
					<model:field name="treeName" type="string"/>
					<model:field name="treeType" type="string"/>
					<model:field name="treeState" type="string"/>
					<model:field name="operation_flag" type="string" defaultValue="0"/>
				</next:treeRecord>
				<next:TreeBaseparam name="treeType" value="getTreeType"/>
				<next:TreeBaseparam name="treeId" value="getTreeId"/>
				<next:TreeBaseparam name="roleId" value="getRoleId"/>
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="treeRecord">
			<next:TreeNodeAttribute name="text" mapping="treeName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getShowType"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="checked" handler="getChecked"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
		<next:Listeners>
			<next:Listener eventName="checkChange" handler="eachClick">
			</next:Listener>
		</next:Listeners>
	</next:Tree>
	</next:Html>
</next:Panel>
<next:Panel id="roleEditPanel" title='<%=res.get("ROLE.INHERIT")%>'
  border="false" anchor="100% 100%">
	<next:Html >
		<form  onsubmit="return false" dataset="roleDataset"  class="L5form">
		<input type="hidden" systype="itemselector"  id="inheritRolecmp"  field="inheritedRoles">
		<div  id="inheritRoleDiv">
		</div>
		</form>
	</next:Html>
</next:Panel>
</next:Tabs>
</next:TabPanel>
</next:Panel>
</next:ViewPort>
</body>
</html>
