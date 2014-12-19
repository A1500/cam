<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>首页消息框列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="comMessageList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var messageTime='<%=DateUtil.getDay()%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="comMessageDataSet" cmd="com.inspur.cams.comm.message.cmd.ComMessageQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.message.data.ComMessage"/>
	</model:dataset>
	<model:dataset id="messageDs" cmd="com.inspur.cams.comm.message.cmd.ComMessageQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.message.data.ComMessage"/>
	</model:dataset>
	<!-- 批次表(查询用) -->
	<model:dataset id="queryDs" cmd="com.inspur.cams.comm.message.cmd.ComMessageQueryCmd" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.message.data.ComMessage"/>
	</model:dataset>
	<%--附件下载--%>
	<model:dataset id="attachDataSet" cmd="com.inspur.cams.comm.message.cmd.ComMessageAttachmentQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.comm.message.data.ComMessageAttachment"></model:record>
	</model:dataset>
	<%--附件表--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.comm.message.cmd.ComMessageAttachmentQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.message.data.ComMessageAttachment"></model:record>
	</model:dataset>
	<!-- 是否发布 -->
	<model:dataset id="ifShowDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">消息名称：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "message_name" /></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="comMessageDataSet" width="100%" stripeRows="true" height="99.9%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="上传附件" handler="uploadFile"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="发布" handler="toshow"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="取消发布" handler="unshow"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="messageId" header="消息ID" width="15%" sortable="false" hidden="true"/>
		<next:Column field="messageTitle" header="消息名称" width="15%" sortable="false"/>
		<next:Column field="messageContents" header="消息正文" width="30%" sortable="false"/>
		<next:Column field="messageTime" header="消息发布时间" width="10%" sortable="false"/>
		<next:Column field="ifShow" header="是否显示" width="5%" sortable="false" dataset="ifShowDataset"/>
		<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
		<next:Column field="serialNum" header="顺序号" width="10%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="comMessageDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id ="messageWin" title="编辑消息" expandOnShow="false"
        resizable="false" width="600" height="215"
       closable="false" >
       <next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem text="确定" iconCls="detail" handler="confirm"/>
				<next:ToolBarItem text="关闭" iconCls="undo" handler="closeWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm"  dataset="messageDs" onsubmit="return false"  class="L5form">
				<table border="1" width="100%" >
			   		<tr>	
						<td  class="FieldLabel" style="width:17%">消息名称:</td>
						<td class="FieldInput" style="width:17%"><input id="messageTitle" field="messageTitle"></input></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>消息正文:</td>
						<td class="FieldInput" style="width: 35%" colspan="3"><textarea
							name="note" rows="5" field="messageContents" id="messageContents" title="备注" style="width: 80%"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>顺序号:</td>
						<td class="FieldInput" style="width: 35%" colspan="3">
						<input id="serialNum" field="serialNum" maxlength="3"></input></td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>
<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="150" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_upload"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:30%">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="files" name="files" style="width:95%;height:40"/></td>
    		</tr>
    		<tr>
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过10M</span></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
</body>
</html>
<!-- 下载附件窗口 -->
<next:Window id="downloadWin" title="附件列表" closeAction="hide" height="400" width="550"modal="true">
	<next:EditGridPanel id="downloadGrid" width="530" stripeRows="true" height="369" dataset="downloadDataSet" >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeDownload"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="附件ID"  field="attachmentId" width="280" editable="false" hidden="true"></next:Column>
			<next:Column header="附件名称"  field="fileName" width="280" editable="false" renderer="winDownloadHref" ><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="80" editable="false" renderer="delUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>