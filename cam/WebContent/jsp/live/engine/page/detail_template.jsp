<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.loushang.live.engine.util.SenderUtil"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.live.engine.core.AbstractExtendMessageSender"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<%@include file="../common/message_init.jsp"%>
<%
	String box = request.getParameter("box");
	//页面信息
	String title = null;
	String jsonStr = null;
	Boolean isPersist = false;
	Boolean withContent = false;
	Boolean withAttach = false; 
	Boolean timerEnable = false;
	if(msgType != null){
		try{
			Map msMap = SenderUtil.getExtendSenders();
			AbstractExtendMessageSender ms = (AbstractExtendMessageSender)msMap.get(msgType);
			title = ms.getWebProperty("text").toString();
			isPersist = ms.isPersist();
			withContent = (Boolean)ms.getWebProperty("withContent");
			withAttach = (Boolean)ms.getWebProperty("withAttach");
			timerEnable = (Boolean)ms.getWebProperty("timerEnable");
			jsonStr = "{" + ms.getJsonStr() + "}";
		}catch(Exception e){
			out.append("获取扩展消息类型相关信息失败!");
		}
	}
%>

<title><%=title%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/live/L5-live.css"/>
<next:ScriptManager/>
<script type="text/javascript" src="detail_template.js"></script>
<script type="text/javascript" src="../mail/attachment.js"></script>
<script type="text/javascript">
var DeliveryMode = <%=jsonStr%>;
function init(){
	var msgId='<%=request.getParameter("msgId")%>';	
	mailDs.setParameter("msgId",msgId);
	mailDs.setParameter("method","detail");
	mailDs.load(true);
	<%if(withAttach){%>
	if(mailDs.getAt(0).get("hasAttach") == "true"){
		attachDs.setParameter("msgId" , msgId);
		attachDs.setParameter("boxType" , "");
		attachDs.setParameter("method" , "detail");
		attachDs.load(true);
	}else{
		document.getElementById("attachField").style.display = "none";
	}
	initAttTable("attachDs" , "downloadTable");
	<%}%>
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
<model:datasets>	
	<model:dataset id="mailDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getMail" pageSize="-1">
		<model:record fromBean="org.loushang.live.engine.view.MessageView"></model:record>
	</model:dataset>
	<model:dataset id="attachDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getAttach" pageSize="-1">
		<model:record fromBean="org.loushang.live.engine.core.AttachmentImpl"></model:record>
	</model:dataset>
</model:datasets>
<body>
<next:Panel border="false">
<%if(isPersist){
	if(!"trash".equals(box)){
%>
<next:TopBar>		
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<%if(!"send".equals(box)){%>
	<next:ToolBarItem  iconCls="msg_reply" text="回复" handler="reply"/>
	<%}%>
	<next:ToolBarItem iconCls="msg_forward"  text="转发" handler="forward"/>
</next:TopBar>
<%}}%>
<next:Html>
	<form id="msgForm" dataset="mailDs" onsubmit="return false" class="L5Form" >
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="70"><label>收件人</label></td>					
				<td class="FieldInput">
					<textarea name="partyName" field="partyName" id="partyName" style="width:90%; height:22px" readonly="readonly"></textarea>
				</td>
			</tr>
			<%if(withContent){%>
			<tr>	
				<td class="FieldLabel"><label>消息主题：</label></td> 
				<td class="FieldInput" >						
					<input type="text" name="title" id="title" field="title" style="width:90%;" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="vertical-align: middle;"><label>消息内容：</label></td> 
				<td class="FieldInput" >						
					<textarea name="content" id="content" field="content" style="width:90%;height:300px;" readonly="readonly"></textarea>
				</td>
			</tr>	
			<%}else{%>	
			<tr>
				<td class="FieldLabel" style="vertical-align: middle;"><label>消息内容：</label></td> 
				<td class="FieldInput" >						
					<textarea name="title" id="title" field="title" style="width:90%;height:300px;" readonly="readonly"></textarea>
				</td>
			</tr>
			<%}%>
		</table>
		<input type="hidden"  id="msgId" field="msgId" />
		<input type="hidden"  id="msgType" field="msgType" />
		<input type="hidden" field="partyInfo" id="partyInfo" />
	</form>
</next:Html>
</next:Panel>

<next:Panel>
<next:Html>
<%if(withAttach){%>
	<fieldset id="attachField">
		<legend>附件
			<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse('downloadTable' , this)">
		</legend>
		<table class="attachmentTable" id="downloadTable"></table>
	</fieldset>
<%}%>
</next:Html>
</next:Panel>
</body>
</html>