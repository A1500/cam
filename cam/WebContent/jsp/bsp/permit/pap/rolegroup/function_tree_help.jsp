
<script type="text/javascript" src="function_tree_help.js"></script>
<next:Tree name="functiontree" id="functiontree" width="100%"  height="100%" lines="true" border="false" autoScroll="true">
		<next:TreeDataSet dataset="function_tree_dataset" root="rootdata">
			<next:TreeLoader cmd="org.loushang.bsp.permit.pap.function.cmd.RolePermitTreeQuery" >
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
		</next:TreeNodemodel>
		<next:Listeners>
			<next:Listener eventName="checkchange" handler="eachClick">
			</next:Listener>
		</next:Listeners>
	</next:Tree>