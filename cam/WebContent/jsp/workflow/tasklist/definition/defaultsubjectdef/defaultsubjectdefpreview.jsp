<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page
	import="org.loushang.workflow.tasklist.taskinfo.util.TaskListJspUtil"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectQueryDef"%>

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
	List defaultDaiBanSubjectDefList = TaskListJspUtil
			.getDefaultDaiBanSubjectDefList();
	//已办任务标题
	List defaultYiBanSubjectDefList = TaskListJspUtil
			.getDefaultYiBanSubjectDefList();
	//办结任务标题
	List defaultEndSubjectDefList = TaskListJspUtil
			.getDefaultEndSubjectDefList();
	//待办任务查询条件定义
	List defaultDaiBanSubjectQueryDefList = TaskListJspUtil
			.getDefaultDaiBanSubjectQueryDefList();
	//已办任务查询条件定义
	List defaultYiBanSubjectQueryDefList = TaskListJspUtil
			.getDefaultYiBanSubjectQueryDefList();
	//办结任务查询条件定义
	List defaultEndSubjectQueryDefList = TaskListJspUtil
			.getDefaultEndSubjectQueryDefList();
%>
<body>

<model:datasets>
	<model:dataset pageSize="15" id="defaultDaiBanSubjectPreviewDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd"
		autoLoad="true" method="previewDefaultDaiBanSubjectDef">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<%
				for (int i = 0; i < defaultDaiBanSubjectDefList.size(); i++) {
					DefaultSubjectDef defaultSubjectDef = (DefaultSubjectDef) defaultDaiBanSubjectDefList
										.get(i);
			%>
			<model:field name="<%=defaultSubjectDef.getSubjectKey()%>" type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="defaultYiBanSubjectPreviewDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd"
		autoLoad="true" method="previewDefaultYiBanSubjectDef">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<%
				for (int i = 0; i < defaultYiBanSubjectDefList.size(); i++) {
					DefaultSubjectDef defaultSubjectDef = (DefaultSubjectDef) defaultYiBanSubjectDefList.get(i);
			%>
			<model:field name="<%=defaultSubjectDef.getSubjectKey()%>" type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="defaultEndSubjectPreviewDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd"
		autoLoad="true" method="previewDefaultEndSubjectDef">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<%
				for (int i = 0; i < defaultEndSubjectDefList.size(); i++) {
					DefaultSubjectDef defaultSubjectDef = (DefaultSubjectDef) defaultEndSubjectDefList
										.get(i);
			%>
			<model:field name="<%=defaultSubjectDef.getSubjectKey()%>" type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
<next:TabPanel name="tabpanel-div" height="590" activeTab="0" id="procTabs">
	<next:Defaults>
		{bodyStyle:'padding:15px;'}
	</next:Defaults>
	<next:Tabs>
		<next:Panel title="待办任务标题定义预览" id="daiBanTab">
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
								src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < defaultDaiBanSubjectQueryDefList.size(); i++) {
													DefaultSubjectQueryDef defaultSubjectQueryDef = (DefaultSubjectQueryDef) defaultDaiBanSubjectQueryDefList
																							.get(i);
													String defaultSubjectKey = defaultSubjectQueryDef
																							.getSubjectKey();
													String defaultSubjectAlias = defaultSubjectQueryDef
																							.getSubjectAlias();
													String defaultSubField = defaultSubjectQueryDef
																							.getSubjectFieldType();
													if ("0".equals(defaultSubField)|| defaultSubField == null) {
									%>
									<td class="FieldLabel" width="15%"><%=defaultSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=defaultSubjectKey%>" class="TextEditor" title="<%=defaultSubjectAlias%>" size="40" /></td>
									<%
										} else if ("4".equals(defaultSubField)) {
									%>
									<td class="FieldLabel" width="15%"><%=defaultSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="startDateTime" class="TextEditor"
										title="开始时间" size="40" format="Y-m-d H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /> 至  <input type="text" id="endDateTime"
										class="TextEditor" title="结束时间" size="40"
										format="Y-m-d H:i:s" name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%
										} if (i % 2 == 1) {
												if (i != defaultDaiBanSubjectQueryDefList.size() - 1) {
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
					<next:GridPanel id="defaultSubjectPreviewGridPanel"
						name="defaultSubjectPreviewGridPanel" anchor="100%" height="100%"
						dataset="defaultDaiBanSubjectPreviewDataset"    
						title="待办任务标题定义预览" notSelectFirstRow="true">						
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="procDefUniqueId" header="内码"
								field="procDefUniqueId" width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								for (int i = 0; i < defaultDaiBanSubjectDefList.size(); i++) {
										DefaultSubjectDef defaultSubjectDef = (DefaultSubjectDef) defaultDaiBanSubjectDefList
																					.get(i);
							%>
							<next:Column header="<%=defaultSubjectDef.getSubjectAlias()%>"
								field="<%=defaultSubjectDef.getSubjectKey()%>"
								width="<%=defaultSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
						</next:Columns>		
						<next:TopBar>
						    <next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="返回"
								handler="backTodefaultSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="defaultDaiBanSubjectPreviewDataset" />
						</next:BottomBar>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
		</next:Panel>
		<next:Panel title="已办任务标题定义预览" id="yiBanTab">
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
								src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < defaultYiBanSubjectQueryDefList.size(); i++) {
													DefaultSubjectQueryDef defaultSubjectQueryDef = (DefaultSubjectQueryDef) defaultYiBanSubjectQueryDefList
																							.get(i);
													String defaultSubjectKey = defaultSubjectQueryDef
																							.getSubjectKey();
													String defaultSubjectAlias = defaultSubjectQueryDef
																							.getSubjectAlias();
													String defaultSubField = defaultSubjectQueryDef
																							.getSubjectFieldType();
													if ("0".equals(defaultSubField)|| defaultSubField == null) {
									%>
									<td class="FieldLabel" width="15%"><%=defaultSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=defaultSubjectKey%>" class="TextEditor" title="<%=defaultSubjectAlias%>" size="40" /></td>
									<%
										} else if ("4".equals(defaultSubField)) {
									%>
									<td class="FieldLabel" width="15%"><%=defaultSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="startDateTime" class="TextEditor"
										title="开始时间" size="40" format="Y-m-d H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /> 至  <input type="text" id="endDateTime"
										class="TextEditor" title="结束时间" size="40"
										format="Y-m-d H:i:s" name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%}
										if (i % 2 == 1) {
											if (i != defaultYiBanSubjectQueryDefList.size() - 1) {
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
					<next:GridPanel id="defaultSubjectPreviewGridPanel"
						name="defaultSubjectPreviewGridPanel" anchor="100%" height="100%"
						dataset="defaultYiBanSubjectPreviewDataset"    
						title="已办任务标题定义预览" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="procDefUniqueId" header="内码"
								field="procDefUniqueId" width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							
							<%
								for (int i = 0; i < defaultYiBanSubjectDefList.size(); i++) {
									DefaultSubjectDef defaultSubjectDef = (DefaultSubjectDef) defaultYiBanSubjectDefList
																					.get(i);
							%>
							<next:Column header="<%=defaultSubjectDef.getSubjectAlias()%>"
								field="<%=defaultSubjectDef.getSubjectKey()%>"
								width="<%=defaultSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
						</next:Columns>
						<next:TopBar>
						    <next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="返回"
								handler="backTodefaultSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="defaultYiBanSubjectPreviewDataset" />
						</next:BottomBar>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
		</next:Panel>
		<next:Panel title="办结任务标题定义预览" id="endTab">
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
								src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < defaultEndSubjectQueryDefList
																						.size(); i++) {
													DefaultSubjectQueryDef defaultSubjectQueryDef = (DefaultSubjectQueryDef) defaultEndSubjectQueryDefList
																							.get(i);
													String defaultSubjectKey = defaultSubjectQueryDef
																							.getSubjectKey();
													String defaultSubjectAlias = defaultSubjectQueryDef
																							.getSubjectAlias();
													String defaultSubField = defaultSubjectQueryDef
																							.getSubjectFieldType();
													if ("0".equals(defaultSubField)|| defaultSubField == null) {
									%>
									<td class="FieldLabel" width="15%"><%=defaultSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=defaultSubjectKey%>" class="TextEditor" title="<%=defaultSubjectAlias%>" size="40" /></td>
									<%
										} else if ("4".equals(defaultSubField)) {
									%>
									<td class="FieldLabel" width="15%"><%=defaultSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="startDateTime" class="TextEditor"
										title="开始时间" size="40" format="Y-m-d H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /> 至  <input type="text" id="endDateTime"
										class="TextEditor" title="结束时间" size="40"
										format="Y-m-d H:i:s" name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%}
										if (i % 2 == 1) {
											if (i != defaultEndSubjectQueryDefList.size() - 1) {
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
					<next:GridPanel id="defaultSubjectPreviewGridPanel"
						name="defaultSubjectPreviewGridPanel" anchor="100%" height="100%"
						dataset="defaultEndSubjectPreviewDataset"    
						title="办结任务标题定义预览" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="procDefUniqueId" header="内码"
								field="procDefUniqueId" width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								for (int i = 0; i < defaultEndSubjectDefList.size(); i++) {
									DefaultSubjectDef defaultSubjectDef = (DefaultSubjectDef) defaultEndSubjectDefList
																					.get(i);
							%>
							<next:Column header="<%=defaultSubjectDef.getSubjectAlias()%>"
								field="<%=defaultSubjectDef.getSubjectKey()%>"
								width="<%=defaultSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
						</next:Columns>
						<next:TopBar>
						    <next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="返回"
								handler="backTodefaultSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="defaultEndSubjectPreviewDataset" />
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

function backTodefaultSubjectDefList()
{
	var url="jsp/workflow/tasklist/definition/defaultsubjectdef/defaultsubjectdefdetailinfo.jsp";
	L5.forward(url,"任务标题详细信息");
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