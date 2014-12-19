<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<% 
	String box = request.getParameter("box");
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/live/L5-live.css"/>
<title>消息编辑</title>
<next:ScriptManager/>
<script type="text/javascript" src="msg_detail.js"></script>
<script type="text/javascript" src="../box/list_common.js"></script>
<script type="text/javascript" src="../common/common.js"></script>
<script type="text/javascript">
/**
 * 初始化，注册事件处理
 */
var msgId='<%=request.getParameter("msgId")%>';	
var msgType = '<%=request.getParameter("msgType")%>';
function init() {
	msgDs.setParameter("msgId",msgId);
	msgDs.setParameter("msgType",msgType);	
	msgDs.setParameter("method","detail");
	msgDs.load(true);		
	if(msgDs.getCount())
		document.getElementById("msgTitle").innerHTML = msgDs.getAt(0).get("title");
}
</script>
</head>
<body style="width:100%">
<input type="hidden" id="msgType" value="<%=request.getParameter("msgType")%>"/>
<model:datasets>
	<model:dataset id="msgDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getMail" pageSize="10">
		<model:record fromBean="org.loushang.live.engine.view.MessageView"></model:record>
	</model:dataset>		
</model:datasets>
<next:ViewPort>
<next:Panel>
<%if(!"trash".equals(box)){%>
	<next:TopBar>		
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%if(!"send".equals(box)){%>
		<next:ToolBarItem  iconCls="msg_reply" text="回复" handler="reply"/>
		<%}%>
		<next:ToolBarItem iconCls="msg_forward"  text="转发" handler="forward"/>		
	</next:TopBar>
<%}%>
	<next:Html>
		<form id="msgForm" dataset="msgDs" onsubmit="return false" class="L5Form" >
		<input type="hidden" field="partyInfo" id="partyInfo" />
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="70"><label>收件人</label></td>
					<td class="FieldInput"><textarea name="partyName" rows="1" cols="100" field="partyName" readonly="true"></textarea></td>
				</tr>
				<tr>	
					<td class="FieldLabel" style="vertical-align: middle;"><label>消息内容：</label></td> 
					<td class="FieldInput" >
						<div id="msgTitle" style="width:100%; height:150;"/>
					</td>
				</tr>				
			</table>
		</form>
	</next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>