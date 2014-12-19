<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.portal.util.PortalJspUtil" %>
<html>
	<head>
		<title>页面模板</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>
<model:datasets>
	<model:dataset id="templateDataset" cmd="org.loushang.portal.template.cmd.PortalTemplateQueryCmd" method="queryPortalTemplatePage" autoLoad="false" pageSize="10" global="true">
	<model:record >
	    <model:field name="templateId" type="string"/>
		<model:field name="templateName" type="string"/>
		<model:field name="pageId" type="string"/>
		<model:field name="pageName" type="string"/>
		<model:field name="type"  type="string"/>
		<model:field name="layoutType"  type="string"/>
		<model:field name="colCount" type="string"/>
		<model:field name="permitIds" type="string"/>
		<model:field name="permitNames" type="string"/>
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
			<form onsubmit="return false;" class="L5form">	
	            <table  border="1" width="100%">
				  <tr>
					<td class="FieldLabel">模板名称：</td>
					<td class="FieldInput"><input type="text" class="TextEditor" id="templateName" /></td>
					<td class="FieldLabel">页面名称：</td>
					<td class="FieldInput"><input type="text" class="TextEditor" id="pageName" /></td>
					<td class="FieldButton" ><button onclick="queryTemplate()">查询</button>&nbsp;&nbsp;&nbsp; 
					<button onclick="resetCondition()">重置</button></td>
				  </tr>
	           </table>
	          </form>	
			</div>
		  </fieldset>
	  </next:Html>
	  </next:Panel>	
<next:GridPanel id="panel" title="页面模板" name="panelGrid" width="100%" height="100%" dataset="templateDataset" notSelectFirstRow="true">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="templateId" header="模板id" field="templateId" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="type" header="模板类型" field="type" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="模板名称" field="templateName" width="120">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="pageId" header="页面Id" field="pageId" width="80" sortable="true" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="页面名称" field="pageName" width="120">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="页面布局" field="layoutType" width="120"  renderer="setLayoutType">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="页面列数" field="colCount" width="120" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="使用范围" field="permitIds"  width="0" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="使用范围" field="permitNames"  width="300">
		</next:Column>
	</next:Columns>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="增加" handler="addTemplate"/>
		<next:ToolBarItem iconCls="edit"  text="维护" handler="updateTemplate"/>
		<next:ToolBarItem iconCls="edit"  text="设计模板" handler="designTemplate"/>
		<next:ToolBarItem iconCls="edit"  text="应用模板" handler="applyTemplate"/>
		<next:ToolBarItem iconCls="remove"  text="删除" handler="removeTemplate"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="templateDataset" displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true"/>
	</next:BottomBar>
</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script type="text/javascript">
//初始化
function init(){
	templateDataset.load();
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
//增加模板
function addTemplate(){
	var url="jsp/portal/template/pagetemplatenew.jsp" ;
	L5.forward(url,"增加模板");
}
//维护模板
function updateTemplate(){
	var panel=L5.getCmp("panel");
	var selecteds=panel.getSelectionModel().getSelections();
	if(selecteds.length<1){
		L5.MessageBox.alert("消息提示","请选择一条记录");
		return false;
	}
	else if(selecteds.length>1){
		L5.MessageBox.alert("消息提示","只能选择一条记录");
		return false;
		}
	var id=selecteds[0].get("pageId");
	var templateId=selecteds[0].get("templateId");
	var type = selecteds[0].get("type");
	var colCount=selecteds[0].get("colCount");
	var url="jsp/portal/template/pagetemplateupdate.jsp?templateId="+templateId+"&type="+type;
	L5.forward(url,"维护页面");
}
//设计模板
function designTemplate(){
	var panel=L5.getCmp("panel");
	var selecteds=panel.getSelectionModel().getSelections();
	if(selecteds.length<1){
		L5.MessageBox.alert("消息提示","请选择一条记录");
		return false;
	}
	else if(selecteds.length>1){
		L5.MessageBox.alert("消息提示","只能选择一条记录");
		return false;
		}
	var pageId=selecteds[0].get("pageId");
	var templateId = selecteds[0].get("templateId");
	var url="jsp/portal/template/pagetemplatedesign.jsp?templateId="+templateId+"&pageId="+pageId;
	L5.forward(url,"设计模板");
}
//应用模板
function applyTemplate(){
	var panelGrid=L5.getCmp('panel');
	var selected = panelGrid.getSelectionModel().getSelections();
	var leng = selected.length;
	if( leng==0){
		L5.MessageBox.alert("消息提示",'请选择要应用的记录');
		return;
	}
	templateIds = [];
	for(var i=0; i<leng; i++){
		templateIds[i] = selected[i].get('templateId');
	}
	//应用模板
	if(templateIds.length > 0){
		var command = new L5.Command("org.loushang.portal.template.cmd.PortalTemplateCmd");
		command.setParameter("templateIds",templateIds);
	    command.afterExecute=function(){
			if (!command.error) {
				L5.MessageBox.alert("消息提示",'应用成功');
			}else{
				L5.MessageBox.alert("消息提示",command.error);
			}
	    }
	    command.execute('applyPortalTemplate');
	}
}
//删除模板
function removeTemplate(){
	if(templateDataset.getCount()==0){
		L5.MessageBox.alert("消息提示",'没有要删除的记录!');
		return;
	}
	var panelGrid=L5.getCmp('panel');
	var selected = panelGrid.getSelectionModel().getSelections();
	var leng = selected.length;
	if( leng==0){
		L5.MessageBox.alert("消息提示",'请选择要删除的记录!');
		return;
	}
	var ids;
	var idNames;
	L5.MessageBox.confirm("消息提示", "你确定要删除吗?",
			function(sta){
				ids = [];
				idNames = [];
				for(var i=0; i<leng; i++){
				  ids[i] = selected[i].get('templateId');
				}
				var isDeleteUserLayout='0';
				if(sta =='yes'){
					L5.MessageBox.confirm("消息提示", "是否删除相应的用户页面布局？",
							function(sta){
								if(sta =='yes'){
									isDeleteUserLayout='1';
								}
								//删除后台的数据
								if(ids.length !=0){
									var command = new L5.Command("org.loushang.portal.template.cmd.PortalTemplateCmd");
									command.setParameter("delIds", ids);
									command.setParameter("isDeleteUserLayout", isDeleteUserLayout);
									command.execute("deletePortalTemplate");
									if (!command.error) {
										L5.MessageBox.alert("消息提示",'删除成功');
										templateDataset.commitChanges();
										for(var i=0; i<leng; i++){
											templateDataset.remove(selected[i]);
										}
										templateDataset.reload();
									}else{
										L5.MessageBox.alert("消息提示",command.error);
									}
								}
							});
	}});
}
//查询模板
function queryTemplate(){
	var pageName=document.getElementById("pageName").value;
	var templateName=document.getElementById("templateName").value;

	templateDataset.setParameter("templateName",templateName);
	templateDataset.setParameter("pageName",pageName);
	templateDataset.load();
}
//重置查询条件
function resetCondition(){
	document.getElementById("pageName").value="";	
	document.getElementById("templateName").value="";
}
</script>
</html>
