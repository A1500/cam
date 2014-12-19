<%@ page  contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<% String actionId=new String(request.getParameter("actionId")); %>
		<title>本地操作定义修改</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
	<body>
		<model:datasets>
		     <model:dataset id="actiondef" cmd="org.loushang.workflow.ecgapform.actiondef.cmd.ActionDefQueryCmd" autoLoad="true">
		          <model:record fromBean="org.loushang.workflow.ecgapform.actiondef.data.ActionDef"></model:record>
		     </model:dataset>
		</model:datasets>
		
		<next:Panel>
			<next:TopBar>
					<next:ToolBarItem symbol="修改本地操作"></next:ToolBarItem>
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
								<input type="text" name="actionId" field="actionId" id="actionId" title="操作ID" size="40" disabled="disabled"/>
								<font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">按钮名称: </td>
							<td class="FieldInput"> <input type="text" name="actionName" id="actionName" field="actionName" title="操作名称" size="40"/><font color="red">*</font></td>
						</tr>
						 <tr>
							<td class="FieldLabel">js函数</td>
							<td class="FieldInput"><input type="text" name="functionName" id="functionName" field="functionName" title="js函数" size="100"/><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">操作说明</td>
							<td class="FieldInput"> <input style="width: 60%" type="text" name="description" id="description" field="description" title="操作说明" size="100"/></td>
						</tr>
						 <tr>
							<td class="FieldLabel">显示顺序</td>
							<td class="FieldInput"> <input type="text" name="displayOrder" id="displayOrder" field="displayOrder" title="显示顺序" size="50"/><font color="red">*</font></td>
						</tr>
					</table>
				</form>
		   </next:Html>
		</next:Panel>	
	</body>
</html>
<script>
	function init(){       
	     var actiondef=L5.DatasetMgr.lookup("actiondef");
	     var actionId='<%=actionId%>';
	     actiondef.baseParams["ACTION_ID@="]=actionId;
	     actiondef.load();
	     L5.QuickTips.init();
	}
	function save(){
		var actionName=document.getElementById("actionName").value;
		var functionName=document.getElementById("functionName").value;
		var actionId=document.getElementById("actionId").value;
		if(actionName==""||actionName==undefined)
		{
			alert("按钮名称不能为空！");
			return;
		}
		if(functionName==""||functionName==undefined)
		{
			alert("函数名称不能为空！");
			return;
		}
		if(functionName.slice(functionName.length-2,functionName.length)!="()")
		{
			alert("函数名称必须以()结尾！");
			return;
		}
		functionName=functionName.slice(0,functionName.length-2);
		if(actionId==functionName)
		{
			alert("按钮ID和js函数名称不能相同！");
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
		command.execute("update");
	   if(!command.error){
		  alert("保存成功");
	      var url='jsp/workflow/ecgapform/actiondef/query.jsp?actionId='+"<%=actionId%>";
	      L5.forward(url,"本地操作修改");
	   }else{
	      alert(command.errror);
	   }  
	}
	function toquery(){
		L5.forward("jsp/workflow/ecgapform/actiondef/query.jsp","");
	}
</script>