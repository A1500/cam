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
<title>流程类型层次任务标题详细信息</title>
<next:ScriptManager></next:ScriptManager>
</head>
<%
	String procTypeId = request.getParameter("procTypeId");
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
	<model:dataset pageSize="15" id="procTypeSubjectDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true"
		method="queryProcTypeSubjectDefDetailInfoWithFormField">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="procTypeDaiBanProcSubjectDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true"
		method="queryProcTypeDaiBanTaskProcSubjectDefDetailInfoWithBizTable">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15"
		id="procTypeDaiBanSelectProcSubjectDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true"
		method="queryProcTypeDaiBanTaskSelectProcSubjectDefDetailInfoWithBizTable">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="procTypeYiBanProcSubjectDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true"
		method="queryProcTypeYiBanTaskProcSubjectDefDetailInfoWithBizTable">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15"
		id="procTypeYiBanSelectProcSubjectDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true"
		method="queryProcTypeYiBanTaskSelectProcSubjectDefDetailInfoWithBizTable">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="procTypeEndProcSubjectDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true"
		method="queryProcTypeEndTaskProcSubjectDefDetailInfoWithBizTable">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectDef"></model:record>
	</model:dataset>
	<model:dataset pageSize="15"
		id="procTypeEndSelectProcSubjectDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true"
		method="queryProcTypeEndTaskSelectProcSubjectDefDetailInfoWithBizTable">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectDef"></model:record>
	</model:dataset>
	<model:dataset id="bizTableDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" global="true" method="queryProcTypeSubjectTableDef">
		<model:record>
			<model:field name="bizTable" type="string" />
			<model:field name="bizTablePk" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="isQueryConditionDataset"
		enumName="SUBJECT_DEF.IS_QUERY_CONDITION" autoLoad="true"></model:dataset>
</model:datasets>

<next:Window id="daiBanWin" title="待办流程标题选择" hidden="true" resizable="false" width="380" height="400" lazyRender="false" closable="false">
  <next:Panel id="extend" border="false" autoScroll="true">
  <next:Html>
    <form  onsubmit="return false" class="L5form">
	  <input type="hidden" systype="itemselector" id="daiBanTask" field="subjectAlias">
	    <div id="daiBanDiv"></div>
	</form>
  </next:Html>
  </next:Panel>
  <next:Buttons>
	<next:ToolButton text="关闭" handler="closeDaiBanWin"></next:ToolButton>
  </next:Buttons>
</next:Window>
	<next:Window id="yiBanWin" title="已办流程标题选择" hidden="true" resizable="false" width="380" height="300" lazyRender="false" closable="false">
		<next:Html>
			<form  onsubmit="return false" class="L5form">
			<input type="hidden" systype="itemselector" id="yiBanTask" field="subjectAlias">
			<div id="yiBanDiv">
			</div>
				</form>
		</next:Html>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closeYiBanWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
	<next:Window id="endWin" title="办结流程标题选择" hidden="true" resizable="false" width="380" height="300" lazyRender="false" closable="false">
		<next:Html>
			<form  onsubmit="return false" class="L5form">
			<input type="hidden" systype="itemselector" id="endTask" field="subjectAlias">
			<div id="endDiv">
			</div>
				</form>
		</next:Html>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closeEndWin"></next:ToolButton>
	</next:Buttons>
</next:Window>

<next:ViewPort>
	<next:TabPanel name="tabpanel-div" height="590" activeTab="<%=dispalyTab %>">
		<next:Defaults>
		{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}
	</next:Defaults>
		<next:Tabs>
			<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel title="业务标题定义">
			<next:AnchorLayout>
			<next:EditGridPanel id="procTypeSubjectGridPanel" name="procTypeSubjectGridPanel" anchor="100%" height="100%" dataset="procTypeSubjectDefDataset"     title="标题详细信息">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程类型定义Id" field="processType" width="10" hidden="true">
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
					<next:ToolBarItem iconCls="add"  text="增加" handler="forInsert"/>
					<next:ToolBarItem iconCls="delete"  text="删除" handler="forDelete"/>
					<next:ToolBarItem iconCls="undo"  text="取消" handler="forCancel"/>
					<next:ToolBarItem iconCls="save"  text="保存" handler="forSave"/>
					<next:ToolBarItem iconCls="add"  text="查询条件定义" handler="forBizQuery"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail"  text="预览" handler="forDaiBanPreview"></next:ToolBarItem>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcTypeSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procTypeSubjectDefDataset"/>
				</next:BottomBar>
			</next:EditGridPanel>
			</next:AnchorLayout>
			</next:Panel>
		</next:Center>
			<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
				<next:Panel title="流程标题定义">
					<next:TabPanel name="tabpanel-div" height="590" activeTab="<%=dispalyProcTab %>" id="procTabs">
						<next:Tabs>							
										<next:EditGridPanel id="procTypeDaiBanProcSubjectGridPanel"
											name="procTypeDaiBanProcSubjectGridPanel" anchor="100%" height="78%" width="64%"
											dataset="procTypeDaiBanSelectProcSubjectDefDataset"
											    title="待办任务标题详细信息">
											<next:Columns>
												<next:RowNumberColumn width="30" />
												<next:CheckBoxColumn></next:CheckBoxColumn>
												<next:Column id="id" header="内码" field="id" hidden="true">
													<next:TextField allowBlank="false" />
												</next:Column>
												<next:Column header="流程类型定义Id" field="processType"
													hidden="true">
													<next:TextField allowBlank="false" />
												</next:Column>
												
												<next:Column header="流程字段显示名称" field="subjectAlias"
													width="150">
													<next:TextField allowBlank="false" />
												</next:Column>
												<next:Column header="流程显示顺序" field="subjectOrder" width="100">
													<next:NumberField allowBlank="true" />
												</next:Column>
												<next:Column header="流程显示长度" field="subjectWidth"
													width="100">
													<next:NumberField allowBlank="true" />
												</next:Column>
												<next:Column header="是否作为查询条件" field="isQueryCondition"
													width="150">
													<next:ComboBox triggerAction="all"
														dataset="isQueryConditionDataset" typeAble="false"/>
												</next:Column>
												<next:Column header="标题类别" field="subjcetCategory"
													hidden="true">
													<next:TextField allowBlank="true" />
												</next:Column>
												<next:Column header="任务类型" field="taskType" hidden="true">
													<next:TextField allowBlank="true" />
												</next:Column>
												<next:Column header="业务字段关联表主键" field="bizColumnId"
													width="200" hidden="true">
												</next:Column>
											</next:Columns>
											<next:TopBar>
											<next:ToolBarItem symbol="->"></next:ToolBarItem>
											<next:ToolBarItem iconCls="add" text="增加" handler="openDaiBanWin" />
												<next:ToolBarItem iconCls="save" text="保存"
													handler="forDaiBanProSubjectSave" />
												<next:ToolBarItem iconCls="add" text="查询条件定义"
													handler="forDaiBanQuery"></next:ToolBarItem>
												<next:ToolBarItem iconCls="detail" text="预览"
													handler="forDaiBanPreview"></next:ToolBarItem>
												<next:ToolBarItem iconCls="undo" text="返回"
													handler="backToProcTypeSubjectDefList" />
											</next:TopBar>
										</next:EditGridPanel>
									
								<next:EditGridPanel id="procTypeYiBanProcSubjectGridPanel"
									name="procTypeYiBanProcSubjectGridPanel" anchor="100%" height="78%" width="64%"
									dataset="procTypeYiBanSelectProcSubjectDefDataset"    
									title="已办任务标题详细信息">
									<next:Columns>
										<next:RowNumberColumn width="30" />
										<next:CheckBoxColumn></next:CheckBoxColumn>
										<next:Column id="id" header="内码" field="id" hidden="true">
											<next:TextField allowBlank="false" />
										</next:Column>
										<next:Column header="流程类型定义Id" field="processType"
											hidden="true">
											<next:TextField allowBlank="false" />
										</next:Column>
										
										<next:Column header="流程字段显示名称" field="subjectAlias"
											width="150">
											<next:TextField allowBlank="false" />
										</next:Column>
										<next:Column header="流程显示顺序" field="subjectOrder" width="100">
											<next:NumberField allowBlank="true" />
										</next:Column>
										<next:Column header="流程显示长度" field="subjectWidth" width="100">
											<next:NumberField allowBlank="true" />
										</next:Column>
										<next:Column header="是否作为查询条件" field="isQueryCondition"
											width="150">
											<next:ComboBox triggerAction="all"
												dataset="isQueryConditionDataset" typeAble="false"/>
										</next:Column>
										<next:Column header="标题类别" field="subjcetCategory"
											hidden="true">
											<next:TextField allowBlank="true" />
										</next:Column>
										<next:Column header="任务类型" field="taskType" hidden="true">
											<next:TextField allowBlank="true" />
										</next:Column>
										<next:Column header="业务字段关联表主键" field="bizColumnId"
											width="200" hidden="true">
										</next:Column>
									</next:Columns>
									<next:TopBar>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="add" text="增加" handler="openYiBanWin" />
										<next:ToolBarItem iconCls="save" text="保存"
											handler="forYiBanProSubjectSave" />
										<next:ToolBarItem iconCls="add" text="查询条件定义"
											handler="forYiBanQuery"></next:ToolBarItem>
										<next:ToolBarItem iconCls="detail" text="预览"
											handler="forYiBanPreview"></next:ToolBarItem>
										<next:ToolBarItem iconCls="undo" text="返回"
											handler="backToProcTypeSubjectDefList" />
									</next:TopBar>
									<next:BottomBar>
										<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
											displayInfo="true"
											dataset="procTypeYiBanSelectProcSubjectDefDataset" />
									</next:BottomBar>
								</next:EditGridPanel>
								
								<next:EditGridPanel id="procTypeEndProcSubjectGridPanel"
									name="procTypeEndProcSubjectGridPanel" anchor="100%" height="78%" width="64%" dataset="procTypeEndSelectProcSubjectDefDataset"
									    title="办结任务标题详细信息">
									<next:Columns>
										<next:RowNumberColumn width="30" />
										<next:CheckBoxColumn></next:CheckBoxColumn>
										<next:Column id="id" header="内码" field="id" 
											hidden="true">
											<next:TextField allowBlank="false" />
										</next:Column>
										<next:Column header="流程类型定义Id" field="processType" 
											hidden="true">
											<next:TextField allowBlank="false" />
										</next:Column>
										
										<next:Column header="流程字段显示名称" field="subjectAlias"
											width="150">
											<next:TextField allowBlank="false" />
										</next:Column>
										<next:Column header="流程显示顺序" field="subjectOrder" width="100">
											<next:NumberField allowBlank="true" />
										</next:Column>
										<next:Column header="流程显示长度" field="subjectWidth" width="100">
											<next:NumberField allowBlank="true" />
										</next:Column>
										<next:Column header="是否作为查询条件" field="isQueryCondition"
											width="150">
											<next:ComboBox triggerAction="all"
												dataset="isQueryConditionDataset" typeAble="false"/>
										</next:Column>
										<next:Column header="标题类别" field="subjcetCategory"
											hidden="true">
											<next:TextField allowBlank="true" />
										</next:Column>
										<next:Column header="任务类型" field="taskType" hidden="true">
											<next:TextField allowBlank="true" />
										</next:Column>
										<next:Column header="业务字段关联表主键" field="bizColumnId"
											width="200" hidden="true">
										</next:Column>
									</next:Columns>
									<next:TopBar>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="add" text="增加" handler="openEndWin" />
										<next:ToolBarItem iconCls="save" text="保存"
											handler="forEndProSubjectSave" />
										<next:ToolBarItem iconCls="add" text="查询条件定义"
											handler="forEndQuery"></next:ToolBarItem>
										<next:ToolBarItem iconCls="detail" text="预览"
											handler="forEndPreview"></next:ToolBarItem>
										<next:ToolBarItem iconCls="undo" text="返回"
											handler="backToProcTypeSubjectDefList" />
									</next:TopBar>
								</next:EditGridPanel>
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
	procTypeSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
	procTypeSubjectDefDataset.load();

	bizTableDataset.setParameter("procTypeId","<%=procTypeId%>");
	bizTableDataset.load();
	
	 var tabId = '<%=tabId%>';
	 if (tabId == "daiBanQuery"){
			isDaiBanInit = true;
			procTypeDaiBanProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeDaiBanProcSubjectDefDataset.load();

			 procTypeDaiBanSelectProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeDaiBanSelectProcSubjectDefDataset.load();
			 initGrantRoleDaiBan();
		}
		if (tabId == "yiBanQuery"){
			isYiBanInit = true;
			procTypeYiBanProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeYiBanProcSubjectDefDataset.load();

			 procTypeYiBanSelectProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeYiBanSelectProcSubjectDefDataset.load();
			 initGrantRoleYiBan();
		}
		if (tabId == "endQuery"){
			isEndInit = true;
			procTypeEndProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeEndProcSubjectDefDataset.load();

			 procTypeEndSelectProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeEndSelectProcSubjectDefDataset.load();
			 initGrantRoleEnd();
		}

	 var tabpanel = L5.getCmp("procTabs");
		tabpanel.on("tabchange", loadTab);

	

}


function loadTab(tabpanels, tab)
{
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isDaiBanInit == false){
		if(tab.id == "procTypeDaiBanProcSubjectGridPanel"){
			isDaiBanInit = true;
			procTypeDaiBanProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeDaiBanProcSubjectDefDataset.load();

			 procTypeDaiBanSelectProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeDaiBanSelectProcSubjectDefDataset.load();
			 initGrantRoleDaiBan();
			
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanInit == false){
		if(tab.id == "procTypeYiBanProcSubjectGridPanel"){
			isYiBanInit = true;
			procTypeYiBanProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeYiBanProcSubjectDefDataset.load();

			 procTypeYiBanSelectProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeYiBanSelectProcSubjectDefDataset.load();
			 initGrantRoleYiBan();
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isEndInit == false){
		if(tab.id == "procTypeEndProcSubjectGridPanel"){
			isEndInit = true;
			procTypeEndProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeEndProcSubjectDefDataset.load();

			 procTypeEndSelectProcSubjectDefDataset.setParameter("procTypeId","<%=procTypeId%>");
			 procTypeEndSelectProcSubjectDefDataset.load();
			 initGrantRoleEnd();
		}
	}
}
function openDaiBanWin()
{
	var win=L5.getCmp('daiBanWin');
	win.show();
}

function openYiBanWin()
{
	if(!isYiBanInit)
	{
		isYiBanInit=true;
		procTypeYiBanProcSubjectDefDataset.load();
		procTypeYiBanSelectProcSubjectDefDataset.load();
		initGrantRoleYiBan();
	}

	var win=L5.getCmp('yiBanWin');
	win.show();
}

function openEndWin()
{
	if(!isEndInit)
	{
		isEndInit=true;
		procTypeEndProcSubjectDefDataset.load();
		procTypeEndSelectProcSubjectDefDataset.load();
		initGrantRoleEnd();
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

function saveBizTable()
{
	var bizTable=document.getElementById("bizTable").value;
	if(bizTable==null||bizTable=="")
	{
		alert("请输入业务表名!");
		return;
	}
	var bizTablePk=document.getElementById("bizTablePk").value;
	if(bizTablePk==null||bizTablePk=="")
	{
		alert("请输入业务表主键名!");
		return;
	}
	
    var command=new L5.Command("org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
    command.setParameter("procTypeId","<%=procTypeId%>");
    command.setParameter("bizTable",bizTable);
    command.setParameter("bizTablePk",bizTablePk);
    command.execute("saveProcTypeSubjectTableDef");
    if(!command.error){
    	   alert("保存成功!");
     }
    else{
       alert(command.error);
    }
}
//添加流程类型标题
function forInsert()
{
	procTypeSubjectDefDataset.newRecord({"id":"","processType":"<%=procTypeId%>","subjectKey":"","subjectAlias":"","subjectOrder":"","subjectWidth":"150","isQueryCondition":"1","bizColumnId":""});
}

//保存流程类型业务标题信息
function forSave()
{
	var isValidate = procTypeSubjectDefDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = procTypeSubjectDefDataset.getAllChangedRecords();
	if (records.length < 1) {// 没有做任何修改,返回
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveProcTypeSubjectDefDetailInfoWithFormField");
	if (!command.error) {
		procTypeSubjectDefDataset.commitChanges();
		procTypeSubjectDefDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

//保存流程类型待办流程标题信息
function forDaiBanProSubjectSave(){
	
	var records = procTypeDaiBanSelectProcSubjectDefDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	var values=L5.get("daiBanTask").getValue();
	var command = new L5.Command("org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
    command.setParameter("records", records);
    command.setParameter("values", values);
    command.setParameter("procTypeId","<%=procTypeId%>");
    command.execute("saveProcTypeDaiBanTaskProcSubjectDefDetailInfo");
    if (!command.error) {
    	procTypeDaiBanSelectProcSubjectDefDataset.commitChanges();
    	procTypeDaiBanSelectProcSubjectDefDataset.reload();
        L5.Msg.alert("提示", "数据保存成功!");
        } else {
            L5.Msg.alert(command.error);
            }
    }

//保存流程类型已办流程标题信息
function forYiBanProSubjectSave(){
	var records = procTypeYiBanSelectProcSubjectDefDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	var values=L5.get("yiBanTask").getValue();
	var command = new L5.Command("org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
    command.setParameter("records", records);
    command.setParameter("values", values);
    command.setParameter("procTypeId","<%=procTypeId%>");
    command.execute("saveProcTypeYiBanTaskProcSubjectDefDetailInfo");
    if (!command.error) {
    	procTypeYiBanSelectProcSubjectDefDataset.commitChanges();
    	procTypeYiBanSelectProcSubjectDefDataset.reload();
        L5.Msg.alert("提示", "数据保存成功!");
        } else {
            L5.Msg.alert(command.error);
            }
}


//保存流程类型办结流程标题信息
function forEndProSubjectSave(){
	var records = procTypeEndSelectProcSubjectDefDataset.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	var values=L5.get("endTask").getValue();
	var command = new L5.Command("org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
    command.setParameter("records", records);
    command.setParameter("values", values);
    command.setParameter("procTypeId","<%=procTypeId%>");
    command.execute("saveProcTypeEndTaskProcSubjectDefDetailInfo");
    if (!command.error) {
    	procTypeEndSelectProcSubjectDefDataset.commitChanges();
    	procTypeEndSelectProcSubjectDefDataset.reload();
        L5.Msg.alert("提示", "数据保存成功!");
        } else {
            L5.Msg.alert(command.error);
            }
}


//删除流程类型标题
function forDelete()
{
	var procTypeSubjectGrid = L5.getCmp('procTypeSubjectGridPanel');
	// 判断是否选择了要删除的记录
	var selected = procTypeSubjectGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert("提示", "请选择要删除的记录！");
		return false;
	}
	var msg="确定要删除选中的记录吗？";
	var procTypeSubjectGridPanel = L5.getCmp('procTypeSubjectGridPanel');
	var selected = procTypeSubjectGridPanel.getSelectionModel().getSelections();
	var isQueryCondition = selected[0].get("isQueryCondition");
	if(isQueryCondition=="1"){
		msg=msg+"您定制的查询条件信息也会随之删除!";
	}
	L5.MessageBox.confirm('确定', msg,function(state){
		if(state=="yes"){   
			var deleteSelected = [];
			for(var i = 0; i < selected.length; i++) {
				if(selected[i].state == 1) {
					procTypeSubjectDefDataset.remove(selected[i]);
				} else {
					deleteSelected[i] = selected[i];
				}
			}
			if (deleteSelected.length < 1) {
				return;
			} else {
				var command=new L5.Command(
					"org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd"); 
				command.setParameter("selected", deleteSelected);
				command.execute("deleteWithFormField");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功!");
					procTypeSubjectDefDataset.reload();
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
	procTypeSubjectDefDataset.rejectChanges();
}

function forBizQuery(){
	forQuery("bizQuery","form");
}

//定义流程标题---待办---查询条件
function forDaiBanQuery(){
	forQuery("daiBanQuery","form");
}

//定义流程标题---已办---查询条件
function forYiBanQuery(){
	forQuery("yiBanQuery","form");
}

//定义流程标题---办结---查询条件
function forEndQuery(){
	forQuery("endQuery","form");
}

//定义流程类型查询条件
function forQuery(tabId,subjectType) {
	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectquerydef.jsp?procTypeId="+"<%=procTypeId%>"+"&tabId="+tabId+"&subjectType="+subjectType;
	L5.forward(url,"流程类型查询条件定义");
}

//待办预览
function forDaiBanPreview() {
	forPreview("daiBanPreview","formTabel");
}

//办结预览
function forYiBanPreview() {
	forPreview("yiBanPreview","formTabel");
}

//办结预览
function forEndPreview() {
	forPreview("endPreview","formTabel");
}

//预览流程类型标题
function forPreview(tabId,subjectType) {
	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefpreview.jsp?procTypeId="+"<%=procTypeId%>"+"&tabId="+tabId+"&subjectType="+subjectType;
	L5.forward(url,"流程类型任务标题预览");
}

//待办双边栏选择框
function initGrantRoleDaiBan(){
	var fromDs=L5.DatasetMgr.lookup("procTypeDaiBanProcSubjectDefDataset");
	var toDs=L5.DatasetMgr.lookup("procTypeDaiBanSelectProcSubjectDefDataset");
	new L5.ux.ItemSelector({
		field:"subjectAlias",
		applyTo:"daiBanDiv",
		id:"daiBanTask",
		name:"subjectAlias",
		fromDataset:fromDs,
		toDataset:toDs,
		valueField:"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已选择流程标题",
	    fromLegend:"未选择流程标题",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	});
}

//已办双边栏选择框
function initGrantRoleYiBan(){
	var fromDs=L5.DatasetMgr.lookup("procTypeYiBanProcSubjectDefDataset");
	var toDs=L5.DatasetMgr.lookup("procTypeYiBanSelectProcSubjectDefDataset");
	new L5.ux.ItemSelector({
		field:"subjectAlias",
		applyTo:"yiBanDiv",
		id:"yiBanTask",
		name:"subjectAlias",
		fromDataset:fromDs,
		toDataset:toDs,
		valueField:"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已选择流程标题",
	    fromLegend:"未选择流程标题",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	});
}

//办结双边栏选择框
function initGrantRoleEnd(){
	var fromDs=L5.DatasetMgr.lookup("procTypeEndProcSubjectDefDataset");
	var toDs=L5.DatasetMgr.lookup("procTypeEndSelectProcSubjectDefDataset");
	new L5.ux.ItemSelector({
		field:"subjectAlias",
		applyTo:"endDiv",
		id:"endTask",
		name:"subjectAlias",
		fromDataset:fromDs,
		toDataset:toDs,
		valueField:"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    toLegend:"已选择流程标题",
	    fromLegend:"未选择流程标题",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	});
}

//查询条件面板打开合并函数
function collapse(element)
{
  var fieldsetParent=L5.get(element).findParent("fieldset");
  if(element.expand==null||element.expand==true)
  {	
	 fieldsetParent.getElementsByTagName("div")[0].style.display="none";
	 element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
     element.expand=false;
   }else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
}
function backToProcTypeSubjectDefList()
{
	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefprofileinfo.jsp";
	L5.forward(url,"流程类型层次任务标题");
}
</script>
</html>