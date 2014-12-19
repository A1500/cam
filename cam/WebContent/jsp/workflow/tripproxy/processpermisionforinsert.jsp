<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>添加操作</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>
<model:datasets>
	<model:dataset pageSize="10" id="proxyOperationDefDs" method="query"
		cmd="org.loushang.workflow.tripproxy.cmd.TripProxyOperationDefQueryCmd"
		autoLoad="true" global="true">>
		<model:record excluding="xpdlContent,xmlContent"
			fromBean="org.loushang.workflow.tripproxy.data.TripProxyOperationDef"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" >
	<next:Html>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="1">
					<tr>
						<td class="FieldLabel" width="20%"><label>操作内码:</label></td> 
						<td class="FieldInput" >
							<input id="operationCodes" type="text" readonly="readonly" name="name"  title="操作内码" size="80"/>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" width="20%"><label >操作名称:</label></td> 
						<td class="FieldInput" ><input id="operationNames" type="text"  name="name"  title="操作名称:" size="80"/>
						<img src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>"  style="cursor:pointer " onclick="selectProxyOperation()" />
						</td>
					</tr>
				</table>
		
	</next:Html>
	<next:TopBar>
	<next:ToolBarItem/>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="forClose"/>
	</next:TopBar>
</next:Panel>
</body>
<script type="text/javascript">
function save(){
	var operationCodes=document.getElementById("operationCodes").value;
	var operationNames=document.getElementById("operationNames").value;
	if(operationCodes == ""){
		L5.Msg.alert("提示:", "请选择操作名称!");
		return false;
	}
	var command =new L5.Command("org.loushang.workflow.tripproxy.cmd.TripProxyOperationDefCmd");
	command.setParameter("operationCodes",operationCodes);
	command.setParameter("operationNames",operationNames);
	command.afterExecute = function() {
		if (!command.error) {
		   var url="jsp/workflow/tripproxy/processpermisiondef.jsp";
		   L5.forward(url,"查询操作");
		}else {
			L5.Msg.alert("错误:", command.error);
		}
}
	command.execute("insert");
	}

function forClose(){
	 var url="jsp/workflow/tripproxy/processpermisiondef.jsp";
	 L5.forward(url,"查询操作");
}

function selectProxyOperation(){
	var dialogMsg = "scroll:auto;status:no;dialogWidth:420px;dialogHeight:450px"; //弹出框设置信息
	var url = L5.webPath + "/jsp/public/help/help.jsp?helpCode=bsp_function_operation_help";
	var returnValues = showModalDialog(url,window,dialogMsg); //弹出框
	if(!returnValues){
		return;
	}
	
	document.getElementById("operationCodes").value=returnValues[0];
	document.getElementById("operationNames").value=returnValues[1];
}
</script>
</html>