<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>页面定义</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>
<model:datasets>
	<model:dataset id="pageDataset" cmd="org.loushang.portal.page.cmd.PortalPageQueryCmd" method="queryAllPortalPage" autoLoad="false" pageSize="10" global="true">
		<model:record fromBean="org.loushang.portal.page.data.PortalPage">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
  <next:BorderLayout>
    <next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
	<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
	  <next:Panel>
	    <next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
	    <next:Html>			
		  <fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件
			</legend>
			<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
              <form name="queryForm" id="queryForm" onsubmit="return false;" action="" method="post" class="L5form">
	            <table  border="1" width="100%">
				  <tr>
					<td class="FieldLabel">页面名称：</td>
					<td class="FieldInput"><input type="text"  name="name" id="name" field="name"/></td>
					<td class="FieldButton" ><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp; 
					<button onclick="reset()">重置</button></td>
				  </tr>
	           </table>
	          </form>	
			</div>
		  </fieldset>
	  </next:Html>
	  </next:Panel>	
  <next:GridPanel id="pageGridPanel" title="页面定义" name="pageGridPanel" width="100%" height="100%" dataset="pageDataset" notSelectFirstRow="true">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="id" header="编号" field="id" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="页面名称" field="name" width="120">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="页面描述" field="description" width="200">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="页面布局" field="layoutType" width="120"  renderer="setLayoutType">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="页面列数" field="colCount" width="120" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="增加" handler="add"/>
		<next:ToolBarItem iconCls="edit"  text="维护" handler="update"/>
		<next:ToolBarItem iconCls="remove"  text="删除" handler="remove"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="pageDataset" displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true"/>
	</next:BottomBar>
</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script type="text/javascript">
function init(){
	pageDataset.load();
}
function setLayoutType(value,second,record)
{
	if(value=="0")
	{
		var colCount=record.get("colCount");
		return "简单布局("+colCount+"列)";
	}
	return "任意布局";
}
function add(){
	var url="jsp/portal/page/pagenew.jsp";
	L5.forward(url,"增加页面");
}
function update(){
	var pageGridPanel=L5.getCmp("pageGridPanel");
	var selecteds=pageGridPanel.getSelectionModel().getSelections();
	if(selecteds.length<1){
		L5.MessageBox.alert("消息提示","请选择一条记录");
		return false;
	}
	else if(selecteds.length>1){
		L5.MessageBox.alert("消息提示","只能选择一条记录");
		return false;
		}
	var id=selecteds[0].get("id");
	var layoutType=selecteds[0].get("layoutType");
	var url="jsp/portal/page/pageupdate.jsp?id="+id+"&layoutType="+layoutType;
	L5.forward(url,"修改页面");
}

function remove(){
	if(pageDataset.getCount()==0){
		L5.MessageBox.alert("消息提示",'没有要删除的记录!');
		return;
	}
	var pageGridPanel=L5.getCmp('pageGridPanel');
	var selected = pageGridPanel.getSelectionModel().getSelections();
	var leng = selected.length;
	if( leng==0){
		L5.MessageBox.alert("消息提示",'请选择要删除的记录!');
		return;
	}
	var ids;
	var idNames;
	L5.MessageBox.confirm("消息提示", "你确定要删除吗?",
			function(sta){
				if(sta =='yes'){
					ids = [];
					idNames = [];
					for(var i=0; i<leng; i++){
						ids[i] = selected[i].get('id');
					}
					//删除后台的数据
				if(ids.length !=0){
					var command = new L5.Command("org.loushang.portal.page.cmd.PortalPageCmd");
					command.setParameter("delIds", ids);
					command.execute("deletePortalPage");
					if (!command.error) {
						var saveResult = command.getReturn("saveResult");
						L5.MessageBox.alert("消息提示",saveResult);
						pageDataset.commitChanges();
						for(var i=0; i<leng; i++){
							pageDataset.remove(selected[i]);
						}
						pageDataset.reload();
					}else{
						L5.MessageBox.alert("消息提示",command.error);
						pageDataset.reload();
					}
				}
	}});
}

function query(){
	var pagename=document.getElementById("name").value;

	pageDataset.setParameter("name",pagename);
	pageDataset.load();
}
function reset(){
	document.getElementById("name").value="";	
}
</script>
</html>
