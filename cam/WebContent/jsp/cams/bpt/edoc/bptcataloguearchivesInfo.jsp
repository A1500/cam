<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>优抚档案目录</title>
<script type="text/javascript" src="bptcataloguearchivesInfo.js"></script>
</head>
<body>

	
		<next:Panel title="优抚目录">
		    <next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="saveTree" />
				<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick" />
			</next:TopBar>
			<next:Tree name="bptCatalogueArchivestree" id="bptCatalogueArchivestree" height="550"  lines="true" autoScroll="true">
				<next:TreeDataSet dataset="bptCatalogueArchivesDataSet" root="rootdata" >
					<next:TreeLoader cmd="com.inspur.cams.bpt.manage.cmd.BptCatalogueArchivesQueryCommand" >
						<next:treeRecord name="bptCatalogueArchivesRecord" idField="catalogID">
						    <model:field name="catalogID" type="string"/>
		   					<model:field name="catalogCode" type="string"/>	
		   					<model:field name="catalogName" type="string"/>	
		   					<model:field name="upCatalogCode" type="string"/>	
		   					<model:field name="catalogInfo" type="string"/>	
		   					<model:field name="catalogOrder" type="string"/>	
		   					<model:field name="organId" type="string"/>	
		   					<model:field name="serviceType" type="string"/>
		   					<model:field name="leve" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="UP_CATALOG_CODE@=" value="getParent"/>
						<next:TreeBaseparam name="ORGAN_ID@=" value='370000000000'/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="bptCatalogueArchivesRecord">
					<next:TreeNodeAttribute name="text" mapping="catalogName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getBptCatalogueArchivesdisabled"></next:TreeNodeAttribute>
					
				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
	
</body>
</html>
