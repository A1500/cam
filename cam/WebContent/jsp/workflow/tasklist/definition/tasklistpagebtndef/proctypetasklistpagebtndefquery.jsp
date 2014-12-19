<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<HTML>
<HEAD>
<TITLE>流程类型办结任务页面按钮配置</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY>
<model:datasets>
	<model:dataset pageSize="-1" id="processTypeDataset"
		cmd="org.loushang.workflow.processtype.cmd.ProcessTypeQueryCmd" autoLoad="true" global="true">
		<model:record fromBean="org.loushang.workflow.processtype.data.ProcessType"></model:record>
	</model:dataset>
	<model:dataset pageSize="13" id="procTypeButtonDefDataset"
		cmd="org.loushang.workflow.processdefinition.tasklist.tasklistpagebtndef.cmd.ProcTypeTaskListPageBtnDefQueryCmd"
		autoLoad="true" global="true">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.tasklistpagebtndef.data.ProcTypeTaskListPageBtnDef"></model:record>
	</model:dataset>
	
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
			<next:Panel>
				<next:Panel width="100%" border="0"
					bodyStyle="padding-bottom:10px;padding-top:0px;">
					<next:Html>
						<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件 <img
							class="GroupBoxExpandButton"
							src="<%=SkinUtils.getImage(request,
													"groupbox_collapse.gif")%>"
							onclick="collapse(this);" /> </legend>
						<div class="GroupBoxDiv" style="width: 60%; height: 100%;">
						<form onsubmit="return false;" class="L5form">
						<table border="1" width="100%">
							<tr>
								<td class="FieldLabel">按钮名称：</td>
								<td class="FieldInput"><input type="text" id="btnNameForQuery" class="TextEditor" style="width: 200px" title="流程类型名称" /></td>
								<td class="FieldButton" rowspan="2"><button onclick="query()">查询</button></td>
							</tr>
						</table>
						</form>
						</div>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="processTypeBtnGridPanel" width="100%" height="100%"
					dataset="procTypeButtonDefDataset" title="流程类型办结任务页面按钮配置信息">
					<next:Columns>
						<next:RowNumberColumn width="30" />
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column header="按钮ID" id="id" field="id" width="200" hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="流程类型" field="procTypeId" width="200">
						<next:TextField allowBlank="false" />
						<next:ComboBox dataset="processTypeDataset" displayField="typeName" valueField="typeId" triggerAction="all" typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column header="按钮函数" field="btnFunc" width="250" >
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="按钮名称" field="btnName" id="btnName" width="200" >
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="Js文件路径" field="jsFilePath" width="300" >
							<next:TextField allowBlank="false" />
						</next:Column>
					</next:Columns>
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="新增" handler="forInsert" />
						<next:ToolBarItem iconCls="delete" text="删除" handler="forDelete" />
						<next:ToolBarItem iconCls="undo" text="取消" handler="forCancel" />
						<next:ToolBarItem iconCls="save" text="保存" handler="forSave" />
					</next:TopBar>
					<next:BottomBar>
						<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
							displayInfo="true" dataset="procTypeButtonDefDataset" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript">

//查询
function query(){
  
  var buttonName=document.getElementById("btnNameForQuery").value;  
  if(buttonName.indexOf("'")!=-1){
	  L5.Msg.alert("提示", "不接受单引号输入!");
	  return;
   }else{
	   procTypeButtonDefDataset.setParameter("btnName",buttonName);
  }
  procTypeButtonDefDataset.load();
}

//新增
function forInsert(){
	procTypeButtonDefDataset.newRecord();	
}
//保存
function forSave()
{
	var records = procTypeButtonDefDataset.getAllChangedRecords();
	if (records.length < 1) {// 没有做任何修改,返回
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	var isValidate= procTypeButtonDefDataset.isValidate();
	if(isValidate!=true){
		//var str=isValidate.replace("displayOrder","显示顺序").replace("(number)","数字").replace("typeName","流程类型名称");
		L5.Msg.alert("提示", "校验未通过,不能保存!");
		return;		
		}
	for(var i=0;i<records.length;i++){
		if(records[i].get("btnName").indexOf("'")>=0){
			alert("按钮名称不能包含单引号!");
			return;
			}
		}
	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.tasklistpagebtndef.cmd.ProcTypeTaskListPageBtnDefCmd");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		procTypeButtonDefDataset.commitChanges();
		procTypeButtonDefDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

//删除
function forDelete(){
	
	var processTypeBtnGridPanel = L5.getCmp('processTypeBtnGridPanel');
	// 判断是否选择了要删除的记录
	var selected = processTypeBtnGridPanel.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert("提示", "请选择要删除的记录！");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
		if(state=="yes"){
			var deleteSelected = [];
			for(var i = 0; i < selected.length; i++) {
				if(selected[i].state == 1) {
					procTypeButtonDefDataset.remove(selected[i]);
				} else {
					deleteSelected[i] = selected[i];
				}
			}
			if (deleteSelected.length < 1) {
				return;
			} else {
				var command=new L5.Command("org.loushang.workflow.processdefinition.tasklist.tasklistpagebtndef.cmd.ProcTypeTaskListPageBtnDefCmd"); 
				command.setParameter("selected", deleteSelected);
				command.execute("delete");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功!");
					procTypeButtonDefDataset.load();
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
	procTypeButtonDefDataset.rejectChanges();
}
//查询条件面板打开合并函数
function collapse(element)
{
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){	
	fieldsetParent.getElementsByTagName("div")[0].style.display="none";
	element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
	element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>";
		element.expand =true;
	}
}
</script>
</html>