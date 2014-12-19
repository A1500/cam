<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
	<title>个人信息</title>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="person.js"></script>	
</head>
<script type="text/javascript">
	var contactId='<%=request.getParameter("contactId")%>';
	contactId = decodeURI(contactId);
	contactId = (contactId == 'null')?'':contactId;	
</script>
<body>
<model:datasets>
	<model:dataset id="userDataset" cmd="org.loushang.live.contact.privacy.cmd.UserQueryCmd" method="queryUser">
		<model:record fromBean="org.loushang.live.contact.privacy.data.User"/>
	</model:dataset>
	<model:dataset id="contactAddrDs" cmd="org.loushang.live.contact.privacy.cmd.UserQueryCmd" method="getContactAddr"  global="true"   pageSize="10">
		<model:record fromBean="org.loushang.live.contact.privacy.data.ContactAddr"/>
	</model:dataset>
	<model:dataset id="deliveryModeDs" cmd="org.loushang.live.contact.privacy.cmd.UserQueryCmd" method="getDeliveryMode"  global="true"  autoLoad="true" >
		<model:record fromBean="org.loushang.live.common.deliverymode.DeliveryMode"/>
	</model:dataset>
	<model:dataset  id="genderDs" enumName="USER.GENDER" autoLoad="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" title="个人信息">
	<next:Html >
		<form id="getInfo" class="L5form" dataset="userDataset">
					<table width="100%">
			<tr>
				<td style="width:10%" class="FieldLabel"><label>账号：</label></td>
				<td style="width:40%" class="FieldInput">
					<label field="userId" id="userId" />
				</td>
				<td style="width:10%" class="FieldLabel"><label>姓名：</label></td>
				<td style="width:40%" class="FieldInput">
					<label field="userName" id="userName" />
				</td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>性别：</label></td>
				<td class="FieldInput">
					<input type="radio" name="gender" field="gender" value="0" disabled="disabled" style="width:60px"/>
					<label id="gender">男</label>
						<input type="radio" name="gender" field="gender" value="1" disabled="disabled" style="width:60px"/>
					<label>女</label>
					<input type="radio" name="gender" field="gender" value="2" disabled="disabled" style="width:60px"/>
					<label>保密</label>							
				</td>
				<td class="FieldLabel"><label>生日：</label></td>
				<td class="FieldInput">
					<label field="birthday" id="birthday" />
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
<next:GridPanel id="contactAddrGrid" title="联系方式" name="addrGrid" width="100%" stripeRows="true"
	hidden="false" height="275" dataset="contactAddrDs" border="0">
	<next:Columns>
		<next:RowNumberColumn/>
		<next:Column hidden="true" field="addrId" header="联系方式编号">
			<next:TextField />
		</next:Column>
		<next:Column header="联系方式" field="deliveryMode" width="30%" align="center" renderer="changeDisplay">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="联系地址" field="deliveryAddr" width="65%" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
</next:GridPanel>
</body>
</html>
