<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>用户页面定义</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>
<model:datasets>
	<model:dataset id="portalCurUserLayoutDataset" cmd="org.loushang.portal.layout.cmd.PortalUserLayoutQueryCmd" method="queryCurUserPortalLayout" autoLoad="false" pageSize="10" global="true">
		<model:record  >
			<model:field name="id" type="string"/>
			<model:field name="pageId" type="string"/>
			<model:field name="pageName" type="string" />
			<model:field name="userId" type="string" />
			<model:field name="sort" type="int"/>
			<model:field name="isShow" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="isDisplayDataset" enumName="LOUSHANG_PORTAL.IS_DISPLAY"  autoLoad="true" global="true"></model:dataset>
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
					<td class="FieldInput"><input type="text"  name="pageName" id="pageName" field="pageName"/></td>
					<td class="FieldButton" ><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp; 
					<button onclick="reset()">重置</button></td>
				  </tr>
	           </table>
	          </form>	
			</div>
		  </fieldset>
	  </next:Html>
	  </next:Panel>	
  <next:EditGridPanel id="curUserlayoutGridPanel" title="门户页面" name="curUserlayoutGridPanel" width="100%" height="100%" dataset="portalCurUserLayoutDataset">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column  header="编号" field="id" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column  header="页面Id" field="pageId" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column  header="用户Id" field="userId" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="页面名称" field="pageName" width="120">
		</next:Column>
		<next:Column header="是否显示" field="isShow" width="100">
			<next:ComboBox  dataset="isDisplayDataset" typeAble="false"/>
		</next:Column>
		<next:Column header="显示顺序" field="sort" width="120">
			<next:NumberField allowBlank="false" minValue="0" maxValue="100"/>
		</next:Column>
	</next:Columns>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit"  text="维护页面布局" handler="update"/>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="portalCurUserLayoutDataset" displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true"/>
	</next:BottomBar>
</next:EditGridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script type="text/javascript">

function init(){
	portalCurUserLayoutDataset.load();
}
function save(){
	var isValidate = portalCurUserLayoutDataset.isValidate();
	if (isValidate != true) {
		L5.MessageBox.alert("消息提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = portalCurUserLayoutDataset.getAllChangedRecords();
	if (records.length < 1) {// 没有做任何修改,返回
		L5.MessageBox.alert("消息提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.portal.layout.cmd.PortalUserLayoutCmd");
	command.setParameter("records", records);
	command.execute("savePortalUserLayout");
	if (!command.error) {
		portalCurUserLayoutDataset.commitChanges();
		portalCurUserLayoutDataset.reload();
		L5.MessageBox.alert("消息提示", "数据保存成功!");
	} else {
		L5.MessageBox.alert("消息提示",command.error);
	}
}
function update(){
	var curUserlayoutGridPanel=L5.getCmp("curUserlayoutGridPanel");
	var selecteds=curUserlayoutGridPanel.getSelectionModel().getSelections();
	if(selecteds.length<1){
		L5.MessageBox.alert("消息提示","请选择一条记录");
		return false;
	}
	else if(selecteds.length>1){
		L5.MessageBox.alert("消息提示","只能选择一条记录");
		return false;
		}
	var id=selecteds[0].get("id");
	var pageId=selecteds[0].get("pageId");
	var url="jsp/portal/layout/curuserlayoutdesign.jsp?id="+id+"&pageId="+pageId;
	L5.forward(url,"设计页面");
}

function remove(){
	if(portalCurUserLayoutDataset.getCount()==0){
		L5.MessageBox.alert("消息提示",'没有要删除的记录!');
		return;
	}
	var curUserlayoutGridPanel=L5.getCmp('curUserlayoutGridPanel');
	var selected = curUserlayoutGridPanel.getSelectionModel().getSelections();
	var leng = selected.length;
	if( leng==0){
		L5.MessageBox.alert("消息提示",'请选择要删除的记录!');
		return;
	}
	var ids;
	var idNames;
	var deleteLayoutIds;
	L5.MessageBox.confirm("消息提示", "你确定要删除吗?", function(state){
		if(state=="yes"){   
			deleteLayoutIds = [];
			for(var i=0;i<selected.length;i++){
				deleteLayoutIds[i] = selected[i].get("id");
				portalCurUserLayoutDataset.remove(selected[i]);
			}
			var command = new L5.Command("org.loushang.portal.layout.cmd.PortalUserLayoutCmd");
			command.setParameter("deleteLayoutIds", deleteLayoutIds);
			command.execute("deletePortalLayout");
			if (!command.error) {
				portalCurUserLayoutDataset.commitChanges();
				portalCurUserLayoutDataset.reload();
				L5.MessageBox.alert("消息提示", "删除成功!");
			} else {
				L5.MessageBox.alert("消息提示",command.error);
			}
		}else{
			return false;
		}
	});
	
}

function query(){
	var pagename=document.getElementById("pageName").value;
	portalCurUserLayoutDataset.setParameter("pageName",pagename);
	portalCurUserLayoutDataset.load();
}
function reset(){
	document.getElementById("pageName").value="";	
}
</script>
</html>
