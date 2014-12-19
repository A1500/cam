<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
</head>
<model:datasets>
<model:dataset id="categoryDataset" cmd="org.loushang.portal.category.cmd.PortalCategoryQueryCmd" autoLoad="false" method="queryPortalCategoryPage" pageSize="10" global="true">
	<model:record>
	<model:field name="cateId" />
	<model:field name="name" rule="require"/>
	<model:field name="description" />
	<model:field name="displayOrder" type="int"/>
	</model:record>
</model:dataset>

</model:datasets>
<body>
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
					<td class="FieldLabel">类别名称：</td>
					<td class="FieldInput"><input type="text"  name="name" id="name" field="name"/></td>
					
					<td class="FieldButton" ><button onclick="queryCategory()">查询</button> &nbsp;&nbsp;&nbsp;
					<button onclick="resetCategory()">重置</button> </td>
				  </tr>
	           </table>
	          </form>	
			</div>
		  </fieldset>
	  </next:Html>
	  </next:Panel>			
  <next:EditGridPanel id="portalCategoryGridPanel" title="微件类别" clicksToEdit="1" name="portalCategoryGrid" width="100%" height="100%" dataset="categoryDataset">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="cateId" header="编号" field="cateId" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="类别名称" field="name" width="150" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="类别描述" field="description" width="200">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="显示顺序" field="displayOrder" width="120" >
			<next:NumberField allowBlank="false" minValue="0" maxValue="100"/>
		</next:Column>
	</next:Columns>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="增加" handler="addCategory"/>
		<next:ToolBarItem iconCls="remove"  text="删除" handler="removeCategory"/>
		<next:ToolBarItem iconCls="save"  text="保存" handler="saveCategory"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="categoryDataset" displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true"/>
	</next:BottomBar>
</next:EditGridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script type="text/javascript">
function init(){
	categoryDataset.load();
}

function addCategory(){
	categoryDataset.newRecord();
	var portalCategoryGridPanel = L5.getCmp('portalCategoryGridPanel');
	portalCategoryGridPanel.stopEditing();
}

function removeCategory(){
	if(categoryDataset.getCount()==0){
		L5.MessageBox.alert("消息提示",'没有要删除的记录!');
		return;
	}
	var portalCategoryGridPanel = L5.getCmp('portalCategoryGridPanel');
	var selected = portalCategoryGridPanel.getSelectionModel().getSelections();
	var leng = selected.length;
	if( leng< 1){
		L5.MessageBox.alert("消息提示",'请选择要删除的记录!');
		return;
	}
	var cateIds;
	L5.MessageBox.confirm("消息提示", "你确定要删除吗?",
			function(sta){
				if(sta =='yes'){
					cateIds = [];
					for(var i=0; i<leng; i++){
						if(selected[i].state !=1){//不是新增的才需要到后台去验证是否被引用
							cateIds[i] = selected[i].get('cateId');
						}
					}
					//删除后台的数据
					if(cateIds.length !=0){
						var command = new L5.Command("org.loushang.portal.category.cmd.PortalCategoryCmd");
						command.setParameter("delCateIds", cateIds);
						command.execute("deletePortalCategory");
						if(command.error){
							L5.MessageBox.alert("消息提示",command.error);
							categoryDataset.load();
							return;
						}
						var saveResult = command.getReturn("saveResult");
						L5.MessageBox.alert("消息提示",saveResult);
						categoryDataset.commitChanges();
						for(var i=0; i<leng; i++){
							categoryDataset.remove(selected[i]);
						}
						categoryDataset.reload();
					}else{
						for(var i=0; i<leng; i++){
							categoryDataset.remove(selected[i]);
						}
					}
					
				}});
				
}

function saveCategory(){
	var records = categoryDataset.getAllChangedRecords();
	if(records.length<1){
		L5.MessageBox.alert("消息提示","没有需要保存的数据!");
		return false;
	}
	//逐一校验
	else
	{
		for(var i=0;i<records.length;i++)
		{
			var record=records[i];
			var widgetName=record.get("name");
			if(!widgetName||widgetName.replace(/(^\s*)|(\s*$)/g, "")=="")
			{
				L5.MessageBox.alert("消息提示","[类别名称]不能为空!");
				return;
			}
			else if(widgetName.length>50)
			{
				L5.MessageBox.alert("消息提示","[类别名称]超长!");
				return;
			}
			var description=record.get("description");
			if(description.length>50)
			{
				L5.MessageBox.alert("消息提示","[类别描述]超长!");
				return;
			}
		}
	}
	var command = new L5.Command("org.loushang.portal.category.cmd.PortalCategoryCmd");
	command.setParameter("records", records);
	command.execute('savePortalCategory');
	if (!command.error) {
		categoryDataset.commitChanges();
		categoryDataset.load();
		L5.MessageBox.alert("消息提示","保存成功！");
	}else{
		L5.MessageBox.alert("消息提示",command.error);
		return;
	}
	
}

function queryCategory(){
	var name = document.getElementById("name").value;

	categoryDataset.setParameter("name",name);
	categoryDataset.load();
}

function resetCategory(){
	document.getElementById("name").value = "";
}

</script>
</html>