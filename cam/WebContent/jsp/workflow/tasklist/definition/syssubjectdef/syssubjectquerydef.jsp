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
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>系统全局层次任务标题查询条件定义</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>

<model:datasets>
    <model:dataset id="subjectFieldTypeDataSet" enumName="SUBJECT_QUERY_DEF.SUBJECT_FIELD_TYPE" autoLoad="true"></model:dataset>
	<model:dataset pageSize="15" id="sysSubjectQueryDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="true" global="true" method="querySysSubjectQueryDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysDaiBanSubjectQueryDataset"cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysDaiBanProcSubjectQueryDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysYiBanSubjectQueryDataset"cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysYiBanProcSubjectQueryDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysEndSubjectQueryDataset"cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysEndProcSubjectQueryDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysYiBanAndEndSubjectQueryDataset"cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysYiBanAndEndProcSubjectQueryDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryDef"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:TabPanel name="tabpanel-div" height="590" activeTab="0">
	<next:Tabs>
		<next:Panel title="业务标题查询条件定义">
			<next:BorderLayout>
			<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
			<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			
			<next:EditGridPanel id="sysSubjectQueryGridPanel" name="sysSubjectQueryGridPanel" anchor="100%" height="100%" dataset="sysSubjectQueryDataset"     title="系统全局层次任务标题查询条件定义">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	   				<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段主键" field="subjectDefUniqueId" width="200" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段值" field="subjectKey" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示名称" field="subjectAlias" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段域类型" field="subjectFieldType" width="150">
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" typeAble="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add"  text="通用帮助定义" handler="forCommonHelp"/>
					<next:ToolBarItem iconCls="add"  text="下拉框定义" handler="forSelect"/>			
					<next:ToolBarItem iconCls="save"  text="保存" handler="forSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToSysSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="sysSubjectQueryDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
			
		</next:Center>
		</next:BorderLayout>
	</next:Panel>
	<next:Panel title="流程标题查询条件定义" >
		<next:TabPanel name="tabpanel-div" height="590" activeTab="0" id="procTabs">
		<next:Tabs>
			<next:EditGridPanel id="sysDaiBanSubjectQueryGridPanel" name="sysDaiBanSubjectQueryGridPanel" anchor="100%" height="100%" dataset="sysDaiBanSubjectQueryDataset"     title="系统全局层次任务标题查询条件定义">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	   				<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段主键" field="subjectDefUniqueId" width="200" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段值" field="subjectKey" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示名称" field="subjectAlias" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段域类型" field="subjectFieldType" width="150" editable="false">
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" typeAble="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>	
					<next:ToolBarItem iconCls="save"  text="保存" handler="forDaiBanSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToSysSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="sysDaiBanSubjectQueryDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
		
			<next:EditGridPanel id="sysYiBanSubjectQueryGridPanel" name="sysYiBanSubjectQueryGridPanel" anchor="100%" height="100%" dataset="sysYiBanSubjectQueryDataset"     title="系统全局层次已办任务标题查询条件定义">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	   				<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段主键" field="subjectDefUniqueId" width="200" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段值" field="subjectKey" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示名称" field="subjectAlias" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段域类型" field="subjectFieldType" width="150" editable="false">
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" typeAble="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>	
					<next:ToolBarItem iconCls="save"  text="保存" handler="forYiBanSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToSysSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="sysYiBanSubjectQueryDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="sysEndSubjectQueryGridPanel" name="sysEndSubjectQueryGridPanel" anchor="100%" height="100%" dataset="sysEndSubjectQueryDataset"     title="系统全局层次办结任务标题查询条件定义">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	   				<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段主键" field="subjectDefUniqueId" width="200" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段值" field="subjectKey" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示名称" field="subjectAlias" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段域类型" field="subjectFieldType" width="150" editable="false">
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" typeAble="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>	
					<next:ToolBarItem iconCls="save"  text="保存" handler="forEndSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToSysSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="sysEndSubjectQueryDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="sysYiBanAndEndSubjectQueryGridPanel" name="sysYiBanAndEndSubjectQueryGridPanel" anchor="100%" height="100%" dataset="sysYiBanAndEndSubjectQueryDataset" title="系统全局层次已办办结合并任务标题查询条件定义">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	   				<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段主键" field="subjectDefUniqueId" width="200" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段值" field="subjectKey" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示名称" field="subjectAlias" width="200" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="查询字段显示顺序" field="subjectOrder" width="150">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段域类型" field="subjectFieldType" width="150" editable="false">
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" typeAble="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>	
					<next:ToolBarItem iconCls="save"  text="保存" handler="forYiBanAndEndSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToSysSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="sysYiBanAndEndSubjectQueryDataset"/>
				</next:BottomBar>
				</next:EditGridPanel>
			</next:Tabs>
		</next:TabPanel>

	</next:Panel>
	</next:Tabs>
</next:TabPanel>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
function init(){
	var tabpanel = L5.getCmp("procTabs");
	tabpanel.on("tabchange", loadTab);
}
var isDaiBanInit = false;
var isYiBanInit = false;
var isEndInit = false;
var isYiBanAndEndInit = false;

function loadTab(tabpanels, tab)
{
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isDaiBanInit == false){
		if(tab.id == "sysDaiBanSubjectQueryGridPanel"){
			isDaiBanInit = true;
			sysDaiBanSubjectQueryDataset.load();
			
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanInit == false){
		if(tab.id == "sysYiBanSubjectQueryGridPanel"){
			isYiBanInit = true;
			sysYiBanSubjectQueryDataset.load();
			
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isEndInit == false){
		if(tab.id == "sysEndSubjectQueryGridPanel"){
			isEndInit = true;
			sysEndSubjectQueryDataset.load();
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanAndEndInit == false){
		if(tab.id == "sysYiBanAndEndSubjectQueryGridPanel"){
			isYiBanAndEndInit = true;
			sysYiBanAndEndSubjectQueryDataset.load();
		}
	}
}

 function forCommonHelp(){
	   var sysSubjectQueryGridPanel=L5.getCmp("sysSubjectQueryGridPanel");
	   var selecteds=sysSubjectQueryGridPanel.getSelectionModel().getSelections();

	   if(selecteds.length<1){
		  L5.Msg.alert("提示","请选择一条记录");
		  return false;
		}
		
	   var subjectFieldType=selecteds[0].get("subjectFieldType");
		if(subjectFieldType!=2){
			L5.Msg.alert("提示","请选择查询字段域类型为通用帮助的记录处理!");
			return false;
		}
		
		var subjectQueryDefUniqueId=selecteds[0].get("id");
		var url="jsp/workflow/tasklist/definition/syssubjectdef/syssubjectquerycommonhelpdef.jsp";
		var query="?subjectQueryDefUniqueId="+subjectQueryDefUniqueId;
		L5.forward(url+query,"通用帮助定义");
			
		
	 }

 function forSelect(){
	   var sysSubjectQueryGridPanel=L5.getCmp("sysSubjectQueryGridPanel");
	   var selecteds=sysSubjectQueryGridPanel.getSelectionModel().getSelections();

	   if(selecteds.length<1){
		  L5.Msg.alert("提示","请选择一条记录");
		  return false;
		}
		
	   var subjectFieldType=selecteds[0].get("subjectFieldType");
		if(subjectFieldType!=1){
			L5.Msg.alert("提示","请选择查询字段域类型为下拉框的记录处理!");
			return false;
		}
		
		var subjectQueryDefUniqueId=selecteds[0].get("id");
		var url="jsp/workflow/tasklist/definition/syssubjectdef/syssubjectqueryselectdef.jsp";
		var query="?subjectQueryDefUniqueId="+subjectQueryDefUniqueId;
		L5.forward(url+query,"下拉框定义");
			
		
	 }
 
function forSave()
{
	var isValidate = sysSubjectQueryDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = sysSubjectQueryDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveSysSubjectQueryDef");
	if (!command.error) {
		sysSubjectQueryDataset.commitChanges();
		sysSubjectQueryDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function backToSysSubjectDefList()
{
	var url="jsp/workflow/tasklist/definition/syssubjectdef/syssubjectdefdetailinfo.jsp";
	L5.forward(url,"系统全局任务标题");
}
function forDaiBanSave()
{
	var isValidate = sysDaiBanSubjectQueryDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = sysDaiBanSubjectQueryDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveSysDaiBanTaskSubjectQueryDef");
	if (!command.error) {
		sysDaiBanSubjectQueryDataset.commitChanges();
		sysDaiBanSubjectQueryDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function forYiBanSave()
{
	var isValidate = sysYiBanSubjectQueryDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = sysYiBanSubjectQueryDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveSysYiBanTaskSubjectQueryDef");
	if (!command.error) {
		sysYiBanSubjectQueryDataset.commitChanges();
		sysYiBanSubjectQueryDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function forEndSave()
{
	var isValidate = sysEndSubjectQueryDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = sysEndSubjectQueryDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveSysEndTaskSubjectQueryDef");
	if (!command.error) {
		sysEndSubjectQueryDataset.commitChanges();
		sysEndSubjectQueryDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function forYiBanAndEndSave()
{
	var isValidate = sysYiBanAndEndSubjectQueryDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = sysYiBanAndEndSubjectQueryDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveSysYiBanAndEndTaskSubjectQueryDef");
	if (!command.error) {
		sysYiBanAndEndSubjectQueryDataset.commitChanges();
		sysYiBanAndEndSubjectQueryDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
</script>
</html>