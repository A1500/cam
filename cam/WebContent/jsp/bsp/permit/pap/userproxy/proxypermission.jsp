<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>

<body>
	<next:Tabs>
	<next:Panel title="基本信息"  autoScroll="true">
		<next:Html >
			<form dataset="proxyPermissionDst"  class="L5form">
				<table width="100%">
					<tr ><td class="FieldLabel">委托项名称</td><td class="FieldInput"><input id="proxyPermissionName" name="proxyPermissionName" field="proxyPermissionName" maxlength="60"/><font color="red">*</font></td></tr>
					<tr><td class="FieldLabel">描述</td><td class="FieldInput"><textarea cols="120" rows="3" field="note"></textarea></td></tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel id="roleEditPanel" title='<%=res.get("PROXY.ROLE")%>' autoScroll="true">
		<next:Html>
			<form  onsubmit="return false" dataset="proxyRoleDataSet"  class="L5form">
			<input type="hidden" systype="itemselector"  id="grantRolecmp"  field="proxyRole">
			<div id="grantRoleDiv">
			</div>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel id="functionTab" title="委托事项" autoScroll="true">
		<next:Tree name="functiontree" id="functiontree" lines="true" border="false" autoScroll="true">
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
						<next:TreeBaseparam name="proxyPermitId" value="getProxyPermitId"/>
						<next:TreeBaseparam name="function" value="'proxy'"/>
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
					<next:Listener eventName="checkchange" handler="eachClick">
					</next:Listener>
				</next:Listeners>
			</next:Tree>
	</next:Panel>

	</next:Tabs>
</body>
