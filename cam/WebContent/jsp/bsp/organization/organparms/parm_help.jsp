<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>参数-定义</title>

<script type="text/javascript">


function init() {


	var parmsHelpDs=L5.DatasetMgr.lookup("parmsHelpDs");
	var parmTypeName='<%=request.getParameter("parmTypeName")%>';
	parmTypeName = decodeURIComponent(parmTypeName);
	parmsHelpDs.setParameter("parmTypeName",parmTypeName);
	parmsHelpDs.load();

};

function confirm(){
	var userGrid=L5.getCmp('helpGridPanel');
	var selected=userGrid.getSelectionModel().getSelections();
	var length = selected.length;
	if(length==0){
		L5.MessageBox.alert('提示 ',"请选择记录！");
		return false;
	}
	var rs = new Array();
	var retParmValue="";
	var retParmNote="";
	for(var i=0;i<length;i++){
		var data = selected[i];
		retParmValue=retParmValue+data.get('selcol');
		retParmNote=retParmNote+data.get('dispcol');
		if(i!=length-1){
			retParmValue=retParmValue+",";
			retParmNote=retParmNote+",";
		}
	}
	rs.push(retParmValue);
	rs.push(retParmNote);
	window.returnValue=rs;
	window.close();
}
function clear1(){
	var rs = new Array();
	rs.push("");
	rs.push("");
	window.returnValue=rs;
	window.close();

}
function winclose(){
	window.close();

}

</script>
</head>
<body>
<model:datasets>
<model:dataset id="parmsHelpDs" autoLoad="true" cmd="org.loushang.bsp.organization.cmd.PubOrganParmsHelpQueryCommand">
	<model:record>
		<model:field name="selcol" mapping="SELCOL"/>
		<model:field name="dispcol" mapping="DISPCOL"/>

	</model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="yes" text="确定"  handler="confirm" ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="undo" text="清除" handler="clear1"  ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="no" text="关闭" handler="winclose" ></next:ToolBarItem>
	</next:TopBar>

<next:GridPanel id="helpGridPanel" name="helpGrid" dataset="parmsHelpDs" stripeRows="true" width="100%" height="450">
	<next:Columns>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="值" width="160" field="selcol"/>
		<next:Column header="描述" width="120" field="dispcol"/>

	</next:Columns>

</next:GridPanel>
</next:Panel>
</body>
</html>