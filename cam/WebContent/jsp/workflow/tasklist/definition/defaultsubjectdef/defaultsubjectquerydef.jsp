<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectQueryDef"%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>任务标题查询条件定义</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>

<model:datasets>
    <model:dataset id="subjectFieldTypeDataSet" enumName="SUBJECT_QUERY_DEF.SUBJECT_FIELD_TYPE" autoLoad="true"></model:dataset>
	
	<model:dataset pageSize="15" id="defaultDaiBanSubjectQueryDataset"cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd" autoLoad="true" global="true" method="queryDefaultDaiBanProcSubjectQueryDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="defaultYiBanSubjectQueryDataset"cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd" autoLoad="false" global="true" method="queryDefaultYiBanProcSubjectQueryDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectQueryDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="defaultEndSubjectQueryDataset"cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd" autoLoad="false" global="true" method="queryDefaultEndProcSubjectQueryDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectQueryDef"></model:record>
	</model:dataset>
</model:datasets>
<next:TabPanel name="tabpanel-div" height="590" activeTab="0" id="procTabs">
		<next:Tabs>
		<next:Panel title="待办任务查询条件定义" id="daiBanTab">
			<next:EditGridPanel id="defaultDaiBanSubjectQueryGridPanel" name="defaultDaiBanSubjectQueryGridPanel" anchor="100%" height="100%" dataset="defaultDaiBanSubjectQueryDataset"     title="系统全局层次任务标题查询条件定义">
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
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" />
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="save"  text="保存" handler="forDaiBanSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToSysSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="defaultDaiBanSubjectQueryDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Panel>
		<next:Panel title="已办任务查询条件定义" id="yiBanTab">
			<next:EditGridPanel id="defaultYiBanSubjectQueryGridPanel" name="defaultYiBanSubjectQueryGridPanel" anchor="100%" height="100%" dataset="defaultYiBanSubjectQueryDataset"     title="系统全局层次已办任务标题查询条件定义">
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
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" />
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="save"  text="保存" handler="forYiBanSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToSysSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="defaultYiBanSubjectQueryDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Panel>
		<next:Panel title="办结任务查询条件定义" id="endTab">
			<next:EditGridPanel id="defaultEndSubjectQueryGridPanel" name="defaultEndSubjectQueryGridPanel" anchor="100%" height="100%" dataset="defaultEndSubjectQueryDataset"     title="系统全局层次办结任务标题查询条件定义">
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
						<next:ComboBox triggerAction="all" dataset="subjectFieldTypeDataSet" />
					</next:Column>
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>	
					<next:ToolBarItem iconCls="save"  text="保存" handler="forEndSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToSysSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="defaultEndSubjectQueryDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</body>
<script language="javascript"  type="text/javascript" >
function init(){
	var tabpanel = L5.getCmp("procTabs");
	tabpanel.on("tabchange", loadTab);
}
var isYiBanInit = false;
var isEndInit = false;
function loadTab(tabpanels, tab)
{
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanInit == false){
		if(tab.id == "yiBanTab"){
			isYiBanInit = true;
			defaultYiBanSubjectQueryDataset.load();
			
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isEndInit == false){
		if(tab.id == "endTab"){
			isEndInit = true;
			defaultEndSubjectQueryDataset.load();
		}
	}
}
function backToSysSubjectDefList()
{
	var url="jsp/workflow/tasklist/definition/defaultsubjectdef/defaultsubjectdefdetailinfo.jsp";
	L5.forward(url,"系统全局任务标题");
}
function forDaiBanSave()
{
	var isValidate = defaultDaiBanSubjectQueryDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = defaultDaiBanSubjectQueryDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveDefaultDaiBanTaskProcSubjectQueryDef");
	if (!command.error) {
		defaultDaiBanSubjectQueryDataset.commitChanges();
		defaultDaiBanSubjectQueryDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function forYiBanSave()
{
	var isValidate = defaultYiBanSubjectQueryDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = defaultYiBanSubjectQueryDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveDefaultYiBanTaskProcSubjectQueryDef");
	if (!command.error) {
		defaultYiBanSubjectQueryDataset.commitChanges();
		defaultYiBanSubjectQueryDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function forEndSave()
{
	var isValidate = defaultEndSubjectQueryDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = defaultEndSubjectQueryDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveDefaultEndTaskProcSubjectQueryDef");
	if (!command.error) {
		defaultEndSubjectQueryDataset.commitChanges();
		defaultEndSubjectQueryDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
</script>
</html>