<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>流程定义层次下拉框定义</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<%
  String procTypeId=request.getParameter("procTypeId");
  String subjectQueryDefUniqueId=request.getParameter("subjectQueryDefUniqueId");
  if(procTypeId == null){
	  procTypeId = "";
  }
  if(subjectQueryDefUniqueId == null){
  	subjectQueryDefUniqueId = "";
  }
  
%>
<body>
<model:datasets>
	<model:dataset pageSize="15" id="procTypeSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd" autoLoad="false" global="true" method="queryProceTypeSubjectQuerySelectDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQuerySelectDef"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:AnchorLayout>
			<next:EditGridPanel id="procSubjectGridPanel" name="procSubjectGridPanel" anchor="100%" height="100%" dataset="procTypeSubjectDataset"     title="流程类型层次任务标题详细信息">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="10" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程类型id" id="procTypeId" field="procTypeId" width="150" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询条件定义唯一id" id="subjectQueryDefUniqueId" field="subjectQueryDefUniqueId" width="150" hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="下拉框名称" field="selectName" id="selectName" width="150"  hidden="true">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="下拉框选项值" field="optionValue" width="150">
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="下拉框选项名称" field="optionText" width="150">
						<next:TextField allowBlank="true"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="add"  text="新增" handler="forInsert"/>
					<next:ToolBarItem iconCls="delete"  text="删除" handler="forDelete"/>
					<next:ToolBarItem iconCls="undo"  text="取消" handler="forCancel"/>
					<next:ToolBarItem iconCls="save"  text="保存" handler="forSave"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcSubjectDefList"/>
				</next:TopBar>
			</next:EditGridPanel>
			</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
function init()
{
	procTypeSubjectDataset.setParameter("subjectQueryDefUniqueId","<%=subjectQueryDefUniqueId%>");
	procTypeSubjectDataset.load();
}

//添加流程定义标题
function forInsert()
{
	procTypeSubjectDataset.newRecord({"id":"","optionValue":"","optionText":""});
}

//保存流程定义标题
function forSave()
{
	var isValidate = procTypeSubjectDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = procTypeSubjectDataset.getAllChangedRecords();
	if (records.length < 1) {// 没有做任何修改,返回
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
	command.setParameter("records", records);
	command.setParameter("subjectQueryDefUniqueId", "<%=subjectQueryDefUniqueId%>");
	command.setParameter("procTypeId","<%=procTypeId%>");
	command.execute("saveProcTyepSubjectQuerySelectDef");
	if (!command.error) {
		procTypeSubjectDataset.commitChanges();
		procTypeSubjectDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

//删除流程定义标题
function forDelete()
{
	var procSubjectGridPanel = L5.getCmp('procSubjectGridPanel');
	// 判断是否选择了要删除的记录
	var selected = procSubjectGridPanel.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert("提示", "请选择要删除的记录！");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
		if(state=="yes"){   
			var deleteSelected = [];
			for(var i = 0; i < selected.length; i++) {
				if(selected[i].state == 1) {
					procTypeSubjectDataset.remove(selected[i]);
				} else {
					deleteSelected[i] = selected[i];
				}
			}
			if (deleteSelected.length < 1) {
				return;
			} else {
				var command=new L5.Command(
					"org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd"); 
				command.setParameter("selected", deleteSelected);
				command.execute("deleteProcTypeSubjectQuerySelectDef");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功!");
					procTypeSubjectDataset.reload();
				} else {
					alert(command.error);
				}
			}
		}else{
			return false;
		}
	});
}

//取消
function forCancel()
{
	procTypeSubjectDataset.rejectChanges();
}
//返回
function backToProcSubjectDefList()
{
	window.history.go(-1);
}
</script>
</html>