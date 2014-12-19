<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/cms-upload" prefix="upload"%>

<%@ page import="org.loushang.cms.core.component.document.api.*" %>
<%@ page import="java.util.*" %>
<%@include file="../common/message_init.jsp"%>
<%
	//获取附件上传大小限制信息
	String totalUploadSize = PropertyUtil.getInstance().get("totaluploadsize")==null ? "20971520" : PropertyUtil.getInstance().get("totaluploadsize");
	String fileSizeLimit = PropertyUtil.getInstance().get("filesizelimit")==null ? "10485760" : PropertyUtil.getInstance().get("filesizelimit");

	String bizType ="webmailattachment";
	if(bizType == null && msgId == null){
		out.write("缺少流程相关类型及ID");
		return;
	}
	String processId = "";
	if("reply".equals(method)){
		processId = newMsgId;
	}else{
		processId = msgId;
	}
	String encryption = request.getParameter("encryption");
	String bizClass = request.getParameter("bizclass");
	String fileCount = request.getParameter("filecount");
	String fileSelectCount = request.getParameter("fileselectcount");
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
	int  fileStored = files.size();
	long fileStoredSize = 0;
	for(int i=0;i<files.size();i++){
		fileStoredSize += ((FileElement)files.get(i)).getSize();
	}
	
%>

<html>

<head>
<title>邮件编辑</title>
<next:ScriptManager/>
<script type="text/javascript" src="mail_edit.js"></script>
<script type="text/javascript" src="uploaddefault.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="attachment.js"></script>
<script type="text/javascript">
/**
 * 初始化，注册事件处理
 */
function init() {
	var method = "<%=method%>";
	//html编辑器
	CKEDITOR.replace( 'htmlEditor',
	{
	    toolbar : 'MyToolbar'	    
	});
	if(method=="reply" || method=="detail"){
		handleDetail();
	}else if(method=="forward"){	
		handleForward();
	}else{
		msgDs.newRecord();
	}	
	attachTableInit("attachTable" , "uploadGridDS");	
	if(isIE()){
		window.onunload = function(){handleUnload()};
	}else{
		window.onbeforeunload = function(){handleUnload()};
	}
}
function handleUnload(){
	var method = "<%=method%>";
	command.reset();
	//确认是否保存信息
	if(!closeMark){
		if(method == "forward" || method == "new"){
			//删除不使用的草稿
			command.setParameter("msgId" , "<%=msgId%>");
			command.execute("deleteMail");
			if (command.error) {
				alert(command.error);
			}
		}else if(method == "detail"){
			//当前默认保存
			setCmdParam(false);		
			command.execute("updateMessage");
			if(command.error){
				alert(command.error);
			}
		}else if(method == "reply"){
			//当前默认保存
			setCmdParam(false);		
			command.execute("saveMessage");
			if(command.error){
				alert(command.error);
			}
		}
	}
	var reload = "<%=openerReload%>";
	if(reload == "true"){
		try{
			window.opener.location.reload();
		}catch(e){
		}
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
	
	CKEDITOR.instances.htmlEditor.setData(msgDs.getAt(0).get("content"));
	uploadGridDS.setParameter("msgId" , msgId);
	if(method=="detail"){
		uploadGridDS.setParameter("boxType" , "temp");
	}
	uploadGridDS.setParameter("method" , method);
	uploadGridDS.load(true);
	if(method == "reply"){
		setParam("corrMsgId",msgId);
		setParam("bizType",method);
		setParam("msgId" , "<%=newMsgId%>");
	}
}
function handleForward(){
	var msgId = '<%=msgId%>';
	var msgType = "<%=msgType%>";
	msgDs.setParameter("msgId" , msgId);
	msgDs.setParameter("msgType" , msgType);
	msgDs.setParameter("boxType" , "temp");
	msgDs.setParameter("method" , "detail");	
	msgDs.load(true);
	
	CKEDITOR.instances.htmlEditor.setData(msgDs.getAt(0).get("content"));
	uploadGridDS.setParameter("msgId" , msgId);
	uploadGridDS.setParameter("boxType" , "temp");
	uploadGridDS.setParameter("method" , "detail");
	uploadGridDS.load(true);	
}
</script>
</head>

<body>		
	<input type="hidden" id = "attachment-biz" value="<%= bizType %>" />
	<input type="hidden" id = "attachment-processid" value="<%= processId %>" />
	<input type="hidden" id = "attachment-encryption" value="<%= encryption %>" />
	<input type="hidden" id = "attachment-bizclass" value="<%= bizClass %>" />
	<input type="hidden" id = "attachment-filecount" value="<%= fileCount %>" />
	<input type="hidden" id = "attachment-filestored" value="<%= fileStored %>" />
	<input type="hidden" id = "attachment-fileselectcount" value="<%=fileSelectCount  %>" />
	

<model:datasets>
	<model:dataset id="msgDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getMail" >
		<model:record fromBean="org.loushang.live.engine.view.MessageView"></model:record>
	</model:dataset>
   		<model:dataset id="timeState" enumName="SERVICESUBSCRIBE.CHOOSESTATE" autoLoad="true">
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

<next:Panel> 
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>		
		<next:ToolBarItem text="发送" iconCls="msg_send" handler="<%=sendHandle%>"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="mailSave"></next:ToolBarItem>
	</next:TopBar>	
	<next:Html>
		<form id="msgForm" dataset="msgDs" class="L5Form" action="<%=request.getContextPath()%>/MessageSender" method="post" onsubmit="return false;">
				<table width="100%">											
					<tr>
						<td class="FieldLabel" width="10%"><button onclick="queryParty();">收件人</button></td>
						<td class="FieldInput"><textarea name="partyName" field="partyName" id="partyName" style="width:80%; height:22px"></textarea></td>
					</tr>
					<tr>	
						<td class="FieldLabel" width="10%"><label>邮件主题：</label></td> 
						<td class="FieldInput"><input type="text" name="title" id="title" field="title" style="width:80%;"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="10%"><label>发送时间：</label></td>
						<td class="FieldInput"><input type="text" id="sendTime" field="sendTime" format="Ymd H:i:s" name="sendTime" onclick="LoushangDatetime(this)"/>
						<font color="red">（发送时间留空默认是立即发送，填充后就按发送时间发送）</font>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="FieldInput"><textarea name="htmlEditor"></textarea></td>
					</tr>										
				</table>	
				<!-- 用于提交表单使用 -->
				<input type="hidden" name="msgId" 		id="msgId" 		value="<%=msgId%>"/>
				<input type="hidden" name="msgType"		id="msgType"	value="<%=msgType%>"/>
				<input type="hidden" name="method" 		id="method"		value="<%=method%>"/>
				<input type="hidden" field="partyInfo"  id="partyInfo"  name="partyInfo"/>
				<input type="hidden" field="corrMsgId"  id="corrMsgId"  name="corrMsgId"/>
				<input type="hidden" field="bizType"  id="bizType"  name="bizType"/>
			</form>
	</next:Html>
</next:Panel>

<next:Panel>
<next:Html>
<!-- 显示附件信息 -->
<table class="attachmentTable" id="attachTable">
</table>
<input type="hidden" id = "attachment-filestoredsize" value="<%=fileStoredSize%>" />
<upload:File name="fj" 
					totalUploadSize="<%=totalUploadSize%>" uploadURL="UploadServlet" 
					fileSizeLimit="<%=fileSizeLimit%>" buttonHeight="22" buttonWidth="120" backColor="#FFFFFF" fontSize="12" width="120" buttonName="添加附件" uploadMode="im"/>
</next:Html>
</next:Panel>
</body>
</html>