<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style type="text/css">
	.center{
		position: relative;
		top: 40%;
		left:0;
	}
	</style>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
		var res = {};
		 res.RES_NEWTEXT='<%=res.get("MSG.TREE_NEW")%>';
		 res.PROMPT_WORD='<%=res.get("MSG.PROMPT_WORD")%>';
		 res.REMOVE_WORD='<%=res.get("MSG.REMOVE_WORD")%>';
		 res.REMOVE_OK = '<%=res.get("MSG.REMOVE_OK")%>';
		 res.NO_CHANGE = '<%=res.get("MSG.NO_CHANGE")%>';
		 res.SAVE_OK ='<%=res.get("MSG.SAVE_OK")%>';
		res.TREE_ROOTDATA_SETNAME='<%=res.get("TREE.ROOTDATA_SETNAME")%>';
		res.WARN_CARDINALITY_SMALL='<%=res.get("MSG.WARN_CARDINALITY_SMALL")%>';
		res.WARN_CARIDNALITY_INVALID='<%=res.get("MSG.WARN_CARDINALITY_INVALID")%>';
		res.WARN_CARDINALITY_BAD_ROLE_COUNT='<%=res.get("MSG.WARN_CARDINALITY_BAD_ROLE_COUNT")%>';
	</script>
<script type="text/javascript" src="confroleset_tree.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="role_dataset"  pageSize="10" cmd="org.loushang.bsp.permit.pap.role.cmd.RoleQueryCommand" method="getUserAbleRoles"   global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role"></model:record>
	</model:dataset>
	<model:dataset id="confrole_dataset"  pageSize="-1" cmd="org.loushang.bsp.permit.pap.confrole.cmd.ConfRoleQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.confrole.dao.ConfRole"></model:record>
	</model:dataset>
	<model:dataset id="confroleset_dataset"   cmd="org.loushang.bsp.permit.pap.confrole.cmd.ConfRoleSetQueryCommand"   global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.confrole.dao.ConfRoleSet"></model:record>
	</model:dataset>
</model:datasets>
	<next:ViewPort>
	<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0 0" margins="5 0 0 0">
	<next:Panel title='<%=res.get("CONF_ROLE_SET")%>' width="20%" collapsible="true">
	<next:Tree autoScroll="true" id="rolesetTree" >
	<next:TreeDataSet root="page.rootdata" dataset="confroleset_tree_dataset">
		<next:TreeLoader cmd="org.loushang.bsp.permit.pap.confrole.cmd.ConfRoleSetQueryCommand" trigger="endLoader" >
				<next:treeRecord name="rootType" idField="setId" fromBean="org.loushang.bsp.permit.pap.confrole.dao.ConfRoleSet">
   				</next:treeRecord>
			<next:TreeBaseparam name="CORPORATION_ID@like" value="anything"/>
		</next:TreeLoader>
	</next:TreeDataSet>
		<next:TreeNodemodel  recordType="rootType">
		<next:TreeNodeAttribute name="text" mapping="setName"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
		<next:RightmouseMenu menuId="menu1">
					<next:MenuItem text='<%=res.get("BUT.ADD")%>' handler="addset"></next:MenuItem>
		</next:RightmouseMenu>
		<next:RightmouseMenu menuId="menu2" trigger="isRoleset" >
					<next:MenuItem text='<%=res.get("BUT.REMOVE")%>' handler="removeset"></next:MenuItem>
		</next:RightmouseMenu>
		<next:Listeners>
			<next:Listener eventName="selected" handler="showDetail"></next:Listener>
	   </next:Listeners>
		</next:TreeNodemodel>
	</next:Tree>
	</next:Panel>
	</next:Left>
	<next:Center floatable="true" margins="5 0 0 0">
	<next:Panel id="rightPan" hidden="true"  border="10">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="submit" text='<%=res.get("SAVE")%>' handler="saveAll"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
		<br/>
		<div id="rsdetail" >
		<form class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel"><%=res.get("ROLE_SET_NAME")%></td>
				<td class="FieldInput"><input id="setName" type="text" size="60" field="setName" onchange="watcher(this,'setName')"/><font color="red">*</font></td>
				<td class="FieldLabel"><%=res.get("CARDINALITY")%></td>
				<td class="FieldInput"><input id="cardinality" type="text" size="10" field="cardinality" onchange="watcher(this,'cardinality')"/><font color="red">*(<%=res.get("CARDINALITY_COMMENT")%>)</font></td>
			</tr>
		</table></form>
		</div>

	</next:Html>
	<next:ColumnLayout >
		<next:GridPanel columnWidth=".45" id="avaiableRoleGrid" name="avaiableRoleGridName"
		 dataset="role_dataset" height="280" >
		 <next:ExtendConfig>
						tbar:[
						{text: '<%=res.get("ROLE")%>'},
                    	{xtype: 'textfield',id: 'roleNameParameter',style:'width:90px;'},
                    	
						{iconCls:'common-query',text:'<%=res.get("QUERY")%>',handler:queryRole}
						]
				</next:ExtendConfig>
			<next:Columns>
				<next:Column fixed="true" header='<%=res.get("ROLE_LIST")%>' id="roleName" field="roleName" renderer="roleNameRender" width="100%" ></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="role_dataset" displayInfo="false"></next:PagingToolBar>
			</next:BottomBar>
		</next:GridPanel>
		<next:Panel height="300" columnWidth=".06">
			<next:Html>
				<div class="center">
				<input type="button" value="&gt;&gt;" onclick="addConfRole()"></input>
				<br/><br/>
				<input type="button" value="&lt;&lt;" onclick="removeConfRole()"></input>
				</div>
			</next:Html>
		</next:Panel>
		<next:GridPanel columnWidth=".45" id="selectedConfRole" name="selectedConfRoleName" dataset="confrole_dataset" height="300">
		
		<next:Columns >
				<next:Column header='<%=res.get("CONF_ROLE_LIST")%>' field="roleName" width="100%" ></next:Column>
			</next:Columns>
		</next:GridPanel>
	</next:ColumnLayout>
</next:Panel>
</next:Center>
</next:BorderLayout>
</next:ViewPort>
</body>
</html>