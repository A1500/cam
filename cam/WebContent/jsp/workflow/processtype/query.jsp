<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<HTML>
<HEAD>
<TITLE>流程类型</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY>
<model:datasets>
	<model:dataset pageSize="10" id="processTypeDataset"
		cmd="org.loushang.workflow.processtype.cmd.ProcessTypeQueryCmd"
		autoLoad="false" global="true">
		<model:record
			fromBean="org.loushang.workflow.processtype.data.ProcessType"></model:record>
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
								<td class="FieldLabel">流程类型名称：</td>
								<td class="FieldInput"><input type="text"
									id="processTypeName" class="TextEditor" style="width: 200px"
									title="流程类型名称" /></td>
								<td class="FieldButton" rowspan="2">
								<button onclick="query()">查询</button>
								</td>
							</tr>
						</table>
						</form>
						</div>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="userGridPanel" width="100%" height="100%"
					dataset="processTypeDataset"     title="流程类型详细信息">
					<next:Columns>
						<next:RowNumberColumn width="30" />
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column header="流程类型Id" field="typeId" width="200">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="流程类型名称" field="typeName" width="200">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="流程类型描述" field="description" width="250">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="显示顺序" field="displayOrder" id="displayOrder"
							width="100">
							<next:NumberField allowBlank="false" />
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
							displayInfo="true" dataset="processTypeDataset" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript"><!--
//初始化
function init(){
	processTypeDataset.load();
}
//查询
function query(){
  
  var processTypeName=document.getElementById("processTypeName").value;  
  if(processTypeName.indexOf("'")!=-1){
	  L5.Msg.alert("提示","查询条件不接受单引号输入!");
	  return;
   }else{
	  processTypeDataset.setParameter("TYPE_NAME@like",processTypeName);
  }
  processTypeDataset.load();
}

//新增
function forInsert(){
	processTypeDataset.newRecord();	
}
//保存
function forSave()
{
	var patrn=/^[0-9a-zA-Z_]{0,}$/;  
	var records = processTypeDataset.getAllChangedRecords();
	if (records.length < 1) {// 没有做任何修改,返回
		L5.Msg.alert("提示", "没有需要保存的数据!");
		return;
	}
	var isValidate= processTypeDataset.isValidate();
	if(isValidate!=true){
		var str=isValidate.replace("displayOrder","显示顺序").replace("(number)","数字").replace("typeName","流程类型名称");
		L5.Msg.alert("提示", "校验未通过,不能保存!" + str);
		return;		
		}
	var idStr = ";";
	for(var i=0;i<records.length;i++){
		if(records[i].get("typeName").indexOf("'")>=0){
			L5.Msg.alert("提示","流程类型名称不接受单引号输入!");
			return;
			}else if(!patrn.exec(records[i].get("typeId"))){
				L5.Msg.alert("提示","流程类型Id只接受字母、数字、下划线输入!");
				return;
			}else if(idStr.indexOf(";"+records[i].get("typeId")+";")!=-1){
				L5.Msg.alert("提示","流程类型Id不能重复!");
				return;
			}else{
				idStr = idStr+records[i].get("typeId")+";";	
			}
		}
	var command = new L5.Command(
			"org.loushang.workflow.processtype.cmd.ProcessTypeCmd");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		processTypeDataset.commitChanges();
		processTypeDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert("错误",command.error);
	}
}

//删除
function forDelete(){
	var userGridPanel = L5.getCmp('userGridPanel');
	// 判断是否选择了要删除的记录
	var selected = userGridPanel.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert("提示", "请选择要删除的记录！");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
		if(state=="yes"){   
			for(var i=0;i<selected.length;i++){	
				if(selected[i].state==1){
					processTypeDataset.remove(selected[i]);
					return;
					}
				if(selected[i].state==3){
					L5.Msg.alert("提示","请取消修改之后再删除!");
					return;
					}		
				var command=new L5.Command("org.loushang.workflow.processtype.cmd.ProcessTypeCmd"); 
				command.setParameter("typeId", selected[i].get("typeId"));
				command.execute("isDelete");
				if (!command.error) {
					var isDelete=command.getReturn("isDelete");
					if(isDelete=="true")
					{
						L5.Msg.alert("提示","删除成功!");
						processTypeDataset.load();						
					}
					else
					{
						var typeName=selected[i].get("typeName");
						L5.Msg.alert("提示", "已经定义了流程类型为["+typeName+"]的流程，请先删除流程!");
						return;
					}
				}else{
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
	processTypeDataset.rejectChanges();
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
--></script>
</html>