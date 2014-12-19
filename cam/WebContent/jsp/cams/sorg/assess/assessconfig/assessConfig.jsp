<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>社会组织评估配置树</title>
<next:ScriptManager/>
<script>
	var type='<%=request.getParameter("type")%>';
	var typeDesc='<%=request.getParameter("typeDesc")%>';
	var id='<%=request.getParameter("id")%>';
	typeDesc=decodeURIComponent(typeDesc);
</script>
<script type="text/javascript" src="assessConfig.js"></script>
</head>
<body oncontextmenu=window.event.returnValue=false>
<%--定义dataset--%>
<model:datasets>
	<model:dataset id="SomAssessConfigDataset" cmd="com.inspur.cams.sorg.assess.assessconfig.cmd.SomAssessConfigQueryCommand" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig">
			<model:field name="assessContent" type="string" rule="require|length{500}" />
			<model:field name="seq" type="string" rule="length{3}" />
			<model:field name="configLevel" type="string" rule="length{1}" />
			<model:field name="fontSize" type="string" rule="length{10}" />
			<model:field name="fontStyle" type="string" rule="length{25}" />
			<model:field name="assessScore" type="string" rule="length{3}" />
		</model:record>
	</model:dataset>
	<model:dataset id="SomAssessConfigTreeDataset" cmd="com.inspur.cams.sorg.assess.assessconfig.cmd.SomAssessConfigQueryCommand" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig"></model:record>
	</model:dataset>
	<%--定义字典表--%>
	<model:dataset id="DicSomAssessConfigDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ASSESS_CONFIG'></model:param>
			<model:param name="value" value='CONFIG_ID'></model:param>
			<model:param name="text" value='ASSESS_CONTENT'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="assessTypeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ASSESS_TYPE'></model:param>
			<model:param name="value" value='TYPE'></model:param>
			<model:param name="text" value='TYPE_DESC'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="archiveStageDataSet" enumName="SOM.ARCHIVE_STAGE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:ViewPort>
<next:BorderLayout>
<next:Left split="true" cmargins="50 0 0 0" margins="5 0 0 0" >
<next:Panel title="社会组织评估配置树" collapsible="true" width="40%">
	<next:Tree name="SomAssessConfigtree" id="SomAssessConfigtree" collapsible="true" width="100%" height="550" autoScroll="true" lines="true">
		<next:TreeDataSet dataset="SomAssessConfigTreeDataset" root="rootdata">
			<next:TreeLoader cmd="com.inspur.cams.sorg.assess.assessconfig.cmd.SomAssessConfigQueryCommand" >
				<next:treeRecord name="SomAssessConfigRecord" idField="configId">
					<model:field name="configId" type="string"/>	
   					<model:field name="configLevel" type="string"/>	
   					<model:field name="assessType" type="string"/>	
   					<model:field name="seq" type="string"/>	
   					<model:field name="assessContent" type="string"/>	
   					<model:field name="assessScore" type="string"/>	
   					<model:field name="upId" type="string"/>	
   					<model:field name="fontSize" type="string"/>	
   					<model:field name="fontStyle" type="string"/>	
   					<model:field name="ifMakeScore" type="string"/>	
   					<model:field name="ifValid" type="string"/>	
				</next:treeRecord>
			<next:TreeBaseparam name="UP_ID@=" value="getParent"/>
			<next:TreeBaseparam name="ASSESS_TYPE@=" value="getType"/>
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="SomAssessConfigRecord">
		<next:TreeNodeAttribute name="text" mapping="assessContent"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="disabled" handler="getSomAssessConfigdisabled"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
		<next:RightmouseMenu menuId="somAssessConfig">
			<next:MenuItem text="添加" handler="addSomAssessConfig"></next:MenuItem>
			<next:MenuItem text="修改" handler="updateSomAssessConfig"></next:MenuItem>
			<next:MenuItem text="删除" handler="delSomAssessConfig"></next:MenuItem>
		</next:RightmouseMenu>
		<next:Listeners>
			<next:Listener eventName="selected" handler="selectedSomAssessConfig"></next:Listener>
		</next:Listeners>
	</next:TreeNodemodel>
</next:Tree>
</next:Panel>
</next:Left>
<next:Center floatable="true" margins="5 0 0 0">
<next:Panel>
<next:Panel id="detailPanel" title="档案名称" name="detailPanel" hidden="true">
<next:Html>
<div id="somAssessConfig_detail" dataset="SomAssessConfigDataset">
<form class="L5form">
	<table style="width:100%">
		<tr>
			<td class="FieldLabel" style="width:25%">评估类型:</td>
			<td class="FieldInput" style="width:25%"><label id="assessType" field="assessType" dataset="assessTypeDataSet"></td>
			<td class="FieldLabel" style="width:25%">顺序号:</td>
			<td class="FieldInput" style="width:25%"><label id="seq" field="seq"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:25%">分数:</td>
			<td class="FieldInput" style="width:25%"><label id="assessScore" field="assessScore"/> 分</td>
			<td class="FieldLabel" style="width:25%"></td>
			<td class="FieldInput" style="width:25%"></td>
		</tr>
		<tr>
			<td class="FieldLabel">评估内容:</td>
			<td class="FieldInput" colspan="5"><textarea rows="5" name='评估内容' field="assessContent" style="width:98%" readonly></textarea><span style="color:red">*</span>
			</td>
	   	</tr>
		<tr>
			<td class="FieldLabel">上级目录:</td>
			<td class="FieldInput"><label id="upId" field="upId" dataset="DicSomAssessConfigDataSet"/></td>
			<td class="FieldLabel">级数:</td>
			<td class="FieldInput"><label id="configLevel" field="configLevel"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">字体:</td>
			<td class="FieldInput"><label id="fontStyle" field="fontStyle" /></td>
			<td class="FieldLabel">字体大小:</td>
			<td class="FieldInput"><label id="fontSize" field="fontSize"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">是否打分:</td>
			<td class="FieldInput"><label id="ifMakeScore" field="ifMakeScore" dataset="yesornoDataSet"/></td>
			<td class="FieldLabel">是否有效:</td>
			<td class="FieldInput"><label id="ifValid" field="ifValid" dataset="yesornoDataSet"/></td>
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
		<div id="somAssessConfig_update" dataset="SomAssessConfigDataset">
			<form class="L5form">
				<table style="width:100%">
					<tr>
	   					<td class="FieldLabel" style="width:25%">评估类型:</td>
						<td class="FieldInput" style="width:25%"><label id="assessType" field="assessType" dataset="assessTypeDataSet"></td>
	   					<td class="FieldLabel" style="width:25%">顺序号:</td>
						<td class="FieldInput" style="width:25%"><input id="seq" field="seq" /></td>
	   				</tr>
	   				<tr>
	   					<td class="FieldLabel">分数:</td>
						<td class="FieldInput"><input id="assessScore" field="assessScore" /> 分</td>
				   		<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
				   	</tr>
					<tr>
	   					<td class="FieldLabel">评估内容:</td>
						<td class="FieldInput" colspan="5"><textarea rows="5" name='评估内容' field="assessContent" style="width:98%"></textarea>
						</td>
				   	</tr>
				   	<tr>
				   		<td class="FieldLabel">上级目录:</td>
						<td class="FieldInput"><label id="upId" field="upId" dataset="DicSomAssessConfigDataSet"/></td>
						<td class="FieldLabel">级数:</td>
						<td class="FieldInput"><input id="configLevel" field="configLevel" /></td>
				   	</tr>
				   	<tr>
						<td class="FieldLabel">字体:</td>
						<td class="FieldInput"><input id="fontStyle" field="fontStyle" /></td>
						<td class="FieldLabel">字体大小:</td>
						<td class="FieldInput"><input id="fontSize" field="fontSize"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">是否打分:</td>
						<td class="FieldInput">
							<select id="ifMakeScore" field="ifMakeScore" >
								<option dataset="yesornoDataSet"></option>
							</select>
						</td>
				   		<td class="FieldLabel">是否有效:</td>
						<td class="FieldInput">
							<select id="ifValid" field="ifValid" >
								<option dataset="yesornoDataSet"></option>
							</select>
						</td>
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