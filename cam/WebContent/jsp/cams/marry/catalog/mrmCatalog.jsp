<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>证明材料目录维护</title>
<next:ScriptManager/>
<script type="text/javascript" src="mrmCatalog.js"></script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<model:dataset id="mrmCatalogDataset" cmd="com.inspur.cams.marry.base.cmd.MrmCatalogQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmCatalog"></model:record>
	</model:dataset>
	<%--定义字典表--%>
	<model:dataset id="catalogDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:ViewPort>
<next:BorderLayout>
<next:Left split="true" cmargins="50 0 0 0" margins="5 0 0 0" >
<next:Panel title="证明材料目录" collapsible="true" width="30%" autoScroll="true">
	<next:Tree name="mrmCatalogtree" id="mrmCatalogtree" collapsible="true" width="100%" height="550" autoScroll="true" lines="true">
		<next:TreeDataSet dataset="mrmCatalogDataSet" root="rootdata">
			<next:TreeLoader cmd="com.inspur.cams.marry.base.cmd.MrmCatalogQueryCmd" >
				<next:treeRecord name="mrmCatalogRecord" idField="catalogCode">
					<model:field name="catalogCode" type="string"/>	
					<model:field name="catalogName" type="string"/>	
					<model:field name="applyType" type="string"/>	
					<model:field name="upCatalogCode" type="string"/>	
					<model:field name="catalogOrder" type="string"/>	
		   			<model:field name="ifValid" type="string"/>	
		   			<model:field name="catalogLevel" type="string"/>	
		   			<model:field name="fileCode" type="string"/>
				</next:treeRecord>
			<next:TreeBaseparam name="UP_CATALOG_CODE@=" value="getParent"/>
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="mrmCatalogRecord">
		<next:TreeNodeAttribute name="text" mapping="catalogName"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="disabled" handler="getMrmCatalogdisabled"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
		<next:RightmouseMenu menuId="mrmCatalog">
			<next:MenuItem text="添加" handler="addMrmCatalog"></next:MenuItem>
			<next:MenuItem text="修改" handler="updateMrmCatalog"></next:MenuItem>
			<next:MenuItem text="删除" handler="delMrmCatalog"></next:MenuItem>
		</next:RightmouseMenu>
		<next:Listeners>
			<next:Listener eventName="selected" handler="selectedMrmCatalog"></next:Listener>
		</next:Listeners>
	</next:TreeNodemodel>
</next:Tree>
</next:Panel>
</next:Left>
<next:Center floatable="true" margins="5 0 0 0">
<next:Panel>
<next:Panel id="detailPanel" name="detailPanel" hidden="true">
<next:Html>
<div id="mrmCatalog_detail" dataset="mrmCatalogDataset">
<form class="L5form">
	<table style="width:100%">
		<tr>
			<td class="FieldLabel" style="width:25%">证明材料目录:</td>
			<td class="FieldInput" style="width:25%" colspan="3"><label id="catalogName" field="catalogName"></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:25%">上级目录:</td>
			<td class="FieldInput" style="width:25%"><label field="upCatalogCode" dataset="catalogDataSet"/></td>
			<td class="FieldLabel" style="width:25%">是否有效:</td>
			<td class="FieldInput" style="width:25%"><label field="ifValid" dataset="yesornoDataSet"></td>
		</tr>
		<tr>
			<td class="FieldLabel">目录次序:</td>
			<td class="FieldInput"><label field="catalogOrder"></td>
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
		<div id="mrmCatalog_update" dataset="mrmCatalogDataset">
			<form class="L5form">
				<table style="width:100%">
					<tr>
	   					<td class="FieldLabel" style="width:25%">证明材料目录:</td>
						<td class="FieldInput" style="width:25%" colspan="3"><input type="text" id="catalogName" field="catalogName" style="width:98%"></td>
	   				</tr>
					<tr>
				   		<td class="FieldLabel" style="width:25%">上级目录:</td>
						<td class="FieldInput" style="width:25%"><label id="upCatalogCode" field="upCatalogCode" dataset="catalogDataSet"/></td>
				   		<td class="FieldLabel" style="width:25%">是否有效:</td>
						<td class="FieldInput" style="width:25%">
							<select id="ifValid" field="ifValid" >
								<option dataset="yesornoDataSet"></option>
							</select>
						</td>
				   	</tr>
	   				<tr>
	   					<td class="FieldLabel">目录次序:</td>
						<td class="FieldInput"><label id="catalogOrder" field="catalogOrder"/></td>
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