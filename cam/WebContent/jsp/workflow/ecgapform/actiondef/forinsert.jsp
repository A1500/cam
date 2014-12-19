<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>本地操作定义增加</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
	<body>
		<model:datasets>
			<model:dataset id="actiondef" cmd="org.loushang.workflow.ecgapform.actiondef.cmd.ActionDefCmd">
				<model:record fromBean="org.loushang.workflow.ecgapform.actiondef.data.ActionDef"></model:record>
			</model:dataset>
		</model:datasets>
		
		<next:Panel>
			<next:TopBar>
					<next:ToolBarItem symbol="本地操作信息"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="toquery"/>
			</next:TopBar>
			<next:Html>
				<form id="userForm" method="post" dataset="actiondef" onsubmit="return false" class="L5form">
					<table width="100%" border="1">
						<tr>
							<td class="FieldLabel" width="20%">按钮ID:</td>					
							<td class="FieldInput" width="80%"> 
								<input type="text" name="actionId" id="actionId" field="actionId" title="操作ID" size="40"/>
								<font color="red">*注意：按钮ID不能和js函数名称相同</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">按钮名称: </td>
							<td class="FieldInput"> <input type="text" name="actionName" id="actionName" field="actionName" title="操作名称" size="40"/><font color="red">*</font></td>
						</tr>
						 <tr>
							<td class="FieldLabel">js函数</td>
							<td class="FieldInput"> <input type="text" name="functionName" id="functionName" field="functionName" title="js函数" size="100"/><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">操作说明</td>
							<td class="FieldInput"> <input style="width: 60%" type="text" name="description" id="description" field="description" title="操作说明" size="100"/></td>
						</tr>
						 <tr>
							<td class="FieldLabel">显示顺序</td>
							<td class="FieldInput"> <input type="text" value="1111" name="displayOrder" id="displayOrder" field="displayOrder" title="显示顺序" size="50"/><font color="red">*</font></td>
						</tr>
					</table>
				</form>
		   </next:Html>
		</next:Panel>	
	</body>
</html>
<script>
	function init(){
		var actiondef = L5.DatasetMgr.lookup("actiondef");
		actiondef.newRecord({displayOrder:9999});
		L5.QuickTips.init(); 
	}
	function save(){
		var actionName=document.getElementById("actionName").value;
		var functionName=document.getElementById("functionName").value;
		var actionId=document.getElementById("actionId").value;
		var displayOrder=document.getElementById("displayOrder").value;
		if(actionName==""||actionName==undefined)
		{
			L5.Msg.alert("提示","按钮名称不能为空！");
			return;
		}
		if(actionId==""||actionId==undefined)
		{
			L5.Msg.alert("提示","按钮ID不能为空！");
			return;
		}
		if(functionName==""||functionName==undefined)
		{
			L5.Msg.alert("提示","函数名称不能为空！");
			return;
		}
		if(functionName.slice(functionName.length-2,functionName.length)!="()")
		{
			L5.Msg.alert("提示","函数名称必须以()结尾！");
			return;
		}
		functionName=functionName.slice(0,functionName.length-2);
		if(actionId==functionName)
		{
			L5.Msg.alert("提示","按钮ID和js函数名称不能相同！");
			return;
		}
	    var actiondef=L5.DatasetMgr.lookup("actiondef");
	    var valid = actiondef.isValidate();
		if (valid != true) {
			L5.Msg.alert("错误",valid.replace("displayOrder","【显示顺序】").replace("number","必须为数字"));
			return false;
		}
	    var ecgapRecord=actiondef.getCurrent();
	    var command=new L5.Command("org.loushang.workflow.ecgapform.actiondef.cmd.ActionDefCmd");
	    command.setParameter("record",ecgapRecord);
	    command.execute("insert");
		if(!command.error){
			L5.Msg.alert("提示","保存成功");
			var url='jsp/workflow/ecgapform/actiondef/query.jsp';
			L5.forward(url,"本地操作增加");
		}else{
			L5.Msg.alert("错误",command.error);
		}
	}
	function toquery(){
		L5.forward("jsp/workflow/ecgapform/actiondef/query.jsp","");
	}
</script>