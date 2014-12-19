<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>

<html>
<head>
<%
	String smslength = PropertyUtil.getInstance().get("smslength");
	int slength = 70;
	try{
		slength = Integer.valueOf(smslength).intValue();
	}catch(Exception e){
		slength = 70;
	}
%>
<title>短信编辑</title>
<next:ScriptManager/>
<%@include file="../common/message_init.jsp"%>
<script type="text/javascript" src="sms_edit.js"></script>
<script type="text/javascript">
var smslength = parseInt('<%=slength%>' , 10);
/**
 * 初始化，注册事件处理
 */
function init() {
	var method = "<%=method%>";
	var msgId = "<%=msgId%>";
	if(method=="detail"||method=="reply"||method=="forward"){
		msgDs.setParameter("msgId",msgId);
		msgDs.setParameter("method",method);
		msgDs.load(true);
		if(method == "reply" || method=="forward")
			setParam("msgId" , "<%=newMsgId%>")
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
	<model:dataset id="msgDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getTempSms" >
		<model:record fromBean="org.loushang.live.engine.view.MessageView"></model:record>
	</model:dataset>		
	<model:dataset id="msgState" enumName="ENGINE.MESSAGESTATE" autoLoad="true"/>
	<model:dataset id="smsPhrases" enumName="SMS.PHRASES" autoLoad="true">
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>		
		<next:ToolBarItem text="发送" iconCls="msg_send" handler="<%=sendHandle%>"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="msgSave"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="smsForm" dataset="msgDs" class="L5Form" action="<%=request.getContextPath()%>/MessageSender" method="post" onsubmit="return false">
			<input type="hidden" field="partyInfo" id="partyInfo" name="partyInfo"/>
			<table width="100%">				
				<tr>
					<td class="FieldButton" width="70"><button onclick="queryParty()">收件人</button></td>
					<td class="FieldInput"><textarea name="partyName" id="partyName" rows="1" cols="100" field="partyName"></textarea></td>
				</tr>
				<tr>	
					<td class="FieldLabel"><label>常用短语：</label></td> 
					<td class="FieldInput">
						<select id="phrases" onchange="phrasesChange();">
							<option dataset="smsPhrases"></option>
						</select>
					</td>
				</tr>	
				<tr>	
					<td class="FieldLabel"><label>短信内容：</label></td> 
					<td class="FieldInput" ><textarea name="title" id="title" rows="10" cols="100" field="title" onkeyup="oninput();"></textarea>
						<br>
						<span id="wordcount"></span>
						<span id="leftwords"></span>
						<br>
						<span id="smssize"></span>
					</td>
				</tr>	
				<tr>
					<td class="FieldLabel"><label>加入签名：</label></td>
					<td class="FieldInput">
						<input type="radio" name="issigned" id="sign"  size="10" onclick="signSelected();">是
						<input type="radio" name="issigned" id="nosign" size="10" checked="checked" onclick="signSelected();">否
						<span id="signature"/>
					</td>  
				</tr>
				<tr>
					<td class="FieldLabel"><label>发送时间：</label></td>
					<td class="FieldInput"><input type="text" id="sendTime" format="Ymd H:i:s" field="sendTime" onclick="LoushangDatetime(this)"/>
					<font color="red">（发送时间留空默认是立即发送，填充后就按发送时间发送）</font>
					</td>
				</tr>					
			</table>	
			<input type="hidden" name="msgId" id="msgId" value="<%=msgId%>"/>
			<input type="hidden" name="smsLength" id="smsLength"/>
			<input type="hidden" id="signText" value="——<%=GetBspInfo.getBspInfo().getUserName()%>"/>	
			<input type="hidden" id="method" name="method" value="<%=method%>"/>
			<input type="hidden" id="msgType" name="msgType" value="<%=msgType%>"/>
		</form>
	</next:Html>
</next:Panel>

</body>
</html> 
