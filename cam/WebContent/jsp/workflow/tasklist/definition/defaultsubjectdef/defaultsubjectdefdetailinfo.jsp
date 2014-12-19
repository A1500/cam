<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>标题定义</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>

<model:datasets>
    <model:dataset id="isQueryConditionDataset" enumName="SUBJECT_DEF.IS_QUERY_CONDITION"	autoLoad="true"></model:dataset>
	<model:dataset pageSize="15" id="defaultDaiBanSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd" autoLoad="false" global="true" method="queryDefaultDaiBanTaskProcSubjectDefDetailInfoInit">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="toDaiBanDataset" cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd" autoLoad="false" global="true" method="queryDefaultDaiBanTaskProcSubjectDefDetailInfo">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="defaultYiBanSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd" autoLoad="false" global="true" method="queryDefaultYiBanTaskProcSubjectDefDetailInfoInit">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="toYiBanDataset" cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd" autoLoad="false" global="true" method="queryDefaultYiBanTaskProcSubjectDefDetailInfo">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="defaultEndSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd" autoLoad="false" global="true" method="queryDefaultEndTaskProcSubjectDefDetailInfoInit">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="toEndDataset" cmd="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefQueryCmd" autoLoad="false" global="true" method="queryDefaultEndTaskProcSubjectDefDetailInfo">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectDef"></model:record>
	</model:dataset>
	
</model:datasets>

<next:Window id="daiBanWin" title="待办流程标题选择" hidden="true" resizable="false" width="450" height="400" lazyRender="false" closable="false">
  <next:Panel id="extend" border="false" autoScroll="true">
  <next:Html>
    <form  onsubmit="return false" class="L5form">
	  <input type="hidden" systype="itemselector" id="daiBanTask" field="subjectKey">
	    <div id="DaiBanTaskDiv"></div>
	</form>
  </next:Html>
  </next:Panel>
  <next:Buttons>
	<next:ToolButton text="关闭" handler="closeDaiBanWin"></next:ToolButton>
  </next:Buttons>
</next:Window>
	<next:Window id="yiBanWin" title="已办流程标题选择" hidden="true" resizable="false" width="500" height="300" lazyRender="false" closable="false">
		<next:Html>
			<form  onsubmit="return false" class="L5form">
			<input type="hidden" systype="itemselector" id="yiBanTask" field="subjectKey">
			<div id="YiBanTaskDiv">
			</div>
				</form>
		</next:Html>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closeYiBanWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
	<next:Window id="endWin" title="办结流程标题选择" hidden="true" resizable="false" width="500" height="300" lazyRender="false" closable="false">
		<next:Html>
			<form  onsubmit="return false" class="L5form">
			<input type="hidden" systype="itemselector" id="endTask" field="subjectKey">
			<div id="EndTaskDiv">
			</div>
				</form>
		</next:Html>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closeEndWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:TabPanel name="tabpanel-div" height="590" activeTab="0" id="procTabs">
	<next:Tabs>
			<next:EditGridPanel id="defaultDaiBanSubjectGridPanel" name="待办任务标题详细信息" 
			anchor="100%" height="78%" width="64%" dataset="toDaiBanDataset" title="待办任务标题详细信息">
			<next:Columns>
			<next:RowNumberColumn width="30"/>
				<next:Column  header="内码" field="id" width="50" hidden="true">
					  <next:TextField allowBlank="false"/>
					</next:Column>
				<next:Column header="标题值" field="subjectKey" width="100" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示名称" field="subjectAlias" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示顺序" field="subjectOrder" width="80">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="标题显示长度" field="subjectWidth" width="100">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="是否作为查询条件" field="isQueryCondition" width="150">
						<next:ComboBox triggerAction="all" dataset="isQueryConditionDataset" typeAble="false" />
					</next:Column>
					<next:Column header="标题类别" field="subjectCategory" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="任务类型" field="taskType" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					</next:Columns>
					<next:TopBar>	
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add"  text="增加" handler="openDaiBanWin"/>
						<next:ToolBarItem iconCls="save"  text="保存" handler="forDaiBanSave"/>
						<next:ToolBarItem iconCls="detail"  text="预览" handler="forPreview"/>
						<next:ToolBarItem iconCls="add"  text="查询条件定义" handler="forQuery"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="toDaiBanDataset"/>
				</next:BottomBar>
				</next:EditGridPanel>
		
			<next:EditGridPanel id="defaultYiBanSubjectGridPanel" name="已办任务标题详细信息" 
			anchor="100%" height="78%" width="64%" dataset="toYiBanDataset"     title="已办任务标题详细信息">
			<next:Columns>
			<next:RowNumberColumn width="30"/>
				<next:Column  header="内码" field="id" width="50" hidden="true">
					  <next:TextField allowBlank="false"/>
					</next:Column>
				<next:Column header="标题值" field="subjectKey" width="100" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示名称" field="subjectAlias" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示顺序" field="subjectOrder" width="120">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="标题显示长度" field="subjectWidth" width="130">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="是否作为查询条件" field="isQueryCondition" width="150">
						<next:ComboBox triggerAction="all" dataset="isQueryConditionDataset" typeAble="false"/>
					</next:Column>
					<next:Column header="标题类别" field="subjectCategory" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="任务类型" field="taskType" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					</next:Columns>
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
						<next:ToolBarItem iconCls="add"  text="增加" handler="openYiBanWin"/>
						<next:ToolBarItem iconCls="save"  text="保存" handler="forYiBanSave"/>
						<next:ToolBarItem iconCls="detail"  text="预览" handler="forPreview"/>
						<next:ToolBarItem iconCls="add"  text="查询条件定义" handler="forQuery"/>
					</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="toYiBanDataset"/>
				</next:BottomBar>
				</next:EditGridPanel>
			<next:EditGridPanel id="defaultEndSubjectGridPanel" name="办结任务标题详细信息" 
			anchor="100%" height="78%" width="64%" dataset="toEndDataset"     title="办结任务标题详细信息">
			<next:Columns>
			<next:RowNumberColumn width="30"/>
				<next:Column  header="内码" field="id" width="50" hidden="true">
					  <next:TextField allowBlank="false"/>
					</next:Column>
				<next:Column header="标题值" field="subjectKey" width="100" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示名称" field="subjectAlias" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示顺序" field="subjectOrder" width="120">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="标题显示长度" field="subjectWidth" width="130">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="是否作为查询条件" field="isQueryCondition" width="150">
						<next:ComboBox triggerAction="all" dataset="isQueryConditionDataset" typeAble="false"/>
					</next:Column>
					<next:Column header="标题类别" field="subjectCategory" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="任务类型" field="taskType" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					</next:Columns>
					<next:TopBar>	
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add"  text="增加" handler="openEndWin"/>
						<next:ToolBarItem iconCls="save"  text="保存" handler="forEndSave"/>
						<next:ToolBarItem iconCls="detail"  text="预览" handler="forPreview"/>
						<next:ToolBarItem iconCls="add"  text="查询条件定义" handler="forQuery"/>
					</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="toEndDataset"/>
				</next:BottomBar>
				</next:EditGridPanel>
	</next:Tabs>
</next:TabPanel>


</body>
<script language="javascript"  type="text/javascript" >
var isDaiBanInit = true;
var isYiBanInit = false;
var isEndInit = false;

function init(){
	defaultDaiBanSubjectDataset.load();
	toDaiBanDataset.load();
	initDaiBanTaskDiv();
	var tabpanel = L5.getCmp("procTabs");
	tabpanel.on("tabchange", loadTab);
}


function loadTab(tabpanels, tab){
	if(isYiBanInit==false){
		if(tab.id=="defaultYiBanSubjectGridPanel")
		{
			isYiBanInit = true;
			defaultYiBanSubjectDataset.load();
			toYiBanDataset.load();
			initYiBanTaskDiv();
		}
	}
	if(isEndInit==false){
		if(tab.id=="defaultEndSubjectGridPanel")
		{
			isEndInit = true;
			defaultEndSubjectDataset.load();
			toEndDataset.load();
			initEndTaskDiv();
		}
	}
}
function openDaiBanWin()
{
	if(!isDaiBanInit)
	{
		isDaiBanInit=true;
		defaultDaiBanSubjectDataset.load();
		toDaiBanDataset.load();
		initDaiBanTaskDiv();
	}
	
	var win=L5.getCmp('daiBanWin');
	win.show();
}

function openYiBanWin()
{
	if(!isYiBanInit)
	{
		isYiBanInit=true;
		defaultYiBanSubjectDataset.load();
		toYiBanDataset.load();
		initYiBanTaskDiv();
	}

	var win=L5.getCmp('yiBanWin');
	win.show();
}

function openEndWin()
{
	if(!isEndInit)
	{
		isEndInit=true;
		defaultEndSubjectDataset.load();
		toEndDataset.load();
		initEndTaskDiv();
	}

	var win=L5.getCmp('endWin');
	win.show();
}
function closeDaiBanWin()
{
  L5.getCmp('daiBanWin').hide();
}
function closeYiBanWin()
{
	var win=L5.getCmp('yiBanWin').hide();
}
function closeEndWin()
{
	var win=L5.getCmp('endWin').hide();
}
function initDaiBanTaskDiv(){
	new L5.ux.ItemSelector({
		applyTo:"DaiBanTaskDiv",
		id:"daiBanTask",
		name:"subjectAlias",
		field:"subjectKey",
		fromDataset:defaultDaiBanSubjectDataset,
		toDataset:toDaiBanDataset,
		valueField :"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已定制的流程信息",
	    fromLegend:"允许定制的流程信息",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}
function initYiBanTaskDiv(){
	new L5.ux.ItemSelector({
		applyTo:"YiBanTaskDiv",
		id:"yiBanTask",
		name:"subjectAlias",
		field:"subjectKey",
		fromDataset:defaultYiBanSubjectDataset,
		toDataset:toYiBanDataset,
		valueField :"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已定制的流程信息",
	    fromLegend:"允许定制的流程信息",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}
function initEndTaskDiv(){
	new L5.ux.ItemSelector({
		applyTo:"EndTaskDiv",
		id:"endTask",
		name:"subjectAlias",
		field:"subjectKey",
		fromDataset:defaultEndSubjectDataset,
		toDataset:toEndDataset,
		valueField :"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已定制的流程信息",
	    fromLegend:"允许定制的流程信息",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}

function forDaiBanSave(){
	var values=L5.get("daiBanTask").getValue();
	var isValidate = toDaiBanDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	} 
	var records = toDaiBanDataset.getAllChangedRecords();
	if(records.length<1){
		alert("没有可保存数据");
		return;
		}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefCmd");
	command.setParameter("values",values);
	command.setParameter("records", records);
	command.execute("saveDefaultDaiBanTaskSubjectDefDetailInfo");
	if (!command.error) {
		toDaiBanDataset.commitChanges();
		toDaiBanDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function forYiBanSave(){
	var values=L5.get("yiBanTask").getValue();
	var isValidate = toYiBanDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	} 
	var records = toYiBanDataset.getAllChangedRecords();
	if(records.length<1){
		alert("没有可保存数据");
		return;
		}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefCmd");
	command.setParameter("values",values);
	command.setParameter("records", records);
	command.execute("saveDefaultYiBanTaskSubjectDefDetailInfo");
	if (!command.error) {
		toYiBanDataset.commitChanges();
		toYiBanDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function forEndSave(){
	var values=L5.get("EndTask").getValue();
	var isValidate = toEndDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	} 
	var records = toEndDataset.getAllChangedRecords();
	if(records.length<1){
		alert("没有可保存数据");
		return;
		}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.cmd.DefaultSubjectDefCmd");
	command.setParameter("values",values);
	command.setParameter("records", records);
	command.execute("saveDefaultEndTaskSubjectDefDetailInfo");
	if (!command.error) {
		toEndDataset.commitChanges();
		toEndDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

//定义系统全局业务信息查询条件
function forQuery() {
	var url="jsp/workflow/tasklist/definition/defaultsubjectdef/defaultsubjectquerydef.jsp";
	L5.forward(url,"系统全局查询条件定义");
}

//预览
function forPreview() {
	var url="jsp/workflow/tasklist/definition/defaultsubjectdef/defaultsubjectdefpreview.jsp";
	L5.forward(url,"系统全局任务标题预览");
}
</script>
</html>