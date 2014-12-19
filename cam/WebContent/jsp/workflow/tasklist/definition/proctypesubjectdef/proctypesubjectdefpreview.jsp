<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>
<%@page
	import="org.loushang.workflow.tasklist.taskinfo.util.TaskListJspUtil"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQueryDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQueryCommonHelpDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQuerySelectDef"%>


<html>
<head>
<style>
a {
	TEXT-DECORATION: none
}
</style>
<title>流程类型层次任务标题预览</title>
<next:ScriptManager></next:ScriptManager>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			String tabId = request.getParameter("tabId");//用于确定首先加载哪个tab页
			  if("".equals(tabId) || null == tabId){
			  	tabId = "daiBanPreview";
			  }
			  int dispalyProcTab = 0;//0:待办 1:已办 2:办结
			 
			  if(tabId.equals("daiBanPreview")){
			  	dispalyProcTab = 0;
			  }
			  else if(tabId.equals("yiBanPreview")){
			  	dispalyProcTab = 1;
			  }
			  else if(tabId.equals("endPreview")){
			  	dispalyProcTab = 2;
			  }

%>
</head>
<%
    String subjectType = request.getParameter("subjectType");
	String procTypeId = request.getParameter("procTypeId");
	//待办业务和流程标题
	List procTypeDaiBanSubjectDefList = TaskListJspUtil.getProcTypeDaiBanSubjectDefListByProcTypeId(procTypeId);
	//已办业务和流程标题
	List procTypeYiBanSubjectDefList = TaskListJspUtil.getProcTypeYiBanSubjectDefListByProcTypeId(procTypeId);
	//办结业务和流程标题
	List procTypeEndSubjectDefList = TaskListJspUtil.getProcTypeEndSubjectDefListByProcTypeId(procTypeId);
	//待办查询条件
	List procTypeDaiBanSubjectQueryDefList = TaskListJspUtil.getProcTypeDaiBanSubjectQueryDefListByProcTypeId(procTypeId);
	//已办查询条件
	List procTypeYiBanSubjectQueryDefList = TaskListJspUtil.getProcTypeYiBanSubjectQueryDefListByProcTypeId(procTypeId);
	//办结查询条件
	List procTypeEndSubjectQueryDefList = TaskListJspUtil.getProcTypeEndSubjectQueryDefListByProcTypeId(procTypeId);
	//该类型下的所有通用帮助定义信息
	List procTypeSubjectQueryCommonHelpDefList = TaskListJspUtil
			.getProcTypeSubjectQueryCommonHelpDefListByProcDefUniqueId(procTypeId);
	//该类型下的所有下拉框定义信息
	List procTypeSubjectQuerySelectDefList = TaskListJspUtil
			.getProcTypeSubjectQuerySelectDefListByProcTypeId(procTypeId);
	String procTypeSubjectKeyDataBegin, procTypeSubjectKeyDataEnd, procTypeSubjectKeyDataTimeBegin, procTypeSubjectKeyDataTimeEnd;
%>
<body>

<model:datasets>
	<model:dataset pageSize="15" id="procTypeDaiBanSubjectPreviewDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" method="previewProcTypeDaiBanSubject" global="true">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<%
				for (int i = 0; i < procTypeDaiBanSubjectDefList.size(); i++) {
								ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeDaiBanSubjectDefList
										.get(i);
			%>
			<model:field name="<%=procTypeSubjectDef.getSubjectKey()%>"
				type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="procTypeYiBanSubjectPreviewDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" method="previewProcTypeYiBanSubject" global="true">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<%
				for (int i = 0; i < procTypeYiBanSubjectDefList.size(); i++) {
								ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeYiBanSubjectDefList
										.get(i);
			%>
			<model:field name="<%=procTypeSubjectDef.getSubjectKey()%>"
				type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="procTypeEndSubjectPreviewDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" method="previewProcTypeEndSubject" global="true">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<%
				for (int i = 0; i < procTypeEndSubjectDefList.size(); i++) {
								ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeEndSubjectDefList
										.get(i);
			%>
			<model:field name="<%=procTypeSubjectDef.getSubjectKey()%>"
				type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
<next:TabPanel name="tabpanel-div" height="590" activeTab="<%=dispalyProcTab %>" id="procTabs">
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Tabs>
			<next:Panel title="待办任务预览" id="daiBanTab">
					<next:Panel width="100%" border="0"
						bodyStyle="padding-bottom:10px;padding-top:0px;">
						<next:Html>
							<fieldset style="overflow: visible;" class="GroupBox">
							<legend class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,
												"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < procTypeDaiBanSubjectQueryDefList
																			.size(); i++) {
																		ProcTypeSubjectQueryDef procTypeSubjectQueryDef = (ProcTypeSubjectQueryDef) procTypeDaiBanSubjectQueryDefList
																				.get(i);
																		String procTypeSubjectKey = procTypeSubjectQueryDef
																				.getSubjectKey();
																		//查询字段内码值
																		String subjectQueryDefUniqueId = procTypeSubjectQueryDef
																				.getId();
																		String procTypeSubjectAlias = procTypeSubjectQueryDef
																				.getSubjectAlias();
																		String t = procTypeSubjectQueryDef
																				.getSubjectFieldType();
																		if (t == null) {
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=procTypeSubjectKey%>" class="TextEditor"
										title="<%=procTypeSubjectAlias%>" size="40" /></td>
									<%
										} else {
																			int type = Integer.parseInt(t);
																			switch (type) {
																				case 1 : {%>
																				<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									                                        <td class="FieldInput" ><select type="text"
										                                        name="<%=procTypeSubjectKey%>" field="selectName"
										                                         title="查询条件">
										                                         <option value="">请选择...</option>
																					<%for (int p = 0; p < procTypeSubjectQuerySelectDefList
																							.size(); p++) {
																						ProcTypeSubjectQuerySelectDef procTypeSubjectQuerySelectDef = (ProcTypeSubjectQuerySelectDef) procTypeSubjectQuerySelectDefList
																								.get(p);
																						String subjectQueryDefUnique = procTypeSubjectQuerySelectDef.getSubjectQueryDefUniqueId()
																						;
																						if(subjectQueryDefUnique.equals(subjectQueryDefUniqueId)){
																						String optionValue = procTypeSubjectQuerySelectDef.getOptionValue();
																						String optionText = procTypeSubjectQuerySelectDef.getOptionText();
																						%>
																						<option value="<%=optionValue%>"><%=optionText%></option>
									                                                          
																						<%}
																					}%>
																					 </select></td>
																				<%}
																				break;
																				case 2 : {
																					String procTypeSubjectKeyHidden = procTypeSubjectKey
																							+ "hidden";
																					for (int j = 0; j < procTypeSubjectQueryCommonHelpDefList
																							.size(); j++) {
																						ProcTypeSubjectQueryCommonHelpDef procTypeSubjectQueryCommonHelpDef = (ProcTypeSubjectQueryCommonHelpDef) procTypeSubjectQueryCommonHelpDefList
																								.get(j);
																						String procTypeSubjectQueryCommonHelpDefId = procTypeSubjectQueryCommonHelpDef
																								.getSubjectQueryDefUniqueId();
																						if (procTypeSubjectQueryCommonHelpDefId
																								.equals(subjectQueryDefUniqueId)) {
																							String dialogUrl = procTypeSubjectQueryCommonHelpDef
																									.getDialogUrl();
																							String dialogHeight = procTypeSubjectQueryCommonHelpDef
																									.getDialogHeight();
																							String dialogWidth = procTypeSubjectQueryCommonHelpDef
																									.getDialogWidth();
																							String conditionUseWay = procTypeSubjectQueryCommonHelpDef
																									.getSubjectQueryDefUniqueId();
																							int keyReturnIndex = procTypeSubjectQueryCommonHelpDef
																									.getKeyReturnIndex();
																							int aliasReturnIndex = procTypeSubjectQueryCommonHelpDef
																									.getAliasReturnIndex();
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=procTypeSubjectKey%>" title="<%=procTypeSubjectAlias%>"
										size="40"> <input id="<%=procTypeSubjectKeyHidden%>"
										type="hidden" name="principalId" /> <img
										src="<%=SkinUtils
																		.getImage(
																				request,
																				"l5/liulan.gif")%>"
										style="cursor: hand"
										onclick="show('<%=procTypeSubjectKey%>','<%=procTypeSubjectKeyHidden%>','<%=dialogUrl%>','<%=dialogHeight%>','<%=dialogWidth%>','<%=keyReturnIndex%>','<%=aliasReturnIndex%>')" /></td>
									<%
										}
																					}
																				}
																					break;
																				case 3 : {
																					procTypeSubjectKeyDataBegin = procTypeSubjectKey
																							+ "dataBegin";
																					procTypeSubjectKeyDataEnd = procTypeSubjectKey
																							+ "dataEnd";
									%>
									<td class="FieldLabel" width="10%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKeyDataBegin%>" class="TextEditor"
										title="开始日期" format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /> 至 <input type="text"
										id="<%=procTypeSubjectKeyDataEnd%>" class="TextEditor"
										title="结束日期" format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /></td>
									<%
										}
																					break;
																				case 4 : {
																					procTypeSubjectKeyDataTimeBegin = procTypeSubjectKey
																							+ "dataTimeBegin";
																					procTypeSubjectKeyDataTimeEnd = procTypeSubjectKey
																							+ "dataTimeEnd";
									%>
									<td class="FieldLabel" width="10%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKeyDataTimeBegin%>" class="TextEditor"
										title="开始时间" size="40" format="Ymd H:i:s" name="createTime"
										field="createTime" onclick="LoushangDatetime(this)" /> 至 <input
										type="text" id="<%=procTypeSubjectKeyDataTimeEnd%>"
										class="TextEditor" title="结束时间" size="40" format="Ymd H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%
										}
																					break;
																				default : {
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKey%>" class="TextEditor"
										title="<%=procTypeSubjectAlias%>" size="40" /></td>
									<%
										}
																					break;
																			}
																		}
																		if (i % 2 == 1) {
																			if (i != procTypeDaiBanSubjectQueryDefList
																					.size() - 1) {
									%>
								</tr>
								<tr>
									<%
										}
																		}
																	}
									%>
								    <% if( procTypeDaiBanSubjectQueryDefList
											.size()%2==1){%>
											<td colspan="2"></td>
									<td class="FieldButton" width="15%">
									<button disabled="disabled">查询</button>
									</td>
								    	
								    <%}else{%>
								    	<td class="FieldButton" width="15%">
									<button disabled="disabled">查询</button>
									</td>
								    <%}
								    %>
									
								</tr>
							</table>
							</form>
							</div>
							</fieldset>
						</next:Html>
					</next:Panel>
					<next:GridPanel id="procTypeDaiBanSubjectPreviewGridPanel"
						name="procTypeDaiBanSubjectPreviewGridPanel" anchor="100%" height="100%"
						dataset="procTypeDaiBanSubjectPreviewDataset"    
						title="预览" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="procDefUniqueId" header="内码"
								field="procDefUniqueId" width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								for (int i = 0; i < procTypeDaiBanSubjectDefList
																	.size(); i++) {
																ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeDaiBanSubjectDefList
																		.get(i);
							%>
							<next:Column header="<%=procTypeSubjectDef.getSubjectAlias()%>"
								field="<%=procTypeSubjectDef.getSubjectKey()%>"
								width="<%=procTypeSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
						</next:Columns>
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToDaiBanProcTypeSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="procTypeDaiBanSubjectPreviewDataset" />
						</next:BottomBar>
					</next:GridPanel>
			</next:Panel>
			<next:Panel title="已办任务预览" id="yiBanTab">
				<next:AnchorLayout>
					<next:Panel width="100%" border="0"
						bodyStyle="padding-bottom:10px;padding-top:0px;">
						<next:Html>
							<fieldset style="overflow: visible;" class="GroupBox">
							<legend class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,
												"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < procTypeYiBanSubjectQueryDefList
																			.size(); i++) {
																		ProcTypeSubjectQueryDef procTypeSubjectQueryDef = (ProcTypeSubjectQueryDef) procTypeYiBanSubjectQueryDefList
																				.get(i);
																		String procTypeSubjectKey = procTypeSubjectQueryDef
																				.getSubjectKey();
																		//查询字段内码值
																		String subjectQueryDefUniqueId = procTypeSubjectQueryDef
																				.getId();
																		String procTypeSubjectAlias = procTypeSubjectQueryDef
																				.getSubjectAlias();
																		String t = procTypeSubjectQueryDef
																				.getSubjectFieldType();
																		if (t == null) {
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=procTypeSubjectKey%>" class="TextEditor"
										title="<%=procTypeSubjectAlias%>" size="40" /></td>
									<%
										} else {
																			int type = Integer.parseInt(t);
																			switch (type) {
																				case 1 : {%>
																				<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									                                        <td class="FieldInput" ><select type="text"
										                                        name="<%=procTypeSubjectKey%>" field="selectName"
										                                         title="查询条件">
										                                         <option value="">请选择...</option>
																					<%for (int p = 0; p < procTypeSubjectQuerySelectDefList
																							.size(); p++) {
																						ProcTypeSubjectQuerySelectDef procTypeSubjectQuerySelectDef = (ProcTypeSubjectQuerySelectDef) procTypeSubjectQuerySelectDefList
																								.get(p);
																						String subjectQueryDefUnique = procTypeSubjectQuerySelectDef.getSubjectQueryDefUniqueId()
																						;
																						if(subjectQueryDefUnique.equals(subjectQueryDefUniqueId)){
																						String optionValue = procTypeSubjectQuerySelectDef.getOptionValue();
																						String optionText = procTypeSubjectQuerySelectDef.getOptionText();
																						%>
																						<option value="<%=optionValue%>"><%=optionText%></option>
									                                                          
																						<%}
																					}%>
																					 </select></td>
																				<%}
																				break;
																				case 2 : {
																					String procTypeSubjectKeyHidden = procTypeSubjectKey
																							+ "hidden";
																					for (int j = 0; j < procTypeSubjectQueryCommonHelpDefList
																							.size(); j++) {
																						ProcTypeSubjectQueryCommonHelpDef procTypeSubjectQueryCommonHelpDef = (ProcTypeSubjectQueryCommonHelpDef) procTypeSubjectQueryCommonHelpDefList
																								.get(j);
																						String procTypeSubjectQueryCommonHelpDefId = procTypeSubjectQueryCommonHelpDef
																								.getSubjectQueryDefUniqueId();
																						if (procTypeSubjectQueryCommonHelpDefId
																								.equals(subjectQueryDefUniqueId)) {
																							String dialogUrl = procTypeSubjectQueryCommonHelpDef
																									.getDialogUrl();
																							String dialogHeight = procTypeSubjectQueryCommonHelpDef
																									.getDialogHeight();
																							String dialogWidth = procTypeSubjectQueryCommonHelpDef
																									.getDialogWidth();
																							String conditionUseWay = procTypeSubjectQueryCommonHelpDef
																									.getSubjectQueryDefUniqueId();
																							int keyReturnIndex = procTypeSubjectQueryCommonHelpDef
																									.getKeyReturnIndex();
																							int aliasReturnIndex = procTypeSubjectQueryCommonHelpDef
																									.getAliasReturnIndex();
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=procTypeSubjectKey%>" title="<%=procTypeSubjectAlias%>"
										size="40"> <input id="<%=procTypeSubjectKeyHidden%>"
										type="hidden" name="principalId" /> <img
										src="<%=SkinUtils
																		.getImage(
																				request,
																				"l5/liulan.gif")%>"
										style="cursor: hand"
										onclick="show('<%=procTypeSubjectKey%>','<%=procTypeSubjectKeyHidden%>','<%=dialogUrl%>','<%=dialogHeight%>','<%=dialogWidth%>','<%=keyReturnIndex%>','<%=aliasReturnIndex%>')" /></td>
									<%
										}
																					}
																				}
																					break;
																				case 3 : {
																					procTypeSubjectKeyDataBegin = procTypeSubjectKey
																							+ "dataBegin";
																					procTypeSubjectKeyDataEnd = procTypeSubjectKey
																							+ "dataEnd";
									%>
									<td class="FieldLabel" width="10%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKeyDataBegin%>" class="TextEditor"
										title="开始日期" format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /> 至 <input type="text"
										id="<%=procTypeSubjectKeyDataEnd%>" class="TextEditor"
										title="结束日期" format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /></td>
									<%
										}
																					break;
																				case 4 : {
																					procTypeSubjectKeyDataTimeBegin = procTypeSubjectKey
																							+ "dataTimeBegin";
																					procTypeSubjectKeyDataTimeEnd = procTypeSubjectKey
																							+ "dataTimeEnd";
									%>
									<td class="FieldLabel" width="10%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKeyDataTimeBegin%>" class="TextEditor"
										title="开始时间" size="40" format="Ymd H:i:s" name="createTime"
										field="createTime" onclick="LoushangDatetime(this)" /> 至 <input
										type="text" id="<%=procTypeSubjectKeyDataTimeEnd%>"
										class="TextEditor" title="结束时间" size="40" format="Ymd H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%
										}
																					break;
																				default : {
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKey%>" class="TextEditor"
										title="<%=procTypeSubjectAlias%>" size="40" /></td>
									<%
										}
																					break;
																			}
																		}
																		if (i % 2 == 1) {
																			if (i != procTypeYiBanSubjectQueryDefList
																					.size() - 1) {
									%>
								</tr>
								<tr>
									<%
										}
																		}
																	}
									%>
									 <% if( procTypeYiBanSubjectQueryDefList
											.size()%2==1){%>
											<td colspan="2"></td>
									<td class="FieldButton" width="15%">
									<button disabled="disabled">查询</button>
									</td>
								    	
								    <%}else{%>
								    	<td class="FieldButton" width="15%">
									<button disabled="disabled">查询</button>
									</td>
								    <%}
								    %>
								</tr>
							</table>
							</form>
							</div>
							</fieldset>
						</next:Html>
					</next:Panel>
					<next:GridPanel id="procTypeYiBanSubjectPreviewGridPanel"
						name="procTypeYiBanSubjectPreviewGridPanel" anchor="100%" height="100%"
						dataset="procTypeYiBanSubjectPreviewDataset"    
						title="预览" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="procDefUniqueId" header="内码"
								field="procDefUniqueId" width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								for (int i = 0; i < procTypeYiBanSubjectDefList
																	.size(); i++) {
																ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeYiBanSubjectDefList
																		.get(i);
							%>
							<next:Column header="<%=procTypeSubjectDef.getSubjectAlias()%>"
								field="<%=procTypeSubjectDef.getSubjectKey()%>"
								width="<%=procTypeSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
						</next:Columns>
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToYiBanProcTypeSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="procTypeYiBanSubjectPreviewDataset" />
						</next:BottomBar>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
			<next:Panel title="办结任务预览" id="endTab">
				<next:AnchorLayout>
					<next:Panel width="100%" border="0"
						bodyStyle="padding-bottom:10px;padding-top:0px;">
						<next:Html>
							<fieldset style="overflow: visible;" class="GroupBox">
							<legend class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,
												"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < procTypeEndSubjectQueryDefList
																			.size(); i++) {
																		ProcTypeSubjectQueryDef procTypeSubjectQueryDef = (ProcTypeSubjectQueryDef) procTypeEndSubjectQueryDefList
																				.get(i);
																		String procTypeSubjectKey = procTypeSubjectQueryDef
																				.getSubjectKey();
																		//查询字段内码值
																		String subjectQueryDefUniqueId = procTypeSubjectQueryDef
																				.getId();
																		String procTypeSubjectAlias = procTypeSubjectQueryDef
																				.getSubjectAlias();
																		String t = procTypeSubjectQueryDef
																				.getSubjectFieldType();
																		if (t == null) {
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=procTypeSubjectKey%>" class="TextEditor"
										title="<%=procTypeSubjectAlias%>" size="40" /></td>
									<%
										} else {
																			int type = Integer.parseInt(t);
																			switch (type) {
																				case 1 : {%>
																				<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									                                        <td class="FieldInput" ><select type="text"
										                                        name="<%=procTypeSubjectKey%>" field="selectName"
										                                         title="查询条件">
										                                         <option value="">请选择...</option>
																					<%for (int p = 0; p < procTypeSubjectQuerySelectDefList
																							.size(); p++) {
																						ProcTypeSubjectQuerySelectDef procTypeSubjectQuerySelectDef = (ProcTypeSubjectQuerySelectDef) procTypeSubjectQuerySelectDefList
																								.get(p);
																						String subjectQueryDefUnique = procTypeSubjectQuerySelectDef.getSubjectQueryDefUniqueId()
																						;
																						if(subjectQueryDefUnique.equals(subjectQueryDefUniqueId)){
																						String optionValue = procTypeSubjectQuerySelectDef.getOptionValue();
																						String optionText = procTypeSubjectQuerySelectDef.getOptionText();
																						%>
																						<option value="<%=optionValue%>"><%=optionText%></option>
									                                                          
																						<%}
																					}%>
																					 </select></td>
																				<%}
																				break;
																				case 2 : {
																					String procTypeSubjectKeyHidden = procTypeSubjectKey
																							+ "hidden";
																					for (int j = 0; j < procTypeSubjectQueryCommonHelpDefList
																							.size(); j++) {
																						ProcTypeSubjectQueryCommonHelpDef procTypeSubjectQueryCommonHelpDef = (ProcTypeSubjectQueryCommonHelpDef) procTypeSubjectQueryCommonHelpDefList
																								.get(j);
																						String procTypeSubjectQueryCommonHelpDefId = procTypeSubjectQueryCommonHelpDef
																								.getSubjectQueryDefUniqueId();
																						if (procTypeSubjectQueryCommonHelpDefId
																								.equals(subjectQueryDefUniqueId)) {
																							String dialogUrl = procTypeSubjectQueryCommonHelpDef
																									.getDialogUrl();
																							String dialogHeight = procTypeSubjectQueryCommonHelpDef
																									.getDialogHeight();
																							String dialogWidth = procTypeSubjectQueryCommonHelpDef
																									.getDialogWidth();
																							String conditionUseWay = procTypeSubjectQueryCommonHelpDef
																									.getSubjectQueryDefUniqueId();
																							int keyReturnIndex = procTypeSubjectQueryCommonHelpDef
																									.getKeyReturnIndex();
																							int aliasReturnIndex = procTypeSubjectQueryCommonHelpDef
																									.getAliasReturnIndex();
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=procTypeSubjectKey%>" title="<%=procTypeSubjectAlias%>"
										size="40"> <input id="<%=procTypeSubjectKeyHidden%>"
										type="hidden" name="principalId" /> <img
										src="<%=SkinUtils
																		.getImage(
																				request,
																				"l5/liulan.gif")%>"
										style="cursor: hand"
										onclick="show('<%=procTypeSubjectKey%>','<%=procTypeSubjectKeyHidden%>','<%=dialogUrl%>','<%=dialogHeight%>','<%=dialogWidth%>','<%=keyReturnIndex%>','<%=aliasReturnIndex%>')" /></td>
									<%
										}
																					}
																				}
																					break;
																				case 3 : {
																					procTypeSubjectKeyDataBegin = procTypeSubjectKey
																							+ "dataBegin";
																					procTypeSubjectKeyDataEnd = procTypeSubjectKey
																							+ "dataEnd";
									%>
									<td class="FieldLabel" width="10%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKeyDataBegin%>" class="TextEditor"
										title="开始日期" format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /> 至 <input type="text"
										id="<%=procTypeSubjectKeyDataEnd%>" class="TextEditor"
										title="结束日期" format="Ymd" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /></td>
									<%
										}
																					break;
																				case 4 : {
																					procTypeSubjectKeyDataTimeBegin = procTypeSubjectKey
																							+ "dataTimeBegin";
																					procTypeSubjectKeyDataTimeEnd = procTypeSubjectKey
																							+ "dataTimeEnd";
									%>
									<td class="FieldLabel" width="10%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKeyDataTimeBegin%>" class="TextEditor"
										title="开始时间" size="40" format="Ymd H:i:s" name="createTime"
										field="createTime" onclick="LoushangDatetime(this)" /> 至 <input
										type="text" id="<%=procTypeSubjectKeyDataTimeEnd%>"
										class="TextEditor" title="结束时间" size="40" format="Ymd H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%
										}
																					break;
																				default : {
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKey%>" class="TextEditor"
										title="<%=procTypeSubjectAlias%>" size="40" /></td>
									<%
										}
																					break;
																			}
																		}
																		if (i % 2 == 1) {
																			if (i != procTypeEndSubjectQueryDefList
																					.size() - 1) {
									%>
								</tr>
								<tr>
									<%
										}
																		}
																	}
									%>
									 <% if( procTypeEndSubjectQueryDefList
											.size()%2==1){%>
											<td colspan="2"></td>
									<td class="FieldButton" width="15%">
									<button disabled="disabled">查询</button>
									</td>
								    	
								    <%}else{%>
								    	<td class="FieldButton" width="15%">
									<button disabled="disabled">查询</button>
									</td>
								    <%}
								    %>
								</tr>
							</table>
							</form>
							</div>
							</fieldset>
						</next:Html>
					</next:Panel>
					<next:GridPanel id="procTypeEndSubjectPreviewGridPanel"
						name="procTypeEndSubjectPreviewGridPanel" anchor="100%" height="100%"
						dataset="procTypeEndSubjectPreviewDataset"    
						title="预览" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="procDefUniqueId" header="内码"
								field="procDefUniqueId" width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								for (int i = 0; i < procTypeEndSubjectDefList
																	.size(); i++) {
																ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeEndSubjectDefList
																		.get(i);
							%>
							<next:Column header="<%=procTypeSubjectDef.getSubjectAlias()%>"
								field="<%=procTypeSubjectDef.getSubjectKey()%>"
								width="<%=procTypeSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
						</next:Columns>
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToEndProcTypeSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="procTypeEndSubjectPreviewDataset" />
						</next:BottomBar>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">
var isYiBanInit = false;
var isEndInit = false;
function init()
{
	procTypeDaiBanSubjectPreviewDataset.setParameter("procTypeId","<%=procTypeId%>");
	procTypeDaiBanSubjectPreviewDataset.load();
	var tabId = '<%=tabId%>';
	if (tabId == "yiBanPreview"){
		isYiBanInit = true;
		procTypeYiBanSubjectPreviewDataset.setParameter("procTypeId","<%=procTypeId%>");
		procTypeYiBanSubjectPreviewDataset.load();
	}
	if (tabId == "endPreview"){
		isEndInit = true;
		procTypeEndSubjectPreviewDataset.setParameter("procTypeId","<%=procTypeId%>");
		procTypeEndSubjectPreviewDataset.load();
	}
	 var tabpanel = L5.getCmp("procTabs");
		tabpanel.on("tabchange", loadTab);
}


function loadTab(tabpanels, tab)
{
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanInit == false){
		if(tab.id == "yiBanTab"){
			isYiBanInit = true;
			procTypeYiBanSubjectPreviewDataset.setParameter("procTypeId","<%=procTypeId%>");
			procTypeYiBanSubjectPreviewDataset.load();
			
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isEndInit == false){
		if(tab.id == "endTab"){
			isEndInit = true;
			procTypeEndSubjectPreviewDataset.setParameter("procTypeId","<%=procTypeId%>");
			procTypeEndSubjectPreviewDataset.load();
		}
	}
}
function backToProcSubjectDefList()
{
	window.history.go(-1);
}

function backToDaiBanProcTypeSubjectDefList()
{
	var subjectType = '<%=subjectType%>'
    if(subjectType=="bizTable"){
    	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithbiztable.jsp?procTypeId="+"<%=procTypeId%>"+"&tabId=daiBanQuery";
    }else{
    	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithformfield.jsp?procTypeId="+"<%=procTypeId%>"+"&tabId=daiBanQuery";
    }
	
	L5.forward(url,"流程类型查询条件定义");
}

function backToYiBanProcTypeSubjectDefList()
{
	var subjectType = '<%=subjectType%>'
	    if(subjectType=="bizTable"){
	    	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithbiztable.jsp?procTypeId="+"<%=procTypeId%>"+"&tabId=yiBanQuery";
	    }else{
	    	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithformfield.jsp?procTypeId="+"<%=procTypeId%>"+"&tabId=yiBanQuery";
	    }
	L5.forward(url,"流程类型查询条件定义");
}

function backToEndProcTypeSubjectDefList()
{
	var subjectType = '<%=subjectType%>'
	    if(subjectType=="bizTable"){
	    	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithbiztable.jsp?procTypeId="+"<%=procTypeId%>"+"&tabId=endQuery";
	    }else{
	    	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithformfield.jsp?procTypeId="+"<%=procTypeId%>"+"&tabId=endQuery";
	    }
	L5.forward(url,"流程类型查询条件定义");
}

//显示通用帮助框
function show(procTypeSubjectKey,procTypeSubjectKeyHidden,dialogUrl,dialogHeight,dialogWidth,keyReturnIndex,aliasReturnIndex){
	var scheme=dialogUrl.substring(0,7);
    if(scheme.toLowerCase()!="http://"){
        var allUrl= '<%=path%>' + "/" + dialogUrl;
    }
	var win = showModalDialog(allUrl,window,"dialogWidth:"+dialogWidth+"px;"+"dialogHeight:"+dialogHeight+"px");
	if(win==null){
		return ;
	}
	document.getElementById(procTypeSubjectKey).value=win[keyReturnIndex];
	document.getElementById(procTypeSubjectKeyHidden).value=win[aliasReturnIndex];
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
</script>
</html>