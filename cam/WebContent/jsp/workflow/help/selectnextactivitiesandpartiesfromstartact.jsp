<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List"%>
<HTML>
<%
String startActDefUniqueId=(String)request.getParameter("startActDefUniqueId");
if(startActDefUniqueId==null)startActDefUniqueId="";
%>
<HEAD>
<TITLE>选择下一环节以及参与者(从起始环节)</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY style="margin:0px;padding: 0px;">
<model:datasets>
	<model:dataset id="actDataSet"
		cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" global="true" autoLoad="true" method="selectNextActivitiesAndPartiesFromStartAct">
		<model:record >
			<model:field name="text" mapping="actDefName" type="string"></model:field>
			<model:field name="value" mapping="actDefUniqueId" type="string"></model:field>
			<model:field name="actDefId" type="string"></model:field>
			<model:field name="actType"  type="string"></model:field>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="partiesDataset" cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" method="selectActivityParties">
		<model:record >
			<model:field name="organId"  type="string"></model:field>
			<model:field name="organName"  type="string"></model:field>
			<model:field name="departmentOrganName"  type="string"></model:field>
			<model:field name="enterpriseOrganName"  type="string"></model:field>
		</model:record>
	</model:dataset>
</model:datasets>

	<next:Panel>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="add" handler="confirmSelect"></next:ToolBarItem>
			<next:ToolBarItem text="取消" iconCls="undo" handler="cancleSelect"></next:ToolBarItem>
		</next:TopBar>
		<next:Panel collapsible="false">
			<next:Html>
				<table width="100%">
					<tr height="25">
						<td class="FieldLabel" width="90px" align="center">请选择下一环节:</td>
						<td class="FieldInput">
							<select id="selectNextActivity" style="width:150" onChange="selectedActChanged()">
								<option dataset="actDataSet"></option>
							</select>
						</td>
					</tr>
				</table>
			</next:Html>
		</next:Panel>
		<next:Panel width="100%" height="310">
			<next:ColumnLayout>

				<next:GridPanel id="listGrid" name="listGrid" anchor="100%" title="环节参与者列表" notSelectFirstRow="true" stripeRows="true" width="70%" height="90%" dataset="partiesDataset">
					<next:Columns>
						<next:RowNumberColumn width="20" />
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column id="organId" field="organId" header="" hidden="true"></next:Column>
						<next:Column id="actor" header="参与者名称" width="100" field="organName"></next:Column>
						<next:Column id="orgn" header="部门" width="102" field="departmentOrganName"></next:Column>
						<next:Column id="enterprise" header="单位" width="102" field="enterpriseOrganName"></next:Column>
					</next:Columns>
					<next:ExtendConfig>
						tbar:[
							{text:'参与者名称:'},
				            {xtype: 'textfield',id: 'actorname'},
							{iconCls:'query',text:'查询', handler: queryByName}
						]
					</next:ExtendConfig>
				</next:GridPanel>
				<next:Panel width="30" title="" height="100%" collapsible="false" border="0">
					<next:Html>
					<div style="margin: 35 15 5 5;">
						<br />
						<br />
						<button class="multiselect_right2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveRight()"></button>
						<br />
						<br />
						<button class="multiselect_left2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveLeft()"></button>
						<br />
					</div>
					</next:Html>
				</next:Panel>
				<next:Panel title="" height="100%" collapsible="false" border="0">
				<next:Defaults>{bodyStyle:'padding:0px;'}</next:Defaults>
					<next:Html>
						<fieldset style="overflow: visible; width: 95%;" class="GroupBox" align="center">
						<legend class="GroupBoxTitle" align="center">已选项</legend>
						<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<select id="SelOpts" size="17" multiple="multiple" align="center" 
								style="width: 100%; height: 270px; margin: 0; padding: 0;" ondblclick="moveLeft()">
							</select>
						</div>
						</fieldset>
					</next:Html>
				</next:Panel>
			</next:ColumnLayout>
		</next:Panel>
	</next:Panel>
</BODY>
</HTML>
<script language="javascript">
var startActDefUniqueId="<%=startActDefUniqueId%>";

/**
* 初始化
*
*/
function init() {
	//定义双击事件
	var grid=L5.getCmp('listGrid');
	grid.on("rowdblclick",moveRight);
	//如果下一环节只有一个环节，选择框默认选中该环节
	var options=document.getElementById("selectNextActivity").options;
	if(options.length==2){
		options[1].selected=true;
		//加载环节的参与人
		selectedActChanged();
	}
}

/**
* 环节选择
* 环节选择改变时触发
*/
var selectNextActIsCounterSignaturn = "";
function selectedActChanged() {
	var actDefUniqueId=document.getElementById("selectNextActivity").value;
	
	if(actDefUniqueId !=""){
		//判断选择的历史环节是否是会签环节
		window['nextActivityIsCounterSignature']= new L5.model.Dataset({proxy:new L5.CommandProxy('org.loushang.workflow.client.common.help.cmd.TaskHelpCmd','getActivityDefInfoWithIsCounterSignatureByActDefUniqueId'),reader: new L5.model.JsonReader({fields:[{name:'isCounterSignature',type:'string'}]}),ds:'nextActivityIsCounterSignature',pageSize:-1,id:'nextActivityIsCounterSignature',remoteSort:true});

		var nextActivityIsCounterSignature = L5.DatasetMgr.lookup("nextActivityIsCounterSignature");
		nextActivityIsCounterSignature.baseParams["actDefUniqueId"]=actDefUniqueId;
		nextActivityIsCounterSignature.load(true);

		nextActivityIsCounterSignatureInfo = nextActivityIsCounterSignature.getCustomData("nextActivityIsCounterSignatureInfo");
		var nextIsCounterSignature = nextActivityIsCounterSignatureInfo.get("isCounterSignature");

		//选择的历史环节是会签环节则不能选择会签环节参与者
		if(nextIsCounterSignature=="1" || nextIsCounterSignature=="2"){
			selectNextActIsCounterSignaturn = "1";
			clearSelected();
			alert("您选择的是会签环节，不能选择会签环节参与者！");
			return;
		}
	}
	
	// 加载参与者
	loadActors();
	// 清空已选择的人员
	clearSelected();
}

function loadActors(){
	var actDefUniqueId=document.getElementById("selectNextActivity").value;
	if(actDefUniqueId==null||actDefUniqueId=="")
	{
		alert("请先选择环节!");
		return;
	}
	var record = actDataSet.getById(actDefUniqueId);

	var actType=record.get("actType");

	if(actType=="1"||actType=="3")
	{
		alert("您选择的环节类型没有参与者");
		return;
	}
	var partiesDataset = L5.DatasetMgr.lookup("partiesDataset");
	partiesDataset.baseParams["actDefUniqueId"]=actDefUniqueId;
	partiesDataset.baseParams["startActDefUniqueId"]=startActDefUniqueId;
	partiesDataset.load();
}

/**
* 根据组织名称过滤DataSet
*/
function queryByName() {
	var partiesDataset = L5.DatasetMgr.lookup("partiesDataset");
	var actorname = document.getElementById("actorname").value;
	partiesDataset.filter("organName", actorname, true, false )
}

/**
* 选择按钮 向右
*
*/
function moveRight() {
	var selOpts=document.all("SelOpts");
	var listGrid = L5.getCmp('listGrid');
	var selectedRow = listGrid.getSelectionModel().getSelections();
	if(selectedRow.length < 1){
		alert("请选择左侧的参与者!");
		return false;
	}
	
	for(var i=0; i < selectedRow.length; i++)
	{
		var row = selectedRow[i];
		var organId = row.get("organId");
		var organName = row.get("organName");
		var exist=0;
		var temp = new Option(organName,organId+","+organName);
		for(var j=selOpts.options.length-1;j>=0;j--)
		{
			var organIds=selOpts.options[j].value.split(",");
			for(var h=0;h<organIds.length;h=h+2)
			{
				var existorganId=organIds[h];
				if(organId==existorganId)
				{
					exist=1;
					continue;
				}
			}
		}
		if(exist==1)
		{
				continue;
		}
		if(exist==0)
		{
			selOpts.options[selOpts.options.length] = temp;
		}
	 }
}

/**
* 选择按钮 向左
*
*/
function moveLeft() {
	var selOpts=document.all("SelOpts");
	var lens=selOpts.options.length;
	for(var i=lens-1;i>=0;i--)
	{
		 if(selOpts.options[i].selected)
		 {
		 	selOpts.options.remove(i);
		 }
	}
	lens=selOpts.options.length;
	if(lens>0)
		selOpts.options[lens-1].selected=true;
}

/**
 * 环节切换时 清空已选择的数据
 * @return
 */
function clearSelected() {
	var selOpts=document.all("SelOpts");
	var lens=selOpts.options.length;
	for(var i=lens-1;i>=0;i--)
	{
		selOpts.options.remove(i);
	}
}

/**
* 确定按钮按下事件
*/
function confirmSelect(){
	var actDefUniqueId=document.getElementById("selectNextActivity").value;
	if(actDefUniqueId==null||actDefUniqueId=="")
	{
		alert("请先选择环节!");
		return;
	}
 	// 参与者
	var selectActors = document.all("SelOpts");
    if(selectActors.options.length<=0)
    {
        //如果选择的历史环节不是会签环节而没有选着参与者
        if(selectNextActIsCounterSignaturn == ""){
        	alert("请选择至少一个参与者！");
    		return ;
        }
    }else{
		if(selectNextActIsCounterSignaturn == "1"){
			alert("您选择的是会签环节，不能选择会签环节参与者！");
			return;
		}
    }
    var organIds="";
    var organNames="";
    for(i=0;i<selectActors.options.length;i++)
    {
		var tempStrIds = selectActors.options[i].value.split(",");
		organIds+=tempStrIds[0];
		organNames+=tempStrIds[1];
		if(i<selectActors.options.length-1)
		{
			organIds+=",";
			organNames+=",";
		}
    }
	var returnV=new Array(4);
	var record = actDataSet.getById(actDefUniqueId);
	//选择的下一环节定义唯一Id
	returnV[0]=actDefUniqueId;
	//下一环节所有参与者的organId
	returnV[1]=organIds;
	//下一环节所有参与者的organName
	returnV[2]=organNames;
	//选择的下一环节定义Id
	returnV[3]=record.get("text");
	window.parent.returnValue=returnV;
	window.parent.close();
}

/**
* 取消按钮按下事件
*/
function cancleSelect(){
	window.parent.close();
}

</script>