<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/live/L5-live.css"/>
<html>
<head>
<title>我的邮箱</title>
<next:ScriptManager />
<script type="text/javascript" src="mail_detail.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="attachment.js"></script>
<script type="text/javascript" src="../common/common.js"></script>
<script type="text/javascript">		
<%
	String box = request.getParameter("box");
%>
function init(){
	var msgId='<%=request.getParameter("msgId")%>';	
	mailDs.setParameter("msgId",msgId);
	mailDs.setParameter("method","detail");
	mailDs.load(true);
	window.frames["contentFrame"].document.write(mailDs.getAt(0).get("content"));
	if(mailDs.getAt(0).get("hasAttach") == "true"){
		attachDs.setParameter("msgId" , msgId);
		attachDs.setParameter("boxType" , "");
		attachDs.setParameter("method" , "detail");
		attachDs.load(true);
	}else{
		document.getElementById("attachField").style.display = "none";
	}
	initAttTable("attachDs" , "downloadTable");
}
function collapse(obj , element){
	if(document.getElementById(obj).style.display == "none"){
		document.getElementById(obj).style.display = "block";
		element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
	}else{
		document.getElementById(obj).style.display = "none";
		element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
	}
}
</script>
</head>
<body>

<model:datasets>	
	<model:dataset id="mailDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getMail" pageSize="-1">
		<model:record fromBean="org.loushang.live.engine.view.MessageView"></model:record>
	</model:dataset>
	<model:dataset id="attachDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getAttach" pageSize="-1">
		<model:record fromBean="org.loushang.live.engine.core.AttachmentImpl"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel id="insertRoot" border="false" >
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
		<form id="editForm" dataset="mailDs" onsubmit="return false" class="L5Form">
		<input type="hidden"  id="msgId" field="msgId" />
		<input type="hidden"  id="msgType" field="msgType" />
		<input type="hidden" field="partyInfo" id="partyInfo" />
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" width="70">&nbsp;收件人：&nbsp;</td>
				<td class="FieldInput"><textarea name="partyName" rows="1" cols="97" field="partyName" readonly="true"></textarea></td>
			</tr>
	   		<tr>
				<td class="FieldLabel">邮件主题：</td>
				<td class="FieldInput"><input type="text" id="title" name="title" field="title" readonly="true" style="width:561"/></td>
			</tr>
			<tr>				
				<td colspan="2"><iframe name="contentFrame" width="100%" height="280" /></td>
			</tr>			
			</table>
		</form>
   </next:Html>
   
</next:Panel>

<next:Panel border="0">
<next:Html>
	<fieldset id="attachField">
		<legend>附件
			<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse('downloadTable' , this)">
		</legend>
		<table class="attachmentTable" id="downloadTable"></table>
	</fieldset>
</next:Html>	
</next:Panel>



<input id="realurl" type="hidden" value = "<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()%>"/>
</body>
</html>