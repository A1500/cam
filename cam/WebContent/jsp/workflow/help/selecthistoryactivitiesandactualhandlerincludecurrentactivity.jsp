<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List"%>
<HTML>
<HEAD>
<TITLE>选择历史环节以及实际处理人</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY style="margin:0px;padding: 0px;">
<model:datasets>
	<model:dataset id="actDataSet"
		cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" global="true" autoLoad="true" method="selectHistoryActivitiesAndActualHandlerIncludeCurrentActivity">
		<model:record >
			<model:field name="actDefName" type="string"></model:field>
			<model:field name="actDefUniqueId" type="string"></model:field>
			<model:field name="actualOrganIds" type="string"></model:field>
			<model:field name="actualOrganNames" type="string"></model:field>
			<model:field name="actDefId" type="string"></model:field>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="confirmSelect"></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="undo" handler="cancleSelect"></next:ToolBarItem>
	</next:TopBar>
	
	<next:Panel  height="100%">
		<next:Html>
    		<next:GridPanel id="userGridPanel" height="100%" width="100%" name="partiesGridPanel" autoScroll="true"
    					dataset="actDataSet"     title="请选择要退回的环节" notSelectFirstRow="true">
				<next:Columns>
				<next:RowNumberColumn width="20"/>
				<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="actualOrganIds" header="实际处理人ID" field="actualOrganIds" width="50" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="actDefUniqueId" header="环节定义唯一Id" field="actDefUniqueId" width="130" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="actDefId" header="环节定义Id" field="actDefId" width="130" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="环节名称" field="actDefName" width="160">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="环节实际处理人" field="actualOrganNames" width="283">
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

function cancleSelect(){
	parent.close();
}

function confirmSelect(){
	var userGridPanel=L5.getCmp('userGridPanel');
    var participants=userGridPanel.getSelectionModel().getSelections();
    if(participants.length<1)
    {
		alert("请选择要退回的环节！");
		return ;
    }
    if(participants.length>1)
    {
		alert("您只能选择一个环节！");
		return ;
    }
	
	var returnV=new Array(4);

	//选择的历史环节定义唯一Id
	returnV[0]=participants[0].get("actDefUniqueId");
	//选择的历史环节实际处理人Id
	returnV[1]=participants[0].get("actualOrganIds");
	//选择的历史环节实际处理人名字
	returnV[2]=participants[0].get("actualOrganNames");
	//选择的历史环节定义Id
	returnV[3]=participants[0].get("actDefId");
	parent.returnValue=returnV;
	parent.close();
}
</script>


















