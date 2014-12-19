<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
	<head>
		<title>帮助信息</title>
		<next:ScriptManager></next:ScriptManager>
		
	</head>
<%
	String pageId = request.getParameter("pageId");
%>
<body style="margin:0;padding:0;scroll:auto;">
<model:datasets>
	<model:dataset id="portalPageHelperDataset" cmd="org.loushang.portal.page.cmd.PortalPageQueryCmd" method="queryAllPortalPage" autoLoad="false" pageSize="10">
		<model:record fromBean="org.loushang.portal.page.data.PortalPage">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
  <next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
    <next:Panel >
    <next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
	    <next:Html>			
		  <fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件
			</legend>
			<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
              <form name="queryForm" id="queryForm" action="" method="post" class="L5form" onsubmit="return false;">
	            <table  border="1" width="100%">
				  <tr>
					<td class="FieldLabel">页面名称：</td>
					<td class="FieldInput"><input type="text"  name="name" id="name" /></td>
					<td class="FieldButton" ><button onclick="query()">查询</button> &nbsp;&nbsp;&nbsp; 
					<button onclick="reset()">重置</button></td>
					</tr>
	           </table>
	          </form>	
			</div>
		  </fieldset>
	  </next:Html>
	  </next:Panel>		
    <next:GridPanel  id="portalPageGridPanel" autoScroll="true" title="选择页面" name="portalPageGrid" width="100%" height="100%" dataset="portalPageHelperDataset" frame="true">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn ></next:RadioBoxColumn>
		<next:Column id="id" header="页面id" field="id" width="100" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="页面名称" field="name" width="170" editable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="页面描述" field="description" width="170" editable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>

	</next:Columns>
	<next:TopBar>		
					<next:ToolBarItem symbol="->"/>	
					<next:ToolBarItem iconCls="add"  text="确定" handler="forSure"/>
					<next:ToolBarItem iconCls="delete"  text="关闭" handler="forClose"/>
					<next:ToolBarItem iconCls="undo"  text="清除" handler="forCancel"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="portalPageHelperDataset" displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true"/>
	</next:BottomBar>
</next:GridPanel >
			</next:Panel>
</next:ViewPort>
</body>
<script language="javascript">
function init(){
	var portalPageHelperDataset=L5.DatasetMgr.lookup("portalPageHelperDataset");
    portalPageHelperDataset.load();
    L5.QuickTips.init();
    portalPageHelperDataset.on("load",setSelect);
}
function setSelect(){
	var portalPageHelperDataset=L5.DatasetMgr.lookup("portalPageHelperDataset");
	 var recordCount = portalPageHelperDataset.getCount();
	    var records = portalPageHelperDataset.getAllRecords();
	    var pageId = '<%=pageId %>';
	    if(pageId != null && pageId != ""){
	    	for(var i = 0; i < records.length; i++){
	    		var record  = records[i];
	    		var id = record.get("id");
	    		if(pageId == id){
	    			var panel=L5.getCmp('portalPageGridPanel'); 
	    		    panel.getSelectionModel().selectRow(i);
	    		    return;
	    		}
	    	}
	    }
}
function forSure(){
	var portalPageGridPanel = L5.getCmp("portalPageGridPanel");
	var selected = portalPageGridPanel.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("消息提示","请选择一条记录");
		return false;
	}
	var returnValue=[];
	var id = selected[0].get("id");
	var name = selected[0].get("name");
	returnValue[0] = id;
	returnValue[1] = name;
	window.returnValue = returnValue;
	window.close();
}
function forClose(){
	window.returnValue="";
	window.close();

}
function forCancel(){
	var returnValue=[];
	var id = "";
	var name = "";
	returnValue[0] = id;
	returnValue[1] = name;
	window.returnValue = returnValue;
	window.close();
}
function query(){
	var pagename = document.getElementById("name").value;
	var portalPageHelperDataset=L5.DatasetMgr.lookup("portalPageHelperDataset");
	portalPageHelperDataset.setParameter("name",pagename);
	portalPageHelperDataset.load();
}
function reset(){
	document.getElementById("name").value="";
}
</script>
</html>
