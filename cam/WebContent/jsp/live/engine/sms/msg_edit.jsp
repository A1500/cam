<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>消息编辑</title>
<next:ScriptManager/>
<%@include file="../common/message_init.jsp"%>
<script type="text/javascript" src="msg_edit.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript">
/**
 * 初始化，注册事件处理
 */
function init() {
	var method = "<%=method%>";
	var msgId = "<%=msgId%>";
	//html编辑器
	CKEDITOR.replace( 'htmlEditor',
	{
	    toolbar : 'MyToolbar'
	    
	});	
	if(method=="reply" || method=="forward" || method=="detail"){
		msgDs.setParameter("msgId",msgId);
		msgDs.setParameter("method",method);
		if(method=="detail"){
			msgDs.setParameter("boxType","temp");
		}
		msgDs.load(true);	
		if(msgDs.getCount()!=0 && method != "reply")
			CKEDITOR.instances.htmlEditor.setData((msgDs.getAt(0).get("title")));
		if(method == "reply" || method=="forward"){
			setParam("corrMsgId" ,msgId);
			setParam("bizType",method);
			setParam("msgId" , "<%=newMsgId%>");
		}
	}else{
		msgDs.newRecord();	
	}
	//根据reload参数判断是否需要刷新父窗口
	if("<%=openerReload%>" == "true"){
		window.onunload = function(){
			try{
				window.opener.location.reload();
			}catch(e){
			}
		}
	}
}
</script>
</head>
<body style="width:100%">
<model:datasets>
	<model:dataset id="msgDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getMail">
		<model:record fromBean="org.loushang.live.engine.view.MessageView"></model:record>
	</model:dataset>	
</model:datasets>

<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>		
		<next:ToolBarItem text="发送" iconCls="msg_send" handler="msgSend"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="msgSave"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="msgForm" dataset="msgDs" onsubmit="return false" class="L5Form">
			<table width="100%">				
				<tr>
					<td class="FieldButton" width="10%"><button onclick="queryParty()">收件人</button></td>
					<td class="FieldInput"><textarea name="partyName" field="partyName" id="partyName" style="width: 80%; height:22px""></textarea></td>
				</tr>
				<tr>	
					<td class="FieldInput" colspan="2"><textarea name="htmlEditor"></textarea></td>
				</tr>				
			</table>		
			<input type="hidden" id="partyInfo"	field="partyInfo"/>	
			<input type="hidden" id="msgId" 	value="<%=msgId%>"/>
			<input type="hidden" id="msgType" 	value="<%=msgType%>"/>
			<input type="hidden" id="method" 	value="<%=method%>"/>
			<input type="hidden" field="corrMsgId"  id="corrMsgId"  name="corrMsgId"/>
			<input type="hidden" field="bizType"  id="bizType"  name="bizType"/>
		</form>
	</next:Html>
</next:Panel>

</body>
</html>