<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.live.engine.util.PropertyUtil"%>
<%  
	//是否使用消息队列引入不同的发送方式
	String usejms = PropertyUtil.getInstance().get("usejms");
	String sendHandle = "mailSendCmd";
	if(!"true".equals(usejms)){
		sendHandle = "mailSendServlet";
	}
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/live/L5-live.css"/>
<html>
	<head>
		<title>发件箱</title>
		<next:ScriptManager />
		<%@include file="../common/deliverycommon.jsp"%>
		<%@include file="list_menu.jsp"%>
		<script type="text/javascript" src="all_outbox_list.js"></script>
		<script type="text/javascript" src="list_common.js"></script>
		<script type="text/javascript" src="../common/common.js"></script>
		<script type="text/javascript">
		var msgType = '<%=request.getParameter("msgType")%>';
		function init(){
			msgDs.setParameter("msgType",msgType);
			msgDs.setParameter("boxType","temp");
			msgDs.setParameter("queryMode","simple");
			msgDs.load();
		}
		</script>
	</head>
<body>
<input type="hidden" id="boxType" value="temp"/>
<model:datasets>	
	<model:dataset id="msgDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="queryDraftBox" pageSize="10">
		<model:record fromBean="org.loushang.live.engine.view.MessageView"></model:record>
	</model:dataset>
	<model:dataset id="mailDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getMail" pageSize="-1">
		<model:record fromBean="org.loushang.live.engine.view.MessageView"></model:record>
	</model:dataset>
	<model:dataset id="attachDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" global="true" method="getAttach" pageSize="-1">
		<model:record fromBean="org.loushang.live.engine.core.AttachmentImpl"></model:record>
	</model:dataset>
	<model:dataset id="msgState" enumName="ENGINE.SENDSTATE" autoLoad="true">
	</model:dataset>
	<model:dataset id="msgTypeDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" method="queryDeliveryMode" autoLoad="true">
		<model:record>
			<model:field name="text" mapping="deliveryName" type="string"/>
			<model:field name="value" mapping="deliveryMode" type="string"/>	
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>


<next:GridPanel border="false" id="editGridPanel" name="mailGrid" anchor="100% 45%" dataset="msgDs" autoScroll="true" enableColumnResize="true" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="query" text="查询" handler="queryMsg"/>
		<next:ToolBarItem  iconCls="msg_new" text="新建▼"  handler="newMsg" id="menulist"/>		
		<next:ToolBarItem  iconCls="msg_send" text="发送" handler="<%=sendHandle%>"/>		
		<next:ToolBarItem  iconCls="remove" text="删除" handler="delTemp"/>
		<next:ToolBarItem  iconCls="msg_cancel" text="取消" handler="cancelSend"/>			
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="msgId" header="msgId"  field="msgId" hidden="true" >
			<next:TextField allowBlank="false" />
		</next:Column>
	    
	    <next:Column id="envId" header="envId"  field="envId" hidden="true" >
			<next:TextField allowBlank="false" />
		</next:Column>	   
		
		<next:Column id="msgType" header="消息类型" field="msgType"  width="7%" sortable="true" renderer="showTypeIco" align="center">
			<next:ComboBox  dataset="msgTypeDs" />
		</next:Column>
		
		<next:Column id="partyName" header="收件人"  field="partyName"  width="20%" sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		 <next:Column id="stat" header="状态"  field="stat"  width="10%" sortable="true">
			<next:ComboBox  dataset="msgState" />
		</next:Column>

		<next:Column id="title" header="主题" field="title" width="45%" sortable="false" renderer="titleFilter">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="sendTime" header="发送时间" field="sendTime" width="15%" sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="bizType" header="业务类型" field="bizType" width="8%" sortable="false" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="scroll" header="" field="" width="2%" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="hasAttach" header="hasAttach"  field="hasAttach" hidden="true" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Listeners>
			<next:Listener eventName="rowclick" handler="showMail"></next:Listener>
			<next:Listener eventName="rowdblclick" handler="openMail"></next:Listener>			
		</next:Listeners>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="msgDs" />
	</next:BottomBar>
</next:GridPanel>
<next:Panel anchor="100% 55%" autoScroll="true">
<next:Panel id="insertRoot" border="false" hidden="true" collapsible="true">
	<next:Html>
		<form id="editForm" dataset="mailDs" onsubmit="return false" class="L5Form">
		<fieldset >
		<legend>邮件编辑</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td class="FieldLabel" width="10%">邮件主题：</td>
				<td class="FieldInput" width="90%">
					<label field="title"> </label>	
				</td>
			</tr>
			<tr>				
				<td class="FieldInput" colspan="2"><iframe name="contentFrame" width="100%"/></td>
			</tr>			
		</table></fieldset>
		</form>
   </next:Html>
</next:Panel>

<next:GridPanel border="true" id="attachGridPanel" hidden="true" name="attachGrid" height="100" dataset="attachDs" autoScroll="true" width="656">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="att_download" text="下载" handler="download"/>
		<next:ToolBarItem  iconCls="att_download" text="下载选中" handler="downloadSelect"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="attID" header="attID"  field="attID" hidden="true" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="fileID" header="fileID"  field="fileID" hidden="true" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="fileName" header="文件名"  field="fileName"  width="250" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="fileSize" header="大小" field="fileSize" width="100" >
			<next:TextField allowBlank="false" />
		</next:Column>	
		
	</next:Columns>
</next:GridPanel>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>

<!--查询条件window-->
<next:Window id="queryWnd" autoHeight="true" width="600" resizable="false" closeAction="hide">
<next:Html>
<form id="queryForm" class="L5form" onsubmit="return false">
	<fieldset style="width: 100%;">
		<legend>查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel">
					<label>消息类型</label>：
				</td>
				<td class="FieldInput">
					<select id="msgTypeSearch" >
					</select>
				</td>
				<td class="FieldLabel">
					<label id="partyNameSearch1">收件人</label>：
				</td>
				<td class="FieldInput">
					<input type="text" id="partyNameSearch"/>
				</td>					
			</tr>
			<tr>
				<td class="FieldLabel">
					<label>发送时间</label>：
				</td>
				<td class="FieldInput">
					<input type="text" id="startTime" format="Ymd" name="startTime" onclick="LoushangDate(this)"/>
				</td>
				<td class="FieldLabel">
					<label>至</label>：
				</td>
				<td class="FieldInput">
					<input type="text" id="endTime" format="Ymd" name="endTime" onclick="LoushangDate(this)"/>					
				</td>
			</tr>
			<tr>
				
				<td class="FieldLabel">
					<label id="titleSearch1">主题</label>：
				</td>
				<td class="FieldInput">
					<input type="text" id="titleSearch"/>
				</td>
				<td class="FieldLabel">
					<!--<label>业务类型</label>-->&nbsp;
				</td>
				<td class="FieldInput">
					<!--<input type="text" id="bizTypeSearch"/>--> &nbsp;
				</td>
			</tr>
			<tr>
				<td align="center" colspan="4">
					<button onclick="queryMail('p')" style="width: 80">查 询</button> 
				</td>
			</tr>
		</table>
		</fieldset>
</form>
</next:Html>
</next:Window>

<!-- 这个是弹出窗口
<next:Window id="jobdetailwin" title="任务详细信息" width="800" height="400" closeAction="hide" resizable="false" autoScroll="true">
	<next:Html>
		<iframe src="" title="修改" width="100%" height="100%" id="detailframe"></iframe>
	</next:Html>
</next:Window>-->
<input id="realurl" type="hidden" value = "<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()%>"/>
<input type="hidden" id="typeMark"/>
<div id="msgtypeMenu" style="display: none; position: absolute;">
</body>
</html>
