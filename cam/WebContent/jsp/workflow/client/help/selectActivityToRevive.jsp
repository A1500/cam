<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>

<HTML>
<HEAD>
<TITLE>环节帮助</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY>
<model:datasets>
	<model:dataset id="actDataSet"
		cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" global="true" autoLoad="true" method="selectActivityToRevive">
		<model:record >
			<model:field name="actDefName" type="string"></model:field>
			<model:field name="actDefUniqueId" type="string"></model:field>
			<model:field name="processId" type="string"></model:field>
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
    		<next:GridPanel id="actGridPanel" height="398" name="actGridPanel"  dataset="actDataSet"     title="选择要激活的环节" notSelectFirstRow="true">
				<next:Columns>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="环节定义唯一ID" field="actDefUniqueId" width="50" hidden="true">
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="环节名称" field="actDefName" width="100%">
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
			</next:GridPanel>
    		</next:Html>
	</next:Panel>
</next:Panel>
<script language="javascript">
function doConfirm(){
	var actGridPanel=L5.getCmp('actGridPanel');
    var acts=actGridPanel.getSelectionModel().getSelections();
    if(acts.length<1)
    {
		alert("请选择要激活的环节！");
		return ;
    }
	var returnV=new Array(2);
	returnV[0]=acts[0].get("actDefUniqueId");
	returnV[1]=acts[0].get("actDefName");
	parent.returnValue=returnV;
	parent.close();
}
function doClose(){
	parent.close();
}
</script>