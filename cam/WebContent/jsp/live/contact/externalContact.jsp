<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.live.engine.util.PropertyUtil"%>
<%@page import="org.loushang.live.common.CommonUtil"%>
<html>
<head>
	<title>个人信息</title>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="externalContact.js"></script>	
</head>
<script type="text/javascript">
var ContactInfo = '<%=PropertyUtil.getInstance().get("contactinfo")==null ? "" : PropertyUtil.getInstance().get("contactinfo")%>';
var contactId='<%=request.getParameter("contactId")%>';
contactId = decodeURI(contactId);
contactId = (contactId == 'null')?'':contactId;	
var groupId='<%=request.getParameter("groupId")%>';
	
function init() {
	if(contactId==""){
		var newRecord = extContactDs.newRecord();
	}else{
		contactAddrDs.setParameter("OWNER_ID" , contactId);
		contactAddrDs.load(true);
		extContactDs.setParameter("CONTACT_USER_ID" , contactId);
		extContactDs.load(true);	
	}
}
</script>
<body>
<model:datasets>
	<model:dataset id="contactAddrDs" cmd="org.loushang.live.contact.privacy.cmd.UserQueryCmd" method="getContactAddr"  global="true"   pageSize="10">
		<model:record fromBean="org.loushang.live.contact.privacy.data.ContactAddr"/>
	</model:dataset>
	<model:dataset id="deliveryModeDs" cmd="org.loushang.live.contact.privacy.cmd.UserQueryCmd" method="getDeliveryMode"  global="true"  autoLoad="true" >
		<model:record fromBean="org.loushang.live.common.deliverymode.DeliveryMode"/>
	</model:dataset>
	<model:dataset id="extContactDs" cmd="org.loushang.live.contact.contactlist.cmd.ContactQueryCmd" method="getExtContact"  global="true">
		<model:record fromBean="org.loushang.live.contact.contactlist.data.Contact">
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text='保存' handler="Evt_butsave_click" />
		<next:ToolBarItem iconCls="undo" text='取消' handler="Evt_butundo_click" />
	</next:TopBar>
	<next:Html >
		<form id="getInfo" class="L5form" dataset="extContactDs">
		<fieldset style="width:100%"><legend>个人信息</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="30%"><label>姓名(名称):</label></td>
				<td class="FieldInput">
					<input type="text" field="contactName" name="contactName" class="TextEditor" id="contactName"/><font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="30%"><label>昵称:</label></td>
				<td class="FieldInput">
					<input type="text" field="nickName" name="nickName" class="TextEditor" id="nickName"/>
				</td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="contactAddrGrid" name="addrGrid" width="100%" stripeRows="true"
	hidden="false" height="250" dataset="contactAddrDs" border="0">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="add" text="新增" handler="btnAddAddr"/>
		<next:ToolBarItem  iconCls="remove" text="删除" handler="btnDelAddr"/>
	</next:TopBar>	
	<next:Columns>
		<next:RowNumberColumn/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column hidden="true" field="addrId" header="联系方式编号">
			<next:TextField />
		</next:Column>
		<next:Column header="联系方式" field="deliveryMode" width="30%" align="center" renderer="changeDisplay">
			<next:TextField  editable="false"></next:TextField>
		</next:Column>
		<next:Column header="联系地址" field="deliveryAddr" width="65%" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
</next:EditGridPanel>

<next:Window id="addrWnd" closeAction="hide" closable="true" resizable="false" width="300" height="120">
<next:Html>
	<form onsubmit="return false" class="L5form">
	<table>
		<tr>
			<td class="FieldLabel" width="300" style="height:35px">联系方式</td>
			<td class="FieldInput" width="300" style="height:35px">
				<select id="deliveryModeSel"></select>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" width="300" style="height:35px">联系地址</td>
			<td class="FieldInput" width="300" style="height:35px">
				<input type="text" id="addrText" name="addrText">
			</td>
		</tr>
		<tr>
			<td class="FieldButton" colspan="2" style="height:35px">
				<button type="button" onclick="addAddr()">确定</button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" onclick="cancelAddr()">取消</button>
			</td>
		</tr>
		</table>
	</form>	
</next:Html>
</next:Window>
</body>
</html>
