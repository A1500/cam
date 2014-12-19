<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
	<head>
		<title>增加微件</title>
		<next:ScriptManager></next:ScriptManager>
		
	</head>
<body style="margin:0;padding:0;scroll:auto;">
<model:datasets>
  <model:dataset id="widgetTypeDataset" enumName="LOUSHANG_PORTAL.WIDGET_TYPE"  autoLoad="true" global="true"></model:dataset>
  <model:dataset id="categeory" cmd="org.loushang.portal.category.cmd.PortalCategoryQueryCmd" autoLoad="true" method="queryPortalCategoryList">
			<model:record>
				<model:field name="value" mapping="cateId" type="string"/>
				<model:field name="text" mapping="name" type="string"/>
			</model:record>
		</model:dataset>
	<model:dataset id="portalWidgetDataset" cmd="org.loushang.portal.widget.cmd.PortalWidgetQueryCmd" method="queryPortalWidget" autoLoad="true" pageSize="10">
		<model:record>
			<model:field name="id" />
			<model:field name="name" rule="require"/>
			<model:field name="categoryId" rule="require"/>
			<model:field name="type"/>
			<model:field name="authorId"/>
			<model:field name="authorName"/>
			<model:field name="version"/>
			<model:field name="uri" rule="require"/>
			<model:field name="logoUri"/>
			<model:field name="showUri"/>
			<model:field name="bgImageUri"/>
			<model:field name="createTime"/>
			<model:field name="height"/>
			<model:field name="description"/>			
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
					<td class="FieldLabel">微件名称：</td>
					<td class="FieldInput"><input type="text"  name="name" id="name" field="name"/></td>
					<td class="FieldLabel">微件类别：</td>
					<td class="FieldInput">
			          <select name="categoryId" field="categoryId" id="categoryId" style="width:130">
						 <option dataset="categeory"/>
		              </select>
					</td>
					<td class="FieldButton" ><button onclick="Evt_qd_click()">查询</button> &nbsp;&nbsp;&nbsp;
					<button onclick="Evt_rs_click()">重置</button> </td>
				  </tr>
	           </table>
	          </form>	
			</div>
		  </fieldset>
	  </next:Html>
	  </next:Panel>			
    <next:EditGridPanel id="portalWidgetGridPanel" title="微件定义" clicksToEdit="1" name="portalWidgetGrid" width="100%" height="100%" dataset="portalWidgetDataset">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="id" header="编号" field="id" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="微件名称" field="name" width="120" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="微件类别" field="categoryId" width="120">
			<next:ComboBox dataset="categeory" typeAble="false"/>
		</next:Column>
		<next:Column header="微件作者" id="authorName" field="authorName" width="120">
			<next:TextField allowBlank="false" />
		</next:Column>	
		<next:Column header="微件访问地址"  field="uri" width="200" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="微件Logo地址"  field="logoUri" width="200" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="微件背景图片地址" field="bgImageUri" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="微件展示图片地址" field="showUri" width="200" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="微件加载方式" field="type" width="100" sortable="true">
			<next:ComboBox  dataset="widgetTypeDataset"/>
		</next:Column>
		<next:Column header="微件描述" field="description" width="150">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="创建时间" field="createTime" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="高度" field="height" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="增加" handler="Evt_butadd_click"/>
		<next:ToolBarItem iconCls="remove"  text="删除" handler="Evt_butremove_click"/>
		<next:ToolBarItem iconCls="save"  text="保存" handler="Evt_butsave_click"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="portalWidgetDataset" displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true"/>
	</next:BottomBar>
</next:EditGridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript">
function Evt_butadd_click() {
	var portalWidgetDataset=L5.DatasetMgr.lookup("portalWidgetDataset");
	var p=portalWidgetDataset.newRecord({"type":"1"});
	var portalWidgetGridPanel = L5.getCmp('portalWidgetGridPanel');
	portalWidgetGridPanel.stopEditing();
}

function Evt_butremove_click() {
	var portalWidgetDataset=L5.DatasetMgr.lookup("portalWidgetDataset");
	if(portalWidgetDataset.getCount()==0){
		L5.MessageBox.alert("消息提示",'没有要删除的记录!');
		return;
	}
	var portalWidgetGridPanel = L5.getCmp('portalWidgetGridPanel');
	var selected = portalWidgetGridPanel.getSelectionModel().getSelections();
	var leng = selected.length;
	if( leng< 1){
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
						if(selected[i].state !=1){//不是新增的才需要到后台去验证是否被引用
							ids[i] = selected[i].get('id');
						}
					}

					//删除后台的数据
					if(ids.length !=0){
						var command = new L5.Command("org.loushang.portal.widget.cmd.PortalWidgetCmd");
						command.setParameter("delIds", ids);
						command.execute("deletePortalWidget");
						if(command.error){
							L5.MessageBox.alert("消息提示",command.error);
							portalWidgetDataset.load();
							return;
						}
						var saveResult = command.getReturn("saveResult");
						L5.MessageBox.alert("消息提示",saveResult);
						portalWidgetDataset.commitChanges();
						for(var i=0; i<leng; i++){
							portalWidgetDataset.remove(selected[i]);
						}
						portalWidgetDataset.reload();
					}else{
						for(var i=0; i<leng; i++){
							portalWidgetDataset.remove(selected[i]);
						}
					}
					
	}});
}

function Evt_butsave_click() {
	var portalWidgetDataset=L5.DatasetMgr.lookup("portalWidgetDataset");
	var records = portalWidgetDataset.getAllChangedRecords();
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
			//微件名称
			var widgetName=record.get("name");
			if(!widgetName||widgetName.replace(/(^\s*)|(\s*$)/g, "")=="")
			{
				L5.MessageBox.alert("消息提示","[微件名称]不能为空!");
				return;
			}
			
			else if(widgetName.length>50)
			{
				L5.MessageBox.alert("消息提示","[微件名称]超长!");
				return;
			}
			var categoryId=record.get("categoryId");
			if(categoryId==null||categoryId==""){
				L5.MessageBox.alert("消息提示","请选择微件所属的[微件类别]!");
				return;
			}
			//微件作者
			var authorName=record.get("authorName");
			if(authorName.length>50)
			{
				L5.MessageBox.alert("消息提示","[微件作者]超长!");
				return;
			}
			//微件地址
			var uri=record.get("uri");
			if(!uri||uri.replace(/(^\s*)|(\s*$)/g, "")=="")
			{
				L5.MessageBox.alert("消息提示","[微件访问地址]不能为空!");
				return;
			}
			else if(uri.length>100)
			{
				L5.MessageBox.alert("消息提示","[微件访问地址]超长!");
				return;
			}
			//微件作者
			var logoUri=record.get("logoUri");
			if(logoUri.length>100)
			{
				L5.MessageBox.alert("消息提示","[微件logo地址]超长!");
				return;
			}
			var description=record.get("description");
			if(description.length>50)
			{
				L5.MessageBox.alert("消息提示","[微件描述]超长!");
				return;
			}
			
		}
	}
	var command = new L5.Command("org.loushang.portal.widget.cmd.PortalWidgetCmd");
	command.setParameter("records", records);
	command.execute('savePortalWidget');
	if (!command.error) {
		portalWidgetDataset.load();
		var saveResult = command.getReturn("saveResult");
		L5.MessageBox.alert("消息提示",saveResult);
	}
	else{
		L5.MessageBox.alert("消息提示",command.error);
		return;
	}
}

function Evt_qd_click(element,e){
	var portalWidgetDataset=L5.DatasetMgr.lookup("portalWidgetDataset");
	var widgetName=L5.getDom("queryForm").name.value;

	var categoryId=L5.getDom("queryForm").categoryId.value;
	portalWidgetDataset.setParameter("NAME",widgetName);
	portalWidgetDataset.setParameter("CATEGORY_ID",categoryId);
	
	portalWidgetDataset.load();
}

function Evt_rs_click(element,e){
	L5.getDom("queryForm").name.value = "";
	L5.getDom("queryForm").categoryId.value = "";
}
</script>
</html>
