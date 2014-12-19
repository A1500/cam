<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List"%>
<html>
<%
String assignmentId=(String)request.getParameter("assignmentId");
if(assignmentId==null||"".equals(assignmentId))
{
	  assignmentId=(String)request.getAttribute("assignmentId"); 
}	  
if(assignmentId==null)
	  assignmentId="";
%>
<head>
<title>选择下一环节以及参与者</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>

<model:datasets>
	<model:dataset id="actDataSet"
		cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" global="true" autoLoad="true" method="selectNextActivitiesAndEmployees">
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
						<td class="FieldLabel" width="90px">请选择下一环节:</td>
						<td class="FieldInput">
							<select id="selectNextActivity" onChange="actsChange()">
								<option dataset="actDataSet"></option>
							</select>
						</td>
					</tr>
				</table>
			</next:Html>
		</next:Panel>
		<next:Panel width="100%" height="310">
			<next:ColumnLayout>
				<next:Panel width="70%" border="0">

					<next:TabPanel id="tabContentSel" name="tabContentSel" height="100%" activeTab="0">
						<next:Defaults>{bodyStyle:'padding:2px;'}</next:Defaults>
						<!-- 内容选择 -->
						<next:Tabs>
							<!-- 列表选择 -->
							<next:Panel id="listContent" name="listContent" width="100%" title="列表选择" collapsible="false">
								<next:GridPanel id="listGrid" name="listGrid"
									notSelectFirstRow="true" stripeRows="true"
									height="270" dataset="partiesDataset" autoExpandColumn="orgn" columnLines="true">
									<next:Columns>
										<next:RowNumberColumn width="20" />
										<next:CheckBoxColumn></next:CheckBoxColumn>
										<next:Column id="organId" field="organId" header="" hidden="true"></next:Column>
										<next:Column id="actor" header="参与者名称" width="20%" field="organName"></next:Column>
										<next:Column id="orgn" header="部门" width="80%" field="departmentOrganName"></next:Column>
									</next:Columns>
									<next:ExtendConfig>
										tbar:[
											{text:'参与者名称:'},
								            {xtype: 'textfield',id: 'actorname'},
											{iconCls:'query',text:'查询', handler: queryByName}
										]
									</next:ExtendConfig>
								</next:GridPanel>
							</next:Panel>
						</next:Tabs>
					</next:TabPanel>
				</next:Panel>
				<next:Panel width="30" title="" height="100%" collapsible="false" border="0">
					<next:Html>
					<div style="margin: 35 15 5 5;">
						<button class="multiselect_top2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveTop()"></button>
						<br />
						<button class="multiselect_up2"	style="width: 22px; height: 22px; cursor: pointer;" onclick="moveUp()"></button>
						<br />
						<button class="multiselect_right2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveRight()"></button>
						<br />
						<button class="multiselect_left2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveLeft()"></button>
						<br />
						<button class="multiselect_down2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveDown()"></button>
						<br />
						<button class="multiselect_bottom2"	style="width: 22px; height: 22px; cursor: pointer;" onclick="moveBottom()"></button>
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
//获取委派Id
var assignmentId="<%=assignmentId%>";

/**
* 初始化
*
*/
function init() {
	//定义双击事件
	var grid=L5.getCmp('listGrid');
	grid.on("rowdblclick",moveRight);
}

/**
* 环节选择
* 环节选择改变时触发
*/
function actsChange() {
	// 重新加载参与者
	loadActors();
	// 清空已选择的人员
	clearSelected();
}

/**
* 加载列表选择中的参与者信息
*
*/
function loadActors()
{
	var actDefInfo=document.getElementById("selectNextActivity").value;
	if(actDefInfo==null||actDefInfo=="")
	{
		alert("请先选择环节!");
		return;
	}
	var record = actDataSet.getById(actDefInfo);

	var actDefUniqueId=actDefInfo;
	var actType=record.get("actType");

	if(actType=="1"||actType=="3")
	{
		alert("您选择的环节类型没有参与者");
		return;
	}
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
* 选择按钮 置顶
*
*/
function moveTop() {

	var selOpts = document.all("SelOpts");
	var selIndex = selOpts.selectedIndex;
	if(selIndex == -1) return;
	// 存储已选择的项的数组
    var  opts = [];
    for(var i = selOpts.options.length -1 ; i >= 0; i--)
    {
        if(selOpts.options[i].selected)
        {
            opts.push(selOpts.options[i]);
            selOpts.remove(i);
        }
    }
    var index = 0 ;
    for(var t = opts.length-1 ; t>=0 ; t--)
    {
        var opt = new Option(opts[t].text,opts[t].value);
        opt.selected = true;
        selOpts.options.add(opt, index++);
    }
}

/**
* 选择按钮 向上
*
*/
function moveUp() {
	var selOpts = document.all("SelOpts");
	var selIndex = selOpts.selectedIndex;
	if(selIndex == -1) return;
	var len = selOpts.length;
	for(var i=1; i < len; i++){
		if(selOpts.options[i].selected){

			if(!selOpts.options.item(i-1).selected)
			{
				var selText = selOpts.options[i].text;
				var selValue = selOpts.options[i].value;

				selOpts.options[i].text = selOpts.options[i-1].text;
				selOpts.options[i].value = selOpts.options[i-1].value;
				selOpts.options[i].selected = false;

				selOpts.options[i-1].text = selText;
				selOpts.options[i-1].value = selValue;
				selOpts.options[i-1].selected=true;
			}
		}
	}
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
		var departmentOrganName = row.get("departmentOrganName");
		var exist=0;
		var temp = new Option(organName,organId+","+organName+","+departmentOrganName);
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
* 选择按钮 向下
*
*/
function moveDown() {
	var selOpts=document.all("SelOpts");
	var selIndex = selOpts.selectedIndex;
	if(selIndex==-1)return;
	var len = selOpts.length;
	for(var i=len-2;i>=0;i--){
		// 向下移动，最后一个不需要处理，所以直接从倒数第二个开始
		if(selOpts.options[i].selected){

		 	if(!selOpts.options[i+1].selected)
			{
				var selText = selOpts.options[i].text;
				var selValue = selOpts.options[i].value;

				selOpts.options[i].text = selOpts.options[i+1].text;
				selOpts.options[i].value = selOpts.options[i+1].value;
				selOpts.options[i].selected = false;

				selOpts.options[i+1].text = selText;
				selOpts.options[i+1].value = selValue;
				selOpts.options[i+1].selected=true;
			}
		}
	}
}

/**
* 选择按钮 置底
*
*/
function moveBottom() {
	var selOpts = document.all("SelOpts");
	var selIndex = selOpts.selectedIndex;
	if(selIndex == -1) return;
	// 存储已选择的项的数组
    var  opts = [];
    for(var i = selOpts.options.length -1 ; i >= 0; i--)
    {
        if(selOpts.options[i].selected)
        {
            opts.push(selOpts.options[i]);
            selOpts.remove(i);
        }
    }
    for(var t = opts.length-1 ; t>=0 ; t--)
    {
        var opt = new Option(opts[t].text,opts[t].value);
        opt.selected = true;
        selOpts.options.add(opt);
    }
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
function Evt_confirmSelect(){
	var actDefInfo=document.getElementById("selectNextActivity").value;
	if(actDefInfo==null||actDefInfo=="")
	{
		alert("请先选择环节!");
		return;
	}
 	// 参与者
	var selectActors = document.all("SelOpts");
    if(selectActors.options.length<=0)
    {
		alert("请选择至少一个参与者！");
		return ;
    }
    var organIds="";
    var organNames="";
    var departmentOrganNames="";
    for(i=0;i<selectActors.options.length;i++)
    {
		var tempStrIds = selectActors.options[i].value.split(",");
		organIds+=tempStrIds[0];
		organNames+=tempStrIds[1];
		departmentOrganNames+=tempStrIds[2];
		if(i<selectActors.options.length-1)
		{
			organIds+=",";
			organNames+=",";
			departmentOrganNames+=",";
		}
    }
	var returnV=new Array(5);
	var record = actDataSet.getById(actDefInfo);
	//选择的下一环节定义唯一Id
	returnV[0]=actDefInfo;
	//选择的环节定义Id
	returnV[1]=record.get("text");
	//此环节所有参与者的organId
	returnV[2]=organIds;
	//此环节所有参与者的organName
	returnV[3]=organNames;
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


