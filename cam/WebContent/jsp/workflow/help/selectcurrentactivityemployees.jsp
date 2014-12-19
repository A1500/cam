<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List"%>
<html>
<next:ScriptManager></next:ScriptManager>
<%
String assignmentId=(String)request.getParameter("assignmentId");
if(assignmentId==null||"".equals(assignmentId))
{
	  assignmentId=(String)request.getAttribute("assignmentId"); 
}	  
if(assignmentId==null)
	  assignmentId="";
%>
<script language="javascript">

</script>
<head>
<title>环节内自由发送</title>
</head>
<body>
<model:datasets>
	<model:dataset id="actDataSet"
		cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" global="true" autoLoad="true" method="getCurrentActivityDefNameAndIdByAssignmentId">
		<model:record >
			<model:field name="text" mapping="actDefName" type="string"></model:field>
			<model:field name="value" mapping="actDefUniqueId" type="string"></model:field>
			<model:field name="actDefId" type="string"></model:field>
			<model:field name="actType"  type="string"></model:field>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="partiesDataset" cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" method="selectActivityEmployees">
		<model:record >
			<model:field name="organId" type="string"></model:field>
			<model:field name="organName" type="string"></model:field>
			<model:field name="departmentOrganName" type="string"></model:field>
			<model:field name="enterpriseOrganName"  type="string"></model:field>
		</model:record>
	</model:dataset>
	</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="Evt_confirmSelect"></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="undo" handler="Evt_cancleSelect"></next:ToolBarItem>
	</next:TopBar>

		<next:Panel collapsible="false">
			<next:Html>
				<table width="100%">
					<tr height="25">
						<td class="FieldLabel" width="75px" align="left">当前环节:</td>
						<td><input type="text" width="90px" id="actDefName" value="default" readOnly="true" /></td>
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
</body>
</html>
<script language="javascript">
var assignmentId="<%=assignmentId%>";
/**
* 初始化
*
*/
function init() {
	//定义双击事件
	var grid=L5.getCmp('listGrid');
	grid.on("rowdblclick",moveRight);
	loadActors();
}

function loadActors(){
	var activityDefInfo = actDataSet.getCustomData("activityDefInfo");
	var actDefUniqueId = activityDefInfo.get("actDefUniqueId");
	var actDefName = activityDefInfo.get("actDefName");
	document.getElementById('actDefName').value =actDefName;
	
	var partiesDataset = L5.DatasetMgr.lookup("partiesDataset");
	partiesDataset.baseParams["assignmentId"]=assignmentId;
	partiesDataset.baseParams["actDefUniqueId"]=actDefUniqueId;
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
* 确定按钮按下事件
*/
function Evt_confirmSelect(){
 	// 参与者
	var selectActors = document.all("SelOpts");
    if(selectActors.options.length<=0)
    {
        alert("请选择至少一个参与者！");
    	return ;
    }
	if(selectActors.options.length>1)
	{
		alert("请选择一个参与者！");
    	return ;
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
	var returnV=new Array(2);
	//选择参与者的organId
	returnV[0]=organIds;
	//选择参与者的organName
	returnV[1]=organNames;
	window.parent.returnValue=returnV;
	window.parent.close();
}

/**
* 取消按钮按下事件
*/
function Evt_cancleSelect(){
	window.parent.close();
}

</script>


