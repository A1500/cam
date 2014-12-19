<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%
	String userId = ExtBspInfo.getUserInfo(request).getUserId();
%>
<html>
<head>
<title>账户信息维护</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="loginUserEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var userId='<%=userId%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="comExtUserDs" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"></model:record>
	</model:dataset>
	<model:dataset id="comExtOrganTypeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="COM_EXT_ORGAN_TYPE"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form1" method="post" dataset="comExtUserDs" onsubmit="return false" class="L5form">
			<fieldset>
				<legend>账户信息维护</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:16%">登录用户名：</td>
						<td class="FieldInput" style="width:30%"><input type="text" name="userId" id="userId" field="userId" style="width:90%"/><font color="red">*</font></td>
						<td class="FieldLabel" style="width:18%">用户名称：</td>
						<td class="FieldInput" style="width:36%"><input type="text" name="userName" id="userName" field="userName" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">登录密码：</td>
						<td class="FieldInput"><input type="password" name="pwd" id="pwd" field="pwd" style="width:90%"/><font color="red">*</font></td>
						<td class="FieldLabel">确认密码：</td>
						<td class="FieldInput"><input type="password" name="repwd" id="repwd" field="pwd" style="width:90%"/><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">通信地址：</td>
						<td class="FieldInput" colspan="3"><input type="text" name="adds" id="adds" field="adds" maxlength="30" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">联系电话：</td>
						<td class="FieldInput"><input type="text" name="phone" id="phone" field="phone" style="width:90%"/></td>
						<td class="FieldLabel">电子邮箱：</td>
						<td class="FieldInput"><input type="text" name="email" id="email" field="email" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">所属单位：</td>
						<td class="FieldInput"><label name="organName" id="organName" field="organName"/></td>
						<td class="FieldLabel">所属单位类型：</td>
						<td class="FieldInput">
							<select name="organType" id="organType" field="organType" disabled="true">
								<option dataset="comExtOrganTypeDs"></option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">所属行政区划：</td>
						<td class="FieldInput"><label name="areaCode" id="areaCode" field="areaCode"/></td>
						<td class="FieldLabel">所属行政区划名称：</td>
						<td class="FieldInput"><label name="areaName" id="areaName" field="areaName"/></td>
					</tr>
					<input type="hidden" name="organId" id="organId" field="organId"/>
					<input type="hidden" name="accountStatus" id="accountStatus" field="accountStatus"/>
				</table>
			</fieldset>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>