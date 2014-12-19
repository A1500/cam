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
	<model:dataset pageSize="15" id="sysSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="true" global="true" method="querySysSubjectDefDetailInfo">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysDaiBanSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysDaiBanTaskProcSubjectDefDetailInfoInit">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="toDaiBanDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysDaiBanTaskProcSubjectDefDetailInfo">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysYiBanSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysYiBanTaskProcSubjectDefDetailInfoInit">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="toYiBanDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysYiBanTaskProcSubjectDefDetailInfo">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="sysEndSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysEndTaskProcSubjectDefDetailInfoInit">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="toEndDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysEndTaskProcSubjectDefDetailInfo">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"></model:record>
	</model:dataset>
	
	<model:dataset pageSize="15" id="sysYiBanAndEndSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysYiBanAndEndTaskProcSubjectDefDetailInfoInit">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="toYiBanAndEndDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" global="true" method="querySysYiBanAndEndTaskProcSubjectDefDetailInfo">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"></model:record>
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
<next:Window id="yiBanAndEndWin" title="已办办结合并流程标题选择" hidden="true" resizable="false" width="500" height="300" lazyRender="false" closable="false">
	<next:Html>
		<form onsubmit="return false" class="L5form">
		<input type="hidden" systype="itemselector" id="yiBanAndEndTask" field="subjectKey">
		<div id="YiBanAndEndTaskDiv"></div>
		</form>
	</next:Html>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closeYiBanAndEndWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:TabPanel name="tabpanel-div" height="590" activeTab="0">
<next:Tabs>
<next:Panel title="业务标题定义">
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			
			<next:EditGridPanel id="sysSubjectGridPanel" name="sysSubjectGridPanel" anchor="100%" height="100%" dataset="sysSubjectDataset"     title="系统全局层次任务标题详细信息">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题值" field="subjectKey" width="200">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示名称" field="subjectAlias" width="200">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示顺序" field="subjectOrder" width="150">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="标题显示长度" field="subjectWidth" width="150">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="是否作为查询条件" field="isQueryCondition" width="150">
						<next:ComboBox triggerAction="all" dataset="isQueryConditionDataset" typeAble="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="add"  text="新增" handler="forInsert"/>
					<next:ToolBarItem iconCls="delete"  text="删除" handler="forDelete"/>
					<next:ToolBarItem iconCls="undo"  text="取消" handler="forCancel"/>
					<next:ToolBarItem iconCls="save"  text="保存" handler="forSave"/>
					<next:ToolBarItem iconCls="add"  text="查询条件定义" handler="forQuery"/>
					<next:ToolBarItem iconCls="detail"  text="预览" handler="forPreview"></next:ToolBarItem>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="sysSubjectDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>			
		</next:Center>
	</next:BorderLayout>
</next:Panel>
<next:Panel title="流程标题定义">
<next:TabPanel name="tabpanel-div" height="590" activeTab="0" id="procTabs">
	<next:Tabs>
			<next:EditGridPanel id="sysDaiBanSubjectGridPanel" name="sysDaiBanSubjectGridPanel" anchor="100%" height="78%" width="64%" dataset="toDaiBanDataset"     title="系统全局层次待办任务标题详细信息">
			<next:Columns>
			<next:RowNumberColumn width="30"/>
				<next:Column  header="内码" field="id" width="50" hidden="true">
					  <next:TextField allowBlank="false"/>
					</next:Column>
				<next:Column header="标题值" field="subjectKey" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示名称" field="subjectAlias" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示顺序" field="subjectOrder" width="100">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="标题显示长度" field="subjectWidth" width="100">
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
						<next:ToolBarItem iconCls="add"  text="增加" handler="openDaiBanWin"/>
						<next:ToolBarItem iconCls="save"  text="保存" handler="forDaiBanSave"/>
						<next:ToolBarItem iconCls="detail"  text="预览" handler="forPreview"/>
						<next:ToolBarItem iconCls="add"  text="查询条件定义" handler="forQuery"/>
					</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="toDaiBanDataset"/>
				</next:BottomBar>
				</next:EditGridPanel>
			<next:EditGridPanel id="sysYiBanSubjectGridPanel" name="sysYiBanSubjectGridPanel" anchor="100%" height="78%" width="64%" dataset="toYiBanDataset"     title="系统全局层次已办任务标题详细信息">
			<next:Columns>
			<next:RowNumberColumn width="30"/>
				<next:Column  header="内码" field="id" width="50" hidden="true">
					  <next:TextField allowBlank="false"/>
					</next:Column>
				<next:Column header="标题值" field="subjectKey" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示名称" field="subjectAlias" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示顺序" field="subjectOrder" width="100">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="标题显示长度" field="subjectWidth" width="100">
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
			<next:EditGridPanel id="sysEndSubjectGridPanel" name="sysEndSubjectGridPanel" anchor="100%" height="78%" width="64%" dataset="toEndDataset"     title="系统全局层次办结任务标题详细信息">
			<next:Columns>
			<next:RowNumberColumn width="30"/>
				<next:Column  header="内码" field="id" width="50" hidden="true">
					  <next:TextField allowBlank="false"/>
					</next:Column>
				<next:Column header="标题值" field="subjectKey" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示名称" field="subjectAlias" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示顺序" field="subjectOrder" width="100">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="标题显示长度" field="subjectWidth" width="100">
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
			<next:EditGridPanel id="sysYiBanAndEndSubjectGridPanel" name="sysYiBanAndEndSubjectGridPanel" anchor="100%" height="78%" width="64%" dataset="toYiBanAndEndDataset"     title="系统全局层次已办办结合并任务标题详细信息">
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:Column  header="内码" field="id" width="50" hidden="true">
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题值" field="subjectKey" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示名称" field="subjectAlias" width="150" editable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示顺序" field="subjectOrder" width="100">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="标题显示长度" field="subjectWidth" width="100">
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
					<next:ToolBarItem iconCls="add"  text="增加" handler="openYiBanAndEndWin"/>
					<next:ToolBarItem iconCls="save"  text="保存" handler="forYiBanAndEndSave"/>
					<next:ToolBarItem iconCls="detail"  text="预览" handler="forPreview"/>
					<next:ToolBarItem iconCls="add"  text="查询条件定义" handler="forQuery"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="toYiBanAndEndDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
	</next:Tabs>
</next:TabPanel>

</next:Panel>
</next:Tabs>
</next:TabPanel>

</body>
<script language="javascript"  type="text/javascript" >
function init() {
	var tabpanel = L5.getCmp("procTabs");
		tabpanel.on("tabchange", loadTab);
	
}
var isDaiBanInit = false;
var isYiBanInit = false;
var isEndInit = false;
var isYiBanAndEndInit = false;


function openDaiBanWin()
{
	var win=L5.getCmp('daiBanWin');
	win.show();
}

function openYiBanWin()
{
	var win=L5.getCmp('yiBanWin');
	win.show();
}

function openEndWin()
{
	var win=L5.getCmp('endWin');
	win.show();
}

function openYiBanAndEndWin()
{
	var win=L5.getCmp('yiBanAndEndWin');
	win.show();
}

function loadTab(tabpanels, tab)
{
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isDaiBanInit == false){
		if(tab.id == "sysDaiBanSubjectGridPanel"){
			isDaiBanInit = true;
			sysDaiBanSubjectDataset.load();
			toDaiBanDataset.load();
			initDaiBanTaskDiv()
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanInit == false){
		if(tab.id == "sysYiBanSubjectGridPanel"){
			isYiBanInit = true;
			sysYiBanSubjectDataset.load();
			toYiBanDataset.load();
			initYiBanTaskDiv()
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isEndInit == false){
		if(tab.id == "sysEndSubjectGridPanel"){
			isEndInit = true;
			sysEndSubjectDataset.load();
			toEndDataset.load();
			initEndTaskDiv()
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanAndEndInit == false){
		if(tab.id == "sysYiBanAndEndSubjectGridPanel"){
			isYiBanAndEndInit = true;
			sysYiBanAndEndSubjectDataset.load();
			toYiBanAndEndDataset.load();
			initYiBanAndEndTaskDiv()
		}
	}
}
function initDaiBanTaskDiv(){
	new L5.ux.ItemSelector({
		applyTo:"DaiBanTaskDiv",
		id:"daiBanTask",
		name:"subjectAlias",
		field:"subjectKey",
		fromDataset:sysDaiBanSubjectDataset,
		toDataset:toDaiBanDataset,
		valueField :"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已定制的标题信息",
	    fromLegend:"允许定制的标题信息",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}
function initYiBanTaskDiv(){
	new L5.ux.ItemSelector({
		applyTo:"YiBanTaskDiv",
		id:"YiBanTask",
		name:"subjectAlias",
		field:"subjectKey",
		fromDataset:sysYiBanSubjectDataset,
		toDataset:toYiBanDataset,
		valueField :"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已定制的标题信息",
	    fromLegend:"允许定制的标题信息",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}
function initEndTaskDiv(){
	new L5.ux.ItemSelector({
		applyTo:"EndTaskDiv",
		id:"EndTask",
		name:"subjectAlias",
		field:"subjectKey",
		fromDataset:sysEndSubjectDataset,
		toDataset:toEndDataset,
		valueField :"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已定制的标题信息",
	    fromLegend:"允许定制的标题信息",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}
function initYiBanAndEndTaskDiv(){
	new L5.ux.ItemSelector({
		applyTo:"YiBanAndEndTaskDiv",
		id:"YiBanAndEndTask",
		name:"subjectAlias",
		field:"subjectKey",
		fromDataset:sysYiBanAndEndSubjectDataset,
		toDataset:toYiBanAndEndDataset,
		valueField :"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已定制的标题信息",
	    fromLegend:"允许定制的标题信息",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
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
function closeYiBanAndEndWin()
{
	var win=L5.getCmp('yiBanAndEndWin').hide();
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
		L5.Msg.alert("提示","没有需要保存的数据!");
		return;
		}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("values",values);
	command.setParameter("records", records);
	command.execute("saveSysDaiBanTaskProcSubjectDefDetailInfo");
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
		L5.Msg.alert("提示","没有需要保存的数据!");
		return;
		}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("values",values);
	command.setParameter("records", records);
	command.execute("saveSysYiBanTaskProcSubjectDefDetailInfo");
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
		L5.Msg.alert("提示","没有需要保存的数据!");
		return;
		}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("values",values);
	command.setParameter("records", records);
	command.execute("saveSysEndTaskProcSubjectDefDetailInfo");
	if (!command.error) {
		toEndDataset.commitChanges();
		toEndDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function forYiBanAndEndSave(){
	var values=L5.get("YiBanAndEndTask").getValue();
	var isValidate = toYiBanAndEndDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	} 
	var records = toYiBanAndEndDataset.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert("提示","没有需要保存的数据!");
		return;
		}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("values",values);
	command.setParameter("records", records);
	command.execute("saveSysYiBanAndEndTaskProcSubjectDefDetailInfo");
	if (!command.error) {
		toYiBanAndEndDataset.commitChanges();
		toYiBanAndEndDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
function forInsert()
{
	sysSubjectDataset.newRecord({"id":"","subjectKey":"","subjectAlias":"","subjectOrder":"","subjectWidth":"150","isQueryCondition":"1","bizColumnId":""});
}
function forSave()
{
	var isValidate = sysSubjectDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = sysSubjectDataset.getAllChangedRecords();
	if (records.length < 1) {// 没有做任何修改,返回
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveSysSubjectDefDetailInfo");
	if (!command.error) {
		sysSubjectDataset.commitChanges();
		sysSubjectDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
//删除
function forDelete()
{
	var sysSubjectGridPanel = L5.getCmp('sysSubjectGridPanel');
	// 判断是否选择了要删除的记录
	var selected = sysSubjectGridPanel.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert("提示", "请选择要删除的记录！");
		return false;
	}
	var msg = "确定要删除选中的记录吗？";
	var isQueryCondition = selected[0].get("isQueryCondition");
	if(isQueryCondition == "1"){
		msg = msg+"您定制的查询条件信息也会随之删除!"
		}
	L5.MessageBox.confirm('确定', msg, function(state){
		if(state=="yes"){
			var deleteSelected = [];
			for (var i = 0; i < selected.length; i++) {
				if (selected[i].state == 1) {
					sysSubjectDataset.remove(selected[i]);
				} else {
					deleteSelected[i] = selected[i];
				}
			}
			if (deleteSelected.length < 1) {
				return;
			} else {
				var command = new L5.Command(
					"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
				command.setParameter("selected" , deleteSelected);
				command.execute("delete");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功!");
					sysSubjectDataset.load();
				} else {
					alert(command.error);
				}
			}
		}else{
			return false;
		}
	});
}
//取消
function forCancel()
{
	sysSubjectDataset.rejectChanges();
}
//定义系统全局业务信息查询条件
function forQuery() {
	var url="jsp/workflow/tasklist/definition/syssubjectdef/syssubjectquerydef.jsp";
	L5.forward(url,"系统全局查询条件定义");
}

//预览
function forPreview() {
	var url="jsp/workflow/tasklist/definition/syssubjectdef/syssubjectdefpreview.jsp";
	L5.forward(url,"系统全局任务标题预览");
}
</script>
</html>