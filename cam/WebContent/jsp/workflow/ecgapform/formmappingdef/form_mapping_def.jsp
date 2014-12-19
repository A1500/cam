<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>流程表单映射列表</title>
		<next:ScriptManager></next:ScriptManager>
		<script language="javascript"  type="text/javascript" >
			//跳转到增加表单映射页面
			function addFormMapping()
			{
				var url='jsp/workflow/ecgapform/formmappingdef/form_mapping_def_edit.jsp';
			    var text = '流程映射定义';
			    L5.forward(url,text);
			}

			//跳转到更新表单映射页面
			function updateFormMapping()
			{
				var userGrid=L5.getCmp('userGridPanel');
				var selected = userGrid.getSelectionModel().getSelections();
				if(selected.length!=1){
					L5.Msg.alert("提示","请选择一条需要更新的记录！");
					return false;
				}
				var url='jsp/workflow/ecgapform/formmappingdef/form_mapping_def_edit.jsp?mappingId='+selected[0].get("mappingId");
			    var text = '流程映射定义';
			    L5.forward(url,text);
			}

			//删除表单映射
			function deleteFormMapping()
			{
				var userGrid=L5.getCmp('userGridPanel');
				var selected = userGrid.getSelectionModel().getSelections();
				if(selected.length<1){
					L5.Msg.alert("提示","请选择要删除的记录！");
					return false;
				}
				var formMappingDataset = L5.DatasetMgr.lookup("formMappingDataset");
				L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
					if(state=="yes"){
						var itemIds=[];
						for(var i=0;i<selected.length;i++){
							itemIds[i]=selected[i].get("mappingId");
						}
						var command=new L5.Command("org.loushang.workflow.ecgapform.formmappingdef.cmd.FormMappingCmd"); 
						command.setParameter("itemIds", itemIds);
						command.execute("deleteFormMapping");
						if (!command.error) {
							for(var i=0;i<selected.length;i++){
								formMappingDataset.remove(selected[i]);		    	
							}
							L5.Msg.alert("提示","删除成功！");
						}else{
							L5.Msg.alert("错误",command.error);
						}
					}else{
						return false;
					}
				});
			}
			//查询表单映射
			function query(){
				 var mappingName=document.getElementById("mappingName").value;
				 var formCaption=document.getElementById("formCaption").value;
				 var associatedFormCaption=document.getElementById("associatedFormCaption").value;
				 var dataSet=L5.DatasetMgr.lookup("formMappingDataset");
				 dataSet.setParameter("MAPPING_NAME@like",mappingName);
				 dataSet.setParameter("FORM_CAPTION@like",formCaption);
				 dataSet.setParameter("ASSOCIATED_FORM_CAPTION@like",associatedFormCaption);
				 dataSet.load();
			};
		</script>
	</head>
<body>
<div style="display:none">
<xml id="datasetDiv" >
	<datasets>
		<dataset id="formMappingDataset" proxy="cmd" pageSize="10" autoLoad="true">
			<record>
				<field name="mappingId"  type="string" />
				<field name="mappingName" type="string" />
				<field name="formId" type="string" />
				<field name="formCaption" type="string" />
				<field name="associatedFormId" type="string" />
				<field name="associatedFormCaption" type="string" />
			</record>
			<command>org.loushang.workflow.ecgapform.formmappingdef.cmd.FormMappingDefQueryCmd</command>
		</dataset>
	</datasets>
</xml>
</div>
<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:Panel width="100%" border="0" >
				<next:Html>			
				<fieldset style="overflow: visible;" class="GroupBox">
					<div class="GroupBoxDiv" style="width: 100%;height: 30px;">	
						<form onsubmit="return false;"  class="L5form">				
							<table  border="1" width="100%">
								<tr>
									<td class="FieldLabel" >映射名称</td>
									<td class="FieldInput" >
										<input type="text" id="mappingName" title="映射名称" />
									</td>
									<td class="FieldLabel" >目标表单名称</td>
									<td class="FieldInput" >
										<input type="text" id="formCaption"title="表单名称" />
									</td>
									<td class="FieldLabel">数据源表单名称：</td>
									<td class="FieldInput">
										<input type="text" id="associatedFormCaption" title="数据源表单名称" />
									</td>
									<td class="FieldButton"><input type="button" onclick="query()" value="查询" style="width:75px;" /> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>			
			<next:GridPanel id="userGridPanel" name="userGridPanel" width="100%" height="100%" dataset="formMappingDataset"     title="表单映射列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="mappingId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="映射名称" field="mappingName" width="200" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="目标表单ID" field="formId" width="200" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="目标表单名称" field="formCaption" width="200" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="数据源表单ID" field="associatedFormId" width="250" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="数据源表单名称" field="associatedFormCaption" width="300">
					<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add"  text="增加" handler="addFormMapping"/>
					<next:ToolBarItem iconCls="edit"  text="修改" handler="updateFormMapping"/>
					<next:ToolBarItem iconCls="delete"  text="删除" handler="deleteFormMapping"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar dataset="formMappingDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
</html>