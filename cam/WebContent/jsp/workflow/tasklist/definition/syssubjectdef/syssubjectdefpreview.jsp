<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page
	import="org.loushang.workflow.tasklist.taskinfo.util.TaskListJspUtil"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryCommonHelpDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQuerySelectDef"%>

<html>
<head>
<style>
a {
	TEXT-DECORATION: none
}
</style>
<title>系统全局任务标题预览</title>
<next:ScriptManager></next:ScriptManager>
</head>
<%
	//待办任务标题
	List sysDaiBanSubjectDefList = TaskListJspUtil
			.getSysDaiBanTaskSubjectDefList();
	//已办任务标题
	List sysYiBanSubjectDefList = TaskListJspUtil
			.getSysYiBanTaskSubjectDefList();
	//办结任务标题
	List sysEndSubjectDefList = TaskListJspUtil
			.getSysEndTaskSubjectDefList();
	//待办任务查询条件定义
	List sysDaiBanSubjectQueryDefList = TaskListJspUtil
			.getSysDaiBanTaskSubjectQueryDefList();
	//已办任务查询条件定义
	List sysYiBanSubjectQueryDefList = TaskListJspUtil
			.getSysYiBanTaskSubjectQueryDefList();
	//办结任务查询条件定义
	List sysEndSubjectQueryDefList = TaskListJspUtil
			.getSysEndTaskSubjectQueryDefList();
	//通用帮助 
	List sysSubjectQueryCommonHelpDefList = TaskListJspUtil
			.getSysSubjectQueryCommonHelpDefList();
	//下拉框
	List sysSubjectQuerySelectDefList = TaskListJspUtil
			.getSysSubjectQuerySelectDefList();
%>
<body>

<model:datasets>
	<model:dataset pageSize="15" id="sysDaiBanSubjectPreviewDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd"
		autoLoad="true" method="previewSysSubjectDefDaiBanTask">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<%
				for (int i = 0; i < sysDaiBanSubjectDefList.size(); i++) {
								SysSubjectDef sysSubjectDef = (SysSubjectDef) sysDaiBanSubjectDefList
										.get(i);
			%>
			<model:field name="<%=sysSubjectDef.getSubjectKey()%>" type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysYiBanSubjectPreviewDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd"
		autoLoad="true" method="previewSysSubjectDefYiBanTask">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<%
				for (int i = 0; i < sysYiBanSubjectDefList.size(); i++) {
								SysSubjectDef sysSubjectDef = (SysSubjectDef) sysYiBanSubjectDefList
										.get(i);
			%>
			<model:field name="<%=sysSubjectDef.getSubjectKey()%>" type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysEndSubjectPreviewDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd"
		autoLoad="true" method="previewSysSubjectDefEndTask">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<%
				for (int i = 0; i < sysEndSubjectDefList.size(); i++) {
								SysSubjectDef sysSubjectDef = (SysSubjectDef) sysEndSubjectDefList
										.get(i);
			%>
			<model:field name="<%=sysSubjectDef.getSubjectKey()%>" type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysSubjectQuerySelectDefDataset"
	cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd"
	autoLoad="true" method="querySysSubjectQueryDef">
	</model:dataset>
</model:datasets>

<next:ViewPort>
<next:TabPanel name="tabpanel-div" height="590" activeTab="0" id="procTabs">
	<next:Defaults>
		{bodyStyle:'padding:15px;'}
	</next:Defaults>
	<next:Tabs>
		<next:Panel title="系统全局层次待办任务标题定义预览" id="daiBanTab">
			<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
			<next:Panel>
				<next:AnchorLayout>
					<next:Panel width="100%" border="0"
						bodyStyle="padding-bottom:10px;padding-top:0px;">
						<next:Html>
							<fieldset style="overflow: visible;" class="GroupBox">
							<legend class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils
																	.getImage(
																			request,
																			"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < sysDaiBanSubjectQueryDefList
																						.size(); i++) {
																					SysSubjectQueryDef sysSubjectQueryDef = (SysSubjectQueryDef) sysDaiBanSubjectQueryDefList
																							.get(i);
																					String sysSubjectKey = sysSubjectQueryDef
																							.getSubjectKey();
																					String sysSubjectAlias = sysSubjectQueryDef
																							.getSubjectAlias();
																					String sysSubField = sysSubjectQueryDef
																							.getSubjectFieldType();
																					if ("0"
																							.equals(sysSubField)
																							|| sysSubField == null) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=sysSubjectKey%>" class="TextEditor" title="<%=sysSubjectAlias%>" size="40" /></td>
									<%
										} else if ("1"
																							.equals(sysSubField)) {
									%>
									<td class="FieldLabel"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput">
									<select id="<%=sysSubjectKey%>">
									<option value="">请选择...</option>
									<%
										String optionValue;
																						String optionText;
																						for (int k = 0; k < sysSubjectQuerySelectDefList
																								.size(); k++) {
																							SysSubjectQuerySelectDef sysSubjectQuerySelectDef = (SysSubjectQuerySelectDef) sysSubjectQuerySelectDefList
																									.get(k);
																							String sujectQueryDefUniqueId = sysSubjectQuerySelectDef
																									.getSubjectQueryDefUniqueId();
																							if (sujectQueryDefUniqueId
																									.equals(sysSubjectQueryDef
																											.getId())) {
																								optionValue = sysSubjectQuerySelectDef
																										.getOptionValue();
																								optionText = sysSubjectQuerySelectDef
																										.getOptionText();
									%>
										<option value="<%=optionValue%>"><%=optionText%></option>
									<%
										}
																						}
									%>
									</select>
									</td>
									<%
										} else if ("3"
																							.equals(sysSubField)) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="startDate" class="TextEditor" title="开始日期" size="40" format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /> 至  <input type="text" id="endDate"class="TextEditor" title="结束日期" size="40"
										format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /></td>
									<%
										} else if ("4"
																							.equals(sysSubField)) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="startDateTime" class="TextEditor"
										title="开始时间" size="40" format="Ymd H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /> 至  <input type="text" id="endDateTime"
										class="TextEditor" title="结束时间" size="40"
										format="Ymd H:i:s" name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%
										} else if ("2"
																							.equals(sysSubField)) {
																						String dialogUrl;
																						String dialogWidth;
																						String dialogHeight;
																						String conditionUseWay;
																						int keyReturnIndex;
																						int aliasReturnIndex;
																						for (int j = 0; j < sysSubjectQueryCommonHelpDefList
																								.size(); j++) {
																							SysSubjectQueryCommonHelpDef sysSubjectQueryCommonHelpDef = (SysSubjectQueryCommonHelpDef) sysSubjectQueryCommonHelpDefList
																									.get(j);
																							String subjectQueryDefUniqueId = sysSubjectQueryCommonHelpDef
																									.getSubjectQueryDefUniqueId();
																							String conditionUseWayHidden = subjectQueryDefUniqueId
																									+ "returnvalue";//返回值id
																							String conditionUseWayShow = subjectQueryDefUniqueId
																									+ "returnshow";//返回显示值id
																							if (subjectQueryDefUniqueId
																									.equals(sysSubjectQueryDef
																											.getId())) {
																								dialogUrl = sysSubjectQueryCommonHelpDef
																										.getDialogUrl();
																								dialogWidth = sysSubjectQueryCommonHelpDef
																										.getDialogWidth();
																								dialogHeight = sysSubjectQueryCommonHelpDef
																										.getDialogHeight();
																								keyReturnIndex = sysSubjectQueryCommonHelpDef
																										.getKeyReturnIndex();
																								aliasReturnIndex = sysSubjectQueryCommonHelpDef
																										.getAliasReturnIndex();
																								conditionUseWay = sysSubjectQueryCommonHelpDef
																										.getConditionUseWay();
									%>
									<input type="hidden" id="<%=conditionUseWayHidden%>" class="TextEditor" value="" size="40" />
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=conditionUseWayShow%>" class="TextEditor" title="<%=sysSubjectAlias%>" value="" size="40" />
									<image src="<%=SkinUtils
																					.getImage(
																							request,
																							"l5/liulan.gif")%>" onclick="forCommonHelp('<%=conditionUseWayHidden%>','<%=conditionUseWayShow%>','<%=keyReturnIndex%>','<%=aliasReturnIndex%>','<%=dialogUrl%>','<%=dialogWidth%>','<%=dialogHeight%>')"/>
									</td>
									<%
										}
																						}
																					}
																					if (i % 2 == 1) {
																						if (i != sysDaiBanSubjectQueryDefList
																								.size() - 1) {
									%>
				                     	</tr>
				                     	<tr>
				                    	<%
				                    		}
				                    													}
				                    												}
				                    	%>
									<td class="FieldButton" width="15%">
									<button disabled="disabled">查询</button>
									</td>
								</tr>
							</table>
							</form>
							</div>
							</fieldset>
						</next:Html>
					</next:Panel>
					<next:GridPanel id="sysSubjectPreviewGridPanel"
						name="sysSubjectPreviewGridPanel" anchor="100%" height="100%"
						dataset="sysDaiBanSubjectPreviewDataset"    
						title="系统全局层次待办任务标题定义预览" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="procDefUniqueId" header="内码"
								field="procDefUniqueId" width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								for (int i = 0; i < sysDaiBanSubjectDefList
																				.size(); i++) {
																			SysSubjectDef sysSubjectDef = (SysSubjectDef) sysDaiBanSubjectDefList
																					.get(i);
							%>
							<next:Column header="<%=sysSubjectDef.getSubjectAlias()%>"
								field="<%=sysSubjectDef.getSubjectKey()%>"
								width="<%=sysSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
						</next:Columns>
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToSysSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="sysDaiBanSubjectPreviewDataset" />
						</next:BottomBar>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
		</next:Panel>
		<next:Panel title="系统全局层次已办任务标题定义预览" id="yiBanTab">
			<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
			<next:Panel>
				<next:AnchorLayout>
					<next:Panel width="100%" border="0"
						bodyStyle="padding-bottom:10px;padding-top:0px;">
						<next:Html>
							<fieldset style="overflow: visible;" class="GroupBox">
							<legend class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils
																	.getImage(
																			request,
																			"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < sysYiBanSubjectQueryDefList
																						.size(); i++) {
																					SysSubjectQueryDef sysSubjectQueryDef = (SysSubjectQueryDef) sysYiBanSubjectQueryDefList
																							.get(i);
																					String sysSubjectKey = sysSubjectQueryDef
																							.getSubjectKey();
																					String sysSubjectAlias = sysSubjectQueryDef
																							.getSubjectAlias();
																					String sysSubField = sysSubjectQueryDef
																							.getSubjectFieldType();
																					if ("0"
																							.equals(sysSubField)
																							|| sysSubField == null) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=sysSubjectKey%>" class="TextEditor" title="<%=sysSubjectAlias%>" size="40" /></td>
									<%
										} else if ("1"
																							.equals(sysSubField)) {
									%>
									<td class="FieldLabel"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput">
									<select id="<%=sysSubjectKey%>">
									<option value="">请选择...</option>
									<%
										String optionValue;
																						String optionText;
																						for (int k = 0; k < sysSubjectQuerySelectDefList
																								.size(); k++) {
																							SysSubjectQuerySelectDef sysSubjectQuerySelectDef = (SysSubjectQuerySelectDef) sysSubjectQuerySelectDefList
																									.get(k);
																							String sujectQueryDefUniqueId = sysSubjectQuerySelectDef
																									.getSubjectQueryDefUniqueId();
																							if (sujectQueryDefUniqueId
																									.equals(sysSubjectQueryDef
																											.getId())) {
																								optionValue = sysSubjectQuerySelectDef
																										.getOptionValue();
																								optionText = sysSubjectQuerySelectDef
																										.getOptionText();
									%>
										<option value="<%=optionValue%>"><%=optionText%></option>
									<%
										}
																						}
									%>
									</select>
									</td>
									<%
										} else if ("3"
																							.equals(sysSubField)) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="startDate" class="TextEditor" title="开始日期" size="40" format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /> 至  <input type="text" id="endDate"class="TextEditor" title="结束日期" size="40"
										format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /></td>
									<%
										} else if ("4"
																							.equals(sysSubField)) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="startDateTime" class="TextEditor"
										title="开始时间" size="40" format="Ymd H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /> 至  <input type="text" id="endDateTime"
										class="TextEditor" title="结束时间" size="40"
										format="Ymd H:i:s" name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%
										} else if ("2"
																							.equals(sysSubField)) {
																						String dialogUrl;
																						String dialogWidth;
																						String dialogHeight;
																						String conditionUseWay;
																						int keyReturnIndex;
																						int aliasReturnIndex;
																						for (int j = 0; j < sysSubjectQueryCommonHelpDefList
																								.size(); j++) {
																							SysSubjectQueryCommonHelpDef sysSubjectQueryCommonHelpDef = (SysSubjectQueryCommonHelpDef) sysSubjectQueryCommonHelpDefList
																									.get(j);
																							String subjectQueryDefUniqueId = sysSubjectQueryCommonHelpDef
																									.getSubjectQueryDefUniqueId();
																							String conditionUseWayHidden = subjectQueryDefUniqueId
																									+ "returnvalue";//返回值id
																							String conditionUseWayShow = subjectQueryDefUniqueId
																									+ "returnshow";//返回显示值id
																							if (subjectQueryDefUniqueId
																									.equals(sysSubjectQueryDef
																											.getId())) {
																								dialogUrl = sysSubjectQueryCommonHelpDef
																										.getDialogUrl();
																								dialogWidth = sysSubjectQueryCommonHelpDef
																										.getDialogWidth();
																								dialogHeight = sysSubjectQueryCommonHelpDef
																										.getDialogHeight();
																								keyReturnIndex = sysSubjectQueryCommonHelpDef
																										.getKeyReturnIndex();
																								aliasReturnIndex = sysSubjectQueryCommonHelpDef
																										.getAliasReturnIndex();
																								conditionUseWay = sysSubjectQueryCommonHelpDef
																										.getConditionUseWay();
									%>
									<input type="hidden" id="<%=conditionUseWayHidden%>" class="TextEditor" value="" size="40" />
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=conditionUseWayShow%>" class="TextEditor" title="<%=sysSubjectAlias%>" value="" size="40" />
									<image src="<%=SkinUtils
																					.getImage(
																							request,
																							"l5/liulan.gif")%>" onclick="forCommonHelp('<%=conditionUseWayHidden%>','<%=conditionUseWayShow%>','<%=keyReturnIndex%>','<%=aliasReturnIndex%>','<%=dialogUrl%>','<%=dialogWidth%>','<%=dialogHeight%>')"/>
									</td>
									<%
										}
																						}
																					}
																					if (i % 2 == 1) {
																						if (i != sysYiBanSubjectQueryDefList
																								.size() - 1) {
									%>
				                     	</tr>
				                     	<tr>
				                    	<%
				                    		}
				                    													}
				                    												}
				                    	%>
									<td class="FieldButton" width="15%">
									<button disabled="disabled">查询</button>
									</td>
								</tr>
							</table>
							</form>
							</div>
							</fieldset>
						</next:Html>
					</next:Panel>
					<next:GridPanel id="sysYiBanSubjectPreviewGridPanel"
						name="sysSubjectPreviewGridPanel" anchor="100%" height="100%"
						dataset="sysYiBanSubjectPreviewDataset"    
						title="系统全局层次已办任务标题定义预览" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="procDefUniqueId" header="内码"
								field="procDefUniqueId" width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								for (int i = 0; i < sysYiBanSubjectDefList
																				.size(); i++) {
																			SysSubjectDef sysSubjectDef = (SysSubjectDef) sysYiBanSubjectDefList
																					.get(i);
							%>
							<next:Column header="<%=sysSubjectDef.getSubjectAlias()%>"
								field="<%=sysSubjectDef.getSubjectKey()%>"
								width="<%=sysSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
						</next:Columns>
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToSysSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="sysYiBanSubjectPreviewDataset" />
						</next:BottomBar>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
		</next:Panel>
		<next:Panel title="系统全局层次办结任务标题定义预览" id="endTab">
			<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
			<next:Panel>
				<next:AnchorLayout>
					<next:Panel width="100%" border="0"
						bodyStyle="padding-bottom:10px;padding-top:0px;">
						<next:Html>
							<fieldset style="overflow: visible;" class="GroupBox">
							<legend class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils
																	.getImage(
																			request,
																			"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < sysEndSubjectQueryDefList
																						.size(); i++) {
																					SysSubjectQueryDef sysSubjectQueryDef = (SysSubjectQueryDef) sysEndSubjectQueryDefList
																							.get(i);
																					String sysSubjectKey = sysSubjectQueryDef
																							.getSubjectKey();
																					String sysSubjectAlias = sysSubjectQueryDef
																							.getSubjectAlias();
																					String sysSubField = sysSubjectQueryDef
																							.getSubjectFieldType();
																					if ("0"
																							.equals(sysSubField)
																							|| sysSubField == null) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=sysSubjectKey%>" class="TextEditor" title="<%=sysSubjectAlias%>" size="40" /></td>
									<%
										} else if ("1"
																							.equals(sysSubField)) {
									%>
									<td class="FieldLabel"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput">
									<select id="<%=sysSubjectKey%>">
									<option value="">请选择...</option>
									<%
										String optionValue;
																						String optionText;
																						for (int k = 0; k < sysSubjectQuerySelectDefList
																								.size(); k++) {
																							SysSubjectQuerySelectDef sysSubjectQuerySelectDef = (SysSubjectQuerySelectDef) sysSubjectQuerySelectDefList
																									.get(k);
																							String sujectQueryDefUniqueId = sysSubjectQuerySelectDef
																									.getSubjectQueryDefUniqueId();
																							if (sujectQueryDefUniqueId
																									.equals(sysSubjectQueryDef
																											.getId())) {
																								optionValue = sysSubjectQuerySelectDef
																										.getOptionValue();
																								optionText = sysSubjectQuerySelectDef
																										.getOptionText();
									%>
										<option value="<%=optionValue%>"><%=optionText%></option>
									<%
										}
																						}
									%>
									</select>
									</td>
									<%
										} else if ("3"
																							.equals(sysSubField)) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="startDate" class="TextEditor" title="开始日期" size="40" format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /> 至  <input type="text" id="endDate"class="TextEditor" title="结束日期" size="40"
										format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /></td>
									<%
										} else if ("4"
																							.equals(sysSubField)) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="startDateTime" class="TextEditor"
										title="开始时间" size="40" format="Ymd H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /> 至  <input type="text" id="endDateTime"
										class="TextEditor" title="结束时间" size="40"
										format="Ymd H:i:s" name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%
										} else if ("2"
																							.equals(sysSubField)) {
																						String dialogUrl;
																						String dialogWidth;
																						String dialogHeight;
																						String conditionUseWay;
																						int keyReturnIndex;
																						int aliasReturnIndex;
																						for (int j = 0; j < sysSubjectQueryCommonHelpDefList
																								.size(); j++) {
																							SysSubjectQueryCommonHelpDef sysSubjectQueryCommonHelpDef = (SysSubjectQueryCommonHelpDef) sysSubjectQueryCommonHelpDefList
																									.get(j);
																							String subjectQueryDefUniqueId = sysSubjectQueryCommonHelpDef
																									.getSubjectQueryDefUniqueId();
																							String conditionUseWayHidden = subjectQueryDefUniqueId
																									+ "returnvalue";//返回值id
																							String conditionUseWayShow = subjectQueryDefUniqueId
																									+ "returnshow";//返回显示值id
																							if (subjectQueryDefUniqueId
																									.equals(sysSubjectQueryDef
																											.getId())) {
																								dialogUrl = sysSubjectQueryCommonHelpDef
																										.getDialogUrl();
																								dialogWidth = sysSubjectQueryCommonHelpDef
																										.getDialogWidth();
																								dialogHeight = sysSubjectQueryCommonHelpDef
																										.getDialogHeight();
																								keyReturnIndex = sysSubjectQueryCommonHelpDef
																										.getKeyReturnIndex();
																								aliasReturnIndex = sysSubjectQueryCommonHelpDef
																										.getAliasReturnIndex();
																								conditionUseWay = sysSubjectQueryCommonHelpDef
																										.getConditionUseWay();
									%>
									<input type="hidden" id="<%=conditionUseWayHidden%>" class="TextEditor" value="" size="40" />
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=conditionUseWayShow%>" class="TextEditor" title="<%=sysSubjectAlias%>" value="" size="40" />
									<image src="<%=SkinUtils
																					.getImage(
																							request,
																							"l5/liulan.gif")%>" onclick="forCommonHelp('<%=conditionUseWayHidden%>','<%=conditionUseWayShow%>','<%=keyReturnIndex%>','<%=aliasReturnIndex%>','<%=dialogUrl%>','<%=dialogWidth%>','<%=dialogHeight%>')"/>
									</td>
									<%
										}
																						}
																					}
																					if (i % 2 == 1) {
																						if (i != sysEndSubjectQueryDefList
																								.size() - 1) {
									%>
				                     	</tr>
				                     	<tr>
				                    	<%
				                    		}
				                    													}
				                    												}
				                    	%>
									<td class="FieldButton" width="15%">
									<button disabled="disabled">查询</button>
									</td>
								</tr>
							</table>
							</form>
							</div>
							</fieldset>
						</next:Html>
					</next:Panel>
					<next:GridPanel id="sysEndSubjectPreviewGridPanel"
						name="sysSubjectPreviewGridPanel" anchor="100%" height="100%"
						dataset="sysEndSubjectPreviewDataset"    
						title="系统全局层次办结任务标题定义预览" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="procDefUniqueId" header="内码"
								field="procDefUniqueId" width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								for (int i = 0; i < sysEndSubjectDefList.size(); i++) {
									SysSubjectDef sysSubjectDef = (SysSubjectDef) sysEndSubjectDefList
																					.get(i);
							%>
							<next:Column header="<%=sysSubjectDef.getSubjectAlias()%>"
								field="<%=sysSubjectDef.getSubjectKey()%>"
								width="<%=sysSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
						</next:Columns>
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToSysSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="sysEndSubjectPreviewDataset" />
						</next:BottomBar>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">

function backToSysSubjectDefList()
{
	var url="jsp/workflow/tasklist/definition/syssubjectdef/syssubjectdefdetailinfo.jsp";
	L5.forward(url,"系统全局任务标题");
}
//查询条件面板打开合并函数
function collapse(element)
{
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){	
	fieldsetParent.getElementsByTagName("div")[0].style.display="none";
	element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
	element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
		element.expand =true;
	}
}
function forCommonHelp(conditionUseWayHidden,conditionUseWayShow,keyReturnIndex,aliasReturnIndex,dialogUrl,dialogWidth,dialogHeight){
	<%String path = request.getContextPath();%>
	var scheme=dialogUrl.substring(0,7);
    if(scheme.toLowerCase()!="http://"){
        var allUrl= '<%=path%>' + "/" + dialogUrl;
    }
	var dialogMsg = "dialogWidth:"+dialogWidth+"px;dialogHeight:"+dialogHeight+"px";
	
	var win = showModalDialog(allUrl,window,dialogMsg);
	var conditionUseWayReturnValue = win[keyReturnIndex];
	var conditonUseWayShowValue = win[aliasReturnIndex];
	document.getElementById(conditionUseWayHidden).value = conditionUseWayReturnValue;
	document.getElementById(conditionUseWayShow).value = conditonUseWayShowValue;
}
</script>
</html>