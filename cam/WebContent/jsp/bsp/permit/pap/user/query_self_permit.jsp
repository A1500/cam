
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title>我的权限</title>
<script type="text/javascript"></script>
<script type="text/javascript" src="query_self_permit.js"></script>
<next:ScriptManager />
</head>
<body>

<model:datasets>
	<model:dataset id="ds" pageSize="10"
		cmd="org.loushang.bsp.permit.pap.function.cmd.OperationQueryCommand"
		method="getFunctionAuthorities" global="true" autoLoad="true">
		<model:record
			fromBean="org.loushang.bsp.permit.pap.function.data.Operation">
		</model:record>
	</model:dataset>
	<model:dataset id="roleds" pageSize="10"
		cmd="org.loushang.bsp.permit.pap.role.cmd.RoleQueryCommand"
		method="getUserAbleRolesPage" global="true" autoLoad="true">
	</model:dataset>
</model:datasets>

<next:ViewPort>
<next:AnchorLayout>
<next:TabPanel name="tabpanel-div" height="100%" activeTab="0">
	
	<next:Tabs>
		<next:Panel title="我的角色">
			<next:Html>
				<next:GridPanel notSelectFirstRow="true" id="roleGridPanel" border="false" name="roleGrid" 
				 anchor="100% 70%" stripeRows="true" dataset="roleds" height="270">
					<next:Columns>
						<next:RowNumberColumn width="30" />
						<next:Column id="roleId" header="角色Id" field="ROLE_ID" width="220" >
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="roleName" header="角色名称" field="ROLE_NAME" width="180">
							<next:TextField allowBlank="false" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="roleds"/>
					</next:BottomBar>
				</next:GridPanel>
			</next:Html>
		</next:Panel>
		<next:Panel title="我的操作" >
			<next:Html>
				<next:GridPanel notSelectFirstRow="true" id="editGridPanel" border="false" name="operationGrid" 
				 anchor="100% 70%" stripeRows="true" dataset="ds" height="270">
					<next:Columns>
						<next:RowNumberColumn width="30" />
						<next:Column id="operationCode" header="操作编码" field="OPERATION_CODE" width="160" >
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="operationName" header="操作名称" field="OPERATION_NAME" width="180">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="functionCode" header="所属功能" field="FUNCTION_CODE" width="160" hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="ds"/>
					</next:BottomBar>
				</next:GridPanel>
			</next:Html>
		</next:Panel>
		
	</next:Tabs>
</next:TabPanel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>