<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>

<HTML>
<HEAD>
<TITLE>参与者帮助</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY>
<model:datasets>
	<model:dataset pageSize="10" id="partiesDataset" cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" autoLoad="true" method="selectActivityParties">
		<model:record >
			<model:field name="organId"  type="string"></model:field>
			<model:field name="organName"  type="string"></model:field>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel >
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save"  text="确定" handler="doConfirm"/>
			<next:ToolBarItem iconCls="undo"  text="关闭" handler="doClose"/>
	</next:TopBar>
	<next:Panel height="400">
			<next:Html>
    		<next:GridPanel id="userGridPanel" height="398" name="partiesGridPanel"  dataset="partiesDataset"     title="选择组织机构" notSelectFirstRow="true">
				<next:Columns>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="organId" header="机构ID" field="organId" width="50" hidden="true">
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="机构名称" field="organName" width="100%">
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
			</next:GridPanel>
    		</next:Html>
	</next:Panel>
</next:Panel>
<script language="javascript">
function doConfirm(){
	var userGridPanel=L5.getCmp('userGridPanel');
    var participants=userGridPanel.getSelectionModel().getSelections();
    if(participants.length<1)
    {
		alert("请选择组织机构！");
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
	returnV[0]=organIds;
	returnV[1]=organNames;
	parent.returnValue=returnV;
	parent.close();
}
function doClose(){
	parent.close();
}
</script>