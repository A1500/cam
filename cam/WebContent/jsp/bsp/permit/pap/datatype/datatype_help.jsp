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
	var parmsHelpDs=L5.DatasetMgr.lookup("organTypeDs");	
	parmsHelpDs.load();

};
 
function confirm(){
	var userGrid=L5.getCmp('helpGridPanel');
	var selected=userGrid.getSelectionModel().getSelections();
	var data = selected[0];
	var rs = new Array();
	rs.push(data.get('value'));
	rs.push(data.get('text'));		
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
<div style="display:none">
	<xml id="datasetDiv" >
		<datasets>
			<dataset id="organTypeDs" autoLoad="true" proxy="cmd" sortField="ORGAN_TYPE">
				<record>
					<field name="value" mapping="organType" type="string" />
					<field name="text" mapping="typeName" type="string" />
				</record>
				<command>org.loushang.bsp.organization.cmd.OrganTypeQueryCommand</command>
			</dataset>
		</datasets>
	</xml>
</div>
<next:Panel>
<next:TopBar>
		<next:ToolBarItem  symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="add" text="确定"  handler="confirm" ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="undo" text="清除" handler="clear1"  ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="remove" text="关闭" handler="winclose" ></next:ToolBarItem>
	</next:TopBar>

<next:GridPanel id="helpGridPanel" name="helpGrid" dataset="organTypeDs" stripeRows="true" width="100%" height="450">
	<next:Columns>		
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="机构编码" width="160" field="value"/>
		<next:Column header="机构名称" width="120" field="text"/>
		
	</next:Columns>
	
</next:GridPanel>
</next:Panel>
</body>
</html>