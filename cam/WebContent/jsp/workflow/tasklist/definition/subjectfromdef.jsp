<%@ page language="java" contentType="text/html;charset=utf-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>标题来源定义</title>
		<next:ScriptManager></next:ScriptManager>
	</head>

<BODY topmargin="10px">
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="确定" handler="doConfirm" />
		<next:ToolBarItem iconCls="undo" text="取消" handler="doCancel" />
		<next:ToolBarItem iconCls="delete" text="关闭" handler="doClose" />
	</next:TopBar>
	<next:Html>
		<form id="userForm" method="post" onsubmit="return false" class="L5form">
		<table width="100%" border="1">
			<tr>
				<td class="FieldLabel" width="40%">标题来源:</td>
				<td class="FieldInput" width="60%"><select name="subjectFromSelect"
										style="width: 100%">
										<option value="0">业务表</option>
										<option value="1">表单域</option>
									</select></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
<script language="javascript">
function doConfirm(){
	var result = new Array();
	var subjectFrom=document.getElementById("subjectFromSelect").value;
	result[0]=subjectFrom;
    parent.returnValue = result;
    parent.close();
}
 
function doCancel()
{
	parent.close();
    return false;
}
 
function doClose()
{
	parent.close();
    return false;
}
</script>
</html>