<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<style>
a {
	TEXT-DECORATION: none
}
</style>
<title>JSP表单定义</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>
	<model:datasets>
		<model:dataset id="jspFormFieldInfoDataset" cmd="org.loushang.workflow.jspform.formdef.field.cmd.FieldQueryCmd" global="true" pageSize="10">
			<model:record fromBean="org.loushang.workflow.jspform.formdef.field.data.JspFormFieldDef">
			</model:record>
		</model:dataset>
		<model:dataset id="jspFormActionInfoDataset" cmd="org.loushang.workflow.jspform.formdef.action.cmd.ActionQueryCmd" global="true" pageSize="10">
			<model:record fromBean="org.loushang.workflow.jspform.formdef.action.data.JspFormActionDef">
			</model:record>
		</model:dataset>
		<model:dataset id="jspFormUrlInfoDataset" cmd="org.loushang.workflow.jspform.formdef.requesturl.cmd.RequestUrlQueryCmd" global="true" pageSize="10">
			<model:record fromBean="org.loushang.workflow.jspform.formdef.requesturl.data.JspFormRequestUrlDef">
			</model:record>
		</model:dataset>
		<model:dataset id="jspFormBasicInfoDataset" cmd="org.loushang.workflow.jspform.formdef.cmd.JspFormQueryCmd" global="true" pageSize="-1">
			<model:record fromBean="org.loushang.workflow.jspform.formdef.data.JspFormDef">
			</model:record>
		</model:dataset>
		<model:dataset id="appCodeDataset" cmd="org.loushang.workflow.util.bsp.AppCodesQueryCommand" global="true" pageSize="-1" autoLoad="true">
			<model:record>
				<model:field name="value" mapping="appCode" type="string"/>
				<model:field name="text" mapping="appName" type="string"/>
			</model:record>
		</model:dataset>
		<model:dataset enumName="JSP_FORM_DATA_FIELD_TYPE" id="fieldTypeDataSet" autoLoad="true">
		</model:dataset>
	</model:datasets>
<next:ViewPort>
			<next:TabPanel name="tabpanel-div" height="100%" width="100%" activeTab="0" id="jspFormTab">
				
				<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" id="saveBtn"  text='保存全部' handler="saveAllInfo"/>
				<next:ToolBarItem iconCls="undo" id="undoBtn" text='取消全部' handler="cancleAllInfo"/>
				<next:ToolBarItem iconCls="undo" id="backBtn" text='返回' handler="backToQuery"/>
			</next:TopBar>
				<next:Tabs>
					<next:Panel title="基本信息" id="jspFormBasicInfoPanel" height="100%" width="100%">
						<next:TopBar>
								<next:ToolBarItem iconCls="save"  text="保存" handler="saveJspForm"/>
								<next:ToolBarItem iconCls="undo"  text="返回" handler="backToQuery"/>
						</next:TopBar>
						<next:Html>
							<form id="userForm" method="post" dataset="jspFormBasicInfoDataset" onsubmit="return false" class="L5form">
							<table width="100%" border="1">
								<tr>
									<td class="FieldLabel" width="20%">表单ID:</td>					
									<td class="FieldInput" width="80%"> 
										<input type="text" name="formId" id="formId" field="formId" title="表单ID" size="150" style="width: 200"/><font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">表单名称: </td>
									<td class="FieldInput"> 
										<input type="text" name="formName" id="formName" field="formName" title="表单名称" size="300" style="width:400"/><font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%">所属应用:</td>					
									<td class="FieldInput" width="80%"> 
										<select name="appPath" id="appPath" field="appPath" >
											<option dataset="appCodeDataset"></option>
										</select>
									</td>
								</tr>
								 <tr>
									<td class="FieldLabel">表单描述</td>
									<td class="FieldInput"> 
										<textarea name="formDescription" id="formDescription" field="formDescription" title="表单描述" cols="80" rows="6" ></textarea>
									</td>
								</tr>
							</table>
							</form>
					   </next:Html>
					</next:Panel>	
					
							<next:EditGridPanel id="jspFormFieldInfo"
								name="jspFormFieldInfo"
								height="100%"
								dataset="jspFormFieldInfoDataset" frame="true"
								title="Jsp表单域信息" width="100%">
								<next:Columns>
									<next:RowNumberColumn width="30" />
									<next:CheckBoxColumn></next:CheckBoxColumn>
									<next:Column id="id" header="内码" field="id" hidden="true">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="表单Id" field="formId"
										hidden="true">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="域ID" field="fieldId" width="150">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="域名称" field="fieldName"
										width="250">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="域类型" field="fieldType" width="150">
										<next:ComboBox  dataset="fieldTypeDataSet"  >
										</next:ComboBox>
									</next:Column>
									<next:Column header="域描述" field="fieldDiscription" width="100%">
										<next:TextField allowBlank="true" />
									</next:Column>
								</next:Columns>
								<next:TopBar>
									<next:ToolBarItem text="增加" iconCls="add"  handler="addJspFormField"></next:ToolBarItem>
									<next:ToolBarItem text="删除" iconCls="delete"  handler="deleteJspFormField"></next:ToolBarItem>
									<next:ToolBarItem iconCls="undo"  text="取消" handler="cancleJspFormFieldEdit"/>
									<next:ToolBarItem iconCls="save"  text="保存" handler="saveJspFormField"/>
								</next:TopBar>
								<next:BottomBar>
									<next:PagingToolBar dataset="jspFormFieldInfoDataset"/>
								</next:BottomBar>
							</next:EditGridPanel>
				

							<next:EditGridPanel id="jspFormActionInfo"
								name="jspFormActionInfo" 
								height="100%" dataset="jspFormActionInfoDataset"
								frame="true" title="JSP表单操作信息" width="100%">
								<next:Columns>
									<next:RowNumberColumn width="30" />
									<next:CheckBoxColumn></next:CheckBoxColumn>
									<next:Column id="id" header="内码" field="id" 
										hidden="true">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="表单Id" field="formId" 
										hidden="true">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="操作ID" field="actionId" width="200">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="操作名称" field="actionName"
										width="250">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="操作函数" field="actionFunction" width="200">
										<next:TextField allowBlank="true" />
									</next:Column>
									<next:Column header="操作描述" field="actionDescription" width="100%">
										<next:TextField allowBlank="true" />
									</next:Column>
								</next:Columns>
								<next:TopBar>
									<next:ToolBarItem text="增加" iconCls="add"  handler="addJspFormAction"></next:ToolBarItem>
									<next:ToolBarItem text="删除" iconCls="delete"  handler="deleteJspFormAction"></next:ToolBarItem>
									<next:ToolBarItem iconCls="undo"  text="取消" handler="cancleJspFormActionEdit"/>
									<next:ToolBarItem iconCls="save"  text="保存" handler="saveJspFormAction"/>
								</next:TopBar>
								<next:BottomBar>
									<next:PagingToolBar dataset="jspFormActionInfoDataset"/>
								</next:BottomBar>
							</next:EditGridPanel>
				
							<next:EditGridPanel id="jspFormUrlInfo"
								name="jspFormUrlInfo" 
								height="100%" dataset="jspFormUrlInfoDataset"
								frame="true" title="JSP表单URL" width="100%">
								<next:Columns>
									<next:RowNumberColumn width="30" />
									<next:CheckBoxColumn></next:CheckBoxColumn>
									<next:Column id="id" header="内码" field="id" 
										hidden="true">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="表单Id" field="formId" 
										hidden="true">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="UrlID" field="urlId" width="150">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="Url名称" field="urlName"
										width="250">
										<next:TextField allowBlank="false" />
									</next:Column>
									<next:Column header="Url值" field="urlValue" width="300">
										<next:TextField allowBlank="true" />
									</next:Column>
								</next:Columns>
								<next:TopBar>
									<next:ToolBarItem text="增加" iconCls="add"  handler="addJspFormUrl"></next:ToolBarItem>
									<next:ToolBarItem text="删除" iconCls="delete"  handler="deleteJspFormUrl"></next:ToolBarItem>
									<next:ToolBarItem iconCls="undo"  text="取消" handler="cancleJspFormUrlEdit"/>
									<next:ToolBarItem iconCls="save"  text="保存" handler="saveJspFormUrl"/>
								</next:TopBar>
								<next:BottomBar>
									<next:PagingToolBar dataset="jspFormUrlInfoDataset"/>
								</next:BottomBar>
							</next:EditGridPanel>

			
				</next:Tabs>
			</next:TabPanel>
</next:ViewPort>

</body>
<script language="javascript" type="text/javascript">
    var newFormId;
	var formId="<%=request.getParameter("formId")%>";    
	function init()
	{
		if(formId==""||formId=="null")
		{
			jspFormBasicInfoDataset.newRecord();
		}
		else
		{
			document.getElementById("formId").disabled=true;
			jspFormBasicInfoDataset.setParameter("FORM_ID@=",formId);
			jspFormBasicInfoDataset.load();
			jspFormFieldInfoDataset.setParameter("FORM_ID@=",formId);
			jspFormFieldInfoDataset.load();
			jspFormActionInfoDataset.setParameter("FORM_ID@=",formId);
			jspFormActionInfoDataset.load();
			jspFormUrlInfoDataset.setParameter("FORM_ID@=",formId);
			jspFormUrlInfoDataset.load();
		}
	}
	function saveJspForm()
	{
		var isValidate = jspFormBasicInfoDataset.isValidate();
		if (isValidate != true) {
			L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
			return;
		}
		
		var records = jspFormBasicInfoDataset.getAllChangedRecords();
		if (records.length < 1) {// 没有做任何修改,返回
			L5.Msg.alert("提示", "没有需要保存的数据!");
			return;
		}
		var command = new L5.Command("org.loushang.workflow.jspform.formdef.cmd.JspFormCmd");
		command.setParameter("record", records[0]);
		if(formId==""||formId=="null")
		{
			command.execute("insert");
		}
		else
		{
			command.execute("update");
		}
		if (!command.error) {			
			jspFormBasicInfoDataset.commitChanges();
			if(formId==""||formId=="null")
			{
				newFormId=command.getReturn("formId");
				document.getElementById("formId").disabled=true;
			}
			L5.Msg.alert("提示","数据保存成功!");
		} else {
			L5.Msg.alert("提示",command.error);
			return;
		}
	}
	function backToQuery()
	{
		var url="jsp/workflow/jspform/form_query.jsp";
		L5.forward(url,"Jsp表单查询");
	}
	function formInfoIsValid()
	{
		newFormId=document.getElementById("formId").value;
		if(newFormId==""||newFormId=="null")
		{
			L5.Msg.alert("提示","请先输入表单信息!");
			return false;
		}
		return true;
	}
	function addJspFormField()
	{
		if(!formInfoIsValid())return;
		jspFormFieldInfoDataset.newRecord(
				{	"id":"",
					"formId":newFormId,
					"fieldId":"",
					"fieldName":"",
					"fieldType":"",
					"fieldDescription":""
				}
		);
	}
	function deleteJspFormField()
	{
		var jspFormFieldInfoPanel = L5.getCmp('jspFormFieldInfo');
		// 判断是否选择了要删除的记录
		var selected = jspFormFieldInfoPanel.getSelectionModel().getSelections();
		if (selected.length < 1) {
			L5.Msg.alert("提示", "请选择要删除的记录！");
			return false;
		}
		L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
			if(state=="yes"){   
				for(var i=0;i<selected.length;i++){
					jspFormFieldInfoDataset.remove(selected[i]);
				}
			}else{
				return false;
			}
		});
	}
	function cancleJspFormFieldEdit()
	{
		jspFormFieldInfoDataset.rejectChanges();
	}
	function saveJspFormField()
	{
		var isValidate = jspFormFieldInfoDataset.isValidate();
		if (isValidate != true) {
			L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
			return;
		}
		
		var records = jspFormFieldInfoDataset.getAllChangedRecords();
		if (records.length < 1) {// 没有做任何修改,返回
			L5.Msg.alert("提示", "没有需要保存的数据!");
			return;
		}

		var command = new L5.Command("org.loushang.workflow.jspform.formdef.field.cmd.FieldCmd");
		command.setParameter("records", records);
		command.execute("save");
		if (!command.error) {
			jspFormFieldInfoDataset.commitChanges();
			if(formId==""||formId=="null"){
			    jspFormFieldInfoDataset.setParameter("FORM_ID@=",newFormId);
			}else{
				jspFormFieldInfoDataset.setParameter("FORM_ID@=",formId);
				}
			jspFormFieldInfoDataset.load();
			L5.Msg.alert("提示", "数据保存成功!");
		} else {
			L5.Msg.alert("提示",command.error);
		}
	}
	function addJspFormAction()
	{
		if(!formInfoIsValid())return;
		jspFormActionInfoDataset.newRecord(
				{	"id":"",
					"formId":newFormId,
					"actionId":"",
					"actionName":"",
					"actionFunction":"",
					"actionDescription":""
				}
		);
	}
	function deleteJspFormAction()
	{
		var jspFormActionInfoPanel = L5.getCmp('jspFormActionInfo');
		// 判断是否选择了要删除的记录
		var selected = jspFormActionInfoPanel.getSelectionModel().getSelections();
		if (selected.length < 1) {
			L5.Msg.alert("提示", "请选择要删除的记录！");
			return false;
		}
		L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
			if(state=="yes"){   
				for(var i=0;i<selected.length;i++){
					jspFormActionInfoDataset.remove(selected[i]);
				}
			}else{
				return false;
			}
		});
	}
	function cancleJspFormActionEdit()
	{
		jspFormActionInfoDataset.rejectChanges();
	}
	function saveJspFormAction()
	{
		var isValidate = jspFormActionInfoDataset.isValidate();
		if (isValidate != true) {
			L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
			return;
		}
		
		var records = jspFormActionInfoDataset.getAllChangedRecords();
		if (records.length < 1) {// 没有做任何修改,返回
			L5.Msg.alert("提示", "没有需要保存的数据!");
			return;
		}

		var command = new L5.Command("org.loushang.workflow.jspform.formdef.action.cmd.ActionCmd");
		command.setParameter("records", records);
		command.execute("save");
		if (!command.error) {
			jspFormActionInfoDataset.commitChanges();
			if(formId==""||formId=="null"){
				jspFormActionInfoDataset.setParameter("FORM_ID@=",newFormId);
			}else{
				jspFormActionInfoDataset.setParameter("FORM_ID@=",formId);
				}
			jspFormActionInfoDataset.load();
			L5.Msg.alert("提示", "数据保存成功!");
		} else {
			L5.Msg.alert("提示",command.error);
		}
	}
	function addJspFormUrl()
	{
		if(!formInfoIsValid())return;
		jspFormUrlInfoDataset.newRecord(
				{	"id":"",
					"formId":newFormId,
					"urlId":"",
					"urlName":"",
					"urlValue":""
				}
		);
	}
	function deleteJspFormUrl()
	{
		var jspFormUrlInfoPanel = L5.getCmp('jspFormUrlInfo');
		// 判断是否选择了要删除的记录
		var selected = jspFormUrlInfoPanel.getSelectionModel().getSelections();
		if (selected.length < 1) {
			L5.Msg.alert("提示", "请选择要删除的记录！");
			return false;
		}
		L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
			if(state=="yes"){   
				for(var i=0;i<selected.length;i++){
					jspFormUrlInfoDataset.remove(selected[i]);
				}
			}else{
				return false;
			}
		});
	}
	function cancleJspFormUrlEdit()
	{
		jspFormUrlInfoDataset.rejectChanges();
	}
	function saveJspFormUrl()
	{
		var isValidate = jspFormUrlInfoDataset.isValidate();
		if (isValidate != true) {
			L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
			return;
		}
		
		var records = jspFormUrlInfoDataset.getAllChangedRecords();
		if (records.length < 1) {// 没有做任何修改,返回
			L5.Msg.alert("提示", "没有需要保存的数据!");
			return;
		}

		var command = new L5.Command("org.loushang.workflow.jspform.formdef.requesturl.cmd.RequestUrlCommand");
		command.setParameter("records", records);
		command.execute("save");
		if (!command.error) {
			jspFormUrlInfoDataset.commitChanges();
			if(formId==""||formId=="null"){
				jspFormUrlInfoDataset.setParameter("FORM_ID@=",newFormId);
			}else{
				jspFormUrlInfoDataset.setParameter("FORM_ID@=",formId);
				}
			jspFormUrlInfoDataset.load();
			L5.Msg.alert("提示", "数据保存成功!");
		} else {
			L5.Msg.alert("提示",command.error);
		}
	}
	function saveAllInfo()
	{
		var isValidate = jspFormBasicInfoDataset.isValidate();
		if (isValidate != true) {
			L5.Msg.alert("提示", "表单基本信息校验未通过,不能保存!" + isValidate);
			return;
		}

		var fieldIsValidate = jspFormFieldInfoDataset.isValidate();
		if (fieldIsValidate != true) {
			L5.Msg.alert("提示", "表单域信息校验未通过,不能保存!" + fieldIsValidate);
			return;
		}

		var actionIsValidate = jspFormActionInfoDataset.isValidate();
		if (actionIsValidate != true) {
			L5.Msg.alert("提示", "表单操作信息校验未通过,不能保存!" + actionIsValidate);
			return;
		}
		var urlIsValidate = jspFormUrlInfoDataset.isValidate();
		if (urlIsValidate != true) {
			L5.Msg.alert("提示", "表单URL信息校验未通过,不能保存!" + urlIsValidate);
			return;
		}
		
		var baseRecords = jspFormBasicInfoDataset.getAllChangedRecords();
		var fieldRecords = jspFormFieldInfoDataset.getAllChangedRecords();
		var actionRecords = jspFormActionInfoDataset.getAllChangedRecords();
		var urlRecords = jspFormUrlInfoDataset.getAllChangedRecords();

		if(baseRecords.length<1&&fieldRecords.length<1&&actionRecords.length<1&&urlRecords.length<1)
		{
			L5.Msg.alert("提示", "没有需要保存的数据!");
			return;
		}
		var command = new L5.Command("org.loushang.workflow.jspform.formdef.cmd.JspFormCmd");
		command.setParameter("baseRecord", baseRecords[0]);
		command.setParameter("fieldRecords", fieldRecords);
		command.setParameter("actionRecords", actionRecords);
		command.setParameter("urlRecords", urlRecords);
		command.execute("saveAll");
		if (!command.error) {
			jspFormBasicInfoDataset.commitChanges();
			if(formId==""||formId=="null")
			{
				formId=command.getReturn("formId");
				document.getElementById("formId").disabled=true;
			}
			jspFormFieldInfoDataset.commitChanges();
			if(formId==""||formId=="null"){
			    jspFormFieldInfoDataset.setParameter("FORM_ID@=",newFormId);
			}else{
				jspFormFieldInfoDataset.setParameter("FORM_ID@=",formId);
				}
			jspFormFieldInfoDataset.load();
			jspFormActionInfoDataset.commitChanges();
			if(formId==""||formId=="null"){
				jspFormActionInfoDataset.setParameter("FORM_ID@=",newFormId);
			}else{
				jspFormActionInfoDataset.setParameter("FORM_ID@=",formId);
				}
			jspFormActionInfoDataset.load();
			jspFormUrlInfoDataset.commitChanges();
			if(formId==""||formId=="null"){
				jspFormUrlInfoDataset.setParameter("FORM_ID@=",newFormId);
			}else{
				jspFormUrlInfoDataset.setParameter("FORM_ID@=",formId);
				}
			jspFormUrlInfoDataset.load();
			
			L5.Msg.alert("提示","数据保存成功!");
		} else {
			L5.Msg.alert("提示",command.error);
			return;
		}
	}

	function cancleAllInfo()
	{
		jspFormBasicInfoDataset.rejectChanges();
		jspFormFieldInfoDataset.rejectChanges();
		jspFormActionInfoDataset.rejectChanges();
		jspFormUrlInfoDataset.rejectChanges();
	}
</script>
</html>