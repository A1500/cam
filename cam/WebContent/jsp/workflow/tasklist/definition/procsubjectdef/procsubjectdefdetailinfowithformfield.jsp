<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>标题详细信息</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<%
  String procDefUniqueId=request.getParameter("procDefUniqueId");
%>
<body>
<model:datasets>
	<model:dataset pageSize="15" id="procSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" autoLoad="false" global="true" method="queryProcSubjectDefDetailInfoWithFormField">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectDef"></model:record>
	</model:dataset>
	<model:dataset id="procSubjectDaiBanFromDataset"
				cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd"
				autoLoad="false" global="true"
				method="queryProcDaiBanTaskProcSubjectDefDetailInfoWithBizTable">
				<model:record
					fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectDef"></model:record>
			</model:dataset>
			
			<model:dataset id="procSubjectDaiBanToDataset"
				cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd"
				autoLoad="false" global="true"
				method="querySelectedProcSubjectDaiBanTaskProcSubjectDefDetailInfoWithBizTable">
				<model:record
					fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectDef"></model:record>
			</model:dataset>
			
			<model:dataset id="procSubjectYiBanFromDataset"
				cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd"
				autoLoad="false" global="true"
				method="queryProcYiBanTaskProcSubjectDefDetailInfoWithBizTable">
				<model:record
					fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectDef"></model:record>
			</model:dataset>
			
			<model:dataset id="procSubjectYiBanToDataset"
				cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd"
				autoLoad="false" global="true"
				method="querySelectedProcSubjectYiBanTaskProcSubjectDefDetailInfoWithBizTable">
				<model:record
					fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectDef"></model:record>
			</model:dataset>
			
			<model:dataset id="procSubjectEndFromDataset"
				cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd"
				autoLoad="false" global="true"
				method="queryProcEndTaskProcSubjectDefDetailInfoWithBizTable">
				<model:record
					fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectDef"></model:record>
			</model:dataset>
			
			<model:dataset id="procSubjectEndToDataset"
				cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd"
				autoLoad="false" global="true"
				method="querySelectedProcSubjectEndTaskProcSubjectDefDetailInfoWithBizTable">
				<model:record
					fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectDef"></model:record>
			</model:dataset>
			
	<model:dataset id="isQueryConditionDataset" enumName="SUBJECT_DEF.IS_QUERY_CONDITION"	autoLoad="true"></model:dataset>
</model:datasets>

<next:Window id="daiBanWin" title="待办流程标题选择" hidden="true" resizable="false" width="450" height="400" lazyRender="false" closable="false">
  <next:Panel id="extend" border="false" autoScroll="true">
  <next:Html>
    <form  onsubmit="return false" class="L5form">
	  <input type="hidden" systype="itemselector" id="daiBanTask" field="subjectKey">
	    <div id="daiBanTaskDiv"></div>
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
			<div id="yiBanTaskDiv">
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
			<div id="endTaskDiv">
			</div>
				</form>
		</next:Html>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closeEndWin"></next:ToolButton>
	</next:Buttons>
</next:Window>


<next:TabPanel  name="tabpanel-div" height="590" activeTab="0">
	<next:Tabs>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel title="业务标题定义" >
			<next:AnchorLayout>
			<next:GridPanel id="procSubjectGridPanel" name="procSubjectGridPanel" anchor="100%" height="100%" dataset="procSubjectDataset"     title="流程定义层次任务标题详细信息">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
					<next:Column id="id" header="内码" field="id" width="10" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程定义唯一Id" field="procDefUniqueId" width="10" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题值" field="subjectKey" width="200">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题显示名称" field="subjectAlias" width="200">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="业务字段显示顺序" field="subjectOrder" width="150">
						<next:NumberField allowBlank="true"/>
					</next:Column>
					<next:Column header="业务字段显示长度" field="subjectWidth" width="150">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="是否作为查询条件" field="isQueryCondition" width="150">
						<next:ComboBox triggerAction="all" dataset="isQueryConditionDataset" typeAble="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="detail"  text="预览" handler="previewBiz"></next:ToolBarItem>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procSubjectDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	
				<next:Panel title="流程标题定义" >
					<next:TabPanel name="border-div" height="590" activeTab="0" id="procTabs" activeTab="0">
						
						<next:Tabs>
								<next:EditGridPanel id="procSubjectDaiBanGridPanel"
										name="procSubjectDaiBanGridPanel" anchor="100%" height="78%" width="62%"
										dataset="procSubjectDaiBanToDataset"    
										title="待办任务标题详细信息">
										<next:Columns>
											<next:RowNumberColumn width="30" />
											<next:CheckBoxColumn></next:CheckBoxColumn>
											<next:Column id="id" header="内码" field="id" width="10"
												hidden="true">
												<next:TextField allowBlank="false" />
											</next:Column>
											<next:Column header="流程定义唯一Id" field="procDefUniqueId"
												width="10" hidden="true">
												<next:TextField allowBlank="false" />
											</next:Column>
											<next:Column header="流程字段值" field="subjectKey" width="100" hidden="true">
												<next:TextField allowBlank="false" editable="false" />
											</next:Column>
											<next:Column header="流程字段显示名称" field="subjectAlias"
												width="180">
												<next:TextField allowBlank="false" editable="false" />
											</next:Column>
											<next:Column header="标题显示顺序" field="subjectOrder" width="110">
												<next:NumberField allowBlank="true" />
											</next:Column>
											<next:Column header="标题显示长度" field="subjectWidth" width="120">
												<next:NumberField allowBlank="true" />
											</next:Column>
											<next:Column header="是否作为查询条件" field="isQueryCondition"
												width="120">
												<next:ComboBox triggerAction="all"
													dataset="isQueryConditionDataset" typeAble="false"/>
											</next:Column>
										</next:Columns>
										
										<next:TopBar>
											<next:ToolBarItem symbol="->"></next:ToolBarItem>
											<next:ToolBarItem iconCls="add"  text="增加" handler="openDaiBanWin"/>
											<next:ToolBarItem iconCls="save" text="保存" handler="forSaveInDaiBanTask" />
											<next:ToolBarItem iconCls="add" text="查询条件定义" handler="forDaiBanQuery"></next:ToolBarItem>
											<next:ToolBarItem iconCls="detail" text="预览" handler="forPreviewInDaiBanTask"></next:ToolBarItem>
											<next:ToolBarItem iconCls="undo" text="返回" handler="backToProcSubjectDefList" />
										</next:TopBar>
										<next:BottomBar>
											<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
												displayInfo="true" dataset="procSubjectDaiBanToDataset" />
										</next:BottomBar>
									</next:EditGridPanel>
									
							
									<next:EditGridPanel id="procSubjectYiBanGridPanel"
										name="procSubjectYiBanGridPanel" anchor="50%" height="20%" width="62%"
										dataset="procSubjectYiBanToDataset"    
										title="已办任务标题详细信息">
										<next:Columns>
											<next:RowNumberColumn width="30" />
											<next:CheckBoxColumn></next:CheckBoxColumn>
											<next:Column id="id" header="内码" field="id" width="10"
												hidden="true">
												<next:TextField allowBlank="false" />
											</next:Column>
											<next:Column header="流程定义唯一Id" field="procDefUniqueId"
												width="10" hidden="true">
												<next:TextField allowBlank="false" />
											</next:Column>
											<next:Column header="流程字段值" field="subjectKey" width="100" hidden="true">
												<next:TextField allowBlank="false" editable="false" />
											</next:Column>
											<next:Column header="流程字段显示名称" field="subjectAlias"
												width="180">
												<next:TextField allowBlank="false" editable="false" />
											</next:Column>
											<next:Column header="标题显示顺序" field="subjectOrder" width="110">
												<next:NumberField allowBlank="true" />
											</next:Column>
											<next:Column header="标题显示长度" field="subjectWidth" width="120">
												<next:NumberField allowBlank="true" />
											</next:Column>
											<next:Column header="是否作为查询条件" field="isQueryCondition"
												width="120">
												<next:ComboBox triggerAction="all"
													dataset="isQueryConditionDataset" typeAble="false"/>
											</next:Column>
										</next:Columns>
										
										<next:TopBar>
											<next:ToolBarItem symbol="->"></next:ToolBarItem>
											<next:ToolBarItem iconCls="add"  text="增加" handler="openYiBanWin"/>
											<next:ToolBarItem iconCls="save" text="保存" handler="forSaveInYiBanTask" />
											<next:ToolBarItem iconCls="add" text="查询条件定义" handler="forYiBanQuery"></next:ToolBarItem>
											<next:ToolBarItem iconCls="detail" text="预览" handler="forPreviewInYiBanTask"></next:ToolBarItem>
											<next:ToolBarItem iconCls="undo" text="返回" handler="backToProcSubjectDefList" />
										</next:TopBar>
										<next:BottomBar>
											<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
												displayInfo="true" dataset="procSubjectYiBanToDataset" />
										</next:BottomBar>
									</next:EditGridPanel>
									
									<next:EditGridPanel id="procSubjectEndGridPanel"
										name="procSubjectEndGridPanel" anchor="50%" height="20%" width="62%"
										dataset="procSubjectEndToDataset"    
										title="办结任务标题详细信息">
										<next:Columns>
											<next:RowNumberColumn width="30" />
											<next:CheckBoxColumn></next:CheckBoxColumn>
											<next:Column id="id" header="内码" field="id" width="10"
												hidden="true">
												<next:TextField allowBlank="false" />
											</next:Column>
											<next:Column header="流程定义唯一Id" field="procDefUniqueId"
												width="10" hidden="true">
												<next:TextField allowBlank="false" />
											</next:Column>
											<next:Column header="流程字段值" field="subjectKey" width="100" hidden="true">
												<next:TextField allowBlank="false" editable="false" />
											</next:Column>
											<next:Column header="流程字段显示名称" field="subjectAlias"
												width="180">
												<next:TextField allowBlank="false" editable="false" />
											</next:Column>
											<next:Column header="标题显示顺序" field="subjectOrder" width="110">
												<next:NumberField allowBlank="true" />
											</next:Column>
											<next:Column header="标题显示长度" field="subjectWidth" width="120">
												<next:NumberField allowBlank="true" />
											</next:Column>
											<next:Column header="是否作为查询条件" field="isQueryCondition"
												width="120">
												<next:ComboBox triggerAction="all"
													dataset="isQueryConditionDataset" typeAble="false"/>
											</next:Column>
										</next:Columns>
										
										<next:TopBar>
											<next:ToolBarItem symbol="->"></next:ToolBarItem>
											<next:ToolBarItem iconCls="add"  text="增加" handler="openEndWin"/>
											<next:ToolBarItem iconCls="save" text="保存" handler="forSaveInEndTask" />
											<next:ToolBarItem iconCls="add" text="查询条件定义" handler="forEndQuery"></next:ToolBarItem>
											<next:ToolBarItem iconCls="detail" text="预览" handler="forPreviewInEndTask"></next:ToolBarItem>
											<next:ToolBarItem iconCls="undo" text="返回" handler="backToProcSubjectDefList" />
										</next:TopBar>
										<next:BottomBar>
											<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
												displayInfo="true" dataset="procSubjectEndToDataset" />
										</next:BottomBar>
									</next:EditGridPanel>
							
						</next:Tabs>
					</next:TabPanel>

				</next:Panel>

			</next:Tabs>
		</next:TabPanel>
</body>
<script language="javascript"  type="text/javascript" >
function init()
{
	
	 procSubjectDataset.setParameter("PROC_DEF_UNIQUE_ID@=","<%=procDefUniqueId%>");
	 procSubjectDataset.setParameter("SUBJECT_CATEGORY@=","0");
	 procSubjectDataset.load();
	 
	 var tabpanel = L5.getCmp("procTabs");
	tabpanel.on("tabchange", loadTab);
	
}


var isDaiBanInit = false;
var isYiBanInit = false;
var isEndInit = false;


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

function loadTab(tabpanels, tab)
{
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isDaiBanInit == false){
		if(tab.id == "procSubjectDaiBanGridPanel"){
			isDaiBanInit = true;
			procSubjectDaiBanFromDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
	 		procSubjectDaiBanFromDataset.load();
	 
			 procSubjectDaiBanToDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			 procSubjectDaiBanToDataset.load();
			initDaiBanDiv();
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanInit == false){
		if(tab.id == "procSubjectYiBanGridPanel"){
			isYiBanInit = true;
			 procSubjectYiBanFromDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			 procSubjectYiBanFromDataset.load();
			 
			 procSubjectYiBanToDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			 procSubjectYiBanToDataset.load();
			initYiBanDiv();
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isEndInit == false){
		if(tab.id == "procSubjectEndGridPanel"){
			isEndInit = true;
			procSubjectEndFromDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			 procSubjectEndFromDataset.load();
			 
			 procSubjectEndToDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			 procSubjectEndToDataset.load();
			 initEndDiv();
		}
	}
}

function initDaiBanDiv(){
	var fromDS = L5.DatasetMgr.lookup("procSubjectDaiBanFromDataset");
	var toDS = L5.DatasetMgr.lookup("procSubjectDaiBanToDataset");
	new L5.ux.ItemSelector({
		field:"subjectKey",
		applyTo:"daiBanTaskDiv",
		id:"daiBanTask",
		name:"subjectAlias",
		fromDataset:fromDS,
		toDataset:toDS,
		valueField:"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
	//daiban.addIcon.on('click', addDaiBan);
	//daiban.removeIcon.on('click', removeDaiBan);
	//daiban.on('rowdblclick', removeDaiBan);
}
function initYiBanDiv(){
	var fromDS = L5.DatasetMgr.lookup("procSubjectYiBanFromDataset");
	var toDS = L5.DatasetMgr.lookup("procSubjectYiBanToDataset");
	new L5.ux.ItemSelector({
		field:"subjectKey",
		applyTo:"yiBanTaskDiv",
		id:"yiBanTask",
		name:"subjectAlias",
		fromDataset:fromDS,
		toDataset:toDS,
		valueField:"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}
function initEndDiv(){
	var fromDS = L5.DatasetMgr.lookup("procSubjectEndFromDataset");
	var toDS = L5.DatasetMgr.lookup("procSubjectEndToDataset");
	new L5.ux.ItemSelector({
		field:"subjectKey",
		applyTo:"endTaskDiv",
		id:"endTask",
		name:"subjectAlias",
		fromDataset:fromDS,
		toDataset:toDS,
		valueField:"subjectKey",
		displayField:"subjectAlias",
	    msWidth:150,
	    msHeight:300,
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
//保存待办任务 流程信息定制
function forSaveInDaiBanTask(){
	var values=L5.get("daiBanTask").getValue();
	//var drag = L5.get("daiBanTask").getDragData();
	//alert(drag);
	save("saveProcDaiBanTaskProcSubjectDefDetailInfo",procSubjectDaiBanToDataset,values);
}
function forPreviewInDaiBanTask(){
	preview("daiBanTask");
}
function backToProcSubjectDefListInDaiBanTask(){
	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefprofileinfo.jsp";
	L5.forward(url,"流程定义层次任务标题");
}

//保存已办任务 流程信息定制
function forSaveInYiBanTask(){
	var values=L5.get("yiBanTask").getValue();
	//alert(values);
	save("saveProcYiBanTaskProcSubjectDefDetailInfo",procSubjectYiBanToDataset,values);
}
function forPreviewInYiBanTask(){
	preview("yiBanTask");
}
function backToProcSubjectDefListInYiBanTask(){
	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefprofileinfo.jsp";
	L5.forward(url,"流程定义层次任务标题");
}

//保存办结任务 流程信息定制
function forSaveInEndTask(){
	var values=L5.get("endTask").getValue();
	//alert(values);
	save("saveProcEndTaskProcSubjectDefDetailInfo",procSubjectEndToDataset,values);
}
function forPreviewInEndTask(){
	preview("endTask");
}
function backToProcSubjectDefListInEndTask(){
	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefprofileinfo.jsp";
	L5.forward(url,"流程定义层次任务标题");
}

//取消
function forCancel()
{
	procSubjectDataset.rejectChanges();
}
//定义流程定义业务信息查询条件
function forBizQuery() {
	forQuery("bizTable","form");
}
//定义流程定义流程信息待办任务查询条件
function forDaiBanQuery() {
	forQuery("daiBanTask","form");
}
//定义流程定义流程信息已办任务查询条件
function forYiBanQuery() {
	forQuery("yiBanTask","form");
}
//定义流程定义流程信息办结任务查询条件
function forEndQuery() {
	forQuery("endTask","form");
}

//定义流程定义查询条件
function forQuery(tabId,type) {
	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectquerydefwithbiztable.jsp?procDefUniqueId="+
			"<%=procDefUniqueId%>"+"&tabId="+tabId+"&type="+type;
	L5.forward(url,"流程定义查询条件定义");
}
function save(saveProcSubject,dataset,values){
	
	var isValidate = dataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = dataset.getAllChangedRecords();
	if (records.length < 1) {// 没有做任何修改,返回
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefCmd");
	command.setParameter("records", records);
	if(null != values && "" != values){
		command.setParameter("values", values);
	}
	command.execute(saveProcSubject);
	if (!command.error) {
		dataset.commitChanges();
		dataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}
//预览流程定义标题
function previewBiz() {
	preview("daiBanTask");
}
//预览流程定义标题
function preview(tabId) {
	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefpreview.jsp?procDefUniqueId="+"<%=procDefUniqueId%>"+"&tabId="+tabId;
	L5.forward(url,"流程定义任务标题预览");
}

//查询条件面板打开合并函数
function collapse(element)
{
  var fieldsetParent=L5.get(element).findParent("fieldset");
  if(element.expand==null||element.expand==true)
  {	
	 fieldsetParent.getElementsByTagName("div")[0].style.display="none";
	 element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
     element.expand=false;
   }else{
	 fieldsetParent.getElementsByTagName("div")[0].style.display="";
	 element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
	 element.expand =true;
  }
}
function backToProcSubjectDefList()
{
	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefprofileinfo.jsp";
	L5.forward(url,"流程定义层次任务标题");
}
</script>
</html>