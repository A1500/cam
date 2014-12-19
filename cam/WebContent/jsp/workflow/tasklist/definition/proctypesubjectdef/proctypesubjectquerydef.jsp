<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<style>
a {
	TEXT-DECORATION: none
}
</style>
<title>流程类型层次任务标题查询条件定义</title>
<next:ScriptManager></next:ScriptManager>
</head>
<%
	String procTypeId = request.getParameter("procTypeId");
    String subjectType = request.getParameter("subjectType");
    String tabId = request.getParameter("tabId");
    if("".equals(tabId) || null == tabId){
      	tabId = "bizQuery";
      }
      int dispalyTab = 0;//0:业务信息 1:流程信息
      int dispalyProcTab = 0;//0:待办 1:已办 2:办结
      if(tabId.equals("bizQuery")){
      	dispalyTab = 0;
      	dispalyProcTab = 0;
      }
      else {
      	dispalyTab = 1;
      	if(tabId.equals("daiBanQuery")){
      		dispalyProcTab = 0;
      	}
      	else if(tabId.equals("yiBanQuery")){
      		dispalyProcTab = 1;
      	}
      	else if(tabId.equals("endQuery")){
      		dispalyProcTab = 2;
      	}
      }
%>
<body>
<model:datasets>
	<model:dataset id="subjectFieldTypeDataSet"
		enumName="SUBJECT_QUERY_DEF.SUBJECT_FIELD_TYPE" autoLoad="true"></model:dataset>
	<model:dataset pageSize="15" id="procTypeSubjectQueryDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true" method="queryProcTypeSubjectQueryDef">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="procTypeDaiBanSubjectQueryDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true" method="queryProcTypeDaiBanTaskSubjectQueryDef">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="procTypeYiBanSubjectQueryDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true" method="queryProcTypeYiBanTaskSubjectQueryDef">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="procTypeEndSubjectQueryDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true" method="queryProcTypeEndTaskSubjectQueryDef">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQueryDef"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
<next:TabPanel name="tabpanel-div" height="590" activeTab="<%=dispalyTab %>">
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Tabs>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
			<next:Panel title="业务标题查询定义">
				<next:AnchorLayout>
					<next:EditGridPanel id="procTypeSubjectQueryGridPanel"
						name="procTypeSubjectQueryGridPanel" anchor="100%" height="100%"
						dataset="procTypeSubjectQueryDefDataset"    
						title="查询条件定义">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:CheckBoxColumn></next:CheckBoxColumn>
							<next:Column id="id" header="内码" field="id" width="50"
								hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="流程类型定义Id" field="processType" width="10"
								hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="业务字段主键" id="subjectDefUniqueId"
								field="subjectDefUniqueId" width="200" hidden="true">
								<next:TextField allowBlank="true" />
							</next:Column>
							<next:Column header="查询字段值" field="subjectKey" width="200"
								editable="false">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="查询字段显示名称" field="subjectAlias" width="200"
								editable="false">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
								<next:NumberField allowBlank="true" />
							</next:Column>
							<next:Column id="subjectFieldType" header="查询字段域类型"
								field="subjectFieldType" width="150">
								<next:ComboBox triggerAction="all"
									dataset="subjectFieldTypeDataSet" typeAble="false"/>
							</next:Column>
						</next:Columns>
						<next:TopBar>
						    <next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="add" text="通用帮助定义"
								handler="forCommonHelp" />
							<next:ToolBarItem iconCls="add" text="下拉框定义"
								handler="forSelect" />
							<next:ToolBarItem iconCls="save" text="保存" handler="forSave" />
							<next:ToolBarItem iconCls="undo" text="返回"
								handler="backToProcTypeSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="procTypeSubjectQueryDefDataset" />
						</next:BottomBar>
					</next:EditGridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Center>
			<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
			<next:Panel title="流程标题查询条件定义">
			<next:TabPanel name="tabpanel-div" height="590" activeTab="<%=dispalyProcTab %>" id="procTabs">
			<next:Tabs>
			<next:Panel title="待办任务查询条件定义" id="daiBanTab">
					<next:EditGridPanel id="procTypeDaiBanProSubjectQueryGridPanel"
						name="procTypeDaiBanProSubjectQueryGridPanel" anchor="100%" height="100%"
						dataset="procTypeDaiBanSubjectQueryDefDataset"    
						title="查询条件定义">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:CheckBoxColumn></next:CheckBoxColumn>
							<next:Column id="id" header="内码" field="id" width="50"
								hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="流程类型定义Id" field="processType" width="10"
								hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="流程字段主键" id="subjectDefUniqueId"
								field="subjectDefUniqueId" width="200" hidden="true">
								<next:TextField allowBlank="true" />
							</next:Column>
							<next:Column header="查询字段值" field="subjectKey" width="200"
								editable="false">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="查询字段显示名称" field="subjectAlias" width="200"
								editable="false">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
								<next:NumberField allowBlank="true" />
							</next:Column>
							<next:Column id="subjectFieldType" header="查询字段域类型" editable="false"
								field="subjectFieldType" width="150">
								<next:ComboBox triggerAction="all" editable="false"
									dataset="subjectFieldTypeDataSet" typeAble="false"/>
							</next:Column>
						</next:Columns>
						<next:TopBar>
						    <next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="save" text="保存" handler="forDaiBanSubjectQueryDefSave" />
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToDaiBanProcTypeSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="procTypeDaiBanSubjectQueryDefDataset" />
						</next:BottomBar>
					</next:EditGridPanel>
					</next:Panel>
					<next:Panel title="已办任务查询条件定义" id="yiBanTab">
					<next:EditGridPanel id="procTypeYiBanProSubjectQueryGridPanel"
						name="procTypeYiBanProSubjectQueryGridPanel" anchor="100%" height="100%"
						dataset="procTypeYiBanSubjectQueryDefDataset"    
						title="查询条件定义">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:CheckBoxColumn></next:CheckBoxColumn>
							<next:Column id="id" header="内码" field="id" width="50"
								hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="流程类型定义Id" field="processType" width="10"
								hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="流程字段主键" id="subjectDefUniqueId"
								field="subjectDefUniqueId" width="200" hidden="true">
								<next:TextField allowBlank="true" />
							</next:Column>
							<next:Column header="查询字段值" field="subjectKey" width="200"
								editable="false">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="查询字段显示名称" field="subjectAlias" width="200"
								editable="false">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
								<next:NumberField allowBlank="true" />
							</next:Column>
							<next:Column id="subjectFieldType" header="查询字段域类型"
								field="subjectFieldType" width="150">
								<next:ComboBox triggerAction="all" editable="false"
									dataset="subjectFieldTypeDataSet" typeAble="false"/>
							</next:Column>
						</next:Columns>
						<next:TopBar>
						    <next:ToolBarItem symbol="->"></next:ToolBarItem>
                    		<next:ToolBarItem iconCls="save" text="保存" handler="forYiBanSubjectQueryDefSave" />
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToYiBanProcTypeSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="procTypeYiBanSubjectQueryDefDataset" />
						</next:BottomBar>
					</next:EditGridPanel>
					</next:Panel>
					<next:Panel title="办结任务查询条件定义" id="endTab">
					<next:EditGridPanel id="procTypeEndProSubjectQueryGridPanel"
						name="procTypeEndProSubjectQueryGridPanel" anchor="100%" height="100%"
						dataset="procTypeEndSubjectQueryDefDataset"    
						title="查询条件定义">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:CheckBoxColumn></next:CheckBoxColumn>
							<next:Column id="id" header="内码" field="id" width="50"
								hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="流程类型定义Id" field="processType" width="10"
								hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="流程字段主键" id="subjectDefUniqueId"
								field="subjectDefUniqueId" width="200" hidden="true">
								<next:TextField allowBlank="true" />
							</next:Column>
							<next:Column header="查询字段值" field="subjectKey" width="200"
								editable="false">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="查询字段显示名称" field="subjectAlias" width="200"
								editable="false">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
								<next:NumberField allowBlank="true" />
							</next:Column>
							<next:Column id="subjectFieldType" header="查询字段域类型"
								field="subjectFieldType" width="150">
								<next:ComboBox triggerAction="all" editable="false"
									dataset="subjectFieldTypeDataSet" typeAble="false"/>
							</next:Column>
						</next:Columns>
						<next:TopBar>
						    <next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="save" text="保存" handler="forEndSubjectQueryDefSave" />
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToEndProcTypeSubjectDefList" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="procTypeEndSubjectQueryDefDataset" />
						</next:BottomBar>
					</next:EditGridPanel>
					</next:Panel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
		</next:Center>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">
var isDaiBanInit = false;
var isYiBanInit = false;
var isEndInit = false;
function init()
{
	 procTypeSubjectQueryDefDataset.setParameter("typeId","<%=procTypeId%>");
	 procTypeSubjectQueryDefDataset.load();
	 var tabId = '<%=tabId%>';
	 if (tabId == "daiBanQuery"){
			isDaiBanInit = true;
			procTypeDaiBanSubjectQueryDefDataset.setParameter("typeId","<%=procTypeId%>");
			procTypeDaiBanSubjectQueryDefDataset.load();
		}
		if (tabId == "yiBanQuery"){
			isYiBanInit = true;
			procTypeYiBanSubjectQueryDefDataset.setParameter("typeId","<%=procTypeId%>");
			procTypeYiBanSubjectQueryDefDataset.load();
		}
		if (tabId == "endQuery"){
			isEndInit = true;
			procTypeEndSubjectQueryDefDataset.setParameter("typeId","<%=procTypeId%>");
			procTypeEndSubjectQueryDefDataset.load();
		}

	 var tabpanel = L5.getCmp("procTabs");
		tabpanel.on("tabchange", loadTab);
}


function loadTab(tabpanels, tab)
{
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isDaiBanInit == false){
		if(tab.id == "daiBanTab"){
			isDaiBanInit = true;
			 procTypeDaiBanSubjectQueryDefDataset.setParameter("typeId","<%=procTypeId%>");
			 procTypeDaiBanSubjectQueryDefDataset.load();
			
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanInit == false){
		if(tab.id == "yiBanTab"){
			isYiBanInit = true;
			 procTypeYiBanSubjectQueryDefDataset.setParameter("typeId","<%=procTypeId%>");
			 procTypeYiBanSubjectQueryDefDataset.load();
			
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isEndInit == false){
		if(tab.id == "endTab"){
			isEndInit = true;
			 procTypeEndSubjectQueryDefDataset.setParameter("typeId","<%=procTypeId%>");
			 procTypeEndSubjectQueryDefDataset.load();
		}
	}
}

function forCommonHelp(){
	var procTypeSubjectQueryGridPanel = L5.getCmp('procTypeSubjectQueryGridPanel');
	var selected = procTypeSubjectQueryGridPanel.getSelectionModel().getSelections();
	if (selected.length ==1) {
		var rec=selected[0];
		var subjectQueryDefUniqueId=rec.get("id");
		if(rec.get("subjectFieldType")=="2"){
			var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectquerycommonhelpdef.jsp?procTypeId="+"<%=procTypeId%>"+"&subjectQueryDefUniqueId="+subjectQueryDefUniqueId;
			L5.forward(url,"通用帮助定义");
			}else{
				L5.Msg.alert("提示", "请先定义字段域为通用帮助定义！");
				return false;
				}
		
	}else{
		L5.Msg.alert("提示", "请选择一条记录！");
		return false;
		}
}
function forSave()
{
	var isValidate = procTypeSubjectQueryDefDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = procTypeSubjectQueryDefDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveProcTypeSubjectQueryDef");
	if (!command.error) {
		procTypeSubjectQueryDefDataset.commitChanges();
		procTypeSubjectQueryDefDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

function forDaiBanSubjectQueryDefSave(){
	var records = procTypeDaiBanSubjectQueryDefDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveProcTypeDaiBanTaskSubjectQueryDef");
	if (!command.error) {
		procTypeDaiBanSubjectQueryDefDataset.commitChanges();
		procTypeDaiBanSubjectQueryDefDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

function forYiBanSubjectQueryDefSave(){
	var records = procTypeYiBanSubjectQueryDefDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveProcTypeYiBanTaskSubjectQueryDef");
	if (!command.error) {
		procTypeYiBanSubjectQueryDefDataset.commitChanges();
		procTypeYiBanSubjectQueryDefDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

function forEndSubjectQueryDefSave(){
	var records = procTypeEndSubjectQueryDefDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveProcTypeEndTaskSubjectQueryDef");
	if (!command.error) {
		procTypeEndSubjectQueryDefDataset.commitChanges();
		procTypeEndSubjectQueryDefDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

function forSelect(){
	var procTypeSubjectQueryGridPanel = L5.getCmp('procTypeSubjectQueryGridPanel');
	var selected = procTypeSubjectQueryGridPanel.getSelectionModel().getSelections();
	if (selected.length ==1) {
		var rec=selected[0];
		var subjectQueryDefUniqueId=rec.get("id");
		if(rec.get("subjectFieldType")=="1"){
			var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectqueryselectdef.jsp?procTypeId="+"<%=procTypeId%>"+"&subjectQueryDefUniqueId="+subjectQueryDefUniqueId;
			L5.forward(url,"下拉框定义");
			}else{
				L5.Msg.alert("提示", "请先定义字段域为下拉框定义！");
				return false;
				}
		
	}else{
		L5.Msg.alert("提示", "请选择一条记录！");
		return false;
		}
}

function backToProcTypeSubjectDefList()
{
	var subjectType = '<%=subjectType%>'
	    if(subjectType=="bizTable"){
	    	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithbiztable.jsp?procTypeId="+"<%=procTypeId%>";
	    }else{
	    	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithformfield.jsp?procTypeId="+"<%=procTypeId%>";
	    }
	
	L5.forward(url,"流程类型层次任务标题");
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
</script>
</html>