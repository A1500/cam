<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.loushang.live.engine.util.SenderUtil"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.live.engine.core.AbstractExtendMessageSender"%>
<%@ page import="org.loushang.cms.core.component.document.api.*"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/cms-upload" prefix="upload"%>
<html>
<head>
<%@include file="../common/message_init.jsp"%>
<%
	//页面信息
	String title = null;
	String jsonStr = null;
	boolean isPersist = false;
	boolean withContent = false;
	boolean withAttach = false; 
	boolean timerEnable = false;
	
	//附件控件信息
	String totalUploadSize = null;
	String fileSizeLimit = null;
	String processId = null;
	String bizType = null;
	String encryption = null;
	String bizClass = null;
	String fileCount = null;
	String fileSelectCount = null;
	long fileStoredSize = 0;
	int fileStored = 0;
	if(msgType != null){
		try{
			Map msMap = SenderUtil.getExtendSenders();
			AbstractExtendMessageSender ms = (AbstractExtendMessageSender)msMap.get(msgType);
			title = ms.getWebProperty("text").toString();
			isPersist = ms.isPersist();
			withContent = ((Boolean)ms.getWebProperty("withContent")).booleanValue();
			withAttach = ((Boolean)ms.getWebProperty("withAttach")).booleanValue();
			timerEnable = ((Boolean)ms.getWebProperty("timerEnable")).booleanValue();
			jsonStr = "{" + ms.getJsonStr() + "}";
			
			//获取附件上传大小限制信息
			totalUploadSize = PropertyUtil.getInstance().get("totaluploadsize")==null ? "20971520" : PropertyUtil.getInstance().get("totaluploadsize");
			fileSizeLimit = PropertyUtil.getInstance().get("filesizelimit")==null ? "10485760" : PropertyUtil.getInstance().get("filesizelimit");
	
			bizType = "webmailattachment";
			if(bizType == null && msgId == null){
				out.write("缺少流程相关类型及ID");
				return;
			}
			
			if("reply".equals(method)){
				processId = newMsgId;
			}else{
				processId = msgId;
			}
			encryption = request.getParameter("encryption");
			bizClass = request.getParameter("bizclass");
			fileCount = request.getParameter("filecount");
			fileSelectCount = request.getParameter("fileselectcount");
			Document doc = null;
			try{
				doc = DocFactory.getDocumentByProcessObjID(processId , bizType);
			}catch(Exception e){
				out.write(e.getMessage());
				return;
			}
			List files = null;
			if(doc == null){
				files = new ArrayList();
			}else{
				files = doc.getFileElementByBizClass(bizClass);
			}
			fileStored = files.size();
			for(int i=0;i<files.size();i++){
				fileStoredSize += ((FileElement)files.get(i)).getSize();
			}
		}catch(Exception e){
			out.append("获取扩展消息类型相关信息失败!");
		}
	}else{
		out.append("参数信息不足!");
	}
	
%>

<title><%=title%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/live/L5-live.css"/>
<next:ScriptManager/>
<script type="text/javascript" src="edit_template.js"></script>
<script type="text/javascript" src="validator.js"></script>
<script type="text/javascript">
var DeliveryMode = <%=jsonStr%>;
var closeMark = false;
//在init中需要处理不同的方法
function init(){
	var method = "<%=method%>";	
	if(method == "new"){
		msgDs.newRecord();
	}else if(method=="reply" || method=="detail"){
		handleDetail();
	}else if(method=="forward"){
		handleForward();
	}
	<%if(withAttach){%>
	attachTableInit("attachTable" , "uploadGridDS");
	<%}%>
	var reload = "<%=openerReload%>";
	if(isIE()){
		window.onunload = function(){handleUnload()};
	}else{
		window.onbeforeunload = function(){handleUnload()};
	}
}
function handleDetail(){
	var msgId = "<%=msgId%>";	
	var msgType = "<%=msgType%>";
	var method = "<%=method%>";
	msgDs.setParameter("msgId" , msgId);
	msgDs.setParameter("msgType" , msgType);
	if(method=="detail"){
		msgDs.setParameter("boxType","temp");
	}
	msgDs.setParameter("method" , method);	
	msgDs.load(true);
	<%if(withAttach){%>
	uploadGridDS.setParameter("msgId" , msgId);
	if(method=="detail"){
		uploadGridDS.setParameter("boxType" , "temp");
	}
	uploadGridDS.setParameter("method" , method);
	uploadGridDS.load(true);
	if(method == "reply"){
		setParam("msgId" , "<%=newMsgId%>");
	}
	<%}%>
}
function handleForward(){
	var msgId = '<%=msgId%>';
	var msgType = "<%=msgType%>";
	msgDs.setParameter("msgId" , msgId);
	msgDs.setParameter("msgType" , msgType);
	msgDs.setParameter("boxType" , "temp");
	msgDs.setParameter("method" , "detail");	
	msgDs.load(true);
	<%if(withAttach){%>
	uploadGridDS.setParameter("msgId" , msgId);
	uploadGridDS.setParameter("boxType" , "temp");
	uploadGridDS.setParameter("method" , "detail");
	uploadGridDS.load(true);	
	<%}%>
}
function handleUnload(){
	var method = "<%=method%>";
	//确认是否保存信息
	<%if((withAttach || withContent) && isPersist){%>
	if(!closeMark){
		var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
		if(method == "forward" || method == "new"){
			//删除不使用的草稿
			command.setParameter("msgId" , "<%=msgId%>");
			command.execute("deleteMail");
			if (command.error) {
				alert(command.error);
			}
		}else if(method == "detail"){
			//当前默认保存
			setCmdParam(command);		
			command.execute("updateMessage");
			if(command.error){
				alert(command.error);
			}
		}else if(method == "reply"){
			//当前默认保存
			setCmdParam(command);		
			command.execute("saveMessage");
			if(command.error){
				alert(command.error);
			}
		}
	}
	<%}%>
	var reload = "<%=openerReload%>";
	if(reload == "true"){
		try{
			window.opener.location.reload();
		}catch(e){
		}
	}
}
</script>

</head>
<model:datasets>
	<model:dataset id="msgDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getMail" >
		<model:record fromBean="org.loushang.live.engine.view.MessageView"></model:record>
	</model:dataset>
	<model:dataset id="uploadGridDS" global="true" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getAttach" pageSize="-1">		
		<model:record>
			<model:field name="attID"  type="string" ></model:field>
			<model:field name="fileID"  type="string" ></model:field>
			<model:field name="fileName"  type="string" ></model:field>
			<model:field name="fileType"  type="string"></model:field>
			<model:field name="fileSize"  type="string" ></model:field>
		</model:record>
	</model:dataset> 
</model:datasets>
<body>
<next:Panel border="0"> 
	<!-- 生成按钮 -->
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>		
		<next:ToolBarItem text="发送" iconCls="msg_send" handler="sendMessage"></next:ToolBarItem>
		<%if(isPersist){ %>
		<next:ToolBarItem text="保存" iconCls="save" handler="saveMessage"></next:ToolBarItem>
		<%}%>
	</next:TopBar>	
	<next:Html>
		<form id="msgForm" dataset="msgDs" class="L5Form" action="<%=request.getContextPath()%>/MessageSender" method="post">
			<table width="100%">											
				<tr>
					<td class="FieldLabel" width="10%"><button onclick="queryParty();">收件人</button></td>
					<td class="FieldInput"><textarea name="partyName" field="partyName" id="partyName" style="width:90%; height:22px"></textarea></td>
				</tr>
				<%if(!withContent){%>
					<%if(timerEnable){%>
					<tr>
						<td class="FieldLabel" width="10%"><label>发送时间：</label></td>
						<td class="FieldInput"><input type="text" id="sendTime" field="sendTime" format="Ymd H:i:s" name="sendTime" onclick="LoushangDatetime(this)"/>
						<font color="red">（发送时间留空默认是立即发送，填充后就按发送时间发送）</font>
						</td>
					</tr>
					<%}%>
				<tr>	
				<td class="FieldLabel"><label>消息内容：</label></td> 
				<td class="FieldInput" ><textarea name="title" id="title" field="title" style="width:90%;height:300px;"></textarea>
				</td>
				</tr>
				<%}else{%>
				<tr>
				<td class="FieldLabel" width="10%"><label>消息主题：</label></td> 
				<td class="FieldInput"><input type="text" name="title" id="title" field="title" style="width:90%;"/></td>	
				</tr>
					<%if(timerEnable){%>
					<tr>
						<td class="FieldLabel" width="10%"><label>发送时间：</label></td>
						<td class="FieldInput"><input type="text" id="sendTime" field="sendTime" format="Ymd H:i:s" name="sendTime" onclick="LoushangDatetime(this)"/>
						<font color="red">（发送时间留空默认是立即发送，填充后就按发送时间发送）</font>
						</td>
					</tr>
					<%}%>
				<tr>	
				<td class="FieldLabel"><label>消息内容：</label></td> 
				<td class="FieldInput" ><textarea name="content" id="content" field="content" style="width:90%;height:300px;"></textarea>
				</td>
				</tr>
				<%}%>
				</table>
				<!-- 用于提交表单使用 -->
				<input type="hidden" name="msgId" 		id="msgId" 		value="<%=msgId%>"/>
				<input type="hidden" name="msgType"		id="msgType"	value="<%=msgType%>"/>
				<input type="hidden" name="method" 		id="method"		value="<%=method%>"/>
				<input type="hidden" field="partyInfo"  id="partyInfo"  name="partyInfo"/>
				<input type="hidden" name="isvalidate"  id="isvalidate"/>
		</form>
	</next:Html>
</next:Panel>
<%if(withAttach){%>
<next:Panel>
<next:Html>
<!-- 显示附件信息 -->
<table class="attachmentTable" id="attachTable">
</table>
</next:Html>
</next:Panel>
<script type="text/javascript" src="../mail/uploaddefault.js"></script>
<script type="text/javascript" src="../mail/attachment.js"></script>
<input type="hidden" id = "attachment-filestoredsize" value="<%=fileStoredSize%>" />
<input type="hidden" id = "attachment-biz" value="<%= bizType %>" />
<input type="hidden" id = "attachment-processid" value="<%= processId%>" />
<input type="hidden" id = "attachment-encryption" value="<%= encryption%>" />
<input type="hidden" id = "attachment-bizclass" value="<%= bizClass%>" />
<input type="hidden" id = "attachment-filecount" value="<%= fileCount%>" />
<input type="hidden" id = "attachment-filestored" value="<%= fileStored%>" />
<input type="hidden" id = "attachment-fileselectcount" value="<%=fileSelectCount%>" />
<upload:File name="fj" 
	totalUploadSize="<%=totalUploadSize%>" uploadURL="UploadServlet" 
	fileSizeLimit="<%=fileSizeLimit%>" buttonHeight="22" buttonWidth="120" backColor="#FFFFFF" fontSize="12" width="120" buttonName="添加附件" uploadMode="im"/>
<div class="progressFieldset progressFlash" id="fsUploadProgress" style="position:absolute;right:0;bottom:0;height:0px;width:370px;border:1px solid; display: none; background: white">
	<span class="progressLegend">上传进度</span>
</div>	
<%}%>
</body>
</html>