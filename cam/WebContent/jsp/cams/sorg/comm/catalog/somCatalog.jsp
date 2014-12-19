<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>SOM_CATALOG</title>
<next:ScriptManager/>
<script type="text/javascript" src="somCatalog.js"></script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<model:dataset id="somCatalogDataset" cmd="com.inspur.cams.sorg.base.cmd.SomCatalogQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCatalog"></model:record>
	</model:dataset>
	<%--定义字典表--%>
	<model:dataset id="catalogDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgTypeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="applyTypeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_APPLY_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="archiveStageDataSet" enumName="SOM.ARCHIVE_STAGE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:ViewPort>
<next:BorderLayout>
<next:Left split="true" cmargins="50 0 0 0" margins="5 0 0 0" >
<next:Panel title="电子档案目录" collapsible="true" width="30%" autoScroll="true">
	<next:Tree name="somCatalogtree" id="somCatalogtree" collapsible="true" width="100%" height="550" autoScroll="true" lines="true">
		<next:TreeDataSet dataset="somCatalogDataSet" root="rootdata">
			<next:TreeLoader cmd="com.inspur.cams.sorg.base.cmd.SomCatalogQueryCmd" >
				<next:treeRecord name="somCatalogRecord" idField="catalogCode">
					<model:field name="catalogCode" type="string"/>	
					<model:field name="catalogName" type="string"/>	
					<model:field name="sorgType" type="string"/>	
					<model:field name="applyType" type="string"/>	
					<model:field name="upCatalogCode" type="string"/>	
					<model:field name="catalogOrder" type="string"/>	
		   			<model:field name="ifValid" type="string"/>	
		   			<model:field name="catalogLevel" type="string"/>	
		   			<model:field name="archiveStage" type="string"/>	
		   			<model:field name="fileCode" type="string"/>
		   			<model:field name="relatingFileCode" type="string"/>
				</next:treeRecord>
			<next:TreeBaseparam name="UP_CATALOG_CODE@=" value="getParent"/>
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="somCatalogRecord">
		<next:TreeNodeAttribute name="text" mapping="catalogName"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="disabled" handler="getSomCatalogdisabled"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
		<next:RightmouseMenu menuId="somCatalog">
			<next:MenuItem text="添加" handler="addSomCatalog"></next:MenuItem>
			<next:MenuItem text="修改" handler="updateSomCatalog"></next:MenuItem>
			<next:MenuItem text="删除" handler="delSomCatalog"></next:MenuItem>
		</next:RightmouseMenu>
		<next:Listeners>
			<next:Listener eventName="selected" handler="selectedSomCatalog"></next:Listener>
		</next:Listeners>
	</next:TreeNodemodel>
</next:Tree>
</next:Panel>
</next:Left>
<next:Center floatable="true" margins="5 0 0 0">
<next:Panel>
<next:Panel id="detailPanel" title="档案名称" name="detailPanel" hidden="true">
<next:Html>
<div id="somCatalog_detail" dataset="somCatalogDataset">
<form class="L5form">
	<table style="width:100%">
		<tr>
			<td class="FieldLabel" style="width:25%">业务:</td>
			<td class="FieldInput" style="width:25%"><label id="catalogName" field="catalogName"></td>
			<td class="FieldLabel" style="width:25%">社会组织种类:</td>
			<td class="FieldInput" style="width:25%"><label id="sorgType" field="sorgType" dataset="sorgTypeDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">业务种类:</td>
			<td class="FieldInput"><label field="applyType" dataset="applyTypeDataSet"/></td>
			<td class="FieldLabel">上级目录:</td>
			<td class="FieldInput"><label field="upCatalogCode" dataset="catalogDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">法律要件上传阶段:</td>
			<td class="FieldInput"><label field="archiveStage" dataset="archiveStageDataSet"></td>
			<td class="FieldLabel">是否有效:</td>
			<td class="FieldInput"><label field="ifValid" dataset="yesornoDataSet"></td>
		</tr>
		<tr>
			<td class="FieldLabel">目录次序:</td>
			<td class="FieldInput"><label field="catalogOrder"></td>
			<td class="FieldLabel">文件类型：</td>
			<td class="FieldInput"><label field="fileCode"></td>
		</tr>
		<tr>
			<td class="FieldLabel">关联文件类型:</td>
			<td class="FieldInput"><label field="relatingFileCode"></td>
			<td class="FieldLabel"></td>
			<td class="FieldInput"></td>
		</tr>
	</table>
</form>
</div>
</next:Html>
</next:Panel>
<next:Panel id="updatePanel" name="updatePanel" hidden="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="saveButoon" iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<div id="somCatalog_update" dataset="somCatalogDataset">
			<form class="L5form">
				<table style="width:100%">
					<tr>
	   					<td class="FieldLabel" style="width:25%">档案文件名:</td>
						<td class="FieldInput" style="width:25%"><input type="text" id="catalogName" field="catalogName" style="width:98%"></td>
	   					<td class="FieldLabel" style="width:25%">社会组织种类:</td>
						<td class="FieldInput" style="width:25%"><label id="sorgType" field="sorgType" dataset="sorgTypeDataSet"/></td>
	   				</tr>
					<tr>
	   					<td class="FieldLabel">业务种类:</td>
						<td class="FieldInput"><label id="applyType" field="applyType" dataset="applyTypeDataSet"/></td>
				   		<td class="FieldLabel">上级目录:</td>
						<td class="FieldInput"><label id="upCatalogCode" field="upCatalogCode" dataset="catalogDataSet"/></td>
				   	</tr>
					<tr>
						<td class="FieldLabel">法律要件上传阶段:</td>
						<td class="FieldInput">
							<select id="archiveStage" field="archiveStage" >
								<option dataset="archiveStageDataSet"></option>
							</select>
						</td>
				   		<td class="FieldLabel">是否有效:</td>
						<td class="FieldInput">
							<select id="ifValid" field="ifValid" >
								<option dataset="yesornoDataSet"></option>
							</select>
						</td>
	   				</tr>
	   				<tr>
	   					<td class="FieldLabel">目录次序:</td>
						<td class="FieldInput"><label id="catalogOrder" field="catalogOrder"/></td>
	   					<td class="FieldLabel">文件类型：</td>
						<td class="FieldInput"><input type="text" id="fileCode" field="fileCode"></td>
					</tr>
					<tr>
	   					<td class="FieldLabel">关联文件类型:</td>
						<td class="FieldInput"><input type="text" id="relatingFileCode" field="relatingFileCode"></td>
	   					<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
				</table>
			</form>
		</div>
	</next:Html>
</next:Panel>
</next:Panel>
</next:Center>
</next:BorderLayout>
</next:ViewPort>
</body>
</html>