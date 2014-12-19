<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List"%>
<HTML>
<%
  String assignmentId=(String)request.getParameter("assignmentId");
  if(assignmentId==null||"".equals(assignmentId))
  {
	  assignmentId=(String)request.getAttribute("assignmentId"); 
  }	  
  if(assignmentId==null)
	  assignmentId="";
%>
<HEAD>
<TITLE>选择历史环节以及实际处理人</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY style="margin:0px;padding: 0px;">
<model:datasets>
	<model:dataset id="actDataSet"
		cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" global="true" autoLoad="true" method="selectHistoryActivitiesAndEmployees">
		<model:record >
			<model:field name="text" mapping="actDefName" type="string"></model:field>
			<model:field name="value" mapping="actDefUniqueId" type="string"></model:field>
			<model:field name="actDefId" type="string"></model:field>
			<model:field name="activityId" type="string"></model:field>
			<model:field name="actType"  type="string"></model:field>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="partiesDataset" cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" method="selectHistoryActivityEmployees">
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
						<td class="FieldLabel" width="90px" align="center">请选择历史环节:</td>
						<td class="FieldInput">
							<select id="selectHistoryActivity" style="width:150" onChange="selectedActChanged();">
								<option dataset="actDataSet"></option>
							</select>
						</td>
					</tr>
				</table>
			</next:Html>
	</next:Panel>
	
	</div>
	<next:Panel  height="100%">
		<next:Html>
    		<next:GridPanel id="userGridPanel" height="100%" width="100%" name="partiesGridPanel" 
    					dataset="partiesDataset"     title="历史环节实际处理人信息" notSelectFirstRow="false">
				<next:Columns>
				<next:RowNumberColumn width="20"/>
				<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="handlerId" header="实际处理人ID" field="organId" width="50" hidden="true">
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="handlerName" header="环节实际处理人名称" field="organName" width="130">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="部门" field="departmentOrganName" width="156">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="单位" field="enterpriseOrganName" width="156">
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
			</next:GridPanel>
   		</next:Html>
	</next:Panel>
</next:Panel>
</BODY>
</HTML>
<script language="javascript">
var assignmentId="<%=assignmentId%>";

function cancleSelect(){
	parent.close();
}

function selectedActChanged(){
	var actDefUniqueId=document.getElementById("selectHistoryActivity").value;
	if(actDefUniqueId==null||actDefUniqueId=="")
	{
		alert("请先选择环节!");
		return;
	}
	var record = actDataSet.getById(actDefUniqueId);

	var actType=record.get("actType");

	if(actType=="1"||actType=="3")
	{
		alert("您选择的环节类型没有处理人");
		return;
	}
	var partiesDataset = L5.DatasetMgr.lookup("partiesDataset");
	partiesDataset.baseParams["activityId"]=record.get("activityId");
	partiesDataset.load();
}

function confirmSelect(){
	var actDefUniqueId=document.getElementById("selectHistoryActivity").value;
	if(actDefUniqueId==null||actDefUniqueId=="")
	{
		alert("请先选择环节!");
		return;
	}
	var userGridPanel=L5.getCmp('userGridPanel');
    var participants=userGridPanel.getSelectionModel().getSelections();
    if(participants.length<1)
    {
		alert("请选择参与者！");
		return ;
    }
    var organIds="";
    var organNames="";
    for(i=0;i<participants.length;i++)
    {
		organIds+=participants[i].get("organId");
		organNames+=participants[i].get("organName");
		if(i<participants.length-1)
		{
			organIds+=",";
			organNames+=",";
		}
    }

	
	var returnV=new Array(4);
	var record = actDataSet.getById(actDefUniqueId);

	//选择的历史环节定义唯一Id
	returnV[0]=actDefUniqueId;
	//选择的历史环节实际处理人Id
	returnV[1]=organIds;
	//选择的历史环节实际处理人名字
	returnV[2]=organNames;
	//选择的历史环节定义Id
	returnV[3]=record.get("text");
	parent.returnValue=returnV;
	parent.close();
}
</script>


















