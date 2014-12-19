<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>流程定义层次任务标题查询条件定义</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<%
  String procDefUniqueId=request.getParameter("procDefUniqueId");
  String tabId = request.getParameter("tabId");//用于确定首先加载哪个tab页
  String type = request.getParameter("type");
  if("".equals(tabId) || null == tabId){
  	tabId = "bizTable";
  }
  int dispalyTab = 0;//0:业务信息 1:流程信息
  int dispalyProcTab = 0;//0:待办 1:已办 2:办结
  if(tabId.equals("bizTable")){
  	dispalyTab = 0;
  	dispalyProcTab = 0;
  }
  else {
  	dispalyTab = 1;
  	if(tabId.equals("daiBanTask")){
  		dispalyProcTab = 0;
  	}
  	else if(tabId.equals("yiBanTask")){
  		dispalyProcTab = 1;
  	}
  	else if(tabId.equals("endTask")){
  		dispalyProcTab = 2;
  	}
  }
%>

<body>
<model:datasets>
    <model:dataset id="subjectFieldTypeDataSet" enumName="SUBJECT_QUERY_DEF.SUBJECT_FIELD_TYPE" autoLoad="true"></model:dataset>
	<model:dataset id="procSubjectQueryDefDataset" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" pageSize="15" autoLoad="false" global="true" method="queryProcSubjectQueryDef">
       <model:record fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset id="procSubjectQueryDefDatasetDaiBan" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" pageSize="15" autoLoad="false" global="true" method="queryProcDaiBanTaskProcSubjectQueryDefWithBizTable">
       <model:record fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset id="procSubjectQueryDefDatasetYiBan" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" pageSize="15" autoLoad="false" global="true" method="queryProcYiBanTaskProcSubjectQueryDefWithBizTable">
       <model:record fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset id="procSubjectQueryDefDatasetEnd" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" pageSize="15" autoLoad="false" global="true" method="queryProcEndTaskProcSubjectQueryDefWithBizTable">
       <model:record fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQueryDef"></model:record>
	</model:dataset>
</model:datasets>

<next:TabPanel  name="tabpanel-div" height="590" activeTab="<%=dispalyTab %>">
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
			<next:Tabs>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel title="业务标题查询条件定义">
			<next:EditGridPanel id="procSubjectGridPanel" name="procSubjectGridPanel" anchor="100%" height="100%" dataset="procSubjectQueryDefDataset"     title="流程定义层次任务标题查询条件定义">
				<next:Columns>
	   				<next:RowNumberColumn width="30" />
	   				<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="10" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段主键" field="subjectDefUniqueId" width="200" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column id="procDefUniqueId" header="流程定义唯一Id" field="procDefUniqueId" width="10" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段值" field="subjectKey" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示名称" field="subjectAlias" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column id="subjectFieldType" header="查询字段域类型" field="subjectFieldType" width="150">
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" typeAble="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add"  text="通用帮助定义" handler="forCommonHelp"/> 	
					<next:ToolBarItem iconCls="add"  text="下拉框定义" handler="forSelect"/> 			
					<next:ToolBarItem iconCls="save"  text="保存" handler="forSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procSubjectQueryDefDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
			</next:Panel>
		</next:Center>
		
		<next:Panel title="流程标题查询条件定义">
		<next:TabPanel  name="tabpanel-div" height="590"  activeTab="<%=dispalyProcTab %>" id="procTabs">
			<next:Tabs>
				<next:Panel title="待办任务标题查询条件定义" id="daiBanTab">
				<next:AnchorLayout>
				<next:EditGridPanel id="procSubjectDaiBanGridPanel" name="procSubjectDaiBanGridPanel" anchor="100%" height="100%" dataset="procSubjectQueryDefDatasetDaiBan"     title="流程定义层次待办任务标题查询条件定义">
				<next:Columns>
	   				<next:RowNumberColumn width="30" />
	   				<next:RadioBoxColumn />
					<next:Column id="id" header="内码" field="id" width="10" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段主键" field="subjectDefUniqueId" width="200" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column id="procDefUniqueId" header="流程定义唯一Id" field="procDefUniqueId" width="10" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段值" field="subjectKey" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示名称" field="subjectAlias" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示顺序" field="subjectOrder" width="150" >
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column id="subjectFieldType" header="查询字段域类型" field="subjectFieldType" width="150" editable="false">
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" />
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="save"  text="保存" handler="forSaveDaiBan"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procSubjectQueryDefDatasetDaiBan"/>
				</next:BottomBar>
			</next:EditGridPanel>
			</next:AnchorLayout>
				</next:Panel>
				<next:Panel title="已办任务标题查询条件定义" id="yiBanTab">
				<next:AnchorLayout>
				<next:EditGridPanel id="procSubjectYiBanGridPanel" name="procSubjectYiBanGridPanel" anchor="100%" height="100%" dataset="procSubjectQueryDefDatasetYiBan"     title="流程定义层次已办任务标题查询条件定义">
				<next:Columns>
	   				<next:RowNumberColumn width="30" />
	   				<next:RadioBoxColumn />
					<next:Column id="id" header="内码" field="id" width="10" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段主键" field="subjectDefUniqueId" width="200" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column id="procDefUniqueId" header="流程定义唯一Id" field="procDefUniqueId" width="10" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段值" field="subjectKey" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示名称" field="subjectAlias" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示顺序" field="subjectOrder" width="150" >
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column id="subjectFieldType" header="查询字段域类型" field="subjectFieldType" width="150" editable="false">
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" />
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="save"  text="保存" handler="forSaveYiBan"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procSubjectQueryDefDatasetYiBan"/>
				</next:BottomBar>
			</next:EditGridPanel>
			</next:AnchorLayout>
				</next:Panel>
				<next:Panel title="办结任务标题查询条件定义" id="endTab">
					<next:AnchorLayout>
				<next:EditGridPanel id="procSubjectEndGridPanel" name="procSubjectEndGridPanel" anchor="100%" height="100%" dataset="procSubjectQueryDefDatasetEnd"     title="流程定义层次办结任务标题查询条件定义">
				<next:Columns>
	   				<next:RowNumberColumn width="30" />
	   				<next:RadioBoxColumn />
					<next:Column id="id" header="内码" field="id" width="10" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段主键" field="subjectDefUniqueId" width="200" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column id="procDefUniqueId" header="流程定义唯一Id" field="procDefUniqueId" width="10" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段值" field="subjectKey" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示名称" field="subjectAlias" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示顺序" field="subjectOrder" width="150" >
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column id="subjectFieldType" header="查询字段域类型" field="subjectFieldType" width="150" editable="false">
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" />
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="save"  text="保存" handler="forSaveEnd"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procSubjectQueryDefDatasetEnd"/>
				</next:BottomBar>
			</next:EditGridPanel>
			</next:AnchorLayout>
				</next:Panel>
			</next:Tabs>
		</next:TabPanel>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</body>
<script language="javascript"  type="text/javascript" >
var isDaiBanInit = false;//控制待办tab只加载一次
var isYiBanInit = false;//控制已办tab只加载一次
var isEndInit = false;//控制办结tab只加载一次
function init()
{	
	procSubjectQueryDefDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
	procSubjectQueryDefDataset.load();
	var tabId = '<%=tabId%>';
	if (tabId == "daiBanTask"){
		isDaiBanInit = true;
		procSubjectQueryDefDatasetDaiBan.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		procSubjectQueryDefDatasetDaiBan.load();
	}
	if (tabId == "yiBanTask"){
		isYiBanInit = true;
		procSubjectQueryDefDatasetYiBan.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		procSubjectQueryDefDatasetYiBan.load();
	}
	if (tabId == "endTask"){
		isEndInit = true;
		procSubjectQueryDefDatasetEnd.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		procSubjectQueryDefDatasetEnd.load();
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
			procSubjectQueryDefDatasetDaiBan.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			procSubjectQueryDefDatasetDaiBan.load();
		}
	}
	
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanInit == false){
		if(tab.id == "yiBanTab"){
			isYiBanInit = true;
			procSubjectQueryDefDatasetYiBan.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			procSubjectQueryDefDatasetYiBan.load();
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isEndInit == false){
		if(tab.id == "endTab"){
			isEndInit = true;
			procSubjectQueryDefDatasetEnd.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			procSubjectQueryDefDatasetEnd.load();
		}
	}
}

/**
*通用帮助定义，只有在查询字段域类型为通用帮助时有用
*约束：选中一行
*    只有查询条件域类型设置为“通用帮助”的，才可定义通用帮助
*    如果定义了查询条件，没有保存(此时查询条件主键id为空)，不能定义通用帮助
*/
function forCommonHelp()
{
	var procSubjectGrid = L5.getCmp("procSubjectGridPanel");
	var selected = procSubjectGrid.getSelectionModel().getSelections();
	
	if(selected.length < 1){
		L5.Msg.alert("提示","请选择一条记录");
		return false;
	}
	
	if(selected.length > 1){
		L5.Msg.alert("提示","请选择一条记录");
		return false;
	}
	
	var subjectFieldType = selected[0].get("subjectFieldType");
	var subjectQueryDefUniqueId = selected[0].get("id");//查询字段定义唯一id
	var procDefUniqueId = selected[0].get("procDefUniqueId");//流程定义唯一id
	if(subjectFieldType != "2"){
		L5.Msg.alert("提示","字段域类型不是通用帮助");
		return false;
	}
	var url = "jsp/workflow/tasklist/definition/procsubjectdef/procsubjectquerycommonhelpdef.jsp";
	url = url + "?subjectQueryDefUniqueId="+subjectQueryDefUniqueId+"&procDefUniqueId="+procDefUniqueId;
	
	L5.forward(url,"通用帮助定义");
	
}

function forSelect()
{
	var procSubjectGrid = L5.getCmp("procSubjectGridPanel");
	var selected = procSubjectGrid.getSelectionModel().getSelections();
	
	if(selected.length < 1){
		L5.Msg.alert("提示","请选择一条记录");
		return false;
	}
	
	if(selected.length > 1){
		L5.Msg.alert("提示","请选择一条记录");
		return false;
	}
	
	var subjectFieldType = selected[0].get("subjectFieldType");
	var subjectQueryDefUniqueId = selected[0].get("id");//查询字段定义唯一id
	var procDefUniqueId = selected[0].get("procDefUniqueId");//流程定义唯一id
	if(subjectFieldType != "1"){
		L5.Msg.alert("提示","字段域类型不是下拉框");
		return false;
	}
	var url = "jsp/workflow/tasklist/definition/procsubjectdef/procsubjectqueryselectdef.jsp";
	url = url + "?subjectQueryDefUniqueId="+subjectQueryDefUniqueId+"&procDefUniqueId="+procDefUniqueId;
	
	L5.forward(url,"下拉框定义");
	
}
//保存流程定义待办任务查询条件
function forSaveDaiBan()
{
	save("saveProcSubjectDaiBanTaskProcSubjectQueryDef",procSubjectQueryDefDatasetDaiBan);
}

//保存流程定义已办任务查询条件
function forSaveYiBan()
{
	save("saveProcSubjectYiBanTaskProcSubjectQueryDef",procSubjectQueryDefDatasetYiBan);
}
//保存流程定义已办任务查询条件
function forSaveEnd()
{
	save("saveProcSubjectEndTaskProcSubjectQueryDef",procSubjectQueryDefDatasetEnd);
}

//保存流程定义查询条件
function forSave()
{
	save("saveProcSubjectQueryDef",procSubjectQueryDefDataset);
}

//保存流程定义查询条件
function save(functionName,dataset)
{
	var isValidate = dataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = dataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefCmd");
	command.setParameter("records", records);
	command.execute(functionName);
	if (!command.error) {
		dataset.commitChanges();
		dataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

function backToProcSubjectDefList()
{
	var type = '<%=type%>'
    if(type=="biz"){
    	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefdetailinfowithbiztable.jsp?procDefUniqueId="+"<%=procDefUniqueId%>";
    }else{
    	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefdetailinfowithformfield.jsp?procDefUniqueId="+"<%=procDefUniqueId%>";
    }
	
	L5.forward(url,"流程类型层次任务标题");
}
</script>
</html>