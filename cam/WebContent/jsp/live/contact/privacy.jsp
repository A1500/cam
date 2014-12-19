<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.live.engine.util.PropertyUtil"%>
<html>
<head>
	<title>个人信息维护</title>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="privacy.js"></script>	
	<script type="text/javascript">
		var ContactInfo = '<%=PropertyUtil.getInstance().get("contactinfo")==null ? "" : PropertyUtil.getInstance().get("contactinfo")%>';
	</script>
</head>
<body>
<model:datasets>
	<model:dataset id="userDataset" cmd="org.loushang.live.contact.privacy.cmd.UserQueryCmd" method="getUser" global="true">
		<model:record fromBean="org.loushang.live.contact.privacy.data.User">
		</model:record>
	</model:dataset>
	<model:dataset id="deliveryModeDs" cmd="org.loushang.live.contact.privacy.cmd.UserQueryCmd" method="getDeliveryMode"  global="true"  autoLoad="true" >
		<model:record fromBean="org.loushang.live.common.deliverymode.DeliveryMode"/>
	</model:dataset>
	<model:dataset id="contactAddrDs" cmd="org.loushang.live.contact.privacy.cmd.UserQueryCmd" method="getUserAddr"  global="true" >
		<model:record fromBean="org.loushang.live.contact.privacy.data.ContactAddr"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" title="个人信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text='保存' handler="Evt_butsave_click" />
		<next:ToolBarItem iconCls="undo" text='取消' handler="Evt_butundo_click" />
	</next:TopBar>
	<next:Html>
		<form id="getInfo" class="L5form" dataset="userDataset">		
		<table width="100%">
			<tr>
				<td style="width:10%" class="FieldLabel">
					<label>账号：</label>
				</td>
				<td style="width:40%" class="FieldInput">
					<input type="text" field="userId" name="userId" disabled="disabled" id="userId" style="width:100%"/>
				</td>
				<td style="width:10%" class="FieldLabel"><label>姓名：</label></td>
				<td style="width:40%" class="FieldInput">
					<input type="text" field="userName" name="userName" maxlength="30" id="userName" style="width:100%"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">
					<label>性别：</label>
				</td>
				<td class="FieldInput">
				    <input type="radio" name="gender" field="gender" value="0" style="width:60px"/>男
				    <input type="radio" name="gender" field="gender" value="1" style="width:60px"/>女
				    <input type="radio" name="gender" field="gender" value="2" style="width:60px"/>保密
                </td>
				<td class="FieldLabel">
					<label>生日：</label>
				</td>
				<td> 
					<input type="text" id="birthday" format="Ymd" name="birthday" field="birthday" onclick="LoushangDate(this)" readonly="readonly" style="width:100%"/>
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="contactAddrGrid" name="addrGrid" width="100%" stripeRows="true" height="250" dataset="contactAddrDs" title="联系方式" border="0">	
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="add" text="新增" handler="btnAddAddr"/>
		<next:ToolBarItem  iconCls="remove" text="删除" handler="btnDelAddr"/>
	</next:TopBar>	
	<next:Columns>
		<next:RowNumberColumn/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column hidden="true" field="addrId" header="联系方式编号"/>
		<next:Column header="联系方式" field="deliveryMode" width="30%" align="center" renderer="changeDisplay">
			<next:TextField editable="false"></next:TextField>
		</next:Column>
		<next:Column header="联系地址" field="deliveryAddr" width="65%" align="center">
			<next:TextField allowBlank="false"/>
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
				<select id="deliveryModeSel">
				</select>
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
