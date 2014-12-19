
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>

<title>优抚对象类别</title>
<script type="text/javascript" src="dicobjecttype.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicObjecttype_detaildataset" global="true">
		<model:record fromBean="com.inspur.cams.bpt.dicobjecttype.dao.DicObjecttype"></model:record>
	</model:dataset>
</model:datasets>

		<next:Panel title="优抚对象类别" width="100%" autoScroll="true" >
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
		</next:TopBar>
			<next:Tree name="dicObjecttypetree" rootExpanded="true" rootVisible="true" id="dicObjecttypetree" collapsible="true" height="100%" lines="true">
				<next:TreeDataSet dataset="dicObjecttypeDataSet" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.bpt.dicobjecttype.cmd.DicObjecttypeQueryCommand">
						<next:treeRecord name="dicObjecttypeRecord" idField="typeId">
		  					
		   					<model:field name="typeId" type="string"/>	
		   					<model:field name="typeName" type="string"/>	
		   					<model:field name="typeOrganId" type="string"/>	
		   					<model:field name="typeParentId" type="string"/>	
		   					<model:field name="typeOrder" type="string"/>	
						</next:treeRecord>
						<next:TreeBaseparam name="TYPE_PARENT_ID@=" value="getParent"/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="dicObjecttypeRecord">
					<next:TreeNodeAttribute name="showType" handler="'checkbox'" ></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="text" mapping="typeName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getDicObjecttypedisabled"></next:TreeNodeAttribute>

				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
</body>
</html>
