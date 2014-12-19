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
  String procDefUniqueId=request.getParameter("procDefUniqueId");
  String subjectQueryDefUniqueId=request.getParameter("subjectQueryDefUniqueId");
  System.out.println("procDefUniqueId="+procDefUniqueId+"||subjectQueryDefUniqueId="+subjectQueryDefUniqueId);
  if(procDefUniqueId == null){
  	procDefUniqueId = "";
  }
  if(subjectQueryDefUniqueId == null){
  	subjectQueryDefUniqueId = "";
  }
  
%>
<body>
<model:datasets>
	<model:dataset pageSize="15" id="procSubjectDataset" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" autoLoad="false" global="true" method="querySelectDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQuerySelectDef"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:AnchorLayout>
			<next:EditGridPanel id="procSubjectGridPanel" name="procSubjectGridPanel" anchor="100%" height="100%" dataset="procSubjectDataset"     title="流程定义层次任务标题详细信息">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="id" width="10" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程定义唯一Id" field="procDefUniqueId" hidden="true" >
						<next:TextField allowBlank="true"/>
					</next:Column>
					<next:Column header="查询字段定义唯一Id" field="subjectQueryDefUniqueId" hidden="true">
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
	 procSubjectDataset.setParameter("subjectQueryDefUniqueId","<%=subjectQueryDefUniqueId%>");
	 procSubjectDataset.load();
}

//添加流程定义标题
function forInsert()
{
	procSubjectDataset.newRecord({"id":"","procDefUniqueId":"<%=procDefUniqueId%>","subjectQueryDefUniqueId":"<%=subjectQueryDefUniqueId%>","selectName":"<%=subjectQueryDefUniqueId%>","optionValue":"","optionText":""});
}

//保存流程定义标题
function forSave()
{
	var isValidate = procSubjectDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = procSubjectDataset.getAllChangedRecords();
	if (records.length < 1) {// 没有做任何修改,返回
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveProcSubjectQuerySelectDef");
	if (!command.error) {
		procSubjectDataset.commitChanges();
		procSubjectDataset.reload();
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
					procSubjectDataset.remove(selected[i]);
				} else {
					deleteSelected[i] = selected[i];
				}
			}
			if (deleteSelected.length < 1) {
				return;
			} else {
				var command=new L5.Command(
					"org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefCmd"); 
				command.setParameter("selected", deleteSelected);
				command.execute("deleteProcSubjectQuerySelectDef");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功!");
					procSubjectDataset.reload();
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
	procSubjectDataset.rejectChanges();
}
//返回
function backToProcSubjectDefList()
{
	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectquerydefwithbiztable.jsp?procDefUniqueId="+"<%=procDefUniqueId%>";
	L5.forward(url,"流程定义查询条件定义");
}
</script>
</html>